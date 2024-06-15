#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' /home/ubuntu/.env | xargs)

# Update package list and install PostgreSQL
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# Start the PostgreSQL service and enable it to start on boot
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Set up PostgreSQL user and database
sudo -u postgres psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';"
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;"

# Allow remote connections to PostgreSQL
echo "listen_addresses='*'" | sudo tee -a /etc/postgresql/12/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/12/main/pg_hba.conf

# Restart PostgreSQL to apply changes
sudo systemctl restart postgresql
