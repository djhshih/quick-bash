#!/bin/bash
# Read from stdin and produce a sorted word frequency table

set -o errexit
set -o nounset
set -o pipefail


tr -cs A-Za-z '\n' |    # put each word on its own line
tr A-Z a-z |            # convert all uppercase letters to lower case
sort |                  # sort the words alphabetically
uniq -c |               # create a frequency table for unique words
sort -k 1rn -k 2        # sort by descending frequency then lexicographically

