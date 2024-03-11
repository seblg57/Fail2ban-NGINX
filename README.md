# Project Name: Fail2Ban Custom Integration

## Overview

This project enhances security by utilizing custom scripts with Fail2Ban to dynamically ban/unban IP addresses based on log analysis, and incorporates a PostgreSQL database for detailed tracking and management of banned IPs.

## How It Works

The process begins with Fail2Ban monitoring specified log files for suspicious activities. Upon detection, our custom scripts are triggered, performing actions such as banning the IP address, logging details to a PostgreSQL database, and optionally sending alerts.

```ini
sudo yum install epel-release
sudo yum install firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo yum install fail2ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

```
## Configuration

Fail2Ban is configured with several jails specific to the services being monitored (e.g., SSH, NGINX). Each jail is associated with custom action scripts that extend functionality beyond basic IP blocking.

### Fail2Ban Jail Configuration Example

```ini
[sshd]
enabled = true
port = 60333
filter = sshd
logpath = /var/log/secure
action = firewallcmd-blockzoneSSH
```

Custom Scripts
Our custom scripts serve multiple purposes:

Ban/Unban IP Addresses: Interact directly with the system's firewall to dynamically manage the ban list.
Database Logging: Record details of each ban/unban action in a PostgreSQL database for audit and analysis.
Notification System: Send alerts through email or other communication channels upon specific events.
Database Structure
The PostgreSQL database stores detailed information about each banned IP address, including country, city, ban reason, and timestamps.


Importance of the Database
The database allows for:

Persistent Storage: Ensures that data about banned IPs persists across system reboots or Fail2Ban service restarts.
Analysis and Reporting: Facilitates the generation of reports and analytics on security incidents.
Audit Compliance: Provides a record of security actions taken, aiding in compliance with security policies and regulations.
Getting Started
To get started with this project, clone the repository and follow the setup instructions in the INSTALL.md file.

Contribution
We welcome contributions to this project! Please see CONTRIBUTING.md for how to help improve this Fail2Ban integration.

License
This project is licensed under the MIT License - see the LICENSE file for details.


![Screenshot_670](https://github.com/seblg57/Fail2ban-NGINX/assets/56646434/802611a5-ecf8-45f3-9380-a45fa5d20d0e)
