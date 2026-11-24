FROM node:20-alpine AS builder
WORKDIR /app
RUN npx -y @angular/cli@18 new practica-angular --defaults --skip-git
WORKDIR /app/practica-angular
RUN npm run build -- --configuration production
RUN mkdir -p /salida && cp -r $(dirname $(find dist -name "index.html" | head -n 1))/* /salida/

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /salida/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
