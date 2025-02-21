#!/bin/bash

work_dir="$(dirname "$(realpath "$0")")"

pushd sway/subprojects/wlroots
git diff > "$work_dir/patch/wlroots.patch"
popd
