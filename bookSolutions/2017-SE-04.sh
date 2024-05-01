#!/bin/bash - 
#===============================================================================
#
#          FILE: 2017-SE-04.sh
# 
#         USAGE: ./2017-SE-04.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/09/24 22:44:40
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

dir=$1

broken_count=0
symlinks=""
while IFS= read -r file; do
		if [ ! -e "$file" ]; then
				broken_count=$(($broken_count + 1))
		else
				symlink=$(stat "$file" | head -n 1 | cut -d ":" -f 2 | cut -b 2-)
				symlinks="${symlinks}${symlink}\n"
		fi
done < <(find "$dir" -type l)

output=$(echo -e "${symlinks}\nBroken symlinks: ${broken_count}" | sed '/^$/d')

if [ $# -eq 2 ]; then
		echo -e "$output" > $2
else
		echo -e "$output"
fi
