#!/bin/bash
ZONE=root-servers.net
PARENT_FILE=/var/lib/knot/root.zone
while :
do
  if [ -n "$(/usr/sbin/keymgr ${ZONE} ds | grep -v OK)" ]
  then
    /usr/sbin/keymgr ${ZONE} ds | grep -v OK >> ${PARENT_FILE}
    touch /var/lib/knot/root.zone.ds_added
    exit
  fi
done
