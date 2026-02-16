#!/bin/sh

set -eu

ARCH=$(uname -m)
if [ "${DEVEL_RELEASE-}" = 1 ]; then
  VERSION=$(pacman -Q taisei-git | awk '{print $2; exit}') # example command to get version of application here
else
  VERSION=$(pacman -Q taisei | awk '{print $2; exit}')
fi
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256/appsorg.taisei_project.Taisei
export DESKTOP=/usr/share/applications/org.taisei_project.Taisei.desktop
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1

# Deploy dependencies
quick-sharun /usr/bin/taisei

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
