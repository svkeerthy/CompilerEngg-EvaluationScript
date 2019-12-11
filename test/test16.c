#include <stdio.h>

int main() {
  int i = 0;
  int c = 0;
  int x = 12;
  int lim = x * x;
  for (i = lim - 100; lim > i; i += 12) {
    c += 3;
    int x = c + 2;
    if (x > 3) {
      x = 3;
    } else {
      x = 1;
    }
  }

  printf("%d\n", c);
  return 0;
}

//*********//
//Output 27
