#!/bin/bash
#
# Script de generación de autom.tar.gz para remotas

if [ -e autom.tar.gz ]; then rm -f autom.tar.gz; fi
if [ -d tmp ]; then rm -rf tmp; fi
mkdir tmp
cp * .bashrc .vimrc tmp 2>/dev/null
cd tmp
echo --------------------------------------------------------------------------
echo -n "Borrando temporales..."
if [ -e siga.cal.new ]; then rm -f siga.cal.new; fi
if [ -e siga.def.new ]; then rm -f siga.def.new; fi
if [ -e siga.pst ]; then rm -f siga.pst; fi
if [ -e siga.psk ]; then rm -f siga.psk; fi
rm -f 000_*
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
