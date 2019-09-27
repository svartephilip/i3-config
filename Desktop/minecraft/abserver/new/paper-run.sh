#!/bin/sh

ip=$(hostname -i)
echo url="https://www.duckdns.org/update?domains=minecraft-svartephilip&token=77d6573d-c968-498c-813a-618905567044&ip=$ip" | curl -k -o ~/duckdns/duck.log -K -
VERSION=${1:-1.14}
~/scripts/push-to-git.sh
sudo rm paperclip.jar
sudo wget https://papermc.io/ci/job/Paper-$VERSION/lastSuccessfulBuild/artifact/paperclip.jar
sudo nice -n -10 java -jar paper*.jar
