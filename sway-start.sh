#!/bin/bash

work_dir="$(dirname "$(realpath "$0")")"

# Xwayland compatibility
export XWAYLAND_NO_GLAMOR=1

"$work_dir/sway/build/sway/sway" --unsupported-gpu
