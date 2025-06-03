#!/bin/bash

# Credential Generation Script for Customer_studio1dev WordPress
# This script generates secure credentials and stores them safely

# Set variables
SITE_NAME="Customer_studio1dev"
CREDENTIALS_FILE="/opt/bitnami/wordpress/wp-content/credentials.txt"
DATE=$(date +%Y-%m-%d)

# Generate secure password
ADMIN_PASSWORD=$(openssl rand -base64 16)

# Create WordPress admin user
wp user create studio1dev_admin admin@customer_studio1dev.com --role=administrator --user_pass="$ADMIN_PASSWORD" --display_name="Site Administrator" --porcelain

# Store credentials securely
echo "WordPress Admin Credentials for $SITE_NAME" > $CREDENTIALS_FILE
echo "Generated on: $DATE" >> $CREDENTIALS_FILE
echo "----------------------------------------" >> $CREDENTIALS_FILE
echo "Username: studio1dev_admin" >> $CREDENTIALS_FILE
echo "Password: $ADMIN_PASSWORD" >> $CREDENTIALS_FILE
echo "Email: admin@customer_studio1dev.com" >> $CREDENTIALS_FILE
echo "Login URL: https://[your-domain]/wp-admin" >> $CREDENTIALS_FILE
echo "----------------------------------------" >> $CREDENTIALS_FILE
echo "IMPORTANT: Store these credentials securely and delete this file after saving" >> $CREDENTIALS_FILE

# Set secure permissions
chmod 600 $CREDENTIALS_FILE

# Output credentials to console
echo "WordPress Admin Credentials"
echo "----------------------------------------"
echo "Username: studio1dev_admin"
echo "Password: $ADMIN_PASSWORD"
echo "Email: admin@customer_studio1dev.com"
echo "----------------------------------------"
echo "Credentials have been saved to: $CREDENTIALS_FILE"
echo "IMPORTANT: Save these credentials securely and delete the credentials file" 