
for group in $(cut -d: -f1 /etc/group); do
    if groups $(whoami) | grep -q $group; then 
	echo "Hello, $group - I am here!"
    else
	echo "Hello, $group"
    fi
done

