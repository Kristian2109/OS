
set -o nounset                              # Treat unset variables as an error

lower_bound=$1
upper_bound=$2
NUMBER_REGEX="[1-9][0-9]*|0"

if ! echo $lower_bound | grep -Eq ${NUMBER_REGEX}; then
		echo "Invalid lower bound: "$lower_bound
		exit 2
fi


if ! echo $upper_bound | grep -Eq ${NUMBER_REGEX}; then
		echo "Invalid upper bound: "$upper_bound
		exit 2
fi

mkdir a b c

len_per_file=$(find -maxdepth 1 -type f -exec wc -l {} \;)

while IFS=' ' read -r len file_name; do	
		if [ "${len}" -lt "${lower_bound}" ]; then
				dir=a
		elif [ "${len}" -lt "${upper_bound}" ]; then
				dir=b
		else
				dir=c
		fi

		mv "${file_name}" "${dir}/${file_name}"
done < <(echo "$len_per_file")


