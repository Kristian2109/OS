#!/bin/bash - 
#===============================================================================
#
#          FILE: 2017-SE-02.sh
# 
#         USAGE: ./2017-SE-02.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/05/24 11:46:11
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $(id -u) -ne 0 ]; then
		echo "Not root"
		exit 1
fi

if [ $# -ne 3 ]; then
		echo "Not three arguments"
		exit 1
fi

source_dir=$1
empty_dir=$2
string=$3

if [ ! -d "$empty_dir" ] || [ "$(find "$empty_dir")" != "$empty_dir" ]; then
		echo "Second argument isn't empty directory."
		exit 1
fi

if [ ! -d "$source_dir" ]; then
		echo "First argument isn't a directory."
		exit 1
fi

files_to_move=$(find "$source_dir" -name "*${string}*" -type f)

while IFS= read -r file_name; do
		new_file=$(echo "$file_name" | sed -E "s/^${source_dir}/${empty_dir}/")
		new_file_dir=$(echo "$new_file" | sed -E "s/\/[[:alnum:].]+$//")
		echo "To create: $new_file"
		if [ ! -d "$new_file_dir" ]; then
			mkdir -p "$new_file_dir"
		fi
		cp "$file_name" "$new_file"
done < <(echo "$files_to_move")
