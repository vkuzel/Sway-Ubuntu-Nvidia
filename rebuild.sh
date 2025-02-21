#!/bin/bash

#sway_version=1.9
#wlroots_version=0.17.4

sway_version=1.10
wlroots_version=0.18.2
wayland_version=1.23.1
wayland_protocols_version=1.35

# to resolve locally installed libraries like libinput
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

install_dependencies() {
  sudo apt install \
    glslang-tools \
    libcairo2-dev \
    libcap-dev \
    libdbus-1-dev \
    libdisplay-info-dev \
    libevdev-dev \
    libgdk-pixbuf2.0-dev \
    libinput-dev \
    libjson-c-dev \
    libliftoff-dev \
    libpam0g-dev \
    libpango1.0-dev \
    libpcre2-dev \
    libpixman-1-dev \
    libseat-dev \
    libsystemd-dev \
    libvulkan-dev \
    libwayland-dev \
    libwayland-egl1 \
    libwlroots-dev \
    libxcb-ewmh-dev \
    libxkbcommon-dev \
    meson \
    pkgconf \
    scdoc \
    tree \
    wayland-protocols
}

clone_repositories() {
  rm -rf sway

  local cacheName='cached-sway.tmp'
  if [[ -d "$cacheName" ]]; then
    cp -R "$cacheName" sway
  else
    git clone https://github.com/swaywm/sway.git
    git clone https://gitlab.freedesktop.org/wlroots/wlroots.git sway/subprojects/wlroots
    git clone https://gitlab.freedesktop.org/wayland/wayland sway/subprojects/wayland
    git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git sway/subprojects/wayland-protocols
    cp -R sway "$cacheName"
  fi
}

checkout_version() {
  pushd sway
  git checkout "$sway_version"
  popd

  pushd sway/subprojects/wlroots
  git checkout "$wlroots_version"
  popd

  pushd sway/subprojects/wayland
  git checkout "$wayland_version"
  popd

  pushd sway/subprojects/wayland-protocols
  git checkout "$wayland_protocols_version"
  popd
}

patch_repositories() {
  work_dir="$(dirname "$(realpath "$0")")"

  pushd sway/subprojects/wlroots
  git apply "$work_dir/patch/wlroots.patch"
  popd
}

build() {
  pushd sway
  meson setup build/
  ninja -C build/
  popd
}

#install_dependencies
clone_repositories
checkout_version
patch_repositories
build
