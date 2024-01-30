FROM node:alpine as build-stage
WORKDIR /react-tetris
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine as production-stage
COPY --from=build-stage /react-tetris/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



