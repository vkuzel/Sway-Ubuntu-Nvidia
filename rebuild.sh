#!/bin/bash

#sway_version=1.9
#wlroots_version=0.17.4

sway_version=1.10
wlroots_version=0.18.2

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

  git clone https://github.com/swaywm/sway.git
  git clone https://gitlab.freedesktop.org/wlroots/wlroots.git sway/subprojects/wlroots
}

checkout_version() {
  pushd sway
  git checkout "$sway_version"
  popd

  pushd sway/subprojects/wlroots
  git checkout "$wlroots_version"
  popd
}

patch_repositories() {
  patch sway/subprojects/wlroots/render/gles2/pass.c nvidia.patch
}

build() {
  pushd sway
  meson build/
  ninja -C build/
  popd
}

install_dependencies
clone_repositories
checkout_version
patch_repositories
build
