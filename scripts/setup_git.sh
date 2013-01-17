#!/bin/sh

export http_proxy="http://www-proxy.us.oracle.com:80"
export https_proxy=$http_proxy
export no_proxy="localhost, 127.0.0.1"

echo Setting up Git global configuration.
git config --global user.name  "Rajesh Raheja"
git config --global user.email "rajesh.raheja@gmail.com"
git config --global http.proxy  $http_proxy
git config --global https.proxy $https_proxy
git config --global credential.helper 'cache --timeout=3600'
git config --global --list

echo Configuring SSH access via ~/.ssh/corkscrew
echo 'Host !*.us.oracle.com !*.local !127.0.0.1 !localhost' > ~/.ssh/config
echo '  ProxyCommand ~/bin/corkscrew www-proxy.us.oracle.com 80 %h %p' >> ~/.ssh/config

echo Environment setup complete. Testing github ssh access...
ssh -T git@github.com
