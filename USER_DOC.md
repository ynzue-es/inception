# This project has been created as part of the 42 curriculum by ynzue-es
# User Documentation — Inception

## What Does This Stack Provide?

The Inception stack deploys a self-hosted WordPress website running behind an NGINX reverse proxy, with a MariaDB database for storage. All traffic is encrypted via HTTPS (TLSv1.2/TLSv1.3). The three services run in isolated Docker containers inside a virtual machine.

In short: you get a fully functional WordPress site accessible at `https://<login>.42.fr`.

## Starting and Stopping the Project

From the project root inside the VM:

```bash
# Start everything (build if needed)
make

# Stop the stack without deleting data
make down

# Stop and wipe everything (volumes, images)
make clean

# Full rebuild
make re
```

After `make`, the stack runs in the background. Containers are configured to restart automatically if they crash or if the VM reboots (restart policy: `on-failure` or `always`).

## Accessing the Website

| What | URL |
|---|---|
| Website homepage | `https://<login>.42.fr` |
| WordPress admin panel | `https://<login>.42.fr/wp-admin` |

The TLS certificate is self-signed. Your browser will display a security warning — proceed manually to access the site. This is expected behavior and not a security issue in this context.

Make sure `<login>.42.fr` resolves to `127.0.0.1` in the VM's `/etc/hosts` file.

## Credentials

### Where Are They Stored?

Sensitive credentials (database passwords, WordPress admin password) are stored as **Docker secrets** — files on disk that Docker mounts read-only inside the containers at `/run/secrets/`.

The secret files are typically located in:

```
srcs/requirements/tools/secrets/
```

Non-sensitive configuration (domain name, database name, usernames) lives in the environment file:

```
srcs/.env
```

### Default Accounts

| Account | Username | Where to find the password |
|---|---|---|
| WordPress administrator | Defined in `.env` (`WP_ADMIN_USER`) | Secret file `wp_admin_password.txt` |
| WordPress regular user | Defined in `.env` (`WP_USER`) | Secret file `wp_user_password.txt` |
| MariaDB root | `root` | Secret file `db_root_password.txt` |
| MariaDB application user | Defined in `.env` (`DB_USER`) | Secret file `db_password.txt` |

### Changing Credentials

1. Edit the corresponding secret file with the new password.
2. Run `make re` to rebuild and restart the stack with the new values.

Do not change passwords directly inside a running container — they will be lost on the next restart.

## Checking That Services Are Running

### Quick Health Check

```bash
# All three containers should show "Up"
docker compose -f srcs/docker-compose.yml ps
```

Expected output shows three services running: `nginx`, `wordpress`, `mariadb`.

### Per-Service Checks

**NGINX**

```bash
# Should return the WordPress homepage HTML
curl -k https://localhost:443
```

**WordPress (php-fpm)**

```bash
# Check the process is running inside the container
docker exec wordpress ps aux | grep php-fpm
```

**MariaDB**

```bash
# Connect to the database and verify it responds
docker exec mariadb mariadb -u root -p<root_password> -e "SHOW DATABASES;"
```

### Logs

```bash
# All services
docker compose -f srcs/docker-compose.yml logs

# Single service
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb

# Follow logs in real time
docker compose -f srcs/docker-compose.yml logs -f
```

### Data Persistence

WordPress files and database data are stored on Docker volumes mapped to `/home/<login>/data/` on the host. Stopping and restarting the stack (`make down` then `make`) preserves all content. Only `make clean` destroys the data.