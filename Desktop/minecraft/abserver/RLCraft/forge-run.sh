#!/bin/sh

echo url="https://www.duckdns.org/update?domains=minecraft-svartephilip&token=77d6573d-c968-498c-813a-618905567044&ip=" | curl -k -o ~/duckdns/duck.log -K -
sudo nice -n -10 java -Xms1G -Xmx1G -XX:+UseConcMarkSweepGC -jar forge*.jar nogui
