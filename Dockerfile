FROM centos:centos7

# Disable the annoying fastest mirror plugin
RUN sed -i '/enabled=1/ c\enabled=0' /etc/yum/pluginconf.d/fastestmirror.conf

# Set the environment up
ENV TERM xterm-256color

RUN yum -y -q install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  yum -y -q update && \
  yum -y -q install \
  # Build tools
  # make gcc-c++ cmake autoconf patch automake \
  # General Utils
  unzip jq git wget sudo which wemux tmux telnet httpie redis ansible libaio gettext bzip2 && \
  # Build libraries
  # libyaml-devel readline-devel zlib-devel libffi-devel openssl-devel libtool bison sqlite-devel \
  # lua-devel luajit luajit-devel ctags tcl-devel libxml2-devel libxslt-devel \
  # All the pythons
  # python34 python34-devel python34-pip python34-setuptools \
  # python27 python27-devel python27-pip python27-setuptools \
  # python-devel \
  # And the perls
  # perl perl-devel perl-ExtUtils-ParseXS \
  # perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed && \
  # Clean up
  yum -y -q clean all

# RUN mkdir -p /storage
# WORKDIR /storage
# RUN chown docker:docker /storage

# RUN pip3 install thefuck

# docker
RUN yum install -y yum-utils device-mapper-persistent-data lvm2 && \
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
  yum install -y docker-ce

RUN useradd -g docker docker && \
  echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker
ENV HOME=/home/docker
ENV USER=docker



# zsh + prezto
RUN sudo yum install -y zsh && \
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"


COPY tmp-scripts /tmp/scripts
RUN sudo  chmod +x /tmp/scripts/prezto && \
  zsh /tmp/scripts/prezto

# Install .NET Core SDK
# RUN rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm && \
#   yum update && \
#   yum install libunwind libicu && \
#   yum install dotnet-sdk-2.1.200

# Add all our config files
COPY home $HOME
RUN sudo chown -R docker:docker $HOME/

# # Fix all permissions
# ENTRYPOINT ["/bin/bash", "--login"]
# CMD ["/usr/local/bin/entrypoint.sh"]
# VOLUME /home/docker

# COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# COPY versions.sh /usr/local/bin/versions.sh
# RUN /bin/bash --login -c "/usr/local/bin/versions.sh | sudo dd of=/.devenv-versions"
ENV SHELL /bin/zsh
CMD ["zsh", "--version"]
