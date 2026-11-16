Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.define "prestashop-server" do |node|
    node.vm.hostname = "prestashop-server"
    node.vm.network "private_network", ip: "192.168.56.10"

    # Redirigir el puerto 80 al 8080 
    node.vm.network "forwarded_port", guest: 80, host: 8080

    node.vm.provider "virtualbox" do |vb|
      vb.name = "prestashop-server"
      vb.memory = "2048" # Mínimo de 2 GB exigido para PrestaShop y la pila LAMP
      vb.cpus = 2
    end

    # provisionamiento
    node.vm.provision "shell", path: "scripts/provision.sh"
  end
end