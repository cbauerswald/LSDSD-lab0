#!/bin/bash

echo "in the script"
curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
sudo yum -y install nodejs
echo "***node installation complete***"
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
echo "***user script completed***"
npm i -g pm2
pm2 start index.js --name "LSDSD lab0"
pm2 startup
pm2 save
