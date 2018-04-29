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
# this commit is 0.14.24:
RUN git clone https://github.com/knxd/knxd.git && cd knxd && git checkout 4fadfa4845d24cd668b924185f38a878d452ea88 && \ 
    dpkg-buildpackage -b -uc && cd .. && dpkg -i knxd_*.deb knxd-tools_*.deb

#CMD ["knxd", "-e 0.0.1", "-E 0.0.2:8", "-DTRS", "-c", "-i", "--send-delay=70", "-B single", "-b ipt:192.168.177.24"]

ADD knxd.ini /etc/
CMD ["knxd", "/etc/knxd.ini"]
