# .files

_Not about being stylish, but simply what makes me a better dev_

```bash
stow .
```

## Full install

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

# setup zsh & ohmyzsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install ohmyzsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

source ~/.zshrc

# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage

sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

# install neovim dependencies
sudo apt install -y \
  libfuse2 \
  xdg-utils \
  fzf \
  gcc \
  ripgrep \
  fd-find \
  make \
  cmake

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
npm install --global yarn

curl -s "https://get.sdkman.io" | bash

# opencode
npm i -g opencode-ai
```
