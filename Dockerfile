FROM node:24-alpine AS builder
RUN apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/angelnav9559-ship-it/practica_5-angular.git .
RUN npm install
RUN npm run build -- --configuration production
RUN mkdir -p /salida && cp -r $(dirname $(find /app/dist -name "index.html" | head -n 1))/* /salida/

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /salida/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
