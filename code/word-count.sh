#!/bin/bash
# Read from stdin and procude a sorted word frequency table

set -o errexit nounset pipefail


tr -cs A-Za-z '\n' |    # put each word on its own line
tr A-Z a-z |            # convert all uppercase letters to lower case
sort |                  # sort the words alphabetically
uniq -c |               # create a frequency table for unique words
sort -rn                # reverse sort by frequency (first column)

