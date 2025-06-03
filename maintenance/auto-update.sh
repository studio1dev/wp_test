#!/bin/bash

# Maintenance script for studio1dev WordPress site
# This script handles automated updates and maintenance tasks

# Set variables
SITE_NAME="studio1dev"
BACKUP_DIR="/opt/bitnami/wordpress/wp-content/backup"
LOG_DIR="/opt/bitnami/wordpress/wp-content/logs"
DATE=$(date +%Y-%m-%d)

# Create directories if they don't exist
mkdir -p $BACKUP_DIR
mkdir -p $LOG_DIR

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_DIR/maintenance.log"
}

# Backup WordPress files
backup_files() {
    log_message "Starting WordPress files backup"
    tar -czf "$BACKUP_DIR/$SITE_NAME-files-$DATE.tar.gz" -C /opt/bitnami/wordpress .
    log_message "WordPress files backup completed"
}

# Backup MySQL database
backup_database() {
    log_message "Starting database backup"
    mysqldump -u root -p$(cat /home/bitnami/bitnami_application_password) bitnami_wordpress > "$BACKUP_DIR/$SITE_NAME-db-$DATE.sql"
    log_message "Database backup completed"
}

# Update WordPress core, themes, and plugins
update_wordpress() {
    log_message "Starting WordPress updates"
    wp core update
    wp plugin update --all
    wp theme update --all
    log_message "WordPress updates completed"
}

# Clean old backups (keep last 7 days)
clean_old_backups() {
    log_message "Cleaning old backups"
    find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +7 -delete
    find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -delete
    log_message "Old backups cleaned"
}

# Clean logs (keep last 7 days)
clean_old_logs() {
    log_message "Cleaning old logs"
    find $LOG_DIR -type f -name "*.log" -mtime +7 -delete
    log_message "Old logs cleaned"
}

# Main execution
log_message "Starting maintenance tasks"

backup_files
backup_database
update_wordpress
clean_old_backups
clean_old_logs

log_message "Maintenance tasks completed" 