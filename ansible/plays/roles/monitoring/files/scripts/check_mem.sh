#!/bin/bash

# $2 is warning threshold
# $4 is critical threshold
# $1 and $3 are -w and -c respectively

if [ "$1" = "-w" ] && [ "$2" -gt "0" ] && [ "$3" = "-c" ] && [ "$4" -gt "0" ]; then

memTotal_b=`free -b |grep Mem |awk '{print $2}'`
memFree_b=`free -b |grep Mem |awk '{print $4}'`
memBuffer_b=`free -b |grep Mem |awk '{print $6}'`
memCache_b=`free -b |grep Mem |awk '{print $7}'`

memTotal_m=`free -m |grep Mem |awk '{print $2}'`
memFree_m=`free -m |grep Mem |awk '{print $4}'`
memBuffer_m=`free -m |grep Mem |awk '{print $6}'`
memCache_m=`free -m |grep Mem |awk '{print $7}'`

memUsed_b=$(($memTotal_b-$memFree_b-$memBuffer_b-$memCache_b))
memUsed_m=$(($memTotal_m-$memFree_m-$memBuffer_m-$memCache_m))

memUsedPrc=$((($memUsed_b*100)/$memTotal_b))


if [ "$memUsedPrc" -ge "$4" ]; then
echo "Memory: CRITICAL Total: $memTotal_m MB - Used: $memUsed_m MB - $memUsedPrc% used!|Total=$memTotal_b;;;Used=$memUsed_b;;;Cache=$memCache_b;;;Buffer=$memBuffer_b;;;"
$(exit 2)
elif [ "$memUsedPrc" -ge "$2" ]; then
echo "Memory: WARNING Total: $memTotal_m MB - Used: $memUsed_m MB - $memUsedPrc% used!|Total=$memTotal_b;;;Used=$memUsed_b;;;Cache=$memCache_b;;;Buffer=$memBuffer_b;;;"
$(exit 1)
else
echo "Memory: OK Total: $memTotal_m MB - Used: $memUsed_m MB - $memUsedPrc% used|Total=$memTotal_b;;;Used=$memUsed_b;;;Cache=$memCache_b;;Buffer=$memBuffer_b;;;"
$(exit 0)
fi

else
echo "check_mem v1.1"
echo ""
echo "Usage:"
echo "check_mem.sh -w -c "
echo ""
echo "warnlevel and critlevel is percentage value without %"
echo ""
exit
fi
