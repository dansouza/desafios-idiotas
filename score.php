#!/usr/bin/php
<?php

$desafio_basepath = dirname(__FILE__);
chdir($desafio_basepath);
require_once($desafio_basepath . '/common.php');

$puzzles = expand_puzzle_args();
$puzzle_runners = find_puzzle_solutions($puzzles);

if (!$puzzle_runners) {
	_fail("no puzzles available for scoring.");
}

$score = $failed = array();
$total_passed = $total_failed = 0;

foreach ($puzzle_runners as $puzzle => $authors) {
	_info("scoring puzzle: $puzzle");
	foreach ($authors as $author => $solutions) {
		_info("   scoring solutions from: $author");
		foreach ($solutions as $solution => $info) {
			_info("      scoring solution: $solution");
			$puzzle_basepath = dirname($info['puzzle_runner']);
			chdir($puzzle_basepath);

			$start = gettimeofday(true);
			exec('./run.sh', $foo, $retval);
			$elapsed = (gettimeofday(true) - $start);

			chdir($desafio_basepath);
			if ($retval == 0) {
				$info['timing'] = number_format($elapsed, 5);
				$score[$puzzle][$info['timing']][$author][$solution] = $info;
				$total_passed++;
				_info("          solution finished successfully in {$info['timing']} seconds.");
			} else {
				$total_failed++;
				_info("          solution failed to run (exit code: $retval).");
			}
		}
	}
}

print "\n\n";
print "    SUMMARY:\n\n";
print "    {$total_passed} solutions ran with success, {$total_failed} solutions failed.\n\n";


foreach ($score as $puzzle => $timings) {
	ksort($timings);

	print "    " . str_pad("PUZZLE", 20) . str_pad("AUTHOR", 20) . str_pad("SOLUTION", 20) . "TIME" . "\n";
	foreach ($timings as $timing => $authors) {
		foreach ($authors as $author => $solutions) {
			foreach ($solutions as $solution => $info) {
				print "    " . str_pad($puzzle, 20) . str_pad($author, 20) . str_pad($solution, 20) . $info['timing'] . "\n";
			}
		}
	}
	print "\n\n";
}


exit(sizeof($failed) == 0 ? 0 : -1);

