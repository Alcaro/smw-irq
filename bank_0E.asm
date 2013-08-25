arch spc700

ORG $0E8000

SPC_engine:
	dw .end-.start				;		| Length of SPC engine
	dw $0500				;		| Location of SPC engine in ARAM

base $0500

.start
	clrp					;$0500		|
	mov x, #$CF				;$0501		|
	mov sp, x				;$0503		|
	mov a, #$00				;$0504		|
	mov $0386, a				;$0506		|
	mov $0387, a				;$0509		|
	mov $0388, a				;$050C		|
	mov $0389, a				;$050F		|
	mov x, a				;$0512		|
CODE_0513:
	mov (x+), a
	cmp x, #$E8				;$0514		|
	bne CODE_0513				;$0516		|
	mov a, #$00				;$0518		|
	mov x, a				;$051A		|
CODE_051B:
	mov $0200+x, a
	inc x					;$051E		|
	bne CODE_051B				;$051F		|
CODE_0521:
	mov $0300+x, a
	inc x					;$0524		|
	bne CODE_0521				;$0525		|
	mov x, #$0B				;$0527		|
CODE_0529:
	mov a, DATA_12A1+x
	mov y, a				;$052C		|
	mov a, DATA_1295+x			;$052D		|
	call CODE_0697				;$0530		|
	dec x					;$0533		|
	bpl CODE_0529				;$0534		|
	mov a, #$F0				;$0536		|
	mov $00F1, a				;$0538		|
	mov a, #$10				;$053B		|
	mov $00FA, a				;$053D		|
	mov a, #$36				;$0540		|
	mov $51, a				;$0542		|
	mov a, #$01				;$0544		|
	mov $00F1, a				;$0546		|

CODE_0549:
	mov y, $00FD
	beq CODE_0549				;$054C		|
	push y					;$054E		|
	mov a, #$38				;$054F		|
	mul ya					;$0551		|
	clrc					;$0552		|
	adc a, $44				;$0553		|
	mov $44, a				;$0555		|
	bcc CODE_0573				;$0557		|
	inc $45					;$0559		|
	call CODE_06AE				;$055B		|
	mov x, #$00				;$055E		|
	call CODE_05A5				;$0560		|
	call CODE_09E5				;$0563		|
	mov x, #$01				;$0566		|
	call CODE_05A5				;$0568		|
	call CODE_0816				;$056B		|
	mov x, #$03				;$056E		|
	call CODE_05A5				;$0570		|
CODE_0573:
	mov a, $51
	pop y					;$0575		|
	mul ya					;$0576		|
	clrc					;$0577		|
	adc a, $49				;$0578		|
	mov $49, a				;$057A		|
	bcc CODE_058D				;$057C		|
	mov a, $0388				;$057E		|
	bne CODE_0586				;$0581		|
	call CODE_0BC0				;$0583		|
CODE_0586:
	mov x, #$02
	call CODE_05A5				;$0588		|
	bra CODE_0549				;$058B		|
CODE_058D:
	mov a, $06
	beq CODE_0549				;$058F		|
	mov x, #$0E				;$0591		|
	mov $48, #$80				;$0593		|
CODE_0596:
	mov a, $31+x
	beq CODE_059D				;$0598		|
	call CODE_1198				;$059A		|
CODE_059D:
	lsr $48
	dec x					;$059F		|
	dec x					;$05A0		|
	bpl CODE_0596				;$05A1		|
	bra CODE_0549				;$05A3		|

CODE_05A5:
	mov a, x
	mov y, a				;$05A6		|
	mov a, $04+x				;$05A7		|
	mov $00F4+x, a				;$05A9		|
CODE_05AC:
	mov a, $00F4+x
	cmp a, $00F4+x				;$05AF		|
	bne CODE_05AC				;$05B2		|
	mov y, a				;$05B4		|
	mov a, $08+x				;$05B5		|
	mov $08+x, y				;$05B7		|
	cbne $08+x, CODE_05C1			;$05B9		|
	mov y, #$00				;$05BC		|
	mov $00+x, y				;$05BE		|
	ret					;$05C0		|

CODE_05C1:
	mov $00+x, y
	mov a, y				;$05C3		|
	ret					;$05C4		|

CODE_05C5:
	cmp a, #$D0
	bcs CODE_05CE				;$05C7		|
	cmp a, #$C6				;$05C9		|
	bcc CODE_05E3				;$05CB		|
CODE_05CD:
	ret

CODE_05CE:
	mov $C1+x, a
	setc					;$05D0		|
	sbc a, #$D0				;$05D1		|
	mov y, #$06				;$05D3		|
	mov $14, #$A5				;$05D5		|
	mov $15, #$5F				;$05D8		|
	call CODE_0D56				;$05DB		|
	bne CODE_05CD				;$05DE		|
	inc y					;$05E0		|
	mov a, ($14)+y				;$05E1		|
CODE_05E3:
	and a, #$7F
	clrc					;$05E5		|
	adc a, $43				;$05E6		|
	mov $02B1+x, a				;$05E8		|
	mov a, $02D1+x				;$05EB		|
	mov $02B0+x, a				;$05EE		|
	mov a, #$00				;$05F1		|
	mov $0330+x, a				;$05F3		|
	mov $0360+x, a				;$05F6		|
	mov $A0+x, a				;$05F9		|
	mov $0110+x, a				;$05FB		|
	mov $B0+x, a				;$05FE		|
	or ($5C), ($48)				;$0600		|
	or ($47), ($48)				;$0603		|
	mov a, $0300+x				;$0606		|
	mov $90+x, a				;$0609		|
	beq CODE_062B				;$060B		|
	mov a, $0301+x				;$060D		|
	mov $91+x, a				;$0610		|
	mov a, $0320+x				;$0612		|
	bne CODE_0621				;$0615		|
	mov a, $02B1+x				;$0617		|
	setc					;$061A		|
	sbc a, $0321+x				;$061B		|
	mov $02B1+x, a				;$061E		|
CODE_0621:
	mov a, $0321+x
	clrc					;$0624		|
	adc a, $02B1+x				;$0625		|
	call CODE_0F5D				;$0628		|
CODE_062B:
	mov a, $02B1+x
	mov y, a				;$062E		|
	mov a, $02B0+x				;$062F		|
	movw $10, ya				;$0632		|

CODE_0634:
	mov y, #$00
	mov a, $11				;$0636		|
	setc					;$0638		|
	sbc a, #$34				;$0639		|
	bcs CODE_0646				;$063B		|
	mov a, $11				;$063D		|
	setc					;$063F		|
	sbc a, #$13				;$0640		|
	bcs CODE_064A				;$0642		|
	dec y					;$0644		|
	asl a					;$0645		|
CODE_0646:
	addw ya, $10
	movw $10, ya				;$0648		|
CODE_064A:
	push x
	mov a, $11				;$064B		|
	call CODE_12BD				;$064D		|
	movw $14, ya				;$0650		|
	mov a, $11				;$0652		|
	inc a					;$0654		|
	call CODE_12BD				;$0655		|
	pop x					;$0658		|
	subw ya, $14				;$0659		|
	push a					;$065B		|
	mov a, $10				;$065C		|
	mul ya					;$065E		|
	addw ya, $14				;$065F		|
	movw $14, ya				;$0661		|
	mov a, $10				;$0663		|
	pop y					;$0665		|
	mul ya					;$0666		|
	mov a, y				;$0667		|
	mov y, #$00				;$0668		|
	addw ya, $14				;$066A		|
	movw $14, ya				;$066C		|
	mov a, $0210+x				;$066E		|
	mov y, $14				;$0671		|
	mul ya					;$0673		|
	movw $16, ya				;$0674		|
	mov a, $0210+x				;$0676		|
	mov y, $15				;$0679		|
	mul ya					;$067B		|
	clrc					;$067C		|
	adc a, $17				;$067D		|
	mov $17, a				;$067F		|
	mov a, x				;$0681		|
	xcn a					;$0682		|
	lsr a					;$0683		|
	or a, #$02				;$0684		|
	mov y, a				;$0686		|
	mov a, $16				;$0687		|
	call CODE_068F				;$0689		|
	inc y					;$068C		|
	mov a, $17				;$068D		|

CODE_068F:
	push a
	mov a, $48				;$0690		|
	and a, $1D				;$0692		|
	pop a					;$0694		|
	bne CODE_069D				;$0695		|

CODE_0697:
	mov $00F2, y
	mov $00F3, a				;$069A		|
CODE_069D:
	ret

CODE_069E:
	mov a, #$0A
	mov $0387, a				;$06A0		|
	mov a, $51				;$06A3		|
	call CODE_0E14				;$06A5		|
	mov a, #$1D				;$06A8		|
	mov $03, a				;$06AA		|
	bra CODE_06D2				;$06AC		|

CODE_06AE:
	cmp $00, #$12
	beq CODE_06C2				;$06B1		|
	cmp $00, #$11				;$06B3		|
	beq CODE_06C2				;$06B6		|
	cmp $04, #$11				;$06B8		|
	beq CODE_06C8				;$06BB		|
	cmp $04, #$1D				;$06BD		|
	beq CODE_06C8				;$06C0		|
CODE_06C2:
	mov a, $00
	bmi CODE_069E				;$06C4		|
	bne CODE_06D2				;$06C6		|
CODE_06C8:
	mov a, $0382
	bne CODE_071A				;$06CB		|
	mov a, $04				;$06CD		|
	bne CODE_074D				;$06CF		|
CODE_06D1:
	ret

CODE_06D2:
	mov $04, a
	mov a, $0388				;$06D4		|
	beq CODE_06F7				;$06D7		|
	mov a, #$00				;$06D9		|
	mov $0388, a				;$06DB		|
	mov a, $0389				;$06DE		|
	bne CODE_06E7				;$06E1		|
	mov a, #$20				;$06E3		|
	bra CODE_06F2				;$06E5		|

CODE_06E7:
	mov a, #$16
	mov $62, a				;$06E9		|
	mov $64, a				;$06EB		|
	call CODE_0EEB				;$06ED		|
	mov a, #$00				;$06F0		|
CODE_06F2:
	mov y, #$6C
	call CODE_0697				;$06F4		|
CODE_06F7:
	mov a, #$02
	mov $0382, a				;$06F9		|
	cmp $04, #$11				;$06FC		|
	bne CODE_070B				;$06FF		|
	mov a, $0389				;$0701		|
	beq CODE_070B				;$0704		|
	mov a, #$00				;$0706		|
	call CODE_0F22				;$0708		|
CODE_070B:
	mov a, #$10
	mov y, #$5C				;$070D		|
	call CODE_0697				;$070F		|
	set1 $1D.4				;$0712		|
	mov a, #$00				;$0714		|
	mov $0308, a				;$0716		|
	ret					;$0719		|


CODE_071A:
	dec $0382
	bne CODE_06D1				;$071D		|
CODE_071F:
	mov a, $04
	asl a					;$0721		|
	mov y, a				;$0722		|
	mov a, $5681+y				;$0723		|
	mov $18, a				;$0726		|
	mov a, $5682+y				;$0728		|
	mov $19, a				;$072B		|
	bra CODE_0754				;$072D		|

CODE_072F:
	cmp $04, #$11
	bne CODE_073E				;$0732		|
	mov a, #$60				;$0734		|
	mov $0388, a				;$0736		|
	mov y, #$6C				;$0739		|
	call CODE_0697				;$073B		|
CODE_073E:
	mov $04, #$00
	clr1 $1D.4				;$0741		|
	mov x, #$08				;$0743		|
	mov a, $C9				;$0745		|
	beq CODE_074C				;$0747		|
	jmp CODE_0D4B				;$0749		|
CODE_074C:
	ret

CODE_074D:
	dec $0380
	bne CODE_07A6				;$0750		|
CODE_0752:
	incw $18
CODE_0754:
	mov x, #$00
	mov a, ($18+x)				;$0756		|
	beq CODE_072F				;$0758		|
	bmi CODE_0786				;$075A		|
	mov $0381, a				;$075C		|
	incw $18				;$075F		|
	mov a, ($18+x)				;$0761		|
	mov $10, a				;$0763		|
	bmi CODE_0786				;$0765		|
	mov y, #$40				;$0767		|
	call CODE_0697				;$0769		|
	incw $18				;$076C		|
	mov a, ($18+x)				;$076E		|
	bpl CODE_077D				;$0770		|
	mov x, a				;$0772		|
	mov a, $10				;$0773		|
	mov y, #$41				;$0775		|
	call CODE_0697				;$0777		|
	mov a, x				;$077A		|
	bra CODE_0786				;$077B		|

CODE_077D:
	mov y, #$41
	call CODE_0697				;$077F		|
	incw $18				;$0782		|
	mov a, ($18+x)				;$0784		|
CODE_0786:
	cmp a, #$DA
	beq CODE_07F3				;$0788		|
	cmp a, #$DD				;$078A		|
	beq CODE_07C2				;$078C		|
	cmp a, #$EB				;$078E		|
	beq CODE_07D5				;$0790		|
	cmp a, #$FF				;$0792		|
	beq CODE_071F				;$0794		|
	mov x, #$08				;$0796		|
	call CODE_05C5				;$0798		|
	mov a, #$10				;$079B		|
	call CODE_0D32				;$079D		|
CODE_07A0:
	mov a, $0381
	mov $0380, a				;$07A3		|
CODE_07A6:
	clr1 $13.7
	mov x, #$08				;$07A8		|
	mov a, $90+x				;$07AA		|
	beq CODE_07B3				;$07AC		|
	call CODE_09CD				;$07AE		|
	bra CODE_07C1				;$07B1		|

CODE_07B3:
	mov a, #$02
	cmp a, $0380				;$07B5		|
	bne CODE_07C1				;$07B8		|
	mov a, #$10				;$07BA		|
	mov y, #$5C				;$07BC		|
	call CODE_0697				;$07BE		|
CODE_07C1:
	ret

CODE_07C2:
	mov x, #$00
	incw $18				;$07C4		|
	mov a, ($18+x)				;$07C6		|
	mov $46, #$08				;$07C8		|
	mov x, #$08				;$07CB		|
	call CODE_05C5				;$07CD		|
	mov a, #$10				;$07D0		|
	call CODE_0D32				;$07D2		|
CODE_07D5:
	mov x, #$00
	incw $18				;$07D7		|
	mov a, ($18+x)				;$07D9		|
	mov $99, a				;$07DB		|
	incw $18				;$07DD		|
	mov a, ($18+x)				;$07DF		|
	mov $98, a				;$07E1		|
	push a					;$07E3		|
	incw $18				;$07E4		|
	mov a, ($18+x)				;$07E6		|
	pop y					;$07E8		|
	mov $46, #$08				;$07E9		|
	mov x, #$08				;$07EC		|
	call CODE_0F5D				;$07EE		|
	bra CODE_07A0				;$07F1		|

CODE_07F3:
	mov x, #$00
	incw $18				;$07F5		|
	mov a, ($18+x)				;$07F7		|
	mov y, #$09				;$07F9		|
	mul ya					;$07FB		|
	mov x, a				;$07FC		|
	mov y, #$40				;$07FD		|
	mov $12, #$08				;$07FF		|
CODE_0802:
	mov a, $5570+x
	call CODE_0697				;$0805		|
	inc x					;$0808		|
	inc y					;$0809		|
	dbnz $12, CODE_0802			;$080A		|
	mov a, $5570+x				;$080D		|
	mov $0218, a				;$0810		|
	jmp CODE_0752				;$0813		|

CODE_0816:
	cmp $07, #$24
	beq CODE_082E				;$0819		|
	cmp $03, #$24				;$081B		|
	beq CODE_082A				;$081E		|
	cmp $07, #$1D				;$0820		|
	beq CODE_082E				;$0823		|
	cmp $07, #$05				;$0825		|
	beq CODE_082E				;$0828		|
CODE_082A:
	mov a, $03
	bne CODE_0837				;$082C		|
CODE_082E:
	mov a, $0D
	bne CODE_084B				;$0830		|
	mov a, $07				;$0832		|
	bne CODE_0876				;$0834		|
CODE_0836:
	ret

CODE_0837:
	mov $07, a
	mov $0D, #$02				;$0839		|
	mov a, #$40				;$083C		|
	mov y, #$5C				;$083E		|
	call CODE_0697				;$0840		|
	set1 $1D.6				;$0843		|
	mov a, #$00				;$0845		|
	mov $030C, a				;$0847		|
	ret					;$084A		|

CODE_084B:
	dbnz $0D, CODE_0836
	mov a, $07				;$084E		|
	asl a					;$0850		|
	mov y, a				;$0851		|
	mov a, $5619+y				;$0852		|
	mov $1A, a				;$0855		|
	mov a, $561A+y				;$0857		|
	mov $1B, a				;$085A		|
	bra CODE_087D				;$085C		|

CODE_085E:
	mov $07, #$00
	clr1 $1D.6				;$0861		|
	mov a, #$00				;$0863		|
	mov $2F, a				;$0865		|
	mov y, #$3D				;$0867		|
	call CODE_0697				;$0869		|
	mov x, #$0C				;$086C		|
	mov a, $CD				;$086E		|
	beq CODE_0875				;$0870		|
	jmp CODE_0D4B				;$0872		|
CODE_0875:
	ret

CODE_0876:
	dec $0384
	bne CODE_08D3				;$0879		|
CODE_087B:
	incw $1A
CODE_087D:
	mov x, #$00
	mov a, ($1A+x)				;$087F		|
	beq CODE_085E				;$0881		|
	bmi CODE_08AF				;$0883		|
	mov $0385, a				;$0885		|
	incw $1A				;$0888		|
	mov a, ($1A+x)				;$088A		|
	mov $10, a				;$088C		|
	bmi CODE_08AF				;$088E		|
	mov y, #$60				;$0890		|
	call CODE_0697				;$0892		|
	incw $1A				;$0895		|
	mov a, ($1A+x)				;$0897		|
	bpl CODE_08A6				;$0899		|
	mov x, a				;$089B		|
	mov a, $10				;$089C		|
	mov y, #$61				;$089E		|
	call CODE_0697				;$08A0		|
	mov a, x				;$08A3		|
	bra CODE_08AF				;$08A4		|

CODE_08A6:
	mov y, #$61
	call CODE_0697				;$08A8		|
	incw $1A				;$08AB		|
	mov a, ($1A+x)				;$08AD		|
CODE_08AF:
	cmp a, #$DA
	beq CODE_0920				;$08B1		|
	cmp a, #$DD				;$08B3		|
	beq CODE_08EF				;$08B5		|
	cmp a, #$EB				;$08B7		|
	beq CODE_0902				;$08B9		|
	cmp a, #$FF				;$08BB		|
	bne CODE_08C3				;$08BD		|
	decw $1A				;$08BF		|
	bra CODE_087D				;$08C1		|

CODE_08C3:
	mov x, #$0C
	call CODE_05C5				;$08C5		|
	mov a, #$40				;$08C8		|
	call CODE_0D32				;$08CA		|
CODE_08CD:
	mov a, $0385
	mov $0384, a				;$08D0		|
CODE_08D3:
	clr1 $13.7
	mov x, #$0C				;$08D5		|
	mov a, $90+x				;$08D7		|
	beq CODE_08E0				;$08D9		|
	call CODE_09CD				;$08DB		|
	bra CODE_08EE				;$08DE		|

CODE_08E0:
	mov a, #$02
	cmp a, $0384				;$08E2		|
	bne CODE_08EE				;$08E5		|
	mov a, #$40				;$08E7		|
	mov y, #$5C				;$08E9		|
	call CODE_0697				;$08EB		|
CODE_08EE:
	ret

CODE_08EF:
	mov x, #$00
	incw $1A				;$08F1		|
	mov a, ($1A+x)				;$08F3		|
	mov $46, #$0C				;$08F5		|
	mov x, #$0C				;$08F8		|
	call CODE_05C5				;$08FA		|
	mov a, #$40				;$08FD		|
	call CODE_0D32				;$08FF		|
CODE_0902:
	mov x, #$00
	incw $1A				;$0904		|
	mov a, ($1A+x)				;$0906		|
	mov $9D, a				;$0908		|
	incw $1A				;$090A		|
	mov a, ($1A+x)				;$090C		|
	mov $9C, a				;$090E		|
	push a					;$0910		|
	incw $1A				;$0911		|
	mov a, ($1A+x)				;$0913		|
	pop y					;$0915		|
	mov $46, #$0C				;$0916		|
	mov x, #$0C				;$0919		|
	call CODE_0F5D				;$091B		|
	bra CODE_08CD				;$091E		|

CODE_0920:
	mov a, #$00
	mov $2F, a				;$0922		|
	mov y, #$3D				;$0924		|
	call CODE_0697				;$0926		|
CODE_0929:
	mov x, #$00
	incw $1A				;$092B		|
	mov a, ($1A+x)				;$092D		|
	bmi CODE_094E				;$092F		|
	mov y, #$09				;$0931		|
	mul ya					;$0933		|
	mov x, a				;$0934		|
	mov y, #$60				;$0935		|
	mov $12, #$08				;$0937		|
CODE_093A:
	mov a, $5570+x
	call CODE_0697				;$093D		|
	inc x					;$0940		|
	inc y					;$0941		|
	dbnz $12, CODE_093A			;$0942		|
	mov a, $5570+x				;$0945		|
	mov $021C, a				;$0948		|
	jmp CODE_087B				;$094B		|
CODE_094E:
	and a, #$1F
	mov $2E, a				;$0950		|
	mov y, #$6C				;$0952		|
	call CODE_0697				;$0954		|
	mov a, #$40				;$0957		|
	mov $2F, a				;$0959		|
	mov y, #$3D				;$095B		|
	call CODE_0697				;$095D		|
	bra CODE_0929				;$0960		|

CODE_0962:
	mov y, #$09
	mul ya					;$0964		|
	mov x, a				;$0965		|
	mov y, #$50				;$0966		|
	mov $12, #$08				;$0968		|
CODE_096B:
	mov a, $5570+x
	call CODE_0697				;$096E		|
	inc x					;$0971		|
	inc y					;$0972		|
	dbnz $12, CODE_096B			;$0973		|
	mov a, $5570+x				;$0976		|
	mov $021A, a				;$0979		|
	ret					;$097C		|

CODE_097D:
	mov a, $06
	cmp a, #$06				;$097F		|
	beq CODE_0987				;$0981		|
	and a, #$FC				;$0983		|
	bne CODE_0A03				;$0985		|
CODE_0987:
	mov a, $0386
	bne CODE_099A				;$098A		|
	mov a, #$09				;$098C		|
	call CODE_0962				;$098E		|
	mov a, #$01				;$0991		|
	bne CODE_0997				;$0993		|
CODE_0995:
	mov a, #$00
CODE_0997:
	mov $0386, a
CODE_099A:
	bra CODE_0A03

CODE_099C:
	mov a, #$60
	mov y, #$6C				;$099E		|
	call CODE_0697				;$09A0		|
	mov a, #$FF				;$09A3		|
	mov y, #$5C				;$09A5		|
	call CODE_0697				;$09A7		|
	call CODE_12F2				;$09AA		|
	mov a, #$00				;$09AD		|
	mov $04, a				;$09AF		|
	mov $05, a				;$09B1		|
	mov $06, a				;$09B3		|
	mov $07, a				;$09B5		|
	mov $1D, a				;$09B7		|
	mov $0387, a				;$09B9		|
	mov $0388, a				;$09BC		|
	mov $0386, a				;$09BF		|
	mov $0389, a				;$09C2		|
	mov a, #$20				;$09C5		|
	mov y, #$6C				;$09C7		|
	call CODE_0697				;$09C9		|
	ret					;$09CC		|

CODE_09CD:
	mov a, #$B0
	mov y, #$02				;$09CF		|
	dec $90+x				;$09D1		|
	call CODE_1075				;$09D3		|
	mov a, $02B1+x				;$09D6		|
	mov y, a				;$09D9		|
	mov a, $02B0+x				;$09DA		|
	movw $10, ya				;$09DD		|
	mov $48, #$00				;$09DF		|
	jmp CODE_0634				;$09E2		|

CODE_09E5:
	mov a, $01
	cmp a, #$FF				;$09E7		|
	beq CODE_099C				;$09E9		|
	cmp a, #$02				;$09EB		|
	beq CODE_097D				;$09ED		|
	cmp a, #$03				;$09EF		|
	beq CODE_0995				;$09F1		|
	cmp a, #$01				;$09F3		|
	beq CODE_0A14				;$09F5		|
	mov a, $05				;$09F7		|
	cmp a, #$01				;$09F9		|
	beq CODE_0A03				;$09FB		|
	mov a, $01				;$09FD		|
	cmp a, #$04				;$09FF		|
	beq CODE_0A0E				;$0A01		|
CODE_0A03:
	mov a, $05
	cmp a, #$01				;$0A05		|
	beq CODE_0A51				;$0A07		|
	cmp a, #$04				;$0A09		|
	beq CODE_0A11				;$0A0B		|
CODE_0A0D:
	ret

CODE_0A0E:
	jmp CODE_0ACE

CODE_0A11:
	jmp CODE_0B08

CODE_0A14:
	mov $05, a
	mov a, #$04				;$0A16		|
	mov $0383, a				;$0A18		|
	mov a, #$80				;$0A1B		|
	mov y, #$5C				;$0A1D		|
	call CODE_0697				;$0A1F		|
	set1 $1D.7				;$0A22		|
	mov a, #$00				;$0A24		|
	mov y, #$20				;$0A26		|
CODE_0A28:
	mov $02FF+y, a
	dbnz y, CODE_0A28			;$0A2B		|
	ret					;$0A2D		|

CODE_0A2E:
	dec $0383
	bne CODE_0A0D				;$0A31		|
	mov $1C, #$30				;$0A33		|
	bra CODE_0A68				;$0A36		|
CODE_0A38:
	cmp $1C, #$2A
	bne CODE_0A99				;$0A3B		|
	mov $46, #$0E				;$0A3D		|
	mov x, #$0E				;$0A40		|
	mov y, #$00				;$0A42		|
	mov $9F, y				;$0A44		|
	mov y, #$12				;$0A46		|
	mov $9E, y				;$0A48		|
	mov a, #$B9				;$0A4A		|
	call CODE_0F5D				;$0A4C		|
	bra CODE_0A99				;$0A4F		|

CODE_0A51:
	mov a, $0383
	bne CODE_0A2E				;$0A54		|
	dbnz $1C, CODE_0A38			;$0A56		|
	mov $05, #$00				;$0A59		|
	clr1 $1D.7				;$0A5C		|
	mov x, #$0E				;$0A5E		|
	mov a, $CF				;$0A60		|
	beq CODE_0A67				;$0A62		|
	jmp CODE_0D4B				;$0A64		|
CODE_0A67:
	ret

CODE_0A68:
	call CODE_0AB1
	mov a, #$B2				;$0A6B		|
	mov $46, #$0E				;$0A6D		|
	mov x, #$0E				;$0A70		|
	call CODE_05C5				;$0A72		|
	mov y, #$00				;$0A75		|
	mov $9F, y				;$0A77		|
	mov y, #$05				;$0A79		|
	mov $9E, y				;$0A7B		|
	mov a, #$B5				;$0A7D		|
	call CODE_0F5D				;$0A7F		|
	mov a, #$38				;$0A82		|
	mov $10, a				;$0A84		|
	mov y, #$70				;$0A86		|
	call CODE_0697				;$0A88		|
	mov a, #$38				;$0A8B		|
	mov $10, a				;$0A8D		|
	mov y, #$71				;$0A8F		|
	call CODE_0697				;$0A91		|
	mov a, #$80				;$0A94		|
	call CODE_0D32				;$0A96		|
CODE_0A99:
	mov a, #$02
	cbne $1C, CODE_0AA5			;$0A9B		|
	mov a, #$80				;$0A9E		|
	mov y, #$5C				;$0AA0		|
	call CODE_0697				;$0AA2		|
CODE_0AA5:
	clr1 $13.7
	mov a, $9E				;$0AA7		|
	beq CODE_0AB0				;$0AA9		|
	mov x, #$0E				;$0AAB		|
	call CODE_09CD				;$0AAD		|
CODE_0AB0:
	ret

CODE_0AB1:
	mov a, #$08
CODE_0AB3:
	mov y, #$09
	mul ya					;$0AB5		|
	mov x, a				;$0AB6		|
	mov y, #$70				;$0AB7		|
	mov $12, #$08				;$0AB9		|
CODE_0ABC:
	mov a, $5570+x
	call CODE_0697				;$0ABF		|
	inc x					;$0AC2		|
	inc y					;$0AC3		|
	dbnz $12, CODE_0ABC			;$0AC4		|
	mov a, $5570+x				;$0AC7		|
	mov $021E, a				;$0ACA		|
	ret					;$0ACD		|

CODE_0ACE:
	mov $05, a
	mov a, #$04				;$0AD0		|
	mov $0383, a				;$0AD2		|
	mov a, #$80				;$0AD5		|
	mov y, #$5C				;$0AD7		|
	call CODE_0697 				;$0AD9		|
	set1 $1D.7				;$0ADC		|
	mov a, #$00				;$0ADE		|
	mov y, #$20				;$0AE0		|
CODE_0AE2:
	mov $02FF+y, a
	dbnz y, CODE_0AE2			;$0AE5		|
CODE_0AE7:
	ret

CODE_0AE8:
	dec $0383
	bne CODE_0AE7				;$0AEB		|
	mov $1C, #$18				;$0AED		|
	bra CODE_0AF7				;$0AF0		|

CODE_0AF2:
	cmp $1C, #$0C
	bne CODE_0B33				;$0AF5		|
CODE_0AF7:
	mov a, #$07
	call CODE_0AB3				;$0AF9		|
	mov a, #$A4				;$0AFC		|
	mov $46, #$0E				;$0AFE		|
	mov x, #$0E				;$0B01		|
	call CODE_05C5				;$0B03		|
	bra CODE_0B1C				;$0B06		|

CODE_0B08:
	mov a, $0383
	bne CODE_0AE8				;$0B0B		|
	dbnz $1C, CODE_0AF2			;$0B0D		|
	mov $05, #$00				;$0B10		|
	clr1 $1D.7				;$0B13		|
	mov x, #$0E				;$0B15		|
	mov a, $CF				;$0B17		|
	jmp CODE_0D4B				;$0B19		|
CODE_0B1C:
	mov a, #$28
	mov $10, a				;$0B1E		|
	mov y, #$70				;$0B20		|
	call CODE_0697				;$0B22		|
	mov a, #$28				;$0B25		|
	mov $10, a				;$0B27		|
	mov y, #$71				;$0B29		|
	call CODE_0697				;$0B2B		|
	mov a, #$80				;$0B2E		|
	call CODE_0D32				;$0B30		|
CODE_0B33:
	mov a, #$02
	cbne $1C, CODE_0B3F			;$0B35		|
	mov a, #$80				;$0B38		|
	mov y, #$5C				;$0B3A		|
	call CODE_0697				;$0B3C		|
CODE_0B3F:
	ret

CODE_0B40:
	setc
	cmp a, #$16				;$0B41		|
	beq CODE_0B55				;$0B43		|
	cmp a, #$10				;$0B45		|
	beq CODE_0B55				;$0B47		|
	cmp a, #$0F				;$0B49		|
	beq CODE_0B55				;$0B4B		|
	cmp a, #$09				;$0B4D		|
	bcc CODE_0B5A				;$0B4F		|
	cmp a, #$0D				;$0B51		|
	bcs CODE_0B5A				;$0B53		|
CODE_0B55:
	mov y, #$00
	mov $0387, y				;$0B57		|
CODE_0B5A:
	mov $06, a
	mov $0C, #$02				;$0B5C		|
	asl a					;$0B5F		|
	mov y, a				;$0B60		|
	mov a, $135E+y				;$0B61		|
	mov $40, a				;$0B64		|
	mov a, $135F+y				;$0B66		|
	mov $41, a				;$0B69		|
	mov x, #$0E				;$0B6B		|
CODE_0B6D:
	mov a, #$0A
	mov $0281+x, a				;$0B6F		|
	mov a, #$FF				;$0B72		|
	mov $0241+x, a				;$0B74		|
	mov a, #$00				;$0B77		|
	mov $02D1+x, a				;$0B79		|
	mov $81+x, a				;$0B7C		|
	mov $80+x, a				;$0B7E		|
	mov $A1+x, a				;$0B80		|
	mov $B1+x, a				;$0B82		|
	mov $C0+x, a				;$0B84		|
	mov $C1+x, a				;$0B86		|
	dec x					;$0B88		|
	dec x					;$0B89		|
	bpl CODE_0B6D				;$0B8A		|
	mov $58, a				;$0B8C		|
	mov $60, a				;$0B8E		|
	mov $52, a				;$0B90		|
	mov $43, a				;$0B92		|
	mov $57, #$C0				;$0B94		|
	mov $51, #$36				;$0B97		|
	mov y, #$20				;$0B9A		|
CODE_0B9C:
	mov $02FF+y, a
	dbnz y, CODE_0B9C			;$0B9F		|
	bra CODE_0BA5				;$0BA1		|

CODE_0BA3:
	mov $06, a
CODE_0BA5:
	mov a, $1D
	eor a, #$FF				;$0BA7		|
	mov y, #$5C				;$0BA9		|
	jmp CODE_0697				;$0BAB		|

CODE_0BAE:
	mov x, #$F0
	mov $58, x				;$0BB0		|
	mov a, #$00				;$0BB2		|
	mov $59, a				;$0BB4		|
	setc					;$0BB6		|
	sbc a, $57				;$0BB7		|
	call CODE_0F76				;$0BB9		|
	movw $5A, ya				;$0BBC		|
	bra CODE_0BE7				;$0BBE		|

CODE_0BC0:
	mov a, $06
	beq CODE_0BDE				;$0BC2		|
	cmp a, #$06				;$0BC4		|
	beq CODE_0BCC				;$0BC6		|
	and a, #$FC				;$0BC8		|
	bne CODE_0BDC				;$0BCA		|
CODE_0BCC:
	mov a, $0386
	bne CODE_0BDC				;$0BCF		|
	mov a, #$20				;$0BD1		|
	mov y, #$5C				;$0BD3		|
	call CODE_0697				;$0BD5		|
	set1 $1D.5				;$0BD8		|
	bra CODE_0BDE				;$0BDA		|

CODE_0BDC:
	clr1 $1D.5
CODE_0BDE:
	mov a, $02
	bmi CODE_0BAE				;$0BE0		|
	beq CODE_0BE7				;$0BE2		|
	jmp CODE_0B40				;$0BE4		|

CODE_0BE7:
	mov a, $0C
	bne CODE_0BFE				;$0BE9		|
	mov a, $06				;$0BEB		|
	bne CODE_0C46				;$0BED		|
CODE_0BEF:
	ret

CODE_0BF0:
	mov y, #$00
	mov a, ($40)+y				;$0BF2		|
	incw $40				;$0BF4		|
	push a					;$0BF6		|
	mov a, ($40)+y				;$0BF7		|
	incw $40				;$0BF9		|
	mov y, a				;$0BFB		|
	pop a					;$0BFC		|
	ret					;$0BFD		|

CODE_0BFE:
	dbnz $0C, CODE_0BEF
CODE_0C01:
	call CODE_0BF0
	movw $16, ya				;$0C04		|
	mov a, y				;$0C06		|
	bne CODE_0C22				;$0C07		|
	mov a, $16				;$0C09		|
	beq CODE_0BA3				;$0C0B		|
	dec $42					;$0C0D		|
	beq CODE_0C1C				;$0C0F		|
	bpl CODE_0C15				;$0C11		|
	mov $42, a				;$0C13		|
CODE_0C15:
	call CODE_0BF0
	movw $40, ya				;$0C18		|
	bra CODE_0C01				;$0C1A		|

CODE_0C1C:
	incw $40
	incw $40				;$0C1E		|
	bra CODE_0C01				;$0C20		|
CODE_0C22:
	mov y, #$0F
CODE_0C24:
	mov a, ($16)+y
	mov $0030+y, a				;$0C26		|
	dec y					;$0C29		|
	bpl CODE_0C24				;$0C2A		|
	mov x, #$0E				;$0C2C		|
	mov $48, #$80				;$0C2E		|
CODE_0C31:
	mov a, $31+x
	beq CODE_0C40				;$0C33		|
	mov a, #$01				;$0C35		|
	mov $70+x, a				;$0C37		|
	mov a, $C1+x				;$0C39		|
	bne CODE_0C40				;$0C3B		|
	call CODE_0D4A				;$0C3D		|
CODE_0C40:
	lsr $48
	dec x					;$0C42		|
	dec x					;$0C43		|
	bpl CODE_0C31				;$0C44		|
CODE_0C46:
	mov x, #$00
	mov $47, x				;$0C48		|
	mov $48, #$01				;$0C4A		|
CODE_0C4D:
	mov $46, x
	mov a, $31+x				;$0C4F		|
	beq CODE_0CC9				;$0C51		|
	dec $70+x				;$0C53		|
	bne CODE_0CC6				;$0C55		|
CODE_0C57:
	call CODE_125E
	bne CODE_0C7A				;$0C5A		|
	mov a, $C0+x				;$0C5C		|
	beq CODE_0C01				;$0C5E		|
	dec $C0+x				;$0C60		|
	bne CODE_0C6E				;$0C62		|
	mov a, $03E0+x				;$0C64		|
	mov $30+x, a				;$0C67		|
	mov a, $03E1+x				;$0C69		|
	bra CODE_0C76				;$0C6C		|

CODE_0C6E:
	mov a, $03F0+x
	mov $30+x, a				;$0C71		|
	mov a, $03F1+x				;$0C73		|
CODE_0C76:
	mov $31+x, a
	bra CODE_0C57				;$0C78		|

CODE_0C7A:
	bmi CODE_0C9F
	mov $0200+x, a				;$0C7C		|
	call CODE_125E				;$0C7F		|
	bmi CODE_0C9F				;$0C82		|
	push a					;$0C84		|
	xcn a					;$0C85		|
	and a, #$07				;$0C86		|
	mov y, a				;$0C88		|
	mov a, DATA_1268+y			;$0C89		|
	mov $0201+x, a				;$0C8C		|
	pop a					;$0C8F		|
	and a, #$0F				;$0C90		|
	mov y, a				;$0C92		|
	mov a, DATA_1270+y			;$0C93		|
	mov $0211+x, a				;$0C96		|
	or ($5C), ($48)				;$0C99		|
	call CODE_125E				;$0C9C		|
