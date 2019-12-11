#include <stdio.h>

int test3() {
  int n = 0;
  for (int i = 1; i < 4096; i *= 2) {
    n += i;
  }
  int p = n + n + n;
  return (n * n) + (p * n);
}

int main() { printf("%d\n", test3()); }

//*********//
//Output 67076100
