# Stage 1: Build the React app
FROM node:20-alpine AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the React app
FROM node:20-alpine AS production

WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy built assets from build stage
COPY --from=build /app/dist ./dist

# Create a non-root user
RUN adduser -u 5678 --disabled-password --gecos "" appuser
USER appuser

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]

# Stage 3: Unit testing
FROM node:20-alpine AS unit_test

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

CMD ["npm", "test"]