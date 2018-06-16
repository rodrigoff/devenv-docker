FROM rodrigoff/devenv

# dotnet
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
  mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
  wget -q https://packages.microsoft.com/config/debian/9/prod.list && \
  mv prod.list /etc/apt/sources.list.d/microsoft-prod.list

RUN apt-get update && \
  apt-get install -y dotnet-sdk-2.1

# omnisharp
RUN wget https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.30.1/omnisharp-linux-x64.tar.gz && \
  mkdir ~/omnisharp && \
  tar -zxvf omnisharp-linux-x64.tar.gz -C ~/omnisharp && \
  rm -rf omnisharp-linux-x64.tar.gz

# add and configure vim plugins
RUN git clone git://github.com/OmniSharp/omnisharp-vim.git ~/.vim_runtime/my_plugins/omnisharp-vim && \
  git clone git://github.com/tpope/vim-dispatch.git ~/.vim_runtime/my_plugins/vim-dispatch && \
  git clone --depth=1 git://github.com/vim-syntastic/syntastic.git ~/.vim_runtime/my_plugins/vim-syntastic &

ADD omnisharp_config.vim ~/.vim_runtime/omnisharp_config.vim
RUN echo 'source ~/.vim_runtime/omnisharp_config.vim' >> ~/.vim_runtime/my_configs.vim