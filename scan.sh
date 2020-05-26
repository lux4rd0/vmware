#!/bin/sh

echo "host,name,cpu,memory,storage" > /mnt/attic/scripts/discovery/out.csv

for i in `cat /mnt/attic/scripts/discovery/esxi_hosts.txt`; do

ssh -i /root/.ssh/id_esxi root@$i "sh -s" < /mnt/attic/scripts/discovery/discover_vms.sh >> /mnt/attic/scripts/discovery/out.csv

done
