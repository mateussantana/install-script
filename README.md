


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
- [ ] [Google chrome](https://www.google.pt/intl/pt-PT/chrome/)
- [ ] [Steam](https://store.steampowered.com/)
- [ ] [Origin](https://www.origin.com/bra/pt-br/store/download)
- [ ] [Epic Games](https://www.epicgames.com/store/pt-BR/)
- [ ] [Ubisoft](https://ubisoftconnect.com/pt-BR/)
- [ ] [Discord](https://discord.com/download)
- [ ] [Whatsapp](https://www.whatsapp.com/download)
- [ ] [Nvidia Geforce Experience](https://www.nvidia.com/pt-br/geforce/geforce-experience/)

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
- [ ] Nvidia GTX 970

### Softwares
- UI (can be installed via Ubuntu Software app)
	- [ ] [Google Chrome](https://www.google.pt/intl/pt-PT/chrome/)
	- [ ] PhpStorm
	- [ ] [Ray](https://spatie.be/profile/purchases)
	- [ ] DataGrip
	- [ ] VS Code
	- [ ] Discord
	- [ ] Postman
	- [ ] RDM (redis ui)
	- [ ] Terminator
	- [ ] Spotify
	- [ ] Steam (?)
	- [ ] Libre Office
	- [ ] Gimp
	- [ ] Menu Editor
	- [ ] Ajustes (tweak)
- CLI
	- [ ] Git
	- [ ] [Docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script) & [Docker Compose](https://docs.docker.com/compose/install/)
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
	- [ ] [Ngrok](https://ngrok.com/download)
		```bash
		snap install ngrok
		ngrok authtoken <token>
		```
	- [ ] [ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) & [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh) & [Temas e fontes](https://blog.rocketseat.com.br/terminal-com-oh-my-zsh-spaceship-dracula-e-mais/)
		```bash
		# zsh
		sudo apt install zsh
		chsh -s $(which zsh)
		# ohmyzsh
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		```

### Configs
- [ ] [Gnome extensions](https://extensions.gnome.org/)
	- [ ] [Vitals System Monitor](https://extensions.gnome.org/extension/1460/vitals/)
		```bash
		# https://github.com/corecoding/Vitals#installation
		sudo apt install gir1.2-gtop-2.0 lm-sensors
		```
	- [ ] [SerMon Service Monitor](https://extensions.gnome.org/extension/1804/sermon/)
	- [ ] [Sound Input & Output Device Chooser](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
	- [ ] [Time++](https://extensions.gnome.org/extension/1238/time/)
- [ ] SSH keys & configs (backup)
- [ ] Docker aliases (composer, php, node)
- [ ] Aliases (em construção: meu repositório github)


# #Observações
- Bios Storage mode: UEFI only
- Mobo drivers: [Aorus B450 Pro Wi-fi](https://www.gigabyte.com/br/Motherboard/B450-AORUS-PRO-WIFI-rev-1x/support#support-dl)
- Ordem de instalação: Windows ---> Linux
- RAID 0: Não consegui fazer o ubuntu enxergar o array raid. Windows funcionou normalmente)
	- Vídeo de referência: <https://www.youtube.com/watch?v=IUNtbe9Az9o>;
	- [Prints com testes nos SSDs](/docs/PRINTS_SSD_TESTS.md).
- Limitações das portas SATA3:
	- Ao utilizar a porta M2A (slot de cima) as portas ASATA3-0 e ASATA3-1 (as duas de frente) são desabilitadas;
	- Ao utilizar a porta M2B (slot de baixo) as portas SATA3-2 e SATA3-3 (laterais superiores) são desabilitadas.
	[![SATA3 limitações](/docs/images/limitacao-sata-ports.png)](https://www.gigabyte.com/br/Motherboard/B450-AORUS-PRO-WIFI-rev-1x/support#support-manual)
