#!/bin/bash
set -e

# Use environment variables
ORACLE_PWD=${ORACLE_PASSWORD}
APP_USER=${APP_USER}
APP_USER_PWD=${APP_USER_PASSWORD}

# Check if initialization has already been performed
if [ -f "/opt/oracle/oradata/.oracle_initialized" ]; then
    echo "Oracle Database has already been initialized. Skipping initialization."
    exit 0
fi

echo "Initializing Oracle Database..."

# Wait for the Oracle Database to be ready
while true; do
    sqlplus -s / as sysdba <<EOF
    exit
EOF
    if [ $? -eq 0 ]; then
        break
    fi
    echo "Waiting for Oracle Database to be ready..."
    sleep 5
done

# Create application user
echo "Creating application user..."
sqlplus -s / as sysdba <<EOF
CREATE USER $APP_USER IDENTIFIED BY "$APP_USER_PWD";
GRANT CONNECT, RESOURCE TO $APP_USER;
GRANT UNLIMITED TABLESPACE TO $APP_USER;
ALTER USER $APP_USER DEFAULT TABLESPACE USERS;
ALTER USER $APP_USER TEMPORARY TABLESPACE TEMP;
EXIT;
EOF

# Create a file to indicate that initialization has been performed
touch /opt/oracle/oradata/.oracle_initialized
echo "Oracle Database initialization completed."