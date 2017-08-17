This project is a collection of vagrant boxes used to prototype the various modles discussed in [RSSAC028](https://www.icann.org/en/system/files/files/rssac-028-03aug17-en.pdf).  

Before starting you will need to initialise the modules directory.  do this by running the following command in the root of the repository

`git submodule update --init --recursive`

After this you can `vagrant up` from the root folder and 6 vms will be spun up.  the vm's  will be listining on local ports 5351 - > 5356.  with the scheme from RSSAC028 section 5.1 listening on port 5351, section 5.2 on 5352 and so on.  Further to this the boxes are all named `l5${i}` where i is the subsection.  so to login to the box configuered for section 5.4 you would `vagrant ssh l54`

Below is a list of dig commands used to validate various aspects of this config
__i was unable to test version 5.3 over the udp forwarded port for this you will need to login to the box__
```bash
$ dig -p5351  +norec +dnssec ns . @127.0.0.1
$ dig -p5351  +norec +dnssec ns root-servers.net. @127.0.0.1
$ dig -p5352  +norec +dnssec ns . @127.0.0.1
$ dig -p5352  +norec +dnssec ns root-servers.net. @127.0.0.1
$ dig -p5353  +norec +dnssec ns . @127.0.0.1
$ dig -p5354  +norec +dnssec ns . @127.0.0.1
$ dig -p5354  +norec +dnssec ns root-servers. @127.0.0.1
$ dig -p5355  +norec +dnssec ns . @127.0.0.1
$ for i in {a..m}; do dig -p5355  +norec +dnssec ns ${i}. @127.0.0.1 ; done
$ dig -p5356  +norec +dnssec ns . @127.0.0.1
```

## Potential frag issues

### IPv4 mtu 
```bash
$ dig -p5351 +bufsize=1480 +norec +dnssec ns . @127.0.0.1
$ dig -p5351 +bufsize=1480 +norec +dnssec ns root-servers.net. @127.0.0.1
$ dig -p5352 +bufsize=1480 +norec +dnssec ns . @127.0.0.1
$ dig -p5352 +bufsize=1480 +norec +dnssec ns root-servers.net. @127.0.0.1
$ dig -p5353 +bufsize=1480 +norec +dnssec ns . @127.0.0.1
$ dig -p5354 +bufsize=1480 +norec +dnssec ns . @127.0.0.1
$ dig -p5354 +bufsize=1480 +norec +dnssec ns root-servers. @127.0.0.1
$ dig -p5355 +bufsize=1480 +norec +dnssec ns . @127.0.0.1
$ for i in {a..m}; do dig -p5355 +bufsize=1480 +norec +dnssec ns ${i}. @127.0.0.1 ; done
$ dig -p5356 +bufsize=1480 +norec +dnssec ns . @127.0.0.1
```
### IPv6 mtu 
```bash
$ dig -p5351 +bufsize=1280 +norec +dnssec ns . @127.0.0.1
$ dig -p5351 +bufsize=1280 +norec +dnssec ns root-servers.net. @127.0.0.1
$ dig -p5352 +bufsize=1280 +norec +dnssec ns . @127.0.0.1
$ dig -p5352 +bufsize=1280 +norec +dnssec ns root-servers.net. @127.0.0.1
$ dig -p5353 +bufsize=1280 +norec +dnssec ns . @127.0.0.1
$ dig -p5354 +bufsize=1280 +norec +dnssec ns . @127.0.0.1
$ dig -p5354 +bufsize=1280 +norec +dnssec ns root-servers. @127.0.0.1
$ dig -p5355 +bufsize=1280 +norec +dnssec ns . @127.0.0.1
$ for i in {a..m}; do dig -p5355 +bufsize=1280 +norec +dnssec ns ${i}. @127.0.0.1 ; done
$ dig -p5356 +bufsize=1280 +norec +dnssec ns . @127.0.0.1
```
