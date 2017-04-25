#!/bin/bash
export PATH="/bin:/usr/bin:/sbin:/usr/sbin"
HOSTS="xxx.xxx.xxx.xxx"
COUNT=4
for myHost in $HOSTS
do
        count=$(ping -c $COUNT $myHost | grep 'bytes from' | wc -l)
        if [ $count -eq 0 ]; then
                #ping failed
                echo "Host $myHost is not available at $(date)"
                logger "Host $myHost is not available at $(date)"
                ifdown eth0 && ifup eth0
                ifdown eth1 && ifup eth1
        else
                echo "Network is working"        
                logger "Network is working and $myHost is available at $(date)"
        fi
done

