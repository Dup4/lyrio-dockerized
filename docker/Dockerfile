FROM node:16 AS build

USER root
WORKDIR /app
COPY ./ ./lyrio-dockerized

RUN cd ./lyrio-dockerized \
    && mkdir packages \
    && cd packages \
    && git clone https://github.com/lyrio-dev/lyrio --depth=1 \
    && git clone https://github.com/lyrio-dev/ui --depth=1 \
    && cd /app/lyrio-dockerized/packages/ui \
    && yarn \
    && NODE_OPTIONS="--max_old_space_size=8192" yarn build \
    && rm -rf node_modules \
    && cd /app/lyrio-dockerized/packages/lyrio \
    && yarn \
    && yarn build \
    && rm -rf node_modules \
    && yarn --prod \
    && cd /app/lyrio-dockerized/packages \
    && cp -a ./ui /app/ui \
    && cp -a ./lyrio /app/lyrio \
    && cp /app/lyrio-dockerized/docker/docker_entry.sh /app/docker_entry.sh \
    && chmod +x /app/docker_entry.sh \
    && rm -rf /app/lyrio-dockerized

FROM node:16-alpine

USER root
WORKDIR /app

COPY --from=build /app ./

RUN apk add tzdata \
    && apk add sed

ENTRYPOINT ["/app/docker_entry.sh"]

CMD ["primary"]
