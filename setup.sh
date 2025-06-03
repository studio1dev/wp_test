#!/bin/bash

# WordPress Setup Script for Customer_studio1dev
# This script will be run after the Lightsail instance is created

# Set variables
SITE_NAME="Customer_studio1dev"

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Remove default themes except Twenty Twenty-Four (latest default theme)
wp theme delete twentytwentytwo twentytwentythree

# Install and configure Hello Elementor theme
wp theme install hello-elementor --activate

# Remove default plugins
wp plugin delete hello
wp plugin delete akismet

# Install required plugins
wp plugin install elementor --activate
wp plugin install wordpress-seo --activate
wp plugin install w3-total-cache --activate
wp plugin install wordfence --activate
wp plugin install updraftplus --activate
wp plugin install wp-optimize --activate
wp plugin install wp-smushit --activate

# Generate secure admin credentials
chmod +x config/generate-credentials.sh
./config/generate-credentials.sh

# Configure WordPress settings
wp option update blogname "$SITE_NAME"
wp option update blogdescription "Professional WordPress Site"
wp option update blog_public 1
wp option update timezone_string "Australia/Sydney"
wp option update date_format "Y-m-d"
wp option update time_format "H:i"

# Configure permalink structure
wp rewrite structure '/%postname%/'

# Optimize WordPress
wp config set WP_MEMORY_LIMIT 256M
wp config set WP_MAX_MEMORY_LIMIT 512M
wp config set WP_POST_REVISIONS 5
wp config set AUTOSAVE_INTERVAL 300
wp config set WP_CACHE true

# Configure W3 Total Cache
wp w3-total-cache option set pgcache.enabled true --type=boolean
wp w3-total-cache option set minify.enabled true --type=boolean
wp w3-total-cache option set dbcache.enabled true --type=boolean
wp w3-total-cache option set objectcache.enabled true --type=boolean
wp w3-total-cache option set browsercache.enabled true --type=boolean
wp w3-total-cache option set cdn.enabled false --type=boolean
wp w3-total-cache option set cloudflare.enabled false --type=boolean
wp w3-total-cache option set pgcache.cache.nginx_handle_xml true --type=boolean
wp w3-total-cache option set browsercache.cssjs.compression true --type=boolean
wp w3-total-cache option set browsercache.html.compression true --type=boolean
wp w3-total-cache option set minify.html.enable true --type=boolean
wp w3-total-cache option set minify.js.enable true --type=boolean
wp w3-total-cache option set minify.css.enable true --type=boolean

# Configure Smush settings
wp option set wp-smush-settings '{
    "auto":true,
    "strip_exif":true,
    "resize":true,
    "original":true,
    "backup":false,
    "png_to_jpg":true,
    "nextgen":true,
    "auto_resize":true,
    "resize_sizes":{
        "width":2560,
        "height":2560
    },
    "lossy":true,
    "original_size":true
}'

# Enable maintenance mode during setup
wp maintenance-mode activate

# Copy optimization configuration
sudo cp config/wp-optimization.conf /opt/bitnami/apache2/conf/wp-optimization.conf
sudo cp config/security-headers.conf /opt/bitnami/apache2/conf/security-headers.conf

# Set up maintenance scripts
sudo cp maintenance/auto-update.sh /opt/bitnami/scripts/auto-update.sh
sudo chmod +x /opt/bitnami/scripts/auto-update.sh
sudo cp maintenance/db-optimize.sh /opt/bitnami/scripts/db-optimize.sh
sudo chmod +x /opt/bitnami/scripts/db-optimize.sh

# Add cron jobs for maintenance
(crontab -l 2>/dev/null; echo "0 2 * * * /opt/bitnami/scripts/auto-update.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * 0 /opt/bitnami/scripts/db-optimize.sh") | crontab -

# Initial database optimization
/opt/bitnami/scripts/db-optimize.sh

# Configure WP-Optimize
wp option set wpo_cache_config '{
    "enable_page_caching":true,
    "page_cache_length_value":24,
    "page_cache_length_unit":"hours",
    "cache_exception_urls":[""],
    "cache_exception_cookies":[""],
    "cache_exception_browser_agents":[""],
    "enable_database_optimization":true,
    "optimization_schedule":"weekly",
    "enable_image_optimization":true,
    "image_optimization_quality":82,
    "enable_minification":true,
    "enable_gzip_compression":true
}'

# Restart Apache to apply changes
sudo /opt/bitnami/ctlscript.sh restart apache

# Flush W3 Total Cache
wp w3-total-cache flush all

# Run initial Smush optimization
wp smush run-all

# Remove default admin user if it exists
wp user delete admin --yes --reassign=studio1dev_admin

# Disable maintenance mode
wp maintenance-mode deactivate

echo "WordPress setup completed for $SITE_NAME"
echo "Please check the credentials file at /opt/bitnami/wordpress/wp-content/credentials.txt"
echo "IMPORTANT: Save the credentials and delete the file after saving" 