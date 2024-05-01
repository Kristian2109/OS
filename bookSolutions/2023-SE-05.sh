
set -o nounset                              # Treat unset variables as an error
declare -A process_counter

limit=3
counter=0

while [ $counter -lt $limit ]; do
		memory_per_command=$(ps -eo pid=,comm=,rss= | awk '{commands[$2]+=$3} END {for (comm in commands) print comm, commands[comm]}')
		isMet=0
		while IFS=' ' read -r comm memory; do
				if [ "$memory" -gt 1000 ]; then
				            if [ "${process_counter[$comm]+_}" ]; then
                					(( process_counter["$comm"]++ ))
            				else
                					process_counter["$comm"]=1
            				fi
							isMet=1
				fi 
		done < <(echo "$memory_per_command")	
		if [ $isMet -eq 0 ]; then
				break
		fi
		counter=$(( "$counter" + "1"))
		sleep 1
done
if [ $counter -eq 0 ]; then
		echo "No such processes with more than 65536"
fi
half_counter=$(echo "$counter / 2" | bc)
for comm in "${!process_counter[@]}"; do
		if [ "${process_counter[$comm]}" -ge $half_counter ]; then	
    			echo "$comm: ${process_counter[$comm]}"
		fi	
done
