#!/bin/bash

# Set the path to your MKVToolNix installation
MKVTOOLNIX_PATH="/Applications/MKVToolNix-54.0.0.app/Contents/MacOS"

# Get the directory path from the first argument
TARGET_DIRECTORY="$1"

# Check if the directory path is provided
if [ -z "$TARGET_DIRECTORY" ]; then
  echo "Please provide the directory path as an argument."
  exit 1
fi

# Check if the provided directory exists
if [ ! -d "$TARGET_DIRECTORY" ]; then
  echo "Directory does not exist: $TARGET_DIRECTORY"
  exit 1
fi

# Change to the target directory
cd "$TARGET_DIRECTORY" || exit

# Iterate over each MKV file in the directory
for file in *.mkv; do
    # Get the file name without extension
    filename=$(basename "$file" .mkv)

    # Check if the filename contains "-deleted"
    if [[ $filename == *"-deleted"* ]]; then
        # Replace "-deleted" with "(Deleted Scene)" in the title
        title="${filename//-deleted/ (Deleted Scene)}"
    else
        # Use the original filename as the title
        title="$filename"
    fi

    # Use MKVToolNix to update the title with the modified filename
    "$MKVTOOLNIX_PATH"/mkvpropedit "$file" --edit info --set "title=$title"
done
