# .files

_Not about being stylish, but simply what makes me a better dev_

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

