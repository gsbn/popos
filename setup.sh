# Fonts Install
echo "Downloading fonts..."
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip -O ~/MesloInstall.zip
echo "Copying fonts..."
unzip -o -q ~/MesloInstall.zip -d ~/MesloInstall
rm ~/MesloInstall.zip
font_dir="$HOME/.local/share/fonts/Meslo/TrueType"
mkdir -p $font_dir
mv ~/MesloInstall/*.ttf $font_dir
rm -r ~/MesloInstall
fc-cache -f $font_dir

# Oh My Posh - Basic Install
sudo wget -q --show-progress https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

# Oh My Posh - Theme Install
mkdir -p ~/.poshthemes
wget -q --show-progress https://raw.githubusercontent.com/gsbn/popos/main/poshthemes/myterminal.omp.json -O ~/.poshthemes/myterminal.omp.json

# Update Bash shell
update_file="$HOME/.bashrc"
bash_header="#OhMyPosh-Config"
bash_footer="#OhMyPosh-Config-End"
bash_text='eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/myterminal.omp.json)"'
bash_full="$bash_header\n$bash_text\n$bash_footer"

sed -i "/$bash_header/,/$bash_footer/d" $update_file
echo -e $bash_full >> $update_file

source ~/.bashrc
