#!/bin/bash
# /config/scripts/firstboot.d/ddclient-ubnt.sh
#
# Update ddclient for EdgeOS.
#

set -e

sudo cp /usr/sbin/ddclient-ubnt /usr/sbin/ddclient-ubnt.dist
sudo curl -sSL -o /usr/sbin/ddclient-ubnt https://raw.githubusercontent.com/markeissler/edgeos-extras/master/ddclient/dist/ddclient-ubnt
chmod 0755 /usr/sbin/ddclient-ubnt
