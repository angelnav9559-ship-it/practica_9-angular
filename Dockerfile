FROM node:20-alpine AS builder
RUN apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com .
RUN npm install
RUN npm run build -- --configuration production

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/*/browser /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
