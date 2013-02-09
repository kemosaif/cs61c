#include <stdio.h>
#include <stdlib.h>
#include <emmintrin.h>

int count(char *arr, int len, char key) {
  int i;
  int res = 0;
  for (i=0;i<len;++i)
    if (arr[i] == key)
      res++;
  return res;
}

int count_simd(char *arr, int len, char key) {

  __m128i sum, compare_to, char_set, compared, ones;

  sum = _mm_setzero_si128();
  ones = _mm_set1_epi8((char)(unsigned int) 1);
  compare_to = _mm_set1_epi8(key);

  int i;
  int res = 0;
  for (i=0; i<len/16*16; i+= 16) {
    char_set = _mm_loadu_si128((__m128i*)(arr+i));
    compared = _mm_cmpeq_epi8(compare_to, char_set);
    compared = _mm_and_si128(ones,compared);
    sum = _mm_add_epi8(compared, sum);
  }

  char found[16] = {0};
  _mm_storeu_si128((__m128i*)found, sum);

  for(i = 0; i < 16; i++) {
    res += found[i];
  }

  for(i = len/16*16; i < len; i++) {
    if (arr[i] == key) {
      res++;
    }
  }

  return res;
}
