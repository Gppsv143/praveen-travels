# Use official Node.js runtime as the base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies (use npm ci if package-lock.json exists)
RUN npm install && npm cache clean --force

# Copy the rest of the application code
COPY . .

# Expose the application port (default 3000 for Node.js)
EXPOSE 3000

# Set a non-root user to run the app
RUN groupadd -r appgroup && useradd -r -m -g appgroup appuser
USER appuser

# Start the application
CMD ["npm", "start"]
