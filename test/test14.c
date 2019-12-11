#include <stdio.h>

int test14(int k) {
  int n = 0;
  for (int i = 50; i < 100; i++) {
    n += k + i;
    }

    return n;
}

int main() { printf("%d\n",  test14(14)); }

//*********//
//Output 4425
