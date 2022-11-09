FROM golang:1.13 AS builder

RUN apt-get -y update && \
    apt-get -y install openjdk-11-jre protobuf-compiler libclang1-11

RUN git clone https://github.com/GoogleCloudPlatform/healthcare-data-harmonization

WORKDIR /go/healthcare-data-harmonization
RUN sh build_all.sh && \
    ln -s /go/healthcare-data-harmonization/mapping_engine/main/main /go/bin/whistle && \
    mkdir -p /work

WORKDIR /work
