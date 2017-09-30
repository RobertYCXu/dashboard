# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network :private_network, ip: '192.168.123.128'
  config.vm.network "forwarded_port", guest: 80, host: 4571

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo echo "America/Toronto" > /etc/timezone
    sudo apt-get install git-core unzip jq -y
    sudo apt-get install libxslt-dev libxml2-dev -y # for nokogiri gem
    sudo apt-get install libgmp3-dev -y # for json gem
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password Roberto980302'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password Roberto980302'
    sudo apt-get install mysql-server mysql-client libmysqlclient-dev -y # for mysql gem
    sudo sed -i 's/127.0.0.1/192.168.123.128/g' /etc/mysql/my.cnf
    sudo service mysql restart
    mysql --user="root" --password="Roberto980302" --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Roberto980302';"


    # Install NodeJS (for assets precompiling)
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install -y nodejs

    # Install our PGP key and add HTTPS support for APT
    sudo apt-get install -y dirmngr gnupg
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
		sudo apt-get install -y apt-transport-https ca-certificates

     # Add our APT repository
    sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
    sudo apt-get update

    # Install Passenger + Nginx
    sudo apt-get install -y nginx-extras passenger


    # Set up vhost and hostname
    echo '127.0.0.1 dashboard' >> /etc/hosts # for prompt
    sudo hostname dashboard

    sudo chown -R vagrant:vagrant /home/vagrant
  SHELL

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    curl -sSL https://get.rvm.io | bash -s stable
    rvm requirements
    rvm install 2.4.0
    rvm use 2.4.0 --default

    sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc

    cd /vagrant


    gem install bundler
    bundle install
    gem install capistrano -v=3.4.0 # For deploying stuff

  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    sudo service nginx restart
    sudo passenger-config validate-install --auto
  SHELL
end
