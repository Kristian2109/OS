#!/bin/bash - 
#===============================================================================
#
#          FILE: 2017-SE-06.sh
# 
#         USAGE: ./2017-SE-06.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/09/24 23:16:27
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function get_user_memory {
		ps -u "$1" -o rss= | awk '{sum+=$1} END {print sum}'	
}

if [ ! $(id -u) -ne 0 ]; then
		echo "Not root"
		exit 2
fi
root_memory=$(get_user_memory "root")
echo "$root_memory"
while IFS=':' read -r username home_dir; do
		if [ ! -d "$home_dir" ]; then
				ps -u "$username" -o pid=,comm=
		elif [ $(stat -c "%U" "$home_dir") != "$username" ]; then
				echo "$username isn't an owner of $home_dir"
				ps -u "$username" -o pid=,comm=
		elif [ $(stat -c "%A" /var/lib/redis/ | cut -b 3) != "w" ]; then
				echo "$username cannot write in $home_dir"
				ps -u "$username" -o pid=,comm=
		fi
		
		current_user_memory=$(get_user_memory "$username")
		if [ ! -z "$current_user_memory" ] && [ "$current_user_memory" -gt "$root_memory" ]; then
				ps -u $username -o pid= | xargs kill
				echo "Processes of ${username} killed"
		fi
done < <(cat "/etc/passwd" | cut -d ":" -f 1,6)

