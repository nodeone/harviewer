FROM node:11.6-alpine

ENV NODE_ENV="production"
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    dumb-init \
    udev \
    #gcc \
      # Do some cleanup
      #&& apk del --no-cache make gcc g++ python binutils-gold gnupg libstdc++ \
      #&& rm -rf /usr/include \
      && echo
COPY . /app
RUN cd /app && npm install --quiet && npm run clean-build && \
   rm -rf /var/cache/apk/* /root/.node-gyp /usr/share/man /tmp/* 
EXPOSE 3000
WORKDIR /app/webapp
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD npm run start
