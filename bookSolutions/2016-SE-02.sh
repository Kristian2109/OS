
set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
		echo "Accepts only one possitional parameter (number)!"
		exit 1
fi

limit=$1
memory_per_user=$(ps -eo pid=,ruser=,rss= | awk '{ memory_per_user[$2] += $3 } END { for (user in memory_per_user) print user, memory_per_user[user]}')

while IFS=' ' read -r user_id memory; do
	   if [ $memory -ge $limit ]; then
			   process_to_stop=$(ps -u ${user_id} --sort=-rss -o pid= | head -n 1)
			   kill -s SIGSTOP $process_to_stop
			   echo "Process stopped: "$process_to_stop
	   fi
	   echo "User: "$user_id
done <<< "$memory_per_user"



