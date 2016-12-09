# 002-word-hopper
Hop from word to word in a dictionary, changing one letter at a time, until you get from the initial word to the final word.

## objective

Given a dictionary and two words that are inside the dictionary, you need to figure out how to go from the first word to the last word by mutating the first word one letter at a time, always using only words that are present the dictionary. If it is impossible to do so with the given words, then you should output `<empty>` and nothing more.

To hop from one word to another, they must have one letter changed from each other (ball -> gall), or one letter removed from each other (dice -> ice) or one letter added from each other (rail -> trail). All words must always be present in the dictionary file. You may revisit words if needed, but you must do as little hops as possible.

## input

Input is fed via STDIN. The first line of input is the `<first word>`, the second line of input is the `<final word>` and all subsequent lines are the dictionary.
For example, to hop from the word `tracy` to `mindy` in a dictionary of 24 words (from `mince` to `trace`), input would be:

```
tracy
mindy
mince
raced
stracy
stacy
dog
diced
mind
mic
mice
ice
god
ace
min
peace
tracy
placed
good
mindy
place
pace
race
riced
dice
trace
```

Do not assume that the dictionary will be in any particular order (alphabetically or otherwise).

## output

Output should be one word per line, first word should be the first word passed as argument, last line should be the second word passed as argument.
If it is impossible to hop from the first word to the final word, you should return `<empty>` in a single line, but still exit with status code of 0.

## example

With `test/test-002-input` looking like:

```
mic
race
mince
raced
stracy
stacy
dog
diced
mind
mic
mice
ice
god
ace
min
peace
tracy
placed
good
mindy
place
pace
race
riced
dice
trace
```

Which means that we should start with word `mic` and end at word `race`, using a dictionary of 24 words, we should see:

```
desafios-idiotas/002-word-hopper/solutions/dansouza/go-hopper$ cat ../../../test/test-002-input | ./run.sh
mic
mice
dice
diced
riced
raced
race
desafios-idiotas/002-word-hopper/solutions/dansouza/go-hopper$
```

## testing your solution

```
desafios-idiotas/002-word-hopper$ ./test/test.sh solutions/dansouza/go-hopper/run.sh
[INFO] testing: 002-word-hopper/solutions/dansouza/go-hopper/run.sh
[INFO] workdir: 002-word-hopper/solutions/dansouza/go-hopper
[INFO] tempdir: /tmp/desafios-idiotas-70b648fa6ed9b20a801cb32dee14199414dc7896.5rEm2t7Jrinw
[INFO] running test test-001: hopping from 'mic' to 'race'
mic
mice
dice
diced
riced
raced
race
[INFO] runtime: .002745930 seconds
[INFO] PASSED
[INFO] running test test-002: hopping from 'dog' to 'tracy'
<empty>
[INFO] runtime: .002658320 seconds
[INFO] PASSED
[INFO] running test test-003: hopping from 'pace' to 'peace'
pace
place
peace
[INFO] runtime: .002948032 seconds
[INFO] PASSED
desafios-idiotas/002-word-hopper$
```

