cd ~
mkdir Documents
mkdir Documents/dotfiles
git clone https://github.com/mope1/dotfiles.git Documents/dotfiles
for conf in $(ls Documents/dotfiles |grep -Ev '^\.\.?\/'); do
	rm -rfv $conf
done
cp -rfv Documents/dotfiles/* .
git clone https://github.com/gmarik/Vundle.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


