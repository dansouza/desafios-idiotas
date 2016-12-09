#!/usr/bin/php
<?php

$desafio_basepath = dirname(__FILE__);
chdir($desafio_basepath);
require_once($desafio_basepath . '/common.php');

$puzzles = expand_puzzle_args();
if (!$puzzles) {
	_fail("no puzzles available for testing.");
}

$puzzle_runners = find_puzzle_solutions($puzzles);
if (!$puzzle_runners) {
	_fail("no puzzles available for execution, aborting.");
}

$passed = $failed = array();
$total_passed = $total_failed = 0;

foreach ($puzzle_runners as $puzzle => $authors) {
	$puzzle_tester = "./{$puzzle}/test/test.sh";
	if (!is_executable($puzzle_tester)) {
		_info("skipping puzzle '$puzzle' because it has no test script or it is not executable: $puzzle_tester");
		continue;
	}
	_info("testing puzzle: $puzzle");
	foreach ($authors as $author => $solutions) {
		_info("   testing solutions from: $author");
		foreach ($solutions as $solution => $info) {
			_info("      testing solution: $solution");
			passthru("$puzzle_tester " . escapeshellarg($info['puzzle_runner']), $retval);
			if ($retval == 0) {
				_info("puzzle passed the test.");
				$passed[$puzzle][$author][$solution] = $info;
				$total_passed++;
			} else {
				_info("puzzle failed the test.");
				$failed[$puzzle][$author][$solution] = $info;
				$total_failed++;
			}
		}
	}
}

print "\n\n";
print "    SUMMARY:\n\n";
print "    {$total_passed} tests passed, {$total_failed} tests failed.\n\n";
print "    " . str_pad("PUZZLE", 20) . str_pad("AUTHOR", 20) . str_pad("SOLUTION", 20) . "TEST" . "\n";

foreach (array("PASSED" => $passed, "FAILED" => $failed) as $title => $puzzles) {
	foreach ($puzzles as $puzzle => $authors) {
		foreach ($authors as $author => $solutions) {
			foreach ($solutions as $solution => $info) {
				print "    " . str_pad($puzzle, 20) . str_pad($author, 20) . str_pad($solution, 20) . $title . "\n";
			}
		}
	}
}

print "\n\n";

exit(sizeof($failed) == 0 ? 0 : -1);

