#!/bin/bash - 
#===============================================================================
#
#          FILE: 05-b-3300.sh
# 
#         USAGE: ./05-b-3300.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/31/24 18:01:00
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

read -p "First file: " first_file

read -p "Second file: " second_file

read -p "Third file: " third_file

if [ ! -f $first_file ] || [ ! -f $second_file ] || [ ! -f $third_file ]; then
		echo "Some of the files is invalid!"
		exit 1
fi

paste -d "\n" $first_file $second_file | sort >&2 > $third_file



