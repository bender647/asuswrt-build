asuswrt-build
==============

Build wrapper for Asus AC-RT66U router firmware.

About
-----
This is a makefile that sets up the build environment necessary to build the asuswrt and asuswrt-merlin mips firmwares.

It contains the firmware source as a submodule:

[https://github.com/bender647/asuswrt-merlin](https://github.com/bender647/asuswrt-merlin)

How to Use
-----
This was tested on a multi-lib, Slackware 14.2 64-bit machine:

~~~~
git clone --recursive-submodules https://github.org/bender647/asuswrt-build.git
cd asuswrt-build
make patch
make clean
make
make install
make package
~~~~

There should be no need to alter your filesystem or environment variables in your build environment.
