#stage 1 : build angular application
FROM node:18.12-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -legacy-peer-deps
RUN npm install -g @angular/cli@8.1.2

COPY . .
RUN ng build
 #stage 2 :run
FROM nginx:latest
RUN apt-get update && apt-get install -y iputils-ping
COPY --from=build  /usr/src/app/dist/aston-villa-app  /usr/share/nginx/html
EXPOSE 80

