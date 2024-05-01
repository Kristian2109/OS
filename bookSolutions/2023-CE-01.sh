
set -o nounset                              # Treat unset variables as an error
stars_file=$1
target_type=$2

type_stars=$(cat "$stars_file" | cut -d ',' -f 4,5 | grep -E ",${target_type}$")
target_conselation=$(echo "$type_stars" | cut -d ',' -f 1 | sort | uniq -c | awk '{print $1,$2}' | sort -t ' ' -k 1 -nr | cut -d ' ' -f 2 | head -n 1)
target_star=$(cat "$stars_file" | cut -d ',' -f 1,4,7 | awk -F ',' '{print $2,$1,$3}' | grep -E "^${target_conselation}" | grep -Ev "\-\-$" | sort -t ' ' -k 3 -nr | head -n 1 | cut -d ' ' -f 2) 
echo "$target_star"

