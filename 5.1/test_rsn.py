#!/usr/bin/env python

import argparse
import logging
import dns
from dns.resolver import Resolver

def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('-z', '--zone', default='.' )
    parser.add_argument('-s', '--server', default='127.0.0.1' )
    parser.add_argument('-b', '--bufsize', type=int, default=4096 )
    parser.add_argument('-v', '--verbose', action='count' )
    return parser.parse_args()

def set_log_level(args_level):
    log_level = logging.ERROR
    if args_level == 1:
        log_level = logging.WARN
    elif args_level == 2:
        log_level = logging.INFO
    elif args_level > 2:
        log_level = logging.DEBUG
    logging.basicConfig(level=log_level)

def get_nsset(zone, server, bufsize):
    nsset                = { 'RRSIG' : False }
    resolver             = Resolver()
    resolver.nameservers = [server]
    resolver.use_edns(edns=True, ednsflags=dns.flags.DO, payload=bufsize)
    response = resolver.query(zone, 'NS', dns.rdataclass.IN, True).response
    for answer in response.answer:
        for ans in answer.items:
            if ans.rdtype == dns.rdatatype.NS:
                nsset[ans.to_text()] = { 'A' : None, 'AAAA' : None, 'RRSIG' : None }
            elif ans.rdtype == dns.rdatatype.RRSIG:
                nsset['RRSIG'] = True
    return nsset

def main():
    query_count = 0
    total_size  = 0
    nsset       = dict()
    args = get_args()
    set_log_level(args.verbose)
    nsset = get_nsset(args.zone, args.server, args.bufsize)

if __name__ == '__main__':
    main()
