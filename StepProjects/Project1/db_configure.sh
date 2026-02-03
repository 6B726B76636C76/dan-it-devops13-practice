#!/bin/bash
set -e
AUTH_PLUGIN="mysql_native_password"

apt-get update -y
apt-get install ufw net-tools -y
apt-get clean

apt-get install mysql-server -y
systemctl start mysql
mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME}
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS '${DB_USER}'@'%'
    IDENTIFIED WITH ${AUTH_PLUGIN} BY '${DB_PASS}';

GRANT ALL PRIVILEGES ON ${DB_NAME}.*
    TO '${DB_USER}'@'%';

FLUSH PRIVILEGES;
EOF

systemctl enable mysql
sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

ufw default deny incoming
ufw default allow outgoing
ufw --force disable
ufw allow OpenSSH
ufw allow http
ufw allow from $NETWORK/24 to any port 3306:3307 proto tcp


ufw --force enable

