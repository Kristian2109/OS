
set -o nounset                              # Treat unset variables as an error
FQDN="[a-z0-9]+[a-z0-9\.]*\."
TTL="[0-9]+"
NUMBER="([0-9]+|0)"
KLASS="IN"
TYPE="(SOA|NS|A|AAAA)"
DATA=".*$"
WHITESPACE="[ \t]+"
SOA_CONTENT=""
LINE="^${FQDN}(${WHITESPACE}${TTL}${WHITESPACE}|${WHITESPACE})${KLASS}${WHITESPACE}${TYPE}"
SOA_LINE="${LINE}(${FQDN}${WHITESPACE})\2(${NUMBER})\4${NUMBER}$"
NORMAL_LINE="${LINE}${WHITESPACE}.*"

for file in "$@"; do
		echo "$file"
		if [ ! -f "$file" ]; then
				echo "${file} isnt' a file!"
				continue
		fi
		file_no_comments=$(sed -E 's/;.*//' "$file")
		
		first_line=$(echo "$file_no_comments" | head -n 1)
		if echo $first_line | grep -qv "SOA"; then
				"${file}:${1}:First line isn't SOA"
				continue
		elif echo "$first_line" | grep -qE "\(${WHITESPACE}*$"; then
				begin_index=7
				echo "Other format"
		elif echo "$first_line" | grep -E "$LINE"; then
				begin_index=2
				echo "Standard format"
				current_serial=$(head -n 1 data/2021-SE-021.txt | rev | awk '{print $5}' | rev)
				today=$(date +"%Y%m%d")
				new_serial="$current_serial"
				if [ $(echo "$current_serial" | cut -b -8) -eq "$today" ]; then
						if [ $(echo "$current_serial" | cut -b 8-) -ne 99 ]; then
								new_serial=$(( "$current_serial" + 1 ))
						fi
				elif [ $(echo "$current_serial" | cut -b -8) -gt "$today" ]; then
						new_serial=$(echo "${today}00")
				fi
				if [ $new_serial != $current_serial ]; then
						delimited_first_line=$(echo "$first_line" | sed -E "s/${current_serial}/;/")
						first_part=$(echo "$delimited_first_line" | cut -d ';' -f 1)
						second_part=$(echo "$delimited_first_line" | cut -d ';' -f 2)
						new_first_line="${first_part}${new_serial}${second_part}"
						sed -iE "s/${first_line}/${new_first_line}/" "$file"
				fi
		else 
				echo "Invalid SOA format."
				continue
		fi

		while IFS= read -r line; do
				if echo "$line" | grep -Ev "$NORMAL_LINE"; then
						echo "Invalid format on line: $line"
				elif echo "$line" | awk '{print $3,$4}' | grep "SOA"; then
						echo "More than one SOA in line: $line" 
				fi
		done < <(tail -n +"$begin_index" $file)
done

