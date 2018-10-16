FROM centos:centos7
MAINTAINER dorianzheng <zhengzhiquan@pingcap.com>
RUN yum install gflags-devel snappy-devel zlib-devel bzip2-devel  gcc-c++  libstdc++-devel git make which -y && \
    yum groupinstall 'Development Tools' -y
# Install Rocksdb
RUN cd /tmp && \
    git clone https://github.com/facebook/rocksdb.git && \
    cd rocksdb && \
    mkdir -p /usr/local/rocksdb/lib && \
    mkdir /usr/local/rocksdb/include && \
    make release -j8 && \
    cp librocksdb.a* /usr/local/rocksdb/lib && \
    make install-shared -j8 && \
    cp librocksdb.so* /usr/local/rocksdb/lib && \
    cp -r include /usr/local/rocksdb/ && \
    rm -rf /tmp/rocksdb/
