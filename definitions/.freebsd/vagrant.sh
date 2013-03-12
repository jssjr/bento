#!/usr/local/bin/bash -x

# disable X11 because vagrants are (usually) headless
cat >> /etc/make.conf << EOT
WITHOUT_X11="YES"
EOT

# Install virtualbox OSE guest additions
PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/ pkg_add -r virtualbox-ose-additions

# undo our customizations
sed -i '' -e '/^REFUSE /d' /etc/portsnap.conf
sed -i '' -e '/^WITHOUT_X11/d' /etc/make.conf

# enable the services
cat >> /etc/rc.conf << EOT
vboxguest_enable="YES"
vboxservice_enable="YES"
EOT

# install vagrant insecure ssh key
mkdir /home/vagrant/.ssh
fetch -o /home/vagrant/.ssh/authorized_keys \
    'http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

#Set Bash as default shell for vagrant user
pw usermod vagrant -s /bin/bash
