FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

RUN apt-get update

# basic utilities
RUN apt-get install -y \
  software-properties-common \
  git \
  wget \
  locales 

# language
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen &&\
  locale-gen en_US.utf8 &&\
  /usr/sbin/update-locale LANG=en_US.UTF-8

# gui stuff
RUN apt-get install -y \
  libfreetype6 \
  libsm6 \
  libxrender1 \
  libxt6 \
  libxtst6 

# ssh x11 forwarding
RUN apt-get install -y openssh-server xauth && \
  mkdir /var/run/sshd && \
  sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config && \
  sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config && \
  sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config && \
  sed -i "s/^.*PermitRootLogin.*$/PermitRootLogin yes/" /etc/ssh/sshd_config && \
  grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_

# zsh + prezto
RUN apt-get install -y zsh && \
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" && \
  chsh -s /bin/zsh

RUN zsh -c 'setopt EXTENDED_GLOB; \
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do \
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; \
  done; \
  unsetopt EXTENDED_GLOB'

## prezto-contrib
RUN cd ${ZDOTDIR:-$HOME}/.zprezto && \
  git clone https://github.com/belak/prezto-contrib contrib && \
  cd contrib && \
  git submodule init && \
  git submodule update

# tmux + tpm
RUN apt-get install -y tmux && \
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# vim + vimrc
RUN apt-get install -y vim-nox && \
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
  sh ~/.vim_runtime/install_awesome_vimrc.sh && \
  touch ~/.vim_runtime/my_configs

# docker
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
  add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable" && \
  apt-get update && \
  apt-get install -y docker-ce && \
  curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# docker completions
RUN curl -fLo ~/.zprezto/modules/completion/external/src/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker && \
  curl -fLo ~/.zprezto/modules/completion/external/src/_docker-compose https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose

# user for apps that don't support root
RUN useradd user && usermod -aG sudo user
RUN mkdir /home/user && chown -R user /home/user
RUN echo 'user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

# copy dotfiles
ADD home /root

EXPOSE 22
ENTRYPOINT $(service ssh restart >> /dev/null) && zsh
