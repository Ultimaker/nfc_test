#!/bin/sh

ULTITAG="<fill in tag number here>"
SAVEFILE="/root/nfc_loop.csv"
DUMPFILE="/tmp/dump.mfd"

while true; do
	echo "M142 r0 g0 b255 w0" > /dev/ttyS1
	sleep 10
	echo "M142 r0 g0 b0 w255" > /dev/ttyS1
	sleep 1
	rm ${DUMPFILE}
	/root/nfc-mfultralight r ${DUMPFILE} --with-uid ${ULTITAG}
	cmp /root/${ULTITAG}.ultitag ${DUMPFILE}
	result=$?
 	if [ ${result} -eq 0 ]; then
		echo "M142 r0 g255 b0 w0" > /dev/ttyS1
	elif [ ${result} -eq 2 ]; then
		echo "M142 r255 g0 b0 w0" > /dev/ttyS1
	else
		echo "M142 r255 g64 b0 w0" > /dev/ttyS1
	fi
	echo "`date`, ${result}" >> ${SAVEFILE}
	sleep 3
done
echo "M142 r0 g0 b0 w0" > /dev/ttyS1
sleep 2
