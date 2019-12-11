#include <stdio.h>

int main() {
  int i = 0, sum = 0;

  do {
    int j = 0;
    do {
      sum += j;
      j += 1;
    } while (j <= 4);
    sum += i;
    i++;
  } while (i <= 10);

  printf("%d\n", sum);
}

//*********//
//Output 165
