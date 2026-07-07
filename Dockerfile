# Dockerfile for OpenWA
FROM node:20-alpine

# Install dependencies for Puppeteer (WhatsApp Web needs this)
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    git \
    python3 \
    make \
    g++

# Set Puppeteer to use system Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Create app directory
WORKDIR /app

# Clone OpenWA
RUN git clone https://github.com/rmyndharis/OpenWA.git /app/openwa

WORKDIR /app/openwa

# Install dependencies
RUN npm install

# Create data directory
RUN mkdir -p /app/openwa/data

# Expose port
EXPOSE 8080

# Start OpenWA
CMD ["npm", "run", "start:dev"]
