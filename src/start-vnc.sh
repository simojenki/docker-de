#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

[[ $(id -u) == "0" ]] &&
    echo "Must not run as root user..." &&
    exit 1

export USER="$(id -u -n)"
export HOME="$(eval echo ~$(id -u -n))"

echo "Running as $(id) with HOME=${HOME}, USER=${USER}"

echo "Launching websockify on port ${NO_VNC_PORT}"
websockify \
  -D \
  --web=/usr/share/novnc \
  "${NO_VNC_PORT}" \
  "localhost:${VNC_PORT}"

echo "Launching vncserver depth=${VNC_DEPTH}, geometry=${VNC_GEOMETRY}"
vncserver \
  "${DISPLAY}" \
  -depth "${VNC_DEPTH}" \
  -geometry "${VNC_GEOMETRY}" \
  -localhost no \
  -autokill \
  -alwaysshared \
  -cleanstale \
  -fg

