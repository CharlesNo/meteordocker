FROM frolvlad/alpine-glibc

RUN apk add --no-cache curl bash python make gcc g++ git libuv tar bzip2
RUN curl -fL https://raw.githubusercontent.com/orctom/alpine-glibc-packages/master/usr/lib/libstdc++.so.6.0.21 -o /usr/lib/libstdc++.so.6
RUN adduser -D -u 1000 meteor
USER meteor
RUN curl -sSL https://install.meteor.com | sh
ENV PATH="/home/meteor/.meteor:${PATH}"
WORKDIR /home/meteor