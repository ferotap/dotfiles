#!/bin/bash
#
# Customize your shell by sourcing files from a directory.
#
# This file itself is sourced from default ~/.profile.
# !TODO: ATM it is sourced # form .bashrc as the .profile, for some reason, is
# not sourced during login. Fix to be done in `script/install.sh`s `rt_bash()` function.
# (remove the line `source ./.rt_sourcer.sh` from the `.bashrc` modification.)

# The main goal for sourcing files from a directory leave ~/.profile and
# ~/.bashrc to as original state as possible and do all the customizations in
# the respective directories
#
# Use cases:
# - set project specific aliases/alias like functions
# - set project specific environment variables
# - set uniform prompt
# - ...
#
# If the shell customization is to done by `vagrant provision --provision-with
# shell` all you need to is to add your customization files in ~/.bash.d
# directory. However, if you plan to set things according to your personal
# likings, it is perhaps better to create your own customization directory, for
# example, `~/.my_bashrc.d` and call `source_files_in ~/my_bash.d` explicitly
# from your `~/.bashrc`
#

et_source_files_in() {
    local dir="$1"

    if [[ -d "$dir" && -r "$dir" && -x "$dir" ]]; then
        for file in "$dir"/*; do
           [[ -f "$file" && -r "$file" ]] && source "$file"
        done
    fi
}
