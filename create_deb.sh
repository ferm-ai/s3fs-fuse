#!/bin/bash

# Create .deb package
# checkinstall needs these env vars and flags to run non-interactively
checkinstall \
  --install=no \
  --fstrans=yes \
  --default \
  --pkgname=s3fs-fuse \
  --pkgversion=1.97 \
  --pkgrelease=1-agentwork \
  --pkglicense=GPL-2.0 \
  --pakdir=. \
  --maintainer="malthe@agentwork.so" \
  --requires="fuse3,libc6,libcurl4t64,libfuse3-4,libgcrypt20,libssl3t64,libstdc++6,libxml2,media-types" \
  make install

# Requirements
#
# On Debian 13/trixie (see https://packages.debian.org/trixie/amd64/utils/s3fs):
#
# fuse
# libc6
# libcurl3t64-gnutls
# libfuse2t64
# libgcrypt20
# libgnutls30t64
# libstdc++6
# libxml2
# media-types
#
# On Ubuntu 24.04 (see https://packages.ubuntu.com/noble/s3fs):
#
# fuse
# libc6 (>= 2.38)
# libcurl3t64-gnutls (>= 7.16.2)
# libfuse2t64 (>= 2.8)
# libgcc-s1 (>= 3.4) [riscv64]
# libgcc-s1 (>= 3.5) [armhf]
# libgcrypt20 (>= 1.10.0)
# libgnutls30t64 (>= 3.7.2)
# libstdc++6 (>= 5.2) [not ppc64el]
# libstdc++6 (>= 9) [ppc64el]
# libxml2 (>= 2.7.4)
# media-types
#
# For Ubuntu 25.10, see: https://packages.ubuntu.com/questing/s3fs

