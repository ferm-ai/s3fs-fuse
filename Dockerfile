FROM debian:trixie

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
    && rm -rf /var/lib/apt/lists/*

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
