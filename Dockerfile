# Copyright 2019, Development Gateway, see COPYING
FROM debian:stretch-slim AS build
RUN apt-get update \
  && apt-get install --no-install-recommends -y cmake make gcc libc6-dev

WORKDIR /tmp
ENV TINI_VERSION 0.18.0
ADD https://github.com/krallin/tini/archive/v${TINI_VERSION}.tar.gz ./
RUN tar -xf v${TINI_VERSION}.tar.gz \
  && cmake tini-${TINI_VERSION} \
  && make

FROM debian:stretch-slim
COPY --from=build /tmp/tini /usr/local/sbin/
