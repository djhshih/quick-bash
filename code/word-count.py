#!/usr/bin/env python3
# Read from stdin and produce a sorted word frequency table


import fileinput

word_counts = {}

for line in fileinput.input():
    # use list comprehension to generate character list
    # join the characters into a string and split on space
    words = ''.join(
        # conver to lowercase; replace any non-alphnumeric character to space
        c if c.isalnum() else ' ' for c in line.lower()
    ).split()
    # count unique words
    for word in words:
        if word in word_counts:
            word_counts[word] += 1
        else:
            word_counts[word] = 1

# sort words by descending frequency and ascending lexicographical order
word_sorted = sorted(word_counts, key = lambda x: (-word_counts[x], x))

# print word frequency table
for word in word_sorted:
    print('   {} {}'.format(word_counts[word], word))

