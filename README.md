# Extended PostgreSQL Docker Image

Docker image for `postgres` extended with management bash scripts.

## Build images

To build the images and push them to the registry:

    make build
    make push

## Docker-compose example

Example of a `docker-compose.yml` file that uses this image:

```yaml
    version: '3'

    volumes:
      postgres_data: {}
      postgres_backups: {}

    services:

      service:
        image: service:latest
        command: ./start

      postgres:
        image: marcosgabarda/postgres:latest
        volumes:
          - postgres_data:/var/lib/postgresql/data
          - postgres_backups:/backups
        env_file:
          - ./.env
```

## Maintenance commands

This images adds commands to the original PostgreSQL image for maintenance proposes.

### Create a database backup

Creates a backup of the database. Usage:

    $ docker compose -f <environment>.yml (exec |run --rm) postgres backup

### View backups

Views a list of all created backups of the database. Usage:

    $ docker compose -f <environment>.yml (exec |run --rm) postgres backups

### Creates a read only user

Creates a read only user. Usage:

    $ docker compose -f <environment>.yml (exec |run --rm) postgres createreaduser

### Restore database from a backup

Restores the indicated database backup. Usage:

    $ docker compose -f <environment>.yml (exec |run --rm) postgres restore <1>

Parameters:

 * `<1>` filename of an existing backup.
