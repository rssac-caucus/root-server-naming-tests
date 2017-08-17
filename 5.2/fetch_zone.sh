#!/bin/bash
mkdir -p /var/lib/knot/
dig AXFR . @xfr.dns.icann.org |  egrep -v "NSEC|RRSIG|DNSKEY|;" > /var/lib/knot/root.zone
dig AXFR root-servers.net. @xfr.dns.icann.org |  egrep -v "NSEC|RRSIG|DNSKEY|;" > /var/lib/knot/root-servers.net.zone
