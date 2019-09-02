##1111111111111111111111
# FROM node:alpine as builder
# WORKDIR /app
# COPY package.json .
# RUN npm install
# COPY . ./
# RUN npm run build


# FROM nginx
# COPY --from=builder /app/build /usr/share/nginx/html



# Stage 1
FROM node:alpine as react-build
WORKDIR /app
COPY . ./
RUN yarn
RUN yarn build

# Stage 2 - the production environment
FROM nginx
#COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]