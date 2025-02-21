#!/bin/bash

pushd libinput
sudo ninja -C build install
popd

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

# verify version
pkg-config --modversion libinput

# uninstall
#sudo rm -rf /usr/local/lib/libinput* \
#  /usr/local/include/libinput \
#  /usr/local/bin/libinput
