#!/bin/sh

host=$(hostname -s)
ipaddress=$(nslookup ${host} 2> /dev/null |grep Address: |tail -n 1 |awk '{print $2}')

version=$(vim-cmd hostsvc/hostsummary |grep version |cut -d'"' -f 2)
build=$(vim-cmd hostsvc/hostsummary |grep build | tail -n 1 |cut -d'"' -f 2)

memorySize=$(vim-cmd hostsvc/hostsummary |grep memorySize |awk '{print $3}' | sed 's/[,]//g' |awk '{print $1/(1024*1024*1024)}')
cpuModel=$(vim-cmd hostsvc/hostsummary |grep cpuModel |cut -d'"' -f 2)
cpuMhz=$(vim-cmd hostsvc/hostsummary |grep cpuMhz |awk '{print $3}' | sed 's/[,]//g')

vendor=$(vim-cmd hostsvc/hostsummary |grep vendor |head -n 1 |cut -d'"' -f 2)
model=$(vim-cmd hostsvc/hostsummary |grep model |cut -d'"' -f 2)

CpuCores=$(vim-cmd hostsvc/hostsummary |grep numCpuCores |awk '{print $3}' | sed 's/[,]//g')
numCpuThreads=$(vim-cmd hostsvc/hostsummary |grep numCpuThreads |awk '{print $3}' | sed 's/[,]//g')

storage=$(vim-cmd hostsvc/storage/fs_info |grep -A 1 vm-local |tail -n 1 |awk '{print $3}' | sed 's/[,]//g' |awk '{print $1/(1024*1024*1024)}')

echo "${host},${ipaddress},${vendor},${model},${version},${build},${cpuModel},${cpuMhz},${CpuCores},${numCpuThreads},${memorySize},${storage}"

