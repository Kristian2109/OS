#!/bin/bash - 
#===============================================================================
#
#          FILE: 05-b-3200.sh
# 
#         USAGE: ./05-b-3200.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/31/24 17:52:17
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
read -p "Enter the absolute path: " path

if grep -Eqv "^/" <<< $path; then
		echo "Not an absolute path"
		exit 1
fi

dirs_count=$(find ${path} -type d | wc -l)
files_count=$(find ${path} -type f | wc -l)

echo "Dirs: "$dirs_count"  Files: "$files_count
