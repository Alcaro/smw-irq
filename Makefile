all:
	asar main.asm SMW.sfc
	purify SMW.sfc
clean:
	rm SMW.sfc
debug:
	asar debug.asm SMW.sfc
	purify SMW.sfc
run:
	purify SMW.sfc

debug_fresh:
	asar main.asm SMW.sfc
	asar debug.asm SMW.sfc
	purify SMW.sfc
