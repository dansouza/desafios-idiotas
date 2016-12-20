#!/usr/bin/env python

from Levenshtein import distance
from dijkstar import Graph, find_path, algorithm

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

	while visited != []:
		for word in visited:
			for dict_ in words_dicts:
				if distance(word, dict_) == 1:
					graph.add_edge(word, dict_, 1)
					visited.append(dict_)
					words_dicts.remove(dict_)

			visited.remove(word)

	try:
		for word in find_path(graph, first_word, last_word)[0]:
			print word
	except algorithm.NoPathError:
		print "<empty>"