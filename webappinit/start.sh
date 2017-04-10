#!/bin/bash

ROOTDIR="/webapp" 
if [ -f $ROOTDIR/index.php ] ;
then
        echo "Found webapp in $ROOTDIR." 
else
        echo "Seems it is the first time that the webapp is installed." 

        cp -Rf ${ROOTDIR}init${ROOTDIR}/* $ROOTDIR
        cp -Rf ${ROOTDIR}init${ROOTDIR}/.* $ROOTDIR
        chmod 707 $ROOTDIR/app/tmp
        chmod 707 $ROOTDIR/app/tmp/cache
        chmod 707 $ROOTDIR/app/tmp/cache/models
        chmod 707 $ROOTDIR/app/tmp/cache/persistent
        chmod 707 $ROOTDIR/app/tmp/img
        chmod 707 $ROOTDIR/app/config
        chmod 707 $ROOTDIR/app/webroot/img/cms
        chown -Rf www-data.www-data $ROORDIR
fi

/usr/sbin/apache2ctl -D FOREGROUND &

tail -f /var/log/apache2/*log
