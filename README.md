# rodrigoff/devenv
The goal of this repository is to keep my development environment inside Docker containers for easy portability and so I can have the same experience accross all the machines I work on without the hassle of setting everything up and keeping track of my dotfiles and stuff like that.

The base image is based on `debian:stretch-slim` and contains the following:

- [git](https://git-scm.com/)
- [zsh](http://www.zsh.org/)
- [prezto](https://github.com/sorin-ionescu/prezto)
- [tmux](https://github.com/tmux/tmux/wiki)
- [vim](https://www.vim.org/) - Built from source with python2.7 to work with the [ominsharp-vim](https://github.com/OmniSharp/omnisharp-vim) plugin in another image (only until [this issue](https://github.com/OmniSharp/omnisharp-vim/pull/316) is resolved).
- [the ultimate vimrc](https://github.com/amix/vimrc)
- [docker](https://www.docker.com/)
- [X11 forwarding over SSH](https://unix.stackexchange.com/questions/12755/how-to-forward-x-over-ssh-to-run-graphics-applications-remotely)

There's also a ssh-agent container, based on [nardeas/docker-ssh-agent](https://github.com/nardeas/docker-ssh-agent) image.

## How to run

```
docker run --rm -it rodrigoff/devenv
```

### Binding the docker socket

On macOS:
```
-v /var/run/docker.sock:/var/run/docker.sock
```

On Windows:
```
-v //var/run/docker.sock:/var/run/docker.sock
```

### Using git with a bind mount

To make git work correctly with bind mounted repositories (especially on Windows), we have to set the [GIT_DISCOVERY_ACROSS_FILESYSTEM](https://git-scm.com/docs/git/1.7.6#git-emGITDISCOVERYACROSSFILESYSTEMem) environment to true (`export GIT_DISCOVERY_ACROSS_FILESYSTEM=true` or `-e GIT_DISCOVERY_ACROSS_FILESYSTEM=true` when starting the container).

### Running the ssh-agent

1. Start the ssh-agent container

```
docker run -d --name ssh-agent rodrigoff/ssh-agent
```

2. Add your ssh keys

```
docker run --rm -it --volumes-from ssh-agent -v ~/.ssh:/.ssh rodrigoff/ssh-agent ssh-add /root/.ssh/id_rsa
```

3. Mount the ssh-agent socket in the desired containers
```
docker run -it --rm -v <your repos folder>:/workspace -e GIT_DISCOVERY_ACROSS_FILESYSTEM=true --volumes-from=ssh-agent -e SSH_AUTH_SOCK=/.ssh-agent/socket -v //var/run/docker.sock:/var/run/docker.sock -h devenv -p 22:22 rodrigoff/devenv
```
