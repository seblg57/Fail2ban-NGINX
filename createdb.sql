CREATE DATABASE fail2ban_db;
CREATE USER fail2ban_user WITH ENCRYPTED PASSWORD 'yourpassword';
GRANT ALL PRIVILEGES ON DATABASE fail2ban_db TO fail2ban_user;
CREATE TABLE ip_bans (
    id SERIAL PRIMARY KEY,
    ip_address VARCHAR(15) NOT NULL,
    country VARCHAR(50),
    city VARCHAR(50),
    ban_time TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'UTC'),
    jail VARCHAR(50),
    connection_type VARCHAR(10)
);