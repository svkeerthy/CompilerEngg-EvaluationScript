#include <stdio.h>

int test2(int j) {
  int n = 0;
  for (int i = 0; i < j; i++) {
    n += i;
  }
  return n;
}

int main() { printf("%d\n", test2(100)); }

//*********//
//Output 4950
