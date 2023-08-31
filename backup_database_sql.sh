#!/bin/bash

# MySQL database credentials
DB_USER="user"
DB_PASS="pass"
DB_NAME="dbname_need_backup"

# Backup directory
BACKUP_DIR="/backup/daily"

# Number of backups to keep
BACKUP_COUNT=12

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Generate backup filename with timestamp
BACKUP_FILENAME="${DB_NAME}_$(date +%Y%m%d%H%M%S).sql"

# Dump MySQL database to backup file
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/$BACKUP_FILENAME

# List all backup files, sort by timestamp, and keep the latest N backups
ls -t $BACKUP_DIR/*.sql | tail -n +$((BACKUP_COUNT+1)) | xargs -d '\n' rm --

# Print success message
echo "Backup completed successfully!"
