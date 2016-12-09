#!/usr/bin/php
<?php

function fib($n) {
	if ($n <= 1) return $n;
	return fib($n-1)+fib($n-2);
}

for ($x = 0; $x <= 45; $x++) {
	print "fib($x)=" . fib($x) . "\n";
}
