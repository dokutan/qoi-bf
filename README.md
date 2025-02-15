# qoi-bf

This repo contains brainfuck programs that implement the [Quite OK Image Format](https://qoiformat.org/). A brainfuck implementation with wrapping 8-bit cells is required.

- `fnl`: sources of the programs
- `bf`: generated brainfuck programs (ready to use)

## programs

- **qoiview:** display a QOI image in a terminal using ANSI escape sequences
- **colors-qoi:** generate a test image containing all possible combinations of two color channels
- **ppm-to-qoi:** convert a ppm image to QOI using only `QOI_OP_RGB` chunks
- **ppm-to-qoi2:** convert a ppm image to QOI using `QOI_OP_RGB` and `QOI_OP_DIFF` chunks
- **qoi-debug:** print all chunks in a QOI file

## building and testing the brainfuck programs
These steps are only necessary if you modified the source files in `fnl` or want to run tests. Requires:
- [Fennel](https://fennel-lang.org/)
- [bfc](https://bfc.wilfred.me.uk/)
- ImageMagick
```sh
git clone --recursive https://github.com/dokutan/qoi-bf
cd qoi-bf
make # build bf/* from fnl/*
make build # compile bf/* with bfc
make debug # compile bf/* to lua for debugging
make test # run tests
```
