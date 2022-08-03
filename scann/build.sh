#!/bin/bash

[[ ! -d .venv ]] && python -m venv .venv

source .venv/bin/activate

sudo apt install clang-8

sudo npm install -g @bazel/bazelisk
USE_BAZEL_VERSION="3.7.2"
bazelisk

# See more info here: https://github.com/google-research/google-research/tree/master/scann
python configure.py
CC=clang-8 bazel build -c opt --features=thin_lto --copt=-mavx2 --copt=-mfma --cxxopt="-std=c++17" --copt=-fsized-deallocation --copt=-w :build_pip_pkg
./bazel-bin/build_pip_pkg
