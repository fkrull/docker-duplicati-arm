# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/debian-9"

  config.vm.provision :docker do |docker|
    docker.build_image '/vagrant', args: '-t duplicati-arm:beta'
    docker.build_image '/vagrant', args: '-t duplicati-arm:canary --build-arg CHANNEL=canary'
  end
end
