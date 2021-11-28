


# #Windows
> Windows 10  ---> SSD Nvme de 1 TB

### Backups
- [ ] Documentos
- [ ] Downloads (?)

### Drivers
- [ ] Nvdia GTX 970
- [ ] Teclado Corsair
- [ ] Mouse Logitech G600 (pendrive)

### Softwares
- [ ] Steam
- [ ] Origin
- [ ] Epic Games
- [ ] Ubisoft
- [ ] Discord
- [ ] Google chrome
- [ ] Nvidia Geforce Experience

### Configs
- [ ] Atualizações windows
- [ ] Verificar as entradas de inicialização com o sistema
- [ ] Executar limpeza após atualizações windows update


# #Linux
> Ubuntu 21.10 ---> SSD Sata de 480 GB

## 1. Pré formatação

### Backups
- [ ] Laravel projects: databases (docker)
- [ ] Laravel projects: arquivos *.env*
- [ ] SSH keys & configs
- [ ] Credenciais aws/azure
- [ ] Abas do chrome (?)

## 2. Pós formatação

### Drivers
- [x] Nvidia GTX 970

### Softwares
- UI
	- [x] [Google Chrome](https://www.google.pt/intl/pt-PT/chrome/)
	- [x] PhpStorm
	- [x] [Ray](https://spatie.be/profile/purchases)
	- [x] DataGrip
	- [x] VS Code
	- [x] Discord
	- [x] Postman
	- [x] RDM (redis ui)
	- [x] Terminator
	- [x] Spotify
	- [x] Steam (?)
	- [x] Libre Office
	- [x] Gimp
	- [x] Ajustes (tweak)
- CLI
	- [x] Git
	- [x] [Docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script) & [Docker Compose](https://docs.docker.com/compose/install/)
		```bash
		# docker
		curl -fsSL https://get.docker.com -o get-docker.sh
		sudo sh get-docker.sh
		sudo groupadd docker
		sudo usermod -aG docker $USER
		# docker-compose
		sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		sudo chmod +x /usr/local/bin/docker-compose
		```
	- [x] [Ngrok](https://ngrok.com/download)
		```bash
		snap install ngrok
		ngrok authtoken <token>
		```
	- [x] [ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) & [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh) & [Temas e fontes](https://blog.rocketseat.com.br/terminal-com-oh-my-zsh-spaceship-dracula-e-mais/)
		```bash
		# zsh
		sudo apt install zsh
		chsh -s $(which zsh)
		# ohmyzsh
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		```

### Configs
- [x] [Gnome extensions](https://extensions.gnome.org/)
	- [x] [Vitals System Monitor](https://extensions.gnome.org/extension/1460/vitals/)
		```bash
		# https://github.com/corecoding/Vitals#installation
		sudo apt install gir1.2-gtop-2.0 lm-sensors
		```
	- [x] [SerMon Service Monitor](https://extensions.gnome.org/extension/1804/sermon/)
	- [x] [Sound Input & Output Device Chooser](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
	- [x] [Time++](https://extensions.gnome.org/extension/1238/time/)
- [x] SSH keys & configs (backup)
- [ ] Docker aliases (composer, php, node)
- [ ] Aliases (em construção: meu repositório github)


# #Hardware & Bios
- SSDs sata e nvme
- Configuração de RAID 0
- UEFI vs Legacy (especificar config da bios)
- Ordem e forma de instalação do Windows e Linux
- Mobo drivers: [Aorus B450 Pro Wi-fi](https://www.gigabyte.com/br/Motherboard/B450-AORUS-PRO-WIFI-rev-1x/support#support-dl)
	- Baixar: Driver > SATA RAID > AMD RAID Preinstall Driver
	- Descompactar e executar **DPInst64** como administrador
	- Em gerenciador de dispositivos: identificar o dispositivo *Controlador RAID* sem driver e instalar manualmente apontando para a pasta x64 (procurar subpastas)
