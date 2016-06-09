#!/usr/bin/env python

import dns
import argparse
import logging

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


def main():
    nsset = [a.root-servers.org : { 'A', 'AAAA' 
    args = get_args()
    set_log_level(args.verbose)
    get_nsset

if __name__ == '__main__':
    main()
