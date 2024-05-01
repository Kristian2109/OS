
set -o nounset                              # Treat unset variables as an error

filename="books.txt"

cat "$filename" | cut -d "-" -f 2,3 | sed 's/^ //' | awk '{printf "%s. %s\n", NR, $0}' | sort -t "." -k 2

