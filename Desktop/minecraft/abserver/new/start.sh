#!/bin/sh

ip=$(hostname -i)
echo url="https://www.duckdns.org/update?domains=minecraft-svartephilip&token=77d6573d-c968-498c-813a-618905567044&ip=$ip" | curl -k -o ~/duckdns/duck.log -K -
~/scripts/push-to-git.sh
sudo nice -n -10 java -Xms1G -Xmx1G -XX:+UseConcMarkSweepGC -jar spigot*.jar
