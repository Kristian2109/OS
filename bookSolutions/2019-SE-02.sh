
set -o nounset                              # Treat unset variables as an error

if [ $# -eq 0 ]; then
		echo "No parameters"
		exit 1
fi

lines_to_show=10
TIME_REGEX="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}"
temp_file=$(mktemp)

if [ $1 = "-n" ]; then
		if echo "$2" | grep -Eq "^[0-9]+$"; then
				lines_to_show="$2"
		else
				echo "Invalid lines count!"
		fi
fi

shift 2
touch "$temp_file"

for file in "$@"; do
		identifier=$(echo "$file" | rev | cut -d '/' -f 1 | rev | sed -E 's/\.log//')
		tail -n "$lines_to_show" "$file" | sed -E "s/^(${TIME_REGEX})/\1 ${identifier}/" 1>> "$temp_file"
done

cat "$temp_file" | sort

rm "$temp_file"
