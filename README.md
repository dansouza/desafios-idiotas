# desafios-idiotas
Algorithmic puzzles for the Idiotis group

## getting started

Clone this repository and include your solution to a given puzzle under its `solutions` subdirectory - use your github name first.
For example, my solutions to problem 001 should be under `./001-fibonacci/solutions/dansouza` as such:

* 001-fibonacci/solutions/dansouza/fib-php/run.sh
* 001-fibonacci/solutions/dansouza/fib-go/run.sh
* and so on.

A player can publish as many solutions as he desires as long as he keeps them under his directory.

## publishing a solution

Each problem includes a full description, examples of input and output

Problem [001: Fibonacci](001-fibonacci/) is a very simple exercise that you can use to get acquainted with the process of writing a solution and testing it.

Regardless of what language you decide to use, your solution should always be executed by invoking a `run.sh` script - if your solution needs to be compiled first, you include any necessary steps to a script called `build.sh`. Only the execution time of `run.sh` will be taken into consideration during benchmarks and ranking. Your `build.sh` build script should exit with status 0 if it worked, -1 if build fails. `build.sh` and `run.sh` will be executed with their directories as "working directory" ($CWD) by the testing suites and benchmark suites, so file operations will happen relative to the solution's directory.

If your solution does not require any special preparation to be built (let's say, you're using an interpreted language), you can safely forgo the creation of a `build.sh`. Build scripts and ranking will run on a `Ubuntu 16.10` based container, so your build scripts should take that into consideration. They will run as root, so you can `apt-get install` any packages that you may need. Both `build.sh` and `run.sh` should be marked as executable (`chmod +x run.sh build.sh`).

You can find many examples of solutions to [001: Fibonacci](001-fibonacci/) to be used as reference in several languages.

Your solution should exit with error code of 0 to signal that it ran successfully, -1 otherwise.

## testing your solution

Every problem includes a test suite that you can use against your solution to validate it.

In order for validation to work properly, the output of your solution `stdout` must conform perfectly with the expected output format as explained in the problem's description. You are free to output whatever you want to `stderr` if you need.

For example, to test the solution in [001-fibonacci/solutions/dansouza/fib-php/](001-fibonacci/solutions/dansouza/fib-php/) you can run:

```
~/desafios-idiotas/001-fibonacci$ ./test/test.sh ./solutions/dansouza/php/run.sh
```

Tests are shell scripts so they can be written in any language - `test.sh` should just invoke the actual testing scripts in whatever language the puzzle designer is more comfortable with. `test.sh` should return with exit code 0 if tests passed or -1 if they fail.

You can recursively run all tests to all solutions by running `php test.php`:

```
~/desafios-idiotas$ ./test.php


    SUMMARY:

    3 tests passed, 0 tests failed.

    PUZZLE              AUTHOR              SOLUTION            TEST
    001-fibonacci       dansouza            fib-c               PASSED
    001-fibonacci       dansouza            fib-go-iter         PASSED
    001-fibonacci       dansouza            fib-go-multicore    PASSED


~/desafios-idiotas$
```

You can also test all solutions to only specific puzzles by passing their names as argument, like:

```
~/desafios-idiotas$ ./test.php 001-fibonacci 002-word-hopper
```

## benchmarking & scoring

You can pit your solutions against other player's solutions by running `php score.php`:

```
~/desafios-idiotas$ php score.php
[INFO] scoring puzzle: 001-fibonacci
[INFO]    scoring solutions from: dansouza
[INFO]       scoring solution: fib-c
[INFO]           solution finished successfully in 9.87665 seconds.
[INFO]       scoring solution: fib-go-iter
[INFO]           solution finished successfully in 0.00352 seconds.
[INFO]       scoring solution: fib-go-multicore
[INFO]           solution finished successfully in 8.85573 seconds.


    SUMMARY:

    3 solutions ran with success, 0 solutions failed.

    PUZZLE              AUTHOR              SOLUTION            TIME
    001-fibonacci       dansouza            fib-go-iter         0.00352
    001-fibonacci       dansouza            fib-go-multicore    8.85573
    001-fibonacci       dansouza            fib-c               9.87665


~/desafios-idiotas$

```

That will recursively find solutions to all puzzles and run them (`run.sh`), sorting by time taken - you can pass an optional list of puzzles to be scored instead of score all puzzles:

```
~/desafios-idiotas$ php score.php 001-fibonacci 002-word-hopper
```

## publishing your own puzzles

New puzzles are welcome - first you reserve your puzzle number and title by editing this file (README.md) and declaring it on the `puzzles` enumerated section below and sending a pull request - once you know your puzzle number then you can take your time to write your puzzle and test suites for it. You are not required to include a solution to your puzzle, but a test suite (in the form of a universal `./test/test.sh` as described above) is mandatory.

Puzzles directory naming should obey the pattern: `/^[0-9]{3}\-[A-Za-z0-9\-_]$/`

## puzzles
* [001: Fibonnaci](001-fibonacci/)
* [002: Word Hopper](002-word-hopper/)