CODE_0C9F:
	cmp a, #$DA
	bcc CODE_0CA8				;$0CA1		|
	call CODE_0D40				;$0CA3		|
	bra CODE_0C57				;$0CA6		|

CODE_0CA8:
	push a
	mov a, $48				;$0CA9		|
	and a, $1D				;$0CAB		|
	pop a					;$0CAD		|
	bne CODE_0CB3				;$0CAE		|
	call CODE_05C5				;$0CB0		|
CODE_0CB3:
	mov a, $0200+x
	mov $70+x, a				;$0CB6		|
	mov y, a				;$0CB8		|
	mov a, $0201+x				;$0CB9		|
	mul ya					;$0CBC		|
	mov a, y				;$0CBD		|
	bne CODE_0CC1				;$0CBE		|
	inc a					;$0CC0		|
CODE_0CC1:
	mov $0100+x, a
	bra CODE_0CC9				;$0CC4		|

CODE_0CC6:
	call CODE_10A1
CODE_0CC9:
	inc x
	inc x					;$0CCA		|
	asl $48					;$0CCB		|
	bcs CODE_0CD2				;$0CCD		|
	jmp CODE_0C4D				;$0CCF		|
CODE_0CD2:
	mov a, $52
	beq CODE_0CE3				;$0CD4		|
	dbnz $52, CODE_0CDD			;$0CD6		|
	movw ya, $52				;$0CD9		|
	bra CODE_0CE1				;$0CDB		|

CODE_0CDD:
	movw ya, $54
	addw ya, $50				;$0CDF		|
CODE_0CE1:
	movw $50, ya
CODE_0CE3:
	mov a, $60
	beq CODE_0D03				;$0CE5		|
	dbnz $60, CODE_0CF4			;$0CE7		|
	mov a, #$00				;$0CEA		|
	mov y, $62				;$0CEC		|
	movw $61, ya				;$0CEE		|
	mov y, $64				;$0CF0		|
	bra CODE_0CFE				;$0CF2		|

CODE_0CF4:
	movw ya, $65
	addw ya, $61				;$0CF6		|
	movw $61, ya				;$0CF8		|
	movw ya, $67				;$0CFA		|
	addw ya, $63				;$0CFC		|
CODE_0CFE:
	movw $63, ya
	call CODE_0EEB				;$0D00		|
CODE_0D03:
	mov a, $58
	beq CODE_0D17				;$0D05		|
	dbnz $58, CODE_0D0E			;$0D07		|
	movw ya, $58				;$0D0A		|
	bra CODE_0D12				;$0D0C		|

CODE_0D0E:
	movw ya, $5A
	addw ya, $56				;$0D10		|
CODE_0D12:
	movw $56, ya
	mov $5C, #$FF				;$0D14		|
CODE_0D17:
	mov x, #$0E
	mov $48, #$80				;$0D19		|
CODE_0D1C:
	mov a, $31+x
	beq CODE_0D23				;$0D1E		|
	call CODE_0FDB				;$0D20		|
CODE_0D23:
	lsr $48
	dec x					;$0D25		|
	dec x					;$0D26		|
	bpl CODE_0D1C				;$0D27		|
	mov $5C, #$00				;$0D29		|
	mov a, $1D				;$0D2C		|
	eor a, #$FF				;$0D2E		|
	and a, $47				;$0D30		|

CODE_0D32:
	push a
	mov y, #$5C				;$0D33		|
	mov a, #$00				;$0D35		|
	call CODE_0697				;$0D37		|
	pop a					;$0D3A		|
	mov y, #$4C				;$0D3B		|
	jmp CODE_0697				;$0D3D		|

CODE_0D40:
	asl a
	mov x, a				;$0D41		|
	mov a, #$00				;$0D42		|
	jmp (CODE_0F90-$B4+x)			;$0D44		|

CODE_0D47:
	call CODE_125C

CODE_0D4A:
	inc a
CODE_0D4B:
	mov $C1+x, a
	dec a					;$0D4D		|
	mov y, #$05				;$0D4E		|
	mov $14, #$46				;$0D50		|
	mov $15, #$5F				;$0D53		|

CODE_0D56:
	mul ya
	addw ya, $14				;$0D57		|
	movw $14, ya				;$0D59		|
	mov a, $48				;$0D5B		|
	and a, $1D				;$0D5D		|
	bne CODE_0D8D				;$0D5F		|
	push x					;$0D61		|
	mov a, x				;$0D62		|
	xcn a					;$0D63		|
	lsr a					;$0D64		|
	or a, #$04				;$0D65		|
	mov x, a				;$0D67		|
	mov a, $48				;$0D68		|
	eor a, #$FF				;$0D6A		|
	and a, $2F				;$0D6C		|
	mov $2F, a				;$0D6E		|
	mov y, #$3D				;$0D70		|
	call CODE_0697				;$0D72		|
	mov y, #$00				;$0D75		|
CODE_0D77:
	mov a, ($14)+y
	mov $00F2, x				;$0D79		|
	mov $00F3, a				;$0D7C		|
	inc x					;$0D7F		|
	inc y					;$0D80		|
	cmp y, #$04				;$0D81		|
	bne CODE_0D77				;$0D83		|
	mov a, ($14)+y				;$0D85		|
	pop x					;$0D87		|
	mov $0210+x, a				;$0D88		|
	mov a, #$00				;$0D8B		|
CODE_0D8D:
	ret

CODE_0D8E:
	call CODE_125C
	and a, #$1F				;$0D91		|
	mov $0281+x, a				;$0D93		|
	mov a, y				;$0D96		|
	and a, #$C0				;$0D97		|
	mov $02A1+x, a				;$0D99		|
	mov a, #$00				;$0D9C		|
	mov $0280+x, a				;$0D9E		|
	or ($5C), ($48)				;$0DA1		|
	ret					;$0DA4		|

CODE_0DA5:
	call CODE_125C
	mov $81+x, a				;$0DA8		|
	push a					;$0DAA		|
	call CODE_125E				;$0DAB		|
	mov $02A0+x, a				;$0DAE		|
	setc					;$0DB1		|
	sbc a, $0281+x				;$0DB2		|
	pop x					;$0DB5		|
	call CODE_0F76				;$0DB6		|
	mov $0290+x, a				;$0DB9		|
	mov a, y				;$0DBC		|
	mov $0291+x, a				;$0DBD		|
	ret					;$0DC0		|

CODE_0DC1:
	call CODE_125C
	mov $0340+x, a				;$0DC4		|
	mov a, #$00				;$0DC7		|
	mov $0341+x, a				;$0DC9		|
	call CODE_125E				;$0DCC		|
	mov $0331+x, a				;$0DCF		|

	call CODE_125E				;$0DD2		|
CODE_0DD5:
	mov x, $46
	mov $A1+x, a				;$0DD7		|
	ret					;$0DD9		|

CODE_0DDA:
	call CODE_125C
	mov $0341+x, a				;$0DDD		|
	push a					;$0DE0		|
	mov a, $A1+x				;$0DE1		|
	mov $0351+x, a				;$0DE3		|
	pop x					;$0DE6		|
	mov y, #$00				;$0DE7		|
	div ya, x				;$0DE9		|
	mov x, $46				;$0DEA		|
	mov $0350+x, a				;$0DEC		|
	ret					;$0DEF		|

CODE_0DF0:
	call CODE_125C
	mov $57, a				;$0DF3		|
	mov $56, #$00				;$0DF5		|
	mov $5C, #$FF				;$0DF8		|
	ret					;$0DFB		|

CODE_0DFC:
	call CODE_125C
	mov $58, a				;$0DFF		|
	call CODE_125E				;$0E01		|
	mov $59, a				;$0E04		|
	mov x, $58				;$0E06		|
	setc					;$0E08		|
	sbc a, $57				;$0E09		|
	call CODE_0F76				;$0E0B		|
	movw $5A, ya				;$0E0E		|
	ret					;$0E10		|

CODE_0E11:
	call CODE_125C

CODE_0E14:
	adc a, $0387
	mov $51, a				;$0E17		|
	mov $50, #$00				;$0E19		|
	ret					;$0E1C		|

CODE_0E1D:
	call CODE_125C
	mov $52, a				;$0E20		|
	call CODE_125E				;$0E22		|
	adc a, $0387				;$0E25		|
	mov $53, a				;$0E28		|
	mov x, $52				;$0E2A		|
	setc					;$0E2C		|
	sbc a, $51				;$0E2D		|
	call CODE_0F76				;$0E2F		|
	movw $54, ya				;$0E32		|
	ret					;$0E34		|

CODE_0E35:
	call CODE_125C
	mov $43, a				;$0E38		|
	ret					;$0E3A		|

CODE_0E3B:
	call CODE_125C
	mov $0370+x, a				;$0E3E		|
	call CODE_125E				;$0E41		|
	mov $0362+x, a				;$0E44		|
	call CODE_125E				;$0E47		|

CODE_0E4A:
	mov x, $46
	mov $B1+x, a				;$0E4C		|
	ret					;$0E4E		|

CODE_0E4F:
	mov a, #$01
	bra CODE_0E55				;$0E51		|

CODE_0E53:
	mov a, #$00
CODE_0E55:
	mov x, $46
	mov $0320+x, a				;$0E57		|
	call CODE_125C				;$0E5A		|
	mov $0301+x, a				;$0E5D		|
	call CODE_125E				;$0E60		|
	mov $0300+x, a				;$0E63		|
	call CODE_125E				;$0E66		|
	mov $0321+x, a				;$0E69		|
	ret					;$0E6C		|

	mov x, $46				;$0E6D		|
	mov $0300+x, a				;$0E6F		|
	ret					;$0E72		|

CODE_0E73:
	call CODE_125C
	mov $0241+x, a				;$0E76		|
	mov a, #$00				;$0E79		|
	mov $0240+x, a				;$0E7B		|
	or ($5C), ($48)				;$0E7E		|
	ret					;$0E81		|

CODE_0E82:
	call CODE_125C
	mov $80+x, a				;$0E85		|
	push a					;$0E87		|
	call CODE_125E				;$0E88		|
	mov $0260+x, a				;$0E8B		|
	setc					;$0E8E		|
	sbc a, $0241+x				;$0E8F		|
	pop x					;$0E92		|
	call CODE_0F76				;$0E93		|
	mov $0250+x, a				;$0E96		|
	mov a, y				;$0E99		|
	mov $0251+x, a				;$0E9A		|
	ret					;$0E9D		|

CODE_0E9E:
	call CODE_125C
	mov $02D1+x, a				;$0EA1		|
	ret					;$0EA4		|

CODE_0EA5:
	call CODE_125C
	push a					;$0EA8		|
	call CODE_125E				;$0EA9		|
	push a					;$0EAC		|
	call CODE_125E				;$0EAD		|
	mov $C0+x, a				;$0EB0		|
	mov a, $30+x				;$0EB2		|
	mov $03E0+x, a				;$0EB4		|
	mov a, $31+x				;$0EB7		|
	mov $03E1+x, a				;$0EB9		|
	pop a					;$0EBC		|
	mov $31+x, a				;$0EBD		|
	mov $03F1+x, a				;$0EBF		|
	pop a					;$0EC2		|
	mov $30+x, a				;$0EC3		|
	mov $03F0+x, a				;$0EC5		|
	ret					;$0EC8		|

CODE_0EC9:
	call CODE_125C
	mov $0389, a				;$0ECC		|
	mov y, #$4D				;$0ECF		|
	call CODE_0697				;$0ED1		|
	call CODE_125E				;$0ED4		|
	mov a, #$00				;$0ED7		|
	movw $61, ya				;$0ED9		|
	call CODE_125E				;$0EDB		|
	mov a, #$00				;$0EDE		|
	movw $63, ya				;$0EE0		|
	mov $2E, a				;$0EE2		|
	and a, #$1F				;$0EE4		|
	mov y, #$6C				;$0EE6		|
	call CODE_0697				;$0EE8		|

CODE_0EEB:
	mov a, $62
	mov y, #$2C				;$0EED		|
	call CODE_0697				;$0EEF		|
	mov a, $64				;$0EF2		|
	mov y, #$3C				;$0EF4		|
	jmp CODE_0697				;$0EF6		|

CODE_0EF9:
	call CODE_125C
	mov $60, a				;$0EFC		|
	call CODE_125E				;$0EFE		|
	mov $69, a				;$0F01		|
	mov x, $60				;$0F03		|
	setc					;$0F05		|
	sbc a, $62				;$0F06		|
	call CODE_0F76				;$0F08		|
	movw $65, ya				;$0F0B		|
	call CODE_125E				;$0F0D		|
	mov $6A, a				;$0F10		|
	mov x, $60				;$0F12		|
	setc					;$0F14		|
	sbc a, $64				;$0F15		|
	call CODE_0F76				;$0F17		|
	movw $67, ya				;$0F1A		|
	ret					;$0F1C		|

CODE_0F1D:
	mov x, $46
	mov $0389, a				;$0F1F		|
CODE_0F22:
	mov y, a
	movw $61, ya				;$0F23		|
	movw $63, ya				;$0F25		|
	call CODE_0EEB				;$0F27		|
	mov $2E, a				;$0F2A		|
	or a, #$20				;$0F2C		|
	mov y, #$6C				;$0F2E		|
	jmp CODE_0697				;$0F30		|

CODE_0F33:
	call CODE_125C
	mov y, #$7D				;$0F36		|
	call CODE_0697				;$0F38		|
	call CODE_125E				;$0F3B		|
	mov y, #$0D				;$0F3E		|
	call CODE_0697				;$0F40		|
	call CODE_125E				;$0F43		|
	mov y, #$08				;$0F46		|
	mul ya					;$0F48		|
	mov x, a				;$0F49		|
	mov y, #$0F				;$0F4A		|
CODE_0F4C:
	mov a, DATA_12AD+x
	call CODE_0697				;$0F4F		|
	inc x					;$0F52		|
	mov a, y				;$0F53		|
	clrc					;$0F54		|
	adc a, #$10				;$0F55		|
	mov y, a				;$0F57		|
	bpl CODE_0F4C				;$0F58		|
	mov x, $46				;$0F5A		|
	ret					;$0F5C		|

CODE_0F5D:
	and a, #$7F
	mov $02D0+x, a				;$0F5F		|
	setc					;$0F62		|
	sbc a, $02B1+x				;$0F63		|
	push a					;$0F66		|
	mov a, $90+x				;$0F67		|
	mov x, a				;$0F69		|
	pop a					;$0F6A		|
	call CODE_0F76				;$0F6B		|
	mov $02C0+x, a				;$0F6E		|
	mov a, y				;$0F71		|
	mov $02C1+x, a				;$0F72		|
	ret					;$0F75		|

CODE_0F76:
	bcs CODE_0F85
	eor a, #$FF				;$0F78		|
	inc a					;$0F7A		|
	call CODE_0F85				;$0F7B		|
	movw $14, ya				;$0F7E		|
	movw ya, $0E				;$0F80		|
	subw ya, $14				;$0F82		|
	ret					;$0F84		|

CODE_0F85:
	mov y, #$00
	div ya, x				;$0F87		|
	push a					;$0F88		|
	mov a, #$00				;$0F89		|
	div ya, x				;$0F8B		|
	pop y					;$0F8C		|
	mov x, $46				;$0F8D		|
	ret					;$0F8F		|

CODE_0F90:
	dw CODE_0D47
	dw CODE_0D8E				;$0F92		|
	dw CODE_0DA5				;$0F94		|
	dw $0000				;$0F96		|
	dw CODE_0DC1				;$0F98		|
	dw CODE_0DD5				;$0F9A		|
	dw CODE_0DF0				;$0F9C		|
	dw CODE_0DFC				;$0F9E		|
	dw CODE_0E11				;$0FA0		|
	dw CODE_0E1D				;$0FA2		|
	dw CODE_0E35				;$0FA4		|
	dw CODE_0E3B				;$0FA6		|
	dw CODE_0E4A				;$0FA8		|
	dw CODE_0E73				;$0FAA		|
	dw CODE_0E82				;$0FAC		|
	dw CODE_0EA5				;$0FAE		|
	dw CODE_0DDA				;$0FB0		|
	dw CODE_0E4F				;$0FB2		|
	dw CODE_0E53				;$0FB4		|
	dw $0000				;$0FB6		|
	dw CODE_0E9E				;$0FB8		|
	dw CODE_0EC9				;$0FBA		|
	dw CODE_0F1D				;$0FBC		|
	dw CODE_0F33				;$0FBE		|
	dw CODE_0EF9				;$0FC0		|

DATA_0FC2:
	db $02,$02,$03,$04,$04,$01,$02,$03
	db $02,$03,$02,$04,$01,$02,$03,$04
	db $02,$04,$04,$01,$02,$04,$01,$04
	db $04

CODE_0FDB:
	mov a, $80+x
	beq CODE_0FEB				;$0FDD		|
	or ($5C), ($48)				;$0FDF		|
	mov a, #$40				;$0FE2		|
	mov y, #$02				;$0FE4		|
	dec $80+x				;$0FE6		|
	call CODE_1075				;$0FE8		|
CODE_0FEB:
	mov a, $B1+x
	mov y, a				;$0FED		|
	beq CODE_1013				;$0FEE		|
	mov a, $0370+x				;$0FF0		|
	cbne $B0+x, CODE_1011			;$0FF3		|
	or ($5C), ($48)				;$0FF6		|
	mov a, $0360+x				;$0FF9		|
	bpl CODE_1005				;$0FFC		|
	inc y					;$0FFE		|
	bne CODE_1005				;$0FFF		|
	mov a, #$80				;$1001		|
	bra CODE_1009				;$1003		|
CODE_1005:
	clrc
	adc a, $0362+x				;$1006		|
CODE_1009:
	mov $0360+x, a
	call CODE_123A				;$100C		|
	bra CODE_1019				;$100F		|

CODE_1011:
	inc $B0+x
CODE_1013:
	mov a, $0211+x
	call CODE_124D				;$1016		|
CODE_1019:
	mov a, $81+x
	bne CODE_1024				;$101B		|
	mov a, $48				;$101D		|
	and a, $5C				;$101F		|
	bne CODE_102D				;$1021		|
	ret					;$1023		|

CODE_1024:
	mov a, #$80
	mov y, #$02				;$1026		|
	dec $81+x				;$1028		|
	call CODE_1075				;$102A		|
CODE_102D:
	mov a, $0281+x
	mov y, a				;$1030		|
	mov a, $0280+x				;$1031		|
	movw $10, ya				;$1034		|

CODE_1036:
	mov a, x
	xcn a					;$1037		|
	lsr a					;$1038		|
	mov $12, a				;$1039		|
CODE_103B:
	mov y, $11
	mov a, DATA_1280+1+y			;$103D		|
	setc					;$1040		|
	sbc a, DATA_1280+y			;$1041		|
	mov y, $10				;$1044		|
	mul ya					;$1046		|
	mov a, y				;$1047		|
	mov y, $11				;$1048		|
	clrc					;$104A		|
	adc a, DATA_1280+y			;$104B		|
	mov y, a				;$104E		|
	mov a, $0371+x				;$104F		|
	mul ya					;$1052		|
	mov a, $02A1+x				;$1053		|
	bbc $12.0, CODE_105A			;$1056		|
	asl a					;$1059		|
CODE_105A:
	bpl CODE_1061
	mov a, y				;$105C		|
	eor a, #$FF				;$105D		|
	inc a					;$105F		|
	mov y, a				;$1060		|
CODE_1061:
	mov a, y
	mov y, $12				;$1062		|
	call CODE_068F				;$1064		|
	mov a, #$00				;$1067		|
	mov y, #$14				;$1069		|
	subw ya, $10				;$106B		|
	movw $10, ya				;$106D		|
	inc $12					;$106F		|
	bbc $12.1, CODE_103B			;$1071		|
	ret					;$1074		|

CODE_1075:
	movw $14, ya
	bne CODE_1088				;$1077		|
	clrc					;$1079		|
	adc a, #$20				;$107A		|
	movw $16, ya				;$107C		|
	mov a, x				;$107E		|
	mov y, a				;$107F		|
	mov a, #$00				;$1080		|
	push a					;$1082		|
	mov a, ($16)+y				;$1083		|
	inc y					;$1085		|
	bra CODE_109A				;$1086		|

CODE_1088:
	clrc
	adc a, #$10				;$1089		|
	movw $16, ya				;$108B		|
	mov a, x				;$108D		|
	mov y, a				;$108E		|
	mov a, ($14)+y				;$108F		|
	clrc					;$1091		|
	adc a, ($16)+y				;$1092		|
	push a					;$1094		|
	inc y					;$1095		|
	mov a, ($14)+y				;$1096		|
	adc a, ($16)+y				;$1098		|
CODE_109A:
	mov ($14)+y, a
	dec y					;$109C		|
	pop a					;$109D		|
	mov ($14)+y, a				;$109E		|
	ret					;$10A0		|

CODE_10A1:
	setp
	dec $00+x				;$10A2		|
	clrp					;$10A4		|
	beq CODE_10AC				;$10A5		|
	mov a, #$02				;$10A7		|
	cbne $70+x, CODE_10D8			;$10A9		|
CODE_10AC:
	mov a, $30+x
	mov y, $31+x				;$10AE		|
	movw $14, ya				;$10B0		|
	mov y, #$00				;$10B2		|
CODE_10B4:
	mov a, ($14)+y
	beq CODE_10D1				;$10B6		|
	bmi CODE_10BF				;$10B8		|
CODE_10BA:
	inc y
	mov a, ($14)+y				;$10BB		|
	bpl CODE_10BA				;$10BD		|
CODE_10BF:
	cmp a, #$C6
	beq CODE_10D8				;$10C1		|
	cmp a, #$DA				;$10C3		|
	bcc CODE_10D1				;$10C5		|
	push y					;$10C7		|
	mov y, a				;$10C8		|
	pop a					;$10C9		|
	clrc					;$10CA		|
	adc a, CODE_0F90-$A8+y			;$10CB		|
	mov y, a				;$10CE		|
	bra CODE_10B4				;$10CF		|

CODE_10D1:
	mov a, $48
	mov y, #$5C				;$10D3		|
	call CODE_068F				;$10D5		|
CODE_10D8:
	clr1 $13.7
	mov a, $90+x				;$10DA		|
	beq CODE_10E4				;$10DC		|
	mov a, $48				;$10DE		|
	and a, $1D				;$10E0		|
	beq CODE_1111				;$10E2		|
CODE_10E4:
	mov a, ($30+x)
	cmp a, #$DD				;$10E6		|
	bne CODE_112A				;$10E8		|
	mov a, $48				;$10EA		|
	and a, $1D				;$10EC		|
	beq CODE_10FB				;$10EE		|
	mov $10, #$04				;$10F0		|
CODE_10F3:
	call CODE_1260
	dbnz $10, CODE_10F3			;$10F6		|
	bra CODE_1111				;$10F9		|

CODE_10FB:
	call CODE_1260
	call CODE_125E				;$10FE		|
	mov $91+x, a				;$1101		|
	call CODE_125E				;$1103		|
	mov $90+x, a				;$1106		|
	call CODE_125E				;$1108		|
	clrc					;$110B		|
	adc a, $43				;$110C		|
	call CODE_0F5D				;$110E		|
CODE_1111:
	mov a, $91+x
	beq CODE_1119				;$1113		|
	dec $91+x				;$1115		|
	bra CODE_112A				;$1117		|

CODE_1119:
	mov a, $1D
	and a, $48				;$111B		|
	bne CODE_112A				;$111D		|
	set1 $13.7				;$111F		|
	mov a, #$B0				;$1121		|
	mov y, #$02				;$1123		|
	dec $90+x				;$1125		|
	call CODE_1075				;$1127		|
CODE_112A:
	mov a, $02B1+x
	mov y, a				;$112D		|
	mov a, $02B0+x				;$112E		|
	movw $10, ya				;$1131		|
	mov a, $A1+x				;$1133		|
	beq CODE_1140				;$1135		|
	mov a, $0340+x				;$1137		|
	cmp a, $A0+x				;$113A		|
	beq CODE_1144				;$113C		|
	inc $A0+x				;$113E		|
CODE_1140:
	bbs $13.7, CODE_1195
	ret					;$1143		|

CODE_1144:
	mov a, $0341+x
	beq CODE_1166				;$1147		|
	cmp a, $0110+x				;$1149		|
	bne CODE_1155				;$114C		|
	mov a, $0351+x				;$114E		|
	mov $A1+x, a				;$1151		|
	bra CODE_1166				;$1153		|

CODE_1155:
	mov a, $0110+x
	beq CODE_115C				;$1158		|
	mov a, $A1+x				;$115A		|
CODE_115C:
	clrc
	adc a, $0350+x				;$115D		|
	mov $A1+x, a				;$1160		|
	setp					;$1162		|
	inc $10+x				;$1163		|
	clrp					;$1165		|
CODE_1166:
	mov a, $0330+x
	clrc					;$1169		|
	adc a, $0331+x				;$116A		|
	mov $0330+x, a				;$116D		|

CODE_1170:
	mov $12, a
	asl a					;$1172		|
	asl a					;$1173		|
	bcc CODE_1178				;$1174		|
	eor a, #$FF				;$1176		|
CODE_1178:
	mov y, a
	mov a, $A1+x				;$1179		|
	cmp a, #$F1				;$117B		|
	bcs CODE_1185				;$117D		|
	mul ya					;$117F		|
	mov a, y				;$1180		|
	mov y, #$00				;$1181		|
	bra CODE_1188				;$1183		|

CODE_1185:
	and a, #$0F
	mul ya					;$1187		|
CODE_1188:
	bbc $12.7, CODE_1191
	movw $12, ya				;$118B		|
	movw ya, $0E				;$118D		|
	subw ya, $12				;$118F		|
CODE_1191:
	addw ya, $10
	movw $10, ya				;$1193		|
CODE_1195:
	jmp CODE_0634

CODE_1198:
	clr1 $13.7
	mov a, $B1+x				;$119A		|
	beq CODE_11A7				;$119C		|
	mov a, $0370+x				;$119E		|
	cbne $B0+x, CODE_11A7			;$11A1		|
	call CODE_122D				;$11A4		|
CODE_11A7:
	mov a, $0281+x
	mov y, a				;$11AA		|
	mov a, $0280+x				;$11AB		|
	movw $10, ya				;$11AE		|
	mov a, $81+x				;$11B0		|
	bne CODE_11B9				;$11B2		|
	bbs $13.7, CODE_11C3			;$11B4		|
	bra CODE_11C6				;$11B7		|

CODE_11B9:
	mov a, $0291+x
	mov y, a				;$11BC		|
	mov a, $0290+x				;$11BD		|
	call CODE_1201				;$11C0		|
CODE_11C3:
	call CODE_1036
CODE_11C6:
	clr1 $13.7
	mov a, $02B1+x				;$11C8		|
	mov y, a				;$11CB		|
	mov a, $02B0+x				;$11CC		|
	movw $10, ya				;$11CF		|
	mov a, $90+x				;$11D1		|
	beq CODE_11E3				;$11D3		|
	mov a, $91+x				;$11D5		|
	bne CODE_11E3				;$11D7		|
	mov a, $02C1+x				;$11D9		|
	mov y, a				;$11DC		|
	mov a, $02C0+x				;$11DD		|
	call CODE_11FF				;$11E0		|
CODE_11E3:
	mov a, $A1+x
	bne CODE_11EB				;$11E5		|
CODE_11E7:
	bbs $13.7, CODE_1195
	ret					;$11EA		|

CODE_11EB:
	mov a, $0340+x
	cbne $A0+x, CODE_11E7			;$11EE		|
	mov y, $49				;$11F1		|
	mov a, $0331+x				;$11F3		|
	mul ya					;$11F6		|
	mov a, y				;$11F7		|
	clrc					;$11F8		|
	adc a, $0330+x				;$11F9		|
	jmp CODE_1170				;$11FC		|

CODE_11FF:
	set1 $13.7
CODE_1201:
	movw $16, ya
	mov $12, y				;$1203		|
	bbc $12.7, CODE_120E			;$1205		|
	movw ya, $0E				;$1208		|
	subw ya, $16				;$120A		|
	movw $16, ya				;$120C		|
CODE_120E:
	mov y, $49
	mov a, $16				;$1210		|
	mul ya					;$1212		|
	mov $14, y				;$1213		|
	mov $15, #$00				;$1215		|
	mov y, $49				;$1218		|
	mov a, $17				;$121A		|
	mul ya					;$121C		|
	addw ya, $14				;$121D		|
	bbc $12.7, CODE_1228			;$121F		|
	movw $14, ya				;$1222		|
	movw ya, $0E				;$1224		|
	subw ya, $14				;$1226		|
CODE_1228:
	addw ya, $10
	movw $10, ya				;$122A		|
	ret					;$122C		|

CODE_122D:
	set1 $13.7
	mov y, $49				;$122F		|
	mov a, $0362+x				;$1231		|
	mul ya					;$1234		|
	mov a, y				;$1235		|
	clrc					;$1236		|
	adc a, $0360+x				;$1237		|
CODE_123A:
	asl a
	bcc CODE_123F				;$123B		|
	eor a, #$FF				;$123D		|
CODE_123F:
	mov y, $B1+x
	mul ya					;$1241		|
	mov a, $0211+x				;$1242		|
	mul ya					;$1245		|
	mov a, y				;$1246		|
	eor a, #$FF				;$1247		|
	setc					;$1249		|
	adc a, $0211+x				;$124A		|
CODE_124D:
	mov y, a

	mov a, $0241+x				;$124E		|
	mul ya					;$1251		|
	mov a, $57				;$1252		|
	mul ya					;$1254		|
	mov a, y				;$1255		|
	mul ya					;$1256		|
	mov a, y				;$1257		|
	mov $0371+x, a				;$1258		|
	ret					;$125B		|

CODE_125C:
	mov x, $46

CODE_125E:
	mov a, ($30+x)
CODE_1260:
	inc $30+x
	bne CODE_1266				;$1262		|
	inc $31+x				;$1264		|
CODE_1266:
	mov y, a
	ret					;$1267		|

DATA_1268:
	db $33,$66,$80,$99,$B3,$CC,$E6,$FF
DATA_1270:
	db $08,$12,$1B,$24,$2C,$35,$3E,$47
	db $51,$5A,$62,$6B,$7D,$8F,$A1,$B3
DATA_1280:
	db $00,$01,$03,$07,$0D,$15,$1E,$29
	db $34,$42,$51,$5E,$67,$6E,$73,$77
	db $7A,$7C,$7D,$7E,$7F
DATA_1295:
	db $7F,$7F,$00,$00,$2F,$60,$00,$00
	db $00,$80,$60,$02
DATA_12A1:
	db $0C,$1C,$2C,$3C,$6C,$0D,$2D,$3D
	db $4D,$5D,$6D,$7D
DATA_12AD:
	db $FF,$08,$17,$24,$24,$17,$08,$FF
	db $7F,$00,$00,$00,$00,$00,$00,$00

CODE_12BD:
	mov y, #$00
	asl a					;$12BF		|
	mov x, #$18				;$12C0		|
	div ya, x				;$12C2		|
	mov x, a				;$12C3		|
	mov a, DATA_12D9+1+y			;$12C4		|
	mov $16, a				;$12C7		|
	mov a, DATA_12D9+y			;$12C9		|
	bra CODE_12D2				;$12CC		|
CODE_12CE:
	lsr $16
	ror a					;$12D0		|
	inc x					;$12D1		|
CODE_12D2:
	cmp x, #$06
	bne CODE_12CE				;$12D4		|
	mov y, $16				;$12D6		|
	ret					;$12D8		|

DATA_12D9:
	dw $10BE,$11BD,$12CB,$13E9,$1518,$1659,$17AD,$1916
	dw $1A94,$1C28,$1DD5,$1F9B
	db $00

CODE_12F2:
	mov a, #$AA
	mov $00F4, a				;$12F4		|
	mov a, #$BB				;$12F7		|
	mov $00F5, a				;$12F9		|
CODE_12FC:
	mov a, $00F4
	cmp a, #$CC				;$12FF		|
	bne CODE_12FC				;$1301		|
	bra CODE_1325				;$1303		|

CODE_1305:
	mov y, $00F4
	bne CODE_1305				;$1308		|
CODE_130A:
	cmp y, $00F4
	bne CODE_131E				;$130D		|
	mov a, $00F5				;$130F		|
	mov $00F4, y				;$1312		|
	mov ($14)+y, a				;$1315		|
	inc y					;$1317		|
	bne CODE_130A				;$1318		|
	inc $15					;$131A		|
	bra CODE_130A				;$131C		|
CODE_131E:
	bpl CODE_130A
	cmp y, $00F4				;$1320		|
	bpl CODE_130A				;$1323		|
CODE_1325:
	mov a, $00F6
	mov y, $00F7				;$1328		|
	movw $14, ya				;$132B		|
	mov y, $00F4				;$132D		|
	mov a, $00F5				;$1330		|
	mov $00F4, y				;$1333		|
	bne CODE_1305				;$1336		|
	mov x, #$31				;$1338		|
	mov $00F1, x				;$133A		|
	ret					;$133D		|

SPC_engine_end:

base off

sound_effects:
	dw .end-.start				;		| Length of sound effect data
	dw $5570				;		| Location of sound effect data in ARAM

