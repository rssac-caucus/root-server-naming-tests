# rsn

This project is a collection of vagrant boxes used to prototype the various modles discussed in [RSSAC028](https://www.icann.org/en/system/files/files/rssac-028-03aug17-en.pdf).  

Before starting you will need to initialise the modules directory.  do this by running the following command in the root of the repository

`git submodule update --init --recursive`

To test a specific scheme simpley change into the directory you want to test and run `vagrant up`.  once the instance is up you will be able to test the server on tcp port 5353.  


```bash
dig -p5353 +norec ns . @127.0.0.1
dig -p5353 +norec +bufsize=1480 ns . @127.0.0.1
dig -p5353 +norec +dnssec ns . @127.0.0.1
dig -p5353 +norec +dnssec +bufsize=1480 ns . @127.0.0.1
```

For some reason udp port forwarding is not working for me so add `+tcp` to the commands above or `vagrant ssh` into the server and run localy
