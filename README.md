# Inception

## Description

Inception is a system administration and DevOps-oriented project whose goal is to design, configure, and deploy a complete web infrastructure using **Docker** and **Docker Compose**.

The project consists in setting up a secure WordPress website composed of multiple services, each running in its own Docker container:
- **NGINX** as a reverse proxy with HTTPS (TLSv1.2+)
- **WordPress** running with PHP-FPM
- **MariaDB** as the database backend

All services are isolated, connected through a Docker network, and configured to persist data using Docker volumes.  
The project emphasizes containerization principles, security best practices, and service orchestration.

---

## Project Architecture Overview

```
Client (Browser)
        |
      HTTPS
        |
      NGINX
        |
    FastCGI
        |
    PHP-FPM
        |
    WordPress
        |
     MariaDB
```

Each component runs in its own container and communicates through an internal Docker network.

---

## Instructions

### Prerequisites
- Docker
- Docker Compose
- GNU Make (optional but recommended)

### Installation & Launch

1. Clone the repository:
```bash
git clone https://github.com/your-repo/inception.git
cd inception
```

2. Create the required secrets files:
```bash
mkdir -p srcs/secrets
echo "your_db_password" > srcs/secrets/db_password.txt
echo "your_db_root_password" > srcs/secrets/db_root_password.txt
echo "your_wp_admin_password" > srcs/secrets/wp_admin_password.txt
```

3. Configure environment variables:
Edit the `.env` file located in `srcs/` to match your domain and preferences.

4. Build and run the infrastructure:
```bash
make start
```
or
```bash
cd srcs
docker compose up --build
```

5. Add the domain to your hosts file:
```text
127.0.0.1 ynzue-es.42.fr
```

6. Access WordPress:
```text
https://ynzue-es.42.fr
```

---

## Docker and Design Choices

### Why Docker?

Docker allows each service to run in an isolated, reproducible environment.  
This ensures consistency across systems, simplifies deployment, and avoids dependency conflicts.

Each service follows the rule:

> **One container = one responsibility**

---

### Virtual Machines vs Docker

| Virtual Machines | Docker |
|------------------|--------|
| Heavy (full OS) | Lightweight |
| Slower startup | Fast startup |
| High resource usage | Low overhead |
| OS-level isolation | Process-level isolation |

Docker was chosen for its efficiency, simplicity, and suitability for microservice architectures.

---

### Secrets vs Environment Variables

| Environment Variables | Docker Secrets |
|-----------------------|----------------|
| Visible via inspect | Mounted as files |
| Less secure | More secure |
| Suitable for config | Suitable for credentials |

Sensitive data (database passwords, admin credentials) are handled using Docker secrets, while non-sensitive configuration is stored in `.env`.

---

### Docker Network vs Host Network

| Docker Network | Host Network |
|---------------|--------------|
| Isolated | Shared with host |
| Secure by default | Less secure |
| Service name resolution | Manual IP handling |

A dedicated Docker network is used to allow containers to communicate securely without exposing internal services to the host.

---

### Docker Volumes vs Bind Mounts

| Docker Volumes | Bind Mounts |
|---------------|-------------|
| Managed by Docker | Linked to host FS |
| Portable | Host-dependent |
| Safer | Permission issues possible |

Docker volumes are used to persist MariaDB and WordPress data safely and portably.

---

## Security Considerations

- HTTPS enforced with **TLSv1.2 and TLSv1.3 only**
- No services exposed unnecessarily
- Database not accessible from the host
- Secrets never stored in plain environment variables
- Non-root database user for WordPress

---

## Resources

### Technical Documentation
- Docker Documentation: https://docs.docker.com
- Docker Compose: https://docs.docker.com/compose/
- NGINX Documentation: https://nginx.org/en/docs/
- PHP-FPM: https://www.php.net/manual/en/install.fpm.php
- WordPress CLI: https://developer.wordpress.org/cli/commands/
- MariaDB: https://mariadb.org/documentation/

### AI Usage Disclosure

AI tools (ChatGPT) were used during this project as a learning and assistance tool, mainly for:
- Understanding Docker, PHP-FPM, FastCGI, and NGINX interactions
- Clarifying DevOps concepts and best practices
- Reviewing configuration logic and architecture decisions
- Improving documentation clarity

All code, configuration, and design decisions were written, implemented, and validated manually by the student.

---

## Conclusion

Inception provides a hands-on introduction to containerized infrastructures and modern DevOps workflows.  
The project demonstrates how independent services can be securely orchestrated using Docker while following best practices in system design and deployment.