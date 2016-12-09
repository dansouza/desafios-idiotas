// go build && ./fib

package main

import (
	"fmt"
	"sync"
)

const (
	WORKERS = 8
	N       = 45
)

var (
	wg       sync.WaitGroup
	m        sync.Mutex
	memoLock sync.RWMutex
	memoList = make(map[int]int)
	fibList  = make(map[int]int)
	workList = make(chan int, WORKERS)
)

func fib(n int) int {
	if n <= 1 {
		return n
	}

	memoLock.RLock()
	if r, ok := memoList[n]; ok {
		memoLock.RUnlock()
		return r
	}
	memoLock.RUnlock()

	x := fib(n-1) + fib(n-2)
	memoLock.Lock()
	memoList[n] = x
	memoLock.Unlock()
	return x
}

func worker() {
	for {
		id := <-workList
		n := fib(id)
		m.Lock()
		fibList[id] = n
		m.Unlock()
		wg.Done()
	}
}

func main() {
	for w := 1; w <= WORKERS; w++ {
		go worker()
	}

	for x := 0; x <= N; x++ {
		wg.Add(1)
		workList <- x
	}

	wg.Wait()

	for x := 0; x <= N; x++ {
		fmt.Printf("fib(%d)=%d\n", x, fibList[x])
	}
}
