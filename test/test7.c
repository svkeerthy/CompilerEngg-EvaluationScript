#include <stdio.h>

int main() {
  int i = 100, sum = 0;
  for (; i > 1; i -= 4) {
    sum += i;
  }

  printf("%d\n", sum);
}

//*********//
//Output 1300
