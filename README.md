# docker-nuget-server

[![Docker Build Status](https://img.shields.io/docker/build/idoop/docker-nuget-server.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/idoop/docker-nuget-server.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![Docker Automated build](https://img.shields.io/docker/automated/idoop/docker-nuget-server.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/idoop/docker-nuget-server/latest.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![ImageLayers Layers](https://img.shields.io/imagelayers/layers/idoop/docker-nuget-server/latest.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)



Auto build docker [image](https://hub.docker.com/r/idoop/simple-nuget-server/) for [simple-nuget-server](https://github.com/Daniel15/simple-nuget-server)

## Quick start

``` shell
docker run -d --name nuget-server -p 80:80 idoop/docker-nuget-server
```

**Note:** make sure your Host feed available on either port `80`.

## Environment configuration

* `NUGET_API_KEY`: set nuget api key. Default key: `112233`

* `UPLOAD_MAX_FILESIZE`: set the maximum size of an uploaded nuget package file. Default size: `20M`

* `SERVER_NAME`: set nuget server domain name. Default name: `localhost`

* `SERVER_PORT`: set nuget server port. Default port: `80`.

  **Note:** If use `host` network mode,you can set `SERVER_PORT` value  to change nuget server port. `Port range: 80-60000`

## Volumes
* `/var/www/simple-nuget-server/db` Path with SQLite database.
* `/var/www/simple-nuget-server/packagefiles` Path with nuget packages save.
