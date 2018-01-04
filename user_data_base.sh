#!/bin/bash
yum install git -y
git clone  https://github.com/cbauerswald/LSDSD-lab0.git
chmod 777 LSDSD-lab0/user_data.sh 
echo LSDSD-lab0/user_data.sh | bash
