#! /bin/bash

# Introduce pyenv and pyenv virtualenv in Ubuntu 16.04
# This script should be run with root privilege
# You should give your account name as the first params

# Install packages
echo "Installing packages ..."
apt-get update
apt-get install -y build-essential
apt-get install -y git
apt-get install -y libpng-dev
apt-get install -y libbz2-dev
apt-get install -y zlib1g-dev
apt-get install -y libssl-dev
apt-get install -y libreadline-dev
apt-get install -y libsqlite3-dev
apt-get install -y openssl

# Generate SSH key
echo "Generate SSH key ..."
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""

# Introduce pyenv
echo "Installing pyenv and virtualenv..."
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
echo "Creating virtualenv with Python 3.6.0 ..."
prenv install 3.6.0
pyenv virtualenv 3.6.0 'machine_learning'
