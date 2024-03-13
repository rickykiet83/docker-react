# Build phase
FROM node:21-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
# Expose port 80 for AWS Elastic Beanstalk
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# Default command of nginx image starts the server, so no need to specify it here