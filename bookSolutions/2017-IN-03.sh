#!/bin/bash - 
#===============================================================================
#
#          FILE: 2017-IN-03.sh
# 
#         USAGE: ./2017-IN-03.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/06/24 10:21:50
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

file=$(find /home -printf "%p\t%T@\n" -type f 2> /dev/null | sort -k2 -nr | head -n 1 | cut -f1)

username=$(echo "$file" | cut -d "/" -f 4)

echo "File: $file"
echo "User: $username"
