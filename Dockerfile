FROM docker.io/debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive

ARG NUT_EXPORTER_VERSION=3.0.0

RUN apt-get update && apt-get install -y \
    nut \
    nut-client \
    nut-server \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

COPY nut.conf ups.conf upsd.users /template
COPY entrypoint.sh /entrypoint.sh

# Default environment variables
ENV NUT_CLIENT_NAME=usbhid-ups \
    NUT_CLIENT_PORT=auto \
    NUT_CLIENT_DESC="A usbhid compatible UPS"

ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["upsd", "-D", "-u", "root"]
