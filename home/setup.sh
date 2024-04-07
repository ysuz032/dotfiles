#!/bin/bash

set -euo pipefail

THIS_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES=$(cd $THIS_DIR && find . -mindepth 1 -print)

for dotfile in $DOTFILES ; do
    # cut ./ prefix
    dotfile="${dotfile/.\//}"

    # guard
    [[ "${dotfile}" =~ ^[^\.]+ ]] && continue
    [[ "${dotfile}" =~ .*README\.md ]] && continue
    [[ "${dotfile}" =~ .*\.gitkeep ]] && continue
    [[ "${dotfile}" =~ .*\.git\/ ]] && continue
    [[ "${dotfile}" =~ .*\.github\/ ]] && continue
    [[ "${dotfile}" =~ .*\.DS_Store ]] && continue

    if [ -d "${THIS_DIR}/${dotfile}" ]; then
        mkdir -pv "${HOME}/${dotfile}"
        continue
    fi

    # Option:
    # -s, Create a symbolic link.
    # -n, Same as -h, for compatibility with other ln implementations.
    #     If the target_file or target_dir is a symbolic link, do not follow it. This is most useful with the -f option, to replace a symlink which may point to a directory.
    # -f, If the target file already exists, then unlink it so that the link may occur.  (The -f option overrides any previous -i and -w options.)
    # -v, Cause ln to be verbose, showing files as they are processed.
    ln -snfv "${THIS_DIR}/${dotfile}" "${HOME}/${dotfile}"
done
