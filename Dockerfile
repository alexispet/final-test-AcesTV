FROM node:21.5.0-alpine3.19 AS build

COPY . /app

WORKDIR /app

COPY package*.json ./

RUN npm install

FROM node:21.5.0-alpine3.19 as api

LABEL org.opencontainers.image.source=https://github.com/alexispet/final-test-AcesTV

WORKDIR /app

COPY --from=build /app/database ./database
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json .
COPY --from=build /app/app.js .

RUN apk --no-cache add curl

EXPOSE 3000

COPY /docker/api/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "npm", "run", "start" ]
