FROM node:20.8.1-alpine@sha256:002b6ee25b63b81dc4e47c9378ffe20915c3fa0e98e834c46584438468b1d0b5

RUN apk --update add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

ENV NODE_PATH=${NODE_PATH}:/opt/npm.global
ENV PATH=${PATH}:/opt/npm.global/.bin

WORKDIR /opt
COPY package.json yarn.lock ./
RUN yarn --prod && \
    yarn autoclean --init && \
    yarn autoclean --force && \
    mv node_modules npm.global && \
    rm package.json yarn.lock .yarnclean

WORKDIR /app

ENTRYPOINT ["commitlint"]
