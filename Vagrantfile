Vagrant.configure("2") do |config|

  # Configuración de vbox base
  config.vm.box = "debian/bullseye64"

  # Configuración del servidor DNS
  config.vm.define "dns-server" do |dns|
  dns.vm.hostname = "debian"
    
  # Configuración de red privada
  dns.vm.network "private_network", ip: "192.168.57.10"
    
  # Configuración de recursos
  dns.vm.provider "virtualbox" do |vb|
  vb.name = "dns-server-nicolas"
    vb.memory = "1024"
    vb.cpus = 1
  end

  # Hago el prosionamiento con el script bootstrap.sh
  config.vm.provision "shell", path: "bootstrap.sh"

  end
end
