#!/bin/bash

libinput_version=1.26.2

install_dependencies() {
  sudo apt install -y \
    meson \
    ninja-build \
    libmtdev-dev \
    libevdev-dev \
    libudev-dev \
    libwacom-dev \
    libgtk-3-dev \
    libgtk-4-dev \
    check
}

clone_repositories() {
  rm -rf libinput

  local cacheName='cache.tmp/libinput'
  if [[ -d "$cacheName" ]]; then
    cp -R "$cacheName" libinput
  else
    git clone https://gitlab.freedesktop.org/libinput/libinput.git libinput
    mkdir -p "$cacheName"
    cp -R libinput "$cacheName"
  fi
}

checkout_version() {
  pushd libinput
  git checkout "$libinput_version"
  popd
}

build() {
  pushd libinput
  meson setup build/
  ninja -C build/
  popd
}

install_dependencies
clone_repositories
checkout_version
build
