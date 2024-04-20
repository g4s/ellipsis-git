#! /usr/bin/env bash

pkg.install(){
    # collect information
    read -p "Which name should be configured in gitconfig? " gituser
    read -p "Which email adress should be used for gitconfig? " gitmail

    # generating configs
    envsubst < gitconfig.tmpl > ${HOME}/.gitconfig
    envsubst < gitmessage.tmpl > ${HOME}/.gitmessage
}