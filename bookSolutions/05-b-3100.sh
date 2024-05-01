#!/bin/bash - 
#===============================================================================
#
#          FILE: 05-b-3100.sh
# 
#         USAGE: ./05-b-3100.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/31/24 17:45:27
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
if [ $# -ne 1 ]; then
		echo "Accepts only one argument!"
		exit 1
fi

username=$1

sessions_count=$(who | grep -c ${username})

echo "User has "$sessions_count









