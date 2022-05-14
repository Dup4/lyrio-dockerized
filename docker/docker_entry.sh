#! /bin/sh

set -e -x

UI_PATH="/app/ui/dist"
EXPORT_PATH="/app/export"
EXPORT_UI_PATH="${EXPORT_PATH}/ui"

if [ -n "${UI_PUBLIC_CDN_PATH}" ]; then
    sed -i "s|__public_path__|${UI_PUBLIC_PATH}|g" ./ui/dist/index.html
fi

if [ -n "${UI_DEFAULT_TITLE}" ]; then
    sed -i "s|__default_title__|${UI_DEFAULT_TITLE}|g" ./ui/dist/index.html
fi

if [ -n "${UI_API_ENDPOINT}" ]; then
    sed -i "s|__api_endpoint__|${UI_API_ENDPOINT}|g" ./ui/dist/index.html
fi

if [ -n "${UI_FAVICON}" ]; then
    sed -i "s|__favicon__|${UI_FAVICON}|g" ./ui/dist/index.html
fi

if [ -n "${UI_APPLOGO}" ]; then
    sed -i "s|__applogo__|${UI_APPLOGO}|g" ./ui/dist/index.html
fi

if [ -n "${UI_GRAVATAR}" ]; then
    sed -i "s|__gravatar__|${UI_GRAVATAR}|g" ./ui/dist/index.html
fi

if [ -n "${UI_GHAVATAR}" ]; then
    sed -i "s|__ghavatar__|${UI_GHAVATAR}|g" ./ui/dist/index.html
fi

if [ -n "${UI_TWEMOJI}" ]; then
    sed -i "s|__twemoji__|${UI_TWEMOJI}|g" ./ui/dist/index.html
fi

if [ -d "${EXPORT_UI_PATH}" ]; then
    cp -a "${UI_PATH}"/* "${EXPORT_UI_PATH}"/
fi

if [ -z "${LYRIO_CONFIG_FILE}" ]; then
    if [ ! -d "/app/config" ]; then
        mkdir -p /app/config
    fi

    if [ ! -f "/app/config/config.yaml" ]; then
        cp /app/lyrio/config-example.yaml /app/config/config.yaml
    fi

    LYRIO_CONFIG_FILE=/app/config/config.yaml
fi

if [ X"${1}" = X"primary" ]; then
    cd /app/lyrio
    exec npm run start:prod
else
    exec "${@}"
fi
