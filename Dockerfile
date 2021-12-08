FROM ubuntu:21.10

ARG NEWUSER_NAME=ubuntu
ARG NEWUSER_PSWD=ubuntu

# Sudo app and new user
RUN	apt-get update && \
    # Instalando apps e pacotes necessários
    apt-get install -y sudo && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*; \
    # Adiciona um novo usuário para resolver os problemas com permissões de arquivos entre o host e o container
    adduser --disabled-password --gecos "" ${NEWUSER_NAME} && \
    adduser ${NEWUSER_NAME} sudo && \
    echo "${NEWUSER_NAME}:${NEWUSER_PSWD}" | chpasswd
