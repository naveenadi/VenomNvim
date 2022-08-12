#!/usr/bin/sh

VENOM_NVIM=~/.config/venom-nvim
export VENOM_NVIM

rm -rf $VENOM_NVIM

mkdir -p $VENOM_NVIM/share
mkdir -p $VENOM_NVIM/nvim

stow --restow --target=$VENOM_NVIM/nvim .

alias nvmm='XDG_DATA_HOME=$VENOM_NVIM/share XDG_CACHE_HOME=$VENOM_NVIM XDG_CONFIG_HOME=$VENOM_NVIM nvim'

