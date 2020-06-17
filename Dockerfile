FROM node:12.18.0-alpine3.11
USER root
RUN mkdir /app
WORKDIR /app

RUN apk add --no-cache bash curl tar git gzip openssl openssh-client ca-certificates gnupg unzip g++ gcc libgcc libstdc++ linux-headers make python && \ 
    npm config set ca "" && \
    npm config set unsafe-perm true && \
    npm config set proxy http://registry.npmjs.org/ && \
    npm config set http-proxy http://registry.npmjs.org/ && \
    npm config set strict-ssl false && \
    npm config set registry http://registry.npmjs.org/ && \
    npm config rm https-proxy && \
    npm update  && \
    npm install -g @vue/cli @vue/cli-init @quasar/cli cordova && \
    rm -f /var/cache/apk/* 

COPY docker-entrypoint.sh ./
#COPY package*.json ./
RUN chmod 777 /app/docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh" ] 
CMD /bin/bash
