#include <stdio.h>

int test11(int k) {
    int n[100];
    for(int i=0; i<100; i++) {
        n[i] = k + i;
    }
    return n[99];
}

int main() { printf("%d\n", test11(11)); }

//*********//
//Output 110
