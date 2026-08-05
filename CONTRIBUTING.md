# Homelab Contribution & Style Guide

> This document defines the conventions used throughout the homelab. The goal is to keep the infrastructure consistent, maintainable, and reproducible.

---

# Design Principles

* Infrastructure should be reproducible.
* Configuration should be version controlled.
* Runtime data should never be committed to Git.
* Services should follow a common layout.
* Prefer simple, explicit configurations over automation magic.

---

# Repository Layout

```
/opt/homelab
├── compose.yaml
├── .env
├── Makefile
├── README.md
├── CONTRIBUTING.md
│
├── configs/
├── data/
├── docs/
├── backups/
├── logs/
└── scripts/
```

---

# Directory Responsibilities

## configs/

Application configuration.

Examples:

```
configs/homepage/
configs/caddy/
configs/filebrowser/
```

Files stored here should be safe to version control unless they contain secrets.

---

## data/

Persistent runtime data.

Examples:

* Databases
* Uploaded files
* Application state

This directory is excluded from Git.

---

## docs/

Project documentation.

Recommended layout:

```
docs/
    architecture.md
    network.md

    services/
        homepage.md
        filebrowser.md
        uptime-kuma.md
```

---

## scripts/

Automation scripts.

Examples:

* backup.sh
* restore.sh
* update.sh

---

## backups/

Generated backups.

Never committed.

---

## logs/

Host-side logs.

Never committed.

---

# Docker Compose Conventions

Every service follows the same structure.

```
service:
    <<: *defaults

    image:
    container_name:

    ports:

    environment:

    volumes:

    healthcheck:
```

Keeping every service ordered the same makes the file much easier to read.

---

# Environment Variables

Environment-specific values belong in `.env`.

Examples:

* Timezone
* Hostnames
* Image versions
* Domain names
* Ports (if configurable)

Do not hardcode these values in `compose.yaml`.

---

# Networking

Use a single shared Docker network.

Containers should communicate using Docker service names.

Example:

```
http://homepage:3000
http://filebrowser:80
```

Avoid using:

* localhost
* Host IP addresses

for communication between containers.

---

# Volume Layout

Configuration and runtime data must remain separate.

Example:

```
configs/filebrowser/
    settings.json

data/filebrowser/
    database/
    Documents/
    Downloads/
```

---

# Git Rules

Commit:

* compose.yaml
* configs/
* docs/
* scripts/
* Makefile
* README.md

Do not commit:

* data/
* backups/
* logs/
* .env

---

# Docker Images

Container image names and versions should be defined only in `.env`.

Example:

```
HOMEPAGE_IMAGE=...
FILEBROWSER_IMAGE=...
UPTIME_KUMA_IMAGE=...
```

---

# Adding a New Service

Checklist:

* Add image variable to `.env`
* Create `configs/<service>/`
* Create `data/<service>/`
* Add service to `compose.yaml`
* Add health check
* Add Homepage entry
* Add documentation
* Commit changes

---

# Health Checks

Every service should define a Docker health check whenever possible.

---

# Reverse Proxy

Only the reverse proxy should expose services externally in the final architecture.

Application containers should communicate over the internal Docker network.

---

# Monitoring

Every service should have:

* Docker health check
* Uptime Kuma monitor
* Homepage entry

---

# Documentation

Each service should have its own documentation page describing:

* Purpose
* Ports
* Volumes
* Environment variables
* Backup strategy
* Restore procedure

---

# Philosophy

Keep the homelab simple.

Avoid adding services that do not provide clear value.

Prefer explicit configuration over implicit behavior.

Build something that can be recreated from scratch with minimal effort.
