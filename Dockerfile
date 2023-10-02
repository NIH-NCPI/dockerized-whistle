FROM golang:1.13 AS builder

RUN apt-get -y update && \
    apt-get -y install \
    libclang1-11 \
    openjdk-11-jre \
    protobuf-compiler 

RUN git clone https://github.com/GoogleCloudPlatform/healthcare-data-harmonization
WORKDIR /go/healthcare-data-harmonization

# The current version doesn't support everything we need, so we'll revert back
# to whistle one
RUN git checkout fa0d4ac3a5bb07ca071fbfd625c9293dbf78102e


# The target will be copied to /dist/whistle which will ultimately
# get copied to the scratch image
RUN mkdir -p /dist && \
    sh build_all.sh && \
    cp /go/healthcare-data-harmonization/mapping_engine/main/main /dist/whistle && \
    mkdir -p /work


WORKDIR /dist

# Copy the libraries needed to make whistle run
RUN ldd /dist/whistle | tr -s '[:blank:]' '\n' | grep '^/' | \
    xargs -I % sh -c 'mkdir -p $(dirname ./%); cp % ./%;' && \
    mkdir -p lib64 && cp /lib64/ld-linux-x86-64.so.2 lib64/

FROM scratch
COPY --chown=0:0 --from=builder /dist /
COPY --from=builder /work /work

USER $DOCKER_USER

# /work is the working directory. Users should map the root directory of 
# their project to this mount point and references to the initial whistle file
# should be relative to that directory (as should any of the other arguments
# passed to whistle). Do keep in mind that the docker image only knows about 
# data that is mounted. So, if you need to point to directories outside this
# particular mount point, you will need to add them via the docker command in 
# addition to the map to /work 
WORKDIR /work
ENTRYPOINT [ "/whistle" ]