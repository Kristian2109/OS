
set -o nounset                              # Treat unset variables as an error

src=$1
target=$2

uniq_rows=$(cut -d ',' -f 2- "$src" | sort | uniq)
temp_file="temp123.txt"
touch "$temp_file"

while IFS= read -r line; do
		cat "$src" | grep -E "^[0-9]+,${line}$" | sort -n | head -n 1 >> "$temp_file"
done < <(echo "$uniq_rows")

touch "$target"
while IFS= read -r line; do
	if grep -q "^${line}$" "$temp_file"; then
			echo "$line" >> "$target"
	fi
done < "$src"

rm "$temp_file"
cat "$target"
