// go build && ./fib

package main

import (
	"fmt"
)

var (
	memoList = make(map[int]int)
)

func fib(n int) int {
	if n <= 1 {
		return n
	}
	if r, ok := memoList[n]; ok {
		return r
	}
	for i, j := 0, 1; ; i, j = i+j, i {
		if n == 0 {
			memoList[n] = i
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
