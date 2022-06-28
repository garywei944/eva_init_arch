#!/usr/bin/env bash

# Set up environments variables and load functions
set -e

# Make sure that $PWD is the directory of the script
EVA_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)
export EVA_ROOT
export SRC_DIR="$EVA_ROOT"/src

# https://stackoverflow.com/questions/3231804/in-bash-how-to-add-are-you-sure-y-n-to-any-command-or-alias
read -r -p "Are you currently in China? [y/N] " response
case "$response" in
[yY][eE][sS] | [yY])
  export COUNTRY=CN
  ;;
*)
  export COUNTRY=US
  ;;
esac

# CD into the directory of init.sh
cd "$EVA_ROOT" || exit

# If the $USER is aris, set $EVA automatically
[[ $USER = "aris" ]] && export EVA="ariseus"

# Make alias
config_keys() { ./keys/init_keys.sh; }

# Load functions
# Issue with other approaches to use find and source them
# https://stackoverflow.com/a/54561526
mapfile -d '' files < <(find "$SRC_DIR" -type f -name '*.sh' -print0) &&
  for file in "${files[@]}"; do
    . "$file"
  done

. "$EVA_ROOT"/instance.sh

# Run arguments
for cmd in "$@"; do
  ($cmd)
done
