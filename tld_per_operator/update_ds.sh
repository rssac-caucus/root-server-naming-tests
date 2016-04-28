#!/bin/bash
PARENT_FILE=/var/lib/knot/root.zone
FAIL=0
set -x
cd /var/lib/knot/kasp
for ZONE in {a..m}
do
  /usr/sbin/keymgr zone key list ${ZONE} &>/dev/null
  if [ $? -eq 0 ]
  then
    /usr/sbin/keymgr zone key list ${ZONE} | while read line 
    do
      /usr/sbin/keymgr zone key ds ${ZONE} ${line##* }
    done >> ${PARENT_FILE}
  else
    FAIL=1
  fi
done
if [ $FAIL -eq 0 ]
then
  touch /var/lib/knot/root.zone.ds_added
fi
