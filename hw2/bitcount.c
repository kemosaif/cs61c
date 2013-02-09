/*
  Name: Jon San Miguel
  Lab section time: Thursday 6-8
*/

#include <stdio.h>
#include <stdlib.h>

int bitCount(unsigned int n);

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf ("# 1-bits in base 2 representation of %u = %d, should be 0\n", 0, bitCount (0));
        printf ("# 1-bits in base 2 representation of %u = %d, should be 1\n", 1, bitCount (1));
        printf ("# 1-bits in base 2 representation of %u = %d, should be 17\n", 2863377066u, bitCount(2863377066u));
        printf ("# 1-bits in base 2 representation of %u = %d, should be 1\n", 268435456, bitCount(268435456));
        printf ("# 1-bits in base 2 representation of %u = %d, should be 31\n", 4294705151u, bitCount(4294705151u));
    } else if (argc > 2) {
        printf ("%s\n", "too many arguments!");
    } else {
        printf ("%i\n", bitCount(atoi(argv[1])));
    }
    return 0;
}

int bitCount(unsigned int n) {
    int count = 0;
    while (n != 0)
        {
            count++;
            n &= (n - 1);
        }
    return count;
}
