# Customer_studio1dev WordPress Configuration

This repository contains the configuration and setup scripts for the Customer_studio1dev WordPress site hosted on AWS Lightsail.

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/[your-username]/Customer_studio1dev.git
cd Customer_studio1dev
```

2. Create AWS Lightsail instance:
- Region: ap-southeast-2 (Sydney)
- Blueprint: WordPress
- Instance plan: nano_3_2 (2 vCPU, 512MB RAM)

3. Upload configuration files:
```bash
scp -r * admin@[your-lightsail-ip]:/home/bitnami/
```

4. Run setup script:
```bash
chmod +x setup.sh
./setup.sh
```

## Features

### Infrastructure
- AWS Lightsail nano_3_2 instance
- Region: ap-southeast-2 (Sydney)
- WordPress with Hello Elementor theme
- Managed MySQL database

### Installed Plugins
- Elementor (Page Builder)
- Yoast SEO
- W3 Total Cache
- Wordfence
- UpdraftPlus
- WP-Optimize
- Smush

### Optimizations
- GZIP compression
- Browser caching
- Image optimization
- Database optimization
- Automated maintenance
- Security hardening

## Directory Structure
```
wordpress/
├── config/
│   ├── wp-optimization.conf
│   ├── security-headers.conf
│   └── generate-credentials.sh
├── maintenance/
│   ├── auto-update.sh
│   └── db-optimize.sh
├── setup.sh
├── README.md
└── CHANGELOG.md
```

## Security

- SSL/TLS encryption enabled
- Custom security headers
- Automated updates
- Secure admin credentials
- Firewall configuration

## Maintenance

Automated maintenance tasks run on the following schedule:
- Daily backups
- Weekly database optimization
- Automated plugin updates
- Security scanning
- Performance monitoring

## Change Management

See [CHANGELOG.md](CHANGELOG.md) for detailed version history and changes.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Security Notice

⚠️ **Important**: This repository contains configuration files only. No sensitive data (passwords, API keys, etc.) should be committed to this repository. 