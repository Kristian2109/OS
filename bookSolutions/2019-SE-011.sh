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

function get_sum {
		current_sum=0
		digits=$(echo "$1" | sed 's/[0-9]/& /g' | tr -d '-')
		for digit in $digits; do
				current_sum=$(($current_sum + $digit))
		done
		echo "$current_sum"
}

max_sum=0
numbers=""
while true; do
	read input
	if [ "$input" == "stop" ]; then
		   break
	fi	   
	if echo "$input" | grep -Eq "$NUMBER"; then
			sum=$(get_sum $input)
			echo "Num ${input} - $sum"
	fi
	numbers="${numbers}${input} "
done

echo "End of input"

max=0
for num in $numbers; do
		current_sum=$(get_sum $num)
		max_sum=$(get_sum $max)
		if [ $current_sum -gt $max_sum ]; then
				max=$num
		elif [ $current_sum -eq $max_sum ] && [ $num -lt $max ]; then
				max=$num
		fi
done	

echo "$max"
