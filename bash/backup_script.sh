#!/bin/sh
#
# Richard's backup script
#
# o	Check to see /media/WD_Combo/backup/ is there and writable
# o	rsync the /home/richard directory

if [ $# -ne 1 ] ; then
	echo "Usage: $0 source_directory"
	exit 1
fi

backupPath=/net
sourcePath=$1

if [ ! -d ${sourcePath} ] ; then
	echo "The source path (${sourcePath}) does not exist"
	exit 1
fi

if [ ! -d ${backupPath}${sourcePath} ] ; then
	mkdir -p ${backupPath}${sourcePath}
	if [ $? -ne 0 ] ; then
		echo "Failed to create ${backupPath}${sourcePath}"
		exit 1
	fi
fi

if [ ! -w ${backupPath}${sourcePath} ] ; then
	echo "The backup directory (${backupPath}${sourcePath}) is not writable"
	exit 1
fi

destinationDir=`dirname ${backupPath}${sourcePath}`
rsync -a -r --exclude=.VirtualBox --exclude=/tmp ${sourcePath} ${destinationDir}
rm -f ${backupPath}${sourcePath}/backup > /dev/null 2>&1
dpkg --get-selections > ${backupPath}${sourcePath}/install_packages.txt

