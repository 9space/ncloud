#!/bin/bash

release='nine-cloud'

echo "Downloading nine-cloud release ${release} to ${PWD}/${release}.tar.gz"
curl -L -o $release.tar.gz https://git.9space.io/open-source/nine-cloud/repository/archive.tar.gz?ref=master

echo "Unpacking nine-cloud release ${release}.tar.gz"
mkdir -p $release-tmp
tar xfz $release.tar.gz -C $release-tmp

mkdir -p /usr/local/share/nine
echo "Installing in /usr/local/share/nine/$release"

rm -Rf /usr/local/share/nine/$release
mv -f $release-tmp/* /usr/local/share/nine/$release
ln -sf /usr/local/share/nine/$release/nine-cloud /usr/local/bin/
rm -Rf $release-tmp
echo "Installation successful!"
echo
echo "Start by typing:"
echo '`nine-cloud`'
exit 0
