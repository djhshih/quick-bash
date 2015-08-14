# Quick Guide on Bash

Bash is *not* a general-purpose programming language. It is a language for
programming the shell, which provides an interface to access the services of a
Linux operating system. Despite its ancient syntax and crippling limitations,
Bash remains relevant today for managing system programs and automating small
tasks in a Linux environment. *Bash is certainly worth learning*.

To illustrate the utility of Bash, imagine that you are asked to
write

> A program that deads a text file and prints a table of unique words and
> corresponding frequencies, sorted from most to least frequent.

In 1986, Donald Knuth, the Father of the analysis of computer algorithms, was
asked to write such a program. He produced a solution in Pascal that was 10
pages in length. This code was well-designed, thoroughly commented, and
introduced a novel data structure. The same task can be achieved by the
following 5-line Bash script:

```bash
tr -cs A-Za-z '\n' |    # put each word on its own line
tr A-Z a-z |            # convert all uppercase letters to lower case
sort |                  # sort the words alphabetically
uniq -c |               # create a frequency table for unique words
sort -rn                # reverse sort by frequency (first column)
```

The reason why this Bash script is so terse is because *it does not start from
scratch*; rather, it feeds the input through a series of existing programs to
produce the desired output. Bash breaks down a complex task into smaller jobs
that it delegates to specialized Linux programs.

Indeed, Bash excels in work flow management. While Bash is a poor choice for
writing complicated, error-proof, performance-critical applications, it is a
widely used language for managing programs in the Linux environment.  With this
guide, you will learn to write simple and comprehensible Bash scripts, allowing
you to achieve the full potential of Linux.

