# This Dockerfile builds Reddcoin seeder and packages it into a minimal `final` image

# VERSION of Reddcoin seeder to be build
ARG VERSION=0.04

FROM debian:bullseye-slim
LABEL maintainer="info@reddcoin.com"
ENV DEBIAN_FRONTEND=noninteractive

ARG VERSION

RUN apt-get update && apt-get install -y git build-essential libboost-all-dev libssl-dev
WORKDIR /src

RUN git clone --depth 1 --branch "v$VERSION" https://github.com/reddcoin-project/reddcoin-seeder.git

RUN cd ./reddcoin-seeder && make
RUN mv ./reddcoin-seeder/dnsseed /usr/local/bin
RUN rm -rf reddcoin-seeder

# Cleanup Build Packages
RUN apt-get remove -y \
  build-essential libboost-all-dev libssl-dev
RUN apt-get autoremove -y

EXPOSE 53/udp

CMD [ "dnsseed" ]

# example configured command: dnsseed -h $HOSTNAME -n $IPADDRESS -p 53
