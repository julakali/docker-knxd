# knxd
# 
#
FROM debian:jessie
MAINTAINER Julian Kalinowski
RUN apt-get update && apt install -y \
	debhelper \
	cdbs \
	automake \
	libtool \
	pkg-config \
	libusb-1.0-0-dev \
	git-core \
	build-essential \
	libsystemd-dev \
	dh-systemd \
	libev-dev \
	cmake \
     && rm -rf /var/lib/apt/lists/*


#RUN apt-get -y install git-core build-essential debhelper autotools-dev autoconf automake libtool \
#                       libusb-1.0-0-dev  pkg-config base-files  base-files libev-dev  \
#                       init-system-helpers dh-systemd libsystemd-dev


#	libfmt3-dev \

RUN apt-get update && apt-get -y install \
	cmake \
	libsystemd-daemon-dev \
	init-system-helpers \
     && rm -rf /var/lib/apt/lists/*

# now build+install knxd

RUN git clone https://github.com/knxd/knxd.git && cd knxd && git checkout tags/v0.14.17 && \
    dpkg-buildpackage -b -uc && cd .. && dpkg -i knxd_*.deb knxd-tools_*.deb


#EXPOSE  4720 6720 3671/udp
##### NOTE AND README ######
#start this container with --net=host instead of binding ports

CMD ["knxd", "-e 0.0.1", "-E 0.0.2:8", "-DTRS", "-c", "-i", "--send-delay=70", "-B single", "-b ipt:192.168.177.24"]
