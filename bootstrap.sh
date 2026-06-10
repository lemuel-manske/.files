#!/usr/bin/env bash

set -euo pipefail

if ! command -v git &>/dev/null || ! command -v ansible &>/dev/null; then
  echo "==> Updating apt..."

  sudo apt-get update -y
fi

if ! command -v git &>/dev/null; then
  echo "==> Installing git..."

  sudo apt-get install -y git
fi

if ! command -v ansible &>/dev/null; then
  echo "==> Installing ansible..."

  sudo apt-get install -y ansible
fi

if [ ! -d "$HOME/.files" ]; then
  echo "==> Cloning .files..."

  git clone https://github.com/lemuel-manske/.files.git "$HOME/.files"
fi

echo "==> Installing Galaxy collections..."
ansible-galaxy collection install -r "$HOME/.files/ansible/requirements.yml"

echo "==> Running playbook..."
ansible-playbook "$HOME/.files/ansible/playbook.yml" -i "$HOME/.files/ansible/inventory"
