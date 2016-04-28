#!/bin/bash
ZONE=root-servers.net
PARENT_FILE=/var/lib/knot/root.zone
set -x
cd /var/lib/knot/kasp
/usr/sbin/keymgr zone key list ${ZONE} &>/dev/null
if [ $? -eq 0 ]
then
  touch /var/lib/knot/root.zone.ds_added
  /usr/sbin/keymgr zone key list ${ZONE} | while read line 
  do
    /usr/sbin/keymgr zone key ds ${ZONE} ${line##* }
  done >> ${PARENT_FILE}
fi
