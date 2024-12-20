# Use official Node.js runtime as the base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available) before copying the rest of the application files
COPY package*.json ./

# Install dependencies using npm ci (clean and deterministic)
RUN npm ci && npm cache clean --force

# Copy the rest of the application code
COPY . .

# Expose the application port (default 3000 for Node.js)
EXPOSE 3000

# Create a non-root user to run the app securely
RUN groupadd -r appgroup && useradd -r -m -g appgroup appuser

# Change the ownership of the app directory to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user for security
USER appuser

# Start the application
CMD ["npm", "start"]
