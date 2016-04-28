#!/usr/bin/env python

import dns
import argparse
import logging

def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('-z', '--zone')
    parser.add_argument('-m', '--master')
    parser.add_argument('-v', '--verbose', action='count')
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

def strip_dnssec(zone):


    return zone
def main():
    args = get_args()
    set_log_level(args.verbose)
    zone = strip_dnssec(dns.zone.from_xfr(dns.query.xfr(master, zone)))


if __name__ == '__main__':
    main()
