# .files

_Not about being stylish, but simply what makes me a better dev_


```
sudo apt-get update -y
sudo apt-get install -y
sudo apt-get install curl fuse zip unzip wget stow
```

- [nvm](https://github.com/nvm-sh/nvm)
- [sdkman](https://sdkman.io/)

```bash
# ~/.bashrc
function load() {
  if [ -f $1 ]; then
      . $1
  fi
}

load ~/.localbashrc
```

```bash
stow . && source ~/.bashrc
```

