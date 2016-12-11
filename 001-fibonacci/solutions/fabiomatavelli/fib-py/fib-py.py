
#!/usr/bin/env python

class fib:
	def __init__(self):
		self.memo = {}

	def __call__(self, n):		
		if not self.memo.get(n) and n > 2:
			self.memo[n] = self.__call__(n-1) + self.__call__(n-2)

		return self.memo.get(n) if n > 2 else n

if __name__ == "__main__":
  f = fib()
  for i in range(46):
  	print "fib(%d)=%d" % (i,f(i))