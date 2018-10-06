# Barton's Dotfiles and /bin

This is my collected junk accumulated and curated since about 2007,
some useful, some not.

`.dependencies` contains a list of hard and soft dependencies.

`linkfiles.sh` is a shell script which will deploy dotfiles as follows:

- Any dot file matching a file name in `~/dotfiles/` will be moved to `$HOME/.user_dotfiles_backup.YYYY.mm.dd_HH.MM.SS`
- Symbolic links will be created between dot files in `$HOME` and the corresponding dot files in `~/dotfiles/`
- A symbolic link will be created between `~/bin` and `$HOME/bin`, as long as `~/bin` does not already exist.

## How to use this:

- You will probably want to fork my repository on github; this will allow you to push your changes to your local repo.
- Clone `~/dotfiles` into your home directory.
- If you have your own `~/bin` directory, you'll want to move it, then...

    cd ~/dotfiles
    ./linkfiles.sh


