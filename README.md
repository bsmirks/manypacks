# Manypacks

- [Manypacks](#manypacks)
  - [Quick start](#quick-start)
    - [Installing on Mac](#installing-on-mac)
    - [Pulling and running containers](#pulling-and-running-containers)
  - [Limitations](#limitations)
  - [Software](#software)
    - [dpkg-deb](#dpkg-deb)
    - [FPM](#fpm)
    - [Chocolatey](#chocolatey)
  - [Tags](#tags)
  - [Contributing](#contributing)

This repository hosts code, builds, and deploys a container that comes with software necessary for creating system packages.

Specifically, the container contains the following:

- [FPM](https://github.com/jordansissel/fpm) - used to build packages such as rpms, debs, OSX packages, etc
- [rpmbuild](https://linux.die.net/man/8/rpmbuild) - use to build rpm packages (used by FPM for it, too)
- [dpkg-deb](https://manpages.ubuntu.com/manpages/trusty/man1/dpkg-deb.1.html) - used to create deb packages
- [choco](https://docs.chocolatey.org/en-us/create/create-packages) - used to create choco/nupkg packages

## Quick start

This section describes how to install [Podman](https://podman.io/) and pull container images.

### Installing on Mac

The instructions in this section assume [Brew](https://brew.sh/) is your package manager.

1. Install Podman - `brew install podman`
2. Initialize a Podman `machine`, a qemu VM which runs Podman locally - `podman machine init`
3. Start the `machine` that was downloaded and/or started in the last step - `podman machine start`

Linux (w/ numerous distros) and Windows install instructions can be found [here](https://podman.io/getting-started/installation)

### Pulling and running containers

Images can be pulled using the `podman pull` command. For example, the following command pulls `manypacks` from one of the Docker repositories:

```bash
podman pull bsmirks/manypacks
```

After pulling a container, you can list it and some basic info like the container ID with:

```bash
podman image ls
```

Start a shell inside of the container with:

```bash
podman run -it <container_id> /bin/bash
```

## Limitations

`Manypacks` utilizes FPM, dpkg-deb, and choco to allow for creating a few different kinds of packages. Along those lines, this section serves to list what the container can and can't do.

Can:
  - Create rpms for `yum` and `zypper` based operating systems
  - Create debs for `apt` based operating systems
  - Create `.nupkg` packages for `choco` based operationg systems (Windows)
  - Create OSX packages for MacOS

Can't:
  - Sign your packages (this is being explored)

## Software

This section provides helpful links and information for the software included in the container.

### dpkg-deb

`dpkg-deb` is a Debian package archive (.deb) manipulation tool. It is included in the container in order to create debs for `apt` based systems.

- [Manual](http://manpages.ubuntu.com/manpages/trusty/man1/dpkg-deb.1.html)
- [How to make a deb package (good example)](https://www.internalpointers.com/post/build-binary-deb-package-practical-guide)
- [In-depth New Debian Maintainer Guide](https://www.debian.org/doc/manuals/maint-guide/)

### FPM

`fpm` makes it easy and quick to build packages such as rpms, debs, OSX packages, etc.

- [FPM tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-fpm-to-easily-create-packages-in-multiple-formats) on DigitalOcean
- [RPM maintainer guide](https://rpm-packaging-guide.github.io/)

### Chocolatey

`choco` is a package manager for Windows systems and includes tooling for creating `.nupkg` packages that you can install on Windows systems.

- [Official package creation docs](https://docs.chocolatey.org/en-us/create/create-packages)
- [Blog post on creating choco packages](https://adamtheautomator.com/create-chocolatey-package/)
 <!-- - [How to create a Chocolatey package with a simply .exe]() -->

 ## Tags

There are a few different tags available providing a couple of different options to assist in making the images as minimalistic as possible for different use cases. All of these run on Debian 10.

- `manypacks:latest` provides all of the tools [listed](#manypacks) above
- `manypacks:dev` provides all of the [listed](#manypacks) software, but is pushed during PRs
- `manypacks:choco` provides only `choco` if just making choco/nupkg's is your goal
- `manypacks:no-choco` provides everything except for `choco` if you just want to create packages for Linux

## Contributing

Contributing synopsis:

- Make a fork of this repo or create a feature branch off of the `main` branch
- Make your proposed changes in your fork/feature branch
- Submit a PR to this repository, comparing your fork to the upstream or your feature branch to `main`
- When a PR is submitted, a Looper job is executed that builds a `manypacks` image and pushes it to the `:dev` tag for validation purposes
- Once a PR is merged, the image will build another `manypacks` image and push it to the `:latest` tag