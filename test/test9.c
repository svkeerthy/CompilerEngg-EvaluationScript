#include <stdio.h>

int i;
int test9(int k) {
  int n = 0;
  i = 50;
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      n += k + i;
    }
  }
  int p = i + i + i;
  return (n * n) + (p * i);
}

int main() { printf("%d\n", test9(9)); }

//*********//
//Output 1830000
