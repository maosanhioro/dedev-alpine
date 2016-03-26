#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}
VAGRANT_KEY_URL=https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub

apk add wget sudo

adduser -D ${SSH_USER}
echo "${SSH_USER}:${SSH_PASSWORD:-$SSH_USER}" | chpasswd
mkdir -pm 700 $SSH_USER_HOME/.ssh
wget --no-check-certificate "${VAGRANT_KEY_URL}" -O $SSH_USER_HOME/.ssh/authorized_keys
chown -R $SSH_USER:$SSH_USER $SSH_USER_HOME/.ssh
chmod -R go-rwsx $SSH_USER_HOME/.ssh

adduser ${SSH_USER} wheel
echo "Defaults exempt_group=wheel" > /etc/sudoers
echo "%wheel ALL=NOPASSWD:ALL" >> /etc/sudoers
