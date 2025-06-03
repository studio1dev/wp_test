# Customer_studio1dev WordPress Configuration

This repository contains the configuration and setup instructions for the Customer_studio1dev WordPress site hosted on AWS Lightsail.

## Infrastructure Overview

- Platform: AWS Lightsail nano_3_2
- Region: ap-southeast-2 (Sydney)
- CMS: WordPress (Latest Version)
- Theme: Hello Elementor
- Database: MySQL (Managed by Lightsail)

## Instance Specifications
- CPU: 2 vCPU
- RAM: 512 MB
- SSD: 20 GB
- Transfer: 2 TB per month

## Installed Plugins
1. Elementor (Page Builder)
2. Yoast SEO (SEO Optimization)
3. WP Super Cache (Performance)
4. Wordfence (Security)
5. UpdraftPlus (Backups)
6. WP-Optimize (Database Optimization)

## Optimization Features
1. GZIP compression enabled
2. Browser caching configured
3. PHP memory optimization
4. Image optimization
5. Database optimization
6. Responsive design support

## Security Features
1. SSL/TLS encryption enabled
2. Custom security headers
3. Automated updates
4. Restricted admin access
5. Firewall configuration

## Configuration Structure
```
studio1dev/
├── wordpress/
│   ├── config/
│   │   ├── wp-config.php
│   │   ├── wp-optimization.conf
│   │   └── security-headers.conf
│   ├── backup/
│   └── maintenance/
│       └── auto-update.sh
```

## Installation Instructions

1. Create AWS Lightsail Instance:
   ```bash
   # Region: ap-southeast-2
   # Blueprint: WordPress
   # Instance plan: nano_3_2
   ```

2. Run Setup Script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. Verify Installation:
   - Check WordPress admin panel
   - Verify plugin installations
   - Test responsive design
   - Confirm security measures

## Maintenance

- Daily automated backups
- Weekly database optimization
- Automated plugin updates
- Security scanning
- Performance monitoring

## Change Management

See [CHANGELOG.md](CHANGELOG.md) for detailed version history and changes. 