# Build berkelydb 4.8.30 for Alpine Linux
FROM alpine as libdb4

ENV LIBDB_VERSION=4.8.30.NC

RUN apk add --no-cache --virtual .build autoconf automake build-base file
RUN wget http://download.oracle.com/berkeley-db/db-${LIBDB_VERSION}.tar.gz
RUN mkdir -p /opt/db-${LIBDB_VERSION}/build
COPY db-4.8.30-rename-atomic-compare-exchange.patch /opt

WORKDIR /opt
RUN tar -xzf /db-${LIBDB_VERSION}.tar.gz

WORKDIR /opt/db-${LIBDB_VERSION}
COPY db-4.8.30-rename-atomic-compare-exchange.patch /opt
RUN patch -Np1 -i ../db-4.8.30-rename-atomic-compare-exchange.patch

WORKDIR /opt/db-${LIBDB_VERSION}/build_unix
RUN ../dist/configure --prefix=/opt/db-${LIBDB_VERSION}/build --enable-cxx --disable-static --with-pic
RUN make -j3 && make install && make uninstall_docs

# Create image
FROM alpine

COPY --from=libdb4 /opt/db-*/build /usr/local/
CMD ["/bin/sh"]
