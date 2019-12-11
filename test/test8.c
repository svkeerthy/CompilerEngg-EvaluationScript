#include <stdio.h>

int test8(int k) {
    int n;
    for(int i=0; i<100; i++) {
        n = k + i;
    }
    int p = n + n + n;
    return (n * n) + (p * n);
}

int main() { printf("%d\n", test8(8)); }

//*********//
//Output 45796
