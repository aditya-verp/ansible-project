# Ansible Project To Setup the flask App on Web Instance and Setup the PostgreSQL on Db Instance using Docker.

This repository contains an Ansible project that will be Dockerized for easier deployment and management.

## Setup Instructions

### Prerequisites

1. **Update Inventory:**
   - Ensure the `inventory.ini` file is updated with the correct IP addresses for both the web and database servers.

2. **Configure Environment Variables:**
   - Create a `.env` file in the root of the project. Take the referance from env.example file
   - Add the private IP address of your database server to the `.env` file using the format:
     ```
     DB_HOST=<private_ip_of_db_server>
     ```
3. **Clone the Repository: (To bastion Host)**
   ```sh
   git clone https://github.com/aditya-verp/ansible-project.git
   cd ansible-project/project/ansible
4. **Install The Ansible Playbook**
   ``` ansible-playbook -i inventory.ini your_playbook.yml

### Dockerization Steps

1. **Build Docker Images:**
   - Navigate to the root directory of the project where the `Dockerfile` is located.
   - Build the Docker images for the web and database servers using:
     ```
     docker build -t web-server ./web
     docker build -t db-server ./db
     ```

2. **Run Docker Containers:**
   - Start the Docker containers using:
     ```
     docker run -d --name db-container db-server
     docker run -d --name web-container --env-file .env -p 80:80 --link db-container:db web-server
     ```

   Replace `your_db_server_private_ip` with the actual private IP of your database server.

3. **Access the Application:**
   - Once containers are running, access the application by navigating to `Externallt --> ALB DNS` OR ` Locally -> http//127.0.0.1:80` in your web browser.

## Project Structure

- **ansible/**: Contains Ansible playbooks and roles for provisioning servers.
- **db/**: Docker configuration files for the database server.
- **web/**: Docker configuration files for the web server.
- **inventory.ini**: Ansible inventory file to specify hosts.


