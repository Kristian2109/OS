#!/bin/bash - 
#===============================================================================
#
#          FILE: 2023-SE-04.sh
# 
#         USAGE: ./2023-SE-04.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/11/24 18:17:25
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
target_dir=$1
files_table=$(mktemp)
for file in $(find "$target_dir" -type f); do
		sha256sum "$file" | cut -d ' ' -f 3,1 >> "$files_table"
done

while IFS=' ' read -r checksum count; do
		original_file=$(grep -E "^${checksum}" "$files_table" | cut -d ' ' -f 2 | head -n 1)
		files_to_remove=$(grep -E "^${checksum}" "$files_table" | cut -d ' ' -f 2 | tail -n +2)
		for file in $files_to_remove; do
				rm "$file"
				ln "$original_file" "$file"
		done
done < <(cat "$files_table" | cut -d ' ' -f 1 | sort | uniq -c | awk '{if ($2 > 1) print $2,$1}')
