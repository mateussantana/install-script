

# #Windows
> Windows 10  ---> SSD Nvme de 1 TB

### Backups
- [x] Documentos
- [x] Downloads (?)

### Drivers
- [x] Nvdia GTX 970
- [x] Teclado Corsair
- [x] Mouse Logitech G600 (pendrive)

### Softwares
- [x] Steam
- [x] Origin
- [x] Epic Games
- [x] Ubisoft
- [x] Discord
- [x] Google chrome
- [x] Nvidia Geforce Experience

### Configs
- [x] Atualizações windows
- [x] Verificar as entradas de inicialização com o sistema
- [x] Executar limpeza após atualizações windows update


# #Linux
> Ubuntu 21.10 ---> SSD Sata de 480 GB
> 2x SSD Sata de 240 GB em RAID 0 (?)

## 1. Pré formatação

### Backups
- [x] Laravel projects: databases (docker)
- [x] Laravel projects: arquivos *.env*
- [x] SSH keys & configs
- [x] Credenciais aws/azure
- [x] Abas do chrome (?)

## 2. Pós formatação

### Drivers
- [ ] Nvidia GTX 970

### Softwares
- UI
	- [ ] Google Chrome
	- [ ] PhpStorm
	- [ ] Ray
	- [ ] DataGrip
	- [ ] VS Code
	- [ ] Discord
	- [ ] Postman
	- [ ] RDM (redis ui)
	- [ ] Terminator
	- [ ] Spotify
	- [ ] Steam
	- [ ] Libre Office
	- [ ] Gimp
	- [ ] Ajustes (tweak)
- CLI
	- [ ] Git
	- [ ] Docker
	- [ ] Docker Compose
	- [ ] Ngrok
	- [ ] OMZ Shell [(OMZ + Spaceship + Dracula theme)](https://blog.rocketseat.com.br/terminal-com-oh-my-zsh-spaceship-dracula-e-mais/)

### Configs
- [ ] Gnome extensions
	- [ ] Resource Monitor
	- [ ] Sound Input & Output Device Chooser
	- [ ] Time++
	- [ ] NetSpeed (?)
- [ ] SSH keys & configs (pendrive)
- [ ] Docker aliases (composer, php, node)
- [ ] Aliases


# #Hardware & Bios
- SSDs sata e nvme
- Configuração de RAID 0
- UEFI vs Legacy (especificar config da bios)
- Ordem e forma de instalação do Windows e Linux
- Mobo drivers: [Aorus B450 Pro Wi-fi](https://www.gigabyte.com/br/Motherboard/B450-AORUS-PRO-WIFI-rev-1x/support#support-dl)
	- Baixar: Driver > SATA RAID > AMD RAID Preinstall Driver
	- Descompactar e executar **DPInst64** como administrador
	- Em gerenciador de dispositivos: identificar o dispositivo *Controlador RAID* sem driver e instalar manualmente apontando para a pasta x64 (procurar subpastas)
