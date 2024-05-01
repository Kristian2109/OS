
set -o nounset                              # Treat unset variables as an error

if [ $# -ne 2 ]; then
		echo "Two arguments needed"
		exit 2
fi
temp_dir=$(mktemp -d)
repo="$1"
package="$2"


package_version=$(cat "${package}/version")
package_name=$(echo "${package}" | sed -E "s/\/$//" | rev | cut -d '/' -f 1 | rev)
$(tar -zcvf "${temp_dir}/${package_name}.tar.gz" "${package}/tree")

checksum=$(sha256sum "${temp_dir}/${package_name}.tar.gz" | cut -d ' ' -f 1)

if grep -Eq "^${package_name}-${package_version} " "${repo}/db"; then
		temp=$(mktemp)
		old_checksum=$(grep -E "^${package_name}-${package_version} " "${repo}/db" | cut -d ' ' -f 2)
		grep -Ev "^${package_name}-${package_version} " "${repo}/db" > "$temp" && mv "$temp" "${repo}/db"
		rm "${repo}/packages/${old_checksum}.tar.gz"
fi

mv "${temp_dir}/${package_name}.tar.gz" "${repo}/packages/${checksum}.tar.gz"
echo "${package_name}-${package_version} ${checksum}" >> "${repo}/db"
sort -o "${repo}/db" "${repo}/db"

