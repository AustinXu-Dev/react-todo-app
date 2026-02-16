# syntax=docker/dockerfile:1
# Use a lightweight Node.js image based on Alpine Linux
FROM node:20-alpine

# Create and set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Required for native sqlite3 build on Alpine
RUN apk add --no-cache python3 make g++ && ln -sf python3 /usr/bin/python

# Install only production dependencies for a smaller image
RUN npm install --omit=dev

# Copy the rest of the application source code
# node_modules and other local artifacts are excluded via .dockerignore
COPY . .

# The application runs on port 3000
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
