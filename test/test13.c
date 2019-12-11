#include <stdio.h>

int main() {
  int i = 5, sum = 0;
  int x = 12;
  int lim = x * 12;
  do {
    // printf("i=%d, sum=%d\n", i, sum);
    sum += i;
    i += 12;
  } while (i <= lim);

  printf("%d\n", sum);
  return sum;
}

//*********//
//Output 852
