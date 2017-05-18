#!/bin/bash
#set default values
c=10
outfile=dispatcherRestarter.log

#read arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        -c)
	    cTemp="$2"
            if [ $cTemp > 0 ]; then
                c=$cTemp
            fi
	    ;;
        -of)
            outfile="$2"
            ;;
         *)
            printf "ungueliges Argument\n"
            exit 1
        esac
        shift
        shift
done

#start the service and repeat c times after exiting
echo "$(date) start" >> $outfile
cd /var/www/Dispatcher
# nohup php5 -f subscriber.php &
for i in `seq 1 $c`;
do
	nohup php5 -f index.php
	echo "$(date) restart $i" >> $outfile
done
exit 0
