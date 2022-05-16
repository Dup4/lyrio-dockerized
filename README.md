<img align="right" width="128px" src="./assets/Moby-logo.webp">

# lyrio-dockerized

[![Build docker Image](https://github.com/Dup4/lyrio-dockerized/actions/workflows/build_docker_image.yml/badge.svg)](https://github.com/Dup4/lyrio-dockerized/actions/workflows/build_docker_image.yml)

## Usage

```bash
docker run \
    -d \
    --restart=always \
    --name=lyrio \
    -p 2002:2002 \
    -e TZ=Asia/Shanghai \
    -v "${TOP_DIR}"/config:/app/config \
    -v "${HOME}"/docker-data/nginx/www/lyrio:/app/export/ui \
    dup4/lyrio:latest
```

* You need to create a `config.yaml`, which represents the server side configuration file, and mount it to `/app/config/config.yaml` in the container.
* You can mount a path to `/app/export/ui` in the container. When the container starts, the front-end resources will be copied to this path. You can use Nginx to proxy the front-end resources externally.
* You can change the configuration in the front-end resources through environment variables, it will be replaced before copying the front-end resources to `/app/export/ui`, the specific environment variable list can refer to [this script file](./docker/docker_entry.sh).
