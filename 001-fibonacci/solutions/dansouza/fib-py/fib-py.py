#!/usr/bin/env python

def fib(n):
    if n <= 1: return n
    else: return fib(n-1)+fib(n-2)

if __name__ == "__main__":
	for x in range(0, 46):
		print "fib(%d)=%d" % (x, fib(x))