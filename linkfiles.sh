#! /bin/sh

cd $HOME

DOTFILES_BACKUP="$HOME/.user_dotfiles_backup"

if [ ! -d $DOTFILES_BACKUP ]
then
    mkdir $DOTFILES_BACKUP
fi
for dotfile in $(find User/ -maxdepth 1 -type f -name '.*' )
do 
    BASE=$(basename $dotfile)
    if [ -e "$BASE" ]
    then
        mv "$BASE" $DOTFILES_BACKUP
    fi
    ln -s $(realpath $dotfile) $HOME
done

if [ ! -d ./bin ]
then
    ln -s $HOME/User/bin $HOME
fi
