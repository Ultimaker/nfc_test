#!/bin/sh

ULTITAG="<fill in tag number here>"
SAVEFILE="/root/nfc_loop.csv"
DUMPFILE="/tmp/dump.mfd"

LED="/sys/class/leds/opinicus:orange:d1"
echo "0" | tee "/sys/class/leds/opinicus:orange:d2/brightness"

while true; do
	echo "none" | tee ${LED}/trigger
	sleep 1
	echo "timer" | tee ${LED}/trigger
	echo "50" | tee ${LED}/delay_o*
	rm ${DUMPFILE}
	/root/nfc-mfultralight r ${DUMPFILE} --with-uid ${ULTITAG}
	cmp /root/${ULTITAG}.ultitag ${DUMPFILE}
	result=$?
 	if [ ${result} -eq 0 ]; then
		echo "default-on" | tee ${LED}/trigger
	elif [ ${result} -eq 2 ]; then
		echo "timer" | tee ${LED}/trigger
		echo "100" | tee ${LED}/delay_off
		echo "1000" | tee ${LED}/delay_on
	else
		echo "timer" | tee ${LED}/trigger
		echo "500" | tee ${LED}/delay_o*
	fi
	echo "`date`, ${result}" >> ${SAVEFILE}
	sleep 3
done
echo "none" | tee ${LED}/trigger
sleep 2
