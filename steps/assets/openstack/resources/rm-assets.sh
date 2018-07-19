#!/bin/bash
set -e

bootstrap_cleanup() {
    rm /etc/systemd/system/multi-user.target.wants/rm-assets.service
    rm /etc/systemd/system/tectonic.service
    rm /etc/systemd/system/bootkube.service
    rm /etc/systemd/system/rm-assets.service
    rm -rf /opt/tectonic
}

bootstrap_cleanup
