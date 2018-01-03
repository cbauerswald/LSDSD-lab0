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
echo "res.send('Cecelia A. AMI ID: ami-7c052e19 user script') })" >> index.js
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
yum install nginx -y
../../../etc/init.d/nginx start
sed -i '50i             proxy_pass http://127.0.0.1:3000;' ../../../etc/nginx/nginx.conf 
sudo service nginx restart
#node index.js

#use pm2 to keep node server running in the background
npm i -g pm2
pm2 start index.js --name "LSDSD lab0"
pm2 startup | bash
pm2 save
