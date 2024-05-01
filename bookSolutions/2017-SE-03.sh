
set -o nounset                              # Treat unset variables as an error
processes=$(ps -e -o user=,pid=,rss= | awk '{memory_per_user[$1]+=$3; count_per_user[$1]++} END {for (user in memory_per_user) print user,memory_per_user[user],count_per_user[user]}')

echo "$processes"

users=$(echo "$processes" | cut -d ' ' -f 1)

while IFS=' ' read -r user memory processes_count; do
		average_memory=$(echo "scale=2; $memory / $processes_count" | bc)
		biggest_process=$(ps -u $user -o pid=,rss= | awk '{print $1,$2}' | sort -t ' ' -k 2 -nr | head -n 1)  
		memory=$(echo "$biggest_process" | cut -d ' ' -f 2)
		is_bigger=$(echo "($memory / 2) > $average_memory" | bc)
		if [ $is_bigger -eq 1 ]; then
				kill $(echo "$biggest_process" | cut -d ' ' -f 1)
				echo "Bigger: $biggest_process"
		fi
		
done < <(echo "$processes")
