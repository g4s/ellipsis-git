#! /usr/bin/env bash

pkg.link(){
    fs.link_file "${PKG_PATH}/gitmessage" "${ELLIPSIS_HOME}/.gitmessage"
}

pkg.install(){
    # collect information
    read -p "Which name should be configured in gitconfig? " gituser
    read -p "Which email adress should be used for gitconfig? " gitmail

    if [[ $(command -v op-ssh-sign) ]]; then
        echo "Found 1password - should git be configured to use 1password for commit signing?"
        select uchoice in "Yes" "No"; do
            case $uchoice in
                Yes )
                    git_gpgformat = "ssh"
                    git_gpgprog = $(command -v op-ssh-sign)
                    git_gpgsign = true

                    read -p "SSH-Key for signing: " git_gpgkey

                    # check if 1password socket exists
                    # if the socket not exists, the ssh-agent is not running
                    if [[ ! -f "${HOME}/.1password/agent.sock" ]]; then
                        echo "please ensure 1password-ssh-agent is running"
                    fi
                    break;;
                No )
                    break;;
            esac
        done

    # generating configs
    envsubst < gitconfig.tmpl > ${HOME}/.gitconfig
}