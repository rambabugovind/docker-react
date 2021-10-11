FROM node:alpine AS builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# all built resources will be available in /app/build

FROM nginx:alpine AS deploy

COPY --from=builder /app/build /usr/share/nginx/html

# nginx's default command starts the server. so no need for explicit startup command