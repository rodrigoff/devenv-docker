# rodrigoff/devenv
Docker-based dev environment 

# How to run

```
docker run --rm -it rodrigoff/devenv
```

## Binding the docker socket

On macOS:
```
-v /var/run/docker.sock:/var/run/docker.sock
```

On Windows:
```
-v //var/run/docker.sock:/var/run/docker.sock
```
