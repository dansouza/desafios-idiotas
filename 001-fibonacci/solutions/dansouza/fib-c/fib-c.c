// gcc -O3 -o fib-c fib-c.c
#include <stdio.h>

int fib(int n) {
	if (n <= 1) return n;
	return fib(n-1)+fib(n-2);
}

int main() {
	for (int x = 0; x <= 45; x++) {
		printf("fib(%d)=%d\n", x, fib(x));
	}
}

