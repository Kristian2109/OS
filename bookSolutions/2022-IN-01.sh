#!/bin/bash - 
#===============================================================================
#
#          FILE: 2022-IN-01.sh
# 
#         USAGE: ./2022-IN-01.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/12/24 23:53:06
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

target=$(echo "$1" | rev | cut -d '/' -f 2- | rev)
empty_dir=$(echo "$2" | rev | cut -d '/' -f 2- | rev)

files=$(find "$target" -type f)

for file in $files; do
		to_add="$file"
		if echo "$file" | grep -qE "\.swp$"; then
				regular_file=$(echo "$file" | rev | cut -d "." -f 2- | rev)
				file_dir=$(echo "$regular_file" | rev | cut -d "/" -f 2- | rev)
				file_name=$(echo "$regular_file" | rev | cut -d "/" -f 1 | rev | cut -b 2-)
				if echo "$files" | grep -qE "^${file_dir}/${file_name}$"; then
						echo "$file is a swap file"
						continue
				fi
		fi
		target_dir_len=$(( $(echo "$target" | wc -c) ))
		file_dir=$(echo "$file" | cut -b ${target_dir_len}- | rev | cut -d "/" -f 2- | rev)
		file_name=$(echo "$file" | rev | cut -d "/" -f 1 | rev)
		mkdir -p "${empty_dir}$file_dir"
		touch "${empty_dir}${file_dir}/${file_name}"
done
