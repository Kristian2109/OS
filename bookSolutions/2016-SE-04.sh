#!/bin/bash - 
#===============================================================================
#
#          FILE: 2016-SE-04.sh
# 
#         USAGE: ./2016-SE-04.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/03/24 18:18:39
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

first_file="$1"
second_file="$2"

first_singer_name=$(sed -E 's/(.*)\/(.*)$/\2/' <(echo $first_file))
second_singer_name=$(sed -E 's/(.*)\/(.*)$/\2/' <(echo $second_file))

first_file_len=$(grep -c "$first_singer_name" "$first_file")
second_file_len=$(grep -c "$second_singer_name" "$second_file")


if [ $first_file_len -ge $second_file_len ]; then
		target_file="$first_file"
else
		target_file="$second_file"
fi


echo $first_file_len $second_file_len
echo $target_file

content=$(sed "s/^.*-//" "$target_file" | sort)

echo "$content" > "${target_file}.songs" 




