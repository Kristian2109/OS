#!/bin/bash - 
#===============================================================================
#
#          FILE: 2022-SE-01.sh
# 
#         USAGE: ./2022-SE-01.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/08/24 17:20:46
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

conf_file=$1
wakeup_file="/home/krisko/wakeup"

if [ ! -f "$conf_file" ]; then
		echo "File $conf_file is isn't a file"
fi

conf_file=$(sed -E 's/#.*$//' $conf_file | sed -E '/^$/d' | awk '{print $1,$2}')

while IFS=' ' read -r device_id desired_mode; do
		if ! grep -qE "^${device_id}" "$wakeup_file"; then
				echo "${device_id} isn't available in ${wakeup_file}."
				continue
		else
				current_mode=$(awk -v dev_id="${device_id}" '{if (dev_id == $1) print $3}' "$wakeup_file" | cut -b 2-)
				if [ "$current_mode" != "${desired_mode}" ]; then
						sed -Ei "s/(^${device_id}.*)(\*${current_mode})(.*$)/\1${desired_mode}\3/" "$wakeup_file"
				fi
		fi
done < <(echo -e "$conf_file")

