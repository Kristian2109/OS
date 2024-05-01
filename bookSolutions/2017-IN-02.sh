
set -o nounset                              # Treat unset variables as an error

if [ $(id -u) -ne 0 ]; then
		echo "Not root!"
		exit 1
fi

username=$1

user_processes_count=$(ps -u ${username} -o pid= | wc -l)

users_with_more_processes=$(ps -eo euser | sort | uniq -c | awk -v lower_bound=${user_processes_count} '{if ($1 > $lower_bound) {print $2}}')

if [ -n "$users_with_more_processes" ]; then
		echo "These users have more processes than ${username}:"
	    echo "$users_with_more_processes"
fi

average_process_time=$(ps -eo etimes | awk '{sum += $1} END {print sum / NR}')

time_formatted=$(date -d @${average_process_time} +"%T")
echo "Average process time: $time_formatted"

user_processes=$(ps -u ${username} -o pid=,etimes= | awk '{print $1, $2}')

while IFS=' ' read -r process_id seconds; do
		var=$(($seconds ))
		to_stop=$(echo "$var > $average_process_time" | bc)
		if [ "$to_stop" -eq 1 ]; then
    			echo "Process ${process_id} stopped!"
    			kill -STOP "$process_id"
		fi
done < <(echo "$user_processes")

