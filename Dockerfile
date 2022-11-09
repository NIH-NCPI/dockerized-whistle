FROM golang:1.13 AS builder

RUN apt-get -y update && \
    apt-get -y install \
                    libclang1-11 \
                    openjdk-11-jre \
                    protobuf-compiler 

RUN git clone https://github.com/GoogleCloudPlatform/healthcare-data-harmonization

WORKDIR /go/healthcare-data-harmonization

# The target will be linked to /go/bin/whistle which is what we'll recommend
# users to call when running whistle from this container
RUN sh build_all.sh && \
    ln -s /go/healthcare-data-harmonization/mapping_engine/main/main /go/bin/whistle && \
    mkdir -p /work

# /work is the working directory. Users should map the root directory of 
# their project to this mount point and references to the initial whistle file
# should be relative to that directory (as should any of the other arguments
# passed to whistle). Do keep in mind that the docker image only knows about 
# data that is mounted. So, if you need to point to directories outside this
# particular mount point, you will need to add them via the docker command in 
# addition to the map to /work 
WORKDIR /work
