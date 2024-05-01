
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

