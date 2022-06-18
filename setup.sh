#!/usr/bin/env bash

# Set up environments variables and load functions
set -e

# Make sure that $PWD is the directory of the script
EVA_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)
export EVA_ROOT
export SRC_DIR="$EVA_ROOT"/src

# CD into the directory of init.sh
cd "$EVA_ROOT" || exit

# If the $USER is aris, set $EVA automatically
[[ $USER = "aris" ]] && export EVA="ariseus"

# Make alias
config_keys() { ./keys/init_keys.sh; }

# Load functions
. ./src_bak/init_config.sh
. ./src_bak/pkg.sh
. ./instance.sh

# Run arguments
for cmd in "$@"; do
  ($cmd)
done
