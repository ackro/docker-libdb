#
# Buld environment for Berkeley DB on Alpine Linux
#
FROM ackro/alpine-build
ARG VERSION=4.8.30.NC
ARG URL=http://download.oracle.com/berkeley-db/db-$VERSION.tar.gz

WORKDIR /usr/local/src
RUN wget $URL \
  && tar -xzf db-$VERSION.tar.gz \
  && rm db-$VERSION.tar.gz

WORKDIR /usr/local/src/db-$VERSION
COPY db-4.8.30-rename-atomic-compare-exchange.patch .
RUN patch -Np1 -i db-4.8.30-rename-atomic-compare-exchange.patch

WORKDIR /usr/local/src/db-$VERSION/build-unix
RUN mkdir /usr/local/src/db-$VERSION/build \
  && ../dist/configure \
    --prefix=/usr/local/src/db-$VERSION/build \
    --enable-cxx \
    --disable-static \
    --with-pic \
  && make -j3 \
  && make install \
  && rm -rf /usr/local/src/db-$VERSION/build/docs /usr/local/src/db-$VERSION/build/share
