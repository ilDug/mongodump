# mongodump

Docker Image able to perform backup of a existing **mongodb** database.

The container executes periodically backup of a database, using **cronjob**. The database can lives into another docker container, or one running into a dedicate machine. It works also with **replica sets**.

## creating container

You can create and run a container using compose.

This is an example to backup hourly a mongodb **replica set** running on a dedicated cluster:

```yaml
version: "3.9"

secrets:
  MONGO_ROOT_PW:
    file: ./path/to/secrets/MONGO_ROOT_PW

volumes:
  backup-vol:
    name: backup-vol

services:
  backup:
    image: ghcr.io/ildug/mongodump
    restart: unless-stopped
    container_name: db-backup
    environment:
      MONGO_ROOT_PW_FILE: /run/secrets/MONGO_ROOT_PW
      USER: root
      REPLSET: rs0
      HOSTS: host01.com:27017,host02.com:27017,host03.com:27017
      DB: shop
      CRON: "0 * * * *" # every hour
    volumes:
      - backup-vol:/backup
    secrets:
      - MONGO_ROOT_PW
```

If the instance of database is itself a docker container, the _docker-compose_ file can be like this:

```yaml
version: "3.9"

networks:
  my-net:
    name: my-net

secrets:
  MONGO_ROOT_PW:
    file: ./path/to/secrets/MONGO_ROOT_PW

volumes:
  backup-vol:
    name: backup-vol

services:
  db:
    image: mongo:7
    restart: unless-stopped
    container_name: database
    networks:
      - my-net

  backup:
    image: ghcr.io/ildug/mongodump
    restart: unless-stopped
    container_name: db-backup
    depends_on:
      - db
    environment:
      MONGO_ROOT_PW_FILE: /run/secrets/MONGO_ROOT_PW
      USER: root
      HOST: db
      PORT: 27017
      DB: shop
      CRON: "0 4 * * *" # daily at 4:00 AM
      ARCHIVE: true # create a single zipped file
    networks:
      - my-net
    volumes:
      - backup-vol:/backup
    secrets:
      - MONGO_ROOT_PW
```

## Configuration

Configuration can be setted by environment variables.

- **MONGO_ROOT_PW_FILE**
  file (as a docker secret) where store the password of database.

- **USER**
  database username

- **DB**
  database name

- **CRON**
  frequency of backup operation. The syntax is the same of **cron** linux command

- **ARCHIVE**
  it indicates whether create a single zipped file for the archive (if true). Else (if false) create a folder with the same name of database, ant store the current data as BSON.

### Connection

Two types of connection:

- **HOST and PORT**
  it connects to a single database using specified hostname and port.

- **HOSTS and REPLSET**
  It connects to a replica set cluster. HOSTS is a comma separated list of hosts and ports. REPLSET is the name of replica set.
