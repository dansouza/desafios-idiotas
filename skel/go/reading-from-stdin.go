package main

import (
	"bufio"
	"log"
	"os"
)

var (
	logger = log.New(os.Stderr, "", 0)
)

func main() {
	var first_line string
	var last_line string
	var rest = []string{}

	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	first_line = scanner.Text()
	scanner.Scan()
	last_line = scanner.Text()
	for scanner.Scan() {
		rest = append(rest, scanner.Text())
	}
	// does something with them
	something(first_line, last_line, rest)
	os.Exit(0)
}
