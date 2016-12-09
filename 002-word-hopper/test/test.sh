#!/bin/bash

fail() {
	echo "[FAIL] $1"
	exit -1
}

info() {
	echo "[INFO] $1"
}

SOLUTION="$1"

if [ ! -e "$SOLUTION"  ]; then
	fail "missing solution path (a 'run.sh' file) as first argument."
fi

if ! ( echo "$SOLUTION" | egrep 'run.sh$' &> /dev/null ); then
	fail "$SOLUTION is not a 'run.sh' file."
fi

if [ ! -x "$SOLUTION"  ]; then
	fail "$SOLUTION is not executable."
fi

TEST_FULLPATH=$( realpath $0 )
TEST_BASEPATH=$( dirname $TEST_FULLPATH )
FULLPATH=$( realpath $SOLUTION )
WORKDIR=$( dirname $FULLPATH )
TMPDIR=$( mktemp -d "${TMPDIR:-/tmp/}desafios-idiotas-$( echo $FULLPATH | sha1sum | cut -d' ' -f1 ).XXXXXXXXXXXX" )

info "testing: $FULLPATH"
info "workdir: $WORKDIR"
info "tempdir: $TMPDIR"

cd $WORKDIR

if [ -x "build.sh" ]; then
	info "building..."
	if ! ./build.sh; then
		rm -rf $TMPDIR &> /dev/null
		fail "build failed! aborting."
	fi
fi;

FAILED=0

for TEST_PREFIX in ` ls $TEST_BASEPATH/test-* | egrep '[0-9]{3}$' `; do
	TEST_BASE=$( basename $TEST_PREFIX )
	TEST_TITLE=$( cat $TEST_PREFIX )
	TEST_INPUT="$TEST_PREFIX-input"

	info "running test $TEST_BASE: $TEST_TITLE"
	
	START=$( date +%s.%N )
	cat $TEST_INPUT | ./run.sh | tee "$TMPDIR/$TEST_BASE-output"
	END=$( date +%s.%N )
	ELAPSED=$( echo "($END - $START)" | bc )
	info "runtime: $ELAPSED seconds"

	if [ "`sha1sum $TEST_PREFIX-output | cut -d' ' -f1`" != "`sha1sum $TMPDIR/$TEST_BASE-output | cut -d' ' -f1`" ]; then
		info "FAILED (expected output can be found at '$TEST_PREFIX-output')"
		FAILED=1
	else
		info "PASSED"
	fi
done

rm -rf $TMPDIR &> /dev/null

if [ $FAILED -eq 0 ]; then
	exit 0
else
	exit -1
fi
