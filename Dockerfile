# Use the specified version of Node.js
FROM node:21.5.0 AS build

LABEL org.opencontainers.image.source=https://github.com/AcesTV/final-cesi-api

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Bundle app source
COPY . .

FROM node:21.5.0-slim as api

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

COPY docker/api/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000

CMD [ "npm", "run", "start" ]
