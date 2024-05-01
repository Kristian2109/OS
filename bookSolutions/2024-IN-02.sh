
set -o nounset                              # Treat unset variables as an error

project_path="$1"
output="$2"

header_files=$(find "$project_path" -type f -name "*.h")
CLASS_NAME="[A-Za-z_][A-Za-z_0-9]*"
ACCESS="(private|public|protected)"

if [ ! -f "$output" ]; then
		touch "$output"
fi

for file in $header_files; do
		declaration_line=$(grep -E "^class " "$file")
		if echo "$declaration_line" | grep -Evq "^class ${CLASS_NAME}( : ($ACCESS ${CLASS_NAME}, )$ACCESS $CLASS_NAME)?"; then
				echo "Invalid line - $line"
				exit 2
		fi

		class_name=$(echo $declaration_line | cut -d " " -f 2)
		if ! grep -Eq "^${class_name}$" "$output"; then
				echo "$class_name" >> "$output"
		fi
		
		if echo "$declaration_line" | grep -Eq "^class $class_name :"; then
				parents=$(echo "$declaration_line" | cut -d ":" -f 2 | sed -E "s/${ACCESS} //g" | sed -E "s/,//g")
				for parent in $parents; do
						echo "${parent} -> ${class_name}" >> "$output"
				done
		fi		
done

