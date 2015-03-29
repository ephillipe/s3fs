FROM debian:wheezy
MAINTAINER Roman Atachiants "roman@misakai.com"

# The dependencies needed for the compilation process, they will be deleted once the docker image is baked
ENV SETUP_TOOLS="build-essential libmount1 libblkid1 libfuse-dev fuse-utils libcurl4-openssl-dev libxml2-dev mime-support automake libtool wget tar"
WORKDIR /deploy

# S3FS Version
ENV S3FS_VERSION="1.78"

# Make sure we have S3
RUN apt-get update -qq \
	&& apt-get install -y $SETUP_TOOLS \
	&& wget https://github.com/s3fs-fuse/s3fs-fuse/archive/v$S3FS_VERSION.tar.gz -O /usr/src/v$S3FS_VERSION.tar.gz \
	&& tar xvz -C /usr/src -f /usr/src/v$S3FS_VERSION.tar.gz \
	&& cd /usr/src/s3fs-fuse-$S3FS_VERSION \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install \
	&& mkdir /data \
	&& apt-get remove -y --purge --force-yes $SETUP_TOOLS \
	&& apt-get autoremove -y --force-yes \
	&& rm -rf /deploy