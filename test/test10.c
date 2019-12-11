#include <stdio.h>

float test10(float k) {
    float n;
    for(int i=0; i<100; i++) {
        n = k + i;
    }
    float p = n + n + n;
    return (n * n) + (p * n);
}

int main() { printf("%d\n", (int)test10(10.0)); }

//*********//
//Output 47524.000000
