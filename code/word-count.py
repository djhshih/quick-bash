#!/usr/bin/env python3
# Read from stdin and produce a sorted word frequency table


import fileinput

word_counts = {}

for line in fileinput.input():
    words = ''.join(
        c for c in line.lower().replace('-', ' ')
            if c.isalnum() or c.isspace()
    ).split()
    for word in words:
        if word in word_counts:
            word_counts[word] += 1
        else:
            word_counts[word] = 1

word_sorted = sorted(word_counts, key = lambda x: (-word_counts[x], x))

for word in word_sorted:
    print('   {} {}'.format(word_counts[word], word))

