#!/usr/bin/env dart
// Read from stdin and produce a sorted word frequency table

import 'dart:io';
import 'dart:convert';

String readInputSync({Encoding encoding: SYSTEM_ENCODING}) {
	final List input = [];
	while (true) {
		int byte = stdin.readByteSync();
		if (byte < 0) {
			if (input.isEmpty) return null;
			break;
		}
		input.add(byte);
	}
	return encoding.decode(input);
}

void word_count(String s) {

	// normalize input string and split into words
	List<String> words = s
		.toLowerCase()
		.replaceAll(new RegExp(r'[^A-Za-z]'), ' ')
		.split(' ');

	// remove empty strings from word list
	words.removeWhere( (x) => x.isEmpty );

	// count unique words
	Map<String, Int> word_counts = new Map();
	for (var i = 0; i < words.length; ++i) {
		var x = words[i];
		if (word_counts.containsKey(x)) {
			++word_counts[x];
		} else {
			word_counts[x] = 1;
		}
	}

	// create unique word list
	// sort by descending frequency, then lexicographically
	List<String> words_unique = new List.from(word_counts.keys);
	words_unique.sort( (x, y) {
		var cmp = word_counts[y].compareTo(word_counts[x]);
		if (cmp == 0) {
			return x.compareTo(y);	
		} else {
			return cmp;
		}
	} );

	// print word frequency table
	for (var i = 0; i < words_unique.length; ++i) {
		var x = words_unique[i];
		print('${word_counts[x]} $x');
	}

}

void main(List<String> args) {
	String text = readInputSync();
	word_count(text);
}

