# Extended PostgreSQL Docker Image

Docker image for `postgres` extended with management bash scripts.

## Build images

To build the images and push them to the registry:

    make build
    make push

## Docker-compose example

Example of a `docker-compose.yml` file that uses this image:

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
