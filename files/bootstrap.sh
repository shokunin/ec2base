#!/bin/sh

### BEGIN INIT INFO
# Provides:             tru_bootstrap
# Required-Start:       $remote_fs $syslog
# Required-Stop:        $remote_fs $syslog
# Default-Start:        2 3 4 5
# X-Start-Before:       consul supervisord
# X-Stop-After:         consul supervisord
# Default-Stop:
# Short-Description:    Setup the hostname and be ready for fun
### END INIT INFO


ROLE=`/usr/local/bin/parse_user_data --param role`
DOMAIN=`/usr/local/bin/parse_user_data --param domain`
INSTANCE_ID=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id |awk -F '-' '{print $NF}'`
IP=`/usr/bin/facter ipaddress`

if [ $(grep -c $IP /etc/hosts) -ne 0 ] ; then
  X="y"
else
  echo "${IP} ${ROLE}-${INSTANCE_ID} ${ROLE}-${INSTANCE_ID}.${DOMAIN}" >> /etc/hosts
fi

echo "${ROLE}-${INSTANCE_ID}.${DOMAIN}" > /etc/hostname
hostname "${ROLE}-${INSTANCE_ID}.${DOMAIN}" > /dev/null

/usr/local/bin/parse_user_data -y > /etc/node_info.yaml

