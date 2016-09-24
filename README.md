# Docker + Vagrant = Dockrant

Full environment for PHP developer based on **Vagrant** & **Docker** instructions

## Package contains

**Vagrantfile**

OS: Ubuntu 14.04 (Trusty)  
Host: gurukami.local, sandbox.local (HTTP/HTTPS)  
Static IP: 10.0.0.2  
NFS mounted folder ./share

**Dokerfile** (compose)

Containers

- redis:3
- percona:5
- gurukami/php:5.6 https://github.com/Gurukami/docker-hub-php
- gurukami/php:7.0 (main) https://github.com/Gurukami/docker-hub-php
- gurukami/nginx https://github.com/Gurukami/docker-hub-nginx
- mongo:3

## Usage

Install **VirtualBox** https://www.virtualbox.org/wiki/Downloads  
Install **Docker Toolbox** https://www.docker.com/products/docker-toolbox  
Install **Vagrant** https://www.vagrantup.com/downloads.html

```
cd /path/to/dockrant
vagrant up --provider virtualbox
```

After installation open http://sandbox.local  
Also you can login to guest machine via ssh

```
vagrant ssh
```

## Docker machine

You can added current guest machine as docker-machine, use instructions below

```
cd /path/to/dockrant
docker-machine create --driver generic --generic-ip-address=10.0.0.2 --generic-ssh-key ./ssh/id_rsa --generic-ssh-user vagrant sandbox
```

After installation restart vagrant, because all containers was stopped

```
vagrant reload
```

## PHP-CLI

Run CLI script inside guest machine (**10.0.0.2**)

```
php56 -v
php70 -v
```

If you want use interactive console with -a parameter use **php*tty** instead **php***

```
php56tty -a
php70tty -a
```

## PHPStorm + Xdebug + PHPUnit

This environment full compatible with **PHPStorm** IDE, just use **Remote Interpreter** with path to **/usr/bin/php56** or **/usr/bin/php70** inside guest machine via ssh or vagrant connect

And as bonus you can install **Docker Integration** plugin https://plugins.jetbrains.com/plugin/7724 and manage containers inside IDE with logs, bash, exec, attach and etc (see instructions to create docker-machine above)

## License

The MIT license  
Copyright (c) 2016 Gurukami, http://gurukami.com/
