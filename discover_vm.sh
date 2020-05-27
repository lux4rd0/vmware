#!/bin/sh

host=$(hostname -s)

list_of_vmids=$(vim-cmd vmsvc/getallvms | sed '1d' | awk '{if ($1 > 0) print $1}')

if [ -n "${list_of_vmids}" ]; then

echo "$list_of_vmids" | while IFS= read -r line ; do

vm_name=$(vim-cmd vmsvc/get.summary "$line" |grep hostName |awk '{print $3}' | sed 's/[""]//g' | sed 's/[,]//g')
vm_ipaddress=$(nslookup ${vm_name} 2> /dev/null |grep Address: |tail -n 1 |awk '{print $2}')
vm_cpu=$(vim-cmd vmsvc/get.summary "$line" |grep numCpu |awk '{print $3}' | sed 's/[""]//g' | sed 's/[,]//g')
vm_memory=$(vim-cmd vmsvc/get.summary "$line" |grep memorySizeMB |awk '{print $3}' | sed 's/[""]//g' | sed 's/[,]//g' |awk '{print $1/(1024)}')
vm_storage=$(vim-cmd vmsvc/device.getdevices "$line" | grep capacityInKB | awk '{print $3}' | sed 's/[,]//g' |awk '{print $1/(1024*1024)}')

echo "${host},${vm_name},${vm_ipaddress},${vm_cpu},${vm_memory},${vm_storage}"

done

fi
