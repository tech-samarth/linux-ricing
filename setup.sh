#!/bin/bash

echo "💀 Installing Samarth Cyber Terminal..."

# Update
sudo apt update

# Install base tools
sudo apt install -y zsh git curl wget unzip cmatrix lolcat fastfetch fonts-powerline

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k 2>/dev/null

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null

# Install eza
wget -q https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.zip
unzip -o eza_x86_64-unknown-linux-gnu.zip
sudo mv eza /usr/local/bin/
sudo chmod +x /usr/local/bin/eza
rm eza_x86_64-unknown-linux-gnu.zip

# Download YOUR .zshrc
echo "⚡ Applying config..."
curl -fsSL https://raw.githubusercontent.com/tech-samarth/linux-ricing/main/.zshrc -o ~/.zshrc

# Fallback auto zsh (for lab systems)
if ! grep -q "exec zsh" ~/.bashrc; then
  echo '
if [ -t 1 ] && [ -z "$ZSH_VERSION" ]; then
  exec zsh
fi
' >> ~/.bashrc
fi

# Try default shell
chsh -s $(which zsh) || echo "⚠️ Using fallback bash → zsh"

echo "✅ Done! Restart terminal"
