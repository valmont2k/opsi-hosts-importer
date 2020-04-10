# opsi-hosts-importer


script for adding many tftp clients from server opsi in automatic mode


1) run   tcpdump -n udp -vvvvv -e port 69 > /var/log/tftp on opsi server
2) boot all clients (you must see blue window)
3) run hostimporter.sh sript on opsi server

if check log file /var/log/tftp and add all tftp cliens to opsi server

you may run this script again and again, it will add only new clients

