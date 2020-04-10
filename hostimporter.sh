#!/bin/bash

#before start tcpdump -n udp -vvvvv -e port 69 > /var/log/tftp
#and boot all clients

file="/var/log/tftp"

domain="domain.local"
newmacs="/tmp/newmacs"
oldmacs="/tmp/oldmacs"
diffmacs="/tmp/diffmacs"

opsirun="/tmp/opsirun.sh"

cat=`which cat`
grep=`which grep`
cut=`which cut`
sort=`which sort`
uniq=`which uniq`
comm=`which comm`



cat $file | grep "ethertype IPv4"| cut -d " "  -f 2 | sort |uniq |sort > $newmacs


cat /var/lib/opsi/config/clients/*| grep hardwareaddress | cut -d = -f 2|cut -c 2- | sort > $oldmacs



comm -23 $newmacs $oldmacs > $diffmacs

echo "" > $opsirun

while read p; do

shaffle=win`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32`

#createClient
#createClient(clientName, domain, description=null, notes=null, ipAddress=null, hardwareAddress=null)
#Parameter: clientName
#Parameter: domain
#Parameter: description
#Default: null
#Parameter: notes
#Default: null
#Parameter: ipAddress
#Default: null
#Parameter: hardwareAddress
#Default: null
#opsi-admin –d method createClient "P02034" "domain.de" "" "" "IP.Ad.dr.ess" "00-21-9B-69-F2-41"

echo "opsi-admin -d method createClient "$shaffle" "$domain '""' '""' '""' "$p"  >> $opsirun

done < $diffmacs

chmod +x $opsirun

$opsirun