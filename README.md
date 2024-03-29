
![sebux](https://github.com/seblg57/Fail2ban-NGINX/assets/56646434/afab38a7-90fa-4a08-ae06-07a4414e33c0)


# Project Name: Fail2Ban Custom Integration

## Overview

This project enhances security by utilizing custom scripts with Fail2Ban to dynamically ban/unban IP addresses based on Nginx / SSH log analysis, and incorporates a PostgreSQL database for detailed tracking and management of banned IPs.

## Tested on :

```ini
NAME="AlmaLinux"
VERSION="9.3 (Shamrock Pampas Cat)"
ID="almalinux"
ID_LIKE="rhel centos fedora"
VERSION_ID="9.3"
PLATFORM_ID="platform:el9"
PRETTY_NAME="AlmaLinux 9.3 (Shamrock Pampas Cat)"
ANSI_COLOR="0;34"
LOGO="fedora-logo-icon"

```
## How It Works

The process begins with Fail2Ban monitoring specified log files for suspicious activities. Upon detection, our custom scripts are triggered, performing actions such as banning the IP address, logging details to a PostgreSQL database, and optionally sending alerts.

```ini
sudo yum install epel-release
sudo yum install firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --permanent --new-zone=blockzoneSSL
sudo firewall-cmd --permanent --new-zone=blockzoneHTTP
sudo firewall-cmd --reload
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

![Screenshot_670](https://github.com/seblg57/Fail2ban-NGINX/assets/56646434/802611a5-ecf8-45f3-9380-a45fa5d20d0e)

Database Logging: Record details of each ban/unban action in a PostgreSQL database for audit and analysis.
Notification System: Send alerts through email or other communication channels upon specific events.
Database Structure
The PostgreSQL database stores detailed information about each banned IP address, including country, city, ban reason, and timestamps.

![Screenshot_671](https://github.com/seblg57/Fail2ban-NGINX/assets/56646434/b8c1386e-1b2b-41ba-87d5-0af54fc0b02d)

Importance of the Database
The database allows for:

Persistent Storage: Ensures that data about banned IPs persists across system reboots or Fail2Ban service restarts.
Analysis and Reporting: Facilitates the generation of reports and analytics on security incidents.
Audit Compliance: Provides a record of security actions taken, aiding in compliance with security policies and regulations.
Getting Started
To get started with this project, clone the repository and follow the setup instructions in the INSTALL.md file.


Database Configuration:

### insert-ban.sql.sh

The script starts by defining variables for the database name, username, password, and host.
Information Retrieval via WHOIS:

- It collects information about the banned IP address using the `whois` command.
- It extracts the country and city information from the WHOIS output using `grep` and `awk` commands.
- If the country or city information is not available, it defaults to "Unknown".
- It takes the connection type as an argument (`$3`) and stores it in the `CONNECTION_TYPE` variable.
- It constructs an SQL command to insert the banned IP address along with the retrieved information and the provided jail name and connection type into the database table.
- It executes the SQL command using `psql`, providing the necessary credentials and executing the command within the specified database.

### firewallcmd-blockzoneHTTP.conf & firewallcmd-blockzoneSSL.conf

[Definition]:
- **actionstart, actionstop, actioncheck**: 
  - These parameters are set to `true`, indicating that the associated actions should be executed when Fail2Ban starts, stops, or checks its configuration, respectively.

- **actionban**: 
  - When Fail2Ban detects malicious activity and decides to ban an IP address, this action is triggered. 
  - It adds the banned IP address to the `blockzoneHTTP` firewall zone using `firewall-cmd` and reloads the firewall configuration. 
  - Additionally, it executes a script (`insert-ban.sql.sh`) to log the banned IP address and associated information into a database table for HTTP/SSH-related activities.

- **actionunban**: 
  - When Fail2Ban decides to unban an IP address, this action is triggered. 
  - It removes the unbanned IP address from the `blockzoneHTTP` firewall zone using `firewall-cmd` and reloads the firewall configuration. 
  - It also executes a script (`delete_unban_SSH/HTTP.sh`) to delete the unban record associated with the IP address from the database.


Contribution
We welcome contributions to this project! Please see CONTRIBUTING.md for how to help improve this Fail2Ban integration.

License
This project is licensed under the MIT License - see the LICENSE file for details.
