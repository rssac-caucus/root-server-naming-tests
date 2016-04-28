#!/bin/bash

mkdir -p /var/lib/knot/
dig AXFR . @xfr.dns.icann.org |  egrep -v "NSEC|RRSIG|DNSKEY|;" | sed s/root-servers.net/root-servers/g > /var/lib/knot/root.zone
dig AXFR root-servers.net. @xfr.dns.icann.org |  egrep -v "NSEC|RRSIG|DNSKEY|;" | sed s/root-servers.net/root-servers/g > /var/lib/knot/root-servers.zone
grep -w NS /var/lib/knot/root-servers.zone >> /var/lib/knot/root.zone

