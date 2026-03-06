FROM node:20-alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

COPY public/runtime-config.js /usr/share/nginx/html/runtime-config.js

EXPOSE 80

CMD ["nginx","-g","daemon off;"]