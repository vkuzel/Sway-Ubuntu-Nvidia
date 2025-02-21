#!/bin/bash

work_dir="$(dirname "$(realpath "$0")")"

pushd /usr/local/bin
sudo ln -s "$work_dir/sway-start.sh" sway
sudo ln -s "$work_dir/sway/build/swaymsg/swaymsg" swaymsg
sudo ln -s "$work_dir/sway/build/swaynag/swaynag" swaynag
sudo ln -s "$work_dir/sway/build/swaybar/swaybar" swaybar
popd
