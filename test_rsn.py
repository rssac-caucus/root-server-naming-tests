#!/usr/bin/env python

import argparse
import logging
from prettytable import PrettyTable
from dns.flags import DO
from dns.resolver import query, Resolver

class RsnServer(object):
    def __init__(self, server):
        self.logger           = logging.getLogger('RsnServer')
        self.server           = server
        self.ipv4             = query(self.server, 'A')[0].address
        self.ipv6             = query(self.server, 'AAAA')[0].address
        self.resolver         = Resolver()

        self.logger.debug('initiate: {} ({}/{})'.format(self.server, self.ipv4, self.ipv6))
        self.update_sizes()

    def _update_size(self, server, dnssec):
        '''get the response size'''
        self.resolver.nameservers = [ server ]
        if dnssec:
            self.resolver.use_edns(0,DO,4096)
        else:
            self.resolver.use_edns(0,0,4096)
        answer = self.resolver.query('.', 'NS')
        size   = len(answer.response.to_wire())
        self.logger.debug('Size:{}:DNSSEC({}):{}'.format(server, dnssec, size))
        return size

    def update_sizes(self):
        self.size_ipv4        = self._update_size(self.ipv4, False)
        self.size_ipv6        = self._update_size(self.ipv6, False)
        self.size_ipv4_dnssec = self._update_size(self.ipv4, True)
        self.size_ipv6_dnssec = self._update_size(self.ipv6, True)


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('-z', '--zone', default='.' )
    parser.add_argument('-s', '--server', default='127.0.0.1' )
    parser.add_argument('-b', '--bufsize', type=int, default=4096 )
    parser.add_argument('-v', '--verbose', action='count' )
    parser.add_argument('servers_file')
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

def print_report(servers):
    table = PrettyTable(
            ['Server', 'IPv4', 'IPv6', 'IPv4 DNSSEC', 'IPv6 DNSSEC'])
    for server in servers:
        table.add_row([server.server, server.size_ipv4, servers.size_ipv6,
            server.size_ipv4_dnssec, server.size_ipv6_dnssec])
    print table.get_string(sortby='Server')

def main():
    args = get_args()
    set_log_level(args.verbose)
    servers = []
    with open(args.servers_file) as f:
        for line in f.read().splitlines():
            logging.debug('loading {}'.format(line))
            servers.append(RsnServer(line))
    print_report(servers)

if __name__ == '__main__':
    main()
