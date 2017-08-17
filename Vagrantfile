Vagrant.configure('2') do |config|
  (1..6).each do |i|
    config.vm.define "l5#{i}" do |node|
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
      node.vm.box = 'ubuntu/trusty64'
      node.vm.host_name = "l5#{i}.root-servers.net"

      h_port = 5350 + i
      node.vm.network 'forwarded_port', guest: 53, host: h_port, protocol: 'tcp'
      node.vm.network 'forwarded_port', guest: 53, host: h_port, protocol: 'udp' 

      node.vm.provision 'shell', inline: 'wget https://apt.puppetlabs.com/puppet5-release-trusty.deb'
      node.vm.provision 'shell', inline: 'dpkg -i puppet5-release-trusty.deb'
      node.vm.provision 'shell', inline: 'apt-get update'
      node.vm.provision 'shell', inline: 'apt-get -y upgrade'
      node.vm.provision 'shell', inline: 'apt-get install -y puppet-agent python-dnspython'
      unless i == 1 
        node.vm.provision "shell", inline: "/vagrant/5.#{i}/fetch_zone.sh"
      end

      node.vm.provision :puppet do |puppet|
        puppet.environment = 'production'
        puppet.environment_path = 'puppet/environments'
        puppet.hiera_config_path = 'puppet/hiera.yaml'
        puppet.module_path = 'modules'
      end
    end
  end
end
