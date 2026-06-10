# Install instructions

Follow the instructions below. Once finished, remember to install the Nerd font available [here](./fonts/).

```
# update
sudo apt update && sudo apt upgrade -y

# setup ssh
ssh-keygen
cat .ssh/id_ed25519.pub

# add to github, then

export GITHUB_TOKEN=<>
git config --global user.name "lemuel-manske"
git config --global user.email "lemuelkauemanskede.liz@philips.com"

# setup dotfiles
git clone git@github.com:lemuel-manske/.files
sudo apt install stow
cd .files

# install dependencies
sudo apt install -y \
  xclip \
  tmux \
  curl \
  zsh \
  zip \
  unzip \
  libfuse2 \
  xdg-utils \
  fzf \
  gcc \
  ripgrep \
  fd-find \
  make \
  cmake

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ohmyzsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# sync
source ~/.zshrc

# install go
sudo apt install -y golang-go

# goimports (go formatter - required by neovim conform)
go install golang.org/x/tools/cmd/goimports@latest

# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
npm i -g yarn
npm install -g neovim  # neovim node.js provider

# sdkman
curl -s "https://get.sdkman.io" | bash

# opencode
curl -fsSL https://opencode.ai/install | bash

# neovim providers
pip install --break-system-packages pynvim  # python provider

# sqlcl
cd /opt
curl https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip -o sqlcl.zip
unzip sqlcl.zip
rm sqlcl.zip

# devcontainers
curl -fsSL https://raw.githubusercontent.com/devcontainers/cli/main/scripts/install.sh | sh

# treesitter parsers (required by nvim-dap-python for test_method/test_class)
npm install -g tree-sitter-cli
mkdir -p ~/.local/share/nvim/site/parser
git clone https://github.com/tree-sitter/tree-sitter-python /tmp/ts-python
cd /tmp/ts-python && tree-sitter build --output ~/.local/share/nvim/site/parser/python.so
rm -rf /tmp/ts-python


# pyenv
curl -fsSL https://pyenv.run | bash

# finalize
source ~/.zshrc
```
