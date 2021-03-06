#!/bin/bash
# MAC SETUP SCRIPT

# Change editor (for next step):
export EDITOR=nano

# Checking if bash_profile already setup
grep "bash profile already setup" .bash_profile
already_setup=$?

set -e

if [ "$already_setup" != "0" ]; then
    echo "# bash profile already setup" >> ~/.bash_profile
    echo "export EDITOR=nano" >> ~/.bash_profile

    # Increase bash history to a million commands (should be enough)
    echo "HISTFILESIZE=10000000" >> ~/.bash_profile

    # Change prompt to linux default
    echo "export PS1='\$(whoami)@\$(hostname):\$(pwd) '" >> ~/.bash_profile

    echo "" >> ~/.bash_profile

    echo "function json {" >> ~/.bash_profile
    echo "	python -m json.tool" >> ~/.bash_profile
    echo "}" >> ~/.bash_profile
    echo "" >> ~/.bash_profile
    
    # nice alias for grepping history (cos CTRL + R not always that great)
    echo "function gh {" >> ~/.bash_profile
    echo "    cat ~/.bash_history | grep \$*" >> ~/.bash_profile
    echo "}" >> ~/.bash_profile
    
    echo ""  >> ~/.bash_profile
    
    # add bash-completion to ~/.bash_profile
    echo "if [ -f \$(brew --prefix)/etc/bash_completion ]; then" >> ~/.bash_profile
    echo "    . \$(brew --prefix)/etc/bash_completion" >> ~/.bash_profile
    echo "fi"  >> ~/.bash_profile
fi

# Disable thing that makes it impossible to run apps from internet
sudo spctl --master-disable

# Increase timeout for sudo
# sudo visudo # then change Defaults timestamp_timeout=0 to Defaults timestamp_timeout=60
# OR ("dangerous" only try this on a fresh install (or rebuild required))

# sudo sh -c 'echo "\nDefaults timestamp_timeout=60">>/etc/sudoers'

# Fix key repeat settings
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Install brew
brew >/dev/null || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install brew cask (makes it easier to install mac apps)
brew tap caskroom/cask

brew cask install google-chrome

# Fix bug with mac mouse & trackpad
# Stopped working:
# brew cask install steelseries-exactmouse-tool

curl http://downloads.steelseriescdn.com/drivers/tools/steelseries-exactmouse-tool.dmg
# Must then manually install the dmg (need to work out how to automate these steps:
# https://apple.stackexchange.com/questions/73926/is-there-a-command-to-install-a-dmg
# This seems best:
# https://stackoverflow.com/questions/21428208/how-to-silently-install-dmg-file-in-mac-os-x-system-using-shell-script

defaults write .GlobalPreferences com.apple.mouse.scaling -1
defaults write .GlobalPreferences com.apple.trackpad.scaling -1

# At this point should reboot to ensure the keyboard & mouse settings work

mkdir -p ~/src

# Spectacle means you can resize and move windows with shortcuts (requires manual step afterwards)
# After you have done the manual step to start, remember to 
# change the default shortcuts for snap right half and snap left half as they conflict with Intellij
brew cask install spectacle

# Install sublime (best text editor ever!)
brew cask install sublime-text

# Install java
brew cask install java

# Install scala
brew install scala

# Install sbt
brew install sbt

# Install Intellij (Community edition) (doesn't seem to work anymore)
# brew cask install intellij-idea-ce

# ifstat
brew install ifstat

# firefox
brew cask install firefox

# Install GNU style bash commands (gives gdate and such and such)
brew install coreutils

# Hipchat
brew cask install hipchat

# DEPRECATED use oneflow
# git-flow
# brew install git-flow

# git auto completion
brew install git bash-completion

# Skip annoying "yes" for cloning git repos
git config --global http.sslVerify false
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

# spotify for concentration
brew cask install spotify

# open office
brew cask install openoffice

# wget
brew install wget

# s3cmd
brew install s3cmd

# Source tree
brew cask install sourcetree

# really cool json tool
brew install jq

# install pip
brew install python

# install aws cli
pip install awscli

# vagrant - a orchestration for virtual box
brew cask install vagrant

# VLC
brew cask install vlc

# Virtual box
brew cask install virtualbox

# Docker
# Manual step - after you need to open docker from spotlight
brew cask install docker

# gcloud
curl https://sdk.cloud.google.com | bash
# manual: restart shell, run gcloud init

# Keybase https://keybase.io/
# manual: open and sign in (and add device)
brew cask install keybase

# start git auto completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Remove DS_Store abomination for ever and ever
# echo "while true; do find / -name .DS_Store -exec rm -f \"{}\" \; ; sleep 2; done" > ~/.rm-DS_Store-abomination.sh && chmod +x ~/.rm-DS_Store-abomination.sh && echo "screen -ls | grep rm-DS_Store-abomination >/dev/null || screen -S rm-DS_Store-abomination -d -m ~/.rm-DS_Store-abomination.sh" >> ~/.bash_profile && screen -ls | grep rm-DS_Store-abomination >/dev/null || screen -S rm-DS_Store-abomination -d -m ~/.rm-DS_Store-abomination.sh
