#!/bin/bash

gwIP="$1"

function setup_ntp_server {
yum install ntp -y
echo "################### ntp server #######################"

cat <<EOF>/etc/ntp.conf
restrict default kod nomodify notrap nopeer noquery
restrict -6 default kod nomodify notrap nopeer noquery
restrict 127.0.0.1
restrict -6 ::1
server 0.pool.ntp.org
server 1.pool.ntp.org
server 2.pool.ntp.org
server 3.pool.ntp.org
restrict 192.168.100.0 mask 255.255.255.0 nomodify notrap
restrict 147.175.0.0 mask 255.255.0.0 nomodify notrap
restrict $gwIP mask 255.255.255.248 nomodify notrap

driftfile /var/lib/ntp/drift
keys /etc/ntp/keys
<EOF>

systemctl start ntpd.service
systemctl enable ntpd.service
ntpstat
timedatectrl

}



setup_ntp_server

