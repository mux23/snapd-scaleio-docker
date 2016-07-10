# Run intel-sdi snapd
# stolen from https://github.com/edyesed/intelsdi-snap and modified
FROM ubuntu:16.04

EXPOSE 8181

RUN mkdir -p /opt/snap/src

ADD https://github.com/intelsdi-x/snap/releases/download/v0.14.0-beta/snap-v0.14.0-beta-linux-amd64.tar.gz /opt/snap/src/
ADD https://github.com/intelsdi-x/snap/releases/download/v0.14.0-beta/snap-plugins-v0.14.0-beta-linux-amd64.tar.gz /opt/snap/src/
ADD https://github.com/intelsdi-x/snap-plugin-collector-scaleio/releases/download/v0.1.0-alpha/snap-plugin-collector-scaleio.linux /opt/snap/src/

RUN mkdir /opt/snap/snap && cd /opt/snap/snap && tar -zxf /opt/snap/src/snap-v0.14.0-beta-linux-amd64.tar.gz && mkdir -p /opt/snap/snap/snap-v0.14.0-beta/plugin && mv /opt/snap/src/snap-plugin-collector-scaleio.linux /opt/snap/snap/snap-v0.14.0-beta/plugin/snap-plugin-collector-scaleio && chmod 755 /opt/snap/snap/snap-v0.14.0-beta/plugin/snap-plugin-collector-scaleio

ENTRYPOINT ["/opt/snap/snap/snap-v0.14.0-beta/bin/snapd", "--api-port", "8181", "--log-level", "2", "--auto-discover", "/opt/snap/snap/snap-v0.14.0-beta/plugin", "-t", "0" ]


