FROM debian:buster-slim

# Install build tools
RUN apt-get update && apt-get install -y \
        build-essential \
        libffi-dev \
        libssl-dev \
        zlib1g-dev \
        libncurses5-dev \
        libsqlite3-dev \
        libbz2-dev \
        liblzma-dev \
        libreadline-dev \
        tk-dev \
        libgdbm-dev \
        git \
        #    wget \
        && rm -rf /var/lib/apt/lists/*

# Install from github
WORKDIR /src
RUN git clone https://github.com/python/cpython.git
WORKDIR /src/cpython
RUN git checkout tags/v3.9.0b1 -b v3.9.0b1
RUN ./configure --with-pydebug  #--enable-optimizations
RUN make -j2 -s

# Install from tar
#RUN wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tar.xz
#RUN tar -xf Python-3.10.0.tar.xz

# Install custom version to system
#RUN make altinstall

CMD ["./python", "--version"]

