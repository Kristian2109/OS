#!/bin/bash - 
#===============================================================================
#
#          FILE: 05-b-2000.sh
# 
#         USAGE: ./05-b-2000.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/29/24 11:17:26
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
name=""
read -p "Enter your name: " name
echo "Your name is"$name

