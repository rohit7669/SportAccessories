FROM node:20-alpine AS build

WORKDIR /app

COPY client/package*.json ./

RUN npm install

COPY client .

RUN npm run build


FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

COPY client/public/config.js /usr/share/nginx/html/config.js

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]