.start
	db $70,$70,$00,$10,$06,$DF,$E0,$B8
	db $02,$70,$70,$00,$10,$00,$FE,$0A
	db $B8,$03,$70,$70,$00,$10,$03,$FE
	db $11,$B8,$03,$70,$70,$00,$10,$04
	db $FE,$6A,$B8,$03,$70,$70,$00,$10
	db $00,$FE,$11,$B8,$03,$70,$70,$00
	db $10,$08,$FE,$6A,$B8,$03,$70,$70
	db $00,$10,$02,$FE,$6A,$B8,$06,$70
	db $70,$00,$10,$06,$FE,$6A,$B8,$05
	db $70,$70,$00,$10,$00,$CA,$D7,$B8
	db $03,$70,$70,$00,$10,$10,$0E,$6A
	db $7F,$04,$70,$70,$00,$10,$0B,$FE
	db $6A,$B8,$02,$70,$70,$00,$10,$0B
	db $FF,$E0,$B8,$05,$70,$70,$00,$10
	db $0E,$FE,$00,$7F,$06,$70,$70,$00
	db $10,$00,$B6,$30,$30,$06,$70,$70
	db $00,$10,$12,$0E,$6A,$70,$03,$70
	db $70,$00,$10,$01,$FA,$6A,$70,$03
	db $70,$70,$00,$10,$02,$FE,$16,$70
	db $03,$70,$70,$00,$10,$13,$0E,$16
	db $7F,$03,$70,$70,$00,$10,$02,$FE
	db $33,$7F,$03,$B6,$5E,$07,$5D,$F9
	db $5C,$9C,$5E,$08,$5E,$8C,$5C,$BE
	db $5E,$00,$5B,$15,$5F,$7D,$5B,$6C
	db $5B,$1C,$5D,$1C,$5D,$31,$5B,$E9
	db $5E,$15,$5F,$25,$5F,$37,$5F,$A4
	db $5B,$BB,$5D,$4E,$5A,$1B,$5A,$14
	db $5A,$ED,$59,$E1,$59,$91,$59,$63
	db $59,$09,$59,$F6,$5B,$F5,$58,$E0
	db $58,$98,$59,$DF,$5C,$CC,$58,$D6
	db $58,$87,$58,$7D,$58,$58,$58,$51
	db $58,$04,$58,$F2,$57,$EA,$57,$95
	db $57,$64,$57,$E3,$56,$EB,$56,$F3
	db $56,$FB,$56,$03,$57,$0B,$57,$13
	db $57,$1B,$57,$EF,$5C,$CC,$5C,$94
	db $5C,$35,$5C,$1C,$5C,$8D,$5B,$4F
	db $5D,$EE,$5A,$46,$5B,$E5,$5D,$74
	db $5C,$3B,$5E,$6A,$5D,$5C,$5B,$83
	db $5E,$14,$5E,$27,$5B,$27,$5B,$9B
	db $5C,$A2,$5C,$A9,$5C,$B0,$5C,$B7
	db $5C,$BE,$5C,$C5,$5C,$DD,$5A,$DF
	db $5A,$B7,$5B,$D0,$5B,$D3,$5A,$6A
	db $5A,$5B,$5A,$30,$59,$26,$5B,$FA
	db $57,$26,$5B,$18,$58,$D8,$57,$A7
	db $57,$54,$57,$23,$57,$D7,$56,$DA
	db $12,$0C,$3C,$A4,$A7,$AA,$AD,$B0
	db $30,$B3,$00,$DA,$92,$0D,$12,$50
	db $00,$A4,$00,$DA,$92,$0D,$12,$46
	db $0A,$A4,$00,$DA,$92,$0D,$12,$3C
	db $14,$A4,$00,$DA,$92,$0D,$12,$32
	db $1E,$A4,$00,$DA,$92,$0D,$12,$1E
	db $32,$A4,$00,$DA,$92,$0D,$12,$14
	db $3C,$A4,$00,$DA,$92,$0D,$12,$0A
	db $46,$A4,$00,$DA,$92,$0D,$12,$00
	db $50,$A4,$00,$DA,$0A,$0C,$46,$46
	db $9C,$24,$0E,$08,$9C,$DA,$11,$24
	db $00,$00,$A4,$06,$08,$08,$A1,$12
	db $0C,$0C,$9F,$06,$0E,$10,$9C,$0C
	db $14,$15,$9B,$06,$18,$17,$99,$12
	db $0C,$11,$97,$12,$0B,$08,$93,$0C
	db $04,$02,$92,$00,$DA,$0D,$30,$0F
	db $DD,$BE,$00,$30,$BC,$1B,$0B,$EB
	db $00,$18,$BB,$00,$DA,$0A,$0C,$00
	db $72,$9C,$24,$0E,$08,$9C,$DA,$11
	db $24,$00,$00,$A4,$06,$00,$0C,$A1
	db $12,$02,$10,$9F,$06,$04,$16,$9C
	db $0C,$00,$1A,$9B,$06,$04,$21,$99
	db $12,$02,$14,$97,$12,$01,$12,$93
	db $0C,$04,$02,$92,$00,$DA,$0D,$30
	db $00,$14,$DD,$BE,$00,$30,$BC,$1B
	db $00,$11,$EB,$00,$18,$BB,$00,$DA
	db $0A,$0C,$72,$00,$9A,$24,$08,$0E
	db $9A,$DA,$11,$24,$00,$00,$A4,$06
	db $0C,$00,$A1,$12,$10,$02,$9F,$06
	db $16,$04,$9C,$0C,$1A,$00,$9B,$06
	db $21,$04,$99,$12,$14,$02,$97,$12
	db $12,$01,$93,$0C,$04,$02,$92,$00
	db $DA,$0D,$30,$14,$00,$DD,$BE,$00
	db $30,$BC,$1B,$11,$00,$EB,$00,$18
	db $BB,$00,$DA,$05,$06,$54,$93,$18
	db $93,$00,$DA,$12,$08,$3C,$B4,$24
	db $B0,$00,$DA,$0D,$27,$28,$DD,$BC
	db $00,$24,$9F,$00,$DA,$05,$08,$54
	db $DD,$98,$00,$08,$90,$08,$EB,$00
	db $08,$A8,$15,$EB,$00,$12,$95,$00
	db $DA,$11,$04,$28,$92,$04,$32,$95
	db $04,$3C,$98,$04,$46,$9B,$04,$50
	db $9E,$04,$4A,$9D,$04,$46,$9C,$04
	db $41,$9B,$04,$3C,$9A,$04,$37,$99
	db $04,$32,$98,$04,$2D,$97,$04,$28
	db $96,$04,$23,$95,$04,$1E,$94,$04
	db $19,$93,$04,$14,$92,$04,$0F,$91
	db $00,$DA,$92,$0D,$0E,$1E,$A4,$00
	db $DA,$98,$0F,$03,$32,$BC,$03,$00
	db $BC,$03,$50,$BC,$03,$00,$BC,$03
	db $3C,$BC,$03,$00,$BC,$03,$28,$BC
	db $03,$00,$BC,$03,$1E,$BC,$03,$00
	db $BC,$03,$14,$BC,$00,$DA,$0A,$0F
	db $54,$DD,$A4,$00,$0C,$9F,$00,$DA
	db $06,$03,$54,$AB,$A6,$03,$46,$AD
	db $A8,$03,$38,$AF,$A9,$03,$2A,$B0
	db $AB,$03,$00,$B0,$03,$54,$AB,$A6
	db $03,$46,$AD,$A8,$03,$38,$AF,$A9
	db $03,$2A,$B0,$AB,$03,$00,$B0,$03
	db $54,$AB,$A6,$03,$46,$AD,$A8,$03
	db $38,$AF,$A9,$03,$2A,$B0,$AB,$03
	db $20,$B2,$AD,$03,$16,$B4,$AF,$03
	db $0C,$B5,$B0,$00,$DA,$12,$0C,$32
	db $AB,$AF,$B2,$30,$B7,$00,$DA,$12
	db $0C,$32,$DD,$B5,$00,$06,$B7,$00
	db $DA,$0E,$0F,$32,$DD,$9A,$00,$0C
	db $AB,$0F,$00,$00,$8C,$1B,$32,$DD
	db $A4,$00,$18,$A1,$00,$DA,$06,$08
	db $32,$DD,$A4,$00,$08,$B7,$08,$EB
	db $00,$08,$AB,$16,$EB,$00,$12,$B7
	db $00,$DA,$12,$06,$38,$38,$B7,$06
	db $3F,$31,$B5,$06,$29,$46,$B2,$06
	db $4D,$23,$AF,$06,$38,$38,$B5,$06
	db $3F,$31,$B2,$06,$2A,$46,$BB,$06
	db $46,$1C,$AD,$30,$23,$4D,$AB,$00
	db $DA,$11,$0C,$00,$54,$8C,$08,$1C
	db $0E,$8C,$0C,$46,$38,$8C,$12,$38
	db $54,$8D,$0C,$0E,$1C,$8B,$12,$2A
	db $1C,$89,$18,$1C,$0E,$8B,$08,$0E
	db $1C,$8C,$0C,$1C,$0E,$89,$06,$2A
	db $15,$8B,$08,$0E,$1C,$8C,$30,$1C
	db $1C,$8B,$FF,$DA,$8E,$03,$06,$23
	db $00,$98,$98,$06,$1C,$07,$98,$98
	db $08,$19,$0A,$98,$06,$15,$0E,$98
	db $98,$08,$11,$11,$98,$98,$06,$0E
	db $1F,$98,$06,$09,$18,$98,$98,$08
	db $07,$1C,$98,$06,$00,$23,$98,$98
	db $00,$DA,$11,$60,$00,$54,$98,$00
	db $DA,$8F,$08,$06,$28,$93,$DA,$91
	db $08,$06,$32,$C3,$06,$00,$93,$DA
	db $8E,$08,$06,$26,$C3,$DA,$90,$08
	db $06,$2D,$C3,$06,$00,$93,$DA,$8D
	db $08,$06,$18,$C3,$DA,$8F,$08,$06
	db $1E,$C3,$06,$00,$93,$DA,$8C,$08
	db $06,$14,$C3,$DA,$8E,$08,$06,$19
	db $C3,$06,$00,$93,$DA,$8B,$08,$06
	db $14,$C3,$DA,$8D,$08,$06,$19,$C3
	db $00,$DA,$0C,$04,$46,$B5,$DA,$9C
	db $10,$18,$2A,$C3,$00,$DA,$11,$0C
	db $46,$A4,$06,$30,$A3,$06,$18,$A1
	db $0C,$2A,$9D,$12,$38,$9A,$18,$3F
	db $99,$0C,$46,$9A,$12,$54,$97,$18
	db $59,$95,$18,$54,$94,$24,$1C,$93
	db $30,$0E,$92,$00,$DA,$91,$0D,$60
	db $15,$AB,$00,$DA,$0B,$04,$46,$3F
	db $AB,$9A,$A8,$04,$3F,$46,$95,$8B
	db $A6,$04,$2A,$3F,$9D,$A6,$90,$04
	db $38,$1C,$A4,$89,$9C,$04,$0E,$31
	db $9F,$8B,$95,$04,$31,$07,$8C,$82
	db $90,$04,$07,$23,$8E,$84,$85,$04
	db $1C,$00,$82,$87,$84,$00,$DA,$02
	db $06,$38,$B7,$B2,$B7,$B9,$BB,$BE
	db $18,$C3,$00,$DA,$05,$0C,$54,$DD
	db $9C,$00,$0C,$9F,$0F,$EB,$00,$0C
	db $90,$00,$DA,$03,$10,$15,$3F,$DD
	db $A1,$00,$10,$B7,$18,$EB,$00,$18
	db $AD,$12,$38,$15,$DD,$A8,$00,$12
	db $AB,$0C,$EB,$00,$0C,$9F,$08,$0E
	db $31,$DD,$A4,$00,$08,$A8,$06,$EB
	db $00,$06,$9C,$0C,$2A,$0E,$DD,$A1
	db $00,$0C,$A4,$06,$EB,$00,$06,$98
	db $0C,$07,$23,$DD,$9C,$00,$0C,$9F
	db $06,$EB,$00,$06,$93,$0C,$1B,$04
	db $DD,$98,$00,$0C,$9C,$06,$EB,$00
	db $06,$90,$0C,$04,$18,$DD,$95,$00
	db $0C,$98,$06,$EB,$00,$06,$8C,$6C
	db $00,$A5,$15,$38,$38,$DD,$AB,$00
	db $12,$BC,$00,$DA,$06,$4B,$46,$DD
	db $90,$00,$48,$9F,$00,$DA,$05,$DA
	db $07,$06,$46,$A9,$06,$00,$B5,$06
	db $46,$A8,$06,$00,$B5,$00,$DA,$0A
	db $1B,$54,$DD,$A4,$00,$18,$9F,$DA
	db $02,$06,$B4,$B7,$B4,$0C,$B7,$00
	db $DA,$05,$08,$54,$DD,$9F,$00,$08
	db $A3,$12,$EB,$00,$12,$AB,$06,$3F
	db $EB,$00,$06,$A8,$11,$31,$EB,$00
	db $11,$AB,$08,$23,$EB,$00,$08,$A8
	db $0F,$15,$EB,$00,$0C,$AB,$00,$DA
	db $02,$0C,$54,$B4,$B0,$B4,$18,$B0
	db $00,$DA,$03,$03,$23,$9F,$93,$A0
	db $94,$A1,$95,$A2,$96,$A3,$97,$A4
	db $98,$A5,$99,$A6,$9A,$00,$DA,$05
	db $0C,$1C,$DD,$A1,$00,$0C,$9F,$18
	db $2A,$EB,$00,$18,$BC,$0F,$15,$EB
	db $00,$0C,$B0,$00,$DA,$01,$0C,$2A
	db $DD,$A1,$00,$0C,$9F,$15,$59,$EB
	db $00,$12,$C1,$00,$DA,$06,$0F,$31
	db $DD,$A4,$00,$0C,$B7,$0F,$00,$00
	db $8C,$18,$31,$B4,$00,$DA,$02,$06
	db $38,$B4,$B7,$12,$00,$C6,$06,$38
	db $B4,$B7,$B6,$BA,$00,$DA,$05,$0F
	db $54,$DD,$8C,$00,$0C,$90,$0C,$00
	db $00,$8C,$DA,$01,$1B,$59,$DD,$96
	db $00,$18,$93,$00,$DA,$06,$06,$38
	db $DD,$98,$00,$06,$AD,$0F,$38,$EB
	db $00,$0C,$A4,$18,$00,$A4,$00,$DA
	db $06,$03,$54,$B5,$B4,$B5,$B4,$03
	db $46,$B5,$B4,$03,$38,$B5,$B4,$03
	db $2A,$B5,$B4,$03,$15,$B5,$B4,$00
	db $DA,$0F,$0C,$2A,$AE,$B8,$0C,$00
	db $B8,$0C,$2A,$B8,$18,$2A,$B8,$0C
	db $31,$AF,$B9,$0C,$00,$B9,$0C,$31
	db $B9,$18,$31,$B9,$0C,$38,$BA,$0C
	db $00,$BA,$30,$38,$BA,$00,$DA,$0F
	db $0C,$2A,$A9,$B2,$0C,$00,$B2,$0C
	db $2A,$B2,$18,$2A,$B2,$0C,$31,$AA
	db $B3,$0C,$00,$B3,$0C,$31,$B3,$18
	db $31,$B3,$0C,$38,$B4,$0C,$00,$B4
	db $30,$38,$B4,$00,$DA,$06,$0C,$38
	db $0E,$DD,$A4,$00,$0C,$B7,$18,$1C
	db $1C,$EB,$00,$18,$B0,$34,$0E,$38
	db $EB,$00,$30,$A4,$00,$DA,$03,$03
	db $00,$38,$AD,$AB,$03,$0E,$23,$A8
	db $A4,$03,$15,$15,$A3,$9F,$03,$1C
	db $00,$9D,$9A,$03,$38,$00,$AD,$AB
	db $03,$23,$0E,$A8,$A4,$03,$15,$15
	db $A3,$9F,$03,$00,$1C,$9D,$9A,$03
	db $00,$38,$AD,$AB,$03,$0E,$23,$A8
	db $A4,$03,$15,$15,$A3,$9F,$03,$1C
	db $00,$9D,$9A,$00,$DA,$06,$09,$38
	db $DD,$9F,$00,$06,$AF,$09,$38,$DD
	db $9F,$00,$06,$AF,$09,$38,$DD,$9F
	db $00,$06,$AF,$00,$DA,$02,$03,$4D
	db $AC,$B0,$B6,$00,$DA,$04,$06,$59
	db $AE,$B5,$00,$DA,$04,$06,$59,$B0
	db $B7,$00,$DA,$04,$06,$59,$B2,$B9
	db $00,$DA,$04,$06,$59,$B4,$BB,$00
	db $DA,$04,$06,$59,$B6,$BD,$00,$DA
	db $04,$06,$59,$B8,$BF,$00,$DA,$04
	db $06,$59,$BA,$C1,$00,$DA,$04,$06
	db $59,$BC,$C3,$00,$DA,$07,$09,$31
	db $DD,$98,$00,$06,$9F,$DA,$0C,$1B
	db $54,$DD,$A4,$00,$0C,$98,$00,$DA
	db $06,$0F,$23,$DD,$98,$00,$0C,$93
	db $0F,$DD,$9C,$00,$0C,$9E,$00,$DA
	db $0A,$07,$23,$DD,$93,$00,$04,$B7
	db $00,$DA,$04,$06,$3F,$A4,$03,$AB
	db $AC,$A5,$AC,$AD,$A6,$AD,$AE,$DA
	db $04,$06,$3F,$A7,$03,$AE,$AF,$A8
	db $AF,$B0,$A9,$B0,$B1,$AA,$B1,$B2
	db $AB,$B2,$B3,$00,$DA,$02,$0F,$46
	db $1C,$DD,$98,$00,$0C,$9F,$0F,$1C
	db $46,$DD,$A4,$00,$0C,$AB,$0F,$46
	db $1C,$DD,$A0,$00,$0C,$A7,$0F,$1C
	db $46,$DD,$AC,$00,$0C,$B3,$0F,$46
	db $1C,$DD,$A2,$00,$0C,$A9,$0F,$1C
	db $46,$DD,$AE,$00,$0C,$B5,$00,$DA
	db $02,$09,$1C,$1C,$B0,$08,$19,$1F
	db $AE,$07,$1F,$19,$AC,$06,$15,$23
	db $AA,$05,$23,$15,$A8,$04,$0E,$2A
	db $A6,$00,$DA,$03,$0C,$15,$07,$DD
	db $95,$00,$0C,$A4,$06,$EB,$00,$06
	db $97,$0C,$07,$1C,$DD,$99,$00,$0C
	db $A8,$06,$EB,$00,$06,$9A,$0C,$23
	db $0E,$DD,$9D,$00,$0C,$AD,$06,$EB
	db $00,$06,$9D,$0C,$0E,$31,$DD,$A1
	db $00,$0C,$B0,$06,$EB,$00,$06,$A0
	db $0C,$38,$15,$DD,$A5,$00,$0C,$B4
	db $06,$EB,$00,$06,$A3,$0C,$15,$3F
	db $DD,$A9,$00,$0C,$B9,$09,$EB,$00
	db $06,$AD,$00,$DA,$05,$0C,$2A,$0E
	db $DD,$A1,$00,$0C,$98,$06,$EB,$00
	db $06,$A3,$0C,$0E,$31,$DD,$A4,$00
	db $0C,$9B,$06,$EB,$00,$06,$A6,$0C
	db $3F,$15,$DD,$A7,$00,$0C,$9E,$09
	db $EB,$00,$06,$A8,$00,$DA,$02,$03
	db $46,$98,$9C,$9F,$A4,$9F,$A4,$A8
	db $AB,$B0,$AB,$A0,$A4,$A7,$AC,$A7
	db $AC,$B0,$B3,$B8,$B3,$A2,$A6,$A9
	db $AE,$A9,$AE,$B2,$B5,$BA,$B5,$00
	db $DA,$02,$08,$59,$B4,$B7,$C0,$BC
	db $BE,$0C,$C3,$00,$DA,$01,$03,$59
	db $A4,$A6,$A7,$A8,$03,$59,$A9,$AA
	db $AB,$AC,$03,$4D,$A9,$AA,$AB,$AC
	db $03,$46,$A9,$AA,$AB,$AC,$03,$3F
	db $A9,$AA,$AB,$AC,$03,$38,$A9,$AA
	db $AB,$AC,$00,$DA,$03,$03,$1C,$1C
	db $A3,$A1,$9F,$9D,$A3,$06,$A1,$03
	db $1C,$1C,$A4,$A3,$A1,$A0,$A4,$06
	db $A3,$03,$2A,$0E,$A8,$A6,$A5,$A4
	db $03,$0E,$23,$A8,$A6,$A5,$A4,$03
	db $23,$0E,$A8,$A6,$A5,$A4,$03,$0E
	db $1C,$A8,$A6,$A5,$A4,$03,$1C,$0E
	db $A8,$A6,$A5,$A4,$03,$07,$15,$A8
	db $A6,$A5,$A4,$03,$15,$07,$A8,$A6
	db $A5,$A4,$00,$DA,$04,$03,$46,$AD
	db $08,$AC,$03,$46,$AF,$08,$B0,$03
	db $3F,$B1,$B3,$B4,$B5,$03,$38,$B3
	db $B5,$B6,$B7,$00,$DA,$01,$03,$3F
	db $B2,$08,$B3,$03,$3F,$B5,$B6,$B7
	db $B8,$03,$38,$B5,$B6,$B7,$B8,$03
	db $31,$B5,$B6,$B7,$B8,$00,$DA,$02
	db $08,$46,$BB,$24,$C0,$00,$DA,$07
	db $04,$2A,$2A,$BB,$C0,$04,$31,$23
	db $AB,$A6,$04,$23,$31,$98,$9A,$04
	db $38,$1C,$9C,$91,$04,$1C,$38,$95
	db $97,$04,$3F,$15,$90,$8C,$04,$15
	db $3F,$8B,$82,$04,$46,$0E,$85,$87
	db $00,$DA,$0A,$03,$38,$9D,$9E,$9F
	db $A0,$A1,$A2,$A3,$A4,$0C,$00,$9C
	db $03,$38,$9F,$A0,$9F,$A0,$06,$9F
	db $0C,$00,$AB,$03,$38,$A3,$A4,$A3
	db $A4,$0C,$00,$AB,$03,$38,$A6,$A7
	db $A6,$A7,$06,$A6,$00,$DA,$0A,$06
	db $54,$98,$06,$00,$8B,$1B,$54,$DD
	db $9F,$00,$18,$98,$00,$DA,$0B,$08
	db $38,$A4,$06,$23,$A4,$06,$1C,$A4
	db $06,$15,$A4,$06,$07,$A4,$FF,$DA
	db $0B,$06,$15,$A4,$06,$1C,$A4,$08
	db $2A,$A4,$18,$38,$A4,$00,$00,$FE
	db $6A,$B8,$06,$01,$FA,$6A,$B8,$03
	db $02,$AE,$2F,$B8,$04,$03,$FE,$6A
	db $B8,$03,$04,$A9,$6A,$B8,$03,$07
	db $AE,$26,$B8,$07,$08,$FA,$6A,$B8
	db $03,$09,$9E,$1F,$B8,$03,$05,$AE
	db $26,$B8,$1E,$0A,$EE,$6A,$B8,$02
	db $0B,$FE,$6A,$B8,$08,$01,$F7,$6A
	db $B8,$03,$10,$0E,$6A,$7F,$04,$0C
	db $FE,$6A,$B8,$03,$0D,$AE,$26,$B8
	db $07,$12,$8E,$E0,$B8,$03,$0C,$FE
	db $70,$B8,$03,$11,$FE,$6A,$B8,$05
	db $01,$E9,$6A,$B8,$03,$0F,$0F,$6A
	db $7F,$03,$A8,$06,$0E,$6A,$40,$07
	db $A4,$06,$8C,$E0,$70,$07,$A1,$0E
	db $FE,$6A,$B8,$07,$A4,$0E,$FE,$6A
	db $B8,$08,$A4,$0B,$FE,$6A,$B8,$02
	db $9C,$0B,$7E,$6A,$7F,$08,$A6,$0B
	db $7E,$6A,$30,$08,$A6,$0E,$0E,$6A
	db $7F,$03,$A1
.end

music_bank_1:
	dw .end-.start				;		| Length of music bank 1
	dw $1360				;		| Location of music in ARAM

