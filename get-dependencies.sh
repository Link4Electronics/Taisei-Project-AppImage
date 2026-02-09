#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    sdl3     \
    cglm     \
    libzip   \
    mimalloc \
    opusfile

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

  make-aur-package cglm
# Comment this out if you need an AUR package
if [ "${DEVEL_RELEASE-}" = 1 ]; then
  make-aur-package taisei-git
else
  make-aur-package taisei
fi

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
