# rodrigoff/devenv
The goal of this repository is to keep my development environment inside Docker containers for easy portability and so I can have the same experience accross all the machines I work on without the hassle of setting everything up and keeping track of my dotfiles and stuff like that.

The base image is based on `debian:stretch-slim` and contains the following:

- [git](https://git-scm.com/)
- [zsh](http://www.zsh.org/)
- [prezto](https://github.com/sorin-ionescu/prezto)
- [vim](https://www.vim.org/)
- [the ultimate vimrc](https://github.com/amix/vimrc)
- [docker](https://www.docker.com/)
- [X11 forwarding over SSH](https://unix.stackexchange.com/questions/12755/how-to-forward-x-over-ssh-to-run-graphics-applications-remotely)

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
