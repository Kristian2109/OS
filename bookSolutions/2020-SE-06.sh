
set -o nounset                              # Treat unset variables as an error

filename=$1
key=$2
value=$3

formatted_file=$(cat "$filename" | cut -d "#" -f 1 | grep -E ".+")

if [ $# -ne 3 ]; then
		echo "Invalid arguments"
		exit 2
fi

word_regex="[a-zA-Z0-9_]+"
whitespace="[ \t]*"
line_regex="^${whitespace}${word_regex}${whitespace}=${whitespace}${word_regex}${whitespace}$"

if [ ! -f "$filename" ]; then
		echo "Invalid file!"
 		exit 2		
fi


if echo "$formatted_file" | grep -Ev "${line_regex}"; then
		echo "Invalid file format"
	    exit 2	
fi


if echo "${key}" | grep -Evq "^${word_regex}$"; then
		echo "Invalid key"
		exit 2
fi	   


if echo "${value}" | grep -Evq "^${word_regex}$"; then
		echo "Invalid value"
		exit 2
fi

user=$(whoami)
date=$(date)
if grep -Eq "^${whitespace}${key}" "$filename"; then
		line=$(grep -E "^${whitespace}${key}" "$filename")
		echo "Line is: $line"
		eddited_comment="# edited at ${date} by ${user}"
		edited_line="# ${line} ${eddited_comment}"
		added_line="${key}=${value} # added at ${date} by ${user}"
		sed -Ei "s/^${line}/${edited_line}\n${added_line}/" "$filename"
else 
		echo "${key}=${value} # added at ${date} by ${user}" >> "${filename}"
fi
