#!/bin/bash
if [ "$(id -u)" != "0" ]; then 
	echo "必须用sudo或者root用户"
else
	if [ "$#" -ne "0" ]; then 
		for i in "$@" 
		do
			echo $i
			`pkill -kill -t $i`
		done
	else
		url='/var/log/killpts.log'
		userlog=`w -ih`
		ip=`w -ih|awk '{print $3}'`
		echo "==============================" >> $url
		date >> $url 
		echo userlog >>$url
		#`w -ih|grep -v 'w -ih'|awk '{print $2}'|xargs -i pkill -kill -t {}`
		`w -ih|grep -v $ip|awk '{print $2}'|xargs -i echo {}`
	fi
fi
exit 0
