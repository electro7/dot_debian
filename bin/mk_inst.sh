#!/bin/bash
#
# Script de generación de autom.tar.gz para remotas

COMMON="/mnt/d/work/obras/000_common/"

if [ -e autom.tar.gz ]; then rm -f autom.tar.gz; fi
if [ -d tmp ]; then rm -rf tmp; fi
mkdir tmp
cp  ${COMMON}* ${COMMON}.* tmp 2>/dev/null
cp * .bashrc .vimrc tmp 2>/dev/null
cd tmp
echo --------------------------------------------------------------------------
echo -n "Borrando temporales..."
rm -f *.ps* 2>/dev/null
rm -f *.new 2>/dev/null
echo " OK"
echo -n "Convirtiendo archivos..."
dos2unix *.prg *.dev *.sh siga.* 2&>/dev/null
echo " OK"
echo --------------------------------------------------------------------------
echo -e "Comprimiendo..."
tar czvf autom.tar.gz * .bashrc .vimrc
mv autom.tar.gz ..
cd ..
rm -rf tmp
echo --------------------------------------------------------------------------
echo -en "$(tput setaf 9)"
ls -l autom.tar.gz
echo -en "$(tput sgr0)"
echo --------------------------------------------------------------------------
