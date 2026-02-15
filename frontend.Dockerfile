# ---------- Stage 1: Build frontend ----------
FROM node:20-alpine AS build
WORKDIR /app

# Copy package.json and install dependencies
COPY client/package*.json ./
RUN npm install

# Copy frontend source code
COPY client/ .

# Build the frontend
RUN npm run build

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine
# Copy built frontend to Nginx's html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]