FROM alpine:3.10 AS build

RUN apk add --no-cache --update \
    wget \
    ca-certificates \
    make \
    cmake \
    openssl-dev \
    g++ \
    gperf \    
    ccache \
    zlib-dev \
    readline-dev \
    linux-headers \
    dumb-init \
    su-exec

ADD https://test.ton.org/ton-test-liteclient-full.tar.xz /ton/sources.tar.xz
RUN \
    cd /ton && \
    tar xvf sources.tar.xz && \
    wget https://test.ton.org/ton-lite-client-test1.config.json -O lite.config.json

WORKDIR /ton/liteclient-build
RUN \
    cmake /ton/lite-client && \
    cmake --build . --target lite-client && \
    cmake --build . --target fift && \
    cmake --build . --target func && \
    cp /ton/liteclient-build/lite-client/lite-client /usr/local/bin/lite-client && \
    cp /ton/liteclient-build/crypto/fift /usr/local/bin/fift && \
    cp /ton/liteclient-build/crypto/func /usr/local/bin/func && \
    rm -rf /ton/lite-client /ton/liteclient-build/ /ton/sources.tar.xz

RUN \
    addgroup ton && \
    adduser -S -G ton ton && \
    chown -R ton:ton /ton

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "lite-client", "-C", "/ton/lite.config.json" ]
