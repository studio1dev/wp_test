#!/bin/bash

# Database Optimization Script for Customer_studio1dev
# This script optimizes database tables and removes unnecessary data

# Set variables
SITE_NAME="Customer_studio1dev"
LOG_DIR="/opt/bitnami/wordpress/wp-content/logs"
DATE=$(date +%Y-%m-%d)

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_DIR/db-maintenance.log"
}

# Start maintenance
log_message "Starting database optimization"

# Remove post revisions (keep last 5)
wp post delete $(wp post list --post_type='revision' --format=ids --posts_per_page=-1) --force
log_message "Removed old post revisions"

# Remove auto-draft posts
wp post delete $(wp post list --post_status=auto-draft --format=ids) --force
log_message "Removed auto-draft posts"

# Remove all trashed posts
wp post delete $(wp post list --post_status=trash --format=ids) --force
log_message "Removed trashed posts"

# Remove trashed comments
wp comment delete $(wp comment list --status=trash --format=ids) --force
log_message "Removed trashed comments"

# Remove spam comments
wp comment delete $(wp comment list --status=spam --format=ids) --force
log_message "Removed spam comments"

# Remove unused themes (keep only Hello Elementor)
wp theme list --status=inactive --field=name | while read theme; do
    if [ "$theme" != "hello-elementor" ]; then
        wp theme delete "$theme"
        log_message "Removed unused theme: $theme"
    fi
done

# Remove unused plugins
REQUIRED_PLUGINS=("elementor" "wordpress-seo" "w3-total-cache" "wordfence" "updraftplus" "wp-optimize")

wp plugin list --status=inactive --field=name | while read plugin; do
    if [[ ! " ${REQUIRED_PLUGINS[@]} " =~ " ${plugin} " ]]; then
        wp plugin delete "$plugin"
        log_message "Removed unused plugin: $plugin"
    fi
done

# Optimize database tables
wp db optimize
log_message "Optimized database tables"

# Clean up transients
wp transient delete --all
log_message "Cleaned up transients"

# Remove unused media files
wp media cleanup
log_message "Cleaned up unused media files"

# Run WP-Optimize commands
wp wpo preload --all
wp wpo cache purge --all
wp wpo db optimize
log_message "Ran WP-Optimize optimizations"

log_message "Database optimization completed"

# Output summary
echo "Database optimization completed for $SITE_NAME"
echo "Check $LOG_DIR/db-maintenance.log for details" 