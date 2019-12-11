#include <stdio.h>

int main() {
  int i = 5, sum = 0;
  int x = 12;
  int lim = x * 12;
  i = lim - 100;
  for (; i <= lim; i += 12) {
    // printf("i=%d, sum=%d\n", i, sum);
    sum += i;
  }

  printf("%d\n", sum);
  return sum;
}

//*********//
//Output 828
