# ddclient-ubnt

This repo builds [ddclient](https://github.com/ddclient/ddclient) for Ubiquiti EdgeOS `v2.0.9-hotfix.7` and higher
although it may work with older versions as well they have not been tested.

# Build

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

# Installation

Open a console to your EdgeOS router and add the `/config/data/firstboot.d` directory:

```bash
ubnt@EdgeRouter-X-5-Port:~$ sudo mkdir -p /config/data/firstboot.d
```

Copy the `ddclient-ubnt.sh` script to the `firstboot.d` directory and set execute permissions:

```bash
ubnt@EdgeRouter-X-5-Port:~$ sudo curl -sSL -o /config/data/firstboot.d/ddclient-ubnt.sh https://raw.githubusercontent.com/markeissler/edgeos-extras/master/ddclient-ubnt/config/data/firstboot.d/ddclient-ubnt.sh
ubnt@EdgeRouter-X-5-Port:~$ sudo chmod 0755 /config/data/firstboot.d/ddclient-ubnt.sh
```

The above steps will ensure that the updated `ddclient-ubnt` package is re-installed after firmware updates.

Next, run the script to install for the first time:

```bash
ubnt@EdgeRouter-X-5-Port:~$ sudo /config/data/firstboot.d/ddclient-ubnt.sh
```

That's all there is to it. Continue with configuration.

---
markeissler
