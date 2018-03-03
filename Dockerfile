FROM node:9.7.1-alpine@sha256:c6c2bbd87a7e142b5d991a2e860ed808756ed67a7e63a2281e8fbc246b5aed00

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
