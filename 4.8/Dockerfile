#
# Berkeley DB libraries for Alpine Linux
#
FROM ackro/libdb:4.8-build-alpine as build
FROM alpine
ARG VERSION=4.8.30.NC

COPY --from=build /usr/local/src/db-$VERSION/build/bin /usr/local/bin/
COPY --from=build /usr/local/src/db-$VERSION/build/lib /usr/local/lib/
