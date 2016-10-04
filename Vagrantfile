Vagrant.require_version ">= 1.8.6"

required_plugins = %w(vagrant-hostsupdater)
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "gurukami.local"

  config.ssh.insert_key = false

  config.hostsupdater.aliases = [
    "sandbox.local"
  ]

  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid

  config.vm.network :private_network, ip: "10.0.0.2"
  config.vm.network :forwarded_port, guest: 22, host: 2202, id: "ssh"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.name = "Gurukami (Dockrant)"
    vb.memory = 1024
    vb.cpus = 2
  end

  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  config.vm.provision "shell", inline: 'mkdir /vagrant', run: "once"
  config.vm.provision "shell", inline: 'echo "nameserver 8.8.8.8" >> /etc/resolv.conf', run: "always"
  config.vm.provision "shell", path: './vagrant/build/php/init.sh', run: "once"
  config.vm.provision "shell", path: './vagrant/build/docker/docker-compose.sh', run: "once"

  config.vm.provision :docker
  config.vm.provision "shell", path: './vagrant/build/docker/init.sh', run: "always"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./share", "/share", nfs: true, nfs_udp: false
end
