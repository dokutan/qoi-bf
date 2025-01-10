all: bf/colors-qoi.bf bf/ppm-to-qoi.bf bf/ppm-to-qoi2.bf

clean:
	rm fnl2bf.lua

fnl2bf.lua: bf-codegen/fnl2bf/fnl2bf.fnl
	fennel --require-as-include --add-package-path "bf-codegen/fnl2bf/?.lua" --compile bf-codegen/fnl2bf/fnl2bf.fnl > fnl2bf.lua

bf/%.bf: fnl/%.fnl fnl2bf.lua
	fennel $< > $@

.PHONY: all clean
