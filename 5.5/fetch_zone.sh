#!/usr/bin/env bash

mkdir -p /var/lib/knot/
dig AXFR . @xfr.dns.icann.org |  sed 4s/root-servers.net.// | egrep -v "NSEC|RRSIG|DNSKEY|root-servers.net|;" > /var/lib/knot/root.zone

declare -A A=(
  ['a']='198.41.0.4'
  ['b']='192.228.79.201'
  ['c']='192.33.4.12'
  ['d']='199.7.91.13'
  ['e']='192.203.230.10'
  ['f']='192.5.5.241'
  ['g']='192.112.36.4'
  ['h']='198.97.190.53'
  ['i']='192.36.148.17'
  ['j']='192.58.128.30'
  ['k']='193.0.14.129'
  ['l']='199.7.83.42'
  ['m']='202.12.27.33')
declare -A AAAA=(
  ['a']='2001:503:ba3e::2:30'
  ['b']='2001:500:84::b'
  ['c']='2001:500:2::c'
  ['d']='2001:500:2d::d'
  ['f']='2001:500:2f::f'
  ['h']='2001:500:1::53'
  ['i']='2001:7fe::53'
  ['j']='2001:503:c27::2:30'
  ['k']='2001:7fd::1'
  ['l']='2001:500:9f::42'
  ['m']='2001:dc3::35')

#dig AXFR root-servers.net. @xfr.dns.icann.org |  egrep -v "NSEC|RRSIG|DNSKEY|;" | sed s/root-servers.net/root-servers/g > /var/lib/knot/root-servers.zone
for LETTER in {a..m}
do
  IPV4=${A[${LETTER}]}
  IPV6=${AAAA[${LETTER}]}
  echo -e "${LETTER}.\t3600000\tIN\tSOA\troot.${LETTER}. hostmaster.${LETTER}. 1 14400 7200 1209600 3600000" > /var/lib/knot/${LETTER}.zone
  echo -e "${LETTER}.\t3600000\tIN\tNS\troot.${LETTER}." >> /var/lib/knot/${LETTER}.zone
  echo -e "${LETTER}.\t172800\tIN\tNS\troot.${LETTER}." >> /var/lib/knot/root.zone
  echo -e ".\t172800\tIN\tNS\troot.${LETTER}." >> /var/lib/knot/root.zone
  echo -e "root.${LETTER}.\t3600000\tIN\tA\t${IPV4}" >> /var/lib/knot/${LETTER}.zone
  echo -e "root.${LETTER}.\t172800\tIN\tA\t${IPV4}" >> /var/lib/knot/root.zone
  if [ ${AAAA[${LETTER}]+isset} ]
  then
    echo -e "root.${LETTER}.\t3600000\tIN\tAAAA\t${IPV6}" >> /var/lib/knot/${LETTER}.zone
    echo -e "root.${LETTER}.\t172800\tIN\tAAAA\t${IPV6}" >> /var/lib/knot/root.zone
  fi
done
