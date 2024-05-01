
set -o nounset                              # Treat unset variables as an error
bad_words_file=$1
while IFS= read -r file; do
		for bad_word in $(cat "$bad_words_file"); do
				word_len=$(echo "$bad_word" | wc -c)
				cenzured_word=""
				for ((i=1; i<$word_len; i++)); do
						cenzured_word="${cenzured_word}*"
				done
				sed -iE "s/\b${bad_word}\b/${cenzured_word}/gI" "$file"
		done
done < <(find "$2" -type f -name "*.txt")

