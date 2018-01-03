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
echo "res.send('Cecelia A. <br> AMI ID: ami-7c052e19 <br> <code> #!/bin/bash <br> yum install git -y <br> git clone  https://github.com/cbauerswald/LSDSD-lab0.git <br> chmod 777 LSDSD-lab0/user_data.sh <br> echo LSDSD-lab0/user_data.sh | bash </code>') })" >> index.js
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
npm i -g pm2
pm2 start index.js --name "LSDSD lab0"
pm2 startup | bash
pm2 save
