# Stage 1: Build Angular Application
FROM node:18.12-alpine AS build

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install project dependencies
RUN npm install -legacy-peer-deps

# Install Angular CLI globally
RUN npm install -g @angular/cli@8.1.2

# Copy all files to the container
COPY . .

# Build the Angular application
RUN ng build

# Stage 2: Serve the application using Nginx
FROM nginx:latest

# Copy the built application from the build stage
COPY --from=build /usr/src/app/dist/aston-villa-app /usr/share/nginx/html
# Install ping utility
RUN apt-get update && apt-get install -y iputils-ping

EXPOSE 80
