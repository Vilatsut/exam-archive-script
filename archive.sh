#!/bin/bash

destination="temp"
address="user@address"
password="password"

# Find all the folder names in cwd and store them seperated by newline in folder_list
folder_list=$(find . -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
num_lines=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)

# Set the seperator to \n, so that for loops over every line in folder_list
let "COUNT=0"
IFS=$'\n'
for folder in $folder_list; do
    # Use send_sort.sh to send to server to looped folder and sort it based on year.
    ./send_sort.sh "$folder" "$destination"/"$folder" "$address" "$password"

    let "COUNT = ++COUNT"
    # Calculate the percentage of completion
    percent=$((COUNT * 100 / num_lines))

    # Create the progress bar
    bar=$(printf '%*s' $percent | tr ' ' '#')

    # Print the progress bar
    printf "\rProgress: [%-100s] %d%%" "$bar" "$percent"
    echo ""
done
