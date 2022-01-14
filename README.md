# My Installation Script

This is a shell script to automate the installation of most packages and softwares used by me to develop in a Linux environment. Feel free to clone or fork this repository and adapt to your needs!


## 🚧 Disclaimer

Tested **only** on a fresh installation of **[Ubuntu](https://ubuntu.com/download/desktop)**. More specifically on Ubuntu 20.04 LTS and Ubuntu 21.10.


## 💿 Installation

You can just run this single command on a shell (needs `curl`):
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mateussantana/install-script/master/install.sh)"
```

*or...*

Cloning this repository (needs `git`) and running ``install.sh``:
```bash
git clone https://github.com/mateussantana/install-script.git
cd install-script/ && ./install.sh
rm -rf ../install-script
```


## 📝 List of applications to be installed

The following changes and applications will be installed:

- Some system dependencies like `curl` and `Firacode font`
- [Git](https://git-scm.com/)
- [Terminator](https://terminator-gtk3.readthedocs.io/en/latest) (terminal)
- [Docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script) and [docker-compose](https://docs.docker.com/compose/install)
- [Ngrok](https://ngrok.com) (localhost tunneling)
- [ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) shell
- [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh) and [Spaceship theme](https://github.com/spaceship-prompt/spaceship-prompt)
- OhMyZsh plugins:
  - [Zinit](https://github.com/zdharma-continuum/zinit)
  - [Syntax highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
  - [Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [Completions](https://github.com/zsh-users/zsh-completions)
  - [My custom plugin](https://github.com/mateussantana/ohmyzsh-custom-funcalias)
- [Node.js 16 LTS](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions) and yarn
- [PHP 8.1](https://www.php.net/downloads.php#v8.1.1) and most used extensions
- [Composer](https://getcomposer.org/download/) (php package manager)
- Set your default shell to ``zsh``


## 🏗️ Editing and testing

If you want to adapt this installation script to your needs, consider to use docker to test.

```bash
# Build docker image and run test non interactively as root
docker build -t install-script .
docker run --rm install-script bash install.sh
```

*or...*

```bash
# Run test interactively as a regular system user
# user: ubuntu
# password: ubuntu
docker run --rm -it -u ubuntu:ubuntu install-script bash install.sh
```

*or...*

```bash
# Map current work directory to container and run test as you go
docker run --rm -it -v $PWD:/home/ubuntu/install-script -u ubuntu:ubuntu install-script
```


###### [Here is a walkthrough about my specific Windows and Linux installation scenario while pc formatting](docs/PC_FORMATTING.md)
