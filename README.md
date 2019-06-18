# LAMP Stack Vagrant provision

A simple provision for setting up a LAMP stack virtual environment with Vagrant. This includes:
* Ubuntu 16.04 (Xenial) 64 bit (L)
* Apache web server (A)
* MariaDB/MySQL (M)
* PHP 7.0 (P)

## Requirements

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 

## Setup

Simply run the following:

```console
vagrant up
```

Once everything is setup, the project will be accessible in the browser at:
* http://localhost:1080
* http://192.168.55.10

To access the command line in the box:

```console
vagrant ssh
```