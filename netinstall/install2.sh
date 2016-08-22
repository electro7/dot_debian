cd ~
mkdir Documents
rm -rf Documents/dotfiles
mkdir Documents/dotfiles
git clone https://github.com/mope1/dotfiles.git Documents/dotfiles
for conf in $(ls -a Documents/dotfiles |grep -Ev '^\.\.?$|netinstall'); do
	echo Replacing with github version: $conf
	rm -rf $conf
	cp -rf Documents/dotfiles/$conf .
done
git clone https://github.com/gmarik/Vundle.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


