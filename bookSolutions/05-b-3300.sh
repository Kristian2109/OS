
set -o nounset                              # Treat unset variables as an error

read -p "First file: " first_file

read -p "Second file: " second_file

read -p "Third file: " third_file

if [ ! -f $first_file ] || [ ! -f $second_file ] || [ ! -f $third_file ]; then
		echo "Some of the files is invalid!"
		exit 1
fi

paste -d "\n" $first_file $second_file | sort >&2 > $third_file



