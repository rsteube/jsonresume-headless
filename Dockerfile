FROM node:slim AS base

WORKDIR /data

# https://docs.browserless.io/blog/2018/04/25/chrome-linux.html
# Install all of Chrome's necessary packages
RUN apt-get update && apt-get install -y \
  locales \
  gconf-service \
  libasound2 \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgcc1 \
  libgconf-2-4 \
  libgdk-pixbuf2.0-0 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libstdc++6 \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6 \
  ca-certificates \
  fonts-liberation \
  libappindicator1 \
  libnss3 \
  lsb-release \
  xdg-utils

RUN npm init -y
RUN npm install puppeteer

FROM base
ARG DOCKER_TAG
ENV VERSION=${DOCKER_TAG}

RUN npm install resume-cli@${VERSION} \
                jsonresume-theme-class \
                jsonresume-theme-classy \
                jsonresume-theme-elegant \
                jsonresume-theme-flat \
                jsonresume-theme-kendall \
                jsonresume-theme-kwan \
                jsonresume-theme-md \
                jsonresume-theme-modern \
                jsonresume-theme-onepage \
                jsonresume-theme-paper \
                jsonresume-theme-short \
                jsonresume-theme-slick \
                jsonresume-theme-spartan \
                jsonresume-theme-stackoverflow

# https://hub.docker.com/r/paskal/jsonresume/dockerfile
# use sed to make the webserver available for the Docker container to map
RUN sed -i~ "s/localhost/0.0.0.0/g" \
    node_modules/resume-cli/index.js \
    node_modules/resume-cli/lib/serve.js

ENV RESUME_PUPPETEER_NO_SANDBOX 1

WORKDIR /work

ENTRYPOINT ["node", "/data/node_modules/resume-cli"]

