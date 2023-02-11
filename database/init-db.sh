#!/bin/bash
set -e

# wait for mysql to start
sleep 5

# grant privileges to laravel_user on laravel_db
mysql -u root -p$MYSQL_ROOT_PASSWORD << EOF \
CREATE DATABASE $LARAVEL_DB; \
CREATE USER '$LARAVEL_USER'@'%' IDENTIFIED BY '$LARAVEL_PASSWORD'; \
GRANT ALL PRIVILEGES ON $LARAVEL_DB.* TO '$LARAVEL_USER'@'%' IDENTIFIED BY '$LARAVEL_PASSWORD'; \
FLUSH PRIVILEGES;
EOF

echo "Granted privileges to laravel_user on laravel_db"
