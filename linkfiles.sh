#! /bin/sh

# A quick deployment script for deploying dotfiles and
# bin/ from ~/User/. This could probably be better done
# using ansible.

# Steps have been taken to back up files so
# the script doesn't overwrite anything, but
# this hasn't been extensively tested. The backups
# should be versioned, for instance, and
# an existing ~/bin directory won't get
# symlinked. I would suggest backing up
# then moving ~/bin before running this,
# then tar-balling ~/.user_dotfiles_backup
# with a versioned file name.

cd $HOME

DOTFILES_BACKUP="$HOME/.user_dotfiles_backup.$(date +%Y.%m.%d_%H.%M.%S)"
DOTPATH=$(dirname -- "$0")

if [ ! -d $DOTFILES_BACKUP ]
then
    mkdir $DOTFILES_BACKUP
fi

for dotfile in $(find "$DOTPATH" -maxdepth 1 -type f -name '.*' )
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
    ln -s $HOME/$DOTPATH/bin $HOME
fi
