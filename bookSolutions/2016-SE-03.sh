#!/bin/bash - 
#===============================================================================
#
#          FILE: 2016-SE-03.sh
# 
#         USAGE: ./2016-SE-03.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/02/24 09:49:05
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $(id -u) -ne 0 ]; then
		echo "Not root"
		exit 1
fi


home_dir_per_user=$(cat /etc/passwd | cut -d : -f 1,6)

while IFS=':' read -r user_id home_dir; do
		if [ ! -d "${home_dir}" ]; then
				echo "User ${user_id} don't have home dir: ${home_dir}"
		elif stat -c "%A" ${home_dir} | grep -qv "^..w"; then
				echo "User ${user_id} cannot write in home dir: ${home_dir}"
		else
				echo "User ${user_id} can write in ${home_dir}"
		fi
done < <(echo "${home_dir_per_user}")

