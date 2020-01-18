FROM alpine:latest

ENV LANG=C.UTF-8 \
    JUMANPP_VERSION=2.0.0-rc3

WORKDIR /tmp/src/

RUN apk --no-cache update && apk --no-cache upgrade && apk --no-cache --update --virtual=build-deps add \
  build-base \
  boost-dev \
  libexecinfo-dev \
  linux-headers \
  g++ \
  make \
  protobuf-dev \
  protobuf \
  eigen-dev \
  automake \
  autoconf \
  cmake \
  curl && \
  pwd && \
   curl -OL https://github.com/ku-nlp/jumanpp/releases/download/v$JUMANPP_VERSION/jumanpp-$JUMANPP_VERSION.tar.xz && \
   tar xf jumanpp-$JUMANPP_VERSION.tar.xz && \
   cd jumanpp-$JUMANPP_VERSION && \
   mkdir build && \
   cd build && \
   cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local  && \
   make install -j  && \
   rm -rf  /tmp/src

CMD ["/usr/local/bin/jumanpp"]
