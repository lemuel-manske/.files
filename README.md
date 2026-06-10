# .files

_Not about being stylish, but simply what makes me a better dev_

This repository keeps my development environment configuration, targeting WSL2 (although it should work on any linux distro).

## Bootstrap

On a fresh Ubuntu WSL machine:

```bash
curl -fsSL https://raw.githubusercontent.com/lemuel-manske/.files/main/bootstrap.sh | bash
```

That single command installs Ansible, clones this repo to `~/.files`, and runs the playbook.

## Running individual roles

```bash
ansible-playbook ansible/playbook.yml -i ansible/inventory --tags zsh
ansible-playbook ansible/playbook.yml -i ansible/inventory --tags neovim
ansible-playbook ansible/playbook.yml -i ansible/inventory --tags node
```

## Dotfiles only

To symlink dotfiles without running the full playbook:

```bash
stow .
```

## Testing idempotency

```bash
docker build -f ansible/tests/Dockerfile -t dotfiles-test .
```

The Dockerfile runs the playbook twice. The second run asserts `changed=0`.

## Tooling

- Opencode
- Neovim
- Tmux
- Oh-my-zsh
