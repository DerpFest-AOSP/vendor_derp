#!/bin/bash
# shellcheck enable=avoid-nullary-conditions

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

file_path=$1
if [[ -f $file_path ]]; then
    echo "Generating .json"
    file_name=$(basename "$file_path")
    device_name=$(echo "$file_name" | cut -d'-' -f5)
    buildprop=${OUT_DIR:-out}/target/product/$device_name/system/build.prop
    file_size=$(stat -c %s "$file_path")
    version=$(basename "$file_path" | cut -d'-' -f2)
    sha256=$(cut -d' ' -f1 "$file_path".sha256sum)
    datetime=$(grep -w ro\\.build\\.date\\.utc "$buildprop" | cut -d= -f2)
    link=https://sourceforge.net/projects/derpfest/files/$device_name/$file_name/download
    
    if [[ $file_name == *"Official"* ]]; then
        romtype="Official"
    else
        romtype="Community"
    fi
    
    cat >"$file_path".json <<JSON
{
  "response": [
    {
      "datetime": $datetime,
      "filename": "$file_name",
      "id": "$sha256",
      "romtype": "$romtype",
      "size": $file_size,
      "url": "$link",
      "version": "$version"
    }
  ]
}
JSON
    mv "$file_path".json "${OUT_DIR:-out}"/target/product/"$device_name"/"$device_name".json
    echo -e "${GREEN}Done generating ${YELLOW}$device_name.json${NC}"
fi
