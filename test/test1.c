#include <stdio.h>

int test1(int j) {
  int n = 1;
  for (int i = 1; i <= j; i++) {
    n *= i;
  }
  return n;
}

int main() { printf("%d\n", test1(7)); }

//*********//
//Output 5040
