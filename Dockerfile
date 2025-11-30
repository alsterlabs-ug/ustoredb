FROM ubuntu:22.04 as builder

ENV DEBIAN_FRONTEND="noninteractive" TZ="Europe/London"

ARG TARGETPLATFORM
ARG TEST_USTORE

RUN ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split && \
    ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb && \
    ln -s /bin/rm /usr/sbin/rm && \
    ln -s /bin/tar /usr/sbin/tar && \
    ln -s /bin/as /usr/sbin/as

RUN apt-get update -y && \
    apt-get install -y apt-utils 2>&1 | grep -v "debconf: delaying package configuration, since apt-utils is not installed" && \
    apt-get install -y --no-install-recommends cmake git libssl-dev wget curl build-essential zlib1g zlib1g-dev python3 python3-dev python3-pip

COPY . /usr/src/ustore
WORKDIR /usr/src/ustore

RUN git config --global http.sslVerify "false"

# Install Conan 2.x
RUN pip install conan>=2.0.0

# Configure Conan profile
RUN conan profile detect --force

# Install dependencies with Conan 2.x
RUN conan install . --build=missing -c tools.cmake.cmaketoolchain:generator="Unix Makefiles"

# Test build section
RUN if [ "$TEST_USTORE" = "True" ]; then \
        cmake -DCMAKE_BUILD_TYPE=Release \
        -DUSTORE_BUILD_ENGINE_UCSET=1 \
        -DUSTORE_BUILD_ENGINE_LEVELDB=1 \
        -DUSTORE_BUILD_ENGINE_ROCKSDB=1 \
        -DUSTORE_BUILD_API_FLIGHT_CLIENT=1 \
        -DUSTORE_BUILD_API_FLIGHT_SERVER=1 \
        -DUSTORE_BUILD_TESTS=1 \
        -DUSE_CONAN=1 \
        -B ./build_release . && \
        make -j 4 -C ./build_release && \
        mkdir -p ./tmp/ustore/ && \
        export USTORE_TEST_PATH="./tmp/" && \
        # Run embedded tests
        for test in $(ls ./build_release/build/bin/*test_units_ustore_embedded*); do echo -e "------ \e[93mRunning $test\e[0m ------"; timeout -v --kill-after=5 300 $test; done && \
        ./build_release/build/bin/test_units_ustore_flight_client && \
        exit 0; \
    fi

# Production build
RUN cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSTORE_BUILD_TESTS=0 \
    -DUSTORE_BUILD_BENCHMARKS=0 \
    -DUSTORE_BUILD_ENGINE_UCSET=1 \
    -DUSTORE_BUILD_ENGINE_LEVELDB=1 \
    -DUSTORE_BUILD_ENGINE_ROCKSDB=1 \
    -DUSTORE_BUILD_API_FLIGHT_CLIENT=0 \
    -DUSTORE_BUILD_API_FLIGHT_SERVER=1 \
    -DUSE_CONAN=1 \
    -B ./build_release . && \
    make -j$(nproc) \
    ustore_flight_server_ucset \
    ustore_flight_server_leveldb \
    ustore_flight_server_rocksdb \
    -C ./build_release

# Add Tini
ENV TINI_VERSION v0.19.0
RUN wget -O /tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini --no-check-certificate
RUN chmod +x /tini

FROM ubuntu:22.04

ARG version
LABEL name="ustore" \
    vendor="Unum" \ 
    version="$version" \
    description="Replacing MongoDB, Neo4J, and Elastic with 1 transactional database"


RUN apt-get update -y && \
    apt-get install -y apt-utils 2>&1 | grep -v "debconf: delaying package configuration, since apt-utils is not installed"

WORKDIR /var/lib/ustore/

RUN mkdir /var/lib/ustore/ucset && \
    mkdir /var/lib/ustore/rocksdb && \
    mkdir /var/lib/ustore/leveldb

COPY --from=builder /usr/src/ustore/build_release/build/bin/ustore_flight_server_ucset ./ucset_server
COPY --from=builder /usr/src/ustore/build_release/build/bin/ustore_flight_server_leveldb ./leveldb_server
COPY --from=builder /usr/src/ustore/build_release/build/bin/ustore_flight_server_rocksdb ./rocksdb_server
COPY --from=builder /tini /tini

COPY ./assets/configs/db.json ./config.json
COPY ./LICENSE /licenses/LICENSE

EXPOSE 38709
ENTRYPOINT ["/tini", "-s"]
CMD ["./ucset_server"]
