
set -o nounset                              # Treat unset variables as an error
if [ $# -ne 1 ]; then
		echo "Accepts only one argument!"
		exit 1
fi

username=$1

sessions_count=$(who | grep -c ${username})

echo "User has "$sessions_count









