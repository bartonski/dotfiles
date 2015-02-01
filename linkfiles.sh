#! /bin/sh

cd $HOME
for dotfile in $(find User/ -maxdepth 1 -type f -name '.*' ); do ln -s $(realpath $dotfile) $HOME; done

if [ ! -d ./bin ]
then
    ln -s $HOME/User/bin $HOME
fi
