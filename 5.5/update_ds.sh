#!/bin/bash
PARENT_FILE=/var/lib/knot/root.zone
cd /var/lib/knot/kasp
for ZONE in {a..m}
do
  while :
  do
    if [ -n "$(/usr/sbin/keymgr ${ZONE} ds | grep -v OK)" ]
    then
      /usr/sbin/keymgr ${ZONE} ds | grep -v OK >> ${PARENT_FILE}
      break
    fi
  done
done
touch /var/lib/knot/root.zone.ds_added
