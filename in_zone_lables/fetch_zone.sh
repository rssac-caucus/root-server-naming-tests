#!/bin/bash

ZONE=$1
SERVER=$2

if [ "${ZONE}" == "." ]
then
  FILE=/var/lib/knot/root.zone
else
  FILE=/var/lib/knot/${ZONE}.zone
fi

mkdir -p /var/lib/knot/
dig AXFR ${ZONE} @${SERVER} |  egrep -v "NSEC|RRSIG|DNSKEY|;" | sed s/root-servers.net/root-servers/g > ${FILE}
