#include <stdio.h>

int main() {
  int i = 1, sum = 0;
  int A[10];
  for (; i < 11; i++) {
    sum += i;
    A[i] = i;
    i += 4;
  }

  sum += i;
  printf("%d\n", sum);
}

//*********//
// Output 18
