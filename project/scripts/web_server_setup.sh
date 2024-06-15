#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' /home/ubuntu/.env | xargs)

# Update package database and install necessary packages
sudo apt-get update
sudo apt-get install -y git docker.io docker-compose

# Clone the example Node.js application from GitHub
git clone https://github.com/bezkoder/nodejs-express-postgresql.git /home/ubuntu/app

# Change to the application directory
cd /home/ubuntu/app

# Create .env file with database connection details
cat <<EOT >> .env
DB_HOST=$DB_HOST
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
DB_NAME=$DB_NAME
DB_PORT=$DB_PORT
EOT

# Build and start the application using Docker
docker-compose up -d
