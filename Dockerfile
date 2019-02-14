FROM node:alpine

# Installs latest Chromium package.
RUN apk update && apk upgrade \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && apk add --no-cache \
    nss-tools \
    udev \
    ttf-freefont \
    chromium@edge \
    nss@edge \
    harfbuzz@edge \
    grep \
    && rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

# Add Chrome as a user
RUN mkdir -p /usr/src/app \
    && adduser -D chrome \
    && chown -R chrome:chrome /usr/src/app

# Run Chrome as non-privileged
USER chrome
WORKDIR /usr/src/app

ENV CHROME_PATH /usr/bin/chromium-browser
ENV CHROME_BIN /usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Add Chromium entrypoint
ENTRYPOINT ["/usr/bin/chromium-browser", "--no-sandbox", "--no-zygote"]
