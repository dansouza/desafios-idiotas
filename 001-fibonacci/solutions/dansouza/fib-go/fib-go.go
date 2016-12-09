// go build && ./fib

package main

import (
	"fmt"
)

func fib(n int) int {
	if n <= 1 {
		return n
	}
	return fib(n-1) + fib(n-2)
}

func main() {
	for x := 0; x <= 45; x++ {
		fmt.Printf("fib(%d)=%d\n", x, fib(x))
	}
}
