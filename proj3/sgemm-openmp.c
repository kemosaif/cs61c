#include <emmintrin.h>
#include <omp.h>
void sgemm( int m, int n, float *A, float *C ) {
        #pragma omp parallel
    {
        __m128 at[4],c[5],a[5];
            #pragma omp for
        for( int j = 0; j < m; j++){
            for( int k = 0; k < n/4*4; k+=4){
                at[0] = _mm_set1_ps(*(A+j+k*m));
                at[1] = _mm_set1_ps(*(A+j+(k+1)*m));
                at[2] = _mm_set1_ps(*(A+j+(k+2)*m));
                at[3] = _mm_set1_ps(*(A+j+(k+3)*m));
                for( int i = 0; i < m/20*20; i+=20 ){
                    float *ctemp = C+j*m+i;
                    float* temp;
                    temp = A+i+k*m;

                    *a = _mm_loadu_ps(temp);
                    *(a+1) = _mm_loadu_ps(temp+m);
                    *(a+2) = _mm_loadu_ps(temp+2*m);
                    *(a+3) = _mm_loadu_ps(temp+3*m);

                    *c = _mm_loadu_ps(ctemp);

                    *a = _mm_mul_ps(*a,at[0]);
                    *(a+1) = _mm_mul_ps(*(a+1),at[1]);
                    *(a+2) = _mm_mul_ps(*(a+2),at[2]);
                    *(a+3) = _mm_mul_ps(*(a+3),at[3]);

                    *a = _mm_add_ps(*a,*c);
                    *a = _mm_add_ps(*(a+1),*a);
                    *a = _mm_add_ps(*(a+2),*a);
                    *a = _mm_add_ps(*(a+3),*a);

                    _mm_storeu_ps(ctemp,*a);

                    temp+=4;

                    *a = _mm_loadu_ps(temp);
                    *(a+1) = _mm_loadu_ps(temp+m);
                    *(a+2) = _mm_loadu_ps(temp+2*m);
                    *(a+3) = _mm_loadu_ps(temp+3*m);

                    *c = _mm_loadu_ps(ctemp+4);

                    *a = _mm_mul_ps(*a,at[0]);
                    *(a+1) = _mm_mul_ps(*(a+1),at[1]);
                    *(a+2) = _mm_mul_ps(*(a+2),at[2]);
                    *(a+3) = _mm_mul_ps(*(a+3),at[3]);

                    *a = _mm_add_ps(*a,*c);
                    *a = _mm_add_ps(*(a+1),*a);
                    *a = _mm_add_ps(*(a+2),*a);
                    *a = _mm_add_ps(*(a+3),*a);

                    _mm_storeu_ps(ctemp+4,*a);

                    temp+=4;

                    *a = _mm_loadu_ps(temp);
                    *(a+1) = _mm_loadu_ps(temp+m);
                    *(a+2) = _mm_loadu_ps(temp+2*m);
                    *(a+3) = _mm_loadu_ps(temp+3*m);

                    *c = _mm_loadu_ps(ctemp+8);

                    *a = _mm_mul_ps(*a,at[0]);
                    *(a+1) = _mm_mul_ps(*(a+1),at[1]);
                    *(a+2) = _mm_mul_ps(*(a+2),at[2]);
                    *(a+3) = _mm_mul_ps(*(a+3),at[3]);

                    *a = _mm_add_ps(*a,*c);
                    *a = _mm_add_ps(*(a+1),*a);
                    *a = _mm_add_ps(*(a+2),*a);
                    *a = _mm_add_ps(*(a+3),*a);

                    _mm_storeu_ps(ctemp+8,*a);

                    temp+=4;

                    *a = _mm_loadu_ps(temp);
                    *(a+1) = _mm_loadu_ps(temp+m);
                    *(a+2) = _mm_loadu_ps(temp+2*m);
                    *(a+3) = _mm_loadu_ps(temp+3*m);

                    *c = _mm_loadu_ps(ctemp+12);

                    *a = _mm_mul_ps(*a,at[0]);
                    *(a+1) = _mm_mul_ps(*(a+1),at[1]);
                    *(a+2) = _mm_mul_ps(*(a+2),at[2]);
                    *(a+3) = _mm_mul_ps(*(a+3),at[3]);

                    *a = _mm_add_ps(*a,*c);
                    *a = _mm_add_ps(*(a+1),*a);
                    *a = _mm_add_ps(*(a+2),*a);
                    *a = _mm_add_ps(*(a+3),*a);

                    _mm_storeu_ps(ctemp+12,*a);

                    temp+=4;

                    *a = _mm_loadu_ps(temp);
                    *(a+1) = _mm_loadu_ps(temp+m);
                    *(a+2) = _mm_loadu_ps(temp+2*m);
                    *(a+3) = _mm_loadu_ps(temp+3*m);

                    *c = _mm_loadu_ps(ctemp+16);

                    *a = _mm_mul_ps(*a,at[0]);
                    *(a+1) = _mm_mul_ps(*(a+1),at[1]);
                    *(a+2) = _mm_mul_ps(*(a+2),at[2]);
                    *(a+3) = _mm_mul_ps(*(a+3),at[3]);

                    *a = _mm_add_ps(*a,*c);
                    *a = _mm_add_ps(*(a+1),*a);
                    *a = _mm_add_ps(*(a+2),*a);
                    *a = _mm_add_ps(*(a+3),*a);

                    _mm_storeu_ps(ctemp+16,*a);
                }
                int temp[] = {j+k*m,j+k*m+m,j+k*m+2*m,j+k*m+3*m};
                for ( int i = m/20*20; i<m; i++){
                    C[i+j*m] += A[i+k*m] * A[j+k*m];
                    C[i+j*m] += A[i+(k+1)*m] * A[j+(k+1)*m];
                    C[i+j*m] += A[i+(k+2)*m] * A[j+(k+2)*m];
                    C[i+j*m] += A[i+(k+3)*m] * A[j+(k+3)*m];
                }
            }
            for( int k = n/4*4; k < n; k++){
                at[0] = _mm_set1_ps(*(A+j+k*m));
                for( int i = 0; i < m/20*20; i+=20 ){
                    float *ctemp = C+j*m+i;
                    float *temp = A+i+k*m;

                    *a = _mm_loadu_ps(temp);
                    *(a+1) = _mm_loadu_ps(temp+4);
                    *(a+2) = _mm_loadu_ps(temp+8);
                    *(a+3) = _mm_loadu_ps(temp+12);
                    *(a+4) = _mm_loadu_ps(temp+16);

                    *c = _mm_loadu_ps(ctemp);
                    *(c+1) = _mm_loadu_ps(ctemp+4);
                    *(c+2) = _mm_loadu_ps(ctemp+8);
                    *(c+3) = _mm_loadu_ps(ctemp+12);
                    *(c+4) = _mm_loadu_ps(ctemp+16);

                    *a = _mm_mul_ps(*a,at[0]);
                    *(a+1) = _mm_mul_ps(*(a+1),at[0]);
                    *(a+2) = _mm_mul_ps(*(a+2),at[0]);
                    *(a+3) = _mm_mul_ps(*(a+3),at[0]);
                    *(a+4) = _mm_mul_ps(*(a+4),at[0]);

                    *a = _mm_add_ps(*a,*c);
                    *(a+1) = _mm_add_ps(*(a+1),*(c+1));
                    *(a+2) = _mm_add_ps(*(a+2),*(c+2));
                    *(a+3) = _mm_add_ps(*(a+3),*(c+3));
                    *(a+4) = _mm_add_ps(*(a+4),*(c+4));

                    _mm_storeu_ps(ctemp,*a);
                    _mm_storeu_ps(ctemp+4,*(a+1));
                    _mm_storeu_ps(ctemp+8,*(a+2));
                    _mm_storeu_ps(ctemp+12,*(a+3));
                    _mm_storeu_ps(ctemp+16,*(a+4));

                }

                for ( int i = m/20*20; i<m; i++){
                    C[i+j*m] += A[i+k*m] * A[j+k*m];
                }
            }
        }
    }
}
