#!/bin/sh
KEXT_NAME="osx-pl2303.kext"
KEXT_BUNDLE="ch.maniswebdesign.driver.pl2303"
DEST_DIR="/private/tmp"
DEST_PATH="${DEST_DIR:?}/${KEXT_NAME:?}"

if [ -e "${DEST_PATH:?}" ]; then sudo rm -rf "${DEST_PATH:?}"; fi
cp -r "./build/Debug/${KEXT_NAME:?}" "/private/tmp"
ls -al "$DEST_PATH"
sudo chmod -R 0700 "${DEST_PATH:?}"
sudo chown -R root:wheel "${DEST_PATH:?}"
sudo kextunload -b "${KEXT_BUNDLE:?}"
if [ -f "$(which kextutil)" ]; then
	sudo kextutil -t "${DEST_PATH:?}"
else
	sudo kextload "${DEST_PATH:?}"
fi

echo ""
kextstat | grep "${KEXT_BUNDLE:?}"
