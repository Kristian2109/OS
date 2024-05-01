
set -o nounset                              # Treat unset variables as an error

target_dir=$1

if [ ! -d "$target_dir" ]; then
		echo "Not a valid dir"
fi

files=$(find "$target_dir" -maxdepth 1 -type f -printf "%p %i\n")

temp_dir=$(mktemp -d)
inode_temp_dir=$(mktemp -d)

while IFS=' ' read -r file_name inode; do
		checksum=$(sha256sum "$file_name" | cut -d ' ' -f 1)
		echo "$file_name $inode" >> "${temp_dir}/${checksum}"

		echo "$file_name" >> "${inode_temp_dir}/${inode}"

done < <(echo "$files")

checksums=$(find "$temp_dir" -type f)

while IFS= read -r checksum; do
		count_per_inode=$(cat "$checksum" | cut -d ' ' -f 2 | sort | uniq -c)
		group_inodes=$(echo "$count_per_inode" | awk '{if ($1 > 1) print $2}')
		single_inodes=$(echo "$count_per_inode" | awk '{if ($1 == 1) print $2}')
		copies_count=$(echo "$single_inodes" | wc -l)
		
		if [ $copies_count -gt 1 ] && [ -z $group_inodes ]; then
				tail -n +2 "$checksum" | cut -d ' ' -f 1
		elif [ ! -z "$group_inodes" ]; then
				while IFS= read -r inode; do
						head -n 1 "$inode_temp_dir/$inode"
				done < <(echo "$group_inodes")

				if [ $copies_count > 1 ]; then
						while IFS= read -r inode; do
								cat "$inode_temp_dir/$inode"
						done < <(echo "$single_inodes")
				fi
		fi
		
		echo "Copies Count: $copies_count"
		echo "Groups: $group_inodes"
done < <(echo "$checksums")
