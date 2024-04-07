#!/bin/bash

# install git secret to global
if [ ! -e "${HOME}/.git-templates/git-secrets" ]; then
    git secrets --install ~/.git-templates/git-secrets
fi
