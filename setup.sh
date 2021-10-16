# Fonts Install
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip -O ~/MesloInstall.zip
unzip -o ~/MesloInstall.zip -d ~/MesloInstall
rm ~/MesloInstall.zip
font_dir="$HOME/.local/share/fonts/Meslo/TrueType"
mkdir -p $font_dir
mv ~/MesloInstall/*.ttf $font_dir
rm -r ~/MesloInstall
fc-cache -f $font_dir

# Oh My Posh - Basic Install
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

# Oh My Posh - Theme Install
mkdir ~/.poshthemes
wget https://raw.githubusercontent.com/gsbn/popos/main/poshthemes/myterminal.omp.json -O ~/.poshthemes/myterminal.omp.json

# Update Bash shell
source ~/.bashrc
