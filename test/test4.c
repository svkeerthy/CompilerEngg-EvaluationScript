#include<stdio.h>

int test4() {
  int n = 0;
  for (int i = 4096; i > 1; i /= 2) {
    n += i * i;
  }
  return n;
}

int main() { printf("%d\n", test4()); }

//*********//
//Output 22369620
