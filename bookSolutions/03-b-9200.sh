
set -o nounset                              # Treat unset variables as an error

permissionsOfBiggestFile=$(find /etc/ -maxdepth 1 -type f -exec stat -c "%n %s %a" {} \; | sort -t " " -k 2 -nr | head -n1 | cut -d " " -f 3)

echo $permissionsOfBiggestFile

