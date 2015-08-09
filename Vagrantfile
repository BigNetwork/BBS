# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "box-cutter/fedora22"
  config.vm.network "forwarded_port", guest: 3000, host: 3200
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \\curl -sSL https://get.rvm.io | bash -s stable
    source ~/.profile
    rvm install ruby-1.8.7-head
    cd /vagrant/
    gem update --system 1.8.25
    gem install bundler
    bundle install
    bundle exec rake db:migrate
  SHELL
end
