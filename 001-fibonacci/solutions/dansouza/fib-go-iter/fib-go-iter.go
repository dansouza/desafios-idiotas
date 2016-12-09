// go build && ./fib

package main

import (
	"fmt"
)

func fib(n int) int {
	if n <= 1 {
		return n
	}
	for i, j := 0, 1; ; i, j = i+j, i {
		if n == 0 {
			return i
		}
		n--
	}

}

func main() {
	for x := 0; x <= 45; x++ {
		fmt.Printf("fib(%d)=%d\n", x, fib(x))
	}
}
