FROM 824214588663.dkr.ecr.ap-south-1.amazonaws.com/build/node:14-alpine as build-step
RUN mkdir -p /app

WORKDIR /app

COPY package.json /app
RUN npm install
COPY . /app

ARG configuration=stage-build
RUN npm run $configuration

# Stage 2
FROM nginx:1.21.1-alpine

COPY --from=build-step /app/dist/ncr-config-panel /usr/share/nginx/html
