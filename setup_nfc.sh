#!/bin/sh

ULTITAG=${1}

mv /tmp/dump.mfd /root/${ULTITAG}.ultitag
sed -i "3s/.*/ULTITAG=${ULTITAG}/" nfc_loop.sh
systemctl stop griffin.nfc.service
systemctl disable griffin.nfc.service
systemctl start nfc_loop.service
systemctl enable nfc_loop.service
