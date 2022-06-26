# First stage of multi-step build process

FROM node:16-alpine as builder

WORKDIR '/usr/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# Second stage of multi-step build process

FROM nginx

COPY --from=builder /usr/app/dist /usr/share/nginx/html