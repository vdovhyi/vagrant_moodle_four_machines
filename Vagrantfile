# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"

  #DB Server
  config.vm.define "db_server" do |db_server|
      db_server.vm.provision :shell, :path => "scenario_db.sh"
      db_server.vm.network "private_network", ip: "192.168.56.21"
      #config.vm.network "forwarded_port", guest: 3306, host: 3308
  end

  #Web server 1
  config.vm.define "web_server1" do |web_server1|
      web_server1.vm.hostname = "webserver1"
      web_server1.vm.network "private_network", ip: "192.168.56.22"
      web_server1.vm.provision :shell, :path => "scenario_web1.sh"
  end
  
  #Web server 2
  config.vm.define "web_server2" do |web_server2|
      web_server2.vm.hostname = "webserver2"
      web_server2.vm.network "private_network", ip: "192.168.56.23"
      web_server2.vm.provision :shell, :path => "scenario_web2.sh"
  end

  #Haproxy
  config.vm.define "haproxy" do |haproxy|
      haproxy.vm.hostname = "haproxy"
      haproxy.vm.network "forwarded_port", guest: 80, host: 8080
      haproxy.vm.network "private_network", ip: "192.168.56.24"
      haproxy.vm.provision :shell, :path => "haproxy.sh"
      
      
  end

  
  #config.vm.provision "shell", path: "scenario.sh"
  
end
