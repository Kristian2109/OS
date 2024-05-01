#!/bin/bash - 
#===============================================================================
#
#          FILE: 03-b-8500.sh
# 
#         USAGE: ./03-b-8500.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/14/24 10:58:27
#      REVISION:  ---
#===============================================================================

for group in $(cut -d: -f1 /etc/group); do
    if groups $(whoami) | grep -q $group; then 
	echo "Hello, $group - I am here!"
    else
	echo "Hello, $group"
    fi
done

