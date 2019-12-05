#!/usr/bin/env zsh
# Install Prezto by creating a bunch of symlinks.
#
# Authors:
#   Adrien Bak <adrien.bak@gmail.com>
#

function create_zshenv() {
    # Create a .zshenv file to load prezto from ZDOTDIR
    echo 'ZDOTDIR=$HOME/.config/zsh' | tee ${HOME}/.zshenv
    echo '[ -e "$HOME/.config/zsh/.zshenv" ] && . $ZDOTDIR/.zshenv' | tee -a ${HOME}/.zshenv
}

# Start
setopt EXTENDED_GLOB

#get the folder containing this script
zprezto_dir=${0:a:h}

if [[ $1 == "-f" ]]; then
    echo '==> Installing prezto <=='
    dryrun=false
else
    echo '==> Dry-Run <=='
    dryrun=true
fi

echo "\nCreating symlinks"
for rcfile in "${zprezto_dir}"/runcoms/^README.md(.N); do
    target="$rcfile"
    symlink="${ZDOTDIR:-$HOME}/.${rcfile:t}"

    if $dryrun ; then
        echo "${symlink} --> ${target}"
    else
        ln -s ${target} ${symlink}
    fi
done

if $dryrun; then
    echo "\nNew file: ~/.zshenv added"
else
    create_zshenv
fi
