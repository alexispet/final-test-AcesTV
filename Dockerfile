FROM node:21.6.0-alpine3.19 AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:21.6.0-alpine3.19 as api

LABEL org.opencontainers.image.source=https://github.com/alexispet/final-test-AcesTV

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

EXPOSE 3000

COPY docker/api/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "npm", "run", "start" ]
