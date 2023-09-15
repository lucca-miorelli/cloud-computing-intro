#!/bin/bash
# Use this for your user data (script from top to bottom)
# Update packages and install Apache HTTP server
sudo apt update
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Hello World from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html >/dev/null