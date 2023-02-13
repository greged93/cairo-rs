#!/usr/bin/env bash
set -ex

apt update -y

# Install curl in order to install Rust and Cargo
# Install make, necessary for installing python 3.9 with pyenv

apt install -y curl \
               make

# Install Rust and Cargo
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"

# Make sure Rust has been installed correctly
rustc --version

# Install pyenv dependencies
apt-get install -y git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

# Install pyenv
curl https://pyenv.run | bash
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Make sure pyenv has been installed correctly
pyenv -v

# Installing python 3.9 with pyenv
pyenv install 3.9

# Setting python 3.9 as the default local version
pyenv local 3.9

# Create and enter a virtual environment
python3.9 -m venv ~/cairo_venv
source ~/cairo_venv/bin/activate

# Install cairo dependencies
apt install -y libgmp3-dev
pip3 install ecdsa fastecdsa sympy

# Install cairo
pip3 install cairo-lang
