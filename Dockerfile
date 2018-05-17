FROM debian:stretch-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  # basic utilities
  apt-get install -y software-properties-common git wget

# zsh + prezto
RUN apt-get install -y zsh && \
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

RUN zsh -c 'setopt EXTENDED_GLOB; \
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do \
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; \
  done' 

# vim + vimrc
RUN apt-get install -y vim && \
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
  sh ~/.vim_runtime/install_awesome_vimrc.sh

# docker
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
  add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable" && \
  apt-get update && \
  apt-get install -y docker-ce

# user for apps that don't support root
RUN useradd user && usermod -aG sudo user
RUN mkdir /home/user && chown -R user /home/user
RUN echo 'user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers