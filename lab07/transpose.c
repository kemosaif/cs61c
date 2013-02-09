#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

void transpose( int n, int blocksize, int *dst, int *src ) {


  int i,j, b1, b2, b1e, b2e, b1n, b2n;
    for( b1 = 0; b1 < n; b1 += blocksize) {
      b1n = b1 + blocksize;
      b1e =  b1n > n ? n : b1n;
      for( b2 = 0; b2 < n; b2 += blocksize) {
        b2n = b2 + blocksize;
        b2e =  b2n > n ? n : b2n;
        for( i = b1; i < b1e; i++ ) {
          for( j = b2; j < b2e; j++ ) {
              dst[j+i*n] = src[i+j*n];
          }
        }
      }
    }
}

int main( int argc, char **argv ) {
    int n = 2000,i,j;
    int blocksize = 30; /* to do: find a better block size */

    /* allocate an n*n block of integers for the matrices */
    int *A = (int*)malloc( n*n*sizeof(int) );
    int *B = (int*)malloc( n*n*sizeof(int) );

    /* initialize A,B to random integers */
    for( i = 0; i < n*n; i++ ) A[i] = rand( );
    for( i = 0; i < n*n; i++ ) B[i] = rand( );

    /* measure performance */
    struct timeval start, end;

    gettimeofday( &start, NULL );
    transpose( n, blocksize, B, A );
    gettimeofday( &end, NULL );

    double seconds = (end.tv_sec - start.tv_sec) + 1.0e-6 * (end.tv_usec - start.tv_usec);
    printf( "%g milliseconds\n", seconds*1e3 );

    /* check correctness */
    for( i = 0; i < n; i++ )
        for( j = 0; j < n; j++ )
            if( B[j+i*n] != A[i+j*n] ) {
	        printf("Error!!!! Transpose does not result in correct answer!!\n");
	        exit( -1 );
            }
  
    /* release resources */
    free( A );
    free( B );
    return 0;
}

