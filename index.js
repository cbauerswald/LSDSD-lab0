const express = require('express')
const app = express()
app.get('/', (req, res) => {
	res.send('Cecelia A. AMI ID: ami-7c052e19 <code> #!/bin/bash <br> yum install git -y <br> git clone  https://github.com/cbauerswald/LSDSD-lab0.git <br> chmod 777 LSDSD-lab0/user_data.sh <br> echo LSDSD-lab0/user_data.sh | bash </code>') 
})
app.listen(3000, () => console.log('Server running on port 3000'))

