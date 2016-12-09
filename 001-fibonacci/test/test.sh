#!/bin/bash

fail() {
	echo "[FAIL] $1"
	exit -1
}

info() {
	echo "[INFO] $1"
}

SOLUTION="$1"
RIGHTHASH="411408252ac0d24ad99c6bbd130063ca7e8ff2ee"

if [ ! -e "$SOLUTION"  ]; then
	fail "missing solution path (a 'run.sh' file) as first argument."
fi

if ! ( echo "$SOLUTION" | egrep 'run.sh$' &> /dev/null ); then
	fail "$SOLUTION is not a 'run.sh' file."
fi

if [ ! -x "$SOLUTION"  ]; then
	fail "$SOLUTION is not executable."
fi

TEST_BASEPATH=$( realpath $0 )
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

info "running solution..."

START=$( date +%s.%N )
./run.sh | tee "$TMPDIR/output"
END=$( date +%s.%N )
ELAPSED=$( echo "($END - $START)" | bc )

info "runtime: $ELAPSED seconds"

VERIFYHASH=$( cat "$TMPDIR/output" | sha1sum | cut -d' ' -f1 )
rm -rf $TMPDIR &> /dev/null

if [ "$VERIFYHASH" != "$RIGHTHASH" ]; then
	fail "output hash verification failed, got '$VERIFYHASH', expected '$RIGHTHASH'"
fi

info "PASSED"

exit 0
