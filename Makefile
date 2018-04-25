# Ken's master makefile to build asuswrt-merlin firmware for RT-AC66 router
# We use a Slackware-14.2 stock machine to build.  No extra dependencies.
# MIPS (RT-N66U, RT-AC66U):
export PATH := $(PATH):$(PWD)/asuswrt-merlin/tools/brcm/hndtools-mipsel-linux/bin:$(PWD)/asuswrt-merlin/tools/brcm/hndtools-mipsel-uclibc/bin:$(PWD)/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin

# With clean git tree,
#   make patch
#   make clean
#   make
#   make install (or make package)

all: rt-ac66u

rt-ac66u:
	$(MAKE) -C asuswrt-merlin/release/src-rt-6.x rt-ac66u

clean:
	$(MAKE) -C asuswrt-merlin/release/src-rt-6.x clean

patch:
	sed -i -e "s|/projects/hnd/tools/linux/|$(PWD)/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/|" asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/aclocal-1.11
	sed -i -e "s/AM_C_PROTOTYPES/AC_C_PROTOTYPES/" -e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" asuswrt-merlin/release/src/router/libxml2/configure.in
	cd asuswrt-merlin/release/src/router/libxml2 && autoconf

unpatch:
	cd asuswrt-merlin/release/src/router/libxml2 && git checkout configure.in
	cd asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin && git checkout aclocal-1.11

install:
	cp -a asuswrt-merlin/release/src-rt-6.x/image/RT-AC66U_*.trx .

package: install
	cp asuswrt-merlin/README-merlin.txt .
	cp asuswrt-merlin/Changelog.txt .
	sha256sum $(shell ls -v1 RT-AC66U_*.trx|tail -1) > sha256sum.sha256
	zip $(shell basename $(shell ls -v1 RT-AC66U_*.trx|tail -1) .trx).zip $(shell ls -v1 RT-AC66U_*.trx|tail -1) README-merlin.txt Changelog.txt sha256sum.sha256
