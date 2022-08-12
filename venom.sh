#!/usr/bin/sh

VENOM_NVIM=~/.config/venom-nvim
export VENOM_NVIM

alias venom='XDG_DATA_HOME=$VENOM_NVIM/share XDG_CACHE_HOME=$VENOM_NVIM XDG_CONFIG_HOME=$VENOM_NVIM nvim'

venom
