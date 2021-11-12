#!/usr/bin/env bash

set -euo pipefail

main() {
    echo 'Starting this locally...'
    docker run \
        -d \
        --name pihole \
        -p 53:53/tcp \
        -p 53:53/udp \
        -p 80:80 \
        -e TZ="America/Chicago" \
        -v "${PIHOLE_BASE}/etc-pihole/:/etc/pihole/" \
        -v "${PIHOLE_BASE}/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
        --dns=127.0.0.1 \
        --dns=1.1.1.1 \
        --restart=unless-stopped \
        --hostname pi.hole \
        -e VIRTUAL_HOST="pi.hole" \
        -e PROXY_LOCATION="pi.hole" \
        -e ServerIP="127.0.0.1" \
        pihole/pihole:2021.10.1
    docker ps
    echo 'Done.'
}

main
