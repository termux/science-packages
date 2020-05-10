# Termux science packages

[![Powered by JFrog Bintray](./.github/static/powered-by-bintray.png)](https://bintray.com)

[![Last build status](https://github.com/termux/science-packages/workflows/Packages/badge.svg)](https://github.com/termux/science-packages/actions)

This repository contains packages that are more or less related to science, i.e. they might not be of interest for the average termux user.

# Contributing

Information on how to open pull requests to help keep the packages here up to date can be read in [CONTRIBUTING.md](CONTRIBUTING.md)

# Building a package
To build a package, first clone science-packages,
```sh
git clone https://github.com/termux/science-packages
```
and then update the termux-packages submodule.
```sh
cd science-packages
git submodule init
git submodule update
```
You can then build a package with the following:
```sh
./build-package.sh name-of-package
```
Note that this currently only works outside of the docker container.
To build from the docker container, science-packages has to be a subfolder of termux-packages, and a science package can then be built with
```sh
./build-package.sh science-packages/packages/package-to-build
```
The termux-package submodule is not needed for this.

# Subscribing to the repository
To install packages from this repository, you need to subscribe to it with:
```sh
pkg install science-repo
```
