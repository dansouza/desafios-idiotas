<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

function _fail($text) {
	print "[FAIL] $text\n";
	exit(-1);
}

function _info($text) {
	print "[INFO] $text\n";
}

function puzzle_info($puzzle_path) {
	# 001-fibonacci/solutions/dansouza/fib-go-multimemo/run.sh
	if (preg_match('#^([0-9]{3}\-[A-Za-z0-9\-_]+)/solutions/([a-zA-Z0-9\-_]+)/([a-zA-Z0-9\-_]+)/run\.sh$#', $puzzle_path, $matches)) {
		$output = array(
			'puzzle_name' => $matches[1],
			'puzzle_author' => $matches[2],
			'puzzle_solution' => $matches[3],
			'puzzle_runner' => $puzzle_path,
		);
		$basepath = dirname($puzzle_path);
		if (is_executable("$basepath/build.sh")) {
			$output['puzzle_builder'] = "$basepath/build.sh";
		}
		return $output;
	}
	return array();
}

function filter_puzzle_names($puzzle_list) {
	$output = array();
	foreach ($puzzle_list as $puzzle_name) {
		$puzzle_name = trim(strtr($puzzle_name, './', '  '));
		if (preg_match('/^[0-9]{3}\-[A-Za-z0-9\-_]+$/', $puzzle_name)) {
			if (is_dir($puzzle_name)) {
				$output[] = $puzzle_name;
			}
		}
	}
	return $output;
}

function find_puzzle_solutions($puzzle_list) {
	$solutions = array();
	foreach ($puzzle_list as $puzzle_name) {
		foreach (explode("\n", trim(`find $puzzle_name -name run.sh`)) as $solution_runner) {
			if (is_executable($solution_runner)) {
				if ($info = puzzle_info($solution_runner)) {
					$solutions[$info['puzzle_name']][$info['puzzle_author']][$info['puzzle_solution']] = $info;
				}
			}
		}
	}
	return $solutions;
}

function expand_puzzle_args() {
	global $argv;

	$puzzles = array_slice($argv, 1);
	if (!$puzzles) {
		$puzzles = array_filter(explode("\n", `find . -type d | egrep '^\./[0-9]{3}\-' | cut -d/ -f2 | sort -u`), "trim");
	}
	return filter_puzzle_names($puzzles);
}
