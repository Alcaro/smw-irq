all:
	asar main.asm SMW.sfc
	purify SMW.sfc
clean:
	rm SMW.sfc

