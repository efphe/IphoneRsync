#!/bin/bash
IPHIP=192.168.0.2
SSHPORT=22 # XXX ToDo: rsync, ssh port arg
BKPDIR=~/.iphone/
MEDIAIDIR=${BKPDIR}media
ADDRBOOK=${BKPDIR}AddressBook

if [ ! -d $BKPDIR ]; then mkdir $BKPDIR; fi
if [ ! -d $MEDIAIDIR ]; then mkdir $MEDIAIDIR; fi
if [ ! -d $ADDRBOOK ]; then mkdir $ADDRBOOK; fi

# to have a `strong` sync, add --delete
RSYNCMD="rsync -av"

syncPhotos() {
  $RSYNCMD root@$IPHIP:/private/var/mobile/Media/DCIM/100APPLE ${MEDIAIDIR}
}
syncSms() {
  $RSYNCMD root@$IPHIP:/private/var/mobile/Library/SMS/sms.db ${BKPDIR}/sms.db
}
syncContacts() {
  $RSYNCMD root@$IPHIP:/private/var/mobile/Library/AddressBook/ ${ADDRBOOK}/
  $RSYNCMD root@$IPHIP:/var/root/Library/AddressBook/AddressBook.sqlitedb ${ADDRBOOK}/RootAddressBook.sqlitedb
}

syncPhotos
syncSms
syncContacts
