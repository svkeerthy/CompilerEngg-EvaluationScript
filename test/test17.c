#include <stdio.h>

int main() {
  int i = 0;
  int sum = 0;
  while (i < 10) {
    sum += i;
    i++;
    int j = 0;
    while (j < 10) {
      j++;
    }
    sum += j;
  }
  printf("%d\n", sum);
  return sum;
}


//*********//
//Output 145
