#!/bin/bash - 
#===============================================================================
#
#          FILE: 2020-SE-02.sh
# 
#         USAGE: ./2020-SE-02.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/12/24 11:03:34
#      REVISION:  ---
#===============================================================================

set -o nounset # Treat unset variables as an error
ADDRESS_NUMBER="([1-9][0-9]{0,2}|0)"
ADDRESS="(${ADDRESS_NUMBER}.){3}${ADDRESS_NUMBER}"
log_file=$1

top_3_sites=$(cat "$log_file" | cut -d ' ' -f 2 | sort | uniq -c | sort -nr | awk '{print $2}'| head -n 3)

for site in $top_3_sites; do
		site_requests=$(grep -E "^${ADDRESS} ${site}" "$log_file")
		http2_count=$(echo "$site_requests" | grep "HTTP/2.0" | wc -l)
		count=$(echo "$site_requests" | wc -l)
		no_http2_count=$(( $count - $http2_count ))
		echo "$site HTTP/2.0: ${http2_count} non-HTTP/2.0: ${no_http2_count}"
done

cat "$log_file" | cut -d ' ' -f 1,9 | awk '{if ($2 > 302) {print $1}}' | sort | uniq -c
