#!/bin/bash

# Vulkan doesn't output to external monitors
export WLR_RENDERER=auto
#export WLR_RENDERER=gles2
#export WLR_RENDERER=pixman

# Doesn't help
export WLR_DRM_NO_ATOMIC=1

# Makes cursor visible on external monitor
export WLR_NO_HARDWARE_CURSORS=1

# OpenGL Variables
export GBM_BACKEND=nvidia-drm
export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
# Xwayland compatibility
export XWAYLAND_NO_GLAMOR=1

$HOME/projects/sway-build/sway/build/sway/sway --unsupported-gpu -D noscanout
