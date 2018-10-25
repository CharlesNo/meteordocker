FROM chneau/meteor:alpine as meteor

USER 0
RUN mkdir -p /build /app
RUN chown 1000 -R /build /app
WORKDIR /app
COPY --chown=1000:1000 . .
RUN rm -rf node_modules/*
RUN rm -rf .meteor/local/*

USER 1000
RUN meteor update --packages-only
RUN meteor npm install
RUN meteor build --server-only --directory /build


FROM node:alpine as mid

USER 0
RUN apk add --no-cache python make g++
RUN mkdir -p /app
RUN chown 1000 -R /app
WORKDIR /app
COPY --chown=1000:1000 --from=meteor /build/bundle .

USER 1000
WORKDIR /app/programs/server
RUN rm -rf node_modules
RUN rm -f package-lock.json
RUN npm i

FROM node:alpine

USER 0
ENV TZ=Europe/London
RUN apk add -U --no-cache tzdata && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir -p /app
RUN chown 1000 -R /app
WORKDIR /app
COPY --chown=1000:1000 --from=mid /app .

USER 1000
ENV LC_ALL=C.UTF-8
ENV ROOT_URL=http://localhost/
ENV MONGO_URL=mongodb://x:22222/meteor
ENV PORT=3000
ENTRYPOINT [ "/usr/local/bin/node", "/app/main.js" ]
