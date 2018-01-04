#!/bin/bash
curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
sudo yum -y install nodejs

#create node app
echo "***create node app***"
mkdir home/ec2-user/server
cd home/ec2-user/server
echo "const express = require('express')" > index.js
echo "const app = express()" >> index.js
echo "app.get('/', (req, res) => {" >> index.js
echo "res.send('Cecelia A. <br> AMI ID: ami-6be9c20e <br> User Data <br> <code> #!/bin/bash <br> yum install git -y <br> git clone  https://github.com/cbauerswald/LSDSD-lab0.git <br> cd LSDSD-lab0 <br> git stash <br> git pull origin master <br> chmod 777 user_data.sh <br> ./user_data.sh <br> </code> <br> <br> more at https://github.com/cbauerswald/LSDSD-lab0/blob/master/user_data_base.sh') })" >> index.js
echo "app.listen(3000, () => console.log('Server running on port 3000'))" >> index.js
echo '{
  "name": "test",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}' > package.json
npm install express --save-dev

#set up nginx so that node can redirect from port 3000 to port 80
echo "*** set up nginx ***"
yum install nginx -y
../../../etc/init.d/nginx start
sed -i '50i             proxy_pass http://127.0.0.1:3000;' ../../../etc/nginx/nginx.conf 
service nginx restart

#use pm2 to keep node server running in the background
echo "*** install pm2 to keep server running ***"
npm i -g pm2 -y
echo "*** PM2 INSTALLED ***"
pm2 start index.js --name "LSDSDlab0"
echo "*** PM2 STARTED ***"
pm2 startup | bash
echo "*** PM2 START-UP-ED ***"
pm2 save
echo "*** PM2 SAVED ***"
