# Use the official NGINX base image
FROM nginx:alpine

# Copy the "Hello, World!" HTML file to the NGINX web root
COPY index.html /usr/share/nginx/html/

#Expose nginx service
EXPOSE 80

# Set the CMD to start NGINX when the container runs
CMD ["nginx", "-g", "daemon off;"]



