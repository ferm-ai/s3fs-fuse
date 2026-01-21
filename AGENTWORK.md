Agentwork's fork of `s3fs`
==========================

## Build the `s3fs` binary

    docker build -t s3fs-build .

## Build .deb file

# Extract the .deb file to your current directory
<!-- docker run --rm -v $(pwd):/host s3fs-build cp /output/*.deb /host/ -->

    # docker run -it --name s3fs-temp s3fs-build ./create_deb.sh
    docker create --name s3fs-temp s3fs-build
    docker cp s3fs-temp:/output/s3fs-fuse_1.97-1_arm64.deb .
    docker rm s3fs-temp



## To install on your Ubuntu machine:

On newer Ubuntu do: (.deb dependencies are currently for 24.04)

    apt update
    apt install ./s3fs-fuse_1.97-1_arm64.deb

On older Ubuntu do:

    # Install the .deb
    sudo dpkg -i s3fs-fuse_1.97-1_*.deb

    # Install any missing dependencies
    sudo apt-get install -f


## Debugging

### Test .deb package on Ubuntu

    docker run --rm -it --mount type=bind,src=.,dst=/mnt/ ubuntu
    apt update
    cd /mnt
    apt install ./s3fs-fuse_1.97-1_arm64.deb

### Get the `s3fs` binary
Copy the built binary out of the container

    docker create --name s3fs-temp s3fs-build
    docker cp s3fs-temp:/s3fs-fuse/src/s3fs ./s3fs
    docker rm s3fs-temp


### Building only changed files

  docker run --rm -v $(pwd):/s3fs-fuse -w /s3fs-fuse s3fs-build make -j$(nproc)


## Notes

1. Architecture: This builds for your Mac's architecture (arm64). If your Ubuntu server is x86_64, build with:
docker build --platform linux/amd64 -t s3fs-build .
2. Ubuntu compatibility: The .deb is built on Debian trixie. For better Ubuntu compatibility, you might need
to adjust the --requires dependencies (e.g., libssl3 vs libssl3t64 on newer Ubuntu).
3. Version: I set --pkgversion=1.94 - update this to match the actual s3fs version you're building.

### E2B
E2B containers are based on Debian 13 (trixie):

    > cat /etc/os-release
    PRETTY_NAME="Debian GNU/Linux 13 (trixie)"
    NAME="Debian GNU/Linux"
    VERSION_ID="13"
    VERSION="13 (trixie)"
    VERSION_CODENAME=trixie
    DEBIAN_VERSION_FULL=13.1
    ID=debian
    HOME_URL="https://www.debian.org/"
    SUPPORT_URL="https://www.debian.org/support"
    BUG_REPORT_URL="https://bugs.debian.org/
