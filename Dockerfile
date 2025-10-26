# Use a minimal Nginx image
FROM nginx:alpine

# Copy HTML page into default web root
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
