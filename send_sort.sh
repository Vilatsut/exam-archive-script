#!/bin/bash

# Check correct amount of arguments
if [ $# -ne 4 ]; then
    echo "Usage: $0 <source_folder> <destination_folder> <user@server> <password>"
    exit 1
fi

# Store the source files, destination folder, server address, and password in variables
source_files="$1"
destination="$2"
address="$3"
password="$4"

# Create folders if they dont exist on server
sshpass -p "$password" ssh -o LogLevel=Fatal -o StrictHostKeyChecking=no "$address" << EOF
    if [ ! -d "$destination" ]; then
        mkdir -p "$destination"
    fi
EOF

# Send files to server
sshpass -p "$password" scp -o LogLevel=Fatal "$source_files"/* "$address":"$destination"

# Sort files on server
sshpass -p "$password"  ssh -o LogLevel=Fatal -o StrictHostKeyChecking=no "$address" << EOF
    # Change directory to the destination folder
    cd "$destination"

    # Loop through the copied files and sort them into subfolders based on the year
    for file in *; do
        if [ -f "\$file" ]; then
            year=\$(echo "\$file" | grep -oE '(19[0-9][0-9]|20[0-2][0-9])' | head -n 1)
            if [ -z "\$year" ]; then
                year="Unknown"
            fi

            # Create a subfolder for the year if it doesn't exist
            if [ ! -d "\$year" ]; then
                mkdir -p "\$year"
            fi

            # Move the file to the corresponding subfolder
            mv "\$file" "\$year/"
        fi
    done

    echo "$destination files sorted into subfolders based on the year."
EOF

