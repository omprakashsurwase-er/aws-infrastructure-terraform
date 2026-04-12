cat > user_data.sh << 'EOF'
#!/bin/bash
set -e

# Update system
yum update -y
yum install -y nodejs npm git

# Create app directory
mkdir -p /opt/app
cd /opt/app

# Create simple Node.js application
cat > app.js << 'APPEOF'
const http = require('http');
const os = require('os');

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  const uptime = process.uptime();
  const response = {
    message: 'Hello from AWS ASG!',
    timestamp: new Date().toISOString(),
    hostname: os.hostname(),
    server_uptime: uptime,
    instance_id: os.hostname().split('-').pop()
  };

  if (req.url === '/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'healthy' }));
  } else {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(response, null, 2));
  }
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
APPEOF

# Create package.json
cat > package.json << 'PKGEOF'
{
  "name": "asg-app",
  "version": "1.0.0",
  "description": "Simple Node.js app for ASG",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "keywords": ["asg", "nodejs"],
  "author": "",
  "license": "MIT"
}
PKGEOF

# Install dependencies
npm install

# Start application
nohup node app.js > app.log 2>&1 &
echo "Application started"
EOF
chmod +x user_data.sh