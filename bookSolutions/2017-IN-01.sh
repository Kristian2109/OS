#!/bin/bash - 
#===============================================================================
#
#          FILE: 2017-IN-01.sh
# 
#         USAGE: ./2017-IN-01.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/04/24 11:03:44
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

filename=$1
key1=$2
key2=$3

first_values=$(grep -E "^${key1}=" "$filename" | cut -d "=" -f 2)
second_values=$(grep -E "^${key2}=" "$filename" | cut -d "=" -f 2)

if [ ! -n "$second_values" ]; then
		echo "Second string not found!"
		exit 0
fi

echo "First values are: $first_values"
echo "Second values are: $second_values"

uniq_elements=$(comm -13 <(echo "$first_values" | sed 's/ /\n/g' | sort) <(echo "$second_values" | sed 's/ /\n/g' | sort) | awk '{printf "%s ", $0}')

echo "$uniq_elements"

sed -Ei "s/^(${key2}=)(.*)$/\1${uniq_elements}/" $filename
