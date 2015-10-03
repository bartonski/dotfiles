#! /bin/sh

cd $HOME

DOTFILES_BACKUP="$HOME/.user_dotfiles_backup"

if [ ! -d $DOTFILES_BACKUP ]
then
    mkdir $DOTFILES_BACKUP
fi
for dotfile in $(find $HOME/User/ -maxdepth 1 -type f -name '.*' )
do 
    BASE=$(basename $dotfile)

    # file is a symbolic link, go ahead and remove it.
    if [ -h "$BASE" ]
    then
        rm "$BASE" 
    fi

    # back up old files to $DOTFILES_BACKUP
    if [ -e "$BASE" ]
    then
        mv "$BASE" $DOTFILES_BACKUP
    fi
    ln -s $dotfile $HOME
done

if [ ! -d ./bin ]
then
    ln -s $HOME/User/bin $HOME
fi
