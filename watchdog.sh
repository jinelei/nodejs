#!/bin/sh

watchFile() {
    inotifywait -rmq -e modify -e create -e delete_self -e move `pwd` | while read file
    do
        restart
    done
}

restart() {
    PID=`ps -ef |grep 'node index.js' |grep -v grep |awk '{print $2}'`
    if [ "$PID" != "" ]; then
        echo "\033[41;32mrestart server\033[0m"
        kill -9 $PID
        node index.js 2>&1 &
    else
        echo "\033[41;32mstart   server\033[0m"
        node index.js 2>&1 &
    fi
}

restart
watchFile
