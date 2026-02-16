#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    boost    \
    glad     \
    glslang  \
    sdl3     \
    libzip   \
    mimalloc \
    opusfile \
    shaderc

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package cglm
REPO="https://github.com/taisei-project/taisei"
if [ "${DEVEL_RELEASE-}" = 1 ]; then
  make-aur-package taisei-git
else
make-aur-package taisei

fi
