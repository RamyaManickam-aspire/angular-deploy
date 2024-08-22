FROM node:20 as build

WORKDIR /app

COPY ./package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:alpine

EXPOSE 80

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/dist/angular-deploy /usr/share/nginx/html
