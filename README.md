# qoi-bf

This repo contains brainfuck programs that implement the [Quite OK Image Format](https://qoiformat.org/). A brainfuck implementation with wrapping 8-bit cells is required.

- `fnl`: sources of the programs
- `bf`: generated brainfuck programs (ready to use)

## building and testing the brainfuck programs
These steps are only necessary if you modified the source files in `fnl` or want to run tests. Requires:
- [Fennel](https://fennel-lang.org/)
- [bfc](https://bfc.wilfred.me.uk/)
- ImageMagick
```sh
make # build bf/* from fnl/*
make build # compile bf/* with bfc
make test # run tests
```
