#!/usr/bin/env node

function fib(n) {
    if (n <= 1) return n;
    return fib(n-1)+fib(n-2);
}

for (var x = 0; x <= 45; x++) {
	console.log("fib(" + x + ")=" + fib(x))
}

