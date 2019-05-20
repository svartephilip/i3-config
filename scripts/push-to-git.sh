#!/bin/sh

date=$(date +'%d/%m/%Y')

cd /home/oskar/
eval "$(ssh-agent -s)"
ssh-add /home/oskar/.ssh/github
git commit -a -m "Automatic commit at: ${date}"
git push -u origin master
