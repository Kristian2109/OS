#!/bin/bash - 
#===============================================================================
#
#          FILE: 2016-SE-06.sh
# 
#         USAGE: ./2016-SE-06.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/05/24 11:09:46
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

filename="books.txt"

cat "$filename" | cut -d "-" -f 2,3 | sed 's/^ //' | awk '{printf "%s. %s\n", NR, $0}' | sort -t "." -k 2

