#!/usr/bin/env sh
# These tests should be run by `make test`

build="./build/"
test="./test/"

mkdir -p "$test"

"$build/colors-qoi" > "$test/colors.qoi"
magick "$test/colors.qoi" "$test/colors.png"
