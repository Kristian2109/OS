
set -o nounset                              # Treat unset variables as an error

if [ $# -ne 2 ]; then
		echo "Invalid number of arguments"
		exit 2
fi

if [ ! -f $1 ]; then
		echo "Invalid file $1"
		exit 2
fi

NAME="[A-Za-z-]+"
LINE_FORMAT="^$NAME $NAME( \(.+\))?: .+$"

file=$1
dir=$2

cat "$file" | egrep -v "$LINE_FORMAT" && echo "Invalid file format of $file" && exit 2

touch dict.txt
counter=0
while IFS= read -r line; do
		full_name=$(echo "$line" | cut -d ':' -f 1 | cut -d ' ' -f -2)
		if ! grep -Eq "^${full_name}" dict.txt; then
				echo "${full_name}; ${counter}" >> dict.txt
				counter=$(($counter + 1))
		fi
		user_counter=$(grep -E "^${full_name}" dict.txt | cut -d ';' -f 2 | cut -b 2-)
		user_text=$(echo "$line" | cut -d ':' -f 2 | cut -b 2-)
		echo "${user_text}" >> "${user_counter}.txt"		
done < "$file"

