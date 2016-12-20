#!/bin/sh

mkdir /etc/nfc
cp libnfc.conf /etc/nfc/
cp nfc_loop.service /etc/systemd/system
/root/nfc-mfultralight r /tmp/dump.mfd
