package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
)

func isAlpha(c byte) bool {
	return ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z')
}

func toLower(c byte) byte {
	if 'A' <= c && c <= 'Z' {
		return c + 'a' - 'A'
	} else {
		return c
	}
}

// StringCompare is the type of a "Less" function that defines the ordering
type StringCompare func(x, y string) bool

func (cmp StringCompare) Sort(strings []string) {
	sorter := &stringSorter{
		strings: strings,
		compare: cmp,
	}
	sort.Sort(sorter)
}

type stringSorter struct {
	strings []string
	compare StringCompare
}

func (s *stringSorter) Len() int {
	return len(s.strings)
}

func (s *stringSorter) Swap(i, j int) {
	s.strings[i], s.strings[j] = s.strings[j], s.strings[i]
}

func (s *stringSorter) Less(i, j int) bool {
	return s.compare(s.strings[i], s.strings[j])
}

func main() {
	var words []string

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		token := scanner.Bytes()
		start := 0
		n := len(token)
		for i := 0; i <= n; i++ {
			// non-alphabeta character and end of line demarcate word boundary
			if i == n || !isAlpha(token[i]) {
				if start < i {
					// extract word
					words = append(words, string(token[start:i]))
				}
				// shift to next word
				start = i + 1
			} else if i < n {
				// do simultaneous lowercase conversion during loop
				token[i] = toLower(token[i])
			}
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Error while reading stdin: ", err)
		os.Exit(1)
	}

	// count unique words
	word_counts := make(map[string]int)
	for _, w := range words {
		word_counts[w] += 1
	}

	var words_unique []string
	for k := range word_counts {
		words_unique = append(words_unique, k)
	}

	// closure that orders the word
	word_order := func(x, y string) (less bool) {
		if word_counts[x] == word_counts[y] {
			// lexicographical order
			less = x < y
		} else {
			// descending word frequency
			less = word_counts[x] > word_counts[y]
		}
		return
	}

	// sort the unique words
	StringCompare(word_order).Sort(words_unique)

	// print word frequency table
	for _, w := range words_unique {
		fmt.Printf("%4d %s\n", word_counts[w], w)
	}

}
