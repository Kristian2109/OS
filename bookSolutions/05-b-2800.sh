#!/bin/bash - 
#===============================================================================
#
#          FILE: 05-b-2800.sh
# 
#         USAGE: ./05-b-2800.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/29/24 11:22:04
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
	echo "Command accepts only one argument"
	exit 1
fi

if [[ "$1" =~ ^[[:alnum:]]+$ ]]; then
	echo "Parameter "$1" is alphanumeric"
else
	echo "Not alphanumeric"
fi

