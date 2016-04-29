#!/bin/bash


mkdir -p /var/lib/knot/
dig AXFR . @xfr.dns.icann.org |  egrep -v "NSEC|RRSIG|DNSKEY|;" | sed s/root-servers.net/root-servers/g > /var/lib/knot/root.zone
