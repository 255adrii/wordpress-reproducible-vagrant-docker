Vagrant.configure("2") do |config|
  config.vm.box      = "ubuntu/jammy64"
  config.vm.hostname = "webfusion"

  # WordPress queda accesible en http://localhost:8080 (solo desde tu equipo)
  config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
    vb.name   = "webfusion-vm"
    vb.memory = 2048
    vb.cpus   = 2
  end

  # /vagrant (carpeta del proyecto) se comparte por defecto
  config.vm.provision "shell", path: "provision.sh"
end
