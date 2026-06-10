# Install instructions

Follow the instructions below. Once finished, remember to install the Nerd font available [here](./fonts/).

```bash
# update
sudo apt update && sudo apt upgrade -y

# setup ssh
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub

# add to github, then

git config --global user.name "lemuel-manske"
git config --global user.email "lemuelkauemanskede.liz@philips.com"

# setup dotfiles
git clone git@github.com:lemuel-manske/.files ~/.files

sudo apt install -y stow

cd ~/.files

# system dependencies
sudo apt install -y \
  xclip \
  tmux \
  curl \
  wget \
  git \
  zsh \
  zip \
  unzip \
  tar \
  gzip \
  libfuse2 \
  xdg-utils \
  fzf \
  gcc \
  g++ \
  ripgrep \
  fd-find \
  make \
  cmake \
  python3 \
  python3-pip \
  python3-venv

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ohmyzsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# sync dotfiles
stow .

source ~/.zshrc

# install go
sudo apt install -y golang-go

# go tools required by neovim
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

chmod u+x nvim-linux-x86_64.appimage

sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

sudo ln -sf /opt/nvim/nvim /usr/local/bin/nvim

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

source ~/.zshrc

nvm install --lts
nvm use --lts

# node tooling required by neovim
npm install -g \
  neovim \
  yarn \
  typescript \
  typescript-language-server \
  pyright \
  prettier \
  eslint_d \
  tree-sitter-cli

# sdkman
curl -s "https://get.sdkman.io" | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

# java required by jdtls
sdk install java 21-tem

# python tooling
pip install --user \
  pynvim \
  debugpy

# opencode
curl -fsSL https://opencode.ai/install | bash

# sqlcl
cd /opt

sudo curl \
  https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip \
  -o sqlcl.zip

sudo unzip sqlcl.zip
sudo rm sqlcl.zip

# devcontainers
curl -fsSL \
  https://raw.githubusercontent.com/devcontainers/cli/main/scripts/install.sh \
  | sh

# pyenv
curl -fsSL https://pyenv.run | bash

# finalize
source ~/.zshrc

# start neovim once
# lazy.nvim + mason will install:
# - jdtls
# - java-debug-adapter
# - java-test
# - lua-language-server
# - stylua
# - jsonls
# - ts_ls
# - pyright
# - gopls
nvim
```
