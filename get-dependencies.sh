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

# Comment this out if you need an AUR package


REPO="https://github.com/taisei-project/taisei"
if [ "${DEVEL_RELEASE-}" = 1 ]; then
  make-aur-package cglm
  make-aur-package taisei-git
#  echo "Making nightly build of Taisei-Project..."
#  echo "---------------------------------------------------------------"
#  VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
#  git clone --recursive --depth 1 "$REPO" ./taisei
else
make-aur-package cglm
make-aur-package taisei
#  echo "Making stable build of Taisei-Project..."
#  echo "---------------------------------------------------------------"
#  VERSION="$(git ls-remote --tags --sort="v:refname" "$REPO" | tail -n1 | sed 's/.*\///; s/\^{}//; s/^v//')"
#  git clone --branch v"$VERSION" --single-branch --recursive --depth 1 "$REPO" ./taisei
fi
#  echo "$VERSION" > ~/version

#  cd ./taisei
#  meson setup --prefix /usr --libexecdir lib --sbindir bin --buildtype plain --wrap-mode nodownload -D b_lto=true -D b_pie=true build
#  meson compile -C build
#  meson install -C build

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
