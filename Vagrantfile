# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT

sudo apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get -y update
sudo apt-get -y install postgresql-9.3 postgresql-contrib
sudo apt-get -y install libpq-dev
sudo apt-get -y install tmux
sudo apt-get -y install python-dev python-pip

sudo pip install virtualenvwrapper
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get -y install nodejs
sudo apt-get -y install npm
npm install -g coffee-script

cd /home/vagrant/
rm /home/vagrant/.config

echo "export APP_DB_USER=vagrant" >> .config
echo "export APP_DB_PASSWORD=vagrant" >> .config
echo "export APP_DATABASE=vagrant_goonjam" >> .config
echo "source /usr/local/bin/virtualenvwrapper.sh" >> .config

echo "source /home/vagrant/.config" >> /home/vagrant/.bashrc
source /home/vagrant/.config

su postgres -c "createdb '$APP_DATABASE'"
echo "CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASSWORD';" | sudo -u postgres psql
echo "GRANT ALL PRIVILEGES ON DATABASE $APP_DATABASE to $APP_DB_USER;" | sudo -u postgres psql

sudo service postgresql restart

sudo pip install virtualenvwrapper

SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
    config.vm.network "forwarded_port", guest: 9090, host: 9090
    config.vm.network "forwarded_port", guest: 8000, host: 8000
    config.vm.synced_folder ".", "/home/vagrant/goonjam"
  config.vm.provision "shell", inline: $script
end
