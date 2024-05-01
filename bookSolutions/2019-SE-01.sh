#!/bin/bash - 
#===============================================================================
#
#          FILE: 2019-SE-01.sh
# 
#         USAGE: ./2019-SE-01.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/10/24 14:24:14
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

NUMBER="^(\-?[1-9][0-9]*|0)$"

max_value=0
numbers=""
while true; do
	read input
	if [ "$input" == "stop" ]; then
		   break
	fi	   
	if echo "$input" | grep -Eq "$NUMBER"; then
			if [ "$input" -lt 0 ]; then
					(( -($input) > $max_value )) && max_value=$input
			elif [ "$input" -gt 0 ]; then
					(( $input > $max_value )) && max_value=$input
			fi
			numbers="${numbers}${input} "
	fi
done

passed=""
for num in $numbers; do
		if ! echo -e "$passed" | grep -Eq "^${num}$" && ((( $num == $max_value )) || (( -($num) == $max_value ))); then
				echo "$num"
		fi
		passed="${passed}${num}\n"
done

