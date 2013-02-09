#include <stdio.h>
#include <math.h>


float unsignedToFloat( unsigned int x ) {

    unsigned int result = 0;

    int exp = -1;
    for (int i=31; i >= 0; i--) {
        int bit = (x >> i) & 1;
        if (bit == 1 && exp < 0) {
            exp = i;
        }else if(bit == 1 && exp > 0) {
            result = result  + (1 << (23+i-exp));
        }
    }

    result = result + ((exp+127) << 23);
    return *(float*)&result;
}


int main() {
    printf("%d\n", 1 << 1);
    printf("%f\n",unsignedToFloat(65874));
}