.start
	db $AA,$14,$18,$14,$42,$14,$6C,$14
	db $B0,$13,$72,$13,$DC,$13,$30,$15
	db $44,$15,$80,$13,$90,$13,$90,$13
	db $A0,$13,$FF,$00,$74,$13,$00,$00
	db $09,$1D,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $0D,$1D,$35,$1D,$4B,$1D,$63,$1D
	db $00,$00,$00,$00,$00,$00,$75,$1D
	db $83,$1D,$BE,$1D,$D6,$1D,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $BC,$13,$BC,$13,$CC,$13,$FF,$00
	db $B0,$13,$00,$00,$EE,$1D,$37,$1E
	db $20,$1E,$62,$1E,$09,$1E,$4C,$1E
	db $00,$00,$00,$00,$7E,$1E,$B5,$1E
	db $A3,$1E,$D6,$1E,$91,$1E,$C5,$1E
	db $00,$00,$00,$00,$E8,$13,$F8,$13
	db $08,$14,$FF,$00,$DE,$13,$00,$00
	db $EE,$1E,$4E,$1F,$02,$1F,$BC,$1F
	db $12,$1F,$7F,$1F,$00,$00,$00,$00
	db $22,$1F,$4E,$1F,$2A,$1F,$BC,$1F
	db $31,$1F,$7F,$1F,$00,$00,$00,$00
	db $38,$1F,$4E,$1F,$40,$1F,$BC,$1F
	db $47,$1F,$7F,$1F,$00,$00,$00,$00
	db $32,$14,$22,$14,$FF,$00,$18,$14
	db $00,$00,$19,$21,$02,$21,$4E,$21
	db $73,$21,$00,$00,$00,$00,$00,$00
	db $39,$22,$B9,$21,$9F,$21,$E9,$21
	db $11,$22,$00,$00,$00,$00,$00,$00
	db $39,$22,$4C,$14,$5C,$14,$FF,$00
	db $42,$14,$00,$00,$D6,$1F,$15,$20
	db $50,$20,$77,$20,$00,$00,$00,$00
	db $00,$00,$00,$00,$A7,$20,$C2,$20
	db $DA,$20,$ED,$20,$00,$00,$00,$00
	db $00,$00,$00,$00,$7A,$14,$8A,$14
	db $8A,$14,$9A,$14,$FF,$00,$6E,$14
	db $00,$00,$00,$00,$00,$00,$48,$23
	db $B0,$23,$63,$23,$00,$00,$00,$00
	db $D3,$23,$52,$22,$76,$22,$48,$23
	db $B0,$23,$63,$23,$BC,$22,$99,$22
	db $D3,$23,$DF,$22,$FA,$22,$7B,$23
	db $B0,$23,$8E,$23,$2E,$23,$14,$23
	db $09,$24,$C0,$14,$D0,$14,$E0,$14
	db $F0,$14,$00,$15,$10,$15,$10,$15
	db $20,$15,$FF,$00,$AC,$14,$00,$00
	db $48,$24,$71,$24,$00,$00,$95,$24
	db $AF,$24,$00,$00,$00,$00,$00,$00
	db $C3,$24,$F9,$24,$6D,$25,$47,$25
	db $93,$25,$00,$00,$00,$00,$00,$00
	db $D7,$25,$00,$26,$65,$26,$3F,$26
	db $8B,$26,$00,$00,$B9,$25,$00,$00
	db $B0,$26,$CC,$26,$51,$27,$2A,$27
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $65,$27,$85,$27,$09,$28,$E3,$27
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $1D,$28,$42,$28,$7E,$28,$6D,$28
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $8F,$28,$CE,$28,$57,$29,$0C,$29
	db $31,$29,$00,$00,$00,$00,$00,$00
	db $34,$15,$00,$00,$51,$1C,$93,$1C
	db $B2,$1C,$D1,$1C,$00,$00,$74,$1C
	db $00,$00,$EF,$1C,$BE,$15,$CE,$15
	db $DE,$15,$BE,$15,$CE,$15,$DE,$15
	db $BE,$15,$CE,$15,$DE,$15,$BE,$15
	db $CE,$15,$DE,$15,$BE,$15,$CE,$15
	db $DE,$15,$BE,$15,$CE,$15,$DE,$15
	db $BE,$15,$CE,$15,$DE,$15,$BE,$15
	db $CE,$15,$DE,$15,$BE,$15,$EE,$15
	db $FE,$15,$FE,$15,$0E,$16,$1E,$16
	db $0E,$16,$2E,$16,$0E,$16,$1E,$16
	db $0E,$16,$2E,$16,$3E,$16,$4E,$16
	db $3E,$16,$5E,$16,$FE,$15,$FE,$15
	db $6E,$16,$7E,$16,$6E,$16,$8E,$16
	db $6E,$16,$7E,$16,$6E,$16,$8E,$16
	db $3E,$16,$4E,$16,$3E,$16,$5E,$16
	db $6E,$16,$7E,$16,$6E,$16,$8E,$16
	db $FF,$00,$78,$15,$00,$00,$6A,$19
	db $62,$17,$3B,$17,$26,$18,$95,$19
	db $1F,$19,$40,$19,$F9,$18,$6A,$19
	db $B0,$17,$89,$17,$94,$18,$95,$19
	db $1F,$19,$40,$19,$F9,$18,$29,$1A
	db $ED,$16,$C6,$16,$4A,$18,$51,$1A
	db $E1,$19,$03,$1A,$BB,$19,$8A,$1B
	db $79,$1B,$4E,$1B,$64,$1B,$95,$19
	db $1F,$19,$6A,$19,$F9,$18,$6E,$18
	db $14,$17,$9E,$16,$D7,$17,$95,$19
	db $1F,$19,$6A,$19,$F9,$18,$6A,$19
	db $CF,$18,$B8,$18,$E5,$18,$95,$19
	db $1F,$19,$00,$00,$F9,$18,$6A,$19
	db $8D,$1A,$77,$1A,$E5,$18,$95,$19
	db $1F,$19,$00,$00,$F9,$18,$6A,$19
	db $B6,$1A,$A2,$1A,$C9,$1A,$95,$19
	db $1F,$19,$00,$00,$F9,$18,$6A,$19
	db $3F,$1B,$DD,$1A,$F2,$1A,$95,$19
	db $1F,$19,$06,$1B,$F9,$18,$6A,$19
	db $3F,$1B,$1C,$1B,$2E,$1B,$95,$19
	db $1F,$19,$06,$1B,$F9,$18,$6A,$19
	db $79,$1B,$4E,$1B,$64,$1B,$95,$19
	db $1F,$19,$8A,$1B,$F9,$18,$6A,$19
	db $C6,$1B,$9D,$1B,$B2,$1B,$95,$19
	db $1F,$19,$00,$00,$F9,$18,$6A,$19
	db $02,$1C,$DB,$1B,$EF,$1B,$95,$19
	db $1F,$19,$00,$00,$F9,$18,$6A,$19
	db $3E,$1C,$17,$1C,$29,$1C,$95,$19
	db $1F,$19,$00,$00,$F9,$18,$DA,$04
	db $DB,$0A,$0C,$6C,$B0,$C7,$C7,$AB
	db $C7,$C7,$A8,$C7,$C7,$AD,$C7,$18
	db $AF,$0C,$AE,$AD,$C7,$10,$AB,$B4
	db $B7,$0C,$B9,$C7,$B5,$B7,$C7,$B4
	db $C7,$B0,$B2,$24,$AF,$00,$DA,$03
	db $DB,$0A,$0C,$6C,$A8,$C7,$A8,$A8
	db $C7,$A8,$C7,$A8,$C7,$A8,$C7,$A8
	db $C7,$A8,$A8,$A8,$0C,$A8,$C7,$A8
	db $C7,$C7,$A9,$C7,$A9,$A8,$C7,$C7
	db $C7,$C7,$C7,$C7,$C7,$DA,$03,$DB
	db $0A,$0C,$6C,$B0,$C7,$B4,$AF,$C7
	db $B4,$C7,$AD,$C7,$B4,$C7,$AF,$C7
	db $AF,$B0,$B2,$0C,$B0,$C7,$B0,$C7
	db $C7,$B0,$C7,$B0,$B0,$C7,$C7,$C7
	db $C7,$C7,$C7,$C7,$DA,$03,$DB,$14
	db $0C,$69,$B0,$C7,$B4,$AF,$C7,$B4
	db $C7,$AD,$C7,$B4,$C7,$AF,$C7,$AF
	db $B0,$B2,$0C,$B0,$C7,$B4,$AF,$C7
	db $B4,$C7,$AD,$C7,$B4,$C7,$AF,$C7
	db $AF,$B0,$B2,$DA,$03,$DB,$0A,$0C
	db $6C,$AB,$C7,$AB,$AB,$C7,$AB,$C7
	db $AB,$C7,$AB,$C7,$AB,$C7,$AB,$AB
	db $AB,$0C,$AB,$C7,$AB,$AB,$C7,$AB
	db $C7,$AB,$C7,$AB,$C7,$AB,$C7,$AB
	db $AB,$AB,$DA,$03,$DB,$0A,$0C,$6C
	db $B0,$C7,$B4,$AF,$C7,$B4,$C7,$AD
	db $C7,$B4,$C7,$AF,$C7,$AF,$B0,$B2
	db $0C,$B0,$C7,$B4,$AF,$C7,$B4,$C7
	db $AD,$C7,$B4,$C7,$AF,$C7,$AF,$B0
	db $B1,$DA,$03,$DB,$0A,$0C,$6C,$AD
	db $C7,$AD,$AD,$C7,$AD,$C7,$AD,$C7
	db $AD,$C7,$AD,$C7,$AD,$AD,$AD,$0C
	db $AD,$C7,$AD,$AD,$C7,$AD,$C7,$AD
	db $C7,$AD,$C7,$AD,$C7,$AD,$AD,$AD
	db $DA,$03,$DB,$0A,$0C,$6C,$B2,$C7
	db $B5,$B1,$C7,$B5,$C7,$B0,$C7,$B5
	db $C7,$AF,$C7,$AF,$B0,$B1,$0C,$B2
	db $C7,$B5,$B1,$C7,$B5,$C7,$B0,$C7
	db $B5,$C7,$AF,$C7,$AF,$B0,$B2,$DA
	db $04,$DB,$0A,$0C,$6C,$A8,$C7,$C7
	db $A4,$C7,$C7,$9F,$C7,$C7,$A4,$C7
	db $18,$A6,$0C,$A5,$A4,$C7,$10,$A4
	db $AB,$AF,$0C,$B0,$C7,$AD,$AF,$C7
	db $AB,$C7,$A8,$A9,$24,$A6,$DA,$04
	db $0C,$6C,$9F,$C7,$C7,$9C,$C7,$C7
	db $98,$C7,$C7,$9D,$C7,$18,$9F,$0C
	db $9E,$9D,$C7,$60,$C7,$C7,$10,$9C
	db $A4,$A8,$0C,$A9,$C7,$A6,$A8,$C7
	db $A4,$C7,$A1,$A3,$24,$9F,$DA,$0E
	db $0C,$6D,$8C,$C6,$C6,$93,$93,$C6
	db $C6,$98,$98,$C6,$C6,$93,$93,$C6
	db $93,$C6,$8C,$C6,$C6,$93,$93,$C6
	db $C6,$98,$C6,$98,$C6,$98,$93,$C6
	db $93,$C6,$DA,$0E,$0C,$6D,$8C,$C6
	db $C6,$93,$93,$C6,$C6,$98,$98,$C6
	db $C6,$93,$93,$C6,$93,$C6,$8C,$C6
	db $8C,$C6,$C6,$8D,$C6,$8D,$8C,$C6
	db $C6,$93,$93,$C6,$93,$C6,$DA,$0E
	db $0C,$6D,$DB,$0A,$8C,$C6,$C6,$8C
	db $90,$C6,$C6,$90,$91,$C6,$C6,$91
	db $92,$C6,$93,$C6,$8C,$C6,$C6,$8C
	db $90,$C6,$C6,$90,$91,$C6,$C6,$91
	db $92,$C6,$93,$C6,$DA,$0E,$0C,$6D
	db $8E,$C6,$C6,$95,$95,$C6,$C6,$9A
	db $9A,$C6,$C6,$95,$95,$C6,$95,$C6
	db $8E,$C6,$C6,$95,$95,$C6,$C6,$9A
	db $C6,$9A,$C6,$9A,$95,$C6,$95,$C6
	db $DA,$07,$DB,$0A,$18,$6B,$C7,$0C
	db $B7,$B6,$B5,$B3,$C7,$B4,$C7,$AC
	db $AD,$B0,$C7,$AD,$B0,$B2,$00,$DA
	db $07,$DB,$0A,$18,$6B,$C7,$0C,$B4
	db $B3,$B2,$AF,$C7,$B0,$C7,$A8,$A9
	db $AB,$C7,$A4,$A8,$A9,$DA,$0E,$0C
	db $6D,$8C,$C6,$C6,$8C,$90,$C6,$C6
	db $90,$91,$C6,$C6,$91,$95,$C6,$98
	db $C6,$DA,$00,$DB,$14,$0C,$7C,$D2
	db $C6,$D2,$D2,$D2,$C6,$D2,$D2,$D2
	db $C6,$D2,$D2,$D2,$C6,$D2,$D2,$D2
	db $C6,$D2,$D2,$D2,$C6,$D2,$D2,$D2
	db $C6,$D2,$D2,$D2,$C6,$D2,$D2,$DA
	db $0C,$DB,$05,$18,$7C,$A9,$A9,$B0
	db $0C,$C6,$A9,$24,$B0,$0C,$A9,$18
	db $A9,$A9,$18,$A9,$A9,$B0,$0C,$C6
	db $A9,$24,$B0,$0C,$A9,$18,$A9,$A9
	db $DA,$02,$DB,$00,$DE,$00,$00,$00
	db $0C,$15,$AB,$AB,$C6,$B2,$AB,$AB
	db $C6,$B2,$C7,$B2,$C7,$B2,$AB,$AB
	db $C6,$B2,$AB,$AB,$C6,$B2,$AB,$AB
	db $C6,$B2,$C7,$B2,$C7,$B2,$AB,$AB
	db $C6,$B2,$F0,$DA,$0C,$DB,$0C,$E2
	db $29,$18,$6C,$98,$9F,$0C,$9F,$98
	db $C6,$18,$98,$9F,$0C,$9F,$0C,$9F
	db $C6,$98,$98,$18,$98,$9F,$0C,$9F
	db $98,$C6,$18,$98,$9F,$0C,$9F,$0C
	db $9F,$C6,$98,$98,$00,$DA,$00,$DB
	db $0A,$0C,$6C,$D6,$D6,$C7,$D3,$D3
	db $D3,$C7,$D6,$C7,$D6,$D6,$C7,$D3
	db $D3,$C7,$D6,$D6,$D6,$C7,$D3,$D3
	db $D3,$C7,$D6,$C7,$D6,$D6,$C7,$D3
	db $D3,$C7,$D6,$DA,$00,$DB,$14,$0C
	db $7C,$D2,$C6,$D2,$D2,$D2,$C6,$D2
	db $D2,$D2,$C6,$D2,$D2,$D2,$C6,$D2
	db $D2,$D2,$D2,$D2,$C6,$D2,$D2,$C6
	db $D2,$D2,$C6,$C6,$C6,$D2,$C6,$D2
	db $D2,$DA,$0C,$DB,$05,$18,$7C,$A9
	db $A9,$B0,$0C,$C6,$A9,$24,$B0,$0C
	db $A9,$18,$A9,$A9,$18,$B0,$B0,$0C
	db $C6,$B0,$C6,$B0,$24,$B0,$0C,$A4
	db $18,$A4,$A4,$DA,$02,$DB,$00,$0C
	db $15,$AB,$AB,$C6,$B2,$AB,$AB,$C6
	db $B2,$C7,$B2,$C7,$B2,$AB,$AB,$C6
	db $B2,$B2,$C7,$B2,$C7,$C7,$B2,$C7
	db $B2,$B2,$C7,$C7,$C7,$B2,$B2,$C6
	db $AB,$DA,$0C,$DB,$0C,$18,$6C,$98
	db $9F,$0C,$9F,$98,$C6,$18,$98,$9F
	db $0C,$9F,$0C,$9F,$C6,$98,$98,$18
	db $6C,$9F,$9F,$0C,$C6,$9F,$C6,$9F
	db $18,$98,$C6,$0C,$9F,$9F,$C6,$98
	db $00,$DA,$00,$DB,$0A,$0C,$6C,$D6
	db $D6,$C7,$D3,$D3,$D3,$C7,$D6,$C7
	db $D6,$D6,$C7,$D3,$D3,$C7,$D6,$D3
	db $C7,$D3,$C7,$C7,$D3,$C7,$D3,$D3
	db $C7,$C7,$C7,$D3,$D3,$C7,$D6,$DA
	db $07,$DB,$0A,$18,$6B,$C7,$0C,$B7
	db $B6,$B5,$B3,$C7,$B4,$C7,$BC,$C7
	db $BC,$18,$BC,$C7,$00,$DA,$07,$DB
	db $0A,$18,$6B,$C7,$0C,$B4,$B3,$B2
	db $AF,$C7,$B0,$C7,$B5,$C7,$B5,$18
	db $B5,$C7,$DA,$07,$DB,$0A,$18,$6B
	db $C7,$0C,$B3,$C7,$C7,$B2,$C7,$C7
	db $18,$B0,$C6,$C6,$C7,$00,$DA,$07
	db $DB,$0A,$18,$6B,$C7,$0C,$AC,$C7
	db $C7,$A9,$C7,$C7,$18,$A8,$C6,$C6
	db $C7,$DA,$0E,$0C,$6D,$94,$C6,$C6
	db $94,$96,$C6,$C6,$96,$98,$95,$96
	db $97,$98,$C6,$C6,$C6,$DA,$06,$DB
	db $0C,$0C,$6B,$B0,$B0,$C7,$B0,$C7
	db $B0,$B2,$C7,$B4,$B0,$C7,$AD,$30
	db $AB,$00,$DA,$06,$DB,$08,$0C,$6B
	db $AC,$AC,$C7,$AC,$C7,$AC,$AE,$C7
	db $AB,$A8,$C7,$A8,$30,$A4,$DA,$03
	db $DB,$14,$0C,$69,$B8,$C7,$BC,$B3
	db $C7,$B8,$C7,$B7,$C7,$BC,$C7,$B4
	db $B7,$C7,$BC,$C7,$DA,$06,$DB,$0C
	db $0C,$6B,$B0,$B0,$C7,$B0,$C7,$B0
	db $B2,$24,$B4,$C6,$C6,$00,$DA,$06
	db $DB,$08,$0C,$6B,$AC,$AC,$C7,$AC
	db $C7,$AC,$AE,$24,$AB,$C6,$C6,$DA
	db $0E,$DB,$0A,$24,$6D,$88,$8F,$18
	db $94,$24,$93,$8C,$18,$87,$DA,$06
	db $DB,$0A,$0C,$6B,$B4,$B4,$C7,$B4
	db $C7,$B0,$B4,$C7,$18,$B7,$C7,$DA
	db $0F,$A3,$C7,$00,$DA,$06,$DB,$0A
	db $0C,$6B,$AA,$AA,$C7,$AA,$C7,$AA
	db $AA,$C7,$18,$AF,$C7,$DA,$0F,$A3
	db $C7,$DA,$0E,$0C,$6D,$8E,$8E,$C7
	db $8E,$C7,$8E,$90,$91,$18,$93,$C7
	db $93,$C7,$DA,$04,$DB,$0A,$0C,$6B
	db $AD,$AD,$C7,$AD,$C7,$AD,$AD,$C7
	db $18,$B2,$C7,$C7,$C7,$DA,$07,$DB
	db $0A,$0C,$6B,$B4,$B0,$C7,$24,$AB
	db $18,$AC,$0C,$AD,$B5,$C7,$B5,$30
	db $AD,$00,$DA,$07,$DB,$0A,$0C,$6B
	db $B0,$18,$AD,$24,$A8,$18,$A8,$0C
	db $A9,$B0,$C7,$B0,$30,$A9,$DA,$0E
	db $DB,$0A,$24,$6D,$8C,$0C,$92,$18
	db $93,$98,$24,$91,$0C,$91,$0C,$98
	db $98,$91,$C7,$DA,$07,$DB,$0A,$10
	db $6B,$AF,$B9,$B9,$B9,$B7,$B5,$0C
	db $B4,$B0,$C7,$AD,$30,$AB,$00,$DA
	db $07,$DB,$0A,$10,$6B,$AB,$B5,$B5
	db $B5,$B4,$B2,$0C,$B0,$AD,$C7,$A9
	db $30,$A8,$DA,$0E,$DB,$0A,$24,$6D
	db $8E,$0C,$91,$18,$93,$97,$24,$93
	db $0C,$93,$0C,$98,$98,$93,$C7,$DA
	db $07,$DB,$0A,$0C,$6B,$AF,$B5,$C7
	db $B5,$10,$B5,$B4,$B2,$30,$B0,$C7
	db $00,$DA,$07,$DB,$0A,$0C,$6B,$AB
	db $B2,$C7,$B2,$10,$B2,$B0,$AF,$0C
	db $AB,$A8,$C7,$A8,$30,$A4,$DA,$0E
	db $DB,$0A,$24,$6D,$93,$0C,$93,$10
	db $93,$95,$97,$18,$98,$93,$30,$8C
	db $00,$F0,$DA,$04,$E2,$23,$DB,$0A
	db $DE,$14,$15,$20,$30,$7E,$C7,$0C
	db $A9,$A9,$18,$4E,$A9,$B0,$48,$7E
	db $AF,$0C,$4E,$AE,$AD,$18,$AC,$B5
	db $60,$B4,$C6,$00,$DA,$04,$DB,$0A
	db $DE,$14,$15,$20,$30,$7E,$C7,$0C
	db $9D,$9D,$18,$4E,$9D,$A4,$48,$7E
	db $A3,$0C,$4E,$A2,$A1,$18,$A0,$A9
	db $60,$A8,$C6,$DA,$04,$DB,$0A,$DE
	db $14,$15,$20,$30,$7E,$C7,$0C,$A4
	db $A4,$18,$4E,$A4,$AB,$48,$7E,$AA
	db $0C,$4E,$A9,$A8,$18,$A7,$B0,$60
	db $AF,$C6,$DA,$04,$DB,$0A,$DE,$14
	db $15,$20,$30,$7E,$C7,$0C,$9F,$9F
	db $18,$4E,$9F,$A6,$48,$7E,$A5,$0C
	db $4E,$A4,$A3,$18,$A2,$AB,$60,$AA
	db $C6,$DA,$04,$DB,$0A,$DE,$14,$1F
	db $30,$0C,$4F,$8C,$8C,$60,$8C,$18
	db $C6,$06,$3F,$8C,$8C,$8C,$8C,$48
	db $6F,$8C,$18,$8C,$60,$8D,$C6,$DA
	db $04,$DB,$0A,$0C,$4F,$D0,$D0,$60
	db $D0,$18,$C6,$06,$3F,$D0,$D0,$D0
	db $D0,$48,$6F,$D0,$18,$D0,$60,$D0
	db $C7,$F0,$18,$C7,$00,$DA,$01,$E2
	db $19,$DB,$0D,$DE,$14,$1F,$30,$06
	db $4E,$B0,$B2,$B0,$C6,$B0,$B2,$B0
	db $C6,$0C,$3E,$B0,$18,$5E,$BC,$0C
	db $BC,$0C,$5C,$BB,$0C,$2C,$B2,$B2
	db $B2,$30,$6D,$B2,$00,$DA,$01,$DB
	db $08,$DE,$14,$1E,$30,$30,$7D,$C7
	db $0C,$A7,$24,$AC,$30,$C7,$0C,$7C
	db $AE,$24,$AF,$DA,$01,$DB,$0A,$DE
	db $14,$1D,$30,$18,$7D,$C7,$C7,$0C
	db $A4,$24,$A7,$18,$C7,$C7,$0C,$7C
	db $AA,$24,$AB,$DA,$01,$DB,$05,$DE
	db $14,$1E,$30,$18,$C7,$48,$4E,$9B
	db $18,$C7,$48,$4D,$9F,$DA,$01,$DB
	db $00,$DE,$14,$1C,$30,$60,$4F,$94
	db $60,$4E,$93,$0C,$6C,$B5,$0C,$2B
	db $B3,$B3,$0C,$6C,$B5,$0C,$2B,$B3
	db $B3,$18,$6C,$B5,$0C,$6C,$B4,$0C
	db $2B,$B2,$B2,$0C,$6C,$B4,$0C,$2B
	db $B2,$B2,$18,$6C,$B4,$0C,$6D,$B5
	db $0C,$2C,$B3,$B3,$0C,$6D,$B5,$0C
	db $2C,$B3,$B3,$0C,$6D,$B5,$BC,$0C
	db $7C,$C6,$54,$7C,$BB,$00,$24,$3B
	db $AE,$AE,$18,$6B,$AE,$24,$3B,$AD
	db $AD,$18,$6B,$AD,$24,$3C,$AE,$AE
	db $18,$6C,$AE,$60,$5D,$AD,$24,$3B
	db $AA,$AA,$18,$6B,$AA,$24,$3B,$A9
	db $A9,$18,$6B,$A9,$24,$3C,$AA,$AA
	db $18,$6C,$AA,$60,$5D,$A9,$F0,$DA
	db $04,$E2,$19,$DB,$0A,$0C,$3B,$B0
	db $B0,$B0,$A6,$18,$B0,$0C,$A6,$AF
	db $C6,$AF,$AF,$A4,$AF,$AD,$AE,$AF
	db $00,$DA,$04,$DB,$00,$0C,$3B,$AD
	db $AD,$AD,$C7,$18,$AD,$0C,$C7,$AB
	db $C6,$AB,$AB,$C7,$AB,$C7,$C7,$C7
	db $DA,$04,$DB,$00,$0C,$3B,$A9,$A9
	db $A9,$C7,$18,$A9,$0C,$C7,$A8,$C6
	db $A8,$A8,$C7,$A8,$C7,$C7,$C7,$DA
	db $08,$DB,$0A,$24,$3E,$8E,$0C,$95
	db $24,$9A,$0C,$95,$24,$8C,$0C,$93
	db $98,$98,$93,$C6,$DA,$0C,$DB,$00
	db $0C,$6F,$A6,$C6,$AD,$C6,$C6,$AD
	db $A3,$A3,$A6,$C6,$AD,$C6,$C6,$AD
	db $A3,$A3,$DA,$0A,$DB,$14,$0C,$6B
	db $C7,$C6,$D2,$C6,$C6,$C6,$0C,$69
	db $D1,$D1,$0C,$6B,$C7,$C6,$D2,$C6
	db $C6,$C6,$0C,$69,$D1,$D1,$0C,$B0
	db $B0,$B0,$A6,$18,$B0,$0C,$A6,$AF
	db $C6,$AF,$AF,$AF,$AF,$C7,$C7,$C7
	db $00,$0C,$AD,$AD,$AD,$C7,$18,$AD
	db $0C,$C7,$AB,$C6,$AB,$AB,$AB,$AB
	db $C7,$C7,$C7,$0C,$A9,$A9,$A9,$C7
	db $18,$A9,$0C,$C7,$A8,$C6,$A8,$A8
	db $A8,$A8,$C7,$C7,$C7,$24,$8E,$0C
	db $95,$24,$9A,$0C,$95,$8C,$8C,$8C
	db $8C,$8C,$C6,$C6,$93,$0C,$A6,$C6
	db $AD,$C6,$C6,$AD,$A3,$A3,$A6,$C6
	db $AD,$AD,$AD,$C6,$B0,$C6,$0C,$C7
	db $C6,$D2,$C6,$C6,$C6,$0C,$69,$D1
	db $D1,$0C,$6B,$C7,$D1,$0C,$69,$D1
	db $0C,$6B,$D1,$30,$6C,$D1,$F0,$DA
	db $04,$E2,$18,$DB,$05,$DE,$00,$00
	db $00,$60,$49,$C6,$48,$C6,$0C,$C7
	db $AC,$00,$DA,$04,$DB,$0A,$DE,$00
	db $00,$00,$60,$49,$C6,$48,$C6,$0C
	db $C7,$A7,$DA,$04,$DB,$0F,$DE,$00
	db $00,$00,$60,$49,$C6,$48,$C6,$0C
	db $C7,$A1,$60,$AB,$48,$C6,$0C,$C7
	db $AB,$00,$60,$A6,$48,$C6,$0C,$C7
	db $A6,$60,$A0,$48,$C6,$0C,$C7,$A0
	db $60,$AC,$48,$C6,$0C,$C7,$AC,$00
	db $60,$A7,$48,$C6,$0C,$C7,$A7,$60
	db $A1,$48,$C6,$0C,$C7,$A1,$DA,$0E
	db $E7,$FF,$DB,$0A,$06,$6F,$C7,$84
	db $84,$84,$84,$C6,$84,$84,$C6,$84
	db $84,$C6,$84,$C6,$0C,$9A,$DD,$06
	db $04,$9C,$06,$C7,$84,$84,$84,$84
	db $C6,$84,$84,$C6,$84,$84,$C6,$84
	db $C6,$0C,$95,$DD,$06,$04,$97,$DA
	db $05,$DB,$14,$DE,$00,$00,$00,$E9
	db $8B,$1F,$20,$06,$49,$D1,$06,$49
	db $D1,$06,$4B,$D1,$06,$49,$D1,$06
	db $4C,$D1,$06,$49,$D1,$06,$4B,$D1
	db $06,$49,$D1,$06,$49,$D1,$06,$49
	db $D1,$06,$4B,$D1,$06,$49,$D1,$06
	db $4C,$D1,$06,$49,$D1,$06,$4B,$D1
	db $06,$49,$D1,$00,$DA,$05,$E7,$FF
	db $DB,$0A,$DE,$00,$00,$00,$18,$4F
	db $D0,$D8,$0C,$C7,$D0,$18,$D8,$D0
	db $D8,$0C,$C7,$D0,$18,$D8,$F0,$DA
	db $03,$E2,$1C,$DB,$0A,$12,$5D,$A8
	db $06,$A8,$0C,$A8,$9F,$18,$A1,$9F
	db $0C,$A8,$A8,$A8,$DA,$00,$DB,$00
	db $0C,$B7,$0C,$B9,$C6,$B7,$C7,$DA
	db $03,$DB,$0A,$12,$A9,$06,$A9,$0C
	db $A9,$A1,$18,$A3,$A1,$0C,$A9,$A9
	db $A9,$DA,$00,$DB,$00,$0C,$B9,$0C
	db $BB,$C6,$B9,$C7,$00,$DA,$03,$DB
	db $0A,$12,$5D,$A4,$06,$A4,$0C,$A4
	db $9C,$18,$9D,$9C,$0C,$A4,$A4,$A4
	db $DA,$00,$DB,$00,$0C,$B4,$0C,$B5
	db $C6,$B4,$C7,$DA,$03,$DB,$0A,$12
	db $A6,$06,$A6,$0C,$A6,$9D,$18,$9F
	db $9D,$0C,$A6,$A6,$A6,$DA,$00,$DB
	db $00,$0C,$B5,$0C,$B7,$C6,$B5,$C7
	db $DA,$04,$DB,$0A,$24,$6D,$8C,$0C
	db $93,$18,$98,$93,$0C,$8C,$8C,$8C
	db $C7,$0C,$C7,$C7,$8C,$C6,$24,$8E
	db $0C,$95,$18,$9A,$95,$0C,$8E,$8E
	db $8E,$C7,$0C,$C7,$C7,$8E,$C6,$DA
	db $04,$DB,$14,$06,$6B,$D1,$06,$69
	db $D1,$D1,$D1,$0C,$D1,$D1,$18,$D1
	db $D1,$0C,$6B,$D1,$D1,$D1,$C7,$30
	db $C7,$06,$6B,$D1,$06,$69,$D1,$D1
	db $D1,$0C,$D1,$D1,$18,$D1,$D1,$0C
	db $6B,$D1,$D1,$D1,$C7,$30,$C7,$DA
	db $03,$E2,$1C,$DB,$0A,$12,$5D,$A8
	db $06,$A8,$0C,$A8,$9F,$18,$A1,$9F
	db $DA,$01,$0C,$A8,$A7,$A6,$A5,$30
	db $A4,$00,$DA,$03,$DB,$0A,$12,$5D
	db $A4,$06,$A4,$0C,$A4,$9C,$18,$9D
	db $9C,$DA,$01,$0C,$A2,$A1,$A0,$9F
	db $30,$9E,$DA,$04,$DB,$0A,$24,$6D
	db $8C,$0C,$93,$18,$98,$93,$0C,$8C
	db $8B,$8A,$89,$30,$88,$DA,$04,$DB
	db $14,$06,$6B,$D1,$06,$69,$D1,$D1
	db $D1,$0C,$D1,$D1,$18,$D1,$D1,$48
	db $C7,$D4,$DA,$08,$E2,$1C,$DB,$0A
	db $18,$4F,$8C,$98,$89,$95,$8E,$9A
	db $87,$93,$8C,$98,$89,$95,$60,$C7
	db $00,$DA,$03,$DB,$0A,$08,$6F,$C7
	db $C7,$A4,$AF,$A4,$AF,$18,$C7,$AD
	db $08,$C7,$C7,$A6,$B0,$A6,$B0,$18
	db $C7,$AF,$08,$C7,$C7,$A4,$AF,$A4
	db $AF,$18,$C7,$AD,$08,$A6,$C7,$A8
	db $A9,$C7,$AB,$DA,$00,$08,$C7,$C7
	db $04,$B7,$B9,$0C,$B7,$C7,$DA,$03
	db $DB,$00,$08,$6F,$C7,$C7,$C7,$AB
	db $C7,$AB,$18,$C7,$A8,$08,$C7,$C7
	db $C7,$AD,$C7,$AD,$18,$C7,$AB,$08
	db $C7,$C7,$C7,$AB,$C7,$AB,$18,$C7
	db $A8,$60,$C7,$DA,$03,$DB,$14,$08
	db $6F,$C7,$C7,$C7,$A8,$C7,$A8,$18
	db $C7,$A4,$08,$C7,$C7,$C7,$A9,$C7
	db $A9,$18,$C7,$A6,$08,$C7,$C7,$C7
	db $A8,$C7,$A8,$18,$C7,$A4,$60,$C7
	db $08,$D1,$C7,$D1,$18,$D2,$00,$DA
	db $08,$DB,$0A,$18,$4F,$8C,$98,$89
	db $95,$8E,$9A,$87,$93,$8C,$98,$89
	db $95,$0C,$8E,$C7,$18,$C7,$30,$8D
	db $00,$F0,$DA,$03,$E2,$1C,$DB,$0A
	db $08,$6F,$C7,$C7,$A4,$AF,$A4,$AF
	db $18,$C7,$AD,$08,$C7,$C7,$A6,$B0
	db $A6,$B0,$18,$C7,$AF,$08,$C7,$C7
	db $A4,$AF,$A4,$AF,$18,$C7,$AD,$08
	db $B0,$C7,$AD,$C7,$A9,$C7,$18,$A8
	db $A6,$DA,$03,$DB,$00,$08,$6F,$C7
	db $C7,$C7,$AB,$C7,$AB,$18,$C7,$A8
	db $08,$C7,$C7,$C7,$AD,$C7,$AD,$18
	db $C7,$AB,$08,$C7,$C7,$C7,$AB,$C7
	db $AB,$18,$C7,$A8,$18,$AD,$C7,$30
	db $A3,$DA,$03,$DB,$14,$08,$6F,$C7
	db $C7,$C7,$A8,$C7,$A8,$18,$C7,$A4
	db $08,$C7,$C7,$C7,$A9,$C7,$A9,$18
	db $C7,$A6,$08,$C7,$C7,$C7,$A8,$C7
	db $A8,$18,$C7,$A4,$18,$A9,$C7,$30
	db $9D,$DA,$02,$DB,$14,$08,$6C,$D1
	db $C7,$D1,$18,$D2,$E9,$98,$21,$05
	db $18,$D1,$08,$D1,$D1,$D1,$18,$D2
	db $D2,$00,$DA,$02,$DB,$05,$DE,$00
	db $00,$00,$06,$6B,$B7,$C6,$C6,$C6
	db $AB,$C6,$C6,$C6,$60,$C6,$30,$C3
	db $06,$B6,$C6,$C6,$C6,$AA,$C6,$C6
	db $C6,$60,$C6,$30,$C2,$00,$DA,$02
	db $DB,$00,$DE,$00,$00,$00,$06,$6B
	db $C6,$B1,$C6,$C6,$C6,$B1,$C6,$C6
	db $60,$C6,$30,$C6,$06,$C6,$B0,$C6
	db $C6,$C6,$B0,$C6,$C6,$60,$C6,$30
	db $C6,$DA,$02,$DB,$14,$DE,$00,$00
	db $00,$06,$6D,$C6,$C6,$AB,$C6,$C6
	db $C6,$B7,$C6,$60,$C6,$30,$C6,$06
	db $C6,$C6,$AA,$C6,$C6,$C6,$B6,$C6
	db $60,$C6,$30,$C6,$DA,$02,$DB,$0F
	db $DE,$00,$00,$00,$06,$6D,$C6,$C6
	db $C6,$A5,$C6,$C6,$C6,$C6,$5A,$C6
	db $36,$B7,$06,$C6,$C6,$C6,$A4,$C6
	db $C6,$C6,$C6,$5A,$C6,$36,$B6,$06
	db $B5,$C6,$C6,$C6,$A9,$C6,$C6,$C6
	db $60,$C6,$30,$C6,$06,$B4,$C6,$C6
	db $C6,$A8,$C6,$C6,$C6,$60,$C6,$30
	db $C6,$00,$06,$C6,$AF,$C6,$C6,$C6
	db $AF,$C6,$C6,$60,$C6,$30,$C6,$06
	db $C6,$AE,$C6,$C6,$C6,$AE,$C6,$C6
	db $60,$C6,$30,$C6,$06,$C6,$C6,$A9
	db $C6,$C6,$C6,$B5,$C6,$60,$C6,$30
	db $C6,$06,$C6,$C6,$A8,$C6,$C6,$C6
	db $B4,$C6,$60,$C6,$30,$C6,$06,$C6
	db $C6,$C6,$A3,$C6,$C6,$C6,$C6,$5A
	db $C6,$36,$C6,$06,$C6,$C6,$C6,$A2
	db $C6,$C6,$C6,$C6,$5A,$C6,$36,$C6
	db $F0,$DA,$0E,$E2,$23,$DB,$0A,$30
	db $4E,$8E,$18,$C6,$0C,$8E,$8E,$60
	db $C7,$30,$91,$18,$C6,$0C,$91,$91
	db $60,$C7,$00,$DA,$07,$DB,$0A,$30
	db $4E,$8E,$18,$C6,$0C,$8E,$8E,$60
	db $C7,$30,$91,$18,$C6,$0C,$91,$91
	db $60,$C7,$00,$30,$4E,$94,$18,$C6
	db $0C,$94,$94,$60,$C7,$30,$8D,$18
	db $C6,$0C,$8D,$8D,$60,$C7,$30,$4E
	db $94,$18,$C6,$0C,$94,$94,$60,$C7
	db $30,$8D,$18,$C6,$0C,$8D,$8D,$0C
	db $6C,$C7,$D8,$0C,$6F,$D0,$D0,$0C
	db $7C,$D8,$0C,$7F,$D0,$0C,$D8,$D8
	db $DA,$05,$DB,$0A,$DE,$00,$00,$00
	db $E9,$BC,$23,$08,$0C,$49,$D1,$D1
	db $0C,$4B,$D1,$0C,$49,$D1,$0C,$4C
	db $D1,$0C,$49,$D1,$0C,$4B,$D1,$0C
	db $49,$D1,$00,$DA,$05,$DB,$0A,$DE
	db $00,$00,$00,$30,$4F,$D0,$02,$C7
	db $16,$D8,$0C,$C6,$D0,$0C,$C7,$D0
	db $C7,$D0,$01,$C7,$17,$D8,$0C,$C6
	db $D0,$30,$D0,$02,$C7,$16,$D8,$0C
	db $C6,$D0,$0C,$4D,$C7,$D0,$0C,$4E
	db $D0,$D0,$01,$C7,$17,$D8,$0C,$C6
	db $D0,$DA,$05,$DB,$0A,$DE,$00,$00
	db $00,$30,$4F,$D0,$02,$C7,$16,$D8
	db $0C,$C6,$D0,$0C,$C7,$D0,$C7,$D0
	db $01,$C7,$17,$D8,$0C,$C6,$D0,$30
	db $D0,$03,$C7,$15,$D8,$0C,$C6,$D0
	db $0C,$7F,$C7,$03,$C6,$09,$D8,$0C
	db $D0,$D0,$03,$C7,$09,$D8,$0C,$D0
	db $03,$C6,$09,$D8,$03,$C6,$09,$D8
	db $F0,$DA,$03,$E2,$3C,$E0,$E6,$DB
	db $0F,$18,$3E,$B2,$B2,$B2,$A6,$B2
	db $B2,$B2,$A6,$06,$B3,$B0,$B3,$B0
	db $B3,$B0,$B3,$B0,$B3,$B0,$B3,$B0
	db $B3,$B0,$B3,$B0,$18,$B2,$AD,$A6
	db $00,$DA,$00,$DB,$0A,$E7,$FA,$DE
	db $23,$13,$40,$18,$4E,$BE,$BE,$BE
	db $B2,$BE,$BE,$BE,$B2,$E1,$0C,$96
	db $0C,$BF,$E1,$54,$FA,$54,$C6,$E0
	db $E6,$18,$BE,$C7,$C7,$DA,$01,$DB
	db $0A,$E7,$FA,$DE,$23,$12,$40,$18
	db $4E,$A6,$A6,$A6,$9A,$A6,$A6,$A6
	db $9A,$60,$AD,$18,$AA,$C7,$C7,$DA
	db $00,$DB,$0A,$E7,$FA,$DE,$23,$11
	db $40,$60,$4E,$C7,$C7,$60,$9D,$18
	db $9A,$C7,$C7,$DA,$02,$E0,$C8,$DB
	db $00,$18,$4B,$B2,$BB,$BB,$BB,$B2
	db $BB,$BB,$BB,$B2,$BB,$BB,$BB,$0C
	db $BB,$BC,$18,$BB,$C6,$B9,$B2,$B9
	db $B9,$0C,$B9,$C6,$18,$B2,$B9,$B9
	db $0C,$B9,$C6,$18,$B2,$B9,$B9,$0C
	db $B9,$C6,$B9,$BB,$18,$B9,$C6,$B7
	db $00,$DA,$00,$DB,$0A,$E7,$DC,$DE
	db $23,$13,$40,$18,$4C,$B2,$BB,$BB
	db $0C,$4D,$BB,$C7,$18,$4C,$B2,$BB
	db $BB,$0C,$4D,$BB,$C7,$18,$4C,$B2
	db $BB,$BB,$0C,$4D,$BB,$C7,$0C,$4C
	db $BB,$BC,$18,$BB,$C6,$B9,$B2,$B9
	db $B9,$0C,$4D,$B9,$C7,$18,$4C,$B2
	db $B9,$B9,$0C,$4D,$B9,$C7,$18,$4C
	db $B2,$B9,$B9,$0C,$4D,$B9,$C7,$0C
	db $4C,$B9,$BB,$18,$B9,$C6,$B7,$DA
	db $01,$DB,$0A,$18,$6E,$C7,$93,$AB
	db $AB,$C7,$93,$AB,$AB,$C7,$93,$AB
	db $AB,$C7,$8E,$AA,$AA,$C7,$8E,$AA
	db $AA,$C7,$8E,$AA,$AA,$C7,$8E,$AA
	db $C7,$AA,$93,$AB,$AB,$DA,$01,$DB
	db $0F,$18,$6E,$C7,$C7,$A3,$A3,$C7
	db $C7,$A3,$A3,$C7,$C7,$A3,$A3,$C7
	db $C7,$A1,$A1,$C7,$C7,$A1,$A1,$C7
	db $C7,$A1,$A1,$C7,$C7,$A1,$C7,$A1
	db $C7,$A3,$A3,$DA,$03,$DB,$0F,$18
	db $6E,$C7,$C7,$9A,$9F,$C7,$C7,$9A
	db $9F,$C7,$C7,$9A,$A3,$C7,$A1,$C7
	db $A1,$C7,$C7,$9A,$A1,$C7,$C7,$9A
	db $A1,$C7,$C7,$9A,$9E,$C7,$9F,$C7
	db $9F,$DA,$01,$DB,$05,$DE,$23,$12
	db $40,$18,$6C,$C7,$E0,$C8,$E1,$FF
	db $F0,$60,$B7,$B5,$B4,$B3,$E1,$64
	db $C8,$B2,$B0,$AF,$48,$C6,$C7,$DA
	db $02,$DB,$00,$18,$4B,$B2,$BB,$BB
	db $BB,$B2,$BB,$BB,$BB,$B2,$BB,$BB
	db $BB,$0C,$B9,$BB,$18,$BC,$C6,$C0
	db $C6,$BE,$BE,$BE,$B2,$BC,$BC,$BC
	db $B6,$B7,$C6,$C6,$C7,$C7,$C7,$00
	db $DA,$00,$DB,$0A,$18,$4C,$B2,$BB
	db $BB,$0C,$4D,$BB,$C7,$18,$4C,$B2
	db $BB,$BB,$0C,$4D,$BB,$C7,$18,$4C
	db $B2,$BB,$BB,$0C,$4D,$BB,$C7,$0C
	db $4C,$B9,$BB,$30,$BC,$C0,$18,$BE
	db $BE,$0C,$4D,$BE,$C7,$18,$4C,$B2
	db $BC,$BC,$0C,$4D,$BC,$C7,$18,$4C
	db $B6,$B7,$C6,$C6,$C7,$C7,$C7,$DA
	db $01,$DB,$0A,$18,$6E,$C7,$93,$AB
	db $AB,$C7,$97,$AF,$AF,$C7,$98,$B0
	db $B0,$C7,$99,$B1,$B1,$C7,$9A,$AD
	db $AD,$C7,$92,$AA,$AA,$C7,$93,$C7
	db $8E,$C7,$93,$C7,$00,$DA,$01,$DB
	db $0F,$18,$6E,$C7,$C7,$A3,$A3,$C7
	db $C7,$A9,$A9,$C7,$C7,$AB,$AB,$C7
	db $C7,$AB,$AB,$C7,$C7,$A6,$A6,$C7
	db $C7,$A4,$A4,$C7,$A3,$C7,$9F,$C7
	db $A3,$C7,$00,$DA,$03,$DB,$0F,$18
	db $6E,$C7,$C7,$9A,$9F,$C7,$C7,$9D
	db $A3,$C7,$C7,$9F,$A4,$C7,$A5,$C7
	db $A5,$C7,$C7,$A1,$A6,$C7,$C7,$9E
	db $A4,$C7,$9A,$C7,$97,$C7,$93,$C7
	db $DA,$00,$DB,$05,$DE,$23,$12,$40
	db $24,$6D,$AF,$0C,$AD,$60,$AF,$B2
	db $B0,$B4,$30,$B6,$B7,$B9,$BC,$60
	db $BB,$30,$C7,$00,$DA,$01,$E7,$F0
	db $DB,$0A,$DE,$23,$13,$40,$24,$6E
	db $B2,$0C,$B0,$30,$AF,$B2,$B7,$18
	db $C6,$B6,$30,$B3,$B4,$B9,$18,$C6
	db $B7,$DA,$03,$DB,$0F,$06,$B6,$AD
	db $B6,$AD,$B6,$AD,$B6,$C7,$B7,$AF
	db $B7,$AF,$B7,$AF,$B7,$C7,$B9,$B0
	db $B9,$B0,$B9,$B0,$B9,$C7,$BC,$B4
	db $BC,$B4,$BC,$B4,$BC,$C7,$BB,$B2
	db $BB,$B2,$BB,$B2,$BB,$B2,$BB,$B2
	db $BB,$B2,$BB,$B2,$BB,$B2,$E8,$30
	db $60,$06,$BB,$B2,$BB,$B2,$BB,$B2
	db $BB,$B2,$DA,$01,$DB,$14,$30,$C7
	db $18,$9F,$A3,$A6,$A3,$9F,$A3,$A6
	db $A3,$A4,$A8,$AB,$A8,$A5,$A8,$AB
	db $A8,$A6,$AA,$AD,$AA,$A6,$AA,$AD
	db $AA,$9F,$A3,$A6,$A3,$9F,$A3,$A6
	db $A3,$DA,$04,$DE,$23,$11,$40,$DB
	db $0A,$30,$6C,$C7,$60,$93,$97,$98
	db $99,$9A,$95,$97,$93,$DA,$00,$DB
	db $05,$DE,$23,$12,$40,$24,$6D,$AF
	db $0C,$AD,$60,$AF,$B2,$B0,$B4,$30
	db $B6,$18,$B5,$B6,$48,$BC,$18,$B6
	db $60,$B7,$48,$C7,$00,$DA,$01,$DB
	db $0A,$E7,$FA,$24,$6E,$B2,$0C,$B0
	db $30,$AF,$B2,$B7,$18,$C6,$B6,$30
	db $B3,$B4,$B9,$18,$C6,$B7,$DA,$03
	db $DB,$0F,$06,$B6,$AD,$B6,$AD,$B6
	db $AD,$B6,$C7,$B5,$AD,$B5,$C7,$B6
	db $AD,$B6,$C7,$BC,$B2,$BC,$B2,$BC
	db $B2,$BC,$B2,$BC,$B2,$BC,$C7,$B6
	db $AD,$B6,$C7,$B7,$AF,$B7,$AF,$B7
	db $AF,$B7,$AF,$B7,$AF,$B7,$AF,$B7
	db $AF,$B7,$AF,$E8,$30,$60,$06,$B7
	db $AF,$B7,$AF,$B7,$AF,$B7,$AF,$C7
	db $C7,$C7,$C7,$DA,$01,$DB,$14,$30
	db $C7,$18,$9F,$A3,$A6,$A3,$A3,$A6
	db $A9,$A6,$A4,$A8,$AB,$A8,$A5,$A8
	db $AB,$A8,$A6,$AA,$AD,$AA,$A1,$A6
	db $AA,$A6,$A3,$A6,$A1,$A6,$9F,$C6
	db $C6,$DA,$04,$DB,$0A,$DE,$23,$11
	db $40,$30,$6D,$C7,$60,$93,$97,$98
	db $99,$9A,$92,$93,$C6,$DA,$00,$E0
	db $DC,$DB,$0A,$DE,$23,$12,$40,$18
	db $6E,$B3,$B4,$B4,$B4,$B6,$B7,$C6
	db $BC,$C6,$DA,$01,$E0,$AA,$10,$AF
	db $B0,$AF,$AD,$AF,$AD,$30,$AB,$18
	db $A6,$00,$DA,$02,$DB,$05,$E7,$FA
	db $18,$6E,$C7,$06,$98,$9A,$9C,$9D
	db $9F,$A1,$A3,$A4,$A6,$A8,$A9,$AB
	db $AD,$AF,$B0,$C6,$60,$C7,$DA,$01
	db $DB,$0A,$10,$AB,$AD,$AB,$AA,$AB
	db $AA,$30,$A6,$18,$A3,$DA,$01,$DB
	db $0A,$18,$6E,$C7,$48,$9F,$18,$9F
	db $30,$9F,$C7,$60,$9F,$9A,$DA,$01
	db $DB,$0A,$18,$6E,$C7,$48,$98,$18
	db $98,$30,$98,$C7,$60,$97,$93,$DA
	db $00,$E0,$DC,$DB,$0A,$DE,$23,$12
	db $40,$18,$6E,$B3,$B4,$B4,$B4,$B6
	db $B7,$C6,$BC,$C6,$DA,$01,$18,$2E
	db $B2,$B1,$B2,$AD,$A6,$A5,$A6,$A1
	db $E0,$96,$E1,$60,$FA,$60,$5E,$A7
	db $DA,$03,$DB,$0F,$18,$1E,$A6,$AD
	db $B2,$B9,$BE,$C7,$C7,$C7,$DA,$01
	db $DB,$0A,$48,$5D,$A6,$00,$DA,$02
	db $DB,$05,$18,$6E,$C7,$06,$98,$9A
	db $9C,$9D,$9F,$A1,$A3,$A4,$A6,$A8
	db $A9,$AB,$AD,$AF,$B0,$C6,$60,$C7
	db $DA,$01,$DB,$0A,$18,$AD,$C7,$C7
	db $AD,$AD,$C7,$C7,$AD,$9B,$C6,$C6
	db $C6,$DA,$00,$DB,$05,$18,$1E,$A6
	db $AD,$B2,$B9,$BE,$C7,$C7,$C7,$DA
	db $01,$48,$5D,$A1,$DA,$01,$DB,$0A
	db $18,$6E,$C7,$48,$9F,$18,$9F,$30
	db $9F,$C7,$18,$A1,$C7,$C7,$C7,$A1
	db $C7,$C7,$C7,$60,$9D,$18,$9E,$C7
	db $C7,$C7,$C7,$C7,$C7,$C7,$48,$5D
	db $9E,$DA,$01,$DB,$14,$18,$6E,$C7
	db $48,$C7,$18,$C7,$30,$C7,$C7,$18
	db $9E,$C7,$C7,$C7,$9E,$C7,$C7,$C7
	db $60,$A4,$18,$A1,$C7,$C7,$C7,$C7
	db $C7,$C7,$C7,$48,$5D,$A4,$00,$DA
	db $01,$DB,$0A,$18,$6E,$C7,$48,$98
	db $18,$98,$30,$98,$C7,$18,$9A,$C7
	db $C7,$C7,$9A,$C7,$C7,$C7,$60,$A1
	db $18,$9A,$C7,$C7,$C7,$C7,$C7,$C7
	db $C7,$48,$6E,$8E,$00
.end
	
	dw $0000				;		| Stop uploading data
	dw $0500				;		|
	
music_bank_2:
	dw .end-.start				;		| Length of music bank 2
	dw $1360				;		| Location of music in ARAM
	
