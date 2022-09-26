#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

[[ $(id -u) == "0" ]] &&
    echo "Must not run as root user..." &&
    exit 1

export USER="$(id -u -n)"
export HOME="$(eval echo ~$(id -u -n))"
readonly vnc_port=$((5900+VNC_DISPLAY))

echo "Running vncserver :${VNC_DISPLAY} depth=${VNC_DEPTH}, geometry=${VNC_GEOMETRY} as $(id), HOME=${HOME}"
  
cat << END > "${HOME}/.vnc/xstartup"
#!/bin/bash

xrdb ${HOME}/.Xresources
xsetroot -solid grey
startlxde
END
chmod 700 "${HOME}/.vnc/xstartup"

touch "${HOME}/.Xauthority" "${HOME}/.Xresources"

vncserver \
  ":${VNC_DISPLAY}" \
  -depth "${VNC_DEPTH}" \
  -geometry "${VNC_GEOMETRY}" \
  -alwaysshared \
  -localhost no \
  -autokill \
  -cleanstale \
  -fg

