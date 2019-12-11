#include <stdio.h>

int main() {
  int i = 10, sum = 0;

  for (; i > 1; i -= 4) {
    sum += 11 - i;
  }

  printf("%d\n", sum);
  return sum;
}

//*********//
// Output 15
