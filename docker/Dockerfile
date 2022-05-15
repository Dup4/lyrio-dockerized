FROM node:16 AS build

USER root
WORKDIR /app
COPY ./ ./lyrio-dockerized

RUN cd ./lyrio-dockerized \
    && mkdir packages \
    && cd packages \
    && git clone https://github.com/lyrio-dev/ui \
    && git clone https://github.com/lyrio-dev/lyrio \
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
    && cp -a /app/lyrio-dockerized/docker/bin /app/ \
    && chmod +x /app/docker_entry.sh \
    && rm -rf /app/lyrio-dockerized

FROM node:16-alpine

USER root
WORKDIR /app

COPY --from=build /app ./

RUN apk add tzdata \
    && apk add sed \
    && apk add curl

HEALTHCHECK --interval=10s --timeout=10s --start-period=30s --retries=3 CMD [ "/app/bin/healthcheck" ]

ENTRYPOINT ["/app/docker_entry.sh"]

CMD ["primary"]
