## How to run

```
docker run --rm --it rodrigoff/devenv-azure
```

### Keeping state

Map the `/root/.azure` folder to a volume or bind mount:

```
docker run --rm --it -v <your local azure folder>:~/.azure rodrigoff/devenv-azure
```