#!/bin/bash

echo "💀 Samarth Cyber Terminal Setup"

# ================================
# 👤 ASK USER NAME
# ================================
read -p "Enter your name: " USERNAME

# ================================
# 📦 INSTALL REQUIRED TOOLS
# ================================
sudo apt update
sudo apt install -y zsh git curl wget unzip cmatrix lolcat neofetch fonts-powerline figlet

# ================================
# 🎨 GENERATE ASCII
# ================================
ASCII_NAME=$(figlet -f slant "$USERNAME")

# Escape for safe insertion
ESCAPED_ASCII=$(printf "%s\n" "$ASCII_NAME" | sed 's/[&/\]/\\&/g')

# ================================
# 📥 DOWNLOAD ORIGINAL ZSHRC
# ================================
curl -fsSL https://raw.githubusercontent.com/tech-samarth/linux-ricing/main/.zshrc -o ~/.zshrc

# ================================
# 🔁 REPLACE BANNER BLOCK
# ================================
# Replace everything between "# Name banner" and "| lolcat"
sed -i "/# Name banner/,/| lolcat/c\\
# Name banner\\
echo \"\\
$ESCAPED_ASCII\\
\" | lolcat" ~/.zshrc

# ================================
# 🧠 OH MY ZSH
# ================================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ================================
# ⚡ POWERLEVEL10K + PLUGINS
# ================================
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k 2>/dev/null

git clone https://github.com/zsh-users/zsh-autosuggestions \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null

# ================================
# 🚀 INSTALL EZA
# ================================
wget -q https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.zip
unzip -o eza_x86_64-unknown-linux-gnu.zip
sudo mv eza /usr/local/bin/
sudo chmod +x /usr/local/bin/eza
rm eza_x86_64-unknown-linux-gnu.zip

# ================================
# 🎯 AUTO CONFIG P10K
# ================================
curl -fsSL https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-lean.zsh -o ~/.p10k.zsh

# ================================
# 🔁 FORCE ZSH
# ================================
if ! grep -q "exec zsh" ~/.bashrc; then
  echo '
if [ -t 1 ] && [ -z "$ZSH_VERSION" ]; then
  exec zsh
fi
' >> ~/.bashrc
fi

chsh -s $(which zsh) 2>/dev/null

# ================================
# ✅ DONE
# ================================
echo ""
echo "🔥 Setup complete for $USERNAME!"
echo "👉 Restart terminal"
