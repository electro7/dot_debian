cd ~
find . -delete
git clone https://github.com/mope1/dotfiles.git .
git clone https://github.com/gmarik/Vundle.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


