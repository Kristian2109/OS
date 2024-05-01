#!/bin/bash - 
#===============================================================================
#
#          FILE: 2017-SE-05.sh
# 
#         USAGE: ./2017-SE-05.sh 
# 
#   DESCRIPTION: Returns one filename
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/05/24 14:09:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

dir=$1
architecture=$2

files=$(find "$dir" -maxdepth 1 -type f -printf "%f\n")

NUMBER="[0-9]+"
FILE_REGEX="^vmlinuz-${NUMBER}\.${NUMBER}\.${NUMBER}-${architecture}$"
matching_files=$(find "${dir}" -maxdepth 1 -type f -printf "%f\n" | grep -E "${FILE_REGEX}")

biggest_version=$(echo "$matching_files" | grep -Eo "\-.*\-" | tr -d "-" | awk -F. '{ printf("%03d.%03d.%03d\t%s\n", $1, $2, $3, $0) }' | sort -nr | cut -f2 | head -n 1)

echo "$matching_files" | grep "$biggest_version"
