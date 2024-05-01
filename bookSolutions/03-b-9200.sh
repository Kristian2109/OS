#!/bin/bash - 
#===============================================================================
#
#          FILE: 03-b-9200.sh
# 
#         USAGE: ./03-b-9200.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/20/24 11:13:15
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

permissionsOfBiggestFile=$(find /etc/ -maxdepth 1 -type f -exec stat -c "%n %s %a" {} \; | sort -t " " -k 2 -nr | head -n1 | cut -d " " -f 3)

echo $permissionsOfBiggestFile

