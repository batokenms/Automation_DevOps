#!/bin/bash

# MySQL database credentials
db_user="root"
db_password="josh@2022PA"
db_name="josh"

# Backup directory
backup_dir="/root/back_up"

# Timestamp (for backup filename)
timestamp=$(date +'%Y%m%d%H%M%S')

# Check if the backup directory exists, create it if not
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi

# Backup the MySQL database
backup_file="$backup_dir/$db_name-$timestamp.sql"
mysqldump --user="$db_user" --password="$db_password" "$db_name" > "$backup_file"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup of database $db_name completed successfully. File saved as $backup_file"
else
    echo "Error: Database backup failed."
fi
