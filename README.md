# exam-archive-script
A script for automating transferring and organizing exams into a folder tree over ssh. It's a simple utility script that can be useful when you want to transfer and organize files on ssh server.

## Usage

1. Clone or download this repository to your local machine.

2. Make the script executable if it's not already:
   ```bash
   chmod +x archive.sh
   chmod +x send_sort.sh
   ```
3. Change the source folder, destination folder, user@address and password inside archive.sh
4. run ./archive.sh

## Notes
Script transfers the folders from source to dest, so if you want to transfer to an existing folder, you need to be precise about naming.