.start
	db $18,$16,$AA,$18,$C6,$16,$62,$1A
	db $B0,$13,$72,$17,$DA,$17,$90,$14
	db $DE,$15,$A6,$15,$9A,$13,$F2,$15
	db $56,$19,$52,$15,$6E,$19,$6E,$19
	db $82,$19,$96,$19,$38,$1A,$10,$1A
	db $24,$1A,$62,$1A,$94,$1B,$BA,$1B
	db $34,$1B,$64,$1B,$CE,$1B,$F6,$1B
	db $5E,$1A,$F8,$15,$A0,$13,$00,$00
	db $2E,$2C,$68,$2C,$9A,$2C,$CC,$2C
	db $74,$2D,$52,$2D,$FE,$2C,$27,$2D
	db $D0,$13,$E0,$13,$20,$14,$60,$14
	db $F0,$13,$80,$14,$40,$14,$00,$14
	db $10,$14,$60,$14,$F0,$13,$80,$14
	db $40,$14,$FF,$00,$B2,$13,$00,$00
	db $7A,$34,$CC,$34,$E4,$34,$95,$34
	db $00,$00,$AC,$34,$FB,$34,$12,$35
	db $29,$35,$00,$00,$00,$00,$B8,$35
	db $00,$00,$DD,$35,$68,$35,$90,$35
	db $29,$35,$A4,$37,$A7,$37,$B8,$35
	db $00,$00,$DD,$35,$68,$35,$90,$35
	db $29,$35,$0C,$38,$0F,$38,$B8,$35
	db $00,$00,$DD,$35,$68,$35,$90,$35
	db $29,$35,$1F,$38,$22,$38,$B8,$35
	db $00,$00,$DD,$35,$68,$35,$90,$35
	db $29,$35,$52,$35,$54,$35,$B8,$35
	db $00,$00,$DD,$35,$68,$35,$90,$35
	db $29,$35,$00,$00,$00,$00,$CD,$35
	db $00,$00,$F2,$35,$68,$35,$90,$35
	db $29,$35,$F0,$37,$F3,$37,$CD,$35
	db $00,$00,$F2,$35,$68,$35,$90,$35
	db $25,$36,$00,$00,$00,$00,$B8,$35
	db $00,$00,$B8,$36,$70,$36,$94,$36
	db $25,$36,$4A,$36,$4D,$36,$B8,$35
	db $00,$00,$B8,$36,$70,$36,$94,$36
	db $E3,$36,$00,$00,$00,$00,$74,$37
	db $00,$00,$50,$37,$08,$37,$2C,$37
	db $E3,$36,$CA,$37,$CD,$37,$74,$37
	db $00,$00,$50,$37,$08,$37,$94,$36
	db $B2,$14,$C2,$14,$D2,$14,$C2,$14
	db $D2,$14,$E2,$14,$F2,$14,$02,$15
	db $22,$15,$12,$15,$22,$15,$32,$15
	db $42,$15,$12,$15,$FF,$00,$A0,$14
	db $00,$00,$AB,$2D,$C5,$2D,$D8,$2D
	db $EB,$2D,$FA,$2D,$09,$2E,$1A,$2E
	db $29,$2E,$3A,$2E,$B5,$2E,$00,$00
	db $00,$00,$00,$00,$2D,$2F,$00,$00
	db $00,$00,$3A,$2E,$B5,$2E,$46,$2F
	db $62,$2F,$00,$00,$2D,$2F,$00,$00
	db $00,$00,$80,$2F,$B7,$2F,$2A,$30
	db $95,$30,$61,$30,$ED,$2F,$00,$00
	db $0D,$30,$B5,$30,$08,$31,$00,$00
	db $00,$00,$00,$00,$5A,$31,$00,$00
	db $00,$00,$B5,$30,$08,$31,$B6,$31
	db $00,$00,$00,$00,$6E,$31,$00,$00
	db $00,$00,$B5,$30,$08,$31,$B6,$31
	db $00,$00,$00,$00,$8A,$31,$00,$00
	db $00,$00,$B5,$30,$08,$31,$EC,$31
	db $08,$32,$00,$00,$8A,$31,$00,$00
	db $00,$00,$23,$32,$6E,$32,$E8,$32
	db $03,$33,$00,$00,$BB,$32,$39,$33
	db $24,$33,$53,$33,$9E,$33,$16,$34
	db $34,$34,$00,$00,$E9,$33,$5F,$34
	db $4F,$34,$66,$15,$96,$15,$96,$15
	db $76,$15,$96,$15,$86,$15,$96,$15
	db $FF,$00,$5E,$15,$00,$00,$F5,$38
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$F8,$38
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$FC,$38
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$39
	db $43,$39,$24,$39,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$AE,$15
	db $BE,$15,$CE,$15,$00,$00,$D2,$3B
	db $DE,$3B,$E9,$3B,$F4,$3B,$FF,$3B
	db $0A,$3C,$17,$3C,$00,$00,$25,$3C
	db $2C,$3C,$35,$3C,$3E,$3C,$46,$3C
	db $50,$3C,$5A,$3C,$00,$00,$63,$3C
	db $6B,$3C,$74,$3C,$81,$3C,$8B,$3C
	db $97,$3C,$A0,$3C,$00,$00,$E2,$15
	db $00,$00,$00,$00,$AA,$3C,$D2,$3C
	db $E7,$3C,$00,$00,$00,$00,$00,$00
	db $00,$00,$F8,$15,$08,$16,$00,$00
	db $00,$00,$00,$3A,$18,$3A,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $37,$3B,$2F,$3A,$AB,$3B,$AC,$3A
	db $00,$00,$FD,$3A,$00,$00,$74,$3B
	db $36,$16,$96,$16,$A6,$16,$96,$16
	db $B6,$16,$46,$16,$56,$16,$46,$16
	db $56,$16,$66,$16,$76,$16,$86,$16
	db $FF,$00,$1A,$16,$00,$00,$0B,$3D
	db $2C,$3D,$38,$3D,$47,$3D,$00,$00
	db $00,$00,$00,$00,$00,$00,$5D,$3D
	db $7C,$3D,$AC,$3D,$BE,$3D,$00,$00
	db $D0,$3D,$00,$00,$00,$00,$14,$3E
	db $30,$3E,$60,$3E,$72,$3E,$00,$00
	db $D0,$3D,$00,$00,$00,$00,$84,$3E
	db $A1,$3E,$D1,$3E,$E3,$3E,$00,$00
	db $F5,$3E,$00,$00,$00,$00,$19,$3F
	db $A1,$3E,$D1,$3E,$E3,$3E,$00,$00
	db $F5,$3E,$00,$00,$00,$00,$34,$3F
	db $63,$3F,$B4,$3F,$E6,$3F,$00,$00
	db $D0,$3D,$00,$00,$00,$00,$1A,$40
	db $49,$40,$AB,$40,$C9,$40,$00,$00
	db $D0,$3D,$00,$00,$00,$00,$DD,$40
	db $0C,$41,$3C,$41,$5E,$41,$00,$00
	db $72,$41,$00,$00,$00,$00,$96,$41
	db $BF,$41,$EF,$41,$10,$42,$00,$00
	db $22,$42,$00,$00,$00,$00,$F2,$16
	db $E2,$16,$02,$17,$22,$17,$12,$17
	db $32,$17,$42,$17,$52,$17,$42,$17
	db $62,$17,$32,$17,$FF,$00,$C8,$16
	db $00,$00,$88,$52,$B8,$52,$72,$52
	db $00,$00,$00,$00,$F4,$52,$D6,$52
	db $00,$00,$E0,$51,$48,$52,$14,$52
	db $FC,$51,$00,$00,$00,$00,$2D,$52
	db $5C,$52,$40,$53,$9C,$53,$87,$53
	db $1E,$53,$00,$00,$F4,$52,$BA,$53
	db $59,$53,$40,$53,$6B,$53,$87,$53
	db $1E,$53,$9C,$53,$F4,$52,$BA,$53
	db $59,$53,$DB,$53,$62,$54,$28,$54
	db $D8,$53,$00,$00,$3B,$54,$81,$54
	db $F2,$53,$DB,$53,$0C,$54,$28,$54
	db $D8,$53,$62,$54,$3B,$54,$81,$54
	db $FF,$53,$A3,$54,$C6,$54,$BD,$54
	db $A0,$54,$00,$00,$EB,$54,$D7,$54
	db $AF,$54,$0B,$55,$29,$55,$20,$55
	db $09,$55,$00,$00,$EB,$54,$37,$55
	db $15,$55,$48,$55,$29,$55,$20,$55
	db $46,$55,$00,$00,$EB,$54,$37,$55
	db $52,$55,$8A,$17,$9A,$17,$AA,$17
	db $BA,$17,$AA,$17,$BA,$17,$AA,$17
	db $CA,$17,$CA,$17,$FF,$00,$76,$17
	db $00,$00,$46,$42,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$59,$42,$00,$00,$00,$00
	db $EF,$42,$00,$00,$16,$43,$00,$00
	db $00,$00,$CA,$42,$00,$00,$00,$00
	db $EF,$42,$00,$00,$16,$43,$00,$00
	db $00,$00,$CA,$42,$A3,$42,$7E,$42
	db $EF,$42,$00,$00,$16,$43,$00,$00
	db $00,$00,$7C,$43,$60,$43,$46,$43
	db $EF,$42,$00,$00,$16,$43,$00,$00
	db $00,$00,$FA,$17,$0A,$18,$4A,$18
	db $6A,$18,$8A,$18,$1A,$18,$9A,$18
	db $6A,$18,$2A,$18,$7A,$18,$4A,$18
	db $3A,$18,$5A,$18,$FF,$00,$DA,$17
	db $00,$00,$D2,$43,$2F,$44,$05,$44
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$D2,$43,$2F,$44,$05,$44
	db $75,$44,$00,$00,$59,$44,$00,$00
	db $00,$00,$99,$46,$99,$47,$EA,$46
	db $B6,$47,$00,$00,$7E,$47,$34,$47
	db $00,$00,$D1,$47,$7B,$48,$D1,$47
	db $98,$48,$00,$00,$60,$48,$1A,$48
	db $00,$00,$B3,$48,$5D,$49,$B3,$48
	db $7A,$49,$00,$00,$42,$49,$FC,$48
	db $00,$00,$91,$44,$E3,$44,$BD,$44
	db $25,$45,$00,$00,$09,$45,$00,$00
	db $00,$00,$91,$44,$E3,$44,$BD,$44
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$41,$45,$93,$45,$6D,$45
	db $D5,$45,$00,$00,$B9,$45,$00,$00
	db $00,$00,$41,$45,$93,$45,$6D,$45
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$F1,$45,$43,$46,$1D,$46
	db $81,$46,$00,$00,$69,$46,$00,$00
	db $00,$00,$F1,$45,$43,$46,$1D,$46
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$D6,$18,$C6,$18,$E6,$18
	db $F6,$18,$E6,$18,$F6,$18,$06,$19
	db $16,$19,$46,$19,$26,$19,$36,$19
	db $FF,$00,$AC,$18,$00,$00,$52,$4A
	db $C9,$4A,$05,$4B,$1B,$4B,$1B,$4B
	db $09,$4C,$1B,$4B,$8D,$4A,$95,$49
	db $F6,$49,$24,$4A,$DE,$49,$C6,$49
	db $3A,$4A,$0C,$4A,$AF,$49,$21,$4B
	db $7C,$4B,$51,$4C,$EC,$4B,$00,$00
	db $09,$4C,$00,$00,$B4,$4B,$65,$4C
	db $B8,$4C,$39,$4D,$20,$4D,$00,$00
	db $09,$4C,$00,$00,$EC,$4C,$4B,$4D
	db $9E,$4D,$1C,$4E,$06,$4E,$00,$00
	db $32,$4E,$00,$00,$D2,$4D,$5F,$4E
	db $B2,$4E,$2D,$4F,$1A,$4F,$00,$00
	db $32,$4E,$00,$00,$E6,$4E,$3F,$4F
	db $75,$4F,$BC,$4F,$98,$4F,$00,$00
	db $D3,$4F,$00,$00,$3F,$4F,$3F,$4F
	db $02,$50,$41,$50,$21,$50,$00,$00
	db $D3,$4F,$00,$00,$3F,$4F,$58,$50
	db $E0,$50,$BA,$51,$8E,$51,$00,$00
	db $09,$4C,$00,$00,$37,$51,$5E,$19
	db $FF,$00,$56,$19,$00,$00,$81,$39
	db $C1,$39,$60,$39,$9F,$39,$00,$00
	db $D8,$39,$00,$00,$00,$00,$72,$19
	db $00,$00,$75,$38,$8C,$38,$9B,$38
	db $AA,$38,$B9,$38,$C8,$38,$D7,$38
	db $E6,$38,$86,$19,$00,$00,$45,$38
	db $5E,$38,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$B0,$19
	db $C0,$19,$D0,$19,$E0,$19,$D0,$19
	db $E0,$19,$F0,$19,$00,$1A,$D0,$19
	db $E0,$19,$FF,$00,$98,$19,$00,$00
	db $36,$29,$82,$29,$5E,$29,$70,$29
	db $00,$00,$4C,$29,$00,$00,$00,$00
	db $00,$00,$BB,$29,$95,$29,$E2,$29
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $2F,$2A,$76,$2A,$8C,$2A,$E2,$29
	db $00,$00,$55,$2A,$00,$00,$A2,$2A
	db $B8,$2A,$EB,$2A,$FC,$2A,$E2,$29
	db $00,$00,$D2,$2A,$00,$00,$0D,$2B
	db $1E,$2B,$32,$2B,$44,$2B,$E2,$29
	db $00,$00,$00,$00,$00,$00,$55,$2B
	db $66,$2B,$32,$2B,$44,$2B,$E2,$29
	db $00,$00,$00,$00,$00,$00,$55,$2B
	db $14,$1A,$00,$00,$78,$2B,$C7,$2B
	db $DD,$2B,$09,$2C,$00,$00,$B0,$2B
	db $95,$2B,$F3,$2B,$28,$1A,$00,$00
	db $6F,$26,$84,$26,$95,$26,$B9,$26
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $3E,$1A,$4E,$1A,$00,$00,$DC,$26
	db $4A,$27,$A4,$27,$83,$27,$18,$27
	db $C5,$27,$5F,$28,$12,$28,$86,$28
	db $A9,$28,$EE,$28,$CD,$28,$B4,$28
	db $D4,$28,$F5,$28,$95,$28,$84,$1A
	db $00,$00,$84,$1A,$94,$1A,$B4,$1A
	db $C4,$1A,$B4,$1A,$D4,$1A,$E4,$1A
	db $F4,$1A,$E4,$1A,$04,$1B,$14,$1B
	db $24,$1B,$14,$1B,$24,$1B,$A4,$1A
	db $FF,$00,$68,$1A,$B3,$22,$D5,$22
	db $F1,$22,$0D,$23,$26,$23,$36,$23
	db $00,$00,$56,$23,$78,$23,$94,$23
	db $AA,$23,$C0,$23,$D6,$23,$EC,$23
	db $00,$00,$00,$00,$6F,$24,$5B,$24
	db $5E,$26,$95,$24,$43,$24,$B0,$24
	db $5B,$26,$65,$24,$6F,$24,$5B,$24
	db $00,$00,$95,$24,$43,$24,$B0,$24
	db $00,$00,$65,$24,$6F,$24,$5B,$24
	db $00,$00,$95,$24,$4F,$24,$B0,$24
	db $00,$00,$65,$24,$6F,$24,$5B,$24
	db $00,$00,$95,$24,$4F,$24,$BD,$24
	db $00,$00,$65,$24,$6F,$24,$5B,$24
	db $02,$24,$95,$24,$43,$24,$B0,$24
	db $1A,$24,$65,$24,$6F,$24,$5B,$24
	db $36,$24,$95,$24,$4F,$24,$B0,$24
	db $33,$24,$65,$24,$6F,$24,$5B,$24
	db $36,$24,$95,$24,$4F,$24,$BD,$24
	db $33,$24,$65,$24,$5E,$25,$E3,$24
	db $D8,$24,$81,$25,$00,$00,$9C,$25
	db $D5,$24,$1F,$25,$38,$26,$C2,$25
	db $B8,$25,$81,$25,$00,$00,$9C,$25
	db $B5,$25,$FC,$25,$54,$1B,$B4,$1A
	db $C4,$1A,$B4,$1A,$D4,$1A,$E4,$1A
	db $F4,$1A,$E4,$1A,$04,$1B,$14,$1B
	db $24,$1B,$14,$1B,$24,$1B,$A4,$1A
	db $FF,$00,$38,$1B,$55,$22,$77,$22
	db $83,$22,$8F,$22,$9B,$22,$A7,$22
	db $00,$00,$00,$00,$84,$1B,$B4,$1A
	db $C4,$1A,$B4,$1A,$D4,$1A,$E4,$1A
	db $F4,$1A,$E4,$1A,$04,$1B,$14,$1B
	db $24,$1B,$14,$1B,$24,$1B,$A4,$1A
	db $FF,$00,$68,$1B,$66,$22,$77,$22
	db $83,$22,$8F,$22,$9B,$22,$A7,$22
	db $00,$00,$00,$00,$9A,$1B,$AA,$1B
	db $00,$00,$4B,$1F,$86,$1F,$BB,$1F
	db $F0,$1F,$00,$00,$00,$00,$00,$00
	db $00,$00,$25,$20,$7F,$20,$D3,$20
	db $27,$21,$00,$00,$00,$00,$00,$00
	db $00,$00,$BE,$1B,$00,$00,$7B,$21
	db $B6,$21,$EB,$21,$20,$22,$00,$00
	db $00,$00,$00,$00,$00,$00,$D6,$1B
	db $E6,$1B,$9A,$1B,$00,$00,$50,$1D
	db $A6,$1D,$FB,$1D,$50,$1E,$00,$00
	db $00,$00,$00,$00,$00,$00,$7D,$1E
	db $B5,$1E,$E7,$1E,$19,$1F,$00,$00
	db $00,$00,$00,$00,$00,$00,$FC,$1B
	db $0C,$1C,$00,$00,$1C,$1C,$3F,$1C
	db $68,$1C,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$79,$1C,$DC,$1C
	db $33,$1D,$F9,$1C,$16,$1D,$AB,$1C
	db $00,$00,$00,$00,$DA,$12,$E2,$14
	db $DE,$14,$14,$20,$DB,$0A,$0C,$6D
	db $AA,$0C,$3D,$AD,$0C,$6D,$A8,$0C
	db $3D,$AD,$0C,$6D,$A6,$0C,$3D,$AD
	db $18,$6D,$B2,$60,$B9,$C6,$00,$DA
	db $12,$DB,$0A,$06,$C7,$0C,$6B,$AA
	db $0C,$3B,$AD,$0C,$6B,$A8,$0C,$3B
	db $AD,$0C,$6B,$A6,$0C,$3B,$AD,$18
	db $6B,$B2,$42,$B9,$DA,$00,$08,$4B
	db $B9,$B2,$B2,$B9,$B9,$BE,$48,$BE
	db $DA,$12,$DE,$14,$14,$20,$DB,$0A
	db $18,$5D,$9A,$99,$98,$97,$60,$96
	db $C6,$DA,$12,$E2,$23,$DE,$14,$14
	db $20,$DB,$0A,$18,$6D,$A6,$A8,$48
	db $6D,$AB,$0C,$3D,$A8,$AB,$48,$6D
	db $AF,$0C,$3D,$AB,$AF,$18,$6E,$B2
	db $0C,$3E,$AF,$B2,$18,$6E,$B4,$0C
	db $3E,$B2,$B4,$30,$6F,$B7,$BB,$60
	db $BE,$C6,$00,$DA,$12,$DE,$14,$14
	db $20,$DB,$0A,$06,$C7,$18,$6B,$A6
	db $A8,$48,$6B,$AB,$0C,$3B,$A8,$AB
	db $48,$6B,$AF,$0C,$3B,$AB,$AF,$18
	db $6B,$B2,$0C,$3B,$AF,$B2,$18,$6B
	db $B4,$0C,$3B,$B2,$B4,$30,$6C,$B7
	db $BB,$60,$BE,$C6,$DA,$12,$DE,$14
	db $14,$20,$DB,$0F,$30,$C7,$48,$6D
	db $A8,$18,$C6,$48,$AB,$18,$C6,$AF
	db $C6,$B0,$C6,$30,$B4,$B7,$60,$BB
	db $C6,$DA,$12,$DE,$14,$14,$20,$DB
	db $05,$30,$C7,$48,$6D,$A4,$18,$C6
	db $48,$A8,$18,$C6,$AB,$C6,$AD,$C6
	db $30,$B0,$B4,$60,$B6,$C6,$DA,$12
	db $DE,$14,$14,$20,$DB,$0A,$30,$C7
	db $48,$6D,$A1,$18,$C6,$48,$A4,$18
	db $C6,$A8,$C6,$AB,$C6,$30,$AD,$B0
	db $60,$B2,$C6,$DA,$12,$DE,$14,$14
	db $20,$DB,$0A,$30,$C7,$48,$6D,$8E
	db $18,$C6,$48,$8E,$18,$C6,$8E,$C6
	db $8E,$C6,$30,$8E,$8E,$60,$93,$C6
	db $DA,$11,$E2,$32,$DB,$14,$0C,$7F
	db $A8,$DD,$00,$0C,$A3,$0C,$7E,$A8
	db $DD,$00,$0C,$A3,$0C,$7D,$A8,$DD
	db $00,$0C,$A3,$0C,$7C,$A8,$DD,$00
	db $0C,$A3,$0C,$7F,$A8,$DD,$00,$0C
	db $A3,$0C,$7E,$A8,$DD,$00,$0C,$A3
	db $0C,$7D,$A8,$DD,$00,$0C,$A3,$0C
	db $7C,$A8,$DD,$00,$0C,$A3,$18,$7F
	db $A8,$DD,$00,$18,$A3,$18,$7E,$A4
	db $DD,$00,$18,$9F,$60,$7E,$A8,$DD
	db $00,$60,$AB,$60,$C7,$00,$DA,$11
	db $DB,$0A,$03,$C7,$0C,$7F,$A2,$DD
	db $00,$0C,$9E,$0C,$7E,$A2,$DD,$00
	db $0C,$9E,$0C,$7D,$A2,$DD,$00,$0C
	db $9E,$0C,$7C,$A2,$DD,$00,$0C,$9E
	db $0C,$7F,$A2,$DD,$00,$0C,$9E,$0C
	db $7E,$A2,$DD,$00,$0C,$9E,$0C,$7D
	db $A2,$DD,$00,$0C,$9E,$0C,$7C,$A2
	db $DD,$00,$0C,$9E,$18,$7F,$A2,$DD
	db $00,$18,$9D,$18,$7E,$9F,$DD,$00
	db $18,$9A,$60,$7E,$A2,$DD,$00,$60
	db $A5,$60,$C7,$DA,$11,$DB,$05,$06
	db $C7,$0C,$7F,$9D,$DD,$00,$0C,$99
	db $0C,$7E,$9D,$DD,$00,$0C,$99,$0C
	db $7D,$9D,$DD,$00,$0C,$99,$0C,$7C
	db $9D,$DD,$00,$0C,$99,$0C,$7F,$9D
	db $DD,$00,$0C,$99,$0C,$7E,$9D,$DD
	db $00,$0C,$99,$0C,$7D,$9D,$DD,$00
	db $0C,$99,$0C,$7C,$9D,$DD,$00,$0C
	db $99,$18,$7F,$9D,$DD,$00,$18,$97
	db $18,$7E,$9A,$DD,$00,$18,$95,$60
	db $7E,$9D,$DD,$00,$60,$A2,$60,$C7
	db $DA,$11,$DB,$0A,$06,$7E,$D0,$06
	db $7D,$D0,$06,$7C,$D0,$06,$7B,$D0
	db $18,$79,$D0,$06,$7E,$D0,$06,$7D
	db $D0,$06,$7C,$D0,$06,$7B,$D0,$18
	db $79,$D0,$30,$C6,$60,$7E,$98,$DD
	db $00,$60,$9C,$60,$C7,$DA,$11,$E2
	db $19,$E0,$FF,$E1,$60,$C8,$DB,$14
	db $18,$7F,$9A,$DD,$00,$0C,$A1,$DD
	db $00,$0C,$98,$18,$7F,$9D,$DD,$00
	db $0C,$A4,$DD,$00,$0C,$9C,$18,$7F
	db $A1,$DD,$00,$0C,$A8,$DD,$00,$0C
	db $9F,$18,$7E,$A4,$DD,$00,$0C,$AB
	db $DD,$00,$0C,$A3,$00,$DA,$11,$DB
	db $00,$06,$C7,$18,$7F,$9A,$DD,$00
	db $0C,$A1,$DD,$00,$0C,$98,$18,$7F
	db $9D,$DD,$00,$0C,$A4,$DD,$00,$0C
	db $9C,$18,$7F,$A1,$DD,$00,$0C,$A8
	db $DD,$00,$0C,$9F,$18,$7E,$A4,$DD
	db $00,$0C,$AB,$DD,$00,$0C,$A3,$DA
	db $11,$DB,$0F,$0C,$C7,$18,$7F,$91
	db $DD,$00,$0C,$9A,$DD,$00,$0C,$90
	db $18,$7F,$95,$DD,$00,$0C,$9D,$DD
	db $00,$0C,$93,$18,$7F,$98,$DD,$00
	db $0C,$9F,$DD,$00,$0C,$97,$18,$7E
	db $9D,$DD,$00,$0C,$A3,$DD,$00,$0C
	db $9A,$DA,$11,$DB,$05,$12,$C7,$18
	db $7F,$91,$DD,$00,$0C,$9A,$DD,$00
	db $0C,$90,$18,$7F,$95,$DD,$00,$0C
	db $9D,$DD,$00,$0C,$93,$18,$7F,$98
	db $DD,$00,$0C,$9F,$DD,$00,$0C,$97
	db $18,$7E,$9D,$DD,$00,$18,$A3,$DD
	db $00,$18,$9A,$DA,$11,$E2,$19,$E0
	db $C8,$E1,$60,$64,$DB,$14,$DC,$30
	db $0A,$18,$7E,$A8,$DD,$00,$0C,$AF
	db $DD,$00,$0C,$A6,$18,$7D,$AB,$DD
	db $00,$0C,$B0,$DD,$00,$0C,$A8,$18
	db $7C,$AF,$DD,$00,$0C,$B5,$DD,$00
	db $0C,$AD,$18,$7B,$B2,$DD,$00,$0C
	db $B9,$DD,$00,$0C,$B0,$00,$DA,$11
	db $DB,$00,$DC,$30,$0A,$06,$C7,$18
	db $7E,$A8,$DD,$00,$0C,$AF,$DD,$00
	db $0C,$A6,$18,$7D,$AB,$DD,$00,$0C
	db $B0,$DD,$00,$0C,$A8,$18,$7C,$AF
	db $DD,$00,$0C,$B5,$DD,$00,$0C,$AD
	db $18,$7B,$B2,$DD,$00,$0C,$B9,$DD
	db $00,$0C,$B0,$DA,$11,$DB,$0F,$DC
	db $30,$0A,$0C,$C7,$18,$7E,$9F,$DD
	db $00,$0C,$A6,$DD,$00,$0C,$9D,$18
	db $7D,$A3,$DD,$00,$0C,$A9,$DD,$00
	db $0C,$A1,$18,$7C,$A6,$DD,$00,$0C
	db $AB,$DD,$00,$0C,$A4,$18,$7B,$A9
	db $DD,$00,$0C,$AF,$DD,$00,$0C,$A8
	db $DA,$11,$DB,$05,$DC,$30,$0A,$12
	db $C7,$18,$7E,$9F,$DD,$00,$0C,$A6
	db $DD,$00,$0C,$9D,$18,$7D,$A3,$DD
	db $00,$0C,$A9,$DD,$00,$0C,$A1,$18
	db $7C,$A6,$DD,$00,$0C,$AB,$DD,$00
	db $0C,$A4,$18,$7B,$A9,$DD,$00,$0C
	db $AF,$DD,$00,$0C,$A8,$DA,$11,$E0
	db $64,$E1,$60,$FF,$DB,$0A,$DC,$60
	db $14,$18,$7B,$B2,$DD,$00,$0C,$B9
	db $DD,$00,$0C,$B0,$18,$7B,$AF,$DD
	db $00,$0C,$B5,$DD,$00,$0C,$AD,$18
	db $7C,$AB,$DD,$00,$0C,$B0,$DD,$00
	db $0C,$A8,$18,$7C,$A8,$DD,$00,$0C
	db $AF,$DD,$00,$0C,$B2,$18,$7D,$A4
	db $DD,$00,$0C,$AB,$DD,$00,$0C,$AF
	db $18,$7E,$A1,$DD,$00,$0C,$A8,$DD
	db $00,$0C,$9F,$2A,$7F,$9D,$DD,$00
	db $0C,$A4,$DD,$00,$1E,$9C,$00,$DB
	db $0A,$DC,$60,$00,$06,$C7,$18,$7B
	db $B2,$DD,$00,$0C,$B9,$DD,$00,$0C
	db $B0,$18,$7B,$AF,$DD,$00,$0C,$B5
	db $DD,$00,$0C,$AD,$18,$7C,$AB,$DD
	db $00,$0C,$B0,$DD,$00,$0C,$A8,$18
	db $7C,$A8,$DD,$00,$0C,$AF,$DD,$00
	db $0C,$B2,$18,$7D,$A4,$DD,$00,$0C
	db $AB,$DD,$00,$0C,$AF,$18,$7E,$A1
	db $DD,$00,$0C,$A8,$DD,$00,$0C,$9F
	db $24,$7F,$9D,$DD,$00,$0C,$A4,$DD
	db $00,$18,$9C,$DB,$0A,$DC,$60,$0F
	db $0C,$C7,$18,$7B,$A9,$DD,$00,$0C
	db $AD,$DD,$00,$0C,$9C,$18,$7B,$A6
	db $DD,$00,$0C,$AB,$DD,$00,$0C,$A4
	db $18,$7C,$A3,$DD,$00,$0C,$A9,$DD
	db $00,$0C,$A1,$18,$7C,$9F,$DD,$00
	db $0C,$A6,$DD,$00,$0C,$9D,$18,$7D
	db $9C,$DD,$00,$0C,$A3,$DD,$00,$0C
	db $9A,$18,$7E,$98,$DD,$00,$0C,$A1
	db $DD,$00,$0C,$97,$1E,$7F,$95,$DD
	db $00,$0C,$9D,$DD,$00,$12,$93,$DB
	db $0A,$DC,$60,$05,$12,$C7,$18,$7B
	db $A9,$DD,$00,$0C,$AD,$DD,$00,$0C
	db $9C,$18,$7B,$A6,$DD,$00,$0C,$AB
	db $DD,$00,$0C,$A4,$18,$7C,$A3,$DD
	db $00,$0C,$A9,$DD,$00,$0C,$A1,$18
	db $7C,$9F,$DD,$00,$0C,$A6,$DD,$00
	db $0C,$9D,$18,$7D,$9C,$DD,$00,$0C
	db $A3,$DD,$00,$0C,$9A,$18,$7E,$98
	db $DD,$00,$0C,$A1,$DD,$00,$0C,$97
	db $18,$7F,$95,$DD,$00,$0C,$9D,$DD
	db $00,$0C,$93,$DA,$11,$E2,$19,$E0
	db $FF,$E1,$60,$C8,$DB,$14,$DC,$60
	db $0A,$18,$7F,$A8,$DD,$00,$0C,$AF
	db $DD,$00,$0C,$B2,$18,$7E,$A4,$DD
	db $00,$0C,$AB,$DD,$00,$0C,$AF,$18
	db $7D,$A1,$DD,$00,$0C,$A8,$DD,$00
	db $0C,$9F,$2A,$7C,$9D,$DD,$00,$0C
	db $A4,$DD,$00,$1E,$9C,$00,$DA,$11
	db $DB,$00,$DC,$60,$0A,$06,$C7,$18
	db $7F,$A8,$DD,$00,$0C,$AF,$DD,$00
	db $0C,$B2,$18,$7E,$A4,$DD,$00,$0C
	db $AB,$DD,$00,$0C,$AF,$18,$7D,$A1
	db $DD,$00,$0C,$A8,$DD,$00,$0C,$9F
	db $24,$7C,$9D,$DD,$00,$0C,$A4,$DD
	db $00,$18,$9C,$DA,$11,$DB,$0F,$DC
	db $60,$0A,$0C,$C7,$18,$7F,$9F,$DD
	db $00,$0C,$A6,$DD,$00,$0C,$9D,$18
	db $7E,$9C,$DD,$00,$0C,$A3,$DD,$00
	db $0C,$9A,$18,$7D,$98,$DD,$00,$0C
	db $A1,$DD,$00,$0C,$97,$1E,$7C,$95
	db $DD,$00,$0C,$9D,$DD,$00,$12,$93
	db $DA,$11,$DB,$05,$DC,$60,$0A,$12
	db $C7,$18,$7F,$9F,$DD,$00,$0C,$A6
	db $DD,$00,$0C,$9D,$18,$7E,$9C,$DD
	db $00,$0C,$A3,$DD,$00,$0C,$9A,$18
	db $7D,$98,$DD,$00,$0C,$A1,$DD,$00
	db $0C,$97,$18,$7C,$95,$DD,$00,$0C
	db $9D,$DD,$00,$0C,$93,$DA,$04,$E2
	db $28,$DB,$0A,$48,$7E,$A3,$C6,$DD
	db $0C,$60,$97,$E2,$41,$00,$DA,$04
	db $E2,$32,$DB,$0A,$48,$7E,$A3,$C6
	db $DD,$0C,$60,$97,$E2,$46,$00,$DA
	db $04,$DB,$14,$48,$7E,$A8,$C6,$DD
	db $0C,$60,$97,$DA,$04,$DB,$0F,$48
	db $7E,$AD,$C6,$DD,$0C,$60,$97,$DA
	db $04,$DB,$05,$48,$7E,$B2,$C6,$DD
	db $0C,$60,$97,$DA,$04,$DB,$00,$48
	db $7E,$B7,$C6,$DD,$0C,$60,$97,$DA
	db $04,$DB,$0A,$48,$7E,$BB,$C6,$DD
	db $0C,$60,$97,$DA,$04,$E2,$0D,$E3
	db $FF,$1E,$DB,$14,$18,$7D,$84,$8A
	db $89,$88,$82,$83,$18,$7E,$84,$8A
	db $89,$88,$82,$83,$18,$7F,$84,$8A
	db $89,$88,$C7,$C7,$00,$DA,$04,$DB
	db $0A,$18,$7D,$90,$96,$95,$94,$8E
	db $8F,$18,$7E,$90,$96,$95,$94,$8E
	db $8F,$18,$7F,$90,$96,$95,$94,$C7
	db $C7,$DA,$04,$DB,$00,$18,$7D,$8B
	db $91,$90,$8F,$89,$8A,$18,$7E,$8B
	db $91,$90,$8F,$89,$8A,$18,$7F,$8B
	db $91,$90,$8F,$C7,$C7,$DA,$04,$DB
	db $0F,$60,$7D,$C7,$30,$C7,$18,$7E
	db $97,$9D,$9C,$9B,$95,$96,$18,$7F
	db $97,$9D,$9C,$9B,$C7,$C7,$DA,$04
	db $DB,$0A,$60,$C7,$C7,$C7,$18,$7F
	db $9C,$A2,$A1,$A0,$C7,$C7,$DA,$04
	db $DB,$0A,$06,$C7,$18,$79,$90,$96
	db $95,$94,$8E,$8F,$18,$7B,$97,$9D
	db $9C,$9B,$95,$96,$18,$7C,$9C,$A2
	db $A1,$12,$A0,$18,$C7,$C7,$DA,$04
	db $DB,$0A,$18,$7D,$D0,$D0,$D0,$D0
	db $D0,$D0,$18,$7E,$D0,$D0,$D0,$D0
	db $D0,$D0,$0C,$7F,$D0,$D0,$D0,$D0
	db $D0,$D0,$D0,$D0,$C7,$C7,$C7,$C7
	db $DA,$04,$E2,$14,$E3,$FF,$28,$DB
	db $14,$48,$7E,$84,$DB,$08,$48,$A2
	db $DB,$0A,$48,$A3,$C6,$DD,$0C,$60
	db $97,$E2,$3C,$00,$DA,$04,$DB,$12
	db $0C,$7E,$C7,$48,$89,$DB,$06,$3C
	db $A7,$DB,$14,$48,$A8,$C6,$DD,$0C
	db $60,$97,$DA,$04,$DB,$10,$18,$7E
	db $C7,$48,$8E,$DB,$04,$30,$AC,$DB
	db $0F,$48,$AD,$C6,$DD,$0C,$60,$97
	db $DA,$04,$DB,$0E,$24,$7E,$C7,$48
	db $93,$DB,$02,$24,$B1,$DB,$05,$48
	db $B2,$C6,$DD,$0C,$60,$97,$DA,$04
	db $DB,$0C,$30,$7E,$C7,$48,$98,$DB
	db $00,$18,$B6,$DB,$00,$48,$B7,$C6
	db $DD,$0C,$60,$97,$DA,$04,$DB,$0A
	db $3C,$7E,$C7,$48,$9D,$DB,$00,$0C
	db $BA,$DB,$0A,$48,$BB,$C6,$DD,$0C
	db $60,$97,$E7,$F0,$DA,$11,$DE,$48
	db $07,$30,$DB,$0A,$08,$7E,$97,$9A
	db $9D,$48,$A3,$54,$A2,$6C,$9C,$60
	db $C6,$00,$E7,$F0,$DA,$11,$DE,$48
	db $07,$30,$DB,$0C,$08,$7C,$C6,$C6
	db $97,$9A,$9D,$48,$A3,$54,$A2,$6C
	db $9C,$60,$C6,$08,$C6,$C6,$08,$97
	db $9A,$9D,$48,$A3,$54,$A2,$6C,$A6
	db $60,$C6,$00,$DA,$0F,$DB,$0F,$60
	db $7D,$C6,$54,$9E,$6C,$A1,$C6,$DA
	db $0F,$DB,$0F,$60,$7D,$C6,$54,$A1
	db $6C,$A7,$C6,$DA,$11,$DB,$0F,$60
	db $7D,$97,$96,$95,$94,$DA,$11,$DB
	db $05,$60,$7D,$90,$8F,$8E,$8D,$DA
	db $0E,$DB,$0A,$0C,$7F,$90,$C6,$90
	db $C6,$90,$C6,$90,$C6,$0C,$90,$90
	db $90,$8E,$C6,$8E,$8E,$8F,$18,$90
	db $90,$90,$90,$0C,$90,$90,$90,$8E
	db $C6,$8E,$8E,$8F,$00,$DA,$01,$DB
	db $0A,$E9,$9D,$24,$04,$18,$7E,$D0
	db $C6,$0C,$D0,$D0,$18,$C6,$0C,$D0
	db $C6,$C6,$D0,$C6,$D0,$C6,$C6,$00
	db $DA,$01,$DB,$0A,$E9,$B8,$24,$10
	db $18,$7E,$C6,$D8,$00,$18,$7E,$C6
	db $D8,$C6,$D8,$C6,$D8,$C6,$D8,$C6
	db $D8,$C6,$D8,$0C,$C6,$D8,$D8,$D8
	db $D8,$D8,$D8,$D8,$00,$08,$C6,$C6
	db $60,$A9,$54,$A8,$6C,$A0,$48,$C6
	db $18,$A9,$00,$DB,$0A,$0C,$3D,$97
	db $9D,$97,$C6,$97,$9D,$97,$C6,$0C
	db $3E,$97,$0C,$3D,$9D,$97,$0C,$3E
	db $9D,$0C,$3D,$C6,$9C,$0C,$3E,$97
	db $0C,$3D,$9D,$97,$9D,$97,$C6,$97
	db $9D,$97,$C6,$0C,$3E,$97,$0C,$3D
	db $9D,$97,$0C,$3E,$9D,$0C,$3D,$C6
	db $9C,$0C,$3E,$97,$0C,$3D,$9D,$DB
	db $05,$01,$3C,$C7,$0C,$9D,$97,$9D
	db $C6,$9D,$97,$9D,$C6,$0C,$3D,$9D
	db $0C,$3C,$97,$9D,$0C,$3D,$97,$0C
	db $3C,$C6,$97,$0C,$3D,$9C,$0C,$3C
	db $97,$0C,$9D,$97,$9D,$C6,$9D,$97
	db $9D,$C6,$0C,$3D,$9D,$0C,$3C,$97
	db $9D,$0C,$3D,$97,$0C,$3C,$C6,$97
	db $0C,$3D,$9C,$0C,$3C,$97,$0C,$88
	db $C6,$88,$C6,$88,$C6,$88,$C6,$88
	db $C6,$88,$88,$C6,$88,$88,$88,$0C
	db $88,$C6,$88,$C6,$88,$C6,$88,$C6
	db $88,$C6,$88,$88,$C6,$88,$88,$88
	db $00,$DA,$01,$DB,$0A,$E9,$89,$25
	db $04,$18,$7E,$D0,$C6,$0C,$D0,$D0
	db $18,$C6,$0C,$C6,$D0,$D0,$C6,$D0
	db $D0,$C6,$D0,$00,$DA,$01,$DB,$0A
	db $E9,$A4,$25,$04,$18,$7E,$C6,$D8
	db $C6,$D8,$0C,$7E,$D8,$C6,$C6,$D8
	db $C6,$C6,$D8,$C6,$00,$08,$C6,$C6
	db $60,$A8,$54,$A7,$6C,$9F,$48,$C6
	db $30,$A8,$0C,$96,$9C,$96,$C6,$96
	db $9C,$96,$C6,$0C,$3E,$96,$0C,$3D
	db $9C,$96,$0C,$3E,$9C,$0C,$3D,$C6
	db $9B,$0C,$3E,$96,$0C,$3D,$9C,$0C
	db $96,$9C,$96,$C6,$96,$9C,$96,$C6
	db $0C,$3E,$96,$0C,$3D,$9C,$96,$0C
	db $3E,$9C,$0C,$3D,$C6,$9B,$0C,$3E
	db $96,$0C,$3D,$9C,$01,$C7,$0C,$9C
	db $96,$9C,$C6,$9C,$96,$9C,$C6,$0C
	db $3D,$9C,$0C,$3C,$96,$9C,$0C,$3D
	db $96,$0C,$3C,$C6,$96,$0C,$3D,$9B
	db $0C,$3C,$96,$0C,$9C,$96,$9C,$C6
	db $9C,$96,$9C,$C6,$0C,$3D,$9C,$0C
	db $3C,$96,$9C,$0C,$3D,$96,$0C,$3C
	db $C6,$96,$0C,$3D,$9B,$0C,$3C,$96
	db $0C,$87,$C6,$87,$C6,$87,$C6,$87
	db $C6,$87,$C6,$87,$87,$C6,$87,$87
	db $87,$0C,$87,$C6,$87,$C6,$87,$C6
	db $87,$C6,$87,$C6,$87,$87,$C6,$87
	db $87,$87,$00,$08,$C6,$C6,$E8,$FF
	db $28,$60,$C6,$18,$C6,$DD,$00,$30
	db $BB,$48,$C6,$60,$C6,$C6,$00,$DA
	db $01,$E2,$2D,$DE,$14,$14,$20,$DB
	db $05,$30,$5D,$B4,$B2,$B0,$60,$AF
	db $C6,$30,$C6,$00,$DA,$01,$DE,$14
	db $14,$20,$DB,$0F,$30,$5D,$B0,$AF
	db $AD,$60,$AB,$C6,$C6,$DA,$01,$DE
	db $14,$14,$20,$DB,$0A,$0C,$5D,$B7
	db $B9,$B7,$B9,$B7,$B9,$B7,$B9,$B7
	db $B9,$B7,$B9,$06,$B7,$B9,$B7,$B9
	db $B7,$B9,$B7,$B9,$60,$B7,$60,$59
	db $C3,$DA,$00,$DE,$14,$14,$20,$DB
	db $0A,$0C,$59,$B7,$B9,$B7,$B9,$B7
	db $B9,$B7,$B9,$B7,$B9,$B7,$B9,$06
	db $B7,$B9,$B7,$B9,$B7,$B9,$B7,$B9
	db $60,$B7,$C6,$C6,$DA,$01,$E2,$32
	db $DE,$14,$14,$20,$DB,$0A,$18,$5D
	db $C7,$0C,$B7,$B9,$C0,$C7,$B7,$B9
	db $30,$C0,$C6,$18,$C7,$0C,$B7,$B9
	db $C1,$C7,$B7,$B9,$30,$C1,$C6,$18
	db $C7,$0C,$B7,$B8,$C1,$C7,$B7,$B8
	db $30,$C1,$C6,$18,$C7,$0C,$B7,$B9
	db $C0,$C7,$B7,$B9,$30,$C0,$C6,$00
	db $DA,$00,$DE,$14,$13,$20,$DB,$0A
	db $60,$59,$C7,$30,$C7,$0C,$B7,$B9
	db $B7,$B9,$60,$B7,$30,$C7,$0C,$B7
	db $B9,$B7,$B9,$60,$B7,$30,$C7,$0C
	db $B7,$B8,$B7,$B8,$B7,$B4,$B0,$AD
	db $B0,$AD,$AB,$A8,$AB,$A8,$A4,$A1
	db $60,$9F,$DA,$01,$DE,$14,$15,$20
	db $DB,$0F,$18,$5D,$C7,$0C,$B4,$B5
	db $BC,$C7,$B4,$B5,$30,$BC,$C6,$18
	db $C7,$0C,$B4,$B5,$BE,$C7,$B4,$B5
	db $30,$BE,$C6,$18,$C7,$0C,$B2,$B5
	db $BE,$C7,$B2,$B5,$30,$BE,$C6,$18
	db $C7,$0C,$B4,$B5,$BC,$C7,$B4,$B5
	db $30,$BC,$C6,$DA,$04,$DB,$0A,$DE
	db $14,$13,$20,$60,$5E,$8C,$48,$C6
	db $18,$8C,$60,$8C,$48,$C6,$18,$8C
	db $60,$8C,$48,$C6,$18,$8C,$60,$8C
	db $48,$C6,$18,$8C,$DA,$01,$DB,$05
	db $DE,$14,$14,$20,$60,$5E,$98,$48
	db $C6,$18,$98,$60,$98,$48,$C6,$18
	db $98,$60,$98,$48,$C6,$18,$98,$60
	db $98,$48,$C6,$18,$98,$DA,$01,$DB
	db $0F,$DE,$14,$15,$20,$E7,$AA,$E8
	db $C0,$F0,$18,$3E,$C7,$0C,$AB,$AB
	db $18,$AB,$AB,$AB,$AB,$AB,$AB,$E7
	db $AA,$E8,$C0,$F0,$18,$C7,$0C,$AD
	db $AD,$18,$AD,$AD,$AD,$AD,$AD,$AD
	db $E7,$AA,$E8,$C0,$F0,$18,$C7,$0C
	db $AC,$AC,$18,$AC,$AC,$AC,$AC,$AC
	db $AC,$E7,$AA,$E8,$C0,$F0,$18,$C7
	db $0C,$AB,$AB,$18,$AB,$AB,$AB,$AB
	db $AB,$AB,$DA,$01,$DB,$0F,$DE,$14
	db $14,$20,$E7,$AA,$E8,$C0,$F0,$18
	db $3E,$C7,$0C,$A8,$A8,$18,$A8,$A8
	db $A8,$A8,$A8,$A8,$E7,$AA,$E8,$C0
	db $F0,$18,$C7,$0C,$A9,$A9,$18,$A9
	db $A9,$A9,$A9,$A9,$A9,$E7,$AA,$E8
	db $C0,$F0,$18,$C7,$0C,$A9,$A9,$18
	db $A9,$A9,$A9,$A9,$A9,$A9,$E7,$AA
	db $E8,$C0,$F0,$18,$C7,$0C,$A8,$A8
	db $18,$A8,$A8,$A8,$A8,$A8,$A8,$DA
	db $01,$DB,$05,$E9,$67,$28,$04,$E7
	db $DC,$E8,$60,$64,$06,$7E,$D7,$D7
	db $D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7
	db $D7,$D7,$D7,$D7,$D7,$D7,$E7,$AA
	db $48,$C7,$18,$5E,$D6,$00,$60,$A9
	db $C6,$18,$7C,$AB,$B2,$B7,$B9,$30
	db $BA,$BB,$60,$C6,$00,$DA,$01,$DE
	db $14,$15,$20,$60,$7C,$A4,$C6,$18
	db $A3,$A9,$AF,$B0,$30,$B1,$B2,$60
	db $C6,$30,$5B,$C6,$B9,$30,$B5,$B2
	db $60,$B0,$AF,$C6,$DA,$00,$DB,$0A
	db $DE,$14,$14,$20,$18,$5D,$C7,$0C
	db $A6,$A5,$18,$A6,$A9,$AD,$A9,$AD
	db $B5,$60,$B4,$B2,$C6,$60,$8E,$C6
	db $60,$93,$C6,$C6,$DA,$01,$DB,$0A
	db $60,$6D,$A1,$C6,$60,$A3,$DA,$10
	db $06,$6D,$AB,$AF,$B2,$B5,$B7,$BB
	db $BE,$C1,$30,$C3,$60,$C6,$60,$9A
	db $C6,$60,$9F,$C6,$C6,$DA,$01,$DB
	db $05,$E7,$C8,$E8,$30,$64,$06,$7E
	db $D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7
	db $30,$C7,$60,$C7,$E7,$C8,$E8,$60
	db $64,$06,$7E,$D7,$D7,$D7,$D7,$D7
	db $D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7
	db $D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7
	db $D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7
	db $D7,$D7,$D7,$60,$C7,$00,$F0,$DA
	db $04,$E2,$40,$DB,$05,$30,$5C,$AB
	db $AB,$AA,$AA,$18,$A9,$A6,$AD,$60
	db $AB,$18,$C7,$00,$DA,$00,$DB,$0A
	db $30,$5C,$B7,$B7,$B6,$B6,$18,$B5
	db $B2,$B9,$60,$B7,$18,$C7,$DA,$04
	db $DB,$0A,$30,$5C,$A8,$A8,$A7,$A7
	db $18,$A6,$A2,$A9,$60,$A8,$18,$C7
	db $DA,$04,$DB,$0F,$30,$5C,$A4,$A4
	db $A4,$A4,$18,$A2,$9F,$A6,$60,$A4
	db $18,$C7,$DA,$0E,$DB,$0A,$30,$5D
	db $95,$95,$94,$94,$18,$93,$C7,$93
	db $8C,$C6,$8C,$8C,$8C,$DA,$07,$DB
	db $0A,$18,$5B,$91,$A4,$A4,$91,$A4
	db $A4,$91,$A4,$8E,$A1,$A1,$8E,$A1
	db $A1,$8E,$A1,$91,$A4,$A4,$91,$A4
	db $A4,$91,$A4,$8E,$A1,$A1,$8E,$A1
	db $C6,$C6,$C6,$DA,$07,$DB,$05,$18
	db $5B,$C7,$A9,$A9,$C7,$A9,$A9,$C7
	db $A9,$C7,$A6,$A6,$C7,$A6,$A6,$C7
	db $A6,$C7,$A9,$A9,$C7,$A9,$A9,$C7
	db $A9,$C7,$A6,$A6,$C7,$A6,$C6,$C6
	db $C6,$00,$DA,$0C,$DB,$0F,$DB,$0A
	db $E7,$FF,$24,$6F,$B5,$0C,$B0,$18
	db $B2,$24,$B5,$0C,$B0,$18,$B2,$0C
	db $B5,$B9,$B0,$B2,$24,$B5,$0C,$B0
	db $18,$B2,$24,$B5,$0C,$B0,$18,$B2
	db $0C,$B5,$B9,$B0,$B2,$24,$B5,$0C
	db $B0,$18,$B2,$24,$B5,$0C,$B0,$18
	db $B2,$0C,$B5,$B9,$B0,$B2,$24,$B5
	db $0C,$B0,$18,$B2,$24,$B5,$0C,$B0
	db $18,$B2,$0C,$B5,$B9,$B0,$B2,$DE
	db $00,$00,$00,$DA,$01,$DB,$0A,$EC
	db $00,$06,$08,$30,$5D,$B9,$24,$B5
	db $0C,$B0,$18,$B5,$B5,$24,$B5,$0C
	db $B0,$18,$B5,$B5,$B5,$BC,$30,$B9
	db $24,$B7,$0C,$B0,$00,$DE,$00,$00
	db $00,$DA,$02,$DB,$05,$30,$59,$B9
	db $24,$B5,$0C,$B0,$18,$B5,$B5,$24
	db $B5,$0C,$B0,$18,$B5,$B5,$B5,$BC
	db $30,$B9,$24,$B7,$0C,$B0,$DA,$07
	db $DB,$0A,$18,$59,$91,$A4,$91,$A4
	db $91,$A4,$91,$A4,$91,$A4,$91,$A4
	db $91,$C7,$8C,$C6,$DA,$07,$DB,$05
	db $18,$59,$C7,$A1,$C7,$A1,$C7,$A1
	db $C7,$A1,$C7,$A1,$C7,$A1,$A1,$C7
	db $9F,$C6,$DA,$07,$DB,$0F,$18,$59
	db $C7,$A9,$C7,$A9,$C7,$A9,$C7,$A9
	db $C7,$A9,$C7,$A9,$A4,$C7,$A8,$C6
	db $30,$B9,$24,$B5,$0C,$B0,$18,$B5
	db $B5,$24,$B5,$0C,$B0,$18,$B5,$BC
	db $B9,$B7,$30,$B5,$DA,$0F,$18,$A1
	db $C6,$00,$30,$B9,$24,$B5,$0C,$B0
	db $18,$B5,$B5,$24,$B5,$0C,$B0,$18
	db $B5,$BC,$B9,$B7,$30,$B5,$DA,$0F
	db $18,$AD,$C6,$18,$91,$A4,$91,$A4
	db $91,$A4,$91,$A4,$91,$A4,$98,$A8
	db $91,$C7,$91,$C7,$18,$C7,$A1,$C7
	db $A1,$C7,$A1,$C7,$A1,$C7,$A1,$C7
	db $A4,$A1,$C7,$A1,$C7,$18,$C7,$A9
	db $C7,$A9,$C7,$A9,$C7,$A9,$C7,$A9
	db $C7,$AB,$A4,$C7,$A4,$C7,$DA,$01
	db $30,$B9,$18,$B5,$B0,$30,$B9,$B5
	db $0C,$B8,$B5,$18,$B0,$30,$B8,$60
	db $B7,$00,$18,$96,$A6,$96,$A6,$95
	db $A4,$95,$A4,$94,$A4,$94,$A4,$93
	db $A6,$8C,$A4,$00,$18,$C7,$A2,$C7
	db $A2,$C7,$A1,$C7,$A1,$C7,$A0,$C7
	db $A0,$C7,$A2,$C7,$A2,$18,$C7,$A9
	db $C7,$A9,$C7,$A9,$C7,$A9,$C7,$A9
	db $C7,$A9,$C7,$A9,$C7,$A8,$30,$B9
	db $18,$B5,$B0,$30,$B9,$B5,$0C,$B8
	db $B5,$18,$B0,$60,$BC,$30,$C7,$00
	db $DA,$01,$DB,$0A,$E2,$40,$EC,$00
	db $06,$08,$30,$5D,$BE,$BE,$BE,$BE
	db $18,$BC,$BC,$B9,$B7,$30,$B5,$DA
	db $0F,$18,$A1,$C6,$00,$DA,$01,$DB
	db $0A,$EC,$00,$06,$08,$30,$5D,$BA
	db $BA,$BB,$BB,$18,$B9,$B9,$B5,$B4
	db $30,$B0,$DA,$0F,$18,$95,$C6,$00
	db $DA,$02,$DB,$05,$30,$59,$BE,$BE
	db $BE,$BE,$18,$BC,$BC,$B9,$B7,$30
	db $B5,$DA,$0F,$18,$A1,$C6,$00,$DA
	db $07,$DB,$0A,$18,$59,$96,$A6,$96
	db $A6,$97,$A6,$97,$A6,$98,$A8,$98
	db $A8,$91,$C7,$91,$C7,$DA,$07,$DB
	db $05,$18,$59,$C7,$A2,$C7,$A2,$C7
	db $A3,$C7,$A3,$C7,$A4,$C7,$A4,$A1
	db $C7,$A1,$C7,$DA,$07,$DB,$0F,$18
	db $59,$C7,$A9,$C7,$A9,$C7,$A9,$C7
	db $A9,$C7,$AB,$C7,$AB,$A4,$C7,$A4
	db $C7,$DA,$0C,$DB,$0F,$DB,$0A,$E7
	db $FF,$24,$6F,$B5,$0C,$B0,$18,$B2
	db $24,$B5,$0C,$B0,$18,$B2,$0C,$B5
	db $B9,$B0,$B2,$24,$B5,$0C,$B0,$18
	db $B2,$B5,$B5,$C6,$B5,$C6,$F0,$DA
	db $04,$E2,$2D,$DE,$23,$13,$30,$DB
	db $0A,$18,$4C,$C6,$0C,$B9,$B9,$18
	db $3C,$B9,$18,$5C,$B9,$B5,$B0,$0C
	db $4C,$B2,$C7,$C7,$B5,$60,$B5,$30
	db $C6,$18,$C7,$0C,$B0,$B0,$18,$3C
	db $B0,$B5,$E3,$30,$26,$10,$5C,$B5
	db $BC,$BC,$60,$6D,$B9,$30,$C6,$00
	db $DA,$04,$DE,$23,$14,$30,$DB,$0A
	db $18,$4C,$C6,$0C,$B2,$B2,$18,$3C
	db $B2,$18,$5C,$B2,$AE,$A9,$0C,$4C
	db $AD,$C7,$C7,$AE,$60,$AE,$30,$C6
	db $18,$C7,$0C,$AB,$AB,$18,$3C,$AB
	db $AE,$10,$5C,$AE,$B7,$B7,$60,$B4
	db $30,$C6,$DA,$04,$DE,$23,$13,$30
	db $DB,$0A,$18,$4C,$C6,$0C,$AE,$AE
	db $18,$3C,$AE,$18,$5C,$AE,$A9,$A6
	db $0C,$4C,$A9,$C7,$C7,$A9,$60,$A9
	db $30,$C6,$18,$C7,$0C,$A7,$A7,$18
	db $3C,$A7,$AB,$10,$5C,$AB,$B1,$B1
	db $60,$B0,$30,$C6,$DA,$04,$DE,$23
	db $14,$30,$DB,$0A,$18,$4C,$C6,$0C
	db $A9,$A9,$18,$3C,$A9,$18,$5C,$A9
	db $A6,$A1,$0C,$4C,$A2,$C7,$C7,$A6
	db $60,$A6,$30,$C6,$18,$C7,$0C,$A2
	db $A2,$18,$3C,$A2,$A5,$10,$5C,$A5
	db $AE,$AE,$60,$AD,$30,$C6,$DA,$02
	db $DB,$14,$60,$6B,$C7,$C7,$DC,$90
	db $00,$06,$A6,$A9,$AD,$AE,$A9,$AD
	db $AE,$B2,$AD,$AE,$B2,$B5,$AE,$B2
	db $B5,$B9,$B2,$B5,$B9,$BA,$B5,$B9
	db $BA,$BE,$60,$C1,$C7,$C7,$C7,$DA
	db $02,$DB,$14,$04,$69,$C7,$60,$C7
	db $C7,$DC,$90,$00,$06,$A6,$A9,$AD
	db $AE,$A9,$AD,$AE,$B2,$AD,$AE,$B2
	db $B5,$AE,$B2,$B5,$B9,$B2,$B5,$B9
	db $BA,$B5,$B9,$BA,$BE,$60,$C1,$C7
	db $C7,$C7,$DA,$04,$DE,$23,$11,$30
	db $DB,$0A,$60,$7E,$8C,$C6,$18,$C6
	db $0C,$8C,$8C,$18,$8C,$8C,$10,$8C
	db $8D,$8E,$60,$8F,$10,$8F,$8F,$8F
	db $60,$91,$30,$C6,$DA,$04,$DB,$0A
	db $60,$7E,$D5,$C6,$18,$C6,$0C,$D5
	db $D5,$18,$D5,$D5,$10,$D5,$D5,$D5
	db $60,$D5,$10,$D5,$D5,$D5,$06,$7D
	db $D5,$D5,$D5,$D5,$D5,$D5,$D5,$D5
	db $06,$D5,$D5,$D5,$D5,$D5,$D5,$D5
	db $D5,$06,$D5,$D5,$D5,$D5,$D5,$D5
	db $30,$6F,$D5,$F0,$DA,$01,$E2,$28
	db $E3,$8C,$46,$E0,$FF,$DE,$23,$11
	db $40,$DB,$14,$60,$6E,$87,$DB,$04
	db $60,$B0,$30,$C6,$00,$DA,$01,$DE
	db $23,$12,$40,$DB,$12,$0C,$6E,$C7
	db $60,$8D,$DB,$02,$60,$B1,$24,$C6
	db $DA,$01,$DE,$23,$13,$40,$DB,$10
	db $18,$6E,$C7,$60,$93,$DB,$00,$60
	db $B7,$18,$C6,$DA,$01,$DE,$23,$12
	db $40,$DB,$0E,$24,$6E,$C7,$60,$99
	db $6C,$C6,$DA,$01,$DE,$23,$13,$40
	db $DB,$0C,$30,$6E,$C7,$60,$9F,$60
	db $C6,$DA,$01,$DE,$23,$12,$40,$DB
	db $0A,$30,$6E,$C7,$0C,$C7,$60,$A4
	db $54,$C6,$DA,$01,$DE,$23,$14,$40
	db $DB,$08,$48,$6E,$C7,$60,$A5,$48
	db $C6,$DA,$01,$DE,$23,$12,$40,$DB
	db $06,$48,$6E,$C7,$0C,$C7,$60,$AB
	db $3C,$C6,$E7,$64,$E8,$60,$C8,$DA
	db $01,$E2,$14,$DB,$14,$06,$6F,$B0
	db $06,$6B,$B0,$B0,$B0,$B0,$B0,$B0
	db $B0,$06,$6D,$B0,$06,$6C,$B0,$B0
	db $B0,$B0,$B0,$B0,$B0,$E7,$64,$E8
	db $60,$C8,$06,$6F,$AF,$06,$6B,$AF
	db $AF,$AF,$AF,$AF,$AF,$AF,$06,$6D
	db $AF,$06,$6C,$AF,$AF,$AF,$AF,$AF
	db $AF,$AF,$E7,$64,$E8,$60,$C8,$06
	db $6F,$B0,$06,$6B,$B0,$B0,$B0,$B0
	db $B0,$B0,$B0,$06,$6D,$B0,$06,$6C
	db $B0,$B0,$B0,$B0,$B0,$B0,$B0,$E7
	db $64,$E8,$60,$C8,$06,$6F,$AF,$06
	db $6B,$AF,$AF,$AF,$AF,$AF,$AF,$AF
	db $06,$6D,$AF,$06,$6C,$AF,$AF,$AF
	db $AF,$AF,$AF,$AF,$00,$E7,$64,$E8
	db $60,$C8,$DA,$01,$DB,$0F,$06,$6F
	db $B5,$06,$6B,$B5,$B5,$B5,$B5,$B5
	db $B5,$B5,$06,$6D,$B5,$06,$6C,$B5
	db $B5,$B5,$B5,$B5,$B5,$B5,$E7,$64
	db $E8,$60,$C8,$06,$6F,$B7,$06,$6B
	db $B7,$B7,$B7,$B7,$B7,$B7,$B7,$06
	db $6D,$B7,$06,$6C,$B7,$B7,$B7,$B7
	db $B7,$B7,$B7,$E7,$64,$E8,$60,$C8
	db $06,$6F,$B8,$06,$6B,$B8,$B8,$B8
	db $B8,$B8,$B8,$B8,$06,$6D,$B8,$06
	db $6C,$B8,$B8,$B8,$B8,$B8,$B8,$B8
	db $E7,$64,$E8,$60,$C8,$06,$6F,$B7
	db $06,$6B,$B7,$B7,$B7,$B7,$B7,$B7
	db $B7,$06,$6D,$B7,$06,$6C,$B7,$B7
	db $B7,$B7,$B7,$B7,$B7,$DA,$04,$E7
	db $C8,$DB,$0A,$DE,$28,$28,$20,$48
	db $6F,$C7,$18,$85,$30,$87,$C7,$48
	db $C7,$18,$85,$30,$87,$C7,$DA,$01
	db $E7,$FF,$DB,$0A,$DE,$1E,$29,$20
	db $18,$6F,$A0,$C6,$9D,$98,$18,$9A
	db $48,$9D,$18,$C7,$98,$9D,$A4,$30
	db $A0,$9F,$04,$C7,$DA,$01,$E7,$FF
	db $DB,$05,$DE,$1E,$28,$20,$18,$6C
	db $A0,$C6,$9D,$98,$18,$9A,$48,$9D
	db $18,$C7,$98,$9D,$A4,$30,$A0,$9F
	db $E7,$64,$E8,$48,$C8,$DA,$01,$E2
	db $14,$DB,$14,$06,$6F,$B0,$06,$6B
	db $B0,$B0,$B0,$B0,$B0,$B0,$B0,$06
	db $6D,$B0,$06,$6C,$B0,$B0,$B0,$E7
	db $DC,$18,$6E,$B0,$AF,$30,$C7,$18
	db $B0,$AF,$30,$C7,$18,$B0,$AF,$B0
	db $AE,$AF,$C6,$48,$C7,$60,$C7,$E7
	db $64,$E8,$48,$C8,$DA,$01,$DB,$0F
	db $06,$6F,$B5,$06,$6B,$B5,$B5,$B5
	db $B5,$B5,$B5,$B5,$06,$6D,$B5,$06
	db $6C,$B5,$B5,$B5,$E7,$DC,$18,$6E
	db $B5,$B7,$30,$C7,$18,$B5,$B7,$30
	db $C7,$18,$B5,$B7,$B8,$B6,$B7,$C6
	db $48,$C7,$60,$C7,$00,$DA,$04,$E7
	db $FF,$DB,$0A,$DE,$23,$14,$40,$48
	db $6E,$C7,$18,$91,$93,$85,$87,$91
	db $93,$85,$87,$85,$87,$88,$86,$87
	db $C6,$48,$C7,$60,$C7,$DA,$0A,$E7
	db $FF,$DB,$0A,$48,$6E,$C7,$18,$C7
	db $C7,$85,$87,$C7,$C7,$85,$87,$85
	db $87,$88,$86,$87,$C6,$48,$C7,$60
	db $C7,$C7,$DA,$01,$E7,$C8,$DB,$0A
	db $DE,$28,$28,$20,$48,$7E,$C7,$18
	db $C1,$C3,$C7,$C7,$C1,$C3,$C7,$C7
	db $C1,$C3,$C4,$C2,$C3,$60,$C6,$30
	db $C6,$E2,$08,$E3,$30,$19,$03,$C1
	db $BE,$BB,$B8,$B7,$B5,$B2,$AF,$AC
	db $AB,$A9,$A6,$A3,$A0,$9F,$C6,$18
	db $C6,$04,$C7,$DA,$01,$E7,$C8,$DB
	db $0A,$DE,$28,$29,$20,$48,$7B,$C7
	db $18,$C1,$C3,$C7,$C7,$C1,$C3,$C7
	db $C7,$C1,$C3,$C4,$C2,$C3,$60,$C6
	db $30,$C6,$03,$C1,$BE,$BB,$B8,$B7
	db $B5,$B2,$AF,$AC,$AB,$A9,$A6,$A3
	db $A0,$9F,$C6,$18,$C6,$DA,$01,$E7
	db $C8,$DB,$0A,$DE,$28,$28,$20,$48
	db $6E,$C7,$18,$AC,$B2,$C7,$C7,$AC
	db $B2,$C7,$C7,$AC,$B2,$B3,$B1,$B2
	db $C6,$48,$C7,$60,$C7,$DA,$01,$E2
	db $19,$DB,$0F,$E7,$78,$E8,$30,$C8
	db $08,$7D,$A4,$A4,$A4,$AB,$AB,$AB
	db $E8,$30,$78,$B3,$B3,$AB,$AB,$AB
	db $A4,$E8,$30,$C8,$A4,$A4,$A4,$AD
	db $AD,$AD,$E8,$30,$78,$B3,$B3,$AD
	db $AD,$AD,$A4,$E8,$30,$C8,$A4,$A4
	db $A4,$AC,$AC,$AC,$E8,$30,$78,$B5
	db $B5,$AC,$AC,$AC,$A4,$E8,$30,$C8
	db $A6,$A6,$A6,$AF,$AF,$AF,$E8,$30
	db $78,$B5,$B5,$AF,$AF,$AF,$A6,$00
	db $DA,$01,$DB,$14,$E7,$78,$E8,$30
	db $C8,$04,$7D,$C6,$08,$9F,$A7,$A7
	db $B0,$B0,$B0,$E8,$30,$78,$B0,$B0
	db $B0,$A7,$A7,$A7,$E8,$30,$C8,$A1
	db $A7,$A7,$A7,$B0,$B0,$E8,$30,$78
	db $B0,$B0,$B0,$A7,$A7,$A7,$E8,$30
	db $C8,$A0,$A9,$A9,$A9,$B0,$B0,$E8
	db $30,$78,$B0,$B0,$B0,$A9,$A9,$A9
	db $E8,$30,$C8,$A3,$A9,$A9,$A9,$B2
	db $B2,$E8,$30,$78,$B2,$B2,$B2,$A9
	db $A9,$A9,$DA,$01,$E7,$C8,$DB,$0A
	db $DE,$1E,$28,$20,$30,$6F,$8C,$8C
	db $92,$92,$91,$91,$93,$93,$DA,$01
	db $E7,$C8,$DB,$0A,$DE,$1E,$27,$20
	db $18,$6F,$8C,$8C,$8C,$8C,$92,$92
	db $92,$92,$91,$91,$91,$91,$93,$93
	db $93,$93,$DA,$01,$E7,$C8,$DB,$0A
	db $DE,$1E,$28,$20,$0C,$6F,$8C,$8C
	db $8C,$8C,$8C,$8C,$8C,$8C,$92,$92
	db $92,$92,$92,$92,$92,$92,$91,$91
	db $91,$91,$91,$91,$91,$91,$93,$93
	db $93,$93,$93,$93,$93,$93,$DA,$04
	db $E7,$C8,$DB,$05,$DE,$1E,$29,$20
	db $60,$7B,$8C,$DD,$0C,$12,$98,$DD
	db $0C,$12,$8C,$60,$7B,$92,$DD,$0C
	db $12,$9E,$DD,$0C,$12,$92,$60,$7B
	db $91,$DD,$0C,$12,$9D,$DD,$0C,$12
	db $91,$60,$7B,$93,$DD,$0C,$12,$9F
	db $DD,$0C,$12,$93,$DA,$01,$E7,$DC
	db $DB,$0A,$DE,$1E,$28,$20,$18,$7D
	db $B3,$C6,$B0,$AB,$18,$AA,$48,$B0
	db $18,$C7,$AB,$B0,$B7,$30,$B3,$B2
	db $DA,$01,$E7,$DC,$DB,$0A,$DE,$18
	db $29,$20,$18,$7C,$AB,$C6,$A7,$A4
	db $18,$A4,$48,$AA,$18,$C7,$A4,$AB
	db $B0,$60,$A9,$E7,$78,$E8,$30,$C8
	db $08,$A4,$A4,$A4,$AB,$AB,$AB,$E8
	db $30,$78,$B3,$B3,$AB,$AB,$AB,$A4
	db $E8,$30,$C8,$A6,$A6,$A6,$AC,$AC
	db $AC,$E8,$30,$78,$B5,$B5,$AC,$AC
	db $AC,$A0,$E8,$30,$C8,$A6,$A6,$A6
	db $AF,$AF,$AF,$E8,$30,$78,$B5,$B5
	db $AF,$AF,$AF,$A6,$E8,$30,$C8,$A4
	db $A4,$A4,$AB,$AB,$AB,$E8,$30,$78
	db $B3,$B3,$AB,$AB,$AB,$A4,$E7,$78
	db $E8,$30,$C8,$04,$C6,$08,$9F,$A7
	db $A7,$A7,$B0,$B0,$E8,$30,$78,$B0
	db $B0,$B0,$A7,$A7,$A7,$E8,$30,$C8
	db $A0,$A9,$A9,$A9,$B2,$B2,$E8,$30
	db $78,$B2,$B2,$B2,$A9,$A6,$A6,$E8
	db $30,$C8,$A3,$A9,$A9,$A9,$B2,$B2
	db $E8,$30,$78,$B2,$B2,$B2,$A9,$A9
	db $A9,$E8,$30,$C8,$9F,$A7,$A7,$A7
	db $B0,$B0,$E8,$30,$78,$B0,$B0,$B0
	db $A7,$A7,$A7,$DA,$01,$E7,$C8,$DB
	db $0A,$DE,$1E,$28,$20,$0C,$6F,$94
	db $94,$94,$94,$94,$94,$94,$94,$97
	db $97,$97,$97,$97,$97,$97,$97,$93
	db $93,$93,$93,$93,$93,$93,$93,$98
	db $98,$98,$98,$98,$98,$98,$98,$00
	db $DA,$01,$E7,$DC,$DB,$0A,$DE,$1E
	db $29,$20,$18,$7D,$C7,$B0,$B7,$BC
	db $30,$B8,$B7,$18,$C7,$AB,$B2,$B7
	db $30,$B5,$B3,$DA,$00,$E7,$DC,$DB
	db $05,$DE,$1E,$28,$20,$60,$79,$C7
	db $18,$C7,$0C,$AF,$B0,$18,$B1,$B2
	db $30,$C6,$C7,$18,$C7,$0C,$AD,$AE
	db $18,$AF,$48,$B0,$DA,$02,$E7,$C8
	db $DB,$0A,$18,$79,$C7,$B0,$B7,$BC
	db $60,$B8,$18,$C7,$AB,$B2,$B7,$60
	db $B5,$DA,$01,$E7,$DC,$DB,$0A,$DE
	db $18,$28,$20,$18,$7C,$C7,$AB,$B0
	db $B7,$30,$B2,$B2,$18,$C7,$A3,$A9
	db $AF,$60,$AB,$E7,$78,$E8,$30,$C8
	db $08,$A4,$A4,$A4,$AA,$AA,$AA,$E8
	db $30,$78,$B3,$B3,$AA,$AA,$AA,$A4
	db $E8,$30,$C8,$A4,$A4,$A4,$AD,$AD
	db $AD,$E8,$30,$78,$B2,$B2,$AD,$AD
	db $AD,$A4,$E8,$30,$C8,$A4,$A4,$A4
	db $AD,$AD,$AD,$E8,$30,$78,$B6,$B6
	db $AD,$AD,$AD,$A4,$E8,$30,$C8,$A4
	db $A4,$A4,$AB,$AB,$AB,$E8,$30,$78
	db $B2,$B2,$B2,$BB,$BB,$BB,$E8,$30
	db $C8,$04,$C6,$08,$9E,$A7,$A7,$A7
	db $B0,$B0,$E8,$30,$78,$B0,$B0,$B0
	db $A7,$A7,$A7,$E8,$30,$C8,$A1,$A6
	db $A6,$A6,$B0,$B0,$E8,$30,$78,$B0
	db $B0,$B0,$A6,$A6,$A6,$E8,$30,$C8
	db $A1,$AA,$AA,$AA,$B0,$B0,$E8,$30
	db $78,$B0,$B0,$B0,$AA,$AA,$AA,$E8
	db $30,$C8,$9F,$A6,$A6,$A6,$B0,$B0
	db $E8,$30,$78,$AF,$B5,$B5,$B5,$BE
	db $BE,$DA,$01,$E7,$C8,$DB,$0A,$DE
	db $1E,$27,$20,$0C,$6F,$95,$95,$95
	db $95,$95,$95,$95,$95,$92,$92,$92
	db $92,$92,$92,$92,$92,$8E,$8E,$8E
	db $8E,$8E,$8E,$8E,$8E,$93,$93,$93
	db $93,$93,$93,$93,$93,$00,$DA,$01
	db $E7,$DC,$DB,$0A,$DE,$1E,$28,$20
	db $18,$7D,$C7,$B3,$B2,$B0,$30,$B2
	db $AD,$18,$C7,$B2,$B0,$B2,$30,$B0
	db $24,$AF,$0C,$C7,$DA,$00,$60,$79
	db $C6,$18,$C6,$0C,$AA,$AB,$18,$AC
	db $AD,$30,$AD,$0C,$C6,$AC,$AD,$B0
	db $24,$B3,$06,$B2,$B0,$30,$B2,$18
	db $6B,$C7,$B3,$B2,$B0,$60,$B2,$18
	db $C7,$B2,$B0,$B2,$30,$B0,$AF,$DA
	db $01,$18,$7C,$C7,$AD,$AA,$AA,$30
	db $AA,$A4,$18,$C7,$AA,$AA,$AA,$30
	db $AB,$A9,$DA,$00,$E2,$32,$60,$6F
	db $C7,$00,$F0,$DA,$00,$E2,$32,$DB
	db $0A,$E7,$C8,$DE,$18,$14,$20,$0C
	db $6F,$BA,$3C,$B8,$0C,$B5,$24,$B3
	db $0C,$AE,$54,$AC,$00,$DA,$04,$DB
	db $0A,$E7,$C8,$DE,$18,$15,$20,$0C
	db $6F,$BA,$3C,$B8,$0C,$B5,$24,$B3
	db $0C,$AE,$54,$AC,$DA,$04,$DB,$0A
	db $E7,$C8,$DE,$18,$13,$20,$0C,$6F
	db $A1,$3C,$9F,$0C,$9C,$24,$9A,$0C
	db $95,$30,$93,$E7,$FF,$24,$7F,$98
	db $DD,$0C,$0C,$8C,$DA,$04,$DB,$0F
	db $E7,$C8,$DE,$18,$14,$20,$0C,$6F
	db $B5,$3C,$B3,$0C,$B0,$24,$AE,$0C
	db $A9,$54,$A7,$00,$DA,$04,$DB,$05
	db $E7,$C8,$DE,$18,$14,$20,$0C,$6F
	db $B0,$3C,$AE,$0C,$AB,$24,$A9,$0C
	db $A4,$54,$A2,$DA,$04,$DB,$14,$E7
	db $C8,$DE,$18,$13,$20,$0C,$6F,$AC
	db $3C,$AA,$0C,$A7,$24,$A5,$0C,$A0
	db $54,$9E,$DA,$04,$DB,$00,$E7,$C8
	db $DE,$18,$15,$20,$0C,$6F,$A6,$3C
	db $A4,$0C,$AD,$24,$9F,$0C,$9A,$54
	db $98,$DA,$01,$DB,$0F,$E7,$C8,$0C
	db $6D,$B0,$C7,$C7,$B0,$C7,$B0,$B0
	db $B0,$B0,$C7,$C7,$B3,$C6,$B1,$B3
	db $B1,$B0,$C7,$C7,$B0,$C7,$B0,$B0
	db $B0,$B0,$C7,$C7,$B3,$C6,$C6,$C7
	db $C7,$00,$12,$C7,$DA,$04,$DB,$0A
	db $E7,$C8,$60,$C7,$18,$7C,$C7,$60
	db $9D,$DD,$00,$60,$C1,$C6,$48,$C6
	db $DA,$01,$DB,$05,$E7,$C8,$0C,$6D
	db $AB,$C7,$C7,$AB,$C7,$AB,$AB,$AB
	db $AB,$C7,$C7,$AE,$C6,$AC,$AE,$AC
	db $AB,$C7,$C7,$AB,$C7,$AB,$AB,$AB
	db $AB,$C7,$C7,$AE,$C6,$C6,$C7,$C7
	db $DA,$01,$DB,$0A,$E7,$C8,$0C,$6D
	db $A6,$C7,$C7,$A6,$C7,$A6,$A6,$A6
	db $A6,$C7,$C7,$A9,$C6,$A7,$A9,$A7
	db $A6,$C7,$C7,$A6,$C7,$A6,$A6,$A6
	db $A6,$C7,$C7,$A9,$C6,$C6,$C7,$C7
	db $DA,$0A,$DB,$0A,$E7,$C8,$E9,$C2
	db $35,$04,$0C,$6F,$D6,$D7,$D7,$D6
	db $D7,$D7,$D6,$D7,$00,$E9,$C2,$35
	db $03,$0C,$D6,$D7,$D7,$06,$D6,$D6
	db $0C,$D6,$D6,$D6,$D6,$DA,$04,$E7
	db $C8,$DB,$0A,$DE,$23,$14,$40,$24
	db $6D,$8C,$93,$18,$98,$24,$8D,$94
	db $18,$99,$24,$8C,$93,$18,$98,$24
	db $8D,$94,$18,$99,$24,$8C,$93,$18
	db $98,$24,$8D,$3C,$99,$DD,$18,$24
	db $8D,$DA,$02,$E7,$FF,$DB,$0A,$DE
	db $22,$28,$20,$18,$6D,$B3,$C6,$B0
	db $AB,$18,$AC,$48,$B0,$18,$C7,$AB
	db $B0,$B7,$30,$B3,$C6,$DA,$01,$0C
	db $6D,$B5,$C7,$C7,$B5,$C7,$B5,$B5
	db $B5,$B5,$C7,$C7,$B8,$C6,$B6,$B8
	db $B6,$B5,$C7,$C7,$B5,$C7,$B5,$B5
	db $B5,$B5,$C7,$C7,$B8,$C6,$C6,$C7
	db $C7,$00,$12,$69,$C7,$DA,$04,$0C
	db $C6,$BE,$BF,$BE,$BF,$BE,$BC,$BB
	db $B8,$B6,$B2,$AD,$AC,$AA,$A9,$A7
	db $A6,$A9,$AC,$AF,$C7,$C7,$A9,$AC
	db $AF,$B2,$C7,$C7,$AF,$B3,$B5,$B8
	db $DA,$01,$0C,$6D,$B0,$C7,$C7,$B0
	db $C7,$B0,$B0,$B0,$B0,$C7,$C7,$B3
	db $C6,$B1,$B3,$B1,$B0,$C7,$C7,$B0
	db $C7,$B0,$B0,$B0,$B0,$C7,$C7,$B3
	db $C6,$C6,$C7,$C7,$DA,$01,$0C,$6D
	db $AB,$C7,$C7,$AB,$C7,$AB,$AB,$AB
	db $AB,$C7,$C7,$AE,$C6,$AC,$AE,$AC
	db $AB,$C7,$C7,$AB,$C7,$AB,$AB,$AB
	db $AB,$C7,$C7,$AE,$C6,$C6,$C7,$C7
	db $DA,$04,$24,$6D,$91,$98,$18,$9D
	db $24,$92,$99,$18,$9E,$24,$91,$98
	db $18,$9D,$24,$92,$99,$18,$9E,$DA
	db $02,$18,$6D,$B3,$C6,$B0,$AB,$18
	db $AC,$48,$B0,$18,$C7,$AB,$B0,$B7
	db $30,$B3,$C6,$DA,$01,$0C,$6D,$B7
	db $B7,$C7,$B7,$C7,$B7,$C7,$B7,$C7
	db $C7,$C7,$B7,$C6,$B6,$B5,$C6,$B4
	db $B4,$C7,$B4,$C7,$B4,$C7,$B4,$C7
	db $C7,$C7,$B4,$C6,$B3,$B2,$C6,$00
	db $DA,$01,$0C,$6D,$B2,$B2,$C7,$B2
	db $C7,$B2,$C7,$B2,$C7,$C7,$C7,$B2
	db $C6,$B1,$B0,$C6,$AF,$AF,$C7,$AF
	db $C7,$AF,$C7,$AF,$C7,$C7,$C7,$AF
	db $C6,$AE,$AD,$C6,$DA,$01,$0C,$6D
	db $AD,$AD,$C7,$AD,$C7,$AD,$C7,$AD
	db $C7,$C7,$C7,$AD,$C6,$AC,$AB,$C6
	db $AA,$AA,$C7,$AA,$C7,$AA,$C7,$AA
	db $C7,$C7,$C7,$AA,$C6,$A9,$A8,$C6
	db $DA,$04,$0C,$6D,$90,$90,$C7,$90
	db $C7,$90,$C7,$90,$C7,$C7,$C7,$90
	db $C6,$8F,$8E,$C6,$8D,$8D,$C7,$8D
	db $C7,$8D,$C7,$8D,$C7,$C7,$C7,$8D
	db $C6,$8C,$8B,$C6,$DA,$0A,$DB,$0A
	db $E7,$C8,$E9,$7E,$37,$02,$0C,$D6
	db $D6,$D7,$D6,$D7,$D6,$D6,$D6,$D6
	db $D7,$D7,$D6,$D7,$D6,$D6,$D7,$00
	db $DA,$02,$18,$6D,$B3,$C6,$B0,$AB
	db $18,$AC,$48,$B0,$18,$C7,$AB,$B0
	db $B7,$30,$B3,$C6,$12,$69,$B8,$DA
	db $04,$0C,$C6,$C6,$B9,$C6,$B8,$C6
	db $B6,$B5,$B3,$AF,$AE,$AC,$A7,$A9
	db $AB,$B0,$B3,$B2,$B0,$B2,$C6,$B9
	db $B3,$B0,$AF,$B0,$AF,$AE,$AC,$A7
	db $A9,$AB,$12,$69,$AB,$DA,$04,$0C
	db $AE,$AB,$AE,$B0,$AE,$B0,$B3,$B0
	db $B3,$B5,$B3,$B5,$B7,$B5,$B7,$BA
	db $BB,$C6,$BA,$B9,$B8,$B7,$C6,$B7
	db $B5,$B1,$AF,$AB,$A9,$B1,$AF,$C6
	db $12,$69,$C6,$DA,$04,$0C,$AF,$B0
	db $B2,$B5,$C6,$B5,$B3,$B2,$B0,$A9
	db $C6,$A9,$C6,$A7,$60,$A9,$DD,$24
	db $48,$9D,$C6,$C6,$06,$69,$C7,$DA
	db $05,$60,$C6,$24,$B5,$B8,$B4,$BA
	db $B8,$BB,$C6,$C6,$60,$C6,$C6,$06
	db $69,$C6,$DA,$05,$0C,$B5,$C6,$B8
	db $B9,$BA,$BB,$BA,$B9,$B5,$C6,$B0
	db $B8,$C6,$BA,$C6,$BA,$BB,$BA,$BB
	db $BA,$B8,$B5,$C6,$B0,$B3,$B5,$C6
	db $C6,$C6,$C6,$C6,$C6,$DA,$00,$E2
	db $46,$DB,$00,$DC,$60,$14,$6C,$7E
	db $B5,$DD,$18,$24,$A4,$DD,$00,$18
	db $B0,$DD,$00,$0C,$B5,$00,$DA,$00
	db $DB,$14,$DC,$60,$00,$6C,$7E,$A9
	db $DD,$18,$24,$98,$DD,$00,$18,$A4
	db $DD,$00,$0C,$A9,$00,$F0,$E0,$64
	db $E1,$30,$FF,$DA,$01,$E2,$14,$DB
	db $0A,$DC,$30,$00,$60,$6F,$A9,$DD
	db $0A,$30,$C1,$00,$DA,$01,$DB,$0A
	db $DC,$30,$14,$60,$6F,$A9,$DD,$0A
	db $30,$91,$00,$DA,$01,$DB,$0A,$DC
	db $30,$00,$60,$6F,$98,$DD,$0A,$30
	db $B5,$00,$DA,$01,$DB,$0A,$DC,$30
	db $14,$60,$6F,$A4,$DD,$0A,$30,$9D
	db $00,$DA,$01,$DB,$0A,$DC,$30,$00
	db $60,$6F,$9D,$DD,$0A,$30,$B0,$00
	db $DA,$01,$DB,$0A,$DC,$30,$14,$60
	db $6F,$91,$DD,$0A,$30,$98,$00,$DA
	db $01,$DB,$0A,$DC,$30,$00,$60,$6F
	db $9D,$DD,$0A,$30,$91,$00,$DA,$01
	db $DB,$0A,$DC,$30,$14,$60,$6F,$A9
	db $DD,$0A,$30,$8C,$00,$E2,$20,$00
	db $E3,$FF,$30,$00,$E3,$FF,$40,$00
	db $DA,$03,$DB,$00,$DC,$60,$14,$18
	db $6F,$C7,$10,$A4,$08,$9F,$C7,$AB
	db $9F,$A4,$C6,$9F,$DC,$60,$00,$18
	db $C7,$10,$A5,$08,$A0,$C7,$AC,$A0
	db $A5,$C6,$A0,$00,$DA,$0C,$DB,$0A
	db $08,$6B,$B0,$B0,$B9,$B9,$B0,$B0
	db $B9,$B9,$B0,$B0,$B9,$B9,$B0,$B0
	db $B9,$B9,$B0,$B0,$B9,$B9,$B0,$B0
	db $B9,$B9,$00,$DA,$03,$DB,$14,$DC
	db $0A,$00,$10,$6F,$8C,$08,$93,$18
	db $C6,$18,$98,$93,$DC,$60,$14,$10
	db $8D,$08,$94,$18,$C6,$18,$99,$94
	db $E2,$38,$DA,$01,$DB,$0A,$18,$3E
	db $B0,$B0,$B0,$0C,$C7,$B0,$C7,$24
	db $B0,$18,$B0,$B0,$AF,$AF,$AF,$0C
	db $C7,$AF,$C6,$24,$AF,$18,$AF,$AF
	db $00,$DA,$01,$DB,$00,$18,$3E,$AD
	db $AD,$AD,$0C,$C7,$AD,$C7,$24,$AD
	db $18,$AD,$AD,$AB,$AB,$AB,$0C,$C7
	db $AB,$C6,$24,$AB,$18,$AB,$AB,$DA
	db $01,$DB,$14,$18,$3E,$A9,$A9,$A9
	db $0C,$A6,$18,$A9,$A9,$0C,$A6,$A9
	db $A6,$18,$A9,$A8,$A8,$A8,$0C,$A4
	db $18,$A8,$A8,$0C,$A4,$A8,$A4,$18
	db $A8,$DA,$08,$DB,$0A,$30,$5E,$8E
	db $24,$95,$9A,$18,$C7,$95,$9A,$30
	db $8C,$24,$93,$98,$18,$C7,$93,$98
	db $DB,$14,$0C,$6D,$D1,$D1,$D1,$D1
	db $18,$D2,$0C,$D1,$D1,$D1,$D1,$D1
	db $D1,$18,$D2,$0C,$D1,$D1,$D1,$D1
	db $D1,$D1,$18,$D2,$0C,$D1,$D1,$D1
	db $D1,$D1,$D1,$18,$D2,$0C,$D1,$D1
	db $F0,$DA,$02,$DB,$14,$DC,$54,$00
	db $54,$7F,$A4,$DD,$00,$0C,$B7,$DD
	db $00,$18,$B0,$DD,$00,$30,$A4,$00
	db $DA,$02,$DB,$14,$DC,$54,$00,$54
	db $7E,$9F,$DD,$00,$0C,$B0,$DD,$00
	db $18,$AB,$DD,$00,$30,$9F,$00,$DA
	db $05,$E2,$38,$DB,$0A,$DE,$00,$00
	db $00,$08,$5B,$B0,$C6,$C6,$08,$5C
	db $B0,$C7,$08,$5B,$B9,$B0,$C6,$C6
	db $08,$5C,$B0,$C7,$08,$5B,$B9,$B0
	db $C6,$C6,$08,$5C,$B0,$C7,$08,$5B
	db $B9,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$B9,$B0,$C6,$C6,$08,$5C
	db $B0,$C7,$08,$5B,$B9,$B0,$C6,$C6
	db $08,$5C,$B0,$C7,$08,$5B,$B9,$B0
	db $C6,$C6,$08,$5C,$B0,$C7,$08,$5B
	db $B9,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$B9,$60,$B0,$C7,$08,$B0
	db $C6,$C6,$08,$5C,$B0,$C7,$08,$5B
	db $B9,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$B9,$B0,$C6,$C6,$C7,$C7
	db $C7,$18,$B0,$C7,$DA,$05,$DB,$0F
	db $01,$C7,$08,$49,$B9,$C6,$C6,$B9
	db $C7,$B0,$B9,$C6,$C6,$B9,$C7,$B0
	db $B9,$C6,$C6,$B9,$C7,$B0,$B9,$C6
	db $C6,$B9,$C7,$B0,$B9,$C6,$C6,$B9
	db $C7,$B0,$B9,$C6,$C6,$B9,$C7,$B0
	db $B9,$C6,$C6,$B9,$C7,$B0,$B9,$C6
	db $C6,$B9,$C7,$B0,$60,$BA,$C7,$08
	db $B9,$C6,$C6,$B9,$C7,$B0,$B9,$C6
	db $C6,$B9,$C7,$B0,$B9,$C6,$C6,$C7
	db $C7,$C7,$18,$B9,$C7,$DA,$06,$DB
	db $05,$DE,$23,$14,$20,$30,$3C,$B0
	db $B0,$0C,$AD,$C7,$30,$B0,$0C,$AD
	db $C7,$18,$6C,$B0,$18,$2B,$AD,$A9
	db $60,$6C,$B0,$0C,$AD,$C7,$18,$5C
	db $B4,$18,$1B,$B5,$B4,$B5,$24,$3C
	db $B4,$0C,$AB,$B7,$B5,$B4,$C6,$60
	db $6C,$B0,$18,$C7,$C7,$BC,$C7,$DA
	db $04,$E2,$38,$DB,$0A,$DE,$23,$14
	db $20,$30,$3C,$B5,$B5,$0C,$B2,$C7
	db $30,$B5,$0C,$B2,$C7,$18,$6C,$B5
	db $18,$2B,$B2,$B0,$60,$6C,$B5,$0C
	db $B2,$C7,$18,$5C,$BC,$18,$1B,$BE
	db $BC,$BE,$24,$3C,$BC,$0C,$B0,$BA
	db $B9,$B7,$C6,$60,$6C,$B5,$18,$C7
	db $C7,$C1,$C7,$00,$DA,$06,$DB,$0F
	db $DE,$23,$14,$20,$30,$3C,$AD,$AD
	db $0C,$A9,$C7,$30,$AD,$0C,$A9,$C7
	db $18,$6C,$AD,$18,$2B,$A9,$A9,$60
	db $6C,$AD,$0C,$A9,$C7,$18,$C7,$C7
	db $C7,$C7,$24,$C7,$0C,$A8,$B4,$B0
	db $AE,$C6,$60,$6C,$AD,$18,$C7,$C7
	db $B9,$C7,$00,$DA,$04,$DB,$0A,$18
	db $4B,$91,$C7,$91,$C7,$8F,$C7,$8F
	db $C7,$8E,$C7,$8E,$C7,$8D,$C7,$8D
	db $C7,$8C,$C7,$C7,$C7,$C7,$C7,$8E
	db $90,$91,$C7,$8C,$C7,$91,$C7,$91
	db $C7,$00,$F0,$DA,$0D,$E2,$30,$DB
	db $0D,$30,$6D,$9F,$C6,$C6,$DA,$0D
	db $DB,$0C,$04,$C7,$30,$6C,$A6,$C6
	db $C6,$DA,$0D,$DB,$0B,$08,$C7,$30
	db $6C,$A9,$C6,$C6,$DA,$0D,$DB,$0A
	db $0B,$C7,$30,$6C,$AE,$C6,$C6,$DA
	db $0D,$DB,$09,$0E,$C7,$30,$6C,$B2
	db $C6,$C6,$DA,$0D,$DB,$08,$11,$C7
	db $30,$6C,$B5,$30,$6D,$B5,$C6,$DA
	db $0D,$DB,$07,$14,$C7,$30,$6D,$B9
	db $18,$6D,$C6,$B0,$00,$DB,$0D,$60
	db $6D,$98,$C6,$C6,$DB,$0C,$04,$C7
	db $60,$6C,$9F,$C6,$C6,$DB,$0B,$08
	db $C7,$60,$6C,$A2,$C6,$C6,$DB,$0A
	db $30,$6C,$AE,$AB,$C6,$C6,$DB,$09
	db $03,$C7,$30,$6C,$B1,$AE,$C6,$C6
	db $DB,$08,$06,$C7,$30,$6C,$B4,$B1
	db $C6,$C6,$DB,$07,$09,$C7,$30,$6D
	db $B9,$B4,$00,$DB,$0D,$60,$6D,$9D
	db $C6,$C6,$00,$DB,$0C,$04,$C7,$60
	db $6C,$A4,$C6,$C6,$DB,$0B,$08,$C7
	db $48,$6C,$A8,$30,$C6,$C3,$60,$C6
	db $C6,$DB,$0A,$01,$C7,$48,$6C,$AD
	db $B9,$C6,$C6,$DB,$09,$03,$C7,$48
	db $6C,$B0,$18,$C6,$60,$BE,$C6,$DB
	db $08,$05,$C7,$60,$6C,$B4,$C6,$C6
	db $DB,$07,$07,$C7,$60,$6D,$B7,$C6
	db $C6,$00,$F0,$DA,$03,$E2,$30,$DB
	db $0A,$04,$6F,$B4,$B2,$B4,$24,$C7
	db $E2,$34,$DA,$09,$0C,$6E,$C4,$C5
	db $C4,$C5,$C1,$BC,$BD,$BE,$B8,$B9
	db $B5,$B0,$B1,$B2,$AC,$AD,$30,$A9
	db $9D,$00,$DA,$09,$DB,$0A,$30,$4E
	db $C7,$18,$C7,$AD,$C7,$AB,$C7,$A9
	db $C7,$A8,$18,$A4,$C7,$98,$C7,$DA
	db $09,$DB,$0A,$30,$6E,$C7,$18,$9D
	db $18,$4E,$A9,$18,$6E,$9B,$18,$4E
	db $A7,$18,$6E,$9A,$18,$4E,$A6,$18
	db $6E,$98,$18,$4E,$A4,$18,$6E,$91
	db $C7,$30,$91,$F0,$DA,$09,$E2,$40
	db $DB,$0A,$DE,$00,$00,$00,$0C,$6E
	db $B4,$0C,$6C,$B2,$AE,$24,$6E,$B4
	db $0C,$6C,$B2,$AE,$18,$AD,$18,$6E
	db $B9,$B9,$C6,$00,$DA,$09,$DB,$14
	db $24,$6D,$96,$96,$18,$C6,$60,$95
	db $DA,$09,$DB,$0A,$24,$6D,$9E,$9E
	db $18,$C6,$18,$9F,$B1,$B1,$C6,$DA
	db $09,$DB,$00,$24,$6E,$AE,$AE,$18
	db $C6,$18,$A5,$06,$B3,$12,$B4,$06
	db $B3,$12,$B4,$18,$C6,$DE,$00,$00
	db $00,$30,$6E,$B9,$24,$6D,$B5,$0C
	db $B0,$B2,$18,$B5,$30,$B5,$0C,$B2
	db $18,$B0,$B5,$B5,$BC,$24,$B9,$30
	db $B7,$0C,$B0,$00,$18,$6C,$91,$18
	db $4C,$A4,$18,$6C,$95,$18,$4C,$A4
	db $18,$6C,$96,$18,$4C,$A6,$18,$6C
	db $97,$18,$4C,$A6,$18,$6C,$95,$18
	db $4C,$A4,$18,$6C,$94,$18,$4C,$A4
	db $18,$6C,$93,$18,$4C,$A6,$18,$6C
	db $8C,$18,$4C,$A4,$18,$4C,$C7,$A1
	db $C7,$A1,$C7,$A2,$C7,$A3,$C7,$A1
	db $C7,$A1,$C7,$A2,$C7,$A2,$18,$4C
	db $C7,$A9,$C7,$A9,$C7,$A9,$C7,$A9
	db $C7,$A9,$C7,$A9,$C7,$A9,$C7,$A8
	db $DA,$0C,$0C,$6F,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$B0,$C6,$B5,$C6
	db $B0,$C6,$B5,$B5,$30,$6E,$B9,$24
	db $6D,$B5,$0C,$B0,$B2,$18,$B5,$30
	db $B5,$0C,$B2,$18,$B0,$B5,$0C,$BA
	db $B9,$B7,$30,$B5,$C7,$0C,$C7,$00
	db $18,$6C,$91,$18,$4C,$A4,$18,$6C
	db $95,$18,$4C,$A4,$18,$6C,$96,$18
	db $4C,$A6,$18,$6C,$97,$18,$4C,$A6
	db $18,$6C,$93,$18,$4C,$A6,$18,$6C
	db $98,$18,$4C,$A8,$18,$6C,$91,$18
	db $4C,$A4,$18,$6C,$91,$18,$4C,$A4
	db $18,$4C,$C7,$A1,$C7,$A1,$C7,$A2
	db $C7,$A3,$C7,$A2,$C7,$A4,$C7,$A1
	db $C7,$A1,$18,$4C,$C7,$A9,$C7,$A9
	db $C7,$A9,$C7,$A9,$C7,$A9,$C7,$AB
	db $C7,$A9,$C7,$A9,$24,$6D,$B9,$24
	db $6C,$B5,$18,$B0,$24,$6D,$B9,$3C
	db $6C,$B5,$0C,$6D,$B8,$0C,$6C,$B5
	db $18,$B0,$24,$6D,$B8,$6C,$6C,$B7
	db $00,$18,$6B,$96,$18,$4B,$A6,$18
	db $6B,$96,$18,$4B,$A6,$18,$6B,$95
	db $18,$4B,$A4,$18,$6B,$95,$18,$4B
	db $A4,$18,$6B,$94,$18,$4B,$A4,$18
	db $6B,$94,$18,$4B,$A4,$18,$6B,$93
	db $18,$4B,$A6,$18,$6B,$8C,$18,$4B
	db $A4,$18,$4B,$C7,$A2,$C7,$A2,$C7
	db $A1,$C7,$A1,$C7,$A0,$C7,$A0,$C7
	db $A2,$C7,$A2,$18,$4B,$C7,$A9,$C7
	db $A9,$C7,$A9,$C7,$A9,$C7,$A9,$C7
	db $A9,$C7,$A9,$C7,$A8,$DA,$0C,$0C
	db $6D,$B0,$C6,$B5,$C6,$B0,$C6,$B5
	db $B5,$B0,$C6,$B5,$C6,$B0,$C6,$B5
	db $B5,$B0,$C6,$B5,$C6,$B0,$C6,$B5
	db $B5,$B0,$C6,$B5,$C6,$B0,$C6,$B5
	db $B5,$24,$6D,$B9,$24,$6C,$B5,$18
	db $B0,$24,$6D,$B9,$3C,$6C,$B5,$0C
	db $6D,$B8,$0C,$6C,$B5,$18,$B0,$60
	db $BC,$30,$C7,$00,$30,$6E,$B9,$24
	db $6D,$B5,$0C,$B0,$B2,$18,$B5,$30
	db $B5,$0C,$B7,$0C,$6E,$B9,$0C,$6D
	db $B5,$18,$B0,$24,$B2,$60,$B5,$0C
	db $B2,$18,$5E,$BC,$BE,$BC,$BE,$24
	db $BC,$0C,$B0,$BA,$B9,$B7,$C6,$60
	db $B5,$C7,$00,$18,$6C,$91,$18,$4C
	db $A4,$18,$6C,$91,$18,$4C,$A4,$18
	db $6C,$8F,$18,$4C,$A4,$18,$6C,$8F
	db $18,$4C,$A4,$18,$6C,$8E,$18,$4C
	db $A4,$18,$6C,$8E,$18,$4C,$A4,$18
	db $6C,$8D,$18,$4C,$A3,$18,$6C,$8D
	db $18,$4C,$A3,$60,$6C,$8C,$30,$C6
	db $18,$6C,$8E,$90,$18,$6C,$91,$18
	db $4C,$A4,$18,$6C,$91,$18,$4C,$A4
	db $18,$6C,$91,$18,$4C,$A4,$18,$6C
	db $91,$18,$4C,$A4,$18,$4C,$C7,$A1
	db $C7,$A1,$C7,$A2,$C7,$A2,$C7,$A1
	db $C7,$A1,$C7,$A0,$C7,$A0,$A2,$C6
	db $C6,$C6,$C6,$C6,$C6,$C6,$0C,$C7
	db $C7,$0C,$6E,$A9,$18,$6D,$A1,$0C
	db $6E,$A9,$18,$6D,$A1,$0C,$6E,$A9
	db $18,$6D,$A1,$30,$6E,$A9,$18,$4C
	db $C7,$A9,$C7,$A9,$C7,$AB,$C7,$AB
	db $C7,$A9,$C7,$A9,$C7,$A9,$C7,$A9
	db $A8,$C6,$C6,$C6,$C6,$C6,$C6,$C6
	db $0C,$C7,$C7,$0C,$6E,$A4,$18,$6D
	db $9D,$0C,$6E,$A4,$18,$6E,$9D,$0C
	db $6E,$A4,$18,$6D,$9D,$0C,$A4,$C6
	db $C6,$9D,$DB,$0A,$0C,$5C,$C6,$A6
	db $B2,$AD,$B0,$18,$7E,$B2,$0C,$5C
	db $AD,$B2,$AA,$AD,$24,$7E,$B2,$0C
	db $5C,$A6,$C6,$C7,$A6,$B2,$A6,$AB
	db $18,$7E,$B2,$0C,$5C,$A6,$B2,$A6
	db $AB,$24,$7E,$B2,$0C,$5C,$A6,$C6
	db $00,$DB,$14,$18,$6C,$8E,$18,$4C
	db $A6,$18,$6C,$95,$18,$4C,$A6,$18
	db $6C,$8E,$18,$4C,$A6,$18,$6C,$95
	db $18,$4C,$A6,$18,$6C,$93,$18,$4C
	db $A6,$18,$6C,$8E,$18,$4C,$A6,$18
	db $6C,$93,$18,$4C,$A6,$18,$6C,$8E
	db $18,$4C,$A6,$18,$6C,$8C,$18,$4C
	db $A4,$18,$6C,$93,$18,$4C,$A4,$18
	db $6C,$8C,$18,$4C,$A4,$18,$6C,$93
	db $18,$4C,$A4,$18,$6C,$91,$18,$4C
	db $A4,$18,$6C,$8C,$18,$4C,$A4,$18
	db $6C,$91,$18,$6D,$91,$18,$7E,$90
	db $18,$7E,$8F,$DB,$0A,$0C,$5C,$C7
	db $C7,$AA,$C6,$C6,$24,$7E,$AA,$24
	db $5C,$AA,$54,$7E,$AA,$24,$5C,$AE
	db $24,$7E,$AE,$24,$5C,$AE,$3C,$7E
	db $AE,$DB,$00,$18,$4C,$C7,$9E,$C7
	db $9E,$C7,$9E,$C7,$9E,$C7,$A2,$C7
	db $A2,$C7,$A2,$C7,$A2,$0C,$5C,$C6
	db $A4,$B0,$AB,$AE,$18,$7E,$B0,$0C
	db $5C,$AB,$B0,$A8,$AB,$24,$7F,$B0
	db $0C,$5C,$A4,$C6,$C6,$A4,$B0,$A9
	db $AD,$18,$7E,$B0,$0C,$5C,$A9,$18
	db $7B,$B0,$18,$7D,$B0,$18,$7E,$AF
	db $18,$7E,$AE,$00,$18,$6C,$8C,$18
	db $4C,$A4,$18,$6C,$93,$18,$4C,$A4
	db $18,$6C,$8C,$18,$4C,$A4,$18,$6C
	db $93,$18,$4C,$A4,$18,$6C,$91,$18
	db $4C,$A4,$18,$6C,$8C,$18,$4C,$A4
	db $18,$7C,$91,$18,$7C,$91,$18,$7E
	db $90,$18,$7E,$8F,$0C,$5C,$C7,$C7
	db $A8,$C6,$C6,$24,$7E,$A8,$24,$5C
	db $A8,$54,$7E,$A8,$24,$5C,$A9,$24
	db $7E,$A9,$18,$7B,$A1,$18,$7D,$A1
	db $18,$7E,$A0,$18,$7E,$9F,$18,$4C
	db $C7,$9C,$C7,$9C,$C7,$9C,$C7,$9C
	db $C7,$9D,$C7,$9D,$A7,$A7,$18,$6E
	db $A6,$A5,$DA,$0C,$0C,$6F,$B0,$C6
	db $B5,$C6,$B0,$C6,$B5,$B5,$B0,$C6
	db $B5,$C6,$B0,$C6,$B5,$B5,$B0,$C6
	db $B5,$C6,$B0,$C6,$B5,$B5,$B5,$B0
	db $B5,$B0,$B5,$B0,$B5,$B0,$0C,$5C
	db $C6,$A8,$B4,$A8,$AB,$18,$7E,$B4
	db $0C,$5C,$A8,$B4,$A8,$AB,$24,$7E
	db $B4,$0C,$5C,$A8,$C6,$C6,$A9,$B5
	db $18,$7E,$A4,$0C,$5C,$B0,$B2,$B4
	db $18,$7E,$B5,$B4,$B5,$C6,$00,$18
	db $6C,$8C,$18,$4C,$A4,$18,$6C,$93
	db $18,$4C,$A4,$18,$6C,$8C,$18,$4C
	db $A4,$18,$6C,$93,$18,$4C,$A4,$18
	db $6C,$91,$18,$4C,$A4,$18,$6C,$8C
	db $18,$4C,$A4,$18,$6C,$91,$18,$6C
	db $8C,$18,$6C,$91,$18,$6C,$91,$0C
	db $5C,$C7,$C7,$AE,$C6,$C6,$24,$7E
	db $AE,$24,$5C,$AE,$54,$7E,$AE,$0C
	db $5C,$AD,$18,$7E,$A9,$0C,$5C,$A9
	db $A9,$AB,$18,$7E,$AD,$AB,$AD,$A1
	db $18,$4C,$C7,$9C,$C7,$9C,$C7,$9C
	db $C7,$9C,$C7,$9D,$C7,$9D,$B0,$B0
	db $B0,$A4,$DA,$0C,$0C,$6F,$B0,$C6
	db $B5,$C6,$B0,$C6,$B5,$B5,$B0,$C6
	db $B5,$C6,$B0,$C6,$B5,$B5,$B0,$C6
	db $B5,$C6,$B0,$C6,$B5,$B5,$B5,$C6
	db $B0,$C6,$B5,$C6,$B0,$C6,$EF,$F6
	db $00,$00,$F1,$04,$6C,$00,$F2,$DC
	db $16,$16,$DA,$03,$E2,$23,$24,$C7
	db $00,$DA,$03,$E2,$23,$DB,$00,$18
	db $4E,$85,$8A,$0C,$88,$8A,$C7,$85
	db $C7,$85,$8A,$C7,$18,$88,$8A,$85
	db $8A,$0C,$88,$8A,$C7,$85,$C7,$85
	db $8A,$C7,$18,$88,$8A,$00,$DA,$08
	db $DB,$05,$DE,$14,$08,$50,$18,$6E
	db $C7,$A0,$24,$9D,$0C,$98,$9A,$48
	db $9D,$0C,$C6,$18,$C7,$98,$0C,$9D
	db $18,$A4,$60,$A0,$DD,$0C,$3C,$A1
	db $60,$C6,$00,$DA,$08,$DB,$0F,$DE
	db $14,$08,$50,$06,$6B,$C7,$18,$C7
	db $A0,$24,$9D,$0C,$98,$9A,$48,$9D
	db $0C,$C6,$18,$C7,$98,$0C,$9D,$18
	db $A4,$60,$A0,$DD,$0C,$3C,$A1,$60
	db $C6,$00,$DA,$03,$E2,$23,$DB,$00
	db $18,$4E,$85,$8A,$0C,$88,$8A,$C7
	db $85,$C7,$85,$8A,$C7,$18,$88,$8A
	db $85,$8A,$0C,$88,$8A,$C7,$85,$C7
	db $85,$8A,$C7,$18,$88,$8A,$00,$DA
	db $03,$DB,$14,$0C,$4E,$91,$8C,$8F
	db $8C,$8D,$8B,$8F,$8D,$91,$8C,$8F
	db $8C,$8D,$8B,$8F,$8D,$91,$8C,$8F
	db $8C,$8D,$8B,$8F,$8D,$91,$8C,$8F
	db $8C,$8D,$8B,$8F,$8D,$00,$DA,$0C
	db $0C,$6D,$A9,$06,$A6,$A6,$0C,$A9
	db $A6,$C6,$A4,$A4,$C6,$A9,$06,$A6
	db $A6,$0C,$A9,$A6,$C6,$A4,$A4,$C6
	db $A9,$06,$A6,$A6,$0C,$A9,$A6,$C6
	db $A4,$A4,$C6,$A9,$06,$A6,$A6,$0C
	db $A9,$A6,$C6,$A4,$A4,$C6,$DA,$08
	db $DB,$05,$24,$5E,$A1,$9D,$18,$98
	db $24,$A1,$30,$9D,$0C,$C7,$A0,$9D
	db $18,$98,$24,$A0,$60,$9F,$0C,$C7
	db $DA,$08,$DB,$0F,$06,$6B,$C7,$24
	db $A1,$9D,$18,$98,$24,$A1,$30,$9D
	db $0C,$C7,$A0,$9D,$18,$98,$24,$A0
	db $60,$9F,$0C,$C7,$DA,$03,$DB,$00
	db $18,$4E,$8A,$8E,$0C,$8C,$8E,$C7
	db $89,$C7,$89,$8E,$C7,$18,$8C,$8E
	db $88,$8E,$0C,$8C,$8E,$C7,$87,$C7
	db $87,$8E,$C7,$18,$8C,$8E,$00,$DA
	db $03,$DB,$14,$0C,$4E,$91,$06,$8A
	db $89,$0C,$8E,$8A,$8C,$8A,$8E,$8A
	db $91,$06,$89,$88,$0C,$8C,$89,$8E
	db $89,$8C,$89,$91,$06,$88,$87,$0C
	db $8B,$88,$8E,$88,$8B,$88,$91,$06
	db $87,$86,$0C,$8A,$87,$8E,$87,$8A
	db $87,$00,$F0,$DA,$01,$E2,$12,$DB
	db $0F,$DE,$00,$00,$00,$E0,$80,$E1
	db $60,$FF,$06,$67,$BB,$BD,$B9,$BC
	db $BB,$BD,$B9,$BC,$BB,$BD,$B9,$BC
	db $BB,$BD,$B9,$BC,$BB,$BD,$B9,$BC
	db $BB,$BD,$B9,$BC,$BB,$BD,$B9,$BC
	db $BB,$BD,$B9,$BC,$00,$DA,$02,$DB
	db $0A,$DE,$00,$00,$00,$06,$67,$BB
	db $BD,$B9,$BC,$BB,$BD,$B9,$BC,$BB
	db $BD,$B9,$BC,$BB,$BD,$B9,$BC,$BB
	db $BD,$B9,$BC,$BB,$BD,$B9,$BC,$BB
	db $BD,$B9,$BC,$BB,$BD,$B9,$BC,$DA
	db $01,$DB,$05,$DE,$00,$00,$00,$06
	db $67,$B5,$B7,$B4,$B6,$B5,$B7,$B4
	db $B6,$B5,$B7,$B4,$B6,$B5,$B7,$B4
	db $B6,$B5,$B7,$B4,$B6,$B5,$B7,$B4
	db $B6,$B5,$B7,$B4,$B6,$B5,$B7,$B4
	db $B6,$DA,$0B,$DB,$00,$DE,$00,$00
	db $00,$E7,$A0,$E8,$60,$FF,$60,$7F
	db $A9,$DD,$30,$60,$A7,$E8,$60,$B0
	db $DC,$60,$0A,$60,$C6,$DA,$0B,$DB
	db $00,$DE,$00,$00,$00,$E7,$A0,$E8
	db $60,$FF,$60,$7F,$A3,$DD,$30,$60
	db $A1,$E8,$60,$B0,$DC,$60,$0A,$60
	db $C6,$DA,$01,$DB,$0F,$E0,$80,$E1
	db $60,$FF,$06,$67,$BD,$BF,$BB,$BE
	db $BD,$BF,$BB,$BE,$BD,$BF,$BB,$BE
	db $BD,$BF,$BB,$BE,$BD,$BF,$BB,$BE
	db $BD,$BF,$BB,$BE,$BD,$BF,$BB,$BE
	db $BD,$BF,$BB,$BE,$00,$DA,$02,$DB
	db $0A,$06,$67,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$DA,$01,$DB,$05,$06
	db $67,$B7,$B9,$B6,$B8,$B7,$B9,$B6
	db $B8,$B7,$B9,$B6,$B8,$B7,$B9,$B6
	db $B8,$B7,$B9,$B6,$B8,$B7,$B9,$B6
	db $B8,$B7,$B9,$B6,$B8,$B7,$B9,$B6
	db $B8,$DA,$0B,$DB,$0A,$DE,$00,$00
	db $00,$E7,$A0,$E8,$60,$FF,$60,$7F
	db $AB,$DD,$30,$60,$A9,$E8,$60,$B0
	db $DC,$60,$14,$60,$C6,$DA,$0B,$DB
	db $0A,$DE,$00,$00,$00,$E7,$A0,$E8
	db $60,$FF,$60,$7F,$A5,$DD,$30,$60
	db $A3,$E8,$60,$B0,$DC,$60,$14,$60
	db $C6,$DA,$01,$DB,$0F,$E0,$80,$E1
	db $60,$FF,$06,$67,$BF,$C1,$BD,$C0
	db $BF,$C1,$BD,$C0,$BF,$C1,$BD,$C0
	db $BF,$C1,$BD,$C0,$BF,$C1,$BD,$C0
	db $BF,$C1,$BD,$C0,$BF,$C1,$BD,$C0
	db $BF,$C1,$BD,$C0,$00,$DA,$02,$DB
	db $0A,$06,$67,$BF,$C1,$BD,$C0,$BF
	db $C1,$BD,$C0,$BF,$C1,$BD,$C0,$BF
	db $C1,$BD,$C0,$BF,$C1,$BD,$C0,$BF
	db $C1,$BD,$C0,$BF,$C1,$BD,$C0,$BF
	db $C1,$BD,$C0,$DA,$01,$DB,$05,$06
	db $67,$B9,$BB,$B8,$BA,$B9,$BB,$B8
	db $BA,$B9,$BB,$B8,$BA,$B9,$BB,$B8
	db $BA,$B9,$BB,$B8,$BA,$B9,$BB,$B8
	db $BA,$B9,$BB,$B8,$BA,$B9,$BB,$B8
	db $BA,$DA,$0B,$DB,$14,$DE,$00,$00
	db $00,$E7,$A0,$E8,$60,$FF,$60,$7F
	db $AD,$DD,$30,$60,$AB,$E8,$60,$B0
	db $DC,$60,$0A,$60,$C6,$DA,$0B,$DB
	db $14,$DE,$00,$00,$00,$E7,$A0,$E8
	db $60,$FF,$60,$7F,$A7,$DD,$30,$60
	db $A5,$E8,$60,$B0,$DC,$60,$0A,$60
	db $C6,$DA,$01,$DB,$0F,$E0,$80,$E1
	db $60,$FF,$06,$67,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$00,$DA,$02,$DB
	db $0A,$06,$67,$C1,$C3,$BF,$C2,$C1
	db $C3,$BF,$C2,$C1,$C3,$BF,$C2,$C1
	db $C3,$BF,$C2,$C1,$C3,$BF,$C2,$C1
	db $C3,$BF,$C2,$C1,$C3,$BF,$C2,$C1
	db $C3,$BF,$C2,$DA,$01,$DB,$05,$06
	db $67,$BB,$BD,$BA,$BC,$BB,$BD,$BA
	db $BC,$BB,$BD,$BA,$BC,$BB,$BD,$BA
	db $BC,$BB,$BD,$BA,$BC,$BB,$BD,$BA
	db $BC,$BB,$BD,$BA,$BC,$BB,$BD,$BA
	db $BC,$DA,$0B,$DB,$0A,$E7,$A0,$E8
	db $60,$FF,$60,$7F,$AF,$DD,$30,$60
	db $AD,$E8,$60,$B0,$DC,$60,$00,$60
	db $C6,$DA,$0B,$DB,$0A,$E7,$A0,$E8
	db $60,$FF,$60,$7F,$A9,$DD,$30,$60
	db $A7,$E8,$60,$B0,$DC,$60,$00,$60
	db $C6,$DA,$01,$E0,$FF,$DB,$0F,$DE
	db $00,$00,$00,$06,$67,$C1,$C3,$BF
	db $C2,$C1,$C3,$BF,$C2,$C1,$C3,$BF
	db $C2,$C1,$C3,$BF,$C2,$C1,$C3,$BF
	db $C2,$C1,$C3,$BF,$C2,$C1,$C3,$BF
	db $C2,$C1,$C3,$BF,$C2,$C1,$C3,$BF
	db $C2,$C1,$C3,$BF,$C2,$C1,$C3,$BF
	db $C2,$C1,$C3,$BF,$C2,$E1,$60,$80
	db $06,$C1,$C3,$BF,$C2,$C1,$C3,$BF
	db $C2,$C1,$C3,$BF,$C2,$C1,$C3,$BF
	db $C2,$00,$DA,$02,$DB,$0A,$DE,$00
	db $00,$00,$06,$67,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$C1,$C3,$BF,$C2
	db $C1,$C3,$BF,$C2,$DA,$01,$DB,$05
	db $DE,$00,$00,$00,$06,$67,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$BB,$BD
	db $BA,$BC,$BB,$BD,$BA,$BC,$DA,$0B
	db $E7,$FF,$DB,$05,$DE,$14,$1E,$70
	db $30,$7F,$A6,$18,$A3,$9E,$9F,$48
	db $A3,$18,$C6,$9E,$A3,$AA,$30,$A6
	db $A5,$DA,$0B,$E7,$FF,$DB,$0A,$DE
	db $14,$1E,$70,$12,$7B,$C7,$30,$A6
	db $18,$A3,$9E,$9F,$48,$A3,$18,$C6
	db $9E,$A3,$AA,$30,$A6,$A5,$DA,$04
	db $E7,$FF,$DB,$0F,$DE,$00,$00,$00
	db $30,$7E,$8E,$18,$8B,$86,$87,$48
	db $8B,$18,$C6,$86,$8B,$92,$30,$8E
	db $8D,$E0,$FF,$06,$67,$BF,$C1,$BD
	db $C0,$BF,$C1,$BD,$C0,$BF,$C1,$BD
	db $C0,$BF,$C1,$BD,$C0,$BF,$C1,$BD
	db $C0,$BF,$C1,$BD,$C0,$BF,$C1,$BD
	db $C0,$BF,$C1,$BD,$C0,$BF,$C1,$BD
	db $C0,$BF,$C1,$BD,$C0,$BF,$C1,$BD
	db $C0,$BF,$C1,$BD,$C0,$E1,$60,$80
	db $06,$BF,$C1,$BD,$C0,$BF,$C1,$BD
	db $C0,$BF,$C1,$BD,$C0,$BF,$C1,$BD
	db $C0,$00,$DA,$01,$DB,$05,$06,$67
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $B9,$BB,$B8,$BA,$B9,$BB,$B8,$BA
	db $DA,$0B,$E7,$FF,$DB,$05,$DE,$14
	db $1E,$70,$30,$7F,$A4,$18,$A1,$9C
	db $9D,$48,$A1,$18,$C6,$9C,$A1,$A8
	db $30,$A4,$A3,$DA,$0B,$E7,$FF,$DB
	db $0A,$DE,$14,$1E,$70,$12,$7B,$C7
	db $30,$A4,$18,$A1,$9C,$9D,$48,$A1
	db $18,$C6,$9C,$A1,$A8,$30,$A4,$A3
	db $DA,$04,$E7,$FF,$DB,$0F,$DE,$00
	db $00,$00,$30,$7E,$8C,$18,$89,$84
	db $85,$48,$89,$18,$C6,$84,$89,$90
	db $30,$8C,$8B,$E0,$FF,$06,$67,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$E1
	db $60,$80,$06,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$BD,$BF,$BB,$BE,$BD
	db $BF,$BB,$BE,$00,$DA,$01,$DB,$05
	db $06,$67,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$B7,$B9,$B6,$B8,$B7,$B9
	db $B6,$B8,$DA,$0B,$E7,$FF,$DB,$05
	db $DE,$14,$1E,$70,$30,$7F,$A2,$18
	db $9F,$9A,$9B,$48,$9F,$18,$C6,$9A
	db $9F,$A6,$30,$A2,$A1,$DA,$0B,$E7
	db $FF,$DB,$0A,$DE,$14,$1E,$70,$12
	db $7B,$C7,$30,$A2,$18,$9F,$9A,$9B
	db $48,$9F,$18,$C6,$9A,$9F,$A6,$30
	db $A2,$A1,$DA,$04,$E7,$FF,$DB,$0F
	db $DE,$00,$00,$00,$30,$7E,$8A,$18
	db $87,$82,$83,$48,$87,$18,$C6,$82
	db $87,$8E,$30,$8A,$89,$F0,$DA,$01
	db $E2,$36,$DB,$0A,$DE,$00,$00,$00
	db $30,$6D,$BE,$24,$BA,$0C,$B5,$0C
	db $B4,$C7,$B5,$B7,$30,$C6,$00,$DA
	db $02,$DB,$0A,$DE,$00,$00,$00,$30
	db $67,$BE,$24,$BA,$0C,$B5,$0C,$B4
	db $C7,$B5,$B7,$30,$C6,$00,$DA,$02
	db $DB,$8A,$DE,$00,$00,$00,$06,$65
	db $C7,$30,$BE,$24,$BA,$0C,$B5,$0C
	db $B4,$C7,$B5,$B7,$30,$C6,$DA,$01
	db $DB,$8A,$DE,$00,$00,$00,$06,$69
	db $C7,$30,$BE,$24,$BA,$0C,$B5,$0C
	db $B4,$C7,$B5,$B7,$30,$C6,$DA,$01
	db $DB,$0A,$DE,$00,$00,$00,$30,$6D
	db $B5,$24,$B2,$0C,$AE,$0C,$AB,$C7
	db $AD,$AE,$30,$C6,$DA,$01,$DB,$82
	db $DE,$00,$00,$00,$06,$69,$C7,$30
	db $B5,$24,$B2,$0C,$AE,$0C,$AB,$C7
	db $AD,$AE,$30,$C6,$DA,$01,$DB,$0A
	db $DE,$00,$00,$00,$30,$6D,$A2,$24
	db $9D,$0C,$9A,$0C,$98,$C7,$9A,$9C
	db $30,$C6,$DA,$01,$DB,$A0,$DE,$00
	db $00,$00,$06,$69,$C7,$30,$A2,$24
	db $9D,$0C,$9A,$0C,$98,$C7,$9A,$9C
	db $30,$C6,$DA,$05,$DB,$0A,$DE,$00
	db $00,$00,$08,$5B,$B0,$C6,$C6,$B0
	db $C7,$B9,$B0,$C6,$C6,$B0,$C7,$B9
	db $B2,$C6,$C6,$B2,$C7,$BA,$B1,$C6
	db $C6,$B1,$C7,$BA,$B0,$C6,$C6,$B0
	db $C7,$B9,$B0,$C6,$C6,$B0,$C7,$B9
	db $B2,$C6,$C6,$B1,$C6,$C6,$C6,$C6
	db $C6,$C6,$C6,$C6,$00,$DA,$05,$DB
	db $0F,$DE,$00,$00,$00,$01,$49,$C7
	db $08,$B5,$C6,$C6,$B5,$C7,$B5,$B5
	db $C6,$C6,$B5,$C7,$B5,$B5,$C6,$C6
	db $B5,$C7,$B5,$B4,$C6,$C6,$B4,$C7
	db $B4,$B5,$C6,$C6,$B5,$C7,$B5,$B5
	db $C6,$C6,$B5,$C7,$B5,$B5,$C6,$C6
	db $B4,$C6,$C6,$C6,$C6,$C6,$C6,$C6
	db $C6,$DA,$05,$DB,$05,$DE,$00,$00
	db $00,$02,$C7,$08,$48,$B9,$C6,$C6
	db $B9,$C7,$B0,$B9,$C6,$C6,$B9,$C7
	db $B0,$BA,$C6,$C6,$BA,$C7,$B2,$BA
	db $C6,$C6,$BA,$C7,$B1,$B9,$C6,$C6
	db $B9,$C7,$B0,$B9,$C6,$C6,$B9,$C7
	db $B0,$BA,$C6,$C6,$BA,$C6,$C6,$C6
	db $C6,$C6,$C6,$C6,$C6,$DA,$04,$DB
	db $0A,$18,$4C,$91,$C7,$8E,$C7,$93
	db $C7,$8C,$C7,$91,$C7,$8E,$C7,$93
	db $92,$C6,$C6,$60,$01,$C7,$C7,$C7
	db $C7,$DA,$05,$DB,$0A,$DE,$00,$00
	db $00,$08,$5B,$B0,$C6,$C6,$08,$5C
	db $B0,$C7,$08,$5B,$B9,$B0,$C6,$C6
	db $08,$5C,$B0,$C7,$08,$5B,$B9,$B2
	db $C6,$C6,$08,$5C,$B2,$C7,$08,$5B
	db $BA,$B2,$C6,$C6,$08,$5C,$B2,$C7
	db $08,$5B,$BB,$B0,$C6,$C6,$08,$5C
	db $B0,$C7,$08,$5B,$B9,$B0,$C6,$C6
	db $08,$5C,$B0,$C7,$08,$5B,$B8,$B0
	db $C6,$C6,$08,$5C,$B0,$C7,$08,$5B
	db $B7,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$BA,$00,$DA,$05,$DB,$05
	db $02,$C7,$08,$48,$B9,$C6,$C6,$B9
	db $C7,$B0,$B9,$C6,$C6,$B9,$C7,$B0
	db $BA,$C6,$C6,$BA,$C7,$B2,$BB,$C6
	db $C6,$BB,$C7,$B2,$B9,$C6,$C6,$B9
	db $C7,$B0,$B8,$C6,$C6,$B8,$C7,$B0
	db $B7,$C6,$C6,$B7,$C7,$B0,$BA,$C6
	db $C6,$BA,$C7,$B0,$DA,$05,$DB,$0F
	db $01,$49,$C7,$08,$B5,$C6,$C6,$B5
	db $C7,$B5,$B5,$C6,$C6,$B5,$C7,$B5
	db $B5,$C6,$C6,$B5,$C7,$B5,$B5,$C6
	db $C6,$B5,$C7,$B5,$B4,$C6,$C6,$B4
	db $C7,$B4,$B3,$C6,$C6,$B3,$C7,$B3
	db $B2,$C6,$C6,$B2,$C7,$B2,$B4,$C6
	db $C6,$B4,$C7,$B4,$DA,$07,$DB,$0A
	db $30,$5C,$AD,$24,$A9,$0C,$A4,$A6
	db $18,$A9,$30,$A9,$0C,$A6,$18,$A4
	db $A9,$A9,$B0,$24,$AD,$30,$AB,$0C
	db $A4,$DA,$0C,$DB,$0A,$E7,$FF,$0C
	db $6F,$B5,$B9,$B5,$B0,$B2,$C6,$B0
	db $C6,$B0,$B2,$B5,$C6,$B0,$B2,$B5
	db $C6,$B5,$B9,$B5,$B0,$B2,$C6,$B0
	db $C6,$B0,$B2,$B5,$C6,$B0,$C6,$C6
	db $C6,$B5,$B9,$B5,$B0,$B2,$C6,$B0
	db $C6,$B0,$B2,$B5,$C6,$B0,$B2,$B5
	db $C6,$B5,$B9,$B5,$B0,$B2,$C6,$B0
	db $C6,$B0,$B2,$B5,$C6,$B0,$C6,$B0
	db $B0,$DA,$04,$18,$4B,$91,$C7,$95
	db $C7,$96,$C7,$97,$C7,$95,$C7,$94
	db $C7,$93,$8C,$8E,$90,$08,$5B,$B0
	db $C6,$C6,$08,$5C,$B0,$C7,$08,$5B
	db $B9,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$B9,$B2,$C6,$C6,$08,$5C
	db $B2,$C7,$08,$5B,$BA,$B2,$C6,$C6
	db $08,$5C,$B2,$C7,$08,$5B,$BB,$B2
	db $C6,$C6,$08,$5C,$B2,$C7,$08,$5B
	db $BA,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$BA,$B0,$C6,$C6,$08,$5C
	db $B0,$C7,$08,$5B,$B9,$B0,$C6,$C6
	db $08,$5C,$B0,$C7,$08,$5B,$B9,$00
	db $02,$C7,$08,$48,$B9,$C6,$C6,$B9
	db $C7,$B0,$B9,$C6,$C6,$B9,$C7,$B0
	db $BA,$C6,$C6,$BA,$C7,$B2,$BB,$C6
	db $C6,$BB,$C7,$B2,$BA,$C6,$C6,$BA
	db $C7,$B2,$BA,$C6,$C6,$BA,$C7,$B0
	db $B9,$C6,$C6,$B9,$C7,$B0,$B9,$C6
	db $C6,$B9,$C7,$B0,$01,$C7,$08,$49
	db $B5,$C6,$C6,$B5,$C7,$B5,$B5,$C6
	db $C6,$B5,$C7,$B5,$B5,$C6,$C6,$B5
	db $C7,$B5,$B5,$C6,$C6,$B5,$C7,$B5
	db $B7,$C6,$C6,$B7,$C7,$B7,$B4,$C6
	db $C6,$B4,$C7,$B4,$B5,$C6,$C6,$B5
	db $C7,$B5,$B5,$C6,$C6,$B5,$C7,$B5
	db $30,$5C,$AD,$24,$A9,$0C,$A4,$A6
	db $18,$A9,$30,$A9,$0C,$A6,$18,$A4
	db $A9,$0C,$AE,$AD,$AB,$30,$A9,$C7
	db $C7,$18,$4B,$91,$C7,$95,$C7,$96
	db $C7,$97,$C7,$98,$8C,$90,$93,$91
	db $8C,$91,$C7,$08,$5B,$B2,$C6,$C6
	db $08,$5C,$B2,$C7,$08,$5B,$BA,$B2
	db $C6,$C6,$08,$5C,$B2,$C7,$08,$5B
	db $BA,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$B9,$B0,$C7,$B9,$08,$5C
	db $B0,$C7,$08,$5B,$B9,$AF,$C6,$C6
	db $08,$5C,$AF,$C7,$08,$5B,$B8,$AF
	db $C6,$C6,$08,$5C,$AF,$C7,$08,$5B
	db $B8,$AE,$C6,$C6,$08,$5C,$AE,$C7
	db $08,$5B,$B7,$B0,$C7,$B7,$08,$5C
	db $B0,$C7,$08,$5B,$B7,$00,$02,$C7
	db $08,$48,$BA,$C6,$C6,$BA,$C7,$B2
	db $BA,$C6,$C6,$BA,$C7,$B2,$B9,$C6
	db $C6,$B9,$C7,$B0,$B9,$C7,$B0,$B9
	db $C7,$B0,$B8,$C6,$C6,$B8,$C7,$AF
	db $B8,$C6,$C6,$B8,$C7,$AF,$B7,$C6
	db $C6,$B7,$C7,$AE,$B7,$C7,$B0,$B7
	db $C7,$B0,$01,$49,$C7,$08,$B5,$C6
	db $C6,$B5,$C7,$B5,$B5,$C6,$C6,$B5
	db $C7,$B5,$B5,$C6,$C6,$B5,$C7,$B5
	db $B5,$C7,$B5,$B5,$C7,$B5,$B2,$C6
	db $C6,$B2,$C7,$B2,$B2,$C6,$C6,$B2
	db $C7,$B2,$B2,$C6,$C6,$B2,$C7,$B2
	db $B4,$C7,$B4,$B4,$C7,$B4,$24,$5C
	db $AD,$A9,$18,$A4,$24,$AD,$30,$A9
	db $0C,$C7,$AC,$A9,$18,$A4,$24,$AC
	db $60,$AB,$0C,$C7,$DA,$08,$DB,$0A
	db $18,$4B,$96,$97,$98,$9A,$98,$95
	db $91,$93,$94,$97,$9A,$9D,$9F,$9D
	db $9C,$98,$DA,$0C,$DB,$0A,$E7,$FF
	db $06,$6F,$B5,$B5,$0C,$B9,$B5,$B0
	db $B2,$C6,$B0,$C6,$B5,$B2,$C6,$B5
	db $B2,$C6,$C6,$C6,$06,$B5,$B5,$0C
	db $B9,$B5,$B0,$B2,$C6,$B0,$C6,$B5
	db $B2,$C6,$B5,$B2,$C6,$C6,$C6,$08
	db $5B,$B2,$C6,$C6,$08,$5C,$B2,$C7
	db $08,$5B,$BA,$B2,$C6,$C6,$08,$5C
	db $B2,$08,$5B,$C7,$BA,$B0,$C6,$C6
	db $08,$5C,$B0,$C7,$08,$5B,$B9,$B0
	db $C7,$B9,$08,$5C,$B0,$08,$5B,$C7
	db $B9,$AF,$C6,$C6,$08,$5C,$AF,$C7
	db $08,$5B,$B8,$AF,$C6,$C6,$08,$5C
	db $AF,$08,$5B,$C7,$B8,$AE,$C6,$C6
	db $08,$5C,$AE,$C7,$08,$5B,$B7,$B0
	db $C7,$B0,$08,$5C,$B7,$08,$5B,$B0
	db $B7,$00,$02,$C7,$08,$48,$BA,$C6
	db $C6,$BA,$C7,$B2,$BA,$C6,$C6,$BA
	db $C7,$B2,$B9,$C6,$C6,$B9,$C7,$B0
	db $B9,$C7,$B0,$B9,$C7,$B0,$B8,$C6
	db $C6,$B8,$C7,$AF,$B8,$C6,$C6,$B8
	db $C7,$AF,$B7,$C6,$C6,$B7,$C7,$AE
	db $B7,$C7,$B7,$B0,$B7,$B0,$01,$C7
	db $08,$49,$B5,$C6,$C6,$B5,$C7,$B5
	db $B5,$C6,$C6,$B5,$C7,$B5,$B5,$C6
	db $C6,$B5,$C7,$B5,$B5,$C7,$B5,$B5
	db $C7,$B5,$B2,$C6,$C6,$B2,$C7,$B2
	db $B2,$C6,$C6,$B2,$C7,$B2,$B2,$C6
	db $C6,$B2,$C7,$B2,$B4,$C7,$B4,$B4
	db $B4,$B4,$24,$5C,$AD,$A9,$18,$A4
	db $24,$AD,$30,$A9,$0C,$C7,$AC,$A9
	db $18,$A4,$60,$B0,$C6,$18,$4B,$96
	db $95,$96,$9A,$9D,$9C,$98,$95,$97
	db $9A,$9D,$97,$96,$9A,$98,$9C,$DA
	db $05,$DB,$0A,$08,$49,$A6,$C6,$C6
	db $A9,$C6,$C6,$A6,$C7,$A9,$AA,$C6
	db $AB,$AD,$C7,$AC,$AB,$C6,$AA,$AD
	db $C7,$A6,$A7,$C6,$A8,$A9,$C7,$C7
	db $A6,$C6,$C6,$A9,$C7,$AB,$AC,$C6
	db $AD,$AC,$C7,$AD,$A9,$C6,$A6,$A4
	db $C7,$A9,$A1,$C6,$A2,$DA,$00,$DB
	db $0A,$DE,$23,$12,$40,$0C,$5C,$A6
	db $18,$A2,$24,$A6,$18,$A6,$0C,$A9
	db $A9,$A8,$30,$A7,$0C,$C7,$A6,$18
	db $A2,$A6,$0C,$C6,$18,$A8,$60,$A9
	db $DA,$00,$DB,$05,$DE,$23,$12,$40
	db $0C,$5C,$A9,$18,$A6,$24,$A9,$18
	db $AB,$0C,$AD,$AC,$AB,$30,$AA,$0C
	db $C7,$A9,$18,$A6,$A9,$0C,$C6,$18
	db $AB,$60,$AD,$00,$DA,$08,$DB,$0A
	db $18,$4C,$96,$95,$96,$97,$98,$99
	db $9A,$95,$93,$96,$95,$93,$91,$8E
	db $8C,$91,$00,$DA,$0C,$DB,$0A,$E7
	db $FF,$06,$6F,$B5,$B5,$B5,$C6,$B5
	db $C6,$B5,$C6,$0C,$B5,$B5,$B2,$C6
	db $B5,$B5,$18,$B5,$B2,$C6,$06,$B5
	db $B5,$B5,$C6,$B5,$C6,$B5,$C6,$0C
	db $B5,$B5,$B2,$C6,$B5,$B5,$18,$B5
	db $B2,$C6,$DA,$01,$DB,$0A,$0C,$5C
	db $A6,$18,$A2,$24,$A6,$18,$A6,$0C
	db $A9,$AB,$AD,$30,$AE,$0C,$C7,$A6
	db $18,$A2,$A6,$0C,$C6,$18,$A8,$60
	db $A4,$DA,$01,$DB,$0F,$0C,$5C,$A9
	db $18,$A6,$24,$A9,$18,$AB,$0C,$AD
	db $AE,$B0,$30,$B2,$0C,$C7,$A9,$18
	db $A6,$A9,$0C,$C6,$18,$AB,$60,$A9
	db $00,$DA,$08,$DB,$0A,$18,$4C,$96
	db $95,$96,$97,$98,$99,$9A,$95,$93
	db $96,$95,$93,$91,$8C,$91,$C6,$00
	db $DA,$05,$DB,$0A,$DE,$00,$00,$00
	db $08,$5B,$B0,$C6,$C6,$08,$5C,$B0
	db $C7,$08,$5B,$B9,$B0,$C6,$C6,$08
	db $5C,$B0,$C7,$08,$5B,$B9,$B0,$C6
	db $C6,$08,$5C,$B0,$C7,$08,$5B,$B9
	db $B0,$C6,$C6,$08,$5C,$B0,$C7,$08
	db $5B,$B9,$B0,$C6,$C6,$08,$5C,$B0
	db $C7,$08,$5B,$B9,$B0,$C6,$C6,$08
	db $5C,$B0,$C7,$08,$5B,$B9,$B0,$C6
	db $C6,$08,$5C,$B0,$C7,$08,$5B,$B9
	db $B0,$C6,$C6,$08,$5C,$B0,$C7,$08
	db $5B,$B9,$48,$B0,$78,$C7,$08,$B0
	db $C6,$C6,$08,$5C,$B0,$C7,$08,$5B
	db $B9,$B0,$C6,$C6,$08,$5C,$B0,$C7
	db $08,$5B,$B9,$B0,$C6,$C6,$08,$5C
	db $B0,$C7,$08,$5B,$B9,$B0,$C6,$C6
	db $08,$5C,$B0,$C7,$08,$5B,$B9,$00
	db $DA,$05,$DB,$05,$02,$C7,$08,$48
	db $B9,$C6,$C6,$B9,$C7,$B0,$B9,$C6
	db $C6,$B9,$C7,$B0,$B9,$C6,$C6,$B9
	db $C7,$B0,$B9,$C6,$C6,$B9,$C7,$B0
	db $B9,$C6,$C6,$B9,$C7,$B0,$B9,$C6
	db $C6,$B9,$C7,$B0,$B9,$C6,$C6,$B9
	db $C7,$B0,$B9,$C6,$C6,$B9,$C7,$B0
	db $02,$C7,$48,$BA,$76,$C7,$08,$B9
	db $C6,$C6,$B9,$C7,$B0,$B9,$C6,$C6
	db $B9,$C7,$B0,$B9,$C6,$C6,$B9,$C7
	db $B0,$B9,$C6,$C6,$B9,$C7,$B0,$DA
	db $05,$DB,$0F,$01,$C7,$08,$49,$B5
	db $C6,$C6,$B5,$C7,$B5,$B5,$C6,$C6
	db $B5,$C7,$B5,$B5,$C6,$C6,$B5,$C7
	db $B5,$B5,$C6,$C6,$B5,$C7,$B5,$B5
	db $C6,$C6,$B5,$C7,$B5,$B5,$C6,$C6
	db $B5,$C7,$B5,$B5,$C6,$C6,$B5,$C7
	db $B5,$B5,$C6,$C6,$B5,$C7,$B5,$01
	db $C7,$48,$B7,$77,$C7,$08,$B5,$C6
	db $C6,$B5,$C7,$B5,$B5,$C6,$C6,$B5
	db $C7,$B5,$B5,$C6,$C6,$B5,$C7,$B5
	db $B5,$C6,$C6,$B5,$C7,$B5,$DA,$07
	db $DB,$0A,$30,$5C,$AD,$24,$A9,$0C
	db $A4,$A6,$18,$A9,$30,$A9,$0C,$AB
	db $AD,$A9,$18,$A4,$24,$A6,$60,$A9
	db $0C,$A6,$18,$B0,$B2,$B0,$B2,$24
	db $B0,$0C,$A4,$AE,$AD,$AB,$C6,$60
	db $A9,$C7,$DA,$04,$DB,$0A,$18,$4B
	db $91,$C7,$91,$C7,$8F,$C7,$8F,$C7
	db $8E,$C7,$8E,$C7,$8D,$C7,$8D,$C7
	db $8C,$C7,$C7,$C7,$C7,$C7,$8E,$90
	db $91,$C7,$8C,$C7,$91,$C7,$91,$C7
	db $F0,$DA,$01,$E2,$32,$DB,$0A,$DE
	db $23,$12,$40,$48,$7E,$BE,$30,$BA
	db $18,$B5,$24,$B4,$0C,$B4,$06,$B5
	db $B6,$48,$B7,$00,$DA,$01,$DB,$8A
	db $06,$7B,$C7,$48,$BE,$30,$BA,$18
	db $B5,$24,$B4,$0C,$B4,$06,$B5,$B6
	db $3C,$B7,$0C,$C7,$DA,$01,$DB,$0A
	db $DE,$23,$12,$40,$48,$6E,$9F,$30
	db $9F,$18,$9F,$24,$8C,$0C,$8C,$06
	db $8E,$8F,$48,$90,$00,$DA,$01,$DB
	db $8A,$DE,$23,$12,$40,$06,$6B,$C7
	db $48,$9F,$30,$9F,$18,$9F,$24,$8C
	db $0C,$8C,$06,$8E,$8F,$48,$90,$00
	db $DA,$01,$DB,$0A,$48,$6E,$B5,$30
	db $B2,$18,$AE,$24,$AB,$0C,$AB,$06
	db $AD,$AD,$48,$AE,$DA,$01,$DB,$A0
	db $06,$6E,$C7,$48,$B5,$30,$B2,$18
	db $AE,$24,$AB,$0C,$AB,$06,$AD,$AD
	db $48,$AE,$DA,$01,$DB,$0A,$DE,$23
	db $12,$40,$48,$3E,$91,$8E,$93,$8C
	db $91,$8E,$93,$18,$8C,$8E,$90,$00
	db $DA,$03,$DB,$0A,$DE,$23,$12,$40
	db $48,$79,$C7,$06,$B0,$B2,$B5,$B9
	db $30,$BC,$48,$C7,$06,$B2,$B5,$B7
	db $BA,$30,$BE,$48,$C7,$06,$B0,$B2
	db $B5,$B9,$30,$BC,$48,$C7,$06,$B4
	db $B7,$BA,$BE,$24,$C0,$0C,$2E,$C7
	db $DA,$01,$DB,$0A,$18,$4D,$C7,$A4
	db $A4,$C7,$A4,$A4,$C7,$A6,$A6,$C7
	db $A5,$A5,$C7,$A4,$A4,$C7,$A4,$A4
	db $C7,$A6,$A6,$C7,$A5,$A5,$DA,$01
	db $DB,$0A,$18,$4D,$C7,$A1,$A1,$C7
	db $A1,$A1,$C7,$A2,$A2,$C7,$A2,$A2
	db $C7,$A1,$A1,$C7,$A1,$A1,$C7,$A2
	db $A2,$C7,$A2,$A2,$DA,$0C,$DB,$0A
	db $18,$6D,$C7,$0C,$B0,$B0,$18,$B0
	db $C7,$AD,$B2,$C7,$0C,$B0,$B0,$18
	db $B0,$C7,$AD,$B2,$C7,$0C,$B0,$B0
	db $18,$B0,$C7,$AD,$B2,$C7,$0C,$B0
	db $B0,$18,$B0,$C7,$AD,$B2,$DA,$01
	db $DB,$0A,$DE,$23,$12,$40,$12,$7B
	db $C7,$48,$B9,$30,$B5,$18,$B0,$30
	db $B2,$18,$B5,$48,$B5,$30,$B0,$18
	db $B5,$30,$B5,$18,$BC,$48,$B9,$B7
	db $48,$6E,$B9,$30,$B5,$18,$B0,$30
	db $B2,$18,$B5,$48,$B5,$30,$B0,$18
	db $B5,$30,$B5,$18,$BC,$48,$B9,$B7
	db $00,$DA,$01,$DB,$0F,$DE,$23,$12
	db $40,$48,$7C,$A4,$A5,$A6,$A5,$A4
	db $A3,$A2,$A8,$DA,$02,$DB,$0A,$48
	db $6C,$B9,$30,$B5,$18,$B0,$30,$B2
	db $18,$B5,$48,$B5,$30,$B0,$18,$B5
	db $30,$B5,$18,$BC,$48,$B9,$B7,$DA
	db $01,$DB,$0A,$DE,$23,$12,$40,$48
	db $3E,$91,$95,$96,$97,$95,$94,$93
	db $18,$8C,$8E,$90,$DA,$01,$DB,$0A
	db $18,$4D,$C7,$A4,$A4,$C7,$A4,$A4
	db $C7,$A6,$A6,$C7,$A6,$A6,$C7,$A8
	db $A8,$C7,$A7,$A7,$C7,$A6,$A6,$C7
	db $A8,$A8,$DA,$01,$DB,$0A,$18,$4D
	db $C7,$A1,$A1,$C7,$A1,$A1,$C7,$A2
	db $A2,$C7,$A3,$A3,$C7,$A4,$A4,$C7
	db $A4,$A4,$C7,$A2,$A2,$C7,$A4,$A4
	db $12,$7B,$C7,$48,$B9,$30,$B5,$18
	db $B0,$30,$B2,$18,$B5,$48,$B5,$30
	db $B0,$18,$B5,$BA,$B9,$B7,$48,$B5
	db $C7,$00,$DA,$01,$48,$7B,$A4,$A5
	db $A6,$A5,$A4,$A2,$A1,$C6,$00,$DA
	db $01,$48,$7B,$A4,$A5,$A6,$A5,$A4
	db $A8,$A9,$C6,$00,$DA,$02,$DB,$0A
	db $48,$6C,$B9,$30,$B5,$18,$B0,$30
	db $B2,$18,$B5,$48,$B5,$30,$B0,$18
	db $B5,$BA,$B9,$B7,$48,$B5,$C7,$00
	db $DA,$01,$DB,$0A,$48,$3E,$91,$95
	db $96,$97,$93,$98,$18,$91,$98,$95
	db $48,$91,$00,$DA,$0C,$DB,$0A,$18
	db $6D,$C7,$0C,$B0,$B0,$18,$B0,$C7
	db $AD,$B2,$C7,$0C,$B0,$B0,$18,$B0
	db $C7,$AD,$B2,$C7,$0C,$B0,$B0,$18
	db $B0,$C7,$AD,$B2,$AD,$B0,$B0,$AD
	db $C7,$C7,$DA,$01,$DB,$0A,$18,$4D
	db $C7,$A4,$A4,$C7,$A4,$A4,$C7,$A6
	db $A6,$C7,$A6,$A6,$C7,$A6,$A6,$C7
	db $A4,$A4,$C7,$A4,$A4,$C7,$A4,$A4
	db $00,$DA,$01,$DB,$0A,$18,$4D,$C7
	db $A1,$A1,$C7,$A1,$A1,$C7,$A2,$A2
	db $C7,$A3,$A3,$C7,$A2,$A2,$C7,$A2
	db $A2,$C7,$A1,$A1,$C7,$A1,$A1,$00
	db $12,$7B,$C7,$DA,$01,$48,$B9,$30
	db $B5,$18,$B0,$48,$B9,$B5,$00,$DA
	db $00,$60,$67,$B0,$0C,$B1,$B2,$B5
	db $B9,$48,$BC,$B9,$00,$DA,$01,$48
	db $3E,$96,$96,$95,$95,$00,$DA,$01
	db $18,$4D,$C7,$A9,$A9,$C7,$A9,$A9
	db $C7,$A9,$A9,$C7,$A9,$A9,$00,$DA
	db $01,$DB,$0A,$18,$4D,$C7,$A6,$A6
	db $C7,$A6,$A6,$C7,$A4,$A4,$C7,$A4
	db $A4,$C7,$00,$DA,$0C,$DB,$0A,$18
	db $6D,$C7,$B2,$B2,$C7,$B2,$AD,$C7
	db $B2,$B2,$C7,$AD,$B2,$C7,$B2,$B2
	db $C7,$B2,$AD,$C7,$B2,$B2,$C7,$AD
	db $B2,$12,$C6,$48,$B8,$30,$B5,$18
	db $B8,$48,$B7,$C7,$00,$60,$AF,$0C
	db $B0,$B2,$B5,$B8,$48,$BA,$B7,$00
	db $48,$94,$94,$93,$18,$8C,$8E,$90
	db $00,$18,$C7,$A9,$A9,$C7,$A9,$A9
	db $C7,$A9,$A9,$C7,$A8,$A8,$00,$18
	db $C7,$A3,$A3,$C7,$A3,$A3,$C7,$A2
	db $A2,$C7,$A4,$A4,$C7,$00,$12,$C6
	db $48,$B8,$30,$B5,$18,$B0,$48,$BC
	db $C6,$00,$60,$AF,$0C,$B0,$B1,$B2
	db $B5,$48,$B9,$B7,$00
.end
	
	dw $0000				;		| Stop uploading data
	dw $0500				;		|

unused_0EF0DB:
	db $E0,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF
	