#!/usr/bin/env sh
# These tests should be run by `make test`

build="./build/"
test="./test/"

mkdir -p "$test"

"$build/colors-qoi" > "$test/colors.qoi"

magick "$test/colors.qoi" "$test/colors.png"
magick "$test/colors.qoi" "$test/colors.ppm"

"$build/ppm-to-qoi" < "$test/colors.ppm" > "$test/colors-from-ppm-1.qoi"
"$build/ppm-to-qoi2" < "$test/colors.ppm" > "$test/colors-from-ppm-2.qoi"

printf "test 1: "
magick compare "$test/colors.qoi" "$test/colors-from-ppm-1.qoi" /dev/null && echo "ok" || echo "not ok"

printf "test 2: "
magick compare "$test/colors.qoi" "$test/colors-from-ppm-2.qoi" /dev/null && echo "ok" || echo "not ok"
