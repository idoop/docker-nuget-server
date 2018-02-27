# docker-nuget-server
Auto build docker [image](https://hub.docker.com/r/idoop/simple-nuget-server/) for [simple-nuget-server](https://github.com/Daniel15/simple-nuget-server)

## Quick start

``` shell
docker run -d --name nuget-server -p 80:80 idoop/simple-nuget-server
```

**Note:** make sure your Host feed available on either port `80`.

## Environment configuration

* `NUGET_API_KEY`: set nuget api key. Default key: `112233`

* `UPLOAD_MAX_FILESIZE`: set the maximum size of an uploaded nuget package file. Default size: `20M`

* `SERVER_NAME`: set nuget server domain name. Default name: `localhost`

* `SERVER_PORT`: set nuget server port. Default port: `80`.

  **Note:** If use `host` network mode,you can set `SERVER_PORT` value  to change nuget server port. `Port range: 80-60000`

