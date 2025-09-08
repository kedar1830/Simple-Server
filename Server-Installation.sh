#!/bin/sh

termux-setup-storage

apt upgrade && apt upgrade -y

pkg install python nodejs -y

touch server.js

# Append the provided Node.js code to server.js
cat << 'EOF' >> server.js
const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
    const clientIp = req.socket.remoteAddress;
    console.log(`IP: ${clientIp}: ${req.url}`);

    let filePath = '.' + req.url;
    if (filePath === './') {
        filePath = './index.html';
    }

    const extname = String(path.extname(filePath)).toLowerCase();
    const contentType = {
        '.html': 'text/html',
        '.js': 'text/javascript',
        '.css': 'text/css',
        '.json': 'application/json',
        '.png': 'image/png',
        '.jpg': 'image/jpg',
        '.gif': 'image/gif',
        '.svg': 'image/svg+xml',
        '.ico': 'image/x-icon',
    }[extname] || 'application/octet-stream';

    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code == 'ENOENT') {
                res.writeHead(404);
                res.end('404 Not Found');
            } else {
                res.writeHead(500);
                res.end('500 Internal Server Error');
            }
        } else {
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content, 'utf-8');
        }
    });
});


const port = process.env.PORT || 3000;
const host = '0.0.0.0';
server.listen(port, host, () => {
    console.log(`Server running on port ${port}`);
    console.log(`http://${host}:${port}/`);
});
EOF

touch index.html about.html contact.html profile.html style.css

cat << 'EOF' >> index.html
<!DOCTYPE html>
<html>
  <head>
    <title>My page</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    
    <hr>
    <div class="head">
      <div class="home"><a href="home.html">Home</a></div>
      <hr class="vr">
      <div class="about"><a href="about.html">About</a></div>
      <hr class="vr">
      <div class="contact_us"><a href="contact.html">Contact us</a></div>
      <hr class="vr">
      <div class="profile"><a href="profile.html">Profile</a></div>
    </div>
    <hr>
        
  </body>
</html>
EOF

cat << 'EOF' >> about.html
<!DOCTYPE html>
<html>
  <head>
    <title>About page</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    
    <hr>
    <div class="head">
      <div class="home"><a href="home.html">Home</a></div>
      <hr class="vr">
      <div class="about"><a href="about.html">About</a></div>
      <hr class="vr">
      <div class="contact_us"><a href="contact.html">Contact us</a></div>
      <hr class="vr">
      <div class="profile"><a href="profile.html">Profile</a></div>
    </div>
    <hr>
        
  </body>
</html>
EOF

cat << 'EOF' >> home.html
<!DOCTYPE html>
<html>
  <head>
    <title>Home page</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    
    <hr>
    <div class="head">
      <div class="home"><a href="home.html">Home</a></div>
      <hr class="vr">
      <div class="about"><a href="about.html">About</a></div>
      <hr class="vr">
      <div class="contact_us"><a href="contact.html">Contact us</a></div>
      <hr class="vr">
      <div class="profile"><a href="profile.html">Profile</a></div>
    </div>
    <hr>
        
  </body>
</html>
EOF

cat << 'EOF' >> contact.html
<!DOCTYPE html>
<html>
  <head>
    <title>Contact-Us page</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    
    <hr>
    <div class="head">
      <div class="home"><a href="home.html">Home</a></div>
      <hr class="vr">
      <div class="about"><a href="about.html">About</a></div>
      <hr class="vr">
      <div class="contact_us"><a href="contact.html">Contact us</a></div>
      <hr class="vr">
      <div class="profile"><a href="profile.html">Profile</a></div>
    </div>
    <hr>
        
  </body>
</html>
EOF

cat << 'EOF' >> profile.html
<!DOCTYPE html>
<html>
  <head>
    <title>Profile page</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    
    <hr>
    <div class="head">
      <div class="home"><a href="home.html">Home</a></div>
      <hr class="vr">
      <div class="about"><a href="about.html">About</a></div>
      <hr class="vr">
      <div class="contact_us"><a href="contact.html">Contact us</a></div>
      <hr class="vr">
      <div class="profile"><a href="profile.html">Profile</a></div>
    </div>
    <hr>
        
  </body>
</html>
EOF

cat << 'EOF' >> style.css
.head{
 width: 25.6cm;
 background-color: grey;
 height: 1cm;
 display: flex;
}

.home{
  width: 6.4cm;
  text-align: center;
  position: relative;
  left: 4.5px;
  bottom: -7px;
}

.about{
  width: 6.4cm;
  text-align: center;
  position: relative;
  left: 4.5px;
  bottom: -7px;
}

.contact_us{
  width: 6.4cm;
  text-align: center;
  position: relative;
  left: 4.5px;
  bottom: -7px;
}

.profile{
  width: 6.4cm;
  text-align: center;
  position: relative;
  left: 4.5px;
  bottom: -7px;
}


.vr{
 height: 1.5cm;
 position: relative;
 bottom: 19px;
}
EOF

touch start
chmod +x start

cat << 'EOF' >> start
node server.js

./start