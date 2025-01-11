# path to bfc: https://bfc.wilfred.me.uk/
BFC=bfc

FNL_FILES   := $(wildcard fnl/*.fnl)
BF_FILES    := $(FNL_FILES:fnl/%.fnl=bf/%.bf)
BUILD_FILES := $(FNL_FILES:fnl/%.fnl=build/%)
DEBUG_FILES := $(FNL_FILES:fnl/%.fnl=debug/%.lua)

all: $(BF_FILES)

clean:
	rm -rf fnl2bf.lua build test debug

build: $(BUILD_FILES)

debug: $(DEBUG_FILES)

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

debug/%.lua: bf/%.bf
	mkdir -p debug
	cd bf2lua && lua bf2.lua -g -i ../$< -o ../$@

.PHONY: all build clean test
