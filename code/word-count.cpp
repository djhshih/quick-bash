// Read from stdin and produce a sorted word frequency table

// Compile:
// g++ -o word_count -std=c++11 word_count.cpp

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <map>

using namespace std;


// Count unique words from input text stream and print word frequency table
void word_count(istream& stream) {
	string line;
	map<string, size_t> word_counts;

	// process text from input stream
	while (getline(stream, line)) {
		// convert to lowercase
		transform(line.begin(), line.end(), line.begin(), ::tolower);

		// extract words and count them
		size_t start = 0;
		size_t line_length = line.length();
		for (size_t i = 0; i <= line_length; ++i) {
			// look for word boundary as marked by non-alphabet characters or EOL
			if (!isalpha(line[i]) || i == line_length) {
				if (i > start) {
					string word = line.substr(start, i - start);
					if (word_counts.find(word) == word_counts.end()) {
						// word does not exist: add it
						word_counts[word] = 1;
					} else {
						// word exists: increment it
						++word_counts[word];
					}
				}
				// shift to next word
				start = i+1;
			}
		}
	}

	// sort words by frequency
	vector<string> words;
	words.reserve(word_counts.size());
	for (auto it = word_counts.begin(); it != word_counts.end(); ++it) {
		words.push_back(it->first);
	}
	auto compare_words = [&word_counts](const string& a, const string& b) {
		return word_counts[b] < word_counts[a]
			|| (word_counts[b] == word_counts[a] && a < b);
	};
	sort(words.begin(), words.end(), compare_words);

	// print word frequency table
	for (auto it = words.begin(); it != words.end(); ++it) {
		cout << "   " << word_counts[*it] << ' ' << *it << endl;
	}
}

int main(int argc, char* argv[]) {

	// process input stream or given text file
	if (argc == 1) {
		word_count(cin);
	} else {
		ifstream in(argv[1]);
		word_count(in);
	}

	return 0;
}

