# path to bfc: https://bfc.wilfred.me.uk/
BFC=bfc

FNL_FILES   := $(wildcard fnl/*.fnl)
BF_FILES    := $(FNL_FILES:fnl/%.fnl=bf/%.bf)
BUILD_FILES := $(FNL_FILES:fnl/%.fnl=build/%)

all: $(BF_FILES)

clean:
	rm -rf fnl2bf.lua build test

build: $(BUILD_FILES)

test: build
	./test.sh

# required to compile the *fnl files
fnl2bf.lua: bf-codegen/fnl2bf/fnl2bf.fnl
	fennel --require-as-include --add-package-path "bf-codegen/fnl2bf/?.lua" --compile bf-codegen/fnl2bf/fnl2bf.fnl > fnl2bf.lua

bf/%.bf: fnl/%.fnl fnl2bf.lua
	fennel $< > $@

build/%: bf/%.bf
	mkdir -p build
	cd build && $(BFC) ../$<

.PHONY: all build clean test
