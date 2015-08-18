#!/usr/bin/env perl
# Read from stdin and produce a sorted word frequency table

use strict;
use warnings;
use autodie;


my %word_counts;

# read text from stdin or given file
while (<>) {
	# remove trailing new line, operating on $_
	chomp;
	# convert non-alphabetic characters to space, squeezing duplicates, on $_
	tr/A-Za-z/ /cs;
	# convert to lowercase, assign to $_
	$_ = lc;
	# split $_ by space and store results in array
	my @words = split;
	# count unique words
	for my $word (@words) {
		$word_counts{$word}++;
	}
}

# sort words by descending word frequency and ascending lexicographical order
my @words_sorted = sort
	{ $word_counts{$b} <=> $word_counts{$a} || $a cmp $b }
	keys %word_counts;

# print word frequency table
for my $word (@words_sorted) {
	printf "   %s %s\n", $word_counts{$word}, $word
}

