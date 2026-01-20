FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies + checkinstall for .deb creation
RUN apt-get update -y -qq && apt-get install -y \
    autoconf \
    automake \
    build-essential \
    checkinstall \
    fuse3 \
    g++ \
    libcurl4-openssl-dev \
    libfuse3-dev \
    libssl-dev \
    libtool \
    libxml2-dev \
    pkg-config \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install autoconf 2.72 from source (Ubuntu 24.04 only has 2.71)
RUN cd /tmp \
    && wget -q https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz \
    && tar xf autoconf-2.72.tar.xz \
    && cd autoconf-2.72 \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/autoconf-2.72*

# Set working directory
WORKDIR /s3fs-fuse

# Copy source code
COPY . .

# Build s3fs
RUN ./autogen.sh \
    && ./configure --prefix=/usr --with-openssl \
    && make -j$(nproc)

# Build .deb package
RUN ./create_deb.sh

# Default command shows the built binary info
CMD ["./src/s3fs", "--version"]
