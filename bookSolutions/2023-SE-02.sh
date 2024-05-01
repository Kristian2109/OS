#!/bin/bash - 
#===============================================================================
#
#          FILE: 2023-SE-02.sh
# 
#         USAGE: ./2023-SE-02.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/06/24 14:09:13
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

time_to_run="$1"
shift 1
comm="$@"

echo "$comm"

starting_time=$(date +"%s.%2N")
end_time=$(echo "${starting_time} + ${time_to_run}" | bc)
command_counter=0
echo "Start: ${starting_time} End: ${end_time}"

while [ $(echo "$(date +'%s.%2N') < ${end_time}" | bc) -eq 1 ]; do
		$@ > /dev/null		
		command_counter=$(echo "${command_counter} + 1" | bc)
done

time=$(echo "$(date +"%s.%2N") - ${starting_time}" | bc)
echo "Rann command: ${comm} ${command_counter} times in ${time}"
average_time=$(echo "scale=3; $time / $command_counter" | bc)
echo "Average time: $average_time" 
