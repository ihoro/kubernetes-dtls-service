FROM ubuntu

RUN apt update && \
    apt install -y git autoconf libtool make

RUN mkdir /app

RUN git clone https://github.com/wolfSSL/wolfssl /app/wolfssl
RUN git clone https://github.com/wolfSSL/wolfssl-examples /app/wolfssl-examples

RUN cd /app/wolfssl && \
    ./autogen.sh && \
    ./configure --enable-dtls && \
    make && \
    make check && \
    make install && \
    make clean

COPY *.c /app/wolfssl-examples/dtls/

ENV LD_LIBRARY_PATH=/usr/local/lib
RUN cd /app/wolfssl-examples/dtls && \
    make CFLAGS=" -pthread "

WORKDIR /app/wolfssl-examples/dtls
