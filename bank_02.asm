ORG $028000

DATA_028000:
	db $80,$40,$20,$10,$08,$04,$02,$01

CODE_028008:
	PHX
	LDA.w $0DC2				;$028009	|
	BEQ CODE_028070				;$02800C	|
	STZ.w $0DC2				;$02800E	|
	PHA					;$028011	|
	LDA.b #$0C				;$028012	|
	STA.w $1DFC				;$028014	|
	LDX.b #$0B				;$028017	|
CODE_028019:
	LDA.w $14C8,X
	BEQ CODE_028042				;$02801C	|
	DEX					;$02801E	|
	BPL CODE_028019				;$02801F	|
	DEC.w $1861				;$028021	|
	BPL ADDR_02802B				;$028024	|
	LDA.b #$01				;$028026	|
	STA.w $1861				;$028028	|
ADDR_02802B:
	LDA.w $1861
	CLC					;$02802E	|
	ADC.b #$0A				;$02802F	|
	TAX					;$028031	|
	LDA $9E,X				;$028032	|
	CMP.b #$7D				;$028034	|
	BNE CODE_028042				;$028036	|
	LDA.w $14C8,X				;$028038	|
	CMP.b #$0B				;$02803B	|
	BNE CODE_028042				;$02803D	|
	STZ.w $13F3				;$02803F	|
CODE_028042:
	LDA.b #$08
	STA.w $14C8,X				;$028044	|
	PLA					;$028047	|
	CLC					;$028048	|
	ADC.b #$73				;$028049	|
	STA $9E,X				;$02804B	|
	JSL InitSpriteTables			;$02804D	|
	LDA.b #$78				;$028051	|
	CLC					;$028053	|
	ADC $1A					;$028054	|
	STA $E4,X				;$028056	|
	LDA $1B					;$028058	|
	ADC.b #$00				;$02805A	|
	STA.w $14E0,X				;$02805C	|
	LDA.b #$20				;$02805F	|
	CLC					;$028061	|
	ADC $1C					;$028062	|
	STA $D8,X				;$028064	|
	LDA $1D					;$028066	|
	ADC.b #$00				;$028068	|
	STA.w $14D4,X				;$02806A	|
	INC.w $1534,X				;$02806D	|
CODE_028070:
	PLX
	RTL					;$028071	|

BombExplosionX:
	db $00,$08,$06,$FA,$F8,$06,$08,$00
	db $F8,$FA

BombExplosionY:
	db $F8,$FE,$06,$06,$FE,$FA,$02,$08
	db $02,$FA

ExplodeBombRt:
	JSR ExplodeBombSubRt	
	RTL					;$028089	|

ExplodeBombSubRt:
	STZ.w $1656,X
	LDA.b #$11				;$02808D	|
	STA.w $1662,X				;$02808F	|
	JSR GetDrawInfo2			;$028092	|
	LDA $9D					;$028095	|
	BNE CODE_02809C				;$028097	|
	INC.w $1570,X				;$028099	|
CODE_02809C:
	LDA.w $1540,X
	BNE ExplodeBombGfx			;$02809F	|
	STZ.w $14C8,X				;$0280A1	|
	RTS					;$0280A4	|

ExplodeBombGfx:
	LDA.w $1540,X
	LSR					;$0280A8	|
	AND.b #$03				;$0280A9	|
	CMP.b #$03				;$0280AB	|
	BNE CODE_0280C0				;$0280AD	|
	JSR ExplodeSprites			;$0280AF	|
	LDA.w $1540,X				;$0280B2	|
	SEC					;$0280B5	|
	SBC.b #$10				;$0280B6	|
	CMP.b #$20				;$0280B8	|
	BCS CODE_0280C0				;$0280BA	|
	JSL MarioSprInteract			;$0280BC	|
CODE_0280C0:
	LDY.b #$04
	STY $0F					;$0280C2	|
CODE_0280C4:
	LDA.w $1540,X
	LSR					;$0280C7	|
	PHA					;$0280C8	|
	AND.b #$03				;$0280C9	|
	STA $02					;$0280CB	|
	LDA $E4,X				;$0280CD	|
	SEC					;$0280CF	|
	SBC $1A					;$0280D0	|
	CLC					;$0280D2	|
	ADC.b #$04				;$0280D3	|
	STA $00					;$0280D5	|
	LDA $D8,X				;$0280D7	|
	SEC					;$0280D9	|
	SBC $1C					;$0280DA	|
	CLC					;$0280DC	|
	ADC.b #$04				;$0280DD	|
	STA $01					;$0280DF	|
	LDY $0F					;$0280E1	|
	PLA					;$0280E3	|
	AND.b #$04				;$0280E4	|
	BEQ CODE_0280ED				;$0280E6	|
	TYA					;$0280E8	|
	CLC					;$0280E9	|
	ADC.b #$05				;$0280EA	|
	TAY					;$0280EC	|
CODE_0280ED:
	LDA $00
	CLC					;$0280EF	|
	ADC.w BombExplosionX,Y			;$0280F0	|
	STA $00					;$0280F3	|
	LDA $01					;$0280F5	|
	CLC					;$0280F7	|
	ADC.w BombExplosionY,Y			;$0280F8	|
	STA $01					;$0280FB	|
	DEC $02					;$0280FD	|
	BPL CODE_0280ED				;$0280FF	|
	LDA $0F					;$028101	|
	ASL					;$028103	|
	ASL					;$028104	|
	ADC.w $15EA,X				;$028105	|
	TAY					;$028108	|
	LDA $00					;$028109	|
	STA.w $0300,Y				;$02810B	|
	LDA $01					;$02810E	|
	STA.w $0301,Y				;$028110	|
	LDA.b #$BC				;$028113	|
	STA.w $0302,Y				;$028115	|
	LDA $13					;$028118	|
	LSR					;$02811A	|
	LSR					;$02811B	|
	AND.b #$03				;$02811C	|
	SEC					;$02811E	|
	ROL					;$02811F	|
	ORA $64					;$028120	|
	STA.w $0303,Y				;$028122	|
	TYA					;$028125	|
	LSR					;$028126	|
	LSR					;$028127	|
	TAY					;$028128	|
	LDA.b #$00				;$028129	|
	STA.w $0460,Y				;$02812B	|
	DEC $0F					;$02812E	|
	BPL CODE_0280C4				;$028130	|
	LDY.b #$00				;$028132	|
	LDA.b #$04				;$028134	|
	JMP CODE_02B7A7				;$028136	|

ExplodeSprites:
	LDY.b #$09
ExplodeLoopStart:
	CPY.w $15E9
	BEQ CODE_02814C				;$02813E	|
	PHY					;$028140	|
	LDA.w $14C8,Y				;$028141	|
	CMP.b #$08				;$028144	|
	BCC CODE_02814B				;$028146	|
	JSR ExplodeKillSpr			;$028148	|
CODE_02814B:
	PLY
CODE_02814C:
	DEY
	BPL ExplodeLoopStart			;$02814D	|
	RTS					;$02814F	|

ExplodeKillSpr:
	PHX
	TYX					;$028151	|
	JSL GetSpriteClippingB			;$028152	|
	PLX					;$028156	|
	JSL GetSpriteClippingA			;$028157	|
	JSL CheckForContact			;$02815B	|
	BCC Return028177			;$02815F	|
	LDA.w $167A,Y				;$028161	|
	AND.b #$02				;$028164	|
	BNE Return028177			;$028166	|
	LDA.b #$02				;$028168	|
	STA.w $14C8,Y				;$02816A	|
	LDA.b #$C0				;$02816D	|
	STA.w $00AA,y				;$02816F	|
	LDA.b #$00				;$028172	|
	STA.w $00B6,y				;$028174	|
Return028177:
	RTS

DATA_028178:
	db $F8,$38,$78,$B8,$00,$10,$20,$D0
	db $E0,$10,$40,$80,$C0,$10,$10,$20
	db $B0,$20,$50,$60,$C0,$F0,$80,$B0
	db $20,$60,$A0,$E0,$70,$F0,$70,$B0
	db $F0,$10,$20,$50,$60,$90,$A0,$D0
	db $E0,$10,$20,$50,$60,$90,$A0,$D0
	db $E0,$10,$20,$50,$60,$90,$A0,$D0
	db $E0,$50,$60,$C0,$D0,$30,$40,$70
	db $80,$B0,$C0,$30,$40,$70,$80,$B0
	db $C0,$40,$50,$80,$90,$C8,$D8,$30
	db $40,$A0,$B0,$58,$68,$B0,$C0

DATA_0281CF:
	db $70,$70,$70,$70,$20,$20,$20,$20
	db $20,$30,$30,$30,$30,$70,$80,$80
	db $80,$90,$90,$90,$A0,$50,$60,$60
	db $70,$70,$70,$70,$60,$60,$70,$70
	db $70,$40,$40,$40,$40,$40,$40,$40
	db $40,$50,$50,$50,$50,$50,$50,$50
	db $50,$60,$60,$60,$60,$60,$60,$60
	db $60,$30,$30,$30,$30,$48,$48,$48
	db $48,$48,$48,$58,$58,$58,$58,$58
	db $58,$70,$70,$78,$78,$70,$70,$80
	db $80,$88,$88,$A0,$A0,$A0,$A0

DATA_028226:
	db $E8,$E8,$E8,$E8,$E4,$E4,$E4,$E4
	db $E4,$E4,$E4,$E4,$E4,$E4,$E4,$E4
	db $E4,$E4,$E4,$E4,$E4,$E4,$E4,$E4
	db $E4,$E4,$E4,$E4,$EE,$EE,$EE,$EE
	db $EE,$C0,$C2,$C0,$C2,$C0,$C2,$C0
	db $C2,$E0,$E2,$E0,$E2,$E0,$E2,$E0
	db $E2,$C4,$A4,$C4,$A4,$C4,$A4,$C4
	db $A4,$CC,$CE,$CC,$CE,$C8,$CA,$C8
	db $CA,$C8,$CA,$CA,$C8,$CA,$C8,$CA
	db $C8,$CC,$CE,$CC,$CE,$CC,$CE,$CC
	db $CE,$CC,$CE,$CC,$CE,$CC,$CE

CODE_02827D:
	LDA $1A
	STA.w $188D				;$02827F	|
	EOR.b #$FF				;$028282	|
	INC A					;$028284	|
	STA $05					;$028285	|
	LDA $1B					;$028287	|
	LSR					;$028289	|
	ROR.w $188D				;$02828A	|
	PHA					;$02828D	|
	LDA.w $188D				;$02828E	|
	EOR.b #$FF				;$028291	|
	INC A					;$028293	|
	STA $06					;$028294	|
	PLA					;$028296	|
	LSR					;$028297	|
	ROR.w $188D				;$028298	|
	LDA.w $188D				;$02829B	|
	EOR.b #$FF				;$02829E	|
	INC A					;$0282A0	|
	STA.w $188D				;$0282A1	|
	REP #$10				;$0282A4	|
	LDY.w #$0164				;$0282A6	|
	LDA.b #$66				;$0282A9	|
	STY $03					;$0282AB	|
	LDA.b #$F0				;$0282AD	|
CODE_0282AF:
	STA.w $020D,Y
	INY					;$0282B2	|
	INY					;$0282B3	|
	INY					;$0282B4	|
	INY					;$0282B5	|
	CPY.w #$018C				;$0282B6	|
	BCC CODE_0282AF				;$0282B9	|
	LDX.w #$0000				;$0282BB	|
	STX $0C					;$0282BE	|
	LDX.w #$0038				;$0282C0	|
	LDY.w #$00E0				;$0282C3	|
	LDA.w $1884				;$0282C6	|
	CMP.b #$01				;$0282C9	|
	BNE CODE_0282D8				;$0282CB	|
	LDX.w #$0039				;$0282CD	|
	STX $0C					;$0282D0	|
	LDX.w #$001D				;$0282D2	|
	LDY.w #$00FC				;$0282D5	|
CODE_0282D8:
	STX $00
	REP #$20				;$0282DA	|
	TXA					;$0282DC	|
	CLC					;$0282DD	|
	ADC $0C					;$0282DE	|
	STA $0A					;$0282E0	|
	SEP #$20				;$0282E2	|
	LDA $06					;$0282E4	|
	CLC					;$0282E6	|
	LDX $0A					;$0282E7	|
	ADC.l DATA_028178,X			;$0282E9	|
	STA.w $020C,Y				;$0282ED	|
	STA $02					;$0282F0	|
	LDA.w $1888				;$0282F2	|
	STA $07					;$0282F5	|
	ASL					;$0282F7	|
	ROR $07					;$0282F8	|
	LDA.l DATA_0281CF,X			;$0282FA	|
	DEC A					;$0282FE	|
	SEC					;$0282FF	|
	SBC $07					;$028300	|
	STA.w $020D,Y				;$028302	|
	LDX $0A					;$028305	|
	LDA.w $188C				;$028307	|
	BNE CODE_028318				;$02830A	|
	LDA.l DATA_028226,X			;$02830C	|
	STA.w $020E,Y				;$028310	|
	LDA.b #$0D				;$028313	|
	STA.w $020F,Y				;$028315	|
CODE_028318:
	REP #$20
	PHY					;$02831A	|
	TYA					;$02831B	|
	LSR					;$02831C	|
	LSR					;$02831D	|
	TAY					;$02831E	|
	SEP #$20				;$02831F	|
	LDA.b #$02				;$028321	|
	STA.w $0423,Y				;$028323	|
	LDA $02					;$028326	|
	CMP.b #$F0				;$028328	|
	BCC CODE_028367				;$02832A	|
	LDA.w $1884				;$02832C	|
	CMP.b #$01				;$02832F	|
	BEQ CODE_028367				;$028331	|
	PLY					;$028333	|
	PHY					;$028334	|
	LDX $03					;$028335	|
	LDA.w $020C,Y				;$028337	|
	STA.w $020C,X				;$02833A	|
	LDA.w $020D,Y				;$02833D	|
	STA.w $020D,X				;$028340	|
	LDA.w $020E,Y				;$028343	|
	STA.w $020E,X				;$028346	|
	LDA.w $020F,Y				;$028349	|
	STA.w $020F,X				;$02834C	|
	REP #$20				;$02834F	|
	TXA					;$028351	|
	LSR					;$028352	|
	LSR					;$028353	|
	TAY					;$028354	|
	SEP #$20				;$028355	|
	LDA.b #$03				;$028357	|
	STA.w $0423,Y				;$028359	|
	LDA $03					;$02835C	|
	CLC					;$02835E	|
	ADC.b #$04				;$02835F	|
	STA $03					;$028361	|
	BCC CODE_028367				;$028363	|
	INC $04					;$028365	|
CODE_028367:
	PLY
	LDX $00					;$028368	|
	DEY					;$02836A	|
	DEY					;$02836B	|
	DEY					;$02836C	|
	DEY					;$02836D	|
	DEX					;$02836E	|
	BMI CODE_028374				;$02836F	|
	JMP CODE_0282D8				;$028371	|

CODE_028374:
	SEP #$10
	LDA.b #$01				;$028376	|
	STA.w $188C				;$028378	|
	LDA.w $1884				;$02837B	|
	CMP.b #$01				;$02837E	|
	BNE CODE_028398				;$028380	|
	LDA.b #$CD				;$028382	|
	STA.w $02BF				;$028384	|
	STA.w $02C3				;$028387	|
	STA.w $02C7				;$02838A	|
	STA.w $02CB				;$02838D	|
	STA.w $02CF				;$028390	|
	STA.w $02D3				;$028393	|
	BRA CODE_0283C4				;$028396	|

CODE_028398:
	LDA $14
	AND.b #$03				;$02839A	|
	BNE CODE_0283C4				;$02839C	|
	STZ $00					;$02839E	|
CODE_0283A0:
	LDX $00
	LDA.l DATA_0283C8,X			;$0283A2	|
	TAY					;$0283A6	|
	JSL GetRand				;$0283A7	|
	AND.b #$01				;$0283AB	|
	BNE CODE_0283B7				;$0283AD	|
	LDA.w $020E,Y				;$0283AF	|
	EOR.b #$02				;$0283B2	|
	STA.w $020E,Y				;$0283B4	|
CODE_0283B7:
	LDA.b #$09
	STA.w $020F,Y				;$0283B9	|
	INC $00					;$0283BC	|
	LDA $00					;$0283BE	|
	CMP.b #$04				;$0283C0	|
	BNE CODE_0283A0				;$0283C2	|
CODE_0283C4:
	JSR CODE_0283CE
	RTL					;$0283C7	|

DATA_0283C8:
	db $00,$04,$08,$0C

DATA_0283CC:
	db $0C,$30

CODE_0283CE:
	LDA.w $153D
	SEC					;$0283D1	|
	SBC.b #$1E				;$0283D2	|
	STA $0C					;$0283D4	|
	LDA.w $1617				;$0283D6	|
	CLC					;$0283D9	|
	ADC.b #$10				;$0283DA	|
	STA $0D					;$0283DC	|
	LDX.b #$01				;$0283DE	|
CODE_0283E0:
	STX $0F
	LDA.w $18A8,X				;$0283E2	|
	BEQ CODE_0283F4				;$0283E5	|
	BMI CODE_0283F1				;$0283E7	|
	STA.w $13FB				;$0283E9	|
	STA $9D					;$0283EC	|
	JSR CODE_0283F8				;$0283EE	|
CODE_0283F1:
	JSR CODE_028439
CODE_0283F4:
	DEX
	BPL CODE_0283E0				;$0283F5	|
	RTS					;$0283F7	|

CODE_0283F8:
	LDA.w $18AA,X
	LSR					;$0283FB	|
	LSR					;$0283FC	|
	LSR					;$0283FD	|
	LSR					;$0283FE	|
	LSR					;$0283FF	|
	SEC					;$028400	|
	ADC.w $18AA,X				;$028401	|
	CMP.b #$B0				;$028404	|
	BCC CODE_028435				;$028406	|
	ASL.w $18A8,X				;$028408	|
	SEC					;$02840B	|
	ROR.w $18A8,X				;$02840C	|
	LDA.b #$30				;$02840F	|
	STA.w $1887				;$028411	|
	LDA.b #$09				;$028414	|
	STA.w $1DFC				;$028416	|
	CPX.b #$00				;$028419	|
	BNE CODE_02842A				;$02841B	|
	LDA.w $18A9				;$02841D	|
	BNE CODE_02842A				;$028420	|
	INC.w $18A9				;$028422	|
	STZ.w $18AB				;$028425	|
	BRA CODE_028433				;$028428	|

CODE_02842A:
	CPX.b #$01
	BNE CODE_028433				;$02842C	|
	STZ $9D					;$02842E	|
	STZ.w $13FB				;$028430	|
CODE_028433:
	LDA.b #$B0
CODE_028435:
	STA.w $18AA,X
	RTS					;$028438	|

CODE_028439:
	LDA.l DATA_0283CC,X
	TAY					;$02843D	|
	STZ $00					;$02843E	|
CODE_028440:
	LDA.b #$F0
	STA.w $0201,Y				;$028442	|
	LDA.w $18AA,X				;$028445	|
	SEC					;$028448	|
	SBC $1C					;$028449	|
	SEC					;$02844B	|
	SBC.w $1888				;$02844C	|
	SEC					;$02844F	|
	SBC $00					;$028450	|
	CMP.b #$20				;$028452	|
	BCC Return02848C			;$028454	|
	CMP.b #$A4				;$028456	|
	BCS CODE_02845D				;$028458	|
	STA.w $0201,Y				;$02845A	|
CODE_02845D:
	LDA $0C,X
	STA.w $0200,Y				;$02845F	|
	LDA.b #$E6				;$028462	|
	LDX $00					;$028464	|
	BEQ CODE_02846A				;$028466	|
	LDA.b #$08				;$028468	|
CODE_02846A:
	STA.w $0202,Y
	LDA.b #$0D				;$02846D	|
	STA.w $0203,Y				;$02846F	|
	TYA					;$028472	|
	LSR					;$028473	|
	LSR					;$028474	|
	TAX					;$028475	|
	LDA.b #$02				;$028476	|
	STA.w $0420,X				;$028478	|
	LDX $0F					;$02847B	|
	INY					;$02847D	|
	INY					;$02847E	|
	INY					;$02847F	|
	INY					;$028480	|
	LDA $00					;$028481	|
	CLC					;$028483	|
	ADC.b #$10				;$028484	|
	STA $00					;$028486	|
	CMP.b #$90				;$028488	|
	BCC CODE_028440				;$02848A	|
Return02848C:
	RTS

SubHorzPosBnk2:
	LDY.b #$00
	LDA $94					;$02848F	|
	SEC					;$028491	|
	SBC $E4,X				;$028492	|
	STA $0F					;$028494	|
	LDA $95					;$028496	|
	SBC.w $14E0,X				;$028498	|
	BPL Return02849E			;$02849B	|
	INY					;$02849D	|
Return02849E:
	RTS

IsOffScreenBnk2:
	LDA.w $15A0,X
	ORA.w $186C,X				;$0284A2	|
	RTS					;$0284A5	|

CODE_0284A6:
	STA $03
	LDA.b #$02				;$0284A8	|
	STA $01					;$0284AA	|
CODE_0284AC:
	JSL CODE_0284D8
	LDA $02					;$0284B0	|
	CLC					;$0284B2	|
	ADC $03					;$0284B3	|
	STA $02					;$0284B5	|
	DEC $01					;$0284B7	|
	BPL CODE_0284AC				;$0284B9	|
	RTL					;$0284BB	|

CODE_0284BC:
	LDA.b #$12
	BRA CODE_0284C2				;$0284BE	|

CODE_0284C0:
	LDA.b #$00
CODE_0284C2:
	STA $00
	STZ $02					;$0284C4	|
	LDA $9E,X				;$0284C6	|
	CMP.b #$41				;$0284C8	|
	BEQ CODE_0284D0				;$0284CA	|
	CMP.b #$42				;$0284CC	|
	BNE CODE_0284D8				;$0284CE	|
CODE_0284D0:
	LDA $AA,X
	BPL Return0284E7			;$0284D2	|
	LDA.b #$0A				;$0284D4	|
	BRA CODE_0284A6				;$0284D6	|

CODE_0284D8:
	JSR IsOffScreenBnk2
	BNE Return0284E7			;$0284DB	|
	LDY.b #$0B				;$0284DD	|
CODE_0284DF:
	LDA.w $17F0,Y
	BEQ CODE_0284E8				;$0284E2	|
	DEY					;$0284E4	|
	BPL CODE_0284DF				;$0284E5	|
Return0284E7:
	RTL

CODE_0284E8:
	LDA $D8,X
	CLC					;$0284EA	|
	ADC.b #$00				;$0284EB	|
	AND.b #$F0				;$0284ED	|
	CLC					;$0284EF	|
	ADC.b #$03				;$0284F0	|
	STA.w $17FC,Y				;$0284F2	|
	LDA $E4,X				;$0284F5	|
	CLC					;$0284F7	|
	ADC $02					;$0284F8	|
	STA.w $1808,Y				;$0284FA	|
	LDA.w $14E0,X				;$0284FD	|
	ADC.b #$00				;$028500	|
	STA.w $18EA,Y				;$028502	|
	LDA.b #$07				;$028505	|
	STA.w $17F0,Y				;$028507	|
	LDA $00					;$02850A	|
	STA.w $1850,Y				;$02850C	|
	RTL					;$02850F	|

DATA_028510:
	db $04,$FC,$06,$FA,$08,$F8,$0A,$F6
DATA_028518:
	db $E0,$E1,$E2,$E3,$E4,$E6,$E8,$EA
DATA_028520:
	db $1F,$13,$10,$1C,$17,$1A,$0F,$1E

CODE_028528:
	JSR IsOffScreenBnk2
	LDA.w $186C,X				;$02852B	|
	BNE Return0284E7			;$02852E	|
	LDA.b #$04				;$028530	|
	STA $00					;$028532	|
	LDY.b #$07				;$028534	|
CODE_028536:
	LDA.w $170B,Y
	BEQ CODE_02853F				;$028539	|
	DEY					;$02853B	|
	BPL CODE_028536				;$02853C	|
	RTL					;$02853E	|

CODE_02853F:
	LDA.b #$07
	STA.w $170B,Y				;$028541	|
	LDA $D8,X				;$028544	|
	STA.w $1715,Y				;$028546	|
	LDA.w $14D4,X				;$028549	|
	STA.w $1729,Y				;$02854C	|
	LDA $E4,X				;$02854F	|
	CLC					;$028551	|
	ADC.b #$04				;$028552	|
	STA.w $171F,Y				;$028554	|
	LDA.w $14E0,X				;$028557	|
	ADC.b #$00				;$02855A	|
	STA.w $1733,Y				;$02855C	|
	JSL GetRand				;$02855F	|
	PHX					;$028563	|
	AND.b #$07				;$028564	|
	TAX					;$028566	|
	LDA.l DATA_028510,X			;$028567	|
	STA.w $1747,Y				;$02856B	|
	LDA.w $148E				;$02856E	|
	AND.b #$07				;$028571	|
	TAX					;$028573	|
	LDA.l DATA_028518,X			;$028574	|
	STA.w $173D,Y				;$028578	|
	JSL GetRand				;$02857B	|
	AND.b #$07				;$02857F	|
	TAX					;$028581	|
	LDA.l DATA_028520,X			;$028582	|
	STA.w $176F,Y				;$028586	|
	PLX					;$028589	|
	DEC $00					;$02858A	|
	BPL CODE_028536				;$02858C	|
	RTL					;$02858E	|

CODE_02858F:
	LDY.b #$1F
	LDX.b #$00				;$028591	|
	LDA $19					;$028593	|
	BNE CODE_02859B				;$028595	|
	LDY.b #$0F				;$028597	|
	LDX.b #$10				;$028599	|
CODE_02859B:
	STX $01
	JSL GetRand				;$02859D	|
	TYA					;$0285A1	|
	AND.w $148D				;$0285A2	|
	CLC					;$0285A5	|
	ADC $01					;$0285A6	|
	CLC					;$0285A8	|
	ADC $96					;$0285A9	|
	STA $00					;$0285AB	|
	LDA.w $148E				;$0285AD	|
	AND.b #$0F				;$0285B0	|
	CLC					;$0285B2	|
	ADC.b #$FE				;$0285B3	|
	CLC					;$0285B5	|
	ADC $94					;$0285B6	|
	STA $02					;$0285B8	|
CODE_0285BA:
	LDY.b #$0B
CODE_0285BC:
	LDA.w $17F0,Y
	BEQ CODE_0285C5				;$0285BF	|
	DEY					;$0285C1	|
	BPL CODE_0285BC				;$0285C2	|
	RTL					;$0285C4	|

CODE_0285C5:
	LDA.b #$05
	STA.w $17F0,Y				;$0285C7	|
	LDA.b #$00				;$0285CA	|
	STA.w $1820,Y				;$0285CC	|
	LDA $00					;$0285CF	|
	STA.w $17FC,Y				;$0285D1	|
	LDA $02					;$0285D4	|
	STA.w $1808,Y				;$0285D6	|
	LDA.b #$17				;$0285D9	|
	STA.w $1850,Y				;$0285DB	|
	RTL					;$0285DE	|

CODE_0285DF:
	JSR IsOffScreenBnk2
	BNE Return0285EE			;$0285E2	|
	LDY.b #$0B				;$0285E4	|
CODE_0285E6:
	LDA.w $17F0,Y
	BEQ CODE_0285EF				;$0285E9	|
	DEY					;$0285EB	|
	BPL CODE_0285E6				;$0285EC	|
Return0285EE:
	RTL

CODE_0285EF:
	JSL GetRand
	LDA.b #$04				;$0285F3	|
	STA.w $17F0,Y				;$0285F5	|
	LDA.b #$00				;$0285F8	|
	STA.w $1820,Y				;$0285FA	|
	LDA.w $148D				;$0285FD	|
	AND.b #$0F				;$028600	|
	SEC					;$028602	|
	SBC.b #$03				;$028603	|
	CLC					;$028605	|
	ADC $E4,X				;$028606	|
	STA.w $1808,Y				;$028608	|
	LDA.w $14E0,X				;$02860B	|
	ADC.b #$00				;$02860E	|
	STA.w $18EA,Y				;$028610	|
	LDA.w $148E				;$028613	|
	AND.b #$07				;$028616	|
	CLC					;$028618	|
	ADC.b #$07				;$028619	|
	CLC					;$02861B	|
	ADC $D8,X				;$02861C	|
	STA.w $17FC,Y				;$02861E	|
	LDA.w $14D4,X				;$028621	|
	ADC.b #$00				;$028624	|
	STA.w $1814,Y				;$028626	|
	LDA.b #$17				;$028629	|
	STA.w $1850,Y				;$02862B	|
	RTL					;$02862E	|

spawn_throw_block:
	JSL FindFreeSprSlot			;$02862F	\ Find a free sprite slot.
	BMI .return				;$028633	 | If unsuccessful, return.
	TYX					;$028635	 | Set X to the sprite slot.
	LDA.b #$0B				;$028636	 |
	STA.w $14C8,X				;$028638	 | Set the throw block as being carried.
	LDA $96					;$02863B	 |\
	STA $D8,X				;$02863D	 | | Set the sprite's Y position to the player's Y position.
	LDA $97					;$02863F	 | |
	STA.w $14D4,X				;$028641	 |/
	LDA $94					;$028644	 |\
	STA $E4,X				;$028646	 | | Set the sprite's X position to the player's X position.
	LDA $95,X				;$028648	 | |
	STA.w $14E0,X				;$02864A	 |/
	LDA.b #$53				;$02864D	 |\ Set the sprite to be a throw block.
	STA $9E,X				;$02864F	 |/
	JSL InitSpriteTables			;$028651	 | Initialize the sprite tables.
	LDA.b #$FF				;$028655	 |\ Set the throw block's disappearance timer.
	STA.w $1540,X				;$028657	 |/
	LDA.b #$08				;$02865A	 |\ Set the time to show the player picking something up.
	STA.w $1498				;$02865C	 |/
	STA.w $148F				;$02865F	 | Mark the player as carrying an object.
.return						;		 |
	RTL					;$028662	/

ShatterBlock:
	PHX					;$028663	|
	STA $00					;$028664	|
	LDY.b #$03				;$028666	|
	LDX.b #$0B				;$028668	|
CODE_02866A:
	LDA.w $17F0,X
	BEQ CODE_02867F				;$02866D	|
CODE_02866F:
	DEX
	BPL CODE_02866A				;$028670	|
	DEC.w $185D				;$028672	|
	BPL CODE_02867C				;$028675	|
	LDA.b #$0B				;$028677	|
	STA.w $185D				;$028679	|
CODE_02867C:
	LDX.w $185D
CODE_02867F:
	LDA.b #$07
	STA.w $1DFC				;$028681	|
	LDA.b #$01				;$028684	|
	STA.w $17F0,X				;$028686	|
	LDA $9A					;$028689	|
	CLC					;$02868B	|
	ADC.w DATA_028746,Y			;$02868C	|
	STA.w $1808,X				;$02868F	|
	LDA $9B					;$028692	|
	ADC.b #$00				;$028694	|
	STA.w $18EA,X				;$028696	|
	LDA $98					;$028699	|
	CLC					;$02869B	|
	ADC.w DATA_028742,Y			;$02869C	|
	STA.w $17FC,X				;$02869F	|
	LDA $99					;$0286A2	|
	ADC.b #$00				;$0286A4	|
	STA.w $1814,X				;$0286A6	|
	LDA.w DATA_02874A,Y			;$0286A9	|
	STA.w $1820,X				;$0286AC	|
	LDA.w DATA_02874E,Y			;$0286AF	|
	STA.w $182C,X				;$0286B2	|
	LDA $00					;$0286B5	|
	STA.w $1850,X				;$0286B7	|
	DEY					;$0286BA	|
	BPL CODE_02866F				;$0286BB	|
	PLX					;$0286BD	|
	RTL					;$0286BE	|

YoshiStompRoutine:
	LDA.w $1697
	BNE Return0286EC			;$0286C2	|
	PHB					;$0286C4	|
	PHK					;$0286C5	|
	PLB					;$0286C6	|
	JSR SprBlkInteract			;$0286C7	|
	LDA.b #$02				;$0286CA	|
	STA.w $16CD,Y				;$0286CC	|
	LDA $94					;$0286CF	|
	STA.w $16D1,Y				;$0286D1	|
	LDA $95					;$0286D4	|
	STA.w $16DD,Y				;$0286D6	|
	LDA $96					;$0286D9	|
	CLC					;$0286DB	|
	ADC.b #$20				;$0286DC	|
	STA.w $16D9,Y				;$0286DE	|
	LDA $97					;$0286E1	|
	ADC.b #$00				;$0286E3	|
	STA.w $16DD,Y				;$0286E5	|
	JSR CODE_029BE4				;$0286E8	|
	PLB					;$0286EB	|
Return0286EC:
	RTL

SprBlkInteract:
	LDY.b #$03
CODE_0286EF:
	LDA.w $16CD,Y
	BEQ CODE_0286F8				;$0286F2	|
	DEY					;$0286F4	|
	BPL CODE_0286EF				;$0286F5	|
	INY					;$0286F7	|
CODE_0286F8:
	LDA $9A
	STA.w $16D1,Y				;$0286FA	|
	LDA $9B					;$0286FD	|
	STA.w $16D5,Y				;$0286FF	|
	LDA $98					;$028702	|
	STA.w $16D9,Y				;$028704	|
	LDA $99					;$028707	|
	STA.w $16DD,Y				;$028709	|
	LDA.w $1933				;$02870C	|
	BEQ CODE_02872F				;$02870F	|
	LDA $9A					;$028711	|
	SEC					;$028713	|
	SBC $26					;$028714	|
	STA.w $16D1,Y				;$028716	|
	LDA $9B					;$028719	|
	SBC $27					;$02871B	|
	STA.w $16D5,Y				;$02871D	|
	LDA $98					;$028720	|
	SEC					;$028722	|
	SBC $28					;$028723	|
	STA.w $16D9,Y				;$028725	|
	LDA $99					;$028728	|
	SBC $29					;$02872A	|
	STA.w $16DD,Y				;$02872C	|
CODE_02872F:
	LDA.b #$01
	STA.w $16CD,Y				;$028731	|
	LDA.b #$06				;$028734	|
	STA.w $18F8,Y				;$028736	|
	RTS					;$028739	|

BlockBounceSpeedY:
	db $C0,$00,$00,$40

BlockBounceSpeedX:
	db $00,$40,$C0,$00

DATA_028742:
	db $00,$00,$08,$08

DATA_028746:
	db $00,$08,$00,$08

DATA_02874A:
	db $FB,$FB,$FD,$FD

DATA_02874E:
	db $FF,$01,$FF,$01

CODE_028752:
	LDA $04
	CMP.b #$07				;$028754	|
	BNE NotBreakable			;$028756	|
BreakTurnBlock:
	LDA.w $0DB3
	ASL					;$02875B	|
	ADC.w $0DB3				;$02875C	|
	TAX					;$02875F	|
	LDA.w $0F34,X				;$028760	|
	CLC					;$028763	|
	ADC.b #$05				;$028764	|
	STA.w $0F34,X				;$028766	|
	BCC CODE_028773				;$028769	|
	INC.w $0F35,X				;$02876B	|
	BNE CODE_028773				;$02876E	|
	INC.w $0F36,X				;$028770	|
CODE_028773:
	LDA.b #$D0
	STA $7D					;$028775	|
	LDA.b #$00				;$028777	|
	JSL ShatterBlock			;$028779	|
	JSR SprBlkInteract			;$02877D	|
CODE_028780:
	LDA.b #$02
	STA $9C					;$028782	|
	JSL generate_tile			;$028784	|
	RTL					;$028788	|

BlockBounce:
	db $00,$03,$00,$00,$01,$07,$00,$04
	db $0A

NotBreakable:
	LDY.b #$03
FindTurningBlkSlot:
	LDA.w $1699,Y
	BEQ CODE_028807				;$028797	|
	DEY					;$028799	|
	BPL FindTurningBlkSlot			;$02879A	|
	DEC.w $18CD				;$02879C	|
	BPL CODE_0287A6				;$02879F	|
	LDA.b #$03				;$0287A1	|
	STA.w $18CD				;$0287A3	|
CODE_0287A6:
	LDY.w $18CD
	LDA.w $1699,Y				;$0287A9	|
	CMP.b #$07				;$0287AC	|
	BNE NoResetTurningBlk			;$0287AE	|
	LDA $9A					;$0287B0	|
	PHA					;$0287B2	|
	LDA $9B					;$0287B3	|
	PHA					;$0287B5	|
	LDA $98					;$0287B6	|
	PHA					;$0287B8	|
	LDA $99					;$0287B9	|
	PHA					;$0287BB	|
	LDA.w $16A5,Y				;$0287BC	|
	STA $9A					;$0287BF	|
	LDA.w $16AD,Y				;$0287C1	|
	STA $9B					;$0287C4	|
	LDA.w $16A1,Y				;$0287C6	|
	CLC					;$0287C9	|
	ADC.b #$0C				;$0287CA	|
	AND.b #$F0				;$0287CC	|
	STA $98					;$0287CE	|
	LDA.w $16A9,Y				;$0287D0	|
	ADC.b #$00				;$0287D3	|
	STA $99					;$0287D5	|
	LDA.w $16C1,Y				;$0287D7	|
	STA $9C					;$0287DA	|
	LDA $04					;$0287DC	|
	PHA					;$0287DE	|
	LDA $05					;$0287DF	|
	PHA					;$0287E1	|
	LDA $06					;$0287E2	|
	PHA					;$0287E4	|
	LDA $07					;$0287E5	|
	PHA					;$0287E7	|
	JSL generate_tile			;$0287E8	|
	PLA					;$0287EC	|
	STA $07					;$0287ED	|
	PLA					;$0287EF	|
	STA $06					;$0287F0	|
	PLA					;$0287F2	|
	STA $05					;$0287F3	|
	PLA					;$0287F5	|
	STA $04					;$0287F6	|
	PLA					;$0287F8	|
	STA $99					;$0287F9	|
	PLA					;$0287FB	|
	STA $98					;$0287FC	|
	PLA					;$0287FE	|
	STA $9B					;$0287FF	|
	PLA					;$028801	|
	STA $9A					;$028802	|
NoResetTurningBlk:
	LDY.w $18CD
CODE_028807:
	LDA $04
	CMP.b #$10				;$028809	|
	BCC CODE_028818				;$02880B	|
	STZ $04					;$02880D	|
	TAX					;$02880F	|
	LDA.w CODE_028780,X			;$028810	|
	STA.w $1901,Y				;$028813	|
	BRA CODE_02882A				;$028816	|

CODE_028818:
	LDA $04
	CMP.b #$05				;$02881A	|
	BNE CODE_028823				;$02881C	|
	LDX.b #$0B				;$02881E	|
	STX.w $1DF9				;$028820	|
CODE_028823:
	TAX
	LDA.w BlockBounce,X			;$028824	|
	STA.w $1901,Y				;$028827	|
CODE_02882A:
	LDA $04
	INC A					;$02882C	|
	STA.w $1699,Y				;$02882D	|
	LDA.b #$00				;$028830	|
	STA.w $169D,Y				;$028832	|
	LDA $9A					;$028835	|
	STA.w $16A5,Y				;$028837	|
	LDA $9B					;$02883A	|
	STA.w $16AD,Y				;$02883C	|
	LDA $98					;$02883F	|
	STA.w $16A1,Y				;$028841	|
	LDA $99					;$028844	|
	STA.w $16A9,Y				;$028846	|
	LDA.w $1933				;$028849	|
	LSR					;$02884C	|
	ROR					;$02884D	|
	STA $08					;$02884E	|
	LDX $06					;$028850	|
	LDA.w BlockBounceSpeedY,X		;$028852	|
	STA.w $16B1,Y				;$028855	|
	LDA.w BlockBounceSpeedX,X		;$028858	|
	STA.w $16B5,Y				;$02885B	|
	TXA					;$02885E	|
	ORA $08					;$02885F	|
	STA.w $16C9,Y				;$028861	|
	LDA $07					;$028864	|
	STA.w $16C1,Y				;$028866	|
	LDA.b #$08				;$028869	|
	STA.w $16C5,Y				;$02886B	|
	LDA.w $1699,Y				;$02886E	|
	CMP.b #$07				;$028871	|
	BNE CODE_02887A				;$028873	|
	LDA.b #$FF				;$028875	|
	STA.w $18CE,Y				;$028877	|
CODE_02887A:
	JSR SprBlkInteract
CODE_02887D:
	LDA $05
	BEQ Return0288A0			;$02887F	|
	CMP.b #$0A				;$028881	|
	BNE CODE_028885				;$028883	|
CODE_028885:
	LDA $05
	CMP.b #$08				;$028887	|
	BCS CODE_0288DC				;$028889	|
	CMP.b #$06				;$02888B	|
	BCC CODE_0288DC				;$02888D	|
	CMP.b #$07				;$02888F	|
	BNE CODE_02889D				;$028891	|
	LDA.w $186B				;$028893	|
	BNE CODE_02889D				;$028896	|
	LDA.b #$FF				;$028898	|
	STA.w $186B				;$02889A	|
CODE_02889D:
	JSR CODE_028A66
Return0288A0:
	RTL

DATA_0288A1:
	db $35,$78

SpriteInBlock:
	db $00,$74,$75,$76,$77,$78,$00,$00
	db $79,$00,$3E,$7D,$2C,$04,$81,$45
	db $80

SpriteInBlockPow:
	db $00,$74,$75,$76,$77,$78,$00,$00
	db $79,$00,$3E,$7D,$2C,$04,$81,$45
	db $80

StatusOfSprInBlk:
	db $00,$08,$08,$08,$08,$08,$00,$00
	db $08,$00,$09,$08,$09,$09,$08,$08
	db $09

DATA_0288D6:
	db $80,$7E,$7D

DATA_0288D9:
	db $09,$08,$08

CODE_0288DC:
	LDY $05
	CPY.b #$0B				;$0288DE	|
	BNE CODE_0288EA				;$0288E0	|
	LDA $9A					;$0288E2	|
	AND.b #$30				;$0288E4	|
	CMP.b #$20				;$0288E6	|
	BEQ GenSpriteFromBlk			;$0288E8	|
CODE_0288EA:
	CPY.b #$10
	BEQ CODE_0288FD				;$0288EC	|
	CPY.b #$08				;$0288EE	|
	BNE CODE_0288F9				;$0288F0	|
	LDA.w $1692				;$0288F2	|
	BEQ GenSpriteFromBlk			;$0288F5	|
	BNE CODE_0288FD				;$0288F7	|
CODE_0288F9:
	CPY.b #$0C
	BNE GenSpriteFromBlk			;$0288FB	|
CODE_0288FD:
	JSL FindFreeSprSlot
	TYX					;$028901	|
	BPL CODE_028922				;$028902	|
	RTL					;$028904	|

GenSpriteFromBlk:
	LDX.b #$0B
CODE_028907:
	LDA.w $14C8,X
	BEQ CODE_028922				;$02890A	|
	DEX					;$02890C	|
	CPX.b #$FF				;$02890D	|
	BNE CODE_028907				;$02890F	|
	DEC.w $1861				;$028911	|
	BPL CODE_02891B				;$028914	|
	LDA.b #$01				;$028916	|
	STA.w $1861				;$028918	|
CODE_02891B:
	LDA.w $1861
	CLC					;$02891E	|
	ADC.b #$0A				;$02891F	|
	TAX					;$028921	|
CODE_028922:
	STX.w $185E
	LDY $05					;$028925	|
	LDA.w StatusOfSprInBlk,Y		;$028927	|
	STA.w $14C8,X				;$02892A	|
	LDA.w $18E2				;$02892D	|
	BEQ CODE_028937				;$028930	|
	TYA					;$028932	|
	CLC					;$028933	|
	ADC.b #$11				;$028934	|
	TAY					;$028936	|
CODE_028937:
	STY.w $1695
	LDA.w SpriteInBlock,Y			;$02893A	|
	STA $9E,X				;$02893D	|
	STA $0E					;$02893F	|
	LDY.b #$02				;$028941	|
	CMP.b #$81				;$028943	|
	BCS CODE_02894C				;$028945	|
	CMP.b #$79				;$028947	|
	BCC CODE_02894C				;$028949	|
	INY					;$02894B	|
CODE_02894C:
	STY.w $1DFC
	JSL InitSpriteTables			;$02894F	|
	INC.w $15A0,X				;$028953	|
	LDA $9E,X				;$028956	|
	CMP.b #$45				;$028958	|
	BNE CODE_028972				;$02895A	|
	LDA.w $1432				;$02895C	|
	BEQ CODE_028967				;$02895F	|
	STZ.w $14C8,X				;$028961	|
	JMP CODE_02889D				;$028964	|

CODE_028967:
	LDA.b #$0E
	STA.w $1DFB				;$028969	|
	INC.w $1432				;$02896C	|
	STZ.w $190C				;$02896F	|
CODE_028972:
	LDA $9A
	STA $E4,X				;$028974	|
	LDA $9B					;$028976	|
	STA.w $14E0,X				;$028978	|
	LDA $98					;$02897B	|
	STA $D8,X				;$02897D	|
	LDA $99					;$02897F	|
	STA.w $14D4,X				;$028981	|
	LDA.w $1933				;$028984	|
	BEQ CODE_0289A5				;$028987	|
	LDA $9A					;$028989	|
	SEC					;$02898B	|
	SBC $26					;$02898C	|
	STA $E4,X				;$02898E	|
	LDA $9B					;$028990	|
	SBC $27					;$028992	|
	STA.w $14E0,X				;$028994	|
	LDA $98					;$028997	|
	SEC					;$028999	|
	SBC $28					;$02899A	|
	STA $D8,X				;$02899C	|
	LDA $99					;$02899E	|
	SBC $29					;$0289A0	|
	STA.w $14D4,X				;$0289A2	|
CODE_0289A5:
	LDA $9E,X
	CMP.b #$7D				;$0289A7	|
	BNE CODE_0289D3				;$0289A9	|
	LDA $E4,X				;$0289AB	|
	AND.b #$30				;$0289AD	|
	LSR					;$0289AF	|
	LSR					;$0289B0	|
	LSR					;$0289B1	|
	LSR					;$0289B2	|
	TAY					;$0289B3	|
	LDA.w DATA_0288D9,Y			;$0289B4	|
	STA.w $14C8,X				;$0289B7	|
	LDA.w DATA_0288D6,Y			;$0289BA	|
	STA $9E,X				;$0289BD	|
	PHA					;$0289BF	|
	JSL InitSpriteTables			;$0289C0	|
	PLA					;$0289C4	|
	CMP.b #$7D				;$0289C5	|
	BNE CODE_0289CD				;$0289C7	|
	INC.w $157C,X				;$0289C9	|
	RTL					;$0289CC	|

CODE_0289CD:
	CMP.b #$7E
	BEQ CODE_028A03				;$0289CF	|
	BRA CODE_028A01				;$0289D1	|

CODE_0289D3:
	CMP.b #$04
	BEQ ADDR_028A08				;$0289D5	|
	CMP.b #$3E				;$0289D7	|
	BEQ CODE_028A2A				;$0289D9	|
	CMP.b #$2C				;$0289DB	|
	BNE CODE_028A11				;$0289DD	|
	LDY.b #$0B				;$0289DF	|
CODE_0289E1:
	LDA.w $14C8,Y
	CMP.b #$08				;$0289E4	|
	BCC CODE_0289F3				;$0289E6	|
	LDA.w $009E,y				;$0289E8	|
	CMP.b #$2D				;$0289EB	|
	BNE CODE_0289F3				;$0289ED	|
CODE_0289EF:
	LDY.b #$01
	BRA CODE_0289FB				;$0289F1	|

CODE_0289F3:
	DEY
	BPL CODE_0289E1				;$0289F4	|
	LDY.w $18E2				;$0289F6	|
	BNE CODE_0289EF				;$0289F9	|
CODE_0289FB:
	LDA.w DATA_0288A1,Y
	STA.w $151C,X				;$0289FE	|
CODE_028A01:
	BRA CODE_028A0D

CODE_028A03:
	INC $C2,X
	INC $C2,X				;$028A05	|
	RTL					;$028A07	|

ADDR_028A08:
	LDA.b #$FF
	STA.w $1540,X				;$028A0A	|
CODE_028A0D:
	LDA.b #$D0
	BRA CODE_028A18				;$028A0F	|

CODE_028A11:
	LDA.b #$3E
	STA.w $1540,X				;$028A13	|
	LDA.b #$D0				;$028A16	|
CODE_028A18:
	STA $AA,X
	LDA.b #$2C				;$028A1A	|
	STA.w $154C,X				;$028A1C	|
	LDA.w $190F,X				;$028A1F	|
	BPL Return028A29			;$028A22	|
	LDA.b #$10				;$028A24	|
	STA.w $15AC,X				;$028A26	|
Return028A29:
	RTL

CODE_028A2A:
	LDA $E4,X
	LSR					;$028A2C	|
	LSR					;$028A2D	|
	LSR					;$028A2E	|
	LSR					;$028A2F	|
	AND.b #$01				;$028A30	|
	STA.w $151C,X				;$028A32	|
	TAY					;$028A35	|
	LDA.w DATA_028A42,Y			;$028A36	|
	STA.w $15F6,X				;$028A39	|
	JSL CODE_028A44				;$028A3C	|
	BRA CODE_028A0D				;$028A40	|

DATA_028A42:
	db $06,$02

CODE_028A44:
	PHX
	LDX.b #$03				;$028A45	|
CODE_028A47:
	LDA.w $17C0,X
	BEQ CODE_028A50				;$028A4A	|
	DEX					;$028A4C	|
	BPL CODE_028A47				;$028A4D	|
	INX					;$028A4F	|
CODE_028A50:
	LDA.b #$01
	STA.w $17C0,X				;$028A52	|
	LDA $98					;$028A55	|
	STA.w $17C4,X				;$028A57	|
	LDA $9A					;$028A5A	|
	STA.w $17C8,X				;$028A5C	|
	LDA.b #$1B				;$028A5F	|
	STA.w $17CC,X				;$028A61	|
	PLX					;$028A64	|
	RTL					;$028A65	|

CODE_028A66:
	LDX.b #$03
CODE_028A68:
	LDA.w $17D0,X
	BEQ CODE_028A7D				;$028A6B	|
	DEX					;$028A6D	|
	BPL CODE_028A68				;$028A6E	|
	DEC.w $1865				;$028A70	|
	BPL ADDR_028A7A				;$028A73	|
	LDA.b #$03				;$028A75	|
	STA.w $1865				;$028A77	|
ADDR_028A7A:
	LDX.w $1865
CODE_028A7D:
	JSL CODE_05B34A
	INC.w $17D0,X				;$028A81	|
	LDA $9A					;$028A84	|
	STA.w $17E0,X				;$028A86	|
	LDA $9B					;$028A89	|
	STA.w $17EC,X				;$028A8B	|
	LDA $98					;$028A8E	|
	SEC					;$028A90	|
	SBC.b #$10				;$028A91	|
	STA.w $17D4,X				;$028A93	|
	LDA $99					;$028A96	|
	SBC.b #$00				;$028A98	|
	STA.w $17E8,X				;$028A9A	|
	LDA.w $1933				;$028A9D	|
	STA.w $17E4,X				;$028AA0	|
	LDA.b #$D0				;$028AA3	|
	STA.w $17D8,X				;$028AA5	|
	RTS					;$028AA8	|

DATA_028AA9:
	db $07,$03,$03,$01,$01,$01,$01,$01

CODE_028AB1:
	PHB
	PHK					;$028AB2	|
	PLB					;$028AB3	|
	LDA.w $18E4				;$028AB4	|
	BEQ CODE_028AD5				;$028AB7	|
	LDA.w $18E5				;$028AB9	|
	BEQ CODE_028AC3				;$028ABC	|
	DEC.w $18E5				;$028ABE	|
	BRA CODE_028AD5				;$028AC1	|

CODE_028AC3:
	DEC.w $18E4
	BEQ CODE_028ACD				;$028AC6	|
	LDA.b #$23				;$028AC8	|
	STA.w $18E5				;$028ACA	|
CODE_028ACD:
	LDA.b #$05
	STA.w $1DFC				;$028ACF	|
	INC.w $0DBE				;$028AD2	|
CODE_028AD5:
	LDA.w $1490
	BEQ CODE_028AEB				;$028AD8	|
	CMP.b #$08				;$028ADA	|
	BCC CODE_028AEB				;$028ADC	|
	LSR					;$028ADE	|
	LSR					;$028ADF	|
	LSR					;$028AE0	|
	LSR					;$028AE1	|
	LSR					;$028AE2	|
	TAY					;$028AE3	|
	LDA $13					;$028AE4	|
	AND.w DATA_028AA9,Y			;$028AE6	|
	BRA CODE_028AF5				;$028AE9	|

CODE_028AEB:
	LDA.w $18D3
	BEQ CODE_028B05				;$028AEE	|
	DEC.w $18D3				;$028AF0	|
	AND.b #$01				;$028AF3	|
CODE_028AF5:
	ORA $7F
	ORA $81					;$028AF7	|
	BNE CODE_028B05				;$028AF9	|
	LDA $80					;$028AFB	|
	CMP.b #$D0				;$028AFD	|
	BCS CODE_028B05				;$028AFF	|
	JSL CODE_02858F				;$028B01	|
CODE_028B05:
	JSR CODE_028B67
	JSR CODE_02902D				;$028B08	|
	JSR ScoreSprGfx				;$028B0B	|
	JSR CODE_029B0A				;$028B0E	|
	JSR CODE_0299D2				;$028B11	|
	JSR CODE_02B387				;$028B14	|
	JSR CallGenerator			;$028B17	|
	JSR CODE_0294F5				;$028B1A	|
	JSR LoadSprFromLevel			;$028B1D	|
	LDA.w $18C0				;$028B20	|
	BEQ CODE_028B65				;$028B23	|
	LDA $13					;$028B25	|
	AND.b #$01				;$028B27	|
	ORA $9D					;$028B29	|
	ORA.w $18BF				;$028B2B	|
	BNE CODE_028B65				;$028B2E	|
	DEC.w $18C0				;$028B30	|
	BNE CODE_028B65				;$028B33	|
	JSL FindFreeSprSlot			;$028B35	|
	BMI CODE_028B65				;$028B39	|
	TYX					;$028B3B	|
	LDA.b #$01				;$028B3C	|
	STA.w $14C8,X				;$028B3E	|
	LDA.w $18C1				;$028B41	|
	STA $9E,X				;$028B44	|
	LDA $1A					;$028B46	|
	SEC					;$028B48	|
	SBC.b #$20				;$028B49	|
	AND.b #$EF				;$028B4B	|
	STA $E4,X				;$028B4D	|
	LDA $1B					;$028B4F	|
	SBC.b #$00				;$028B51	|
	STA.w $14E0,X				;$028B53	|
	LDA.w $18C3				;$028B56	|
	STA $D8,X				;$028B59	|
	LDA.w $18C4				;$028B5B	|
	STA.w $14D4,X				;$028B5E	|
	JSL InitSpriteTables			;$028B61	|
CODE_028B65:
	PLB
	RTL					;$028B66	|

CODE_028B67:
	LDX.b #$0B
CODE_028B69:
	LDA.w $17F0,X
	BEQ CODE_028B74				;$028B6C	|
	STX.w $1698				;$028B6E	|
	JSR CODE_028B94				;$028B71	|
CODE_028B74:
	DEX
	BPL CODE_028B69				;$028B75	|
Return028B77:
	RTS

BrokenBlock:
	db $50,$54,$58,$5C,$60,$64,$68,$6C
	db $70,$74,$78,$7C

BrokenBlock2:
	db $3C,$3D,$3D,$3C,$3C,$3D,$3D,$3C
DATA_028B8C:
	db $00,$00,$80,$80,$80,$C0,$40,$00

CODE_028B94:
	JSL execute_pointer

Ptrs028B98:
	dw Return028B77
	dw CODE_028F8B
	dw CODE_028ED2
	dw CODE_028E7E
	dw CODE_028F2F
	dw CODE_028ED2
	dw CODE_028DDB
	dw CODE_028D4F
	dw CODE_028DDB
	dw CODE_028DDB
	dw CODE_028CC4
	dw ADDR_028C0F

DisabledAddSmokeRt:
	PHB
	PHK					;$028BB1	|
	PLB					;$028BB2	|
	JSR Return028BB8			;$028BB3	|
	PLB					;$028BB6	|
	RTL					;$028BB7	|

Return028BB8:
	RTS

UnusedYoshiSmoke:
	STZ $00
	JSR ADDR_028BC0				;$028BBB	|
	INC $00					;$028BBE	|
ADDR_028BC0:
	LDY.b #$0B
ADDR_028BC2:
	LDA.w $17F0,Y
	BEQ ADDR_028BCB				;$028BC5	|
	DEY					;$028BC7	|
	BPL ADDR_028BC2				;$028BC8	|
	RTS					;$028BCA	|

ADDR_028BCB:
	LDA.b #$0B
	STA.w $17F0,Y				;$028BCD	|
	LDA.b #$00				;$028BD0	|
	STA.w $1850,Y				;$028BD2	|
	LDA $D8,X				;$028BD5	|
	CLC					;$028BD7	|
	ADC.b #$1C				;$028BD8	|
	STA.w $17FC,Y				;$028BDA	|
	LDA.w $14D4,X				;$028BDD	|
	ADC.b #$00				;$028BE0	|
	STA.w $1814,Y				;$028BE2	|
	LDA $94					;$028BE5	|
	STA $02					;$028BE7	|
	LDA $95					;$028BE9	|
	STA $03					;$028BEB	|
	PHX					;$028BED	|
	LDX $00					;$028BEE	|
	LDA.w DATA_028C09,X			;$028BF0	|
	STA.w $182C,Y				;$028BF3	|
	LDA $02					;$028BF6	|
	CLC					;$028BF8	|
	ADC.w DATA_028C0B,X			;$028BF9	|
	STA.w $1808,Y				;$028BFC	|
	LDA $03					;$028BFF	|
	ADC.w DATA_028C0D,X			;$028C01	|
	STA.w $18EA,Y				;$028C04	|
	PLX					;$028C07	|
	RTS					;$028C08	|

DATA_028C09:
	db $40,$C0

DATA_028C0B:
	db $0C,$FC

DATA_028C0D:
	db $00,$FF

ADDR_028C0F:
	LDA.w $1850,X
	BNE ADDR_028C61				;$028C12	|
	LDA.w $182C,X				;$028C14	|
	BEQ ADDR_028C66				;$028C17	|
	BPL ADDR_028C20				;$028C19	|
	CLC					;$028C1B	|
	ADC.b #$08				;$028C1C	|
	BRA ADDR_028C23				;$028C1E	|

ADDR_028C20:
	SEC
	SBC.b #$08				;$028C21	|
ADDR_028C23:
	STA.w $182C,X
	JSR CODE_02B5BC				;$028C26	|
	TXA					;$028C29	|
	EOR $13					;$028C2A	|
	AND.b #$03				;$028C2C	|
	BNE Return028C60			;$028C2E	|
	LDY.b #$0B				;$028C30	|
ADDR_028C32:
	LDA.w $17F0,Y
	BEQ ADDR_028C3B				;$028C35	|
	DEY					;$028C37	|
	BPL ADDR_028C32				;$028C38	|
	RTS					;$028C3A	|

ADDR_028C3B:
	LDA.b #$0B
	STA.w $17F0,Y				;$028C3D	|
	STA.w $1820,Y				;$028C40	|
	LDA.w $1808,X				;$028C43	|
	STA.w $1808,Y				;$028C46	|
	LDA.w $18EA,X				;$028C49	|
	STA.w $18EA,Y				;$028C4C	|
	LDA.w $17FC,X				;$028C4F	|
	STA.w $17FC,Y				;$028C52	|
	LDA.w $1814,X				;$028C55	|
	STA.w $1814,Y				;$028C58	|
	LDA.b #$10				;$028C5B	|
	STA.w $1850,Y				;$028C5D	|
Return028C60:
	RTS

ADDR_028C61:
	DEC.w $1850,X
	BNE ADDR_028C6E				;$028C64	|
ADDR_028C66:
	STZ.w $17F0,X
	RTS					;$028C69	|

DATA_028C6A:
	db $66,$66,$64,$62

ADDR_028C6E:
	LDY.w BrokenBlock,X
	LDA.w $1808,X				;$028C71	|
	SEC					;$028C74	|
	SBC $1A					;$028C75	|
	STA $00					;$028C77	|
	LDA.w $18EA,X				;$028C79	|
	SBC $1B					;$028C7C	|
	BNE ADDR_028C66				;$028C7E	|
	LDA.w $17FC,X				;$028C80	|
	SEC					;$028C83	|
	SBC $1C					;$028C84	|
	STA $01					;$028C86	|
	LDA.w $1814,X				;$028C88	|
	SBC $1D					;$028C8B	|
	BNE ADDR_028C66				;$028C8D	|
	LDA $00					;$028C8F	|
	STA.w $0200,Y				;$028C91	|
	LDA $01					;$028C94	|
	STA.w $0201,Y				;$028C96	|
	PHX					;$028C99	|
	LDA.w $1850,X				;$028C9A	|
	LSR					;$028C9D	|
	LSR					;$028C9E	|
	TAX					;$028C9F	|
	LDA.w DATA_028C6A,X			;$028CA0	|
	STA.w $0202,Y				;$028CA3	|
	PLX					;$028CA6	|
	LDA $64					;$028CA7	|
	ORA.b #$08				;$028CA9	|
	STA.w $0203,Y				;$028CAB	|
	TYA					;$028CAE	|
	LSR					;$028CAF	|
	LSR					;$028CB0	|
	TAY					;$028CB1	|
	LDA.b #$00				;$028CB2	|
	STA.w $0420,Y				;$028CB4	|
	RTS					;$028CB7	|

BooStreamTiles:
	db $88,$A8,$AA,$8C,$8E,$AE,$88,$A8
	db $AA,$8C,$8E,$AE

CODE_028CC4:
	LDA $9D
	BNE CODE_028CFF				;$028CC6	|
	LDA.w $1808,X				;$028CC8	|
	CLC					;$028CCB	|
	ADC.b #$04				;$028CCC	|
	STA $04					;$028CCE	|
	LDA.w $18EA,X				;$028CD0	|
	ADC.b #$00				;$028CD3	|
	STA $0A					;$028CD5	|
	LDA.w $17FC,X				;$028CD7	|
	CLC					;$028CDA	|
	ADC.b #$04				;$028CDB	|
	STA $05					;$028CDD	|
	LDA.w $1814,X				;$028CDF	|
	ADC.b #$00				;$028CE2	|
	STA $0B					;$028CE4	|
	LDA.b #$08				;$028CE6	|
	STA $06					;$028CE8	|
	STA $07					;$028CEA	|
	JSL GetMarioClipping			;$028CEC	|
	JSL CheckForContact			;$028CF0	|
	BCC CODE_028CFA				;$028CF4	|
	JSL HurtMario				;$028CF6	|
CODE_028CFA:
	DEC.w $1850,X
	BEQ CODE_028D62				;$028CFD	|
CODE_028CFF:
	LDY.w BrokenBlock,X
	LDA.w $1808,X				;$028D02	|
	SEC					;$028D05	|
	SBC $1A					;$028D06	|
	STA $00					;$028D08	|
	LDA.w $18EA,X				;$028D0A	|
	SBC $1B					;$028D0D	|
	BNE Return028D41			;$028D0F	|
	LDA $00					;$028D11	|
	STA.w $0200,Y				;$028D13	|
	LDA.w $17FC,X				;$028D16	|
	SEC					;$028D19	|
	SBC $1C					;$028D1A	|
	CMP.b #$F0				;$028D1C	|
	BCS CODE_028D62				;$028D1E	|
	STA.w $0201,Y				;$028D20	|
	LDA.w BooStreamTiles,X			;$028D23	|
	STA.w $0202,Y				;$028D26	|
	LDA.w $182C,X				;$028D29	|
	LSR					;$028D2C	|
	AND.b #$40				;$028D2D	|
	EOR.b #$40				;$028D2F	|
	ORA $64					;$028D31	|
	ORA.b #$0F				;$028D33	|
	STA.w $0203,Y				;$028D35	|
	TYA					;$028D38	|
	LSR					;$028D39	|
	LSR					;$028D3A	|
	TAY					;$028D3B	|
	LDA.b #$02				;$028D3C	|
	STA.w $0420,Y				;$028D3E	|
Return028D41:
	RTS

WaterSplashTiles:
	db $68,$68,$6A,$6A,$6A,$62,$62,$62
	db $64,$64,$64,$64,$66

CODE_028D4F:
	LDA.w $1808,X
	CMP $1A					;$028D52	|
	LDA.w $18EA,X				;$028D54	|
	SBC $1B					;$028D57	|
	BNE CODE_028D62				;$028D59	|
	LDA.w $1850,X				;$028D5B	|
	CMP.b #$20				;$028D5E	|
	BNE CODE_028D66				;$028D60	|
CODE_028D62:
	STZ.w $17F0,X
	RTS					;$028D65	|

CODE_028D66:
	STZ $00
	CMP.b #$10				;$028D68	|
	BCC CODE_028D8B				;$028D6A	|
	AND.b #$01				;$028D6C	|
	ORA $9D					;$028D6E	|
	BNE CODE_028D75				;$028D70	|
	INC.w $17FC,X				;$028D72	|
CODE_028D75:
	LDA.w $1850,X
	SEC					;$028D78	|
	SBC.b #$10				;$028D79	|
	LSR					;$028D7B	|
	LSR					;$028D7C	|
	STA $02					;$028D7D	|
	LDA $13					;$028D7F	|
	LSR					;$028D81	|
	LDA $02					;$028D82	|
	BCC CODE_028D89				;$028D84	|
	EOR.b #$FF				;$028D86	|
	INC A					;$028D88	|
CODE_028D89:
	STA $00
CODE_028D8B:
	LDY.w BrokenBlock,X
	LDA.w $1808,X				;$028D8E	|
	CLC					;$028D91	|
	ADC $00					;$028D92	|
	SEC					;$028D94	|
	SBC $1A					;$028D95	|
	CMP.b #$F0				;$028D97	|
	BCS CODE_028D62				;$028D99	|
	STA.w $0200,Y				;$028D9B	|
	LDA.w $17FC,X				;$028D9E	|
	SEC					;$028DA1	|
	SBC $1C					;$028DA2	|
	CMP.b #$E8				;$028DA4	|
	BCS CODE_028D62				;$028DA6	|
	STA.w $0201,Y				;$028DA8	|
	LDA.w $1850,X				;$028DAB	|
	LSR					;$028DAE	|
	TAX					;$028DAF	|
	CPX.b #$0C				;$028DB0	|
	BCC CODE_028DB6				;$028DB2	|
	LDX.b #$0C				;$028DB4	|
CODE_028DB6:
	LDA.w WaterSplashTiles,X
	LDX.w $1698				;$028DB9	|
	STA.w $0202,Y				;$028DBC	|
	LDA $64					;$028DBF	|
	ORA.b #$02				;$028DC1	|
	STA.w $0203,Y				;$028DC3	|
	TYA					;$028DC6	|
	LSR					;$028DC7	|
	LSR					;$028DC8	|
	TAY					;$028DC9	|
	LDA.b #$02				;$028DCA	|
	STA.w $0420,Y				;$028DCC	|
	LDA $9D					;$028DCF	|
	BNE Return028DD6			;$028DD1	|
	INC.w $1850,X				;$028DD3	|
Return028DD6:
	RTS

RipVanFishZsTiles:
	db $F1,$F0,$E1,$E0

CODE_028DDB:
	LDA $9D
	BNE CODE_028E20				;$028DDD	|
	LDA.w $1850,X				;$028DDF	|
	BEQ CODE_028DE7				;$028DE2	|
	DEC.w $1850,X				;$028DE4	|
CODE_028DE7:
	LDA.w $1850,X
	AND.b #$00				;$028DEA	|
	BNE CODE_028DFE				;$028DEC	|
	LDA.w $1850,X				;$028DEE	|
	INC.w $182C,X				;$028DF1	|
	AND.b #$10				;$028DF4	|
	BNE CODE_028DFE				;$028DF6	|
	DEC.w $182C,X				;$028DF8	|
	DEC.w $182C,X				;$028DFB	|
CODE_028DFE:
	LDA.w $182C,X
	PHA					;$028E01	|
	LDY.w $17F0,X				;$028E02	|
	CPY.b #$09				;$028E05	|
	BNE CODE_028E0F				;$028E07	|
	EOR.b #$FF				;$028E09	|
	INC A					;$028E0B	|
	STA.w $182C,X				;$028E0C	|
CODE_028E0F:
	JSR CODE_02B5BC
	PLA					;$028E12	|
	STA.w $182C,X				;$028E13	|
	LDA.w $1850,X				;$028E16	|
	AND.b #$03				;$028E19	|
	BNE CODE_028E20				;$028E1B	|
	DEC.w $17FC,X				;$028E1D	|
CODE_028E20:
	LDY.w BrokenBlock,X
	LDA.w $1808,X				;$028E23	|
	SEC					;$028E26	|
	SBC $1A					;$028E27	|
	CMP.b #$08				;$028E29	|
	BCC CODE_028E76				;$028E2B	|
	CMP.b #$FC				;$028E2D	|
	BCS CODE_028E76				;$028E2F	|
	STA.w $0200,Y				;$028E31	|
	LDA.w $17FC,X				;$028E34	|
	SEC					;$028E37	|
	SBC $1C					;$028E38	|
	CMP.b #$F0				;$028E3A	|
	BCS CODE_028E76				;$028E3C	|
	STA.w $0201,Y				;$028E3E	|
	LDA $64					;$028E41	|
	ORA.b #$03				;$028E43	|
	STA.w $0203,Y				;$028E45	|
	LDA.w $1850,X				;$028E48	|
	CMP.b #$14				;$028E4B	|
	BEQ CODE_028E76				;$028E4D	|
	LDA.w $17F0,X				;$028E4F	|
	CMP.b #$08				;$028E52	|
	LDA.b #$7F				;$028E54	|
	BCS CODE_028E66				;$028E56	|
	LDA.w $1850,X				;$028E58	|
	LSR					;$028E5B	|
	LSR					;$028E5C	|
	LSR					;$028E5D	|
	LSR					;$028E5E	|
	LSR					;$028E5F	|
	AND.b #$03				;$028E60	|
	TAX					;$028E62	|
	LDA.w RipVanFishZsTiles,X		;$028E63	|
CODE_028E66:
	STA.w $0202,Y
	TYA					;$028E69	|
	LSR					;$028E6A	|
	LSR					;$028E6B	|
	TAY					;$028E6C	|
	LDA.b #$00				;$028E6D	|
	STA.w $0420,Y				;$028E6F	|
	LDX.w $1698				;$028E72	|
	RTS					;$028E75	|

CODE_028E76:
	STZ.w $17F0,X
	RTS					;$028E79	|

DATA_028E7A:
	db $03,$43,$83,$C3

CODE_028E7E:
	DEC.w $1850,X
	LDA.w $1850,X				;$028E81	|
	AND.b #$3F				;$028E84	|
	BEQ CODE_028ED7				;$028E86	|
	JSR CODE_02B5BC				;$028E88	|
	JSR CODE_02B5C8				;$028E8B	|
	INC.w $1820,X				;$028E8E	|
	INC.w $1820,X				;$028E91	|
	LDY.w BrokenBlock,X			;$028E94	|
	LDA.w $17FC,X				;$028E97	|
	SEC					;$028E9A	|
	SBC $1C					;$028E9B	|
	CMP.b #$F0				;$028E9D	|
	BCS CODE_028ED7				;$028E9F	|
	STA.w $0201,Y				;$028EA1	|
	LDA.w $1808,X				;$028EA4	|
	SEC					;$028EA7	|
	SBC $1A					;$028EA8	|
	CMP.b #$F8				;$028EAA	|
	BCS CODE_028ED7				;$028EAC	|
	STA.w $0200,Y				;$028EAE	|
	LDA.b #$6F				;$028EB1	|
	STA.w $0202,Y				;$028EB3	|
	LDA.w $1850,X				;$028EB6	|
	AND.b #$C0				;$028EB9	|
	ORA.b #$03				;$028EBB	|
	ORA $64					;$028EBD	|
	STA.w $0203,Y				;$028EBF	|
	TYA					;$028EC2	|
	LSR					;$028EC3	|
	LSR					;$028EC4	|
	TAY					;$028EC5	|
	LDA.b #$00				;$028EC6	|
	STA.w $0420,Y				;$028EC8	|
	RTS					;$028ECB	|

StarSparkleTiles:
	db $66,$6E,$FF,$6D,$6C,$5C

CODE_028ED2:
	LDA.w $1850,X
	BNE CODE_028EDA				;$028ED5	|
CODE_028ED7:
	JMP CODE_028F87

CODE_028EDA:
	LDY $9D
	BNE CODE_028EE1				;$028EDC	|
	DEC.w $1850,X				;$028EDE	|
CODE_028EE1:
	LDY.w BrokenBlock,X
	LDA.w $1808,X				;$028EE4	|
	SEC					;$028EE7	|
	SBC $1A					;$028EE8	|
	CMP.b #$F0				;$028EEA	|
	BCS CODE_028ED7				;$028EEC	|
	STA.w $0200,Y				;$028EEE	|
	LDA.w $17FC,X				;$028EF1	|
	SEC					;$028EF4	|
	SBC $1C					;$028EF5	|
	CMP.b #$F0				;$028EF7	|
	BCS CODE_028ED7				;$028EF9	|
	STA.w $0201,Y				;$028EFB	|
	LDA.w $17F0,X				;$028EFE	|
	PHA					;$028F01	|
	LDA.w $1850,X				;$028F02	|
	LSR					;$028F05	|
	LSR					;$028F06	|
	LSR					;$028F07	|
	TAX					;$028F08	|
	PLA					;$028F09	|
	CMP.b #$05				;$028F0A	|
	BNE CODE_028F11				;$028F0C	|
	INX					;$028F0E	|
	INX					;$028F0F	|
	INX					;$028F10	|
CODE_028F11:
	LDA.w StarSparkleTiles,X
	STA.w $0202,Y				;$028F14	|
	LDA $64					;$028F17	|
	ORA.b #$06				;$028F19	|
	STA.w $0203,Y				;$028F1B	|
	LDX.w $1698				;$028F1E	|
	TYA					;$028F21	|
	LSR					;$028F22	|
	LSR					;$028F23	|
	TAY					;$028F24	|
	LDA.b #$00				;$028F25	|
	STA.w $0420,Y				;$028F27	|
	RTS					;$028F2A	|

LavaSplashTiles:
	db $D7,$C7,$D6,$C6

CODE_028F2F:
	LDA.w $1808,X
	CMP $1A					;$028F32	|
	LDA.w $18EA,X				;$028F34	|
	SBC $1B					;$028F37	|
	BNE CODE_028F87				;$028F39	|
	LDA.w $1850,X				;$028F3B	|
	BEQ CODE_028F87				;$028F3E	|
	LDY $9D					;$028F40	|
	BNE CODE_028F4D				;$028F42	|
	DEC.w $1850,X				;$028F44	|
	JSR CODE_02B5C8				;$028F47	|
	INC.w $1820,X				;$028F4A	|
CODE_028F4D:
	LDY.w BrokenBlock,X
	LDA.w $1808,X				;$028F50	|
	SEC					;$028F53	|
	SBC $1A					;$028F54	|
	STA.w $0200,Y				;$028F56	|
	LDA.w $17FC,X				;$028F59	|
	CMP.b #$F0				;$028F5C	|
	BCS CODE_028F87				;$028F5E	|
	SEC					;$028F60	|
	SBC $1C					;$028F61	|
	STA.w $0201,Y				;$028F63	|
	LDA.w $1850,X				;$028F66	|
	LSR					;$028F69	|
	LSR					;$028F6A	|
	LSR					;$028F6B	|
	TAX					;$028F6C	|
	LDA.w LavaSplashTiles,X			;$028F6D	|
	STA.w $0202,Y				;$028F70	|
	LDA $64					;$028F73	|
	ORA.b #$05				;$028F75	|
	STA.w $0203,Y				;$028F77	|
	LDX.w $1698				;$028F7A	|
	TYA					;$028F7D	|
	LSR					;$028F7E	|
	LSR					;$028F7F	|
	TAY					;$028F80	|
	LDA.b #$00				;$028F81	|
	STA.w $0420,Y				;$028F83	|
	RTS					;$028F86	|

CODE_028F87:
	STZ.w $17F0,X
	RTS					;$028F8A	|

CODE_028F8B:
	LDA $9D
	BNE CODE_028FCA				;$028F8D	|
	LDA $13					;$028F8F	|
	AND.b #$03				;$028F91	|
	BEQ CODE_028FAB				;$028F93	|
	LDY.b #$00				;$028F95	|
	LDA.w $182C,X				;$028F97	|
	BPL CODE_028F9D				;$028F9A	|
	DEY					;$028F9C	|
CODE_028F9D:
	CLC
	ADC.w $1808,X				;$028F9E	|
	STA.w $1808,X				;$028FA1	|
	TYA					;$028FA4	|
	ADC.w $18EA,X				;$028FA5	|
	STA.w $18EA,X				;$028FA8	|
CODE_028FAB:
	LDY.b #$00
	LDA.w $1820,X				;$028FAD	|
	BPL CODE_028FB3				;$028FB0	|
	DEY					;$028FB2	|
CODE_028FB3:
	CLC
	ADC.w $17FC,X				;$028FB4	|
	STA.w $17FC,X				;$028FB7	|
	TYA					;$028FBA	|
	ADC.w $1814,X				;$028FBB	|
	STA.w $1814,X				;$028FBE	|
	LDA $13					;$028FC1	|
	AND.b #$03				;$028FC3	|
	BNE CODE_028FCA				;$028FC5	|
	INC.w $1820,X				;$028FC7	|
CODE_028FCA:
	LDA.w $17FC,X
	SEC					;$028FCD	|
	SBC $1C					;$028FCE	|
	STA $00					;$028FD0	|
	LDA.w $1814,X				;$028FD2	|
	SBC $1D					;$028FD5	|
	BEQ CODE_028FDD				;$028FD7	|
	BPL CODE_028F87				;$028FD9	|
	BMI Return02902C			;$028FDB	|
CODE_028FDD:
	LDY.w BrokenBlock,X
	LDA.w $1808,X				;$028FE0	|
	SEC					;$028FE3	|
	SBC $1A					;$028FE4	|
	STA $01					;$028FE6	|
	LDA.w $18EA,X				;$028FE8	|
	SBC $1B					;$028FEB	|
	BNE CODE_028F87				;$028FED	|
	LDA $01					;$028FEF	|
	STA.w $0200,Y				;$028FF1	|
	LDA $00					;$028FF4	|
	CMP.b #$F0				;$028FF6	|
	BCS CODE_028F87				;$028FF8	|
	STA.w $0201,Y				;$028FFA	|
	LDA.w $1850,X				;$028FFD	|
	PHA					;$029000	|
	LDA $14					;$029001	|
	LSR					;$029003	|
	CLC					;$029004	|
	ADC.w $1698				;$029005	|
	AND.b #$07				;$029008	|
	TAX					;$02900A	|
	LDA.w BrokenBlock2,X			;$02900B	|
	STA.w $0202,Y				;$02900E	|
	PLA					;$029011	|
	BEQ CODE_029018				;$029012	|
	LDA $13					;$029014	|
	AND.b #$0E				;$029016	|
CODE_029018:
	EOR.w DATA_028B8C,X
	ORA $64					;$02901B	|
	STA.w $0203,Y				;$02901D	|
	LDX.w $1698				;$029020	|
	TYA					;$029023	|
	LSR					;$029024	|
	LSR					;$029025	|
	TAY					;$029026	|
	LDA.b #$00				;$029027	|
	STA.w $0420,Y				;$029029	|
Return02902C:
	RTS

CODE_02902D:
	LDA.w $186B
	CMP.b #$02				;$029030	|
	BCC CODE_02903B				;$029032	|
	LDA $9D					;$029034	|
	BNE CODE_02903B				;$029036	|
	DEC.w $186B				;$029038	|
CODE_02903B:
	LDX.b #$03
CODE_02903D:
	STX.w $1698
	JSR CODE_02904D				;$029040	|
	JSR CODE_029398				;$029043	|
	JSR CODE_0296C0				;$029046	|
	DEX					;$029049	|
	BPL CODE_02903D				;$02904A	|
Return02904C:
	RTS

CODE_02904D:
	LDA.w $1699,X
	BEQ Return02904C			;$029050	|
	LDY $9D					;$029052	|
	BNE CODE_02905E				;$029054	|
	LDY.w $16C5,X				;$029056	|
	BEQ CODE_02905E				;$029059	|
	DEC.w $16C5,X				;$02905B	|
CODE_02905E:
	JSL execute_pointer

BounceSpritePtrs:
	dw Return02904C
	dw BounceBlockSpr
	dw BounceBlockSpr
	dw BounceBlockSpr
	dw BounceBlockSpr
	dw BounceBlockSpr
	dw BounceBlockSpr
	dw TurnBlockSpr

DATA_029072:
	db $13,$00,$00,$ED

TurnBlockSpr:
	LDA $9D
	BNE Return0290CD			;$029078	|
	LDA.w $169D,X				;$02907A	|
	BNE CODE_029085				;$02907D	|
	INC.w $169D,X				;$02907F	|
	JSR InvisSldFromBncSpr			;$029082	|
CODE_029085:
	LDA.w $16C5,X
	BEQ CODE_0290BB				;$029088	|
	CMP.b #$01				;$02908A	|
	BNE CODE_0290A8				;$02908C	|
	LDA.w $16A1,X				;$02908E	|
	CLC					;$029091	|
	ADC.b #$08				;$029092	|
	AND.b #$F0				;$029094	|
	STA.w $16A1,X				;$029096	|
	LDA.w $16A9,X				;$029099	|
	ADC.b #$00				;$02909C	|
	STA.w $16A9,X				;$02909E	|
	LDA.b #$05				;$0290A1	|
	JSR TileFromBounceSpr1			;$0290A3	|
	BRA CODE_0290BB				;$0290A6	|

CODE_0290A8:
	JSR CODE_02B526
	LDY.w $16C9,X				;$0290AB	|
	LDA.w $16B1,X				;$0290AE	|
	CLC					;$0290B1	|
	ADC.w DATA_029072,Y			;$0290B2	|
	STA.w $16B1,X				;$0290B5	|
	JSR BounceSprGfx			;$0290B8	|
CODE_0290BB:
	LDA.w $18CE,X
	BEQ CODE_0290C4				;$0290BE	|
	DEC.w $18CE,X				;$0290C0	|
	RTS					;$0290C3	|

CODE_0290C4:
	LDA.w $16C1,X
	JSR TileFromBounceSpr1			;$0290C7	|
	STZ.w $1699,X				;$0290CA	|
Return0290CD:
	RTS

DATA_0290CE:
	db $10,$00,$00,$F0

DATA_0290D2:
	db $00,$F0,$10,$00

DATA_0290D6:
	db $80,$80,$80,$00

DATA_0290DA:
	db $80,$E0,$20,$80

BounceBlockSpr:
	JSR BounceSprGfx
	LDA $9D					;$0290E1	|
	BNE Return0290CD			;$0290E3	|
	LDA.w $169D,X				;$0290E5	|
	BNE CODE_02910B				;$0290E8	|
	INC.w $169D,X				;$0290EA	|
	JSR CODE_029265				;$0290ED	|
	JSR InvisSldFromBncSpr			;$0290F0	|
	LDA.w $16C9,X				;$0290F3	|
	AND.b #$03				;$0290F6	|
	TAY					;$0290F8	|
	LDA.w DATA_0290D6,Y			;$0290F9	|
	CMP.b #$80				;$0290FC	|
	BEQ CODE_029102				;$0290FE	|
	STA $7D					;$029100	|
CODE_029102:
	LDA.w DATA_0290DA,Y
	CMP.b #$80				;$029105	|
	BEQ CODE_02910B				;$029107	|
	STA $7B					;$029109	|
CODE_02910B:
	JSR CODE_02B526
	JSR CODE_02B51A				;$02910E	|
	LDA.w $16C9,X				;$029111	|
	AND.b #$03				;$029114	|
	TAY					;$029116	|
	LDA.w $16B1,X				;$029117	|
	CLC					;$02911A	|
	ADC.w DATA_0290CE,Y			;$02911B	|
	STA.w $16B1,X				;$02911E	|
	LDA.w $16B5,X				;$029121	|
	CLC					;$029124	|
	ADC.w DATA_0290D2,Y			;$029125	|
	STA.w $16B5,X				;$029128	|
	LDA.w $16C9,X				;$02912B	|
	AND.b #$03				;$02912E	|
	CMP.b #$03				;$029130	|
	BNE CODE_02915E				;$029132	|
	LDA $71					;$029134	|
	CMP.b #$01				;$029136	|
	BCS CODE_02915E				;$029138	|
	LDA.b #$20				;$02913A	|
	LDY.w $187A				;$02913C	|
	BEQ CODE_029143				;$02913F	|
	LDA.b #$30				;$029141	|
CODE_029143:
	STA $00
	LDA.w $16A1,X				;$029145	|
	SEC					;$029148	|
	SBC $00					;$029149	|
	STA $96					;$02914B	|
	LDA.w $16A9,X				;$02914D	|
	SBC.b #$00				;$029150	|
	STA $97					;$029152	|
	LDA.b #$01				;$029154	|
	STA.w $1471				;$029156	|
	STA.w $1402				;$029159	|
	STZ $7D					;$02915C	|
CODE_02915E:
	LDA.w $16C5,X
	BNE Return02919C			;$029161	|
	LDA.w $16C9,X				;$029163	|
	AND.b #$03				;$029166	|
	CMP.b #$03				;$029168	|
	BNE CODE_029182				;$02916A	|
	LDA.b #$A0				;$02916C	|
	STA $7D					;$02916E	|
	LDA $96					;$029170	|
	SEC					;$029172	|
	SBC.b #$02				;$029173	|
	STA $96					;$029175	|
	LDA $97					;$029177	|
	SBC.b #$00				;$029179	|
	STA $97					;$02917B	|
	LDA.b #$08				;$02917D	|
	STA.w $1DFC				;$02917F	|
CODE_029182:
	JSR TileFromBounceSpr0
	LDY.w $1699,X				;$029185	|
	CPY.b #$06				;$029188	|
	BCC CODE_029199				;$02918A	|
	LDA.b #$0B				;$02918C	|
	STA.w $1DF9				;$02918E	|
	LDA.w $14AF				;$029191	|
	EOR.b #$01				;$029194	|
	STA.w $14AF				;$029196	|
CODE_029199:
	STZ.w $1699,X
Return02919C:
	RTS

DATA_02919D:
	db $01,$00

TileFromBounceSpr0:
	LDA.w $16C1,X
	CMP.b #$0A				;$0291A2	|
	BEQ CODE_0291AA				;$0291A4	|
	CMP.b #$0B				;$0291A6	|
	BNE CODE_0291B6				;$0291A8	|
CODE_0291AA:
	LDY.w $186B
	CPY.b #$01				;$0291AD	|
	BNE CODE_0291B6				;$0291AF	|
	STZ.w $186B				;$0291B1	|
	LDA.b #$0D				;$0291B4	|
CODE_0291B6:
	BRA TileFromBounceSpr1

InvisSldFromBncSpr:
	LDA.b #$09
TileFromBounceSpr1:
	STA $9C
	LDA.w $16A5,X				;$0291BC	|
	CLC					;$0291BF	|
	ADC.b #$08				;$0291C0	|
	AND.b #$F0				;$0291C2	|
	STA $9A					;$0291C4	|
	LDA.w $16AD,X				;$0291C6	|
	ADC.b #$00				;$0291C9	|
	STA $9B					;$0291CB	|
	LDA.w $16A1,X				;$0291CD	|
	CLC					;$0291D0	|
	ADC.b #$08				;$0291D1	|
	AND.b #$F0				;$0291D3	|
	STA $98					;$0291D5	|
	LDA.w $16A9,X				;$0291D7	|
	ADC.b #$00				;$0291DA	|
	STA $99					;$0291DC	|
	LDA.w $16C9,X				;$0291DE	|
	ASL					;$0291E1	|
	ROL					;$0291E2	|
	AND.b #$01				;$0291E3	|
	STA.w $1933				;$0291E5	|
	JSL generate_tile			;$0291E8	|
Return0291EC:
	RTS

DATA_0291ED:
	db $10,$14,$18

BounceSpriteTiles:
	db $1C,$40,$6B,$2A,$42,$EA,$8A,$40

BounceSprGfx:
	LDY.b #$00
	LDA.w $16C9,X				;$0291FA	|
	BPL CODE_029201				;$0291FD	|
	LDY.b #$04				;$0291FF	|
CODE_029201:
	LDA.w $001C,y
	STA $02					;$029204	|
	LDA.w $001A,y				;$029206	|
	STA $03					;$029209	|
	LDA.w $001D,y				;$02920B	|
	STA $04					;$02920E	|
	LDA.w $001B,y				;$029210	|
	STA $05					;$029213	|
	LDA.w $16A1,X				;$029215	|
	CMP $02					;$029218	|
	LDA.w $16A9,X				;$02921A	|
	SBC $04					;$02921D	|
	BNE Return0291EC			;$02921F	|
	LDA.w $16A5,X				;$029221	|
	CMP $03					;$029224	|
	LDA.w $16AD,X				;$029226	|
	SBC $05					;$029229	|
	BNE Return0291EC			;$02922B	|
	LDY.w DATA_0291ED,X			;$02922D	|
	LDA.w $16A1,X				;$029230	|
	SEC					;$029233	|
	SBC $02					;$029234	|
	STA $01					;$029236	|
	STA.w $0201,Y				;$029238	|
	LDA.w $16A5,X				;$02923B	|
	SEC					;$02923E	|
	SBC $03					;$02923F	|
	STA $00					;$029241	|
	STA.w $0200,Y				;$029243	|
	LDA.w $1901,X				;$029246	|
	ORA $64					;$029249	|
	STA.w $0203,Y				;$02924B	|
	LDA.w $1699,X				;$02924E	|
	TAX					;$029251	|
	LDA.w BounceSpriteTiles,X		;$029252	|
	STA.w $0202,Y				;$029255	|
	TYA					;$029258	|
	LSR					;$029259	|
	LSR					;$02925A	|
	TAY					;$02925B	|
	LDA.b #$02				;$02925C	|
	STA.w $0420,Y				;$02925E	|
	LDX.w $1698				;$029261	|
	RTS					;$029264	|

CODE_029265:
	LDA.b #$01
	LDY.w $16C9,X				;$029267	|
	STY $0F					;$02926A	|
	BPL CODE_02926F				;$02926C	|
	ASL					;$02926E	|
CODE_02926F:
	AND $5B
	BEQ CODE_0292CA				;$029271	|
	LDA.w $16A1,X				;$029273	|
	SEC					;$029276	|
	SBC.b #$03				;$029277	|
	AND.b #$F0				;$029279	|
	STA $00					;$02927B	|
	LDA.w $16A9,X				;$02927D	|
	SBC.b #$00				;$029280	|
	CMP $5D					;$029282	|
	BCS Return0292C9			;$029284	|
	STA $03					;$029286	|
	AND.b #$10				;$029288	|
	STA $08					;$02928A	|
	LDA.w $16A5,X				;$02928C	|
	STA $01					;$02928F	|
	LDA.w $16AD,X				;$029291	|
	CMP.b #$02				;$029294	|
	BCS Return0292C9			;$029296	|
	STA $02					;$029298	|
	LDA $01					;$02929A	|
	LSR					;$02929C	|
	LSR					;$02929D	|
	LSR					;$02929E	|
	LSR					;$02929F	|
	ORA $00					;$0292A0	|
	STA $00					;$0292A2	|
	LDX $03					;$0292A4	|
	LDA.l DATA_00BA80,X			;$0292A6	|
	LDY $0F					;$0292AA	|
	BEQ CODE_0292B2				;$0292AC	|
	LDA.l DATA_00BA8E,X			;$0292AE	|
CODE_0292B2:
	CLC
	ADC $00					;$0292B3	|
	STA $05					;$0292B5	|
	LDA.l DATA_00BABC,X			;$0292B7	|
	LDY $0F					;$0292BB	|
	BEQ CODE_0292C3				;$0292BD	|
	LDA.l DATA_00BACA,X			;$0292BF	|
CODE_0292C3:
	ADC $02
	STA $06					;$0292C5	|
	BRA CODE_02931A				;$0292C7	|

Return0292C9:
	RTS

CODE_0292CA:
	LDA.w $16A1,X
	SEC					;$0292CD	|
	SBC.b #$03				;$0292CE	|
	AND.b #$F0				;$0292D0	|
	STA $00					;$0292D2	|
	LDA.w $16A9,X				;$0292D4	|
	SBC.b #$00				;$0292D7	|
	CMP.b #$02				;$0292D9	|
	BCS Return0292C9			;$0292DB	|
	STA $02					;$0292DD	|
	LDA.w $16A5,X				;$0292DF	|
	STA $01					;$0292E2	|
	LDA.w $16AD,X				;$0292E4	|
	CMP $5D					;$0292E7	|
	BCS Return0292C9			;$0292E9	|
	STA $03					;$0292EB	|
	LDA $01					;$0292ED	|
	LSR					;$0292EF	|
	LSR					;$0292F0	|
	LSR					;$0292F1	|
	LSR					;$0292F2	|
	ORA $00					;$0292F3	|
	STA $00					;$0292F5	|
	LDX $03					;$0292F7	|
	LDA.l DATA_00BA60,X			;$0292F9	|
	LDY $0F					;$0292FD	|
	BEQ CODE_029305				;$0292FF	|
	LDA.l DATA_00BA70,X			;$029301	|
CODE_029305:
	CLC
	ADC $00					;$029306	|
	STA $05					;$029308	|
	LDA.l DATA_00BA9C,X			;$02930A	|
	LDY $0F					;$02930E	|
	BEQ CODE_029316				;$029310	|
	LDA.l DATA_00BAAC,X			;$029312	|
CODE_029316:
	ADC $02
	STA $06					;$029318	|
CODE_02931A:
	LDA.b #$7E
	STA $07					;$02931C	|
	LDX.w $1698				;$02931E	|
	LDA [$05]				;$029321	|
	STA.w $1693				;$029323	|
	INC $07					;$029326	|
	LDA [$05]				;$029328	|
	BNE Return029355			;$02932A	|
	LDA.w $1693				;$02932C	|
	CMP.b #$2B				;$02932F	|
	BNE Return029355			;$029331	|
	LDA.w $16A1,X				;$029333	|
	PHA					;$029336	|
	SBC.b #$03				;$029337	|
	AND.b #$F0				;$029339	|
	STA.w $16A1,X				;$02933B	|
	LDA.w $16A9,X				;$02933E	|
	PHA					;$029341	|
	SBC.b #$00				;$029342	|
	STA.w $16A9,X				;$029344	|
	JSR InvisSldFromBncSpr			;$029347	|
	JSR ADDR_029356				;$02934A	|
	PLA					;$02934D	|
	STA.w $16A9,X				;$02934E	|
	PLA					;$029351	|
	STA.w $16A1,X				;$029352	|
Return029355:
	RTS

ADDR_029356:
	LDY.b #$03
ADDR_029358:
	LDA.w $17D0,Y
	BEQ ADDR_029361				;$02935B	|
	DEY					;$02935D	|
	BPL ADDR_029358				;$02935E	|
	INY					;$029360	|
ADDR_029361:
	LDA.b #$01
	STA.w $17D0,Y				;$029363	|
	JSL CODE_05B34A				;$029366	|
	LDA.w $16A5,X				;$02936A	|
	STA.w $17E0,Y				;$02936D	|
	LDA.w $16AD,X				;$029370	|
	STA.w $17EC,Y				;$029373	|
	LDA.w $16A1,X				;$029376	|
	STA.w $17D4,Y				;$029379	|
	LDA.w $16A9,X				;$02937C	|
	STA.w $17E8,Y				;$02937F	|
	LDA.w $16C9,X				;$029382	|
	ASL					;$029385	|
	ROL					;$029386	|
	AND.b #$01				;$029387	|
	STA.w $17E4,Y				;$029389	|
	LDA.b #$D0				;$02938C	|
	STA.w $17D8,Y				;$02938E	|
Return029391:
	RTS

DATA_029392:
	db $F8,$08

CODE_029394:
	STZ.w $16CD,X
Return029397:
	RTS

CODE_029398:
	LDA.w $16CD,X
	BEQ Return029397			;$02939B	|
	DEC.w $18F8,X				;$02939D	|
	BEQ CODE_029394				;$0293A0	|
	LDA.w $18F8,X				;$0293A2	|
	CMP.b #$03				;$0293A5	|
	BCS Return029391			;$0293A7	|
	LDY.w $1698				;$0293A9	|
	STZ $0E					;$0293AC	|
CODE_0293AE:
	LDX.b #$0B
CODE_0293B0:
	STX.w $15E9
	LDA.w $14C8,X				;$0293B3	|
	CMP.b #$0B				;$0293B6	|
	BEQ CODE_0293F7				;$0293B8	|
	CMP.b #$08				;$0293BA	|
	BCC CODE_0293F7				;$0293BC	|
	LDA.w $166E,X				;$0293BE	|
	AND.b #$20				;$0293C1	|
	ORA.w $15D0,X				;$0293C3	|
	ORA.w $154C,X				;$0293C6	|
	ORA.w $1FE2,X				;$0293C9	|
	BNE CODE_0293F7				;$0293CC	|
	LDA.w $1632,X				;$0293CE	|
	PHY					;$0293D1	|
	LDY $74					;$0293D2	|
	BEQ CODE_0293D8				;$0293D4	|
	EOR.b #$01				;$0293D6	|
CODE_0293D8:
	PLY
	EOR.w $13F9				;$0293D9	|
	BNE CODE_0293F7				;$0293DC	|
	JSL GetSpriteClippingA			;$0293DE	|
	LDA $0E					;$0293E2	|
	BEQ CODE_0293EB				;$0293E4	|
	JSR CODE_029696				;$0293E6	|
	BRA CODE_0293EE				;$0293E9	|

CODE_0293EB:
	JSR CODE_029663
CODE_0293EE:
	JSL CheckForContact
	BCC CODE_0293F7				;$0293F2	|
	JSR CODE_029404				;$0293F4	|
CODE_0293F7:
	LDY.w $1698
	DEX					;$0293FA	|
	BMI CODE_029400				;$0293FB	|
	JMP CODE_0293B0				;$0293FD	|

CODE_029400:
	LDX.w $1698
	RTS					;$029403	|

CODE_029404:
	LDA.b #$08
	STA.w $154C,X				;$029406	|
	LDA $9E,X				;$029409	|
	CMP.b #$81				;$02940B	|
	BNE CODE_029427				;$02940D	|
	LDA $C2,X				;$02940F	|
	BEQ Return029426			;$029411	|
	STZ $C2,X				;$029413	|
	LDA.b #$C0				;$029415	|
	STA $AA,X				;$029417	|
	LDA.b #$10				;$029419	|
	STA.w $1540,X				;$02941B	|
	STZ.w $157C,X				;$02941E	|
	LDA.b #$20				;$029421	|
	STA.w $1558,X				;$029423	|
Return029426:
	RTS

CODE_029427:
	CMP.b #$2D
	BEQ CODE_029448				;$029429	|
	LDA.w $167A,X				;$02942B	|
	AND.b #$02				;$02942E	|
	BNE CODE_0294A2				;$029430	|
	LDA.w $14C8,X				;$029432	|
	CMP.b #$08				;$029435	|
	BEQ CODE_029443				;$029437	|
	LDA $9E,X				;$029439	|
	CMP.b #$0D				;$02943B	|
	BEQ CODE_029448				;$02943D	|
	LDA $C2,X				;$02943F	|
	BEQ CODE_029448				;$029441	|
CODE_029443:
	LDA.b #$FF
	STA.w $1540,X				;$029445	|
CODE_029448:
	STZ.w $1558,X
	LDA $0E					;$02944B	|
	CMP.b #$35				;$02944D	|
	BEQ CODE_029455				;$02944F	|
	JSL CODE_01AB6F				;$029451	|
CODE_029455:
	LDA.b #$00
	JSL GivePoints				;$029457	|
	LDA.b #$02				;$02945B	|
	STA.w $14C8,X				;$02945D	|
	LDA $9E,X				;$029460	|
	CMP.b #$1E				;$029462	|
	BNE CODE_02946B				;$029464	|
	LDA.b #$1F				;$029466	|
	STA.w $1549				;$029468	|
CODE_02946B:
	LDA.w $1662,X
	AND.b #$80				;$02946E	|
	BNE CODE_0294A2				;$029470	|
	LDA.w $1656,X				;$029472	|
	AND.b #$10				;$029475	|
	BEQ CODE_0294A2				;$029477	|
	LDA.w $1656,X				;$029479	|
	AND.b #$20				;$02947C	|
	BNE CODE_0294A2				;$02947E	|
	LDA.b #$09				;$029480	|
	STA.w $14C8,X				;$029482	|
	ASL.w $15F6,X				;$029485	|
	SEC					;$029488	|
	ROR.w $15F6,X				;$029489	|
	LDA.w $1686,X				;$02948C	|
	AND.b #$40				;$02948F	|
	BEQ CODE_0294A2				;$029491	|
	PHX					;$029493	|
	LDA $9E,X				;$029494	|
	TAX					;$029496	|
	LDA.l SpriteToSpawn,X			;$029497	|
	PLX					;$02949B	|
	STA $9E,X				;$02949C	|
	JSL LoadSpriteTables			;$02949E	|
CODE_0294A2:
	LDA.b #$C0
	LDY $0E					;$0294A4	|
	BEQ CODE_0294B0				;$0294A6	|
	LDA.b #$B0				;$0294A8	|
	CPY.b #$02				;$0294AA	|
	BNE CODE_0294B0				;$0294AC	|
	LDA.b #$C0				;$0294AE	|
CODE_0294B0:
	STA $AA,X
	JSR SubHorzPosBnk2			;$0294B2	|
	LDA.w DATA_029392,Y			;$0294B5	|
	STA $B6,X				;$0294B8	|
	TYA					;$0294BA	|
	EOR.b #$01				;$0294BB	|
	STA.w $157C,X				;$0294BD	|
	RTS					;$0294C0	|

GroundPound:
	LDA.b #$30
	STA.w $1887				;$0294C3	|
	STZ.w $14A9				;$0294C6	|
	PHB					;$0294C9	|
	PHK					;$0294CA	|
	PLB					;$0294CB	|
	LDX.b #$09				;$0294CC	|
KillSprLoopStart:
	LDA.w $14C8,X
	CMP.b #$08				;$0294D1	|
	BCC GroundPoundNextSpr			;$0294D3	|
	LDA.w $1588,X				;$0294D5	|
	AND.b #$04				;$0294D8	|
	BEQ GroundPoundNextSpr			;$0294DA	|
	LDA.w $166E,X				;$0294DC	|
	AND.b #$20				;$0294DF	|
	ORA.w $15D0,X				;$0294E1	|
	ORA.w $154C,X				;$0294E4	|
	BNE GroundPoundNextSpr			;$0294E7	|
	LDA.b #$35				;$0294E9	|
	STA $0E					;$0294EB	|
	JSR CODE_029404				;$0294ED	|
GroundPoundNextSpr:
	DEX
	BPL KillSprLoopStart			;$0294F1	|
	PLB					;$0294F3	|
	RTL					;$0294F4	|

CODE_0294F5:
	LDA.w $13E8
	BEQ Return02950A			;$0294F8	|
	STA $0E					;$0294FA	|
	LDA $13					;$0294FC	|
	LSR					;$0294FE	|
	BCC CODE_029507				;$0294FF	|
	JSR CODE_0293AE				;$029501	|
	JSR CODE_029631				;$029504	|
CODE_029507:
	JSR CODE_02950B
Return02950A:
	RTS

CODE_02950B:
	STZ $0F
	JSR CODE_029540				;$02950D	|
	LDA $5B					;$029510	|
	BPL Return02953B			;$029512	|
	INC $0F					;$029514	|
	LDA.w $13E9				;$029516	|
	CLC					;$029519	|
	ADC $26					;$02951A	|
	STA.w $13E9				;$02951C	|
	LDA.w $13EA				;$02951F	|
	ADC $27					;$029522	|
	STA.w $13EA				;$029524	|
	LDA.w $13EB				;$029527	|
	CLC					;$02952A	|
	ADC $28					;$02952B	|
	STA.w $13EB				;$02952D	|
	LDA.w $13EC				;$029530	|
	ADC $29					;$029533	|
	STA.w $13EC				;$029535	|
	JSR CODE_029540				;$029538	|
Return02953B:
	RTS

DATA_02953C:
	db $08,$08

DATA_02953E:
	db $02,$0E

CODE_029540:
	LDA $13
	AND.b #$01				;$029542	|
	TAY					;$029544	|
	LDA $0F					;$029545	|
	INC A					;$029547	|
	AND $5B					;$029548	|
	BEQ CODE_0295AE				;$02954A	|
	LDA.w $13EB				;$02954C	|
	CLC					;$02954F	|
	ADC.w DATA_02953C,Y			;$029550	|
	AND.b #$F0				;$029553	|
	STA $00					;$029555	|
	STA $98					;$029557	|
	LDA.w $13EC				;$029559	|
	ADC.b #$00				;$02955C	|
	CMP $5D					;$02955E	|
	BCS Return0295AD			;$029560	|
	STA $03					;$029562	|
	STA $99					;$029564	|
	LDA.w $13E9				;$029566	|
	CLC					;$029569	|
	ADC.w DATA_02953E,Y			;$02956A	|
	STA $01					;$02956D	|
	STA $9A					;$02956F	|
	LDA.w $13EA				;$029571	|
	ADC.b #$00				;$029574	|
	CMP.b #$02				;$029576	|
	BCS Return0295AD			;$029578	|
	STA $02					;$02957A	|
	STA $9B					;$02957C	|
	LDA $01					;$02957E	|
	LSR					;$029580	|
	LSR					;$029581	|
	LSR					;$029582	|
	LSR					;$029583	|
	ORA $00					;$029584	|
	STA $00					;$029586	|
	LDX $03					;$029588	|
	LDA.l DATA_00BA80,X			;$02958A	|
	LDY $0F					;$02958E	|
	BEQ CODE_029596				;$029590	|
	LDA.l DATA_00BA8E,X			;$029592	|
CODE_029596:
	CLC
	ADC $00					;$029597	|
	STA $05					;$029599	|
	LDA.l DATA_00BABC,X			;$02959B	|
	LDY $0F					;$02959F	|
	BEQ CODE_0295A7				;$0295A1	|
	LDA.l DATA_00BACA,X			;$0295A3	|
CODE_0295A7:
	ADC $02
	STA $06					;$0295A9	|
	BRA CODE_02960D				;$0295AB	|

Return0295AD:
	RTS

CODE_0295AE:
	LDA.w $13EB
	CLC					;$0295B1	|
	ADC.w DATA_02953C,Y			;$0295B2	|
	AND.b #$F0				;$0295B5	|
	STA $00					;$0295B7	|
	STA $98					;$0295B9	|
	LDA.w $13EC				;$0295BB	|
	ADC.b #$00				;$0295BE	|
	CMP.b #$02				;$0295C0	|
	BCS Return0295AD			;$0295C2	|
	STA $02					;$0295C4	|
	STA $99					;$0295C6	|
	LDA.w $13E9				;$0295C8	|
	CLC					;$0295CB	|
	ADC.w DATA_02953E,Y			;$0295CC	|
	STA $01					;$0295CF	|
	STA $9A					;$0295D1	|
	LDA.w $13EA				;$0295D3	|
	ADC.b #$00				;$0295D6	|
	CMP $5D					;$0295D8	|
	BCS Return0295AD			;$0295DA	|
	STA $03					;$0295DC	|
	STA $9B					;$0295DE	|
	LDA $01					;$0295E0	|
	LSR					;$0295E2	|
	LSR					;$0295E3	|
	LSR					;$0295E4	|
	LSR					;$0295E5	|
	ORA $00					;$0295E6	|
	STA $00					;$0295E8	|
	LDX $03					;$0295EA	|
	LDA.l DATA_00BA60,X			;$0295EC	|
	LDY $0F					;$0295F0	|
	BEQ CODE_0295F8				;$0295F2	|
	LDA.l DATA_00BA70,X			;$0295F4	|
CODE_0295F8:
	CLC
	ADC $00					;$0295F9	|
	STA $05					;$0295FB	|
	LDA.l DATA_00BA9C,X			;$0295FD	|
	LDY $0F					;$029601	|
	BEQ CODE_029609				;$029603	|
	LDA.l DATA_00BAAC,X			;$029605	|
CODE_029609:
	ADC $02
	STA $06					;$02960B	|
CODE_02960D:
	LDA.b #$7E
	STA $07					;$02960F	|
	LDA [$05]				;$029611	|
	STA.w $1693				;$029613	|
	INC $07					;$029616	|
	LDA [$05]				;$029618	|
	JSL conditional_map16			;$02961A	|
	CMP.b #$00				;$02961E	|
	BEQ Return029630			;$029620	|
	LDA $0F					;$029622	|
	STA.w $1933				;$029624	|
	LDA.w $1693				;$029627	|
	LDY.b #$00				;$02962A	|
	JSL CODE_00F160				;$02962C	|
Return029630:
	RTS

CODE_029631:
	LDX.b #$07
CODE_029633:
	STX.w $15E9
	LDA.w $170B,X				;$029636	|
	CMP.b #$02				;$029639	|
	BCC CODE_029653				;$02963B	|
	JSR CODE_02A519				;$02963D	|
	JSR CODE_029696				;$029640	|
	JSL CheckForContact			;$029643	|
	BCC CODE_029653				;$029647	|
	LDA.w $170B,X				;$029649	|
	CMP.b #$12				;$02964C	|
	BEQ CODE_029653				;$02964E	|
	JSR CODE_02A4DE				;$029650	|
CODE_029653:
	DEX
	BPL CODE_029633				;$029654	|
Return029656:
	RTS

DATA_029657:
	db $FC

DATA_029658:
	db $E0,$FF

DATA_02965A:
	db $FF,$18

DATA_02965C:
	db $50,$FC

DATA_02965E:
	db $F8,$FF

DATA_029660:
	db $FF,$18,$10

CODE_029663:
	PHX
	LDA.w $16CD,Y				;$029664	|
	TAX					;$029667	|
	LDA.w $16D1,Y				;$029668	|
	CLC					;$02966B	|
	ADC.w Return029656,X			;$02966C	|
	STA $00					;$02966F	|
	LDA.w $16D5,Y				;$029671	|
	ADC.w DATA_029658,X			;$029674	|
	STA $08					;$029677	|
	LDA.w DATA_02965A,X			;$029679	|
	STA $02					;$02967C	|
	LDA.w $16D9,Y				;$02967E	|
	CLC					;$029681	|
	ADC.w DATA_02965C,X			;$029682	|
	STA $01					;$029685	|
	LDA.w $16DD,Y				;$029687	|
	ADC.w DATA_02965E,X			;$02968A	|
	STA $09					;$02968D	|
	LDA.w DATA_029660,X			;$02968F	|
	STA $03					;$029692	|
	PLX					;$029694	|
	RTS					;$029695	|

CODE_029696:
	LDA.w $13E9
	SEC					;$029699	|
	SBC.b #$02				;$02969A	|
	STA $00					;$02969C	|
	LDA.w $13EA				;$02969E	|
	SBC.b #$00				;$0296A1	|
	STA $08					;$0296A3	|
	LDA.b #$14				;$0296A5	|
	STA $02					;$0296A7	|
	LDA.w $13EB				;$0296A9	|
	STA $01					;$0296AC	|
	LDA.w $13EC				;$0296AE	|
	STA $09					;$0296B1	|
	LDA.b #$10				;$0296B3	|
	STA $03					;$0296B5	|
	RTS					;$0296B7	|

DATA_0296B8:
	db $20,$24,$28,$2C

DATA_0296BC:
	db $90,$94,$98,$9C

CODE_0296C0:
	LDA.w $17C0,X
	BEQ Return0296D7			;$0296C3	|
	AND.b #$7F				;$0296C5	|
	JSL execute_pointer			;$0296C7	|

Ptrs0296CB:
	dw Return0296D7
	dw CODE_0296E3
	dw CODE_029797
	dw CODE_029927
	dw Return0296D7
	dw CODE_0298CA

Return0296D7:
	RTS

DATA_0296D8:
	db $66,$66,$64,$62,$60,$62,$60

CODE_0296DF:
	STZ.w $17C0,X
	RTS					;$0296E2	|

CODE_0296E3:
	LDA.w $17CC,X
	BEQ CODE_0296DF				;$0296E6	|
	LDA.w $17C0,X				;$0296E8	|
	BMI CODE_0296F1				;$0296EB	|
	LDA $9D					;$0296ED	|
	BNE CODE_0296F4				;$0296EF	|
CODE_0296F1:
	DEC.w $17CC,X
CODE_0296F4:
	LDA $A5
	CMP.b #$A9				;$0296F6	|
	BEQ CODE_02974A				;$0296F8	|
	LDA.w $0D9B				;$0296FA	|
	AND.b #$40				;$0296FD	|
	BEQ CODE_02974A				;$0296FF	|
	LDY.w DATA_0296BC,X			;$029701	|
	LDA.w $17C8,X				;$029704	|
	SEC					;$029707	|
	SBC $1A					;$029708	|
	CMP.b #$F4				;$02970A	|
	BCS CODE_0296DF				;$02970C	|
	STA.w $0300,Y				;$02970E	|
	LDA.w $17C4,X				;$029711	|
	SEC					;$029714	|
	SBC $1C					;$029715	|
	CMP.b #$E0				;$029717	|
	BCS CODE_0296DF				;$029719	|
	STA.w $0301,Y				;$02971B	|
	LDA.w $17CC,X				;$02971E	|
	CMP.b #$08				;$029721	|
	LDA.b #$00				;$029723	|
	BCS CODE_02972D				;$029725	|
	ASL					;$029727	|
	ASL					;$029728	|
	ASL					;$029729	|
	ASL					;$02972A	|
	AND.b #$40				;$02972B	|
CODE_02972D:
	ORA $64
	STA.w $0303,Y				;$02972F	|
	LDA.w $17CC,X				;$029732	|
	PHY					;$029735	|
	LSR					;$029736	|
	LSR					;$029737	|
	TAY					;$029738	|
	LDA.w DATA_0296D8,Y			;$029739	|
	PLY					;$02973C	|
	STA.w $0302,Y				;$02973D	|
	TYA					;$029740	|
	LSR					;$029741	|
	LSR					;$029742	|
	TAY					;$029743	|
	LDA.b #$02				;$029744	|
	STA.w $0460,Y				;$029746	|
	RTS					;$029749	|

CODE_02974A:
	LDY.w DATA_0296B8,X
	LDA.w $17C8,X				;$02974D	|
	SEC					;$029750	|
	SBC $1A					;$029751	|
	CMP.b #$F4				;$029753	|
	BCS CODE_029793				;$029755	|
	STA.w $0200,Y				;$029757	|
	LDA.w $17C4,X				;$02975A	|
	SEC					;$02975D	|
	SBC $1C					;$02975E	|
	CMP.b #$E0				;$029760	|
	BCS CODE_029793				;$029762	|
	STA.w $0201,Y				;$029764	|
	LDA.w $17CC,X				;$029767	|
	CMP.b #$08				;$02976A	|
	LDA.b #$00				;$02976C	|
	BCS CODE_029776				;$02976E	|
	ASL					;$029770	|
	ASL					;$029771	|
	ASL					;$029772	|
	ASL					;$029773	|
	AND.b #$40				;$029774	|
CODE_029776:
	ORA $64
	STA.w $0203,Y				;$029778	|
	LDA.w $17CC,X				;$02977B	|
	PHY					;$02977E	|
	LSR					;$02977F	|
	LSR					;$029780	|
	TAY					;$029781	|
	LDA.w DATA_0296D8,Y			;$029782	|
	PLY					;$029785	|
	STA.w $0202,Y				;$029786	|
	TYA					;$029789	|
	LSR					;$02978A	|
	LSR					;$02978B	|
	TAY					;$02978C	|
	LDA.b #$02				;$02978D	|
	STA.w $0420,Y				;$02978F	|
	RTS					;$029792	|

CODE_029793:
	STZ.w $17C0,X
	RTS					;$029796	|

CODE_029797:
	LDA.w $17CC,X
	BEQ CODE_029793				;$02979A	|
	LDY $9D					;$02979C	|
	BNE CODE_0297A3				;$02979E	|
	DEC.w $17CC,X				;$0297A0	|
CODE_0297A3:
	BIT.w $0D9B
	BVC CODE_0297B2				;$0297A6	|
	LDA.w $0D9B				;$0297A8	|
	CMP.b #$C1				;$0297AB	|
	BEQ CODE_0297B2				;$0297AD	|
	JMP CODE_029838				;$0297AF	|

CODE_0297B2:
	LDY.b #$F0
	LDA.w $17C8,X				;$0297B4	|
	SEC					;$0297B7	|
	SBC $1A					;$0297B8	|
	CMP.b #$F0				;$0297BA	|
	BCS CODE_029793				;$0297BC	|
	STA.w $0200,Y				;$0297BE	|
	STA.w $0208,Y				;$0297C1	|
	CLC					;$0297C4	|
	ADC.b #$08				;$0297C5	|
	STA.w $0204,Y				;$0297C7	|
	STA.w $020C,Y				;$0297CA	|
	LDA.w $17C4,X				;$0297CD	|
	SEC					;$0297D0	|
	SBC $1C					;$0297D1	|
	STA.w $0201,Y				;$0297D3	|
	STA.w $0205,Y				;$0297D6	|
	CLC					;$0297D9	|
	ADC.b #$08				;$0297DA	|
	STA.w $0209,Y				;$0297DC	|
	STA.w $020D,Y				;$0297DF	|
	LDA.w $17CC,X				;$0297E2	|
	ASL					;$0297E5	|
	ASL					;$0297E6	|
	ASL					;$0297E7	|
	ASL					;$0297E8	|
	ASL					;$0297E9	|
	AND.b #$40				;$0297EA	|
	ORA $64					;$0297EC	|
	STA.w $0203,Y				;$0297EE	|
	STA.w $0207,Y				;$0297F1	|
	EOR.b #$C0				;$0297F4	|
	STA.w $020B,Y				;$0297F6	|
	STA.w $020F,Y				;$0297F9	|
	LDA.w $17CC,X				;$0297FC	|
	AND.b #$02				;$0297FF	|
	BNE CODE_029815				;$029801	|
	LDA.b #$7C				;$029803	|
	STA.w $0202,Y				;$029805	|
	STA.w $020E,Y				;$029808	|
	LDA.b #$7D				;$02980B	|
	STA.w $0206,Y				;$02980D	|
	STA.w $020A,Y				;$029810	|
	BRA CODE_029825				;$029813	|

CODE_029815:
	LDA.b #$7D
	STA.w $0202,Y				;$029817	|
	STA.w $020E,Y				;$02981A	|
	LDA.b #$7C				;$02981D	|
	STA.w $0206,Y				;$02981F	|
	STA.w $020A,Y				;$029822	|
CODE_029825:
	TYA
	LSR					;$029826	|
	LSR					;$029827	|
	TAY					;$029828	|
	LDA.b #$00				;$029829	|
	STA.w $0420,Y				;$02982B	|
	STA.w $0421,Y				;$02982E	|
	STA.w $0422,Y				;$029831	|
	STA.w $0423,Y				;$029834	|
	RTS					;$029837	|

CODE_029838:
	LDY.b #$90
	LDA.w $17C8,X				;$02983A	|
	SEC					;$02983D	|
	SBC $1A					;$02983E	|
	CMP.b #$F0				;$029840	|
	BCS CODE_0298BE				;$029842	|
	STA.w $0300,Y				;$029844	|
	STA.w $0308,Y				;$029847	|
	CLC					;$02984A	|
	ADC.b #$08				;$02984B	|
	STA.w $0304,Y				;$02984D	|
	STA.w $030C,Y				;$029850	|
	LDA.w $17C4,X				;$029853	|
	SEC					;$029856	|
	SBC $1C					;$029857	|
	STA.w $0301,Y				;$029859	|
	STA.w $0305,Y				;$02985C	|
	CLC					;$02985F	|
	ADC.b #$08				;$029860	|
	STA.w $0309,Y				;$029862	|
	STA.w $030D,Y				;$029865	|
	LDA.w $17CC,X				;$029868	|
	ASL					;$02986B	|
	ASL					;$02986C	|
	ASL					;$02986D	|
	ASL					;$02986E	|
	ASL					;$02986F	|
	AND.b #$40				;$029870	|
	ORA $64					;$029872	|
	STA.w $0303,Y				;$029874	|
	STA.w $0307,Y				;$029877	|
	EOR.b #$C0				;$02987A	|
	STA.w $030B,Y				;$02987C	|
	STA.w $030F,Y				;$02987F	|
	LDA.w $17CC,X				;$029882	|
	AND.b #$02				;$029885	|
	BNE CODE_02989B				;$029887	|
	LDA.b #$7C				;$029889	|
	STA.w $0302,Y				;$02988B	|
	STA.w $030E,Y				;$02988E	|
	LDA.b #$7D				;$029891	|
	STA.w $0306,Y				;$029893	|
	STA.w $030A,Y				;$029896	|
	BRA CODE_0298AB				;$029899	|

CODE_02989B:
	LDA.b #$7D
	STA.w $0302,Y				;$02989D	|
	STA.w $030E,Y				;$0298A0	|
	LDA.b #$7C				;$0298A3	|
	STA.w $0306,Y				;$0298A5	|
	STA.w $030A,Y				;$0298A8	|
CODE_0298AB:
	TYA
	LSR					;$0298AC	|
	LSR					;$0298AD	|
	TAY					;$0298AE	|
	LDA.b #$00				;$0298AF	|
	STA.w $0460,Y				;$0298B1	|
	STA.w $0461,Y				;$0298B4	|
	STA.w $0462,Y				;$0298B7	|
	STA.w $0463,Y				;$0298BA	|
	RTS					;$0298BD	|

CODE_0298BE:
	STZ.w $17C0,X
	RTS					;$0298C1	|

DATA_0298C2:
	db $04,$08,$04,$00

DATA_0298C6:
	db $FC,$04,$0C,$04

CODE_0298CA:
	LDA.w $17CC,X
	BEQ CODE_0298BE				;$0298CD	|
	LDY $9D					;$0298CF	|
	BNE Return029921			;$0298D1	|
	DEC.w $17CC,X				;$0298D3	|
	AND.b #$03				;$0298D6	|
	BNE Return029921			;$0298D8	|
	LDY.b #$0B				;$0298DA	|
CODE_0298DC:
	LDA.w $17F0,Y
	BEQ CODE_0298F1				;$0298DF	|
	DEY					;$0298E1	|
	BPL CODE_0298DC				;$0298E2	|
	DEC.w $185D				;$0298E4	|
	BPL CODE_0298EE				;$0298E7	|
	LDA.b #$0B				;$0298E9	|
	STA.w $185D				;$0298EB	|
CODE_0298EE:
	LDY.w $185D
CODE_0298F1:
	LDA.b #$02
	STA.w $17F0,Y				;$0298F3	|
	LDA.w $17C4,X				;$0298F6	|
	STA $01					;$0298F9	|
	LDA.w $17C8,X				;$0298FB	|
	STA $00					;$0298FE	|
	LDA.w $17CC,X				;$029900	|
	LSR					;$029903	|
	LSR					;$029904	|
	AND.b #$03				;$029905	|
	PHX					;$029907	|
	TAX					;$029908	|
	LDA.w DATA_0298C2,X			;$029909	|
	CLC					;$02990C	|
	ADC $00					;$02990D	|
	STA.w $1808,Y				;$02990F	|
	LDA.w DATA_0298C6,X			;$029912	|
	CLC					;$029915	|
	ADC $01					;$029916	|
	STA.w $17FC,Y				;$029918	|
	PLX					;$02991B	|
	LDA.b #$17				;$02991C	|
	STA.w $1850,Y				;$02991E	|
Return029921:
	RTS

DATA_029922:
	db $66,$66,$64,$62,$62

CODE_029927:
	LDA.w $17CC,X
	BNE CODE_029941				;$02992A	|
	BIT.w $0D9B				;$02992C	|
	BVC CODE_02993E				;$02992F	|
	LDA.w $140F				;$029931	|
	BNE CODE_02993E				;$029934	|
	LDY.w DATA_0296BC,X			;$029936	|
	LDA.b #$F0				;$029939	|
	STA.w $0301,Y				;$02993B	|
CODE_02993E:
	JMP CODE_029793

CODE_029941:
	LDY $9D
	BNE CODE_02994F				;$029943	|
	DEC.w $17CC,X				;$029945	|
	AND.b #$07				;$029948	|
	BNE CODE_02994F				;$02994A	|
	DEC.w $17C4,X				;$02994C	|
CODE_02994F:
	LDA $A5
	CMP.b #$A9				;$029951	|
	BEQ CODE_02996C				;$029953	|
	LDA.w $140F				;$029955	|
	BNE CODE_02996C				;$029958	|
	LDA.w $0D9B				;$02995A	|
	BPL CODE_02996C				;$02995D	|
	CMP.b #$C1				;$02995F	|
	BEQ CODE_029967				;$029961	|
	AND.b #$40				;$029963	|
	BNE CODE_02999F				;$029965	|
CODE_029967:
	LDY.w DATA_0296BC,X
	BRA CODE_02996F				;$02996A	|

CODE_02996C:
	LDY.w DATA_0296B8,X
CODE_02996F:
	LDA.w $17C8,X
	SEC					;$029972	|
	SBC $1A					;$029973	|
	STA.w $0200,Y				;$029975	|
	LDA.w $17C4,X				;$029978	|
	SEC					;$02997B	|
	SBC $1C					;$02997C	|
	STA.w $0201,Y				;$02997E	|
	LDA $64					;$029981	|
	STA.w $0203,Y				;$029983	|
	LDA.w $17CC,X				;$029986	|
	LSR					;$029989	|
	LSR					;$02998A	|
	TAX					;$02998B	|
	LDA.w DATA_029922,X			;$02998C	|
	LDX.w $1698				;$02998F	|
	STA.w $0202,Y				;$029992	|
	TYA					;$029995	|
	LSR					;$029996	|
	LSR					;$029997	|
	TAY					;$029998	|
	LDA.b #$00				;$029999	|
	STA.w $0420,Y				;$02999B	|
	RTS					;$02999E	|

CODE_02999F:
	LDY.w DATA_0296BC,X
	LDA.w $17C8,X				;$0299A2	|
	SEC					;$0299A5	|
	SBC $1A					;$0299A6	|
	STA.w $0300,Y				;$0299A8	|
	LDA.w $17C4,X				;$0299AB	|
	SEC					;$0299AE	|
	SBC $1C					;$0299AF	|
	STA.w $0301,Y				;$0299B1	|
	LDA $64					;$0299B4	|
	STA.w $0303,Y				;$0299B6	|
	LDA.w $17CC,X				;$0299B9	|
	LSR					;$0299BC	|
	LSR					;$0299BD	|
	TAX					;$0299BE	|
	LDA.w DATA_029922,X			;$0299BF	|
	LDX.w $1698				;$0299C2	|
	STA.w $0302,Y				;$0299C5	|
	TYA					;$0299C8	|
	LSR					;$0299C9	|
	LSR					;$0299CA	|
	TAY					;$0299CB	|
	LDA.b #$00				;$0299CC	|
	STA.w $0460,Y				;$0299CE	|
	RTS					;$0299D1	|

CODE_0299D2:
	LDX.b #$03
CODE_0299D4:
	STX.w $15E9
	LDA.w $17D0,X				;$0299D7	|
	BEQ CODE_0299DF				;$0299DA	|
	JSR CODE_0299F1				;$0299DC	|
CODE_0299DF:
	DEX
	BPL CODE_0299D4				;$0299E0	|
	RTS					;$0299E2	|

CODE_0299E3:
	LDA.b #$00
	STA.w $17D0,X				;$0299E5	|
	RTS					;$0299E8	|

DATA_0299E9:
	db $30,$38,$40,$48,$EC,$EA,$E8,$EC

CODE_0299F1:
	LDA $9D
	BNE CODE_029A08				;$0299F3	|
	JSR CODE_02B58E				;$0299F5	|
	LDA.w $17D8,X				;$0299F8	|
	CLC					;$0299FB	|
	ADC.b #$03				;$0299FC	|
	STA.w $17D8,X				;$0299FE	|
	CMP.b #$20				;$029A01	|
	BMI CODE_029A08				;$029A03	|
	JMP CODE_029AA8				;$029A05	|

CODE_029A08:
	LDA.w $17E4,X
	ASL					;$029A0B	|
	ASL					;$029A0C	|
	TAY					;$029A0D	|
	LDA.w $001C,y				;$029A0E	|
	STA $02					;$029A11	|
	LDA.w $001A,y				;$029A13	|
	STA $03					;$029A16	|
	LDA.w $001D,y				;$029A18	|
	STA $04					;$029A1B	|
	LDA.w $17D4,X				;$029A1D	|
	CMP $02					;$029A20	|
	LDA.w $17E8,X				;$029A22	|
	SBC $04					;$029A25	|
	BNE Return029A6D			;$029A27	|
	LDA.w $17E0,X				;$029A29	|
	SEC					;$029A2C	|
	SBC $03					;$029A2D	|
	CMP.b #$F8				;$029A2F	|
	BCS CODE_0299E3				;$029A31	|
	STA $00					;$029A33	|
	LDA.w $17D4,X				;$029A35	|
	SEC					;$029A38	|
	SBC $02					;$029A39	|
	STA $01					;$029A3B	|
	LDY.w DATA_0299E9,X			;$029A3D	|
	STY $0F					;$029A40	|
	LDY $0F					;$029A42	|
	LDA $00					;$029A44	|
	STA.w $0200,Y				;$029A46	|
	LDA $01					;$029A49	|
	STA.w $0201,Y				;$029A4B	|
	LDA.b #$E8				;$029A4E	|
	STA.w $0202,Y				;$029A50	|
	LDA.b #$04				;$029A53	|
	ORA $64					;$029A55	|
	STA.w $0203,Y				;$029A57	|
	TYA					;$029A5A	|
	LSR					;$029A5B	|
	LSR					;$029A5C	|
	TAY					;$029A5D	|
	LDA.b #$02				;$029A5E	|
	STA.w $0420,Y				;$029A60	|
	TXA					;$029A63	|
	CLC					;$029A64	|
	ADC $14					;$029A65	|
	LSR					;$029A67	|
	LSR					;$029A68	|
	AND.b #$03				;$029A69	|
	BNE CODE_029A71				;$029A6B	|
Return029A6D:
	RTS

RollingCoinTiles:
	db $EA,$FA,$EA

CODE_029A71:
	LDY $0F
	PHX					;$029A73	|
	TAX					;$029A74	|
	LDA $00					;$029A75	|
	CLC					;$029A77	|
	ADC.b #$04				;$029A78	|
	STA.w $0200,Y				;$029A7A	|
	STA.w $0204,Y				;$029A7D	|
	LDA $01					;$029A80	|
	CLC					;$029A82	|
	ADC.b #$08				;$029A83	|
	STA.w $0205,Y				;$029A85	|
	LDA.l Return029A6D,X			;$029A88	|
	STA.w $0202,Y				;$029A8C	|
	STA.w $0206,Y				;$029A8F	|
	LDA.w $0203,Y				;$029A92	|
	ORA.b #$80				;$029A95	|
	STA.w $0207,Y				;$029A97	|
	TYA					;$029A9A	|
	LSR					;$029A9B	|
	LSR					;$029A9C	|
	TAY					;$029A9D	|
	LDA.b #$00				;$029A9E	|
	STA.w $0420,Y				;$029AA0	|
	STA.w $0421,Y				;$029AA3	|
	PLX					;$029AA6	|
	RTS					;$029AA7	|

CODE_029AA8:
	JSL CODE_02AD34
	LDA.b #$01				;$029AAC	|
	STA.w $16E1,Y				;$029AAE	|
	LDA.w $17D4,X				;$029AB1	|
	STA.w $16E7,Y				;$029AB4	|
	LDA.w $17E8,X				;$029AB7	|
	STA.w $16F9,Y				;$029ABA	|
	LDA.w $17E0,X				;$029ABD	|
	STA.w $16ED,Y				;$029AC0	|
	LDA.w $17EC,X				;$029AC3	|
	STA.w $16F3,Y				;$029AC6	|
	LDA.b #$30				;$029AC9	|
	STA.w $16FF,Y				;$029ACB	|
	LDA.w $17E4,X				;$029ACE	|
	STA.w $1705,Y				;$029AD1	|
	JSR CODE_029ADA				;$029AD4	|
	JMP CODE_0299E3				;$029AD7	|

CODE_029ADA:
	LDY.b #$03
CODE_029ADC:
	LDA.w $17C0,Y
	BEQ CODE_029AE5				;$029ADF	|
	DEY					;$029AE1	|
	BPL CODE_029ADC				;$029AE2	|
	RTS					;$029AE4	|

CODE_029AE5:
	LDA.b #$05
	STA.w $17C0,Y				;$029AE7	|
	LDA.w $17E4,X				;$029AEA	|
	LSR					;$029AED	|
	PHP					;$029AEE	|
	LDA.w $17E0,X				;$029AEF	|
	BCC CODE_029AF6				;$029AF2	|
	SBC $26					;$029AF4	|
CODE_029AF6:
	STA.w $17C8,Y
	LDA.w $17D4,X				;$029AF9	|
	PLP					;$029AFC	|
	BCC CODE_029B01				;$029AFD	|
	SBC $28					;$029AFF	|
CODE_029B01:
	STA.w $17C4,Y
	LDA.b #$10				;$029B04	|
	STA.w $17CC,Y				;$029B06	|
	RTS					;$029B09	|

CODE_029B0A:
	LDX.b #$09
CODE_029B0C:
	STX.w $15E9
	JSR CODE_029B16				;$029B0F	|
	DEX					;$029B12	|
	BPL CODE_029B0C				;$029B13	|
Return029B15:
	RTS

CODE_029B16:
	LDA.w $170B,X
	BEQ Return029B15			;$029B19	|
	LDY $9D					;$029B1B	|
	BNE CODE_029B27				;$029B1D	|
	LDY.w $176F,X				;$029B1F	|
	BEQ CODE_029B27				;$029B22	|
	DEC.w $176F,X				;$029B24	|
CODE_029B27:
	JSL execute_pointer

ExtendedSpritePtrs:
	dw Return029B15
	dw SmokePuff
	dw ReznorFireball
	dw FlameRemnant
	dw Hammer
	dw MarioFireball
	dw Baseball
	dw LavaSplash
	dw LauncherArm
	dw UnusedExtendedSpr
	dw CloudCoin
	dw Hammer
	dw VolcanoLotusFire
	dw Baseball
	dw CloudCoin
	dw SmokeTrail
	dw SpinJumpStars
	dw YoshiFireball
	dw WaterBubble

VolcanoLotusFire:
	LDY.w DATA_02A153,X
	LDA.w $171F,X				;$029B54	|
	SEC					;$029B57	|
	SBC $1A					;$029B58	|
	STA $00					;$029B5A	|
	LDA.w $1733,X				;$029B5C	|
	SBC $1B					;$029B5F	|
	BNE CODE_029BDA				;$029B61	|
	LDA.w $1715,X				;$029B63	|
	SEC					;$029B66	|
	SBC $1C					;$029B67	|
	STA $01					;$029B69	|
	LDA.w $1729,X				;$029B6B	|
	SBC $1D					;$029B6E	|
	BEQ CODE_029B76				;$029B70	|
	BMI CODE_029BA5				;$029B72	|
	BPL CODE_029BDA				;$029B74	|
CODE_029B76:
	LDA $00
	STA.w $0200,Y				;$029B78	|
	LDA $01					;$029B7B	|
	CMP.b #$F0				;$029B7D	|
	BCS CODE_029BA5				;$029B7F	|
	STA.w $0201,Y				;$029B81	|
	LDA.b #$09				;$029B84	|
	ORA $64					;$029B86	|
	STA.w $0203,Y				;$029B88	|
	LDA $14					;$029B8B	|
	LSR					;$029B8D	|
	EOR.w $15E9				;$029B8E	|
	LSR					;$029B91	|
	LSR					;$029B92	|
	LDA.b #$A6				;$029B93	|
	BCC CODE_029B99				;$029B95	|
	LDA.b #$B6				;$029B97	|
CODE_029B99:
	STA.w $0202,Y
	TYA					;$029B9C	|
	LSR					;$029B9D	|
	LSR					;$029B9E	|
	TAY					;$029B9F	|
	LDA.b #$00				;$029BA0	|
	STA.w $0420,Y				;$029BA2	|
CODE_029BA5:
	LDA $9D
	BNE Return029BD9			;$029BA7	|
	JSR CODE_02A3F6				;$029BA9	|
	JSR CODE_02B554				;$029BAC	|
	JSR CODE_02B560				;$029BAF	|
	LDA $13					;$029BB2	|
	AND.b #$03				;$029BB4	|
	BNE CODE_029BC2				;$029BB6	|
	LDA.w $173D,X				;$029BB8	|
	CMP.b #$18				;$029BBB	|
	BPL CODE_029BC2				;$029BBD	|
	INC.w $173D,X				;$029BBF	|
CODE_029BC2:
	LDA.w $173D,X
	BMI Return029BD9			;$029BC5	|
	TXA					;$029BC7	|
	ASL					;$029BC8	|
	ASL					;$029BC9	|
	ASL					;$029BCA	|
	ADC $13					;$029BCB	|
	LDY.b #$08				;$029BCD	|
	AND.b #$08				;$029BCF	|
	BNE CODE_029BD5				;$029BD1	|
	LDY.b #$F8				;$029BD3	|
CODE_029BD5:
	TYA
	STA.w $1747,X				;$029BD6	|
Return029BD9:
	RTS

CODE_029BDA:
	STZ.w $170B,X
	RTS					;$029BDD	|

DATA_029BDE:
	db $08,$F8

DATA_029BE0:
	db $00,$FF

DATA_029BE2:
	db $18,$E8

CODE_029BE4:
	LDA.b #$05
	STA.w $1887				;$029BE6	|
	LDA.b #$09				;$029BE9	|
	STA.w $1DFC				;$029BEB	|
	STZ $00					;$029BEE	|
	JSR CODE_029BF5				;$029BF0	|
	INC $00					;$029BF3	|
CODE_029BF5:
	LDY.b #$07
CODE_029BF7:
	LDA.w $170B,Y
	BEQ CODE_029C00				;$029BFA	|
	DEY					;$029BFC	|
	BPL CODE_029BF7				;$029BFD	|
	RTS					;$029BFF	|

CODE_029C00:
	LDA.b #$0F
	STA.w $170B,Y				;$029C02	|
	LDA $96					;$029C05	|
	CLC					;$029C07	|
	ADC.b #$28				;$029C08	|
	STA.w $1715,Y				;$029C0A	|
	LDA $97					;$029C0D	|
	ADC.b #$00				;$029C0F	|
	STA.w $1729,Y				;$029C11	|
	LDX $00					;$029C14	|
	LDA $94					;$029C16	|
	CLC					;$029C18	|
	ADC.w DATA_029BDE,X			;$029C19	|
	STA.w $171F,Y				;$029C1C	|
	LDA $95					;$029C1F	|
	ADC.w DATA_029BE0,X			;$029C21	|
	STA.w $1733,Y				;$029C24	|
	LDA.w DATA_029BE2,X			;$029C27	|
	STA.w $1747,Y				;$029C2A	|
	LDA.b #$15				;$029C2D	|
	STA.w $176F,Y				;$029C2F	|
	RTS					;$029C32	|

SmokeTrailTiles:
	db $66,$64,$62,$60,$60,$60,$60,$60
	db $60,$60,$60

SmokeTrail:
	JSR CODE_02A1A4
	LDY.w DATA_02A153,X			;$029C41	|
	LDA.w $176F,X				;$029C44	|
	LSR					;$029C47	|
	PHX					;$029C48	|
	TAX					;$029C49	|
	LDA $14					;$029C4A	|
	ASL					;$029C4C	|
	ASL					;$029C4D	|
	ASL					;$029C4E	|
	ASL					;$029C4F	|
	AND.b #$C0				;$029C50	|
	ORA.b #$32				;$029C52	|
	STA.w $0203,Y				;$029C54	|
	LDA.w SmokeTrailTiles,X			;$029C57	|
	STA.w $0202,Y				;$029C5A	|
	TYA					;$029C5D	|
	LSR					;$029C5E	|
	LSR					;$029C5F	|
	TAY					;$029C60	|
	LDA.b #$02				;$029C61	|
	STA.w $0420,Y				;$029C63	|
	PLX					;$029C66	|
	LDA $9D					;$029C67	|
	BNE Return029C7E			;$029C69	|
	LDA.w $176F,X				;$029C6B	|
	BEQ CODE_029C7F				;$029C6E	|
	CMP.b #$06				;$029C70	|
	BNE CODE_029C7B				;$029C72	|
	LDA.w $1747,X				;$029C74	|
	ASL					;$029C77	|
	ROR.w $1747,X				;$029C78	|
CODE_029C7B:
	JSR CODE_02B554
Return029C7E:
	RTS

CODE_029C7F:
	STZ.w $170B,X
	RTS					;$029C82	|

SpinJumpStars:
	LDA.w $176F,X
	BEQ CODE_029C7F				;$029C86	|
	JSR CODE_02A1A4				;$029C88	|
	LDY.w DATA_02A153,X			;$029C8B	|
	LDA.b #$34				;$029C8E	|
	STA.w $0203,Y				;$029C90	|
	LDA.b #$EF				;$029C93	|
	STA.w $0202,Y				;$029C95	|
	LDA $9D					;$029C98	|
	BNE Return029CAF			;$029C9A	|
	LDA.w $176F,X				;$029C9C	|
	LSR					;$029C9F	|
	LSR					;$029CA0	|
	TAY					;$029CA1	|
	LDA $13					;$029CA2	|
	AND.w DATA_029CB0,Y			;$029CA4	|
	BNE Return029CAF			;$029CA7	|
	JSR CODE_02B554				;$029CA9	|
	JSR CODE_02B560				;$029CAC	|
Return029CAF:
	RTS

DATA_029CB0:
	db $FF,$07,$01,$00,$00

CloudCoin:
	LDA $9D
	BNE CODE_029CF8				;$029CB7	|
	JSR CODE_02B560				;$029CB9	|
	LDA.w $173D,X				;$029CBC	|
	CMP.b #$30				;$029CBF	|
	BPL CODE_029CC9				;$029CC1	|
	CLC					;$029CC3	|
	ADC.b #$02				;$029CC4	|
	STA.w $173D,X				;$029CC6	|
CODE_029CC9:
	LDA.w $170B,X
	CMP.b #$0E				;$029CCC	|
	BNE ADDR_029CE3				;$029CCE	|
	LDY.b #$08				;$029CD0	|
	LDA $14					;$029CD2	|
	AND.b #$08				;$029CD4	|
	BEQ CODE_029CDA				;$029CD6	|
	LDY.b #$F8				;$029CD8	|
CODE_029CDA:
	TYA
	STA.w $1747,X				;$029CDB	|
	JSR CODE_02B554				;$029CDE	|
	BRA CODE_029CF8				;$029CE1	|

ADDR_029CE3:
	LDA.w $1765,X
	BNE ADDR_029CF5				;$029CE6	|
	JSR CODE_02A56E				;$029CE8	|
	BCC ADDR_029CF5				;$029CEB	|
	LDA.b #$D0				;$029CED	|
	STA.w $173D,X				;$029CEF	|
	INC.w $1765,X				;$029CF2	|
ADDR_029CF5:
	JSR CODE_02A3F6
CODE_029CF8:
	LDA.w $1715,X
	SEC					;$029CFB	|
	SBC $1C					;$029CFC	|
	CMP.b #$F0				;$029CFE	|
	BCS CODE_029D5A				;$029D00	|
	STA $01					;$029D02	|
	LDA.w $171F,X				;$029D04	|
	CMP $1A					;$029D07	|
	LDA.w $1733,X				;$029D09	|
	SBC $1B					;$029D0C	|
	BNE Return029D5D			;$029D0E	|
	LDY.w DATA_02A153,X			;$029D10	|
	STY $0F					;$029D13	|
	LDA.w $171F,X				;$029D15	|
	SEC					;$029D18	|
	SBC $1A					;$029D19	|
	STA $00					;$029D1B	|
	STA.w $0200,Y				;$029D1D	|
	LDA.w $170B,X				;$029D20	|
	CMP.b #$0E				;$029D23	|
	BNE ADDR_029D45				;$029D25	|
	LDA $01					;$029D27	|
	SEC					;$029D29	|
	SBC.b #$05				;$029D2A	|
	STA.w $0201,Y				;$029D2C	|
	LDA.b #$98				;$029D2F	|
	STA.w $0202,Y				;$029D31	|
	LDA.b #$0B				;$029D34	|
CODE_029D36:
	ORA $64
	STA.w $0203,Y				;$029D38	|
	TYA					;$029D3B	|
	LSR					;$029D3C	|
	LSR					;$029D3D	|
	TAY					;$029D3E	|
	LDA.b #$00				;$029D3F	|
	STA.w $0420,Y				;$029D41	|
	RTS					;$029D44	|

ADDR_029D45:
	LDA $01
	STA.w $0201,Y				;$029D47	|
	LDA.b #$C2				;$029D4A	|
	STA.w $0202,Y				;$029D4C	|
	LDA.b #$04				;$029D4F	|
	JSR CODE_029D36				;$029D51	|
	LDA.b #$02				;$029D54	|
	STA.w $0420,Y				;$029D56	|
	RTS					;$029D59	|

CODE_029D5A:
	STZ.w $170B,X
Return029D5D:
	RTS

DATA_029D5E:
	db $00,$01,$02,$03,$02,$03,$02,$03
	db $03,$02,$03,$02,$03,$02,$01,$00
UnusedExSprDispX:
	db $10,$F8,$03,$10,$F8,$03,$10,$F0
	db $FF,$10,$F0,$FF

UnusedExSprDispY:
	db $02,$02,$EE,$02,$02,$EE,$FE,$FE
	db $E6,$FE,$FE,$E6

UnusedExSprTiles:
	db $B3,$B3,$B1,$B2,$B2,$B0,$8E,$8E
	db $A8,$8C,$8C,$88

UnusedExSprGfxProp:
	db $69,$29,$29

UnusedExSprTileSize:
	db $00,$00,$02,$02

ADDR_029D99:
	STZ.w $170B,X
	RTS					;$029D9C	|

UnusedExtendedSpr:
	JSR CODE_02A3F6
	LDY.w $1747,X				;$029DA0	|
	LDA.w $14C8,Y				;$029DA3	|
	CMP.b #$08				;$029DA6	|
	BNE ADDR_029D99				;$029DA8	|
	LDA.w $176F,X				;$029DAA	|
	BEQ ADDR_029D99				;$029DAD	|
	LSR					;$029DAF	|
	LSR					;$029DB0	|
	NOP					;$029DB1	|
	NOP					;$029DB2	|
	TAY					;$029DB3	|
	LDA.w DATA_029D5E,Y			;$029DB4	|
	STA $0F					;$029DB7	|
	ASL					;$029DB9	|
	ADC $0F					;$029DBA	|
	STA $02					;$029DBC	|
	LDA.w $1765,X				;$029DBE	|
	CLC					;$029DC1	|
	ADC $02					;$029DC2	|
	TAY					;$029DC4	|
	STY $03					;$029DC5	|
	LDA.w $171F,X				;$029DC7	|
	CLC					;$029DCA	|
	ADC.w UnusedExSprDispX,Y		;$029DCB	|
	SEC					;$029DCE	|
	SBC $1A					;$029DCF	|
	STA $00					;$029DD1	|
	LDA.w $1715,X				;$029DD3	|
	CLC					;$029DD6	|
	ADC.w UnusedExSprDispY,Y		;$029DD7	|
	SEC					;$029DDA	|
	SBC $1C					;$029DDB	|
	STA $01					;$029DDD	|
	LDY.w DATA_02A153,X			;$029DDF	|
	CMP.b #$F0				;$029DE2	|
	BCS CODE_029E39				;$029DE4	|
	STA.w $0201,Y				;$029DE6	|
	LDA $00					;$029DE9	|
	CMP.b #$10				;$029DEB	|
	BCC CODE_029E39				;$029DED	|
	CMP.b #$F0				;$029DEF	|
	BCS CODE_029E39				;$029DF1	|
	STA.w $0200,Y				;$029DF3	|
	LDA.w $1765,X				;$029DF6	|
	TAX					;$029DF9	|
	LDA.w UnusedExSprGfxProp,X		;$029DFA	|
	STA.w $0203,Y				;$029DFD	|
	LDX $03					;$029E00	|
	LDA.w UnusedExSprTiles,X		;$029E02	|
	STA.w $0202,Y				;$029E05	|
	TYA					;$029E08	|
	LSR					;$029E09	|
	LSR					;$029E0A	|
	TAY					;$029E0B	|
	LDX $0F					;$029E0C	|
	LDA.w UnusedExSprTileSize,X		;$029E0E	|
	STA.w $0420,Y				;$029E11	|
	LDX.w $15E9				;$029E14	|
	LDA $00					;$029E17	|
	SEC					;$029E19	|
	SBC $7E					;$029E1A	|
	CLC					;$029E1C	|
	ADC.b #$04				;$029E1D	|
	CMP.b #$08				;$029E1F	|
	BCS Return029E35			;$029E21	|
	LDA $01					;$029E23	|
	SEC					;$029E25	|
	SBC $80					;$029E26	|
	SEC					;$029E28	|
	SBC.b #$10				;$029E29	|
	CLC					;$029E2B	|
	ADC.b #$10				;$029E2C	|
	CMP.b #$10				;$029E2E	|
	BCS Return029E35			;$029E30	|
	JMP CODE_02A469				;$029E32	|

Return029E35:
	RTS

DATA_029E36:
	db $08,$00,$F8

CODE_029E39:
	STZ.w $170B,X
	RTS					;$029E3C	|

LauncherArm:
	LDY.b #$00
	LDA.w $176F,X				;$029E3F	|
	BEQ CODE_029E39				;$029E42	|
	CMP.b #$60				;$029E44	|
	BCS CODE_029E4E				;$029E46	|
	INY					;$029E48	|
	CMP.b #$30				;$029E49	|
	BCS CODE_029E4E				;$029E4B	|
	INY					;$029E4D	|
CODE_029E4E:
	PHY
	LDA $9D					;$029E4F	|
	BNE CODE_029E5C				;$029E51	|
	LDA.w DATA_029E36,Y			;$029E53	|
	STA.w $173D,X				;$029E56	|
	JSR CODE_02B560				;$029E59	|
CODE_029E5C:
	JSR CODE_02A1A4
	LDY.w DATA_02A153,X			;$029E5F	|
	PLA					;$029E62	|
	CMP.b #$01				;$029E63	|
	LDA.b #$84				;$029E65	|
	BCC CODE_029E6B				;$029E67	|
	LDA.b #$A4				;$029E69	|
CODE_029E6B:
	STA.w $0202,Y
	LDA.w $0203,Y				;$029E6E	|
	AND.b #$00				;$029E71	|
	ORA.b #$13				;$029E73	|
	STA.w $0203,Y				;$029E75	|
	TYA					;$029E78	|
	LSR					;$029E79	|
	LSR					;$029E7A	|
	TAY					;$029E7B	|
	LDA.b #$02				;$029E7C	|
	STA.w $0420,Y				;$029E7E	|
	RTS					;$029E81	|

LavaSplashTiles2:
	db $D7,$C7,$D6,$C6

LavaSplash:
	LDA $9D
	BNE CODE_029E9D				;$029E88	|
	JSR CODE_02B554				;$029E8A	|
	JSR CODE_02B560				;$029E8D	|
	LDA.w $173D,X				;$029E90	|
	CLC					;$029E93	|
	ADC.b #$02				;$029E94	|
	STA.w $173D,X				;$029E96	|
	CMP.b #$30				;$029E99	|
	BPL CODE_029EE6				;$029E9B	|
CODE_029E9D:
	LDY.w DATA_02A153,X
	LDA.w $171F,X				;$029EA0	|
	SEC					;$029EA3	|
	SBC $1A					;$029EA4	|
	STA $00					;$029EA6	|
	LDA.w $1733,X				;$029EA8	|
	SBC $1B					;$029EAB	|
	BNE CODE_029EE6				;$029EAD	|
	LDA $00					;$029EAF	|
	STA.w $0200,Y				;$029EB1	|
	LDA.w $1715,X				;$029EB4	|
	SEC					;$029EB7	|
	SBC $1C					;$029EB8	|
	CMP.b #$F0				;$029EBA	|
	BCS CODE_029EE6				;$029EBC	|
	STA.w $0201,Y				;$029EBE	|
	LDA.w $176F,X				;$029EC1	|
	LSR					;$029EC4	|
	LSR					;$029EC5	|
	LSR					;$029EC6	|
	NOP					;$029EC7	|
	NOP					;$029EC8	|
	AND.b #$03				;$029EC9	|
	TAX					;$029ECB	|
	LDA.w LavaSplashTiles2,X		;$029ECC	|
	STA.w $0202,Y				;$029ECF	|
	LDA $64					;$029ED2	|
	ORA.b #$05				;$029ED4	|
	STA.w $0203,Y				;$029ED6	|
	TYA					;$029ED9	|
	LSR					;$029EDA	|
	LSR					;$029EDB	|
	TAY					;$029EDC	|
	LDA.b #$00				;$029EDD	|
	STA.w $0420,Y				;$029EDF	|
	LDX.w $15E9				;$029EE2	|
	RTS					;$029EE5	|

CODE_029EE6:
	STZ.w $170B,X
	RTS					;$029EE9	|

DATA_029EEA:
	db $00,$01,$00,$FF

WaterBubble:
	LDA $9D
	BNE CODE_029F2A				;$029EF0	|
	INC.w $1765,X				;$029EF2	|
	LDA.w $1765,X				;$029EF5	|
	AND.b #$30				;$029EF8	|
	BEQ CODE_029F08				;$029EFA	|
	DEC.w $1715,X				;$029EFC	|
	LDY.w $1715,X				;$029EFF	|
	INY					;$029F02	|
	BNE CODE_029F08				;$029F03	|
	DEC.w $1729,X				;$029F05	|
CODE_029F08:
	TXA
	EOR $13					;$029F09	|
	LSR					;$029F0B	|
	BCS CODE_029F2A				;$029F0C	|
	JSR CODE_02A56E				;$029F0E	|
	BCS CODE_029F27				;$029F11	|
	LDA $85					;$029F13	|
	BNE CODE_029F2A				;$029F15	|
	LDA $0C					;$029F17	|
	CMP.b #$06				;$029F19	|
	BCC CODE_029F2A				;$029F1B	|
	LDA $0F					;$029F1D	|
	BEQ CODE_029F27				;$029F1F	|
	LDA $0D					;$029F21	|
	CMP.b #$06				;$029F23	|
	BCC CODE_029F2A				;$029F25	|
CODE_029F27:
	JMP CODE_02A211

CODE_029F2A:
	LDA.w $1715,X
	CMP $1C					;$029F2D	|
	LDA.w $1729,X				;$029F2F	|
	SBC $1D					;$029F32	|
	BNE CODE_029F27				;$029F34	|
	JSR CODE_02A1A4				;$029F36	|
	LDA.w $1765,X				;$029F39	|
	AND.b #$0C				;$029F3C	|
	LSR					;$029F3E	|
	LSR					;$029F3F	|
	TAY					;$029F40	|
	LDA.w DATA_029EEA,Y			;$029F41	|
	STA $00					;$029F44	|
	LDY.w DATA_02A153,X			;$029F46	|
	LDA.w $0200,Y				;$029F49	|
	CLC					;$029F4C	|
	ADC $00					;$029F4D	|
	STA.w $0200,Y				;$029F4F	|
	LDA.w $0201,Y				;$029F52	|
	CLC					;$029F55	|
	ADC.b #$05				;$029F56	|
	STA.w $0201,Y				;$029F58	|
	LDA.b #$1C				;$029F5B	|
	STA.w $0202,Y				;$029F5D	|
	RTS					;$029F60	|

YoshiFireball:
	LDA $9D
	BNE CODE_029F6E				;$029F63	|
	JSR CODE_02B554				;$029F65	|
	JSR CODE_02B560				;$029F68	|
	JSR ProcessFireball			;$029F6B	|
CODE_029F6E:
	JSR CODE_02A1A4
	LDA $14					;$029F71	|
	LSR					;$029F73	|
	LSR					;$029F74	|
	LSR					;$029F75	|
	LDY.w DATA_02A153,X			;$029F76	|
	LDA.b #$04				;$029F79	|
	BCC CODE_029F7F				;$029F7B	|
	LDA.b #$2B				;$029F7D	|
CODE_029F7F:
	STA.w $0202,Y
	LDA.w $1747,X				;$029F82	|
	AND.b #$80				;$029F85	|
	EOR.b #$80				;$029F87	|
	LSR					;$029F89	|
	ORA.b #$35				;$029F8A	|
	STA.w $0203,Y				;$029F8C	|
	TYA					;$029F8F	|
	LSR					;$029F90	|
	LSR					;$029F91	|
	TAY					;$029F92	|
	LDA.b #$02				;$029F93	|
	STA.w $0420,Y				;$029F95	|
	RTS					;$029F98	|

DATA_029F99:
	db $00,$B8,$C0,$C8,$D0,$D8,$E0,$E8
	db $F0

DATA_029FA2:
	db $00

DATA_029FA3:
	db $05,$03

DATA_029FA5:
	db $02,$02,$02,$02,$02,$02,$F8,$FC
	db $A0,$A4

MarioFireball:
	LDA $9D
	BNE CODE_02A02C				;$029FB1	|
	LDA.w $1715,X				;$029FB3	|
	CMP $1C					;$029FB6	|
	LDA.w $1729,X				;$029FB8	|
	SBC $1D					;$029FBB	|
	BEQ CODE_029FC2				;$029FBD	|
	JMP CODE_02A211				;$029FBF	|

CODE_029FC2:
	INC.w $1765,X
	JSR ProcessFireball			;$029FC5	|
	LDA.w $173D,X				;$029FC8	|
	CMP.b #$30				;$029FCB	|
	BPL CODE_029FD8				;$029FCD	|
	LDA.w $173D,X				;$029FCF	|
	CLC					;$029FD2	|
	ADC.b #$04				;$029FD3	|
	STA.w $173D,X				;$029FD5	|
CODE_029FD8:
	JSR CODE_02A56E
	BCC CODE_02A010				;$029FDB	|
	INC.w $175B,X				;$029FDD	|
	LDA.w $175B,X				;$029FE0	|
	CMP.b #$02				;$029FE3	|
	BCS CODE_02A042				;$029FE5	|
	LDA.w $1747,X				;$029FE7	|
	BPL CODE_029FF3				;$029FEA	|
	LDA $0B					;$029FEC	|
	EOR.b #$FF				;$029FEE	|
	INC A					;$029FF0	|
	STA $0B					;$029FF1	|
CODE_029FF3:
	LDA $0B
	CLC					;$029FF5	|
	ADC.b #$04				;$029FF6	|
	TAY					;$029FF8	|
	LDA.w DATA_029F99,Y			;$029FF9	|
	STA.w $173D,X				;$029FFC	|
	LDA.w $1715,X				;$029FFF	|
	SEC					;$02A002	|
	SBC.w DATA_029FA2,Y			;$02A003	|
	STA.w $1715,X				;$02A006	|
	BCS CODE_02A00E				;$02A009	|
	DEC.w $1729,X				;$02A00B	|
CODE_02A00E:
	BRA CODE_02A013

CODE_02A010:
	STZ.w $175B,X
CODE_02A013:
	LDY.b #$00
	LDA.w $1747,X				;$02A015	|
	BPL CODE_02A01B				;$02A018	|
	DEY					;$02A01A	|
CODE_02A01B:
	CLC
	ADC.w $171F,X				;$02A01C	|
	STA.w $171F,X				;$02A01F	|
	TYA					;$02A022	|
	ADC.w $1733,X				;$02A023	|
	STA.w $1733,X				;$02A026	|
	JSR CODE_02B560				;$02A029	|
CODE_02A02C:
	LDA $A5
	CMP.b #$A9				;$02A02E	|
	BEQ CODE_02A03B				;$02A030	|
	LDA.w $0D9B				;$02A032	|
	BPL CODE_02A03B				;$02A035	|
	AND.b #$40				;$02A037	|
	BNE ADDR_02A04F				;$02A039	|
CODE_02A03B:
	LDY.w DATA_029FA3,X
	JSR CODE_02A1A7				;$02A03E	|
	RTS					;$02A041	|

CODE_02A042:
	JSR CODE_02A02C
CODE_02A045:
	LDA.b #$01
	STA.w $1DF9				;$02A047	|
	LDA.b #$0F				;$02A04A	|
	JMP CODE_02A4E0				;$02A04C	|

ADDR_02A04F:
	LDY.w DATA_029FA5,X
	LDA.w $1747,X				;$02A052	|
	AND.b #$80				;$02A055	|
	LSR					;$02A057	|
	STA $00					;$02A058	|
	LDA.w $171F,X				;$02A05A	|
	SEC					;$02A05D	|
	SBC $1A					;$02A05E	|
	CMP.b #$F8				;$02A060	|
	BCS ADDR_02A0A9				;$02A062	|
	STA.w $0300,Y				;$02A064	|
	LDA.w $1715,X				;$02A067	|
	SEC					;$02A06A	|
	SBC $1C					;$02A06B	|
	CMP.b #$F0				;$02A06D	|
	BCS ADDR_02A0A9				;$02A06F	|
	STA.w $0301,Y				;$02A071	|
	LDA.w $1779,X				;$02A074	|
	STA $01					;$02A077	|
	LDA.w $1765,X				;$02A079	|
	LSR					;$02A07C	|
	LSR					;$02A07D	|
	AND.b #$03				;$02A07E	|
	TAX					;$02A080	|
	LDA.w FireballTiles,X			;$02A081	|
	STA.w $0302,Y				;$02A084	|
	LDA.w DATA_02A15F,X			;$02A087	|
	EOR $00					;$02A08A	|
	ORA $64					;$02A08C	|
	STA.w $0303,Y				;$02A08E	|
	LDX $01					;$02A091	|
	BEQ ADDR_02A09C				;$02A093	|
	AND.b #$CF				;$02A095	|
	ORA.b #$10				;$02A097	|
	STA.w $0303,Y				;$02A099	|
ADDR_02A09C:
	TYA
	LSR					;$02A09D	|
	LSR					;$02A09E	|
	TAY					;$02A09F	|
	LDA.b #$00				;$02A0A0	|
	STA.w $0460,Y				;$02A0A2	|
	LDX.w $15E9				;$02A0A5	|
Return02A0A8:
	RTS

ADDR_02A0A9:
	JMP CODE_02A211

ProcessFireball:
	TXA
	EOR $13					;$02A0AD	|
	AND.b #$03				;$02A0AF	|
	BNE Return02A0A8			;$02A0B1	|
	PHX					;$02A0B3	|
	TXY					;$02A0B4	|
	STY.w $185E				;$02A0B5	|
	LDX.b #$09				;$02A0B8	|
FireRtLoopStart:
	STX.w $15E9
	LDA.w $14C8,X				;$02A0BD	|
	CMP.b #$08				;$02A0C0	|
	BCC FireRtNextSprite			;$02A0C2	|
	LDA.w $167A,X				;$02A0C4	|
	AND.b #$02				;$02A0C7	|
	ORA.w $15D0,X				;$02A0C9	|
	ORA.w $1632,X				;$02A0CC	|
	EOR.w $1779,Y				;$02A0CF	|
	BNE FireRtNextSprite			;$02A0D2	|
	JSL GetSpriteClippingA			;$02A0D4	|
	JSR CODE_02A547				;$02A0D8	|
	JSL CheckForContact			;$02A0DB	|
	BCC FireRtNextSprite			;$02A0DF	|
	LDA.w $170B,Y				;$02A0E1	|
	CMP.b #$11				;$02A0E4	|
	BEQ CODE_02A0EE				;$02A0E6	|
	PHX					;$02A0E8	|
	TYX					;$02A0E9	|
	JSR CODE_02A045				;$02A0EA	|
	PLX					;$02A0ED	|
CODE_02A0EE:
	LDA.w $166E,X
	AND.b #$10				;$02A0F1	|
	BNE FireRtNextSprite			;$02A0F3	|
	LDA.w $190F,X				;$02A0F5	|
	AND.b #$08				;$02A0F8	|
	BEQ TurnSpriteToCoin			;$02A0FA	|
	INC.w $1528,X				;$02A0FC	|
	LDA.w $1528,X				;$02A0FF	|
	CMP.b #$05				;$02A102	|
	BCC FireRtNextSprite			;$02A104	|
ChuckFireKill:
	LDA.b #$02
	STA.w $1DF9				;$02A108	|
	LDA.b #$02				;$02A10B	|
	STA.w $14C8,X				;$02A10D	|
	LDA.b #$D0				;$02A110	|
	STA $AA,X				;$02A112	|
	JSR SubHorzPosBnk2			;$02A114	|
	LDA.w FireKillSpeedX,Y			;$02A117	|
	STA $B6,X				;$02A11A	|
	LDA.b #$04				;$02A11C	|
	JSL GivePoints				;$02A11E	|
	BRA FireRtNextSprite			;$02A122	|

TurnSpriteToCoin:
	LDA.b #$03
	STA.w $1DF9				;$02A126	|
	LDA.b #$21				;$02A129	|
	STA $9E,X				;$02A12B	|
	LDA.b #$08				;$02A12D	|
	STA.w $14C8,X				;$02A12F	|
	JSL InitSpriteTables			;$02A132	|
	LDA.b #$D0				;$02A136	|
	STA $AA,X				;$02A138	|
	JSR SubHorzPosBnk2			;$02A13A	|
	TYA					;$02A13D	|
	EOR.b #$01				;$02A13E	|
	STA.w $157C,X				;$02A140	|
FireRtNextSprite:
	LDY.w $185E
	DEX					;$02A146	|
	BMI CODE_02A14C				;$02A147	|
	JMP FireRtLoopStart			;$02A149	|

CODE_02A14C:
	PLX
	STX.w $15E9				;$02A14D	|
	RTS					;$02A150	|

FireKillSpeedX:
	db $F0,$10

DATA_02A153:
	db $90,$94,$98,$9C,$A0,$A4,$A8,$AC
FireballTiles:
	db $2C,$2D,$2C,$2D

DATA_02A15F:
	db $04,$04,$C4,$C4

ReznorFireTiles:
	db $26,$2A,$26,$2A

DATA_02A167:
	db $35,$35,$F5,$F5

ReznorFireball:
	LDA $9D
	BNE CODE_02A178				;$02A16D	|
	JSR CODE_02B554				;$02A16F	|
	JSR CODE_02B560				;$02A172	|
	JSR CODE_02A3F6				;$02A175	|
CODE_02A178:
	LDA.w $0D9B
	BPL CODE_02A1A4				;$02A17B	|
	JSR CODE_02A1A4				;$02A17D	|
	LDY.w DATA_02A153,X			;$02A180	|
	LDA $14					;$02A183	|
	LSR					;$02A185	|
	LSR					;$02A186	|
	AND.b #$03				;$02A187	|
	PHX					;$02A189	|
	TAX					;$02A18A	|
	LDA.w ReznorFireTiles,X			;$02A18B	|
	STA.w $0202,Y				;$02A18E	|
	LDA.w DATA_02A167,X			;$02A191	|
	EOR $00					;$02A194	|
	STA.w $0203,Y				;$02A196	|
	TYA					;$02A199	|
	LSR					;$02A19A	|
	LSR					;$02A19B	|
	TAX					;$02A19C	|
	LDA.b #$02				;$02A19D	|
	STA.w $0420,X				;$02A19F	|
	PLX					;$02A1A2	|
	RTS					;$02A1A3	|

CODE_02A1A4:
	LDY.w DATA_02A153,X
CODE_02A1A7:
	LDA.w $1747,X
	AND.b #$80				;$02A1AA	|
	EOR.b #$80				;$02A1AC	|
	LSR					;$02A1AE	|
	STA $00					;$02A1AF	|
	LDA.w $171F,X				;$02A1B1	|
	SEC					;$02A1B4	|
	SBC $1A					;$02A1B5	|
	STA $01					;$02A1B7	|
	LDA.w $1733,X				;$02A1B9	|
	SBC $1B					;$02A1BC	|
	BNE CODE_02A211				;$02A1BE	|
	LDA.w $1715,X				;$02A1C0	|
	SEC					;$02A1C3	|
	SBC $1C					;$02A1C4	|
	STA $02					;$02A1C6	|
	LDA.w $1729,X				;$02A1C8	|
	SBC $1D					;$02A1CB	|
	BNE CODE_02A211				;$02A1CD	|
	LDA $02					;$02A1CF	|
	CMP.b #$F0				;$02A1D1	|
	BCS CODE_02A211				;$02A1D3	|
	STA.w $0201,Y				;$02A1D5	|
	LDA $01					;$02A1D8	|
	STA.w $0200,Y				;$02A1DA	|
	LDA.w $1779,X				;$02A1DD	|
	STA $01					;$02A1E0	|
	LDA $14					;$02A1E2	|
	LSR					;$02A1E4	|
	LSR					;$02A1E5	|
	AND.b #$03				;$02A1E6	|
	TAX					;$02A1E8	|
	LDA.w FireballTiles,X			;$02A1E9	|
	STA.w $0202,Y				;$02A1EC	|
	LDA.w DATA_02A15F,X			;$02A1EF	|
	EOR $00					;$02A1F2	|
	ORA $64					;$02A1F4	|
	STA.w $0203,Y				;$02A1F6	|
	LDX $01					;$02A1F9	|
	BEQ CODE_02A204				;$02A1FB	|
	AND.b #$CF				;$02A1FD	|
	ORA.b #$10				;$02A1FF	|
	STA.w $0203,Y				;$02A201	|
CODE_02A204:
	TYA
	LSR					;$02A205	|
	LSR					;$02A206	|
	TAY					;$02A207	|
	LDA.b #$00				;$02A208	|
	STA.w $0420,Y				;$02A20A	|
	LDX.w $15E9				;$02A20D	|
	RTS					;$02A210	|

CODE_02A211:
	LDA.b #$00
	STA.w $170B,X				;$02A213	|
	RTS					;$02A216	|

SmallFlameTiles:
	db $AC,$AD

FlameRemnant:
	LDA $9D
	BNE CODE_02A22F				;$02A21B	|
	INC.w $1765,X				;$02A21D	|
	LDA.w $176F,X				;$02A220	|
	BEQ CODE_02A211				;$02A223	|
	CMP.b #$50				;$02A225	|
	BCS CODE_02A22F				;$02A227	|
	AND.b #$01				;$02A229	|
	BNE Return02A253			;$02A22B	|
	BEQ CODE_02A232				;$02A22D	|
CODE_02A22F:
	JSR CODE_02A3F6
CODE_02A232:
	JSR CODE_02A1A4
	LDY.w DATA_02A153,X			;$02A235	|
	LDA.w $1765,X				;$02A238	|
	LSR					;$02A23B	|
	LSR					;$02A23C	|
	AND.b #$01				;$02A23D	|
	TAX					;$02A23F	|
	LDA.w SmallFlameTiles,X			;$02A240	|
	STA.w $0202,Y				;$02A243	|
	LDA.w $0203,Y				;$02A246	|
	AND.b #$3F				;$02A249	|
	ORA.b #$05				;$02A24B	|
	STA.w $0203,Y				;$02A24D	|
	LDX.w $15E9				;$02A250	|
Return02A253:
	RTS

Baseball:
	LDA $9D
	BNE CODE_02A26A				;$02A256	|
	JSR CODE_02B554				;$02A258	|
	INC.w $1765,X				;$02A25B	|
	LDA $13					;$02A25E	|
	AND.b #$01				;$02A260	|
	BNE CODE_02A267				;$02A262	|
	INC.w $1765,X				;$02A264	|
CODE_02A267:
	JSR CODE_02A3F6
CODE_02A26A:
	LDA.w $170B,X
	CMP.b #$0D				;$02A26D	|
	BNE CODE_02A2C3				;$02A26F	|
	LDA.w $171F,X				;$02A271	|
	SEC					;$02A274	|
	SBC $1A					;$02A275	|
	STA $00					;$02A277	|
	LDA.w $1733,X				;$02A279	|
	SBC $1B					;$02A27C	|
	BEQ CODE_02A287				;$02A27E	|
	EOR.w $1747,X				;$02A280	|
	BPL CODE_02A2BF				;$02A283	|
	BMI Return02A2BE			;$02A285	|
CODE_02A287:
	LDY.w DATA_02A153,X
	LDA $00					;$02A28A	|
	STA.w $0200,Y				;$02A28C	|
	LDA.w $1715,X				;$02A28F	|
	SEC					;$02A292	|
	SBC $1C					;$02A293	|
	STA $01					;$02A295	|
	LDA.w $1729,X				;$02A297	|
	SBC $1D					;$02A29A	|
	BNE CODE_02A2BF				;$02A29C	|
	LDA $01					;$02A29E	|
	STA.w $0201,Y				;$02A2A0	|
	LDA.b #$AD				;$02A2A3	|
	STA.w $0202,Y				;$02A2A5	|
	LDA $14					;$02A2A8	|
	ASL					;$02A2AA	|
	ASL					;$02A2AB	|
	ASL					;$02A2AC	|
	ASL					;$02A2AD	|
	AND.b #$C0				;$02A2AE	|
	ORA.b #$39				;$02A2B0	|
	STA.w $0203,Y				;$02A2B2	|
	TYA					;$02A2B5	|
	LSR					;$02A2B6	|
	LSR					;$02A2B7	|
	TAY					;$02A2B8	|
	LDA.b #$00				;$02A2B9	|
	STA.w $0420,Y				;$02A2BB	|
Return02A2BE:
	RTS

CODE_02A2BF:
	STZ.w $170B,X
	RTS					;$02A2C2	|

CODE_02A2C3:
	JSR CODE_02A317
	LDA.w $0202,Y				;$02A2C6	|
	CMP.b #$26				;$02A2C9	|
	LDA.b #$80				;$02A2CB	|
	BCS CODE_02A2D1				;$02A2CD	|
	LDA.b #$82				;$02A2CF	|
CODE_02A2D1:
	STA.w $0202,Y
	LDA.w $0203,Y				;$02A2D4	|
	AND.b #$F1				;$02A2D7	|
	ORA.b #$02				;$02A2D9	|
	STA.w $0203,Y				;$02A2DB	|
	RTS					;$02A2DE	|

HammerTiles:
	db $08,$6D,$6D,$08,$08,$6D,$6D,$08
HammerGfxProp:
	db $47,$47,$07,$07,$87,$87,$C7,$C7

Hammer:
	LDA $9D
	BNE CODE_02A30C				;$02A2F1	|
	JSR CODE_02B554				;$02A2F3	|
	JSR CODE_02B560				;$02A2F6	|
	LDA.w $173D,X				;$02A2F9	|
	CMP.b #$40				;$02A2FC	|
	BPL CODE_02A306				;$02A2FE	|
	INC.w $173D,X				;$02A300	|
	INC.w $173D,X				;$02A303	|
CODE_02A306:
	JSR CODE_02A3F6
	INC.w $1765,X				;$02A309	|
CODE_02A30C:
	LDA.w $170B,X
	CMP.b #$0B				;$02A30F	|
	BNE CODE_02A317				;$02A311	|
	JSR CODE_02A178				;$02A313	|
	RTS					;$02A316	|

CODE_02A317:
	JSR CODE_02A1A4
	LDY.w DATA_02A153,X			;$02A31A	|
	LDA.w $1765,X				;$02A31D	|
	LSR					;$02A320	|
	LSR					;$02A321	|
	LSR					;$02A322	|
	AND.b #$07				;$02A323	|
	PHX					;$02A325	|
	TAX					;$02A326	|
	LDA.w HammerTiles,X			;$02A327	|
	STA.w $0202,Y				;$02A32A	|
	LDA.w HammerGfxProp,X			;$02A32D	|
	EOR $00					;$02A330	|
	EOR.b #$40				;$02A332	|
	ORA $64					;$02A334	|
	STA.w $0203,Y				;$02A336	|
	TYA					;$02A339	|
	LSR					;$02A33A	|
	LSR					;$02A33B	|
	TAX					;$02A33C	|
	LDA.b #$02				;$02A33D	|
	STA.w $0420,X				;$02A33F	|
	PLX					;$02A342	|
	RTS					;$02A343	|

CODE_02A344:
	JMP CODE_02A211

DustCloudTiles:
	db $66,$64,$60,$62

DATA_02A34B:
	db $00,$40,$C0,$80

SmokePuff:
	LDA.w $176F,X
	BEQ CODE_02A344				;$02A352	|
	LDA.w $140F				;$02A354	|
	BNE CODE_02A362				;$02A357	|
	LDA.w $0D9B				;$02A359	|
	BPL CODE_02A362				;$02A35C	|
	AND.b #$40				;$02A35E	|
	BNE ADDR_02A3B1				;$02A360	|
CODE_02A362:
	LDY.w DATA_02A153,X
	CPX.b #$08				;$02A365	|
	BCC CODE_02A36C				;$02A367	|
	LDY.w DATA_029FA3,X			;$02A369	|
CODE_02A36C:
	LDA.w $171F,X
	SEC					;$02A36F	|
	SBC $1A					;$02A370	|
	CMP.b #$F8				;$02A372	|
	BCS CODE_02A3AE				;$02A374	|
	STA.w $0200,Y				;$02A376	|
	LDA.w $1715,X				;$02A379	|
	SEC					;$02A37C	|
	SBC $1C					;$02A37D	|
	CMP.b #$F0				;$02A37F	|
	BCS CODE_02A3AE				;$02A381	|
	STA.w $0201,Y				;$02A383	|
	LDA.w $176F,X				;$02A386	|
	LSR					;$02A389	|
	LSR					;$02A38A	|
	TAX					;$02A38B	|
	LDA.w DustCloudTiles,X			;$02A38C	|
	STA.w $0202,Y				;$02A38F	|
	LDA $14					;$02A392	|
	LSR					;$02A394	|
	LSR					;$02A395	|
	AND.b #$03				;$02A396	|
	TAX					;$02A398	|
	LDA.w DATA_02A34B,X			;$02A399	|
	ORA $64					;$02A39C	|
	STA.w $0203,Y				;$02A39E	|
	TYA					;$02A3A1	|
	LSR					;$02A3A2	|
	LSR					;$02A3A3	|
	TAY					;$02A3A4	|
	LDA.b #$02				;$02A3A5	|
	STA.w $0420,Y				;$02A3A7	|
	LDX.w $15E9				;$02A3AA	|
	RTS					;$02A3AD	|

CODE_02A3AE:
	JMP CODE_02A211

ADDR_02A3B1:
	LDY.w DATA_029FA5,X
	LDA.w $171F,X				;$02A3B4	|
	SEC					;$02A3B7	|
	SBC $1A					;$02A3B8	|
	CMP.b #$F8				;$02A3BA	|
	BCS CODE_02A3AE				;$02A3BC	|
	STA.w $0300,Y				;$02A3BE	|
	LDA.w $1715,X				;$02A3C1	|
	SEC					;$02A3C4	|
	SBC $1C					;$02A3C5	|
	CMP.b #$F0				;$02A3C7	|
	BCS CODE_02A3AE				;$02A3C9	|
	STA.w $0301,Y				;$02A3CB	|
	LDA.w $176F,X				;$02A3CE	|
	LSR					;$02A3D1	|
	LSR					;$02A3D2	|
	TAX					;$02A3D3	|
	LDA.w DustCloudTiles,X			;$02A3D4	|
	STA.w $0302,Y				;$02A3D7	|
	LDA $14					;$02A3DA	|
	LSR					;$02A3DC	|
	LSR					;$02A3DD	|
	AND.b #$03				;$02A3DE	|
	TAX					;$02A3E0	|
	LDA.w DATA_02A34B,X			;$02A3E1	|
	ORA $64					;$02A3E4	|
	STA.w $0303,Y				;$02A3E6	|
	LDX.w $15E9				;$02A3E9	|
	TYA					;$02A3EC	|
	LSR					;$02A3ED	|
	LSR					;$02A3EE	|
	TAY					;$02A3EF	|
	LDA.b #$02				;$02A3F0	|
	STA.w $0460,Y				;$02A3F2	|
	RTS					;$02A3F5	|

CODE_02A3F6:
	LDA.w $13F9
	EOR.w $1779,X				;$02A3F9	|
	BNE Return02A468			;$02A3FC	|
	JSL GetMarioClipping			;$02A3FE	|
	JSR CODE_02A519				;$02A402	|
	JSL CheckForContact			;$02A405	|
	BCC Return02A468			;$02A409	|
	LDA.w $170B,X				;$02A40B	|
	CMP.b #$0A				;$02A40E	|
	BNE CODE_02A469				;$02A410	|
	JSL CODE_05B34A				;$02A412	|
	INC.w $18E3				;$02A416	|
	STZ.w $170B,X				;$02A419	|
	LDY.b #$03				;$02A41C	|
ADDR_02A41E:
	LDA.w $17C0,Y
	BEQ ADDR_02A427				;$02A421	|
	DEY					;$02A423	|
	BPL ADDR_02A41E				;$02A424	|
	INY					;$02A426	|
ADDR_02A427:
	LDA.b #$05
	STA.w $17C0,Y				;$02A429	|
	LDA.w $171F,X				;$02A42C	|
	STA.w $17C8,Y				;$02A42F	|
	LDA.w $1715,X				;$02A432	|
	STA.w $17C4,Y				;$02A435	|
	LDA.b #$0A				;$02A438	|
	STA.w $17CC,Y				;$02A43A	|
	JSL CODE_02AD34				;$02A43D	|
	LDA.b #$05				;$02A441	|
	STA.w $16E1,Y				;$02A443	|
	LDA.w $1715,X				;$02A446	|
	STA.w $16E7,Y				;$02A449	|
	LDA.w $1729,X				;$02A44C	|
	STA.w $16F9,Y				;$02A44F	|
	LDA.w $171F,X				;$02A452	|
	STA.w $16ED,Y				;$02A455	|
	LDA.w $1733,X				;$02A458	|
	STA.w $16F3,Y				;$02A45B	|
	LDA.b #$30				;$02A45E	|
	STA.w $16FF,Y				;$02A460	|
	LDA.b #$00				;$02A463	|
	STA.w $1705,Y				;$02A465	|
Return02A468:
	RTS

CODE_02A469:
	LDA.w $1490
	BNE CODE_02A4B5				;$02A46C	|
	LDA.w $187A				;$02A46E	|
	BEQ CODE_02A4AE				;$02A471	|
CODE_02A473:
	PHX
	LDX.w $18DF				;$02A474	|
	LDA.b #$10				;$02A477	|
	STA.w $163D,X				;$02A479	|
	LDA.b #$03				;$02A47C	|
	STA.w $1DFA				;$02A47E	|
	LDA.b #$13				;$02A481	|
	STA.w $1DFC				;$02A483	|
	LDA.b #$02				;$02A486	|
	STA $C1,X				;$02A488	|
	STZ.w $187A				;$02A48A	|
	STZ.w $0DC1				;$02A48D	|
	LDA.b #$C0				;$02A490	|
	STA $7D					;$02A492	|
	STZ $7B					;$02A494	|
	LDY.w $157B,X				;$02A496	|
	LDA.w DATA_02A4B3,Y			;$02A499	|
	STA $B5,X				;$02A49C	|
	STZ.w $1593,X				;$02A49E	|
	STZ.w $151B,X				;$02A4A1	|
	STZ.w $18AE				;$02A4A4	|
	LDA.b #$30				;$02A4A7	|
	STA.w $1497				;$02A4A9	|
	PLX					;$02A4AC	|
	RTS					;$02A4AD	|

CODE_02A4AE:
	JSL HurtMario
	RTS					;$02A4B2	|

DATA_02A4B3:
	db $10,$F0

CODE_02A4B5:
	LDA.w $170B,X
	CMP.b #$04				;$02A4B8	|
	BEQ CODE_02A4DE				;$02A4BA	|
	LDA.w $171F,X				;$02A4BC	|
	SEC					;$02A4BF	|
	SBC.b #$04				;$02A4C0	|
	STA.w $171F,X				;$02A4C2	|
	LDA.w $1733,X				;$02A4C5	|
	SBC.b #$00				;$02A4C8	|
	STA.w $1733,X				;$02A4CA	|
	LDA.w $1715,X				;$02A4CD	|
	SEC					;$02A4D0	|
	SBC.b #$04				;$02A4D1	|
	STA.w $1715,X				;$02A4D3	|
	LDA.w $1729,X				;$02A4D6	|
	SBC.b #$00				;$02A4D9	|
	STA.w $1729,X				;$02A4DB	|
CODE_02A4DE:
	LDA.b #$07
CODE_02A4E0:
	STA.w $176F,X
	LDA.b #$01				;$02A4E3	|
	STA.w $170B,x				;$02A4E5	|
	RTS					;$02A4E8	|

DATA_02A4E9:
	db $03,$03,$04,$03,$04,$00,$00,$00
	db $04,$03

DATA_02A4F3:
	db $03,$03,$03,$03,$04,$03,$04,$00
	db $00,$00,$02,$03

DATA_02A4FF:
	db $03,$03,$01,$01,$08,$01,$08,$00
	db $00,$0F,$08,$01

DATA_02A50B:
	db $01,$01,$01,$01,$08,$01,$08,$00
	db $00,$0F,$0C,$01,$01,$01

CODE_02A519:
	LDY.w $170B,X
	LDA.w $171F,X				;$02A51C	|
	CLC					;$02A51F	|
	ADC.w $A4E7,Y			;$02A520	|
	STA $04					;$02A523	|
	LDA.w $1733,X				;$02A525	|
	ADC.b #$00				;$02A528	|
	STA $0A					;$02A52A	|
	LDA.w DATA_02A4FF,Y			;$02A52C	|
	STA $06					;$02A52F	|
	LDA.w $1715,X				;$02A531	|
	CLC					;$02A534	|
	ADC.w DATA_02A4F3,Y			;$02A535	|
	STA $05					;$02A538	|
	LDA.w $1729,X				;$02A53A	|
	ADC.b #$00				;$02A53D	|
	STA $0B					;$02A53F	|
	LDA.w DATA_02A50B,Y			;$02A541	|
	STA $07					;$02A544	|
	RTS					;$02A546	|

CODE_02A547:
	LDA.w $171F,Y
	SEC					;$02A54A	|
	SBC.b #$02				;$02A54B	|
	STA $00					;$02A54D	|
	LDA.w $1733,Y				;$02A54F	|
	SBC.b #$00				;$02A552	|
	STA $08					;$02A554	|
	LDA.b #$0C				;$02A556	|
	STA $02					;$02A558	|
	LDA.w $1715,Y				;$02A55A	|
	SEC					;$02A55D	|
	SBC.b #$04				;$02A55E	|
	STA $01					;$02A560	|
	LDA.w $1729,Y				;$02A562	|
	SBC.b #$00				;$02A565	|
	STA $09					;$02A567	|
	LDA.b #$13				;$02A569	|
	STA $03					;$02A56B	|
	RTS					;$02A56D	|

CODE_02A56E:
	STZ $0F
	STZ $0E					;$02A570	|
	STZ $0B					;$02A572	|
	STZ.w $1694				;$02A574	|
	LDA.w $140F				;$02A577	|
	BNE CODE_02A5BC				;$02A57A	|
	LDA.w $0D9B				;$02A57C	|
	BPL CODE_02A5BC				;$02A57F	|
	AND.b #$40				;$02A581	|
	BEQ CODE_02A592				;$02A583	|
	LDA.w $0D9B				;$02A585	|
	CMP.b #$C1				;$02A588	|
	BEQ CODE_02A5BC				;$02A58A	|
	LDA.w $1715,X				;$02A58C	|
	CMP.b #$A8				;$02A58F	|
	RTS					;$02A591	|

CODE_02A592:
	LDA.w $171F,X
	CLC					;$02A595	|
	ADC.b #$04				;$02A596	|
	STA.w $14B4				;$02A598	|
	LDA.w $1733,X				;$02A59B	|
	ADC.b #$00				;$02A59E	|
	STA.w $14B5				;$02A5A0	|
	LDA.w $1715,X				;$02A5A3	|
	CLC					;$02A5A6	|
	ADC.b #$08				;$02A5A7	|
	STA.w $14B6				;$02A5A9	|
	LDA.w $1729,X				;$02A5AC	|
	ADC.b #$00				;$02A5AF	|
	STA.w $14B7				;$02A5B1	|
	JSL CODE_01CC9D				;$02A5B4	|
	LDX.w $15E9				;$02A5B8	|
	RTS					;$02A5BB	|

CODE_02A5BC:
	JSR CODE_02A611
	ROL $0E					;$02A5BF	|
	LDA.w $1693				;$02A5C1	|
	STA $0C					;$02A5C4	|
	LDA $5B					;$02A5C6	|
	BPL CODE_02A60C				;$02A5C8	|
	INC $0F					;$02A5CA	|
	LDA.w $171F,X				;$02A5CC	|
	PHA					;$02A5CF	|
	CLC					;$02A5D0	|
	ADC $26					;$02A5D1	|
	STA.w $171F,X				;$02A5D3	|
	LDA.w $1733,X				;$02A5D6	|
	PHA					;$02A5D9	|
	ADC $27					;$02A5DA	|
	STA.w $1733,X				;$02A5DC	|
	LDA.w $1715,X				;$02A5DF	|
	PHA					;$02A5E2	|
	CLC					;$02A5E3	|
	ADC $28					;$02A5E4	|
	STA.w $1715,X				;$02A5E6	|
	LDA.w $1729,X				;$02A5E9	|
	PHA					;$02A5EC	|
	ADC $29					;$02A5ED	|
	STA.w $1729,X				;$02A5EF	|
	JSR CODE_02A611				;$02A5F2	|
	ROL $0E					;$02A5F5	|
	LDA.w $1693				;$02A5F7	|
	STA $0D					;$02A5FA	|
	PLA					;$02A5FC	|
	STA.w $1729,X				;$02A5FD	|
	PLA					;$02A600	|
	STA.w $1715,X				;$02A601	|
	PLA					;$02A604	|
	STA.w $1733,X				;$02A605	|
	PLA					;$02A608	|
	STA.w $171F,X				;$02A609	|
CODE_02A60C:
	LDA $0E
	CMP.b #$01				;$02A60E	|
	RTS					;$02A610	|

CODE_02A611:
	LDA $0F
	INC A					;$02A613	|
	AND $5B					;$02A614	|
	BEQ CODE_02A679				;$02A616	|
	LDA.w $1715,X				;$02A618	|
	CLC					;$02A61B	|
	ADC.b #$08				;$02A61C	|
	STA $98					;$02A61E	|
	AND.b #$F0				;$02A620	|
	STA $00					;$02A622	|
	LDA.w $1729,X				;$02A624	|
	ADC.b #$00				;$02A627	|
	CMP $5D					;$02A629	|
	BCS CODE_02A677				;$02A62B	|
	STA $03					;$02A62D	|
	STA $99					;$02A62F	|
	LDA.w $171F,X				;$02A631	|
	CLC					;$02A634	|
	ADC.b #$04				;$02A635	|
	STA $01					;$02A637	|
	STA $9A					;$02A639	|
	LDA.w $1733,X				;$02A63B	|
	ADC.b #$00				;$02A63E	|
	CMP.b #$02				;$02A640	|
	BCS CODE_02A677				;$02A642	|
	STA $02					;$02A644	|
	STA $9B					;$02A646	|
	LDA $01					;$02A648	|
	LSR					;$02A64A	|
	LSR					;$02A64B	|
	LSR					;$02A64C	|
	LSR					;$02A64D	|
	ORA $00					;$02A64E	|
	STA $00					;$02A650	|
	LDX $03					;$02A652	|
	LDA.l DATA_00BA80,X			;$02A654	|
	LDY $0F					;$02A658	|
	BEQ CODE_02A660				;$02A65A	|
	LDA.l DATA_00BA8E,X			;$02A65C	|
CODE_02A660:
	CLC
	ADC $00					;$02A661	|
	STA $05					;$02A663	|
	LDA.l DATA_00BABC,X			;$02A665	|
	LDY $0F					;$02A669	|
	BEQ CODE_02A671				;$02A66B	|
	LDA.l DATA_00BACA,X			;$02A66D	|
CODE_02A671:
	ADC $02
	STA $06					;$02A673	|
	BRA CODE_02A6DB				;$02A675	|

CODE_02A677:
	CLC
	RTS					;$02A678	|

CODE_02A679:
	LDA.w $1715,X
	CLC					;$02A67C	|
	ADC.b #$08				;$02A67D	|
	STA $98					;$02A67F	|
	AND.b #$F0				;$02A681	|
	STA $00					;$02A683	|
	LDA.w $1729,X				;$02A685	|
	ADC.b #$00				;$02A688	|
	STA $02					;$02A68A	|
	STA $99					;$02A68C	|
	LDA $00					;$02A68E	|
	SEC					;$02A690	|
	SBC $1C					;$02A691	|
	CMP.b #$F0				;$02A693	|
	BCS CODE_02A677				;$02A695	|
	LDA.w $171F,X				;$02A697	|
	CLC					;$02A69A	|
	ADC.b #$04				;$02A69B	|
	STA $01					;$02A69D	|
	STA $9A					;$02A69F	|
	LDA.w $1733,X				;$02A6A1	|
	ADC.b #$00				;$02A6A4	|
	CMP $5D					;$02A6A6	|
	BCS CODE_02A677				;$02A6A8	|
	STA $03					;$02A6AA	|
	STA $9B					;$02A6AC	|
	LDA $01					;$02A6AE	|
	LSR					;$02A6B0	|
	LSR					;$02A6B1	|
	LSR					;$02A6B2	|
	LSR					;$02A6B3	|
	ORA $00					;$02A6B4	|
	STA $00					;$02A6B6	|
	LDX $03					;$02A6B8	|
	LDA.l DATA_00BA60,X			;$02A6BA	|
	LDY $0F					;$02A6BE	|
	BEQ CODE_02A6C6				;$02A6C0	|
	LDA.l DATA_00BA70,X			;$02A6C2	|
CODE_02A6C6:
	CLC
	ADC $00					;$02A6C7	|
	STA $05					;$02A6C9	|
	LDA.l DATA_00BA9C,X			;$02A6CB	|
	LDY $0F					;$02A6CF	|
	BEQ CODE_02A6D7				;$02A6D1	|
	LDA.l DATA_00BAAC,X			;$02A6D3	|
CODE_02A6D7:
	ADC $02
	STA $06					;$02A6D9	|
CODE_02A6DB:
	LDA.b #$7E
	STA $07					;$02A6DD	|
	LDX.w $15E9				;$02A6DF	|
	LDA [$05]				;$02A6E2	|
	STA.w $1693				;$02A6E4	|
	INC $07					;$02A6E7	|
	LDA [$05]				;$02A6E9	|
	JSL conditional_map16			;$02A6EB	|
	CMP.b #$00				;$02A6EF	|
	BEQ CODE_02A729				;$02A6F1	|
	LDA.w $1693				;$02A6F3	|
	CMP.b #$11				;$02A6F6	|
	BCC CODE_02A72B				;$02A6F8	|
	CMP.b #$6E				;$02A6FA	|
	BCC CODE_02A727				;$02A6FC	|
	CMP.b #$D8				;$02A6FE	|
	BCS CODE_02A735				;$02A700	|
	LDY $9A					;$02A702	|
	STY $0A					;$02A704	|
	LDY $98					;$02A706	|
	STY $0C					;$02A708	|
	JSL CODE_00FA19				;$02A70A	|
	LDA $00					;$02A70E	|
	CMP.b #$0C				;$02A710	|
	BCS CODE_02A718				;$02A712	|
	CMP [$05],Y				;$02A714	|
	BCC CODE_02A729				;$02A716	|
CODE_02A718:
	LDA [$05],Y
	STA.w $1694				;$02A71A	|
	PHX					;$02A71D	|
	LDX $08					;$02A71E	|
	LDA.l DATA_00E53D,X			;$02A720	|
	PLX					;$02A724	|
	STA $0B					;$02A725	|
CODE_02A727:
	SEC
	RTS					;$02A728	|

CODE_02A729:
	CLC
	RTS					;$02A72A	|

CODE_02A72B:
	LDA $98
	AND.b #$0F				;$02A72D	|
	CMP.b #$06				;$02A72F	|
	BCS CODE_02A729				;$02A731	|
	SEC					;$02A733	|
	RTS					;$02A734	|

CODE_02A735:
	LDA $98
	AND.b #$0F				;$02A737	|
	CMP.b #$06				;$02A739	|
	BCS CODE_02A729				;$02A73B	|
	LDA.w $1715,X				;$02A73D	|
	SEC					;$02A740	|
	SBC.b #$02				;$02A741	|
	STA.w $1715,X				;$02A743	|
	LDA.w $1729,X				;$02A746	|
	SBC.b #$00				;$02A749	|
	STA.w $1729,X				;$02A74B	|
	JMP CODE_02A611				;$02A74E	|

CODE_02A751:
	PHB
	PHK					;$02A752	|
	PLB					;$02A753	|
	JSR CODE_02ABF2				;$02A754	|
	JSR CODE_02AC5C				;$02A757	|
	LDA.w $0D9B				;$02A75A	|
	BMI CODE_02A763				;$02A75D	|
	JSL CODE_01808C				;$02A75F	|
CODE_02A763:
	LDA.w $0DC1
	BEQ CODE_02A771				;$02A766	|
	LDA.w $1B9B				;$02A768	|
	BNE CODE_02A771				;$02A76B	|
	JSL CODE_00FC7A				;$02A76D	|
CODE_02A771:
	PLB
	RTL					;$02A772	|

SpriteSlotMax:
	db $09,$05,$07,$07,$07,$06,$07,$06
	db $06,$09,$08,$04,$07,$07,$07,$08
	db $09,$05,$05

SpriteSlotMax1:
	db $09,$07,$07,$01,$00,$01,$07,$06
	db $06,$00,$02,$00,$07,$01,$07,$08
	db $09,$07,$05

SpriteSlotMax2:
	db $09,$07,$07,$01,$00,$06,$07,$06
	db $06,$00,$02,$00,$07,$01,$07,$08
	db $09,$07,$05

SpriteSlotStart:
	db $FF,$FF,$00,$01,$00,$01,$FF,$01
	db $FF,$00,$FF,$00,$FF,$01,$FF,$FF
	db $FF,$FF,$FF

SpriteSlotStart1:
	db $FF,$05,$FF,$FF,$FF,$FF,$FF,$01
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$05,$FF

ReservedSprite1:
	db $FF,$5F,$54,$5E,$60,$28,$88,$FF
	db $FF,$C5,$86,$28,$FF,$90,$FF,$FF
	db $FF,$AE

ReservedSprite2:
	db $FF,$64,$FF,$FF,$9F,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$9F,$FF,$FF
	db $FF,$FF

DATA_02A7F6:
	db $D0,$00,$20

DATA_02A7F9:
	db $FF,$00,$01

LoadSprFromLevel:
	LDA $13
	AND.b #$01				;$02A7FE	|
	BNE Return02A84B			;$02A800	|
CODE_02A802:
	LDY $55
	LDA $5B					;$02A804	|
	LSR					;$02A806	|
	BCC CODE_02A817				;$02A807	|
	LDA $1C					;$02A809	|
	CLC					;$02A80B	|
	ADC.w DATA_02A7F6,Y			;$02A80C	|
	AND.b #$F0				;$02A80F	|
	STA $00					;$02A811	|
	LDA $1D					;$02A813	|
	BRA CODE_02A823				;$02A815	|

CODE_02A817:
	LDA $1A
	CLC					;$02A819	|
	ADC.w DATA_02A7F6,Y			;$02A81A	|
	AND.b #$F0				;$02A81D	|
	STA $00					;$02A81F	|
	LDA $1B					;$02A821	|
CODE_02A823:
	ADC.w DATA_02A7F9,Y
	BMI Return02A84B			;$02A826	|
	STA $01					;$02A828	|
	LDX.b #$00				;$02A82A	|
	LDY.b #$01				;$02A82C	|
LoadSpriteLoopStrt:
	LDA [$CE],Y
	CMP.b #$FF				;$02A830	|
	BEQ Return02A84B			;$02A832	|
	ASL					;$02A834	|
	ASL					;$02A835	|
	ASL					;$02A836	|
	AND.b #$10				;$02A837	|
	STA $02					;$02A839	|
	INY					;$02A83B	|
	LDA [$CE],Y				;$02A83C	|
	AND.b #$0F				;$02A83E	|
	ORA $02					;$02A840	|
	CMP $01					;$02A842	|
	BCS CODE_02A84C				;$02A844	|
LoadNextSprite:
	INY
	INY					;$02A847	|
	INX					;$02A848	|
	BRA LoadSpriteLoopStrt			;$02A849	|

Return02A84B:
	RTS

CODE_02A84C:
	BNE Return02A84B
	LDA [$CE],Y				;$02A84E	|
	AND.b #$F0				;$02A850	|
	CMP $00					;$02A852	|
	BNE LoadNextSprite			;$02A854	|
	LDA.w $1938,X				;$02A856	|
	BNE LoadNextSprite			;$02A859	|
	STX $02					;$02A85B	|
	INC.w $1938,X				;$02A85D	|
	INY					;$02A860	|
	LDA [$CE],Y				;$02A861	|
	STA $05					;$02A863	|
	DEY					;$02A865	|
	CMP.b #$E7				;$02A866	|
	BCC CODE_02A88C				;$02A868	|
LoadScrollSprite:
	LDA.w $143E
	ORA.w $143F				;$02A86D	|
	BNE CODE_02A88A				;$02A870	|
	PHY					;$02A872	|
	PHX					;$02A873	|
	LDA $05					;$02A874	|
	SEC					;$02A876	|
	SBC.b #$E7				;$02A877	|
	STA.w $143E				;$02A879	|
	DEY					;$02A87C	|
	LDA [$CE],Y				;$02A87D	|
	LSR					;$02A87F	|
	LSR					;$02A880	|
	STA.w $1440				;$02A881	|
	JSL CODE_05BCD6				;$02A884	|
	PLX					;$02A888	|
	PLY					;$02A889	|
CODE_02A88A:
	BRA LoadNextSprite

CODE_02A88C:
	CMP.b #$DE
	BNE CODE_02A89C				;$02A88E	|
	PHY					;$02A890	|
	PHX					;$02A891	|
	DEY					;$02A892	|
	STY $03					;$02A893	|
	JSR Load5Eeries				;$02A895	|
	PLX					;$02A898	|
	PLY					;$02A899	|
CODE_02A89A:
	BRA LoadNextSprite

CODE_02A89C:
	CMP.b #$E0
	BNE CODE_02A8AC				;$02A89E	|
	PHY					;$02A8A0	|
	PHX					;$02A8A1	|
	DEY					;$02A8A2	|
	STY $03					;$02A8A3	|
	JSR Load3Platforms			;$02A8A5	|
	PLX					;$02A8A8	|
	PLY					;$02A8A9	|
	BRA CODE_02A89A				;$02A8AA	|

CODE_02A8AC:
	CMP.b #$CB
	BCC CODE_02A8D4				;$02A8AE	|
	CMP.b #$DA				;$02A8B0	|
	BCS CODE_02A8C0				;$02A8B2	|
InitGenerator:
	SEC
	SBC.b #$CB				;$02A8B5	|
	INC A					;$02A8B7	|
	STA.w $18B9				;$02A8B8	|
	STZ.w $1938,X				;$02A8BB	|
	BRA CODE_02A89A				;$02A8BE	|

CODE_02A8C0:
	CMP.b #$E1
	BCC CODE_02A8D0				;$02A8C2	|
	PHX					;$02A8C4	|
	PHY					;$02A8C5	|
	DEY					;$02A8C6	|
	STY $03					;$02A8C7	|
	JSR CODE_02AAC0				;$02A8C9	|
	PLY					;$02A8CC	|
	PLX					;$02A8CD	|
	BRA CODE_02A89A				;$02A8CE	|

CODE_02A8D0:
	LDA.b #$09
	BRA CODE_02A8DF				;$02A8D2	|

CODE_02A8D4:
	CMP.b #$C9
	BCC LoadNormalSprite			;$02A8D6	|
	JSR LoadShooter				;$02A8D8	|
	BRA CODE_02A89A				;$02A8DB	|

LoadNormalSprite:
	LDA.b #$01
CODE_02A8DF:
	STA $04
	DEY					;$02A8E1	|
	STY $03					;$02A8E2	|
	LDY.w $1692				;$02A8E4	|
	LDX.w SpriteSlotMax,Y			;$02A8E7	|
	LDA.w SpriteSlotStart,Y			;$02A8EA	|
	STA $06					;$02A8ED	|
	LDA $05					;$02A8EF	|
	CMP.w ReservedSprite1,Y			;$02A8F1	|
	BNE CODE_02A8FE				;$02A8F4	|
	LDX.w SpriteSlotMax1,Y			;$02A8F6	|
	LDA.w SpriteSlotStart1,Y		;$02A8F9	|
	STA $06					;$02A8FC	|
CODE_02A8FE:
	LDA $05
	CMP.w ReservedSprite2,Y			;$02A900	|
	BNE CODE_02A916				;$02A903	|
	CMP.b #$64				;$02A905	|
	BNE CODE_02A90F				;$02A907	|
	LDA $00					;$02A909	|
	AND.b #$10				;$02A90B	|
	BEQ CODE_02A916				;$02A90D	|
CODE_02A90F:
	LDX.w SpriteSlotMax2,Y
	LDA.b #$FF				;$02A912	|
	STA $06					;$02A914	|
CODE_02A916:
	STX $0F
CODE_02A918:
	LDA.w $14C8,X
	BEQ CODE_02A93C				;$02A91B	|
	DEX					;$02A91D	|
	CPX $06					;$02A91E	|
	BNE CODE_02A918				;$02A920	|
	LDA $05					;$02A922	|
	CMP.b #$7B				;$02A924	|
	BNE CODE_02A936				;$02A926	|
	LDX $0F					;$02A928	|
ADDR_02A92A:
	LDA.w $167A,X
	AND.b #$02				;$02A92D	|
	BEQ CODE_02A93C				;$02A92F	|
	DEX					;$02A931	|
	CPX $06					;$02A932	|
	BNE ADDR_02A92A				;$02A934	|
CODE_02A936:
	LDX $02
	STZ.w $1938,X				;$02A938	|
	RTS					;$02A93B	|

CODE_02A93C:
	LDY $03
	LDA $5B					;$02A93E	|
	LSR					;$02A940	|
	BCC CODE_02A95B				;$02A941	|
	LDA [$CE],Y				;$02A943	|
	PHA					;$02A945	|
	AND.b #$F0				;$02A946	|
	STA $E4,X				;$02A948	|
	PLA					;$02A94A	|
	AND.b #$0D				;$02A94B	|
	STA.w $14E0,X				;$02A94D	|
	LDA $00					;$02A950	|
	STA $D8,X				;$02A952	|
	LDA $01					;$02A954	|
	STA.w $14D4,X				;$02A956	|
	BRA CODE_02A971				;$02A959	|

CODE_02A95B:
	LDA [$CE],Y
	PHA					;$02A95D	|
	AND.b #$F0				;$02A95E	|
	STA $D8,X				;$02A960	|
	PLA					;$02A962	|
	AND.b #$0D				;$02A963	|
	STA.w $14D4,X				;$02A965	|
	LDA $00					;$02A968	|
	STA $E4,X				;$02A96A	|
	LDA $01					;$02A96C	|
	STA.w $14E0,X				;$02A96E	|
CODE_02A971:
	INY
	INY					;$02A972	|
	LDA $04					;$02A973	|
	STA.w $14C8,X				;$02A975	|
	CMP.b #$09				;$02A978	|
	LDA [$CE],Y				;$02A97A	|
	BCC CODE_02A984 			;$02A97C	|
	SEC					;$02A97E	|
	SBC.b #$DA				;$02A97F	|
	CLC					;$02A981	|
	ADC.b #$04				;$02A982	|
CODE_02A984:
	PHY
	LDY.w $1EEB				;$02A985	|
	BPL CODE_02A996				;$02A988	|
	CMP.b #$04				;$02A98A	|
	BNE CODE_02A990				;$02A98C	|
	LDA.b #$07				;$02A98E	|
CODE_02A990:
	CMP.b #$05
	BNE CODE_02A996				;$02A992	|
	LDA.b #$06				;$02A994	|
CODE_02A996:
	STA $9E,X
	PLY					;$02A998	|
	LDA $02					;$02A999	|
	STA.w $161A,X				;$02A99B	|
	LDA.w $14AE				;$02A99E	|
	BEQ CODE_02A9C9				;$02A9A1	|
	PHX					;$02A9A3	|
	LDA $9E,X				;$02A9A4	|
	TAX					;$02A9A6	|
	LDA.l Sprite190FVals,X			;$02A9A7	|
	PLX					;$02A9AB	|
	AND.b #$40				;$02A9AC	|
	BNE CODE_02A9C9				;$02A9AE	|
	LDA.b #$21				;$02A9B0	|
	STA $9E,X				;$02A9B2	|
	LDA.b #$08				;$02A9B4	|
	STA.w $14C8,X				;$02A9B6	|
	JSL InitSpriteTables			;$02A9B9	|
	LDA.w $15F6,X				;$02A9BD	|
	AND.b #$F1				;$02A9C0	|
	ORA.b #$02				;$02A9C2	|
	STA.w $15F6,X				;$02A9C4	|
	BRA CODE_02A9CD				;$02A9C7	|

CODE_02A9C9:
	JSL InitSpriteTables
CODE_02A9CD:
	LDA.b #$01
	STA.w $15A0,X				;$02A9CF	|
	LDA.b #$04				;$02A9D2	|
	STA.w $1FE2,X				;$02A9D4	|
	INY					;$02A9D7	|
	LDX $02					;$02A9D8	|
	INX					;$02A9DA	|
	JMP LoadSpriteLoopStrt			;$02A9DB	|

FindFreeSlotLowPri:
	LDA.b #$02
	STA $0E					;$02A9E0	|
	BRA CODE_02A9E6				;$02A9E2	|

FindFreeSprSlot:
	STZ $0E
CODE_02A9E6:
	PHB
	PHK					;$02A9E7	|
	PLB					;$02A9E8	|
	JSR FindFreeSlotRt			;$02A9E9	|
	PLB					;$02A9EC	|
	TYA					;$02A9ED	|
	RTL					;$02A9EE	|

FindFreeSlotRt:
	LDY.w $1692
	LDA.w SpriteSlotStart,Y			;$02A9F2	|
	STA $0F					;$02A9F5	|
	LDA.w SpriteSlotMax,Y			;$02A9F7	|
	SEC					;$02A9FA	|
	SBC $0E					;$02A9FB	|
	TAY					;$02A9FD	|
CODE_02A9FE:
	LDA.w $14C8,Y
	BEQ Return02AA0A			;$02AA01	|
	DEY					;$02AA03	|
	CPY $0F					;$02AA04	|
	BNE CODE_02A9FE				;$02AA06	|
	LDY.b #$FF				;$02AA08	|
Return02AA0A:
	RTS

DATA_02AA0B:
	db $31,$71,$A1,$43,$93,$C3,$14,$65
	db $E5,$36,$A7,$39,$99,$F9,$1A,$7A
	db $DA,$4C,$AD,$ED

DATA_02AA1F:
	db $01,$51,$91,$D1,$22,$62,$A2,$73
	db $E3,$C7,$88,$29,$5A,$AA,$EB,$2C
	db $8C,$CC,$FC,$5D

	LDX.b #$0E				;$02AA33	|
ADDR_02AA35:
	STZ.w $1E66,X
	STZ.w $0F86,X				;$02AA38	|
	LDA.b #$08				;$02AA3B	|
	STA.w $1892,X				;$02AA3D	|
	JSL GetRand				;$02AA40	|
	CLC					;$02AA44	|
	ADC $1A					;$02AA45	|
	STA.w $1E16,X				;$02AA47	|
	STA.w $0F4A,X				;$02AA4A	|
	LDA $1B					;$02AA4D	|
	ADC.b #$00				;$02AA4F	|
	STA.w $1E3E,X				;$02AA51	|
	LDY $03					;$02AA54	|
	LDA [$CE],Y				;$02AA56	|
	PHA					;$02AA58	|
	AND.b #$F0				;$02AA59	|
	STA.w $1E02,X				;$02AA5B	|
	PLA					;$02AA5E	|
	AND.b #$01				;$02AA5F	|
	STA.w $1E2A,X				;$02AA61	|
	DEX					;$02AA64	|
	BPL ADDR_02AA35				;$02AA65	|
	RTS					;$02AA67	|

DATA_02AA68:
	db $50,$90,$D0,$10

CODE_02AA6C:
	LDA.b #$07
	STA.w $14CB				;$02AA6E	|
	LDX.b #$03				;$02AA71	|
CODE_02AA73:
	LDA.b #$05
	STA.w $1892,X				;$02AA75	|
	LDA.w DATA_02AA68,X			;$02AA78	|
	STA.w $1E16,X				;$02AA7B	|
	LDA.b #$F0				;$02AA7E	|
	STA.w $1E02,X				;$02AA80	|
	TXA					;$02AA83	|
	ASL					;$02AA84	|
	ASL					;$02AA85	|
	STA.w $0F4A,X				;$02AA86	|
	DEX					;$02AA89	|
	BPL CODE_02AA73				;$02AA8A	|
	RTS					;$02AA8C	|

CODE_02AA8D:
	STZ.w $190A
	LDX.b #$13				;$02AA90	|
CODE_02AA92:
	LDA.b #$07
	STA.w $1892,X				;$02AA94	|
	LDA.w DATA_02AA0B,X			;$02AA97	|
	PHA					;$02AA9A	|
	AND.b #$F0				;$02AA9B	|
	STA.w $1E66,X				;$02AA9D	|
	PLA					;$02AAA0	|
	ASL					;$02AAA1	|
	ASL					;$02AAA2	|
	ASL					;$02AAA3	|
	ASL					;$02AAA4	|
	STA.w $1E52,X				;$02AAA5	|
	LDA.w DATA_02AA1F,X			;$02AAA8	|
	PHA					;$02AAAB	|
	AND.b #$F0				;$02AAAC	|
	STA.w $1E8E,X				;$02AAAE	|
	PLA					;$02AAB1	|
	ASL					;$02AAB2	|
	ASL					;$02AAB3	|
	ASL					;$02AAB4	|
	ASL					;$02AAB5	|
	STA.w $1E7A,X				;$02AAB6	|
	DEX					;$02AAB9	|
	BPL CODE_02AA92				;$02AABA	|
	RTS					;$02AABC	|

DATA_02AABD:
	db $4C,$33,$AA

CODE_02AAC0:
	LDY.b #$01
	STY.w $18B8				;$02AAC2	|
	CMP.b #$E4				;$02AAC5	|
	BEQ DATA_02AABD				;$02AAC7	|
	CMP.b #$E6				;$02AAC9	|
	BEQ CODE_02AA6C				;$02AACB	|
	CMP.b #$E5				;$02AACD	|
	BEQ CODE_02AA8D				;$02AACF	|
	CMP.b #$E2				;$02AAD1	|
	BCS CODE_02AB11				;$02AAD3	|
	LDX.b #$13				;$02AAD5	|
CODE_02AAD7:
	STZ.w $1E66,X
	STZ.w $0F86,X				;$02AADA	|
	LDA.b #$03				;$02AADD	|
	STA.w $1892,X				;$02AADF	|
	JSL GetRand				;$02AAE2	|
	CLC					;$02AAE6	|
	ADC $1A					;$02AAE7	|
	STA.w $1E16,X				;$02AAE9	|
	STA.w $0F4A,X				;$02AAEC	|
	LDA $1B					;$02AAEF	|
	ADC.b #$00				;$02AAF1	|
	STA.w $1E3E,X				;$02AAF3	|
	LDA.w $148E				;$02AAF6	|
	AND.b #$3F				;$02AAF9	|
	ADC.b #$08				;$02AAFB	|
	CLC					;$02AAFD	|
	ADC $1C					;$02AAFE	|
	STA.w $1E02,X				;$02AB00	|
	LDA $1D					;$02AB03	|
	ADC.b #$00				;$02AB05	|
	STA.w $1E2A,X				;$02AB07	|
	DEX					;$02AB0A	|
	BPL CODE_02AAD7				;$02AB0B	|
	INC.w $18BA				;$02AB0D	|
	RTS					;$02AB10	|

CODE_02AB11:
	LDY.w $18BA
	CPY.b #$02				;$02AB14	|
	BCS Return02AB77			;$02AB16	|
	LDY.b #$01				;$02AB18	|
	CMP.b #$E2				;$02AB1A	|
	BEQ CODE_02AB20				;$02AB1C	|
	LDY.b #$FF				;$02AB1E	|
CODE_02AB20:
	STY $0F
	LDA.b #$09				;$02AB22	|
	STA $0E					;$02AB24	|
	LDX.b #$13				;$02AB26	|
CODE_02AB28:
	LDA.w $1892,X
	BNE CODE_02AB71				;$02AB2B	|
	LDA.b #$04				;$02AB2D	|
	STA.w $1892,X				;$02AB2F	|
	LDA.w $18BA				;$02AB32	|
	STA.w $0F86,X				;$02AB35	|
	LDA $0E					;$02AB38	|
	STA.w $0F72,X				;$02AB3A	|
	LDA $0F					;$02AB3D	|
	STA.w $0F4A,X				;$02AB3F	|
	STZ $0F					;$02AB42	|
	BEQ CODE_02AB6D				;$02AB44	|
	LDY $03					;$02AB46	|
	LDA [$CE],Y				;$02AB48	|
	LDY.w $18BA				;$02AB4A	|
	PHA					;$02AB4D	|
	AND.b #$F0				;$02AB4E	|
	STA.w $0FB6,Y				;$02AB50	|
	PLA					;$02AB53	|
	AND.b #$01				;$02AB54	|
	STA.w $0FB8,Y				;$02AB56	|
	LDA $00					;$02AB59	|
	STA.w $0FB2,Y				;$02AB5B	|
	LDA $01					;$02AB5E	|
	STA.w $0FB4,Y				;$02AB60	|
	LDA.b #$00				;$02AB63	|
	STA.w $0FBA,Y				;$02AB65	|
	LDA $02					;$02AB68	|
	STA.w $0FBC,Y				;$02AB6A	|
CODE_02AB6D:
	DEC $0E
	BMI CODE_02AB74				;$02AB6F	|
CODE_02AB71:
	DEX
	BPL CODE_02AB28				;$02AB72	|
CODE_02AB74:
	INC.w $18BA
Return02AB77:
	RTS

LoadShooter:
	STX $02
	DEY					;$02AB7A	|
	STY $03					;$02AB7B	|
	STA $04					;$02AB7D	|
	LDX.b #$07				;$02AB7F	|
CODE_02AB81:
	LDA.w $1783,X
	BEQ CODE_02AB9E				;$02AB84	|
	DEX					;$02AB86	|
	BPL CODE_02AB81				;$02AB87	|
	DEC.w $18FF				;$02AB89	|
	BPL CODE_02AB93				;$02AB8C	|
	LDA.b #$07				;$02AB8E	|
	STA.w $18FF				;$02AB90	|
CODE_02AB93:
	LDX.w $18FF
	LDY.w $17B3,X				;$02AB96	|
	LDA.b #$00				;$02AB99	|
	STA.w $1938,Y				;$02AB9B	|
CODE_02AB9E:
	LDY $03
	LDA $04					;$02ABA0	|
	SEC					;$02ABA2	|
	SBC.b #$C8				;$02ABA3	|
	STA.w $1783,X				;$02ABA5	|
	LDA $5B					;$02ABA8	|
	LSR					;$02ABAA	|
	BCC CODE_02ABC7				;$02ABAB	|
	LDA [$CE],Y				;$02ABAD	|
	PHA					;$02ABAF	|
	AND.b #$F0				;$02ABB0	|
	STA.w $179B,X				;$02ABB2	|
	PLA					;$02ABB5	|
	AND.b #$01				;$02ABB6	|
	STA.w $17A3,X				;$02ABB8	|
	LDA $00					;$02ABBB	|
	STA.w $178B,X				;$02ABBD	|
	LDA $01					;$02ABC0	|
	STA.w $1793,X				;$02ABC2	|
	BRA CODE_02ABDF				;$02ABC5	|

CODE_02ABC7:
	LDA [$CE],Y
	PHA					;$02ABC9	|
	AND.b #$F0				;$02ABCA	|
	STA.w $178B,X				;$02ABCC	|
	PLA					;$02ABCF	|
	AND.b #$01				;$02ABD0	|
	STA.w $1793,X				;$02ABD2	|
	LDA $00					;$02ABD5	|
	STA.w $179B,X				;$02ABD7	|
	LDA $01					;$02ABDA	|
	STA.w $17A3,X				;$02ABDC	|
CODE_02ABDF:
	LDA $02
	STA.w $17B3,X				;$02ABE1	|
	LDA.b #$10				;$02ABE4	|
	STA.w $17AB,X				;$02ABE6	|
	INY					;$02ABE9	|
	INY					;$02ABEA	|
	INY					;$02ABEB	|
	LDX $02					;$02ABEC	|
	INX					;$02ABEE	|
	JMP LoadSpriteLoopStrt			;$02ABEF	|

CODE_02ABF2:
	LDX.b #$3F
CODE_02ABF4:
	STZ.w $1938,X
	DEX					;$02ABF7	|
	BPL CODE_02ABF4				;$02ABF8	|
	LDA.b #$FF				;$02ABFA	|
	STA $00					;$02ABFC	|
	LDX.b #$0B				;$02ABFE	|
CODE_02AC00:
	LDA.b #$FF
	STA.w $161A,X				;$02AC02	|
	LDA.w $14C8,X				;$02AC05	|
	CMP.b #$0B				;$02AC08	|
	BEQ CODE_02AC11				;$02AC0A	|
	STZ.w $14C8,X				;$02AC0C	|
	BRA CODE_02AC13				;$02AC0F	|

CODE_02AC11:
	STX $00
CODE_02AC13:
	DEX
	BPL CODE_02AC00				;$02AC14	|
	LDX $00					;$02AC16	|
	BMI CODE_02AC48				;$02AC18	|
	STZ.w $14C8,X				;$02AC1A	|
	LDA.b #$0B				;$02AC1D	|
	STA.w $14C8				;$02AC1F	|
	LDA $9E,X				;$02AC22	|
	STA $9E					;$02AC24	|
	LDA $E4,X				;$02AC26	|
	STA $E4					;$02AC28	|
	LDA.w $14E0,X				;$02AC2A	|
	STA.w $14E0				;$02AC2D	|
	LDA $D8,X				;$02AC30	|
	STA $D8					;$02AC32	|
	LDA.w $14D4,X				;$02AC34	|
	STA.w $14D4				;$02AC37	|
	LDA.w $15F6,X				;$02AC3A	|
	PHA					;$02AC3D	|
	LDX.b #$00				;$02AC3E	|
	JSL InitSpriteTables			;$02AC40	|
	PLA					;$02AC44	|
	STA.w $15F6				;$02AC45	|
CODE_02AC48:
	REP #$10
	LDX.w #$027A				;$02AC4A	|
CODE_02AC4D:
	STZ.w $1693,X
	DEX					;$02AC50	|
	BPL CODE_02AC4D				;$02AC51	|
	SEP #$10				;$02AC53	|
	STZ.w $143E				;$02AC55	|
	STZ.w $143F				;$02AC58	|
	RTS					;$02AC5B	|

CODE_02AC5C:
	LDA $5B
	LSR					;$02AC5E	|
	BCC CODE_02ACA1				;$02AC5F	|
	LDA $55					;$02AC61	|
	PHA					;$02AC63	|
	LDA.b #$01				;$02AC64	|
	STA $55					;$02AC66	|
	LDA $1C					;$02AC68	|
	PHA					;$02AC6A	|
	SEC					;$02AC6B	|
	SBC.b #$60				;$02AC6C	|
	STA $1C					;$02AC6E	|
	LDA $1D					;$02AC70	|
	PHA					;$02AC72	|
	SBC.b #$00				;$02AC73	|
	STA $1D					;$02AC75	|
	STZ.w $18B6				;$02AC77	|
CODE_02AC7A:
	JSR CODE_02A802
	JSR CODE_02A802				;$02AC7D	|
	LDA $1C					;$02AC80	|
	CLC					;$02AC82	|
	ADC.b #$10				;$02AC83	|
	STA $1C					;$02AC85	|
	LDA $1D					;$02AC87	|
	ADC.b #$00				;$02AC89	|
	STA $1D					;$02AC8B	|
	INC.w $18B6				;$02AC8D	|
	LDA.w $18B6				;$02AC90	|
	CMP.b #$20				;$02AC93	|
	BCC CODE_02AC7A				;$02AC95	|
	PLA					;$02AC97	|
	STA $1D					;$02AC98	|
	PLA					;$02AC9A	|
	STA $1C					;$02AC9B	|
	PLA					;$02AC9D	|
	STA $55					;$02AC9E	|
	RTS					;$02ACA0	|

CODE_02ACA1:
	LDA $55
	PHA					;$02ACA3	|
	LDA.b #$01				;$02ACA4	|
	STA $55					;$02ACA6	|
	LDA $1A					;$02ACA8	|
	PHA					;$02ACAA	|
	SEC					;$02ACAB	|
	SBC.b #$60				;$02ACAC	|
	STA $1A					;$02ACAE	|
	LDA $1B					;$02ACB0	|
	PHA					;$02ACB2	|
	SBC.b #$00				;$02ACB3	|
	STA $1B					;$02ACB5	|
	STZ.w $18B6				;$02ACB7	|
CODE_02ACBA:
	JSR CODE_02A802
	JSR CODE_02A802				;$02ACBD	|
	LDA $1A					;$02ACC0	|
	CLC					;$02ACC2	|
	ADC.b #$10				;$02ACC3	|
	STA $1A					;$02ACC5	|
	LDA $1B					;$02ACC7	|
	ADC.b #$00				;$02ACC9	|
	STA $1B					;$02ACCB	|
	INC.w $18B6				;$02ACCD	|
	LDA.w $18B6				;$02ACD0	|
	CMP.b #$20				;$02ACD3	|
	BCC CODE_02ACBA				;$02ACD5	|
	PLA					;$02ACD7	|
	STA $1B					;$02ACD8	|
	PLA					;$02ACDA	|
	STA $1A					;$02ACDB	|
	PLA					;$02ACDD	|
	STA $55					;$02ACDE	|
	RTS					;$02ACE0	|

CODE_02ACE1:
	PHX
	TYX					;$02ACE2	|
	BRA CODE_02ACE6				;$02ACE3	|

GivePoints:
	PHX
CODE_02ACE6:
	CLC
	ADC.b #$05				;$02ACE7	|
	JSL CODE_02ACEF				;$02ACE9	|
	PLX					;$02ACED	|
	RTL					;$02ACEE	|

CODE_02ACEF:
	PHY
	PHA					;$02ACF0	|
	JSL CODE_02AD34				;$02ACF1	|
	PLA					;$02ACF5	|
	STA.w $16E1,Y				;$02ACF6	|
	LDA $D8,X				;$02ACF9	|
	SEC					;$02ACFB	|
	SBC.b #$08				;$02ACFC	|
	STA.w $16E7,Y				;$02ACFE	|
	PHA					;$02AD01	|
	LDA.w $14D4,X				;$02AD02	|
	SBC.b #$00				;$02AD05	|
	STA.w $16F9,Y				;$02AD07	|
	PLA					;$02AD0A	|
	SEC					;$02AD0B	|
	SBC $1C					;$02AD0C	|
	CMP.b #$F0				;$02AD0E	|
	BCC CODE_02AD22				;$02AD10	|
	LDA.w $16E7,Y				;$02AD12	|
	ADC.b #$10				;$02AD15	|
	STA.w $16E7,Y				;$02AD17	|
	LDA.w $16F9,Y				;$02AD1A	|
	ADC.b #$00				;$02AD1D	|
	STA.w $16F9,Y				;$02AD1F	|
CODE_02AD22:
	LDA $E4,X
	STA.w $16ED,Y				;$02AD24	|
	LDA.w $14E0,X				;$02AD27	|
	STA.w $16F3,Y				;$02AD2A	|
	LDA.b #$30				;$02AD2D	|
	STA.w $16FF,Y				;$02AD2F	|
	PLY					;$02AD32	|
	RTL					;$02AD33	|

CODE_02AD34:
	LDY.b #$05
CODE_02AD36:
	LDA.w $16E1,Y
	BEQ Return02AD4B			;$02AD39	|
	DEY					;$02AD3B	|
	BPL CODE_02AD36				;$02AD3C	|
	DEC.w $18F7				;$02AD3E	|
	BPL CODE_02AD48				;$02AD41	|
	LDA.b #$05				;$02AD43	|
	STA.w $18F7				;$02AD45	|
CODE_02AD48:
	LDY.w $18F7
Return02AD4B:
	RTL

PointTile1:
	db $00,$83,$83,$83,$83,$44,$54,$46
	db $47,$44,$54,$46,$47,$56,$29,$39
	db $38,$5E,$5E,$5E,$5E,$5E

PointTile2:
	db $00,$44,$54,$46,$47,$45,$45,$45
	db $45,$55,$55,$55,$55,$57,$57,$57
	db $57,$4E,$44,$4F,$54,$5D

PointMultiplierLo:
	db $00,$01,$02,$04,$08,$0A,$14,$28
	db $50,$64,$C8,$90,$20,$00,$00,$00
	db $00

PointMultiplierHi:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$01,$03,$00,$00,$00
	db $00

PointSpeedY:
	db $03,$01,$00,$00

DATA_02AD9E:
	db $B0,$B8,$C0,$C8,$D0,$D8

ScoreSprGfx:
	BIT.w $0D9B
	BVC CODE_02ADB8				;$02ADA7	|
	LDA.w $0D9B				;$02ADA9	|
	CMP.b #$C1				;$02ADAC	|
	BEQ Return02ADC8			;$02ADAE	|
	LDA.b #$F0				;$02ADB0	|
	STA.w $0205				;$02ADB2	|
	STA.w $0209				;$02ADB5	|
CODE_02ADB8:
	LDX.b #$05
CODE_02ADBA:
	STX.w $15E9
	LDA.w $16E1,X				;$02ADBD	|
	BEQ CODE_02ADC5				;$02ADC0	|
	JSR CODE_02ADC9				;$02ADC2	|
CODE_02ADC5:
	DEX
	BPL CODE_02ADBA				;$02ADC6	|
Return02ADC8:
	RTS

CODE_02ADC9:
	LDA $9D
	BEQ CODE_02ADD0				;$02ADCA	|
	JMP CODE_02AE5B				;$02ADCD	|
CODE_02ADD0:
	LDA.w $16FF,X				;$02ADD0	|
	BNE CODE_02ADE4				;$02ADD3	|
	STZ.w $16E1,X				;$02ADD5	|
	RTS					;$02ADD8	|

CoinsToGive:
	db $01,$02,$03,$05,$05,$0A,$0F,$14
	db $19

attributes2Upand3Up:
	db $04,$06

CODE_02ADE4:
	DEC.w $16FF,X				;$02ADE4	|
	CMP.b #$2A				;$02ADE7	|
	BNE CODE_02AE38				;$02ADE9	|
	LDY.w $16E1,X				;$02ADEB	|
	CPY.b #$0D				;$02ADEE	|
	BCC CODE_02AE12				;$02ADF0	|
	CPY.b #$11				;$02ADF2	|
	BCC CODE_02AE03				;$02ADF4	|
	PHX					;$02ADF6	|
	PHY					;$02ADF7	|
	LDA.w $ADCC,Y				;$02ADF8	|
	JSL ADDR_05B329				;$02ADFB	|
	PLY					;$02ADFF	|
	PLX					;$02AE00	|
	BRA CODE_02AE12				;$02AE01	|

CODE_02AE03:
	LDA.w $ADCC,Y
	CLC					;$02AE06	|
	ADC.w $18E4				;$02AE07	|
	STA.w $18E4				;$02AE0A	|
	STZ.w $18E5				;$02AE0D	|
	BRA CODE_02AE35				;$02AE10	|

CODE_02AE12:
	LDA.w $0DB3
	ASL					;$02AE15	|
	ADC.w $0DB3				;$02AE16	|
	TAX					;$02AE19	|
	LDA.w $0F34,X				;$02AE1A	|
	CLC					;$02AE1D	|
	ADC.w PointMultiplierLo,Y		;$02AE1E	|
	STA.w $0F34,X				;$02AE21	|
	LDA.w $0F35,X				;$02AE24	|
	ADC.w PointMultiplierHi,Y		;$02AE27	|
	STA.w $0F35,X				;$02AE2A	|
	LDA.w $0F36,X				;$02AE2D	|
	ADC.b #$00				;$02AE30	|
	STA.w $0F36,X				;$02AE32	|
CODE_02AE35:
	LDX.w $15E9
CODE_02AE38:
	LDA.w $16FF,X
	LSR					;$02AE3B	|
	LSR					;$02AE3C	|
	LSR					;$02AE3D	|
	LSR					;$02AE3E	|
	TAY					;$02AE3F	|
	LDA $13					;$02AE40	|
	AND.w PointSpeedY,Y			;$02AE42	|
	BNE CODE_02AE5B				;$02AE45	|
	LDA.w $16E7,X				;$02AE47	|
	TAY					;$02AE4A	|
	SEC					;$02AE4B	|
	SBC $1C					;$02AE4C	|
	CMP.b #$04				;$02AE4E	|
	BCC CODE_02AE5B				;$02AE50	|
	DEC.w $16E7,X				;$02AE52	|
	TYA					;$02AE55	|
	BNE CODE_02AE5B				;$02AE56	|
	DEC.w $16F9,X				;$02AE58	|
CODE_02AE5B:
	LDA.w $1705,X
	ASL					;$02AE5E	|
	ASL					;$02AE5F	|
	TAY					;$02AE60	|
	REP #$20				;$02AE61	|
	LDA.w $001C,y				;$02AE63	|
	STA $02					;$02AE66	|
	LDA.w $001A,y				;$02AE68	|
	STA $04					;$02AE6B	|
	SEP #$20				;$02AE6D	|
	LDA.w $16ED,X				;$02AE6F	|
	CLC					;$02AE72	|
	ADC.b #$0C				;$02AE73	|
	PHP					;$02AE75	|
	SEC					;$02AE76	|
	SBC $04					;$02AE77	|
	LDA.w $16F3,X				;$02AE79	|
	SBC $05					;$02AE7C	|
	PLP					;$02AE7E	|
	ADC.b #$00				;$02AE7F	|
	BNE Return02AEFB			;$02AE81	|
	LDA.w $16ED,X				;$02AE83	|
	CMP $04					;$02AE86	|
	LDA.w $16F3,X				;$02AE88	|
	SBC $05					;$02AE8B	|
	BNE Return02AEFB			;$02AE8D	|
	LDA.w $16E7,X				;$02AE8F	|
	CMP $02					;$02AE92	|
	LDA.w $16F9,X				;$02AE94	|
	SBC $03					;$02AE97	|
	BNE Return02AEFB			;$02AE99	|
	LDY.w DATA_02AD9E,X			;$02AE9B	|
	BIT.w $0D9B				;$02AE9E	|
	BVC CODE_02AEA5				;$02AEA1	|
	LDY.b #$04				;$02AEA3	|
CODE_02AEA5:
	LDA.w $16E7,X
	SEC					;$02AEA8	|
	SBC $02					;$02AEA9	|
	STA.w $0201,Y				;$02AEAB	|
	STA.w $0205,Y				;$02AEAE	|
	LDA.w $16ED,X				;$02AEB1	|
	SEC					;$02AEB4	|
	SBC $04					;$02AEB5	|
	STA.w $0200,Y				;$02AEB7	|
	CLC					;$02AEBA	|
	ADC.b #$08				;$02AEBB	|
	STA.w $0204,Y				;$02AEBD	|
	PHX					;$02AEC0	|
	LDA.w $16E1,X				;$02AEC1	|
	TAX					;$02AEC4	|
	LDA.w PointTile1,X			;$02AEC5	|
	STA.w $0202,Y				;$02AEC8	|
	LDA.w PointTile2,X			;$02AECB	|
	STA.w $0206,Y				;$02AECE	|
	PLX					;$02AED1	|
	PHY					;$02AED2	|
	LDY.w $16E1,X				;$02AED3	|
	CPY.b #$0E				;$02AED6	|
	LDA.b #$08				;$02AED8	|
	BCC CODE_02AEDF				;$02AEDA	|
	LDA.w $ADD4,Y				;$02AEDC	|
CODE_02AEDF:
	PLY
	ORA.b #$30				;$02AEE0	|
	STA.w $0203,Y				;$02AEE2	|
	STA.w $0207,Y				;$02AEE5	|
	TYA					;$02AEE8	|
	LSR					;$02AEE9	|
	LSR					;$02AEEA	|
	TAY					;$02AEEB	|
	LDA.b #$00				;$02AEEC	|
	STA.w $0420,Y				;$02AEEE	|
	STA.w $0421,Y				;$02AEF1	|
	LDA.w $16E1,X				;$02AEF4	|
	CMP.b #$11				;$02AEF7	|
	BCS ADDR_02AEFC				;$02AEF9	|
Return02AEFB:
	RTS

ADDR_02AEFC:
	LDY.b #$4C
	LDA.w $16ED,X				;$02AEFE	|
	SEC					;$02AF01	|
	SBC $04					;$02AF02	|
	SEC					;$02AF04	|
	SBC.b #$08				;$02AF05	|
	STA.w $0200,Y				;$02AF07	|
	LDA.w $16E7,X				;$02AF0A	|
	SEC					;$02AF0D	|
	SBC $02					;$02AF0E	|
	STA.w $0201,Y				;$02AF10	|
	LDA.b #$5F				;$02AF13	|
	STA.w $0202,Y				;$02AF15	|
	LDA.b #$04				;$02AF18	|
	ORA.b #$30				;$02AF1A	|
	STA.w $0203,Y				;$02AF1C	|
	TYA					;$02AF1F	|
	LSR					;$02AF20	|
	LSR					;$02AF21	|
	TAY					;$02AF22	|
	LDA.b #$00				;$02AF23	|
	STA.w $0420,Y				;$02AF25	|
	RTS					;$02AF28	|

	STZ.w $16E1,X				;$02AF29	|
	RTS					;$02AF2C	|

DATA_02AF2D:
	db $00,$AA,$54

DATA_02AF30:
	db $00,$00,$01

Load3Platforms:
	LDY $03
	LDA [$CE],Y				;$02AF35	|
	PHA					;$02AF37	|
	AND.b #$F0				;$02AF38	|
	STA $08					;$02AF3A	|
	PLA					;$02AF3C	|
	AND.b #$01				;$02AF3D	|
	STA $09					;$02AF3F	|
	LDA.b #$02				;$02AF41	|
	STA $04					;$02AF43	|
CODE_02AF45:
	JSL FindFreeSprSlot
	BMI Return02AF86			;$02AF49	|
	TYX					;$02AF4B	|
	LDA.b #$01				;$02AF4C	|
	STA.w $14C8,X				;$02AF4E	|
	LDA.b #$A3				;$02AF51	|
	STA $9E,X				;$02AF53	|
	JSL InitSpriteTables			;$02AF55	|
	LDA $00					;$02AF59	|
	STA $E4,X				;$02AF5B	|
	LDA $01					;$02AF5D	|
	STA.w $14E0,X				;$02AF5F	|
	LDA $08					;$02AF62	|
	STA $D8,X				;$02AF64	|
	LDA $09					;$02AF66	|
	STA.w $14D4,X				;$02AF68	|
	LDY $04					;$02AF6B	|
	LDA.w DATA_02AF2D,Y			;$02AF6D	|
	STA.w $1602,X				;$02AF70	|
	LDA.w DATA_02AF30,Y			;$02AF73	|
	STA.w $151C,X				;$02AF76	|
	CPY.b #$02				;$02AF79	|
	BNE CODE_02AF82				;$02AF7B	|
	LDA $02					;$02AF7D	|
	STA.w $161A,X				;$02AF7F	|
CODE_02AF82:
	DEC $04
	BPL CODE_02AF45				;$02AF84	|
Return02AF86:
	RTS

EerieGroupDispXLo:
	db $E0,$F0,$00,$10,$20

EerieGroupDispXHi:
	db $FF,$FF,$00,$00,$00

EerieGroupSpeedY:
	db $17,$E9,$17,$E9,$17

EerieGroupState:
	db $00,$01,$00,$01,$00

EerieGroupSpeedX:
	db $10,$F0

Load5Eeries:
	LDY $03
	LDA [$CE],Y				;$02AF9F	|
	PHA					;$02AFA1	|
	AND.b #$F0				;$02AFA2	|
	STA $08					;$02AFA4	|
	PLA					;$02AFA6	|
	AND.b #$01				;$02AFA7	|
	STA $09					;$02AFA9	|
	LDA.b #$04				;$02AFAB	|
	STA $04					;$02AFAD	|
CODE_02AFAF:
	JSL FindFreeSprSlot
	BMI Return02AFFD			;$02AFB3	|
	TYX					;$02AFB5	|
	LDA.b #$08				;$02AFB6	|
	STA.w $14C8,X				;$02AFB8	|
	LDA.b #$39				;$02AFBB	|
	STA $9E,X				;$02AFBD	|
	JSL InitSpriteTables			;$02AFBF	|
	LDY $04					;$02AFC3	|
	LDA $00					;$02AFC5	|
	CLC					;$02AFC7	|
	ADC.w EerieGroupDispXLo,Y		;$02AFC8	|
	STA $E4,X				;$02AFCB	|
	LDA $01					;$02AFCD	|
	ADC.w EerieGroupDispXHi,Y		;$02AFCF	|
	STA.w $14E0,X				;$02AFD2	|
	LDA $08					;$02AFD5	|
	STA $D8,X				;$02AFD7	|
	LDA $09					;$02AFD9	|
	STA.w $14D4,X				;$02AFDB	|
	LDA.w EerieGroupSpeedY,Y		;$02AFDE	|
	STA $AA,X				;$02AFE1	|
	LDA.w EerieGroupState,Y			;$02AFE3	|
	STA $C2,X				;$02AFE6	|
	CPY.b #$04				;$02AFE8	|
	BNE CODE_02AFF1				;$02AFEA	|
	LDA $02					;$02AFEC	|
	STA.w $161A,X				;$02AFEE	|
CODE_02AFF1:
	JSR SubHorzPosBnk2
	LDA.w EerieGroupSpeedX,Y		;$02AFF4	|
	STA $B6,X				;$02AFF7	|
	DEC $04					;$02AFF9	|
	BPL CODE_02AFAF				;$02AFFB	|
Return02AFFD:
	RTS

CallGenerator:
	LDA.w $18B9
	BEQ Return02B02A			;$02B001	|
	LDY $9D					;$02B003	|
	BNE Return02B02A			;$02B005	|
	DEC A					;$02B007	|
	JSL execute_pointer			;$02B008	|

GeneratorPtrs:
	dw GenerateEerie
	dw GenParaEnemy
	dw GenParaEnemy
	dw GenParaEnemy
	dw GenerateDolphin
	dw GenerateDolphin
	dw GenerateFish
	dw TurnOffGen2
	dw GenSuperKoopa
	dw GenerateBubble
	dw GenerateBullet
	dw GenMultiBullets
	dw GenMultiBullets
	dw GenerateFire
	dw TurnOffGenerators

Return02B02A:
	RTS

TurnOffGen2:
	INC.w $18BF
	STZ.w $18C0				;$02B02E	|
	RTS					;$02B031	|

TurnOffGenerators:
	STZ.w $18B9
	RTS					;$02B035	|

GenerateFire:
	LDA $14
	AND.b #$7F				;$02B038	|
	BNE Return02B07B			;$02B03A	|
	JSL FindFreeSlotLowPri			;$02B03C	|
	BMI Return02B07B			;$02B040	|
	TYX					;$02B042	|
	LDA.b #$17				;$02B043	|
	STA.w $1DFC				;$02B045	|
	LDA.b #$08				;$02B048	|
	STA.w $14C8,X				;$02B04A	|
	LDA.b #$B3				;$02B04D	|
	STA $9E,X				;$02B04F	|
	JSL InitSpriteTables			;$02B051	|
	JSL GetRand				;$02B055	|
	AND.b #$7F				;$02B059	|
	ADC.b #$20				;$02B05B	|
	ADC $1C					;$02B05D	|
	AND.b #$F0				;$02B05F	|
	STA $D8,X				;$02B061	|
	LDA $1D					;$02B063	|
	ADC.b #$00				;$02B065	|
	STA.w $14D4,X				;$02B067	|
	LDA $1A					;$02B06A	|
	CLC					;$02B06C	|
	ADC.b #$FF				;$02B06D	|
	STA $E4,X				;$02B06F	|
	LDA $1B					;$02B071	|
	ADC.b #$00				;$02B073	|
	STA.w $14E0,X				;$02B075	|
	INC.w $157C,X				;$02B078	|
Return02B07B:
	RTS

GenerateBullet:
	LDA $14
	AND.b #$7F				;$02B07E	|
	BNE Return02B0C8			;$02B080	|
	JSL FindFreeSlotLowPri			;$02B082	|
	BMI Return02B0C8			;$02B086	|
	LDA.b #$09				;$02B088	|
	STA.w $1DFC				;$02B08A	|
	TYX					;$02B08D	|
	LDA.b #$08				;$02B08E	|
	STA.w $14C8,X				;$02B090	|
	LDA.b #$1C				;$02B093	|
	STA $9E,X				;$02B095	|
	JSL InitSpriteTables			;$02B097	|
	JSL GetRand				;$02B09B	|
	PHA					;$02B09F	|
	AND.b #$7F				;$02B0A0	|
	ADC.b #$20				;$02B0A2	|
	ADC $1C					;$02B0A4	|
	AND.b #$F0				;$02B0A6	|
	STA $D8,X				;$02B0A8	|
	LDA $1D					;$02B0AA	|
	ADC.b #$00				;$02B0AC	|
	STA.w $14D4,X				;$02B0AE	|
	PLA					;$02B0B1	|
	AND.b #$01				;$02B0B2	|
	TAY					;$02B0B4	|
	LDA $1A					;$02B0B5	|
	CLC					;$02B0B7	|
	ADC.w DATA_02B1B8,Y			;$02B0B8	|
	STA $E4,X				;$02B0BB	|
CODE_02B0BD:
	LDA $1B
CODE_02B0BF:
	ADC.w DATA_02B1BA,Y
	STA.w $14E0,X				;$02B0C2	|
	TYA					;$02B0C5	|
	STA $C2,X				;$02B0C6	|
Return02B0C8:
	RTS

DATA_02B0C9:
	db $04,$08,$04,$03

GenMultiBullets:
	LDA $14
	LSR					;$02B0CF	|
	BCS Return02B0F9			;$02B0D0	|
	LDA.w $18FE				;$02B0D2	|
	INC.w $18FE				;$02B0D5	|
	CMP.b #$A0				;$02B0D8	|
	BNE Return02B0F9			;$02B0DA	|
	STZ.w $18FE				;$02B0DC	|
	LDA.b #$09				;$02B0DF	|
	STA.w $1DFC				;$02B0E1	|
	LDY.w $18B9				;$02B0E4	|
	LDA.w CODE_02B0BD,Y			;$02B0E7	|
	LDX.w CODE_02B0BF,Y			;$02B0EA	|
	STA $0D					;$02B0ED	|
CODE_02B0EF:
	PHX
	JSR CODE_02B115				;$02B0F0	|
	DEC $0D					;$02B0F3	|
	PLX					;$02B0F5	|
	DEX					;$02B0F6	|
	BPL CODE_02B0EF				;$02B0F7	|
Return02B0F9:
	RTS

DATA_02B0FA:
	db $00,$00,$40,$C0,$F0,$00,$00,$F0
	db $F0

DATA_02B103:
	db $50,$B0,$E0,$E0,$80,$00,$E0,$E0
	db $00

DATA_02B10C:
	db $00,$00,$02,$02,$01,$05,$04,$07
	db $06

CODE_02B115:
	JSL FindFreeSlotLowPri
	BMI Return02B152			;$02B119	|
	LDA.b #$1C				;$02B11B	|
	STA.w $009E,y				;$02B11D	|
	LDA.b #$08				;$02B120	|
	STA.w $14C8,Y				;$02B122	|
	TYX					;$02B125	|
	JSL InitSpriteTables			;$02B126	|
	LDX $0D					;$02B12A	|
	LDA.w DATA_02B0FA,X			;$02B12C	|
	CLC					;$02B12F	|
	ADC $1A					;$02B130	|
	STA.w $00E4,y				;$02B132	|
	LDA $1B					;$02B135	|
	ADC.b #$00				;$02B137	|
	STA.w $14E0,Y				;$02B139	|
	LDA.w DATA_02B103,X			;$02B13C	|
	CLC					;$02B13F	|
	ADC $1C					;$02B140	|
	STA.w $00D8,y				;$02B142	|
	LDA $1D					;$02B145	|
	ADC.b #$00				;$02B147	|
	STA.w $14D4,Y				;$02B149	|
	LDA.w DATA_02B10C,X			;$02B14C	|
	STA.w $00C2,y				;$02B14F	|
Return02B152:
	RTS

DATA_02B153:
	db $10,$18,$20,$28

DATA_02B157:
	db $18,$1A,$1C,$1E

GenerateFish:
	LDA $14
	AND.b #$1F				;$02B15D	|
	BNE Return02B1B7			;$02B15F	|
	JSL FindFreeSlotLowPri			;$02B161	|
	BMI Return02B1B7			;$02B165	|
	TYX					;$02B167	|
	LDA.b #$08				;$02B168	|
	STA.w $14C8,X				;$02B16A	|
	LDA.b #$17				;$02B16D	|
	STA $9E,X				;$02B16F	|
	JSL InitSpriteTables			;$02B171	|
	LDA $1C					;$02B175	|
	CLC					;$02B177	|
	ADC.b #$C0				;$02B178	|
	STA $D8,X				;$02B17A	|
	LDA $1D					;$02B17C	|
	ADC.b #$00				;$02B17E	|
	STA.w $14D4,X				;$02B180	|
	JSL GetRand				;$02B183	|
	CMP.b #$00				;$02B187	|
	PHP					;$02B189	|
	PHP					;$02B18A	|
	AND.b #$03				;$02B18B	|
	TAY					;$02B18D	|
	LDA.w DATA_02B153,Y			;$02B18E	|
	PLP					;$02B191	|
	BPL CODE_02B196				;$02B192	|
	EOR.b #$FF				;$02B194	|
CODE_02B196:
	CLC
	ADC $1A					;$02B197	|
	STA $E4,X				;$02B199	|
	LDA $1B					;$02B19B	|
	ADC.b #$00				;$02B19D	|
	STA.w $14E0,X				;$02B19F	|
	LDA.w $148E				;$02B1A2	|
	AND.b #$03				;$02B1A5	|
	TAY					;$02B1A7	|
	LDA.w DATA_02B157,Y			;$02B1A8	|
	PLP					;$02B1AB	|
	BPL CODE_02B1B1				;$02B1AC	|
	EOR.b #$FF				;$02B1AE	|
	INC A					;$02B1B0	|
CODE_02B1B1:
	STA $B6,X
	LDA.b #$B8				;$02B1B3	|
	STA $AA,X				;$02B1B5	|
Return02B1B7:
	RTS

DATA_02B1B8:
	db $E0,$10

DATA_02B1BA:
	db $FF,$01

GenSuperKoopa:
	LDA $14
	AND.b #$3F				;$02B1BE	|
	BNE Return02B206			;$02B1C0	|
	JSL FindFreeSlotLowPri			;$02B1C2	|
	BMI Return02B206			;$02B1C6	|
	TYX					;$02B1C8	|
	LDA.b #$08				;$02B1C9	|
	STA.w $14C8,X				;$02B1CB	|
	LDA.b #$71				;$02B1CE	|
	STA $9E,X				;$02B1D0	|
	JSL InitSpriteTables			;$02B1D2	|
	JSL GetRand				;$02B1D6	|
	PHA					;$02B1DA	|
	AND.b #$3F				;$02B1DB	|
	ADC.b #$20				;$02B1DD	|
	ADC $1C					;$02B1DF	|
	STA $D8,X				;$02B1E1	|
	LDA $1D					;$02B1E3	|
	ADC.b #$00				;$02B1E5	|
	STA.w $14D4,X				;$02B1E7	|
	LDA.b #$28				;$02B1EA	|
	STA $AA,X				;$02B1EC	|
	PLA					;$02B1EE	|
	AND.b #$01				;$02B1EF	|
	TAY					;$02B1F1	|
	LDA $1A					;$02B1F2	|
	CLC					;$02B1F4	|
	ADC.w DATA_02B1B8,Y			;$02B1F5	|
	STA $E4,X				;$02B1F8	|
	LDA $1B					;$02B1FA	|
	ADC.w DATA_02B1BA,Y			;$02B1FC	|
	STA.w $14E0,X				;$02B1FF	|
	TYA					;$02B202	|
	STA.w $157C,X				;$02B203	|
Return02B206:
	RTS

GenerateBubble:
	LDA $14
	AND.b #$7F				;$02B209	|
	BNE Return02B259			;$02B20B	|
	JSL FindFreeSlotLowPri			;$02B20D	|
	BMI Return02B259			;$02B211	|
	TYX					;$02B213	|
	LDA.b #$08				;$02B214	|
	STA.w $14C8,X				;$02B216	|
	LDA.b #$9D				;$02B219	|
	STA $9E,X				;$02B21B	|
	JSL InitSpriteTables			;$02B21D	|
	JSL GetRand				;$02B221	|
	PHA					;$02B225	|
	AND.b #$3F				;$02B226	|
	ADC.b #$20				;$02B228	|
	ADC $1C					;$02B22A	|
	STA $D8,X				;$02B22C	|
	LDA $1D					;$02B22E	|
	ADC.b #$00				;$02B230	|
	STA.w $14D4,X				;$02B232	|
	PLA					;$02B235	|
	AND.b #$01				;$02B236	|
	TAY					;$02B238	|
	LDA $1A					;$02B239	|
	CLC					;$02B23B	|
	ADC.w DATA_02B1B8,Y			;$02B23C	|
	STA $E4,X				;$02B23F	|
	LDA $1B					;$02B241	|
	ADC.w DATA_02B1BA,Y			;$02B243	|
	STA.w $14E0,X				;$02B246	|
	TYA					;$02B249	|
	STA.w $157C,X				;$02B24A	|
	JSL GetRand				;$02B24D	|
	AND.b #$03				;$02B251	|
	TAY					;$02B253	|
	LDA.w DATA_02B25A,Y			;$02B254	|
	STA $C2,X				;$02B257	|
Return02B259:
	RTS

DATA_02B25A:
	db $00

DATA_02B25B:
	db $01,$02

DATA_02B25D:
	db $00,$10,$E0,$01,$FF,$E8

DATA_02B263:
	db $18

DATA_02B264:
	db $F0

DATA_02B265:
	db $E0,$00,$10,$04,$09,$FF,$04

GenerateDolphin:
	LDA $14
	AND.b #$1F				;$02B26E	|
	BNE Return02B2CF			;$02B270	|
	LDY.w $18B9				;$02B272	|
	LDX.w DATA_02B263,Y			;$02B275	|
	LDA.w DATA_02B265,Y			;$02B278	|
	STA $00					;$02B27B	|
CODE_02B27D:
	LDA.w $14C8,X
	BEQ CODE_02B288				;$02B280	|
	DEX					;$02B282	|
	CPX $00					;$02B283	|
	BNE CODE_02B27D				;$02B285	|
	RTS					;$02B287	|

CODE_02B288:
	LDA.b #$08
	STA.w $14C8,X				;$02B28A	|
	LDA.b #$41				;$02B28D	|
	STA $9E,X				;$02B28F	|
	JSL InitSpriteTables			;$02B291	|
	JSL GetRand				;$02B295	|
	AND.b #$7F				;$02B299	|
	ADC.b #$40				;$02B29B	|
	ADC $1C					;$02B29D	|
	STA $D8,X				;$02B29F	|
	LDA $1D					;$02B2A1	|
	ADC.b #$00				;$02B2A3	|
	STA.w $14D4,X				;$02B2A5	|
	JSL GetRand				;$02B2A8	|
	AND.b #$03				;$02B2AC	|
	TAY					;$02B2AE	|
	LDA.w DATA_02B264,Y			;$02B2AF	|
	STA $AA,X				;$02B2B2	|
	LDY.w $18B9				;$02B2B4	|
	LDA $1A					;$02B2B7	|
	CLC					;$02B2B9	|
	ADC.w Return02B259,Y			;$02B2BA	|
	STA $E4,X				;$02B2BD	|
	LDA $1B					;$02B2BF	|
	ADC.w DATA_02B25B,Y			;$02B2C1	|
	STA.w $14E0,X				;$02B2C4	|
	LDA.w DATA_02B25D,Y			;$02B2C7	|
	STA $B6,X				;$02B2CA	|
	INC.w $151C,X				;$02B2CC	|
Return02B2CF:
	RTS

DATA_02B2D0:
	db $F0,$FF

DATA_02B2D2:
	db $FF,$00

DATA_02B2D4:
	db $10,$F0

GenerateEerie:
	LDA $14
	AND.b #$3F				;$02B2D8	|
	BNE Return02B31E			;$02B2DA	|
	JSL FindFreeSlotLowPri			;$02B2DC	|
	BMI Return02B31E			;$02B2E0	|
	TYX					;$02B2E2	|
	LDA.b #$08				;$02B2E3	|
	STA.w $14C8,X				;$02B2E5	|
	LDA.b #$38				;$02B2E8	|
	STA $9E,X				;$02B2EA	|
	JSL InitSpriteTables			;$02B2EC	|
	JSL GetRand				;$02B2F0	|
	AND.b #$7F				;$02B2F4	|
	ADC.b #$40				;$02B2F6	|
	ADC $1C					;$02B2F8	|
	STA $D8,X				;$02B2FA	|
	LDA $1D					;$02B2FC	|
	ADC.b #$00				;$02B2FE	|
	STA.w $14D4,X				;$02B300	|
	LDA.w $148E				;$02B303	|
	AND.b #$01				;$02B306	|
	TAY					;$02B308	|
	LDA.w DATA_02B2D0,Y			;$02B309	|
	CLC					;$02B30C	|
	ADC $1A					;$02B30D	|
	STA $E4,X				;$02B30F	|
	LDA $1B					;$02B311	|
	ADC.w DATA_02B2D2,Y			;$02B313	|
	STA.w $14E0,X				;$02B316	|
	LDA.w DATA_02B2D4,Y			;$02B319	|
	STA $B6,X				;$02B31C	|
Return02B31E:
	RTS

DATA_02B31F:
	db $3F,$40,$3F,$3F,$40,$40

DATA_02B325:
	db $FA,$FB,$FC,$FD

GenParaEnemy:
	LDA $14
	AND.b #$7F				;$02B32B	|
	BNE Return02B386			;$02B32D	|
	JSL FindFreeSlotLowPri			;$02B32F	|
	BMI Return02B386			;$02B333	|
	TYX					;$02B335	|
	LDA.b #$08				;$02B336	|
	STA.w $14C8,X				;$02B338	|
	JSL GetRand				;$02B33B	|
	LSR					;$02B33F	|
	LDY.w $18B9				;$02B340	|
	BCC CODE_02B348				;$02B343	|
	INY					;$02B345	|
	INY					;$02B346	|
	INY					;$02B347	|
CODE_02B348:
	LDA.w $B31D,Y
	STA $9E,X				;$02B34B	|
	JSL InitSpriteTables			;$02B34D	|
	LDA $1C					;$02B351	|
	SEC					;$02B353	|
	SBC.b #$20				;$02B354	|
	STA $D8,X				;$02B356	|
	LDA $1D					;$02B358	|
	SBC.b #$00				;$02B35A	|
	STA.w $14D4,X				;$02B35C	|
	LDA.w $148D				;$02B35F	|
	AND.b #$FF				;$02B362	|
	CLC					;$02B364	|
	ADC.b #$30				;$02B365	|
	PHP					;$02B367	|
	ADC $1A					;$02B368	|
	STA $E4,X				;$02B36A	|
	PHP					;$02B36C	|
	AND.b #$0E				;$02B36D	|
	STA.w $1570,X				;$02B36F	|
	LSR					;$02B372	|
	AND.b #$03				;$02B373	|
	TAY					;$02B375	|
	LDA.w DATA_02B325,Y			;$02B376	|
	STA $B6,X				;$02B379	|
	LDA $1B					;$02B37B	|
	PLP					;$02B37D	|
	ADC.b #$00				;$02B37E	|
	PLP					;$02B380	|
	ADC.b #$00				;$02B381	|
	STA.w $14E0,X				;$02B383	|
Return02B386:
	RTS

CODE_02B387:
	LDA $9D
	BNE Return02B3AA			;$02B389	|
	LDX.b #$07				;$02B38B	|
CODE_02B38D:
	STX.w $15E9
	LDA.w $1783,X				;$02B390	|
	BEQ CODE_02B3A7				;$02B393	|
	LDY.w $17AB,X				;$02B395	|
	BEQ CODE_02B3A4				;$02B398	|
	PHA					;$02B39A	|
	LDA $13					;$02B39B	|
	LSR					;$02B39D	|
	BCC CODE_02B3A3				;$02B39E	|
	DEC.w $17AB,X				;$02B3A0	|
CODE_02B3A3:
	PLA
CODE_02B3A4:
	JSR CODE_02B3AB
CODE_02B3A7:
	DEX
	BPL CODE_02B38D				;$02B3A8	|
Return02B3AA:
	RTS

CODE_02B3AB:
	DEC A
	JSL execute_pointer			;$02B3AC	|

ShooterPtrs:
	dw ShootBullet
	dw LaunchTorpedo
	dw Return02B3AA

LaunchTorpedo:
	LDA.w $17AB,X
	BNE Return02B42C			;$02B3B9	|
	LDA.b #$50				;$02B3BB	|
	STA.w $17AB,X				;$02B3BD	|
	LDA.w $178B,X				;$02B3C0	|
	CMP $1C					;$02B3C3	|
	LDA.w $1793,X				;$02B3C5	|
	SBC $1D					;$02B3C8	|
	BNE Return02B3AA			;$02B3CA	|
	LDA.w $179B,X				;$02B3CC	|
	CMP $1A					;$02B3CF	|
	LDA.w $17A3,X				;$02B3D1	|
	SBC $1B					;$02B3D4	|
	BNE Return02B3AA			;$02B3D6	|
	LDA.w $179B,X				;$02B3D8	|
	SEC					;$02B3DB	|
	SBC $1A					;$02B3DC	|
	CLC					;$02B3DE	|
	ADC.b #$10				;$02B3DF	|
	CMP.b #$20				;$02B3E1	|
	BCC Return02B42C			;$02B3E3	|
	JSL FindFreeSlotLowPri			;$02B3E5	|
	BMI Return02B42C			;$02B3E9	|
	LDA.b #$08				;$02B3EB	|
	STA.w $14C8,Y				;$02B3ED	|
	LDA.b #$44				;$02B3F0	|
	STA.w $009E,y				;$02B3F2	|
	LDA.w $179B,X				;$02B3F5	|
	STA.w $00E4,y				;$02B3F8	|
	LDA.w $17A3,X				;$02B3FB	|
	STA.w $14E0,Y				;$02B3FE	|
	LDA.w $178B,X				;$02B401	|
	STA.w $00D8,y				;$02B404	|
	LDA.w $1793,X				;$02B407	|
	STA.w $14D4,Y				;$02B40A	|
	PHX					;$02B40D	|
	TYX					;$02B40E	|
	JSL InitSpriteTables			;$02B40F	|
	JSR SubHorzPosBnk2			;$02B413	|
	TYA					;$02B416	|
	STA.w $157C,X				;$02B417	|
	STA $00					;$02B41A	|
	LDA.b #$30				;$02B41C	|
	STA.w $1540,X				;$02B41E	|
	PLX					;$02B421	|
	LDY.b #$07				;$02B422	|
CODE_02B424:
	LDA.w $170B,Y
	BEQ CODE_02B42D				;$02B427	|
	DEY					;$02B429	|
	BPL CODE_02B424				;$02B42A	|
Return02B42C:
	RTS

CODE_02B42D:
	LDA.b #$08
	STA.w $170B,Y				;$02B42F	|
	LDA.w $179B,X				;$02B432	|
	CLC					;$02B435	|
	ADC.b #$08				;$02B436	|
	STA.w $171F,Y				;$02B438	|
	LDA.w $17A3,X				;$02B43B	|
	ADC.b #$00				;$02B43E	|
	STA.w $1733,Y				;$02B440	|
	LDA.w $178B,X				;$02B443	|
	SEC					;$02B446	|
	SBC.b #$09				;$02B447	|
	STA.w $1715,Y				;$02B449	|
	LDA.w $1793,X				;$02B44C	|
	SBC.b #$00				;$02B44F	|
	STA.w $1729,Y				;$02B451	|
	LDA.b #$90				;$02B454	|
	STA.w $176F,Y				;$02B456	|
	PHX					;$02B459	|
	LDX $00					;$02B45A	|
	LDA.w DATA_02B464,X			;$02B45C	|
	STA.w $1747,Y				;$02B45F	|
	PLX					;$02B462	|
	RTS					;$02B463	|

DATA_02B464:
	db $01,$FF

ShootBullet:
	LDA.w $17AB,X
	BNE Return02B4DD			;$02B469	|
	LDA.b #$60				;$02B46B	|
	STA.w $17AB,X				;$02B46D	|
	LDA.w $178B,X				;$02B470	|
	CMP $1C					;$02B473	|
	LDA.w $1793,X				;$02B475	|
	SBC $1D					;$02B478	|
	BNE Return02B4DD			;$02B47A	|
	LDA.w $179B,X				;$02B47C	|
	CMP $1A					;$02B47F	|
	LDA.w $17A3,X				;$02B481	|
	SBC $1B					;$02B484	|
	BNE Return02B4DD			;$02B486	|
	LDA.w $179B,X				;$02B488	|
	SEC					;$02B48B	|
	SBC $1A					;$02B48C	|
	CLC					;$02B48E	|
	ADC.b #$10				;$02B48F	|
	CMP.b #$10				;$02B491	|
	BCC Return02B4DD			;$02B493	|
	LDA $94					;$02B495	|
	SBC.w $179B,X				;$02B497	|
	CLC					;$02B49A	|
	ADC.b #$11				;$02B49B	|
	CMP.b #$22				;$02B49D	|
	BCC Return02B4DD			;$02B49F	|
	JSL FindFreeSlotLowPri			;$02B4A1	|
	BMI Return02B4DD			;$02B4A5	|
	LDA.b #$09				;CODE_02B4A7
	STA.w $1DFC				;$02B4A9	|
	LDA.b #$01				;$02B4AC	|
	STA.w $14C8,Y				;$02B4AE	|
	LDA.b #$1C				;$02B4B1	|
	STA.w $009E,y				;$02B4B3	|
	LDA.w $179B,X				;$02B4B6	|
	STA.w $00E4,y				;$02B4B9	|
	LDA.w $17A3,X				;$02B4BC	|
	STA.w $14E0,Y				;$02B4BF	|
	LDA.w $178B,X				;$02B4C2	|
	SEC					;$02B4C5	|
	SBC.b #$01				;$02B4C6	|
	STA.w $00D8,y				;$02B4C8	|
	LDA.w $1793,X				;$02B4CB	|
	SBC.b #$00				;$02B4CE	|
	STA.w $14D4,Y				;$02B4D0	|
	PHX					;$02B4D3	|
	TYX					;$02B4D4	|
	JSL InitSpriteTables			;$02B4D5	|
	PLX					;$02B4D9	|
	JSR ShowShooterSmoke			;$02B4DA	|
Return02B4DD:
	RTS

ShowShooterSmoke:
	LDY.b #$03
FindFreeSmokeSlot:
	LDA.w $17C0,Y
	BEQ SetShooterSmoke			;$02B4E3	|
	DEY					;$02B4E5	|
	BPL FindFreeSmokeSlot			;$02B4E6	|
	RTS					;$02B4E8	|

ShooterSmokeDispX:
	db $F4,$0C

SetShooterSmoke:
	LDA.b #$01
	STA.w $17C0,Y				;$02B4ED	|
	LDA.w $178B,X				;$02B4F0	|
	STA.w $17C4,Y				;$02B4F3	|
	LDA.b #$1B				;$02B4F6	|
	STA.w $17CC,Y				;$02B4F8	|
	LDA.w $179B,X				;$02B4FB	|
	PHA					;$02B4FE	|
	LDA $94					;$02B4FF	|
	CMP.w $179B,X				;$02B501	|
	LDA $95					;$02B504	|
	SBC.w $17A3,X				;$02B506	|
	LDX.b #$00				;$02B509	|
	BCC CODE_02B50E				;$02B50B	|
	INX					;$02B50D	|
CODE_02B50E:
	PLA
	CLC					;$02B50F	|
	ADC.w ShooterSmokeDispX,X		;$02B510	|
	STA.w $17C8,Y				;$02B513	|
	LDX.w $15E9				;$02B516	|
	RTS					;$02B519	|

CODE_02B51A:
	TXA
	CLC					;$02B51B	|
	ADC.b #$04				;$02B51C	|
	TAX					;$02B51E	|
	JSR CODE_02B526				;$02B51F	|
	LDX.w $1698				;$02B522	|
	RTS					;$02B525	|

CODE_02B526:
	LDA.w $16B1,X
	ASL					;$02B529	|
	ASL					;$02B52A	|
	ASL					;$02B52B	|
	ASL					;$02B52C	|
	CLC					;$02B52D	|
	ADC.w $16B9,X				;$02B52E	|
	STA.w $16B9,X				;$02B531	|
	PHP					;$02B534	|
	LDA.w $16B1,X				;$02B535	|
	LSR					;$02B538	|
	LSR					;$02B539	|
	LSR					;$02B53A	|
	LSR					;$02B53B	|
	CMP.b #$08				;$02B53C	|
	LDY.b #$00				;$02B53E	|
	BCC CODE_02B545				;$02B540	|
	ORA.b #$F0				;$02B542	|
	DEY					;$02B544	|
CODE_02B545:
	PLP
	ADC.w $16A1,X				;$02B546	|
	STA.w $16A1,X				;$02B549	|
	TYA					;$02B54C	|
	ADC.w $16A9,X				;$02B54D	|
	STA.w $16A9,X				;$02B550	|
	RTS					;$02B553	|

CODE_02B554:
	TXA
	CLC					;$02B555	|
	ADC.b #$0A				;$02B556	|
	TAX					;$02B558	|
	JSR CODE_02B560				;$02B559	|
	LDX.w $15E9				;$02B55C	|
	RTS					;$02B55F	|

CODE_02B560:
	LDA.w $173D,X
	ASL					;$02B563	|
	ASL					;$02B564	|
	ASL					;$02B565	|
	ASL					;$02B566	|
	CLC					;$02B567	|
	ADC.w $1751,X				;$02B568	|
	STA.w $1751,X				;$02B56B	|
	PHP					;$02B56E	|
	LDY.b #$00				;$02B56F	|
	LDA.w $173D,X				;$02B571	|
	LSR					;$02B574	|
	LSR					;$02B575	|
	LSR					;$02B576	|
	LSR					;$02B577	|
	CMP.b #$08				;$02B578	|
	BCC CODE_02B57F				;$02B57A	|
	ORA.b #$F0				;$02B57C	|
	DEY					;$02B57E	|
CODE_02B57F:
	PLP
	ADC.w $1715,X				;$02B580	|
	STA.w $1715,X				;$02B583	|
	TYA					;$02B586	|
	ADC.w $1729,X				;$02B587	|
	STA.w $1729,X				;$02B58A	|
	RTS					;$02B58D	|

CODE_02B58E:
	LDA.w $17D8,X
	ASL					;$02B591	|
	ASL					;$02B592	|
	ASL					;$02B593	|
	ASL					;$02B594	|
	CLC					;$02B595	|
	ADC.w $17DC,X				;$02B596	|
	STA.w $17DC,X				;$02B599	|
	PHP					;$02B59C	|
	LDY.b #$00				;$02B59D	|
	LDA.w $17D8,X				;$02B59F	|
	LSR					;$02B5A2	|
	LSR					;$02B5A3	|
	LSR					;$02B5A4	|
	LSR					;$02B5A5	|
	CMP.b #$08				;$02B5A6	|
	BCC CODE_02B5AD				;$02B5A8	|
	ORA.b #$F0				;$02B5AA	|
	DEY					;$02B5AC	|
CODE_02B5AD:
	PLP
	ADC.w $17D4,X				;$02B5AE	|
	STA.w $17D4,X				;$02B5B1	|
	TYA					;$02B5B4	|
	ADC.w $17E8,X				;$02B5B5	|
	STA.w $17E8,X				;$02B5B8	|
	RTS					;$02B5BB	|

CODE_02B5BC:
	TXA
	CLC					;$02B5BD	|
	ADC.b #$0C				;$02B5BE	|
	TAX					;$02B5C0	|
	JSR CODE_02B5C8				;$02B5C1	|
	LDX.w $1698				;$02B5C4	|
	RTS					;$02B5C7	|

CODE_02B5C8:
	LDA.w $1820,X
	ASL					;$02B5CB	|
	ASL					;$02B5CC	|
	ASL					;$02B5CD	|
	ASL					;$02B5CE	|
	CLC					;$02B5CF	|
	ADC.w $1838,X				;$02B5D0	|
	STA.w $1838,X				;$02B5D3	|
	PHP					;$02B5D6	|
	LDA.w $1820,X				;$02B5D7	|
	LSR					;$02B5DA	|
	LSR					;$02B5DB	|
	LSR					;$02B5DC	|
	LSR					;$02B5DD	|
	CMP.b #$08				;$02B5DE	|
	BCC CODE_02B5E4				;$02B5E0	|
	ORA.b #$F0				;$02B5E2	|
CODE_02B5E4:
	PLP
	ADC.w $17FC,X				;$02B5E5	|
	STA.w $17FC,X				;$02B5E8	|
	RTS					;$02B5EB	|

Empty02B5EC:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF

PokeyClipIndex:
	db $1B,$1B,$1A,$19,$18,$17

PokeyMain:
	PHB
	PHK					;$02B637	|
	PLB					;$02B638	|
	JSR PokeyMainRt				;$02B639	|
	LDA $C2,X				;$02B63C	|
	PHX					;$02B63E	|
	LDX.b #$04				;$02B63F	|
	LDY.b #$00				;$02B641	|
PokeyLoopStart:
	LSR
	BCC BitNotSet				;$02B644	|
	INY					;$02B646	|
BitNotSet:
	DEX
	BPL PokeyLoopStart			;$02B648	|
	PLX					;$02B64A	|
	LDA.w PokeyClipIndex,Y			;$02B64B	|
	STA.w $1662,X				;$02B64E	|
	PLB					;$02B651	|
	RTL					;$02B652	|

DATA_02B653:
	db $01,$02,$04,$08

DATA_02B657:
	db $00,$01,$03,$07

DATA_02B65B:
	db $FF,$FE,$FC,$F8

PokeyTileDispX:
	db $00,$01,$00,$FF

PokeySpeed:
	db $02,$FE

DATA_02B665:
	db $00,$05,$09,$0C,$0E,$0F,$10,$10
	db $10,$10,$10,$10,$10

PokeyMainRt:
	LDA.w $1534,X
	BNE CODE_02B681				;$02B675	|
	LDA.w $14C8,X				;$02B677	|
	CMP.b #$08				;$02B67A	|
	BEQ CODE_02B6A7				;$02B67C	|
	JMP CODE_02B726				;$02B67E	|

CODE_02B681:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$02B685	|
	LDA $C2,X				;$02B688	|
	CMP.b #$01				;$02B68A	|
	LDA.b #$8A				;$02B68C	|
	BCC CODE_02B692				;$02B68E	|
	LDA.b #$E8				;$02B690	|
CODE_02B692:
	STA.w $0302,Y
	LDA.w $14C8,X				;$02B695	|
	CMP.b #$08				;$02B698	|
	BNE Return02B6A6			;$02B69A	|
	JSR UpdateYPosNoGrvtyB1			;$02B69C	|
	INC $AA,X				;$02B69F	|
	INC $AA,X				;$02B6A1	|
	JSR SubOffscreen0Bnk2			;$02B6A3	|
Return02B6A6:
	RTS

CODE_02B6A7:
	LDA $C2,X
	BNE PokeyAlive				;$02B6A9	|
CODE_02B6AB:
	STZ.w $14C8,X
	RTS					;$02B6AE	|

PokeyAlive:
	CMP.b #$20
	BCS CODE_02B6AB				;$02B6B1	|
	LDA $9D					;$02B6B3	|
	BNE CODE_02B726				;$02B6B5	|
	JSR SubOffscreen0Bnk2			;$02B6B7	|
	JSL MarioSprInteract			;$02B6BA	|
	INC.w $1570,X				;$02B6BE	|
	LDA.w $1570,X				;$02B6C1	|
	AND.b #$7F				;$02B6C4	|
	BNE CODE_02B6CF				;$02B6C6	|
	JSR CODE_02D4FA				;$02B6C8	|
	TYA					;$02B6CB	|
	STA.w $157C,X				;$02B6CC	|
CODE_02B6CF:
	LDY.w $157C,X
	LDA.w PokeySpeed,Y			;$02B6D2	|
	STA $B6,X				;$02B6D5	|
	JSR UpdateXPosNoGrvtyB1			;$02B6D7	|
	JSR UpdateYPosNoGrvtyB1			;$02B6DA	|
	LDA $AA,X				;$02B6DD	|
	CMP.b #$40				;$02B6DF	|
	BPL CODE_02B6E8				;$02B6E1	|
	CLC					;$02B6E3	|
	ADC.b #$02				;$02B6E4	|
	STA $AA,X				;$02B6E6	|
CODE_02B6E8:
	JSL CODE_019138
	LDA.w $1588,X				;$02B6EC	|
	AND.b #$04				;$02B6EF	|
	BEQ CODE_02B6F5				;$02B6F1	|
	STZ $AA,X				;$02B6F3	|
CODE_02B6F5:
	LDA.w $1588,X
	AND.b #$03				;$02B6F8	|
	BEQ CODE_02B704				;$02B6FA	|
	LDA.w $157C,X				;$02B6FC	|
	EOR.b #$01				;$02B6FF	|
	STA.w $157C,X				;$02B701	|
CODE_02B704:
	JSR CODE_02B7AC
	LDY.b #$00				;$02B707	|
CODE_02B709:
	LDA $C2,X
	AND.w DATA_02B653,Y			;$02B70B	|
	BNE CODE_02B721				;$02B70E	|
	LDA $C2,X				;$02B710	|
	PHA					;$02B712	|
	AND.w DATA_02B657,Y			;$02B713	|
	STA $00					;$02B716	|
	PLA					;$02B718	|
	LSR					;$02B719	|
	AND.w DATA_02B65B,Y			;$02B71A	|
	ORA $00					;$02B71D	|
	STA $C2,X				;$02B71F	|
CODE_02B721:
	INY
	CPY.b #$04				;$02B722	|
	BNE CODE_02B709				;$02B724	|
CODE_02B726:
	JSR GetDrawInfo2
	LDA $01					;$02B729	|
	CLC					;$02B72B	|
	ADC.b #$40				;$02B72C	|
	STA $01					;$02B72E	|
	LDA $C2,X				;$02B730	|
	STA $02					;$02B732	|
	STA $07					;$02B734	|
	LDA.w $151C,X				;$02B736	|
	STA $04					;$02B739	|
	LDY.w $1540,X				;$02B73B	|
	LDA.w DATA_02B665,Y			;$02B73E	|
	STA $03					;$02B741	|
	STZ $05					;$02B743	|
	LDY.w $15EA,X				;$02B745	|
	PHX					;$02B748	|
	LDX.b #$04				;$02B749	|
CODE_02B74B:
	STX $06
	LDA $14					;$02B74D	|
	LSR					;$02B74F	|
	LSR					;$02B750	|
	LSR					;$02B751	|
	CLC					;$02B752	|
	ADC $06					;$02B753	|
	AND.b #$03				;$02B755	|
	TAX					;$02B757	|
	LDA $07					;$02B758	|
	CMP.b #$01				;$02B75A	|
	BNE CODE_02B760				;$02B75C	|
	LDX.b #$00				;$02B75E	|
CODE_02B760:
	LDA $00
	CLC					;$02B762	|
	ADC.w PokeyTileDispX,X			;$02B763	|
	STA.w $0300,Y				;$02B766	|
	LDX $06					;$02B769	|
	LDA $01					;$02B76B	|
	LSR $02					;$02B76D	|
	BCC CODE_02B781				;$02B76F	|
	LSR $04					;$02B771	|
	BCS CODE_02B77B				;$02B773	|
	PHA					;$02B775	|
	LDA $03					;$02B776	|
	STA $05					;$02B778	|
	PLA					;$02B77A	|
CODE_02B77B:
	SEC
	SBC $05					;$02B77C	|
	STA.w $0301,Y				;$02B77E	|
CODE_02B781:
	LDA $01
	SEC					;$02B783	|
	SBC.b #$10				;$02B784	|
	STA $01					;$02B786	|
	LDA $02					;$02B788	|
	LSR					;$02B78A	|
	LDA.b #$E8				;$02B78B	|
	BCS CODE_02B791				;$02B78D	|
	LDA.b #$8A				;$02B78F	|
CODE_02B791:
	STA.w $0302,Y
	LDA.b #$05				;$02B794	|
	ORA $64					;$02B796	|
	STA.w $0303,Y				;$02B798	|
	INY					;$02B79B	|
	INY					;$02B79C	|
	INY					;$02B79D	|
	INY					;$02B79E	|
	DEX					;$02B79F	|
	BPL CODE_02B74B				;$02B7A0	|
	PLX					;$02B7A2	|
	LDA.b #$04				;$02B7A3	|
	LDY.b #$02				;$02B7A5	|
CODE_02B7A7:
	JSL FinishOAMWrite
	RTS					;$02B7AB	|

CODE_02B7AC:
	LDY.b #$09
CODE_02B7AE:
	TYA
	EOR $13					;$02B7AF	|
	LSR					;$02B7B1	|
	BCS CODE_02B7D2				;$02B7B2	|
	LDA.w $14C8,Y				;$02B7B4	|
	CMP.b #$0A				;$02B7B7	|
	BNE CODE_02B7D2				;$02B7B9	|
	PHB					;$02B7BB	|
	LDA.b #$03				;$02B7BC	|
	PHA					;$02B7BE	|
	PLB					;$02B7BF	|
	PHX					;$02B7C0	|
	TYX					;$02B7C1	|
	JSL GetSpriteClippingB			;$02B7C2	|
	PLX					;$02B7C6	|
	JSL GetSpriteClippingA			;$02B7C7	|
	JSL CheckForContact			;$02B7CB	|
	PLB					;$02B7CF	|
	BCS CODE_02B7D6				;$02B7D0	|
CODE_02B7D2:
	DEY
	BPL CODE_02B7AE				;$02B7D3	|
Return02B7D5:
	RTS

CODE_02B7D6:
	LDA.w $1558,X
	BNE Return02B7D5			;$02B7D9	|
	LDA.w $00D8,y				;$02B7DB	|
	SEC					;$02B7DE	|
	SBC $D8,X				;$02B7DF	|
	PHY					;$02B7E1	|
	STY.w $1695				;$02B7E2	|
	JSR RemovePokeySgmntRt			;$02B7E5	|
	PLY					;$02B7E8	|
	JSR CODE_02B82E				;$02B7E9	|
	RTS					;$02B7EC	|

RemovePokeySgmntRt:
	LDY.b #$00
	CMP.b #$09				;$02B7EF	|
	BMI CODE_02B803				;$02B7F1	|
	INY					;$02B7F3	|
	CMP.b #$19				;$02B7F4	|
	BMI CODE_02B803				;$02B7F6	|
	INY					;$02B7F8	|
	CMP.b #$29				;$02B7F9	|
	BMI CODE_02B803				;$02B7FB	|
	INY					;$02B7FD	|
	CMP.b #$39				;$02B7FE	|
	BMI CODE_02B803				;$02B800	|
	INY					;$02B802	|
CODE_02B803:
	LDA $C2,X
	AND.w PokeyUnsetBit,Y			;$02B805	|
	STA $C2,X				;$02B808	|
	STA.w $151C,X				;$02B80A	|
	LDA.w DATA_02B829,Y			;$02B80D	|
	STA $0D					;$02B810	|
	LDA.b #$0C				;$02B812	|
	STA.w $1540,X				;$02B814	|
	ASL					;$02B817	|
	STA.w $1558,X				;$02B818	|
	RTS					;$02B81B	|

RemovePokeySegment:
	PHB
	PHK					;$02B81D	|
	PLB					;$02B81E	|
	JSR RemovePokeySgmntRt			;$02B81F	|
	PLB					;$02B822	|
	RTL					;$02B823	|

PokeyUnsetBit:
	db $EF,$F7,$FB,$FD,$FE

DATA_02B829:
	db $E0,$F0,$F8,$FC,$FE

CODE_02B82E:
	JSL FindFreeSprSlot
	BMI Return02B881			;$02B832	|
	LDA.b #$02				;$02B834	|
	STA.w $14C8,Y				;$02B836	|
	LDA.b #$70				;$02B839	|
	STA.w $009E,y				;$02B83B	|
	LDA $E4,X				;$02B83E	|
	STA.w $00E4,y				;$02B840	|
	LDA.w $14E0,X				;$02B843	|
	STA.w $14E0,Y				;$02B846	|
	PHX					;$02B849	|
	TYX					;$02B84A	|
	JSL InitSpriteTables			;$02B84B	|
	LDX.w $1695				;$02B84F	|
	LDA $D8,X				;$02B852	|
	STA.w $00D8,y				;$02B854	|
	LDA.w $14D4,X				;$02B857	|
	STA.w $14D4,Y				;$02B85A	|
	LDA $B6,X				;$02B85D	|
	STA $00					;$02B85F	|
	ASL					;$02B861	|
	ROR $00					;$02B862	|
	LDA $00					;$02B864	|
	STA.w $00B6,y				;$02B866	|
	LDA.b #$E0				;$02B869	|
	STA.w $00AA,y				;$02B86B	|
	PLX					;$02B86E	|
	LDA $C2,X				;$02B86F	|
	AND $0D					;$02B871	|
	STA.w $00C2,y				;$02B873	|
	LDA.b #$01				;$02B876	|
	STA.w $1534,Y				;$02B878	|
	LDA.b #$01				;$02B87B	|
	JSL CODE_02ACE1				;$02B87D	|
Return02B881:
	RTS

TorpedoTedMain:
	PHB
	PHK					;$02B883	|
	PLB					;$02B884	|
	JSR CODE_02B88A				;$02B885	|
	PLB					;$02B888	|
	RTL					;$02B889	|

CODE_02B88A:
	LDA $64
	PHA					;$02B88C	|
	LDA.w $1540,X				;$02B88D	|
	BEQ CODE_02B896				;$02B890	|
	LDA.b #$10				;$02B892	|
	STA $64					;$02B894	|
CODE_02B896:
	JSR TorpedoGfxRt
	PLA					;$02B899	|
	STA $64					;$02B89A	|
	LDA $9D					;$02B89C	|
	BNE Return02B8B7			;$02B89E	|
	JSR SubOffscreen0Bnk2			;$02B8A0	|
	JSL SprSprPMarioSprRts			;$02B8A3	|
	LDA.w $1540,X				;$02B8A7	|
	BEQ CODE_02B8BC				;$02B8AA	|
	LDA.b #$08				;$02B8AC	|
	STA $AA,X				;$02B8AE	|
	JSR UpdateYPosNoGrvtyB1			;$02B8B0	|
	LDA.b #$10				;$02B8B3	|
	STA $AA,X				;$02B8B5	|
Return02B8B7:
	RTS

TorpedoMaxSpeed:
	db $20,$F0

TorpedoAccel:
	db $01,$FF

CODE_02B8BC:
	LDA $13
	AND.b #$03				;$02B8BE	|
	BNE CODE_02B8D2				;$02B8C0	|
	LDY.w $157C,X				;$02B8C2	|
	LDA $B6,X				;$02B8C5	|
	CMP.w TorpedoMaxSpeed,Y			;$02B8C7	|
	BEQ CODE_02B8D2				;$02B8CA	|
	CLC					;$02B8CC	|
	ADC.w TorpedoAccel,Y			;$02B8CD	|
	STA $B6,X				;$02B8D0	|
CODE_02B8D2:
	JSR UpdateXPosNoGrvtyB1
	JSR UpdateYPosNoGrvtyB1			;$02B8D5	|
	LDA $AA,X				;$02B8D8	|
	BEQ CODE_02B8E4				;$02B8DA	|
	LDA $13					;$02B8DC	|
	AND.b #$01				;$02B8DE	|
	BNE CODE_02B8E4				;$02B8E0	|
	DEC $AA,X				;$02B8E2	|
CODE_02B8E4:
	TXA
	CLC					;$02B8E5	|
	ADC $14					;$02B8E6	|
	AND.b #$07				;$02B8E8	|
	BNE Return02B8EF			;$02B8EA	|
	JSR CODE_02B952				;$02B8EC	|
Return02B8EF:
	RTS

DATA_02B8F0:
	db $10

DATA_02B8F1:
	db $00,$10,$80,$82

DATA_02B8F5:
	db $40,$00

TorpedoGfxRt:
	JSR GetDrawInfo2
	LDA $01					;$02B8FA	|
	STA.w $0301,Y				;$02B8FC	|
	STA.w $0305,Y				;$02B8FF	|
	PHX					;$02B902	|
	LDA.w $15F6,X				;$02B903	|
	ORA $64					;$02B906	|
	STA $02					;$02B908	|
	LDA.w $157C,X				;$02B90A	|
	TAX					;$02B90D	|
	LDA $00					;$02B90E	|
	CLC					;$02B910	|
	ADC.w DATA_02B8F0,X			;$02B911	|
	STA.w $0300,Y				;$02B914	|
	LDA $00					;$02B917	|
	CLC					;$02B919	|
	ADC.w DATA_02B8F1,X			;$02B91A	|
	STA.w $0304,Y				;$02B91D	|
	LDA.w DATA_02B8F5,X			;$02B920	|
	ORA $02					;$02B923	|
	STA.w $0303,Y				;$02B925	|
	STA.w $0307,Y				;$02B928	|
	PLX					;$02B92B	|
	LDA.b #$80				;$02B92C	|
	STA.w $0302,Y				;$02B92E	|
	LDA.w $1540,X				;$02B931	|
	CMP.b #$01				;$02B934	|
	LDA.b #$82				;$02B936	|
	BCS CODE_02B944				;$02B938	|
	LDA $14					;$02B93A	|
	LSR					;$02B93C	|
	LSR					;$02B93D	|
	LDA.b #$A0				;$02B93E	|
	BCC CODE_02B944				;$02B940	|
	LDA.b #$82				;$02B942	|
CODE_02B944:
	STA.w $0306,Y
	LDA.b #$01				;$02B947	|
	LDY.b #$02				;$02B949	|
	JMP CODE_02B7A7				;$02B94B	|

DATA_02B94E:
	db $F4,$1C

DATA_02B950:
	db $FF,$00

CODE_02B952:
	LDY.b #$03
CODE_02B954:
	LDA.w $17C0,Y
	BEQ CODE_02B969				;$02B957	|
	DEY					;$02B959	|
	BPL CODE_02B954				;$02B95A	|
	DEC.w $18E9				;$02B95C	|
	BPL CODE_02B966				;$02B95F	|
	LDA.b #$03				;$02B961	|
	STA.w $18E9				;$02B963	|
CODE_02B966:
	LDY.w $18E9
CODE_02B969:
	LDA $E4,X
	STA $00					;$02B96B	|
	LDA.w $14E0,X				;$02B96D	|
	STA $01					;$02B970	|
	PHX					;$02B972	|
	LDA.w $157C,X				;$02B973	|
	TAX					;$02B976	|
	LDA $00					;$02B977	|
	CLC					;$02B979	|
	ADC.w DATA_02B94E,X			;$02B97A	|
	STA $02					;$02B97D	|
	LDA $01					;$02B97F	|
	ADC.w DATA_02B950,X			;$02B981	|
	PHA					;$02B984	|
	LDA $02					;$02B985	|
	CMP $1A					;$02B987	|
	PLA					;$02B989	|
	PLX					;$02B98A	|
	SBC $1B					;$02B98B	|
	BNE Return02B9A3			;$02B98D	|
	LDA.b #$01				;$02B98F	|
	STA.w $17C0,Y				;$02B991	|
	LDA $02					;$02B994	|
	STA.w $17C8,Y				;$02B996	|
	LDA $D8,X				;$02B999	|
	STA.w $17C4,Y				;$02B99B	|
	LDA.b #$0F				;$02B99E	|
	STA.w $17CC,Y				;$02B9A0	|
Return02B9A3:
	RTS

GenTileFromSpr0:
	STA $9C
	LDA $E4,X				;$02B9A6	|
	STA $9A					;$02B9A8	|
	LDA.w $14E0,X				;$02B9AA	|
	STA $9B					;$02B9AD	|
	LDA $D8,X				;$02B9AF	|
	STA $98					;$02B9B1	|
	LDA.w $14D4,X				;$02B9B3	|
	STA $99					;$02B9B6	|
	JSL generate_tile			;$02B9B8	|
	RTL					;$02B9BC	|

CODE_02B9BD:
	LDA.b #$02
	STA.w $18DD				;$02B9BF	|
	LDY.b #$09				;$02B9C2	|
CODE_02B9C4:
	LDA.w $14C8,Y
	CMP.b #$08				;$02B9C7	|
	BCC CODE_02B9D5				;$02B9C9	|
	LDA.w $190F,Y				;$02B9CB	|
	AND.b #$40				;$02B9CE	|
	BNE CODE_02B9D5				;$02B9D0	|
	JSR CODE_02B9D9				;$02B9D2	|
CODE_02B9D5:
	DEY
	BPL CODE_02B9C4				;$02B9D6	|
	RTL					;$02B9D8	|

CODE_02B9D9:
	LDA.b #$21
	STA.w $009E,y				;$02B9DB	|
	LDA.b #$08				;$02B9DE	|
	STA.w $14C8,Y				;$02B9E0	|
	PHX					;$02B9E3	|
	TYX					;$02B9E4	|
	JSL InitSpriteTables			;$02B9E5	|
	LDA.w $15F6,X				;$02B9E9	|
	AND.b #$F1				;$02B9EC	|
	ORA.b #$02				;$02B9EE	|
	STA.w $15F6,X				;$02B9F0	|
	LDA.b #$D8				;$02B9F3	|
	STA.w $AA,X				;$02B9F5	|
	PLX					;$02B9F8	|
	RTS					;$02B9F9	|

CODE_02B9FA:
	STZ $0F
	BRA CODE_02BA48				;$02B9FC	|

	LDA $01					;$02B9FE	|
	AND.b #$F0				;$02BA00	|
	STA $04					;$02BA02	|
	LDA $09					;$02BA04	|
	CMP $5D					;$02BA06	|
	BCS Return02BA47			;$02BA08	|
	STA $05					;$02BA0A	|
	LDA $00					;$02BA0C	|
	STA $07					;$02BA0E	|
	LDA $08					;$02BA10	|
	CMP.b #$02				;$02BA12	|
	BCS Return02BA47			;$02BA14	|
	STA $0A					;$02BA16	|
	LDA $07					;$02BA18	|
	LSR					;$02BA1A	|
	LSR					;$02BA1B	|
	LSR					;$02BA1C	|
	LSR					;$02BA1D	|
	ORA $04					;$02BA1E	|
	STA $04					;$02BA20	|
	LDX $05					;$02BA22	|
	LDA.l DATA_00BA80,X			;$02BA24	|
	LDY $0F					;$02BA28	|
	BEQ ADDR_02BA30				;$02BA2A	|
	LDA.l DATA_00BA8E,X			;$02BA2C	|
ADDR_02BA30:
	CLC
	ADC $04					;$02BA31	|
	STA $05					;$02BA33	|
	LDA.l DATA_00BABC,X			;$02BA35	|
	LDY $0F					;$02BA39	|
	BEQ ADDR_02BA41				;$02BA3B	|
	LDA.l DATA_00BACA,X			;$02BA3D	|
ADDR_02BA41:
	ADC $0A
	STA $06					;$02BA43	|
	BRA CODE_02BA92				;$02BA45	|

Return02BA47:
	RTL

CODE_02BA48:
	LDA $01
	AND.b #$F0				;$02BA4A	|
	STA $04					;$02BA4C	|
	LDA $09					;$02BA4E	|
	CMP.b #$02				;$02BA50	|
	BCS Return02BA47			;$02BA52	|
	STA $0D					;$02BA54	|
	STA.w $18B3				;$02BA56	|
	LDA $00					;$02BA59	|
	STA $06					;$02BA5B	|
	LDA $08					;$02BA5D	|
	CMP $5D					;$02BA5F	|
	BCS Return02BA47			;$02BA61	|
	STA $07					;$02BA63	|
	LDA $06					;$02BA65	|
	LSR					;$02BA67	|
	LSR					;$02BA68	|
	LSR					;$02BA69	|
	LSR					;$02BA6A	|
	ORA $04					;$02BA6B	|
	STA $04					;$02BA6D	|
	LDX $07					;$02BA6F	|
	LDA.l DATA_00BA60,X			;$02BA71	|
	LDY $0F					;$02BA75	|
	BEQ CODE_02BA7D				;$02BA77	|
	LDA.l DATA_00BA70,X			;$02BA79	|
CODE_02BA7D:
	CLC
	ADC $04					;$02BA7E	|
	STA $05					;$02BA80	|
	LDA.l DATA_00BA9C,X			;$02BA82	|
	LDY $0F					;$02BA86	|
	BEQ CODE_02BA8E				;$02BA88	|
	LDA.l DATA_00BAAC,X			;$02BA8A	|
CODE_02BA8E:
	ADC $0D
	STA $06					;$02BA90	|
CODE_02BA92:
	LDX.w $15E9
	LDA.b #$7E				;$02BA95	|
	STA $07					;$02BA97	|
	LDA [$05]				;$02BA99	|
	STA.w $1693				;$02BA9B	|
	INC $07					;$02BA9E	|
	LDA [$05]				;$02BAA0	|
	BNE Return02BABF			;$02BAA2	|
	LDA.w $1693				;$02BAA4	|
	CMP.b #$45				;$02BAA7	|
	BCC Return02BABF			;$02BAA9	|
	CMP.b #$48				;$02BAAB	|
	BCS Return02BABF			;$02BAAD	|
	SEC					;$02BAAF	|
	SBC.b #$44				;$02BAB0	|
	STA.w $18D6				;$02BAB2	|
	LDY.b #$0B				;$02BAB5	|
CODE_02BAB7:
	LDA.w $14C8,Y
	BEQ CODE_02BAC0				;$02BABA	|
	DEY					;$02BABC	|
	BPL CODE_02BAB7				;$02BABD	|
Return02BABF:
	RTL

CODE_02BAC0:
	LDA.b #$08
	STA.w $14C8,Y				;$02BAC2	|
	LDA.b #$74				;$02BAC5	|
	STA.w $009E,y				;$02BAC7	|
	LDA $00					;$02BACA	|
	STA.w $00E4,y				;$02BACC	|
	STA $9A					;$02BACF	|
	LDA $08					;$02BAD1	|
	STA.w $14E0,Y				;$02BAD3	|
	STA $9B					;$02BAD6	|
	LDA $01					;$02BAD8	|
	STA.w $00D8,y				;$02BADA	|
	STA $98					;$02BADD	|
	LDA $09					;$02BADF	|
	STA.w $14D4,Y				;$02BAE1	|
	STA $99					;$02BAE4	|
	PHX					;$02BAE6	|
	TYX					;$02BAE7	|
	JSL InitSpriteTables			;$02BAE8	|
	INC.w $160E,X				;$02BAEC	|
	LDA.w $1662,X				;$02BAEF	|
	AND.b #$F0				;$02BAF2	|
	ORA.b #$0C				;$02BAF4	|
	STA.w $1662,X				;$02BAF6	|
	LDA.w $167A,X				;$02BAF9	|
	AND.b #$BF				;$02BAFC	|
	STA.w $167A,X				;$02BAFE	|
	PLX					;$02BB01	|
	LDA.b #$04				;$02BB02	|
	STA $9C					;$02BB04	|
	JSL generate_tile			;$02BB06	|
	RTL					;$02BB0A	|

DATA_02BB0B:
	db $02,$FA,$06,$06

DATA_02BB0F:
	db $00,$FF,$00,$00

DATA_02BB13:
	db $10,$08,$10,$08

YoshiWingsTiles:
	db $5D,$C6,$5D,$C6

YoshiWingsGfxProp:
	db $46,$46,$06,$06

YoshiWingsSize:
	db $00,$02,$00,$02

CODE_02BB23:
	STA $02
	JSR IsSprOffScreenBnk2			;$02BB25	|
	BNE Return02BB87			;$02BB28	|
	LDA $E4,X				;$02BB2A	|
	STA $00					;$02BB2C	|
	LDA.w $14E0,X				;$02BB2E	|
	STA $04					;$02BB31	|
	LDA $D8,X				;$02BB33	|
	STA $01					;$02BB35	|
	LDY.b #$F8				;$02BB37	|
	PHX					;$02BB39	|
	LDA.w $157C,X				;$02BB3A	|
	ASL					;$02BB3D	|
	ADC $02					;$02BB3E	|
	TAX					;$02BB40	|
	LDA $00					;$02BB41	|
	CLC					;$02BB43	|
	ADC.l DATA_02BB0B,X			;$02BB44	|
	STA $00					;$02BB48	|
	LDA $04					;$02BB4A	|
	ADC.l DATA_02BB0F,X			;$02BB4C	|
	PHA					;$02BB50	|
	LDA $00					;$02BB51	|
	SEC					;$02BB53	|
	SBC $1A					;$02BB54	|
	STA.w $0200,Y				;$02BB56	|
	PLA					;$02BB59	|
	SBC $1B					;$02BB5A	|
	BNE CODE_02BB86				;$02BB5C	|
	LDA $01					;$02BB5E	|
	SEC					;$02BB60	|
	SBC $1C					;$02BB61	|
	CLC					;$02BB63	|
	ADC.l DATA_02BB13,X			;$02BB64	|
	STA.w $0201,Y				;$02BB68	|
	LDA.l YoshiWingsTiles,X			;$02BB6B	|
	STA.w $0202,Y				;$02BB6F	|
	LDA $64					;$02BB72	|
	ORA.l YoshiWingsGfxProp,X		;$02BB74	|
	STA.w $0203,Y				;$02BB78	|
	TYA					;$02BB7B	|
	LSR					;$02BB7C	|
	LSR					;$02BB7D	|
	TAY					;$02BB7E	|
	LDA.l YoshiWingsSize,X			;$02BB7F	|
	STA.w $0420,Y				;$02BB83	|
CODE_02BB86:
	PLX
Return02BB87:
	RTL

DATA_02BB88:
	db $FF,$01,$FF,$01,$00,$00

DATA_02BB8E:
	db $E8,$18,$F8,$08,$00,$00

DolphinMain:
	JSR CODE_02BC14
	LDA $9D					;$02BB97	|
	BNE Return02BBFF			;$02BB99	|
	JSR SubOffscreen1Bnk2			;$02BB9B	|
	JSR UpdateYPosNoGrvtyB1			;$02BB9E	|
	JSR UpdateXPosNoGrvtyB1			;$02BBA1	|
	STA.w $1528,X				;$02BBA4	|
	LDA $14					;$02BBA7	|
	AND.b #$00				;$02BBA9	|
	BNE CODE_02BBB7				;$02BBAB	|
	LDA $AA,X				;$02BBAD	|
	BMI CODE_02BBB5				;$02BBAF	|
	CMP.b #$3F				;$02BBB1	|
	BCS CODE_02BBB7				;$02BBB3	|
CODE_02BBB5:
	INC $AA,X
CODE_02BBB7:
	TXA
	EOR $13					;$02BBB8	|
	LSR					;$02BBBA	|
	BCC CODE_02BBC1				;$02BBBB	|
	JSL CODE_019138				;$02BBBD	|
CODE_02BBC1:
	LDA $AA,X
	BMI CODE_02BBFB				;$02BBC3	|
	LDA.w $164A,X				;$02BBC5	|
	BEQ CODE_02BBFB				;$02BBC8	|
	LDA $AA,X				;$02BBCA	|
	BEQ CODE_02BBD7				;$02BBCC	|
	SEC					;$02BBCE	|
	SBC.b #$08				;$02BBCF	|
	STA $AA,X				;$02BBD1	|
	BPL CODE_02BBD7				;$02BBD3	|
	STZ $AA,X				;$02BBD5	|
CODE_02BBD7:
	LDA.w $151C,X
	BNE CODE_02BBF7				;$02BBDA	|
	LDA $C2,X				;$02BBDC	|
	LSR					;$02BBDE	|
	PHP					;$02BBDF	|
	LDA $9E,X				;$02BBE0	|
	SEC					;$02BBE2	|
	SBC.b #$41				;$02BBE3	|
	PLP					;$02BBE5	|
	ROL					;$02BBE6	|
	TAY					;$02BBE7	|
	LDA $B6,X				;$02BBE8	|
	CLC					;$02BBEA	|
	ADC.w DATA_02BB88,Y			;$02BBEB	|
	STA $B6,X				;$02BBEE	|
	CMP.w DATA_02BB8E,Y			;$02BBF0	|
	BNE CODE_02BBFB				;$02BBF3	|
	INC $C2,X				;$02BBF5	|
CODE_02BBF7:
	LDA.b #$C0
	STA $AA,X				;$02BBF9	|
CODE_02BBFB:
	JSL InvisBlkMainRt
Return02BBFF:
	RTL

CODE_02BC00:
	LDA $14
	AND.b #$04				;$02BC02	|
	LSR					;$02BC04	|
	LSR					;$02BC05	|
	STA.w $157C,X				;$02BC06	|
	JSL GenericSprGfxRt1			;$02BC09	|
	RTS					;$02BC0D	|

DolphinTiles1:
	db $E2,$88

DolphinTiles2:
	db $E7,$A8

DolphinTiles3:
	db $E8,$A9

CODE_02BC14:
	LDA $9E,X
	CMP.b #$43				;$02BC16	|
	BNE CODE_02BC1D				;$02BC18	|
	JMP CODE_02BC00				;$02BC1A	|

CODE_02BC1D:
	JSR GetDrawInfo2
	LDA $B6,X				;$02BC20	|
	STA $02					;$02BC22	|
	LDA $00					;$02BC24	|
	ASL $02					;$02BC26	|
	PHP					;$02BC28	|
	BCC CODE_02BC3C				;$02BC29	|
	STA.w $0300,Y				;$02BC2B	|
	CLC					;$02BC2E	|
	ADC.b #$10				;$02BC2F	|
	STA.w $0304,Y				;$02BC31	|
	CLC					;$02BC34	|
	ADC.b #$08				;$02BC35	|
	STA.w $0308,Y				;$02BC37	|
	BRA CODE_02BC4E				;$02BC3A	|

CODE_02BC3C:
	CLC
	ADC.b #$18				;$02BC3D	|
	STA.w $0300,Y				;$02BC3F	|
	SEC					;$02BC42	|
	SBC.b #$10				;$02BC43	|
	STA.w $0304,Y				;$02BC45	|
	SEC					;$02BC48	|
	SBC.b #$08				;$02BC49	|
	STA.w $0308,Y				;$02BC4B	|
CODE_02BC4E:
	LDA $01
	STA.w $0301,Y				;$02BC50	|
	STA.w $0305,Y				;$02BC53	|
	STA.w $0309,Y				;$02BC56	|
	PHX					;$02BC59	|
	LDA $14					;$02BC5A	|
	AND.b #$08				;$02BC5C	|
	LSR					;$02BC5E	|
	LSR					;$02BC5F	|
	LSR					;$02BC60	|
	TAX					;$02BC61	|
	LDA.w DolphinTiles1,X			;$02BC62	|
	STA.w $0302,Y				;$02BC65	|
	LDA.w DolphinTiles2,X			;$02BC68	|
	STA.w $0306,Y				;$02BC6B	|
	LDA.w DolphinTiles3,X			;$02BC6E	|
	STA.w $030A,Y				;$02BC71	|
	PLX					;$02BC74	|
	LDA.w $15F6,X				;$02BC75	|
	ORA $64					;$02BC78	|
	PLP					;$02BC7A	|
	BCS CODE_02BC7F				;$02BC7B	|
	ORA.b #$40				;$02BC7D	|
CODE_02BC7F:
	STA.w $0303,Y
	STA.w $0307,Y				;$02BC82	|
	STA.w $030B,Y				;$02BC85	|
	LDA.b #$02				;$02BC88	|
	LDY.b #$02				;$02BC8A	|
	JMP CODE_02B7A7				;$02BC8C	|

DATA_02BC8F:
	db $08,$00,$F8,$00,$F8,$00,$08,$00
DATA_02BC97:
	db $00,$08,$00,$F8,$00,$08,$00,$F8
DATA_02BC9F:
	db $01,$FF,$FF,$01,$FF,$01,$01,$FF
DATA_02BCA7:
	db $01,$01,$FF,$FF,$01,$01,$FF,$FF
DATA_02BCAF:
	db $01,$04,$02,$08,$02,$04,$01,$08
DATA_02BCB7:
	db $00,$02,$00,$02,$00,$02,$00,$02
	db $05,$04,$05,$04,$05,$04,$05,$04
DATA_02BCC7:
	db $00,$C0,$C0,$00,$40,$80,$80,$40
	db $80,$C0,$40,$00,$C0,$80,$00,$40
DATA_02BCD7:
	db $00,$01,$02,$01

WallFollowersMain:
	JSL SprSprInteract
	JSL GetRand				;$02BCDF	|
	AND.b #$FF				;$02BCE3	|
	ORA $9D					;$02BCE5	|
	BNE CODE_02BCEE				;$02BCE7	|
	LDA.b #$0C				;$02BCE9	|
	STA.w $1558,X				;$02BCEB	|
CODE_02BCEE:
	LDA $9E,X
	CMP.b #$2E				;$02BCF0	|
	BNE CODE_02BD23				;$02BCF2	|
	LDY $C2,X				;$02BCF4	|
	LDA.w $1564,X				;$02BCF6	|
	BEQ CODE_02BD04				;$02BCF9	|
	TYA					;$02BCFB	|
	CLC					;$02BCFC	|
	ADC.b #$08				;$02BCFD	|
	TAY					;$02BCFF	|
	LDA.b #$00				;$02BD00	|
	BRA CODE_02BD0B				;$02BD02	|

CODE_02BD04:
	LDA $14
	LSR					;$02BD06	|
	LSR					;$02BD07	|
	LSR					;$02BD08	|
	AND.b #$01				;$02BD09	|
CODE_02BD0B:
	CLC
	ADC.w DATA_02BCB7,Y			;$02BD0C	|
	STA.w $1602,X				;$02BD0F	|
	LDA.w $15F6,X				;$02BD12	|
	AND.b #$3F				;$02BD15	|
	ORA.w DATA_02BCC7,Y			;$02BD17	|
	STA.w $15F6,X				;$02BD1A	|
	JSL GenericSprGfxRt2			;$02BD1D	|
	BRA CODE_02BD2F				;$02BD21	|

CODE_02BD23:
	CMP.b #$A5
	BCC CODE_02BD2C				;$02BD25	|
	JSR CODE_02BE4E				;$02BD27	|
	BRA CODE_02BD2F				;$02BD2A	|

CODE_02BD2C:
	JSR CODE_02BF5C
CODE_02BD2F:
	LDA.w $14C8,X
	CMP.b #$08				;$02BD32	|
	BEQ CODE_02BD3F				;$02BD34	|
	STZ.w $1528,X				;$02BD36	|
	LDA.b #$FF				;$02BD39	|
	STA.w $1558,X				;$02BD3B	|
	RTL					;$02BD3E	|

CODE_02BD3F:
	LDA $9D
	BNE Return02BD74			;$02BD41	|
	JSR SubOffscreen3Bnk2			;$02BD43	|
	JSL MarioSprInteract			;$02BD46	|
	LDA $9E,X				;$02BD4A	|
	CMP.b #$2E				;$02BD4C	|
	BEQ CODE_02BDA7				;$02BD4E	|
	CMP.b #$3C				;$02BD50	|
	BEQ CODE_02BDB3				;$02BD52	|
	CMP.b #$A5				;$02BD54	|
	BEQ CODE_02BDB3				;$02BD56	|
	CMP.b #$A6				;$02BD58	|
	BEQ CODE_02BDB3				;$02BD5A	|
	LDA $C2,X				;$02BD5C	|
	AND.b #$01				;$02BD5E	|
	JSL execute_pointer			;$02BD60	|

UrchinPtrs:
	dw CODE_02BD68
	dw CODE_02BD75

CODE_02BD68:
	LDA.w $1540,X
	BNE Return02BD74			;$02BD6B	|
	LDA.b #$80				;$02BD6D	|
	STA.w $1540,X				;$02BD6F	|
	INC $C2,X				;$02BD72	|
Return02BD74:
	RTL

CODE_02BD75:
	LDA $9E,X
	CMP.b #$3B				;$02BD77	|
	BEQ CODE_02BD80				;$02BD79	|
	LDA.w $1540,X				;$02BD7B	|
	BEQ CODE_02BD91				;$02BD7E	|
CODE_02BD80:
	JSR UpdateXPosNoGrvtyB1
	JSR UpdateYPosNoGrvtyB1			;$02BD83	|
	JSL CODE_019138				;$02BD86	|
	LDA.w $1588,X				;$02BD8A	|
	AND.b #$0F				;$02BD8D	|
	BEQ Return02BDA6			;$02BD8F	|
CODE_02BD91:
	LDA $B6,X
	EOR.b #$FF				;$02BD93	|
	INC A					;$02BD95	|
	STA $B6,X				;$02BD96	|
	LDA $AA,X				;$02BD98	|
	EOR.b #$FF				;$02BD9A	|
	INC A					;$02BD9C	|
	STA $AA,X				;$02BD9D	|
	LDA.b #$40				;$02BD9F	|
	STA.w $1540,X				;$02BDA1	|
	INC $C2,X				;$02BDA4	|
Return02BDA6:
	RTL

CODE_02BDA7:
	LDA $D8,X
	SEC					;$02BDA9	|
	SBC $1C					;$02BDAA	|
	CMP.b #$E0				;$02BDAC	|
	BCC CODE_02BDB3				;$02BDAE	|
	STZ.w $14C8,X				;$02BDB0	|
CODE_02BDB3:
	LDA.w $1540,X
	BNE CODE_02BDE7				;$02BDB6	|
	LDY $C2,X				;$02BDB8	|
	LDA.w DATA_02BCA7,Y			;$02BDBA	|
	STA $AA,X				;$02BDBD	|
	LDA.w DATA_02BC9F,Y			;$02BDBF	|
	STA $B6,X				;$02BDC2	|
	JSL CODE_019138				;$02BDC4	|
	LDA.w $1588,X				;$02BDC8	|
	AND.b #$0F				;$02BDCB	|
	BNE CODE_02BDE7				;$02BDCD	|
	LDA.b #$08				;$02BDCF	|
	STA.w $1564,X				;$02BDD1	|
	LDA.b #$38				;$02BDD4	|
	LDY $9E,X				;$02BDD6	|
	CPY.b #$3C				;$02BDD8	|
	BEQ CODE_02BDE4				;$02BDDA	|
	LDA.b #$1A				;$02BDDC	|
	CPY.b #$A5				;$02BDDE	|
	BNE CODE_02BDE4				;$02BDE0	|
	LSR					;$02BDE2	|
	NOP					;$02BDE3	|
CODE_02BDE4:
	STA.w $1540,X
CODE_02BDE7:
	LDA.b #$20
	LDY $9E,X				;$02BDE9	|
	CPY.b #$3C				;$02BDEB	|
	BEQ CODE_02BDF7				;$02BDED	|
	LDA.b #$10				;$02BDEF	|
	CPY.b #$A5				;$02BDF1	|
	BNE CODE_02BDF7				;$02BDF3	|
	LSR					;$02BDF5	|
	NOP					;$02BDF6	|
CODE_02BDF7:
	CMP.w $1540,X
	BNE CODE_02BE0E				;$02BDFA	|
	INC $C2,X				;$02BDFC	|
	LDA $C2,X				;$02BDFE	|
	CMP.b #$04				;$02BE00	|
	BNE CODE_02BE06				;$02BE02	|
	STZ $C2,X				;$02BE04	|
CODE_02BE06:
	CMP.b #$08
	BNE CODE_02BE0E				;$02BE08	|
	LDA.b #$04				;$02BE0A	|
	STA $C2,X				;$02BE0C	|
CODE_02BE0E:
	LDY $C2,X
	LDA.w $1588,X				;$02BE10	|
	AND.w DATA_02BCAF,Y			;$02BE13	|
	BEQ CODE_02BE2F				;$02BE16	|
	LDA.b #$08				;$02BE18	|
	STA.w $1564,X				;$02BE1A	|
	DEC $C2,X				;$02BE1D	|
	LDA $C2,X				;$02BE1F	|
	BPL CODE_02BE27				;$02BE21	|
	LDA.b #$03				;$02BE23	|
	BRA CODE_02BE2D				;$02BE25	|

CODE_02BE27:
	CMP.b #$03
	BNE CODE_02BE2F				;$02BE29	|
	LDA.b #$07				;$02BE2B	|
CODE_02BE2D:
	STA $C2,X
CODE_02BE2F:
	LDY $C2,X
	LDA.w DATA_02BC97,Y			;$02BE31	|
	STA $AA,X				;$02BE34	|
	LDA.w DATA_02BC8F,Y			;$02BE36	|
	STA $B6,X				;$02BE39	|
	LDA $9E,X				;$02BE3B	|
	CMP.b #$A5				;$02BE3D	|
	BNE CODE_02BE45				;$02BE3F	|
	ASL $B6,X				;$02BE41	|
	ASL $AA,X				;$02BE43	|
CODE_02BE45:
	JSR UpdateXPosNoGrvtyB1
	JSR UpdateYPosNoGrvtyB1			;$02BE48	|
	RTL					;$02BE4B	|

DATA_02BE4C:
	db $05,$45

CODE_02BE4E:
	LDA $9E,X
	CMP.b #$A5				;$02BE50	|
	BNE CODE_02BEB5				;$02BE52	|
	JSL GenericSprGfxRt2			;$02BE54	|
	LDY.w $15EA,X				;$02BE58	|
	LDA.w $192B				;$02BE5B	|
	CMP.b #$02				;$02BE5E	|
	BNE CODE_02BE79				;$02BE60	|
	PHX					;$02BE62	|
	LDA $14					;$02BE63	|
	LSR					;$02BE65	|
	LSR					;$02BE66	|
	AND.b #$01				;$02BE67	|
	TAX					;$02BE69	|
	LDA.b #$C8				;$02BE6A	|
	STA.w $0302,Y				;$02BE6C	|
	LDA.w DATA_02BE4C,X			;$02BE6F	|
	ORA $64					;$02BE72	|
	STA.w $0303,Y				;$02BE74	|
	PLX					;$02BE77	|
	RTS					;$02BE78	|

CODE_02BE79:
	LDA.b #$0A
	STA.w $0302,Y				;$02BE7B	|
	LDA $14					;$02BE7E	|
	AND.b #$0C				;$02BE80	|
	ASL					;$02BE82	|
	ASL					;$02BE83	|
	ASL					;$02BE84	|
	ASL					;$02BE85	|
	EOR.w $0303,Y				;$02BE86	|
	STA.w $0303,Y				;$02BE89	|
	RTS					;$02BE8C	|

DATA_02BE8D:
	db $F8,$08,$F8,$08

DATA_02BE91:
	db $F8,$F8,$08,$08

HotheadTiles:
	db $0C,$0E,$0E,$0C,$0E,$0C,$0C,$0E
DATA_02BE9D:
	db $05,$05,$C5,$C5,$45,$45,$85,$85
DATA_02BEA5:
	db $07,$07,$01,$01,$01,$01,$07,$07
DATA_02BEAD:
	db $00,$08,$08,$00,$00,$08,$08,$00

CODE_02BEB5:
	JSR GetDrawInfo2
	TYA					;$02BEB8	|
	CLC					;$02BEB9	|
	ADC.b #$04				;$02BEBA	|
	STA.w $15EA,X				;$02BEBC	|
	TAY					;$02BEBF	|
	LDA $14					;$02BEC0	|
	AND.b #$04				;$02BEC2	|
	STA $03					;$02BEC4	|
	PHX					;$02BEC6	|
	LDX.b #$03				;$02BEC7	|
CODE_02BEC9:
	LDA $00
	CLC					;$02BECB	|
	ADC.w DATA_02BE8D,X			;$02BECC	|
	STA.w $0300,Y				;$02BECF	|
	LDA $01					;$02BED2	|
	CLC					;$02BED4	|
	ADC.w DATA_02BE91,X			;$02BED5	|
	STA.w $0301,Y				;$02BED8	|
	PHX					;$02BEDB	|
	TXA					;$02BEDC	|
	ORA $03					;$02BEDD	|
	TAX					;$02BEDF	|
	LDA.w HotheadTiles,X			;$02BEE0	|
	STA.w $0302,Y				;$02BEE3	|
	LDA.w DATA_02BE9D,X			;$02BEE6	|
	ORA $64					;$02BEE9	|
	STA.w $0303,Y				;$02BEEB	|
	PLX					;$02BEEE	|
	INY					;$02BEEF	|
	INY					;$02BEF0	|
	INY					;$02BEF1	|
	INY					;$02BEF2	|
	DEX					;$02BEF3	|
	BPL CODE_02BEC9				;$02BEF4	|
	PLX					;$02BEF6	|
	LDA $00					;$02BEF7	|
	PHA					;$02BEF9	|
	LDA $01					;$02BEFA	|
	PHA					;$02BEFC	|
	LDY.b #$02				;$02BEFD	|
	LDA.b #$03				;$02BEFF	|
	JSR CODE_02B7A7				;$02BF01	|
	PLA					;$02BF04	|
	STA $01					;$02BF05	|
	PLA					;$02BF07	|
	STA $00					;$02BF08	|
	LDA.b #$09				;$02BF0A	|
	LDY.w $1558,X				;$02BF0C	|
	BEQ CODE_02BF13				;$02BF0F	|
	LDA.b #$19				;$02BF11	|
CODE_02BF13:
	STA $02
	LDA.w $15EA,X				;$02BF15	|
	SEC					;$02BF18	|
	SBC.b #$04				;$02BF19	|
	STA.w $15EA,X				;$02BF1B	|
	TAY					;$02BF1E	|
	PHX					;$02BF1F	|
	LDA $C2,X				;$02BF20	|
	TAX					;$02BF22	|
	LDA $00					;$02BF23	|
	CLC					;$02BF25	|
	ADC.w DATA_02BEA5,X			;$02BF26	|
	STA.w $0300,Y				;$02BF29	|
	LDA $01					;$02BF2C	|
	CLC					;$02BF2E	|
	ADC.w DATA_02BEAD,X			;$02BF2F	|
	STA.w $0301,Y				;$02BF32	|
	LDA $02					;$02BF35	|
	STA.w $0302,Y				;$02BF37	|
	LDA.b #$05				;$02BF3A	|
	ORA $64					;$02BF3C	|
	STA.w $0303,Y				;$02BF3E	|
	PLX					;$02BF41	|
	LDY.b #$00				;$02BF42	|
	LDA.b #$00				;$02BF44	|
	JMP CODE_02B7A7				;$02BF46	|

DATA_02BF49:
	db $08,$00,$10,$00,$10

DATA_02BF4E:
	db $08,$00,$00,$10,$10

DATA_02BF53:
	db $37,$37,$77,$B7,$F7

UrchinTiles:
	db $C4,$C6,$C8,$C6

CODE_02BF5C:
	LDA.w $163E,X
	BNE CODE_02BF69				;$02BF5F	|
	INC.w $1528,X				;$02BF61	|
	LDA.b #$0C				;$02BF64	|
	STA.w $163E,X				;$02BF66	|
CODE_02BF69:
	LDA.w $1528,X
	AND.b #$03				;$02BF6C	|
	TAY					;$02BF6E	|
	LDA.w DATA_02BCD7,Y			;$02BF6F	|
	STA.w $1602,X				;$02BF72	|
	JSR GetDrawInfo2			;$02BF75	|
	STZ $05					;$02BF78	|
	LDA.w $1602,X				;$02BF7A	|
	STA $02					;$02BF7D	|
	LDA.w $1558,X				;$02BF7F	|
	STA $03					;$02BF82	|
CODE_02BF84:
	LDX $05
	LDA $00					;$02BF86	|
	CLC					;$02BF88	|
	ADC.w DATA_02BF49,X			;$02BF89	|
	STA.w $0300,Y				;$02BF8C	|
	LDA $01					;$02BF8F	|
	CLC					;$02BF91	|
	ADC.w DATA_02BF4E,X			;$02BF92	|
	STA.w $0301,Y				;$02BF95	|
	LDA.w DATA_02BF53,X			;$02BF98	|
	STA.w $0303,Y				;$02BF9B	|
	CPX.b #$00				;$02BF9E	|
	BNE CODE_02BFAC				;$02BFA0	|
	LDA.b #$CA				;$02BFA2	|
	LDX $03					;$02BFA4	|
	BEQ CODE_02BFAA				;$02BFA6	|
	LDA.b #$CC				;$02BFA8	|
CODE_02BFAA:
	BRA CODE_02BFB1

CODE_02BFAC:
	LDX $02
	LDA.w UrchinTiles,X			;$02BFAE	|
CODE_02BFB1:
	STA.w $0302,Y
	INY					;$02BFB4	|
	INY					;$02BFB5	|
	INY					;$02BFB6	|
	INY					;$02BFB7	|
	INC $05					;$02BFB8	|
	LDA $05					;$02BFBA	|
	CMP.b #$05				;$02BFBC	|
	BNE CODE_02BF84				;$02BFBE	|
	LDX.w $15E9				;$02BFC0	|
	LDY.b #$02				;$02BFC3	|
	JMP CODE_02C82B				;$02BFC5	|

DATA_02BFC8:
	db $10,$F0

DATA_02BFCA:
	db $01,$FF

Return02BFCC:
	RTL

RipVanFishMain:
	JSL GenericSprGfxRt2
	LDA $9D					;$02BFD1	|
	BNE Return02BFCC			;$02BFD3	|
	JSR SubOffscreen0Bnk2			;$02BFD5	|
	JSL SprSprPMarioSprRts			;$02BFD8	|
	LDA $B6,X				;$02BFDC	|
	PHA					;$02BFDE	|
	LDA $AA,X				;$02BFDF	|
	PHA					;$02BFE1	|
	LDY.w $1490				;$02BFE2	|
	BEQ CODE_02BFF3				;$02BFE5	|
	EOR.b #$FF				;$02BFE7	|
	INC A					;$02BFE9	|
	STA $AA,X				;$02BFEA	|
	LDA $B6,X				;$02BFEC	|
	EOR.b #$FF				;$02BFEE	|
	INC A					;$02BFF0	|
	STA $B6,X				;$02BFF1	|
CODE_02BFF3:
	JSR CODE_02C126
	JSR UpdateXPosNoGrvtyB1			;$02BFF6	|
	JSR UpdateYPosNoGrvtyB1			;$02BFF9	|
	JSL CODE_019138				;$02BFFC	|
	PLA					;$02C000	|
	STA $AA,X				;$02C001	|
	PLA					;$02C003	|
	STA $B6,X				;$02C004	|
	INC.w $1570,X				;$02C006	|
	LDA.w $1588,X				;$02C009	|
	AND.b #$03				;$02C00C	|
	BEQ CODE_02C012				;$02C00E	|
	STZ $B6,X				;$02C010	|
CODE_02C012:
	LDA.w $1588,X
	AND.b #$0C				;$02C015	|
	BEQ CODE_02C01B				;$02C017	|
	STZ $AA,X				;$02C019	|
CODE_02C01B:
	LDA.w $164A,X
	BNE CODE_02C024				;$02C01E	|
	LDA.b #$10				;$02C020	|
	STA $AA,X				;$02C022	|
CODE_02C024:
	LDA $C2,X
	JSL execute_pointer			;$02C026	|

RipVanFishPtrs:
	dw CODE_02C02E
	dw CODE_02C08A

CODE_02C02E:
	LDA.b #$02
	STA $AA,X				;$02C030	|
	LDA $13					;$02C032	|
	AND.b #$03				;$02C034	|
	BNE CODE_02C044				;$02C036	|
	LDA $B6,X				;$02C038	|
	BEQ CODE_02C044				;$02C03A	|
	BPL CODE_02C042				;$02C03C	|
	INC $B6,X				;$02C03E	|
	BRA CODE_02C044				;$02C040	|

CODE_02C042:
	DEC $B6,X
CODE_02C044:
	LDA.w $1588,X
	AND.b #$04				;$02C047	|
	BEQ CODE_02C053				;$02C049	|
	STZ $AA,X				;$02C04B	|
	LDA $D8,X				;$02C04D	|
	AND.b #$F0				;$02C04F	|
	STA $D8,X				;$02C051	|
CODE_02C053:
	JSL CODE_02C0D9
	LDA.w $18FD				;$02C057	|
	BNE CODE_02C072				;$02C05A	|
	JSR CODE_02D4FA				;$02C05C	|
	LDA $0F					;$02C05F	|
	ADC.b #$30				;$02C061	|
	CMP.b #$60				;$02C063	|
	BCS CODE_02C07B				;$02C065	|
	JSR CODE_02D50C				;$02C067	|
	LDA $0E					;$02C06A	|
	ADC.b #$30				;$02C06C	|
	CMP.b #$60				;$02C06E	|
	BCS CODE_02C07B				;$02C070	|
CODE_02C072:
	INC $C2,X
	LDA.b #$FF				;$02C074	|
	STA.w $151C,X				;$02C076	|
	BRA CODE_02C08A				;$02C079	|

CODE_02C07B:
	LDY.b #$02
	LDA.w $1570,X				;$02C07D	|
	AND.b #$30				;$02C080	|
	BNE CODE_02C085				;$02C082	|
	INY					;$02C084	|
CODE_02C085:
	TYA
	STA.w $1602,X				;$02C086	|
	RTL					;$02C089	|

CODE_02C08A:
	LDA $13
	AND.b #$01				;$02C08C	|
	BNE CODE_02C095				;$02C08E	|
	DEC.w $151C,X				;$02C090	|
	BEQ CODE_02C0CA				;$02C093	|
CODE_02C095:
	LDA $13
	AND.b #$07				;$02C097	|
	BNE CODE_02C0BB				;$02C099	|
	JSR CODE_02D4FA				;$02C09B	|
	LDA $B6,X				;$02C09E	|
	CMP.w DATA_02BFC8,Y			;$02C0A0	|
	BEQ CODE_02C0AB				;$02C0A3	|
	CLC					;$02C0A5	|
	ADC.w DATA_02BFCA,Y			;$02C0A6	|
	STA $B6,X				;$02C0A9	|
CODE_02C0AB:
	JSR CODE_02D50C
	LDA $AA,X				;$02C0AE	|
	CMP.w DATA_02BFC8,Y			;$02C0B0	|
	BEQ CODE_02C0BB				;$02C0B3	|
	CLC					;$02C0B5	|
	ADC.w DATA_02BFCA,Y			;$02C0B6	|
	STA $AA,X				;$02C0B9	|
CODE_02C0BB:
	LDY.b #$00
	LDA.w $1570,X				;$02C0BD	|
	AND.b #$04				;$02C0C0	|
	BEQ CODE_02C0C5				;$02C0C2	|
	INY					;$02C0C4	|
CODE_02C0C5:
	TYA
	STA.w $1602,X				;$02C0C6	|
	RTL					;$02C0C9	|

CODE_02C0CA:
	STZ $C2,X
	JMP CODE_02C02E				;$02C0CC	|

ADDR_02C0CF:
	LDA.b #$08
	LDY.w $157C,X				;$02C0D1	|
	BEQ ADDR_02C0D7				;$02C0D4	|
	INC A					;$02C0D6	|
ADDR_02C0D7:
	BRA CODE_02C0DB

CODE_02C0D9:
	LDA.b #$06
CODE_02C0DB:
	TAY
	LDA.w $15A0,X				;$02C0DC	|
	ORA.w $186C,X				;$02C0DF	|
	BNE Return02C125			;$02C0E2	|
	TYA					;$02C0E4	|
	DEC.w $1528,X				;$02C0E5	|
	BPL Return02C125			;$02C0E8	|
	PHA					;$02C0EA	|
	LDA.b #$28				;$02C0EB	|
	STA.w $1528,X				;$02C0ED	|
	LDY.b #$0B				;$02C0F0	|
CODE_02C0F2:
	LDA.w $17F0,Y
	BEQ CODE_02C107				;$02C0F5	|
	DEY					;$02C0F7	|
	BPL CODE_02C0F2				;$02C0F8	|
	DEC.w $185D				;$02C0FA	|
	BPL CODE_02C104				;$02C0FD	|
	LDA.b #$0B				;$02C0FF	|
	STA.w $185D				;$02C101	|
CODE_02C104:
	LDY.w $185D
CODE_02C107:
	PLA
	STA.w $17F0,Y				;$02C108	|
	LDA $E4,X				;$02C10B	|
	CLC					;$02C10D	|
	ADC.b #$06				;$02C10E	|
	STA.w $1808,Y				;$02C110	|
	LDA $D8,X				;$02C113	|
	CLC					;$02C115	|
	ADC.b #$00				;$02C116	|
	STA.w $17FC,Y				;$02C118	|
	LDA.b #$7F				;$02C11B	|
	STA.w $1850,Y				;$02C11D	|
	LDA.b #$FA				;$02C120	|
	STA.w $182C,Y				;$02C122	|
Return02C125:
	RTL

CODE_02C126:
	LDY.b #$00
	LDA $B6,X				;$02C128	|
	BPL CODE_02C12D				;$02C12A	|
	INY					;$02C12C	|
CODE_02C12D:
	TYA
	STA.w $157C,X				;$02C12E	|
	RTS					;$02C131	|

DATA_02C132:
	db $30,$20,$0A,$30

DATA_02C136:
	db $05,$0E,$0F,$10

CODE_02C13A:
	LDA.w $1558,X
	BEQ CODE_02C156				;$02C13D	|
	CMP.b #$01				;$02C13F	|
	BNE CODE_02C150				;$02C141	|
	LDA.b #$30				;$02C143	|
	STA.w $1540,X				;$02C145	|
	LDA.b #$04				;$02C148	|
	STA.w $1534,X				;$02C14A	|
	STZ.w $1570,X				;$02C14D	|
CODE_02C150:
	LDA.b #$02
	STA.w $151C,X				;$02C152	|
	RTS					;$02C155	|

CODE_02C156:
	LDA.w $1540,X
	BNE CODE_02C181				;$02C159	|
	INC.w $1534,X				;$02C15B	|
	LDA.w $1534,X				;$02C15E	|
	AND.b #$03				;$02C161	|
	STA.w $1570,X				;$02C163	|
	TAY					;$02C166	|
	LDA.w DATA_02C132,Y			;$02C167	|
	STA.w $1540,X				;$02C16A	|
	CPY.b #$01				;$02C16D	|
	BNE CODE_02C181				;$02C16F	|
	LDA.w $1534,X				;$02C171	|
	AND.b #$0C				;$02C174	|
	BNE CODE_02C17E				;$02C176	|
	LDA.b #$40				;$02C178	|
	STA.w $1558,X				;$02C17A	|
	RTS					;$02C17D	|

CODE_02C17E:
	JSR CODE_02C19A
CODE_02C181:
	LDY.w $1570,X
	LDA.w DATA_02C136,Y			;$02C184	|
	STA.w $1602,X				;$02C187	|
	LDY.w $157C,X				;$02C18A	|
	LDA.w DATA_02C1F3,Y			;$02C18D	|
	STA.w $151C,X				;$02C190	|
	RTS					;$02C193	|

DATA_02C194:
	db $14,$EC

DATA_02C196:
	db $00,$FF

DATA_02C198:
	db $08,$F8

CODE_02C19A:
	JSL FindFreeSprSlot
	BMI Return02C1F2			;$02C19E	|
	LDA.b #$08				;$02C1A0	|
	STA.w $14C8,Y				;$02C1A2	|
	LDA.b #$48				;$02C1A5	|
	STA.w $009E,y				;$02C1A7	|
	LDA.w $157C,X				;$02C1AA	|
	STA $02					;$02C1AD	|
	LDA $E4,X				;$02C1AF	|
	STA $00					;$02C1B1	|
	LDA.w $14E0,X				;$02C1B3	|
	STA $01					;$02C1B6	|
	PHX					;$02C1B8	|
	TYX					;$02C1B9	|
	JSL InitSpriteTables			;$02C1BA	|
	LDX $02					;$02C1BE	|
	LDA $00					;$02C1C0	|
	CLC					;$02C1C2	|
	ADC.w DATA_02C194,X			;$02C1C3	|
	STA.w $00E4,y				;$02C1C6	|
	LDA $01					;$02C1C9	|
	ADC.w DATA_02C196,X			;$02C1CB	|
	STA.w $14E0,Y				;$02C1CE	|
	LDA.w DATA_02C198,X			;$02C1D1	|
	STA.w $00B6,y				;$02C1D4	|
	PLX					;$02C1D7	|
	LDA $D8,X				;$02C1D8	|
	CLC					;$02C1DA	|
	ADC.b #$0A				;$02C1DB	|
	STA.w $00D8,y				;$02C1DD	|
	LDA.w $14D4,X				;$02C1E0	|
	ADC.b #$00				;$02C1E3	|
	STA.w $14D4,Y				;$02C1E5	|
	LDA.b #$C0				;$02C1E8	|
	STA.w $00AA,y				;$02C1EA	|
	LDA.b #$2C				;$02C1ED	|
	STA.w $1540,Y				;$02C1EF	|
Return02C1F2:
	RTS

DATA_02C1F3:
	db $01,$03

ChucksMain:
	PHB
	PHK					;$02C1F6	|
	PLB					;$02C1F7	|
	LDA.w $187B,X				;$02C1F8	|
	PHA					;$02C1FB	|
	JSR CODE_02C22C				;$02C1FC	|
	PLA					;$02C1FF	|
	BNE CODE_02C211				;$02C200	|
	CMP.w $187B,X				;$02C202	|
	BEQ CODE_02C211				;$02C205	|
	LDA.w $163E,X				;$02C207	|
	BNE CODE_02C211				;$02C20A	|
	LDA.b #$28				;$02C20C	|
	STA.w $163E,X				;$02C20E	|
CODE_02C211:
	PLB
	RTL					;$02C212	|

DATA_02C213:
	db $01,$02,$03,$02

CODE_02C217:
	LDA $14
	LSR					;$02C219	|
	LSR					;$02C21A	|
	AND.b #$03				;$02C21B	|
	TAY					;$02C21D	|
	LDA.w DATA_02C213,Y			;$02C21E	|
	STA.w $151C,X				;$02C221	|
	JSR CODE_02C81A				;$02C224	|
	RTS					;$02C227	|

DATA_02C228:
	db $40,$10

DATA_02C22A:
	db $03,$01

CODE_02C22C:
	LDA.w $14C8,X
	CMP.b #$08				;$02C22F	|
	BNE CODE_02C217				;$02C231	|
	LDA.w $15AC,X				;$02C233	|
	BEQ CODE_02C23D				;$02C236	|
	LDA.b #$05				;$02C238	|
	STA.w $1602,X				;$02C23A	|
CODE_02C23D:
	LDA.w $1588,X
	AND.b #$04				;$02C240	|
	BNE CODE_02C253				;$02C242	|
	LDA $AA,X				;$02C244	|
	BPL CODE_02C253				;$02C246	|
	LDA $C2,X				;$02C248	|
	CMP.b #$05				;$02C24A	|
	BCS CODE_02C253				;$02C24C	|
	LDA.b #$06				;$02C24E	|
	STA.w $1602,X				;$02C250	|
CODE_02C253:
	JSR CODE_02C81A
	LDA $9D					;$02C256	|
	BEQ CODE_02C25B				;$02C258	|
	RTS					;$02C25A	|

CODE_02C25B:
	JSR SubOffscreen0Bnk2
	JSR CODE_02C79D				;$02C25E	|
	JSL SprSprInteract			;$02C261	|
	JSL CODE_019138				;$02C265	|
	LDA.w $1588,X				;$02C269	|
	AND.b #$08				;$02C26C	|
	BEQ CODE_02C274				;$02C26E	|
	LDA.b #$10				;$02C270	|
	STA $AA,X				;$02C272	|
CODE_02C274:
	LDA.w $1588,X
	AND.b #$03				;$02C277	|
	BEQ CODE_02C2F4				;$02C279	|
	LDA.w $15A0,X				;$02C27B	|
	ORA.w $186C,X				;$02C27E	|
	BNE CODE_02C2E4				;$02C281	|
	LDA.w $187B,X				;$02C283	|
	BEQ CODE_02C2E4				;$02C286	|
	LDA $E4,X				;$02C288	|
	SEC					;$02C28A	|
	SBC $1A					;$02C28B	|
	CLC					;$02C28D	|
	ADC.b #$14				;$02C28E	|
	CMP.b #$1C				;$02C290	|
	BCC CODE_02C2E4				;$02C292	|
	LDA.w $1588,X				;$02C294	|
	AND.b #$40				;$02C297	|
	BNE CODE_02C2E4				;$02C299	|
	LDA.w $18A7				;$02C29B	|
	CMP.b #$2E				;$02C29E	|
	BEQ CODE_02C2A6				;$02C2A0	|
	CMP.b #$1E				;$02C2A2	|
	BNE CODE_02C2E4				;$02C2A4	|
CODE_02C2A6:
	LDA.w $1588,X
	AND.b #$04				;$02C2A9	|
	BEQ CODE_02C2F7				;$02C2AB	|
	LDA $9B					;$02C2AD	|
	PHA					;$02C2AF	|
	LDA $9A					;$02C2B0	|
	PHA					;$02C2B2	|
	LDA $99					;$02C2B3	|
	PHA					;$02C2B5	|
	LDA $98					;$02C2B6	|
	PHA					;$02C2B8	|
	JSL ShatterBlock			;$02C2B9	|
	LDA.b #$02				;$02C2BD	|
	STA $9C					;$02C2BF	|
	JSL generate_tile			;$02C2C1	|
	PLA					;$02C2C5	|
	SEC					;$02C2C6	|
	SBC.b #$10				;$02C2C7	|
	STA $98					;$02C2C9	|
	PLA					;$02C2CB	|
	SBC.b #$00				;$02C2CC	|
	STA $99					;$02C2CE	|
	PLA					;$02C2D0	|
	STA $9A					;$02C2D1	|
	PLA					;$02C2D3	|
	STA $9B					;$02C2D4	|
	JSL ShatterBlock			;$02C2D6	|
	LDA.b #$02				;$02C2DA	|
	STA $9C					;$02C2DC	|
	JSL generate_tile			;$02C2DE	|
	BRA CODE_02C2F4				;$02C2E2	|

CODE_02C2E4:
	LDA.w $1588,X
	AND.b #$04				;$02C2E7	|
	BEQ CODE_02C2F7				;$02C2E9	|
	LDA.b #$C0				;$02C2EB	|
	STA $AA,X				;$02C2ED	|
	JSR UpdateYPosNoGrvtyB1			;$02C2EF	|
	BRA CODE_02C301				;$02C2F2	|

CODE_02C2F4:
	JSR UpdateXPosNoGrvtyB1
CODE_02C2F7:
	LDA.w $1588,X
	AND.b #$04				;$02C2FA	|
	BEQ CODE_02C301				;$02C2FC	|
	JSR CODE_02C579				;$02C2FE	|
CODE_02C301:
	JSR UpdateYPosNoGrvtyB1
	LDY.w $164A,X				;$02C304	|
	CPY.b #$01				;$02C307	|
	LDY.b #$00				;$02C309	|
	LDA $AA,X				;$02C30B	|
	BCC CODE_02C31A				;$02C30D	|
	INY					;$02C30F	|
	CMP.b #$00				;$02C310	|
	BPL CODE_02C31A				;$02C312	|
	CMP.b #$E0				;$02C314	|
	BCS CODE_02C31A				;$02C316	|
	LDA.b #$E0				;$02C318	|
CODE_02C31A:
	CLC
	ADC.w DATA_02C22A,Y			;$02C31B	|
	BMI CODE_02C328				;$02C31E	|
	CMP.w DATA_02C228,Y			;$02C320	|
	BCC CODE_02C328				;$02C323	|
	LDA.w DATA_02C228,Y			;$02C325	|
CODE_02C328:
	TAY
	BMI CODE_02C334				;$02C329	|
	LDY $C2,X				;$02C32B	|
	CPY.b #$07				;$02C32D	|
	BNE CODE_02C334				;$02C32F	|
	CLC					;$02C331	|
	ADC.b #$03				;$02C332	|
CODE_02C334:
	STA $AA,X
	LDA $C2,X				;$02C336	|
	JSL execute_pointer			;$02C338	|

ChuckPtrs:
	dw CODE_02C63B
	dw CODE_02C6A7
	dw CODE_02C726
	dw CODE_02C74A
	dw CODE_02C13A
	dw CODE_02C582
	dw CODE_02C53C
	dw CODE_02C564
	dw CODE_02C4E3
	dw CODE_02C4BD
	dw CODE_02C3CB
	dw CODE_02C356
	dw CODE_02C37B

CODE_02C356:
	LDA.b #$03
	STA.w $1602,X				;$02C358	|
	LDA.w $164A,X				;$02C35B	|
	BEQ CODE_02C370				;$02C35E	|
	JSR CODE_02D4FA				;$02C360	|
	LDA $0F					;$02C363	|
	CLC					;$02C365	|
	ADC.b #$30				;$02C366	|
	CMP.b #$60				;$02C368	|
	BCS CODE_02C370				;$02C36A	|
	LDA.b #$0C				;$02C36C	|
	STA $C2,X				;$02C36E	|
CODE_02C370:
	JMP CODE_02C556

DATA_02C373:
	db $05,$05,$05,$02,$02,$06,$06,$06

CODE_02C37B:
	LDA $14
	AND.b #$3F				;$02C37D	|
	BNE CODE_02C386				;$02C37F	|
	LDA.b #$1E				;$02C381	|
	STA.w $1DFC				;$02C383	|
CODE_02C386:
	LDY.b #$03
	LDA $14					;$02C388	|
	AND.b #$30				;$02C38A	|
	BEQ CODE_02C390				;$02C38C	|
	LDY.b #$06				;$02C38E	|
CODE_02C390:
	TYA
	STA.w $1602,X				;$02C391	|
	LDA $14					;$02C394	|
	LSR					;$02C396	|
	LSR					;$02C397	|
	AND.b #$07				;$02C398	|
	TAY					;$02C39A	|
	LDA.w DATA_02C373,Y			;$02C39B	|
	STA.w $151C,X				;$02C39E	|
	LDA $E4,X				;$02C3A1	|
	LSR					;$02C3A3	|
	LSR					;$02C3A4	|
	LSR					;$02C3A5	|
	LSR					;$02C3A6	|
	LSR					;$02C3A7	|
	LDA.b #$09				;$02C3A8	|
	BCC CODE_02C3AF				;$02C3AA	|
	STA.w $18B9				;$02C3AC	|
CODE_02C3AF:
	STA.w $18FD
	RTS					;$02C3B2	|

DATA_02C3B3:
	db $7F,$BF,$FF,$DF

DATA_02C3B7:
	db $18,$19,$14,$14

DATA_02C3BB:
	db $18,$18,$18,$18,$17,$17,$17,$17
	db $17,$17,$16,$15,$15,$16,$16,$16

CODE_02C3CB:
	LDA.w $1534,X
	BNE CODE_02C43A				;$02C3CE	|
	JSR CODE_02D50C				;$02C3D0	|
	LDA $0E					;$02C3D3	|
	BPL CODE_02C3E7				;$02C3D5	|
	CMP.b #$D0				;$02C3D7	|
	BCS CODE_02C3E7				;$02C3D9	|
	LDA.b #$C8				;$02C3DB	|
	STA $AA,X				;$02C3DD	|
	LDA.b #$3E				;$02C3DF	|
	STA.w $1540,X				;$02C3E1	|
	INC.w $1534,X				;$02C3E4	|
CODE_02C3E7:
	LDA $13
	AND.b #$07				;$02C3E9	|
	BNE CODE_02C3F5				;$02C3EB	|
	LDA.w $1540,X				;$02C3ED	|
	BEQ CODE_02C3F5				;$02C3F0	|
	INC.w $1540,X				;$02C3F2	|
CODE_02C3F5:
	LDA $14
	AND.b #$3F				;$02C3F7	|
	BNE CODE_02C3FE				;$02C3F9	|
	JSR CODE_02C556				;$02C3FB	|
CODE_02C3FE:
	LDA.w $1540,X
	BNE CODE_02C40C				;$02C401	|
	LDY.w $187B,X				;$02C403	|
	LDA.w DATA_02C3B3,Y			;$02C406	|
	STA.w $1540,X				;$02C409	|
CODE_02C40C:
	LDA.w $1540,X
	CMP.b #$40				;$02C40F	|
	BCS CODE_02C419				;$02C411	|
	LDA.b #$00				;$02C413	|
	STA.w $1602,X				;$02C415	|
	RTS					;$02C418	|

CODE_02C419:
	SEC
	SBC.b #$40				;$02C41A	|
	LSR					;$02C41C	|
	LSR					;$02C41D	|
	LSR					;$02C41E	|
	AND.b #$03				;$02C41F	|
	TAY					;$02C421	|
	LDA.w DATA_02C3B7,Y			;$02C422	|
	STA.w $1602,X				;$02C425	|
	LDA.w $1540,X				;$02C428	|
	AND.b #$1F				;$02C42B	|
	CMP.b #$06				;$02C42D	|
	BNE Return02C439			;$02C42F	|
	JSR CODE_02C466				;$02C431	|
	LDA.b #$08				;$02C434	|
	STA.w $1558,X				;$02C436	|
Return02C439:
	RTS

CODE_02C43A:
	LDA.w $1540,X
	BEQ CODE_02C45C				;$02C43D	|
	PHA					;$02C43F	|
	CMP.b #$20				;$02C440	|
	BCC CODE_02C44A				;$02C442	|
	CMP.b #$30				;$02C444	|
	BCS CODE_02C44A				;$02C446	|
	STZ $AA,X				;$02C448	|
CODE_02C44A:
	LSR
	LSR					;$02C44B	|
	TAY					;$02C44C	|
	LDA.w DATA_02C3BB,Y			;$02C44D	|
	STA.w $1602,X				;$02C450	|
	PLA					;$02C453	|
	CMP.b #$26				;$02C454	|
	BNE Return02C45B			;$02C456	|
	JSR CODE_02C466				;$02C458	|
Return02C45B:
	RTS

CODE_02C45C:
	STZ.w $1534,X
	RTS					;$02C45F	|

BaseballTileDispX:
	db $10,$F8

DATA_02C462:
	db $00,$FF

BaseballSpeed:
	db $18,$E8

CODE_02C466:
	LDA.w $1558,X
	ORA.w $186C,X				;$02C469	|
	BNE Return02C439			;$02C46C	|
	LDY.b #$07				;$02C46E	|
CODE_02C470:
	LDA.w $170B,Y
	BEQ CODE_02C479				;$02C473	|
	DEY					;$02C475	|
	BPL CODE_02C470				;$02C476	|
	RTS					;$02C478	|

CODE_02C479:
	LDA.b #$0D
	STA.w $170B,Y				;$02C47B	|
	LDA $E4,X				;$02C47E	|
	STA $00					;$02C480	|
	LDA.w $14E0,X				;$02C482	|
	STA $01					;$02C485	|
	LDA $D8,X				;$02C487	|
	CLC					;$02C489	|
	ADC.b #$00				;$02C48A	|
	STA.w $1715,Y				;$02C48C	|
	LDA.w $14D4,X				;$02C48F	|
	ADC.b #$00				;$02C492	|
	STA.w $1729,Y				;$02C494	|
	PHX					;$02C497	|
	LDA.w $157C,X				;$02C498	|
	TAX					;$02C49B	|
	LDA $00					;$02C49C	|
	CLC					;$02C49E	|
	ADC.w BaseballTileDispX,X		;$02C49F	|
	STA.w $171F,Y				;$02C4A2	|
	LDA $01					;$02C4A5	|
	ADC.w DATA_02C462,X			;$02C4A7	|
	STA.w $1733,Y				;$02C4AA	|
	LDA.w BaseballSpeed,X			;$02C4AD	|
	STA.w $1747,Y				;$02C4B0	|
	PLX					;$02C4B3	|
	RTS					;$02C4B4	|

DATA_02C4B5:
	db $00,$00,$11,$11,$11,$11,$00,$00

CODE_02C4BD:
	STZ.w $1602,X
	TXA					;$02C4C0	|
	ASL					;$02C4C1	|
	ASL					;$02C4C2	|
	ASL					;$02C4C3	|
	ADC $13					;$02C4C4	|
	AND.b #$7F				;$02C4C6	|
	CMP.b #$00				;$02C4C8	|
	BNE CODE_02C4D5				;$02C4CA	|
	PHA					;$02C4CC	|
	JSR CODE_02C556				;$02C4CD	|
	JSL CODE_03CBB3				;$02C4D0	|
	PLA					;$02C4D4	|
CODE_02C4D5:
	CMP.b #$20
	BCS Return02C4E2			;$02C4D7	|
	LSR					;$02C4D9	|
	LSR					;$02C4DA	|
	TAY					;$02C4DB	|
	LDA.w DATA_02C4B5,Y			;$02C4DC	|
	STA.w $1602,X				;$02C4DF	|
Return02C4E2:
	RTS

CODE_02C4E3:
	JSR CODE_02C556
	LDA.b #$06				;$02C4E6	|
	LDY $AA,X				;$02C4E8	|
	CPY.b #$F0				;$02C4EA	|
	BMI CODE_02C504				;$02C4EC	|
	LDY.w $160E,X				;$02C4EE	|
	BEQ CODE_02C504				;$02C4F1	|
	LDA.w $1FE2,X				;$02C4F3	|
	BNE CODE_02C502				;$02C4F6	|
	LDA.b #$19				;$02C4F8	|
	STA.w $1DFC				;$02C4FA	|
	LDA.b #$20				;$02C4FD	|
	STA.w $1FE2,X				;$02C4FF	|
CODE_02C502:
	LDA.b #$07
CODE_02C504:
	STA.w $1602,X
	LDA.w $1588,X				;$02C507	|
	AND.b #$04				;$02C50A	|
	BEQ Return02C53B			;$02C50C	|
	STZ.w $160E,X				;$02C50E	|
	LDA.b #$04				;$02C511	|
	STA.w $1602,X				;$02C513	|
	LDA.w $1540,X				;$02C516	|
	BNE Return02C53B			;$02C519	|
	LDA.b #$20				;$02C51B	|
	STA.w $1540,X				;$02C51D	|
	LDA.b #$F0				;$02C520	|
	STA $AA,X				;$02C522	|
	JSR CODE_02D50C				;$02C524	|
	LDA $0E					;$02C527	|
	BPL Return02C53B			;$02C529	|
	CMP.b #$D0				;$02C52B	|
	BCS Return02C53B			;$02C52D	|
	LDA.b #$C0				;$02C52F	|
	STA $AA,X				;$02C531	|
	INC.w $160E,X				;$02C533	|
CODE_02C536:
	LDA.b #$08
	STA.w $1DFC				;$02C538	|
Return02C53B:
	RTS

CODE_02C53C:
	LDA.b #$06
	STA.w $1602,X				;$02C53E	|
	LDA.w $1588,X				;$02C541	|
	AND.b #$04				;$02C544	|
	BEQ Return02C555			;$02C546	|
	JSR CODE_02C579				;$02C548	|
	JSR CODE_02C556				;$02C54B	|
	LDA.b #$08				;$02C54E	|
	STA.w $1540,X				;$02C550	|
	INC $C2,X				;$02C553	|
Return02C555:
	RTS

CODE_02C556:
	JSR CODE_02D4FA
	TYA					;$02C559	|
	STA.w $157C,X				;$02C55A	|
	LDA.w DATA_02C639,Y			;$02C55D	|
	STA.w $151C,X				;$02C560	|
	RTS					;$02C563	|

CODE_02C564:
	LDA.b #$03
	STA.w $1602,X				;$02C566	|
	LDA.w $1540,X				;$02C569	|
	BNE CODE_02C579				;$02C56C	|
	LDA.w $1588,X				;$02C56E	|
	AND.b #$04				;$02C571	|
	BEQ Return02C57D			;$02C573	|
	LDA.b #$05				;$02C575	|
	STA $C2,X				;$02C577	|
CODE_02C579:
	STZ $B6,X
	STZ $AA,X				;$02C57B	|
Return02C57D:
	RTS

DATA_02C57E:
	db $10,$F0

DATA_02C580:
	db $20,$E0

CODE_02C582:
	JSR CODE_02C556
	LDA.w $1540,X				;$02C585	|
	BEQ CODE_02C602				;$02C588	|
	CMP.b #$01				;$02C58A	|
	BNE CODE_02C5FC				;$02C58C	|
	LDA $9E,X				;$02C58E	|
	CMP.b #$93				;$02C590	|
	BNE CODE_02C5A7				;$02C592	|
	JSR CODE_02D4FA				;$02C594	|
	LDA.w DATA_02C580,Y			;$02C597	|
	STA $B6,X				;$02C59A	|
	LDA.b #$B0				;$02C59C	|
	STA $AA,X				;$02C59E	|
	LDA.b #$06				;$02C5A0	|
	STA $C2,X				;$02C5A2	|
	JMP CODE_02C536				;$02C5A4	|

CODE_02C5A7:
	STZ $C2,X
	LDA.b #$50				;$02C5A9	|
	STA.w $1540,X				;$02C5AB	|
	LDA.b #$10				;$02C5AE	|
	STA.w $1DF9				;$02C5B0	|
	STZ.w $185E				;$02C5B3	|
	JSR CODE_02C5BC				;$02C5B6	|
	INC.w $185E				;$02C5B9	|
CODE_02C5BC:
	JSL FindFreeSprSlot
	BMI CODE_02C5FC				;$02C5C0	|
	LDA.b #$08				;$02C5C2	|
	STA.w $14C8,Y				;$02C5C4	|
	LDA.b #$91				;$02C5C7	|
	STA.w $009E,y				;$02C5C9	|
	LDA $E4,X				;$02C5CC	|
	STA.w $00E4,y				;$02C5CE	|
	LDA.w $14E0,X				;$02C5D1	|
	STA.w $14E0,Y				;$02C5D4	|
	LDA $D8,X				;$02C5D7	|
	STA.w $00D8,y				;$02C5D9	|
	LDA.w $14D4,X				;$02C5DC	|
	STA.w $14D4,Y				;$02C5DF	|
	PHX					;$02C5E2	|
	TYX					;$02C5E3	|
	JSL InitSpriteTables			;$02C5E4	|
	LDX.w $185E				;$02C5E8	|
	LDA.w DATA_02C57E,X			;$02C5EB	|
	STA.w $00B6,y				;$02C5EE	|
	PLX					;$02C5F1	|
	LDA.b #$C8				;$02C5F2	|
	STA.w $00AA,y				;$02C5F4	|
	LDA.b #$50				;$02C5F7	|
	STA.w $1540,Y				;$02C5F9	|
CODE_02C5FC:
	LDA.b #$09
	STA.w $1602,X				;$02C5FE	|
	RTS					;$02C601	|

CODE_02C602:
	JSR CODE_02D4FA
	TYA					;$02C605	|
	STA.w $157C,X				;$02C606	|
	LDA $0F					;$02C609	|
	CLC					;$02C60B	|
	ADC.b #$50				;$02C60C	|
	CMP.b #$A0				;$02C60E	|
	BCS CODE_02C618				;$02C610	|
	LDA.b #$40				;$02C612	|
	STA.w $1540,X				;$02C614	|
	RTS					;$02C617	|

CODE_02C618:
	LDA.b #$03
	STA.w $1602,X				;$02C61A	|
	LDA $13					;$02C61D	|
	AND.b #$3F				;$02C61F	|
	BNE Return02C627			;$02C621	|
	LDA.b #$E0				;$02C623	|
	STA $AA,X				;$02C625	|
Return02C627:
	RTS

CODE_02C628:
	LDA.b #$08
	STA.w $15AC,X				;$02C62A	|
	RTS					;$02C62D	|

DATA_02C62E:
	db $00,$00,$00,$00,$01,$02,$03,$04
	db $04,$04,$04

DATA_02C639:
	db $00,$04

CODE_02C63B:
	LDA.b #$03
	STA.w $1602,X				;$02C63D	|
	STZ.w $187B,X				;$02C640	|
	LDA.w $1540,X				;$02C643	|
	AND.b #$0F				;$02C646	|
	BNE CODE_02C668				;$02C648	|
	JSR CODE_02D50C				;$02C64A	|
	LDA $0E					;$02C64D	|
	CLC					;$02C64F	|
	ADC.b #$28				;$02C650	|
	CMP.b #$50				;$02C652	|
	BCS CODE_02C668				;$02C654	|
	JSR CODE_02C556				;$02C656	|
	INC.w $187B,X				;$02C659	|
CODE_02C65C:
	LDA.b #$02
	STA $C2,X				;$02C65E	|
	LDA.b #$18				;$02C660	|
	STA.w $1540,X				;$02C662	|
	RTS					;$02C665	|

DATA_02C666:
	db $01,$FF

CODE_02C668:
	LDA.w $1540,X
	BNE CODE_02C677				;$02C66B	|
	LDA.w $157C,X				;$02C66D	|
	EOR.b #$01				;$02C670	|
	STA.w $157C,X				;$02C672	|
	BRA CODE_02C65C				;$02C675	|

CODE_02C677:
	LDA $14
	AND.b #$03				;$02C679	|
	BNE CODE_02C691				;$02C67B	|
	LDA.w $1534,X				;$02C67D	|
	AND.b #$01				;$02C680	|
	TAY					;$02C682	|
	LDA.w $1594,X				;$02C683	|
	CLC					;$02C686	|
	ADC.w DATA_02C666,Y			;$02C687	|
	CMP.b #$0B				;$02C68A	|
	BCS CODE_02C69B				;$02C68C	|
	STA.w $1594,X				;$02C68E	|
CODE_02C691:
	LDY.w $1594,X
	LDA.w DATA_02C62E,Y			;$02C694	|
	STA.w $151C,X				;$02C697	|
	RTS					;$02C69A	|

CODE_02C69B:
	INC.w $1534,X
	RTS					;$02C69E	|

DATA_02C69F:
	db $10,$F0,$18,$E8

DATA_02C6A3:
	db $12,$13,$12,$13

CODE_02C6A7:
	LDA.w $1588,X
	AND.b #$04				;$02C6AA	|
	BEQ CODE_02C6BA				;$02C6AC	|
	LDA.w $163E,X				;$02C6AE	|
	CMP.b #$01				;$02C6B1	|
	BRA CODE_02C6BA				;$02C6B3	|

	LDA.b #$24				;$02C6B5	|
	STA.w $1DF9				;$02C6B7	|
CODE_02C6BA:
	JSR CODE_02D50C
	LDA $0E					;$02C6BD	|
	CLC					;$02C6BF	|
	ADC.b #$30				;$02C6C0	|
	CMP.b #$60				;$02C6C2	|
	BCS CODE_02C6D7				;$02C6C4	|
	JSR CODE_02D4FA				;$02C6C6	|
	TYA					;$02C6C9	|
	CMP.w $157C,X				;$02C6CA	|
	BNE CODE_02C6D7				;$02C6CD	|
	LDA.b #$20				;$02C6CF	|
	STA.w $1540,X				;$02C6D1	|
	STA.w $187B,X				;$02C6D4	|
CODE_02C6D7:
	LDA.w $1540,X
	BNE CODE_02C6EC				;$02C6DA	|
	STZ $C2,X				;$02C6DC	|
	JSR CODE_02C628				;$02C6DE	|
	JSL GetRand				;$02C6E1	|
	AND.b #$3F				;$02C6E5	|
	ORA.b #$40				;$02C6E7	|
	STA.w $1540,X				;$02C6E9	|
CODE_02C6EC:
	LDY.w $157C,X
	LDA.w DATA_02C639,Y			;$02C6EF	|
	STA.w $151C,X				;$02C6F2	|
	LDA.w $1588,X				;$02C6F5	|
	AND.b #$04				;$02C6F8	|
	BEQ CODE_02C713				;$02C6FA	|
	LDA.w $187B,X				;$02C6FC	|
	BEQ CODE_02C70E				;$02C6FF	|
	LDA $14					;$02C701	|
	AND.b #$07				;$02C703	|
	BNE CODE_02C70C				;$02C705	|
	LDA.b #$01				;$02C707	|
	STA.w $1DF9				;$02C709	|
CODE_02C70C:
	INY
	INY					;$02C70D	|
CODE_02C70E:
	LDA.w DATA_02C69F,Y
	STA $B6,X				;$02C711	|
CODE_02C713:
	LDA $13
	LDY.w $187B,X				;$02C715	|
	BNE CODE_02C71B				;$02C718	|
	LSR					;$02C71A	|
CODE_02C71B:
	LSR
	AND.b #$03				;$02C71C	|
	TAY					;$02C71E	|
	LDA.w DATA_02C6A3,Y			;$02C71F	|
	STA.w $1602,X				;$02C722	|
	RTS					;$02C725	|

CODE_02C726:
	LDA.b #$03
	STA.w $1602,X				;$02C728	|
	LDA.w $1540,X				;$02C72B	|
	BNE Return02C73C			;$02C72E	|
	JSR CODE_02C628				;$02C730	|
	LDA.b #$01				;$02C733	|
	STA $C2,X				;$02C735	|
	LDA.b #$40				;$02C737	|
	STA.w $1540,X				;$02C739	|
Return02C73C:
	RTS

DATA_02C73D:
	db $0A,$0B,$0A,$0C,$0D,$0C

DATA_02C743:
	db $0C,$10,$10,$04,$08,$10,$18

CODE_02C74A:
	LDY.w $1570,X
	LDA.w $1540,X				;$02C74D	|
	BNE CODE_02C760				;$02C750	|
	INC.w $1570,X				;$02C752	|
	INY					;$02C755	|
	CPY.b #$07				;$02C756	|
	BEQ CODE_02C777				;$02C758	|
	LDA.w DATA_02C743,Y			;$02C75A	|
	STA.w $1540,X				;$02C75D	|
CODE_02C760:
	LDA.w DATA_02C73D,Y
	STA.w $1602,X				;$02C763	|
	LDA.b #$02				;$02C766	|
	CPY.b #$05				;$02C768	|
	BNE CODE_02C773				;$02C76A	|
	LDA $14					;$02C76C	|
	LSR					;$02C76E	|
	NOP					;$02C76F	|
	AND.b #$02				;$02C770	|
	INC A					;$02C772	|
CODE_02C773:
	STA.w $151C,X
	RTS					;$02C776	|

CODE_02C777:
	LDA $9E,X
	CMP.b #$94				;$02C779	|
	BEQ CODE_02C794				;$02C77B	|
	CMP.b #$46				;$02C77D	|
	BNE CODE_02C785				;$02C77F	|
	LDA.b #$91				;$02C781	|
	STA $9E,X				;$02C783	|
CODE_02C785:
	LDA.b #$30
	STA.w $1540,X				;$02C787	|
	LDA.b #$02				;$02C78A	|
	STA $C2,X				;$02C78C	|
	INC.w $187B,X				;$02C78E	|
	JMP CODE_02C556				;$02C791	|

CODE_02C794:
	LDA.b #$0C
	STA $C2,X				;$02C796	|
	RTS					;$02C798	|

DATA_02C799:
	db $F0,$10

DATA_02C79B:
	db $20,$E0

CODE_02C79D:
	LDA.w $1564,X
	BNE Return02C80F			;$02C7A0	|
	JSL MarioSprInteract			;$02C7A2	|
	BCC Return02C80F			;$02C7A6	|
	LDA.w $1490				;$02C7A8	|
	BEQ CODE_02C7C4				;$02C7AB	|
	LDA.b #$D0				;$02C7AD	|
	STA $AA,X				;$02C7AF	|
CODE_02C7B1:
	STZ $B6,X
	LDA.b #$02				;$02C7B3	|
	STA.w $14C8,X				;$02C7B5	|
	LDA.b #$03				;$02C7B8	|
	STA.w $1DF9				;$02C7BA	|
	LDA.b #$03				;$02C7BD	|
	JSL GivePoints				;$02C7BF	|
	RTS					;$02C7C3	|

CODE_02C7C4:
	JSR CODE_02D50C
	LDA $0E					;$02C7C7	|
	CMP.b #$EC				;$02C7C9	|
	BPL CODE_02C810				;$02C7CB	|
	LDA.b #$05				;$02C7CD	|
	STA.w $1564,X				;$02C7CF	|
	LDA.b #$02				;$02C7D2	|
	STA.w $1DF9				;$02C7D4	|
	JSL DisplayContactGfx			;$02C7D7	|
	JSL BoostMarioSpeed			;$02C7DB	|
	STZ.w $163E,X				;$02C7DF	|
	LDA $C2,X				;$02C7E2	|
	CMP.b #$03				;$02C7E4	|
	BEQ Return02C80F			;$02C7E6	|
	INC.w $1528,X				;$02C7E8	|
	LDA.w $1528,X				;$02C7EB	|
	CMP.b #$03				;$02C7EE	|
	BCC CODE_02C7F6				;$02C7F0	|
	STZ $AA,X				;$02C7F2	|
	BRA CODE_02C7B1				;$02C7F4	|

CODE_02C7F6:
	LDA.b #$28
	STA.w $1DFC				;$02C7F8	|
	LDA.b #$03				;$02C7FB	|
	STA $C2,X				;$02C7FD	|
	LDA.b #$03				;$02C7FF	|
	STA.w $1540,X				;$02C801	|
	STZ.w $1570,X				;$02C804	|
	JSR CODE_02D4FA				;$02C807	|
	LDA.w DATA_02C79B,Y			;$02C80A	|
	STA $7B					;$02C80D	|
Return02C80F:
	RTS

CODE_02C810:
	LDA.w $187A
	BNE Return02C819			;$02C813	|
	JSL HurtMario				;$02C815	|
Return02C819:
	RTS

CODE_02C81A:
	JSR GetDrawInfo2
	JSR CODE_02C88C				;$02C81D	|
	JSR CODE_02CA27				;$02C820	|
	JSR CODE_02CA9D				;$02C823	|
	JSR CODE_02CBA1				;$02C826	|
	LDY.b #$FF				;$02C829	|
CODE_02C82B:
	LDA.b #$04
	JMP CODE_02B7A7				;$02C82D	|

DATA_02C830:
	db $F8,$F8,$F8,$00,$00,$FE,$00,$00
	db $FA,$00,$00,$00,$00,$00,$00,$FD
	db $FD,$F9,$F6,$F6,$F8,$FE,$FC,$FA
	db $F8,$FA

DATA_02C84A:
	db $F8,$F9,$F7,$F8,$FC,$F8,$F4,$F5
	db $F5,$FC,$FD,$00,$F9,$F5,$F8,$FA
	db $F6,$F6,$F4,$F4,$F8,$F6,$F6,$F8
	db $F8,$F5

DATA_02C864:
	db $08,$08,$08,$00,$00,$00,$08,$08
	db $08,$00,$08,$08,$00,$00,$00,$00
	db $00,$08,$10,$10,$0C,$0C,$0C,$0C
	db $0C,$0C

ChuckHeadTiles:
	db $06,$0A,$0E,$0A,$06,$4B,$4B

DATA_02C885:
	db $40,$40,$00,$00,$00,$00,$40

CODE_02C88C:
	STZ $07
	LDY.w $1602,X				;$02C88E	|
	STY $04					;$02C891	|
	CPY.b #$09				;$02C893	|
	CLC					;$02C895	|
	BNE CODE_02C8AB				;$02C896	|
	LDA.w $1540,X				;$02C898	|
	SEC					;$02C89B	|
	SBC.b #$20				;$02C89C	|
	BCC CODE_02C8AB				;$02C89E	|
	PHA					;$02C8A0	|
	LSR					;$02C8A1	|
	LSR					;$02C8A2	|
	LSR					;$02C8A3	|
	LSR					;$02C8A4	|
	LSR					;$02C8A5	|
	STA $07					;$02C8A6	|
	PLA					;$02C8A8	|
	LSR					;$02C8A9	|
	LSR					;$02C8AA	|
CODE_02C8AB:
	LDA $00
	ADC.b #$00				;$02C8AD	|
	STA $00					;$02C8AF	|
	LDA.w $151C,X				;$02C8B1	|
	STA $02					;$02C8B4	|
	LDA.w $157C,X				;$02C8B6	|
	STA $03					;$02C8B9	|
	LDA.w $15F6,X				;$02C8BB	|
	ORA $64					;$02C8BE	|
	STA $08					;$02C8C0	|
	LDA.w $15EA,X				;$02C8C2	|
	STA $05					;$02C8C5	|
	CLC					;$02C8C7	|
	ADC.w DATA_02C864,Y			;$02C8C8	|
	TAY					;$02C8CB	|
	LDX $04					;$02C8CC	|
	LDA.w DATA_02C830,X			;$02C8CE	|
	LDX $03					;$02C8D1	|
	BNE CODE_02C8D8				;$02C8D3	|
	EOR.b #$FF				;$02C8D5	|
	INC A					;$02C8D7	|
CODE_02C8D8:
	CLC
	ADC $00					;$02C8D9	|
	STA.w $0300,Y				;$02C8DB	|
	LDX $04					;$02C8DE	|
	LDA $01					;$02C8E0	|
	CLC					;$02C8E2	|
	ADC.w DATA_02C84A,X			;$02C8E3	|
	SEC					;$02C8E6	|
	SBC $07					;$02C8E7	|
	STA.w $0301,Y				;$02C8E9	|
	LDX $02					;$02C8EC	|
	LDA.w DATA_02C885,X			;$02C8EE	|
	ORA $08					;$02C8F1	|
	STA.w $0303,Y				;$02C8F3	|
	LDA.w ChuckHeadTiles,X			;$02C8F6	|
	STA.w $0302,Y				;$02C8F9	|
	TYA					;$02C8FC	|
	LSR					;$02C8FD	|
	LSR					;$02C8FE	|
	TAY					;$02C8FF	|
	LDA.b #$02				;$02C900	|
	STA.w $0460,Y				;$02C902	|
	LDX.w $15E9				;$02C905	|
	RTS					;$02C908	|

DATA_02C909:
	db $F8,$F8,$F8,$FC,$FC,$FC,$FC,$F8
	db $01,$FC,$FC,$FC,$FC,$FC,$FC,$FC
	db $FC,$F8,$F8,$F8,$F8,$08,$06,$F8
	db $F8,$01,$10,$10,$10,$04,$04,$04
	db $04,$08,$07,$04,$04,$04,$04,$04
	db $04,$04,$04,$10,$08,$08,$10,$00
	db $02,$10,$10,$07

DATA_02C93D:
	db $00,$00,$00,$04,$04,$04,$04,$08
	db $00,$04,$04,$04,$04,$04,$04,$04
	db $04,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$FC,$FC,$FC
	db $FC,$F8,$00,$FC,$FC,$FC,$FC,$FC
	db $FC,$FC,$FC,$00,$00,$00,$00,$00
	db $00,$00,$00,$00

DATA_02C971:
	db $06,$06,$06,$00,$00,$00,$00,$00
	db $F8,$00,$00,$00,$00,$00,$00,$00
	db $00,$03,$00,$00,$06,$F8,$F8,$00
	db $00,$F8

ChuckBody1:
	db $0D,$34,$35,$26,$2D,$28,$40,$42
	db $5D,$2D,$64,$64,$64,$64,$E7,$28
	db $82,$CB,$23,$20,$0D,$0C,$5D,$BD
	db $BD,$5D

ChuckBody2:
	db $4E,$0C,$22,$26,$2D,$29,$40,$42
	db $AE,$2D,$64,$64,$64,$64,$E8,$29
	db $83,$CC,$24,$21,$4E,$A0,$A0,$A2
	db $A4,$AE

DATA_02C9BF:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$40,$00,$00
	db $00,$00

DATA_02C9D9:
	db $00,$00,$00,$40,$40,$00,$40,$40
	db $00,$40,$40,$40,$40,$40,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00

DATA_02C9F3:
	db $00,$00,$00,$02,$02,$02,$02,$02
	db $00,$02,$02,$02,$02,$02,$02,$02
	db $02,$00,$02,$02,$00,$00,$00,$00
	db $00,$00

DATA_02CA0D:
	db $00,$00,$00,$04,$04,$04,$0C,$0C
	db $00,$08,$00,$00,$04,$04,$04,$04
	db $04,$00,$08,$08,$00,$00,$00,$00
	db $00,$00

CODE_02CA27:
	STZ $06
	LDA $04					;$02CA29	|
	LDY $03					;$02CA2B	|
	BNE CODE_02CA36				;$02CA2D	|
	CLC					;$02CA2F	|
	ADC.b #$1A				;$02CA30	|
	LDX.b #$40				;$02CA32	|
	STX $06					;$02CA34	|
CODE_02CA36:
	TAX
	LDY $04					;$02CA37	|
	LDA.w DATA_02CA0D,Y			;$02CA39	|
	CLC					;$02CA3C	|
	ADC $05					;$02CA3D	|
	TAY					;$02CA3F	|
	LDA $00					;$02CA40	|
	CLC					;$02CA42	|
	ADC.w DATA_02C909,X			;$02CA43	|
	STA.w $0300,Y				;$02CA46	|
	LDA $00					;$02CA49	|
	CLC					;$02CA4B	|
	ADC.w DATA_02C93D,X			;$02CA4C	|
	STA.w $0304,Y				;$02CA4F	|
	LDX $04					;$02CA52	|
	LDA $01					;$02CA54	|
	CLC					;$02CA56	|
	ADC.w DATA_02C971,X			;$02CA57	|
	STA.w $0301,Y				;$02CA5A	|
	LDA $01					;$02CA5D	|
	STA.w $0305,Y				;$02CA5F	|
	LDA.w ChuckBody1,X			;$02CA62	|
	STA.w $0302,Y				;$02CA65	|
	LDA.w ChuckBody2,X			;$02CA68	|
	STA.w $0306,Y				;$02CA6B	|
	LDA $08					;$02CA6E	|
	ORA $06					;$02CA70	|
	PHA					;$02CA72	|
	EOR.w DATA_02C9BF,X			;$02CA73	|
	STA.w $0303,Y				;$02CA76	|
	PLA					;$02CA79	|
	EOR.w DATA_02C9D9,X			;$02CA7A	|
	STA.w $0307,Y				;$02CA7D	|
	TYA					;$02CA80	|
	LSR					;$02CA81	|
	LSR					;$02CA82	|
	TAY					;$02CA83	|
	LDA.w DATA_02C9F3,X			;$02CA84	|
	STA.w $0460,Y				;$02CA87	|
	LDA.b #$02				;$02CA8A	|
	STA.w $0461,Y				;$02CA8C	|
	LDX.w $15E9				;$02CA8F	|
	RTS					;$02CA92	|

DATA_02CA93:
	db $FA,$00

DATA_02CA95:
	db $0E,$00

ClappinChuckTiles:
	db $0C,$44

DATA_02CA99:
	db $F8,$F0

DATA_02CA9B:
	db $00,$02

CODE_02CA9D:
	LDA $04
	CMP.b #$14				;$02CA9F	|
	BCC CODE_02CAA6				;$02CAA1	|
	JMP CODE_02CB53				;$02CAA3	|

CODE_02CAA6:
	CMP.b #$12
	BEQ CODE_02CAFC				;$02CAA8	|
	CMP.b #$13				;$02CAAA	|
	BEQ CODE_02CAFC				;$02CAAC	|
	SEC					;$02CAAE	|
	SBC.b #$06				;$02CAAF	|
	CMP.b #$02				;$02CAB1	|
	BCS Return02CAF9			;$02CAB3	|
	TAX					;$02CAB5	|
	LDY $05					;$02CAB6	|
	LDA $00					;$02CAB8	|
	CLC					;$02CABA	|
	ADC.w DATA_02CA93,X			;$02CABB	|
	STA.w $0300,Y				;$02CABE	|
	LDA $00					;$02CAC1	|
	CLC					;$02CAC3	|
	ADC.w DATA_02CA95,X			;$02CAC4	|
	STA.w $0304,Y				;$02CAC7	|
	LDA $01					;$02CACA	|
	CLC					;$02CACC	|
	ADC.w DATA_02CA99,X			;$02CACD	|
	STA.w $0301,Y				;$02CAD0	|
	STA.w $0305,Y				;$02CAD3	|
	LDA.w ClappinChuckTiles,X		;$02CAD6	|
	STA.w $0302,Y				;$02CAD9	|
	STA.w $0306,Y				;$02CADC	|
	LDA $08					;$02CADF	|
	STA.w $0303,Y				;$02CAE1	|
	ORA.b #$40				;$02CAE4	|
	STA.w $0307,Y				;$02CAE6	|
	TYA					;$02CAE9	|
	LSR					;$02CAEA	|
	LSR					;$02CAEB	|
	TAY					;$02CAEC	|
	LDA.w DATA_02CA9B,X			;$02CAED	|
	STA.w $0460,Y				;$02CAF0	|
	STA.w $0461,Y				;$02CAF3	|
	LDX.w $15E9				;$02CAF6	|
Return02CAF9:
	RTS

ChuckGfxProp:
	db $47,$07

CODE_02CAFC:
	LDY $05
	LDA.w $157C,X				;$02CAFE	|
	PHX					;$02CB01	|
	TAX					;$02CB02	|
	ASL					;$02CB03	|
	ASL					;$02CB04	|
	ASL					;$02CB05	|
	PHA					;$02CB06	|
	EOR.b #$08				;$02CB07	|
	CLC					;$02CB09	|
	ADC $00					;$02CB0A	|
	STA.w $0300,Y				;$02CB0C	|
	PLA					;$02CB0F	|
	CLC					;$02CB10	|
	ADC $00					;$02CB11	|
	STA.w $0304,Y				;$02CB13	|
	LDA.b #$1C				;$02CB16	|
	STA.w $0302,Y				;$02CB18	|
	INC A					;$02CB1B	|
	STA.w $0306,Y				;$02CB1C	|
	LDA $01					;$02CB1F	|
	SEC					;$02CB21	|
	SBC.b #$08				;$02CB22	|
	STA.w $0301,Y				;$02CB24	|
	STA.w $0305,Y				;$02CB27	|
	LDA.w ChuckGfxProp,X			;$02CB2A	|
CODE_02CB2D:
	ORA $64
	STA.w $0303,Y				;$02CB2F	|
	STA.w $0307,Y				;$02CB32	|
	TYA					;$02CB35	|
	LSR					;$02CB36	|
	LSR					;$02CB37	|
	TAX					;$02CB38	|
CODE_02CB39:
	STZ.w $0460,X
	STZ.w $0461,X				;$02CB3C	|
	PLX					;$02CB3F	|
	RTS					;$02CB40	|

DATA_02CB41:
	db $FA,$0A,$06,$00,$00,$01,$0E,$FE
	db $02,$00,$00,$09,$08,$F4,$F4,$00
	db $00,$F4

CODE_02CB53:
	PHX
	STA $02					;$02CB54	|
	LDY.w $157C,X				;$02CB56	|
	BNE CODE_02CB5E				;$02CB59	|
	CLC					;$02CB5B	|
	ADC.b #$06				;$02CB5C	|
CODE_02CB5E:
	TAX
	LDA $05					;$02CB5F	|
	CLC					;$02CB61	|
	ADC.b #$08				;$02CB62	|
	TAY					;$02CB64	|
	LDA $00					;$02CB65	|
	CLC					;$02CB67	|
	ADC.w CODE_02CB2D,X			;$02CB68	|
	STA.w $0300,Y				;$02CB6B	|
	LDX $02					;$02CB6E	|
	LDA.w CODE_02CB39,X			;$02CB70	|
	BEQ CODE_02CB8E				;$02CB73	|
	CLC					;$02CB75	|
	ADC $01					;$02CB76	|
	STA.w $0301,Y				;$02CB78	|
	LDA.b #$AD				;$02CB7B	|
	STA.w $0302,Y				;$02CB7D	|
	LDA.b #$09				;$02CB80	|
	ORA $64					;$02CB82	|
	STA.w $0303,Y				;$02CB84	|
	TYA					;$02CB87	|
	LSR					;$02CB88	|
	LSR					;$02CB89	|
	TAX					;$02CB8A	|
	STZ.w $0460,X				;$02CB8B	|
CODE_02CB8E:
	PLX
	RTS					;$02CB8F	|

DigChuckTileDispX:
	db $FC,$04,$10,$F0,$12,$EE

DigChuckTileProp:
	db $47,$07

DigChuckTileDispY:
	db $F8,$00,$F8

DigChuckTiles:
	db $CA,$E2,$A0

DigChuckTileSize:
	db $00,$02,$02

CODE_02CBA1:
	LDA $9E,X
	CMP.b #$46				;$02CBA3	|
	BNE Return02CBFB			;$02CBA5	|
	LDA.w $1602,X				;$02CBA7	|
	CMP.b #$05				;$02CBAA	|
	BNE CODE_02CBB2				;$02CBAC	|
	LDA.b #$01				;$02CBAE	|
	BRA CODE_02CBB9				;$02CBB0	|

CODE_02CBB2:
	CMP.b #$0E
	BCC Return02CBFB			;$02CBB4	|
	SEC					;$02CBB6	|
	SBC.b #$0E				;$02CBB7	|
CODE_02CBB9:
	STA $02
	LDA.w $15EA,X				;$02CBBB	|
	CLC					;$02CBBE	|
	ADC.b #$0C				;$02CBBF	|
	TAY					;$02CBC1	|
	PHX					;$02CBC2	|
	LDA $02					;$02CBC3	|
	ASL					;$02CBC5	|
	ORA.w $157C,X				;$02CBC6	|
	TAX					;$02CBC9	|
	LDA $00					;$02CBCA	|
	CLC					;$02CBCC	|
	ADC.w DigChuckTileDispX,X		;$02CBCD	|
	STA.w $0300,Y				;$02CBD0	|
	TXA					;$02CBD3	|
	AND.b #$01				;$02CBD4	|
	TAX					;$02CBD6	|
	LDA.w DigChuckTileProp,X		;$02CBD7	|
	ORA $64					;$02CBDA	|
	STA.w $0303,Y				;$02CBDC	|
	LDX $02					;$02CBDF	|
	LDA $01					;$02CBE1	|
	CLC					;$02CBE3	|
	ADC.w DigChuckTileDispY,X		;$02CBE4	|
	STA.w $0301,Y				;$02CBE7	|
	LDA.w DigChuckTiles,X			;$02CBEA	|
	STA.w $0302,Y				;$02CBED	|
	TYA					;$02CBF0	|
	LSR					;$02CBF1	|
	LSR					;$02CBF2	|
	TAY					;$02CBF3	|
	LDA.w DigChuckTileSize,X		;$02CBF4	|
	STA.w $0460,Y				;$02CBF7	|
	PLX					;$02CBFA	|
Return02CBFB:
	RTS

	RTS					;$02CBFC	|

Return02CBFD:
	RTL

WingedCageMain:
	LDA $9D
	BNE ADDR_02CC05				;$02CC00	|
	INC.w $1570,X				;$02CC02	|
ADDR_02CC05:
	JSR ADDR_02CCB9
	PHX					;$02CC08	|
	JSL ADDR_00FF32				;$02CC09	|
	PLX					;$02CC0D	|
	LDA $E4,X				;$02CC0E	|
	CLC					;$02CC10	|
	ADC.w $17BD				;$02CC11	|
	STA $E4,X				;$02CC14	|
	LDA.w $14E0,X				;$02CC16	|
	ADC.b #$00				;$02CC19	|
	STA.w $14E0,X				;$02CC1B	|
	LDA $71					;$02CC1E	|
	CMP.b #$01				;$02CC20	|
	BCS Return02CBFD			;$02CC22	|
	LDA.w $18B5				;$02CC24	|
	BEQ ADDR_02CC2D				;$02CC27	|
	JSL ADDR_00FF07				;$02CC29	|
ADDR_02CC2D:
	LDY.b #$00
	LDA.w $17BC				;$02CC2F	|
	BPL ADDR_02CC35				;$02CC32	|
	DEY					;$02CC34	|
ADDR_02CC35:
	CLC
	ADC $D8,X				;$02CC36	|
	STA $D8,X				;$02CC38	|
	TYA					;$02CC3A	|
	ADC.w $14D4,X				;$02CC3B	|
	STA.w $14D4,X				;$02CC3E	|
	LDA $E4,X				;$02CC41	|
	STA $00					;$02CC43	|
	LDA.w $14E0,X				;$02CC45	|
	STA $01					;$02CC48	|
	LDA $D8,X				;$02CC4A	|
	STA $02					;$02CC4C	|
	LDA.w $14D4,X				;$02CC4E	|
	STA $03					;$02CC51	|
	REP #$20				;$02CC53	|
	LDA $00					;$02CC55	|
	LDY $7B					;$02CC57	|
	DEY					;$02CC59	|
	BPL ADDR_02CC6C				;$02CC5A	|
	CLC					;$02CC5C	|
	ADC.w #$0000				;$02CC5D	|
	CMP $94					;$02CC60	|
	BCC ADDR_02CC7F				;$02CC62	|
	STA $94					;$02CC64	|
	LDY.b #$00				;$02CC66	|
	STY $7B					;$02CC68	|
	BRA ADDR_02CC7F				;$02CC6A	|

ADDR_02CC6C:
	CLC
	ADC.w #$0090				;$02CC6D	|
	CMP $94					;$02CC70	|
	BCS ADDR_02CC7F				;$02CC72	|
	LDA $00					;$02CC74	|
	ADC.w #$0091				;$02CC76	|
	STA $94					;$02CC79	|
	LDY.b #$00				;$02CC7B	|
	STY $7B					;$02CC7D	|
ADDR_02CC7F:
	LDA $02
	LDY $7D					;$02CC81	|
	BPL ADDR_02CC93				;$02CC83	|
	CLC					;$02CC85	|
	ADC.w #$0020				;$02CC86	|
	CMP $96					;$02CC89	|
	BCC ADDR_02CCAE				;$02CC8B	|
	LDY.b #$00				;$02CC8D	|
	STY $7D					;$02CC8F	|
	BRA ADDR_02CCAE				;$02CC91	|

ADDR_02CC93:
	CLC
	ADC.w #$0060				;$02CC94	|
	CMP $96					;$02CC97	|
	BCS ADDR_02CCAE				;$02CC99	|
	LDA $02					;$02CC9B	|
	ADC.w #$0061				;$02CC9D	|
	STA $96					;$02CCA0	|
	LDY.b #$00				;$02CCA2	|
	STY $7D					;$02CCA4	|
	LDY.b #$01				;$02CCA6	|
	STY.w $1471				;$02CCA8	|
	STY.w $18B5				;$02CCAB	|
ADDR_02CCAE:
	SEP #$20
	RTL					;$02CCB0	|

CageWingTileDispX:
	db $00,$30,$60,$90

CageWingTileDispY:
	db $F8,$00,$F8,$00

ADDR_02CCB9:
	LDA.b #$03
	STA $08					;$02CCBB	|
	LDA $E4,X				;$02CCBD	|
	SEC					;$02CCBF	|
	SBC $1A					;$02CCC0	|
	STA $00					;$02CCC2	|
	LDA $D8,X				;$02CCC4	|
	SEC					;$02CCC6	|
	SBC $1C					;$02CCC7	|
	STA $01					;$02CCC9	|
	LDY.w $15EA,X				;$02CCCB	|
	STY $02					;$02CCCE	|
ADDR_02CCD0:
	LDY $02
	LDX $08					;$02CCD2	|
	LDA $00					;$02CCD4	|
	CLC					;$02CCD6	|
	ADC.w CageWingTileDispX,X		;$02CCD7	|
	STA.w $0300,Y				;$02CCDA	|
	STA.w $0304,Y				;$02CCDD	|
	LDA $01					;$02CCE0	|
	CLC					;$02CCE2	|
	ADC.w CageWingTileDispY,X		;$02CCE3	|
	STA.w $0301,Y				;$02CCE6	|
	CLC					;$02CCE9	|
	ADC.b #$08				;$02CCEA	|
	STA.w $0305,Y				;$02CCEC	|
	LDX.w $15E9				;$02CCEF	|
	LDA.w $1570,X				;$02CCF2	|
	LSR					;$02CCF5	|
	LSR					;$02CCF6	|
	LSR					;$02CCF7	|
	EOR $08					;$02CCF8	|
	LSR					;$02CCFA	|
	LDA.b #$C6				;$02CCFB	|
	BCC ADDR_02CD01				;$02CCFD	|
	LDA.b #$81				;$02CCFF	|
ADDR_02CD01:
	STA.w $0302,Y
	LDA.b #$D6				;$02CD04	|
	BCC ADDR_02CD0A				;$02CD06	|
	LDA.b #$D7				;$02CD08	|
ADDR_02CD0A:
	STA.w $0306,Y
	LDA.b #$70				;$02CD0D	|
	STA.w $0303,Y				;$02CD0F	|
	STA.w $0307,Y				;$02CD12	|
	TYA					;$02CD15	|
	LSR					;$02CD16	|
	LSR					;$02CD17	|
	TAY					;$02CD18	|
	LDA.b #$00				;$02CD19	|
	STA.w $0460,Y				;$02CD1B	|
	STA.w $0461,Y				;$02CD1E	|
	LDA $02					;$02CD21	|
	CLC					;$02CD23	|
	ADC.b #$08				;$02CD24	|
	STA $02					;$02CD26	|
	DEC $08					;$02CD28	|
	BPL ADDR_02CCD0				;$02CD2A	|
	RTS					;$02CD2C	|

CODE_02CD2D:
	PHB
	PHK					;$02CD2E	|
	PLB					;$02CD2F	|
	JSR CODE_02CD59				;$02CD30	|
	PLB					;$02CD33	|
	RTL					;$02CD34	|

DATA_02CD35:
	db $00,$08,$10,$18,$00,$08,$10,$18
DATA_02CD3D:
	db $00,$00,$00,$00,$08,$08,$08,$08
DATA_02CD45:
	db $00,$01,$01,$00,$10,$11,$11,$10
DATA_02CD4D:
	db $31,$31,$71,$71,$31,$31,$71,$71
DATA_02CD55:
	db $0A,$04,$06,$08

CODE_02CD59:
	LDA.w $1540,X
	CMP.b #$5E				;$02CD5C	|
	BNE CODE_02CD7F				;$02CD5E	|
	LDA.b #$1B				;$02CD60	|
	STA $9C					;$02CD62	|
	LDA $E4,X				;$02CD64	|
	STA $9A					;$02CD66	|
	LDA.w $14E0,X				;$02CD68	|
	STA $9B					;$02CD6B	|
	LDA $D8,X				;$02CD6D	|
	SEC					;$02CD6F	|
	SBC.b #$10				;$02CD70	|
	STA $98					;$02CD72	|
	LDA.w $14D4,X				;$02CD74	|
	SBC.b #$00				;$02CD77	|
	STA $99					;$02CD79	|
	JSL generate_tile			;$02CD7B	|
CODE_02CD7F:
	JSL InvisBlkMainRt
	JSR GetDrawInfo2			;$02CD83	|
	PHX					;$02CD86	|
	LDX.w $191E				;$02CD87	|
	LDA.w DATA_02CD55,X			;$02CD8A	|
	STA $02					;$02CD8D	|
	LDX.b #$07				;$02CD8F	|
CODE_02CD91:
	LDA $00
	CLC					;$02CD93	|
	ADC.w DATA_02CD35,X			;$02CD94	|
	STA.w $0300,Y				;$02CD97	|
	LDA $01					;$02CD9A	|
	CLC					;$02CD9C	|
	ADC.w DATA_02CD3D,X			;$02CD9D	|
	STA.w $0301,Y				;$02CDA0	|
	LDA.w DATA_02CD45,X			;$02CDA3	|
	STA.w $0302,Y				;$02CDA6	|
	LDA.w DATA_02CD4D,X			;$02CDA9	|
	CPX.b #$04				;$02CDAC	|
	BCS CODE_02CDB2				;$02CDAE	|
	ORA $02					;$02CDB0	|
CODE_02CDB2:
	STA.w $0303,Y
	INY					;$02CDB5	|
	INY					;$02CDB6	|
	INY					;$02CDB7	|
	INY					;$02CDB8	|
	DEX					;$02CDB9	|
	BPL CODE_02CD91				;$02CDBA	|
	PLX					;$02CDBC	|
	LDY.b #$00				;$02CDBD	|
	LDA.b #$07				;$02CDBF	|
	JMP CODE_02B7A7				;$02CDC1	|

	RTS					;$02CDC4	|

DATA_02CDC5:
	db $00,$07,$F9,$00,$01,$FF

PeaBouncerMain:
	JSR SubOffscreen0Bnk2
	JSR CODE_02CEE0				;$02CDCE	|
	LDA $9D					;$02CDD1	|
	BNE Return02CDFE			;$02CDD3	|
	LDA.w $1534,X				;$02CDD5	|
	BEQ CODE_02CDF1				;$02CDD8	|
	DEC.w $1534,X				;$02CDDA	|
	BIT $15					;$02CDDD	|
	BPL CODE_02CDF1				;$02CDDF	|
	STZ.w $1534,X				;$02CDE1	|
	LDY.w $151C,X				;$02CDE4	|
	LDA.w DATA_02CDFF,Y			;$02CDE7	|
	STA $7D					;$02CDEA	|
	LDA.b #$08				;$02CDEC	|
	STA.w $1DFC				;$02CDEE	|
CODE_02CDF1:
	LDA.w $1528,X
	JSL execute_pointer			;$02CDF4	|

PeaBouncerPtrs:
	dw Return02CDFE
	dw CODE_02CE0F
	dw CODE_02CE3A

Return02CDFE:
	RTL

DATA_02CDFF:
	db $B6,$B4,$B0,$A8,$A0,$98,$90,$88
DATA_02CE07:
	db $00,$00,$E8,$E0,$D0,$C8,$C0,$B8

CODE_02CE0F:
	LDA.w $1540,X
	BEQ CODE_02CE20				;$02CE12	|
	DEC A					;$02CE14	|
	BNE Return02CE1F			;$02CE15	|
	INC.w $1528,X				;$02CE17	|
	LDA.b #$01				;$02CE1A	|
	STA.w $157C,X				;$02CE1C	|
Return02CE1F:
	RTL

CODE_02CE20:
	LDA $C2,X
	BMI CODE_02CE29				;$02CE22	|
	CMP.w $151C,X				;$02CE24	|
	BCS CODE_02CE2F				;$02CE27	|
CODE_02CE29:
	CLC
	ADC.b #$01				;$02CE2A	|
	STA $C2,X				;$02CE2C	|
	RTL					;$02CE2E	|

CODE_02CE2F:
	LDA.w $151C,X
	STA $C2,X				;$02CE32	|
	LDA.b #$08				;$02CE34	|
	STA.w $1540,X				;$02CE36	|
	RTL					;$02CE39	|

CODE_02CE3A:
	INC.w $1570,X
	LDA.w $1570,X				;$02CE3D	|
	AND.b #$03				;$02CE40	|
	BNE CODE_02CE49				;$02CE42	|
	DEC.w $151C,X				;$02CE44	|
	BEQ CODE_02CE86				;$02CE47	|
CODE_02CE49:
	LDA.w $151C,X
	EOR.b #$FF				;$02CE4C	|
	INC A					;$02CE4E	|
	STA $00					;$02CE4F	|
	LDA.w $157C,X				;$02CE51	|
	AND.b #$01				;$02CE54	|
	BNE CODE_02CE70				;$02CE56	|
	LDA $C2,X				;$02CE58	|
	CLC					;$02CE5A	|
	ADC.b #$04				;$02CE5B	|
	STA $C2,X				;$02CE5D	|
	BMI Return02CE66			;$02CE5F	|
	CMP.w $151C,X				;$02CE61	|
	BCS CODE_02CE67				;$02CE64	|
Return02CE66:
	RTL

CODE_02CE67:
	LDA.w $151C,X
	STA $C2,X				;$02CE6A	|
	INC.w $157C,X				;$02CE6C	|
	RTL					;$02CE6F	|

CODE_02CE70:
	LDA $C2,X
	SEC					;$02CE72	|
	SBC.b #$04				;$02CE73	|
	STA $C2,X				;$02CE75	|
	BPL Return02CE7D			;$02CE77	|
	CMP $00					;$02CE79	|
	BCC CODE_02CE7E				;$02CE7B	|
Return02CE7D:
	RTL

CODE_02CE7E:
	LDA $00
	STA $C2,X				;$02CE80	|
	INC.w $157C,X				;$02CE82	|
	RTL					;$02CE85	|

CODE_02CE86:
	STZ $C2,X
	STZ.w $1528,X				;$02CE88	|
	RTL					;$02CE8B	|

	JSR CODE_02CEE0				;$02CE8C	|
	RTL					;$02CE8F	|

DATA_02CE90:
	db $00,$08,$10,$18,$20,$00,$08,$10
	db $18,$20,$00,$08,$10,$18,$20,$00
	db $08,$10,$18,$1F,$00,$08,$10,$17
	db $1E,$00,$08,$0F,$16,$1D,$00,$07
	db $0F,$16,$1C,$00,$07,$0E,$15,$1B
DATA_02CEB8:
	db $00,$00,$00,$00,$00,$00,$01,$01
	db $01,$02,$00,$00,$01,$02,$04,$00
	db $01,$02,$04,$06,$00,$01,$03,$06
	db $08,$00,$02,$04,$08,$0A,$00,$02
	db $05,$07,$0C,$00,$02,$05,$09,$0E

CODE_02CEE0:
	JSR GetDrawInfo2
	LDA.b #$04				;$02CEE3	|
	STA $02					;$02CEE5	|
	LDA $9E,X				;$02CEE7	|
	SEC					;$02CEE9	|
	SBC.b #$6B				;$02CEEA	|
	STA $05					;$02CEEC	|
	LDA $C2,X				;$02CEEE	|
	STA $03					;$02CEF0	|
	BPL CODE_02CEF7				;$02CEF2	|
	EOR.b #$FF				;$02CEF4	|
	INC A					;$02CEF6	|
CODE_02CEF7:
	STA $04
	LDY.w $15EA,X				;$02CEF9	|
CODE_02CEFC:
	LDA $04
	ASL					;$02CEFE	|
	ASL					;$02CEFF	|
	ADC $04					;$02CF00	|
	ADC $02					;$02CF02	|
	TAX					;$02CF04	|
	LDA $05					;$02CF05	|
	LSR					;$02CF07	|
	LDA.w DATA_02CE90,X			;$02CF08	|
	BCC CODE_02CF10				;$02CF0B	|
	EOR.b #$FF				;$02CF0D	|
	INC A					;$02CF0F	|
CODE_02CF10:
	STA $08
	CLC					;$02CF12	|
	ADC $00					;$02CF13	|
	STA.w $0300,Y				;$02CF15	|
	LDA $03					;$02CF18	|
	ASL					;$02CF1A	|
	LDA.w DATA_02CEB8,X			;$02CF1B	|
	BCC CODE_02CF23				;$02CF1E	|
	EOR.b #$FF				;$02CF20	|
	INC A					;$02CF22	|
CODE_02CF23:
	STA $09
	CLC					;$02CF25	|
	ADC $01					;$02CF26	|
	STA.w $0301,Y				;$02CF28	|
	LDA.b #$3D				;$02CF2B	|
	STA.w $0302,Y				;$02CF2D	|
	LDA $64					;$02CF30	|
	ORA.b #$0A				;$02CF32	|
	STA.w $0303,Y				;$02CF34	|
	LDX.w $15E9				;$02CF37	|
	PHY					;$02CF3A	|
	JSR CODE_02CF52				;$02CF3B	|
	PLY					;$02CF3E	|
	INY					;$02CF3F	|
	INY					;$02CF40	|
	INY					;$02CF41	|
	INY					;$02CF42	|
	DEC $02					;$02CF43	|
	BMI CODE_02CF4A				;$02CF45	|
	JMP CODE_02CEFC				;$02CF47	|

CODE_02CF4A:
	LDY.b #$00
	LDA.b #$04				;$02CF4C	|
	JMP CODE_02B7A7				;$02CF4E	|

Return02CF51:
	RTS

CODE_02CF52:
	LDA $71
	CMP.b #$01				;$02CF54	|
	BCS Return02CF51			;$02CF56	|
	LDA $81					;$02CF58	|
	ORA $7F					;$02CF5A	|
	ORA.w $15A0,X				;$02CF5C	|
	ORA.w $186C,X				;$02CF5F	|
	BNE Return02CF51			;$02CF62	|
	LDA $7E					;$02CF64	|
	CLC					;$02CF66	|
	ADC.b #$02				;$02CF67	|
	STA $0A					;$02CF69	|
	LDA.w $187A				;$02CF6B	|
	CMP.b #$01				;$02CF6E	|
	LDA.b #$10				;$02CF70	|
	BCC CODE_02CF76				;$02CF72	|
	LDA.b #$20				;$02CF74	|
CODE_02CF76:
	CLC
	ADC $80					;$02CF77	|
	STA $0B					;$02CF79	|
	LDA.w $0300,Y				;$02CF7B	|
	SEC					;$02CF7E	|
	SBC $0A					;$02CF7F	|
	CLC					;$02CF81	|
	ADC.b #$08				;$02CF82	|
	CMP.b #$14				;$02CF84	|
	BCS Return02CFFD			;$02CF86	|
	LDA $19					;$02CF88	|
	CMP.b #$01				;$02CF8A	|
	LDA.b #$1A				;$02CF8C	|
	BCS CODE_02CF92				;$02CF8E	|
	LDA.b #$1C				;$02CF90	|
CODE_02CF92:
	STA $0F
	LDA.w $0301,Y				;$02CF94	|
	SEC					;$02CF97	|
	SBC $0B					;$02CF98	|
	CLC					;$02CF9A	|
	ADC.b #$08				;$02CF9B	|
	CMP $0F					;$02CF9D	|
	BCS Return02CFFD			;$02CF9F	|
	LDA $7D					;$02CFA1	|
	BMI Return02CFFD			;$02CFA3	|
	LDA.b #$1F				;$02CFA5	|
	PHX					;$02CFA7	|
	LDX.w $187A				;$02CFA8	|
	BEQ CODE_02CFAF				;$02CFAB	|
	LDA.b #$2F				;$02CFAD	|
CODE_02CFAF:
	STA $0F
	PLX					;$02CFB1	|
	LDA.w $0301,Y				;$02CFB2	|
	SEC					;$02CFB5	|
	SBC $0F					;$02CFB6	|
	PHP					;$02CFB8	|
	CLC					;$02CFB9	|
	ADC $1C					;$02CFBA	|
	STA $96					;$02CFBC	|
	LDA $1D					;$02CFBE	|
	ADC.b #$00				;$02CFC0	|
	PLP					;$02CFC2	|
	SBC.b #$00				;$02CFC3	|
	STA $97					;$02CFC5	|
	STZ $72					;$02CFC7	|
	LDA.b #$02				;$02CFC9	|
	STA.w $1471				;$02CFCB	|
	LDA.w $1528,X				;$02CFCE	|
	BEQ CODE_02CFEB				;$02CFD1	|
	CMP.b #$02				;$02CFD3	|
	BEQ CODE_02CFEB				;$02CFD5	|
	LDA.w $1540,X				;$02CFD7	|
	CMP.b #$01				;$02CFDA	|
	BNE Return02CFEA			;$02CFDC	|
	LDA.b #$08				;$02CFDE	|
	STA.w $1534,X				;$02CFE0	|
	LDY $C2,X				;$02CFE3	|
	LDA.w DATA_02CE07,Y			;$02CFE5	|
	STA $7D					;$02CFE8	|
Return02CFEA:
	RTS

CODE_02CFEB:
	STZ $7B
	LDY $02					;$02CFED	|
	LDA.w PeaBouncerPhysics,Y		;$02CFEF	|
	STA.w $151C,X				;$02CFF2	|
	LDA.b #$01				;$02CFF5	|
	STA.w $1528,X				;$02CFF7	|
	STZ.w $1570,X				;$02CFFA	|
Return02CFFD:
	RTS

PeaBouncerPhysics:
	db $01,$01,$03,$05,$07

DATA_02D003:
	db $40,$B0

DATA_02D005:
	db $01,$FF

DATA_02D007:
	db $30,$C0,$A0,$C0,$A0,$70,$60,$B0
DATA_02D00F:
	db $01,$FF,$01,$FF,$01,$FF,$01,$FF

SubOffscreen3Bnk2:
	LDA.b #$06
	BRA CODE_02D021				;$02D019	|

SubOffscreen2Bnk2:
	LDA.b #$04
	BRA CODE_02D021				;$02D01D	|

SubOffscreen1Bnk2:
	LDA.b #$02
CODE_02D021:
	STA $03
	BRA CODE_02D027				;$02D023	|

SubOffscreen0Bnk2:
	STZ $03
CODE_02D027:
	JSR IsSprOffScreenBnk2
	BEQ Return02D090			;$02D02A	|
	LDA $5B					;$02D02C	|
	AND.b #$01				;$02D02E	|
	BNE VerticalLevelBnk2			;$02D030	|
	LDA $03					;$02D032	|
	CMP.b #$04				;$02D034	|
	BEQ CODE_02D04D				;$02D036	|
	LDA $D8,X				;$02D038	|
	CLC					;$02D03A	|
	ADC.b #$50				;$02D03B	|
	LDA.w $14D4,X				;$02D03D	|
	ADC.b #$00				;$02D040	|
	CMP.b #$02				;$02D042	|
	BPL OffScrEraseSprBnk2			;$02D044	|
	LDA.w $167A,X				;$02D046	|
	AND.b #$04				;$02D049	|
	BNE Return02D090			;$02D04B	|
CODE_02D04D:
	LDA $13
	AND.b #$01				;$02D04F	|
	ORA $03					;$02D051	|
	STA $01					;$02D053	|
	TAY					;$02D055	|
	LDA $1A					;$02D056	|
	CLC					;$02D058	|
	ADC.w DATA_02D007,Y			;$02D059	|
	ROL $00					;$02D05C	|
	CMP $E4,X				;$02D05E	|
	PHP					;$02D060	|
	LDA $1B					;$02D061	|
	LSR $00					;$02D063	|
	ADC.w DATA_02D00F,Y			;$02D065	|
	PLP					;$02D068	|
	SBC.w $14E0,X				;$02D069	|
	STA $00					;$02D06C	|
	LSR $01					;$02D06E	|
	BCC CODE_02D076				;$02D070	|
	EOR.b #$80				;$02D072	|
	STA $00					;$02D074	|
CODE_02D076:
	LDA $00
	BPL Return02D090			;$02D078	|
OffScrEraseSprBnk2:
	LDA.w $14C8,X
	CMP.b #$08				;$02D07D	|
	BCC OffScrKillSprBnk2			;$02D07F	|
	LDY.w $161A,X				;$02D081	|
	CPY.b #$FF				;$02D084	|
	BEQ OffScrKillSprBnk2			;$02D086	|
	LDA.b #$00				;$02D088	|
	STA.w $1938,Y				;$02D08A	|
OffScrKillSprBnk2:
	STZ.w $14C8,X
Return02D090:
	RTS

VerticalLevelBnk2:
	LDA.w $167A,X
	AND.b #$04				;$02D094	|
	BNE Return02D090			;$02D096	|
	LDA $13					;$02D098	|
	LSR					;$02D09A	|
	BCS Return02D090			;$02D09B	|
	AND.b #$01				;$02D09D	|
	STA $01					;$02D09F	|
	TAY					;$02D0A1	|
	LDA $1C					;$02D0A2	|
	CLC					;$02D0A4	|
	ADC.w DATA_02D003,Y			;$02D0A5	|
	ROL $00					;$02D0A8	|
	CMP $D8,X				;$02D0AA	|
	PHP					;$02D0AC	|
	LDA.w $1D				;$02D0AD	|
	LSR $00					;$02D0B0	|
	ADC.w DATA_02D005,Y			;$02D0B2	|
	PLP					;$02D0B5	|
	SBC.w $14D4,X				;$02D0B6	|
	STA $00					;$02D0B9	|
	LDY $01					;$02D0BB	|
	BEQ CODE_02D0C3				;$02D0BD	|
	EOR.b #$80				;$02D0BF	|
	STA $00					;$02D0C1	|
CODE_02D0C3:
	LDA $00
	BPL Return02D090			;$02D0C5	|
	BMI OffScrEraseSprBnk2			;$02D0C7	|
IsSprOffScreenBnk2:
	LDA.w $15A0,X
	ORA.w $186C,X				;$02D0CC	|
	RTS					;$02D0CF	|

DATA_02D0D0:
	db $14,$FC

DATA_02D0D2:
	db $00,$FF

CODE_02D0D4:
	LDA.w $1564,X
	BNE Return02D0E5			;$02D0D7	|
	LDA.w $160E,X				;$02D0D9	|
	BPL Return02D0E5			;$02D0DC	|
	PHB					;$02D0DE	|
	PHK					;$02D0DF	|
	PLB					;$02D0E0	|
	JSR CODE_02D0E6				;$02D0E1	|
	PLB					;$02D0E4	|
Return02D0E5:
	RTL

CODE_02D0E6:
	STZ $0F
	BRA CODE_02D149				;$02D0E8	|

	LDA $D8,X				;$02D0EA	|
	CLC					;$02D0EC	|
	ADC.b #$08				;$02D0ED	|
	AND.b #$F0				;$02D0EF	|
	STA $00					;$02D0F1	|
	LDA.w $14D4,X				;$02D0F3	|
	ADC.b #$00				;$02D0F6	|
	CMP $5D					;$02D0F8	|
	BCS Return02D148			;$02D0FA	|
	STA $03					;$02D0FC	|
	AND.b #$10				;$02D0FE	|
	STA $08					;$02D100	|
	LDY.w $157C,X				;$02D102	|
	LDA $E4,X				;$02D105	|
	CLC					;$02D107	|
	ADC.w DATA_02D0D0,Y			;$02D108	|
	STA $01					;$02D10B	|
	LDA.w $14E0,X				;$02D10D	|
	ADC.w DATA_02D0D2,Y			;$02D110	|
	CMP.b #$02				;$02D113	|
	BCS Return02D148			;$02D115	|
	STA $02					;$02D117	|
	LDA $01					;$02D119	|
	LSR					;$02D11B	|
	LSR					;$02D11C	|
	LSR					;$02D11D	|
	LSR					;$02D11E	|
	ORA $00					;$02D11F	|
	STA $00					;$02D121	|
	LDX $03					;$02D123	|
	LDA.l DATA_00BA80,X			;$02D125	|
	LDY $0F					;$02D129	|
	BEQ ADDR_02D131				;$02D12B	|
	LDA.l DATA_00BA8E,X			;$02D12D	|
ADDR_02D131:
	CLC
	ADC $00					;$02D132	|
	STA $05					;$02D134	|
	LDA.l DATA_00BABC,X			;$02D136	|
	LDY $0F					;$02D13A	|
	BEQ ADDR_02D142				;$02D13C	|
	LDA.l DATA_00BACA,X			;$02D13E	|
ADDR_02D142:
	ADC $02
	STA $06					;$02D144	|
	BRA CODE_02D1AD				;$02D146	|

Return02D148:
	RTS

CODE_02D149:
	LDA $D8,X
	CLC					;$02D14B	|
	ADC.b #$08				;$02D14C	|
	STA.w $18B2				;$02D14E	|
	AND.b #$F0				;$02D151	|
	STA $00					;$02D153	|
	LDA.w $14D4,X				;$02D155	|
	ADC.b #$00				;$02D158	|
	CMP.b #$02				;$02D15A	|
	BCS Return02D148			;$02D15C	|
	STA $02					;$02D15E	|
	STA.w $18B3				;$02D160	|
	LDY.w $157C,X				;$02D163	|
	LDA $E4,X				;$02D166	|
	CLC					;$02D168	|
	ADC.w DATA_02D0D0,Y			;$02D169	|
	STA $01					;$02D16C	|
	STA.w $18B0				;$02D16E	|
	LDA.w $14E0,X				;$02D171	|
	ADC.w DATA_02D0D2,Y			;$02D174	|
	CMP $5D					;$02D177	|
	BCS Return02D148			;$02D179	|
	STA.w $18B1				;$02D17B	|
	STA $03					;$02D17E	|
	LDA $01					;$02D180	|
	LSR					;$02D182	|
	LSR					;$02D183	|
	LSR					;$02D184	|
	LSR					;$02D185	|
	ORA $00					;$02D186	|
	STA $00					;$02D188	|
	LDX $03					;$02D18A	|
	LDA.l DATA_00BA60,X			;$02D18C	|
	LDY $0F					;$02D190	|
	BEQ CODE_02D198				;$02D192	|
	LDA.l DATA_00BA70,X			;$02D194	|
CODE_02D198:
	CLC
	ADC $00					;$02D199	|
	STA $05					;$02D19B	|
	LDA.l DATA_00BA9C,X			;$02D19D	|
	LDY $0F					;$02D1A1	|
	BEQ CODE_02D1A9				;$02D1A3	|
	LDA.l DATA_00BAAC,X			;$02D1A5	|
CODE_02D1A9:
	ADC $02
	STA $06					;$02D1AB	|
CODE_02D1AD:
	LDA.b #$7E
	STA $07					;$02D1AF	|
	LDX.w $15E9				;$02D1B1	|
	LDA [$05]				;$02D1B4	|
	STA.w $1693				;$02D1B6	|
	INC $07					;$02D1B9	|
	LDA [$05]				;$02D1BB	|
	BNE Return02D1F0			;$02D1BD	|
	LDA.w $1693				;$02D1BF	|
	CMP.b #$45				;$02D1C2	|
	BCC Return02D1F0			;$02D1C4	|
	CMP.b #$48				;$02D1C6	|
	BCS Return02D1F0			;$02D1C8	|
	SEC					;$02D1CA	|
	SBC.b #$44				;$02D1CB	|
	STA.w $18D6				;$02D1CD	|
	STZ.w $14A3				;$02D1D0	|
	LDY.w $18DC				;$02D1D3	|
	LDA.w DATA_02D1F1,Y			;$02D1D6	|
	STA.w $1602,X				;$02D1D9	|
	LDA.b #$22				;$02D1DC	|
	STA.w $1564,X				;$02D1DE	|
	LDA $96					;$02D1E1	|
	CLC					;$02D1E3	|
	ADC.b #$08				;$02D1E4	|
	AND.b #$F0				;$02D1E6	|
	STA $96					;$02D1E8	|
	LDA $97					;$02D1EA	|
	ADC.b #$00				;$02D1EC	|
	STA $97					;$02D1EE	|
Return02D1F0:
	RTS

DATA_02D1F1:
	db $00,$04

SetTreeTile:
	LDA.w $18B0
	STA $9A					;$02D1F6	|
	LDA.w $18B1				;$02D1F8	|
	STA $9B					;$02D1FB	|
	LDA.w $18B2				;$02D1FD	|
	STA $98					;$02D200	|
	LDA.w $18B3				;$02D202	|
	STA $99					;$02D205	|
	LDA.b #$04				;$02D207	|
	STA $9C					;$02D209	|
	JSL generate_tile			;$02D20B	|
Return02D20F:
	RTL

DATA_02D210:
	db $01

DATA_02D211:
	db $FF,$10,$F0

CODE_02D214:
	LDA $15
	AND.b #$03				;$02D216	|
	BNE CODE_02D228				;$02D218	|
CODE_02D21A:
	LDA $B6,X
	BEQ CODE_02D226				;$02D21C	|
	BPL CODE_02D224				;$02D21E	|
	INC $B6,X				;$02D220	|
	INC $B6,X				;$02D222	|
CODE_02D224:
	DEC $B6,X
CODE_02D226:
	BRA CODE_02D247

CODE_02D228:
	TAY
	CPY.b #$01				;$02D229	|
	BNE CODE_02D238				;$02D22B	|
	LDA $B6,X				;$02D22D	|
	CMP.w DATA_02D211,Y			;$02D22F	|
	BEQ CODE_02D247				;$02D232	|
	BPL CODE_02D21A				;$02D234	|
	BRA CODE_02D241				;$02D236	|

CODE_02D238:
	LDA $B6,X
	CMP.w DATA_02D211,Y			;$02D23A	|
	BEQ CODE_02D247				;$02D23D	|
	BMI CODE_02D21A				;$02D23F	|
CODE_02D241:
	CLC
	ADC.w Return02D20F,Y			;$02D242	|
	STA $B6,X				;$02D245	|
CODE_02D247:
	LDY.b #$00
	LDA $9E,X				;$02D249	|
	CMP.b #$87				;$02D24B	|
	BNE CODE_02D25F				;$02D24D	|
	LDA $15					;$02D24F	|
	AND.b #$0C				;$02D251	|
	BEQ CODE_02D26F				;$02D253	|
	LDY.b #$10				;$02D255	|
	AND.b #$08				;$02D257	|
	BEQ CODE_02D26F				;$02D259	|
	LDY.b #$F0				;$02D25B	|
	BRA CODE_02D26F				;$02D25D	|

CODE_02D25F:
	LDY.b #$F8
	LDA $15					;$02D261	|
	AND.b #$0C				;$02D263	|
	BEQ CODE_02D26F				;$02D265	|
	LDY.b #$F0				;$02D267	|
	AND.b #$08				;$02D269	|
	BNE CODE_02D26F				;$02D26B	|
	LDY.b #$08				;$02D26D	|
CODE_02D26F:
	STY $00
	LDA $AA,X				;$02D271	|
	CMP $00					;$02D273	|
	BEQ CODE_02D27F				;$02D275	|
	BPL CODE_02D27D				;$02D277	|
	INC $AA,X				;$02D279	|
	INC $AA,X				;$02D27B	|
CODE_02D27D:
	DEC $AA,X
CODE_02D27F:
	LDA $B6,X
	STA $7B					;$02D281	|
	LDA $AA,X				;$02D283	|
	STA $7D					;$02D285	|
	RTL					;$02D287	|

UpdateXPosNoGrvtyB1:
	TXA
	CLC					;$02D289	|
	ADC.b #$0C				;$02D28A	|
	TAX					;$02D28C	|
	JSR UpdateYPosNoGrvtyB1			;$02D28D	|
	LDX.w $15E9				;$02D290	|
	RTS					;$02D293	|

UpdateYPosNoGrvtyB1:
	LDA $AA,X
	ASL					;$02D296	|
	ASL					;$02D297	|
	ASL					;$02D298	|
	ASL					;$02D299	|
	CLC					;$02D29A	|
	ADC.w $14EC,X				;$02D29B	|
	STA.w $14EC,X				;$02D29E	|
	PHP					;$02D2A1	|
	PHP					;$02D2A2	|
	LDY.b #$00				;$02D2A3	|
	LDA $AA,X				;$02D2A5	|
	LSR					;$02D2A7	|
	LSR					;$02D2A8	|
	LSR					;$02D2A9	|
	LSR					;$02D2AA	|
	CMP.b #$08				;$02D2AB	|
	BCC CODE_02D2B2				;$02D2AD	|
	ORA.b #$F0				;$02D2AF	|
	DEY					;$02D2B1	|
CODE_02D2B2:
	PLP
	PHA					;$02D2B3	|
	ADC $D8,X				;$02D2B4	|
	STA $D8,X				;$02D2B6	|
	TYA					;$02D2B8	|
	ADC.w $14D4,X				;$02D2B9	|
	STA.w $14D4,X				;$02D2BC	|
	PLA					;$02D2BF	|
	PLP					;$02D2C0	|
	ADC.b #$00				;$02D2C1	|
	STA.w $1491				;$02D2C3	|
	RTS					;$02D2C6	|

	STA $00					;$02D2C7	|
	LDA $94					;$02D2C9	|
	PHA					;$02D2CB	|
	LDA $95					;$02D2CC	|
	PHA					;$02D2CE	|
	LDA $96					;$02D2CF	|
	PHA					;$02D2D1	|
	LDA $97					;$02D2D2	|
	PHA					;$02D2D4	|
	LDA.w $00E4,y				;$02D2D5	|
	STA $94					;$02D2D8	|
	LDA.w $14E0,Y				;$02D2DA	|
	STA $95					;$02D2DD	|
	LDA.w $00D8,y				;$02D2DF	|
	STA $96					;$02D2E2	|
	LDA.w $14D4,Y				;$02D2E4	|
	STA $97					;$02D2E7	|
	LDA $00					;$02D2E9	|
	JSR CODE_02D2FB				;$02D2EB	|
	PLA					;$02D2EE	|
	STA $97					;$02D2EF	|
	PLA					;$02D2F1	|
	STA $96					;$02D2F2	|
	PLA					;$02D2F4	|
	STA $95					;$02D2F5	|
	PLA					;$02D2F7	|
	STA $94					;$02D2F8	|
	RTS					;$02D2FA	|

CODE_02D2FB:
	STA $01
	PHX					;$02D2FD	|
	PHY					;$02D2FE	|
	JSR CODE_02D50C				;$02D2FF	|
	STY $02					;$02D302	|
	LDA $0E					;$02D304	|
	BPL CODE_02D30D				;$02D306	|
	EOR.b #$FF				;$02D308	|
	CLC					;$02D30A	|
	ADC.b #$01				;$02D30B	|
CODE_02D30D:
	STA $0C
	JSR CODE_02D4FA				;$02D30F	|
	STY $03					;$02D312	|
	LDA $0F					;$02D314	|
	BPL CODE_02D31D				;$02D316	|
	EOR.b #$FF				;$02D318	|
	CLC					;$02D31A	|
	ADC.b #$01				;$02D31B	|
CODE_02D31D:
	STA $0D
	LDY.b #$00				;$02D31F	|
	LDA $0D					;$02D321	|
	CMP $0C					;$02D323	|
	BCS CODE_02D330				;$02D325	|
	INY					;$02D327	|
	PHA					;$02D328	|
	LDA $0C					;$02D329	|
	STA $0D					;$02D32B	|
	PLA					;$02D32D	|
	STA $0C					;$02D32E	|
CODE_02D330:
	LDA.b #$00
	STA $0B					;$02D332	|
	STA $00					;$02D334	|
	LDX $01					;$02D336	|
CODE_02D338:
	LDA $0B
	CLC					;$02D33A	|
	ADC $0C					;$02D33B	|
	CMP $0D					;$02D33D	|
	BCC CODE_02D345				;$02D33F	|
	SBC $0D					;$02D341	|
	INC $00					;$02D343	|
CODE_02D345:
	STA $0B
	DEX					;$02D347	|
	BNE CODE_02D338				;$02D348	|
	TYA					;$02D34A	|
	BEQ CODE_02D357				;$02D34B	|
	LDA $00					;$02D34D	|
	PHA					;$02D34F	|
	LDA $01					;$02D350	|
	STA $00					;$02D352	|
	PLA					;$02D354	|
	STA $01					;$02D355	|
CODE_02D357:
	LDA $00
	LDY $02					;$02D359	|
	BEQ CODE_02D364				;$02D35B	|
	EOR.b #$FF				;$02D35D	|
	CLC					;$02D35F	|
	ADC.b #$01				;$02D360	|
	STA $00					;$02D362	|
CODE_02D364:
	LDA $01
	LDY $03					;$02D366	|
	BEQ CODE_02D371				;$02D368	|
	EOR.b #$FF				;$02D36A	|
	CLC					;$02D36C	|
	ADC.b #$01				;$02D36D	|
	STA $01					;$02D36F	|
CODE_02D371:
	PLY
	PLX					;$02D372	|
	RTS					;$02D373	|

DATA_02D374:
	db $0C,$1C

DATA_02D376:
	db $01,$02

GetDrawInfo2:
	STZ.w $186C,X
	STZ.w $15A0,X				;$02D37B	|
	LDA $E4,X				;$02D37E	|
	CMP $1A					;$02D380	|
	LDA.w $14E0,X				;$02D382	|
	SBC $1B					;$02D385	|
	BEQ CODE_02D38C				;$02D387	|
	INC.w $15A0,X				;$02D389	|
CODE_02D38C:
	LDA.w $14E0,X
	XBA					;$02D38F	|
	LDA $E4,X				;$02D390	|
	REP #$20				;$02D392	|
	SEC					;$02D394	|
	SBC $1A					;$02D395	|
	CLC					;$02D397	|
	ADC.w #$0040				;$02D398	|
	CMP.w #$0180				;$02D39B	|
	SEP #$20				;$02D39E	|
	ROL					;$02D3A0	|
	AND.b #$01				;$02D3A1	|
	STA.w $15C4,X				;$02D3A3	|
	BNE CODE_02D3E7				;$02D3A6	|
	LDY.b #$00				;$02D3A8	|
	LDA.w $1662,X				;$02D3AA	|
	AND.b #$20				;$02D3AD	|
	BEQ CODE_02D3B2				;$02D3AF	|
	INY					;$02D3B1	|
CODE_02D3B2:
	LDA $D8,X
	CLC					;$02D3B4	|
	ADC.w DATA_02D374,Y			;$02D3B5	|
	PHP					;$02D3B8	|
	CMP $1C					;$02D3B9	|
	ROL $00					;$02D3BB	|
	PLP					;$02D3BD	|
	LDA.w $14D4,X				;$02D3BE	|
	ADC.b #$00				;$02D3C1	|
	LSR $00					;$02D3C3	|
	SBC $1D					;$02D3C5	|
	BEQ CODE_02D3D2				;$02D3C7	|
	LDA.w $186C,X				;$02D3C9	|
	ORA.w DATA_02D376,Y			;$02D3CC	|
	STA.w $186C,X				;$02D3CF	|
CODE_02D3D2:
	DEY
	BPL CODE_02D3B2				;$02D3D3	|
	LDY.w $15EA,X				;$02D3D5	|
	LDA $E4,X				;$02D3D8	|
	SEC					;$02D3DA	|
	SBC $1A					;$02D3DB	|
	STA $00					;$02D3DD	|
	LDA $D8,X				;$02D3DF	|
	SEC					;$02D3E1	|
	SBC $1C					;$02D3E2	|
	STA $01					;$02D3E4	|
	RTS					;$02D3E6	|

CODE_02D3E7:
	PLA
	PLA					;$02D3E8	|
	RTS					;$02D3E9	|

Layer3SmashMain:
	JSL CODE_00FF61
	LDA $9D					;$02D3EE	|
	BNE Return02D444			;$02D3F0	|
	JSR CODE_02D49C				;$02D3F2	|
	LDY.b #$00				;$02D3F5	|
	LDA.w $17BD				;$02D3F7	|
	BPL CODE_02D3FD				;$02D3FA	|
	DEY					;$02D3FC	|
CODE_02D3FD:
	CLC
	ADC $E4,X				;$02D3FE	|
	STA $E4,X				;$02D400	|
	TYA					;$02D402	|
	ADC.w $14E0,X				;$02D403	|
	STA.w $14E0,X				;$02D406	|
	LDA $C2,X				;$02D409	|
	JSL execute_pointer			;$02D40B	|

Layer3SmashPtrs:
	dw CODE_02D419
	dw CODE_02D445
	dw CODE_02D455
	dw CODE_02D481
	dw CODE_02D489

CODE_02D419:
	LDA.w $18BF
	BEQ CODE_02D422				;$02D41C	|
	JSR OffScrEraseSprBnk2			;$02D41E	|
	RTS					;$02D421	|

CODE_02D422:
	LDA.w $1540,X
	BNE Return02D444			;$02D425	|
	INC $C2,X				;$02D427	|
	LDA.b #$80				;$02D429	|
	STA.w $1540,X				;$02D42B	|
	JSL GetRand				;$02D42E	|
	AND.b #$3F				;$02D432	|
	ORA.b #$80				;$02D434	|
	STA $E4,X				;$02D436	|
	LDA.b #$FF				;$02D438	|
	STA.w $14E0,X				;$02D43A	|
	STZ $D8,X				;$02D43D	|
	STZ.w $14D4,X				;$02D43F	|
	STZ $AA,X				;$02D442	|
Return02D444:
	RTL

CODE_02D445:
	LDA.w $1540,X
	BEQ CODE_02D452				;$02D448	|
	LDA.b #$04				;$02D44A	|
	STA $AA,X				;$02D44C	|
	JSR UpdateYPosNoGrvtyB1			;$02D44E	|
	RTL					;$02D451	|

CODE_02D452:
	INC $C2,X
	RTL					;$02D454	|

CODE_02D455:
	JSR UpdateYPosNoGrvtyB1
	LDA $AA,X				;$02D458	|
	BMI CODE_02D460				;$02D45A	|
	CMP.b #$40				;$02D45C	|
	BCS CODE_02D465				;$02D45E	|
CODE_02D460:
	CLC
	ADC.b #$07				;$02D461	|
	STA $AA,X				;$02D463	|
CODE_02D465:
	LDA $D8,X
	CMP.b #$A0				;$02D467	|
	BCC Return02D480			;$02D469	|
	AND.b #$F0				;$02D46B	|
	STA $D8,X				;$02D46D	|
	LDA.b #$50				;$02D46F	|
	STA.w $1887				;$02D471	|
	LDA.b #$09				;$02D474	|
	STA.w $1DFC				;$02D476	|
	LDA.b #$30				;$02D479	|
	STA.w $1540,X				;$02D47B	|
	INC $C2,X				;$02D47E	|
Return02D480:
	RTL

CODE_02D481:
	LDA.w $1540,X
	BNE Return02D488			;$02D484	|
	INC $C2,X				;$02D486	|
Return02D488:
	RTL

CODE_02D489:
	LDA.b #$E0
	STA $AA,X				;$02D48B	|
	JSR UpdateYPosNoGrvtyB1			;$02D48D	|
	LDA $D8,X				;$02D490	|
	BNE Return02D49B			;$02D492	|
	STZ $C2,X				;$02D494	|
	LDA.b #$A0				;$02D496	|
	STA.w $1540,X				;$02D498	|
Return02D49B:
	RTL

CODE_02D49C:
	LDA.b #$00
	LDY $19					;$02D49E	|
	BEQ CODE_02D4A8				;$02D4A0	|
	LDY $73					;$02D4A2	|
	BNE CODE_02D4A8				;$02D4A4	|
	LDA.b #$10				;$02D4A6	|
CODE_02D4A8:
	CLC
	ADC $D8,X				;$02D4A9	|
	CMP $80					;$02D4AB	|
	BCC CODE_02D4EF				;$02D4AD	|
	LDA $E4,X				;$02D4AF	|
	STA $00					;$02D4B1	|
	LDA.w $14E0,X				;$02D4B3	|
	STA $01					;$02D4B6	|
	REP #$20				;$02D4B8	|
	LDA $7E					;$02D4BA	|
	CLC					;$02D4BC	|
	ADC $00					;$02D4BD	|
	SEC					;$02D4BF	|
	SBC.w #$0030				;$02D4C0	|
	CMP.w #$0090				;$02D4C3	|
	BCS CODE_02D4EF				;$02D4C6	|
	SEC					;$02D4C8	|
	SBC.w #$0008				;$02D4C9	|
	CMP.w #$0080				;$02D4CC	|
	SEP #$20				;$02D4CF	|
	BCS CODE_02D4E5				;$02D4D1	|
	LDA $72					;$02D4D3	|
	BNE CODE_02D4DC				;$02D4D5	|
	JSL HurtMario				;$02D4D7	|
	RTS					;$02D4DB	|

CODE_02D4DC:
	STZ $7D
	LDA $AA,X				;$02D4DE	|
	BMI Return02D4E4			;$02D4E0	|
	STA $7D					;$02D4E2	|
Return02D4E4:
	RTS

CODE_02D4E5:
	PHP
	LDA.b #$08				;$02D4E6	|
	PLP					;$02D4E8	|
	BPL CODE_02D4ED				;$02D4E9	|
	LDA.b #$F8				;$02D4EB	|
CODE_02D4ED:
	STA $7B
CODE_02D4EF:
	SEP #$20
	RTS					;$02D4F1	|

DATA_02D4F2:
	db $80,$40,$20,$10,$08,$04,$02,$01

CODE_02D4FA:
	LDY.b #$00
	LDA $94					;$02D4FC	|
	SEC					;$02D4FE	|
	SBC $E4,X				;$02D4FF	|
	STA $0F					;$02D501	|
	LDA $95					;$02D503	|
	SBC.w $14E0,X				;$02D505	|
	BPL Return02D50B			;$02D508	|
	INY					;$02D50A	|
Return02D50B:
	RTS

CODE_02D50C:
	LDY.b #$00
	LDA $96					;$02D50E	|
	SEC					;$02D510	|
	SBC $D8,X				;$02D511	|
	STA $0E					;$02D513	|
	LDA $97					;$02D515	|
	SBC.w $14D4,X				;$02D517	|
	BPL Return02D51D			;$02D51A	|
	INY					;$02D51C	|
Return02D51D:
	RTS

DATA_02D51E:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF

DATA_02D57F:
	db $FF,$13,$14,$15,$16,$17,$18,$19

CODE_02D587:
	JSR CODE_02D5E4
	LDA.w $14C8,X				;$02D58A	|
	CMP.b #$02				;$02D58D	|
	BEQ Return02D5A3			;$02D58F	|
	LDA $9D					;$02D591	|
	BNE Return02D5A3			;$02D593	|
	JSR SubOffscreen0Bnk2			;$02D595	|
	LDA.b #$E8				;$02D598	|
	STA $B6,X				;$02D59A	|
	JSR UpdateXPosNoGrvtyB1			;$02D59C	|
	JSL MarioSprInteract			;$02D59F	|
Return02D5A3:
	RTS

DATA_02D5A4:
	db $00,$10,$20,$30,$00,$10,$20,$30
	db $00,$10,$20,$30,$00,$10,$20,$30
DATA_02D5B4:
	db $00,$00,$00,$00,$10,$10,$10,$10
	db $20,$20,$20,$20,$30,$30,$30,$30
BanzaiBillTiles:
	db $80,$82,$84,$86,$A0,$88,$CE,$EE
	db $C0,$C2,$CE,$EE,$8E,$AE,$84,$86
DATA_02D5D4:
	db $33,$33,$33,$33,$33,$33,$33,$33
	db $33,$33,$33,$33,$33,$33,$B3,$B3

CODE_02D5E4:
	JSR GetDrawInfo2
	PHX					;$02D5E7	|
	LDX.b #$0F				;$02D5E8	|
CODE_02D5EA:
	LDA $00
	CLC					;$02D5EC	|
	ADC.w DATA_02D5A4,X			;$02D5ED	|
	STA.w $0300,Y				;$02D5F0	|
	LDA $01					;$02D5F3	|
	CLC					;$02D5F5	|
	ADC.w DATA_02D5B4,X			;$02D5F6	|
	STA.w $0301,Y				;$02D5F9	|
	LDA.w BanzaiBillTiles,X			;$02D5FC	|
	STA.w $0302,Y				;$02D5FF	|
	LDA.w DATA_02D5D4,X			;$02D602	|
	STA.w $0303,Y				;$02D605	|
	INY					;$02D608	|
	INY					;$02D609	|
	INY					;$02D60A	|
	INY					;$02D60B	|
	DEX					;$02D60C	|
	BPL CODE_02D5EA				;$02D60D	|
	PLX					;$02D60F	|
	LDY.b #$02				;$02D610	|
	LDA.b #$0F				;$02D612	|
	JMP CODE_02B7A7				;$02D614	|

BanzaiPRotating:
	PHB
	PHK					;$02D618	|
	PLB					;$02D619	|
	LDA $9E,X				;$02D61A	|
	CMP.b #$9F				;$02D61C	|
	BNE CODE_02D625				;$02D61E	|
	JSR CODE_02D587				;$02D620	|
	BRA CODE_02D628				;$02D623	|

CODE_02D625:
	JSR CODE_02D62A
CODE_02D628:
	PLB
	RTL					;$02D629	|

CODE_02D62A:
	JSR SubOffscreen3Bnk2
	LDA $9D					;$02D62D	|
	BNE CODE_02D653				;$02D62F	|
	LDA $E4,X				;$02D631	|
	LDY.b #$02				;$02D633	|
	AND.b #$10				;$02D635	|
	BNE CODE_02D63B				;$02D637	|
	LDY.b #$FE				;$02D639	|
CODE_02D63B:
	TYA
	LDY.b #$00				;$02D63C	|
	CMP.b #$00				;$02D63E	|
	BPL CODE_02D643				;$02D640	|
	DEY					;$02D642	|
CODE_02D643:
	CLC
	ADC.w $1602,X				;$02D644	|
	STA.w $1602,X				;$02D647	|
	TYA					;$02D64A	|
	ADC.w $151C,X				;$02D64B	|
	AND.b #$01				;$02D64E	|
	STA.w $151C,X				;$02D650	|
CODE_02D653:
	LDA.w $151C,X
	STA $01					;$02D656	|
	LDA.w $1602,X				;$02D658	|
	STA $00					;$02D65B	|
	REP #$30				;$02D65D	|
	LDA $00					;$02D65F	|
	CLC					;$02D661	|
	ADC.w #$0080				;$02D662	|
	AND.w #$01FF				;$02D665	|
	STA $02					;$02D668	|
	LDA $00					;$02D66A	|
	AND.w #$00FF				;$02D66C	|
	ASL					;$02D66F	|
	TAX					;$02D670	|
	LDA.l CircleCoords,X			;$02D671	|
	STA $04					;$02D675	|
	LDA $02					;$02D677	|
	AND.w #$00FF				;$02D679	|
	ASL					;$02D67C	|
	TAX					;$02D67D	|
	LDA.l CircleCoords,X			;$02D67E	|
	STA $06					;$02D682	|
	SEP #$30				;$02D684	|
	LDX.w $15E9				;$02D686	|
	LDA $04					;$02D689	|
	STA.w $4202				;$02D68B	|
	LDA.w $187B,X				;$02D68E	|
	LDY $05					;$02D691	|
	BNE CODE_02D6A3				;$02D693	|
	STA.w $4203				;$02D695	|
	JSR CODE_02D800				;$02D698	|
	ASL.w $4216				;$02D69B	|
	LDA.w $4217				;$02D69E	|
	ADC.b #$00				;$02D6A1	|
CODE_02D6A3:
	LSR $01
	BCC CODE_02D6AA				;$02D6A5	|
	EOR.b #$FF				;$02D6A7	|
	INC A					;$02D6A9	|
CODE_02D6AA:
	STA $04
	LDA $06					;$02D6AC	|
	STA.w $4202				;$02D6AE	|
	LDA.w $187B,X				;$02D6B1	|
	LDY $07					;$02D6B4	|
	BNE CODE_02D6C6				;$02D6B6	|
	STA.w $4203				;$02D6B8	|
	JSR CODE_02D800				;$02D6BB	|
	ASL.w $4216				;$02D6BE	|
	LDA.w $4217				;$02D6C1	|
	ADC.b #$00				;$02D6C4	|
CODE_02D6C6:
	LSR $03
	BCC CODE_02D6CD				;$02D6C8	|
	EOR.b #$FF				;$02D6CA	|
	INC A					;$02D6CC	|
CODE_02D6CD:
	STA $06
	LDA $E4,X				;$02D6CF	|
	PHA					;$02D6D1	|
	LDA.w $14E0,X				;$02D6D2	|
	PHA					;$02D6D5	|
	LDA $D8,X				;$02D6D6	|
	PHA					;$02D6D8	|
	LDA.w $14D4,X				;$02D6D9	|
	PHA					;$02D6DC	|
	LDY.w $0F86,X				;$02D6DD	|
	STZ $00					;$02D6E0	|
	LDA $04					;$02D6E2	|
	BPL CODE_02D6E8				;$02D6E4	|
	DEC $00					;$02D6E6	|
CODE_02D6E8:
	CLC
	ADC $E4,X				;$02D6E9	|
	STA $E4,X				;$02D6EB	|
	PHP					;$02D6ED	|
	PHA					;$02D6EE	|
	SEC					;$02D6EF	|
	SBC.w $1534,X				;$02D6F0	|
	STA.w $1528,X				;$02D6F3	|
	PLA					;$02D6F6	|
	STA.w $1534,X				;$02D6F7	|
	PLP					;$02D6FA	|
	LDA.w $14E0,X				;$02D6FB	|
	ADC $00					;$02D6FE	|
	STA.w $14E0,X				;$02D700	|
	STZ $01					;$02D703	|
	LDA $06					;$02D705	|
	BPL CODE_02D70B				;$02D707	|
	DEC $01					;$02D709	|
CODE_02D70B:
	CLC
	ADC $D8,X				;$02D70C	|
	STA $D8,X				;$02D70E	|
	LDA.w $14D4,X				;$02D710	|
	ADC $01					;$02D713	|
	STA.w $14D4,X				;$02D715	|
	LDA $9E,X				;$02D718	|
	CMP.b #$9E				;$02D71A	|
	BEQ CODE_02D750				;$02D71C	|
	JSL InvisBlkMainRt			;$02D71E	|
	BCC CODE_02D73D				;$02D722	|
	LDA.b #$03				;$02D724	|
	STA.w $160E,X				;$02D726	|
	STA.w $1471				;$02D729	|
	LDA.w $187A				;$02D72C	|
	BNE CODE_02D74B				;$02D72F	|
	PHX					;$02D731	|
	JSL CODE_00E2BD				;$02D732	|
	PLX					;$02D736	|
	LDA.b #$FF				;$02D737	|
	STA $78					;$02D739	|
	BRA CODE_02D74B				;$02D73B	|

CODE_02D73D:
	LDA.w $160E,X
	BEQ CODE_02D74B				;$02D740	|
	STZ.w $160E,X				;$02D742	|
	PHX					;$02D745	|
	JSL CODE_00E2BD				;$02D746	|
	PLX					;$02D74A	|
CODE_02D74B:
	JSR CODE_02D848
	BRA CODE_02D757				;$02D74E	|

CODE_02D750:
	JSL MarioSprInteract
	JSR CODE_02D813				;$02D754	|
CODE_02D757:
	PLA
	STA.w $14D4,X				;$02D758	|
	PLA					;$02D75B	|
	STA $D8,X				;$02D75C	|
	PLA					;$02D75E	|
	STA.w $14E0,X				;$02D75F	|
	PLA					;$02D762	|
	STA $E4,X				;$02D763	|
	LDA $00					;$02D765	|
	CLC					;$02D767	|
	ADC $1A					;$02D768	|
	SEC					;$02D76A	|
	SBC $E4,X				;$02D76B	|
	JSR CODE_02D870				;$02D76D	|
	CLC					;$02D770	|
	ADC $E4,X				;$02D771	|
	SEC					;$02D773	|
	SBC $1A					;$02D774	|
	STA $00					;$02D776	|
	LDA $01					;$02D778	|
	CLC					;$02D77A	|
	ADC $1C					;$02D77B	|
	SEC					;$02D77D	|
	SBC $D8,X				;$02D77E	|
	JSR CODE_02D870				;$02D780	|
	CLC					;$02D783	|
	ADC $D8,X				;$02D784	|
	SEC					;$02D786	|
	SBC $1C					;$02D787	|
	STA $01					;$02D789	|
	LDA.w $15C4,X				;$02D78B	|
	BNE Return02D806			;$02D78E	|
	LDA.w $15EA,X				;$02D790	|
	CLC					;$02D793	|
	ADC.b #$10				;$02D794	|
	TAY					;$02D796	|
	PHX					;$02D797	|
	LDA $E4,X				;$02D798	|
	STA $0A					;$02D79A	|
	LDA $D8,X				;$02D79C	|
	STA $0B					;$02D79E	|
	LDA $9E,X				;$02D7A0	|
	TAX					;$02D7A2	|
	LDA.b #$E8				;$02D7A3	|
	CPX.b #$9E				;$02D7A5	|
	BEQ CODE_02D7AB				;$02D7A7	|
	LDA.b #$A2				;$02D7A9	|
CODE_02D7AB:
	STA $08
	LDX.b #$01				;$02D7AD	|
CODE_02D7AF:
	LDA $00
	STA.w $0300,Y				;$02D7B1	|
	LDA $01					;$02D7B4	|
	STA.w $0301,Y				;$02D7B6	|
	LDA $08					;$02D7B9	|
	STA.w $0302,Y				;$02D7BB	|
	LDA.b #$33				;$02D7BE	|
	STA.w $0303,Y				;$02D7C0	|
	LDA $00					;$02D7C3	|
	CLC					;$02D7C5	|
	ADC $1A					;$02D7C6	|
	SEC					;$02D7C8	|
	SBC $0A					;$02D7C9	|
	STA $00					;$02D7CB	|
	ASL					;$02D7CD	|
	ROR $00					;$02D7CE	|
	LDA $00					;$02D7D0	|
	SEC					;$02D7D2	|
	SBC $1A					;$02D7D3	|
	CLC					;$02D7D5	|
	ADC $0A					;$02D7D6	|
	STA $00					;$02D7D8	|
	LDA $01					;$02D7DA	|
	CLC					;$02D7DC	|
	ADC $1C					;$02D7DD	|
	SEC					;$02D7DF	|
	SBC $0B					;$02D7E0	|
	STA $01					;$02D7E2	|
	ASL					;$02D7E4	|
	ROR $01					;$02D7E5	|
	LDA $01					;$02D7E7	|
	SEC					;$02D7E9	|
	SBC $1C					;$02D7EA	|
	CLC					;$02D7EC	|
	ADC $0B					;$02D7ED	|
	STA $01					;$02D7EF	|
	INY					;$02D7F1	|
	INY					;$02D7F2	|
	INY					;$02D7F3	|
	INY					;$02D7F4	|
	DEX					;$02D7F5	|
	BPL CODE_02D7AF				;$02D7F6	|
	PLX					;$02D7F8	|
	LDY.b #$02				;$02D7F9	|
	LDA.b #$05				;$02D7FB	|
	JMP CODE_02B7A7				;$02D7FD	|

CODE_02D800:
	NOP
	NOP					;$02D801	|
	NOP					;$02D802	|
	NOP					;$02D803	|
	NOP					;$02D804	|
	NOP					;$02D805	|
Return02D806:
	RTS

DATA_02D807:
	db $F8,$08,$F8,$08

DATA_02D80B:
	db $F8,$F8,$08,$08

DATA_02D80F:
	db $33,$73,$B3,$F3

CODE_02D813:
	JSR GetDrawInfo2
	PHX					;$02D816	|
	LDX.b #$03				;$02D817	|
CODE_02D819:
	LDA $00
	CLC					;$02D81B	|
	ADC.w DATA_02D807,X			;$02D81C	|
	STA.w $0300,Y				;$02D81F	|
	LDA $01					;$02D822	|
	CLC					;$02D824	|
	ADC.w DATA_02D80B,X			;$02D825	|
	STA.w $0301,Y				;$02D828	|
	LDA.w CODE_02D800,X			;$02D82B	|
	STA.w $0302,Y				;$02D82E	|
	LDA.w DATA_02D80F,X			;$02D831	|
	STA.w $0303,Y				;$02D834	|
	INY					;$02D837	|
	INY					;$02D838	|
	INY					;$02D839	|
	INY					;$02D83A	|
	DEX					;$02D83B	|
	BPL CODE_02D819				;$02D83C	|
	PLX					;$02D83E	|
	RTS					;$02D83F	|

DATA_02D840:
	db $00,$F0,$00,$10

WoodPlatformTiles:
	db $A2,$60,$61,$62

CODE_02D848:
	JSR GetDrawInfo2
	PHX					;$02D84B	|
	LDX.b #$03				;$02D84C	|
CODE_02D84E:
	LDA $00
	CLC					;$02D850	|
	ADC.w DATA_02D840,X			;$02D851	|
	STA.w $0300,Y				;$02D854	|
	LDA $01					;$02D857	|
	STA.w $0301,Y				;$02D859	|
	LDA.w WoodPlatformTiles,X		;$02D85C	|
	STA.w $0302,Y				;$02D85F	|
	LDA.b #$33				;$02D862	|
	STA.w $0303,Y				;$02D864	|
	INY					;$02D867	|
	INY					;$02D868	|
	INY					;$02D869	|
	INY					;$02D86A	|
	DEX					;$02D86B	|
	BPL CODE_02D84E				;$02D86C	|
	PLX					;$02D86E	|
	RTS					;$02D86F	|

CODE_02D870:
	PHP
	BPL CODE_02D876				;$02D871	|
	EOR.b #$FF				;$02D873	|
	INC A					;$02D875	|
CODE_02D876:
	STA.w $4205
	STZ.w $4204				;$02D879	|
	LDA.w $187B,X				;$02D87C	|
	LSR					;$02D87F	|
	STA.w $4206				;$02D880	|
	JSR CODE_02D800				;$02D883	|
	LDA.w $4214				;$02D886	|
	STA $0E					;$02D889	|
	LDA.w $4215				;$02D88B	|
	ASL $0E					;$02D88E	|
	ROL					;$02D890	|
	ASL $0E					;$02D891	|
	ROL					;$02D893	|
	ASL $0E					;$02D894	|
	ROL					;$02D896	|
	ASL $0E					;$02D897	|
	ROL					;$02D899	|
	PLP					;$02D89A	|
	BPL Return02D8A0			;$02D89B	|
	EOR.b #$FF				;$02D89D	|
	INC A					;$02D89F	|
Return02D8A0:
	RTS

BubbleSprTiles1:
	db $A8,$CA,$67,$24

BubbleSprTiles2:
	db $AA,$CC,$69,$24

BubbleSprGfxProp1:
	db $84,$85,$05,$08

BubbleSpriteMain:
	PHB
	PHK					;$02D8AE	|
	PLB					;$02D8AF	|
	JSR CODE_02D8BB				;$02D8B0	|
	PLB					;$02D8B3	|
	RTL					;$02D8B4	|

BubbleSprGfxProp2:
	db $08,$F8

BubbleSprGfxProp3:
	db $01,$FF

BubbleSprGfxProp4:
	db $0C,$F4

CODE_02D8BB:
	LDA.w $15EA,X
	CLC					;$02D8BE	|
	ADC.b #$14				;$02D8BF	|
	STA.w $15EA,X				;$02D8C1	|
	JSL GenericSprGfxRt2			;$02D8C4	|
	PHX					;$02D8C8	|
	LDA $C2,X				;$02D8C9	|
	LDY.w $15EA,X				;$02D8CB	|
	TAX					;$02D8CE	|
	LDA.w BubbleSprGfxProp1,X		;$02D8CF	|
	ORA $64					;$02D8D2	|
	STA.w $0303,Y				;$02D8D4	|
	LDA $14					;$02D8D7	|
	ASL					;$02D8D9	|
	ASL					;$02D8DA	|
	ASL					;$02D8DB	|
	LDA.w BubbleSprTiles1,X			;$02D8DC	|
	BCC CODE_02D8E4				;$02D8DF	|
	LDA.w BubbleSprTiles2,X			;$02D8E1	|
CODE_02D8E4:
	STA.w $0302,Y
	PLX					;$02D8E7	|
	LDA.w $1534,X				;$02D8E8	|
	CMP.b #$60				;$02D8EB	|
	BCS CODE_02D8F3				;$02D8ED	|
	AND.b #$02				;$02D8EF	|
	BEQ CODE_02D8F6				;$02D8F1	|
CODE_02D8F3:
	JSR CODE_02D9D6
CODE_02D8F6:
	LDA.w $14C8,X
	CMP.b #$02				;$02D8F9	|
	BNE CODE_02D904				;$02D8FB	|
	LDA.b #$08				;$02D8FD	|
	STA.w $14C8,X				;$02D8FF	|
	BRA CODE_02D96B				;$02D902	|

CODE_02D904:
	LDA $9D
	BNE Return02D977			;$02D906	|
	LDA $13					;$02D908	|
	AND.b #$01				;$02D90A	|
	BNE CODE_02D91D				;$02D90C	|
	DEC.w $1534,X				;$02D90E	|
	LDA.w $1534,X				;$02D911	|
	CMP.b #$04				;$02D914	|
	BNE CODE_02D91D				;$02D916	|
	LDA.b #$19				;$02D918	|
	STA.w $1DFC				;$02D91A	|
CODE_02D91D:
	LDA.w $1534,X
	DEC A					;$02D920	|
	BEQ CODE_02D978				;$02D921	|
	CMP.b #$07				;$02D923	|
	BCC Return02D977			;$02D925	|
	JSR SubOffscreen0Bnk2			;$02D927	|
	JSR UpdateXPosNoGrvtyB1			;$02D92A	|
	JSR UpdateYPosNoGrvtyB1			;$02D92D	|
	JSL CODE_019138				;$02D930	|
	LDY.w $157C,X				;$02D934	|
	LDA.w BubbleSprGfxProp2,Y		;$02D937	|
	STA $B6,X				;$02D93A	|
	LDA $13					;$02D93C	|
	AND.b #$01				;$02D93E	|
	BNE CODE_02D958				;$02D940	|
	LDA.w $151C,X				;$02D942	|
	AND.b #$01				;$02D945	|
	TAY					;$02D947	|
	LDA $AA,X				;$02D948	|
	CLC					;$02D94A	|
	ADC.w BubbleSprGfxProp3,Y		;$02D94B	|
	STA $AA,X				;$02D94E	|
	CMP.w BubbleSprGfxProp4,Y		;$02D950	|
	BNE CODE_02D958				;$02D953	|
	INC.w $151C,X				;$02D955	|
CODE_02D958:
	LDA.w $1588,X
	BNE CODE_02D96B				;$02D95B	|
	JSL SprSprInteract			;$02D95D	|
	JSL MarioSprInteract			;$02D961	|
	BCC Return02D9A0			;$02D965	|
	STZ $7D					;$02D967	|
	STZ $7B					;$02D969	|
CODE_02D96B:
	LDA.w $1534,X
	CMP.b #$07				;$02D96E	|
	BCC Return02D977			;$02D970	|
	LDA.b #$06				;$02D972	|
	STA.w $1534,X				;$02D974	|
Return02D977:
	RTS

CODE_02D978:
	LDY $C2,X
	LDA.w BubbleSprites,Y			;$02D97A	|
	STA $9E,X				;$02D97D	|
	PHA					;$02D97F	|
	JSL InitSpriteTables			;$02D980	|
	PLY					;$02D984	|
	LDA.b #$20				;$02D985	|
	CPY.b #$74				;$02D987	|
	BNE CODE_02D98D				;$02D989	|
	LDA.b #$04				;$02D98B	|
CODE_02D98D:
	STA.w $154C,X
	LDA $9E,X				;$02D990	|
	CMP.b #$0D				;$02D992	|
	BNE CODE_02D999				;$02D994	|
	DEC.w $1540,X				;$02D996	|
CODE_02D999:
	JSR CODE_02D4FA
	TYA					;$02D99C	|
	STA.w $157C,X				;$02D99D	|
Return02D9A0:
	RTS

BubbleSprites:
	db $0F,$0D,$15,$74

BubbleTileDispX:
	db $F8,$08,$F8,$08,$FF,$F9,$07,$F9
	db $07,$00,$FA,$06,$FA,$06,$00

BubbleTileDispY:
	db $F6,$F6,$02,$02,$FC,$F5,$F5,$03
	db $03,$FC,$F4,$F4,$04,$04,$FB

BubbleTiles:
	db $A0,$A0,$A0,$A0,$99

BubbleGfxProp:
	db $07,$47,$87,$C7,$03

BubbleSize:
	db $02,$02,$02,$02,$00

DATA_02D9D2:
	db $00,$05,$0A,$05

CODE_02D9D6:
	JSR GetDrawInfo2
	LDA $14					;$02D9D9	|
	LSR					;$02D9DB	|
	LSR					;$02D9DC	|
	LSR					;$02D9DD	|
	AND.b #$03				;$02D9DE	|
	TAY					;$02D9E0	|
	LDA.w DATA_02D9D2,Y			;$02D9E1	|
	STA $02					;$02D9E4	|
	LDA.w $15EA,X				;$02D9E6	|
	SEC					;$02D9E9	|
	SBC.b #$14				;$02D9EA	|
	STA.w $15EA,X				;$02D9EC	|
	TAY					;$02D9EF	|
	PHX					;$02D9F0	|
	LDA.w $1534,X				;$02D9F1	|
	STA $03					;$02D9F4	|
	LDX.b #$04				;$02D9F6	|
CODE_02D9F8:
	PHX
	TXA					;$02D9F9	|
	CLC					;$02D9FA	|
	ADC $02					;$02D9FB	|
	TAX					;$02D9FD	|
	LDA $00					;$02D9FE	|
	CLC					;$02DA00	|
	ADC.w BubbleTileDispX,X			;$02DA01	|
	STA.w $0300,Y				;$02DA04	|
	LDA $01					;$02DA07	|
	CLC					;$02DA09	|
	ADC.w BubbleTileDispY,X			;$02DA0A	|
	STA.w $0301,Y				;$02DA0D	|
	PLX					;$02DA10	|
	LDA.w BubbleTiles,X			;$02DA11	|
	STA.w $0302,Y				;$02DA14	|
	LDA.w BubbleGfxProp,X			;$02DA17	|
	ORA $64					;$02DA1A	|
	STA.w $0303,Y				;$02DA1C	|
	LDA $03					;$02DA1F	|
	CMP.b #$06				;$02DA21	|
	BCS CODE_02DA37				;$02DA23	|
	CMP.b #$03				;$02DA25	|
	LDA.b #$02				;$02DA27	|
	ORA $64					;$02DA29	|
	STA.w $0303,Y				;$02DA2B	|
	LDA.b #$64				;$02DA2E	|
	BCS CODE_02DA34				;$02DA30	|
	LDA.b #$66				;$02DA32	|
CODE_02DA34:
	STA.w $0302,Y
CODE_02DA37:
	PHY
	TYA					;$02DA38	|
	LSR					;$02DA39	|
	LSR					;$02DA3A	|
	TAY					;$02DA3B	|
	LDA.w BubbleSize,X			;$02DA3C	|
	STA.w $0460,Y				;$02DA3F	|
	PLY					;$02DA42	|
	INY					;$02DA43	|
	INY					;$02DA44	|
	INY					;$02DA45	|
	INY					;$02DA46	|
	DEX					;$02DA47	|
	BPL CODE_02D9F8				;$02DA48	|
	PLX					;$02DA4A	|
	LDY.b #$FF				;$02DA4B	|
	LDA.b #$04				;$02DA4D	|
	JMP CODE_02B7A7				;$02DA4F	|

HammerBrotherMain:
	PHB
	PHK					;$02DA53	|
	PLB					;$02DA54	|
	JSR CODE_02DA5A				;$02DA55	|
	PLB					;$02DA58	|
Return02DA59:
	RTL

CODE_02DA5A:
	STZ.w $157C,X
	LDA.w $14C8,X				;$02DA5D	|
	CMP.b #$02				;$02DA60	|
	BNE CODE_02DA6E				;$02DA62	|
	JMP HammerBroGfx			;$02DA64	|

HammerFreq:
	db $1F,$0F,$0F,$0F,$0F,$0F,$0F

CODE_02DA6E:
	LDA $9D
	BNE Return02DAE8			;$02DA70	|
	JSL SprSprPMarioSprRts			;$02DA72	|
	JSR SubOffscreen1Bnk2			;$02DA76	|
	LDY.w $0DB3				;$02DA79	|
	LDA.w $1F11,Y				;$02DA7C	|
	TAY					;$02DA7F	|
	LDA $13					;$02DA80	|
	AND.b #$03				;$02DA82	|
	BEQ CODE_02DA89				;$02DA84	|
	INC.w $1570,X				;$02DA86	|
CODE_02DA89:
	LDA.w $1570,X
	ASL					;$02DA8C	|
	CPY.b #$00				;$02DA8D	|
	BEQ CODE_02DA92				;$02DA8F	|
	ASL					;$02DA91	|
CODE_02DA92:
	AND.b #$40
	STA.w $157C,X				;$02DA94	|
	LDA.w $1570,X				;$02DA97	|
	AND.w HammerFreq,Y			;$02DA9A	|
	ORA.w $15A0,X				;$02DA9D	|
	ORA.w $186C,X				;$02DAA0	|
	ORA.w $1540,X				;$02DAA3	|
	BNE Return02DAE8			;$02DAA6	|
	LDA.b #$03				;$02DAA8	|
	STA.w $1540,X				;$02DAAA	|
	LDY.b #$10				;$02DAAD	|
	LDA.w $157C,X				;$02DAAF	|
	BNE CODE_02DAB6				;$02DAB2	|
	LDY.b #$F0				;$02DAB4	|
CODE_02DAB6:
	STY $00
	LDY.b #$07				;$02DAB8	|
CODE_02DABA:
	LDA.w $170B,Y
	BEQ GenerateHammer			;$02DABD	|
	DEY					;$02DABF	|
	BPL CODE_02DABA				;$02DAC0	|
	RTS					;$02DAC2	|

GenerateHammer:
	LDA.b #$04
	STA.w $170B,Y				;$02DAC5	|
	LDA $E4,X				;$02DAC8	|
	STA.w $171F,Y				;$02DACA	|
	LDA.w $14E0,X				;$02DACD	|
	STA.w $1733,Y				;$02DAD0	|
	LDA $D8,X				;$02DAD3	|
	STA.w $1715,Y				;$02DAD5	|
	LDA.w $14D4,X				;$02DAD8	|
	STA.w $1729,Y				;$02DADB	|
	LDA.b #$D0				;$02DADE	|
	STA.w $173D,Y				;$02DAE0	|
	LDA $00					;$02DAE3	|
	STA.w $1747,Y				;$02DAE5	|
Return02DAE8:
	RTS

HammerBroDispX:
	db $08,$10,$00,$10

HammerBroDispY:
	db $F8,$F8,$00,$00

HammerBroTiles:
	db $5A,$4A,$46,$48,$4A,$5A,$48,$46
HammerBroTileSize:
	db $00,$00,$02,$02

HammerBroGfx:
	JSR GetDrawInfo2
	LDA.w $157C,X				;$02DB00	|
	STA $02					;$02DB03	|
	PHX					;$02DB05	|
	LDX.b #$03				;$02DB06	|
CODE_02DB08:
	LDA $00
	CLC					;$02DB0A	|
	ADC.w HammerBroDispX,X			;$02DB0B	|
	STA.w $0300,Y				;$02DB0E	|
	LDA $01					;$02DB11	|
	CLC					;$02DB13	|
	ADC.w HammerBroDispY,X			;$02DB14	|
	STA.w $0301,Y				;$02DB17	|
	PHX					;$02DB1A	|
	LDA $02					;$02DB1B	|
	PHA					;$02DB1D	|
	ORA.b #$37				;$02DB1E	|
	STA.w $0303,Y				;$02DB20	|
	PLA					;$02DB23	|
	BEQ CODE_02DB2A				;$02DB24	|
	INX					;$02DB26	|
	INX					;$02DB27	|
	INX					;$02DB28	|
	INX					;$02DB29	|
CODE_02DB2A:
	LDA.w HammerBroTiles,X
	STA.w $0302,Y				;$02DB2D	|
	PLX					;$02DB30	|
	PHY					;$02DB31	|
	TYA					;$02DB32	|
	LSR					;$02DB33	|
	LSR					;$02DB34	|
	TAY					;$02DB35	|
	LDA.w HammerBroTileSize,X		;$02DB36	|
	STA.w $0460,Y				;$02DB39	|
	PLY					;$02DB3C	|
	INY					;$02DB3D	|
	INY					;$02DB3E	|
	INY					;$02DB3F	|
	INY					;$02DB40	|
	DEX					;$02DB41	|
	BPL CODE_02DB08				;$02DB42	|
CODE_02DB44:
	PLX
	LDY.b #$FF				;$02DB45	|
	LDA.b #$03				;$02DB47	|
	JMP CODE_02B7A7				;$02DB49	|

FlyingPlatformMain:
	PHB
	PHK					;$02DB4D	|
	PLB					;$02DB4E	|
	JSR CODE_02DB5C				;$02DB4F	|
	PLB					;$02DB52	|
	RTL					;$02DB53	|

DATA_02DB54:
	db $01,$FF

DATA_02DB56:
	db $20,$E0

DATA_02DB58:
	db $02,$FE

DATA_02DB5A:
	db $20,$E0

CODE_02DB5C:
	JSR FlyingPlatformGfx
	LDA.b #$FF				;$02DB5F	|
	STA.w $1594,X				;$02DB61	|
	LDY.b #$09				;$02DB64	|
CODE_02DB66:
	LDA.w $14C8,Y
	CMP.b #$08				;$02DB69	|
	BNE CODE_02DB74				;$02DB6B	|
	LDA.w $009E,y				;$02DB6D	|
	CMP.b #$9B				;$02DB70	|
	BEQ PutHammerBroOnPlat			;$02DB72	|
CODE_02DB74:
	DEY
	BPL CODE_02DB66				;$02DB75	|
	BRA CODE_02DB9E				;$02DB77	|

PutHammerBroOnPlat:
	TYA
	STA.w $1594,X				;$02DB7A	|
	LDA $E4,X				;$02DB7D	|
	STA.w $00E4,y				;$02DB7F	|
	LDA.w $14E0,X				;$02DB82	|
	STA.w $14E0,Y				;$02DB85	|
	LDA $D8,X				;$02DB88	|
	SEC					;$02DB8A	|
	SBC.b #$10				;$02DB8B	|
	STA.w $00D8,y				;$02DB8D	|
	LDA.w $14D4,X				;$02DB90	|
	SBC.b #$00				;$02DB93	|
	STA.w $14D4,Y				;$02DB95	|
	PHX					;$02DB98	|
	TYX					;$02DB99	|
	JSR HammerBroGfx			;$02DB9A	|
	PLX					;$02DB9D	|
CODE_02DB9E:
	LDA $9D
	BNE Return02DC0E			;$02DBA0	|
	JSR SubOffscreen1Bnk2			;$02DBA2	|
	LDA $13					;$02DBA5	|
	AND.b #$01				;$02DBA7	|
	BNE CODE_02DBD7				;$02DBA9	|
	LDA.w $1534,X				;$02DBAB	|
	AND.b #$01				;$02DBAE	|
	TAY					;$02DBB0	|
	LDA $B6,X				;$02DBB1	|
	CLC					;$02DBB3	|
	ADC.w DATA_02DB54,Y			;$02DBB4	|
	STA $B6,X				;$02DBB7	|
	CMP.w DATA_02DB56,Y			;$02DBB9	|
	BNE CODE_02DBC1				;$02DBBC	|
	INC.w $1534,X				;$02DBBE	|
CODE_02DBC1:
	LDA.w $151C,X
	AND.b #$01				;$02DBC4	|
	TAY					;$02DBC6	|
	LDA $AA,X				;$02DBC7	|
	CLC					;$02DBC9	|
	ADC.w DATA_02DB58,Y			;$02DBCA	|
	STA $AA,X				;$02DBCD	|
	CMP.w DATA_02DB5A,Y			;$02DBCF	|
	BNE CODE_02DBD7				;$02DBD2	|
	INC.w $151C,X				;$02DBD4	|
CODE_02DBD7:
	JSR UpdateYPosNoGrvtyB1
	JSR UpdateXPosNoGrvtyB1			;$02DBDA	|
	STA.w $1528,X				;$02DBDD	|
	JSL InvisBlkMainRt			;$02DBE0	|
	LDA.w $1558,X				;$02DBE4	|
	BEQ Return02DC0E			;$02DBE7	|
	LDA.b #$01				;$02DBE9	|
	STA $C2,X				;$02DBEB	|
	JSR CODE_02D4FA				;$02DBED	|
	LDA $0F					;$02DBF0	|
	CMP.b #$08				;$02DBF2	|
	BMI CODE_02DBF8				;$02DBF4	|
	INC $C2,X				;$02DBF6	|
CODE_02DBF8:
	LDY.w $1594,X
	BMI Return02DC0E			;$02DBFB	|
	LDA.b #$02				;$02DBFD	|
	STA.w $14C8,Y				;$02DBFF	|
	LDA.b #$C0				;$02DC02	|
	STA.w $00AA,y				;$02DC04	|
	PHX					;$02DC07	|
	TYX					;$02DC08	|
	JSL CODE_01AB6F				;$02DC09	|
	PLX					;$02DC0D	|
Return02DC0E:
	RTS

DATA_02DC0F:
	db $00,$10,$F2,$1E,$00,$10,$FA,$1E
DATA_02DC17:
	db $00,$00,$F6,$F6,$00,$00,$FE,$FE
HmrBroPlatTiles:
	db $40,$40,$C6,$C6,$40,$40,$5D,$5D
DATA_02DC27:
	db $32,$32,$72,$32,$32,$32,$72,$32
DATA_02DC2F:
	db $02,$02,$02,$02,$02,$02,$00,$00
DATA_02DC37:
	db $00,$04,$06,$08,$08,$06,$04,$00

FlyingPlatformGfx:
	JSR GetDrawInfo2
	LDA $C2,X				;$02DC42	|
	STA $07					;$02DC44	|
	LDA.w $1558,X				;$02DC46	|
	LSR					;$02DC49	|
	TAY					;$02DC4A	|
	LDA.w DATA_02DC37,Y			;$02DC4B	|
	STA $05					;$02DC4E	|
	LDY.w $15EA,X				;$02DC50	|
	PHX					;$02DC53	|
	LDA $14					;$02DC54	|
	LSR					;$02DC56	|
	AND.b #$04				;$02DC57	|
	STA $02					;$02DC59	|
	LDX.b #$03				;$02DC5B	|
CODE_02DC5D:
	STX $06
	TXA					;$02DC5F	|
	ORA $02					;$02DC60	|
	TAX					;$02DC62	|
	LDA $00					;$02DC63	|
	CLC					;$02DC65	|
	ADC.w DATA_02DC0F,X			;$02DC66	|
	STA.w $0300,Y				;$02DC69	|
	LDA $01					;$02DC6C	|
	CLC					;$02DC6E	|
	ADC.w DATA_02DC17,X			;$02DC6F	|
	STA.w $0301,Y				;$02DC72	|
	PHX					;$02DC75	|
	LDX $06					;$02DC76	|
	CPX.b #$02				;$02DC78	|
	BCS CODE_02DC8A				;$02DC7A	|
	INX					;$02DC7C	|
	CPX $07					;$02DC7D	|
	BNE CODE_02DC8A				;$02DC7F	|
	LDA.w $0301,Y				;$02DC81	|
	SEC					;$02DC84	|
	SBC $05					;$02DC85	|
	STA.w $0301,Y				;$02DC87	|
CODE_02DC8A:
	PLX
	LDA.w HmrBroPlatTiles,X			;$02DC8B	|
	STA.w $0302,Y				;$02DC8E	|
	LDA.w DATA_02DC27,X			;$02DC91	|
	STA.w $0303,Y				;$02DC94	|
	PHY					;$02DC97	|
	TYA					;$02DC98	|
	LSR					;$02DC99	|
	LSR					;$02DC9A	|
	TAY					;$02DC9B	|
	LDA.w DATA_02DC2F,X			;$02DC9C	|
	STA.w $0460,Y				;$02DC9F	|
	PLY					;$02DCA2	|
	INY					;$02DCA3	|
	INY					;$02DCA4	|
	INY					;$02DCA5	|
	INY					;$02DCA6	|
	LDX $06					;$02DCA7	|
	DEX					;$02DCA9	|
	BPL CODE_02DC5D				;$02DCAA	|
	JMP CODE_02DB44				;$02DCAC	|

SumoBrotherMain:
	PHB
	PHK					;$02DCB0	|
	PLB					;$02DCB1	|
	JSR CODE_02DCB7				;$02DCB2	|
	PLB					;$02DCB5	|
	RTL					;$02DCB6	|

CODE_02DCB7:
	JSR SumoBroGfx
	LDA $9D					;$02DCBA	|
	BNE Return02DCE9			;$02DCBC	|
	LDA.w $14C8,X				;$02DCBE	|
	CMP.b #$08				;$02DCC1	|
	BNE Return02DCE9			;$02DCC3	|
	JSR SubOffscreen0Bnk2			;$02DCC5	|
	JSL SprSprPMarioSprRts			;$02DCC8	|
	JSL UpdateSpritePos			;$02DCCC	|
	LDA.w $1588,X				;$02DCD0	|
	AND.b #$04				;$02DCD3	|
	BEQ CODE_02DCDB				;$02DCD5	|
	STZ $AA,X				;$02DCD7	|
	STZ $B6,X				;$02DCD9	|
CODE_02DCDB:
	LDA $C2,X
	JSL execute_pointer			;$02DCDD	|

SumoBroPtrs:
	dw CODE_02DCEA
	dw CODE_02DCFF
	dw CODE_02DD0E
	dw CODE_02DD4B

Return02DCE9:
	RTS

CODE_02DCEA:
	LDA.b #$01
	STA.w $1602,X				;$02DCEC	|
	LDA.w $1540,X				;$02DCEF	|
	BNE Return02DCFE			;$02DCF2	|
	STZ.w $1602,X				;$02DCF4	|
	LDA.b #$03				;$02DCF7	|
CODE_02DCF9:
	STA.w $1540,X
	INC $C2,X				;$02DCFC	|
Return02DCFE:
	RTS

CODE_02DCFF:
	LDA.w $1540,X
	BNE Return02DD0B			;$02DD02	|
	INC.w $1602,X				;$02DD04	|
	LDA.b #$03				;$02DD07	|
	BRA CODE_02DCF9				;$02DD09	|

Return02DD0B:
	RTS

DATA_02DD0C:
	db $20,$E0

CODE_02DD0E:
	LDA.w $1558,X
	BNE CODE_02DD45				;$02DD11	|
	LDY.w $157C,X				;$02DD13	|
	LDA.w DATA_02DD0C,Y			;$02DD16	|
	STA $B6,X				;$02DD19	|
	LDA.w $1540,X				;$02DD1B	|
	BNE Return02DD44			;$02DD1E	|
	INC.w $1570,X				;$02DD20	|
	LDA.w $1570,X				;$02DD23	|
	AND.b #$01				;$02DD26	|
	BNE CODE_02DD2F				;$02DD28	|
	LDA.b #$20				;$02DD2A	|
	STA.w $1558,X				;$02DD2C	|
CODE_02DD2F:
	LDA.w $1570,X
	CMP.b #$03				;$02DD32	|
	BNE CODE_02DD3D				;$02DD34	|
	STZ.w $1570,X				;$02DD36	|
	LDA.b #$70				;$02DD39	|
	BRA CODE_02DCF9				;$02DD3B	|

CODE_02DD3D:
	LDA.b #$03
CODE_02DD3F:
	JSR CODE_02DCF9
	STZ $C2,X				;$02DD42	|
Return02DD44:
	RTS

CODE_02DD45:
	LDA.b #$01
	STA.w $1602,X				;$02DD47	|
	RTS					;$02DD4A	|

CODE_02DD4B:
	LDA.b #$03
	LDY.w $1540,X				;$02DD4D	|
	BEQ CODE_02DD81				;$02DD50	|
	CPY.b #$2E				;$02DD52	|
	BNE CODE_02DD6F				;$02DD54	|
	PHA					;$02DD56	|
	LDA.w $15A0,X				;$02DD57	|
	ORA.w $186C,X				;$02DD5A	|
	BNE CODE_02DD6E				;$02DD5D	|
	LDA.b #$30				;$02DD5F	|
	STA.w $1887				;$02DD61	|
	LDA.b #$09				;$02DD64	|
	STA.w $1DFC				;$02DD66	|
	PHY					;$02DD69	|
	JSR GenSumoLightning			;$02DD6A	|
	PLY					;$02DD6D	|
CODE_02DD6E:
	PLA
CODE_02DD6F:
	CPY.b #$30
	BCC CODE_02DD7D				;$02DD71	|
	CPY.b #$50				;$02DD73	|
	BCS CODE_02DD7D				;$02DD75	|
	INC A					;$02DD77	|
	CPY.b #$44				;$02DD78	|
	BCS CODE_02DD7D				;$02DD7A	|
	INC A					;$02DD7C	|
CODE_02DD7D:
	STA.w $1602,X
	RTS					;$02DD80	|

CODE_02DD81:
	LDA.w $157C,X
	EOR.b #$01				;$02DD84	|
	STA.w $157C,X				;$02DD86	|
	LDA.b #$40				;$02DD89	|
	JSR CODE_02DD3F				;$02DD8B	|
	RTS					;$02DD8E	|

GenSumoLightning:
	JSL FindFreeSprSlot
	BMI Return02DDC5			;$02DD93	|
	LDA.b #$2B				;$02DD95	|
	STA.w $009E,y				;$02DD97	|
	LDA.b #$08				;$02DD9A	|
	STA.w $14C8,Y				;$02DD9C	|
	LDA $E4,X				;$02DD9F	|
	ADC.b #$04				;$02DDA1	|
	STA.w $00E4,y				;$02DDA3	|
	LDA.w $14E0,X				;$02DDA6	|
	ADC.b #$00				;$02DDA9	|
	STA.w $14E0,Y				;$02DDAB	|
	LDA $D8,X				;$02DDAE	|
	STA.w $00D8,y				;$02DDB0	|
	LDA.w $14D4,X				;$02DDB3	|
	STA.w $14D4,Y				;$02DDB6	|
	PHX					;$02DDB9	|
	TYX					;$02DDBA	|
	JSL InitSpriteTables			;$02DDBB	|
	LDA.b #$10				;$02DDBF	|
	STA.w $1FE2,X				;$02DDC1	|
	PLX					;$02DDC4	|
Return02DDC5:
	RTS

SumoBrosDispX:
	db $FF,$07,$FC,$04,$FF,$07,$FC,$04
	db $FF,$FF,$FC,$04,$FF,$FF,$FC,$04
	db $02,$02,$F4,$04,$02,$02,$F4,$04
	db $09,$01,$04,$FC,$09,$01,$04,$FC
	db $01,$01,$04,$FC,$01,$01,$04,$FC
	db $FF,$FF,$0C,$FC,$FF,$FF,$0C,$FC
SumoBrosDispY:
	db $F8,$F8,$00,$00,$F8,$F8,$00,$00
	db $F8,$F0,$00,$00,$F8,$F8,$00,$00
	db $F8,$F8,$01,$00,$F8,$F8,$FF,$00
SumoBrosTiles:
	db $98,$99,$A7,$A8,$98,$99,$AA,$AB
	db $8A,$66,$AA,$AB,$EE,$EE,$C5,$C6
	db $80,$80,$C1,$C3,$80,$80,$C1,$C3
SumoBrosTileSize:
	db $00,$00,$02,$02,$00,$00,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02

SumoBroGfx:
	JSR GetDrawInfo2
	LDA.w $157C,X				;$02DE41	|
	LSR					;$02DE44	|
	ROR					;$02DE45	|
	ROR					;$02DE46	|
	AND.b #$40				;$02DE47	|
	EOR.b #$40				;$02DE49	|
	STA $02					;$02DE4B	|
	LDY.w $15EA,X				;$02DE4D	|
	LDA.w $1602,X				;$02DE50	|
	ASL					;$02DE53	|
	ASL					;$02DE54	|
	PHX					;$02DE55	|
	TAX					;$02DE56	|
	LDA.b #$03				;$02DE57	|
	STA $05					;$02DE59	|
CODE_02DE5B:
	PHX
	LDA $02					;$02DE5C	|
	BEQ CODE_02DE65				;$02DE5E	|
	TXA					;$02DE60	|
	CLC					;$02DE61	|
	ADC.b #$18				;$02DE62	|
	TAX					;$02DE64	|
CODE_02DE65:
	LDA $00
	CLC					;$02DE67	|
	ADC.w SumoBrosDispX,X			;$02DE68	|
	STA.w $0300,Y				;$02DE6B	|
	PLX					;$02DE6E	|
	LDA $01					;$02DE6F	|
	CLC					;$02DE71	|
	ADC.w SumoBrosDispY,X			;$02DE72	|
	STA.w $0301,Y				;$02DE75	|
	LDA.w SumoBrosTiles,X			;$02DE78	|
	STA.w $0302,Y				;$02DE7B	|
	CMP.b #$66				;$02DE7E	|
	SEC					;$02DE80	|
	BNE CODE_02DE84				;$02DE81	|
	CLC					;$02DE83	|
CODE_02DE84:
	LDA.b #$34
	ADC $02					;$02DE86	|
	STA.w $0303,Y				;$02DE88	|
	PHY					;$02DE8B	|
	TYA					;$02DE8C	|
	LSR					;$02DE8D	|
	LSR					;$02DE8E	|
	TAY					;$02DE8F	|
	LDA.w SumoBrosTileSize,X		;$02DE90	|
	STA.w $0460,Y				;$02DE93	|
	PLY					;$02DE96	|
	INY					;$02DE97	|
	INY					;$02DE98	|
	INY					;$02DE99	|
	INY					;$02DE9A	|
	INX					;$02DE9B	|
	DEC $05					;$02DE9C	|
	BPL CODE_02DE5B				;$02DE9E	|
	PLX					;$02DEA0	|
	LDY.b #$FF				;$02DEA1	|
	LDA.b #$03				;$02DEA3	|
	JMP CODE_02B7A7				;$02DEA5	|

SumosLightningMain:
	PHB
	PHK					;$02DEA9	|
	PLB					;$02DEAA	|
	JSR CODE_02DEB0				;$02DEAB	|
	PLB					;$02DEAE	|
	RTL					;$02DEAF	|

CODE_02DEB0:
	LDA.w $1540,X
	BNE CODE_02DEFC				;$02DEB3	|
	LDA.b #$30				;$02DEB5	|
	STA $AA,X				;$02DEB7	|
	JSR UpdateYPosNoGrvtyB1			;$02DEB9	|
	LDA.w $1FE2,X				;$02DEBC	|
	BNE CODE_02DEEA				;$02DEBF	|
	JSL CODE_019138				;$02DEC1	|
	LDA.w $1588,X				;$02DEC5	|
	AND.b #$04				;$02DEC8	|
	BEQ CODE_02DEEA				;$02DECA	|
	LDA.b #$17				;$02DECC	|
	STA.w $1DFC				;$02DECE	|
	LDA.b #$22				;$02DED1	|
	STA.w $1540,X				;$02DED3	|
	LDA.w $15A0,X				;$02DED6	|
	ORA.w $186C,X				;$02DED9	|
	BNE CODE_02DEEA				;$02DEDC	|
	LDA $E4,X				;$02DEDE	|
	STA $9A					;$02DEE0	|
	LDA $D8,X				;$02DEE2	|
	STA $98					;$02DEE4	|
	JSL CODE_028A44				;$02DEE6	|
CODE_02DEEA:
	LDA.b #$00
	JSL GenericSprGfxRt0			;$02DEEC	|
	LDY.w $15EA,X				;$02DEF0	|
	LDA.w $0307,Y				;$02DEF3	|
	EOR.b #$C0				;$02DEF6	|
	STA.w $0307,Y				;$02DEF8	|
	RTS					;$02DEFB	|

CODE_02DEFC:
	STA $02
	CMP.b #$01				;$02DEFE	|
	BNE CODE_02DF05				;$02DF00	|
	STZ.w $14C8,X				;$02DF02	|
CODE_02DF05:
	AND.b #$0F
	CMP.b #$01				;$02DF07	|
	BNE Return02DF21			;$02DF09	|
	STA.w $18B8				;$02DF0B	|
	JSR CODE_02DF2C				;$02DF0E	|
	INC.w $1570,X				;$02DF11	|
	LDA.w $1570,X				;$02DF14	|
	CMP.b #$01				;$02DF17	|
	BEQ Return02DF21			;$02DF19	|
	JSR CODE_02DF2C				;$02DF1B	|
	INC.w $1570,X				;$02DF1E	|
Return02DF21:
	RTS

DATA_02DF22:
	db $FC,$0C,$EC,$1C,$DC

DATA_02DF27:
	db $FF,$00,$FF,$00,$FF

CODE_02DF2C:
	LDA $E4,X
	STA $00					;$02DF2E	|
	LDA.w $14E0,X				;$02DF30	|
	STA $01					;$02DF33	|
	LDY.b #$09				;$02DF35	|
CODE_02DF37:
	LDA.w $1892,Y
	BEQ CODE_02DF4C				;$02DF3A	|
	DEY					;$02DF3C	|
	BPL CODE_02DF37				;$02DF3D	|
	DEC.w $191D				;$02DF3F	|
	BPL CODE_02DF49				;$02DF42	|
	LDA.b #$09				;$02DF44	|
	STA.w $191D				;$02DF46	|
CODE_02DF49:
	LDY.w $191D
CODE_02DF4C:
	PHX
	LDA.w $1570,X				;$02DF4D	|
	TAX					;$02DF50	|
	LDA $00					;$02DF51	|
	CLC					;$02DF53	|
	ADC.w DATA_02DF22,X			;$02DF54	|
	STA.w $1E16,Y				;$02DF57	|
	LDA $01					;$02DF5A	|
	ADC.w DATA_02DF27,X			;$02DF5C	|
	STA.w $1E3E,Y				;$02DF5F	|
	PLX					;$02DF62	|
	LDA $D8,X				;$02DF63	|
	SEC					;$02DF65	|
	SBC.b #$10				;$02DF66	|
	STA.w $1E02,Y				;$02DF68	|
	LDA.w $14D4,X				;$02DF6B	|
	SEC					;$02DF6E	|
	SBC.b #$00				;$02DF6F	|
	STA.w $1E2A,Y				;$02DF71	|
	LDA.b #$7F				;$02DF74	|
	STA.w $0F4A,Y				;$02DF76	|
	LDA.w $1E16,Y				;$02DF79	|
	CMP $1A					;$02DF7C	|
	LDA.w $1E3E,Y				;$02DF7E	|
	SBC $1B					;$02DF81	|
	BNE Return02DF8A			;$02DF83	|
	LDA.b #$06				;$02DF85	|
	STA.w $1892,Y				;$02DF87	|
Return02DF8A:
	RTS

VolcanoLotusMain:
	PHB
	PHK					;$02DF8C	|
	PLB					;$02DF8D	|
	JSR CODE_02DF93				;$02DF8E	|
	PLB					;$02DF91	|
	RTL					;$02DF92	|

CODE_02DF93:
	JSR VolcanoLotusGfx
	LDA $9D					;$02DF96	|
	BNE Return02DFC8			;$02DF98	|
	STZ.w $151C,X				;$02DF9A	|
	JSL SprSprPMarioSprRts			;$02DF9D	|
	JSR SubOffscreen0Bnk2			;$02DFA1	|
	JSR UpdateYPosNoGrvtyB1			;$02DFA4	|
	LDA $AA,X				;$02DFA7	|
	CMP.b #$40				;$02DFA9	|
	BPL CODE_02DFAF				;$02DFAB	|
	INC $AA,X				;$02DFAD	|
CODE_02DFAF:
	JSL CODE_019138
	LDA.w $1588,X				;$02DFB3	|
	AND.b #$04				;$02DFB6	|
	BEQ CODE_02DFBC				;$02DFB8	|
	STZ $AA,X				;$02DFBA	|
CODE_02DFBC:
	LDA $C2,X
	JSL execute_pointer			;$02DFBE	|

VolcanoLotusPtrs:
	dw CODE_02DFC9
	dw CODE_02DFDF
	dw CODE_02DFEF

Return02DFC8:
	RTS

CODE_02DFC9:
	LDA.w $1540,X
	BNE CODE_02DFD6				;$02DFCC	|
	LDA.b #$40				;$02DFCE	|
CODE_02DFD0:
	STA.w $1540,X
	INC $C2,X				;$02DFD3	|
	RTS					;$02DFD5	|

CODE_02DFD6:
	LSR
	LSR					;$02DFD7	|
	LSR					;$02DFD8	|
	AND.b #$01				;$02DFD9	|
	STA.w $1602,X				;$02DFDB	|
	RTS					;$02DFDE	|

CODE_02DFDF:
	LDA.w $1540,X
	BNE CODE_02DFE8				;$02DFE2	|
	LDA.b #$40				;$02DFE4	|
	BRA CODE_02DFD0				;$02DFE6	|

CODE_02DFE8:
	LSR
	AND.b #$01				;$02DFE9	|
	STA.w $151C,X				;$02DFEB	|
	RTS					;$02DFEE	|

CODE_02DFEF:
	LDA.w $1540,X
	BNE CODE_02DFFB				;$02DFF2	|
	LDA.b #$80				;$02DFF4	|
	JSR CODE_02DFD0				;$02DFF6	|
	STZ $C2,X				;$02DFF9	|
CODE_02DFFB:
	CMP.b #$38
	BNE CODE_02E002				;$02DFFD	|
	JSR CODE_02E079				;$02DFFF	|
CODE_02E002:
	LDA.b #$02
	STA.w $1602,X				;$02E004	|
	RTS					;$02E007	|

VolcanoLotusTiles:
	db $8E,$9E,$E2

VolcanoLotusGfx:
	JSR MushroomScaleGfx
	LDY.w $15EA,X				;$02E00E	|
	LDA.b #$CE				;$02E011	|
	STA.w $0302,Y				;$02E013	|
	STA.w $0306,Y				;$02E016	|
	LDA.w $0303,Y				;$02E019	|
	AND.b #$30				;$02E01C	|
	ORA.b #$0B				;$02E01E	|
	STA.w $0303,Y				;$02E020	|
	ORA.b #$40				;$02E023	|
	STA.w $0307,Y				;$02E025	|
	LDA.w $0300,Y				;$02E028	|
	CLC					;$02E02B	|
	ADC.b #$08				;$02E02C	|
	STA.w $0308,Y				;$02E02E	|
	CLC					;$02E031	|
	ADC.b #$08				;$02E032	|
	STA.w $030C,Y				;$02E034	|
	LDA.w $0301,Y				;$02E037	|
	STA.w $0309,Y				;$02E03A	|
	STA.w $030D,Y				;$02E03D	|
	PHX					;$02E040	|
	LDA.w $1602,X				;$02E041	|
	TAX					;$02E044	|
	LDA.w VolcanoLotusTiles,X		;$02E045	|
	STA.w $030A,Y				;$02E048	|
	INC A					;$02E04B	|
	STA.w $030E,Y				;$02E04C	|
	PLX					;$02E04F	|
	LDA.w $151C,X				;$02E050	|
	CMP.b #$01				;$02E053	|
	LDA.b #$39				;$02E055	|
	BCC CODE_02E05B				;$02E057	|
	LDA.b #$35				;$02E059	|
CODE_02E05B:
	STA.w $030B,Y
	STA.w $030F,Y				;$02E05E	|
	LDA.w $15EA,X				;$02E061	|
	CLC					;$02E064	|
	ADC.b #$08				;$02E065	|
	STA.w $15EA,X				;$02E067	|
	LDY.b #$00				;$02E06A	|
	LDA.b #$01				;$02E06C	|
	JMP CODE_02B7A7				;$02E06E	|

DATA_02E071:
	db $10,$F0,$06,$FA

DATA_02E075:
	db $EC,$EC,$E8,$E8

CODE_02E079:
	LDA.w $15A0,X
	ORA.w $186C,X				;$02E07C	|
	BNE Return02E0C4			;$02E07F	|
	LDA.b #$03				;$02E081	|
	STA $00					;$02E083	|
CODE_02E085:
	LDY.b #$07
CODE_02E087:
	LDA.w $170B,Y
	BEQ CODE_02E090				;$02E08A	|
	DEY					;$02E08C	|
	BPL CODE_02E087				;$02E08D	|
	RTS					;$02E08F	|

CODE_02E090:
	LDA.b #$0C
	STA.w $170B,Y				;$02E092	|
	LDA $E4,X				;$02E095	|
	CLC					;$02E097	|
	ADC.b #$04				;$02E098	|
	STA.w $171F,Y				;$02E09A	|
	LDA.w $14E0,X				;$02E09D	|
	ADC.b #$00				;$02E0A0	|
	STA.w $1733,Y				;$02E0A2	|
	LDA $D8,X				;$02E0A5	|
	STA.w $1715,Y				;$02E0A7	|
	LDA.w $14D4,X				;$02E0AA	|
	STA.w $1729,Y				;$02E0AD	|
	PHX					;$02E0B0	|
	LDX $00					;$02E0B1	|
	LDA.w DATA_02E071,X			;$02E0B3	|
	STA.w $1747,Y				;$02E0B6	|
	LDA.w DATA_02E075,X			;$02E0B9	|
	STA.w $173D,Y				;$02E0BC	|
	PLX					;$02E0BF	|
	DEC $00					;$02E0C0	|
	BPL CODE_02E085				;$02E0C2	|
Return02E0C4:
	RTS

JumpingPiranhaMain:
	PHB
	PHK					;$02E0C6	|
	PLB					;$02E0C7	|
	JSR CODE_02E0CD				;$02E0C8	|
	PLB					;$02E0CB	|
	RTL					;$02E0CC	|

CODE_02E0CD:
	JSL LoadSpriteTables
	LDA $64					;$02E0D1	|
	PHA					;$02E0D3	|
	LDA.b #$10				;$02E0D4	|
	STA $64					;$02E0D6	|
	LDA.w $1570,X				;$02E0D8	|
	AND.b #$08				;$02E0DB	|
	LSR					;$02E0DD	|
	LSR					;$02E0DE	|
	EOR.b #$02				;$02E0DF	|
	STA.w $1602,X				;$02E0E1	|
	JSL GenericSprGfxRt2			;$02E0E4	|
	LDA.w $15EA,X				;$02E0E8	|
	CLC					;$02E0EB	|
	ADC.b #$04				;$02E0EC	|
	STA.w $15EA,X				;$02E0EE	|
	LDA.w $151C,X				;$02E0F1	|
	AND.b #$04				;$02E0F4	|
	LSR					;$02E0F6	|
	LSR					;$02E0F7	|
	INC A					;$02E0F8	|
	STA.w $1602,X				;$02E0F9	|
	LDA $D8,X				;$02E0FC	|
	PHA					;$02E0FE	|
	CLC					;$02E0FF	|
	ADC.b #$08				;$02E100	|
	STA $D8,X				;$02E102	|
	LDA.w $14D4,X				;$02E104	|
	PHA					;$02E107	|
	ADC.b #$00				;$02E108	|
	STA.w $14D4,X				;$02E10A	|
	LDA.b #$0A				;$02E10D	|
	STA.w $15F6,X				;$02E10F	|
	LDA.b #$01				;$02E112	|
	JSL GenericSprGfxRt0			;$02E114	|
	PLA					;$02E118	|
	STA.w $14D4,X				;$02E119	|
	PLA					;$02E11C	|
	STA $D8,X				;$02E11D	|
	PLA					;$02E11F	|
	STA $64					;$02E120	|
	LDA $9D					;$02E122	|
	BNE Return02E158			;$02E124	|
	JSR SubOffscreen0Bnk2			;$02E126	|
	JSL SprSprPMarioSprRts			;$02E129	|
	JSR UpdateYPosNoGrvtyB1			;$02E12D	|
	LDA $C2,X				;$02E130	|
	JSL execute_pointer			;$02E132	|

JumpingPiranhaPtrs:
	dw CODE_02E13C
	dw CODE_02E159
	dw CODE_02E177

CODE_02E13C:
	STZ $AA,X
	LDA.w $1540,X				;$02E13E	|
	BNE Return02E158			;$02E141	|
	JSR CODE_02D4FA				;$02E143	|
	LDA $0F					;$02E146	|
	CLC					;$02E148	|
	ADC.b #$1B				;$02E149	|
	CMP.b #$37				;$02E14B	|
	BCC Return02E158			;$02E14D	|
	LDA.b #$C0				;$02E14F	|
	STA $AA,X				;$02E151	|
	INC $C2,X				;$02E153	|
	STZ.w $1602,X				;$02E155	|
Return02E158:
	RTS

CODE_02E159:
	LDA $AA,X
	BMI CODE_02E161				;$02E15B	|
	CMP.b #$40				;$02E15D	|
	BCS CODE_02E166				;$02E15F	|
CODE_02E161:
	CLC
	ADC.b #$02				;$02E162	|
	STA $AA,X				;$02E164	|
CODE_02E166:
	INC.w $1570,X
	LDA $AA,X				;$02E169	|
	CMP.b #$F0				;$02E16B	|
	BMI Return02E176			;$02E16D	|
	LDA.b #$50				;$02E16F	|
	STA.w $1540,X				;$02E171	|
	INC $C2,X				;$02E174	|
Return02E176:
	RTS

CODE_02E177:
	INC.w $151C,X
	LDA.w $1540,X				;$02E17A	|
	BNE CODE_02E1A4				;$02E17D	|
CODE_02E17F:
	INC.w $1570,X
	LDA $14					;$02E182	|
	AND.b #$03				;$02E184	|
	BNE CODE_02E191				;$02E186	|
	LDA $AA,X				;$02E188	|
	CMP.b #$08				;$02E18A	|
	BPL CODE_02E191				;$02E18C	|
	INC A					;$02E18E	|
	STA $AA,X				;$02E18F	|
CODE_02E191:
	JSL CODE_019138
	LDA.w $1588,X				;$02E195	|
	AND.b #$04				;$02E198	|
	BEQ Return02E176			;$02E19A	|
	STZ $C2,X				;$02E19C	|
	LDA.b #$40				;$02E19E	|
	STA.w $1540,X				;$02E1A0	|
	RTS					;$02E1A3	|

CODE_02E1A4:
	LDY $9E,X
	CPY.b #$50				;$02E1A6	|
	BNE CODE_02E1F7				;$02E1A8	|
	STZ.w $1570,X				;$02E1AA	|
	CMP.b #$40				;$02E1AD	|
	BNE CODE_02E1F7				;$02E1AF	|
	LDA.w $15A0,X				;$02E1B1	|
	ORA.w $186C,X				;$02E1B4	|
	BNE CODE_02E1F7				;$02E1B7	|
	LDA.b #$10				;$02E1B9	|
	JSR CODE_02E1C0				;$02E1BB	|
	LDA.b #$F0				;$02E1BE	|
CODE_02E1C0:
	STA $00
	LDY.b #$07				;$02E1C2	|
CODE_02E1C4:
	LDA.w $170B,Y
	BEQ CODE_02E1CD				;$02E1C7	|
	DEY					;$02E1C9	|
	BPL CODE_02E1C4				;$02E1CA	|
	RTS					;$02E1CC	|

CODE_02E1CD:
	LDA.b #$0B
	STA.w $170B,Y				;$02E1CF	|
	LDA $E4,X				;$02E1D2	|
	CLC					;$02E1D4	|
	ADC.b #$04				;$02E1D5	|
	STA.w $171F,Y				;$02E1D7	|
	LDA.w $14E0,X				;$02E1DA	|
	ADC.b #$00				;$02E1DD	|
	STA.w $1733,Y				;$02E1DF	|
	LDA $D8,X				;$02E1E2	|
	STA.w $1715,Y				;$02E1E4	|
	LDA.w $14D4,X				;$02E1E7	|
	STA.w $1729,Y				;$02E1EA	|
	LDA.b #$D0				;$02E1ED	|
	STA.w $173D,Y				;$02E1EF	|
	LDA $00					;$02E1F2	|
	STA.w $1747,Y				;$02E1F4	|
CODE_02E1F7:
	BRA CODE_02E17F

DATA_02E1F9:
	db $00,$00,$F0,$10

DATA_02E1FD:
	db $F0,$10,$00,$00

DATA_02E201:
	db $00,$03,$02,$00,$01,$03,$02,$00
	db $00,$03,$02,$00,$00,$00,$00,$00
DATA_02E211:
	db $01,$00,$03,$02

DirectionCoinsMain:
	PHB
	PHK					;$02E216	|
	PLB					;$02E217	|
	JSR CODE_02E21D				;$02E218	|
	PLB					;$02E21B	|
	RTL					;$02E21C	|

CODE_02E21D:
	LDA $64
	PHA					;$02E21F	|
	LDA.w $1540,X				;$02E220	|
	CMP.b #$30				;$02E223	|
	BCC CODE_02E22B				;$02E225	|
	LDA.b #$10				;$02E227	|
	STA $64					;$02E229	|
CODE_02E22B:
	LDA $1C
	PHA					;$02E22D	|
	CLC					;$02E22E	|
	ADC.b #$01				;$02E22F	|
	STA $1C					;$02E231	|
	LDA $1D					;$02E233	|
	PHA					;$02E235	|
	ADC.b #$00				;$02E236	|
	STA $1D					;$02E238	|
	LDA.w $14AD				;$02E23A	|
	BNE CODE_02E245				;$02E23D	|
	JSL CoinSprGfx				;$02E23F	|
	BRA CODE_02E259				;$02E243	|

CODE_02E245:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$02E249	|
	LDA.b #$2E				;$02E24C	|
	STA.w $0302,Y				;$02E24E	|
	LDA.w $0303,Y				;$02E251	|
	AND.b #$3F				;$02E254	|
	STA.w $0303,Y				;$02E256	|
CODE_02E259:
	PLA
	STA $1D					;$02E25A	|
	PLA					;$02E25C	|
	STA $1C					;$02E25D	|
	PLA					;$02E25F	|
	STA $64					;$02E260	|
	LDA $9D					;$02E262	|
	BNE CODE_02E2DE				;$02E264	|
	LDA $13					;$02E266	|
	AND.b #$03				;$02E268	|
	BNE CODE_02E288				;$02E26A	|
	DEC.w $190C				;$02E26C	|
	BNE CODE_02E288				;$02E26F	|
CODE_02E271:
	STZ.w $190C
	STZ.w $14C8,X				;$02E274	|
	LDA.w $14AD				;$02E277	|
	ORA.w $14AE				;$02E27A	|
	BNE Return02E287			;$02E27D	|
	LDA.w $0DDA				;$02E27F	|
	BMI Return02E287			;$02E282	|
	STA.w $1DFB				;$02E284	|
Return02E287:
	RTS

CODE_02E288:
	LDY $C2,X
	LDA.w DATA_02E1F9,Y			;$02E28A	|
	STA $B6,X				;$02E28D	|
	LDA.w DATA_02E1FD,Y			;$02E28F	|
	STA $AA,X				;$02E292	|
	JSR UpdateYPosNoGrvtyB1			;$02E294	|
	JSR UpdateXPosNoGrvtyB1			;$02E297	|
	LDA $15					;$02E29A	|
	AND.b #$0F				;$02E29C	|
	BEQ CODE_02E2B0				;$02E29E	|
	TAY					;$02E2A0	|
	LDA.w DATA_02E201,Y			;$02E2A1	|
	TAY					;$02E2A4	|
	LDA.w DATA_02E211,Y			;$02E2A5	|
	CMP $C2,X				;$02E2A8	|
	BEQ CODE_02E2B0				;$02E2AA	|
	TYA					;$02E2AC	|
	STA.w $151C,X				;$02E2AD	|
CODE_02E2B0:
	LDA $D8,X
	AND.b #$0F				;$02E2B2	|
	STA $00					;$02E2B4	|
	LDA $E4,X				;$02E2B6	|
	AND.b #$0F				;$02E2B8	|
	ORA $00					;$02E2BA	|
	BNE CODE_02E2DE				;$02E2BC	|
	LDA.w $151C,X				;$02E2BE	|
	STA $C2,X				;$02E2C1	|
	LDA $E4,X				;$02E2C3	|
	STA $9A					;$02E2C5	|
	LDA.w $14E0,X				;$02E2C7	|
	STA $9B					;$02E2CA	|
	LDA $D8,X				;$02E2CC	|
	STA $98					;$02E2CE	|
	LDA.w $14D4,X				;$02E2D0	|
	STA $99					;$02E2D3	|
	LDA.b #$06				;$02E2D5	|
	STA $9C					;$02E2D7	|
	JSL generate_tile			;$02E2D9	|
	RTS					;$02E2DD	|

CODE_02E2DE:
	JSL CODE_019138
	LDA $B6,X				;$02E2E2	|
	BNE CODE_02E2F3				;$02E2E4	|
	LDA.w $18D7				;$02E2E6	|
	BNE CODE_02E2FF				;$02E2E9	|
	LDA.w $185F				;$02E2EB	|
	CMP.b #$25				;$02E2EE	|
	BNE CODE_02E2FF				;$02E2F0	|
	RTS					;$02E2F2	|

CODE_02E2F3:
	LDA.w $1862
	BNE CODE_02E2FF				;$02E2F6	|
	LDA.w $1860				;$02E2F8	|
	CMP.b #$25				;$02E2FB	|
	BEQ Return02E302			;$02E2FD	|
CODE_02E2FF:
	JSR CODE_02E271
Return02E302:
	RTS

GasBubbleMain:
	PHB
	PHK					;$02E304	|
	PLB					;$02E305	|
	JSR CODE_02E311				;$02E306	|
	PLB					;$02E309	|
	RTL					;$02E30A	|

DATA_02E30B:
	db $10,$F0

DATA_02E30D:
	db $01,$FF

DATA_02E30F:
	db $10,$F0

CODE_02E311:
	JSR GasBubbleGfx
	LDA $9D					;$02E314	|
	BNE Return02E351			;$02E316	|
	LDA.w $14C8,X				;$02E318	|
	CMP.b #$08				;$02E31B	|
	BNE Return02E351			;$02E31D	|
	LDY.w $157C,X				;$02E31F	|
	LDA.w DATA_02E30B,Y			;$02E322	|
	STA $B6,X				;$02E325	|
	JSR UpdateXPosNoGrvtyB1			;$02E327	|
	LDA $13					;$02E32A	|
	AND.b #$03				;$02E32C	|
	BNE CODE_02E344				;$02E32E	|
	LDA $C2,X				;$02E330	|
	AND.b #$01				;$02E332	|
	TAY					;$02E334	|
	LDA $AA,X				;$02E335	|
	CLC					;$02E337	|
	ADC.w DATA_02E30D,Y			;$02E338	|
	STA $AA,X				;$02E33B	|
	CMP.w DATA_02E30F,Y			;$02E33D	|
	BNE CODE_02E344				;$02E340	|
	INC $C2,X				;$02E342	|
CODE_02E344:
	JSR UpdateYPosNoGrvtyB1
	INC.w $1570,X				;$02E347	|
	JSR SubOffscreen0Bnk2			;$02E34A	|
	JSL MarioSprInteract			;$02E34D	|
Return02E351:
	RTS

DATA_02E352:
	db $00,$10,$20,$30,$00,$10,$20,$30
	db $00,$10,$20,$30,$00,$10,$20,$30
DATA_02E362:
	db $00,$00,$00,$00,$10,$10,$10,$10
	db $20,$20,$20,$20,$30,$30,$30,$30
DATA_02E372:
	db $80,$82,$84,$86,$A0,$A2,$A4,$A6
	db $A0,$A2,$A4,$A6,$80,$82,$84,$86
DATA_02E382:
	db $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
	db $BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB
DATA_02E392:
	db $00,$00,$02,$02,$00,$00,$02,$02
	db $01,$01,$03,$03,$01,$01,$03,$03
DATA_02E3A2:
	db $00,$01,$02,$01

DATA_02E3A6:
	db $02,$01,$00,$01

GasBubbleGfx:
	JSR GetDrawInfo2
	LDA.w $1570,X				;$02E3AD	|
	LSR					;$02E3B0	|
	LSR					;$02E3B1	|
	LSR					;$02E3B2	|
	AND.b #$03				;$02E3B3	|
	TAY					;$02E3B5	|
	LDA.w DATA_02E3A2,Y			;$02E3B6	|
	STA $02					;$02E3B9	|
	LDA.w DATA_02E3A6,Y			;$02E3BB	|
	STA $03					;$02E3BE	|
	LDY.w $15EA,X				;$02E3C0	|
	PHX					;$02E3C3	|
	LDX.b #$0F				;$02E3C4	|
CODE_02E3C6:
	LDA $00
	CLC					;$02E3C8	|
	ADC.w DATA_02E352,X			;$02E3C9	|
	PHA					;$02E3CC	|
	LDA.w DATA_02E392,X			;$02E3CD	|
	AND.b #$02				;$02E3D0	|
	BNE CODE_02E3DA				;$02E3D2	|
	PLA					;$02E3D4	|
	CLC					;$02E3D5	|
	ADC $02					;$02E3D6	|
	BRA CODE_02E3DE				;$02E3D8	|

CODE_02E3DA:
	PLA
	SEC					;$02E3DB	|
	SBC $02					;$02E3DC	|
CODE_02E3DE:
	STA.w $0300,Y
	LDA $01					;$02E3E1	|
	CLC					;$02E3E3	|
	ADC.w DATA_02E362,X			;$02E3E4	|
	PHA					;$02E3E7	|
	LDA.w DATA_02E392,X			;$02E3E8	|
	AND.b #$01				;$02E3EB	|
	BNE CODE_02E3F5				;$02E3ED	|
	PLA					;$02E3EF	|
	CLC					;$02E3F0	|
	ADC $03					;$02E3F1	|
	BRA CODE_02E3F9				;$02E3F3	|

CODE_02E3F5:
	PLA
	SEC					;$02E3F6	|
	SBC $03					;$02E3F7	|
CODE_02E3F9:
	STA.w $0301,Y
	LDA.w DATA_02E372,X			;$02E3FC	|
	STA.w $0302,Y				;$02E3FF	|
	LDA.w DATA_02E382,X			;$02E402	|
	STA.w $0303,Y				;$02E405	|
	INY					;$02E408	|
	INY					;$02E409	|
	INY					;$02E40A	|
	INY					;$02E40B	|
	DEX					;$02E40C	|
	BPL CODE_02E3C6				;$02E40D	|
	PLX					;$02E40F	|
	LDY.b #$02				;$02E410	|
	LDA.b #$0F				;$02E412	|
	JMP CODE_02B7A7				;$02E414	|

ExplodingBlkMain:
	PHB
	PHK					;$02E418	|
	PLB					;$02E419	|
	JSR CODE_02E41F				;$02E41A	|
	PLB					;$02E41D	|
	RTL					;$02E41E	|

CODE_02E41F:
	JSL GenericSprGfxRt2
	LDA $9D					;$02E423	|
	BNE Return02E462			;$02E425	|
	BRA CODE_02E42D				;$02E427	|

	JSL ADDR_02C0CF				;$02E429	|
CODE_02E42D:
	LDY.b #$00
	INC.w $1570,X				;$02E42F	|
	LDA.w $1570,X				;$02E432	|
	AND.b #$40				;$02E435	|
	BEQ CODE_02E444				;$02E437	|
	LDY.b #$04				;$02E439	|
	LDA.w $1570,X				;$02E43B	|
	AND.b #$04				;$02E43E	|
	BEQ CODE_02E444				;$02E440	|
	LDY.b #$FC				;$02E442	|
CODE_02E444:
	STY $B6,X
	JSR UpdateXPosNoGrvtyB1			;$02E446	|
	JSL SprSprPMarioSprRts			;$02E449	|
	JSR CODE_02D4FA				;$02E44D	|
	LDA $0F					;$02E450	|
	CLC					;$02E452	|
	ADC.b #$60				;$02E453	|
	CMP.b #$C0				;$02E455	|
	BCS Return02E462			;$02E457	|
	LDY.w $15A0,X				;$02E459	|
	BNE Return02E462			;$02E45C	|
	JSL CODE_02E463				;$02E45E	|
Return02E462:
	RTS

CODE_02E463:
	LDA $C2,X
	STA $9E,X				;$02E465	|
	JSL InitSpriteTables			;$02E467	|
	LDA.b #$D0				;$02E46B	|
	STA $AA,X				;$02E46D	|
	JSR CODE_02D4FA				;$02E46F	|
	TYA					;$02E472	|
	STA.w $157C,X				;$02E473	|
	LDA $E4,X				;$02E476	|
	STA $9A					;$02E478	|
	LDA.w $14E0,X				;$02E47A	|
	STA $9B					;$02E47D	|
	LDA $D8,X				;$02E47F	|
	STA $98					;$02E481	|
	LDA.w $14D4,X				;$02E483	|
	STA $99					;$02E486	|
	PHB					;$02E488	|
	LDA.b #$02				;$02E489	|
	PHA					;$02E48B	|
	PLB					;$02E48C	|
	LDA.b #$00				;$02E48D	|
	JSL ShatterBlock			;$02E48F	|
	PLB					;$02E493	|
	RTL					;$02E494	|

ScalePlatformMain:
	LDA.w $15EA,X
	PHA					;$02E498	|
	PHB					;$02E499	|
	PHK					;$02E49A	|
	PLB					;$02E49B	|
	JSR CODE_02E4A5				;$02E49C	|
	PLB					;$02E49F	|
	PLA					;$02E4A0	|
	STA.w $15EA,X				;$02E4A1	|
	RTL					;$02E4A4	|

CODE_02E4A5:
	JSR SubOffscreen2Bnk2
	STZ.w $185E				;$02E4A8	|
	LDA $E4,X				;$02E4AB	|
	PHA					;$02E4AD	|
	LDA.w $14E0,X				;$02E4AE	|
	PHA					;$02E4B1	|
	LDA $D8,X				;$02E4B2	|
	PHA					;$02E4B4	|
	LDA.w $14D4,X				;$02E4B5	|
	PHA					;$02E4B8	|
	LDA.w $151C,X				;$02E4B9	|
	STA.w $14D4,X				;$02E4BC	|
	LDA.w $1534,X				;$02E4BF	|
	STA $D8,X				;$02E4C2	|
	LDA $C2,X				;$02E4C4	|
	STA $E4,X				;$02E4C6	|
	LDA.w $1602,X				;$02E4C8	|
	STA.w $14E0,X				;$02E4CB	|
	LDY.b #$02				;$02E4CE	|
	JSR CODE_02E524				;$02E4D0	|
	PLA					;$02E4D3	|
	STA.w $14D4,X				;$02E4D4	|
	PLA					;$02E4D7	|
	STA $D8,X				;$02E4D8	|
	PLA					;$02E4DA	|
	STA.w $14E0,X				;$02E4DB	|
	PLA					;$02E4DE	|
	STA $E4,X				;$02E4DF	|
	BCC CODE_02E4EB				;$02E4E1	|
	INC.w $185E				;$02E4E3	|
	LDA.b #$F8				;$02E4E6	|
	JSR CODE_02E559				;$02E4E8	|
CODE_02E4EB:
	LDA.w $15EA,X
	CLC					;$02E4EE	|
	ADC.b #$08				;$02E4EF	|
	STA.w $15EA,X				;$02E4F1	|
	LDY.b #$00				;$02E4F4	|
	JSR CODE_02E524				;$02E4F6	|
	BCC CODE_02E503				;$02E4F9	|
	INC.w $185E				;$02E4FB	|
	LDA.b #$08				;$02E4FE	|
	JSR CODE_02E559				;$02E500	|
CODE_02E503:
	LDA.w $185E
	BNE Return02E51F			;$02E506	|
	LDY.b #$02				;$02E508	|
	LDA $D8,X				;$02E50A	|
	CMP.w $1534,X				;$02E50C	|
	BEQ Return02E51F			;$02E50F	|
	LDA.w $14D4,X				;$02E511	|
	SBC.w $151C,X				;$02E514	|
	BMI CODE_02E51B				;$02E517	|
	LDY.b #$FE				;$02E519	|
CODE_02E51B:
	TYA
	JSR CODE_02E559				;$02E51C	|
Return02E51F:
	RTS

MushrmScaleTiles:
	db $02,$07,$07,$02

CODE_02E524:
	LDA $D8,X
	AND.b #$0F				;$02E526	|
	BNE CODE_02E54E				;$02E528	|
	LDA $AA,X				;$02E52A	|
	BEQ CODE_02E54E				;$02E52C	|
	LDA $AA,X				;$02E52E	|
	BPL CODE_02E533				;$02E530	|
	INY					;$02E532	|
CODE_02E533:
	LDA.w MushrmScaleTiles,Y
	STA $9C					;$02E536	|
	LDA $E4,X				;$02E538	|
	STA $9A					;$02E53A	|
	LDA.w $14E0,X				;$02E53C	|
	STA $9B					;$02E53F	|
	LDA $D8,X				;$02E541	|
	STA $98					;$02E543	|
	LDA.w $14D4,X				;$02E545	|
	STA $99					;$02E548	|
	JSL generate_tile			;$02E54A	|
CODE_02E54E:
	JSR MushroomScaleGfx
	STZ.w $1528,X				;$02E551	|
	JSL InvisBlkMainRt			;$02E554	|
	RTS					;$02E558	|

CODE_02E559:
	LDY $9D
	BNE Return02E57D			;$02E55B	|
	PHA					;$02E55D	|
	JSR UpdateYPosNoGrvtyB1			;$02E55E	|
	PLA					;$02E561	|
	STA $AA,X				;$02E562	|
	LDY.b #$00				;$02E564	|
	LDA.w $1491				;$02E566	|
	EOR.b #$FF				;$02E569	|
	INC A					;$02E56B	|
	BPL CODE_02E56F				;$02E56C	|
	DEY					;$02E56E	|
CODE_02E56F:
	CLC
	ADC.w $1534,X				;$02E570	|
	STA.w $1534,X				;$02E573	|
	TYA					;$02E576	|
	ADC.w $151C,X				;$02E577	|
	STA.w $151C,X				;$02E57A	|
Return02E57D:
	RTS

MushroomScaleGfx:
	JSR GetDrawInfo2
	LDA $00					;$02E581	|
	SEC					;$02E583	|
	SBC.b #$08				;$02E584	|
	STA.w $0300,Y				;$02E586	|
	CLC					;$02E589	|
	ADC.b #$10				;$02E58A	|
	STA.w $0304,Y				;$02E58C	|
	LDA $01					;$02E58F	|
	DEC A					;$02E591	|
	STA.w $0301,Y				;$02E592	|
	STA.w $0305,Y				;$02E595	|
	LDA.b #$80				;$02E598	|
	STA.w $0302,Y				;$02E59A	|
	STA.w $0306,Y				;$02E59D	|
	LDA.w $15F6,X				;$02E5A0	|
	ORA $64					;$02E5A3	|
	STA.w $0303,Y				;$02E5A5	|
	ORA.b #$40				;$02E5A8	|
	STA.w $0307,Y				;$02E5AA	|
	LDA.b #$01				;$02E5AD	|
	LDY.b #$02				;$02E5AF	|
	JMP CODE_02B7A7				;$02E5B1	|

MovingLedgeMain:
	PHB
	PHK					;$02E5B5	|
	PLB					;$02E5B6	|
	JSR CODE_02E5BC				;$02E5B7	|
	PLB					;$02E5BA	|
	RTL					;$02E5BB	|

CODE_02E5BC:
	JSR SubOffscreen0Bnk2
	LDA $9D					;$02E5BF	|
	BNE CODE_02E5D7				;$02E5C1	|
	INC.w $1570,X				;$02E5C3	|
	LDY.b #$10				;$02E5C6	|
	LDA.w $1570,X				;$02E5C8	|
	AND.b #$80				;$02E5CB	|
	BNE CODE_02E5D1				;$02E5CD	|
	LDY.b #$F0				;$02E5CF	|
CODE_02E5D1:
	TYA
	STA $B6,X				;$02E5D2	|
	JSR UpdateXPosNoGrvtyB1			;$02E5D4	|
CODE_02E5D7:
	JSR CODE_02E637
	JSR CODE_02E5F7				;$02E5DA	|
	LDA.w $185C				;$02E5DD	|
	BEQ CODE_02E5E8				;$02E5E0	|
	DEC A					;$02E5E2	|
	CMP.w $15E9				;$02E5E3	|
	BNE Return02E5F6			;$02E5E6	|
CODE_02E5E8:
	JSL MarioSprInteract
	STZ.w $185C				;$02E5EC	|
	BCC Return02E5F6			;$02E5EF	|
	INX					;$02E5F1	|
	STX.w $185C				;$02E5F2	|
	DEX					;$02E5F5	|
Return02E5F6:
	RTS

CODE_02E5F7:
	LDY.b #$0B
CODE_02E5F9:
	CPY.w $15E9
	BEQ CODE_02E633				;$02E5FC	|
	TYA					;$02E5FE	|
	EOR $13					;$02E5FF	|
	AND.b #$03				;$02E601	|
	BNE CODE_02E633				;$02E603	|
	LDA.w $14C8,Y				;$02E605	|
	CMP.b #$08				;$02E608	|
	BCC CODE_02E633				;$02E60A	|
	LDA.w $15DC,Y				;$02E60C	|
	BEQ CODE_02E617				;$02E60F	|
	DEC A					;$02E611	|
	CMP.w $15E9				;$02E612	|
	BNE CODE_02E633				;$02E615	|
CODE_02E617:
	TYX
	JSL GetSpriteClippingB			;$02E618	|
	LDX.w $15E9				;$02E61C	|
	JSL GetSpriteClippingA			;$02E61F	|
	JSL CheckForContact			;$02E623	|
	LDA.b #$00				;$02E627	|
	STA.w $15DC,Y				;$02E629	|
	BCC CODE_02E633				;$02E62C	|
	TXA					;$02E62E	|
	INC A					;$02E62F	|
	STA.w $15DC,Y				;$02E630	|
CODE_02E633:
	DEY
	BPL CODE_02E5F9				;$02E634	|
	RTS					;$02E636	|

CODE_02E637:
	JSR GetDrawInfo2
	PHX					;$02E63A	|
	LDX.b #$03				;$02E63B	|
CODE_02E63D:
	LDA $00
	CLC					;$02E63F	|
	ADC.w DATA_02E666,X			;$02E640	|
	STA.w $0300,Y				;$02E643	|
	LDA $01					;$02E646	|
	STA.w $0301,Y				;$02E648	|
	LDA.w MovingHoleTiles,X			;$02E64B	|
	STA.w $0302,Y				;$02E64E	|
	LDA.w DATA_02E66E,X			;$02E651	|
	STA.w $0303,Y				;$02E654	|
	INY					;$02E657	|
	INY					;$02E658	|
	INY					;$02E659	|
	INY					;$02E65A	|
	DEX					;$02E65B	|
	BPL CODE_02E63D				;$02E65C	|
	PLX					;$02E65E	|
	LDA.b #$03				;$02E65F	|
	LDY.b #$02				;$02E661	|
	JMP CODE_02B7A7				;$02E663	|

DATA_02E666:
	db $00,$08,$18,$20

MovingHoleTiles:
	db $EB,$EA,$EA,$EB

DATA_02E66E:
	db $71,$31,$31,$31

CODE_02E672:
	PHB
	PHK					;$02E673	|
	PLB					;$02E674	|
	JSR CODE_02E67A				;$02E675	|
	PLB					;$02E678	|
	RTL					;$02E679	|

CODE_02E67A:
	JSR GetDrawInfo2
	TYA					;$02E67D	|
	CLC					;$02E67E	|
	ADC.b #$08				;$02E67F	|
	STA.w $15EA,X				;$02E681	|
	TAY					;$02E684	|
	LDA $00					;$02E685	|
	SEC					;$02E687	|
	SBC.b #$0D				;$02E688	|
	STA.w $0300,Y				;$02E68A	|
	SEC					;$02E68D	|
	SBC.b #$08				;$02E68E	|
	STA.w $185E				;$02E690	|
	STA.w $0304,Y				;$02E693	|
	LDA $01					;$02E696	|
	CLC					;$02E698	|
	ADC.b #$02				;$02E699	|
	STA.w $0301,Y				;$02E69B	|
	STA.w $18B6				;$02E69E	|
	CLC					;$02E6A1	|
	ADC.b #$40				;$02E6A2	|
	STA.w $0305,Y				;$02E6A4	|
	LDA.b #$AA				;$02E6A7	|
	STA.w $0302,Y				;$02E6A9	|
	LDA.b #$24				;$02E6AC	|
	STA.w $0306,Y				;$02E6AE	|
	LDA.b #$35				;$02E6B1	|
	STA.w $0303,Y				;$02E6B3	|
	LDA.b #$3A				;$02E6B6	|
	STA.w $0307,Y				;$02E6B8	|
	LDA.b #$01				;$02E6BB	|
	LDY.b #$02				;$02E6BD	|
	JSR CODE_02B7A7				;$02E6BF	|
	LDA.w $15A0,X				;$02E6C2	|
	BNE CODE_02E6EB				;$02E6C5	|
	LDY.w $15EA,X				;$02E6C7	|
	LDA $7E					;$02E6CA	|
	SEC					;$02E6CC	|
	SBC.w $0304,Y				;$02E6CD	|
	CLC					;$02E6D0	|
	ADC.b #$0C				;$02E6D1	|
	CMP.b #$18				;$02E6D3	|
	BCS CODE_02E6EB				;$02E6D5	|
	LDA $80					;$02E6D7	|
	SEC					;$02E6D9	|
	SBC.w $0305,Y				;$02E6DA	|
	CLC					;$02E6DD	|
	ADC.b #$0C				;$02E6DE	|
	CMP.b #$18				;$02E6E0	|
	BCS CODE_02E6EB				;$02E6E2	|
	STZ.w $151C,X				;$02E6E4	|
	JSL CODE_00F388				;$02E6E7	|
CODE_02E6EB:
	PHX
	LDA.b #$38				;$02E6EC	|
	STA.w $15EA,X				;$02E6EE	|
	TAY					;$02E6F1	|
	LDX.b #$07				;$02E6F2	|
CODE_02E6F4:
	LDA.w $185E
	STA.w $0300,Y				;$02E6F7	|
	LDA.w $18B6				;$02E6FA	|
	STA.w $0301,Y				;$02E6FD	|
	CLC					;$02E700	|
	ADC.b #$08				;$02E701	|
	STA.w $18B6				;$02E703	|
	LDA.b #$89				;$02E706	|
	STA.w $0302,Y				;$02E708	|
	LDA.b #$35				;$02E70B	|
	STA.w $0303,Y				;$02E70D	|
	INY					;$02E710	|
	INY					;$02E711	|
	INY					;$02E712	|
	INY					;$02E713	|
	DEX					;$02E714	|
	BPL CODE_02E6F4				;$02E715	|
	PLX					;$02E717	|
	LDA.b #$07				;$02E718	|
	LDY.b #$00				;$02E71A	|
	JMP CODE_02B7A7				;$02E71C	|

SwimJumpFishMain:
	PHB
	PHK					;$02E720	|
	PLB					;$02E721	|
	JSR CODE_02E727				;$02E722	|
	PLB					;$02E725	|
	RTL					;$02E726	|

CODE_02E727:
	JSL GenericSprGfxRt2
	LDA $9D					;$02E72B	|
	BNE Return02E74B			;$02E72D	|
	JSR SubOffscreen0Bnk2			;$02E72F	|
	JSL SprSprPMarioSprRts			;$02E732	|
	JSL CODE_019138				;$02E736	|
	LDY.b #$00				;$02E73A	|
	JSR CODE_02EB3D				;$02E73C	|
	LDA $C2,X				;$02E73F	|
	AND.b #$01				;$02E741	|
	JSL execute_pointer			;$02E743	|

FishPtrs:
	dw CODE_02E74E
	dw CODE_02E788

Return02E74B:
	RTS

DATA_02E74C:
	db $14,$EC

CODE_02E74E:
	LDY.w $157C,X
	LDA.w DATA_02E74C,Y			;$02E751	|
	STA $B6,X				;$02E754	|
	JSR UpdateXPosNoGrvtyB1			;$02E756	|
	LDA.w $1540,X				;$02E759	|
	BNE Return02E77B			;$02E75C	|
	INC.w $1570,X				;$02E75E	|
	LDY.w $1570,X				;$02E761	|
	CPY.b #$04				;$02E764	|
	BEQ CODE_02E77C				;$02E766	|
	LDA.w $157C,X				;$02E768	|
	EOR.b #$01				;$02E76B	|
	STA.w $157C,X				;$02E76D	|
	LDA.b #$20				;$02E770	|
	CPY.b #$03				;$02E772	|
	BEQ CODE_02E778				;$02E774	|
	LDA.b #$40				;$02E776	|
CODE_02E778:
	STA.w $1540,X
Return02E77B:
	RTS

CODE_02E77C:
	INC $C2,X
	LDA.b #$80				;$02E77E	|
	STA.w $1540,X				;$02E780	|
	LDA.b #$A0				;$02E783	|
	STA $AA,X				;$02E785	|
	RTS					;$02E787	|

CODE_02E788:
	LDA.w $1540,X
	BEQ CODE_02E7A4				;$02E78B	|
	CMP.b #$70				;$02E78D	|
	BCS Return02E7A3			;$02E78F	|
	STZ $B6,X				;$02E791	|
	JSR UpdateYPosNoGrvtyB1			;$02E793	|
	LDA $AA,X				;$02E796	|
	BMI CODE_02E79E				;$02E798	|
	CMP.b #$30				;$02E79A	|
	BCS Return02E7A3			;$02E79C	|
CODE_02E79E:
	CLC
	ADC.b #$02				;$02E79F	|
	STA $AA,X				;$02E7A1	|
Return02E7A3:
	RTS

CODE_02E7A4:
	LDA $D8,X
	AND.b #$F0				;$02E7A6	|
	STA $D8,X				;$02E7A8	|
	INC $C2,X				;$02E7AA	|
	STZ.w $1570,X				;$02E7AC	|
	LDA.b #$20				;$02E7AF	|
	STA.w $1540,X				;$02E7B1	|
	RTS					;$02E7B4	|

ChucksRockMain:
	PHB
	PHK					;$02E7B6	|
	PLB					;$02E7B7	|
	JSR CODE_02E7BD				;$02E7B8	|
	PLB					;$02E7BB	|
	RTL					;$02E7BC	|

CODE_02E7BD:
	LDA $64
	PHA					;$02E7BF	|
	LDA.w $1540,X				;$02E7C0	|
	BEQ CODE_02E7C9				;$02E7C3	|
	LDA.b #$10				;$02E7C5	|
	STA $64					;$02E7C7	|
CODE_02E7C9:
	JSL GenericSprGfxRt2
	PLA					;$02E7CD	|
	STA $64					;$02E7CE	|
	LDA $9D					;$02E7D0	|
	BNE Return02E82C			;$02E7D2	|
	LDA.w $1540,X				;$02E7D4	|
	CMP.b #$08				;$02E7D7	|
	BCS Return02E82C			;$02E7D9	|
	LDY.b #$00				;$02E7DB	|
	LDA $13					;$02E7DD	|
	LSR					;$02E7DF	|
	JSR CODE_02EB3D				;$02E7E0	|
	JSR SubOffscreen0Bnk2			;$02E7E3	|
	JSL UpdateSpritePos			;$02E7E6	|
	LDA.w $1540,X				;$02E7EA	|
	BNE CODE_02E828				;$02E7ED	|
	LDA.w $1588,X				;$02E7EF	|
	AND.b #$03				;$02E7F2	|
	BEQ CODE_02E7FD				;$02E7F4	|
	LDA $B6,X				;$02E7F6	|
	EOR.b #$FF				;$02E7F8	|
	INC A					;$02E7FA	|
	STA $B6,X				;$02E7FB	|
CODE_02E7FD:
	LDA.w $1588,X
	AND.b #$08				;$02E800	|
	BEQ CODE_02E808				;$02E802	|
	LDA.b #$10				;$02E804	|
	STA $AA,X				;$02E806	|
CODE_02E808:
	LDA.w $1588,X
	AND.b #$04				;$02E80B	|
	BEQ CODE_02E828				;$02E80D	|
	LDA $AA,X				;$02E80F	|
	CMP.b #$38				;$02E811	|
	LDA.b #$E0				;$02E813	|
	BCC CODE_02E819				;$02E815	|
	LDA.b #$D0				;$02E817	|
CODE_02E819:
	STA $AA,X
	LDA.b #$08				;$02E81B	|
	LDY.w $15B8,X				;$02E81D	|
	BEQ CODE_02E828				;$02E820	|
	BPL CODE_02E826				;$02E822	|
	LDA.b #$F8				;$02E824	|
CODE_02E826:
	STA $B6,X
CODE_02E828:
	JSL SprSprPMarioSprRts
Return02E82C:
	RTS

GrowingPipeMain:
	PHB
	PHK					;$02E82E	|
	PLB					;$02E82F	|
	JSR CODE_02E845				;$02E830	|
	PLB					;$02E833	|
	RTL					;$02E834	|

DATA_02E835:
	db $00,$F0,$00,$10

DATA_02E839:
	db $20,$40,$20,$40

GrowingPipeTiles1:
	db $00,$14,$00,$02

GrowingPipeTiles2:
	db $00,$15,$00,$02

CODE_02E845:
	LDA.w $1534,X
	BMI CODE_02E872				;$02E848	|
	LDA $D8,X				;$02E84A	|
	PHA					;$02E84C	|
	SEC					;$02E84D	|
	SBC.w $1534,X				;$02E84E	|
	STA $D8,X				;$02E851	|
	LDA.w $14D4,X				;$02E853	|
	PHA					;$02E856	|
	SBC.b #$00				;$02E857	|
	STA.w $14D4,X				;$02E859	|
	LDY.b #$03				;$02E85C	|
	JSR GrowingPipeGfx			;$02E85E	|
	PLA					;$02E861	|
	STA.w $14D4,X				;$02E862	|
	PLA					;$02E865	|
	STA $D8,X				;$02E866	|
	LDA.w $1534,X				;$02E868	|
	SEC					;$02E86B	|
	SBC.b #$10				;$02E86C	|
	STA.w $1534,X				;$02E86E	|
	RTS					;$02E871	|

CODE_02E872:
	JSR CODE_02E902
	JSR SubOffscreen0Bnk2			;$02E875	|
	LDA $9D					;$02E878	|
	ORA.w $15A0,X				;$02E87A	|
	BNE CODE_02E8B5				;$02E87D	|
	JSR CODE_02D4FA				;$02E87F	|
	LDA $0F					;$02E882	|
	CLC					;$02E884	|
	ADC.b #$50				;$02E885	|
	CMP.b #$A0				;$02E887	|
	BCS CODE_02E8B5				;$02E889	|
	LDA $C2,X				;$02E88B	|
	AND.b #$03				;$02E88D	|
	TAY					;$02E88F	|
	INC.w $1570,X				;$02E890	|
	LDA.w $1570,X				;$02E893	|
	CMP.w DATA_02E839,Y			;$02E896	|
	BNE CODE_02E8A2				;$02E899	|
	STZ.w $1570,X				;$02E89B	|
	INC $C2,X				;$02E89E	|
	BRA CODE_02E8B5				;$02E8A0	|

CODE_02E8A2:
	LDA.w DATA_02E835,Y
	STA $AA,X				;$02E8A5	|
	BEQ CODE_02E8B2				;$02E8A7	|
	LDA $D8,X				;$02E8A9	|
	AND.b #$0F				;$02E8AB	|
	BNE CODE_02E8B2				;$02E8AD	|
	JSR GrowingPipeGfx			;$02E8AF	|
CODE_02E8B2:
	JSR UpdateYPosNoGrvtyB1
CODE_02E8B5:
	JSL InvisBlkMainRt
	RTS					;$02E8B9	|

GrowingPipeGfx:
	LDA.w GrowingPipeTiles1,Y
	STA.w $185E				;$02E8BD	|
	LDA.w GrowingPipeTiles2,Y		;$02E8C0	|
	STA.w $18B6				;$02E8C3	|
	LDA.w $185E				;$02E8C6	|
	STA $9C					;$02E8C9	|
	LDA $E4,X				;$02E8CB	|
	STA $9A					;$02E8CD	|
	LDA.w $14E0,X				;$02E8CF	|
	STA $9B					;$02E8D2	|
	LDA $D8,X				;$02E8D4	|
	STA $98					;$02E8D6	|
	LDA.w $14D4,X				;$02E8D8	|
	STA $99					;$02E8DB	|
	JSL generate_tile			;$02E8DD	|
	LDA.w $18B6				;$02E8E1	|
	STA $9C					;$02E8E4	|
	LDA $E4,X				;$02E8E6	|
	CLC					;$02E8E8	|
	ADC.b #$10				;$02E8E9	|
	STA $9A					;$02E8EB	|
	LDA.w $14E0,X				;$02E8ED	|
	ADC.b #$00				;$02E8F0	|
	STA $9B					;$02E8F2	|
	LDA $D8,X				;$02E8F4	|
	STA $98					;$02E8F6	|
	LDA.w $14D4,X				;$02E8F8	|
	STA $99					;$02E8FB	|
	JSL generate_tile			;$02E8FD	|
	RTS					;$02E901	|

CODE_02E902:
	JSR GetDrawInfo2
	LDA $00					;$02E905	|
	STA.w $0300,Y				;$02E907	|
	CLC					;$02E90A	|
	ADC.b #$10				;$02E90B	|
	STA.w $0304,Y				;$02E90D	|
	LDA $01					;$02E910	|
	DEC A					;$02E912	|
	STA.w $0301,Y				;$02E913	|
	STA.w $0305,Y				;$02E916	|
	LDA.b #$A4				;$02E919	|
	STA.w $0302,Y				;$02E91B	|
	LDA.b #$A6				;$02E91E	|
	STA.w $0306,Y				;$02E920	|
	LDA.w $15F6,X				;$02E923	|
	ORA $64					;$02E926	|
	STA.w $0303,Y				;$02E928	|
	STA.w $0307,Y				;$02E92B	|
CODE_02E92E:
	LDA.b #$01
	LDY.b #$02				;$02E930	|
	JMP CODE_02B7A7				;$02E932	|

PipeLakituMain:
	PHB
	PHK					;$02E936	|
	PLB					;$02E937	|
	JSR CODE_02E93D				;$02E938	|
	PLB					;$02E93B	|
	RTL					;$02E93C	|

CODE_02E93D:
	LDA.w $14C8,X
	CMP.b #$02				;$02E940	|
	BNE CODE_02E94C				;$02E942	|
	LDA.b #$02				;$02E944	|
	STA.w $1602,X				;$02E946	|
	JMP CODE_02E9EC				;$02E949	|

CODE_02E94C:
	JSR CODE_02E9EC
	LDA $9D					;$02E94F	|
	BNE Return02E985			;$02E951	|
	STZ.w $1602,X				;$02E953	|
	JSR SubOffscreen0Bnk2			;$02E956	|
	JSL SprSprPMarioSprRts			;$02E959	|
	LDA $C2,X				;$02E95D	|
	JSL execute_pointer			;$02E95F	|

PipeLakituPtrs:
	dw CODE_02E96D
	dw CODE_02E986
	dw CODE_02E9B4
	dw CODE_02E9BD
	dw CODE_02E9D5

CODE_02E96D:
	LDA.w $1540,X
	BNE Return02E985			;$02E970	|
	JSR CODE_02D4FA				;$02E972	|
	LDA $0F					;$02E975	|
	CLC					;$02E977	|
	ADC.b #$13				;$02E978	|
	CMP.b #$36				;$02E97A	|
	BCC Return02E985			;$02E97C	|
	LDA.b #$90				;$02E97E	|
CODE_02E980:
	STA.w $1540,X
	INC $C2,X				;$02E983	|
Return02E985:
	RTS

CODE_02E986:
	LDA.w $1540,X
	BNE CODE_02E996				;$02E989	|
	JSR CODE_02D4FA				;$02E98B	|
	TYA					;$02E98E	|
	STA.w $157C,X				;$02E98F	|
	LDA.b #$0C				;$02E992	|
	BRA CODE_02E980				;$02E994	|

CODE_02E996:
	CMP.b #$7C
	BCC CODE_02E9A2				;$02E998	|
CODE_02E99A:
	LDA.b #$F8
CODE_02E99C:
	STA $AA,X
	JSR UpdateYPosNoGrvtyB1			;$02E99E	|
	RTS					;$02E9A1	|

CODE_02E9A2:
	CMP.b #$50
	BCS Return02E9B3			;$02E9A4	|
	LDY.b #$00				;$02E9A6	|
	LDA $13					;$02E9A8	|
	AND.b #$20				;$02E9AA	|
	BEQ CODE_02E9AF				;$02E9AC	|
	INY					;$02E9AE	|
CODE_02E9AF:
	TYA
	STA.w $157C,X				;$02E9B0	|
Return02E9B3:
	RTS

CODE_02E9B4:
	LDA.w $1540,X
	BNE CODE_02E99A				;$02E9B7	|
	LDA.b #$80				;$02E9B9	|
	BRA CODE_02E980				;$02E9BB	|

CODE_02E9BD:
	LDA.w $1540,X
	BNE CODE_02E9C6				;$02E9C0	|
	LDA.b #$20				;$02E9C2	|
	BRA CODE_02E980				;$02E9C4	|

CODE_02E9C6:
	CMP.b #$40
	BNE CODE_02E9CF				;$02E9C8	|
	JSL CODE_01EA19				;$02E9CA	|
	RTS					;$02E9CE	|

CODE_02E9CF:
	BCS Return02E9D4
	INC.w $1602,X				;$02E9D1	|
Return02E9D4:
	RTS

CODE_02E9D5:
	LDA.w $1540,X
	BNE CODE_02E9E2				;$02E9D8	|
	LDA.b #$50				;$02E9DA	|
	JSR CODE_02E980				;$02E9DC	|
	STZ $C2,X				;$02E9DF	|
	RTS					;$02E9E1	|

CODE_02E9E2:
	LDA.b #$08
	BRA CODE_02E99C				;$02E9E4	|

PipeLakitu1:
	db $EC,$A8,$CE

PipeLakitu2:
	db $EE,$EE,$EE

CODE_02E9EC:
	JSR GetDrawInfo2
	LDA $00					;$02E9EF	|
	STA.w $0300,Y				;$02E9F1	|
	STA.w $0304,Y				;$02E9F4	|
	LDA $01					;$02E9F7	|
	STA.w $0301,Y				;$02E9F9	|
	CLC					;$02E9FC	|
	ADC.b #$10				;$02E9FD	|
	STA.w $0305,Y				;$02E9FF	|
	PHX					;$02EA02	|
	LDA.w $1602,X				;$02EA03	|
	TAX					;$02EA06	|
	LDA.w PipeLakitu1,X			;$02EA07	|
	STA.w $0302,Y				;$02EA0A	|
	LDA.w PipeLakitu2,X			;$02EA0D	|
	STA.w $0306,Y				;$02EA10	|
	PLX					;$02EA13	|
	LDA.w $157C,X				;$02EA14	|
	LSR					;$02EA17	|
	ROR					;$02EA18	|
	LSR					;$02EA19	|
	EOR.b #$5B				;$02EA1A	|
	STA.w $0303,Y				;$02EA1C	|
	STA.w $0307,Y				;$02EA1F	|
	JMP CODE_02E92E				;$02EA22	|

CODE_02EA25:
	LDY.w $15EA,X
	LDA.w $0302,Y				;$02EA28	|
	STA $00					;$02EA2B	|
	STZ $01					;$02EA2D	|
	LDA.b #$06				;$02EA2F	|
	STA.w $0302,Y				;$02EA31	|
	REP #$20				;$02EA34	|
	LDA $00					;$02EA36	|
	ASL					;$02EA38	|
	ASL					;$02EA39	|
	ASL					;$02EA3A	|
	ASL					;$02EA3B	|
	ASL					;$02EA3C	|
	CLC					;$02EA3D	|
	ADC.w #$8500				;$02EA3E	|
	STA.w $0D8B				;$02EA41	|
	CLC					;$02EA44	|
	ADC.w #$0200				;$02EA45	|
	STA.w $0D95				;$02EA48	|
	SEP #$20				;$02EA4B	|
	RTL					;$02EA4D	|

CODE_02EA4E:
	LDY.b #$0B
CODE_02EA50:
	TYA
	CMP.w $160E,X				;$02EA51	|
	BEQ CODE_02EA86				;$02EA54	|
	EOR $13					;$02EA56	|
	LSR					;$02EA58	|
	BCS CODE_02EA86				;$02EA59	|
	CPY.w $15E9				;$02EA5B	|
	BEQ CODE_02EA86				;$02EA5E	|
	STY.w $1695				;$02EA60	|
	LDA.w $14C8,Y				;$02EA63	|
	CMP.b #$08				;$02EA66	|
	BCC CODE_02EA86				;$02EA68	|
	LDA.w $009E,y				;$02EA6A	|
	CMP.b #$70				;$02EA6D	|
	BEQ CODE_02EA86				;$02EA6F	|
	CMP.b #$0E				;$02EA71	|
	BEQ CODE_02EA86				;$02EA73	|
	CMP.b #$1D				;$02EA75	|
	BCC CODE_02EA83				;$02EA77	|
	LDA.w $1686,Y				;$02EA79	|
	AND.b #$03				;$02EA7C	|
	ORA.w $18E8				;$02EA7E	|
	BNE CODE_02EA86				;$02EA81	|
CODE_02EA83:
	JSR CODE_02EA8A
CODE_02EA86:
	DEY
	BPL CODE_02EA50				;$02EA87	|
	RTL					;$02EA89	|

CODE_02EA8A:
	PHX
	TYX					;$02EA8B	|
	JSL GetSpriteClippingB			;$02EA8C	|
	PLX					;$02EA90	|
	JSL GetSpriteClippingA			;$02EA91	|
	JSL CheckForContact			;$02EA95	|
	BCC Return02EACD			;$02EA99	|
	LDA.w $163E,X				;$02EA9B	|
	BEQ CODE_02EAA9				;$02EA9E	|
	JSL CODE_03C023				;$02EAA0	|
	LDA.w $18E8				;$02EAA4	|
	BNE ADDR_02EACE				;$02EAA7	|
CODE_02EAA9:
	LDA.b #$37
	STA.w $163E,X				;$02EAAB	|
	LDY.w $1695				;$02EAAE	|
	STA.w $1632,Y				;$02EAB1	|
	LDA.w $1695				;$02EAB4	|
	STA.w $160E,X				;$02EAB7	|
	STZ.w $157C,X				;$02EABA	|
	LDA $E4,X				;$02EABD	|
	CMP.w $00E4,y				;$02EABF	|
	LDA.w $14E0,X				;$02EAC2	|
	SBC.w $14E0,Y				;$02EAC5	|
	BCC Return02EACD			;$02EAC8	|
	INC.w $157C,X				;$02EACA	|
Return02EACD:
	RTS

ADDR_02EACE:
	STZ.w $163E,X
	RTS					;$02EAD1	|

WarpBlocksMain:
	PHB
	PHK					;$02EAD3	|
	PLB					;$02EAD4	|
	JSR CODE_02EADA				;$02EAD5	|
	PLB					;$02EAD8	|
	RTL					;$02EAD9	|

CODE_02EADA:
	JSL MarioSprInteract
	BCC Return02EAF0			;$02EADE	|
	STZ $7B					;$02EAE0	|
	LDA $E4,X				;$02EAE2	|
	CLC					;$02EAE4	|
	ADC.b #$0A				;$02EAE5	|
	STA $94					;$02EAE7	|
	LDA.w $14E0,X				;$02EAE9	|
	ADC.b #$00				;$02EAEC	|
	STA $95					;$02EAEE	|
Return02EAF0:
	RTS

	RTS					;$02EAF1	|

CODE_02EAF2:
	JSL FindFreeSprSlot
	BMI Return02EB26			;$02EAF6	|
	LDA.b #$08				;$02EAF8	|
	STA.w $14C8,Y				;$02EAFA	|
	LDA.b #$77				;$02EAFD	|
	STA.w $009E,y				;$02EAFF	|
	LDA $E4,X				;$02EB02	|
	STA.w $00E4,y				;$02EB04	|
	LDA.w $14E0,X				;$02EB07	|
	STA.w $14E0,Y				;$02EB0A	|
	LDA $D8,X				;$02EB0D	|
	STA.w $00D8,y				;$02EB0F	|
	LDA.w $14D4,X				;$02EB12	|
	STA.w $14D4,Y				;$02EB15	|
	TYX					;$02EB18	|
	JSL InitSpriteTables			;$02EB19	|
	LDA.b #$30				;$02EB1D	|
	STA.w $154C,X				;$02EB1F	|
	LDA.b #$D0				;$02EB22	|
	STA $AA,X				;$02EB24	|
Return02EB26:
	RTL

SuperKoopaMain:
	PHB
	PHK					;$02EB28	|
	PLB					;$02EB29	|
	JSR CODE_02EB31				;$02EB2A	|
	PLB					;$02EB2D	|
	RTL					;$02EB2E	|

DATA_02EB2F:
	db $18,$E8

CODE_02EB31:
	JSR CODE_02ECDE
	LDA.w $14C8,X				;$02EB34	|
	CMP.b #$02				;$02EB37	|
	BNE CODE_02EB49				;$02EB39	|
	LDY.b #$04				;$02EB3B	|
CODE_02EB3D:
	LDA $14
	AND.b #$04				;$02EB3F	|
	BEQ CODE_02EB44				;$02EB41	|
	INY					;$02EB43	|
CODE_02EB44:
	TYA
	STA.w $1602,X				;$02EB45	|
	RTS					;$02EB48	|

CODE_02EB49:
	LDA $9D
	BNE Return02EB7C			;$02EB4B	|
	JSR SubOffscreen0Bnk2			;$02EB4D	|
	JSL SprSprPMarioSprRts			;$02EB50	|
	JSR UpdateXPosNoGrvtyB1			;$02EB54	|
	JSR UpdateYPosNoGrvtyB1			;$02EB57	|
	LDA $9E,X				;$02EB5A	|
	CMP.b #$73				;$02EB5C	|
	BEQ CODE_02EB7D				;$02EB5E	|
	LDY.w $157C,X				;$02EB60	|
	LDA.w DATA_02EB2F,Y			;$02EB63	|
	STA $B6,X				;$02EB66	|
	JSR CODE_02EBF8				;$02EB68	|
	LDA $13					;$02EB6B	|
	AND.b #$01				;$02EB6D	|
	BNE Return02EB7C			;$02EB6F	|
	LDA $AA,X				;$02EB71	|
	CMP.b #$F0				;$02EB73	|
	BMI Return02EB7C			;$02EB75	|
	CLC					;$02EB77	|
	ADC.b #$FF				;$02EB78	|
	STA $AA,X				;$02EB7A	|
Return02EB7C:
	RTS

CODE_02EB7D:
	LDA $C2,X
	JSL execute_pointer			;$02EB7F	|

SuperKoopaPtrs:
	dw CODE_02EB8D
	dw CODE_02EBD1
	dw CODE_02EBE7

DATA_02EB89:
	db $18,$E8

DATA_02EB8B:
	db $01,$FF

CODE_02EB8D:
	LDA $13
	AND.b #$00				;$02EB8F	|
	STA $01					;$02EB91	|
	STZ $00					;$02EB93	|
	LDY.w $157C,X				;$02EB95	|
	LDA $B6,X				;$02EB98	|
	CMP.w DATA_02EB89,Y			;$02EB9A	|
	BEQ CODE_02EBAB				;$02EB9D	|
	CLC					;$02EB9F	|
	ADC.w DATA_02EB8B,Y			;$02EBA0	|
	LDY $01					;$02EBA3	|
	BNE CODE_02EBA9				;$02EBA5	|
	STA $B6,X				;$02EBA7	|
CODE_02EBA9:
	INC $00
CODE_02EBAB:
	INC.w $151C,X
	LDA.w $151C,X				;$02EBAE	|
	CMP.b #$30				;$02EBB1	|
	BEQ CODE_02EBCA				;$02EBB3	|
CODE_02EBB5:
	LDY.b #$00
	LDA $13					;$02EBB7	|
	AND.b #$04				;$02EBB9	|
	BEQ CODE_02EBBE				;$02EBBB	|
	INY					;$02EBBD	|
CODE_02EBBE:
	TYA
	LDY $00					;$02EBBF	|
	BNE CODE_02EBC6				;$02EBC1	|
	CLC					;$02EBC3	|
	ADC.b #$06				;$02EBC4	|
CODE_02EBC6:
	STA.w $1602,X
	RTS					;$02EBC9	|

CODE_02EBCA:
	INC $C2,X
	LDA.b #$D0				;$02EBCC	|
	STA $AA,X				;$02EBCE	|
	RTS					;$02EBD0	|

CODE_02EBD1:
	LDA $AA,X
	CLC					;$02EBD3	|
	ADC.b #$02				;$02EBD4	|
	STA $AA,X				;$02EBD6	|
	CMP.b #$14				;$02EBD8	|
	BMI CODE_02EBDE				;$02EBDA	|
	INC $C2,X				;$02EBDC	|
CODE_02EBDE:
	STZ $00
	JSR CODE_02EBB5				;$02EBE0	|
	INC.w $1602,X				;$02EBE3	|
	RTS					;$02EBE6	|

CODE_02EBE7:
	LDY.w $157C,X
	LDA.w DATA_02EB89,Y			;$02EBEA	|
	STA $B6,X				;$02EBED	|
	LDA $AA,X				;$02EBEF	|
	BEQ CODE_02EBF8				;$02EBF1	|
	CLC					;$02EBF3	|
	ADC.b #$FF				;$02EBF4	|
	STA $AA,X				;$02EBF6	|
CODE_02EBF8:
	LDY.b #$02
	LDA $13					;$02EBFA	|
	AND.b #$04				;$02EBFC	|
	BEQ CODE_02EC01				;$02EBFE	|
	INY					;$02EC00	|
CODE_02EC01:
	TYA
	STA.w $1602,X				;$02EC02	|
	RTS					;$02EC05	|

DATA_02EC06:
	db $08,$08,$10,$00,$08,$08,$10,$00
	db $08,$10,$10,$00,$08,$10,$10,$00
	db $09,$09,$00,$00,$09,$09,$00,$00
	db $08,$10,$00,$00,$08,$10,$00,$00
	db $08,$10,$00,$00,$00,$00,$F8,$00
	db $00,$00,$F8,$00,$00,$F8,$F8,$00
	db $00,$F8,$F8,$00,$FF,$FF,$00,$00
	db $FF,$FF,$00,$00,$00,$F8,$00,$00
	db $00,$F8,$00,$00,$00,$F8,$00,$00
DATA_02EC4E:
	db $00,$08,$08,$00,$00,$08,$08,$00
	db $03,$03,$08,$00,$03,$03,$08,$00
	db $FF,$07,$00,$00,$FF,$07,$00,$00
	db $FD,$FD,$00,$00,$FD,$FD,$00,$00
	db $FD,$FD,$00,$00

SuperKoopaTiles:
	db $C8,$D8,$D0,$E0,$C9,$D9,$C0,$E2
	db $E4,$E5,$F2,$E0,$F4,$F5,$F2,$E0
	db $DA,$CA,$E0,$CF,$DB,$CB,$E0,$CF
	db $E4,$E5,$E0,$CF,$F4,$F5,$E2,$CF
	db $E4,$E5,$E2,$CF

DATA_02EC96:
	db $03,$03,$03,$00,$03,$03,$03,$00
	db $03,$03,$01,$01,$03,$03,$01,$01
	db $83,$83,$80,$00,$83,$83,$80,$00
	db $03,$03,$00,$01,$03,$03,$00,$01
	db $03,$03,$00,$01

DATA_02ECBA:
	db $00,$00,$00,$02,$00,$00,$00,$02
	db $00,$00,$00,$02,$00,$00,$00,$02
	db $00,$00,$02,$00,$00,$00,$02,$00
	db $00,$00,$02,$00,$00,$00,$02,$00
	db $00,$00,$02,$00

CODE_02ECDE:
	JSR GetDrawInfo2
	LDA.w $157C,X				;$02ECE1	|
	STA $02					;$02ECE4	|
	LDA.w $15F6,X				;$02ECE6	|
	AND.b #$0E				;$02ECE9	|
	STA $05					;$02ECEB	|
	LDA.w $1602,X				;$02ECED	|
	ASL					;$02ECF0	|
	ASL					;$02ECF1	|
	STA $03					;$02ECF2	|
	PHX					;$02ECF4	|
	STZ $04					;$02ECF5	|
CODE_02ECF7:
	LDA $03
	CLC					;$02ECF9	|
	ADC $04					;$02ECFA	|
	TAX					;$02ECFC	|
	LDA $01					;$02ECFD	|
	CLC					;$02ECFF	|
	ADC.w DATA_02EC4E,X			;$02ED00	|
	STA.w $0301,Y				;$02ED03	|
	LDA.w SuperKoopaTiles,X			;$02ED06	|
	STA.w $0302,Y				;$02ED09	|
	PHY					;$02ED0C	|
	TYA					;$02ED0D	|
	LSR					;$02ED0E	|
	LSR					;$02ED0F	|
	TAY					;$02ED10	|
	LDA.w DATA_02ECBA,X			;$02ED11	|
	STA.w $0460,Y				;$02ED14	|
	PLY					;$02ED17	|
	LDA $02					;$02ED18	|
	LSR					;$02ED1A	|
	LDA.w DATA_02EC96,X			;$02ED1B	|
	AND.b #$02				;$02ED1E	|
	BEQ CODE_02ED4D				;$02ED20	|
	PHP					;$02ED22	|
	PHX					;$02ED23	|
	LDX.w $15E9				;$02ED24	|
	LDA.w $1534,X				;$02ED27	|
	BEQ CODE_02ED3B				;$02ED2A	|
	LDA $14					;$02ED2C	|
	LSR					;$02ED2E	|
	AND.b #$01				;$02ED2F	|
	PHY					;$02ED31	|
	TAY					;$02ED32	|
	LDA.w DATA_02ED39,Y			;$02ED33	|
	PLY					;$02ED36	|
	BRA CODE_02ED44				;$02ED37	|

DATA_02ED39:
	db $10,$0A

CODE_02ED3B:
	LDA $9E,X
	CMP.b #$72				;$02ED3D	|
	LDA.b #$08				;$02ED3F	|
	BCC CODE_02ED44				;$02ED41	|
	LSR					;$02ED43	|
CODE_02ED44:
	PLX
	PLP					;$02ED45	|
	ORA.w DATA_02EC96,X			;$02ED46	|
	AND.b #$FD				;$02ED49	|
	BRA CODE_02ED52				;$02ED4B	|

CODE_02ED4D:
	LDA.w DATA_02EC96,X
	ORA $05					;$02ED50	|
CODE_02ED52:
	ORA $64
	BCS CODE_02ED5F				;$02ED54	|
	PHA					;$02ED56	|
	TXA					;$02ED57	|
	CLC					;$02ED58	|
	ADC.b #$24				;$02ED59	|
	TAX					;$02ED5B	|
	PLA					;$02ED5C	|
	ORA.b #$40				;$02ED5D	|
CODE_02ED5F:
	STA.w $0303,Y
	LDA $00					;$02ED62	|
	CLC					;$02ED64	|
	ADC.w DATA_02EC06,X			;$02ED65	|
	STA.w $0300,Y				;$02ED68	|
	INY					;$02ED6B	|
	INY					;$02ED6C	|
	INY					;$02ED6D	|
	INY					;$02ED6E	|
	INC $04					;$02ED6F	|
	LDA $04					;$02ED71	|
	CMP.b #$04				;$02ED73	|
	BNE CODE_02ECF7				;$02ED75	|
	PLX					;$02ED77	|
	LDY.b #$FF				;$02ED78	|
	LDA.b #$03				;$02ED7A	|
	JMP CODE_02B7A7				;$02ED7C	|

DATA_02ED7F:
	db $10,$20,$30

FloatingSkullInit:
	PHB
	PHK					;$02ED83	|
	PLB					;$02ED84	|
	JSR CODE_02ED8A				;$02ED85	|
	PLB					;$02ED88	|
	RTL					;$02ED89	|

CODE_02ED8A:
	STZ.w $18BC
	INC $C2,X				;$02ED8D	|
	LDA.b #$02				;$02ED8F	|
	STA $00					;$02ED91	|
CODE_02ED93:
	JSL FindFreeSprSlot
	BMI CODE_02EDCB				;$02ED97	|
	LDA.b #$08				;$02ED99	|
	STA.w $14C8,Y				;$02ED9B	|
	LDA.b #$61				;$02ED9E	|
	STA.w $009E,y				;$02EDA0	|
	LDA $D8,X				;$02EDA3	|
	STA.w $00D8,y				;$02EDA5	|
	LDA.w $14D4,X				;$02EDA8	|
	STA.w $14D4,Y				;$02EDAB	|
	LDX $00					;$02EDAE	|
	LDA.w DATA_02ED7F,X			;$02EDB0	|
	LDX.w $15E9				;$02EDB3	|
	CLC					;$02EDB6	|
	ADC $E4,X				;$02EDB7	|
	STA.w $00E4,y				;$02EDB9	|
	LDA.w $14E0,X				;$02EDBC	|
	ADC.b #$00				;$02EDBF	|
	STA.w $14E0,Y				;$02EDC1	|
	PHX					;$02EDC4	|
	TYX					;$02EDC5	|
	JSL InitSpriteTables			;$02EDC6	|
	PLX					;$02EDCA	|
CODE_02EDCB:
	DEC $00
	BPL CODE_02ED93				;$02EDCD	|
	RTS					;$02EDCF	|

FloatingSkullMain:
	PHB
	PHK					;$02EDD1	|
	PLB					;$02EDD2	|
	JSR CODE_02EDD8				;$02EDD3	|
	PLB					;$02EDD6	|
	RTL					;$02EDD7	|

CODE_02EDD8:
	LDA $C2,X
	BEQ CODE_02EDF6				;$02EDDA	|
	JSR SubOffscreen0Bnk2			;$02EDDC	|
	LDA.w $14C8,X				;$02EDDF	|
	BNE CODE_02EDF6				;$02EDE2	|
	LDY.b #$09				;$02EDE4	|
CODE_02EDE6:
	LDA.w $009E,y
	CMP.b #$61				;$02EDE9	|
	BNE CODE_02EDF2				;$02EDEB	|
	LDA.b #$00 				;$02EDED	|
	STA.w $14C8,Y				;$02EDEF	|
CODE_02EDF2:
	DEY
	BPL CODE_02EDE6				;$02EDF3	|
Return02EDF5:
	RTS

CODE_02EDF6:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$02EDFA	|
	LDA $14					;$02EDFD	|
	LSR					;$02EDFF	|
	LSR					;$02EE00	|
	LSR					;$02EE01	|
	LSR					;$02EE02	|
	LDA.b #$E0				;$02EE03	|
	BCC CODE_02EE09				;$02EE05	|
	LDA.b #$E2				;$02EE07	|
CODE_02EE09:
	STA.w $0302,Y
	LDA.w $0301,Y				;$02EE0C	|
	CMP.b #$F0				;$02EE0F	|
	BCS CODE_02EE19				;$02EE11	|
	CLC					;$02EE13	|
	ADC.b #$03				;$02EE14	|
	STA.w $0301,Y				;$02EE16	|
CODE_02EE19:
	LDA $9D
	BNE Return02EDF5			;$02EE1B	|
	STZ $00					;$02EE1D	|
	LDY.b #$09				;$02EE1F	|
CODE_02EE21:
	LDA.w $14C8,Y
	BEQ CODE_02EE36				;$02EE24	|
	LDA.w $009E,y				;$02EE26	|
	CMP.b #$61				;$02EE29	|
	BNE CODE_02EE36				;$02EE2B	|
	LDA.w $1588,Y				;$02EE2D	|
	AND.b #$0F				;$02EE30	|
	BEQ CODE_02EE36				;$02EE32	|
	STA $00					;$02EE34	|
CODE_02EE36:
	DEY
	BPL CODE_02EE21				;$02EE37	|
	LDA.w $18BC				;$02EE39	|
	STA $B6,X				;$02EE3C	|
	LDA $AA,X				;$02EE3E	|
	CMP.b #$20				;$02EE40	|
	BMI CODE_02EE48				;$02EE42	|
	LDA.b #$20				;$02EE44	|
	STA $AA,X				;$02EE46	|
CODE_02EE48:
	JSL UpdateSpritePos
	LDA.w $1588,X				;$02EE4C	|
	AND.b #$04				;$02EE4F	|
	BEQ CODE_02EE57				;$02EE51	|
	LDA.b #$10				;$02EE53	|
	STA $AA,X				;$02EE55	|
CODE_02EE57:
	JSL MarioSprInteract
	BCC Return02EEA8			;$02EE5B	|
	LDA $7D					;$02EE5D	|
	BMI Return02EEA8			;$02EE5F	|
	LDA.b #$0C				;$02EE61	|
	STA.w $18BC				;$02EE63	|
	LDA.w $15EA,X				;$02EE66	|
	TAX					;$02EE69	|
	INC.w $0301,X				;$02EE6A	|
	LDX.w $15E9				;$02EE6D	|
	LDA.b #$01				;$02EE70	|
	STA.w $1471				;$02EE72	|
	STZ $72					;$02EE75	|
	LDA.b #$1C				;$02EE77	|
	LDY.w $187A				;$02EE79	|
	BEQ CODE_02EE80				;$02EE7C	|
	LDA.b #$2C				;$02EE7E	|
CODE_02EE80:
	STA $01
	LDA $D8,X				;$02EE82	|
	SEC					;$02EE84	|
	SBC $01					;$02EE85	|
	STA $96					;$02EE87	|
	LDA.w $14D4,X				;$02EE89	|
	SBC.b #$00				;$02EE8C	|
	STA $97					;$02EE8E	|
	LDA $77					;$02EE90	|
	AND.b #$01				;$02EE92	|
	BNE Return02EEA8			;$02EE94	|
	LDY.b #$00				;$02EE96	|
	LDA.w $1491				;$02EE98	|
	BPL CODE_02EE9E				;$02EE9B	|
	DEY					;$02EE9D	|
CODE_02EE9E:
	CLC
	ADC $94					;$02EE9F	|
	STA $94					;$02EEA1	|
	TYA					;$02EEA3	|
	ADC $95					;$02EEA4	|
	STA $95					;$02EEA6	|
Return02EEA8:
	RTS

CoinCloudMain:
	PHB
	PHK					;$02EEAA	|
	PLB					;$02EEAB	|
	JSR ADDR_02EEB5				;$02EEAC	|
	PLB					;$02EEAF	|
	RTL					;$02EEB0	|

DATA_02EEB1:
	db $01,$FF

DATA_02EEB3:
	db $10,$F0

ADDR_02EEB5:
	LDA $C2,X
	BNE ADDR_02EEBE				;$02EEB7	|
	INC $C2,X				;$02EEB9	|
	STZ.w $18E3				;$02EEBB	|
ADDR_02EEBE:
	LDA $9D
	BNE ADDR_02EF1C				;$02EEC0	|
	LDA $14					;$02EEC2	|
	AND.b #$7F				;$02EEC4	|
	BNE ADDR_02EED5				;$02EEC6	|
	LDA.w $1570,X				;$02EEC8	|
	CMP.b #$0B				;$02EECB	|
	BCS ADDR_02EED5				;$02EECD	|
	INC.w $1570,X				;$02EECF	|
	JSR ADDR_02EF67				;$02EED2	|
ADDR_02EED5:
	LDA $14
	AND.b #$01				;$02EED7	|
	BNE ADDR_02EF12				;$02EED9	|
	LDA $D8,X				;$02EEDB	|
	STA $00					;$02EEDD	|
	LDA.w $14D4,X				;$02EEDF	|
	STA $01					;$02EEE2	|
	LDA.b #$10				;$02EEE4	|
	STA $02					;$02EEE6	|
	LDA.b #$01				;$02EEE8	|
	STA $03					;$02EEEA	|
	REP #$20				;$02EEEC	|
	LDA $00					;$02EEEE	|
	CMP $02					;$02EEF0	|
	SEP #$20				;$02EEF2	|
	LDY.b #$00				;$02EEF4	|
	BCC ADDR_02EEF9				;$02EEF6	|
	INY					;$02EEF8	|
ADDR_02EEF9:
	LDA.w $1570,X
	CMP.b #$0B				;$02EEFC	|
	BCC ADDR_02EF05				;$02EEFE	|
	JSR SubOffscreen0Bnk2			;$02EF00	|
	LDY.b #$01				;$02EF03	|
ADDR_02EF05:
	LDA $AA,X
	CMP.w DATA_02EEB3,Y			;$02EF07	|
	BEQ ADDR_02EF12				;$02EF0A	|
	CLC					;$02EF0C	|
	ADC.w DATA_02EEB1,Y			;$02EF0D	|
	STA $AA,X				;$02EF10	|
ADDR_02EF12:
	JSR UpdateYPosNoGrvtyB1
	LDA.b #$08				;$02EF15	|
	STA $B6,X				;$02EF17	|
	JSR UpdateXPosNoGrvtyB1			;$02EF19	|
ADDR_02EF1C:
	LDA.w $15EA,X
	PHA					;$02EF1F	|
	CLC					;$02EF20	|
	ADC.b #$04				;$02EF21	|
	STA.w $15EA,X				;$02EF23	|
	JSL GenericSprGfxRt2			;$02EF26	|
	LDY.w $15EA,X				;$02EF2A	|
	LDA.b #$60				;$02EF2D	|
	STA.w $0302,Y				;$02EF2F	|
	LDA $14					;$02EF32	|
	ASL					;$02EF34	|
	ASL					;$02EF35	|
	ASL					;$02EF36	|
	AND.b #$C0				;$02EF37	|
	ORA.b #$30				;$02EF39	|
	STA.w $0303,Y				;$02EF3B	|
	PLA					;$02EF3E	|
	STA.w $15EA,X				;$02EF3F	|
	JSR GetDrawInfo2			;$02EF42	|
	LDA $00					;$02EF45	|
	CLC					;$02EF47	|
	ADC.b #$04				;$02EF48	|
	STA.w $0300,Y				;$02EF4A	|
	LDA $01					;$02EF4D	|
	CLC					;$02EF4F	|
	ADC.b #$04				;$02EF50	|
	STA.w $0301,Y				;$02EF52	|
	LDA.b #$4D				;$02EF55	|
	STA.w $0302,Y				;$02EF57	|
	LDA.b #$39				;$02EF5A	|
	STA.w $0303,Y				;$02EF5C	|
	LDY.b #$00				;$02EF5F	|
	LDA.b #$00				;$02EF61	|
	JSR CODE_02B7A7				;$02EF63	|
	RTS					;$02EF66	|

ADDR_02EF67:
	LDA.w $18E3
	CMP.b #$0A				;$02EF6A	|
	BCC ADDR_02EFAA				;$02EF6C	|
	LDY.b #$0B				;$02EF6E	|
ADDR_02EF70:
	LDA.w $14C8,Y
	BEQ ADDR_02EF7B				;$02EF73	|
	DEY					;$02EF75	|
	CPY.b #$09				;$02EF76	|
	BNE ADDR_02EF70				;$02EF78	|
	RTS					;$02EF7A	|

ADDR_02EF7B:
	LDA.b #$08
	STA.w $14C8,Y				;$02EF7D	|
	LDA.b #$78				;$02EF80	|
	STA.w $009E,y				;$02EF82	|
	LDA $E4,X				;$02EF85	|
	STA.w $00E4,y				;$02EF87	|
	LDA.w $14E0,X				;$02EF8A	|
	STA.w $14E0,Y				;$02EF8D	|
	LDA $D8,X				;$02EF90	|
	STA.w $00D8,y				;$02EF92	|
	LDA.w $14D4,X				;$02EF95	|
	STA.w $14D4,Y				;$02EF98	|
	PHX					;$02EF9B	|
	TYX					;$02EF9C	|
	JSL InitSpriteTables			;$02EF9D	|
	LDA.b #$E0				;$02EFA1	|
	STA $AA,X				;$02EFA3	|
	INC.w $157C,X				;$02EFA5	|
	PLX					;$02EFA8	|
	RTS					;$02EFA9	|

ADDR_02EFAA:
	LDA.w $1570,X
	CMP.b #$0B				;$02EFAD	|
	BCS Return02EFBB			;$02EFAF	|
	LDY.b #$07				;$02EFB1	|
ADDR_02EFB3:
	LDA.w $170B,Y
	BEQ ADDR_02EFBC				;$02EFB6	|
	DEY					;$02EFB8	|
	BPL ADDR_02EFB3				;$02EFB9	|
Return02EFBB:
	RTS

ADDR_02EFBC:
	LDA.b #$0A
	STA.w $170B,Y				;$02EFBE	|
	LDA $E4,X				;$02EFC1	|
	CLC					;$02EFC3	|
	ADC.b #$04				;$02EFC4	|
	STA.w $171F,Y				;$02EFC6	|
	LDA.w $14E0,X				;$02EFC9	|
	ADC.b #$00				;$02EFCC	|
	STA.w $1733,Y				;$02EFCE	|
	LDA $D8,X				;$02EFD1	|
	STA.w $1715,Y				;$02EFD3	|
	LDA.w $14D4,X				;$02EFD6	|
	STA.w $1729,Y				;$02EFD9	|
	LDA.b #$D0				;$02EFDC	|
	STA.w $173D,Y				;$02EFDE	|
	LDA.b #$00				;$02EFE1	|
	STA.w $1747,Y				;$02EFE3	|
	STA.w $1765,Y				;$02EFE6	|
	RTS					;$02EFE9	|

DATA_02EFEA:
	db $00,$80,$00,$80

DATA_02EFEE:
	db $00,$00,$01,$01

WigglerInit:
	PHB
	PHK					;$02EFF3	|
	PLB					;$02EFF4	|
	JSR CODE_02F011				;$02EFF5	|
	LDY.b #$7E				;$02EFF8	|
CODE_02EFFA:
	LDA $E4,X
	STA [$D5],Y				;$02EFFC	|
	LDA $D8,X				;$02EFFE	|
	INY					;$02F000	|
	STA [$D5],Y				;$02F001	|
	DEY					;$02F003	|
	DEY					;$02F004	|
	DEY					;$02F005	|
	BPL CODE_02EFFA				;$02F006	|
	JSR CODE_02D4FA				;$02F008	|
	TYA					;$02F00B	|
	STA.w $157C,X				;$02F00C	|
	PLB					;$02F00F	|
	RTL					;$02F010	|

CODE_02F011:
	TXA
	AND.b #$03				;$02F012	|
	TAY					;$02F014	|
	LDA.b #$7B				;$02F015	|
	CLC					;$02F017	|
	ADC.w DATA_02EFEA,Y			;$02F018	|
	STA $D5					;$02F01B	|
	LDA.b #$9A				;$02F01D	|
	ADC.w DATA_02EFEE,Y			;$02F01F	|
	STA $D6					;$02F022	|
	LDA.b #$7F				;$02F024	|
	STA $D7					;$02F026	|
	RTS					;$02F028	|

WigglerMain:
	PHB
	PHK					;$02F02A	|
	PLB					;$02F02B	|
	JSR WigglerMainRt			;$02F02C	|
	PLB					;$02F02F	|
	RTL					;$02F030	|

WigglerSpeed:
	db $08,$F8,$10,$F0

WigglerMainRt:
	JSR CODE_02F011
	LDA $9D					;$02F038	|
	BEQ CODE_02F03F				;$02F03A	|
	JMP CODE_02F0D8				;$02F03C	|

CODE_02F03F:
	JSL SprSprInteract
	LDA.w $1540,X				;$02F043	|
	BEQ CODE_02F061				;$02F046	|
	CMP.b #$01				;$02F048	|
	BNE CODE_02F050				;$02F04A	|
	LDA.b #$08				;$02F04C	|
	BRA CODE_02F052				;$02F04E	|

CODE_02F050:
	AND.b #$0E
CODE_02F052:
	STA $00
	LDA.w $15F6,X				;$02F054	|
	AND.b #$F1				;$02F057	|
	ORA $00					;$02F059	|
	STA.w $15F6,X				;$02F05B	|
	JMP CODE_02F0D8				;$02F05E	|

CODE_02F061:
	JSR UpdateXPosNoGrvtyB1
	JSR UpdateYPosNoGrvtyB1			;$02F064	|
	JSR SubOffscreen0Bnk2			;$02F067	|
	INC.w $1570,X				;$02F06A	|
	LDA.w $151C,X				;$02F06D	|
	BEQ CODE_02F086				;$02F070	|
	INC.w $1570,X				;$02F072	|
	INC.w $1534,X				;$02F075	|
	LDA.w $1534,X				;$02F078	|
	AND.b #$3F				;$02F07B	|
	BNE CODE_02F086				;$02F07D	|
	JSR CODE_02D4FA				;$02F07F	|
	TYA					;$02F082	|
	STA.w $157C,X				;$02F083	|
CODE_02F086:
	LDY.w $157C,X
	LDA.w $151C,X				;$02F089	|
	BEQ CODE_02F090				;$02F08C	|
	INY					;$02F08E	|
	INY					;$02F08F	|
CODE_02F090:
	LDA.w WigglerSpeed,Y
	STA $B6,X				;$02F093	|
	INC $AA,X				;$02F095	|
	JSL CODE_019138				;$02F097	|
	LDA.w $1588,X				;$02F09B	|
	AND.b #$03				;$02F09E	|
	BNE CODE_02F0AE				;$02F0A0	|
	LDA.w $1588,X				;$02F0A2	|
	AND.b #$04				;$02F0A5	|
	BEQ CODE_02F0AE				;$02F0A7	|
	JSR CODE_02FFD1				;$02F0A9	|
	BRA CODE_02F0C3				;$02F0AC	|

CODE_02F0AE:
	LDA.w $15AC,X
	BNE CODE_02F0C3				;$02F0B1	|
	LDA.w $157C,X				;$02F0B3	|
	EOR.b #$01				;$02F0B6	|
	STA.w $157C,X				;$02F0B8	|
	STZ.w $1602,X				;$02F0BB	|
	LDA.b #$08				;$02F0BE	|
	STA.w $15AC,X				;$02F0C0	|
CODE_02F0C3:
	JSR CODE_02F0DB
	LDA.w $1602,X				;$02F0C6	|
	INC.w $1602,X				;$02F0C9	|
	AND.b #$07				;$02F0CC	|
	BNE CODE_02F0D8				;$02F0CE	|
	LDA $C2,X				;$02F0D0	|
	ASL					;$02F0D2	|
	ORA.w $157C,X				;$02F0D3	|
	STA $C2,X				;$02F0D6	|
CODE_02F0D8:
	JMP CODE_02F110

CODE_02F0DB:
	PHX
	PHB					;$02F0DC	|
	REP #$30				;$02F0DD	|
	LDA $D5					;$02F0DF	|
	CLC					;$02F0E1	|
	ADC.w #$007D				;$02F0E2	|
	TAX					;$02F0E5	|
	LDA $D5					;$02F0E6	|
	CLC					;$02F0E8	|
	ADC.w #$007F				;$02F0E9	|
	TAY					;$02F0EC	|
	LDA.w #$007D				;$02F0ED	|
	db $44,$7F,$7F				;$02F0F0	|
	SEP #$30				;$02F0F3	|
	PLB					;$02F0F5	|
	PLX					;$02F0F6	|
	LDY.b #$00				;$02F0F7	|
	LDA $E4,X				;$02F0F9	|
	STA [$D5],Y				;$02F0FB	|
	LDA $D8,X				;$02F0FD	|
	INY					;$02F0FF	|
	STA [$D5],Y				;$02F100	|
	RTS					;$02F102	|

DATA_02F103:
	db $00,$1E,$3E,$5E,$7E

DATA_02F108:
	db $00,$01,$02,$01

WigglerTiles:
	db $C4,$C6,$C8,$C6

CODE_02F110:
	JSR GetDrawInfo2
	LDA.w $1570,X				;$02F113	|
	STA $03					;$02F116	|
	LDA.w $15F6,X				;$02F118	|
	STA $07					;$02F11B	|
	LDA.w $151C,X				;$02F11D	|
	STA $08					;$02F120	|
	LDA $C2,X				;$02F122	|
	STA $02					;$02F124	|
	TYA					;$02F126	|
	CLC					;$02F127	|
	ADC.b #$04				;$02F128	|
	TAY					;$02F12A	|
	LDX.b #$00				;$02F12B	|
CODE_02F12D:
	PHX
	STX $05					;$02F12E	|
	LDA $03					;$02F130	|
	LSR					;$02F132	|
	LSR					;$02F133	|
	LSR					;$02F134	|
	NOP					;$02F135	|
	NOP					;$02F136	|
	NOP					;$02F137	|
	NOP					;$02F138	|
	CLC					;$02F139	|
	ADC $05					;$02F13A	|
	AND.b #$03				;$02F13C	|
	STA $06					;$02F13E	|
	PHY					;$02F140	|
	LDY.w DATA_02F103,X			;$02F141	|
	LDA $08					;$02F144	|
	BEQ CODE_02F14D				;$02F146	|
	TYA					;$02F148	|
	LSR					;$02F149	|
	AND.b #$FE				;$02F14A	|
	TAY					;$02F14C	|
CODE_02F14D:
	STY $09
	LDA [$D5],Y				;$02F14F	|
	PLY					;$02F151	|
	SEC					;$02F152	|
	SBC $1A					;$02F153	|
	STA.w $0300,Y				;$02F155	|
	PHY					;$02F158	|
	LDY $09					;$02F159	|
	INY					;$02F15B	|
	LDA [$D5],Y				;$02F15C	|
	PLY					;$02F15E	|
	SEC					;$02F15F	|
	SBC $1C					;$02F160	|
	LDX $06					;$02F162	|
	SEC					;$02F164	|
	SBC.w DATA_02F108,X			;$02F165	|
	STA.w $0301,Y				;$02F168	|
	PLX					;$02F16B	|
	PHX					;$02F16C	|
	LDA.b #$8C				;$02F16D	|
	CPX.b #$00				;$02F16F	|
	BEQ CODE_02F178				;$02F171	|
	LDX $06					;$02F173	|
	LDA.w WigglerTiles,X			;$02F175	|
CODE_02F178:
	STA.w $0302,Y
	PLX					;$02F17B	|
	LDA $07					;$02F17C	|
	ORA $64					;$02F17E	|
	LSR $02					;$02F180	|
	BCS CODE_02F186				;$02F182	|
	ORA.b #$40				;$02F184	|
CODE_02F186:
	STA.w $0303,Y
	PHY					;$02F189	|
	TYA					;$02F18A	|
	LSR					;$02F18B	|
	LSR					;$02F18C	|
	TAY					;$02F18D	|
	LDA.b #$02				;$02F18E	|
	STA.w $0460,Y				;$02F190	|
	PLY					;$02F193	|
	INY					;$02F194	|
	INY					;$02F195	|
	INY					;$02F196	|
	INY					;$02F197	|
	INX					;$02F198	|
	CPX.b #$05				;$02F199	|
	BNE CODE_02F12D				;$02F19B	|
	LDX.w $15E9				;$02F19D	|
	LDA $08					;$02F1A0	|
	BEQ CODE_02F1C7				;$02F1A2	|
	PHX					;$02F1A4	|
	LDY.w $15EA,X				;$02F1A5	|
	LDA.w $157C,X				;$02F1A8	|
	TAX					;$02F1AB	|
	LDA.w $0304,Y				;$02F1AC	|
	CLC					;$02F1AF	|
	ADC.w WigglerEyesX,X			;$02F1B0	|
	PLX					;$02F1B3	|
	STA.w $0300,Y				;$02F1B4	|
	LDA.w $0305,Y				;$02F1B7	|
	STA.w $0301,Y				;$02F1BA	|
	LDA.b #$88				;$02F1BD	|
	STA.w $0302,Y				;$02F1BF	|
	LDA.w $0307,Y				;$02F1C2	|
	BRA CODE_02F1EF				;$02F1C5	|

CODE_02F1C7:
	PHX
	LDY.w $15EA,X				;$02F1C8	|
	LDA.w $157C,X				;$02F1CB	|
	TAX					;$02F1CE	|
	LDA.w $0304,Y				;$02F1CF	|
	CLC					;$02F1D2	|
	ADC.w DATA_02F2D3,X			;$02F1D3	|
	PLX					;$02F1D6	|
	STA.w $0300,Y				;$02F1D7	|
	LDA.w $0305,Y				;$02F1DA	|
	SEC					;$02F1DD	|
	SBC.b #$08				;$02F1DE	|
	STA.w $0301,Y				;$02F1E0	|
	LDA.b #$98				;$02F1E3	|
	STA.w $0302,Y				;$02F1E5	|
	LDA.w $0307,Y				;$02F1E8	|
	AND.b #$F1				;$02F1EB	|
	ORA.b #$0A				;$02F1ED	|
CODE_02F1EF:
	STA.w $0303,Y
	TYA					;$02F1F2	|
	LSR					;$02F1F3	|
	LSR					;$02F1F4	|
	TAY					;$02F1F5	|
	LDA.b #$00				;$02F1F6	|
	STA.w $0460,Y				;$02F1F8	|
	LDA.b #$05				;$02F1FB	|
	LDY.b #$FF				;$02F1FD	|
	JSR CODE_02B7A7				;$02F1FF	|
	LDA $E4,X				;$02F202	|
	STA $00					;$02F204	|
	LDA.w $14E0,X				;$02F206	|
	STA $01					;$02F209	|
	REP #$20				;$02F20B	|
	LDA $00					;$02F20D	|
	SEC					;$02F20F	|
	SBC $94					;$02F210	|
	CLC					;$02F212	|
	ADC.w #$0050				;$02F213	|
	CMP.w #$00A0				;$02F216	|
	SEP #$20				;$02F219	|
	BCS Return02F295			;$02F21B	|
	LDA.w $14C8,X				;$02F21D	|
	CMP.b #$08				;$02F220	|
	BNE Return02F295			;$02F222	|
	LDA.b #$04				;$02F224	|
	STA $00					;$02F226	|
	LDY.w $15EA,X				;$02F228	|
CODE_02F22B:
	LDA.w $0304,Y
	SEC					;$02F22E	|
	SBC $7E					;$02F22F	|
	ADC.b #$0C				;$02F231	|
	CMP.b #$18				;$02F233	|
	BCS CODE_02F29B				;$02F235	|
	LDA.w $0305,Y				;$02F237	|
	SEC					;$02F23A	|
	SBC $80					;$02F23B	|
	SBC.b #$10				;$02F23D	|
	PHY					;$02F23F	|
	LDY.w $187A				;$02F240	|
	BEQ CODE_02F247				;$02F243	|
	SBC.b #$10				;$02F245	|
CODE_02F247:
	PLY
	CLC					;$02F248	|
	ADC.b #$0C				;$02F249	|
	CMP.b #$18				;$02F24B	|
	BCS CODE_02F29B				;$02F24D	|
	LDA.w $1490				;$02F24F	|
	BNE ADDR_02F29D				;$02F252	|
	LDA.w $154C,X				;$02F254	|
	ORA $81					;$02F257	|
	BNE CODE_02F29B				;$02F259	|
	LDA.b #$08				;$02F25B	|
	STA.w $154C,X				;$02F25D	|
	LDA.w $1697				;$02F260	|
	BNE CODE_02F26B				;$02F263	|
	LDA $7D					;$02F265	|
	CMP.b #$08				;$02F267	|
	BMI CODE_02F296				;$02F269	|
CODE_02F26B:
	LDA.b #$03
	STA.w $1DF9				;$02F26D	|
	JSL BoostMarioSpeed			;$02F270	|
	LDA.w $151C,X				;$02F274	|
	ORA.w $15D0,X				;$02F277	|
	BNE Return02F295			;$02F27A	|
	JSL DisplayContactGfx			;$02F27C	|
	LDA.w $1697				;$02F280	|
	INC.w $1697				;$02F283	|
	JSL GivePoints				;$02F286	|
	LDA.b #$40				;$02F28A	|
	STA.w $1540,X				;$02F28C	|
	INC.w $151C,X				;$02F28F	|
	JSR CODE_02F2D7				;$02F292	|
Return02F295:
	RTS

CODE_02F296:
	JSL HurtMario
	RTS					;$02F29A	|

CODE_02F29B:
	BRA CODE_02F2C7

ADDR_02F29D:
	LDA.b #$02
	STA.w $14C8,X				;$02F29F	|
	LDA.b #$D0				;$02F2A2	|
	STA $AA,X				;$02F2A4	|
	INC.w $18D2				;$02F2A6	|
	LDA.w $18D2				;$02F2A9	|
	CMP.b #$09				;$02F2AC	|
	BCC ADDR_02F2B5				;$02F2AE	|
	LDA.b #$09				;$02F2B0	|
	STA.w $18D2				;$02F2B2	|
ADDR_02F2B5:
	JSL GivePoints
	LDY.w $18D2				;$02F2B9	|
	CPY.b #$08				;$02F2BC	|
	BCS Return02F2C6			;$02F2BE	|
	LDA.w DATA_02D57F,Y			;$02F2C0	|
	STA.w $1DF9				;$02F2C3	|
Return02F2C6:
	RTS

CODE_02F2C7:
	INY
	INY					;$02F2C8	|
	INY					;$02F2C9	|
	INY					;$02F2CA	|
	DEC $00					;$02F2CB	|
	BMI Return02F2D2			;$02F2CD	|
	JMP CODE_02F22B				;$02F2CF	|

Return02F2D2:
	RTS

DATA_02F2D3:
	db $00,$08

WigglerEyesX:
	db $04,$04

CODE_02F2D7:
	LDY.b #$07
CODE_02F2D9:
	LDA.w $170B,Y
	BEQ CODE_02F2E2				;$02F2DC	|
	DEY					;$02F2DE	|
	BPL CODE_02F2D9				;$02F2DF	|
	RTS					;$02F2E1	|

CODE_02F2E2:
	LDA.b #$0E
	STA.w $170B,Y				;$02F2E4	|
	LDA.b #$01				;$02F2E7	|
	STA.w $1765,Y				;$02F2E9	|
	LDA $E4,X				;$02F2EC	|
	STA.w $171F,Y				;$02F2EE	|
	LDA.w $14E0,X				;$02F2F1	|
	STA.w $1733,Y				;$02F2F4	|
	LDA $D8,X				;$02F2F7	|
	STA.w $1715,Y				;$02F2F9	|
	LDA $D8,X				;$02F2FC	|
	STA.w $1729,Y				;$02F2FE	|
	LDA.b #$D0				;$02F301	|
	STA.w $173D,Y				;$02F303	|
	LDA $B6,X				;$02F306	|
	EOR.b #$FF				;$02F308	|
	INC A					;$02F30A	|
	STA.w $1747,Y				;$02F30B	|
	RTS					;$02F30E	|

BirdsMain:
	PHB
	PHK					;$02F310	|
	PLB					;$02F311	|
	JSR CODE_02F317				;$02F312	|
	PLB					;$02F315	|
	RTL					;$02F316	|

CODE_02F317:
	LDA.w $15AC,X
	BEQ CODE_02F321				;$02F31A	|
	LDA.b #$04				;$02F31C	|
	STA.w $1602,X				;$02F31E	|
CODE_02F321:
	JSR CODE_02F3EA
	JSR UpdateXPosNoGrvtyB1			;$02F324	|
	JSR UpdateYPosNoGrvtyB1			;$02F327	|
	LDA $AA,X				;$02F32A	|
	CLC					;$02F32C	|
	ADC.b #$03				;$02F32D	|
	STA $AA,X				;$02F32F	|
	LDA $C2,X				;$02F331	|
	JSL execute_pointer			;$02F333	|

BirdsPtrs:
	dw CODE_02F342
	dw CODE_02F38F

	RTS					;$02F33B	|

DATA_02F33C:
	db $02,$03,$05,$01

DATA_02F340:
	db $08,$F8

CODE_02F342:
	LDY.w $157C,X
	LDA.w DATA_02F340,Y			;$02F345	|
	STA $B6,X				;$02F348	|
	STZ.w $1602,X				;$02F34A	|
	LDA $AA,X				;$02F34D	|
	BMI Return02F370			;$02F34F	|
	LDA $D8,X				;$02F351	|
	CMP.b #$E8				;$02F353	|
	BCC Return02F370			;$02F355	|
	AND.b #$F8				;$02F357	|
	STA $D8,X				;$02F359	|
	LDA.b #$F0				;$02F35B	|
	STA $AA,X				;$02F35D	|
	LDA $E4,X				;$02F35F	|
	CLC					;$02F361	|
	ADC.b #$30				;$02F362	|
	CMP.b #$60				;$02F364	|
	BCC CODE_02F381				;$02F366	|
	LDA.w $1570,X				;$02F368	|
	BEQ CODE_02F371				;$02F36B	|
	DEC.w $1570,X				;$02F36D	|
Return02F370:
	RTS

CODE_02F371:
	INC $C2,X
	JSL GetRand				;$02F373	|
	AND.b #$03				;$02F377	|
	TAY					;$02F379	|
	LDA.w DATA_02F33C,Y			;$02F37A	|
	STA.w $1570,X				;$02F37D	|
	RTS					;$02F380	|

CODE_02F381:
	LDA.w $154C,X
	BNE Return02F38E			;$02F384	|
	JSR CODE_02F3C1				;$02F386	|
	LDA.b #$10				;$02F389	|
	STA.w $154C,X				;$02F38B	|
Return02F38E:
	RTS

CODE_02F38F:
	STZ $AA,X
	STZ $B6,X				;$02F391	|
	STZ.w $1602,X				;$02F393	|
	LDA.w $1540,X				;$02F396	|
	BEQ CODE_02F3A3				;$02F399	|
	CMP.b #$08				;$02F39B	|
	BCS Return02F3A2			;$02F39D	|
	INC.w $1602,X				;$02F39F	|
Return02F3A2:
	RTS

CODE_02F3A3:
	LDA.w $1570,X
	BEQ CODE_02F3B7				;$02F3A6	|
	DEC.w $1570,X				;$02F3A8	|
	JSL GetRand				;$02F3AB	|
	AND.b #$1F				;$02F3AF	|
	ORA.b #$0A				;$02F3B1	|
	STA.w $1540,X				;$02F3B3	|
	RTS					;$02F3B6	|

CODE_02F3B7:
	STZ $C2,X
	JSL GetRand				;$02F3B9	|
	AND.b #$01				;$02F3BD	|
	BNE CODE_02F3CE				;$02F3BF	|
CODE_02F3C1:
	LDA.w $157C,X
	EOR.b #$01				;$02F3C4	|
	STA.w $157C,X				;$02F3C6	|
	LDA.b #$0A				;$02F3C9	|
	STA.w $15AC,X				;$02F3CB	|
CODE_02F3CE:
	JSL GetRand
	AND.b #$03				;$02F3D2	|
	CLC					;$02F3D4	|
	ADC.b #$02				;$02F3D5	|
	STA.w $1570,X				;$02F3D7	|
	RTS					;$02F3DA	|

BirdsTilemap:
	db $D2,$D3,$D0,$D1,$9B

BirdsFlip:
	db $71,$31

BirdsPal:
	db $08,$04,$06,$0A

FireplaceTilemap:
	db $30,$34,$48,$3C

CODE_02F3EA:
	TXA
	AND.b #$03				;$02F3EB	|
	TAY					;$02F3ED	|
	LDA.w BirdsPal,Y			;$02F3EE	|
	LDY.w $157C,X				;$02F3F1	|
	ORA.w BirdsFlip,Y			;$02F3F4	|
	STA $02					;$02F3F7	|
	TXA					;$02F3F9	|
	AND.b #$03				;$02F3FA	|
	TAY					;$02F3FC	|
	LDA.w FireplaceTilemap,Y		;$02F3FD	|
	TAY					;$02F400	|
	LDA $E4,X				;$02F401	|
	SEC					;$02F403	|
	SBC $1A					;$02F404	|
	STA.w $0200,Y				;$02F406	|
	LDA $D8,X				;$02F409	|
	SEC					;$02F40B	|
	SBC $1C					;$02F40C	|
	STA.w $0201,Y				;$02F40E	|
	PHX					;$02F411	|
	LDA.w $1602,X				;$02F412	|
	TAX					;$02F415	|
	LDA.w BirdsTilemap,X			;$02F416	|
	STA.w $0202,Y				;$02F419	|
	PLX					;$02F41C	|
	LDA $02					;$02F41D	|
	STA.w $0203,Y				;$02F41F	|
	TYA					;$02F422	|
	LSR					;$02F423	|
	LSR					;$02F424	|
	TAY					;$02F425	|
	LDA.b #$00				;$02F426	|
	STA.w $0420,Y				;$02F428	|
	RTS					;$02F42B	|

SmokeMain:
	PHB
	PHK					;$02F42D	|
	PLB					;$02F42E	|
	JSR CODE_02F434				;$02F42F	|
	PLB					;$02F432	|
	RTL					;$02F433	|

CODE_02F434:
	INC.w $1570,X
	LDY.b #$04				;$02F437	|
	LDA.w $1570,X				;$02F439	|
	AND.b #$40				;$02F43C	|
	BEQ CODE_02F442				;$02F43E	|
	LDY.b #$FE				;$02F440	|
CODE_02F442:
	STY $B6,X
	LDA.b #$FC				;$02F444	|
	STA $AA,X				;$02F446	|
	JSR UpdateYPosNoGrvtyB1			;$02F448	|
	LDA.w $1540,X				;$02F44B	|
	BNE CODE_02F453				;$02F44E	|
	JSR UpdateXPosNoGrvtyB1			;$02F450	|
CODE_02F453:
	JSR CODE_02F47C
	LDA $D8,X				;$02F456	|
	SEC					;$02F458	|
	SBC $1C					;$02F459	|
	CMP.b #$F0				;$02F45B	|
	BNE Return02F462			;$02F45D	|
	STZ.w $14C8,X				;$02F45F	|
Return02F462:
	RTS

DATA_02F463:
	db $03,$04,$05,$04,$05,$06,$05,$06
	db $07,$06,$07,$08,$07,$08,$07,$08
	db $07,$08,$07,$08,$07,$08,$07,$08
	db $07

CODE_02F47C:
	LDA $14
	AND.b #$0F				;$02F47E	|
	BNE CODE_02F485				;$02F480	|
	INC.w $151C,X				;$02F482	|
CODE_02F485:
	LDY.w $151C,X
	LDA.w DATA_02F463,Y			;$02F488	|
	STA $00					;$02F48B	|
	LDY.w $15EA,X				;$02F48D	|
	LDA $E4,X				;$02F490	|
	SEC					;$02F492	|
	SBC $1A					;$02F493	|
	PHA					;$02F495	|
	SEC					;$02F496	|
	SBC $00					;$02F497	|
	STA.w $0300,Y				;$02F499	|
	PLA					;$02F49C	|
	CLC					;$02F49D	|
	ADC $00					;$02F49E	|
	STA.w $0304,Y				;$02F4A0	|
	LDA $D8,X				;$02F4A3	|
	SEC					;$02F4A5	|
	SBC $1C					;$02F4A6	|
	STA.w $0301,Y				;$02F4A8	|
	STA.w $0305,Y				;$02F4AB	|
	LDA.b #$C5				;$02F4AE	|
	STA.w $0302,Y				;$02F4B0	|
	STA.w $0306,Y				;$02F4B3	|
	LDA.b #$05				;$02F4B6	|
	STA.w $0303,Y				;$02F4B8	|
	ORA.b #$40				;$02F4BB	|
	STA.w $0307,Y				;$02F4BD	|
	TYA					;$02F4C0	|
	LSR					;$02F4C1	|
	LSR					;$02F4C2	|
	TAY					;$02F4C3	|
	LDA.b #$02				;$02F4C4	|
	STA.w $0460,Y				;$02F4C6	|
	STA.w $0461,Y				;$02F4C9	|
	RTS					;$02F4CC	|

SideExitMain:
	PHB
	PHK					;$02F4CE	|
	PLB					;$02F4CF	|
	JSR CODE_02F4D5				;$02F4D0	|
	PLB					;$02F4D3	|
	RTL					;$02F4D4	|

CODE_02F4D5:
	LDA.b #$01
	STA.w $1B96				;$02F4D7	|
	LDA $E4,X				;$02F4DA	|
	AND.b #$10				;$02F4DC	|
	BNE Return02F4E6			;$02F4DE	|
	JSR CODE_02F4EB				;$02F4E0	|
	JSR CODE_02F53E				;$02F4E3	|
Return02F4E6:
	RTS

DATA_02F4E7:
	db $D4,$AB

DATA_02F4E9:
	db $BB,$9A

CODE_02F4EB:
	LDA.w $15EA,X
	CLC					;$02F4EE	|
	ADC.b #$08				;$02F4EF	|
	TAY					;$02F4F1	|
	LDA.b #$B8				;$02F4F2	|
	STA.w $0300,Y				;$02F4F4	|
	STA.w $0304,Y				;$02F4F7	|
	LDA.b #$B0				;$02F4FA	|
	STA.w $0301,Y				;$02F4FC	|
	LDA.b #$B8				;$02F4FF	|
	STA.w $0305,Y				;$02F501	|
	LDA $13					;$02F504	|
	AND.b #$03				;$02F506	|
	BNE CODE_02F516				;$02F508	|
	PHY					;$02F50A	|
	JSL GetRand				;$02F50B	|
	PLY					;$02F50F	|
	AND.b #$03				;$02F510	|
	BNE CODE_02F516				;$02F512	|
	INC $C2,X				;$02F514	|
CODE_02F516:
	PHX
	LDA $C2,X				;$02F517	|
	AND.b #$01				;$02F519	|
	TAX					;$02F51B	|
	LDA.w DATA_02F4E7,X			;$02F51C	|
	STA.w $0302,Y				;$02F51F	|
	LDA.w DATA_02F4E9,X			;$02F522	|
	STA.w $0306,Y				;$02F525	|
	LDA.b #$35				;$02F528	|
	STA.w $0303,Y				;$02F52A	|
	STA.w $0307,Y				;$02F52D	|
	TYA					;$02F530	|
	LSR					;$02F531	|
	LSR					;$02F532	|
	TAY					;$02F533	|
	LDA.b #$00				;$02F534	|
	STA.w $0460,Y				;$02F536	|
	STA.w $0461,Y				;$02F539	|
	PLX					;$02F53C	|
	RTS					;$02F53D	|

CODE_02F53E:
	LDA $14
	AND.b #$3F				;$02F540	|
	BNE Return02F547			;$02F542	|
	JSR CODE_02F548				;$02F544	|
Return02F547:
	RTS

CODE_02F548:
	LDY.b #$09
CODE_02F54A:
	LDA.w $14C8,Y
	BEQ CODE_02F553				;$02F54D	|
	DEY					;$02F54F	|
	BPL CODE_02F54A				;$02F550	|
	RTS					;$02F552	|

CODE_02F553:
	LDA.b #$8B
	STA.w $009E,y				;$02F555	|
	LDA.b #$08				;$02F558	|
	STA.w $14C8,Y				;$02F55A	|
	PHX					;$02F55D	|
	TYX					;$02F55E	|
	JSL InitSpriteTables			;$02F55F	|
	LDA.b #$BB				;$02F563	|
	STA $E4,X				;$02F565	|
	LDA.b #$00				;$02F567	|
	STA.w $14E0,X				;$02F569	|
	LDA.b #$00				;$02F56C	|
	STA.w $14D4,X				;$02F56E	|
	LDA.b #$E0				;$02F571	|
	STA $D8,X				;$02F573	|
	LDA.b #$20				;$02F575	|
	STA.w $1540,X				;$02F577	|
	PLX					;$02F57A	|
	RTS					;$02F57B	|

CODE_02F57C:
	PHB
	PHK					;$02F57D	|
	PLB					;$02F57E	|
	JSR CODE_02F759				;$02F57F	|
	PLB					;$02F582	|
	RTL					;$02F583	|

CODE_02F584:
	PHB
	PHK					;$02F585	|
	PLB					;$02F586	|
	JSR CODE_02F66E				;$02F587	|
	PLB					;$02F58A	|
	RTL					;$02F58B	|

ADDR_02F58C:
	PHB
	PHK					;$02F58D	|
	PLB					;$02F58E	|
	JSR ADDR_02F639				;$02F58F	|
	PLB					;$02F592	|
	RTL					;$02F593	|

GhostExitMain:
	PHB
	PHK					;$02F595	|
	PLB					;$02F596	|
	PHX					;$02F597	|
	JSR CODE_02F5D0				;$02F598	|
	PLX					;$02F59B	|
	PLB					;$02F59C	|
	RTL					;$02F59D	|

DATA_02F59E:
	db $08,$18,$F8,$F8,$F8,$F8,$28,$28
	db $28,$28

DATA_02F5A8:
	db $00,$00,$FF,$FF,$FF,$FF,$00,$00
	db $00,$00

DATA_02F5B2:
	db $5F,$5F,$8F,$97,$A7,$AF,$8F,$97
	db $A7,$AF

DATA_02F5BC:
	db $9C,$9E,$A0,$B0,$B0,$A0,$A0,$B0
	db $B0,$A0

DATA_02F5C6:
	db $23,$23,$2D,$2D,$AD,$AD,$6D,$6D
	db $ED,$ED

CODE_02F5D0:
	LDA $1A
	CMP.b #$46				;$02F5D2	|
	BCS Return02F618			;$02F5D4	|
	LDX.b #$09				;$02F5D6	|
	LDY.b #$A0				;$02F5D8	|
CODE_02F5DA:
	STZ $02
	LDA.w DATA_02F59E,X			;$02F5DC	|
	SEC					;$02F5DF	|
	SBC $1A					;$02F5E0	|
	STA $00					;$02F5E2	|
	LDA.w DATA_02F5A8,X			;$02F5E4	|
	SBC $1B					;$02F5E7	|
	BEQ CODE_02F5ED				;$02F5E9	|
	INC $02					;$02F5EB	|
CODE_02F5ED:
	LDA $00
	STA.w $0300,Y				;$02F5EF	|
	LDA.w DATA_02F5B2,X			;$02F5F2	|
	STA.w $0301,Y				;$02F5F5	|
	LDA.w DATA_02F5BC,X			;$02F5F8	|
	STA.w $0302,Y				;$02F5FB	|
	LDA.w DATA_02F5C6,X			;$02F5FE	|
	STA.w $0303,Y				;$02F601	|
	PHY					;$02F604	|
	TYA					;$02F605	|
	LSR					;$02F606	|
	LSR					;$02F607	|
	TAY					;$02F608	|
	LDA.b #$02				;$02F609	|
	ORA $02					;$02F60B	|
	STA.w $0460,Y				;$02F60D	|
	PLY					;$02F610	|
	INY					;$02F611	|
	INY					;$02F612	|
	INY					;$02F613	|
	INY					;$02F614	|
	DEX					;$02F615	|
	BPL CODE_02F5DA				;$02F616	|
Return02F618:
	RTS

DATA_02F619:
	db $F8,$08,$F8,$08,$00,$00,$00,$00
DATA_02F621:
	db $00,$00,$10,$10,$20,$30,$40,$08
DATA_02F629:
	db $C7,$A7,$A7,$C7,$A9,$C9,$C9,$E0
DATA_02F631:
	db $A9,$69,$A9,$69,$29,$29,$29,$6B

ADDR_02F639:
	LDX.b #$07
	LDY.b #$B0				;$02F63B	|
ADDR_02F63D:
	LDA.b #$C0
	CLC					;$02F63F	|
	ADC.w DATA_02F619,X			;$02F640	|
	STA.w $0300,Y				;$02F643	|
	LDA.b #$70				;$02F646	|
	CLC					;$02F648	|
	ADC.w DATA_02F621,X			;$02F649	|
	STA.w $0301,Y				;$02F64C	|
	LDA.w DATA_02F629,X			;$02F64F	|
	STA.w $0302,Y				;$02F652	|
	LDA.w DATA_02F631,X			;$02F655	|
	STA.w $0303,Y				;$02F658	|
	PHY					;$02F65B	|
	TYA					;$02F65C	|
	LSR					;$02F65D	|
	LSR					;$02F65E	|
	TAY					;$02F65F	|
	LDA.b #$02				;$02F660	|
	STA.w $0460,Y				;$02F662	|
	PLY					;$02F665	|
	INY					;$02F666	|
	INY					;$02F667	|
	INY					;$02F668	|
	INY					;$02F669	|
	DEX					;$02F66A	|
	BPL ADDR_02F63D				;$02F66B	|
	RTS					;$02F66D	|

CODE_02F66E:
	LDA.w $18D9
	BEQ CODE_02F676				;$02F671	|
	DEC.w $18D9				;$02F673	|
CODE_02F676:
	CMP.b #$B0
	BNE CODE_02F67F				;$02F678	|
	LDY.b #$0F				;$02F67A	|
	STY.w $1DFC				;$02F67C	|
CODE_02F67F:
	CMP.b #$01
	BNE CODE_02F688				;$02F681	|
	LDY.b #$10				;$02F683	|
	STY.w $1DFC				;$02F685	|
CODE_02F688:
	CMP.b #$30
	BCC CODE_02F69A				;$02F68A	|
	CMP.b #$81				;$02F68C	|
	BCC CODE_02F698				;$02F68E	|
	CLC					;$02F690	|
	ADC.b #$4F				;$02F691	|
	EOR.b #$FF				;$02F693	|
	INC A					;$02F695	|
	BRA CODE_02F69A				;$02F696	|

CODE_02F698:
	LDA.b #$30
CODE_02F69A:
	STA $00
	JSR CODE_02F6B8				;$02F69C	|
	RTS					;$02F69F	|

DATA_02F6A0:
	db $00,$10,$20,$00,$10,$20,$00,$10
	db $20,$00,$10,$20

DATA_02F6AC:
	db $00,$00,$00,$10,$10,$10,$20,$20
	db $20,$30,$30,$30

CODE_02F6B8:
	LDX.b #$0B
	LDY.b #$B0				;$02F6BA	|
CODE_02F6BC:
	LDA.b #$B8
	CLC					;$02F6BE	|
	ADC.w DATA_02F6A0,X			;$02F6BF	|
	STA.w $0200,Y				;$02F6C2	|
	LDA.b #$50				;$02F6C5	|
	SEC					;$02F6C7	|
	SBC $1C					;$02F6C8	|
	SEC					;$02F6CA	|
	SBC $00					;$02F6CB	|
	CLC					;$02F6CD	|
	ADC.w DATA_02F6AC,X			;$02F6CE	|
	STA.w $0201,Y				;$02F6D1	|
	LDA.b #$A5				;$02F6D4	|
	STA.w $0202,Y				;$02F6D6	|
	LDA.b #$21				;$02F6D9	|
	STA.w $0203,Y				;$02F6DB	|
	PHY					;$02F6DE	|
	TYA					;$02F6DF	|
	LSR					;$02F6E0	|
	LSR					;$02F6E1	|
	TAY					;$02F6E2	|
	LDA.b #$02				;$02F6E3	|
	STA.w $0420,Y				;$02F6E5	|
	PLY					;$02F6E8	|
	INY					;$02F6E9	|
	INY					;$02F6EA	|
	INY					;$02F6EB	|
	INY					;$02F6EC	|
	DEX					;$02F6ED	|
	BPL CODE_02F6BC				;$02F6EE	|
	RTS					;$02F6F0	|

DATA_02F6F1:
	db $00,$00,$00,$00,$10,$10,$10,$10
	db $00,$00,$00,$00,$10,$10,$10,$10
	db $00,$00,$00,$00,$10,$10,$10,$10
	db $F2,$F2,$F2,$F2,$1E,$1E,$1E,$1E
DATA_02F711:
	db $00,$08,$18,$20,$00,$08,$18,$20
DATA_02F719:
	db $7D,$7D,$FD,$FD,$3D,$3D,$BD,$BD
DATA_02F721:
	db $A0,$B0,$B0,$A0,$A0,$B0,$B0,$A0
	db $A3,$B3,$B3,$A3,$A3,$B3,$B3,$A3
	db $A2,$B2,$B2,$A2,$A2,$B2,$B2,$A2
	db $A3,$B3,$B3,$A3,$A3,$B3,$B3,$A3
DATA_02F741:
	db $40,$44,$48,$4C,$F0,$F4,$F8,$FC
DATA_02F749:
	db $00,$01,$02,$03,$03,$03,$03,$03
	db $03,$03,$03,$03,$03,$02,$01,$00

CODE_02F759:
	LDA.w $18D9
	BEQ CODE_02F761				;$02F75C	|
	DEC.w $18D9				;$02F75E	|
CODE_02F761:
	CMP.b #$76
	BNE CODE_02F76A				;$02F763	|
	LDY.b #$0F				;$02F765	|
	STY.w $1DFC				;$02F767	|
CODE_02F76A:
	CMP.b #$08
	BNE CODE_02F773				;$02F76C	|
	LDY.b #$10				;$02F76E	|
	STY.w $1DFC				;$02F770	|
CODE_02F773:
	LSR
	LSR					;$02F774	|
	LSR					;$02F775	|
	TAY					;$02F776	|
	LDA.w DATA_02F749,Y			;$02F777	|
	STA $03					;$02F77A	|
	LDX.b #$07				;$02F77C	|
	LDA.b #$B8				;$02F77E	|
	SEC					;$02F780	|
	SBC $1A					;$02F781	|
	STA $00					;$02F783	|
	LDA.b #$60				;$02F785	|
	SEC					;$02F787	|
	SBC $1C					;$02F788	|
	STA $01					;$02F78A	|
CODE_02F78C:
	STX $02
	LDY.w DATA_02F741,X			;$02F78E	|
	LDA $03					;$02F791	|
	ASL					;$02F793	|
	ASL					;$02F794	|
	ASL					;$02F795	|
	CLC					;$02F796	|
	ADC $02					;$02F797	|
	TAX					;$02F799	|
	TYA					;$02F79A	|
	BMI CODE_02F7D0				;$02F79B	|
	LDA $00					;$02F79D	|
	CLC					;$02F79F	|
	ADC.w DATA_02F6F1,X			;$02F7A0	|
	STA.w $0300,Y				;$02F7A3	|
	LDA.w DATA_02F721,X			;$02F7A6	|
	STA.w $0302,Y				;$02F7A9	|
	LDX $02					;$02F7AC	|
	LDA $01					;$02F7AE	|
	CLC					;$02F7B0	|
	ADC.w DATA_02F711,X			;$02F7B1	|
	STA.w $0301,Y				;$02F7B4	|
	LDA $03					;$02F7B7	|
	CMP.b #$03				;$02F7B9	|
	LDA.w DATA_02F719,X			;$02F7BB	|
	BCC CODE_02F7C2				;$02F7BE	|
	EOR.b #$40				;$02F7C0	|
CODE_02F7C2:
	STA.w $0303,Y
	TYA					;$02F7C5	|
	LSR					;$02F7C6	|
	LSR					;$02F7C7	|
	TAY					;$02F7C8	|
	LDA.b #$02				;$02F7C9	|
	STA.w $0460,Y				;$02F7CB	|
	BRA CODE_02F801				;$02F7CE	|

CODE_02F7D0:
	LDA $00
	CLC					;$02F7D2	|
	ADC.w DATA_02F6F1,X			;$02F7D3	|
	STA.w $0200,Y				;$02F7D6	|
	LDA.w DATA_02F721,X			;$02F7D9	|
	STA.w $0202,Y				;$02F7DC	|
	LDX $02					;$02F7DF	|
	LDA $01					;$02F7E1	|
	CLC					;$02F7E3	|
	ADC.w DATA_02F711,X			;$02F7E4	|
	STA.w $0201,Y				;$02F7E7	|
	LDA $03					;$02F7EA	|
	CMP.b #$03				;$02F7EC	|
	LDA.w DATA_02F719,X			;$02F7EE	|
	BCC CODE_02F7F5				;$02F7F1	|
	EOR.b #$40				;$02F7F3	|
CODE_02F7F5:
	STA.w $0203,Y
	TYA					;$02F7F8	|
	LSR					;$02F7F9	|
	LSR					;$02F7FA	|
	TAY					;$02F7FB	|
	LDA.b #$02				;$02F7FC	|
	STA.w $0420,Y				;$02F7FE	|
CODE_02F801:
	DEX
	BMI Return02F807			;$02F802	|
	JMP CODE_02F78C				;$02F804	|

Return02F807:
	RTS

CODE_02F808:
	PHB
	PHK					;$02F809	|
	PLB					;$02F80A	|
	JSR CODE_02F810				;$02F80B	|
	PLB					;$02F80E	|
	RTL					;$02F80F	|

CODE_02F810:
	LDX.b #$13
CODE_02F812:
	STX.w $15E9
	LDA.w $1892,X				;$02F815	|
	BEQ CODE_02F81D				;$02F818	|
	JSR CODE_02F821				;$02F81A	|
CODE_02F81D:
	DEX
	BPL CODE_02F812				;$02F81E	|
Return02F820:
	RTS

CODE_02F821:
	JSL execute_pointer

Ptrs02F825:
	dw Return02F820
	dw CODE_02FDBC
	dw $0000
	dw CODE_02FBC7
	dw CODE_02FA98
	dw CODE_02FA16
	dw CODE_02F91C
	dw CODE_02F83D
	dw CODE_02FBC7

DATA_02F837:
	db $01,$FF

DATA_02F839:
	db $00,$FF,$02,$0E

CODE_02F83D:
	LDA.w $190A
	STA.w $185E				;$02F840	|
	TXY					;$02F843	|
	BNE CODE_02F855				;$02F844	|
	DEC.w $190A				;$02F846	|
	CMP.b #$00				;$02F849	|
	BNE CODE_02F855				;$02F84B	|
	INC.w $18BA				;$02F84D	|
	LDY.b #$FF				;$02F850	|
	STY.w $190A				;$02F852	|
CODE_02F855:
	CMP.b #$00
	BNE CODE_02F89E				;$02F857	|
	LDA.w $18BF				;$02F859	|
	BEQ CODE_02F865				;$02F85C	|
	STZ.w $1892,X				;$02F85E	|
	STZ.w $18BA				;$02F861	|
	RTS					;$02F864	|

CODE_02F865:
	LDA.w $1E66,X
	STA $00					;$02F868	|
	LDA.w $1E52,X				;$02F86A	|
	STA $01					;$02F86D	|
	LDA.w $18BA				;$02F86F	|
	AND.b #$01				;$02F872	|
	BNE CODE_02F880				;$02F874	|
	LDA.w $1E8E,X				;$02F876	|
	STA $00					;$02F879	|
	LDA.w $1E7A,X				;$02F87B	|
	STA $01					;$02F87E	|
CODE_02F880:
	LDA $00
	CLC					;$02F882	|
	ADC $1A					;$02F883	|
	STA.w $1E16,X				;$02F885	|
	LDA $1B					;$02F888	|
	ADC.b #$00				;$02F88A	|
	STA.w $1E3E,X				;$02F88C	|
	LDA $01					;$02F88F	|
	CLC					;$02F891	|
	ADC $1C					;$02F892	|
	STA.w $1E02,X				;$02F894	|
	LDA $1D					;$02F897	|
	ADC.b #$00				;$02F899	|
	STA.w $1E2A,X				;$02F89B	|
CODE_02F89E:
	TXA
	ASL					;$02F89F	|
	ASL					;$02F8A0	|
	ADC $14					;$02F8A1	|
	STA $00					;$02F8A3	|
	AND.b #$07				;$02F8A5	|
	ORA $9D					;$02F8A7	|
	BNE CODE_02F8C8				;$02F8A9	|
	LDA $00					;$02F8AB	|
	AND.b #$20				;$02F8AD	|
	LSR					;$02F8AF	|
	LSR					;$02F8B0	|
	LSR					;$02F8B1	|
	LSR					;$02F8B2	|
	LSR					;$02F8B3	|
	TAY					;$02F8B4	|
	LDA.w $1E02,X				;$02F8B5	|
	CLC					;$02F8B8	|
	ADC.w DATA_02F837,Y			;$02F8B9	|
	STA.w $1E02,X				;$02F8BC	|
	LDA.w $1E2A,X				;$02F8BF	|
	ADC.w DATA_02F839,Y			;$02F8C2	|
	STA.w $1E2A,X				;$02F8C5	|
CODE_02F8C8:
	LDY.w $185E
	CPY.b #$20				;$02F8CB	|
	BCC Return02F8FB			;$02F8CD	|
	CPY.b #$40				;$02F8CF	|
	BCS CODE_02F8D8				;$02F8D1	|
	TYA					;$02F8D3	|
	SBC.b #$1F				;$02F8D4	|
	BRA CODE_02F8E2				;$02F8D6	|

CODE_02F8D8:
	CPY.b #$E0
	BCC CODE_02F8E6				;$02F8DA	|
	TYA					;$02F8DC	|
	SBC.b #$E0				;$02F8DD	|
	EOR.b #$1F				;$02F8DF	|
	INC A					;$02F8E1	|
CODE_02F8E2:
	LSR
	LSR					;$02F8E3	|
	BRA CODE_02F8EB				;$02F8E4	|

CODE_02F8E6:
	JSR CODE_02FBB0
	LDA.b #$08				;$02F8E9	|
CODE_02F8EB:
	STA.w $190B
	CPX.b #$00				;$02F8EE	|
	BNE CODE_02F8F6				;$02F8F0	|
	JSL CODE_038239				;$02F8F2	|
CODE_02F8F6:
	LDA.b #$0F
	JSR CODE_02FD48				;$02F8F8	|
Return02F8FB:
	RTS

DATA_02F8FC:
	db $00,$10,$00,$10,$08,$10,$FF,$10
SumoBroFlameTiles:
	db $DC,$EC,$CC,$EC,$CC,$DC,$00,$CC
DATA_02F90C:
	db $03,$03,$03,$03,$02,$01,$00,$00
	db $00,$00,$00,$00,$01,$02,$03,$03

CODE_02F91C:
	LDA.w $0F4A,X
	BEQ CODE_02F93C				;$02F91F	|
	LDY $9D					;$02F921	|
	BNE CODE_02F928				;$02F923	|
	DEC.w $0F4A,X				;$02F925	|
CODE_02F928:
	LSR
	LSR					;$02F929	|
	LSR					;$02F92A	|
	TAY					;$02F92B	|
	LDA.w DATA_02F90C,Y			;$02F92C	|
	ASL					;$02F92F	|
	STA.w $185E				;$02F930	|
	JSR CODE_02F9AE				;$02F933	|
	PHX					;$02F936	|
	JSR CODE_02F940				;$02F937	|
	PLX					;$02F93A	|
	RTS					;$02F93B	|

CODE_02F93C:
	STZ.w $1892,X
	RTS					;$02F93F	|

CODE_02F940:
	TXA
	ASL					;$02F941	|
	TAY					;$02F942	|
	LDA.w DATA_02FF50,Y			;$02F943	|
	STA.w $15EA				;$02F946	|
	LDA.w $1E16,X				;$02F949	|
	STA $E4					;$02F94C	|
	LDA.w $1E3E,X				;$02F94E	|
	STA.w $14E0				;$02F951	|
	LDA.w $1E02,X				;$02F954	|
	STA $D8					;$02F957	|
	LDA.w $1E2A,X				;$02F959	|
	STA.w $14D4				;$02F95C	|
	TAY					;$02F95F	|
	LDX.b #$00				;$02F960	|
	JSR GetDrawInfo2			;$02F962	|
	LDX.b #$01				;$02F965	|
CODE_02F967:
	PHX
	LDA $00					;$02F968	|
	STA.w $0300,Y				;$02F96A	|
	TXA					;$02F96D	|
	ORA.w $185E				;$02F96E	|
	TAX					;$02F971	|
	LDA.w DATA_02F8FC,X			;$02F972	|
	BMI CODE_02F993				;$02F975	|
	CLC					;$02F977	|
	ADC $01					;$02F978	|
	STA.w $0301,Y				;$02F97A	|
	LDA.w SumoBroFlameTiles,X		;$02F97D	|
	STA.w $0302,Y				;$02F980	|
	LDA $14					;$02F983	|
	AND.b #$04				;$02F985	|
	ASL					;$02F987	|
	ASL					;$02F988	|
	ASL					;$02F989	|
	ASL					;$02F98A	|
	NOP					;$02F98B	|
	ORA $64					;$02F98C	|
	ORA.b #$05				;$02F98E	|
	STA.w $0303,Y				;$02F990	|
CODE_02F993:
	PLX
	INY					;$02F994	|
	INY					;$02F995	|
	INY					;$02F996	|
	INY					;$02F997	|
	DEX					;$02F998	|
	BPL CODE_02F967				;$02F999	|
	LDX.b #$00				;$02F99B	|
	LDY.b #$02				;$02F99D	|
	LDA.b #$01				;$02F99F	|
	JSL FinishOAMWrite			;$02F9A1	|
	RTS					;$02F9A5	|

ADDR_02F9A6:
	STZ.w $1892,X
	RTS					;$02F9A9	|

DATA_02F9AA:
	db $02,$0A,$12,$1A

CODE_02F9AE:
	TXA
	EOR $13					;$02F9AF	|
	AND.b #$03				;$02F9B1	|
	BNE Return02F9FE			;$02F9B3	|
	LDA.w $0F4A,X				;$02F9B5	|
	CMP.b #$10				;$02F9B8	|
	BCC Return02F9FE			;$02F9BA	|
	LDA.w $1E16,X				;$02F9BC	|
	CLC					;$02F9BF	|
	ADC.b #$02				;$02F9C0	|
	STA $04					;$02F9C2	|
	LDA.w $1E3E,X				;$02F9C4	|
	ADC.b #$00				;$02F9C7	|
	STA $0A					;$02F9C9	|
	LDA.b #$0C				;$02F9CB	|
	STA $06					;$02F9CD	|
	LDY.w $185E				;$02F9CF	|
	LDA.w $1E02,X				;$02F9D2	|
	CLC					;$02F9D5	|
	ADC.w DATA_02F9AA,Y			;$02F9D6	|
	STA $05					;$02F9D9	|
	LDA.b #$14				;$02F9DB	|
	STA $07					;$02F9DD	|
	LDA.w $1E2A,X				;$02F9DF	|
	ADC.b #$00				;$02F9E2	|
	STA $0B					;$02F9E4	|
	JSL GetMarioClipping			;$02F9E6	|
	JSL CheckForContact			;$02F9EA	|
	BCC Return02F9FE			;$02F9EE	|
	LDA.w $1490				;$02F9F0	|
	BNE ADDR_02F9A6				;$02F9F3	|
CODE_02F9F5:
	LDA.w $187A
	BNE CODE_02F9FF				;$02F9F8	|
	JSL HurtMario				;$02F9FA	|
Return02F9FE:
	RTS

CODE_02F9FF:
	JMP CODE_02A473

DATA_02FA02:
	db $03,$07,$07,$07,$0F,$07,$07,$0F
DATA_02FA0A:
	db $F0,$F4,$F8,$FC

CastleFlameTiles:
	db $E2,$E4,$E2,$E4

CastleFlameGfxProp:
	db $09,$09,$49,$49

CODE_02FA16:
	LDA $9D
	BNE CODE_02FA2B				;$02FA18	|
	JSL GetRand				;$02FA1A	|
	AND.b #$07				;$02FA1E	|
	TAY					;$02FA20	|
	LDA $13					;$02FA21	|
	AND.w DATA_02FA02,Y			;$02FA23	|
	BNE CODE_02FA2B				;$02FA26	|
	INC.w $0F4A,X				;$02FA28	|
CODE_02FA2B:
	LDY.w DATA_02FA0A,X
	LDA.w $1E16,X				;$02FA2E	|
	SEC					;$02FA31	|
	SBC $1E					;$02FA32	|
	STA.w $0300,Y				;$02FA34	|
	LDA.w $1E02,X				;$02FA37	|
	SEC					;$02FA3A	|
	SBC $20					;$02FA3B	|
	STA.w $0301,Y				;$02FA3D	|
	PHY					;$02FA40	|
	PHX					;$02FA41	|
	LDA.w $0F4A,X				;$02FA42	|
	AND.b #$03				;$02FA45	|
	TAX					;$02FA47	|
	LDA.w CastleFlameTiles,X		;$02FA48	|
	STA.w $0302,Y				;$02FA4B	|
	LDA.w CastleFlameGfxProp,X		;$02FA4E	|
	STA.w $0303,Y				;$02FA51	|
	PLX					;$02FA54	|
	TYA					;$02FA55	|
	LSR					;$02FA56	|
	LSR					;$02FA57	|
	TAY					;$02FA58	|
	LDA.b #$02				;$02FA59	|
	STA.w $0460,Y				;$02FA5B	|
	PLY					;$02FA5E	|
	LDA.w $0300,Y				;$02FA5F	|
	CMP.b #$F0				;$02FA62	|
	BCC Return02FA83			;$02FA64	|
	LDA.w $0300,Y				;$02FA66	|
	STA.w $03EC				;$02FA69	|
	LDA.w $0301,Y				;$02FA6C	|
	STA.w $03ED				;$02FA6F	|
	LDA.w $0302,Y				;$02FA72	|
	STA.w $03EE				;$02FA75	|
	LDA.w $0303,Y				;$02FA78	|
	STA.w $03EF				;$02FA7B	|
	LDA.b #$03				;$02FA7E	|
	STA.w $049B				;$02FA80	|
Return02FA83:
	RTS

DATA_02FA84:
	db $00

DATA_02FA85:
	db $00,$28,$00,$50,$00,$78,$00,$A0
	db $00,$C8,$00,$F0,$00,$18,$01,$40
	db $01,$68,$01

CODE_02FA98:
	LDY.w $0F86,X
	LDA.w $0FBA,Y				;$02FA9B	|
	BEQ CODE_02FAA4				;$02FA9E	|
	STZ.w $1892,X				;$02FAA0	|
	RTS					;$02FAA3	|

CODE_02FAA4:
	LDA $9D
	BNE CODE_02FAF0				;$02FAA6	|
	LDA.w $0F4A,X				;$02FAA8	|
	BEQ CODE_02FAF0				;$02FAAB	|
	STZ $00					;$02FAAD	|
	BPL CODE_02FAB3				;$02FAAF	|
	DEC $00					;$02FAB1	|
CODE_02FAB3:
	CLC
	ADC.w $0FAE,Y				;$02FAB4	|
	STA.w $0FAE,Y				;$02FAB7	|
	LDA.w $0FB0,Y				;$02FABA	|
	ADC $00					;$02FABD	|
	AND.b #$01				;$02FABF	|
	STA.w $0FB0,Y				;$02FAC1	|
	LDA.w $0FB2,Y				;$02FAC4	|
	STA $00					;$02FAC7	|
	LDA.w $0FB4,Y				;$02FAC9	|
	STA $01					;$02FACC	|
	REP #$20				;$02FACE	|
	LDA $00					;$02FAD0	|
	SEC					;$02FAD2	|
	SBC $1A					;$02FAD3	|
	CLC					;$02FAD5	|
	ADC.w #$0080				;$02FAD6	|
	CMP.w #$0200				;$02FAD9	|
	SEP #$20				;$02FADC	|
	BCC CODE_02FAF0				;$02FADE	|
	LDA.b #$01				;$02FAE0	|
	STA.w $0FBA,Y				;$02FAE2	|
	PHX					;$02FAE5	|
	LDX.w $0FBC,Y				;$02FAE6	|
	STZ.w $1938,X				;$02FAE9	|
	PLX					;$02FAEC	|
	DEC.w $18BA				;$02FAED	|
CODE_02FAF0:
	PHX
	LDA.w $0F72,X				;$02FAF1	|
	ASL					;$02FAF4	|
	TAX					;$02FAF5	|
	LDA.w DATA_02FA84,X			;$02FAF6	|
	CLC					;$02FAF9	|
	ADC.w $0FAE,Y				;$02FAFA	|
	STA $00					;$02FAFD	|
	LDA.w DATA_02FA85,X			;$02FAFF	|
	ADC.w $0FB0,Y				;$02FB02	|
	AND.b #$01				;$02FB05	|
	STA $01					;$02FB07	|
	PLX					;$02FB09	|
	REP #$30				;$02FB0A	|
	LDA $00					;$02FB0C	|
	CLC					;$02FB0E	|
	ADC.w #$0080				;$02FB0F	|
	AND.w #$01FF				;$02FB12	|
	STA $02					;$02FB15	|
	LDA $00					;$02FB17	|
	AND.w #$00FF				;$02FB19	|
	ASL					;$02FB1C	|
	TAX					;$02FB1D	|
	LDA.l CircleCoords,X			;$02FB1E	|
	STA $04					;$02FB22	|
	LDA $02					;$02FB24	|
	AND.w #$00FF				;$02FB26	|
	ASL					;$02FB29	|
	TAX					;$02FB2A	|
	LDA.l CircleCoords,X			;$02FB2B	|
	STA $06					;$02FB2F	|
	SEP #$30				;$02FB31	|
	LDA $04					;$02FB33	|
	STA.w $4202				;$02FB35	|
	LDA.b #$50				;$02FB38	|
	LDY $05					;$02FB3A	|
	BNE CODE_02FB4D				;$02FB3C	|
	STA.w $4203				;$02FB3E	|
	NOP					;$02FB41	|
	NOP					;$02FB42	|
	NOP					;$02FB43	|
	NOP					;$02FB44	|
	ASL.w $4216				;$02FB45	|
	LDA.w $4217				;$02FB48	|
	ADC.b #$00				;$02FB4B	|
CODE_02FB4D:
	LSR $01
	BCC CODE_02FB54				;$02FB4F	|
	EOR.b #$FF				;$02FB51	|
	INC A					;$02FB53	|
CODE_02FB54:
	STA $04
	LDA $06					;$02FB56	|
	STA.w $4202				;$02FB58	|
	LDA.b #$50				;$02FB5B	|
	LDY $07					;$02FB5D	|
	BNE CODE_02FB70				;$02FB5F	|
	STA.w $4203				;$02FB61	|
	NOP					;$02FB64	|
	NOP					;$02FB65	|
	NOP					;$02FB66	|
	NOP					;$02FB67	|
	ASL.w $4216				;$02FB68	|
	LDA.w $4217				;$02FB6B	|
	ADC.b #$00				;$02FB6E	|
CODE_02FB70:
	LSR $03
	BCC CODE_02FB77				;$02FB72	|
	EOR.b #$FF				;$02FB74	|
	INC A					;$02FB76	|
CODE_02FB77:
	STA $06
	LDX.w $15E9				;$02FB79	|
	LDY.w $0F86,X				;$02FB7C	|
	STZ $00					;$02FB7F	|
	LDA $04					;$02FB81	|
	BPL CODE_02FB87				;$02FB83	|
	DEC $00					;$02FB85	|
CODE_02FB87:
	CLC
	ADC.w $0FB2,Y				;$02FB88	|
	STA.w $1E16,X				;$02FB8B	|
	LDA.w $0FB4,Y				;$02FB8E	|
	ADC $00					;$02FB91	|
	STA.w $1E3E,X				;$02FB93	|
	STZ $01					;$02FB96	|
	LDA $06					;$02FB98	|
	BPL CODE_02FB9E				;$02FB9A	|
	DEC $01					;$02FB9C	|
CODE_02FB9E:
	CLC
	ADC.w $0FB6,Y				;$02FB9F	|
	STA.w $1E02,X				;$02FBA2	|
	LDA.w $0FB8,Y				;$02FBA5	|
	ADC $01					;$02FBA8	|
	STA.w $1E2A,X				;$02FBAA	|
	JSR CODE_02FC8D				;$02FBAD	|
CODE_02FBB0:
	TXA
	EOR $13					;$02FBB1	|
	AND.b #$03				;$02FBB3	|
	BNE Return02FBBA			;$02FBB5	|
	JSR CODE_02FE71				;$02FBB7	|
Return02FBBA:
	RTS

DATA_02FBBB:
	db $01,$FF

DATA_02FBBD:
	db $08,$F8

BooRingTiles:
	db $88,$8C,$A8,$8E,$AA,$AE,$88,$8C

CODE_02FBC7:
	CPX.b #$00
	BEQ CODE_02FBCE				;$02FBC9	|
	JMP CODE_02FC41				;$02FBCB	|

CODE_02FBCE:
	LDA $13
	AND.b #$07				;$02FBD0	|
	ORA $9D					;$02FBD2	|
	BNE CODE_02FC3E				;$02FBD4	|
	JSL GetRand				;$02FBD6	|
	AND.b #$1F				;$02FBDA	|
	CMP.b #$14				;$02FBDC	|
	BCC CODE_02FBE2				;$02FBDE	|
	SBC.b #$14				;$02FBE0	|
CODE_02FBE2:
	TAX
	LDA.w $0F86,X				;$02FBE3	|
	BNE CODE_02FC3E				;$02FBE6	|
	INC.w $0F86,X				;$02FBE8	|
	LDA.b #$20				;$02FBEB	|
	STA.w $0F9A,X				;$02FBED	|
	STZ $00					;$02FBF0	|
	LDA.w $1E16,X				;$02FBF2	|
	SBC $1A					;$02FBF5	|
	ADC $1A					;$02FBF7	|
	PHP					;$02FBF9	|
	ADC $00					;$02FBFA	|
	STA.w $1E16,X				;$02FBFC	|
	STA $E4					;$02FBFF	|
	LDA $1B					;$02FC01	|
	ADC.b #$00				;$02FC03	|
	PLP					;$02FC05	|
	ADC.b #$00				;$02FC06	|
	STA.w $1E3E,X				;$02FC08	|
	STA.w $14E0				;$02FC0B	|
	LDA.w $1E02,X				;$02FC0E	|
	SBC $1C					;$02FC11	|
	ADC $1C					;$02FC13	|
	STA.w $1E02,X				;$02FC15	|
	STA $D8					;$02FC18	|
	AND.b #$FC				;$02FC1A	|
	STA.w $0F72,X				;$02FC1C	|
	LDA $1D					;$02FC1F	|
	ADC.b #$00				;$02FC21	|
	STA.w $1E2A,X				;$02FC23	|
	STA.w $14D4				;$02FC26	|
	PHX					;$02FC29	|
	LDX.b #$00				;$02FC2A	|
	LDA.b #$10				;$02FC2C	|
	JSR CODE_02D2FB				;$02FC2E	|
	PLX					;$02FC31	|
	LDA $00					;$02FC32	|
	ADC.b #$09				;$02FC34	|
	STA.w $1E52,X				;$02FC36	|
	LDA $01					;$02FC39	|
	STA.w $1E66,X				;$02FC3B	|
CODE_02FC3E:
	LDX.w $15E9
CODE_02FC41:
	LDA $9D
	BNE CODE_02FC4D				;$02FC43	|
	LDA.w $0F9A,X				;$02FC45	|
	BEQ CODE_02FC4D				;$02FC48	|
	DEC.w $0F9A,X				;$02FC4A	|
CODE_02FC4D:
	LDA.w $0F86,X
	BNE CODE_02FC55				;$02FC50	|
	JMP CODE_02FCE2				;$02FC52	|

CODE_02FC55:
	LDA $9D
	BNE CODE_02FC8D				;$02FC57	|
	LDA.w $0F9A,X				;$02FC59	|
	BNE CODE_02FC78				;$02FC5C	|
	JSR CODE_02FF98				;$02FC5E	|
	JSR CODE_02FFA3				;$02FC61	|
	TXA					;$02FC64	|
	EOR $13					;$02FC65	|
	AND.b #$03				;$02FC67	|
	BNE CODE_02FC78				;$02FC69	|
	JSR CODE_02FE71				;$02FC6B	|
	LDA.w $1E52,X				;$02FC6E	|
	CMP.b #$E1				;$02FC71	|
	BMI CODE_02FC78				;$02FC73	|
	DEC.w $1E52,X				;$02FC75	|
CODE_02FC78:
	LDA.w $1E02,X
	AND.b #$FC				;$02FC7B	|
	CMP.w $0F72,X				;$02FC7D	|
	BNE CODE_02FC8D				;$02FC80	|
	LDA.w $1E52,X				;$02FC82	|
	BPL CODE_02FC8D				;$02FC85	|
	STZ.w $0F86,X				;$02FC87	|
	STZ.w $1E66,X				;$02FC8A	|
CODE_02FC8D:
	LDA.w $1E16,X
	STA $00					;$02FC90	|
	LDA.w $1E3E,X				;$02FC92	|
	STA $01					;$02FC95	|
	REP #$20				;$02FC97	|
	LDA $00					;$02FC99	|
	SEC					;$02FC9B	|
	SBC $1A					;$02FC9C	|
	CLC					;$02FC9E	|
	ADC.w #$0040				;$02FC9F	|
	CMP.w #$0180				;$02FCA2	|
	SEP #$20				;$02FCA5	|
	BCS Return02FCD8			;$02FCA7	|
	LDA.b #$02				;$02FCA9	|
	JSR CODE_02FD48				;$02FCAB	|
	LDA.w $1E02,X				;$02FCAE	|
	CLC					;$02FCB1	|
	ADC.b #$10				;$02FCB2	|
	PHP					;$02FCB4	|
	CMP $1C					;$02FCB5	|
	LDA.w $1E2A,X				;$02FCB7	|
	SBC $1D					;$02FCBA	|
	PLP					;$02FCBC	|
	ADC.b #$00				;$02FCBD	|
	BNE CODE_02FCD9				;$02FCBF	|
	LDA.w $1E16,X				;$02FCC1	|
	CMP $1A					;$02FCC4	|
	LDA.w $1E3E,X				;$02FCC6	|
	SBC $1B					;$02FCC9	|
	BEQ Return02FCD8			;$02FCCB	|
	LDA.w DATA_02FF50,X			;$02FCCD	|
	LSR					;$02FCD0	|
	LSR					;$02FCD1	|
	TAY					;$02FCD2	|
	LDA.b #$03				;$02FCD3	|
	STA.w $0460,Y				;$02FCD5	|
Return02FCD8:
	RTS

CODE_02FCD9:
	LDY.w DATA_02FF50,X
	LDA.b #$F0				;$02FCDC	|
	STA.w $0301,Y				;$02FCDE	|
	RTS					;$02FCE1	|

CODE_02FCE2:
	LDA $9D
	BNE CODE_02FD46				;$02FCE4	|
	LDA.w $1892,X				;$02FCE6	|
	CMP.b #$08				;$02FCE9	|
	BEQ CODE_02FD46				;$02FCEB	|
	LDA.w $0F9A,X				;$02FCED	|
	BNE CODE_02FD1A				;$02FCF0	|
	LDA $13					;$02FCF2	|
	AND.b #$01				;$02FCF4	|
	BNE CODE_02FD1A				;$02FCF6	|
	LDA.w $0F4A,X				;$02FCF8	|
	AND.b #$01				;$02FCFB	|
	TAY					;$02FCFD	|
	LDA.w $1E66,X				;$02FCFE	|
	CLC					;$02FD01	|
	ADC.w DATA_02FBBB,Y			;$02FD02	|
	STA.w $1E66,X				;$02FD05	|
	CMP.w DATA_02FBBD,Y			;$02FD08	|
	BNE CODE_02FD1A				;$02FD0B	|
	INC.w $0F4A,X				;$02FD0D	|
	LDA.w $148D				;$02FD10	|
	AND.b #$FF				;$02FD13	|
	ORA.b #$3F				;$02FD15	|
	STA.w $0F9A,X				;$02FD17	|
CODE_02FD1A:
	JSR CODE_02FF98
	TXA					;$02FD1D	|
	EOR $13					;$02FD1E	|
	AND.b #$03				;$02FD20	|
	BNE CODE_02FD46				;$02FD22	|
	STZ $00					;$02FD24	|
	LDY.b #$01				;$02FD26	|
	TXA					;$02FD28	|
	ASL					;$02FD29	|
	ASL					;$02FD2A	|
	ASL					;$02FD2B	|
	ADC $13					;$02FD2C	|
	AND.b #$40				;$02FD2E	|
	BEQ CODE_02FD36				;$02FD30	|
	LDY.b #$FF				;$02FD32	|
	DEC $00					;$02FD34	|
CODE_02FD36:
	TYA
	CLC					;$02FD37	|
	ADC.w $1E02,X				;$02FD38	|
	STA.w $1E02,X				;$02FD3B	|
	LDA $00					;$02FD3E	|
	ADC.w $1E2A,X				;$02FD40	|
	STA.w $1E2A,X				;$02FD43	|
CODE_02FD46:
	LDA.b #$0E
CODE_02FD48:
	STA $02
	LDY.w DATA_02FF50,X			;$02FD4A	|
	LDA.w $1E16,X				;$02FD4D	|
	SEC					;$02FD50	|
	SBC $1A					;$02FD51	|
	STA.w $0300,Y				;$02FD53	|
	LDA.w $1E02,X				;$02FD56	|
	SEC					;$02FD59	|
	SBC $1C					;$02FD5A	|
	STA.w $0301,Y				;$02FD5C	|
	LDA $14					;$02FD5F	|
	LSR					;$02FD61	|
	LSR					;$02FD62	|
	LSR					;$02FD63	|
	AND.b #$01				;$02FD64	|
	STA $00					;$02FD66	|
	TXA					;$02FD68	|
	AND.b #$03				;$02FD69	|
	ASL					;$02FD6B	|
	ADC $00					;$02FD6C	|
	PHX					;$02FD6E	|
	TAX					;$02FD6F	|
	LDA.w BooRingTiles,X			;$02FD70	|
	STA.w $0302,Y				;$02FD73	|
	PLX					;$02FD76	|
	LDA.w $1E66,X				;$02FD77	|
	ASL					;$02FD7A	|
	LDA.b #$00				;$02FD7B	|
	BCS CODE_02FD81				;$02FD7D	|
	LDA.b #$40				;$02FD7F	|
CODE_02FD81:
	ORA.b #$31
	ORA $02					;$02FD83	|
	STA.w $0303,Y				;$02FD85	|
	TYA					;$02FD88	|
	LSR					;$02FD89	|
	LSR					;$02FD8A	|
	TAY					;$02FD8B	|
	LDA.b #$02				;$02FD8C	|
	STA.w $0460,Y				;$02FD8E	|
	LDA.w $1892,X				;$02FD91	|
	CMP.b #$08				;$02FD94	|
	BNE Return02FDB7			;$02FD96	|
	LDY.w DATA_02FF50,X			;$02FD98	|
	LDA $14					;$02FD9B	|
	LSR					;$02FD9D	|
	LSR					;$02FD9E	|
	AND.b #$01				;$02FD9F	|
	STA $00					;$02FDA1	|
	LDA.w $0F86,X				;$02FDA3	|
	ASL					;$02FDA6	|
	ORA $00					;$02FDA7	|
	PHX					;$02FDA9	|
	TAX					;$02FDAA	|
	LDA.w BatCeilingTiles,X			;$02FDAB	|
	STA.w $0302,Y				;$02FDAE	|
	LDA.b #$37				;$02FDB1	|
	STA.w $0303,Y				;$02FDB3	|
	PLX					;$02FDB6	|
Return02FDB7:
	RTS

BatCeilingTiles:
	db $AE,$AE,$C0,$EB

CODE_02FDBC:
	JSR CODE_02FFA3
	LDA.w $1E52,X				;$02FDBF	|
	CMP.b #$40				;$02FDC2	|
	BPL CODE_02FDCC				;$02FDC4	|
	CLC					;$02FDC6	|
	ADC.b #$03				;$02FDC7	|
	STA.w $1E52,X				;$02FDC9	|
CODE_02FDCC:
	LDA.w $1E2A,X
	BEQ CODE_02FDE0				;$02FDCF	|
	LDA.w $1E02,X				;$02FDD1	|
	CMP.b #$80				;$02FDD4	|
	BCC CODE_02FDE0				;$02FDD6	|
	AND.b #$F0				;$02FDD8	|
	STA.w $1E02,X				;$02FDDA	|
	STZ.w $1E52,X				;$02FDDD	|
CODE_02FDE0:
	TXA
	EOR $13					;$02FDE1	|
	LSR					;$02FDE3	|
	BCC CODE_02FE48				;$02FDE4	|
	LDA.w $1E52,X				;$02FDE6	|
	BNE CODE_02FE10				;$02FDE9	|
	LDA.w $1E66,X				;$02FDEB	|
	CLC					;$02FDEE	|
	ADC.w $1E16,X				;$02FDEF	|
	STA.w $1E16,X				;$02FDF2	|
	LDA.w $1E16,X				;$02FDF5	|
	EOR.w $1E66,X				;$02FDF8	|
	BPL CODE_02FE10				;$02FDFB	|
	LDA.w $1E16,X				;$02FDFD	|
	CLC					;$02FE00	|
	ADC.b #$20				;$02FE01	|
	CMP.b #$30				;$02FE03	|
	BCS CODE_02FE10				;$02FE05	|
	LDA.w $1E66,X				;$02FE07	|
	EOR.b #$FF				;$02FE0A	|
	INC A					;$02FE0C	|
	STA.w $1E66,X				;$02FE0D	|
CODE_02FE10:
	LDA $94
	SEC					;$02FE12	|
	SBC.w $1E16,X				;$02FE13	|
	CLC					;$02FE16	|
	ADC.b #$0C				;$02FE17	|
	CMP.b #$1E				;$02FE19	|
	BCS CODE_02FE48				;$02FE1B	|
	LDA.b #$20				;$02FE1D	|
	LDY $73					;$02FE1F	|
	BNE CODE_02FE29				;$02FE21	|
	LDY $19					;$02FE23	|
	BEQ CODE_02FE29				;$02FE25	|
	LDA.b #$30				;$02FE27	|
CODE_02FE29:
	STA $00
	LDA $96					;$02FE2B	|
	SEC					;$02FE2D	|
	SBC.w $1E02,X				;$02FE2E	|
	CLC					;$02FE31	|
	ADC.b #$20				;$02FE32	|
	CMP $00					;$02FE34	|
	BCS CODE_02FE48				;$02FE36	|
	STZ.w $1892,X				;$02FE38	|
	JSR CODE_02FF6C				;$02FE3B	|
	DEC.w $1920				;$02FE3E	|
	BNE CODE_02FE48				;$02FE41	|
	LDA.b #$58				;$02FE43	|
	STA.w $14AB				;$02FE45	|
CODE_02FE48:
	LDY.w DATA_02FF64,X
	LDA.w $1E16,X				;$02FE4B	|
	SEC					;$02FE4E	|
	SBC $1A					;$02FE4F	|
	STA.w $0200,Y				;$02FE51	|
	LDA.w $1E02,X				;$02FE54	|
	SEC					;$02FE57	|
	SBC $1C					;$02FE58	|
	STA.w $0201,Y				;$02FE5A	|
	LDA.b #$24				;$02FE5D	|
	STA.w $0202,Y				;$02FE5F	|
	LDA.b #$3A				;$02FE62	|
	STA.w $0203,Y				;$02FE64	|
	TYA					;$02FE67	|
	LSR					;$02FE68	|
	LSR					;$02FE69	|
	TAY					;$02FE6A	|
	LDA.b #$02				;$02FE6B	|
	STA.w $0420,Y				;$02FE6D	|
	RTS					;$02FE70	|

CODE_02FE71:
	LDA.b #$14
	BRA CODE_02FE77				;$02FE73	|

	LDA.b #$0C				;$02FE75	|
CODE_02FE77:
	STA $02
	STZ $03					;$02FE79	|
	LDA.w $1E16,X				;$02FE7B	|
	STA $00					;$02FE7E	|
	LDA.w $1E3E,X				;$02FE80	|
	STA $01					;$02FE83	|
	REP #$20				;$02FE85	|
	LDA $94					;$02FE87	|
	SEC					;$02FE89	|
	SBC $00					;$02FE8A	|
	CLC					;$02FE8C	|
	ADC.w #$000A				;$02FE8D	|
	CMP $02					;$02FE90	|
	SEP #$20				;$02FE92	|
	BCS Return02FEC4			;$02FE94	|
	LDA.w $1E02,X				;$02FE96	|
	ADC.b #$03				;$02FE99	|
	STA $02					;$02FE9B	|
	LDA.w $1E2A,X				;$02FE9D	|
	ADC.b #$00				;$02FEA0	|
	STA $03					;$02FEA2	|
	REP #$20				;$02FEA4	|
	LDA.w #$0014				;$02FEA6	|
	LDY $19					;$02FEA9	|
	BEQ CODE_02FEB0				;$02FEAB	|
	LDA.w #$0020				;$02FEAD	|
CODE_02FEB0:
	STA $04
	LDA $96					;$02FEB2	|
	SEC					;$02FEB4	|
	SBC $02					;$02FEB5	|
	CLC					;$02FEB7	|
	ADC.w #$001C				;$02FEB8	|
	CMP $04					;$02FEBB	|
	SEP #$20				;$02FEBD	|
	BCS Return02FEC4			;$02FEBF	|
	JSR CODE_02F9F5				;$02FEC1	|
Return02FEC4:
	RTS

DATA_02FEC5:
	db $40,$B0

DATA_02FEC7:
	db $01,$FF

DATA_02FEC9:
	db $30,$C0

DATA_02FECB:
	db $01,$FF

	LDA $5B					;$02FECD	|
	AND.b #$01				;$02FECF	|
	BNE ADDR_02FF1E				;$02FED1	|
	LDA.w $1E02,X				;$02FED3	|
	CLC					;$02FED6	|
	ADC.b #$50				;$02FED7	|
	LDA.w $1E2A,X				;$02FED9	|
	ADC.b #$00				;$02FEDC	|
	CMP.b #$02				;$02FEDE	|
	BPL ADDR_02FF0E				;$02FEE0	|
	LDA $13					;$02FEE2	|
	AND.b #$01				;$02FEE4	|
	STA $01					;$02FEE6	|
	TAY					;$02FEE8	|
	LDA $1A					;$02FEE9	|
	CLC					;$02FEEB	|
	ADC.w DATA_02FEC9,Y			;$02FEEC	|
	ROL $00					;$02FEEF	|
	CMP.w $1E16,X				;$02FEF1	|
	PHP					;$02FEF4	|
	LDA $1B					;$02FEF5	|
	LSR $00					;$02FEF7	|
	ADC.w DATA_02FECB,Y			;$02FEF9	|
	PLP					;$02FEFC	|
	SBC.w $1E3E,X				;$02FEFD	|
	STA $00					;$02FF00	|
	LSR $01					;$02FF02	|
	BCC ADDR_02FF0A				;$02FF04	|
	EOR.b #$80				;$02FF06	|
	STA $00					;$02FF08	|
ADDR_02FF0A:
	LDA $00
	BPL Return02FF1D			;$02FF0C	|
ADDR_02FF0E:
	LDY.w $0F86,X
	CPY.b #$FF				;$02FF11	|
	BEQ ADDR_02FF1A				;$02FF13	|
	LDA.b #$00				;$02FF15	|
	STA.w $1938,Y				;$02FF17	|
ADDR_02FF1A:
	STZ.w $1892,X
Return02FF1D:
	RTS

ADDR_02FF1E:
	LDA $13
	LSR					;$02FF20	|
	BCS Return02FF1D			;$02FF21	|
	AND.b #$01				;$02FF23	|
	STA $01					;$02FF25	|
	TAY					;$02FF27	|
	LDA $1A					;$02FF28	|
	CLC					;$02FF2A	|
	ADC.w DATA_02FEC5,Y			;$02FF2B	|
	ROL $00					;$02FF2E	|
	CMP.w $1E02,X				;$02FF30	|
	PHP					;$02FF33	|
	LDA.w $1D				;$02FF34	|
	LSR $00					;$02FF37	|
	ADC.w DATA_02FEC7,Y			;$02FF39	|
	PLP					;$02FF3C	|
	SBC.w $1E2A,X				;$02FF3D	|
	STA $00					;$02FF40	|
	LDY $01					;$02FF42	|
	BEQ ADDR_02FF4A				;$02FF44	|
	EOR.b #$80				;$02FF46	|
	STA $00					;$02FF48	|
ADDR_02FF4A:
	LDA $00
	BPL Return02FF1D			;$02FF4C	|
	BMI ADDR_02FF0E				;$02FF4E	|

DATA_02FF50:
	db $E0,$E4,$E8,$EC,$F0,$F4,$F8,$FC
	db $5C,$58,$54,$50,$4C,$48,$44,$40
	db $3C,$38,$34,$30

DATA_02FF64:
	db $90,$94,$98,$9C,$A0,$A4,$A8,$AC

CODE_02FF6C:
	JSL CODE_02AD34
	LDA.b #$0D				;$02FF70	|
	STA.w $16E1,Y				;$02FF72	|
	LDA.w $1E02,X				;$02FF75	|
	SEC					;$02FF78	|
	SBC.b #$08				;$02FF79	|
	STA.w $16E7,Y				;$02FF7B	|
	LDA.w $1E2A,X				;$02FF7E	|
	SBC.b #$00				;$02FF81	|
	STA.w $16F9,Y				;$02FF83	|
	LDA.w $1E16,X				;$02FF86	|
	STA.w $16ED,Y				;$02FF89	|
	LDA.w $1E3E,X				;$02FF8C	|
	STA.w $16F3,Y				;$02FF8F	|
	LDA.b #$30				;$02FF92	|
	STA.w $16FF,Y				;$02FF94	|
	RTS					;$02FF97	|

CODE_02FF98:
	PHX
	TXA					;$02FF99	|
	CLC					;$02FF9A	|
	ADC.b #$14				;$02FF9B	|
	TAX					;$02FF9D	|
	JSR CODE_02FFA3				;$02FF9E	|
	PLX					;$02FFA1	|
	RTS					;$02FFA2	|

CODE_02FFA3:
	LDA.w $1E52,X
	ASL					;$02FFA6	|
	ASL					;$02FFA7	|
	ASL					;$02FFA8	|
	ASL					;$02FFA9	|
	CLC					;$02FFAA	|
	ADC.w $1E7A,X				;$02FFAB	|
	STA.w $1E7A,X				;$02FFAE	|
	PHP					;$02FFB1	|
	LDA.w $1E52,X				;$02FFB2	|
	LSR					;$02FFB5	|
	LSR					;$02FFB6	|
	LSR					;$02FFB7	|
	LSR					;$02FFB8	|
	CMP.b #$08				;$02FFB9	|
	LDY.b #$00				;$02FFBB	|
	BCC CODE_02FFC2				;$02FFBD	|
	ORA.b #$F0				;$02FFBF	|
	DEY					;$02FFC1	|
CODE_02FFC2:
	PLP
	ADC.w $1E02,X				;$02FFC3	|
	STA.w $1E02,X				;$02FFC6	|
	TYA					;$02FFC9	|
	ADC.w $1E2A,X				;$02FFCA	|
	STA.w $1E2A,X				;$02FFCD	|
	RTS					;$02FFD0	|

CODE_02FFD1:
	LDA.w $1588,X
	BMI ADDR_02FFDD				;$02FFD4	|
	LDA.b #$00				;$02FFD6	|
	LDY.w $15B8,X				;$02FFD8	|
	BEQ CODE_02FFDF				;$02FFDB	|
ADDR_02FFDD:
	LDA.b #$18
CODE_02FFDF:
	STA $AA,X
	RTS					;$02FFE1	|

DATA_02FFE2:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF
