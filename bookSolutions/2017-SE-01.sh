
set -o nounset                              # Treat unset variables as an error

target_dir=$1

if [ $# == 2 ]; then
		hardlinks_count=$2
		find "$target_dir" -type f -printf "%p %n\n" | awk -v lower_bound=$hardlinks_count '{if ($2 >= lower_bound) print $1}'
else
		while IFS= read -r symlink; do
				! (test -e "$symlink") && echo "$symlink"
		done < <(find "$target_dir" -type l)	
fi

