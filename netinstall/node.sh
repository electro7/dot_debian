

echo 'root	ALL=(ALL:ALL) ALL' >> /etc/sudoers

apt-get install lynx python-dev g++ make
URL=$(lynx --dump --listonly https://nodejs.org/dist/latest/ | tail -2 | head -1 | perl -pe 's/[0-9]+\.\s//')
cd /tmp
rm -rfv *
wget --no-clobber $URL
tar xzvf node*.tar.gz
cd node*
./configure
make install

