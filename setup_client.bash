#!/bin/bash

gwIP="$1"

function setup_ntp_client {
echo "##################  ntp client ##############################"
yum install ntp -y
cat <<EOF>/etc/ntp.conf
restrict default kod nomodify notrap nopeer noquery
restrict -6 default kod nomodify notrap nopeer noquery
restrict 127.0.0.1
restrict -6 ::1
server $gwIP
driftfile /var/lib/ntp/drift
keys /etc/ntp/keys
EOF

systemctl start ntpd.service
systemctl enable ntpd.service
ntpstat
timedatectrl

ntpdate -q pool.ntp.org
}

setup_ntp_client

