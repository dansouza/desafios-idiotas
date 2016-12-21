#!/usr/bin/env python

from Levenshtein import distance
from dijkstar import Graph, find_path, algorithm
from itertools import product

graph = Graph()

words_dicts = []
visited = []

if __name__ == "__main__":
	first_word = raw_input().strip()
	last_word = raw_input().strip()

	while True:
		try:
			words_dicts.append(raw_input())
		except EOFError:
			break

	visited.append(first_word)
	words_dicts.remove(first_word)

	for visit in visited:
		if visit == last_word:
			break

		for word in set(words_dicts):
			if distance(visit, word) == 1:
				graph.add_edge(visit, word, 1)
				visited.append(word)
				words_dicts.remove(word)

	try:
		for word in find_path(graph, first_word, last_word)[0]:
			print word
	except algorithm.NoPathError:
		print "<empty>"