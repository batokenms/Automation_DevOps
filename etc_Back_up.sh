#!/bin/bash

# Define backup variables
BACKUP_DIR="/root/back_up/back_up"
DATE=$(date +"%Y%m%d%H%M%S")
LOG_FILE="/root/back_up/backup.log"

# Function to perform the backup
perform_backup() {
    # Create a backup directory with a timestamp
    BACKUP_DIR="$BACKUP_DIR/backup_$DATE"
    mkdir -p "$BACKUP_DIR"

    # Use rsync to copy the contents of /etc to the backup directory
    rsync -av /etc/ "$BACKUP_DIR/"
}

# Function to log backup status
log_backup_status() {
    if [ $? -eq 0 ]; then
        echo "$(date +"%Y-%m-%d %H:%M:%S"): Backup successful" >> "$LOG_FILE"
    else
        echo "$(date +"%Y-%m-%d %H:%M:%S"): Backup failed" >> "$LOG_FILE"
    fi
}

# Main backup process
echo "$(date +"%Y-%m-%d %H:%M:%S"): Starting backup" >> "$LOG_FILE"
perform_backup
log_backup_status
echo "$(date +"%Y-%m-%d %H:%M:%S"): Backup completed" >> "$LOG_FILE"

echo "You can schedule this script to run at regular intervals using cron jobs to automate your backups. For example, to run it daily at 2 AM, add the following line to your crontab: 0 2 * * * /path/to/your/script.sh"
