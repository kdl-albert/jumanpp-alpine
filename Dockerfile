FROM alpine:latest

ENV LANG=C.UTF-8 \
    JUMANPP_VERSION=2.0.0-rc3

RUN apk add --update --no-cache --virtual=build-deps \
    g++ make cmake libexecinfo-dev protobuf-dev \
    && wget -q https://github.com/ku-nlp/jumanpp/releases/download/v${JUMANPP_VERSION}/jumanpp-${JUMANPP_VERSION}.tar.xz \
    && tar xf jumanpp-${JUMANPP_VERSION}.tar.xz \
    && cd jumanpp-${JUMANPP_VERSION}/ \
    && mkdir bld \
    && cd bld \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j "$(nproc)" \
    && make install \
    && rm -rf /var/cache/* \
    && apk del build-deps \
    && apk add --update --no-cache libstdc++ libgcc \
    && cd / \
    && rm jumanpp-${JUMANPP_VERSION}.tar.xz \
    && rm -rf jumanpp-${JUMANPP_VERSION}

CMD ["jumanpp"]
