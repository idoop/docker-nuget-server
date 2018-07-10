# docker-nuget-server

[![Docker Build Status](https://img.shields.io/docker/build/idoop/docker-nuget-server.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/idoop/docker-nuget-server.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![Docker Automated build](https://img.shields.io/docker/automated/idoop/docker-nuget-server.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/idoop/docker-nuget-server/latest.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)
[![ImageLayers Layers](https://img.shields.io/imagelayers/layers/idoop/docker-nuget-server/latest.svg)](https://hub.docker.com/r/idoop/docker-nuget-server/)



Auto build docker [image](https://hub.docker.com/r/idoop/docker-nuget-server/) for [simple-nuget-server](https://github.com/Daniel15/simple-nuget-server)

## Quick start

### docker command
``` shell
docker run -d --name nuget-server -p 80:80 -e NUGET_API_KEY="112233" idoop/docker-nuget-server
```

### docker-compose

``` yaml
version: '2'
services:
  nuget-server:
    container_name: nuget-server
    image: idoop/docker-nuget-server:latest
    network_mode: "host"
    restart: always
    environment:
      NUGET_API_KEY: "112233"
      UPLOAD_MAX_FILESIZE: "40M"
      
      ## When use host network mode, 
      ## set SERVER_PORT value if you want change server expose port.
      # SERVER_PORT: "8080"
      
      ## Set nuget server domain[:port], also you can use machine(not container) ip[:port]. 
      ## eg: "192.168.11.22:8080" or "nuet.eg.com:8080"
      SERVER_NAME: "nuget.example.com"
      WORKER_PROCESSES: "2"
    volumes:
      - nuget-db:/var/www/simple-nuget-server/db
      - nuget-packagefiles:/var/www/simple-nuget-server/packagefiles
      - nuget-nginx:/etc/nginx
    ulimits:
      nproc: 8096
      nofile:
        soft: 65535
        hard: 65535
volumes:
  nuget-db:
  nuget-packagefiles:
  nuget-nginx:
```

**Note:** make sure your Host feed available on either port `80`.

## Environment configuration

* `NUGET_API_KEY`:  nuget api key. Default key: `112233`

* `UPLOAD_MAX_FILESIZE`:  the maximum size of an uploaded nuget package file. Default size: `20M`

* `WORKER_PROCESSES`:  nginx worker processes.Default: `1`

* `WORKER_CONNECTIONS`:  nginx worker connections. Default: `65535`

* `SERVER_NAME`:  name of server domain,set value with domain name or ip.Default: `localhost` (Require). 

* `SERVER_PORT`:  server port. Default port: `80`.

  **Note:** If use `host` network mode,you can set `SERVER_PORT` value  to change nuget server port.

## Volumes
* `/var/www/simple-nuget-server/db` Path with SQLite database.
* `/var/www/simple-nuget-server/packagefiles` Path with nuget packages save.
* `/etc/nginx` Path with nginx config. If you want use https, please mount this path, generate cert/key and modify `<mount path>/conf.d/nuget.conf` to support https,then restart container.


## Test

Download [nuget commandline tool](https://www.nuget.org/downloads).

#### Push nuget package:
``` shell
nuget push xxx.nupkg -source SERVER_NAME -apikey NUGET_API_KEY
```

#### Download nuget package:
``` shell
nuget install xxx -source SERVER_NAME -packagesavemode nupkg
```

## Bug:

If not set `SERVER_NAME` value ,client will resolve the default server name `localhost` at client machine.