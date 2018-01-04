#!/bin/bash
yum install git -y
git clone  https://github.com/cbauerswald/LSDSD-lab0.git
cd LSDSD-lab0
git stash
git pull origin master
chmod 777 user_data.sh 
./user_data.sh 
