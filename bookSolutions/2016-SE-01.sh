
set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
	echo "File accepts only 1 positional argument (dir name)"
	exit 1
fi

dirName=$1

isDir=$(find $dirName -maxdepth 0 -type d 2> /dev/null)

if [ ! $isDir ]; then
	echo "Not Dir"
	exit 1
fi

find dir1/ -type l -exec stat -L {} \;
