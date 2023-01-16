<p align="center">
    <a href="https://github.com/fbnmtz/torctl/issues"><img src="https://img.shields.io/github/issues/fbnmtz/torctl.svg"></a>
    <a href="https://img.shields.io/github/forks/fbnmtz/torctl.svg"><img src="https://img.shields.io/github/forks/fbnmtz/torctl.svg"></a>
    <a href="https://github.com/fbnmtz/torctl/stargazers"><img src="https://img.shields.io/github/stars/fbnmtz/torctl.svg"></a>
    <a href="https://github.com/fbnmtz/torctl/releases"><img src="https://img.shields.io/github/downloads/fbnmtz/torctl/total.svg"></a>
    <a href="https://repology.org/metapackage/torctl/versions"><img src="https://repology.org/badge/tiny-repos/torctl.svg"></a>
    <a href="https://github.com/fbnmtz/torctl/graphs/contributors">
      <img alt="GitHub Contributors" src="https://img.shields.io/github/contributors/fbnmtz/torctl" />
    </a>
</p>

<p align="center">
    <img width="250px" src="./docs/logo-torctl.png" align="center" />
</p>

# torctl

Simple scritp to setup a tor-server via docker and route all traffic of your system to it.

## requirements:

* [docker](https://docs.docker.com/engine/install/ubuntu/)
* curl
* jq
* grep
* [xSHELL](https://github.com/fbnmtz/xSHELL)

## Install:

use this script to install torctl on your machine

```bash
curl -sSL https://raw.githubusercontent.com/fbnmtz/torctl/master/install | bash
```

## Usage:

```
torctl --help                                                                    

usage:
  torctl [-s] [-t] [-S] [-r] [-h] [-v]

-> Available Options:
   -s,  --start         start Tor Server and redirect traffic throug it
   -t,  --stop          stop Tor Server and restore firewall rules
   -S,  --status        show current status
   -r,  --restart       restart Tor Server
   -h,  --help          show this help
   -v,  --version       print version and exit

v0.0.2-rc91 - writen by @fbnmtz 2022

```

## TODO:

* [ ] Port firewall rules to MacOs
