#!/bin/sh

echo "host,ipaddress,vendor,model,version,build,cpuModel,cpuMhz,CpuCores,numCpuThreads,memorySize,storage" > /mnt/attic/scripts/discovery/out_esxi.csv

for i in `cat /mnt/attic/scripts/discovery/esxi_hosts.txt`; do

ssh -i /root/.ssh/id_esxi root@$i "sh -s" < /mnt/attic/scripts/discovery/discover_esxi.sh >> /mnt/attic/scripts/discovery/out_esxi.csv

done
