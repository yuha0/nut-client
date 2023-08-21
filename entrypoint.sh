#!/bin/sh
set -e

for f in /template/*; do
    bn=$(basename $f)
    envsubst < $f > /etc/nut/$bn
done

upsdrvctl -u root start

exec "$@"
