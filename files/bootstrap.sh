#!/bin/sh

if [ -x /opt/puppetlabs/bin/facter ] ; then
	IP=`/opt/puppetlabs/bin/facter ipaddress`
else
	IP=`/usr/bin/facter ipaddress`
fi


ROLE=`/usr/local/bin/parse_user_data --param role`
DOMAIN=`/usr/local/bin/parse_user_data --param domain`
INSTANCE_ID=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id |awk -F '-' '{print $NF}'`

if [ $(grep -c $IP /etc/hosts) -ne 0 ] ; then
  X="y"
else
  echo "${IP} ${ROLE}-${INSTANCE_ID} ${ROLE}-${INSTANCE_ID}.${DOMAIN}" >> /etc/hosts
fi

echo "${ROLE}-${INSTANCE_ID}.${DOMAIN}" > /etc/hostname
hostname "${ROLE}-${INSTANCE_ID}.${DOMAIN}" > /dev/null

/usr/local/bin/parse_user_data -y > /etc/node_info.yaml

exit 0
