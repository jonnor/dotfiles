#!/bin/bash

cp /config/tmux.conf "$HOME/.tmux.conf"

mkdir -p "$HOME/.pi/agent"
cp /config/pi/agent/* "$HOME/.pi/agent"

# use local DNS only server for lookup for mDNS etc
# podman via pasta does the proxying
# NOTE: requires systemd-resolved or similar on the host
# fails because not root
#cat > /etc/resolv.conf << 'EOF'
#nameserver 169.254.1.1
#options single-request-reopen
#EOF

echo "resolv.conf overridden"

exec "$@"
