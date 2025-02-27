#!/bin/bash

work_dir="$(dirname "$(realpath "$0")")"

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

# Xwayland compatibility
export XWAYLAND_NO_GLAMOR=1

# Disable atomic mode-setting for wlroots
# Avoid "Failed to pick cursor plane format" error
export WLR_DRM_NO_ATOMIC=1

"$work_dir/sway/build/sway/sway" --unsupported-gpu
