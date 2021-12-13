FROM ubuntu:21.10

ARG NEWUSER_NAME=ubuntu
ARG NEWUSER_PSWD=ubuntu
ARG SCRIPT_FOLDER=install-script

COPY . /tmp/${SCRIPT_FOLDER}

RUN	apt-get update && \
    apt-get install -y sudo && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*; \
    adduser --disabled-password --gecos "" ${NEWUSER_NAME} && \
    adduser ${NEWUSER_NAME} sudo && \
    echo "${NEWUSER_NAME}:${NEWUSER_PSWD}" | chpasswd && \
    mv /tmp/${SCRIPT_FOLDER} /home/${NEWUSER_NAME} && \
    chown ${NEWUSER_NAME}:${NEWUSER_NAME} /home/${NEWUSER_NAME} -R

WORKDIR /home/${NEWUSER_NAME}/${SCRIPT_FOLDER}
