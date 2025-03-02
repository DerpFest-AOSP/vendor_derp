#!/bin/bash
# shellcheck enable=avoid-nullary-conditions
# Script to generate JSON build information for DerpFest builds

# Colors for terminal output
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NC="\033[0m" # No Color

# Check if file path is provided
if [[ $# -lt 1 ]]; then
    echo -e "${YELLOW}Error: Missing file path argument${NC}"
    echo "Usage: $0 <zip_file_path>"
    exit 1
fi

file_path="$1"
if [[ -f "$file_path" ]]; then
    echo "Generating .json"
    file_name=$(basename "$file_path")
    device_name=$(echo "$file_name" | cut -d'-' -f5)
    
    # Set output directory with fallback
    out_dir="${OUT_DIR:-out}"
    buildprop="$out_dir/target/product/$device_name/system/build.prop"
    
    # Check if build.prop exists
    if [[ ! -f "$buildprop" ]]; then
        echo -e "${YELLOW}Error: build.prop not found at $buildprop${NC}"
        exit 1
    fi
    
    # Get file information
    file_size=$(stat -c %s "$file_path")
    version=$(basename "$file_path" | cut -d'-' -f2)
    sha256=$(cut -d' ' -f1 "$file_path".sha256sum)
    datetime=$(grep -w ro\\.build\\.date\\.utc "$buildprop" | cut -d= -f2)
    link=https://sourceforge.net/projects/derpfest/files/$device_name/$file_name/download
    
    # Determine ROM type based on filename
    if [[ $file_name == *"Official"* ]]; then
        romtype="Official"
    else
        romtype="Community"
    fi
    
    # Generate JSON file
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
    
    # Move JSON file to target directory
    json_target="$out_dir/target/product/$device_name/$device_name.json"
    mv "$file_path".json "$json_target"
    
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}Done generating ${YELLOW}$device_name.json${NC}"
    else
        echo -e "${YELLOW}Error: Failed to move JSON file to $json_target${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}Error: File not found at $file_path${NC}"
    exit 1
fi
