#! /bin/bash

# Introduce pyenv and pyenv virtualenv in Ubuntu 16.04
# This script should be run with root privilege
# You should give your account name as the first params

# Install packages
apt-get update
apt-get install build-essential
apt-get install git
apt-get install libpng-dev
apt-get install libbz2-dev
apt-get install zlib1g-dev
apt-get install libssl-dev
apt-get install libreadline-dev
apt-get install libsqlite3-dev
apt-get install openssl

# Generate SSH key
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""

# Introduce pyenv
sudo -u $1 cd /usr/local/
git clone git://github.com/yyuu/pyenv.git ./pyenv
mkdir -p ./pyenv/versions ./pyenv/shims

# Introduce pyenv virtualenv
sudo -u $1 cd /usr/local/pyenv/plugins/
git clone git://github.com/yyuu/pyenv-virtualenv.git

# Rewrite paths
sudo -u $1 echo 'export PYENV_ROOT="/usr/local/pyenv"' | tee -a /etc/profile.d/pyenv.sh
echo 'export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"' | tee -a /etc/profile.d/pyenv.sh
# Initialize
source /etc/profile.d/pyenv.sh

echo 'Add following to /etc/sudoers...\
#Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin
Defaults    env_keep += "PATH"
Defaults    env_keep += "PYENV_ROOT"'

# Install Python 3.6.0 with pyenv
prenv install 3.6.0
pyenv virtualenv 3.6.0 'machine_learning'
