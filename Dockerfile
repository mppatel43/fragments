#this is dockerfile for building a docker image for the fragments project

################################################################################
# Stage 0: Base
################################################################################
# Use node version 18.13.0
FROM node:18.13.0-alpine@sha256:fda98168118e5a8f4269efca4101ee51dd5c75c0fe56d8eb6fad80455c2f5827 AS base 

LABEL maintainer="Meshvi Patel <mppatel43@myseneca.ca>"
LABEL description="Fragments node.js microservice"

# Create a new non-root user
RUN addgroup -S nodejs && adduser -S nodejs -G nodejs
USER nodejs

ENV PORT=8080

ENV NPM_CONFIG_LOGLEVEL=warn

ENV NPM_CONFIG_COLOR=false

# Set the NODE_ENV to production
ENV NODE_ENV production

# Use /app as our working directory
WORKDIR /app

# Copy the package.json and package-lock.json files into /app
COPY package*.json /app/

# Install node dependencies defined in package-lock.json
RUN npm ci --only=production

################################################################################
# Stage 1: local deployment
################################################################################

FROM node:18.13.0-alpine@sha256:fda98168118e5a8f4269efca4101ee51dd5c75c0fe56d8eb6fad80455c2f5827 AS deploy

# Set the default working directory
WORKDIR /app

# Copy generated node_modules from base stage
COPY --from=base /app/ /app/

# Copy src to /app/src/
COPY ./src ./src

# Copy our HTPASSWD file
COPY ./tests/.htpasswd ./tests/.htpasswd

# Install process manager
RUN npm install -g pm2@5.1.0

# Install production node modules
COPY package*.json ./
RUN npm install --only=production

# Start the container by running our server using pm2
CMD ["pm2-runtime", "start", "npm", "--", "start"]

# We run our service on port 8080
EXPOSE 8080

# Add a healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl --fail http://localhost:$PORT/v1/fragments || exit 1