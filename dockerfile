# Use an official Nginx image as base
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the Swagger UI files from swagger-ui-dist
COPY --from=node:14-alpine /usr/lib/node_modules/swagger-ui-dist /usr/share/nginx/html

# Copy the Swagger specification file (YAML)
COPY index.yaml /usr/share/nginx/html/swagger.yaml

# Replace the default Swagger UI configuration to load our YAML file
RUN sed -i 's|url: "https://petstore.swagger.io/v2/swagger.json"|url: "/swagger.yaml"|' /usr/share/nginx/html/swagger-initializer.js

# Expose port 8080 for Swagger UI
EXPOSE 8080

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
