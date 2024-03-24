# ddclient-ubnt

This repo builds [ddclient](https://github.com/ddclient/ddclient) for Ubiquiti EdgeOS `v2.0.9-hotfix.7` and higher
although it may work with older versions as well they have not been tested.

## Build

You will need to have the build toolchain installed on your build host:

- autoconf
- autogen
- make
- perl

You will also need to have `bash` installed since the build script is written for that shell specifically.

```bash
prompt> ./build.sh
```

During the build process the `ddclient` repo will be cloned in a build directory, the package will be configured
for installation on EdgeOS.

## Installation

Open a console to your EdgeOS router and add the `/config/scripts/firstboot.d` directory:

```bash
ubnt@EdgeRouter-X-5-Port:~$ sudo mkdir -p /config/scripts/firstboot.d
```

Copy the `ddclient-ubnt.sh` script to the `firstboot.d` directory and set execute permissions:

```bash
ubnt@EdgeRouter-X-5-Port:~$ sudo curl -sSL -o /config/scripts/firstboot.d/ddclient-ubnt.sh https://raw.githubusercontent.com/markeissler/edgeos-extras/master/ddclient-ubnt/config/scripts/firstboot.d/ddclient-ubnt.sh
ubnt@EdgeRouter-X-5-Port:~$ sudo chmod 0755 /config/scripts/firstboot.d/ddclient-ubnt.sh
```

The above steps will ensure that the updated `ddclient-ubnt` package is re-installed after firmware updates.

Next, run the script to install for the first time:

```bash
ubnt@EdgeRouter-X-5-Port:~$ sudo /config/scripts/firstboot.d/ddclient-ubnt.sh
```

That's all there is to it. Continue with configuration.

## Configuration

The EdgeOS Web GUI for ddns does not support service providers and protocols that were not present in the last
release from Ubiqiti (ddclient-3.8.3). Therefore, to configure any of the additional providers you will need to
use the CLI.

Setup via CLI (DNSMadeEasy example):

```bash
ubnt@EdgeRouter-X-5-Port# set service dns dynamic interface eth0 service custom-dme
ubnt@EdgeRouter-X-5-Port# set service dns dynamic interface eth0 service custom-dme host-name <ID>
ubnt@EdgeRouter-X-5-Port# set service dns dynamic interface eth0 service custom-dme login <USER>
ubnt@EdgeRouter-X-5-Port# set service dns dynamic interface eth0 service custom-dme protocol dnsmadeeasy
ubnt@EdgeRouter-X-5-Port# commit; save
```

If your router is sitting behind an internal firewall you may want to configure a URL that will return your
external IP address.

```bash
ubnt@EdgeRouter-X-5-Port# set service dns dynamic interface eth0 web https://ipcheck.dynu.com/
ubnt@EdgeRouter-X-5-Port# commit; save
```

>NOTE: The URL you specify must support `https://` protocol as it appears that EdgeOS will strip out any provided
>scheme and set it to `https://`. This is the case for `http://checkip.dyndns.org/` which doesn't support `https`
>at the time of writing.

### Verify

The following commands will not work unless you have exited the configure state.

```bash
ubnt@EdgeRouter-X-5-Port# exit
```

Check status (DNSMadeEasy example):

```bash
ubnt@EdgeRouter-X-5-Port:~$ show dns dynamic status
interface    : eth0
ip address   : <ASSIGNED_IP_ADDR>
host-name    : <ID>
last update  : Sun Mar 24 23:49:05 2024
update-status: good
```

Force an update:

```bash
ubnt@EdgeRouter-X-5-Port:~$ update dns dynamic interface eth0
```


---
markeissler
