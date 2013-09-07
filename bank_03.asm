ORG $038000

DATA_038000:
	db $13,$14,$15,$16,$17,$18,$19

DATA_038007:
	db $F0,$F8,$FC,$00,$04,$08,$10

DATA_03800E:
	db $A0,$D0,$C0,$D0

Football:
	JSL GenericSprGfxRt2
	LDA $9D					;$038016	|
	BNE Return038086			;$038018	|
	JSR SubOffscreen0Bnk3			;$03801A	|
	JSL SprSprPMarioSprRts			;$03801D	|
	LDA.w $1540,X				;$038021	|
	BEQ CODE_03802D				;$038024	|
	DEC A					;$038026	|
	BNE CODE_038031				;$038027	|
	JSL CODE_01AB6F				;$038029	|
CODE_03802D:
	JSL UpdateSpritePos
CODE_038031:
	LDA.w $1588,X
	AND.b #$03				;$038034	|
	BEQ CODE_03803F				;$038036	|
	LDA $B6,X				;$038038	|
	EOR.b #$FF				;$03803A	|
	INC A					;$03803C	|
	STA $B6,X				;$03803D	|
CODE_03803F:
	LDA.w $1588,X
	AND.b #$08				;$038042	|
	BEQ CODE_038048				;$038044	|
	STZ $AA,X				;$038046	|
CODE_038048:
	LDA.w $1588,X
	AND.b #$04				;$03804B	|
	BEQ Return038086			;$03804D	|
	LDA.w $1540,X				;$03804F	|
	BNE Return038086			;$038052	|
	LDA.w $15F6,X				;$038054	|
	EOR.b #$40				;$038057	|
	STA.w $15F6,X				;$038059	|
	JSL GetRand				;$03805C	|
	AND.b #$03				;$038060	|
	TAY					;$038062	|
	LDA.w DATA_03800E,Y			;$038063	|
	STA $AA,X				;$038066	|
	LDY.w $15B8,X				;$038068	|
	INY					;$03806B	|
	INY					;$03806C	|
	INY					;$03806D	|
	LDA.w DATA_038007,Y			;$03806E	|
	CLC					;$038071	|
	ADC $B6,X				;$038072	|
	BPL CODE_03807E				;$038074	|
	CMP.b #$E0				;$038076	|
	BCS CODE_038084				;$038078	|
	LDA.b #$E0				;$03807A	|
	BRA CODE_038084				;$03807C	|

CODE_03807E:
	CMP.b #$20
	BCC CODE_038084				;$038080	|
	LDA.b #$20				;$038082	|
CODE_038084:
	STA $B6,X
Return038086:
	RTS

BigBooBoss:
	JSL CODE_038398
	JSL CODE_038239				;$03808B	|
	LDA.w $14C8,X				;$03808F	|
	BNE CODE_0380A2				;$038092	|
	INC.w $13C6				;$038094	|
	LDA.b #$FF				;$038097	|
	STA.w $1493				;$038099	|
	LDA.b #$0B				;$03809C	|
	STA.w $1DFB				;$03809E	|
	RTS					;$0380A1	|

CODE_0380A2:
	CMP.b #$08
	BNE Return0380D4			;$0380A4	|
	LDA $9D					;$0380A6	|
	BNE Return0380D4			;$0380A8	|
	LDA $C2,X				;$0380AA	|
	JSL execute_pointer			;$0380AC	|

BooBossPtrs:
	dw CODE_0380BE
	dw CODE_0380D5
	dw CODE_038119
	dw CODE_03818B
	dw CODE_0381BC
	dw CODE_038106
	dw CODE_0381D3

CODE_0380BE:
	LDA.b #$03
	STA.w $1602,X				;$0380C0	|
	INC.w $1570,X				;$0380C3	|
	LDA.w $1570,X				;$0380C6	|
	CMP.b #$90				;$0380C9	|
	BNE Return0380D4			;$0380CB	|
	LDA.b #$08				;$0380CD	|
	STA.w $1540,X				;$0380CF	|
	INC $C2,X				;$0380D2	|
Return0380D4:
	RTS

CODE_0380D5:
	LDA.w $1540,X
	BNE Return0380F9			;$0380D8	|
	LDA.b #$08				;$0380DA	|
	STA.w $1540,X				;$0380DC	|
	INC.w $190B				;$0380DF	|
	LDA.w $190B				;$0380E2	|
	CMP.b #$02				;$0380E5	|
	BNE CODE_0380EE				;$0380E7	|
	LDY.b #$10				;$0380E9	|
	STY.w $1DF9				;$0380EB	|
CODE_0380EE:
	CMP.b #$07
	BNE Return0380F9			;$0380F0	|
	INC $C2,X				;$0380F2	|
	LDA.b #$40				;$0380F4	|
	STA.w $1540,X				;$0380F6	|
Return0380F9:
	RTS

DATA_0380FA:
	db $FF,$01

DATA_0380FC:
	db $F0,$10

DATA_0380FE:
	db $0C,$F4

DATA_038100:
	db $01,$FF

DATA_038102:
	db $01,$02,$02,$01

CODE_038106:
	LDA.w $1540,X
	BNE CODE_038112				;$038109	|
	STZ $C2,X				;$03810B	|
	LDA.b #$40				;$03810D	|
	STA.w $1570,X				;$03810F	|
CODE_038112:
	LDA.b #$03
	STA.w $1602,X				;$038114	|
	BRA CODE_03811F				;$038117	|

CODE_038119:
	STZ.w $1602,X
	JSR CODE_0381E4				;$03811C	|
CODE_03811F:
	LDA.w $15AC,X
	BNE CODE_038132				;$038122	|
	JSR SubHorzPosBnk3			;$038124	|
	TYA					;$038127	|
	CMP.w $157C,X				;$038128	|
	BEQ CODE_03814A				;$03812B	|
	LDA.b #$1F				;$03812D	|
	STA.w $15AC,X				;$03812F	|
CODE_038132:
	CMP.b #$10
	BNE CODE_038140				;$038134	|
	PHA					;$038136	|
	LDA.w $157C,X				;$038137	|
	EOR.b #$01				;$03813A	|
	STA.w $157C,X				;$03813C	|
	PLA					;$03813F	|
CODE_038140:
	LSR
	LSR					;$038141	|
	LSR					;$038142	|
	TAY					;$038143	|
	LDA.w DATA_038102,Y			;$038144	|
	STA.w $1602,X				;$038147	|
CODE_03814A:
	LDA $14
	AND.b #$07				;$03814C	|
	BNE CODE_038166				;$03814E	|
	LDA.w $151C,X				;$038150	|
	AND.b #$01				;$038153	|
	TAY					;$038155	|
	LDA $B6,X				;$038156	|
	CLC					;$038158	|
	ADC.w DATA_0380FA,Y			;$038159	|
	STA $B6,X				;$03815C	|
	CMP.w DATA_0380FC,Y			;$03815E	|
	BNE CODE_038166				;$038161	|
	INC.w $151C,X				;$038163	|
CODE_038166:
	LDA $14
	AND.b #$07				;$038168	|
	BNE CODE_038182				;$03816A	|
	LDA.w $1528,X				;$03816C	|
	AND.b #$01				;$03816F	|
	TAY					;$038171	|
	LDA $AA,X				;$038172	|
	CLC					;$038174	|
	ADC.w DATA_038100,Y			;$038175	|
	STA $AA,X				;$038178	|
	CMP.w DATA_0380FE,Y			;$03817A	|
	BNE CODE_038182				;$03817D	|
	INC.w $1528,X				;$03817F	|
CODE_038182:
	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty			;$038186	|
	RTS					;$03818A	|

CODE_03818B:
	LDA.w $1540,X
	BNE CODE_0381AE				;$03818E	|
	INC $C2,X				;$038190	|
	LDA.b #$08				;$038192	|
	STA.w $1540,X				;$038194	|
	JSL LoadSpriteTables			;$038197	|
	INC.w $1534,X				;$03819B	|
	LDA.w $1534,X				;$03819E	|
	CMP.b #$03				;$0381A1	|
	BNE Return0381AD			;$0381A3	|
	LDA.b #$06				;$0381A5	|
	STA $C2,X				;$0381A7	|
	JSL KillMostSprites			;$0381A9	|
Return0381AD:
	RTS

CODE_0381AE:
	AND.b #$0E
	EOR.w $15F6,X				;$0381B0	|
	STA.w $15F6,X				;$0381B3	|
	LDA.b #$03				;$0381B6	|
	STA.w $1602,X				;$0381B8	|
	RTS					;$0381BB	|

CODE_0381BC:
	LDA.w $1540,X
	BNE Return0381D2			;$0381BF	|
	LDA.b #$08				;$0381C1	|
	STA.w $1540,X				;$0381C3	|
	DEC.w $190B				;$0381C6	|
	BNE Return0381D2			;$0381C9	|
	INC $C2,X				;$0381CB	|
	LDA.b #$C0				;$0381CD	|
	STA.w $1540,X				;$0381CF	|
Return0381D2:
	RTS

CODE_0381D3:
	LDA.b #$02
	STA.w $14C8,X				;$0381D5	|
	STZ $B6,X				;$0381D8	|
	LDA.b #$D0				;$0381DA	|
	STA $AA,X				;$0381DC	|
	LDA.b #$23				;$0381DE	|
	STA.w $1DF9				;$0381E0	|
	RTS					;$0381E3	|

CODE_0381E4:
	LDY.b #$0B
CODE_0381E6:
	LDA.w $14C8,Y
	CMP.b #$09				;$0381E9	|
	BEQ CODE_0381F5				;$0381EB	|
	CMP.b #$0A				;$0381ED	|
	BEQ CODE_0381F5				;$0381EF	|
CODE_0381F1:
	DEY
	BPL CODE_0381E6				;$0381F2	|
	RTS					;$0381F4	|

CODE_0381F5:
	PHX
	TYX					;$0381F6	|
	JSL GetSpriteClippingB			;$0381F7	|
	PLX					;$0381FB	|
	JSL GetSpriteClippingA			;$0381FC	|
	JSL CheckForContact			;$038200	|
	BCC CODE_0381F1				;$038204	|
	LDA.b #$03				;$038206	|
	STA $C2,X				;$038208	|
	LDA.b #$40				;$03820A	|
	STA.w $1540,X				;$03820C	|
	PHX					;$03820F	|
	TYX					;$038210	|
	STZ.w $14C8,X				;$038211	|
	LDA $E4,X				;$038214	|
	STA $9A					;$038216	|
	LDA.w $14E0,X				;$038218	|
	STA $9B					;$03821B	|
	LDA $D8,X				;$03821D	|
	STA $98					;$03821F	|
	LDA.w $14D4,X				;$038221	|
	STA $99					;$038224	|
	PHB					;$038226	|
	LDA.b #$02				;$038227	|
	PHA					;$038229	|
	PLB					;$03822A	|
	LDA.b #$FF				;$03822B	|
	JSL ShatterBlock			;$03822D	|
	PLB					;$038231	|
	PLX					;$038232	|
	LDA.b #$28				;$038233	|
	STA.w $1DFC				;$038235	|
	RTS					;$038238	|

CODE_038239:
	LDY.b #$24
	STY $40					;$03823B	|
	LDA.w $190B				;$03823D	|
	CMP.b #$08				;$038240	|
	DEC A					;$038242	|
	BCS CODE_03824A				;$038243	|
	LDY.b #$34				;$038245	|
	STY $40					;$038247	|
	INC A					;$038249	|
CODE_03824A:
	ASL
	ASL					;$03824B	|
	ASL					;$03824C	|
	ASL					;$03824D	|
	TAX					;$03824E	|
	STZ $00					;$03824F	|
	LDY.w $0681				;$038251	|
CODE_038254:
	LDA.l BooBossPals,X
	STA.w $0684,Y				;$038258	|
	INY					;$03825B	|
	INX					;$03825C	|
	INC $00					;$03825D	|
	LDA $00					;$03825F	|
	CMP.b #$10				;$038261	|
	BNE CODE_038254				;$038263	|
	LDX.w $0681				;$038265	|
	LDA.b #$10				;$038268	|
	STA.w $0682,X				;$03826A	|
	LDA.b #$F0				;$03826D	|
	STA.w $0683,X				;$03826F	|
	STZ.w $0694,X				;$038272	|
	TXA					;$038275	|
	CLC					;$038276	|
	ADC.b #$12				;$038277	|
	STA.w $0681				;$038279	|
	LDX.w $15E9				;$03827C	|
	RTL					;$03827F	|

BigBooDispX:
	db $08,$08,$20,$00,$00,$00,$00,$10
	db $10,$10,$10,$20,$20,$20,$20,$30
	db $30,$30,$30,$FD,$0C,$0C,$27,$00
	db $00,$00,$00,$10,$10,$10,$10,$1F
	db $20,$20,$1F,$2E,$2E,$2C,$2C,$FB
	db $12,$12,$30,$00,$00,$00,$00,$10
	db $10,$10,$10,$1F,$20,$20,$1F,$2E
	db $2E,$2E,$2E,$F8,$11,$FF,$08,$08
	db $00,$00,$00,$00,$10,$10,$10,$10
	db $20,$20,$20,$20,$30,$30,$30,$30
BigBooDispY:
	db $12,$22,$18,$00,$10,$20,$30,$00
	db $10,$20,$30,$00,$10,$20,$30,$00
	db $10,$20,$30,$18,$16,$16,$12,$22
	db $00,$10,$20,$30,$00,$10,$20,$30
	db $00,$10,$20,$30,$00,$10,$20,$30
BigBooTiles:
	db $C0,$E0,$E8,$80,$A0,$A0,$80,$82
	db $A2,$A2,$82,$84,$A4,$C4,$E4,$86
	db $A6,$C6,$E6,$E8,$C0,$E0,$E8,$80
	db $A0,$A0,$80,$82,$A2,$A2,$82,$84
	db $A4,$C4,$E4,$86,$A6,$C6,$E6,$E8
	db $C0,$E0,$E8,$80,$A0,$A0,$80,$82
	db $A2,$A2,$82,$84,$A4,$A4,$84,$86
	db $A6,$A6,$86,$E8,$E8,$E8,$C2,$E2
	db $80,$A0,$A0,$80,$82,$A2,$A2,$82
	db $84,$A4,$C4,$E4,$86,$A6,$C6,$E6
BigBooGfxProp:
	db $00,$00,$40,$00,$00,$80,$80,$00
	db $00,$80,$80,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$40,$00
	db $00,$80,$80,$00,$00,$80,$80,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$40,$00,$00,$80,$80,$00
	db $00,$80,$80,$00,$00,$80,$80,$00
	db $00,$80,$80,$00,$00,$40,$00,$00
	db $00,$00,$80,$80,$00,$00,$80,$80
	db $00,$00,$00,$00,$00,$00,$00,$00

CODE_038398:
	PHB
	PHK					;$038399	|
	PLB					;$03839A	|
	JSR CODE_0383A0				;$03839B	|
	PLB					;$03839E	|
	RTL					;$03839F	|

CODE_0383A0:
	LDA $9E,X
	CMP.b #$37				;$0383A2	|
	BNE CODE_0383C2				;$0383A4	|
	LDA.b #$00				;$0383A6	|
	LDY $C2,X				;$0383A8	|
	BEQ CODE_0383BA				;$0383AA	|
	LDA.b #$06				;$0383AC	|
	LDY.w $1558,X				;$0383AE	|
	BEQ CODE_0383BA				;$0383B1	|
	TYA					;$0383B3	|
	AND.b #$04				;$0383B4	|
	LSR					;$0383B6	|
	LSR					;$0383B7	|
	ADC.b #$02				;$0383B8	|
CODE_0383BA:
	STA.w $1602,X
	JSL GenericSprGfxRt2			;$0383BD	|
	RTS					;$0383C1	|

CODE_0383C2:
	JSR GetDrawInfoBnk3
	LDA.w $1602,X				;$0383C5	|
	STA $06					;$0383C8	|
	ASL					;$0383CA	|
	ASL					;$0383CB	|
	STA $03					;$0383CC	|
	ASL					;$0383CE	|
	ASL					;$0383CF	|
	ADC $03					;$0383D0	|
	STA $02					;$0383D2	|
	LDA.w $157C,X				;$0383D4	|
	STA $04					;$0383D7	|
	LDA.w $15F6,X				;$0383D9	|
	STA $05					;$0383DC	|
	LDX.b #$00				;$0383DE	|
CODE_0383E0:
	PHX
	LDX $02					;$0383E1	|
	LDA.w BigBooTiles,X			;$0383E3	|
	STA.w $0302,Y				;$0383E6	|
	LDA $04					;$0383E9	|
	LSR					;$0383EB	|
	LDA.w BigBooGfxProp,X			;$0383EC	|
	ORA $05					;$0383EF	|
	BCS CODE_0383F5				;$0383F1	|
	EOR.b #$40				;$0383F3	|
CODE_0383F5:
	ORA $64
	STA.w $0303,Y				;$0383F7	|
	LDA.w BigBooDispX,X			;$0383FA	|
	BCS CODE_038405				;$0383FD	|
	EOR.b #$FF				;$0383FF	|
	INC A					;$038401	|
	CLC					;$038402	|
	ADC.b #$28				;$038403	|
CODE_038405:
	CLC
	ADC $00					;$038406	|
	STA.w $0300,Y				;$038408	|
	PLX					;$03840B	|
	PHX					;$03840C	|
	LDA $06					;$03840D	|
	CMP.b #$03				;$03840F	|
	BCC CODE_038418				;$038411	|
	TXA					;$038413	|
	CLC					;$038414	|
	ADC.b #$14				;$038415	|
	TAX					;$038417	|
CODE_038418:
	LDA $01
	CLC					;$03841A	|
	ADC.w BigBooDispY,X			;$03841B	|
	STA.w $0301,Y				;$03841E	|
	PLX					;$038421	|
	INY					;$038422	|
	INY					;$038423	|
	INY					;$038424	|
	INY					;$038425	|
	INC $02					;$038426	|
	INX					;$038428	|
	CPX.b #$14				;$038429	|
	BNE CODE_0383E0				;$03842B	|
	LDX.w $15E9				;$03842D	|
	LDA.w $1602,X				;$038430	|
	CMP.b #$03				;$038433	|
	BNE CODE_03844B				;$038435	|
	LDA.w $1558,X				;$038437	|
	BEQ CODE_03844B				;$03843A	|
	LDY.w $15EA,X				;$03843C	|
	LDA.w $0301,Y				;$03843F	|
	CLC					;$038442	|
	ADC.b #$05				;$038443	|
	STA.w $0301,Y				;$038445	|
	STA.w $0305,Y				;$038448	|
CODE_03844B:
	LDA.b #$13
	LDY.b #$02				;$03844D	|
	JSL FinishOAMWrite			;$03844F	|
	RTS					;$038453	|

GreyFallingPlat:
	JSR CODE_038492
	LDA $9D					;$038457	|
	BNE Return038489			;$038459	|
	JSR SubOffscreen0Bnk3			;$03845B	|
	LDA $AA,X				;$03845E	|
	BEQ CODE_038476				;$038460	|
	LDA.w $1540,X				;$038462	|
	BNE CODE_038472				;$038465	|
	LDA $AA,X				;$038467	|
	CMP.b #$40				;$038469	|
	BPL CODE_038472				;$03846B	|
	CLC					;$03846D	|
	ADC.b #$02				;$03846E	|
	STA $AA,X				;$038470	|
CODE_038472:
	JSL UpdateYPosNoGrvty
CODE_038476:
	JSL InvisBlkMainRt
	BCC Return038489			;$03847A	|
	LDA $AA,X				;$03847C	|
	BNE Return038489			;$03847E	|
	LDA.b #$03				;$038480	|
	STA $AA,X				;$038482	|
	LDA.b #$18				;$038484	|
	STA.w $1540,X				;$038486	|
Return038489:
	RTS

FallingPlatDispX:
	db $00,$10,$20,$30

FallingPlatTiles:
	db $60,$61,$61,$62

CODE_038492:
	JSR GetDrawInfoBnk3
	PHX					;$038495	|
	LDX.b #$03				;$038496	|
CODE_038498:
	LDA $00
	CLC					;$03849A	|
	ADC.w FallingPlatDispX,X		;$03849B	|
	STA.w $0300,Y				;$03849E	|
	LDA $01					;$0384A1	|
	STA.w $0301,Y				;$0384A3	|
	LDA.w FallingPlatTiles,X		;$0384A6	|
	STA.w $0302,Y				;$0384A9	|
	LDA.b #$03				;$0384AC	|
	ORA $64					;$0384AE	|
	STA.w $0303,Y				;$0384B0	|
	INY					;$0384B3	|
	INY					;$0384B4	|
	INY					;$0384B5	|
	INY					;$0384B6	|
	DEX					;$0384B7	|
	BPL CODE_038498				;$0384B8	|
	PLX					;$0384BA	|
	LDY.b #$02				;$0384BB	|
	LDA.b #$03				;$0384BD	|
	JSL FinishOAMWrite			;$0384BF	|
	RTS					;$0384C3	|

BlurpMaxSpeedY:
	db $04,$FC

BlurpSpeedX:
	db $08,$F8

BlurpAccelY:
	db $01,$FF

Blurp:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$0384CE	|
	LDA.w $14				;$0384D1	|
	LSR					;$0384D4	|
	LSR					;$0384D5	|
	LSR					;$0384D6	|
	CLC					;$0384D7	|
	ADC.w $15E9				;$0384D8	|
	LSR					;$0384DB	|
	LDA.b #$A2				;$0384DC	|
	BCC CODE_0384E2				;$0384DE	|
	LDA.b #$EC				;$0384E0	|
CODE_0384E2:
	STA.w $0302,Y
	LDA.w $14C8,X				;$0384E5	|
	CMP.b #$08				;$0384E8	|
	BEQ CODE_0384F5				;$0384EA	|
CODE_0384EC:
	LDA.w $0303,Y
	ORA.b #$80				;$0384EF	|
	STA.w $0303,Y				;$0384F1	|
	RTS					;$0384F4	|

CODE_0384F5:
	LDA $9D
	BNE Return03852A			;$0384F7	|
	JSR SubOffscreen0Bnk3			;$0384F9	|
	LDA $14					;$0384FC	|
	AND.b #$03				;$0384FE	|
	BNE CODE_038516				;$038500	|
	LDA $C2,X				;$038502	|
	AND.b #$01				;$038504	|
	TAY					;$038506	|
	LDA $AA,X				;$038507	|
	CLC					;$038509	|
	ADC.w BlurpAccelY,Y			;$03850A	|
	STA $AA,X				;$03850D	|
	CMP.w BlurpMaxSpeedY,Y			;$03850F	|
	BNE CODE_038516				;$038512	|
	INC $C2,X				;$038514	|
CODE_038516:
	LDY.w $157C,X
	LDA.w BlurpSpeedX,Y			;$038519	|
	STA $B6,X				;$03851C	|
	JSL UpdateXPosNoGrvty			;$03851E	|
	JSL UpdateYPosNoGrvty			;$038522	|
	JSL SprSprPMarioSprRts			;$038526	|
Return03852A:
	RTS

PorcuPuffAccel:
	db $01,$FF

PorcuPuffMaxSpeed:
	db $10,$F0

PorcuPuffer:
	JSR CODE_0385A3
	LDA $9D					;$038532	|
	BNE Return038586			;$038534	|
	LDA.w $14C8,X				;$038536	|
	CMP.b #$08				;$038539	|
	BNE Return038586			;$03853B	|
	JSR SubOffscreen0Bnk3			;$03853D	|
	JSL SprSprPMarioSprRts			;$038540	|
	JSR SubHorzPosBnk3			;$038544	|
	TYA					;$038547	|
	STA.w $157C,X				;$038548	|
	LDA $14					;$03854B	|
	AND.b #$03				;$03854D	|
	BNE CODE_03855E				;$03854F	|
	LDA $B6,X				;$038551	|
	CMP.w PorcuPuffMaxSpeed,Y		;$038553	|
	BEQ CODE_03855E				;$038556	|
	CLC					;$038558	|
	ADC.w PorcuPuffAccel,Y			;$038559	|
	STA $B6,X				;$03855C	|
CODE_03855E:
	LDA $B6,X
	PHA					;$038560	|
	LDA.w $17BD				;$038561	|
	ASL					;$038564	|
	ASL					;$038565	|
	ASL					;$038566	|
	CLC					;$038567	|
	ADC $B6,X				;$038568	|
	STA $B6,X				;$03856A	|
	JSL UpdateXPosNoGrvty			;$03856C	|
	PLA					;$038570	|
	STA $B6,X				;$038571	|
	JSL CODE_019138				;$038573	|
	LDY.b #$04				;$038577	|
	LDA.w $164A,X				;$038579	|
	BEQ CODE_038580				;$03857C	|
	LDY.b #$FC				;$03857E	|
CODE_038580:
	STY $AA,X
	JSL UpdateYPosNoGrvty			;$038582	|
Return038586:
	RTS

PocruPufferDispX:
	db $F8,$08,$F8,$08,$08,$F8,$08,$F8
PocruPufferDispY:
	db $F8,$F8,$08,$08

PocruPufferTiles:
	db $86,$C0,$A6,$C2,$86,$C0,$A6,$8A
PocruPufferGfxProp:
	db $0D,$0D,$0D,$0D,$4D,$4D,$4D,$4D

CODE_0385A3:
	JSR GetDrawInfoBnk3
	LDA $14					;$0385A6	|
	AND.b #$04				;$0385A8	|
	STA $03					;$0385AA	|
	LDA.w $157C,X				;$0385AC	|
	STA $02					;$0385AF	|
	PHX					;$0385B1	|
	LDX.b #$03				;$0385B2	|
CODE_0385B4:
	LDA $01
	CLC					;$0385B6	|
	ADC.w PocruPufferDispY,X		;$0385B7	|
	STA.w $0301,Y				;$0385BA	|
	PHX					;$0385BD	|
	LDA $02					;$0385BE	|
	BNE CODE_0385C6				;$0385C0	|
	TXA					;$0385C2	|
	ORA.b #$04				;$0385C3	|
	TAX					;$0385C5	|
CODE_0385C6:
	LDA $00
	CLC					;$0385C8	|
	ADC.w PocruPufferDispX,X		;$0385C9	|
	STA.w $0300,Y				;$0385CC	|
	LDA.w PocruPufferGfxProp,X		;$0385CF	|
	ORA $64					;$0385D2	|
	STA.w $0303,Y				;$0385D4	|
	PLA					;$0385D7	|
	PHA					;$0385D8	|
	ORA $03					;$0385D9	|
	TAX					;$0385DB	|
	LDA.w PocruPufferTiles,X		;$0385DC	|
	STA.w $0302,Y				;$0385DF	|
	PLX					;$0385E2	|
	INY					;$0385E3	|
	INY					;$0385E4	|
	INY					;$0385E5	|
	INY					;$0385E6	|
	DEX					;$0385E7	|
	BPL CODE_0385B4				;$0385E8	|
	PLX					;$0385EA	|
	LDY.b #$02				;$0385EB	|
	LDA.b #$03				;$0385ED	|
	JSL FinishOAMWrite			;$0385EF	|
	RTS					;$0385F3	|

FlyingBlockSpeedY:
	db $08,$F8

FlyingTurnBlocks:
	JSR CODE_0386A8
	LDA $9D					;$0385F9	|
	BNE Return038675			;$0385FB	|
	LDA.w $1B9A				;$0385FD	|
	BEQ CODE_038629				;$038600	|
	LDA.w $1534,X				;$038602	|
	INC.w $1534,X				;$038605	|
	AND.b #$01				;$038608	|
	BNE CODE_03861E				;$03860A	|
	DEC.w $1602,X				;$03860C	|
	LDA.w $1602,X				;$03860F	|
	CMP.b #$FF				;$038612	|
	BNE CODE_03861E				;$038614	|
	LDA.b #$FF				;$038616	|
	STA.w $1602,X				;$038618	|
	INC.w $157C,X				;$03861B	|
CODE_03861E:
	LDA.w $157C,X
	AND.b #$01				;$038621	|
	TAY					;$038623	|
	LDA.w FlyingBlockSpeedY,Y		;$038624	|
	STA $AA,X				;$038627	|
CODE_038629:
	LDA $AA,X
	PHA					;$03862B	|
	LDY.w $151C,X				;$03862C	|
	BNE CODE_038636				;$03862F	|
	EOR.b #$FF				;$038631	|
	INC A					;$038633	|
	STA $AA,X				;$038634	|
CODE_038636:
	JSL UpdateYPosNoGrvty
	PLA					;$03863A	|
	STA $AA,X				;$03863B	|
	LDA.w $1B9A				;$03863D	|
	STA $B6,X				;$038640	|
	JSL UpdateXPosNoGrvty			;$038642	|
	STA.w $1528,X				;$038646	|
	JSL InvisBlkMainRt			;$038649	|
	BCC Return038675			;$03864D	|
	LDA.w $1B9A				;$03864F	|
	BNE Return038675			;$038652	|
	LDA.b #$08				;$038654	|
	STA.w $1B9A				;$038656	|
	LDA.b #$7F				;$038659	|
	STA.w $1602,X				;$03865B	|
	LDY.b #$09				;$03865E	|
CODE_038660:
	CPY.w $15E9
	BEQ CODE_03866C				;$038663	|
	LDA.w $009E,y				;$038665	|
	CMP.b #$C1				;$038668	|
	BEQ CODE_038670				;$03866A	|
CODE_03866C:
	DEY
	BPL CODE_038660				;$03866D	|
	INY					;$03866F	|
CODE_038670:
	LDA.b #$7F
	STA.w $1602,Y				;$038672	|
Return038675:
	RTS

ForestPlatDispX:
	db $00,$10,$20,$F2,$2E,$00,$10,$20
	db $FA,$2E

ForestPlatDispY:
	db $00,$00,$00,$F6,$F6,$00,$00,$00
	db $FE,$FE

ForestPlatTiles:
	db $40,$40,$40,$C6,$C6,$40,$40,$40
	db $5D,$5D

ForestPlatGfxProp:
	db $32,$32,$32,$72,$32,$32,$32,$32
	db $72,$32

ForestPlatTileSize:
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $00,$00

CODE_0386A8:
	JSR GetDrawInfoBnk3
	LDY.w $15EA,X				;$0386AB	|
	LDA $14					;$0386AE	|
	LSR					;$0386B0	|
	AND.b #$04				;$0386B1	|
	BEQ CODE_0386B6				;$0386B3	|
	INC A					;$0386B5	|
CODE_0386B6:
	STA $02
	PHX					;$0386B8	|
	LDX.b #$04				;$0386B9	|
CODE_0386BB:
	STX $06
	TXA					;$0386BD	|
	CLC					;$0386BE	|
	ADC $02					;$0386BF	|
	TAX					;$0386C1	|
	LDA $00					;$0386C2	|
	CLC					;$0386C4	|
	ADC.w ForestPlatDispX,X			;$0386C5	|
	STA.w $0300,Y				;$0386C8	|
	LDA $01					;$0386CB	|
	CLC					;$0386CD	|
	ADC.w ForestPlatDispY,X			;$0386CE	|
	STA.w $0301,Y				;$0386D1	|
	LDA.w ForestPlatTiles,X			;$0386D4	|
	STA.w $0302,Y				;$0386D7	|
	LDA.w ForestPlatGfxProp,X		;$0386DA	|
	STA.w $0303,Y				;$0386DD	|
	PHY					;$0386E0	|
	TYA					;$0386E1	|
	LSR					;$0386E2	|
	LSR					;$0386E3	|
	TAY					;$0386E4	|
	LDA.w ForestPlatTileSize,X		;$0386E5	|
	STA.w $0460,Y				;$0386E8	|
	PLY					;$0386EB	|
	INY					;$0386EC	|
	INY					;$0386ED	|
	INY					;$0386EE	|
	INY					;$0386EF	|
	LDX $06					;$0386F0	|
	DEX					;$0386F2	|
	BPL CODE_0386BB				;$0386F3	|
	PLX					;$0386F5	|
	LDY.b #$FF				;$0386F6	|
	LDA.b #$04				;$0386F8	|
	JSL FinishOAMWrite			;$0386FA	|
	RTS					;$0386FE	|

GrayLavaPlatform:
	JSR CODE_03873A
	LDA $9D					;$038702	|
	BNE Return038733			;$038704	|
	JSR SubOffscreen0Bnk3			;$038706	|
	LDA.w $1540,X				;$038709	|
	DEC A					;$03870C	|
	BNE CODE_03871B				;$03870D	|
	LDY.w $161A,X				;$03870F	|
	LDA.b #$00				;$038712	|
	STA.w $1938,Y				;$038714	|
	STZ.w $14C8,X				;$038717	|
	RTS					;$03871A	|

CODE_03871B:
	JSL UpdateYPosNoGrvty
	JSL InvisBlkMainRt			;$03871F	|
	BCC Return038733			;$038723	|
	LDA.w $1540,X				;$038725	|
	BNE Return038733			;$038728	|
	LDA.b #$06				;$03872A	|
	STA $AA,X				;$03872C	|
	LDA.b #$40				;$03872E	|
	STA.w $1540,X				;$038730	|
Return038733:
	RTS

LavaPlatTiles:
	db $85,$86,$85

DATA_038737:
	db $43,$03,$03

CODE_03873A:
	JSR GetDrawInfoBnk3
	PHX					;$03873D	|
	LDX.b #$02				;$03873E	|
CODE_038740:
	LDA $00
	STA.w $0300,Y				;$038742	|
	CLC					;$038745	|
	ADC.b #$10				;$038746	|
	STA $00					;$038748	|
	LDA $01					;$03874A	|
	STA.w $0301,Y				;$03874C	|
	LDA.w LavaPlatTiles,X			;$03874F	|
	STA.w $0302,Y				;$038752	|
	LDA.w DATA_038737,X			;$038755	|
	ORA $64					;$038758	|
	STA.w $0303,Y				;$03875A	|
	INY					;$03875D	|
	INY					;$03875E	|
	INY					;$03875F	|
	INY					;$038760	|
	DEX					;$038761	|
	BPL CODE_038740				;$038762	|
	PLX					;$038764	|
	LDY.b #$02				;$038765	|
	LDA.b #$02				;$038767	|
	JSL FinishOAMWrite			;$038769	|
	RTS					;$03876D	|

MegaMoleSpeed:
	db $10,$F0

MegaMole:
	JSR MegaMoleGfxRt
	LDA.w $14C8,X				;$038773	|
	CMP.b #$08				;$038776	|
	BNE Return038733			;$038778	|
	JSR SubOffscreen3Bnk3			;$03877A	|
	LDY.w $157C,X				;$03877D	|
	LDA.w MegaMoleSpeed,Y			;$038780	|
	STA $B6,X				;$038783	|
	LDA $9D					;$038785	|
	BNE Return038733			;$038787	|
	LDA.w $1588,X				;$038789	|
	AND.b #$04				;$03878C	|
	PHA					;$03878E	|
	JSL UpdateSpritePos			;$03878F	|
	JSL SprSprInteract			;$038793	|
	LDA.w $1588,X				;$038797	|
	AND.b #$04				;$03879A	|
	BEQ MegaMoleInAir			;$03879C	|
	STZ $AA,X				;$03879E	|
	PLA					;$0387A0	|
	BRA MegaMoleOnGround			;$0387A1	|

MegaMoleInAir:
	PLA
	BEQ MegaMoleWasInAir			;$0387A4	|
	LDA.b #$0A				;$0387A6	|
	STA.w $1540,X				;$0387A8	|
MegaMoleWasInAir:
	LDA.w $1540,X
	BEQ MegaMoleOnGround			;$0387AE	|
	STZ $AA,X				;$0387B0	|
MegaMoleOnGround:
	LDY.w $15AC,X
	LDA.w $1588,X				;$0387B5	|
	AND.b #$03				;$0387B8	|
	BEQ CODE_0387CD				;$0387BA	|
	CPY.b #$00				;$0387BC	|
	BNE CODE_0387C5				;$0387BE	|
	LDA.b #$10				;$0387C0	|
	STA.w $15AC,X				;$0387C2	|
CODE_0387C5:
	LDA.w $157C,X
	EOR.b #$01				;$0387C8	|
	STA.w $157C,X				;$0387CA	|
CODE_0387CD:
	CPY.b #$00
	BNE CODE_0387D7				;$0387CF	|
	LDA.w $157C,X				;$0387D1	|
	STA.w $151C,X				;$0387D4	|
CODE_0387D7:
	JSL MarioSprInteract
	BCC Return03882A			;$0387DB	|
	JSR SubVertPosBnk3			;$0387DD	|
	LDA $0E					;$0387E0	|
	CMP.b #$D8				;$0387E2	|
	BPL MegaMoleContact			;$0387E4	|
	LDA $7D					;$0387E6	|
	BMI Return03882A			;$0387E8	|
	LDA.b #$01				;$0387EA	|
	STA.w $1471				;$0387EC	|
	LDA.b #$06				;$0387EF	|
	STA.w $154C,X				;$0387F1	|
	STZ $7D					;$0387F4	|
	LDA.b #$D6				;$0387F6	|
	LDY.w $187A				;$0387F8	|
	BEQ MegaMoleNoYoshi			;$0387FB	|
	LDA.b #$C6				;$0387FD	|
MegaMoleNoYoshi:
	CLC
	ADC $D8,X				;$038800	|
	STA $96					;$038802	|
	LDA.w $14D4,X				;$038804	|
	ADC.b #$FF				;$038807	|
	STA $97					;$038809	|
	LDY.b #$00				;$03880B	|
	LDA.w $1491				;$03880D	|
	BPL CODE_038813				;$038810	|
	DEY					;$038812	|
CODE_038813:
	CLC
	ADC $94					;$038814	|
	STA $94					;$038816	|
	TYA					;$038818	|
	ADC $95					;$038819	|
	STA $95					;$03881B	|
	RTS					;$03881D	|

MegaMoleContact:
	LDA.w $154C,X
	ORA.w $15D0,X				;$038821	|
	BNE Return03882A			;$038824	|
	JSL HurtMario				;$038826	|
Return03882A:
	RTS

MegaMoleTileDispX:
	db $00,$10,$00,$10,$10,$00,$10,$00
MegaMoleTileDispY:
	db $F0,$F0,$00,$00

MegaMoleTiles:
	db $C6,$C8,$E6,$E8,$CA,$CC,$EA,$EC

MegaMoleGfxRt:
	JSR GetDrawInfoBnk3
	LDA.w $151C,X				;$038842	|
	STA $02					;$038845	|
	LDA $14					;$038847	|
	LSR					;$038849	|
	LSR					;$03884A	|
	NOP					;$03884B	|
	CLC					;$03884C	|
	ADC.w $15E9				;$03884D	|
	AND.b #$01				;$038850	|
	ASL					;$038852	|
	ASL					;$038853	|
	STA $03					;$038854	|
	PHX					;$038856	|
	LDX.b #$03				;$038857	|
MegaMoleGfxLoopSt:
	PHX
	LDA $02					;$03885A	|
	BNE MegaMoleFaceLeft			;$03885C	|
	INX					;$03885E	|
	INX					;$03885F	|
	INX					;$038860	|
	INX					;$038861	|
MegaMoleFaceLeft:
	LDA $00
	CLC					;$038864	|
	ADC.w MegaMoleTileDispX,X		;$038865	|
	STA.w $0300,Y				;$038868	|
	PLX					;$03886B	|
	LDA $01					;$03886C	|
	CLC					;$03886E	|
	ADC.w MegaMoleTileDispY,X		;$03886F	|
	STA.w $0301,Y				;$038872	|
	PHX					;$038875	|
	TXA					;$038876	|
	CLC					;$038877	|
	ADC $03					;$038878	|
	TAX					;$03887A	|
	LDA.w MegaMoleTiles,X			;$03887B	|
	STA.w $0302,Y				;$03887E	|
	LDA.b #$01				;$038881	|
	LDX $02					;$038883	|
	BNE MegaMoleGfxNoFlip			;$038885	|
	ORA.b #$40				;$038887	|
MegaMoleGfxNoFlip:
	ORA $64
	STA.w $0303,Y				;$03888B	|
	PLX					;$03888E	|
	INY					;$03888F	|
	INY					;$038890	|
	INY					;$038891	|
	INY					;$038892	|
	DEX					;$038893	|
	BPL MegaMoleGfxLoopSt			;$038894	|
	PLX					;$038896	|
	LDY.b #$02				;$038897	|
	LDA.b #$03				;$038899	|
	JSL FinishOAMWrite			;$03889B	|
	RTS					;$03889F	|

BatTiles:
	db $AE,$C0,$E8

Swooper:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$0388A7	|
	PHX					;$0388AA	|
	LDA.w $1602,X				;$0388AB	|
	TAX					;$0388AE	|
	LDA.w BatTiles,X			;$0388AF	|
	STA.w $0302,Y				;$0388B2	|
	PLX					;$0388B5	|
	LDA.w $14C8,X				;$0388B6	|
	CMP.b #$08				;$0388B9	|
	BEQ CODE_0388C0				;$0388BB	|
	JMP CODE_0384EC				;$0388BD	|

CODE_0388C0:
	LDA $9D
	BNE Return0388DF			;$0388C2	|
	JSR SubOffscreen0Bnk3			;$0388C4	|
	JSL SprSprPMarioSprRts			;$0388C7	|
	JSL UpdateXPosNoGrvty			;$0388CB	|
	JSL UpdateYPosNoGrvty			;$0388CF	|
	LDA $C2,X				;$0388D3	|
	JSL execute_pointer			;$0388D5	|

SwooperPtrs:
	dw CODE_0388E4
	dw CODE_038905
	dw CODE_038936

Return0388DF:
	RTS

DATA_0388E0:
	db $10,$F0

DATA_0388E2:
	db $01,$FF

CODE_0388E4:
	LDA.w $15A0,X
	BNE Return038904			;$0388E7	|
	JSR SubHorzPosBnk3			;$0388E9	|
	LDA $0F					;$0388EC	|
	CLC					;$0388EE	|
	ADC.b #$50				;$0388EF	|
	CMP.b #$A0				;$0388F1	|
	BCS Return038904			;$0388F3	|
	INC $C2,X				;$0388F5	|
	TYA					;$0388F7	|
	STA.w $157C,X				;$0388F8	|
	LDA.b #$20				;$0388FB	|
	STA $AA,X				;$0388FD	|
	LDA.b #$26				;$0388FF	|
	STA.w $1DFC				;$038901	|
Return038904:
	RTS

CODE_038905:
	LDA $13
	AND.b #$03				;$038907	|
	BNE CODE_038915				;$038909	|
	LDA $AA,X				;$03890B	|
	BEQ CODE_038915				;$03890D	|
	DEC $AA,X				;$03890F	|
	BNE CODE_038915				;$038911	|
	INC $C2,X				;$038913	|
CODE_038915:
	LDA $13
	AND.b #$03				;$038917	|
	BNE CODE_03892B				;$038919	|
	LDY.w $157C,X				;$03891B	|
	LDA $B6,X				;$03891E	|
	CMP.w DATA_0388E0,Y			;$038920	|
	BEQ CODE_03892B				;$038923	|
	CLC					;$038925	|
	ADC.w DATA_0388E2,Y			;$038926	|
	STA $B6,X				;$038929	|
CODE_03892B:
	LDA $14
	AND.b #$04				;$03892D	|
	LSR					;$03892F	|
	LSR					;$038930	|
	INC A					;$038931	|
	STA.w $1602,X				;$038932	|
	RTS					;$038935	|

CODE_038936:
	LDA $13
	AND.b #$01				;$038938	|
	BNE CODE_038952				;$03893A	|
	LDA.w $151C,X				;$03893C	|
	AND.b #$01				;$03893F	|
	TAY					;$038941	|
	LDA $AA,X				;$038942	|
	CLC					;$038944	|
	ADC.w BlurpAccelY,Y			;$038945	|
	STA $AA,X				;$038948	|
	CMP.w BlurpMaxSpeedY,Y			;$03894A	|
	BNE CODE_038952				;$03894D	|
	INC.w $151C,X				;$03894F	|
CODE_038952:
	BRA CODE_038915

DATA_038954:
	db $20,$E0

DATA_038956:
	db $02,$FE

SlidingKoopa:
	LDA.b #$00
	LDY $B6,X				;$03895A	|
	BEQ CODE_038964				;$03895C	|
	BPL CODE_038961				;$03895E	|
	INC A					;$038960	|
CODE_038961:
	STA.w $157C,X
CODE_038964:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$038968	|
	LDA.w $1558,X				;$03896B	|
	CMP.b #$01				;$03896E	|
	BNE CODE_038983				;$038970	|
	LDA.w $157C,X				;$038972	|
	PHA					;$038975	|
	LDA.b #$02				;$038976	|
	STA $9E,X				;$038978	|
	JSL InitSpriteTables			;$03897A	|
	PLA					;$03897E	|
	STA.w $157C,X				;$03897F	|
	SEC					;$038982	|
CODE_038983:
	LDA.b #$86
	BCC CODE_038989				;$038985	|
	LDA.b #$E0				;$038987	|
CODE_038989:
	STA.w $0302,Y
	LDA.w $14C8,X				;$03898C	|
	CMP.b #$08				;$03898F	|
	BNE Return0389FE			;$038991	|
	JSR SubOffscreen0Bnk3			;$038993	|
	JSL SprSprPMarioSprRts			;$038996	|
	LDA $9D					;$03899A	|
	ORA.w $1540,X				;$03899C	|
	ORA.w $1558,X				;$03899F	|
	BNE Return0389FE			;$0389A2	|
	JSL UpdateSpritePos			;$0389A4	|
	LDA.w $1588,X				;$0389A8	|
	AND.b #$04				;$0389AB	|
	BEQ Return0389FE			;$0389AD	|
	JSR CODE_0389FF				;$0389AF	|
	LDY.b #$00				;$0389B2	|
	LDA $B6,X				;$0389B4	|
	BEQ CODE_0389CC				;$0389B6	|
	BPL CODE_0389BD				;$0389B8	|
	EOR.b #$FF				;$0389BA	|
	INC A					;$0389BC	|
CODE_0389BD:
	STA $00
	LDA.w $15B8,X				;$0389BF	|
	BEQ CODE_0389CC				;$0389C2	|
	LDY $00					;$0389C4	|
	EOR $B6,X				;$0389C6	|
	BPL CODE_0389CC				;$0389C8	|
	LDY.b #$D0				;$0389CA	|
CODE_0389CC:
	STY $AA,X
	LDA $13					;$0389CE	|
	AND.b #$01				;$0389D0	|
	BNE Return0389FE			;$0389D2	|
	LDA.w $15B8,X				;$0389D4	|
	BNE CODE_0389EC				;$0389D7	|
	LDA $B6,X				;$0389D9	|
	BNE CODE_0389E3				;$0389DB	|
	LDA.b #$20				;$0389DD	|
	STA.w $1558,X				;$0389DF	|
	RTS					;$0389E2	|

CODE_0389E3:
	BPL CODE_0389E9
	INC $B6,X				;$0389E5	|
	INC $B6,X				;$0389E7	|
CODE_0389E9:
	DEC $B6,X
	RTS					;$0389EB	|

CODE_0389EC:
	ASL
	ROL					;$0389ED	|
	AND.b #$01				;$0389EE	|
	TAY					;$0389F0	|
	LDA $B6,X				;$0389F1	|
	CMP.w DATA_038954,Y			;$0389F3	|
	BEQ Return0389FE			;$0389F6	|
	CLC					;$0389F8	|
	ADC.w DATA_038956,Y			;$0389F9	|
	STA $B6,X				;$0389FC	|
Return0389FE:
	RTS

CODE_0389FF:
	LDA $B6,X
	BEQ Return038A20			;$038A01	|
	LDA $13					;$038A03	|
	AND.b #$03				;$038A05	|
	BNE Return038A20			;$038A07	|
	LDA.b #$04				;$038A09	|
	STA $00					;$038A0B	|
	LDA.b #$0A				;$038A0D	|
	STA $01					;$038A0F	|
	JSR IsSprOffScreenBnk3			;$038A11	|
	BNE Return038A20			;$038A14	|
	LDY.b #$03				;$038A16	|
CODE_038A18:
	LDA.w $17C0,Y
	BEQ CODE_038A21				;$038A1B	|
	DEY					;$038A1D	|
	BPL CODE_038A18				;$038A1E	|
Return038A20:
	RTS

CODE_038A21:
	LDA.b #$03
	STA.w $17C0,Y				;$038A23	|
	LDA $E4,X				;$038A26	|
	CLC					;$038A28	|
	ADC $00					;$038A29	|
	STA.w $17C8,Y				;$038A2B	|
	LDA $D8,X				;$038A2E	|
	CLC					;$038A30	|
	ADC $01					;$038A31	|
	STA.w $17C4,Y				;$038A33	|
	LDA.b #$13				;$038A36	|
	STA.w $17CC,Y				;$038A38	|
	RTS					;$038A3B	|

BowserStatue:
	JSR BowserStatueGfx
	LDA $9D					;$038A3F	|
	BNE Return038A68			;$038A41	|
	JSR SubOffscreen0Bnk3			;$038A43	|
	LDA $C2,X				;$038A46	|
	JSL execute_pointer			;$038A48	|

BowserStatuePtrs:
	dw CODE_038A57
	dw CODE_038A54
	dw CODE_038A69
	dw CODE_038A54

CODE_038A54:
	JSR CODE_038ACB
CODE_038A57:
	JSL InvisBlkMainRt
	JSL UpdateSpritePos			;$038A5B	|
	LDA.w $1588,X				;$038A5F	|
	AND.b #$04				;$038A62	|
	BEQ Return038A68			;$038A64	|
	STZ $AA,X				;$038A66	|
Return038A68:
	RTS

CODE_038A69:
	ASL.w $167A,X
	LSR.w $167A,X				;$038A6C	|
	JSL MarioSprInteract			;$038A6F	|
	STZ.w $1602,X				;$038A73	|
	LDA $AA,X				;$038A76	|
	CMP.b #$10				;$038A78	|
	BPL CODE_038A7F				;$038A7A	|
	INC.w $1602,X				;$038A7C	|
CODE_038A7F:
	JSL UpdateSpritePos
	LDA.w $1588,X				;$038A83	|
	AND.b #$03				;$038A86	|
	BEQ CODE_038A99				;$038A88	|
	LDA $B6,X				;$038A8A	|
	EOR.b #$FF				;$038A8C	|
	INC A					;$038A8E	|
	STA $B6,X				;$038A8F	|
	LDA.w $157C,X				;$038A91	|
	EOR.b #$01				;$038A94	|
	STA.w $157C,X				;$038A96	|
CODE_038A99:
	LDA.w $1588,X
	AND.b #$04				;$038A9C	|
	BEQ Return038AC6			;$038A9E	|
	LDA.b #$10				;$038AA0	|
	STA $AA,X				;$038AA2	|
	STZ $B6,X				;$038AA4	|
	LDA.w $1540,X				;$038AA6	|
	BEQ CODE_038AC1				;$038AA9	|
	DEC A					;$038AAB	|
	BNE Return038AC6			;$038AAC	|
	LDA.b #$C0				;$038AAE	|
	STA $AA,X				;$038AB0	|
	JSR SubHorzPosBnk3			;$038AB2	|
	TYA					;$038AB5	|
	STA.w $157C,X				;$038AB6	|
	LDA.w BwsrStatueSpeed,Y			;$038AB9	|
	STA $B6,X				;$038ABC	|
	RTS					;$038ABE	|

BwsrStatueSpeed:
	db $10,$F0

CODE_038AC1:
	LDA.b #$30
	STA.w $1540,X				;$038AC3	|
Return038AC6:
	RTS

BwserFireDispXLo:
	db $10,$F0

BwserFireDispXHi:
	db $00,$FF

CODE_038ACB:
	TXA
	ASL					;$038ACC	|
	ASL					;$038ACD	|
	ADC $13					;$038ACE	|
	AND.b #$7F				;$038AD0	|
	BNE Return038B24			;$038AD2	|
	JSL FindFreeSprSlot			;$038AD4	|
	BMI Return038B24			;$038AD8	|
	LDA.b #$17				;$038ADA	|
	STA.w $1DFC				;$038ADC	|
	LDA.b #$08				;$038ADF	|
	STA.w $14C8,Y				;$038AE1	|
	LDA.b #$B3				;$038AE4	|
	STA.w $009E,y				;$038AE6	|
	LDA $E4,X				;$038AE9	|
	STA $00					;$038AEB	|
	LDA.w $14E0,X				;$038AED	|
	STA $01					;$038AF0	|
	PHX					;$038AF2	|
	LDA.w $157C,X				;$038AF3	|
	TAX					;$038AF6	|
	LDA $00					;$038AF7	|
	CLC					;$038AF9	|
	ADC.w BwserFireDispXLo,X		;$038AFA	|
	STA.w $00E4,y				;$038AFD	|
	LDA $01					;$038B00	|
	ADC.w BwserFireDispXHi,X		;$038B02	|
	STA.w $14E0,Y				;$038B05	|
	TYX					;$038B08	|
	JSL InitSpriteTables			;$038B09	|
	PLX					;$038B0D	|
	LDA $D8,X				;$038B0E	|
	SEC					;$038B10	|
	SBC.b #$02				;$038B11	|
	STA.w $00D8,y				;$038B13	|
	LDA.w $14D4,X				;$038B16	|
	SBC.b #$00				;$038B19	|
	STA.w $14D4,Y				;$038B1B	|
	LDA.w $157C,X				;$038B1E	|
	STA.w $157C,Y				;$038B21	|
Return038B24:
	RTS

BwsrStatueDispX:
	db $08,$F8,$00,$00,$08,$00

BwsrStatueDispY:
	db $10,$F8,$00

BwsrStatueTiles:
	db $56,$30,$41,$56,$30,$35

BwsrStatueTileSize:
	db $00,$02,$02

BwsrStatueGfxProp:
	db $00,$00,$00,$40,$40,$40

BowserStatueGfx:
	JSR GetDrawInfoBnk3
	LDA.w $1602,X				;$038B40	|
	STA $04					;$038B43	|
	EOR.b #$01				;$038B45	|
	DEC A					;$038B47	|
	STA $03					;$038B48	|
	LDA.w $15F6,X				;$038B4A	|
	STA $05					;$038B4D	|
	LDA.w $157C,X				;$038B4F	|
	STA $02					;$038B52	|
	PHX					;$038B54	|
	LDX.b #$02				;$038B55	|
CODE_038B57:
	PHX
	LDA $02					;$038B58	|
	BNE CODE_038B5F				;$038B5A	|
	INX					;$038B5C	|
	INX					;$038B5D	|
	INX					;$038B5E	|
CODE_038B5F:
	LDA $00
	CLC					;$038B61	|
	ADC.w BwsrStatueDispX,X			;$038B62	|
	STA.w $0300,Y				;$038B65	|
	LDA.w BwsrStatueGfxProp,X		;$038B68	|
	ORA $05					;$038B6B	|
	ORA $64					;$038B6D	|
	STA.w $0303,Y				;$038B6F	|
	PLX					;$038B72	|
	LDA $01					;$038B73	|
	CLC					;$038B75	|
	ADC.w BwsrStatueDispY,X			;$038B76	|
	STA.w $0301,Y				;$038B79	|
	PHX					;$038B7C	|
	LDA $04					;$038B7D	|
	BEQ CODE_038B84				;$038B7F	|
	INX					;$038B81	|
	INX					;$038B82	|
	INX					;$038B83	|
CODE_038B84:
	LDA.w BwsrStatueTiles,X
	STA.w $0302,Y				;$038B87	|
	PLX					;$038B8A	|
	PHY					;$038B8B	|
	TYA					;$038B8C	|
	LSR					;$038B8D	|
	LSR					;$038B8E	|
	TAY					;$038B8F	|
	LDA.w BwsrStatueTileSize,X		;$038B90	|
	STA.w $0460,Y				;$038B93	|
	PLY					;$038B96	|
	INY					;$038B97	|
	INY					;$038B98	|
	INY					;$038B99	|
	INY					;$038B9A	|
	DEX					;$038B9B	|
	CPX $03					;$038B9C	|
	BNE CODE_038B57				;$038B9E	|
	PLX					;$038BA0	|
	LDY.b #$FF				;$038BA1	|
	LDA.b #$02				;$038BA3	|
	JSL FinishOAMWrite			;$038BA5	|
	RTS					;$038BA9	|

DATA_038BAA:
	db $20,$20,$20,$20,$20,$20,$20,$20
	db $20,$20,$20,$20,$20,$20,$20,$20
	db $20,$1F,$1E,$1D,$1C,$1B,$1A,$19
	db $18,$17,$16,$15,$14,$13,$12,$11
	db $10,$0F,$0E,$0D,$0C,$0B,$0A,$09
	db $08,$07,$06,$05,$04,$03,$02,$01
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $01,$02,$03,$04,$05,$06,$07,$08
	db $09,$0A,$0B,$0C,$0D,$0E,$0F,$10
	db $11,$12,$13,$14,$15,$16,$17,$18
	db $19,$1A,$1B,$1C,$1D,$1E,$1F,$20
	db $20,$20,$20,$20,$20,$20,$20,$20
	db $20,$20,$20,$20,$20,$20,$20,$20
DATA_038C2A:
	db $00,$F8,$00,$08

Return038C2E:
	RTS

CarrotTopLift:
	JSR CarrotTopLiftGfx
	LDA $9D					;$038C32	|
	BNE Return038C2E			;$038C34	|
	JSR SubOffscreen0Bnk3			;$038C36	|
	LDA.w $1540,X				;$038C39	|
	BNE CODE_038C45				;$038C3C	|
	INC $C2,X				;$038C3E	|
	LDA.b #$80				;$038C40	|
	STA.w $1540,X				;$038C42	|
CODE_038C45:
	LDA $C2,X
	AND.b #$03				;$038C47	|
	TAY					;$038C49	|
	LDA.w DATA_038C2A,Y			;$038C4A	|
	STA $B6,X				;$038C4D	|
	LDA $B6,X				;$038C4F	|
	LDY $9E,X				;$038C51	|
	CPY.b #$B8				;$038C53	|
	BEQ CODE_038C5A				;$038C55	|
	EOR.b #$FF				;$038C57	|
	INC A					;$038C59	|
CODE_038C5A:
	STA $AA,X
	JSL UpdateYPosNoGrvty			;$038C5C	|
	LDA $E4,X				;$038C60	|
	STA.w $151C,X				;$038C62	|
	JSL UpdateXPosNoGrvty			;$038C65	|
	JSR CODE_038CE4				;$038C69	|
	JSL GetSpriteClippingA			;$038C6C	|
	JSL CheckForContact			;$038C70	|
	BCC Return038CE3			;$038C74	|
	LDA $7D					;$038C76	|
	BMI Return038CE3			;$038C78	|
	LDA $94					;$038C7A	|
	SEC					;$038C7C	|
	SBC.w $151C,X				;$038C7D	|
	CLC					;$038C80	|
	ADC.b #$1C				;$038C81	|
	LDY $9E,X				;$038C83	|
	CPY.b #$B8				;$038C85	|
	BNE CODE_038C8C				;$038C87	|
	CLC					;$038C89	|
	ADC.b #$38				;$038C8A	|
CODE_038C8C:
	TAY
	LDA.w $187A				;$038C8D	|
	CMP.b #$01				;$038C90	|
	LDA.b #$20				;$038C92	|
	BCC CODE_038C98				;$038C94	|
	LDA.b #$30				;$038C96	|
CODE_038C98:
	CLC
	ADC $96					;$038C99	|
	STA $00					;$038C9B	|
	LDA $D8,X				;$038C9D	|
	CLC					;$038C9F	|
	ADC.w DATA_038BAA,Y			;$038CA0	|
	CMP $00					;$038CA3	|
	BPL Return038CE3			;$038CA5	|
	LDA.w $187A				;$038CA7	|
	CMP.b #$01				;$038CAA	|
	LDA.b #$1D				;$038CAC	|
	BCC CODE_038CB2				;$038CAE	|
	LDA.b #$2D				;$038CB0	|
CODE_038CB2:
	STA $00
	LDA $D8,X				;$038CB4	|
	CLC					;$038CB6	|
	ADC.w DATA_038BAA,Y			;$038CB7	|
	PHP					;$038CBA	|
	SEC					;$038CBB	|
	SBC $00					;$038CBC	|
	STA $96					;$038CBE	|
	LDA.w $14D4,X				;$038CC0	|
	SBC.b #$00				;$038CC3	|
	PLP					;$038CC5	|
	ADC.b #$00				;$038CC6	|
	STA $97					;$038CC8	|
	STZ $7D					;$038CCA	|
	LDA.b #$01				;$038CCC	|
	STA.w $1471				;$038CCE	|
	LDY.b #$00				;$038CD1	|
	LDA.w $1491				;$038CD3	|
	BPL CODE_038CD9				;$038CD6	|
	DEY					;$038CD8	|
CODE_038CD9:
	CLC
	ADC $94					;$038CDA	|
	STA $94					;$038CDC	|
	TYA					;$038CDE	|
	ADC $95					;$038CDF	|
	STA $95					;$038CE1	|
Return038CE3:
	RTS

CODE_038CE4:
	LDA $94
	CLC					;$038CE6	|
	ADC.b #$04				;$038CE7	|
	STA $00					;$038CE9	|
	LDA $95					;$038CEB	|
	ADC.b #$00				;$038CED	|
	STA $08					;$038CEF	|
	LDA.b #$08				;$038CF1	|
	STA $02					;$038CF3	|
	STA $03					;$038CF5	|
	LDA.b #$20				;$038CF7	|
	LDY.w $187A				;$038CF9	|
	BEQ CODE_038D00				;$038CFC	|
	LDA.b #$30				;$038CFE	|
CODE_038D00:
	CLC
	ADC $96					;$038D01	|
	STA $01					;$038D03	|
	LDA $97					;$038D05	|
	ADC.b #$00				;$038D07	|
	STA $09					;$038D09	|
	RTS					;$038D0B	|

DiagPlatDispX:
	db $10,$00,$10,$00,$10,$00

DiagPlatDispY:
	db $00,$10,$10,$00,$10,$10

DiagPlatTiles2:
	db $E4,$E0,$E2,$E4,$E0,$E2

DiagPlatGfxProp:
	db $0B,$0B,$0B,$4B,$4B,$4B

CarrotTopLiftGfx:
	JSR GetDrawInfoBnk3
	PHX					;$038D27	|
	LDA $9E,X				;$038D28	|
	CMP.b #$B8				;$038D2A	|
	LDX.b #$02				;$038D2C	|
	STX $02					;$038D2E	|
	BCC CODE_038D34				;$038D30	|
	LDX.b #$05				;$038D32	|
CODE_038D34:
	LDA $00
	CLC					;$038D36	|
	ADC.w DiagPlatDispX,X			;$038D37	|
	STA.w $0300,Y				;$038D3A	|
	LDA $01					;$038D3D	|
	CLC					;$038D3F	|
	ADC.w DiagPlatDispY,X			;$038D40	|
	STA.w $0301,Y				;$038D43	|
	LDA.w DiagPlatTiles2,X			;$038D46	|
	STA.w $0302,Y				;$038D49	|
	LDA.w DiagPlatGfxProp,X			;$038D4C	|
	ORA $64					;$038D4F	|
	STA.w $0303,Y				;$038D51	|
	INY					;$038D54	|
	INY					;$038D55	|
	INY					;$038D56	|
	INY					;$038D57	|
	DEX					;$038D58	|
	DEC $02					;$038D59	|
	BPL CODE_038D34				;$038D5B	|
	PLX					;$038D5D	|
	LDY.b #$02				;$038D5E	|
	TYA					;$038D60	|
	JSL FinishOAMWrite			;$038D61	|
	RTS					;$038D65	|

DATA_038D66:
	db $00,$04,$07,$08,$08,$07,$04,$00
	db $00

InfoBox:
	JSL InvisBlkMainRt
	JSR SubOffscreen0Bnk3			;$038D73	|
	LDA.w $1558,X				;$038D76	|
	CMP.b #$01				;$038D79	|
	BNE CODE_038D93				;$038D7B	|
	LDA.b #$22				;$038D7D	|
	STA.w $1DFC				;$038D7F	|
	STZ.w $1558,X				;$038D82	|
	STZ $C2,X				;$038D85	|
	LDA $E4,X				;$038D87	|
	LSR					;$038D89	|
	LSR					;$038D8A	|
	LSR					;$038D8B	|
	LSR					;$038D8C	|
	AND.b #$01				;$038D8D	|
	INC A					;$038D8F	|
	STA.w $1426				;$038D90	|
CODE_038D93:
	LDA.w $1558,X
	LSR					;$038D96	|
	TAY					;$038D97	|
	LDA $1C					;$038D98	|
	PHA					;$038D9A	|
	CLC					;$038D9B	|
	ADC.w DATA_038D66,Y			;$038D9C	|
	STA $1C					;$038D9F	|
	LDA $1D					;$038DA1	|
	PHA					;$038DA3	|
	ADC.b #$00				;$038DA4	|
	STA $1D					;$038DA6	|
	JSL GenericSprGfxRt2			;$038DA8	|
	LDY.w $15EA,X				;$038DAC	|
	LDA.b #$C0				;$038DAF	|
	STA.w $0302,Y				;$038DB1	|
	PLA					;$038DB4	|
	STA $1D					;$038DB5	|
	PLA					;$038DB7	|
	STA $1C					;$038DB8	|
	RTS					;$038DBA	|

TimedLift:
	JSR TimedPlatformGfx
	LDA $9D					;$038DBE	|
	BNE Return038DEF			;$038DC0	|
	JSR SubOffscreen0Bnk3			;$038DC2	|
	LDA $13					;$038DC5	|
	AND.b #$00				;$038DC7	|
	BNE CODE_038DD7				;$038DC9	|
	LDA $C2,X				;$038DCB	|
	BEQ CODE_038DD7				;$038DCD	|
	LDA.w $1570,X				;$038DCF	|
	BEQ CODE_038DD7				;$038DD2	|
	DEC.w $1570,X				;$038DD4	|
CODE_038DD7:
	LDA.w $1570,X
	BEQ CODE_038DF0				;$038DDA	|
	JSL UpdateXPosNoGrvty			;$038DDC	|
	STA.w $1528,X				;$038DE0	|
	JSL InvisBlkMainRt			;$038DE3	|
	BCC Return038DEF			;$038DE7	|
	LDA.b #$10				;$038DE9	|
	STA $B6,X				;$038DEB	|
	STA $C2,X				;$038DED	|
Return038DEF:
	RTS

CODE_038DF0:
	JSL UpdateSpritePos
	LDA.w $1491				;$038DF4	|
	STA.w $1528,X				;$038DF7	|
	JSL InvisBlkMainRt			;$038DFA	|
	RTS					;$038DFE	|

TimedPlatDispX:
	db $00,$10,$0C

TimedPlatDispY:
	db $00,$00,$04

TimedPlatTiles:
	db $C4,$C4,$00

TimedPlatGfxProp:
	db $0B,$4B,$0B

TimedPlatTileSize:
	db $02,$02,$00

TimedPlatNumTiles:
	db $B6,$B5,$B4,$B3

TimedPlatformGfx:
	JSR GetDrawInfoBnk3
	LDA.w $1570,X				;$038E15	|
	PHX					;$038E18	|
	PHA					;$038E19	|
	LSR					;$038E1A	|
	LSR					;$038E1B	|
	LSR					;$038E1C	|
	LSR					;$038E1D	|
	LSR					;$038E1E	|
	LSR					;$038E1F	|
	TAX					;$038E20	|
	LDA.w TimedPlatNumTiles,X		;$038E21	|
	STA $02					;$038E24	|
	LDX.b #$02				;$038E26	|
	PLA					;$038E28	|
	CMP.b #$08				;$038E29	|
	BCS CODE_038E2E				;$038E2B	|
	DEX					;$038E2D	|
CODE_038E2E:
	LDA $00
	CLC					;$038E30	|
	ADC.w TimedPlatDispX,X			;$038E31	|
	STA.w $0300,Y				;$038E34	|
	LDA $01					;$038E37	|
	CLC					;$038E39	|
	ADC.w TimedPlatDispY,X			;$038E3A	|
	STA.w $0301,Y				;$038E3D	|
	LDA.w TimedPlatTiles,X			;$038E40	|
	CPX.b #$02				;$038E43	|
	BNE CODE_038E49				;$038E45	|
	LDA $02					;$038E47	|
CODE_038E49:
	STA.w $0302,Y
	LDA.w TimedPlatGfxProp,X		;$038E4C	|
	ORA $64					;$038E4F	|
	STA.w $0303,Y				;$038E51	|
	PHY					;$038E54	|
	TYA					;$038E55	|
	LSR					;$038E56	|
	LSR					;$038E57	|
	TAY					;$038E58	|
	LDA.w TimedPlatTileSize,X		;$038E59	|
	STA.w $0460,Y				;$038E5C	|
	PLY					;$038E5F	|
	INY					;$038E60	|
	INY					;$038E61	|
	INY					;$038E62	|
	INY					;$038E63	|
	DEX					;$038E64	|
	BPL CODE_038E2E				;$038E65	|
	PLX					;$038E67	|
	LDY.b #$FF				;$038E68	|
	LDA.b #$02				;$038E6A	|
	JSL FinishOAMWrite			;$038E6C	|
	RTS					;$038E70	|

GreyMoveBlkSpeed:
	db $00,$F0,$00,$10

GreyMoveBlkTiming:
	db $40,$50,$40,$50

GreyCastleBlock:
	JSR CODE_038EB4
	LDA $9D					;$038E7C	|
	BNE Return038EA7			;$038E7E	|
	LDA.w $1540,X				;$038E80	|
	BNE CODE_038E92				;$038E83	|
	INC $C2,X				;$038E85	|
	LDA $C2,X				;$038E87	|
	AND.b #$03				;$038E89	|
	TAY					;$038E8B	|
	LDA.w GreyMoveBlkTiming,Y		;$038E8C	|
	STA.w $1540,X				;$038E8F	|
CODE_038E92:
	LDA $C2,X
	AND.b #$03				;$038E94	|
	TAY					;$038E96	|
	LDA.w GreyMoveBlkSpeed,Y		;$038E97	|
	STA $B6,X				;$038E9A	|
	JSL UpdateXPosNoGrvty			;$038E9C	|
	STA.w $1528,X				;$038EA0	|
	JSL InvisBlkMainRt			;$038EA3	|
Return038EA7:
	RTS

GreyMoveBlkDispX:
	db $00,$10,$00,$10

GreyMoveBlkDispY:
	db $00,$00,$10,$10

GreyMoveBlkTiles:
	db $CC,$CE,$EC,$EE

CODE_038EB4:
	JSR GetDrawInfoBnk3
	PHX					;$038EB7	|
	LDX.b #$03				;$038EB8	|
CODE_038EBA:
	LDA $00
	CLC					;$038EBC	|
	ADC.w GreyMoveBlkDispX,X		;$038EBD	|
	STA.w $0300,Y				;$038EC0	|
	LDA $01					;$038EC3	|
	CLC					;$038EC5	|
	ADC.w GreyMoveBlkDispY,X		;$038EC6	|
	STA.w $0301,Y				;$038EC9	|
	LDA.w GreyMoveBlkTiles,X		;$038ECC	|
	STA.w $0302,Y				;$038ECF	|
	LDA.b #$03				;$038ED2	|
	ORA $64					;$038ED4	|
	STA.w $0303,Y				;$038ED6	|
	INY					;$038ED9	|
	INY					;$038EDA	|
	INY					;$038EDB	|
	INY					;$038EDC	|
	DEX					;$038EDD	|
	BPL CODE_038EBA				;$038EDE	|
	PLX					;$038EE0	|
	LDY.b #$02				;$038EE1	|
	LDA.b #$03				;$038EE3	|
	JSL FinishOAMWrite			;$038EE5	|
	RTS					;$038EE9	|

StatueFireSpeed:
	db $10,$F0

StatueFireball:
	JSR StatueFireballGfx
	LDA $9D					;$038EEF	|
	BNE Return038F06			;$038EF1	|
	JSR SubOffscreen0Bnk3			;$038EF3	|
	JSL MarioSprInteract			;$038EF6	|
	LDY.w $157C,X				;$038EFA	|
	LDA.w StatueFireSpeed,Y			;$038EFD	|
	STA $B6,X				;$038F00	|
	JSL UpdateXPosNoGrvty			;$038F02	|
Return038F06:
	RTS

StatueFireDispX:
	db $08,$00,$00,$08

StatueFireTiles:
	db $32,$50,$33,$34,$32,$50,$33,$34
StatueFireGfxProp:
	db $09,$09,$09,$09,$89,$89,$89,$89

StatueFireballGfx:
	JSR GetDrawInfoBnk3
	LDA.w $157C,X				;$038F1E	|
	ASL					;$038F21	|
	STA $02					;$038F22	|
	LDA $14					;$038F24	|
	LSR					;$038F26	|
	AND.b #$03				;$038F27	|
	ASL					;$038F29	|
	STA $03					;$038F2A	|
	PHX					;$038F2C	|
	LDX.b #$01				;$038F2D	|
CODE_038F2F:
	LDA $01
	STA.w $0301,Y				;$038F31	|
	PHX					;$038F34	|
	TXA					;$038F35	|
	ORA $02					;$038F36	|
	TAX					;$038F38	|
	LDA $00					;$038F39	|
	CLC					;$038F3B	|
	ADC.w StatueFireDispX,X			;$038F3C	|
	STA.w $0300,Y				;$038F3F	|
	PLA					;$038F42	|
	PHA					;$038F43	|
	ORA $03					;$038F44	|
	TAX					;$038F46	|
	LDA.w StatueFireTiles,X			;$038F47	|
	STA.w $0302,Y				;$038F4A	|
	LDA.w StatueFireGfxProp,X		;$038F4D	|
	LDX $02					;$038F50	|
	BNE CODE_038F56				;$038F52	|
	EOR.b #$40				;$038F54	|
CODE_038F56:
	ORA $64
	STA.w $0303,Y				;$038F58	|
	PLX					;$038F5B	|
	INY					;$038F5C	|
	INY					;$038F5D	|
	INY					;$038F5E	|
	INY					;$038F5F	|
	DEX					;$038F60	|
	BPL CODE_038F2F				;$038F61	|
	PLX					;$038F63	|
	LDY.b #$00				;$038F64	|
	LDA.b #$01				;$038F66	|
	JSL FinishOAMWrite			;$038F68	|
	RTS					;$038F6C	|

BooStreamFrntTiles:
	db $88,$8C,$8E,$A8,$AA,$AE,$88,$8C

ReflectingFireball:
	JSR CODE_038FF2
	BRA CODE_038FA4				;$038F78	|

BooStream:
	LDA.b #$00
	LDY $B6,X				;$038F7C	|
	BPL CODE_038F81				;$038F7E	|
	INC A					;$038F80	|
CODE_038F81:
	STA.w $157C,X
	JSL GenericSprGfxRt2			;$038F84	|
	LDY.w $15EA,X				;$038F88	|
	LDA $14					;$038F8B	|
	LSR					;$038F8D	|
	LSR					;$038F8E	|
	LSR					;$038F8F	|
	LSR					;$038F90	|
	AND.b #$01				;$038F91	|
	STA $00					;$038F93	|
	TXA					;$038F95	|
	AND.b #$03				;$038F96	|
	ASL					;$038F98	|
	ORA $00					;$038F99	|
	PHX					;$038F9B	|
	TAX					;$038F9C	|
	LDA.w BooStreamFrntTiles,X		;$038F9D	|
	STA.w $0302,Y				;$038FA0	|
	PLX					;$038FA3	|
CODE_038FA4:
	LDA.w $14C8,X
	CMP.b #$08				;$038FA7	|
	BNE Return038FF1			;$038FA9	|
	LDA $9D					;$038FAB	|
	BNE Return038FF1			;$038FAD	|
	TXA					;$038FAF	|
	EOR $14					;$038FB0	|
	AND.b #$07				;$038FB2	|
	ORA.w $186C,X				;$038FB4	|
	BNE CODE_038FC2				;$038FB7	|
	LDA $9E,X				;$038FB9	|
	CMP.b #$B0				;$038FBB	|
	BNE CODE_038FC2				;$038FBD	|
	JSR CODE_039020				;$038FBF	|
CODE_038FC2:
	JSL UpdateYPosNoGrvty
	JSL UpdateXPosNoGrvty			;$038FC6	|
	JSL CODE_019138				;$038FCA	|
	LDA.w $1588,X				;$038FCE	|
	AND.b #$03				;$038FD1	|
	BEQ CODE_038FDC				;$038FD3	|
	LDA $B6,X				;$038FD5	|
	EOR.b #$FF				;$038FD7	|
	INC A					;$038FD9	|
	STA $B6,X				;$038FDA	|
CODE_038FDC:
	LDA.w $1588,X
	AND.b #$0C				;$038FDF	|
	BEQ CODE_038FEA				;$038FE1	|
	LDA $AA,X				;$038FE3	|
	EOR.b #$FF				;$038FE5	|
	INC A					;$038FE7	|
	STA $AA,X				;$038FE8	|
CODE_038FEA:
	JSL MarioSprInteract
	JSR SubOffscreen0Bnk3			;$038FEE	|
Return038FF1:
	RTS

CODE_038FF2:
	JSL GenericSprGfxRt2
	LDA $14					;$038FF6	|
	LSR					;$038FF8	|
	LSR					;$038FF9	|
	LDA.b #$04				;$038FFA	|
	BCC CODE_038FFF				;$038FFC	|
	ASL					;$038FFE	|
CODE_038FFF:
	LDY $B6,X
	BPL CODE_039005				;$039001	|
	EOR.b #$40				;$039003	|
CODE_039005:
	LDY $AA,X
	BMI CODE_03900B				;$039007	|
	EOR.b #$80				;$039009	|
CODE_03900B:
	STA $00
	LDY.w $15EA,X				;$03900D	|
	LDA.b #$AC				;$039010	|
	STA.w $0302,Y				;$039012	|
	LDA.w $0303,Y				;$039015	|
	AND.b #$31				;$039018	|
	ORA $00					;$03901A	|
	STA.w $0303,Y				;$03901C	|
	RTS					;$03901F	|

CODE_039020:
	LDY.b #$0B
CODE_039022:
	LDA.w $17F0,Y
	BEQ CODE_039037				;$039025	|
	DEY					;$039027	|
	BPL CODE_039022				;$039028	|
	DEC.w $185D				;$03902A	|
	BPL ADDR_039034				;$03902D	|
	LDA.b #$0B				;$03902F	|
	STA.w $185D				;$039031	|
ADDR_039034:
	LDY.w $185D
CODE_039037:
	LDA.b #$0A
	STA.w $17F0,Y				;$039039	|
	LDA $E4,X				;$03903C	|
	STA.w $1808,Y				;$03903E	|
	LDA.w $14E0,X				;$039041	|
	STA.w $18EA,Y				;$039044	|
	LDA $D8,X				;$039047	|
	STA.w $17FC,Y				;$039049	|
	LDA.w $14D4,X				;$03904C	|
	STA.w $1814,Y				;$03904F	|
	LDA.b #$30				;$039052	|
	STA.w $1850,Y				;$039054	|
	LDA $B6,X				;$039057	|
	STA.w $182C,Y				;$039059	|
	RTS					;$03905C	|

FishinBooAccelX:
	db $01,$FF

FishinBooMaxSpeedX:
	db $20,$E0

FishinBooAccelY:
	db $01,$FF

FishinBooMaxSpeedY:
	db $10,$F0

FishinBoo:
	JSR FishinBooGfx
	LDA $9D					;$039068	|
	BNE Return0390EA			;$03906A	|
	JSL MarioSprInteract			;$03906C	|
	JSR SubHorzPosBnk3			;$039070	|
	STZ.w $1602,X				;$039073	|
	LDA.w $15AC,X				;$039076	|
	BEQ CODE_039086				;$039079	|
	INC.w $1602,X				;$03907B	|
	CMP.b #$10				;$03907E	|
	BNE CODE_039086				;$039080	|
	TYA					;$039082	|
	STA.w $157C,X				;$039083	|
CODE_039086:
	TXA
	ASL					;$039087	|
	ASL					;$039088	|
	ASL					;$039089	|
	ASL					;$03908A	|
	ADC $13					;$03908B	|
	AND.b #$3F				;$03908D	|
	ORA.w $15AC,X				;$03908F	|
	BNE CODE_039099				;$039092	|
	LDA.b #$20				;$039094	|
	STA.w $15AC,X				;$039096	|
CODE_039099:
	LDA.w $18BF
	BEQ CODE_0390A2				;$03909C	|
	TYA					;$03909E	|
	EOR.b #$01				;$03909F	|
	TAY					;$0390A1	|
CODE_0390A2:
	LDA $B6,X
	CMP.w FishinBooMaxSpeedX,Y		;$0390A4	|
	BEQ CODE_0390AF				;$0390A7	|
	CLC					;$0390A9	|
	ADC.w FishinBooAccelX,Y			;$0390AA	|
	STA $B6,X				;$0390AD	|
CODE_0390AF:
	LDA $13
	AND.b #$01				;$0390B1	|
	BNE CODE_0390C9				;$0390B3	|
	LDA $C2,X				;$0390B5	|
	AND.b #$01				;$0390B7	|
	TAY					;$0390B9	|
	LDA $AA,X				;$0390BA	|
	CLC					;$0390BC	|
	ADC.w FishinBooAccelY,Y			;$0390BD	|
	STA $AA,X				;$0390C0	|
	CMP.w FishinBooMaxSpeedY,Y		;$0390C2	|
	BNE CODE_0390C9				;$0390C5	|
	INC $C2,X				;$0390C7	|
CODE_0390C9:
	LDA $B6,X
	PHA					;$0390CB	|
	LDY.w $18BF				;$0390CC	|
	BNE CODE_0390DC				;$0390CF	|
	LDA.w $17BD				;$0390D1	|
	ASL					;$0390D4	|
	ASL					;$0390D5	|
	ASL					;$0390D6	|
	CLC					;$0390D7	|
	ADC $B6,X				;$0390D8	|
	STA $B6,X				;$0390DA	|
CODE_0390DC:
	JSL UpdateXPosNoGrvty
	PLA					;$0390E0	|
	STA $B6,X				;$0390E1	|
	JSL UpdateYPosNoGrvty			;$0390E3	|
	JSR CODE_0390F3				;$0390E7	|
Return0390EA:
	RTS

DATA_0390EB:
	db $1A,$14,$EE,$F8

DATA_0390EF:
	db $00,$00,$FF,$FF

CODE_0390F3:
	LDA.w $157C,X
	ASL					;$0390F6	|
	ADC.w $1602,X				;$0390F7	|
	TAY					;$0390FA	|
	LDA $E4,X				;$0390FB	|
	CLC					;$0390FD	|
	ADC.w DATA_0390EB,Y			;$0390FE	|
	STA $04					;$039101	|
	LDA.w $14E0,X				;$039103	|
	ADC.w DATA_0390EF,Y			;$039106	|
	STA $0A					;$039109	|
	LDA.b #$04				;$03910B	|
	STA $06					;$03910D	|
	STA $07					;$03910F	|
	LDA $D8,X				;$039111	|
	CLC					;$039113	|
	ADC.b #$47				;$039114	|
	STA $05					;$039116	|
	LDA.w $14D4,X				;$039118	|
	ADC.b #$00				;$03911B	|
	STA $0B					;$03911D	|
	JSL GetMarioClipping			;$03911F	|
	JSL CheckForContact			;$039123	|
	BCC Return03912D			;$039127	|
	JSL HurtMario				;$039129	|
Return03912D:
	RTS

FishinBooDispX:
	db $FB,$05,$00,$F2,$FD,$03,$EA,$EA
	db $EA,$EA,$FB,$05,$00,$FA,$FD,$03
	db $F2,$F2,$F2,$F2,$FB,$05,$00,$0E
	db $03,$FD,$16,$16,$16,$16,$FB,$05
	db $00,$06,$03,$FD,$0E,$0E,$0E,$0E
FishinBooDispY:
	db $0B,$0B,$00,$03,$0F,$0F,$13,$23
	db $33,$43

FishinBooTiles1:
	db $60,$60,$64,$8A,$60,$60,$AC,$AC
	db $AC,$CE

FishinBooGfxProp:
	db $04,$04,$0D,$09,$04,$04,$0D,$0D
	db $0D,$07

FishinBooTiles2:
	db $CC,$CE,$CC,$CE

DATA_039178:
	db $00,$00,$40,$40

DATA_03917C:
	db $00,$40,$C0,$80

FishinBooGfx:
	JSR GetDrawInfoBnk3
	LDA.w $1602,X				;$039183	|
	STA $04					;$039186	|
	LDA.w $157C,X				;$039188	|
	STA $02					;$03918B	|
	PHX					;$03918D	|
	PHY					;$03918E	|
	LDX.b #$09				;$03918F	|
CODE_039191:
	LDA $01
	CLC					;$039193	|
	ADC.w FishinBooDispY,X			;$039194	|
	STA.w $0301,Y				;$039197	|
	STZ $03					;$03919A	|
	LDA.w FishinBooTiles1,X			;$03919C	|
	CPX.b #$09				;$03919F	|
	BNE CODE_0391B4				;$0391A1	|
	LDA $14					;$0391A3	|
	LSR					;$0391A5	|
	LSR					;$0391A6	|
	PHX					;$0391A7	|
	AND.b #$03				;$0391A8	|
	TAX					;$0391AA	|
	LDA.w DATA_039178,X			;$0391AB	|
	STA $03					;$0391AE	|
	LDA.w FishinBooTiles2,X			;$0391B0	|
	PLX					;$0391B3	|
CODE_0391B4:
	STA.w $0302,Y
	LDA $02					;$0391B7	|
	CMP.b #$01				;$0391B9	|
	LDA.w FishinBooGfxProp,X		;$0391BB	|
	EOR $03					;$0391BE	|
	ORA $64					;$0391C0	|
	BCS CODE_0391C6				;$0391C2	|
	EOR.b #$40				;$0391C4	|
CODE_0391C6:
	STA.w $0303,Y
	PHX					;$0391C9	|
	LDA $04					;$0391CA	|
	BEQ CODE_0391D3				;$0391CC	|
	TXA					;$0391CE	|
	CLC					;$0391CF	|
	ADC.b #$0A				;$0391D0	|
	TAX					;$0391D2	|
CODE_0391D3:
	LDA $02
	BNE CODE_0391DC				;$0391D5	|
	TXA					;$0391D7	|
	CLC					;$0391D8	|
	ADC.b #$14				;$0391D9	|
	TAX					;$0391DB	|
CODE_0391DC:
	LDA $00
	CLC					;$0391DE	|
	ADC.w FishinBooDispX,X			;$0391DF	|
	STA.w $0300,Y				;$0391E2	|
	PLX					;$0391E5	|
	INY					;$0391E6	|
	INY					;$0391E7	|
	INY					;$0391E8	|
	INY					;$0391E9	|
	DEX					;$0391EA	|
	BPL CODE_039191				;$0391EB	|
	LDA $14					;$0391ED	|
	LSR					;$0391EF	|
	LSR					;$0391F0	|
	LSR					;$0391F1	|
	AND.b #$03				;$0391F2	|
	TAX					;$0391F4	|
	PLY					;$0391F5	|
	LDA.w DATA_03917C,X			;$0391F6	|
	EOR.w $0313,Y				;$0391F9	|
	STA.w $0313,Y				;$0391FC	|
	STA.w $0327,Y				;$0391FF	|
	EOR.b #$C0				;$039202	|
	STA.w $0317,Y				;$039204	|
	STA.w $0323,Y				;$039207	|
	PLX					;$03920A	|
	LDY.b #$02				;$03920B	|
	LDA.b #$09				;$03920D	|
	JSL FinishOAMWrite			;$03920F	|
	RTS					;$039213	|

FallingSpike:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$039218	|
	LDA.b #$E0				;$03921B	|
	STA.w $0302,Y				;$03921D	|
	LDA.w $0301,Y				;$039220	|
	DEC A					;$039223	|
	STA.w $0301,Y				;$039224	|
	LDA.w $1540,X				;$039227	|
	BEQ CODE_039237				;$03922A	|
	LSR					;$03922C	|
	LSR					;$03922D	|
	AND.b #$01				;$03922E	|
	CLC					;$039230	|
	ADC.w $0300,Y				;$039231	|
	STA.w $0300,Y				;$039234	|
CODE_039237:
	LDA $9D
	BNE CODE_03926C				;$039239	|
	JSR SubOffscreen0Bnk3			;$03923B	|
	JSL UpdateSpritePos			;$03923E	|
	LDA $C2,X				;$039242	|
	JSL execute_pointer			;$039244	|

FallingSpikePtrs:
	dw CODE_03924C
	dw CODE_039262

CODE_03924C:
	STZ $AA,X
	JSR SubHorzPosBnk3			;$03924E	|
	LDA $0F					;$039251	|
	CLC					;$039253	|
	ADC.b #$40				;$039254	|
	CMP.b #$80				;$039256	|
	BCS Return039261			;$039258	|
	INC $C2,X				;$03925A	|
	LDA.b #$40				;$03925C	|
	STA.w $1540,X				;$03925E	|
Return039261:
	RTS

CODE_039262:
	LDA.w $1540,X
	BNE CODE_03926C				;$039265	|
	JSL MarioSprInteract			;$039267	|
	RTS					;$03926B	|

CODE_03926C:
	STZ $AA,X
	RTS					;$03926E	|

CrtEatBlkSpeedX:
	db $10,$F0,$00,$00,$00

CrtEatBlkSpeedY:
	db $00,$00,$10,$F0,$00

DATA_039279:
	db $00,$00,$01,$00,$02,$00,$00,$00
	db $03,$00,$00

CreateEatBlock:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$039288	|
	LDA.w $0301,Y				;$03928B	|
	DEC A					;$03928E	|
	STA.w $0301,Y				;$03928F	|
	LDA.b #$2E				;$039292	|
	STA.w $0302,Y				;$039294	|
	LDA.w $0303,Y				;$039297	|
	AND.b #$3F				;$03929A	|
	STA.w $0303,Y				;$03929C	|
	LDY.b #$02				;$03929F	|
	LDA.b #$00				;$0392A1	|
	JSL FinishOAMWrite			;$0392A3	|
	LDY.b #$04				;$0392A7	|
	LDA.w $1909				;$0392A9	|
	CMP.b #$FF				;$0392AC	|
	BEQ CODE_0392C0				;$0392AE	|
	LDA $13					;$0392B0	|
	AND.b #$03				;$0392B2	|
	ORA $9D					;$0392B4	|
	BNE CODE_0392BD				;$0392B6	|
	LDA.b #$04				;$0392B8	|
	STA.w $1DFA				;$0392BA	|
CODE_0392BD:
	LDY.w $157C,X
CODE_0392C0:
	LDA $9D
	BNE Return03932B			;$0392C2	|
	LDA.w CrtEatBlkSpeedX,Y			;$0392C4	|
	STA $B6,X				;$0392C7	|
	LDA.w CrtEatBlkSpeedY,Y			;$0392C9	|
	STA $AA,X				;$0392CC	|
	JSL UpdateYPosNoGrvty			;$0392CE	|
	JSL UpdateXPosNoGrvty			;$0392D2	|
	STZ.w $1528,X				;$0392D6	|
	JSL InvisBlkMainRt			;$0392D9	|
	LDA.w $1909				;$0392DD	|
	CMP.b #$FF				;$0392E0	|
	BEQ Return03932B			;$0392E2	|
	LDA $D8,X				;$0392E4	|
	ORA $E4,X				;$0392E6	|
	AND.b #$0F				;$0392E8	|
	BNE Return03932B			;$0392EA	|
	LDA.w $151C,X				;$0392EC	|
	BNE CODE_03932C				;$0392EF	|
	DEC.w $1570,X				;$0392F1	|
	BMI CODE_0392F8				;$0392F4	|
	BNE CODE_03931F				;$0392F6	|
CODE_0392F8:
	LDY.w $0DB3
	LDA.w $1F11,Y				;$0392FB	|
	CMP.b #$01				;$0392FE	|
	LDY.w $1534,X				;$039300	|
	INC.w $1534,X				;$039303	|
	LDA.w CrtEatBlkData1,Y			;$039306	|
	BCS CODE_03930E				;$039309	|
	LDA.w CrtEatBlkData2,Y			;$03930B	|
CODE_03930E:
	STA.w $1602,X
	PHA					;$039311	|
	LSR					;$039312	|
	LSR					;$039313	|
	LSR					;$039314	|
	LSR					;$039315	|
	STA.w $1570,X				;$039316	|
	PLA					;$039319	|
	AND.b #$03				;$03931A	|
	STA.w $157C,X				;$03931C	|
CODE_03931F:
	LDA.b #$0D
	JSR GenTileFromSpr1			;$039321	|
	LDA.w $1602,X				;$039324	|
	CMP.b #$FF				;$039327	|
	BEQ CODE_039387				;$039329	|
Return03932B:
	RTS

CODE_03932C:
	LDA.b #$02
	JSR GenTileFromSpr1			;$03932E	|
	LDA.b #$01				;$039331	|
	STA $B6,X				;$039333	|
	STA $AA,X				;$039335	|
	JSL CODE_019138				;$039337	|
	LDA.w $1588,X				;$03933B	|
	PHA					;$03933E	|
	LDA.b #$FF				;$03933F	|
	STA $B6,X				;$039341	|
	STA $AA,X				;$039343	|
	LDA $E4,X				;$039345	|
	PHA					;$039347	|
	SEC					;$039348	|
	SBC.b #$01				;$039349	|
	STA $E4,X				;$03934B	|
	LDA.w $14E0,X				;$03934D	|
	PHA					;$039350	|
	SBC.b #$00				;$039351	|
	STA.w $14E0,X				;$039353	|
	LDA $D8,X				;$039356	|
	PHA					;$039358	|
	SEC					;$039359	|
	SBC.b #$01				;$03935A	|
	STA $D8,X				;$03935C	|
	LDA.w $14D4,X				;$03935E	|
	PHA					;$039361	|
	SBC.b #$00				;$039362	|
	STA.w $14D4,X				;$039364	|
	JSL CODE_019138				;$039367	|
	PLA					;$03936B	|
	STA.w $14D4,X				;$03936C	|
	PLA					;$03936F	|
	STA $D8,X				;$039370	|
	PLA					;$039372	|
	STA.w $14E0,X				;$039373	|
	PLA					;$039376	|
	STA $E4,X				;$039377	|
	PLA					;$039379	|
	ORA.w $1588,X				;$03937A	|
	BEQ CODE_039387				;$03937D	|
	TAY					;$03937F	|
	LDA.w DATA_039279,Y			;$039380	|
	STA.w $157C,X				;$039383	|
	RTS					;$039386	|

CODE_039387:
	STZ.w $14C8,X
	RTS					;$03938A	|

GenTileFromSpr1:
	STA $9C
	LDA $E4,X				;$03938D	|
	STA $9A					;$03938F	|
	LDA.w $14E0,X				;$039391	|
	STA $9B					;$039394	|
	LDA $D8,X				;$039396	|
	STA $98					;$039398	|
	LDA.w $14D4,X				;$03939A	|
	STA $99					;$03939D	|
	JSL generate_tile			;$03939F	|
	RTS					;$0393A3	|

CrtEatBlkData1:
	db $10,$13,$10,$13,$10,$13,$10,$13
	db $10,$13,$10,$13,$10,$13,$10,$13
	db $F0,$F0,$20,$12,$10,$12,$10,$12
	db $10,$12,$10,$12,$10,$12,$10,$12
	db $D0,$C3,$F1,$21,$22,$F1,$F1,$51
	db $43,$10,$13,$10,$13,$10,$13,$F0
	db $F0,$F0,$60,$32,$60,$32,$71,$32
	db $60,$32,$61,$32,$70,$33,$10,$33
	db $10,$33,$10,$33,$10,$33,$F0,$10
	db $F2,$52,$FF

CrtEatBlkData2:
	db $80,$13,$10,$13,$10,$13,$10,$13
	db $60,$23,$20,$23,$B0,$22,$A1,$22
	db $A0,$22,$A1,$22,$C0,$13,$10,$13
	db $10,$13,$10,$13,$10,$13,$10,$13
	db $10,$13,$F0,$F0,$F0,$52,$50,$33
	db $50,$32,$50,$33,$50,$22,$50,$33
	db $F0,$50,$82,$FF

WoodenSpike:
	JSR WoodSpikeGfx
	LDA $9D					;$039426	|
	BNE Return039440			;$039428	|
	JSR SubOffscreen0Bnk3			;$03942A	|
	JSR CODE_039488				;$03942D	|
	LDA $C2,X				;$039430	|
	AND.b #$03				;$039432	|
	JSL execute_pointer			;$039434	|

WoodenSpikePtrs:
	dw CODE_039458
	dw CODE_03944E
	dw CODE_039441
	dw CODE_03946B

Return039440:
	RTS

CODE_039441:
	LDA.w $1540,X
	BEQ CODE_03944A				;$039444	|
	LDA.b #$20				;$039446	|
	BRA CODE_039475				;$039448	|

CODE_03944A:
	LDA.b #$30
	BRA SetTimerNextState			;$03944C	|

CODE_03944E:
	LDA.w $1540,X
	BNE Return039457			;$039451	|
	LDA.b #$18				;$039453	|
	BRA SetTimerNextState			;$039455	|

Return039457:
	RTS

CODE_039458:
	LDA.w $1540,X
	BEQ CODE_039463				;$03945B	|
	LDA.b #$F0				;$03945D	|
	JSR CODE_039475				;$03945F	|
	RTS					;$039462	|

CODE_039463:
	LDA.b #$30
SetTimerNextState:
	STA.w $1540,X
	INC $C2,X				;$039468	|
	RTS					;$03946A	|

CODE_03946B:
	LDA.w $1540,X
	BNE Return039474			;$03946E	|
	LDA.b #$2F				;$039470	|
	BRA SetTimerNextState			;$039472	|

Return039474:
	RTS

CODE_039475:
	LDY.w $151C,X
	BEQ CODE_03947D				;$039478	|
	EOR.b #$FF				;$03947A	|
	INC A					;$03947C	|
CODE_03947D:
	STA $AA,X
	JSL UpdateYPosNoGrvty			;$03947F	|
	RTS					;$039483	|

DATA_039484:
	db $01,$FF

DATA_039486:
	db $00,$FF

CODE_039488:
	JSL MarioSprInteract
	BCC Return0394B0			;$03948C	|
	JSR SubHorzPosBnk3			;$03948E	|
	LDA $0F					;$039491	|
	CLC					;$039493	|
	ADC.b #$04				;$039494	|
	CMP.b #$08				;$039496	|
	BCS CODE_03949F				;$039498	|
	JSL HurtMario				;$03949A	|
	RTS					;$03949E	|

CODE_03949F:
	LDA $94
	CLC					;$0394A1	|
	ADC.w DATA_039484,Y			;$0394A2	|
	STA $94					;$0394A5	|
	LDA $95					;$0394A7	|
	ADC.w DATA_039486,Y			;$0394A9	|
	STA $95					;$0394AC	|
	STZ $7B					;$0394AE	|
Return0394B0:
	RTS

WoodSpikeDispY:
	db $00,$10,$20,$30,$40,$40,$30,$20
	db $10,$00

WoodSpikeTiles:
	db $6A,$6A,$6A,$6A,$4A,$6A,$6A,$6A
	db $6A,$4A

WoodSpikeGfxProp:
	db $81,$81,$81,$81,$81,$01,$01,$01
	db $01,$01

WoodSpikeGfx:
	JSR GetDrawInfoBnk3
	STZ $02					;$0394D2	|
	LDA $9E,X				;$0394D4	|
	CMP.b #$AD				;$0394D6	|
	BNE CODE_0394DE				;$0394D8	|
	LDA.b #$05				;$0394DA	|
	STA $02					;$0394DC	|
CODE_0394DE:
	PHX
	LDX.b #$04				;$0394DF	|
WoodSpikeGfxLoopSt:
	PHX
	TXA					;$0394E2	|
	CLC					;$0394E3	|
	ADC $02					;$0394E4	|
	TAX					;$0394E6	|
	LDA $00					;$0394E7	|
	STA.w $0300,Y				;$0394E9	|
	LDA $01					;$0394EC	|
	CLC					;$0394EE	|
	ADC.w WoodSpikeDispY,X			;$0394EF	|
	STA.w $0301,Y				;$0394F2	|
	LDA.w WoodSpikeTiles,X			;$0394F5	|
	STA.w $0302,Y				;$0394F8	|
	LDA.w WoodSpikeGfxProp,X		;$0394FB	|
	STA.w $0303,Y				;$0394FE	|
	INY					;$039501	|
	INY					;$039502	|
	INY					;$039503	|
	INY					;$039504	|
	PLX					;$039505	|
	DEX					;$039506	|
	BPL WoodSpikeGfxLoopSt			;$039507	|
	PLX					;$039509	|
	LDY.b #$02				;$03950A	|
	LDA.b #$04				;$03950C	|
	JSL FinishOAMWrite			;$03950E	|
	RTS					;$039512	|

RexSpeed:
	db $08,$F8,$10,$F0

RexMainRt:
	JSR RexGfxRt
	LDA.w $14C8,X				;$03951A	|
	CMP.b #$08				;$03951D	|
	BNE RexReturn				;$03951F	|
	LDA $9D					;$039521	|
	BNE RexReturn				;$039523	|
	LDA.w $1558,X				;$039525	|
	BEQ RexAlive				;$039528	|
	STA.w $15D0,X				;$03952A	|
	DEC A					;$03952D	|
	BNE RexReturn				;$03952E	|
	STZ.w $14C8,X				;$039530	|
RexReturn:
	RTS

RexAlive:
	JSR SubOffscreen0Bnk3
	INC.w $1570,X				;$039537	|
	LDA.w $1570,X				;$03953A	|
	LSR					;$03953D	|
	LSR					;$03953E	|
	LDY $C2,X				;$03953F	|
	BEQ CODE_03954A				;$039541	|
	AND.b #$01				;$039543	|
	CLC					;$039545	|
	ADC.b #$03				;$039546	|
	BRA CODE_03954D				;$039548	|

CODE_03954A:
	LSR
	AND.b #$01				;$03954B	|
CODE_03954D:
	STA.w $1602,X
	LDA.w $1588,X				;$039550	|
	AND.b #$04				;$039553	|
	BEQ RexInAir				;$039555	|
	LDA.b #$10				;$039557	|
	STA $AA,X				;$039559	|
	LDY.w $157C,X				;$03955B	|
	LDA $C2,X				;$03955E	|
	BEQ RexNoAdjustSpeed			;$039560	|
	INY					;$039562	|
	INY					;$039563	|
RexNoAdjustSpeed:
	LDA.w RexSpeed,Y
	STA $B6,X				;$039567	|
RexInAir:
	LDA.w $1FE2,X
	BNE RexHalfSmushed			;$03956C	|
	JSL UpdateSpritePos			;$03956E	|
RexHalfSmushed:
	LDA.w $1588,X
	AND.b #$03				;$039575	|
	BEQ CODE_039581				;$039577	|
	LDA.w $157C,X				;$039579	|
	EOR.b #$01				;$03957C	|
	STA.w $157C,X				;$03957E	|
CODE_039581:
	JSL SprSprInteract
	JSL MarioSprInteract			;$039585	|
	BCC NoRexContact			;$039589	|
	LDA.w $1490				;$03958B	|
	BNE RexStarKill				;$03958E	|
	LDA.w $154C,X				;$039590	|
	BNE NoRexContact			;$039593	|
	LDA.b #$08				;$039595	|
	STA.w $154C,X				;$039597	|
	LDA $7D					;$03959A	|
	CMP.b #$10				;$03959C	|
	BMI RexWins				;$03959E	|
MarioBeatsRex:
	JSR RexPoints
	JSL BoostMarioSpeed			;$0395A3	|
	JSL DisplayContactGfx			;$0395A7	|
	LDA.w $140D				;$0395AB	|
	ORA.w $187A				;$0395AE	|
	BNE RexSpinKill				;$0395B1	|
	INC $C2,X				;$0395B3	|
	LDA $C2,X				;$0395B5	|
	CMP.b #$02				;$0395B7	|
	BNE SmushRex				;$0395B9	|
	LDA.b #$20				;$0395BB	|
	STA.w $1558,X				;$0395BD	|
	RTS					;$0395C0	|

SmushRex:
	LDA.b #$0C
	STA.w $1FE2,X				;$0395C3	|
	STZ.w $1662,X				;$0395C6	|
	RTS					;$0395C9	|

RexWins:
	LDA.w $1497
	ORA.w $187A				;$0395CD	|
	BNE NoRexContact			;$0395D0	|
	JSR SubHorzPosBnk3			;$0395D2	|
	TYA					;$0395D5	|
	STA.w $157C,X				;$0395D6	|
	JSL HurtMario				;$0395D9	|
NoRexContact:
	RTS

RexSpinKill:
	LDA.b #$04
	STA.w $14C8,X				;$0395E0	|
	LDA.b #$1F				;$0395E3	|
	STA.w $1540,X				;$0395E5	|
	JSL CODE_07FC3B				;$0395E8	|
	LDA.b #$08				;$0395EC	|
	STA.w $1DF9				;$0395EE	|
	RTS					;$0395F1	|

RexStarKill:
	LDA.b #$02
	STA.w $14C8,X				;$0395F4	|
	LDA.b #$D0				;$0395F7	|
	STA $AA,X				;$0395F9	|
	JSR SubHorzPosBnk3			;$0395FB	|
	LDA.w RexKilledSpeed,Y			;$0395FE	|
	STA $B6,X				;$039601	|
	INC.w $18D2				;$039603	|
	LDA.w $18D2				;$039606	|
	CMP.b #$08				;$039609	|
	BCC ADDR_039612				;$03960B	|
	LDA.b #$08				;$03960D	|
	STA.w $18D2				;$03960F	|
ADDR_039612:
	JSL GivePoints
	LDY.w $18D2				;$039616	|
	CPY.b #$08				;$039619	|
	BCS Return039623			;$03961B	|
	LDA.w $7FFF,Y				;$03961D	|
	STA.w $1DF9				;$039620	|
Return039623:
	RTS

	RTS					;$039624	|

RexKilledSpeed:
	db $F0,$10

	RTS					;$039627	|

RexPoints:
	PHY
	LDA.w $1697				;$039629	|
	CLC					;$03962C	|
	ADC.w $1626,X				;$03962D	|
	INC.w $1697				;$039630	|
	TAY					;$039633	|
	INY					;$039634	|
	CPY.b #$08				;$039635	|
	BCS CODE_03963F				;$039637	|
	LDA.w $7FFF,Y				;$039639	|
	STA.w $1DF9				;$03963C	|
CODE_03963F:
	TYA
	CMP.b #$08				;$039640	|
	BCC CODE_039646				;$039642	|
	LDA.b #$08				;$039644	|
CODE_039646:
	JSL GivePoints
	PLY					;$03964A	|
	RTS					;$03964B	|

RexTileDispX:
	db $FC,$00,$FC,$00,$FE,$00,$00,$00
	db $00,$00,$00,$08,$04,$00,$04,$00
	db $02,$00,$00,$00,$00,$00,$08,$00
RexTileDispY:
	db $F1,$00,$F0,$00,$F8,$00,$00,$00
	db $00,$00,$08,$08

RexTiles:
	db $8A,$AA,$8A,$AC,$8A,$AA,$8C,$8C
	db $A8,$A8,$A2,$B2

RexGfxProp:
	db $47,$07

RexGfxRt:
	LDA.w $1558,X
	BEQ RexGfxAlive				;$039681	|
	LDA.b #$05				;$039683	|
	STA.w $1602,X				;$039685	|
RexGfxAlive:
	LDA.w $1FE2,X
	BEQ RexNotHalfSmushed			;$03968B	|
	LDA.b #$02				;$03968D	|
	STA.w $1602,X				;$03968F	|
RexNotHalfSmushed:
	JSR GetDrawInfoBnk3
	LDA.w $1602,X				;$039695	|
	ASL					;$039698	|
	STA $03					;$039699	|
	LDA.w $157C,X				;$03969B	|
	STA $02					;$03969E	|
	PHX					;$0396A0	|
	LDX.b #$01				;$0396A1	|
RexGfxLoopStart:
	PHX
	TXA					;$0396A4	|
	ORA $03					;$0396A5	|
	PHA					;$0396A7	|
	LDX $02					;$0396A8	|
	BNE RexFaceLeft				;$0396AA	|
	CLC					;$0396AC	|
	ADC.b #$0C				;$0396AD	|
RexFaceLeft:
	TAX
	LDA $00					;$0396B0	|
	CLC					;$0396B2	|
	ADC.w RexTileDispX,X			;$0396B3	|
	STA.w $0300,Y				;$0396B6	|
	PLX					;$0396B9	|
	LDA $01					;$0396BA	|
	CLC					;$0396BC	|
	ADC.w RexTileDispY,X			;$0396BD	|
	STA.w $0301,Y				;$0396C0	|
	LDA.w RexTiles,X			;$0396C3	|
	STA.w $0302,Y				;$0396C6	|
	LDX $02					;$0396C9	|
	LDA.w RexGfxProp,X			;$0396CB	|
	ORA $64					;$0396CE	|
	STA.w $0303,Y				;$0396D0	|
	TYA					;$0396D3	|
	LSR					;$0396D4	|
	LSR					;$0396D5	|
	LDX $03					;$0396D6	|
	CPX.b #$0A				;$0396D8	|
	TAX					;$0396DA	|
	LDA.b #$00				;$0396DB	|
	BCS Rex8x8Tile				;$0396DD	|
	LDA.b #$02				;$0396DF	|
Rex8x8Tile:
	STA.w $0460,X
	PLX					;$0396E4	|
	INY					;$0396E5	|
	INY					;$0396E6	|
	INY					;$0396E7	|
	INY					;$0396E8	|
	DEX					;$0396E9	|
	BPL RexGfxLoopStart			;$0396EA	|
	PLX					;$0396EC	|
	LDY.b #$FF				;$0396ED	|
	LDA.b #$01				;$0396EF	|
	JSL FinishOAMWrite			;$0396F1	|
	RTS					;$0396F5	|

Fishbone:
	JSR FishboneGfx
	LDA $9D					;$0396F9	|
	BNE Return03972A			;$0396FB	|
	JSR SubOffscreen0Bnk3			;$0396FD	|
	JSL MarioSprInteract			;$039700	|
	JSL UpdateXPosNoGrvty			;$039704	|
	TXA					;$039708	|
	ASL					;$039709	|
	ASL					;$03970A	|
	ASL					;$03970B	|
	ASL					;$03970C	|
	ADC $13					;$03970D	|
	AND.b #$7F				;$03970F	|
	BNE CODE_039720				;$039711	|
	JSL GetRand				;$039713	|
	AND.b #$01				;$039717	|
	BNE CODE_039720				;$039719	|
	LDA.b #$0C				;$03971B	|
	STA.w $1558,X				;$03971D	|
CODE_039720:
	LDA $C2,X
	JSL execute_pointer			;$039722	|

FishbonePtrs:
	dw CODE_03972F
	dw CODE_03975E

Return03972A:
	RTS

FishboneMaxSpeed:
	db $10,$F0

FishboneAcceler:
	db $01,$FF

CODE_03972F:
	INC.w $1570,X
	LDA.w $1570,X				;$039732	|
	NOP					;$039735	|
	LSR					;$039736	|
	AND.b #$01				;$039737	|
	STA.w $1602,X				;$039739	|
	LDA.w $1540,X				;$03973C	|
	BEQ CODE_039756				;$03973F	|
	AND.b #$01				;$039741	|
	BNE Return039755			;$039743	|
	LDY.w $157C,X				;$039745	|
	LDA $B6,X				;$039748	|
	CMP.w FishboneMaxSpeed,Y		;$03974A	|
	BEQ Return039755			;$03974D	|
	CLC					;$03974F	|
	ADC.w FishboneAcceler,Y			;$039750	|
	STA $B6,X				;$039753	|
Return039755:
	RTS

CODE_039756:
	INC $C2,X
	LDA.b #$30				;$039758	|
	STA.w $1540,X				;$03975A	|
	RTS					;$03975D	|

CODE_03975E:
	STZ.w $1602,X
	LDA.w $1540,X				;$039761	|
	BEQ CODE_039776				;$039764	|
	AND.b #$03				;$039766	|
	BNE Return039775			;$039768	|
	LDA $B6,X				;$03976A	|
	BEQ Return039775			;$03976C	|
	BPL CODE_039773				;$03976E	|
	INC $B6,X				;$039770	|
	RTS					;$039772	|

CODE_039773:
	DEC $B6,X
Return039775:
	RTS

CODE_039776:
	STZ $C2,X
	LDA.b #$30				;$039778	|
	STA.w $1540,X				;$03977A	|
	RTS					;$03977D	|

FishboneDispX:
	db $F8,$F8,$10,$10

FishboneDispY:
	db $00,$08

FishboneGfxProp:
	db $4D,$CD,$0D,$8D

FishboneTailTiles:
	db $A3,$A3,$B3,$B3

FishboneGfx:
	JSL GenericSprGfxRt2
	LDY.w $15EA,X				;$039790	|
	LDA.w $1558,X				;$039793	|
	CMP.b #$01				;$039796	|
	LDA.b #$A6				;$039798	|
	BCC CODE_03979E				;$03979A	|
	LDA.b #$A8				;$03979C	|
CODE_03979E:
	STA.w $0302,Y
	JSR GetDrawInfoBnk3			;$0397A1	|
	LDA.w $157C,X				;$0397A4	|
	ASL					;$0397A7	|
	STA $02					;$0397A8	|
	LDA.w $1602,X				;$0397AA	|
	ASL					;$0397AD	|
	STA $03					;$0397AE	|
	LDA.w $15EA,X				;$0397B0	|
	CLC					;$0397B3	|
	ADC.b #$04				;$0397B4	|
	STA.w $15EA,X				;$0397B6	|
	TAY					;$0397B9	|
	PHX					;$0397BA	|
	LDX.b #$01				;$0397BB	|
CODE_0397BD:
	LDA $01
	CLC					;$0397BF	|
	ADC.w FishboneDispY,X			;$0397C0	|
	STA.w $0301,Y				;$0397C3	|
	PHX					;$0397C6	|
	TXA					;$0397C7	|
	ORA $02					;$0397C8	|
	TAX					;$0397CA	|
	LDA $00					;$0397CB	|
	CLC					;$0397CD	|
	ADC.w FishboneDispX,X			;$0397CE	|
	STA.w $0300,Y				;$0397D1	|
	LDA.w FishboneGfxProp,X			;$0397D4	|
	ORA $64					;$0397D7	|
	STA.w $0303,Y				;$0397D9	|
	PLA					;$0397DC	|
	PHA					;$0397DD	|
	ORA $03					;$0397DE	|
	TAX					;$0397E0	|
	LDA.w FishboneTailTiles,X		;$0397E1	|
	STA.w $0302,Y				;$0397E4	|
	PLX					;$0397E7	|
	INY					;$0397E8	|
	INY					;$0397E9	|
	INY					;$0397EA	|
	INY					;$0397EB	|
	DEX					;$0397EC	|
	BPL CODE_0397BD				;$0397ED	|
	PLX					;$0397EF	|
	LDY.b #$00				;$0397F0	|
	LDA.b #$02				;$0397F2	|
	JSL FinishOAMWrite			;$0397F4	|
	RTS					;$0397F8	|

CODE_0397F9:
	STA $01
	PHX					;$0397FB	|
	PHY					;$0397FC	|
	JSR SubVertPosBnk3			;$0397FD	|
	STY $02					;$039800	|
	LDA $0E					;$039802	|
	BPL CODE_03980B				;$039804	|
	EOR.b #$FF				;$039806	|
	CLC					;$039808	|
	ADC.b #$01				;$039809	|
CODE_03980B:
	STA $0C
	JSR SubHorzPosBnk3			;$03980D	|
	STY $03					;$039810	|
	LDA $0F					;$039812	|
	BPL CODE_03981B				;$039814	|
	EOR.b #$FF				;$039816	|
	CLC					;$039818	|
	ADC.b #$01				;$039819	|
CODE_03981B:
	STA $0D
	LDY.b #$00				;$03981D	|
	LDA $0D					;$03981F	|
	CMP $0C					;$039821	|
	BCS CODE_03982E				;$039823	|
	INY					;$039825	|
	PHA					;$039826	|
	LDA $0C					;$039827	|
	STA $0D					;$039829	|
	PLA					;$03982B	|
	STA $0C					;$03982C	|
CODE_03982E:
	LDA.b #$00
	STA $0B					;$039830	|
	STA $00					;$039832	|
	LDX $01					;$039834	|
CODE_039836:
	LDA $0B
	CLC					;$039838	|
	ADC $0C					;$039839	|
	CMP $0D					;$03983B	|
	BCC CODE_039843				;$03983D	|
	SBC $0D					;$03983F	|
	INC $00					;$039841	|
CODE_039843:
	STA $0B
	DEX					;$039845	|
	BNE CODE_039836				;$039846	|
	TYA					;$039848	|
	BEQ CODE_039855				;$039849	|
	LDA $00					;$03984B	|
	PHA					;$03984D	|
	LDA $01					;$03984E	|
	STA $00					;$039850	|
	PLA					;$039852	|
	STA $01					;$039853	|
CODE_039855:
	LDA $00
	LDY $02					;$039857	|
	BEQ CODE_039862				;$039859	|
	EOR.b #$FF				;$03985B	|
	CLC					;$03985D	|
	ADC.b #$01				;$03985E	|
	STA $00					;$039860	|
CODE_039862:
	LDA $01
	LDY $03					;$039864	|
	BEQ CODE_03986F				;$039866	|
	EOR.b #$FF				;$039868	|
	CLC					;$03986A	|
	ADC.b #$01				;$03986B	|
	STA $01					;$03986D	|
CODE_03986F:
	PLY
	PLX					;$039870	|
	RTS					;$039871	|

ReznorInit:
	CPX.b #$07
	BNE CODE_03987E				;$039874	|
	LDA.b #$04				;$039876	|
	STA $C2,X				;$039878	|
	JSL CODE_03DD7D				;$03987A	|
CODE_03987E:
	JSL GetRand
	STA.w $1570,X				;$039882	|
	RTL					;$039885	|

ReznorStartPosLo:
	db $00,$80,$00,$80

ReznorStartPosHi:
	db $00,$00,$01,$01

ReboundSpeedX:
	db $20,$E0

Reznor:
	INC.w $140F
	LDA $9D					;$039893	|
	BEQ ReznorNotLocked			;$039895	|
	JMP DrawReznor				;$039897	|

ReznorNotLocked:
	CPX.b #$07
	BNE CODE_039910				;$03989C	|
	PHX					;$03989E	|
	JSL CODE_03D70C				;$03989F	|
ReznorSignCode:
	LDA.b #$80
	STA $2A					;$0398A5	|
	STZ $2B					;$0398A7	|
	LDX.b #$00				;$0398A9	|
	LDA.b #$C0				;$0398AB	|
	STA $E4					;$0398AD	|
	STZ.w $14E0				;$0398AF	|
	LDA.b #$B2				;$0398B2	|
	STA $D8					;$0398B4	|
	STZ.w $14D4				;$0398B6	|
	LDA.b #$2C				;$0398B9	|
	STA.w $1BA2				;$0398BB	|
	JSL CODE_03DEDF				;$0398BE	|
	PLX					;$0398C2	|
	REP #$20				;$0398C3	|
	LDA $36					;$0398C5	|
	CLC					;$0398C7	|
	ADC.w #$0001				;$0398C8	|
	AND.w #$01FF				;$0398CB	|
	STA $36					;$0398CE	|
	SEP #$20				;$0398D0	|
	CPX.b #$07				;$0398D2	|
	BNE CODE_039910				;$0398D4	|
	LDA.w $163E,X				;$0398D6	|
	BEQ ReznorNoLevelEnd			;$0398D9	|
	DEC A					;$0398DB	|
	BNE CODE_039910				;$0398DC	|
	DEC.w $13C6				;$0398DE	|
	LDA.b #$FF				;$0398E1	|
	STA.w $1493				;$0398E3	|
	LDA.b #$0B				;$0398E6	|
	STA.w $1DFB				;$0398E8	|
	RTS					;$0398EB	|

ReznorNoLevelEnd:
	LDA.w $1523
	CLC					;$0398EF	|
	ADC.w $1522				;$0398F0	|
	ADC.w $1521				;$0398F3	|
	ADC.w $1520				;$0398F6	|
	CMP.b #$04				;$0398F9	|
	BNE CODE_039910				;$0398FB	|
	LDA.b #$90				;$0398FD	|
	STA.w $163E,X				;$0398FF	|
	JSL KillMostSprites			;$039902	|
	LDY.b #$07				;$039906	|
	LDA.b #$00				;$039908	|
CODE_03990A:
	STA.w $170B,Y
	DEY					;$03990D	|
	BPL CODE_03990A				;$03990E	|
CODE_039910:
	LDA.w $14C8,X
	CMP.b #$08				;$039913	|
	BEQ CODE_03991A				;$039915	|
	JMP DrawReznor				;$039917	|

CODE_03991A:
	TXA
	AND.b #$03				;$03991B	|
	TAY					;$03991D	|
	LDA $36					;$03991E	|
	CLC					;$039920	|
	ADC.w ReznorStartPosLo,Y		;$039921	|
	STA $00					;$039924	|
	LDA $37					;$039926	|
	ADC.w ReznorStartPosHi,Y		;$039928	|
	AND.b #$01				;$03992B	|
	STA $01					;$03992D	|
	REP #$30				;$03992F	|
	LDA $00					;$039931	|
	EOR.w #$01FF				;$039933	|
	INC A					;$039936	|
	STA $00					;$039937	|
	CLC					;$039939	|
	ADC.w #$0080				;$03993A	|
	AND.w #$01FF				;$03993D	|
	STA $02					;$039940	|
	LDA $00					;$039942	|
	AND.w #$00FF				;$039944	|
	ASL					;$039947	|
	TAX					;$039948	|
	LDA.l CircleCoords,X			;$039949	|
	STA $04					;$03994D	|
	LDA $02					;$03994F	|
	AND.w #$00FF				;$039951	|
	ASL					;$039954	|
	TAX					;$039955	|
	LDA.l CircleCoords,X			;$039956	|
	STA $06					;$03995A	|
	SEP #$30				;$03995C	|
	LDA $04					;$03995E	|
	STA.w $4202				;$039960	|
	LDA.b #$38				;$039963	|
	LDY $05					;$039965	|
	BNE CODE_039978				;$039967	|
	STA.w $4203				;$039969	|
	NOP					;$03996C	|
	NOP					;$03996D	|
	NOP					;$03996E	|
	NOP					;$03996F	|
	ASL.w $4216				;$039970	|
	LDA.w $4217				;$039973	|
	ADC.b #$00				;$039976	|
CODE_039978:
	LSR $01
	BCC CODE_03997F				;$03997A	|
	EOR.b #$FF				;$03997C	|
	INC A					;$03997E	|
CODE_03997F:
	STA $04
	LDA $06					;$039981	|
	STA.w $4202				;$039983	|
	LDA.b #$38				;$039986	|
	LDY $07					;$039988	|
	BNE CODE_03999B				;$03998A	|
	STA.w $4203				;$03998C	|
	NOP					;$03998F	|
	NOP					;$039990	|
	NOP					;$039991	|
	NOP					;$039992	|
	ASL.w $4216				;$039993	|
	LDA.w $4217				;$039996	|
	ADC.b #$00				;$039999	|
CODE_03999B:
	LSR $03
	BCC CODE_0399A2				;$03999D	|
	EOR.b #$FF				;$03999F	|
	INC A					;$0399A1	|
CODE_0399A2:
	STA $06
	LDX.w $15E9				;$0399A4	|
	LDA $E4,X				;$0399A7	|
	PHA					;$0399A9	|
	STZ $00					;$0399AA	|
	LDA $04					;$0399AC	|
	BPL CODE_0399B2				;$0399AE	|
	DEC $00					;$0399B0	|
CODE_0399B2:
	CLC
	ADC $2A					;$0399B3	|
	PHP					;$0399B5	|
	CLC					;$0399B6	|
	ADC.b #$40				;$0399B7	|
	STA $E4,X				;$0399B9	|
	LDA $2B					;$0399BB	|
	ADC.b #$00				;$0399BD	|
	PLP					;$0399BF	|
	ADC $00					;$0399C0	|
	STA.w $14E0,X				;$0399C2	|
	PLA					;$0399C5	|
	SEC					;$0399C6	|
	SBC $E4,X				;$0399C7	|
	EOR.b #$FF				;$0399C9	|
	INC A					;$0399CB	|
	STA.w $1528,X				;$0399CC	|
	STZ $01					;$0399CF	|
	LDA $06					;$0399D1	|
	BPL CODE_0399D7				;$0399D3	|
	DEC $01					;$0399D5	|
CODE_0399D7:
	CLC
	ADC $2C					;$0399D8	|
	PHP					;$0399DA	|
	ADC.b #$20				;$0399DB	|
	STA $D8,X				;$0399DD	|
	LDA $2D					;$0399DF	|
	ADC.b #$00				;$0399E1	|
	PLP					;$0399E3	|
	ADC $01					;$0399E4	|
	STA.w $14D4,X				;$0399E6	|
	LDA.w $151C,X				;$0399E9	|
	BEQ ReznorAlive				;$0399EC	|
	JSL InvisBlkMainRt			;$0399EE	|
	JMP DrawReznor				;$0399F2	|

ReznorAlive:
	LDA $13
	AND.b #$00				;$0399F7	|
	ORA.w $15AC,X				;$0399F9	|
	BNE NoSetRznrFireTime			;$0399FC	|
	INC.w $1570,X				;$0399FE	|
	LDA.w $1570,X				;$039A01	|
	CMP.b #$00				;$039A04	|
	BNE NoSetRznrFireTime			;$039A06	|
	STZ.w $1570,X				;$039A08	|
	LDA.b #$40				;$039A0B	|
	STA.w $1558,X				;$039A0D	|
NoSetRznrFireTime:
	TXA
	ASL					;$039A11	|
	ASL					;$039A12	|
	ASL					;$039A13	|
	ASL					;$039A14	|
	ADC $14					;$039A15	|
	AND.b #$3F				;$039A17	|
	ORA.w $1558,X				;$039A19	|
	ORA.w $15AC,X				;$039A1C	|
	BNE NoSetRenrTurnTime			;$039A1F	|
	LDA.w $157C,X				;$039A21	|
	PHA					;$039A24	|
	JSR SubHorzPosBnk3			;$039A25	|
	TYA					;$039A28	|
	STA.w $157C,X				;$039A29	|
	PLA					;$039A2C	|
	CMP.w $157C,X				;$039A2D	|
	BEQ NoSetRenrTurnTime			;$039A30	|
	LDA.b #$0A				;$039A32	|
	STA.w $15AC,X				;$039A34	|
NoSetRenrTurnTime:
	LDA.w $154C,X
	BNE DrawReznor				;$039A3A	|
	JSL MarioSprInteract			;$039A3C	|
	BCC DrawReznor				;$039A40	|
	LDA.b #$08				;$039A42	|
	STA.w $154C,X				;$039A44	|
	LDA $96					;$039A47	|
	SEC					;$039A49	|
	SBC $D8,X				;$039A4A	|
	CMP.b #$ED				;$039A4C	|
	BMI HitReznor				;$039A4E	|
	CMP.b #$F2				;$039A50	|
	BMI HitPlatSide				;$039A52	|
	LDA $7D					;$039A54	|
	BPL HitPlatSide				;$039A56	|
HitPlatBottom:
	LDA.b #$29
	STA.w $1662,X				;$039A5A	|
	LDA.b #$0F				;$039A5D	|
	STA.w $1564,X				;$039A5F	|
	LDA.b #$10				;$039A62	|
	STA $7D					;$039A64	|
	LDA.b #$01				;$039A66	|
	STA.w $1DF9				;$039A68	|
	BRA DrawReznor				;$039A6B	|

HitPlatSide:
	JSR SubHorzPosBnk3
	LDA.w ReboundSpeedX,Y			;$039A70	|
	STA $7B					;$039A73	|
	BRA DrawReznor				;$039A75	|

HitReznor:
	JSL HurtMario
DrawReznor:
	STZ.w $1602,X
	LDA.w $157C,X				;$039A7E	|
	PHA					;$039A81	|
	LDY.w $15AC,X				;$039A82	|
	BEQ ReznorNoTurning			;$039A85	|
	CPY.b #$05				;$039A87	|
	BCC ReznorTurning			;$039A89	|
	EOR.b #$01				;$039A8B	|
	STA.w $157C,X				;$039A8D	|
ReznorTurning:
	LDA.b #$02
	STA.w $1602,X				;$039A92	|
ReznorNoTurning:
	LDA.w $1558,X
	BEQ ReznorNoFiring			;$039A98	|
	CMP.b #$20				;$039A9A	|
	BNE ReznorFiring			;$039A9C	|
	JSR ReznorFireRt			;$039A9E	|
ReznorFiring:
	LDA.b #$01
	STA.w $1602,X				;$039AA3	|
ReznorNoFiring:
	JSR ReznorGfxRt
	PLA					;$039AA9	|
	STA.w $157C,X				;$039AAA	|
	LDA $9D					;$039AAD	|
	ORA.w $151C,X				;$039AAF	|
	BNE Return039AF7			;$039AB2	|
	LDA.w $1564,X				;$039AB4	|
	CMP.b #$0C				;$039AB7	|
	BNE Return039AF7			;$039AB9	|
KillReznor:
	LDA.b #$03
	STA.w $1DF9				;$039ABD	|
	STZ.w $1558,X				;$039AC0	|
	INC.w $151C,X				;$039AC3	|
	JSL FindFreeSprSlot			;$039AC6	|
	BMI Return039AF7			;$039ACA	|
	LDA.b #$02				;$039ACC	|
	STA.w $14C8,Y				;$039ACE	|
	LDA.b #$A9				;$039AD1	|
	STA.w $009E,y				;$039AD3	|
	LDA $E4,X				;$039AD6	|
	STA.w $00E4,y				;$039AD8	|
	LDA.w $14E0,X				;$039ADB	|
	STA.w $14E0,Y				;$039ADE	|
	LDA $D8,X				;$039AE1	|
	STA.w $00D8,y				;$039AE3	|
	LDA.w $14D4,X				;$039AE6	|
	STA.w $14D4,Y				;$039AE9	|
	PHX					;$039AEC	|
	TYX					;$039AED	|
	JSL InitSpriteTables			;$039AEE	|
	LDA.b #$C0				;$039AF2	|
	STA $AA,X				;$039AF4	|
	PLX					;$039AF6	|
Return039AF7:
	RTS

ReznorFireRt:
	LDY.b #$07
CODE_039AFA:
	LDA.w $170B,Y
	BEQ FoundRznrFireSlot			;$039AFD	|
	DEY					;$039AFF	|
	BPL CODE_039AFA				;$039B00	|
	RTS					;$039B02	|

FoundRznrFireSlot:
	LDA.b #$10
	STA.w $1DF9				;$039B05	|
	LDA.b #$02				;$039B08	|
	STA.w $170B,Y				;$039B0A	|
	LDA $E4,X				;$039B0D	|
	PHA					;$039B0F	|
	SEC					;$039B10	|
	SBC.b #$08				;$039B11	|
	STA.w $171F,Y				;$039B13	|
	STA $E4,X				;$039B16	|
	LDA.w $14E0,X				;$039B18	|
	SBC.b #$00				;$039B1B	|
	STA.w $1733,Y				;$039B1D	|
	LDA $D8,X				;$039B20	|
	PHA					;$039B22	|
	SEC					;$039B23	|
	SBC.b #$14				;$039B24	|
	STA $D8,X				;$039B26	|
	STA.w $1715,Y				;$039B28	|
	LDA.w $14D4,X				;$039B2B	|
	PHA					;$039B2E	|
	SBC.b #$00				;$039B2F	|
	STA.w $1729,Y				;$039B31	|
	STA.w $14D4,X				;$039B34	|
	LDA.b #$10				;$039B37	|
	JSR CODE_0397F9				;$039B39	|
	PLA					;$039B3C	|
	STA.w $14D4,X				;$039B3D	|
	PLA					;$039B40	|
	STA $D8,X				;$039B41	|
	PLA					;$039B43	|
	STA $E4,X				;$039B44	|
	LDA $00					;$039B46	|
	STA.w $173D,Y				;$039B48	|
	LDA $01					;$039B4B	|
	STA.w $1747,Y				;$039B4D	|
	RTS					;$039B50	|

ReznorTileDispX:
	db $00,$F0,$00,$F0,$F0,$00,$F0,$00
ReznorTileDispY:
	db $E0,$E0,$F0,$F0

ReznorTiles:
	db $40,$42,$60,$62,$44,$46,$64,$66
	db $28,$28,$48,$48

ReznorPal:
	db $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F
	db $7F,$3F,$7F,$3F

ReznorGfxRt:
	LDA.w $151C,X
	BNE DrawReznorPlats			;$039B78	|
	JSR GetDrawInfoBnk3			;$039B7A	|
	LDA.w $1602,X				;$039B7D	|
	ASL					;$039B80	|
	ASL					;$039B81	|
	STA $03					;$039B82	|
	LDA.w $157C,X				;$039B84	|
	ASL					;$039B87	|
	ASL					;$039B88	|
	STA $02					;$039B89	|
	PHX					;$039B8B	|
	LDX.b #$03				;$039B8C	|
RznrGfxLoopStart:
	PHX
	LDA $03					;$039B8F	|
	CMP.b #$08				;$039B91	|
	BCS CODE_039B99				;$039B93	|
	TXA					;$039B95	|
	ORA $02					;$039B96	|
	TAX					;$039B98	|
CODE_039B99:
	LDA $00
	CLC					;$039B9B	|
	ADC.w ReznorTileDispX,X			;$039B9C	|
	STA.w $0300,Y				;$039B9F	|
	PLX					;$039BA2	|
	LDA $01					;$039BA3	|
	CLC					;$039BA5	|
	ADC.w ReznorTileDispY,X			;$039BA6	|
	STA.w $0301,Y				;$039BA9	|
	PHX					;$039BAC	|
	TXA					;$039BAD	|
	ORA $03					;$039BAE	|
	TAX					;$039BB0	|
	LDA.w ReznorTiles,X			;$039BB1	|
	STA.w $0302,Y				;$039BB4	|
	LDA.w ReznorPal,X			;$039BB7	|
	CPX.b #$08				;$039BBA	|
	BCS NoReznorGfxFlip			;$039BBC	|
	LDX $02					;$039BBE	|
	BNE NoReznorGfxFlip			;$039BC0	|
	EOR.b #$40				;$039BC2	|
NoReznorGfxFlip:
	STA.w $0303,Y
	PLX					;$039BC7	|
	INY					;$039BC8	|
	INY					;$039BC9	|
	INY					;$039BCA	|
	INY					;$039BCB	|
	DEX					;$039BCC	|
	BPL RznrGfxLoopStart			;$039BCD	|
	PLX					;$039BCF	|
	LDY.b #$02				;$039BD0	|
	LDA.b #$03				;$039BD2	|
	JSL FinishOAMWrite			;$039BD4	|
	LDA.w $14C8,X				;$039BD8	|
	CMP.b #$02				;$039BDB	|
	BEQ Return039BE2			;$039BDD	|
DrawReznorPlats:
	JSR ReznorPlatGfxRt
Return039BE2:
	RTS

ReznorPlatDispY:
	db $00,$03,$04,$05,$05,$04,$03,$00

ReznorPlatGfxRt:
	LDA.w $15EA,X
	CLC					;$039BEE	|
	ADC.b #$10				;$039BEF	|
	STA.w $15EA,X				;$039BF1	|
	JSR GetDrawInfoBnk3			;$039BF4	|
	LDA.w $1564,X				;$039BF7	|
	LSR					;$039BFA	|
	PHY					;$039BFB	|
	TAY					;$039BFC	|
	LDA.w ReznorPlatDispY,Y			;$039BFD	|
	STA $02					;$039C00	|
	PLY					;$039C02	|
	LDA $00					;$039C03	|
	STA.w $0304,Y				;$039C05	|
	SEC					;$039C08	|
	SBC.b #$10				;$039C09	|
	STA.w $0300,Y				;$039C0B	|
	LDA $01					;$039C0E	|
	SEC					;$039C10	|
	SBC $02					;$039C11	|
	STA.w $0301,Y				;$039C13	|
	STA.w $0305,Y				;$039C16	|
	LDA.b #$4E				;$039C19	|
	STA.w $0302,Y				;$039C1B	|
	STA.w $0306,Y				;$039C1E	|
	LDA.b #$33				;$039C21	|
	STA.w $0303,Y				;$039C23	|
	ORA.b #$40				;$039C26	|
	STA.w $0307,Y				;$039C28	|
	LDY.b #$02				;$039C2B	|
	LDA.b #$01				;$039C2D	|
	JSL FinishOAMWrite			;$039C2F	|
	RTS					;$039C33	|

InvisBlkPDinosMain:
	LDA $9E,X
	CMP.b #$6D				;$039C36	|
	BNE DinoMainRt				;$039C38	|
	JSL InvisBlkMainRt			;$039C3A	|
	RTL					;$039C3E	|

DinoMainRt:
	PHB
	PHK					;$039C40	|
	PLB					;$039C41	|
	JSR DinoMainSubRt			;$039C42	|
	PLB					;$039C45	|
	RTL					;$039C46	|

DinoMainSubRt:
	JSR DinoGfxRt
	LDA $9D					;$039C4A	|
	BNE Return039CA3			;$039C4C	|
	LDA.w $14C8,X				;$039C4E	|
	CMP.b #$08				;$039C51	|
	BNE Return039CA3			;$039C53	|
	JSR SubOffscreen0Bnk3			;$039C55	|
	JSL MarioSprInteract			;$039C58	|
	JSL UpdateSpritePos			;$039C5C	|
	LDA $C2,X				;$039C60	|
	JSL execute_pointer			;$039C62	|

RhinoStatePtrs:
	dw CODE_039CA8
	dw CODE_039D41
	dw CODE_039D41
	dw CODE_039C74

DATA_039C6E:
	db $00,$FE,$02

DATA_039C71:
	db $00,$FF,$00

CODE_039C74:
	LDA $AA,X
	BMI CODE_039C89				;$039C76	|
	STZ $C2,X				;$039C78	|
	LDA.w $1588,X				;$039C7A	|
	AND.b #$03				;$039C7D	|
	BEQ CODE_039C89				;$039C7F	|
	LDA.w $157C,X				;$039C81	|
	EOR.b #$01				;$039C84	|
	STA.w $157C,X				;$039C86	|
CODE_039C89:
	STZ.w $1602,X
	LDA.w $1588,X				;$039C8C	|
	AND.b #$03				;$039C8F	|
	TAY					;$039C91	|
	LDA $E4,X				;$039C92	|
	CLC					;$039C94	|
	ADC.w DATA_039C6E,Y			;$039C95	|
	STA $E4,X				;$039C98	|
	LDA.w $14E0,X				;$039C9A	|
	ADC.w DATA_039C71,Y			;$039C9D	|
	STA.w $14E0,X				;$039CA0	|
Return039CA3:
	RTS

DinoSpeed:
	db $08,$F8,$10,$F0

CODE_039CA8:
	LDA.w $1588,X
	AND.b #$04				;$039CAB	|
	BEQ CODE_039C89				;$039CAD	|
	LDA.w $1540,X				;$039CAF	|
	BNE CODE_039CC8				;$039CB2	|
	LDA $9E,X				;$039CB4	|
	CMP.b #$6E				;$039CB6	|
	BEQ CODE_039CC8				;$039CB8	|
	LDA.b #$FF				;$039CBA	|
	STA.w $1540,X				;$039CBC	|
	JSL GetRand				;$039CBF	|
	AND.b #$01				;$039CC3	|
	INC A					;$039CC5	|
	STA $C2,X				;$039CC6	|
CODE_039CC8:
	TXA
	ASL					;$039CC9	|
	ASL					;$039CCA	|
	ASL					;$039CCB	|
	ASL					;$039CCC	|
	ADC $14					;$039CCD	|
	AND.b #$3F				;$039CCF	|
	BNE CODE_039CDA				;$039CD1	|
	JSR SubHorzPosBnk3			;$039CD3	|
	TYA					;$039CD6	|
	STA.w $157C,X				;$039CD7	|
CODE_039CDA:
	LDA.b #$10
	STA $AA,X				;$039CDC	|
	LDY.w $157C,X				;$039CDE	|
	LDA $9E,X				;$039CE1	|
	CMP.b #$6E				;$039CE3	|
	BEQ CODE_039CE9				;$039CE5	|
	INY					;$039CE7	|
	INY					;$039CE8	|
CODE_039CE9:
	LDA.w DinoSpeed,Y
	STA $B6,X				;$039CEC	|
	JSR DinoSetGfxFrame			;$039CEE	|
	LDA.w $1588,X				;$039CF1	|
	AND.b #$03				;$039CF4	|
	BEQ Return039D00			;$039CF6	|
	LDA.b #$C0				;$039CF8	|
	STA $AA,X				;$039CFA	|
	LDA.b #$03				;$039CFC	|
	STA $C2,X				;$039CFE	|
Return039D00:
	RTS

DinoFlameTable:
	db $41,$42,$42,$32,$22,$12,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$12
	db $22,$32,$42,$42,$42,$42,$41,$41
	db $41,$43,$43,$33,$23,$13,$03,$03
	db $03,$03,$03,$03,$03,$03,$03,$03
	db $03,$03,$03,$03,$03,$03,$03,$13
	db $23,$33,$43,$43,$43,$43,$41,$41

CODE_039D41:
	STZ $B6,X
	LDA.w $1540,X				;$039D43	|
	BNE DinoFlameTimerSet			;$039D46	|
	STZ $C2,X				;$039D48	|
	LDA.b #$40				;$039D4A	|
	STA.w $1540,X				;$039D4C	|
	LDA.b #$00				;$039D4F	|
DinoFlameTimerSet:
	CMP.b #$C0
	BNE CODE_039D5A				;$039D53	|
	LDY.b #$17				;$039D55	|
	STY.w $1DFC				;$039D57	|
CODE_039D5A:
	LSR
	LSR					;$039D5B	|
	LSR					;$039D5C	|
	LDY $C2,X				;$039D5D	|
	CPY.b #$02				;$039D5F	|
	BNE CODE_039D66				;$039D61	|
	CLC					;$039D63	|
	ADC.b #$20				;$039D64	|
CODE_039D66:
	TAY
	LDA.w DinoFlameTable,Y			;$039D67	|
	PHA					;$039D6A	|
	AND.b #$0F				;$039D6B	|
	STA.w $1602,X				;$039D6D	|
	PLA					;$039D70	|
	LSR					;$039D71	|
	LSR					;$039D72	|
	LSR					;$039D73	|
	LSR					;$039D74	|
	STA.w $151C,X				;$039D75	|
	BNE Return039D9D			;$039D78	|
	LDA $9E,X				;$039D7A	|
	CMP.b #$6E				;$039D7C	|
	BEQ Return039D9D			;$039D7E	|
	TXA					;$039D80	|
	EOR $13					;$039D81	|
	AND.b #$03				;$039D83	|
	BNE Return039D9D			;$039D85	|
	JSR DinoFlameClipping			;$039D87	|
	JSL GetMarioClipping			;$039D8A	|
	JSL CheckForContact			;$039D8E	|
	BCC Return039D9D			;$039D92	|
	LDA.w $1490				;$039D94	|
	BNE Return039D9D			;$039D97	|
	JSL HurtMario				;$039D99	|
Return039D9D:
	RTS

DinoFlame1:
	db $DC,$02,$10,$02

DinoFlame2:
	db $FF,$00,$00,$00

DinoFlame3:
	db $24,$0C,$24,$0C

DinoFlame4:
	db $02,$DC,$02,$DC

DinoFlame5:
	db $00,$FF,$00,$FF

DinoFlame6:
	db $0C,$24,$0C,$24

DinoFlameClipping:
	LDA.w $1602,X
	SEC					;$039DB9	|
	SBC.b #$02				;$039DBA	|
	TAY					;$039DBC	|
	LDA.w $157C,X				;$039DBD	|
	BNE CODE_039DC4				;$039DC0	|
	INY					;$039DC2	|
	INY					;$039DC3	|
CODE_039DC4:
	LDA $E4,X
	CLC					;$039DC6	|
	ADC.w DinoFlame1,Y			;$039DC7	|
	STA $04					;$039DCA	|
	LDA.w $14E0,X				;$039DCC	|
	ADC.w DinoFlame2,Y			;$039DCF	|
	STA $0A					;$039DD2	|
	LDA.w DinoFlame3,Y			;$039DD4	|
	STA $06					;$039DD7	|
	LDA $D8,X				;$039DD9	|
	CLC					;$039DDB	|
	ADC.w DinoFlame4,Y			;$039DDC	|
	STA $05					;$039DDF	|
	LDA.w $14D4,X				;$039DE1	|
	ADC.w DinoFlame5,Y			;$039DE4	|
	STA $0B					;$039DE7	|
	LDA.w DinoFlame6,Y			;$039DE9	|
	STA $07					;$039DEC	|
	RTS					;$039DEE	|

DinoSetGfxFrame:
	INC.w $1570,X
	LDA.w $1570,X				;$039DF2	|
	AND.b #$08				;$039DF5	|
	LSR					;$039DF7	|
	LSR					;$039DF8	|
	LSR					;$039DF9	|
	STA.w $1602,X				;$039DFA	|
	RTS					;$039DFD	|

DinoTorchTileDispX:
	db $D8,$E0,$EC,$F8,$00,$FF,$FF,$FF
	db $FF,$00

DinoTorchTileDispY:
	db $00,$00,$00,$00,$00,$D8,$E0,$EC
	db $F8,$00

DinoFlameTiles:
	db $80,$82,$84,$86,$00,$88,$8A,$8C
	db $8E,$00

DinoTorchGfxProp:
	db $09,$05,$05,$05,$0F

DinoTorchTiles:
	db $EA,$AA,$C4,$C6

DinoRhinoTileDispX:
	db $F8,$08,$F8,$08,$08,$F8,$08,$F8
DinoRhinoGfxProp:
	db $2F,$2F,$2F,$2F,$6F,$6F,$6F,$6F
DinoRhinoTileDispY:
	db $F0,$F0,$00,$00

DinoRhinoTiles:
	db $C0,$C2,$E4,$E6,$C0,$C2,$E0,$E2
	db $C8,$CA,$E8,$E2,$CC,$CE,$EC,$EE

DinoGfxRt:
	JSR GetDrawInfoBnk3
	LDA.w $157C,X				;$039E4C	|
	STA $02					;$039E4F	|
	LDA.w $1602,X				;$039E51	|
	STA $04					;$039E54	|
	LDA $9E,X				;$039E56	|
	CMP.b #$6F				;$039E58	|
	BEQ CODE_039EA9				;$039E5A	|
	PHX					;$039E5C	|
	LDX.b #$03				;$039E5D	|
CODE_039E5F:
	STX $0F
	LDA $02					;$039E61	|
	CMP.b #$01				;$039E63	|
	BCS CODE_039E6C				;$039E65	|
	TXA					;$039E67	|
	CLC					;$039E68	|
	ADC.b #$04				;$039E69	|
	TAX					;$039E6B	|
CODE_039E6C:
	LDA.w DinoRhinoGfxProp,X
	STA.w $0303,Y				;$039E6F	|
	LDA.w DinoRhinoTileDispX,X		;$039E72	|
	CLC					;$039E75	|
	ADC $00					;$039E76	|
	STA.w $0300,Y				;$039E78	|
	LDA $04					;$039E7B	|
	CMP.b #$01				;$039E7D	|
	LDX $0F					;$039E7F	|
	LDA.w DinoRhinoTileDispY,X		;$039E81	|
	ADC $01					;$039E84	|
	STA.w $0301,Y				;$039E86	|
	LDA $04					;$039E89	|
	ASL					;$039E8B	|
	ASL					;$039E8C	|
	ADC $0F					;$039E8D	|
	TAX					;$039E8F	|
	LDA.w DinoRhinoTiles,X			;$039E90	|
	STA.w $0302,Y				;$039E93	|
	INY					;$039E96	|
	INY					;$039E97	|
	INY					;$039E98	|
	INY					;$039E99	|
	LDX $0F					;$039E9A	|
	DEX					;$039E9C	|
	BPL CODE_039E5F				;$039E9D	|
	PLX					;$039E9F	|
	LDA.b #$03				;$039EA0	|
	LDY.b #$02				;$039EA2	|
	JSL FinishOAMWrite			;$039EA4	|
	RTS					;$039EA8	|

CODE_039EA9:
	LDA.w $151C,X
	STA $03					;$039EAC	|
	LDA.w $1602,X				;$039EAE	|
	STA $04					;$039EB1	|
	PHX					;$039EB3	|
	LDA $14					;$039EB4	|
	AND.b #$02				;$039EB6	|
	ASL					;$039EB8	|
	ASL					;$039EB9	|
	ASL					;$039EBA	|
	ASL					;$039EBB	|
	ASL					;$039EBC	|
	LDX $04					;$039EBD	|
	CPX.b #$03				;$039EBF	|
	BEQ CODE_039EC4				;$039EC1	|
	ASL					;$039EC3	|
CODE_039EC4:
	STA $05
	LDX.b #$04				;$039EC6	|
CODE_039EC8:
	STX $06
	LDA $04					;$039ECA	|
	CMP.b #$03				;$039ECC	|
	BNE CODE_039ED5				;$039ECE	|
	TXA					;$039ED0	|
	CLC					;$039ED1	|
	ADC.b #$05				;$039ED2	|
	TAX					;$039ED4	|
CODE_039ED5:
	PHX
	LDA.w DinoTorchTileDispX,X		;$039ED6	|
	LDX $02					;$039ED9	|
	BNE CODE_039EE0				;$039EDB	|
	EOR.b #$FF				;$039EDD	|
	INC A					;$039EDF	|
CODE_039EE0:
	PLX
	CLC					;$039EE1	|
	ADC $00					;$039EE2	|
	STA.w $0300,Y				;$039EE4	|
	LDA.w DinoTorchTileDispY,X		;$039EE7	|
	CLC					;$039EEA	|
	ADC $01					;$039EEB	|
	STA.w $0301,Y				;$039EED	|
	LDA $06					;$039EF0	|
	CMP.b #$04				;$039EF2	|
	BNE CODE_039EFD				;$039EF4	|
	LDX $04					;$039EF6	|
	LDA.w DinoTorchTiles,X			;$039EF8	|
	BRA CODE_039F00				;$039EFB	|

CODE_039EFD:
	LDA.w DinoFlameTiles,X
CODE_039F00:
	STA.w $0302,Y
	LDA.b #$00				;$039F03	|
	LDX $02					;$039F05	|
	BNE CODE_039F0B				;$039F07	|
	ORA.b #$40				;$039F09	|
CODE_039F0B:
	LDX $06
	CPX.b #$04				;$039F0D	|
	BEQ CODE_039F13				;$039F0F	|
	EOR $05					;$039F11	|
CODE_039F13:
	ORA.w DinoTorchGfxProp,X
	ORA $64					;$039F16	|
	STA.w $0303,Y				;$039F18	|
	INY					;$039F1B	|
	INY					;$039F1C	|
	INY					;$039F1D	|
	INY					;$039F1E	|
	DEX					;$039F1F	|
	CPX $03					;$039F20	|
	BPL CODE_039EC8				;$039F22	|
	PLX					;$039F24	|
	LDY.w $151C,X				;$039F25	|
	LDA.w DinoTilesWritten,Y		;$039F28	|
	LDY.b #$02				;$039F2B	|
	JSL FinishOAMWrite			;$039F2D	|
	RTS					;$039F31	|

DinoTilesWritten:
	db $04,$03,$02,$01,$00

	RTS					;$039F37	|

Blargg:
	JSR CODE_03A062
	LDA $9D					;$039F3B	|
	BNE Return039F56			;$039F3D	|
	JSL MarioSprInteract			;$039F3F	|
	JSR SubOffscreen0Bnk3			;$039F43	|
	LDA $C2,X				;$039F46	|
	JSL execute_pointer			;$039F48	|

BlarggPtrs:
	dw CODE_039F57
	dw CODE_039F8B
	dw CODE_039FA4
	dw CODE_039FC8
	dw CODE_039FEF

Return039F56:
	RTS

CODE_039F57:
	LDA.w $15A0,X
	ORA.w $1540,X				;$039F5A	|
	BNE Return039F8A			;$039F5D	|
	JSR SubHorzPosBnk3			;$039F5F	|
	LDA $0F					;$039F62	|
	CLC					;$039F64	|
	ADC.b #$70				;$039F65	|
	CMP.b #$E0				;$039F67	|
	BCS Return039F8A			;$039F69	|
	LDA.b #$E3				;$039F6B	|
	STA $AA,X				;$039F6D	|
	LDA.w $14E0,X				;$039F6F	|
	STA.w $151C,X				;$039F72	|
	LDA $E4,X				;$039F75	|
	STA.w $1528,X				;$039F77	|
	LDA.w $14D4,X				;$039F7A	|
	STA.w $1534,X				;$039F7D	|
	LDA $D8,X				;$039F80	|
	STA.w $1594,X				;$039F82	|
	JSR CODE_039FC0				;$039F85	|
	INC $C2,X				;$039F88	|
Return039F8A:
	RTS

CODE_039F8B:
	LDA $AA,X
	CMP.b #$10				;$039F8D	|
	BMI CODE_039F9B				;$039F8F	|
	LDA.b #$50				;$039F91	|
	STA.w $1540,X				;$039F93	|
	INC $C2,X				;$039F96	|
	STZ $AA,X				;$039F98	|
	RTS					;$039F9A	|

CODE_039F9B:
	JSL UpdateYPosNoGrvty
	INC $AA,X				;$039F9F	|
	INC $AA,X				;$039FA1	|
	RTS					;$039FA3	|

CODE_039FA4:
	LDA.w $1540,X
	BNE CODE_039FB1				;$039FA7	|
	INC $C2,X				;$039FA9	|
	LDA.b #$0A				;$039FAB	|
	STA.w $1540,X				;$039FAD	|
	RTS					;$039FB0	|

CODE_039FB1:
	CMP.b #$20
	BCC CODE_039FC0				;$039FB3	|
	AND.b #$1F				;$039FB5	|
	BNE Return039FC7			;$039FB7	|
	LDA.w $157C,X				;$039FB9	|
	EOR.b #$01				;$039FBC	|
	BRA CODE_039FC4				;$039FBE	|

CODE_039FC0:
	JSR SubHorzPosBnk3
	TYA					;$039FC3	|
CODE_039FC4:
	STA.w $157C,X
Return039FC7:
	RTS

CODE_039FC8:
	LDA.w $1540,X
	BEQ CODE_039FD6				;$039FCB	|
	LDA.b #$20				;$039FCD	|
	STA $AA,X				;$039FCF	|
	JSL UpdateYPosNoGrvty			;$039FD1	|
	RTS					;$039FD5	|

CODE_039FD6:
	LDA.b #$20
	STA.w $1540,X				;$039FD8	|
	LDY.w $157C,X				;$039FDB	|
	LDA.w DATA_039FED,Y			;$039FDE	|
	STA $B6,X				;$039FE1	|
	LDA.b #$E2				;$039FE3	|
	STA $AA,X				;$039FE5	|
	JSR CODE_03A045				;$039FE7	|
	INC $C2,X				;$039FEA	|
	RTS					;$039FEC	|

DATA_039FED:
	db $10,$F0

CODE_039FEF:
	STZ.w $1602,X
	LDA.w $1540,X				;$039FF2	|
	BEQ CODE_03A002				;$039FF5	|
	DEC A					;$039FF7	|
	BNE CODE_03A038				;$039FF8	|
	LDA.b #$25				;$039FFA	|
	STA.w $1DF9				;$039FFC	|
	JSR CODE_03A045				;$039FFF	|
CODE_03A002:
	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty			;$03A006	|
	LDA $13					;$03A00A	|
	AND.b #$00				;$03A00C	|
	BNE CODE_03A012				;$03A00E	|
	INC $AA,X				;$03A010	|
CODE_03A012:
	LDA $AA,X
	CMP.b #$20				;$03A014	|
	BMI CODE_03A038				;$03A016	|
	JSR CODE_03A045				;$03A018	|
	STZ $C2,X				;$03A01B	|
	LDA.w $151C,X				;$03A01D	|
	STA.w $14E0,X				;$03A020	|
	LDA.w $1528,X				;$03A023	|
	STA $E4,X				;$03A026	|
	LDA.w $1534,X				;$03A028	|
	STA.w $14D4,X				;$03A02B	|
	LDA.w $1594,X				;$03A02E	|
	STA $D8,X				;$03A031	|
	LDA.b #$40				;$03A033	|
	STA.w $1540,X				;$03A035	|
CODE_03A038:
	LDA $AA,X
	CLC					;$03A03A	|
	ADC.b #$06				;$03A03B	|
	CMP.b #$0C				;$03A03D	|
	BCS Return03A044			;$03A03F	|
	INC.w $1602,X				;$03A041	|
Return03A044:
	RTS

CODE_03A045:
	LDA $D8,X
	PHA					;$03A047	|
	SEC					;$03A048	|
	SBC.b #$0C				;$03A049	|
	STA $D8,X				;$03A04B	|
	LDA.w $14D4,X				;$03A04D	|
	PHA					;$03A050	|
	SBC.b #$00				;$03A051	|
	STA.w $14D4,X				;$03A053	|
	JSL CODE_028528				;$03A056	|
	PLA					;$03A05A	|
	STA.w $14D4,X				;$03A05B	|
	PLA					;$03A05E	|
	STA $D8,X				;$03A05F	|
	RTS					;$03A061	|

CODE_03A062:
	JSR GetDrawInfoBnk3
	LDA $C2,X				;$03A065	|
	BEQ CODE_03A038				;$03A067	|
	CMP.b #$04				;$03A069	|
	BEQ CODE_03A09D				;$03A06B	|
	JSL GenericSprGfxRt2			;$03A06D	|
	LDY.w $15EA,X				;$03A071	|
	LDA.b #$A0				;$03A074	|
	STA.w $0302,Y				;$03A076	|
	LDA.w $0303,Y				;$03A079	|
	AND.b #$CF				;$03A07C	|
	STA.w $0303,Y				;$03A07E	|
	RTS					;$03A081	|

DATA_03A082:
	db $F8,$08,$F8,$08,$18,$08,$F8,$08
	db $F8,$E8

DATA_03A08C:
	db $F8,$F8,$08,$08,$08

BlarggTilemap:
	db $A2,$A4,$C2,$C4,$A6,$A2,$A4,$E6
	db $C8,$A6

DATA_03A09B:
	db $45,$05

CODE_03A09D:
	LDA.w $1602,X
	ASL					;$03A0A0	|
	ASL					;$03A0A1	|
	ADC.w $1602,X				;$03A0A2	|
	STA $03					;$03A0A5	|
	LDA.w $157C,X				;$03A0A7	|
	STA $02					;$03A0AA	|
	PHX					;$03A0AC	|
	LDX.b #$04				;$03A0AD	|
CODE_03A0AF:
	PHX
	PHX					;$03A0B0	|
	LDA $01					;$03A0B1	|
	CLC					;$03A0B3	|
	ADC.w DATA_03A08C,X			;$03A0B4	|
	STA.w $0301,Y				;$03A0B7	|
	LDA $02					;$03A0BA	|
	BNE CODE_03A0C3				;$03A0BC	|
	TXA					;$03A0BE	|
	CLC					;$03A0BF	|
	ADC.b #$05				;$03A0C0	|
	TAX					;$03A0C2	|
CODE_03A0C3:
	LDA $00
	CLC					;$03A0C5	|
	ADC.w DATA_03A082,X			;$03A0C6	|
	STA.w $0300,Y				;$03A0C9	|
	PLA					;$03A0CC	|
	CLC					;$03A0CD	|
	ADC $03					;$03A0CE	|
	TAX					;$03A0D0	|
	LDA.w BlarggTilemap,X			;$03A0D1	|
	STA.w $0302,Y				;$03A0D4	|
	LDX $02					;$03A0D7	|
	LDA.w DATA_03A09B,X			;$03A0D9	|
	STA.w $0303,Y				;$03A0DC	|
	PLX					;$03A0DF	|
	INY					;$03A0E0	|
	INY					;$03A0E1	|
	INY					;$03A0E2	|
	INY					;$03A0E3	|
	DEX					;$03A0E4	|
	BPL CODE_03A0AF				;$03A0E5	|
	PLX					;$03A0E7	|
	LDY.b #$02				;$03A0E8	|
	LDA.b #$04				;$03A0EA	|
	JSL FinishOAMWrite			;$03A0EC	|
	RTS					;$03A0F0	|

CODE_03A0F1:
	JSL InitSpriteTables
	STZ.w $15A0,X				;$03A0F5	|
	LDA.b #$80				;$03A0F8	|
	STA $D8,X				;$03A0FA	|
	LDA.b #$FF				;$03A0FC	|
	STA.w $14D4,X				;$03A0FE	|
	LDA.b #$D0				;$03A101	|
	STA $E4,X				;$03A103	|
	LDA.b #$00				;$03A105	|
	STA.w $14E0,X				;$03A107	|
	LDA.b #$02				;$03A10A	|
	STA.w $187B,X				;$03A10C	|
	LDA.b #$03				;$03A10F	|
	STA $C2,X				;$03A111	|
	JSL CODE_03DD7D				;$03A113	|
	RTL					;$03A117	|

Bnk3CallSprMain:
	PHB
	PHK					;$03A119	|
	PLB					;$03A11A	|
	LDA $9E,X				;$03A11B	|
	CMP.b #$C8				;$03A11D	|
	BNE CODE_03A126				;$03A11F	|
	JSR LightSwitch				;$03A121	|
	PLB					;$03A124	|
	RTL					;$03A125	|

CODE_03A126:
	CMP.b #$C7
	BNE CODE_03A12F				;$03A128	|
	JSR InvisMushroom			;$03A12A	|
	PLB					;$03A12D	|
	RTL					;$03A12E	|

CODE_03A12F:
	CMP.b #$51
	BNE CODE_03A138				;$03A131	|
	JSR Ninji				;$03A133	|
	PLB					;$03A136	|
	RTL					;$03A137	|

CODE_03A138:
	CMP.b #$1B
	BNE CODE_03A141				;$03A13A	|
	JSR Football				;$03A13C	|
	PLB					;$03A13F	|
	RTL					;$03A140	|

CODE_03A141:
	CMP.b #$C6
	BNE CODE_03A14A				;$03A143	|
	JSR DarkRoomWithLight			;$03A145	|
	PLB					;$03A148	|
	RTL					;$03A149	|

CODE_03A14A:
	CMP.b #$7A
	BNE CODE_03A153				;$03A14C	|
	JSR Firework				;$03A14E	|
	PLB					;$03A151	|
	RTL					;$03A152	|

CODE_03A153:
	CMP.b #$7C
	BNE CODE_03A15C				;$03A155	|
	JSR PrincessPeach			;$03A157	|
	PLB					;$03A15A	|
	RTL					;$03A15B	|

CODE_03A15C:
	CMP.b #$C5
	BNE CODE_03A165				;$03A15E	|
	JSR BigBooBoss				;$03A160	|
	PLB					;$03A163	|
	RTL					;$03A164	|

CODE_03A165:
	CMP.b #$C4
	BNE CODE_03A16E				;$03A167	|
	JSR GreyFallingPlat			;$03A169	|
	PLB					;$03A16C	|
	RTL					;$03A16D	|

CODE_03A16E:
	CMP.b #$C2
	BNE CODE_03A177				;$03A170	|
	JSR Blurp				;$03A172	|
	PLB					;$03A175	|
	RTL					;$03A176	|

CODE_03A177:
	CMP.b #$C3
	BNE CODE_03A180				;$03A179	|
	JSR PorcuPuffer				;$03A17B	|
	PLB					;$03A17E	|
	RTL					;$03A17F	|

CODE_03A180:
	CMP.b #$C1
	BNE CODE_03A189				;$03A182	|
	JSR FlyingTurnBlocks			;$03A184	|
	PLB					;$03A187	|
	RTL					;$03A188	|

CODE_03A189:
	CMP.b #$C0
	BNE CODE_03A192				;$03A18B	|
	JSR GrayLavaPlatform			;$03A18D	|
	PLB					;$03A190	|
	RTL					;$03A191	|

CODE_03A192:
	CMP.b #$BF
	BNE CODE_03A19B				;$03A194	|
	JSR MegaMole				;$03A196	|
	PLB					;$03A199	|
	RTL					;$03A19A	|

CODE_03A19B:
	CMP.b #$BE
	BNE CODE_03A1A4				;$03A19D	|
	JSR Swooper				;$03A19F	|
	PLB					;$03A1A2	|
	RTL					;$03A1A3	|

CODE_03A1A4:
	CMP.b #$BD
	BNE CODE_03A1AD				;$03A1A6	|
	JSR SlidingKoopa			;$03A1A8	|
	PLB					;$03A1AB	|
	RTL					;$03A1AC	|

CODE_03A1AD:
	CMP.b #$BC
	BNE CODE_03A1B6				;$03A1AF	|
	JSR BowserStatue			;$03A1B1	|
	PLB					;$03A1B4	|
	RTL					;$03A1B5	|

CODE_03A1B6:
	CMP.b #$B8
	BEQ CODE_03A1BE				;$03A1B8	|
	CMP.b #$B7				;$03A1BA	|
	BNE CODE_03A1C3				;$03A1BC	|
CODE_03A1BE:
	JSR CarrotTopLift
	PLB					;$03A1C1	|
	RTL					;$03A1C2	|

CODE_03A1C3:
	CMP.b #$B9
	BNE CODE_03A1CC				;$03A1C5	|
	JSR InfoBox				;$03A1C7	|
	PLB					;$03A1CA	|
	RTL					;$03A1CB	|

CODE_03A1CC:
	CMP.b #$BA
	BNE CODE_03A1D5				;$03A1CE	|
	JSR TimedLift				;$03A1D0	|
	PLB					;$03A1D3	|
	RTL					;$03A1D4	|

CODE_03A1D5:
	CMP.b #$BB
	BNE CODE_03A1DE				;$03A1D7	|
	JSR GreyCastleBlock			;$03A1D9	|
	PLB					;$03A1DC	|
	RTL					;$03A1DD	|

CODE_03A1DE:
	CMP.b #$B3
	BNE CODE_03A1E7				;$03A1E0	|
	JSR StatueFireball			;$03A1E2	|
	PLB					;$03A1E5	|
	RTL					;$03A1E6	|

CODE_03A1E7:
	LDA $9E,X
	CMP.b #$B2				;$03A1E9	|
	BNE CODE_03A1F2				;$03A1EB	|
	JSR FallingSpike			;$03A1ED	|
	PLB					;$03A1F0	|
	RTL					;$03A1F1	|

CODE_03A1F2:
	CMP.b #$AE
	BNE CODE_03A1FB				;$03A1F4	|
	JSR FishinBoo				;$03A1F6	|
	PLB					;$03A1F9	|
	RTL					;$03A1FA	|

CODE_03A1FB:
	CMP.b #$B6
	BNE CODE_03A204				;$03A1FD	|
	JSR ReflectingFireball			;$03A1FF	|
	PLB					;$03A202	|
	RTL					;$03A203	|

CODE_03A204:
	CMP.b #$B0
	BNE CODE_03A20D				;$03A206	|
	JSR BooStream				;$03A208	|
	PLB					;$03A20B	|
	RTL					;$03A20C	|

CODE_03A20D:
	CMP.b #$B1
	BNE CODE_03A216				;$03A20F	|
	JSR CreateEatBlock			;$03A211	|
	PLB					;$03A214	|
	RTL					;$03A215	|

CODE_03A216:
	CMP.b #$AC
	BEQ CODE_03A21E				;$03A218	|
	CMP.b #$AD				;$03A21A	|
	BNE CODE_03A223				;$03A21C	|
CODE_03A21E:
	JSR WoodenSpike
	PLB					;$03A221	|
	RTL					;$03A222	|

CODE_03A223:
	CMP.b #$AB
	BNE CODE_03A22C				;$03A225	|
	JSR RexMainRt				;$03A227	|
	PLB					;$03A22A	|
	RTL					;$03A22B	|

CODE_03A22C:
	CMP.b #$AA
	BNE CODE_03A235				;$03A22E	|
	JSR Fishbone				;$03A230	|
	PLB					;$03A233	|
	RTL					;$03A234	|

CODE_03A235:
	CMP.b #$A9
	BNE CODE_03A23E				;$03A237	|
	JSR Reznor				;$03A239	|
	PLB					;$03A23C	|
	RTL					;$03A23D	|

CODE_03A23E:
	CMP.b #$A8
	BNE CODE_03A247				;$03A240	|
	JSR Blargg				;$03A242	|
	PLB					;$03A245	|
	RTL					;$03A246	|

CODE_03A247:
	CMP.b #$A1
	BNE CODE_03A250				;$03A249	|
	JSR BowserBowlingBall			;$03A24B	|
	PLB					;$03A24E	|
	RTL					;$03A24F	|

CODE_03A250:
	CMP.b #$A2
	BNE BowserFight				;$03A252	|
	JSR MechaKoopa				;$03A254	|
	PLB					;$03A257	|
	RTL					;$03A258	|

BowserFight:
	JSL CODE_03DFCC
	JSR CODE_03A279				;$03A25D	|
	JSR CODE_03B43C				;$03A260	|
	PLB					;$03A263	|
	RTL					;$03A264	|

DATA_03A265:
	db $04,$03,$02,$01,$00,$01,$02,$03
	db $04,$05,$06,$07,$07,$07,$07,$07
	db $07,$07,$07,$07

CODE_03A279:
	LDA $38
	LSR					;$03A27B	|
	LSR					;$03A27C	|
	LSR					;$03A27D	|
	TAY					;$03A27E	|
	LDA.w DATA_03A265,Y			;$03A27F	|
	STA.w $1429				;$03A282	|
	LDA.w $1570,X				;$03A285	|
	CLC					;$03A288	|
	ADC.b #$1E				;$03A289	|
	ORA.w $157C,X				;$03A28B	|
	STA.w $1BA2				;$03A28E	|
	LDA $14					;$03A291	|
	LSR					;$03A293	|
	AND.b #$03				;$03A294	|
	STA.w $1428				;$03A296	|
	LDA.b #$90				;$03A299	|
	STA $2A					;$03A29B	|
	LDA.b #$C8				;$03A29D	|
	STA $2C					;$03A29F	|
	JSL CODE_03DEDF				;$03A2A1	|
	LDA.w $14B5				;$03A2A5	|
	BEQ CODE_03A2AD				;$03A2A8	|
	JSR CODE_03AF59				;$03A2AA	|
CODE_03A2AD:
	LDA.w $1564,X
	BEQ CODE_03A2B5				;$03A2B0	|
	JSR CODE_03A3E2				;$03A2B2	|
CODE_03A2B5:
	LDA.w $1594,X
	BEQ CODE_03A2CE				;$03A2B8	|
	DEC A					;$03A2BA	|
	LSR					;$03A2BB	|
	LSR					;$03A2BC	|
	PHA					;$03A2BD	|
	LSR					;$03A2BE	|
	TAY					;$03A2BF	|
	LDA.w DATA_03A8BE,Y			;$03A2C0	|
	STA $02					;$03A2C3	|
	PLA					;$03A2C5	|
	AND.b #$03				;$03A2C6	|
	STA $03					;$03A2C8	|
	JSR CODE_03AA6E				;$03A2CA	|
	NOP					;$03A2CD	|
CODE_03A2CE:
	LDA $9D
	BNE Return03A340			;$03A2D0	|
	STZ.w $1594,X				;$03A2D2	|
	LDA.b #$30				;$03A2D5	|
	STA $64					;$03A2D7	|
	LDA $38					;$03A2D9	|
	CMP.b #$20				;$03A2DB	|
	BCS CODE_03A2E1				;$03A2DD	|
	STZ $64					;$03A2DF	|
CODE_03A2E1:
	JSR CODE_03A661
	LDA.w $14B0				;$03A2E4	|
	BEQ CODE_03A2F2				;$03A2E7	|
	LDA $13					;$03A2E9	|
	AND.b #$03				;$03A2EB	|
	BNE CODE_03A2F2				;$03A2ED	|
	DEC.w $14B0				;$03A2EF	|
CODE_03A2F2:
	LDA $13
	AND.b #$7F				;$03A2F4	|
	BNE CODE_03A305				;$03A2F6	|
	JSL GetRand				;$03A2F8	|
	AND.b #$01				;$03A2FC	|
	BNE CODE_03A305				;$03A2FE	|
	LDA.b #$0C				;$03A300	|
	STA.w $1558,X				;$03A302	|
CODE_03A305:
	JSR CODE_03B078
	LDA.w $151C,X				;$03A308	|
	CMP.b #$09				;$03A30B	|
	BEQ CODE_03A31A				;$03A30D	|
	STZ.w $1427				;$03A30F	|
	LDA.w $1558,X				;$03A312	|
	BEQ CODE_03A31A				;$03A315	|
	INC.w $1427				;$03A317	|
CODE_03A31A:
	JSR CODE_03A5AD
	JSL UpdateXPosNoGrvty			;$03A31D	|
	JSL UpdateYPosNoGrvty			;$03A321	|
	LDA.w $151C,X				;$03A325	|
	JSL execute_pointer			;$03A328	|

BowserFightPtrs:
	dw CODE_03A441
	dw CODE_03A6F8
	dw CODE_03A84B
	dw CODE_03A7AD
	dw CODE_03AB9F
	dw CODE_03ABBE
	dw CODE_03AC03
	dw CODE_03A49C
	dw CODE_03AB21
	dw CODE_03AB64

Return03A340:
	RTS

DATA_03A341:
	db $D5,$DD,$23,$2B,$D5,$DD,$23,$2B
	db $D5,$DD,$23,$2B,$D5,$DD,$23,$2B
	db $D6,$DE,$22,$2A,$D6,$DE,$22,$2A
	db $D7,$DF,$21,$29,$D7,$DF,$21,$29
	db $D8,$E0,$20,$28,$D8,$E0,$20,$28
	db $DA,$E2,$1E,$26,$DA,$E2,$1E,$26
	db $DC,$E4,$1C,$24,$DC,$E4,$1C,$24
	db $E0,$E8,$18,$20,$E0,$E8,$18,$20
	db $E8,$F0,$10,$18,$E8,$F0,$10,$18
DATA_03A389:
	db $DD,$D5,$D5,$DD,$23,$2B,$2B,$23
	db $DD,$D5,$D5,$DD,$23,$2B,$2B,$23
	db $DE,$D6,$D6,$DE,$22,$2A,$2A,$22
	db $DF,$D7,$D7,$DF,$21,$29,$29,$21
	db $E0,$D8,$D8,$E0,$20,$28,$28,$20
	db $E2,$DA,$DA,$E2,$1E,$26,$26,$1E
	db $E4,$DC,$DC,$E4,$1C,$24,$24,$1C
	db $E8,$E0,$E0,$E8,$18,$20,$20,$18
	db $F0,$E8,$E8,$F0,$10,$18,$18,$10
DATA_03A3D1:
	db $80,$40,$00,$C0,$00,$C0,$80,$40
DATA_03A3D9:
	db $E3,$ED,$ED,$EB,$EB,$E9,$E9,$E7
	db $E7

CODE_03A3E2:
	JSR GetDrawInfoBnk3
	LDA.w $1564,X				;$03A3E5	|
	DEC A					;$03A3E8	|
	LSR					;$03A3E9	|
	STA $03					;$03A3EA	|
	ASL					;$03A3EC	|
	ASL					;$03A3ED	|
	ASL					;$03A3EE	|
	STA $02					;$03A3EF	|
	LDA.b #$70				;$03A3F1	|
	STA.w $15EA,X				;$03A3F3	|
	TAY					;$03A3F6	|
	PHX					;$03A3F7	|
	LDX.b #$07				;$03A3F8	|
CODE_03A3FA:
	PHX
	TXA					;$03A3FB	|
	ORA $02					;$03A3FC	|
	TAX					;$03A3FE	|
	LDA $00					;$03A3FF	|
	CLC					;$03A401	|
	ADC.w DATA_03A341,X			;$03A402	|
	CLC					;$03A405	|
	ADC.b #$08				;$03A406	|
	STA.w $0300,Y				;$03A408	|
	LDA $01					;$03A40B	|
	CLC					;$03A40D	|
	ADC.w DATA_03A389,X			;$03A40E	|
	CLC					;$03A411	|
	ADC.b #$30				;$03A412	|
	STA.w $0301,Y				;$03A414	|
	LDX $03					;$03A417	|
	LDA.w DATA_03A3D9,X			;$03A419	|
	STA.w $0302,Y				;$03A41C	|
	PLX					;$03A41F	|
	LDA.w DATA_03A3D1,X			;$03A420	|
	STA.w $0303,Y				;$03A423	|
	INY					;$03A426	|
	INY					;$03A427	|
	INY					;$03A428	|
	INY					;$03A429	|
	DEX					;$03A42A	|
	BPL CODE_03A3FA				;$03A42B	|
	PLX					;$03A42D	|
	LDY.b #$02				;$03A42E	|
	LDA.b #$07				;$03A430	|
	JSL FinishOAMWrite			;$03A432	|
	RTS					;$03A436	|

DATA_03A437:
	db $00,$00,$00,$00,$02,$04,$06,$08
	db $0A,$0E

CODE_03A441:
	LDA.w $154C,X
	BNE CODE_03A482				;$03A444	|
	LDA.w $1540,X				;$03A446	|
	BNE CODE_03A465				;$03A449	|
	LDA.b #$0E				;$03A44B	|
	STA.w $1570,X				;$03A44D	|
	LDA.b #$04				;$03A450	|
	STA $AA,X				;$03A452	|
	STZ $B6,X				;$03A454	|
	LDA $D8,X				;$03A456	|
	SEC					;$03A458	|
	SBC $1C					;$03A459	|
	CMP.b #$10				;$03A45B	|
	BNE Return03A464			;$03A45D	|
	LDA.b #$A4				;$03A45F	|
	STA.w $1540,X				;$03A461	|
Return03A464:
	RTS

CODE_03A465:
	STZ $AA,X
	STZ $B6,X				;$03A467	|
	CMP.b #$01				;$03A469	|
	BEQ CODE_03A47C				;$03A46B	|
	CMP.b #$40				;$03A46D	|
	BCS Return03A47B			;$03A46F	|
	LSR					;$03A471	|
	LSR					;$03A472	|
	LSR					;$03A473	|
	TAY					;$03A474	|
	LDA.w DATA_03A437,Y			;$03A475	|
	STA.w $1570,X				;$03A478	|
Return03A47B:
	RTS

CODE_03A47C:
	LDA.b #$24
	STA.w $154C,X				;$03A47E	|
	RTS					;$03A481	|

CODE_03A482:
	DEC A
	BNE Return03A48F			;$03A483	|
	LDA.b #$07				;$03A485	|
	STA.w $151C,X				;$03A487	|
	LDA.b #$78				;$03A48A	|
	STA.w $14B0				;$03A48C	|
Return03A48F:
	RTS

DATA_03A490:
	db $FF,$01

DATA_03A492:
	db $C8,$38

DATA_03A494:
	db $01,$FF

DATA_03A496:
	db $1C,$E4

DATA_03A498:
	db $00,$02,$04,$02

CODE_03A49C:
	JSR CODE_03A4D2
	JSR CODE_03A4FD				;$03A49F	|
	JSR CODE_03A4ED				;$03A4A2	|
	LDA.w $1528,X				;$03A4A5	|
	AND.b #$01				;$03A4A8	|
	TAY					;$03A4AA	|
	LDA $B6,X				;$03A4AB	|
	CLC					;$03A4AD	|
	ADC.w DATA_03A490,Y			;$03A4AE	|
	STA $B6,X				;$03A4B1	|
	CMP.w DATA_03A492,Y			;$03A4B3	|
	BNE CODE_03A4BB				;$03A4B6	|
	INC.w $1528,X				;$03A4B8	|
CODE_03A4BB:
	LDA.w $1534,X
	AND.b #$01				;$03A4BE	|
	TAY					;$03A4C0	|
	LDA $AA,X				;$03A4C1	|
	CLC					;$03A4C3	|
	ADC.w DATA_03A494,Y			;$03A4C4	|
	STA $AA,X				;$03A4C7	|
	CMP.w DATA_03A496,Y			;$03A4C9	|
	BNE Return03A4D1			;$03A4CC	|
	INC.w $1534,X				;$03A4CE	|
Return03A4D1:
	RTS

CODE_03A4D2:
	LDY.b #$00
	LDA $13					;$03A4D4	|
	AND.b #$E0				;$03A4D6	|
	BNE CODE_03A4E6				;$03A4D8	|
	LDA $13					;$03A4DA	|
	AND.b #$18				;$03A4DC	|
	LSR					;$03A4DE	|
	LSR					;$03A4DF	|
	LSR					;$03A4E0	|
	TAY					;$03A4E1	|
	LDA.w DATA_03A498,Y			;$03A4E2	|
	TAY					;$03A4E5	|
CODE_03A4E6:
	TYA
	STA.w $1570,X				;$03A4E7	|
	RTS					;$03A4EA	|

DATA_03A4EB:
	db $80,$00

CODE_03A4ED:
	LDA $13
	AND.b #$1F				;$03A4EF	|
	BNE Return03A4FC			;$03A4F1	|
	JSR SubHorzPosBnk3			;$03A4F3	|
	LDA.w DATA_03A4EB,Y			;$03A4F6	|
	STA.w $157C,X				;$03A4F9	|
Return03A4FC:
	RTS

CODE_03A4FD:
	LDA.w $14B0
	BNE Return03A52C			;$03A500	|
	LDA.w $151C,X				;$03A502	|
	CMP.b #$08				;$03A505	|
	BNE CODE_03A51A				;$03A507	|
	INC.w $14B8				;$03A509	|
	LDA.w $14B8				;$03A50C	|
	CMP.b #$03				;$03A50F	|
	BEQ CODE_03A51A				;$03A511	|
	LDA.b #$FF				;$03A513	|
	STA.w $14B6				;$03A515	|
	BRA Return03A52C			;$03A518	|

CODE_03A51A:
	STZ.w $14B8
	LDA.w $14C8				;$03A51D	|
	BEQ CODE_03A527				;$03A520	|
	LDA.w $14C9				;$03A522	|
	BNE Return03A52C			;$03A525	|
CODE_03A527:
	LDA.b #$FF
	STA.w $14B1				;$03A529	|
Return03A52C:
	RTS

DATA_03A52D:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$02,$04,$06,$08,$0A,$0E,$0E
	db $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	db $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	db $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	db $0E,$0E,$0A,$08,$06,$04,$02,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
DATA_03A56D:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$10,$20,$30,$40,$50,$60
	db $80,$A0,$C0,$E0,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$C0,$80,$60
	db $40,$30,$20,$10,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00

CODE_03A5AD:
	LDA.w $14B1
	BEQ CODE_03A5D8				;$03A5B0	|
	DEC.w $14B1				;$03A5B2	|
	BNE CODE_03A5BD				;$03A5B5	|
	LDA.b #$54				;$03A5B7	|
	STA.w $14B0				;$03A5B9	|
	RTS					;$03A5BC	|

CODE_03A5BD:
	LSR
	LSR					;$03A5BE	|
	TAY					;$03A5BF	|
	LDA.w DATA_03A52D,Y			;$03A5C0	|
	STA.w $1570,X				;$03A5C3	|
	LDA.w $14B1				;$03A5C6	|
	CMP.b #$80				;$03A5C9	|
	BNE CODE_03A5D5				;$03A5CB	|
	JSR CODE_03B019				;$03A5CD	|
	LDA.b #$08				;$03A5D0	|
	STA.w $1DFC				;$03A5D2	|
CODE_03A5D5:
	PLA
	PLA					;$03A5D6	|
	RTS					;$03A5D7	|

CODE_03A5D8:
	LDA.w $14B6
	BEQ Return03A60D			;$03A5DB	|
	DEC.w $14B6				;$03A5DD	|
	BEQ CODE_03A60E				;$03A5E0	|
	LSR					;$03A5E2	|
	LSR					;$03A5E3	|
	TAY					;$03A5E4	|
	LDA.w DATA_03A52D,Y			;$03A5E5	|
	STA.w $1570,X				;$03A5E8	|
	LDA.w DATA_03A56D,Y			;$03A5EB	|
	STA $36					;$03A5EE	|
	STZ $37					;$03A5F0	|
	CMP.b #$FF				;$03A5F2	|
	BNE CODE_03A5FC				;$03A5F4	|
	STZ $36					;$03A5F6	|
	INC $37					;$03A5F8	|
	STZ $64					;$03A5FA	|
CODE_03A5FC:
	LDA.w $14B6
	CMP.b #$80				;$03A5FF	|
	BNE CODE_03A60B				;$03A601	|
	LDA.b #$09				;$03A603	|
	STA.w $1DFC				;$03A605	|
	JSR CODE_03A61D				;$03A608	|
CODE_03A60B:
	PLA
	PLA					;$03A60C	|
Return03A60D:
	RTS

CODE_03A60E:
	LDA.b #$60
	LDY.w $14B8				;$03A610	|
	CPY.b #$02				;$03A613	|
	BEQ CODE_03A619				;$03A615	|
	LDA.b #$20				;$03A617	|
CODE_03A619:
	STA.w $14B0
	RTS					;$03A61C	|

CODE_03A61D:
	LDA.b #$08
	STA.w $14D0				;$03A61F	|
	LDA.b #$A1				;$03A622	|
	STA $A6					;$03A624	|
	LDA $E4,X				;$03A626	|
	CLC					;$03A628	|
	ADC.b #$08				;$03A629	|
	STA $EC					;$03A62B	|
	LDA.w $14E0,X				;$03A62D	|
	ADC.b #$00				;$03A630	|
	STA.w $14E8				;$03A632	|
	LDA $D8,X				;$03A635	|
	CLC					;$03A637	|
	ADC.b #$40				;$03A638	|
	STA $E0					;$03A63A	|
	LDA.w $14D4,X				;$03A63C	|
	ADC.b #$00				;$03A63F	|
	STA.w $14DC				;$03A641	|
	PHX					;$03A644	|
	LDX.b #$08				;$03A645	|
	JSL InitSpriteTables			;$03A647	|
	PLX					;$03A64B	|
	RTS					;$03A64C	|

DATA_03A64D:
	db $00,$00,$00,$00,$FC,$F8,$F4,$F0
	db $F4,$F8,$FC,$00,$04,$08,$0C,$10
	db $0C,$08,$04,$00

CODE_03A661:
	LDA.w $14B5
	BEQ Return03A6BF			;$03A664	|
	STZ.w $14B1				;$03A666	|
	STZ.w $14B6				;$03A669	|
	DEC.w $14B5				;$03A66C	|
	BNE CODE_03A691				;$03A66F	|
	LDA.b #$50				;$03A671	|
	STA.w $14B0				;$03A673	|
	DEC.w $187B,X				;$03A676	|
	BNE CODE_03A691				;$03A679	|
	LDA.w $151C,X				;$03A67B	|
	CMP.b #$09				;$03A67E	|
	BEQ CODE_03A6C0				;$03A680	|
	LDA.b #$02				;$03A682	|
	STA.w $187B,X				;$03A684	|
	LDA.b #$01				;$03A687	|
	STA.w $151C,X				;$03A689	|
	LDA.b #$80				;$03A68C	|
	STA.w $1540,X				;$03A68E	|
CODE_03A691:
	PLY
	PLY					;$03A692	|
	PHA					;$03A693	|
	LDA.w $14B5				;$03A694	|
	LSR					;$03A697	|
	LSR					;$03A698	|
	TAY					;$03A699	|
	LDA.w DATA_03A64D,Y			;$03A69A	|
	STA $36					;$03A69D	|
	STZ $37					;$03A69F	|
	BPL CODE_03A6A5				;$03A6A1	|
	INC $37					;$03A6A3	|
CODE_03A6A5:
	PLA
	LDY.b #$0C				;$03A6A6	|
	CMP.b #$40				;$03A6A8	|
	BCS CODE_03A6B6				;$03A6AA	|
CODE_03A6AC:
	LDA $13
	LDY.b #$10				;$03A6AE	|
	AND.b #$04				;$03A6B0	|
	BEQ CODE_03A6B6				;$03A6B2	|
	LDY.b #$12				;$03A6B4	|
CODE_03A6B6:
	TYA
	STA.w $1570,X				;$03A6B7	|
	LDA.b #$02				;$03A6BA	|
	STA.w $1427				;$03A6BC	|
Return03A6BF:
	RTS

CODE_03A6C0:
	LDA.b #$04
	STA.w $151C,X				;$03A6C2	|
	STZ $B6,X				;$03A6C5	|
	RTS					;$03A6C7	|

KillMostSprites:
	LDY.b #$09
CODE_03A6CA:
	LDA.w $14C8,Y
	BEQ CODE_03A6EC				;$03A6CD	|
	LDA.w $009E,y				;$03A6CF	|
	CMP.b #$A9				;$03A6D2	|
	BEQ CODE_03A6EC				;$03A6D4	|
	CMP.b #$29				;$03A6D6	|
	BEQ CODE_03A6EC				;$03A6D8	|
	CMP.b #$A0				;$03A6DA	|
	BEQ CODE_03A6EC				;$03A6DC	|
	CMP.b #$C5				;$03A6DE	|
	BEQ CODE_03A6EC				;$03A6E0	|
	LDA.b #$04				;$03A6E2	|
	STA.w $14C8,Y				;$03A6E4	|
	LDA.b #$1F				;$03A6E7	|
	STA.w $1540,Y				;$03A6E9	|
CODE_03A6EC:
	DEY
	BPL CODE_03A6CA				;$03A6ED	|
	RTL					;$03A6EF	|

DATA_03A6F0:
	db $0E,$0E,$0A,$08,$06,$04,$02,$00

CODE_03A6F8:
	LDA.w $1540,X
	BEQ CODE_03A731				;$03A6FB	|
	CMP.b #$01				;$03A6FD	|
	BNE CODE_03A706				;$03A6FF	|
	LDY.b #$17				;$03A701	|
	STY.w $1DFB				;$03A703	|
CODE_03A706:
	LSR
	LSR					;$03A707	|
	LSR					;$03A708	|
	LSR					;$03A709	|
	TAY					;$03A70A	|
	LDA.w DATA_03A6F0,Y			;$03A70B	|
	STA.w $1570,X				;$03A70E	|
	STZ $B6,X				;$03A711	|
	STZ $AA,X				;$03A713	|
	STZ.w $1528,X				;$03A715	|
	STZ.w $1534,X				;$03A718	|
	STZ.w $14B2				;$03A71B	|
	RTS					;$03A71E	|

DATA_03A71F:
	db $01,$FF

DATA_03A721:
	db $10,$80

DATA_03A723:
	db $07,$03

DATA_03A725:
	db $FF,$01

DATA_03A727:
	db $F0,$08

DATA_03A729:
	db $01,$FF

DATA_03A72B:
	db $03,$03

DATA_03A72D:
	db $60,$02

DATA_03A72F:
	db $01,$01

CODE_03A731:
	LDY.w $1528,X
	CPY.b #$02				;$03A734	|
	BCS CODE_03A74F				;$03A736	|
	LDA $13					;$03A738	|
	AND.w DATA_03A723,Y			;$03A73A	|
	BNE CODE_03A74F				;$03A73D	|
	LDA $B6,X				;$03A73F	|
	CLC					;$03A741	|
	ADC.w DATA_03A71F,Y			;$03A742	|
	STA $B6,X				;$03A745	|
	CMP.w DATA_03A721,Y			;$03A747	|
	BNE CODE_03A74F				;$03A74A	|
	INC.w $1528,X				;$03A74C	|
CODE_03A74F:
	LDY.w $1534,X
	CPY.b #$02				;$03A752	|
	BCS CODE_03A76D				;$03A754	|
	LDA $13					;$03A756	|
	AND.w DATA_03A72B,Y			;$03A758	|
	BNE CODE_03A76D				;$03A75B	|
	LDA $AA,X				;$03A75D	|
	CLC					;$03A75F	|
	ADC.w DATA_03A725,Y			;$03A760	|
	STA $AA,X				;$03A763	|
	CMP.w DATA_03A727,Y			;$03A765	|
	BNE CODE_03A76D				;$03A768	|
	INC.w $1534,X				;$03A76A	|
CODE_03A76D:
	LDY.w $14B2
	CPY.b #$02				;$03A770	|
	BEQ CODE_03A794				;$03A772	|
	LDA $13					;$03A774	|
	AND.w DATA_03A72F,Y			;$03A776	|
	BNE CODE_03A78D				;$03A779	|
	LDA $38					;$03A77B	|
	CLC					;$03A77D	|
	ADC.w DATA_03A729,Y			;$03A77E	|
	STA $38					;$03A781	|
	STA $39					;$03A783	|
	CMP.w DATA_03A72D,Y			;$03A785	|
	BNE CODE_03A78D				;$03A788	|
	INC.w $14B2				;$03A78A	|
CODE_03A78D:
	LDA.w $14E0,X
	CMP.b #$FE				;$03A790	|
	BNE Return03A7AC			;$03A792	|
CODE_03A794:
	LDA.b #$03
	STA.w $151C,X				;$03A796	|
	LDA.b #$80				;$03A799	|
	STA.w $14B0				;$03A79B	|
	JSL GetRand				;$03A79E	|
	AND.b #$F0				;$03A7A2	|
	STA.w $14B7				;$03A7A4	|
	LDA.b #$1D				;$03A7A7	|
	STA.w $1DFB				;$03A7A9	|
Return03A7AC:
	RTS

CODE_03A7AD:
	LDA.b #$60
	STA $38					;$03A7AF	|
	STA $39					;$03A7B1	|
	LDA.b #$FF				;$03A7B3	|
	STA.w $14E0,X				;$03A7B5	|
	LDA.b #$60				;$03A7B8	|
	STA $E4,X				;$03A7BA	|
	LDA.w $14B0				;$03A7BC	|
	BNE CODE_03A7DF				;$03A7BF	|
	LDA.b #$18				;$03A7C1	|
	STA.w $1DFB				;$03A7C3	|
	LDA.b #$02				;$03A7C6	|
	STA.w $151C,X				;$03A7C8	|
	LDA.b #$18				;$03A7CB	|
	STA $D8,X				;$03A7CD	|
	LDA.b #$00				;$03A7CF	|
	STA.w $14D4,X				;$03A7D1	|
	LDA.b #$08				;$03A7D4	|
	STA $38					;$03A7D6	|
	STA $39					;$03A7D8	|
	LDA.b #$64				;$03A7DA	|
	STA $B6,X				;$03A7DC	|
	RTS					;$03A7DE	|

CODE_03A7DF:
	CMP.b #$60
	BCS Return03A840			;$03A7E1	|
	LDA $13					;$03A7E3	|
	AND.b #$1F				;$03A7E5	|
	BNE Return03A840			;$03A7E7	|
	LDY.b #$07				;$03A7E9	|
CODE_03A7EB:
	LDA.w $14C8,Y
	BEQ CODE_03A7F6				;$03A7EE	|
	DEY					;$03A7F0	|
	CPY.b #$01				;$03A7F1	|
	BNE CODE_03A7EB				;$03A7F3	|
	RTS					;$03A7F5	|

CODE_03A7F6:
	LDA.b #$17
	STA.w $1DFC				;$03A7F8	|
	LDA.b #$08				;$03A7FB	|
	STA.w $14C8,Y				;$03A7FD	|
	LDA.b #$33				;$03A800	|
	STA.w $009E,y				;$03A802	|
	LDA.w $14B7				;$03A805	|
	PHA					;$03A808	|
	STA.w $00E4,y				;$03A809	|
	CLC					;$03A80C	|
	ADC.b #$20				;$03A80D	|
	STA.w $14B7				;$03A80F	|
	LDA.b #$00				;$03A812	|
	STA.w $14E0,Y				;$03A814	|
	LDA.b #$00				;$03A817	|
	STA.w $00D8,y				;$03A819	|
	STA.w $14D4,Y				;$03A81C	|
	PHX					;$03A81F	|
	TYX					;$03A820	|
	JSL InitSpriteTables			;$03A821	|
	INC $C2,X				;$03A825	|
	ASL.w $1686,X				;$03A827	|
	LSR.w $1686,X				;$03A82A	|
	LDA.b #$39				;$03A82D	|
	STA.w $1662,X				;$03A82F	|
	PLX					;$03A832	|
	PLA					;$03A833	|
	LSR					;$03A834	|
	LSR					;$03A835	|
	LSR					;$03A836	|
	LSR					;$03A837	|
	LSR					;$03A838	|
	TAY					;$03A839	|
	LDA.w BowserSound,Y			;$03A83A	|
	STA.w $1DFC				;$03A83D	|
Return03A840:
	RTS

BowserSound:
	db $2D

BowserSoundMusic:
	db $2E,$2F,$30,$31,$32,$33,$34,$19
	db $1A

CODE_03A84B:
	STZ $AA,X
	LDA.w $1540,X				;$03A84D	|
	BNE CODE_03A86E				;$03A850	|
	LDA $B6,X				;$03A852	|
	BEQ CODE_03A858				;$03A854	|
	DEC $B6,X				;$03A856	|
CODE_03A858:
	LDA $13
	AND.b #$03				;$03A85A	|
	BNE Return03A86D			;$03A85C	|
	INC $38					;$03A85E	|
	INC $39					;$03A860	|
	LDA $38					;$03A862	|
	CMP.b #$20				;$03A864	|
	BNE Return03A86D			;$03A866	|
	LDA.b #$FF				;$03A868	|
	STA.w $1540,X				;$03A86A	|
Return03A86D:
	RTS

CODE_03A86E:
	CMP.b #$A0
	BNE CODE_03A877				;$03A870	|
	PHA					;$03A872	|
	JSR CODE_03A8D6				;$03A873	|
	PLA					;$03A876	|
CODE_03A877:
	STZ $B6,X
	STZ $AA,X				;$03A879	|
	CMP.b #$01				;$03A87B	|
	BEQ CODE_03A89D				;$03A87D	|
	CMP.b #$40				;$03A87F	|
	BCS CODE_03A8AE				;$03A881	|
	CMP.b #$3F				;$03A883	|
	BNE CODE_03A892				;$03A885	|
	PHA					;$03A887	|
	LDY.w $14B4				;$03A888	|
	LDA.w BowserSoundMusic,Y		;$03A88B	|
	STA.w $1DFB				;$03A88E	|
	PLA					;$03A891	|
CODE_03A892:
	LSR
	LSR					;$03A893	|
	LSR					;$03A894	|
	TAY					;$03A895	|
	LDA.w DATA_03A437,Y			;$03A896	|
	STA.w $1570,X				;$03A899	|
	RTS					;$03A89C	|

CODE_03A89D:
	LDA.w $14B4
	INC A					;$03A8A0	|
	STA.w $151C,X				;$03A8A1	|
	STZ $B6,X				;$03A8A4	|
	STZ $AA,X				;$03A8A6	|
	LDA.b #$80				;$03A8A8	|
	STA.w $14B0				;$03A8AA	|
	RTS					;$03A8AD	|

CODE_03A8AE:
	CMP.b #$E8
	BNE CODE_03A8B7				;$03A8B0	|
	LDY.b #$2A				;$03A8B2	|
	STY.w $1DF9				;$03A8B4	|
CODE_03A8B7:
	SEC
	SBC.b #$3F				;$03A8B8	|
	STA.w $1594,X				;$03A8BA	|
	RTS					;$03A8BD	|

DATA_03A8BE:
	db $00,$00,$00,$08,$10,$14,$14,$16
	db $16,$18,$18,$17,$16,$16,$17,$18
	db $18,$17,$14,$10,$0C,$08,$04,$00

CODE_03A8D6:
	LDY.b #$07
CODE_03A8D8:
	LDA.w $14C8,Y
	BEQ CODE_03A8E3				;$03A8DB	|
	DEY					;$03A8DD	|
	CPY.b #$01				;$03A8DE	|
	BNE CODE_03A8D8				;$03A8E0	|
	RTS					;$03A8E2	|

CODE_03A8E3:
	LDA.b #$10
	STA.w $1DF9				;$03A8E5	|
	LDA.b #$08				;$03A8E8	|
	STA.w $14C8,Y				;$03A8EA	|
	LDA.b #$74				;$03A8ED	|
	STA.w $009E,y				;$03A8EF	|
	LDA $E4,X				;$03A8F2	|
	CLC					;$03A8F4	|
	ADC.b #$04				;$03A8F5	|
	STA.w $00E4,y				;$03A8F7	|
	LDA.w $14E0,X				;$03A8FA	|
	ADC.b #$00				;$03A8FD	|
	STA.w $14E0,Y				;$03A8FF	|
	LDA $D8,X				;$03A902	|
	CLC					;$03A904	|
	ADC.b #$18				;$03A905	|
	STA.w $00D8,y				;$03A907	|
	LDA.w $14D4,X				;$03A90A	|
	ADC.b #$00				;$03A90D	|
	STA.w $14D4,Y				;$03A90F	|
	PHX					;$03A912	|
	TYX					;$03A913	|
	JSL InitSpriteTables			;$03A914	|
	LDA.b #$C0				;$03A918	|
	STA $AA,X				;$03A91A	|
	STZ.w $157C,X				;$03A91C	|
	LDY.b #$0C				;$03A91F	|
	LDA $E4,X				;$03A921	|
	BPL CODE_03A92A				;$03A923	|
	LDY.b #$F4				;$03A925	|
	INC.w $157C,X				;$03A927	|
CODE_03A92A:
	STY $B6,X
	PLX					;$03A92C	|
	RTS					;$03A92D	|

DATA_03A92E:
	db $00,$08,$00,$08,$00,$08,$00,$08
	db $00,$08,$00,$08,$00,$08,$00,$08
	db $00,$08,$00,$08,$00,$08,$00,$08
	db $00,$08,$00,$08,$00,$08,$00,$08
	db $00,$08,$00,$08,$00,$08,$00,$08
	db $00,$08,$00,$08,$00,$08,$00,$08
	db $08,$00,$08,$00,$08,$00,$08,$00
	db $08,$00,$08,$00,$08,$00,$08,$00
	db $08,$00,$08,$00,$08,$00,$08,$00
	db $08,$00,$08,$00,$08,$00,$08,$00
DATA_03A97E:
	db $00,$00,$08,$08,$00,$00,$08,$08
	db $00,$00,$08,$08,$00,$00,$08,$08
	db $00,$00,$10,$10,$00,$00,$10,$10
	db $00,$00,$10,$10,$00,$00,$10,$10
	db $00,$00,$10,$10,$00,$00,$10,$10
	db $00,$00,$10,$10,$00,$00,$10,$10
	db $00,$00,$10,$10,$00,$00,$10,$10
	db $00,$00,$10,$10,$00,$00,$10,$10
	db $00,$00,$10,$10,$00,$00,$10,$10
	db $00,$00,$10,$10,$00,$00,$10,$10
DATA_03A9CE:
	db $05,$06,$15,$16,$9D,$9E,$4E,$AE
	db $06,$05,$16,$15,$9E,$9D,$AE,$4E
	db $8A,$8B,$AA,$68,$83,$84,$AA,$68
	db $8A,$8B,$80,$81,$83,$84,$80,$81
	db $85,$86,$A5,$A6,$83,$84,$A5,$A6
	db $82,$83,$A2,$A3,$82,$83,$A2,$A3
	db $8A,$8B,$AA,$68,$83,$84,$AA,$68
	db $8A,$8B,$80,$81,$83,$84,$80,$81
	db $85,$86,$A5,$A6,$83,$84,$A5,$A6
	db $82,$83,$A2,$A3,$82,$83,$A2,$A3
DATA_03AA1E:
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $41,$41,$41,$41,$41,$41,$41,$41
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $00,$00,$00,$00,$01,$01,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $41,$41,$41,$41,$41,$41,$41,$41
	db $41,$41,$41,$41,$41,$41,$41,$41
	db $40,$40,$40,$40,$41,$41,$40,$40
	db $40,$40,$40,$40,$40,$40,$40,$40

CODE_03AA6E:
	LDA $E4,X
	CLC					;$03AA70	|
	ADC.b #$04				;$03AA71	|
	SEC					;$03AA73	|
	SBC $1A					;$03AA74	|
	STA $00					;$03AA76	|
	LDA $D8,X				;$03AA78	|
	CLC					;$03AA7A	|
	ADC.b #$20				;$03AA7B	|
	SEC					;$03AA7D	|
	SBC $02					;$03AA7E	|
	SEC					;$03AA80	|
	SBC $1C					;$03AA81	|
	STA $01					;$03AA83	|
	CPY.b #$08				;$03AA85	|
	BCC CODE_03AAC6				;$03AA87	|
	CPY.b #$10				;$03AA89	|
	BCS CODE_03AAC6				;$03AA8B	|
	LDA $00					;$03AA8D	|
	SEC					;$03AA8F	|
	SBC.b #$04				;$03AA90	|
	STA.w $02A0				;$03AA92	|
	CLC					;$03AA95	|
	ADC.b #$10				;$03AA96	|
	STA.w $02A4				;$03AA98	|
	LDA $01					;$03AA9B	|
	SEC					;$03AA9D	|
	SBC.b #$18				;$03AA9E	|
	STA.w $02A1				;$03AAA0	|
	STA.w $02A5				;$03AAA3	|
	LDA.b #$20				;$03AAA6	|
	STA.w $02A2				;$03AAA8	|
	LDA.b #$22				;$03AAAB	|
	STA.w $02A6				;$03AAAD	|
	LDA $14					;$03AAB0	|
	LSR					;$03AAB2	|
	AND.b #$06				;$03AAB3	|
	INC A					;$03AAB5	|
	INC A					;$03AAB6	|
	INC A					;$03AAB7	|
	STA.w $02A3				;$03AAB8	|
	STA.w $02A7				;$03AABB	|
	LDA.b #$02				;$03AABE	|
	STA.w $0448				;$03AAC0	|
	STA.w $0449				;$03AAC3	|
CODE_03AAC6:
	LDY.b #$70
CODE_03AAC8:
	LDA $03
	ASL					;$03AACA	|
	ASL					;$03AACB	|
	STA $04					;$03AACC	|
	PHX					;$03AACE	|
	LDX.b #$03				;$03AACF	|
CODE_03AAD1:
	PHX
	TXA					;$03AAD2	|
	CLC					;$03AAD3	|
	ADC $04					;$03AAD4	|
	TAX					;$03AAD6	|
	LDA $00					;$03AAD7	|
	CLC					;$03AAD9	|
	ADC.w DATA_03A92E,X			;$03AADA	|
	STA.w $0300,Y				;$03AADD	|
	LDA $01					;$03AAE0	|
	CLC					;$03AAE2	|
	ADC.w DATA_03A97E,X			;$03AAE3	|
	STA.w $0301,Y				;$03AAE6	|
	LDA.w DATA_03A9CE,X			;$03AAE9	|
	STA.w $0302,Y				;$03AAEC	|
	LDA.w DATA_03AA1E,X			;$03AAEF	|
	PHX					;$03AAF2	|
	LDX.w $15E9				;$03AAF3	|
	CPX.b #$09				;$03AAF6	|
	BEQ CODE_03AAFC				;$03AAF8	|
	ORA.b #$30				;$03AAFA	|
CODE_03AAFC:
	STA.w $0303,Y
	PLX					;$03AAFF	|
	PHY					;$03AB00	|
	TYA					;$03AB01	|
	LSR					;$03AB02	|
	LSR					;$03AB03	|
	TAY					;$03AB04	|
	LDA.b #$02				;$03AB05	|
	STA.w $0460,Y				;$03AB07	|
	PLY					;$03AB0A	|
	INY					;$03AB0B	|
	INY					;$03AB0C	|
	INY					;$03AB0D	|
	INY					;$03AB0E	|
	PLX					;$03AB0F	|
	DEX					;$03AB10	|
	BPL CODE_03AAD1				;$03AB11	|
	PLX					;$03AB13	|
	RTS					;$03AB14	|

DATA_03AB15:
	db $01,$FF

DATA_03AB17:
	db $20,$E0

DATA_03AB19:
	db $02,$FE

DATA_03AB1B:
	db $20,$E0,$01,$FF,$10,$F0

CODE_03AB21:
	JSR CODE_03A4FD
	JSR CODE_03A4D2				;$03AB24	|
	JSR CODE_03A4ED				;$03AB27	|
	LDA $13					;$03AB2A	|
	AND.b #$00				;$03AB2C	|
	BNE CODE_03AB4B				;$03AB2E	|
	LDY.b #$00				;$03AB30	|
	LDA $E4,X				;$03AB32	|
	CMP $94					;$03AB34	|
	LDA.w $14E0,X				;$03AB36	|
	SBC $95					;$03AB39	|
	BMI CODE_03AB3E				;$03AB3B	|
	INY					;$03AB3D	|
CODE_03AB3E:
	LDA $B6,X
	CMP.w DATA_03AB17,Y			;$03AB40	|
	BEQ CODE_03AB4B				;$03AB43	|
	CLC					;$03AB45	|
	ADC.w DATA_03AB15,Y			;$03AB46	|
	STA $B6,X				;$03AB49	|
CODE_03AB4B:
	LDY.b #$00
	LDA $D8,X				;$03AB4D	|
	CMP.b #$10				;$03AB4F	|
	BMI CODE_03AB54				;$03AB51	|
	INY					;$03AB53	|
CODE_03AB54:
	LDA $AA,X
	CMP.w DATA_03AB1B,Y			;$03AB56	|
	BEQ Return03AB61			;$03AB59	|
	CLC					;$03AB5B	|
	ADC.w DATA_03AB19,Y			;$03AB5C	|
	STA $AA,X				;$03AB5F	|
Return03AB61:
	RTS

DATA_03AB62:
	db $10,$F0

CODE_03AB64:
	LDA.b #$03
	STA.w $1427				;$03AB66	|
	JSR CODE_03A4FD				;$03AB69	|
	JSR CODE_03A4D2				;$03AB6C	|
	JSR CODE_03A4ED				;$03AB6F	|
	LDA $AA,X				;$03AB72	|
	CLC					;$03AB74	|
	ADC.b #$03				;$03AB75	|
	STA $AA,X				;$03AB77	|
	LDA $D8,X				;$03AB79	|
	CMP.b #$64				;$03AB7B	|
	BCC Return03AB9E			;$03AB7D	|
	LDA.w $14D4,X				;$03AB7F	|
	BMI Return03AB9E			;$03AB82	|
	LDA.b #$64				;$03AB84	|
	STA $D8,X				;$03AB86	|
	LDA.b #$A0				;$03AB88	|
	STA $AA,X				;$03AB8A	|
	LDA.b #$09				;$03AB8C	|
	STA.w $1DFC				;$03AB8E	|
	JSR SubHorzPosBnk3			;$03AB91	|
	LDA.w DATA_03AB62,Y			;$03AB94	|
	STA $B6,X				;$03AB97	|
	LDA.b #$20				;$03AB99	|
	STA.w $1887				;$03AB9B	|
Return03AB9E:
	RTS

CODE_03AB9F:
	JSR CODE_03A6AC
	LDA.w $14D4,X				;$03ABA2	|
	BMI CODE_03ABAF				;$03ABA5	|
	BNE CODE_03ABB9				;$03ABA7	|
	LDA $D8,X				;$03ABA9	|
	CMP.b #$10				;$03ABAB	|
	BCS CODE_03ABB9				;$03ABAD	|
CODE_03ABAF:
	LDA.b #$05
	STA.w $151C,X				;$03ABB1	|
	LDA.b #$60				;$03ABB4	|
	STA.w $1540,X				;$03ABB6	|
CODE_03ABB9:
	LDA.b #$F8
	STA $AA,X				;$03ABBB	|
	RTS					;$03ABBD	|

CODE_03ABBE:
	JSR CODE_03A6AC
	STZ $B6,X				;$03ABC1	|
	STZ $AA,X				;$03ABC3	|
	LDA.w $1540,X				;$03ABC5	|
	BNE CODE_03ABEB				;$03ABC8	|
	LDA $36					;$03ABCA	|
	CLC					;$03ABCC	|
	ADC.b #$0A				;$03ABCD	|
	STA $36					;$03ABCF	|
	LDA $37					;$03ABD1	|
	ADC.b #$00				;$03ABD3	|
	STA $37					;$03ABD5	|
	BEQ Return03ABEA			;$03ABD7	|
	STZ $36					;$03ABD9	|
	LDA.b #$20				;$03ABDB	|
	STA.w $154C,X				;$03ABDD	|
	LDA.b #$60				;$03ABE0	|
	STA.w $1540,X				;$03ABE2	|
	LDA.b #$06				;$03ABE5	|
	STA.w $151C,X				;$03ABE7	|
Return03ABEA:
	RTS

CODE_03ABEB:
	CMP.b #$40
	BCC Return03AC02			;$03ABED	|
	CMP.b #$5E				;$03ABEF	|
	BNE CODE_03ABF8				;$03ABF1	|
	LDY.b #$1B				;$03ABF3	|
	STY.w $1DFB				;$03ABF5	|
CODE_03ABF8:
	LDA.w $1564,X
	BNE Return03AC02			;$03ABFB	|
	LDA.b #$12				;$03ABFD	|
	STA.w $1564,X				;$03ABFF	|
Return03AC02:
	RTS

CODE_03AC03:
	JSR CODE_03A6AC
	LDA.w $154C,X				;$03AC06	|
	CMP.b #$01				;$03AC09	|
	BNE CODE_03AC22				;$03AC0B	|
	LDA.b #$0B				;$03AC0D	|
	STA $71					;$03AC0F	|
	INC.w $190D				;$03AC11	|
	STZ.w $0701				;$03AC14	|
	STZ.w $0702				;$03AC17	|
	LDA.b #$03				;$03AC1A	|
	STA.w $13F9				;$03AC1C	|
	JSR CODE_03AC63				;$03AC1F	|
CODE_03AC22:
	LDA.w $1540,X
	BNE Return03AC4C			;$03AC25	|
	LDA.b #$FA				;$03AC27	|
	STA $B6,X				;$03AC29	|
	LDA.b #$FC				;$03AC2B	|
	STA $AA,X				;$03AC2D	|
	LDA $36					;$03AC2F	|
	CLC					;$03AC31	|
	ADC.b #$05				;$03AC32	|
	STA $36					;$03AC34	|
	LDA $37					;$03AC36	|
	ADC.b #$00				;$03AC38	|
	STA $37					;$03AC3A	|
	LDA $13					;$03AC3C	|
	AND.b #$03				;$03AC3E	|
	BNE Return03AC4C			;$03AC40	|
	LDA $38					;$03AC42	|
	CMP.b #$80				;$03AC44	|
	BCS CODE_03AC4D				;$03AC46	|
	INC $38					;$03AC48	|
	INC $39					;$03AC4A	|
Return03AC4C:
	RTS

CODE_03AC4D:
	LDA.w $164A,X
	BNE CODE_03AC5A				;$03AC50	|
	LDA.b #$1C				;$03AC52	|
	STA.w $1DFB				;$03AC54	|
	INC.w $164A,X				;$03AC57	|
CODE_03AC5A:
	LDA.b #$FE
	STA.w $14E0,X				;$03AC5C	|
	STA.w $14D4,X				;$03AC5F	|
	RTS					;$03AC62	|

CODE_03AC63:
	LDA.b #$08
	STA.w $14D0				;$03AC65	|
	LDA.b #$7C				;$03AC68	|
	STA $A6					;$03AC6A	|
	LDA $E4,X				;$03AC6C	|
	CLC					;$03AC6E	|
	ADC.b #$08				;$03AC6F	|
	STA $EC					;$03AC71	|
	LDA.w $14E0,X				;$03AC73	|
	ADC.b #$00				;$03AC76	|
	STA.w $14E8				;$03AC78	|
	LDA $D8,X				;$03AC7B	|
	CLC					;$03AC7D	|
	ADC.b #$47				;$03AC7E	|
	STA $E0					;$03AC80	|
	LDA.w $14D4,X				;$03AC82	|
	ADC.b #$00				;$03AC85	|
	STA.w $14DC				;$03AC87	|
	PHX					;$03AC8A	|
	LDX.b #$08				;$03AC8B	|
	JSL InitSpriteTables			;$03AC8D	|
	PLX					;$03AC91	|
	RTS					;$03AC92	|

BlushTileDispY:
	db $01,$11

BlushTiles:
	db $6E,$88

PrincessPeach:
	LDA $E4,X
	SEC					;$03AC99	|
	SBC $1A					;$03AC9A	|
	STA $00					;$03AC9C	|
	LDA $D8,X				;$03AC9E	|
	SEC					;$03ACA0	|
	SBC $1C					;$03ACA1	|
	STA $01					;$03ACA3	|
	LDA $13					;$03ACA5	|
	AND.b #$7F				;$03ACA7	|
	BNE CODE_03ACB8				;$03ACA9	|
	JSL GetRand				;$03ACAB	|
	AND.b #$07				;$03ACAF	|
	BNE CODE_03ACB8				;$03ACB1	|
	LDA.b #$0C				;$03ACB3	|
	STA.w $154C,X				;$03ACB5	|
CODE_03ACB8:
	LDY.w $1602,X
	LDA.w $154C,X				;$03ACBB	|
	BEQ CODE_03ACC1				;$03ACBE	|
	INY					;$03ACC0	|
CODE_03ACC1:
	LDA.w $157C,X
	BNE CODE_03ACCB				;$03ACC4	|
	TYA					;$03ACC6	|
	CLC					;$03ACC7	|
	ADC.b #$08				;$03ACC8	|
	TAY					;$03ACCA	|
CODE_03ACCB:
	STY $03
	LDA.b #$D0				;$03ACCD	|
	STA.w $15EA,X				;$03ACCF	|
	TAY					;$03ACD2	|
	JSR CODE_03AAC8				;$03ACD3	|
	LDY.b #$02				;$03ACD6	|
	LDA.b #$03				;$03ACD8	|
	JSL FinishOAMWrite			;$03ACDA	|
	LDA.w $1558,X				;$03ACDE	|
	BEQ CODE_03AD18				;$03ACE1	|
	PHX					;$03ACE3	|
	LDX.b #$00				;$03ACE4	|
	LDA $19					;$03ACE6	|
	BNE CODE_03ACEB				;$03ACE8	|
	INX					;$03ACEA	|
CODE_03ACEB:
	LDY.b #$4C
	LDA $7E					;$03ACED	|
	STA.w $0300,Y				;$03ACEF	|
	LDA $80					;$03ACF2	|
	CLC					;$03ACF4	|
	ADC.w BlushTileDispY,X			;$03ACF5	|
	STA.w $0301,Y				;$03ACF8	|
	LDA.w BlushTiles,X			;$03ACFB	|
	STA.w $0302,Y				;$03ACFE	|
	PLX					;$03AD01	|
	LDA $76					;$03AD02	|
	CMP.b #$01				;$03AD04	|
	LDA.b #$31				;$03AD06	|
	BCC CODE_03AD0C				;$03AD08	|
	ORA.b #$40				;$03AD0A	|
CODE_03AD0C:
	STA.w $0303,Y
	TYA					;$03AD0F	|
	LSR					;$03AD10	|
	LSR					;$03AD11	|
	TAY					;$03AD12	|
	LDA.b #$02				;$03AD13	|
	STA.w $0460,Y				;$03AD15	|
CODE_03AD18:
	STZ $B6,X
	STZ $7B					;$03AD1A	|
	LDA.b #$04				;$03AD1C	|
	STA.w $1602,X				;$03AD1E	|
	LDA $C2,X				;$03AD21	|
	JSL execute_pointer			;$03AD23	|

PeachPtrs:
	dw CODE_03AD37
	dw CODE_03ADB3
	dw CODE_03ADDD
	dw CODE_03AE25
	dw CODE_03AE32
	dw CODE_03AEAF
	dw CODE_03AEE8
	dw CODE_03C796

CODE_03AD37:
	LDA.b #$06
	STA.w $1602,X				;$03AD39	|
	JSL UpdateYPosNoGrvty			;$03AD3C	|
	LDA $AA,X				;$03AD40	|
	CMP.b #$08				;$03AD42	|
	BCS CODE_03AD4B				;$03AD44	|
	CLC					;$03AD46	|
	ADC.b #$01				;$03AD47	|
	STA $AA,X				;$03AD49	|
CODE_03AD4B:
	LDA.w $14D4,X
	BMI CODE_03AD63				;$03AD4E	|
	LDA $D8,X				;$03AD50	|
	CMP.b #$A0				;$03AD52	|
	BCC CODE_03AD63				;$03AD54	|
	LDA.b #$A0				;$03AD56	|
	STA $D8,X				;$03AD58	|
	STZ $AA,X				;$03AD5A	|
	LDA.b #$A0				;$03AD5C	|
	STA.w $1540,X				;$03AD5E	|
	INC $C2,X				;$03AD61	|
CODE_03AD63:
	LDA $13
	AND.b #$07				;$03AD65	|
	BNE Return03AD73			;$03AD67	|
	LDY.b #$0B				;$03AD69	|
CODE_03AD6B:
	LDA.w $17F0,Y
	BEQ CODE_03AD74				;$03AD6E	|
	DEY					;$03AD70	|
	BPL CODE_03AD6B				;$03AD71	|
Return03AD73:
	RTS

CODE_03AD74:
	LDA.b #$05
	STA.w $17F0,Y				;$03AD76	|
	JSL GetRand				;$03AD79	|
	STZ $00					;$03AD7D	|
	AND.b #$1F				;$03AD7F	|
	CLC					;$03AD81	|
	ADC.b #$F8				;$03AD82	|
	BPL CODE_03AD88				;$03AD84	|
	DEC $00					;$03AD86	|
CODE_03AD88:
	CLC
	ADC $E4,X				;$03AD89	|
	STA.w $1808,Y				;$03AD8B	|
	LDA.w $14E0,X				;$03AD8E	|
	ADC $00					;$03AD91	|
	STA.w $18EA,Y				;$03AD93	|
	LDA.w $148E				;$03AD96	|
	AND.b #$1F				;$03AD99	|
	ADC $D8,X				;$03AD9B	|
	STA.w $17FC,Y				;$03AD9D	|
	LDA.w $14D4,X				;$03ADA0	|
	ADC.b #$00				;$03ADA3	|
	STA.w $1814,Y				;$03ADA5	|
	LDA.b #$00				;$03ADA8	|
	STA.w $1820,Y				;$03ADAA	|
	LDA.b #$17				;$03ADAD	|
	STA.w $1850,Y				;$03ADAF	|
	RTS					;$03ADB2	|

CODE_03ADB3:
	LDA.w $1540,X
	BNE CODE_03ADC2				;$03ADB6	|
	INC $C2,X				;$03ADB8	|
	JSR CODE_03ADCC				;$03ADBA	|
	BCC CODE_03ADC2				;$03ADBD	|
	INC.w $151C,X				;$03ADBF	|
CODE_03ADC2:
	JSR SubHorzPosBnk3
	TYA					;$03ADC5	|
	STA.w $157C,X				;$03ADC6	|
	STA $76					;$03ADC9	|
	RTS					;$03ADCB	|

CODE_03ADCC:
	JSL GetSpriteClippingA
	JSL GetMarioClipping			;$03ADD0	|
	JSL CheckForContact			;$03ADD4	|
	RTS					;$03ADD8	|

DATA_03ADD9:
	db $08,$F8,$F8,$08

CODE_03ADDD:
	LDA $14
	AND.b #$08				;$03ADDF	|
	BNE CODE_03ADE8				;$03ADE1	|
	LDA.b #$08				;$03ADE3	|
	STA.w $1602,X				;$03ADE5	|
CODE_03ADE8:
	JSR CODE_03ADCC
	PHP					;$03ADEB	|
	JSR SubHorzPosBnk3			;$03ADEC	|
	PLP					;$03ADEF	|
	LDA.w $151C,X				;$03ADF0	|
	BNE ADDR_03ADF9				;$03ADF3	|
	BCS CODE_03AE14				;$03ADF5	|
	BRA CODE_03ADFF				;$03ADF7	|

ADDR_03ADF9:
	BCC CODE_03AE14
	TYA					;$03ADFB	|
	EOR.b #$01				;$03ADFC	|
	TAY					;$03ADFE	|
CODE_03ADFF:
	LDA.w DATA_03ADD9,Y
	STA $B6,X				;$03AE02	|
	EOR.b #$FF				;$03AE04	|
	INC A					;$03AE06	|
	STA $7B					;$03AE07	|
	TYA					;$03AE09	|
	STA.w $157C,X				;$03AE0A	|
	STA $76					;$03AE0D	|
	JSL UpdateXPosNoGrvty			;$03AE0F	|
	RTS					;$03AE13	|

CODE_03AE14:
	JSR SubHorzPosBnk3
	TYA					;$03AE17	|
	STA.w $157C,X				;$03AE18	|
	STA $76					;$03AE1B	|
	INC $C2,X				;$03AE1D	|
	LDA.b #$60				;$03AE1F	|
	STA.w $1540,X				;$03AE21	|
	RTS					;$03AE24	|

CODE_03AE25:
	LDA.w $1540,X
	BNE Return03AE31			;$03AE28	|
	INC $C2,X				;$03AE2A	|
	LDA.b #$A0				;$03AE2C	|
	STA.w $1540,X				;$03AE2E	|
Return03AE31:
	RTS

CODE_03AE32:
	LDA.w $1540,X
	BNE CODE_03AE3F				;$03AE35	|
	INC $C2,X				;$03AE37	|
	STZ.w $188A				;$03AE39	|
	STZ.w $188B				;$03AE3C	|
CODE_03AE3F:
	CMP.b #$50
	BCC Return03AE5A			;$03AE41	|
	PHA					;$03AE43	|
	BNE CODE_03AE4B				;$03AE44	|
	LDA.b #$14				;$03AE46	|
	STA.w $154C,X				;$03AE48	|
CODE_03AE4B:
	LDA.b #$0A
	STA.w $1602,X				;$03AE4D	|
	PLA					;$03AE50	|
	CMP.b #$68				;$03AE51	|
	BNE Return03AE5A			;$03AE53	|
	LDA.b #$80				;$03AE55	|
	STA.w $1558,X				;$03AE57	|
Return03AE5A:
	RTS

DATA_03AE5B:
	db $08,$08,$08,$08,$08,$08,$18,$08
	db $08,$08,$08,$08,$08,$08,$08,$08
	db $08,$08,$08,$08,$08,$08,$20,$08
	db $08,$08,$08,$08,$20,$08,$08,$10
	db $08,$08,$08,$08,$08,$08,$08,$08
	db $20,$08,$08,$08,$08,$08,$20,$08
	db $04,$20,$08,$08,$08,$08,$08,$08
	db $08,$08,$08,$08,$08,$08,$10,$08
	db $08,$08,$08,$08,$08,$08,$08,$08
	db $08,$08,$10,$08,$08,$08,$08,$08
	db $08,$08,$08,$40

CODE_03AEAF:
	JSR CODE_03D674
	LDA.w $1540,X				;$03AEB2	|
	BNE Return03AEC7			;$03AEB5	|
	LDY.w $1921				;$03AEB7	|
	CPY.b #$54				;$03AEBA	|
	BEQ CODE_03AEC8				;$03AEBC	|
	INC.w $1921				;$03AEBE	|
	LDA.w DATA_03AE5B,Y			;$03AEC1	|
	STA.w $1540,X				;$03AEC4	|
Return03AEC7:
	RTS

CODE_03AEC8:
	INC $C2,X
	LDA.b #$40				;$03AECA	|
	STA.w $1540,X				;$03AECC	|
	RTS					;$03AECF	|

CODE_03AED0:
	INC $C2,X
	LDA.b #$80				;$03AED2	|
	STA.w $1FEB				;$03AED4	|
	RTS					;$03AED7	|

DATA_03AED8:
	db $00,$00,$94,$18,$18,$9C,$9C,$FF
	db $00,$00,$52,$63,$63,$73,$73,$7F

CODE_03AEE8:
	LDA.w $1540,X
	BEQ CODE_03AED0				;$03AEEB	|
	LSR					;$03AEED	|
	STA $00					;$03AEEE	|
	STZ $01					;$03AEF0	|
	REP #$20				;$03AEF2	|
	LDA $00					;$03AEF4	|
	ASL					;$03AEF6	|
	ASL					;$03AEF7	|
	ASL					;$03AEF8	|
	ASL					;$03AEF9	|
	ASL					;$03AEFA	|
	ORA $00					;$03AEFB	|
	STA $00					;$03AEFD	|
	ASL					;$03AEFF	|
	ASL					;$03AF00	|
	ASL					;$03AF01	|
	ASL					;$03AF02	|
	ASL					;$03AF03	|
	ORA $00					;$03AF04	|
	STA $00					;$03AF06	|
	SEP #$20				;$03AF08	|
	PHX					;$03AF0A	|
	TAX					;$03AF0B	|
	LDY.w $0681				;$03AF0C	|
	LDA.b #$02				;$03AF0F	|
	STA.w $0682,Y				;$03AF11	|
	LDA.b #$F1				;$03AF14	|
	STA.w $0683,Y				;$03AF16	|
	LDA $00					;$03AF19	|
	STA.w $0684,Y				;$03AF1B	|
	LDA $01					;$03AF1E	|
	STA.w $0685,Y				;$03AF20	|
	LDA.b #$00				;$03AF23	|
	STA.w $0686,Y				;$03AF25	|
	TYA					;$03AF28	|
	CLC					;$03AF29	|
	ADC.b #$04				;$03AF2A	|
	STA.w $0681				;$03AF2C	|
	PLX					;$03AF2F	|
	JSR CODE_03D674				;$03AF30	|
	RTS					;$03AF33	|

DATA_03AF34:
	db $F4,$FF,$0C,$19,$24,$19,$0C,$FF
DATA_03AF3C:
	db $FC,$F6,$F4,$F6,$FC,$02,$04,$02
DATA_03AF44:
	db $05,$05,$05,$05,$45,$45,$45,$45
DATA_03AF4C:
	db $34,$34,$34,$35,$35,$36,$36,$37
	db $38,$3A,$3E,$46,$54

CODE_03AF59:
	JSR GetDrawInfoBnk3
	LDA.w $157C,X				;$03AF5C	|
	STA $04					;$03AF5F	|
	LDA $14					;$03AF61	|
	LSR					;$03AF63	|
	LSR					;$03AF64	|
	AND.b #$07				;$03AF65	|
	STA $02					;$03AF67	|
	LDA.b #$EC				;$03AF69	|
	STA.w $15EA,X				;$03AF6B	|
	TAY					;$03AF6E	|
	PHX					;$03AF6F	|
	LDX.b #$03				;$03AF70	|
CODE_03AF72:
	PHX
	TXA					;$03AF73	|
	ASL					;$03AF74	|
	ASL					;$03AF75	|
	ADC $02					;$03AF76	|
	AND.b #$07				;$03AF78	|
	TAX					;$03AF7A	|
	LDA $00					;$03AF7B	|
	CLC					;$03AF7D	|
	ADC.w DATA_03AF34,X			;$03AF7E	|
	STA.w $0300,Y				;$03AF81	|
	LDA $01					;$03AF84	|
	CLC					;$03AF86	|
	ADC.w DATA_03AF3C,X			;$03AF87	|
	STA.w $0301,Y				;$03AF8A	|
	LDA.b #$59				;$03AF8D	|
	STA.w $0302,Y				;$03AF8F	|
	LDA.w DATA_03AF44,X			;$03AF92	|
	ORA $64					;$03AF95	|
	STA.w $0303,Y				;$03AF97	|
	PLX					;$03AF9A	|
	INY					;$03AF9B	|
	INY					;$03AF9C	|
	INY					;$03AF9D	|
	INY					;$03AF9E	|
	DEX					;$03AF9F	|
	BPL CODE_03AF72				;$03AFA0	|
	LDA.w $14B3				;$03AFA2	|
	INC.w $14B3				;$03AFA5	|
	LSR					;$03AFA8	|
	LSR					;$03AFA9	|
	LSR					;$03AFAA	|
	CMP.b #$0D				;$03AFAB	|
	BCS CODE_03AFD7				;$03AFAD	|
	TAX					;$03AFAF	|
	LDY.b #$FC				;$03AFB0	|
	LDA $04					;$03AFB2	|
	ASL					;$03AFB4	|
	ROL					;$03AFB5	|
	ASL					;$03AFB6	|
	ASL					;$03AFB7	|
	ASL					;$03AFB8	|
	ADC $00					;$03AFB9	|
	CLC					;$03AFBB	|
	ADC.b #$15				;$03AFBC	|
	STA.w $0300,Y				;$03AFBE	|
	LDA $01					;$03AFC1	|
	CLC					;$03AFC3	|
	ADC.l DATA_03AF4C,X			;$03AFC4	|
	STA.w $0301,Y				;$03AFC8	|
	LDA.b #$49				;$03AFCB	|
	STA.w $0302,Y				;$03AFCD	|
	LDA.b #$07				;$03AFD0	|
	ORA $64					;$03AFD2	|
	STA.w $0303,Y				;$03AFD4	|
CODE_03AFD7:
	PLX
	LDY.b #$00				;$03AFD8	|
	LDA.b #$04				;$03AFDA	|
	JSL FinishOAMWrite			;$03AFDC	|
	LDY.w $15EA,X				;$03AFE0	|
	PHX					;$03AFE3	|
	LDX.b #$04				;$03AFE4	|
CODE_03AFE6:
	LDA.w $0300,Y
	STA.w $0200,Y				;$03AFE9	|
	LDA.w $0301,Y				;$03AFEC	|
	STA.w $0201,Y				;$03AFEF	|
	LDA.w $0302,Y				;$03AFF2	|
	STA.w $0202,Y				;$03AFF5	|
	LDA.w $0303,Y				;$03AFF8	|
	STA.w $0203,Y				;$03AFFB	|
	PHY					;$03AFFE	|
	TYA					;$03AFFF	|
	LSR					;$03B000	|
	LSR					;$03B001	|
	TAY					;$03B002	|
	LDA.w $0460,Y				;$03B003	|
	STA.w $0420,Y				;$03B006	|
	PLY					;$03B009	|
	INY					;$03B00A	|
	INY					;$03B00B	|
	INY					;$03B00C	|
	INY					;$03B00D	|
	DEX					;$03B00E	|
	BPL CODE_03AFE6				;$03B00F	|
	PLX					;$03B011	|
	RTS					;$03B012	|

DATA_03B013:
	db $00,$10

DATA_03B015:
	db $00,$00

DATA_03B017:
	db $F8,$08

CODE_03B019:
	STZ $02
	JSR CODE_03B020				;$03B01B	|
	INC $02					;$03B01E	|
CODE_03B020:
	LDY.b #$01
CODE_03B022:
	LDA.w $14C8,Y
	BEQ CODE_03B02B				;$03B025	|
	DEY					;$03B027	|
	BPL CODE_03B022				;$03B028	|
	RTS					;$03B02A	|

CODE_03B02B:
	LDA.b #$08
	STA.w $14C8,Y				;$03B02D	|
	LDA.b #$A2				;$03B030	|
	STA.w $009E,y				;$03B032	|
	LDA $D8,X				;$03B035	|
	CLC					;$03B037	|
	ADC.b #$10				;$03B038	|
	STA.w $00D8,y				;$03B03A	|
	LDA.w $14D4,X				;$03B03D	|
	ADC.b #$00				;$03B040	|
	STA.w $14D4,Y				;$03B042	|
	LDA $E4,X				;$03B045	|
	STA $00					;$03B047	|
	LDA.w $14E0,X				;$03B049	|
	STA $01					;$03B04C	|
	PHX					;$03B04E	|
	LDX $02					;$03B04F	|
	LDA $00					;$03B051	|
	CLC					;$03B053	|
	ADC.w DATA_03B013,X			;$03B054	|
	STA.w $00E4,y				;$03B057	|
	LDA $01					;$03B05A	|
	ADC.w DATA_03B015,X			;$03B05C	|
	STA.w $14E0,Y				;$03B05F	|
	TYX					;$03B062	|
	JSL InitSpriteTables			;$03B063	|
	LDY $02					;$03B067	|
	LDA.w DATA_03B017,Y			;$03B069	|
	STA $B6,X				;$03B06C	|
	LDA.b #$C0				;$03B06E	|
	STA $AA,X				;$03B070	|
	PLX					;$03B072	|
	RTS					;$03B073	|

DATA_03B074:
	db $40,$C0

DATA_03B076:
	db $10,$F0

CODE_03B078:
	LDA $38
	CMP.b #$20				;$03B07A	|
	BNE Return03B0DB			;$03B07C	|
	LDA.w $151C,X				;$03B07E	|
	CMP.b #$07				;$03B081	|
	BCC Return03B0F2			;$03B083	|
	LDA $36					;$03B085	|
	ORA $37					;$03B087	|
	BNE Return03B0F2			;$03B089	|
	JSR CODE_03B0DC				;$03B08B	|
	LDA.w $154C,X				;$03B08E	|
	BNE Return03B0DB			;$03B091	|
	LDA.b #$24				;$03B093	|
	STA.w $1662,X				;$03B095	|
	JSL MarioSprInteract			;$03B098	|
	BCC CODE_03B0BD				;$03B09C	|
	JSR CODE_03B0D6				;$03B09E	|
	STZ $7D					;$03B0A1	|
	JSR SubHorzPosBnk3			;$03B0A3	|
	LDA.w $14B1				;$03B0A6	|
	ORA.w $14B6				;$03B0A9	|
	BEQ CODE_03B0B3				;$03B0AC	|
	LDA.w DATA_03B076,Y			;$03B0AE	|
	BRA CODE_03B0B6				;$03B0B1	|

CODE_03B0B3:
	LDA.w DATA_03B074,Y
CODE_03B0B6:
	STA $7B
	LDA.b #$01				;$03B0B8	|
	STA.w $1DF9				;$03B0BA	|
CODE_03B0BD:
	INC.w $1662,X
	JSL MarioSprInteract			;$03B0C0	|
	BCC CODE_03B0C9				;$03B0C4	|
	JSR CODE_03B0D2				;$03B0C6	|
CODE_03B0C9:
	INC.w $1662,X
	JSL MarioSprInteract			;$03B0CC	|
	BCC Return03B0DB			;$03B0D0	|
CODE_03B0D2:
	JSL HurtMario
CODE_03B0D6:
	LDA.b #$20
	STA.w $154C,X				;$03B0D8	|
Return03B0DB:
	RTS

CODE_03B0DC:
	LDY.b #$01
CODE_03B0DE:
	PHY
	LDA.w $14C8,Y				;$03B0DF	|
	CMP.b #$09				;$03B0E2	|
	BNE CODE_03B0EE				;$03B0E4	|
	LDA.w $15A0,Y				;$03B0E6	|
	BNE CODE_03B0EE				;$03B0E9	|
	JSR CODE_03B0F3				;$03B0EB	|
CODE_03B0EE:
	PLY
	DEY					;$03B0EF	|
	BPL CODE_03B0DE				;$03B0F0	|
Return03B0F2:
	RTS

CODE_03B0F3:
	PHX
	TYX					;$03B0F4	|
	JSL GetSpriteClippingB			;$03B0F5	|
	PLX					;$03B0F9	|
	LDA.b #$24				;$03B0FA	|
	STA.w $1662,X				;$03B0FC	|
	JSL GetSpriteClippingA			;$03B0FF	|
	JSL CheckForContact			;$03B103	|
	BCS CODE_03B142				;$03B107	|
	INC.w $1662,X				;$03B109	|
	JSL GetSpriteClippingA			;$03B10C	|
	JSL CheckForContact			;$03B110	|
	BCC Return03B160			;$03B114	|
	LDA.w $14B5				;$03B116	|
	BNE Return03B160			;$03B119	|
	LDA.b #$4C				;$03B11B	|
	STA.w $14B5				;$03B11D	|
	STZ.w $14B3				;$03B120	|
	LDA.w $151C,X				;$03B123	|
	STA.w $14B4				;$03B126	|
	LDA.b #$28				;$03B129	|
	STA.w $1DFC				;$03B12B	|
	LDA.w $151C,X				;$03B12E	|
	CMP.b #$09				;$03B131	|
	BNE CODE_03B142				;$03B133	|
	LDA.w $187B,X				;$03B135	|
	CMP.b #$01				;$03B138	|
	BNE CODE_03B142				;$03B13A	|
	PHY					;$03B13C	|
	JSL KillMostSprites			;$03B13D	|
	PLY					;$03B141	|
CODE_03B142:
	LDA.b #$00
	STA.w $00B6,y				;$03B144	|
	PHX					;$03B147	|
	LDX.b #$10				;$03B148	|
	LDA.w $00AA,y				;$03B14A	|
	BMI CODE_03B151				;$03B14D	|
	LDX.b #$D0				;$03B14F	|
CODE_03B151:
	TXA
	STA.w $00AA,y				;$03B152	|
	LDA.b #$02				;$03B155	|
	STA.w $14C8,Y				;$03B157	|
	TYX					;$03B15A	|
	JSL CODE_01AB6F				;$03B15B	|
	PLX					;$03B15F	|
Return03B160:
	RTS

BowserBallSpeed:
	db $10,$F0

BowserBowlingBall:
	JSR BowserBallGfx
	LDA $9D					;$03B166	|
	BNE Return03B1D4			;$03B168	|
	JSR SubOffscreen0Bnk3			;$03B16A	|
	JSL MarioSprInteract			;$03B16D	|
	JSL UpdateXPosNoGrvty			;$03B171	|
	JSL UpdateYPosNoGrvty			;$03B175	|
	LDA $AA,X				;$03B179	|
	CMP.b #$40				;$03B17B	|
	BPL CODE_03B186				;$03B17D	|
	CLC					;$03B17F	|
	ADC.b #$03				;$03B180	|
	STA $AA,X				;$03B182	|
	BRA CODE_03B18A				;$03B184	|

CODE_03B186:
	LDA.b #$40
	STA $AA,X				;$03B188	|
CODE_03B18A:
	LDA $AA,X
	BMI CODE_03B1C5				;$03B18C	|
	LDA.w $14D4,X				;$03B18E	|
	BMI CODE_03B1C5				;$03B191	|
	LDA $D8,X				;$03B193	|
	CMP.b #$B0				;$03B195	|
	BCC CODE_03B1C5				;$03B197	|
	LDA.b #$B0				;$03B199	|
	STA $D8,X				;$03B19B	|
	LDA $AA,X				;$03B19D	|
	CMP.b #$3E				;$03B19F	|
	BCC CODE_03B1AD				;$03B1A1	|
	LDY.b #$25				;$03B1A3	|
	STY.w $1DFC				;$03B1A5	|
	LDY.b #$20				;$03B1A8	|
	STY.w $1887				;$03B1AA	|
CODE_03B1AD:
	CMP.b #$08
	BCC CODE_03B1B6				;$03B1AF	|
	LDA.b #$01				;$03B1B1	|
	STA.w $1DF9				;$03B1B3	|
CODE_03B1B6:
	JSR CODE_03B7F8
	LDA $B6,X				;$03B1B9	|
	BNE CODE_03B1C5				;$03B1BB	|
	JSR SubHorzPosBnk3			;$03B1BD	|
	LDA.w BowserBallSpeed,Y			;$03B1C0	|
	STA $B6,X				;$03B1C3	|
CODE_03B1C5:
	LDA $B6,X
	BEQ Return03B1D4			;$03B1C7	|
	BMI CODE_03B1D1				;$03B1C9	|
	DEC.w $1570,X				;$03B1CB	|
	DEC.w $1570,X				;$03B1CE	|
CODE_03B1D1:
	INC.w $1570,X
Return03B1D4:
	RTS

BowserBallDispX:
	db $F0,$00,$10,$F0,$00,$10,$F0,$00
	db $10,$00,$00,$F8

BowserBallDispY:
	db $E2,$E2,$E2,$F2,$F2,$F2,$02,$02
	db $02,$02,$02,$EA

BowserBallTiles:
	db $45,$47,$45,$65,$66,$65,$45,$47
	db $45,$39,$38,$63

BowserBallGfxProp:
	db $0D,$0D,$4D,$0D,$0D,$4D,$8D,$8D
	db $CD,$0D,$0D,$0D

BowserBallTileSize:
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $02,$00,$00,$02

BowserBallDispX2:
	db $04,$0D,$10,$0D,$04,$FB,$F8,$FB
BowserBallDispY2:
	db $00,$FD,$F4,$EB,$E8,$EB,$F4,$FD

BowserBallGfx:
	LDA.b #$70
	STA.w $15EA,X				;$03B223	|
	JSR GetDrawInfoBnk3			;$03B226	|
	PHX					;$03B229	|
	LDX.b #$0B				;$03B22A	|
CODE_03B22C:
	LDA $00
	CLC					;$03B22E	|
	ADC.w BowserBallDispX,X			;$03B22F	|
	STA.w $0300,Y				;$03B232	|
	LDA $01					;$03B235	|
	CLC					;$03B237	|
	ADC.w BowserBallDispY,X			;$03B238	|
	STA.w $0301,Y				;$03B23B	|
	LDA.w BowserBallTiles,X			;$03B23E	|
	STA.w $0302,Y				;$03B241	|
	LDA.w BowserBallGfxProp,X		;$03B244	|
	ORA $64					;$03B247	|
	STA.w $0303,Y				;$03B249	|
	PHY					;$03B24C	|
	TYA					;$03B24D	|
	LSR					;$03B24E	|
	LSR					;$03B24F	|
	TAY					;$03B250	|
	LDA.w BowserBallTileSize,X		;$03B251	|
	STA.w $0460,Y				;$03B254	|
	PLY					;$03B257	|
	INY					;$03B258	|
	INY					;$03B259	|
	INY					;$03B25A	|
	INY					;$03B25B	|
	DEX					;$03B25C	|
	BPL CODE_03B22C				;$03B25D	|
	PLX					;$03B25F	|
	PHX					;$03B260	|
	LDY.w $15EA,X				;$03B261	|
	LDA.w $1570,X				;$03B264	|
	LSR					;$03B267	|
	LSR					;$03B268	|
	LSR					;$03B269	|
	AND.b #$07				;$03B26A	|
	PHA					;$03B26C	|
	TAX					;$03B26D	|
	LDA.w $0304,Y				;$03B26E	|
	CLC					;$03B271	|
	ADC.w BowserBallDispX2,X		;$03B272	|
	STA.w $0304,Y				;$03B275	|
	LDA.w $0305,Y				;$03B278	|
	CLC					;$03B27B	|
	ADC.w BowserBallDispY2,X		;$03B27C	|
	STA.w $0305,Y				;$03B27F	|
	PLA					;$03B282	|
	CLC					;$03B283	|
	ADC.b #$02				;$03B284	|
	AND.b #$07				;$03B286	|
	TAX					;$03B288	|
	LDA.w $0308,Y				;$03B289	|
	CLC					;$03B28C	|
	ADC.w BowserBallDispX2,X		;$03B28D	|
	STA.w $0308,Y				;$03B290	|
	LDA.w $0309,Y				;$03B293	|
	CLC					;$03B296	|
	ADC.w BowserBallDispY2,X		;$03B297	|
	STA.w $0309,Y				;$03B29A	|
	PLX					;$03B29D	|
	LDA.b #$0B				;$03B29E	|
	LDY.b #$FF				;$03B2A0	|
	JSL FinishOAMWrite			;$03B2A2	|
	RTS					;$03B2A6	|

MechakoopaSpeed:
	db $08,$F8

MechaKoopa:
	JSL CODE_03B307
	LDA.w $14C8,X				;$03B2AD	|
	CMP.b #$08				;$03B2B0	|
	BNE Return03B306			;$03B2B2	|
	LDA $9D					;$03B2B4	|
	BNE Return03B306			;$03B2B6	|
	JSR SubOffscreen0Bnk3			;$03B2B8	|
	JSL SprSprPMarioSprRts			;$03B2BB	|
	JSL UpdateSpritePos			;$03B2BF	|
	LDA.w $1588,X				;$03B2C3	|
	AND.b #$04				;$03B2C6	|
	BEQ CODE_03B2E3				;$03B2C8	|
	STZ $AA,X				;$03B2CA	|
	LDY.w $157C,X				;$03B2CC	|
	LDA.w MechakoopaSpeed,Y			;$03B2CF	|
	STA $B6,X				;$03B2D2	|
	LDA $C2,X				;$03B2D4	|
	INC $C2,X				;$03B2D6	|
	AND.b #$3F				;$03B2D8	|
	BNE CODE_03B2E3				;$03B2DA	|
	JSR SubHorzPosBnk3			;$03B2DC	|
	TYA					;$03B2DF	|
	STA.w $157C,X				;$03B2E0	|
CODE_03B2E3:
	LDA.w $1588,X
	AND.b #$03				;$03B2E6	|
	BEQ CODE_03B2F9				;$03B2E8	|
	LDA $B6,X				;$03B2EA	|
	EOR.b #$FF				;$03B2EC	|
	INC A					;$03B2EE	|
	STA $B6,X				;$03B2EF	|
	LDA.w $157C,X				;$03B2F1	|
	EOR.b #$01				;$03B2F4	|
	STA.w $157C,X				;$03B2F6	|
CODE_03B2F9:
	INC.w $1570,X
	LDA.w $1570,X				;$03B2FC	|
	AND.b #$0C				;$03B2FF	|
	LSR					;$03B301	|
	LSR					;$03B302	|
	STA.w $1602,X				;$03B303	|
Return03B306:
	RTS

CODE_03B307:
	PHB
	PHK					;$03B308	|
	PLB					;$03B309	|
	JSR MechaKoopaGfx			;$03B30A	|
	PLB					;$03B30D	|
	RTL					;$03B30E	|

MechakoopaDispX:
	db $F8,$08,$F8,$00,$08,$00,$10,$00
MechakoopaDispY:
	db $F8,$F8,$08,$00,$F9,$F9,$09,$00
	db $F8,$F8,$08,$00,$F9,$F9,$09,$00
	db $FD,$00,$05,$00,$00,$00,$08,$00
MechakoopaTiles:
	db $40,$42,$60,$51,$40,$42,$60,$0A
	db $40,$42,$60,$0C,$40,$42,$60,$0E
	db $00,$02,$10,$01,$00,$02,$10,$01
MechakoopaGfxProp:
	db $00,$00,$00,$00,$40,$40,$40,$40
MechakoopaTileSize:
	db $02,$00,$00,$02

MechakoopaPalette:
	db $0B,$05

MechaKoopaGfx:
	LDA.b #$0B
	STA.w $15F6,X				;$03B357	|
	LDA.w $1540,X				;$03B35A	|
	BEQ CODE_03B37F				;$03B35D	|
	LDY.b #$05				;$03B35F	|
	CMP.b #$05				;$03B361	|
	BCC CODE_03B369				;$03B363	|
	CMP.b #$FA				;$03B365	|
	BCC CODE_03B36B				;$03B367	|
CODE_03B369:
	LDY.b #$04
CODE_03B36B:
	TYA
	STA.w $1602,X				;$03B36C	|
	LDA.w $1540,X				;$03B36F	|
	CMP.b #$30				;$03B372	|
	BCS CODE_03B37F				;$03B374	|
	AND.b #$01				;$03B376	|
	TAY					;$03B378	|
	LDA.w MechakoopaPalette,Y		;$03B379	|
	STA.w $15F6,X				;$03B37C	|
CODE_03B37F:
	JSR GetDrawInfoBnk3
	LDA.w $15F6,X				;$03B382	|
	STA $04					;$03B385	|
	TYA					;$03B387	|
	CLC					;$03B388	|
	ADC.b #$0C				;$03B389	|
	TAY					;$03B38B	|
	LDA.w $1602,X				;$03B38C	|
	ASL					;$03B38F	|
	ASL					;$03B390	|
	STA $03					;$03B391	|
	LDA.w $157C,X				;$03B393	|
	ASL					;$03B396	|
	ASL					;$03B397	|
	EOR.b #$04				;$03B398	|
	STA $02					;$03B39A	|
	PHX					;$03B39C	|
	LDX.b #$03				;$03B39D	|
CODE_03B39F:
	PHX
	PHY					;$03B3A0	|
	TYA					;$03B3A1	|
	LSR					;$03B3A2	|
	LSR					;$03B3A3	|
	TAY					;$03B3A4	|
	LDA.w MechakoopaTileSize,X		;$03B3A5	|
	STA.w $0460,Y				;$03B3A8	|
	PLY					;$03B3AB	|
	PLA					;$03B3AC	|
	PHA					;$03B3AD	|
	CLC					;$03B3AE	|
	ADC $02					;$03B3AF	|
	TAX					;$03B3B1	|
	LDA $00					;$03B3B2	|
	CLC					;$03B3B4	|
	ADC.w MechakoopaDispX,X			;$03B3B5	|
	STA.w $0300,Y				;$03B3B8	|
	LDA.w MechakoopaGfxProp,X		;$03B3BB	|
	ORA $04					;$03B3BE	|
	ORA $64					;$03B3C0	|
	STA.w $0303,Y				;$03B3C2	|
	PLA					;$03B3C5	|
	PHA					;$03B3C6	|
	CLC					;$03B3C7	|
	ADC $03					;$03B3C8	|
	TAX					;$03B3CA	|
	LDA.w MechakoopaTiles,X			;$03B3CB	|
	STA.w $0302,Y				;$03B3CE	|
	LDA $01					;$03B3D1	|
	CLC					;$03B3D3	|
	ADC.w MechakoopaDispY,X			;$03B3D4	|
	STA.w $0301,Y				;$03B3D7	|
	PLX					;$03B3DA	|
	DEY					;$03B3DB	|
	DEY					;$03B3DC	|
	DEY					;$03B3DD	|
	DEY					;$03B3DE	|
	DEX					;$03B3DF	|
	BPL CODE_03B39F				;$03B3E0	|
	PLX					;$03B3E2	|
	LDY.b #$FF				;$03B3E3	|
	LDA.b #$03				;$03B3E5	|
	JSL FinishOAMWrite			;$03B3E7	|
	JSR MechaKoopaKeyGfx			;$03B3EB	|
	RTS					;$03B3EE	|

MechaKeyDispX:
	db $F9,$0F

MechaKeyGfxProp:
	db $4D,$0D

MechaKeyTiles:
	db $70,$71,$72,$71

MechaKoopaKeyGfx:
	LDA.w $15EA,X
	CLC					;$03B3FA	|
	ADC.b #$10				;$03B3FB	|
	STA.w $15EA,X				;$03B3FD	|
	JSR GetDrawInfoBnk3			;$03B400	|
	PHX					;$03B403	|
	LDA.w $1570,X				;$03B404	|
	LSR					;$03B407	|
	LSR					;$03B408	|
	AND.b #$03				;$03B409	|
	STA $02					;$03B40B	|
	LDA.w $157C,X				;$03B40D	|
	TAX					;$03B410	|
	LDA $00					;$03B411	|
	CLC					;$03B413	|
	ADC.w MechaKeyDispX,X			;$03B414	|
	STA.w $0300,Y				;$03B417	|
	LDA $01					;$03B41A	|
	SEC					;$03B41C	|
	SBC.b #$00				;$03B41D	|
	STA.w $0301,Y				;$03B41F	|
	LDA.w MechaKeyGfxProp,X			;$03B422	|
	ORA $64					;$03B425	|
	STA.w $0303,Y				;$03B427	|
	LDX $02					;$03B42A	|
	LDA.w MechaKeyTiles,X			;$03B42C	|
	STA.w $0302,Y				;$03B42F	|
	PLX					;$03B432	|
	LDY.b #$00				;$03B433	|
	LDA.b #$00				;$03B435	|
	JSL FinishOAMWrite			;$03B437	|
	RTS					;$03B43B	|

CODE_03B43C:
	JSR BowserItemBoxGfx
	JSR BowserSceneGfx			;$03B43F	|
	RTS					;$03B442	|

BowserItemBoxPosX:
	db $70,$80,$70,$80

BowserItemBoxPosY:
	db $07,$07,$17,$17

BowserItemBoxProp:
	db $37,$77,$B7,$F7

BowserItemBoxGfx:
	LDA.w $190D
	BEQ CODE_03B457				;$03B452	|
	STZ.w $0DC2				;$03B454	|
CODE_03B457:
	LDA.w $0DC2
	BEQ Return03B48B			;$03B45A	|
	PHX					;$03B45C	|
	LDX.b #$03				;$03B45D	|
	LDY.b #$04				;$03B45F	|
CODE_03B461:
	LDA.w BowserItemBoxPosX,X
	STA.w $0200,Y				;$03B464	|
	LDA.w BowserItemBoxPosY,X		;$03B467	|
	STA.w $0201,Y				;$03B46A	|
	LDA.b #$43				;$03B46D	|
	STA.w $0202,Y				;$03B46F	|
	LDA.w BowserItemBoxProp,X		;$03B472	|
	STA.w $0203,Y				;$03B475	|
	PHY					;$03B478	|
	TYA					;$03B479	|
	LSR					;$03B47A	|
	LSR					;$03B47B	|
	TAY					;$03B47C	|
	LDA.b #$02				;$03B47D	|
	STA.w $0420,Y				;$03B47F	|
	PLY					;$03B482	|
	INY					;$03B483	|
	INY					;$03B484	|
	INY					;$03B485	|
	INY					;$03B486	|
	DEX					;$03B487	|
	BPL CODE_03B461				;$03B488	|
	PLX					;$03B48A	|
Return03B48B:
	RTS

BowserRoofPosX:
	db $00,$30,$60,$90,$C0,$F0,$00,$30
	db $40,$50,$60,$90,$A0,$B0,$C0,$F0
BowserRoofPosY:
	db $B0,$B0,$B0,$B0,$B0,$B0,$D0,$D0
	db $D0,$D0,$D0,$D0,$D0,$D0,$D0,$D0

BowserSceneGfx:
	PHX
	LDY.b #$BC				;$03B4AD	|
	STZ $01					;$03B4AF	|
	LDA.w $190D				;$03B4B1	|
	STA $0F					;$03B4B4	|
	CMP.b #$01				;$03B4B6	|
	LDX.b #$10				;$03B4B8	|
	BCC CODE_03B4BF				;$03B4BA	|
	LDY.b #$90				;$03B4BC	|
	DEX					;$03B4BE	|
CODE_03B4BF:
	LDA.b #$C0
	SEC					;$03B4C1	|
	SBC $1C					;$03B4C2	|
	STA.w $0301,Y				;$03B4C4	|
	LDA $01					;$03B4C7	|
	SEC					;$03B4C9	|
	SBC $1A					;$03B4CA	|
	STA.w $0300,Y				;$03B4CC	|
	CLC					;$03B4CF	|
	ADC.b #$10				;$03B4D0	|
	STA $01					;$03B4D2	|
	LDA.b #$08				;$03B4D4	|
	STA.w $0302,Y				;$03B4D6	|
	LDA.b #$0D				;$03B4D9	|
	ORA $64					;$03B4DB	|
	STA.w $0303,Y				;$03B4DD	|
	PHY					;$03B4E0	|
	TYA					;$03B4E1	|
	LSR					;$03B4E2	|
	LSR					;$03B4E3	|
	TAY					;$03B4E4	|
	LDA.b #$02				;$03B4E5	|
	STA.w $0460,Y				;$03B4E7	|
	PLY					;$03B4EA	|
	INY					;$03B4EB	|
	INY					;$03B4EC	|
	INY					;$03B4ED	|
	INY					;$03B4EE	|
	DEX					;$03B4EF	|
	BPL CODE_03B4BF				;$03B4F0	|
	LDX.b #$0F				;$03B4F2	|
	LDA $0F					;$03B4F4	|
	BNE CODE_03B532				;$03B4F6	|
	LDY.b #$14				;$03B4F8	|
CODE_03B4FA:
	LDA.w BowserRoofPosX,X
	SEC					;$03B4FD	|
	SBC $1A					;$03B4FE	|
	STA.w $0200,Y				;$03B500	|
	LDA.w BowserRoofPosY,X			;$03B503	|
	SEC					;$03B506	|
	SBC $1C					;$03B507	|
	STA.w $0201,Y				;$03B509	|
	LDA.b #$08				;$03B50C	|
	CPX.b #$06				;$03B50E	|
	BCS CODE_03B514				;$03B510	|
	LDA.b #$03				;$03B512	|
CODE_03B514:
	STA.w $0202,Y
	LDA.b #$0D				;$03B517	|
	ORA $64					;$03B519	|
	STA.w $0203,Y				;$03B51B	|
	PHY					;$03B51E	|
	TYA					;$03B51F	|
	LSR					;$03B520	|
	LSR					;$03B521	|
	TAY					;$03B522	|
	LDA.b #$02				;$03B523	|
	STA.w $0420,Y				;$03B525	|
	PLY					;$03B528	|
	INY					;$03B529	|
	INY					;$03B52A	|
	INY					;$03B52B	|
	INY					;$03B52C	|
	DEX					;$03B52D	|
	BPL CODE_03B4FA				;$03B52E	|
	BRA CODE_03B56A				;$03B530	|

CODE_03B532:
	LDY.b #$50
CODE_03B534:
	LDA.w BowserRoofPosX,X
	SEC					;$03B537	|
	SBC $1A					;$03B538	|
	STA.w $0300,Y				;$03B53A	|
	LDA.w BowserRoofPosY,X			;$03B53D	|
	SEC					;$03B540	|
	SBC $1C					;$03B541	|
	STA.w $0301,Y				;$03B543	|
	LDA.b #$08				;$03B546	|
	CPX.b #$06				;$03B548	|
	BCS CODE_03B54E				;$03B54A	|
	LDA.b #$03				;$03B54C	|
CODE_03B54E:
	STA.w $0302,Y
	LDA.b #$0D				;$03B551	|
	ORA $64					;$03B553	|
	STA.w $0303,Y				;$03B555	|
	PHY					;$03B558	|
	TYA					;$03B559	|
	LSR					;$03B55A	|
	LSR					;$03B55B	|
	TAY					;$03B55C	|
	LDA.b #$02				;$03B55D	|
	STA.w $0460,Y				;$03B55F	|
	PLY					;$03B562	|
	INY					;$03B563	|
	INY					;$03B564	|
	INY					;$03B565	|
	INY					;$03B566	|
	DEX					;$03B567	|
	BPL CODE_03B534				;$03B568	|
CODE_03B56A:
	PLX
	RTS					;$03B56B	|

SprClippingDispX:
	db $02,$02,$10,$14,$00,$00,$01,$08
	db $F8,$FE,$03,$06,$01,$00,$06,$02
	db $00,$E8,$FC,$FC,$04,$00,$FC,$02
	db $02,$02,$02,$02,$00,$02,$E0,$F0
	db $FC,$FC,$00,$F8,$F4,$F2,$00,$FC
	db $F2,$F0,$02,$00,$F8,$04,$02,$02
	db $08,$00,$00,$00,$FC,$03,$08,$00
	db $08,$04,$F8,$00

SprClippingWidth:
	db $0C,$0C,$10,$08,$30,$50,$0E,$28
	db $20,$14,$01,$03,$0D,$0F,$14,$24
	db $0F,$40,$08,$08,$18,$0F,$18,$0C
	db $0C,$0C,$0C,$0C,$0A,$1C,$30,$30
	db $08,$08,$10,$20,$38,$3C,$20,$18
	db $1C,$20,$0C,$10,$10,$08,$1C,$1C
	db $10,$30,$30,$40,$08,$12,$34,$0F
	db $20,$08,$20,$10

SprClippingDispY:
	db $03,$03,$FE,$08,$FE,$FE,$02,$08
	db $FE,$08,$07,$06,$FE,$FC,$06,$FE
	db $FE,$E8,$10,$10,$02,$FE,$F4,$08
	db $13,$23,$33,$43,$0A,$FD,$F8,$FC
	db $E8,$10,$00,$E8,$20,$04,$58,$FC
	db $E8,$FC,$F8,$02,$F8,$04,$FE,$FE
	db $F2,$FE,$FE,$FE,$FC,$00,$08,$F8
	db $10,$03,$10,$00

SprClippingHeight:
	db $0A,$15,$12,$08,$0E,$0E,$18,$30
	db $10,$1E,$02,$03,$16,$10,$14,$12
	db $20,$40,$34,$74,$0C,$0E,$18,$45
	db $3A,$2A,$1A,$0A,$30,$1B,$20,$12
	db $18,$18,$10,$20,$38,$14,$08,$18
	db $28,$1B,$13,$4C,$10,$04,$22,$20
	db $1C,$12,$12,$12,$08,$20,$2E,$14
	db $28,$0A,$10,$0D

MairoClipDispY:
	db $06,$14,$10,$18

MarioClippingHeight:
	db $1A,$0C,$20,$18

GetMarioClipping:
	PHX
	LDA $94					;$03B665	|
	CLC					;$03B667	|
	ADC.b #$02				;$03B668	|
	STA $00					;$03B66A	|
	LDA $95					;$03B66C	|
	ADC.b #$00				;$03B66E	|
	STA $08					;$03B670	|
	LDA.b #$0C				;$03B672	|
	STA $02					;$03B674	|
	LDX.b #$00				;$03B676	|
	LDA $73					;$03B678	|
	BNE CODE_03B680				;$03B67A	|
	LDA $19					;$03B67C	|
	BNE CODE_03B681				;$03B67E	|
CODE_03B680:
	INX
CODE_03B681:
	LDA.w $187A
	BEQ CODE_03B688				;$03B684	|
	INX					;$03B686	|
	INX					;$03B687	|
CODE_03B688:
	LDA.l MarioClippingHeight,X
	STA $03					;$03B68C	|
	LDA $96					;$03B68E	|
	CLC					;$03B690	|
	ADC.l MairoClipDispY,X			;$03B691	|
	STA $01					;$03B695	|
	LDA $97					;$03B697	|
	ADC.b #$00				;$03B699	|
	STA $09					;$03B69B	|
	PLX					;$03B69D	|
	RTL					;$03B69E	|

GetSpriteClippingA:
	PHY
	PHX					;$03B6A0	|
	TXY					;$03B6A1	|
	LDA.w $1662,X				;$03B6A2	|
	AND.b #$3F				;$03B6A5	|
	TAX					;$03B6A7	|
	STZ $0F					;$03B6A8	|
	LDA.l SprClippingDispX,X		;$03B6AA	|
	BPL CODE_03B6B2				;$03B6AE	|
	DEC $0F					;$03B6B0	|
CODE_03B6B2:
	CLC
	ADC.w $00E4,y				;$03B6B3	|
	STA $04					;$03B6B6	|
	LDA.w $14E0,Y				;$03B6B8	|
	ADC $0F					;$03B6BB	|
	STA $0A					;$03B6BD	|
	LDA.l SprClippingWidth,X		;$03B6BF	|
	STA $06					;$03B6C3	|
	STZ $0F					;$03B6C5	|
	LDA.l SprClippingDispY,X		;$03B6C7	|
	BPL CODE_03B6CF				;$03B6CB	|
	DEC $0F					;$03B6CD	|
CODE_03B6CF:
	CLC
	ADC.w $00D8,y				;$03B6D0	|
	STA $05					;$03B6D3	|
	LDA.w $14D4,Y				;$03B6D5	|
	ADC $0F					;$03B6D8	|
	STA $0B					;$03B6DA	|
	LDA.l SprClippingHeight,X		;$03B6DC	|
	STA $07					;$03B6E0	|
	PLX					;$03B6E2	|
	PLY					;$03B6E3	|
	RTL					;$03B6E4	|

GetSpriteClippingB:
	PHY
	PHX					;$03B6E6	|
	TXY					;$03B6E7	|
	LDA.w $1662,X				;$03B6E8	|
	AND.b #$3F				;$03B6EB	|
	TAX					;$03B6ED	|
	STZ $0F					;$03B6EE	|
	LDA.l SprClippingDispX,X		;$03B6F0	|
	BPL CODE_03B6F8				;$03B6F4	|
	DEC $0F					;$03B6F6	|
CODE_03B6F8:
	CLC
	ADC.w $00E4,y				;$03B6F9	|
	STA $00					;$03B6FC	|
	LDA.w $14E0,Y				;$03B6FE	|
	ADC $0F					;$03B701	|
	STA $08					;$03B703	|
	LDA.l SprClippingWidth,X		;$03B705	|
	STA $02					;$03B709	|
	STZ $0F					;$03B70B	|
	LDA.l SprClippingDispY,X		;$03B70D	|
	BPL CODE_03B715				;$03B711	|
	DEC $0F					;$03B713	|
CODE_03B715:
	CLC
	ADC.w $00D8,y				;$03B716	|
	STA $01					;$03B719	|
	LDA.w $14D4,Y				;$03B71B	|
	ADC $0F					;$03B71E	|
	STA $09					;$03B720	|
	LDA.l SprClippingHeight,X		;$03B722	|
	STA $03					;$03B726	|
	PLX					;$03B728	|
	PLY					;$03B729	|
	RTL					;$03B72A	|

CheckForContact:
	PHX
	LDX.b #$01				;$03B72C	|
CODE_03B72E:
	LDA $00,X
	SEC					;$03B730	|
	SBC $04,X				;$03B731	|
	PHA					;$03B733	|
	LDA $08,X				;$03B734	|
	SBC $0A,X				;$03B736	|
	STA $0C					;$03B738	|
	PLA					;$03B73A	|
	CLC					;$03B73B	|
	ADC.b #$80				;$03B73C	|
	LDA $0C					;$03B73E	|
	ADC.b #$00				;$03B740	|
	BNE CODE_03B75A				;$03B742	|
	LDA $04,X				;$03B744	|
	SEC					;$03B746	|
	SBC $00,X				;$03B747	|
	CLC					;$03B749	|
	ADC $06,X				;$03B74A	|
	STA $0F					;$03B74C	|
	LDA $02,X				;$03B74E	|
	CLC					;$03B750	|
	ADC $06,X				;$03B751	|
	CMP $0F					;$03B753	|
	BCC CODE_03B75A				;$03B755	|
	DEX					;$03B757	|
	BPL CODE_03B72E				;$03B758	|
CODE_03B75A:
	PLX
	RTL					;$03B75B	|

DATA_03B75C:
	db $0C,$1C

DATA_03B75E:
	db $01,$02

GetDrawInfoBnk3:
	STZ.w $186C,X
	STZ.w $15A0,X				;$03B763	|
	LDA $E4,X				;$03B766	|
	CMP $1A					;$03B768	|
	LDA.w $14E0,X				;$03B76A	|
	SBC $1B					;$03B76D	|
	BEQ CODE_03B774				;$03B76F	|
	INC.w $15A0,X				;$03B771	|
CODE_03B774:
	LDA.w $14E0,X
	XBA					;$03B777	|
	LDA $E4,X				;$03B778	|
	REP #$20				;$03B77A	|
	SEC					;$03B77C	|
	SBC $1A					;$03B77D	|
	CLC					;$03B77F	|
	ADC.w #$0040				;$03B780	|
	CMP.w #$0180				;$03B783	|
	SEP #$20				;$03B786	|
	ROL					;$03B788	|
	AND.b #$01				;$03B789	|
	STA.w $15C4,X				;$03B78B	|
	BNE CODE_03B7CF				;$03B78E	|
	LDY.b #$00				;$03B790	|
	LDA.w $1662,X				;$03B792	|
	AND.b #$20				;$03B795	|
	BEQ CODE_03B79A				;$03B797	|
	INY					;$03B799	|
CODE_03B79A:
	LDA $D8,X
	CLC					;$03B79C	|
	ADC.w DATA_03B75C,Y			;$03B79D	|
	PHP					;$03B7A0	|
	CMP $1C					;$03B7A1	|
	ROL $00					;$03B7A3	|
	PLP					;$03B7A5	|
	LDA.w $14D4,X				;$03B7A6	|
	ADC.b #$00				;$03B7A9	|
	LSR $00					;$03B7AB	|
	SBC $1D					;$03B7AD	|
	BEQ CODE_03B7BA				;$03B7AF	|
	LDA.w $186C,X				;$03B7B1	|
	ORA.w DATA_03B75E,Y			;$03B7B4	|
	STA.w $186C,X				;$03B7B7	|
CODE_03B7BA:
	DEY
	BPL CODE_03B79A				;$03B7BB	|
	LDY.w $15EA,X				;$03B7BD	|
	LDA $E4,X				;$03B7C0	|
	SEC					;$03B7C2	|
	SBC $1A					;$03B7C3	|
	STA $00					;$03B7C5	|
	LDA $D8,X				;$03B7C7	|
	SEC					;$03B7C9	|
	SBC $1C					;$03B7CA	|
	STA $01					;$03B7CC	|
	RTS					;$03B7CE	|

CODE_03B7CF:
	PLA
	PLA					;$03B7D0	|
	RTS					;$03B7D1	|

DATA_03B7D2:
	db $00,$00,$00,$F8,$F8,$F8,$F8,$F8
	db $F8,$F7,$F6,$F5,$F4,$F3,$F2,$E8
	db $E8,$E8,$E8,$00,$00,$00,$00,$FE
	db $FC,$F8,$EC,$EC,$EC,$E8,$E4,$E0
	db $DC,$D8,$D4,$D0,$CC,$C8

CODE_03B7F8:
	LDA $AA,X
	PHA					;$03B7FA	|
	STZ $AA,X				;$03B7FB	|
	PLA					;$03B7FD	|
	LSR					;$03B7FE	|
	LSR					;$03B7FF	|
	TAY					;$03B800	|
	LDA $9E,X				;$03B801	|
	CMP.b #$A1				;$03B803	|
	BNE CODE_03B80C				;$03B805	|
	TYA					;$03B807	|
	CLC					;$03B808	|
	ADC.b #$13				;$03B809	|
	TAY					;$03B80B	|
CODE_03B80C:
	LDA.w DATA_03B7D2,Y
	LDY.w $1588,X				;$03B80F	|
	BMI Return03B816			;$03B812	|
	STA $AA,X				;$03B814	|
Return03B816:
	RTS

SubHorzPosBnk3:
	LDY.b #$00
	LDA $94					;$03B819	|
	SEC					;$03B81B	|
	SBC $E4,X				;$03B81C	|
	STA $0F					;$03B81E	|
	LDA $95					;$03B820	|
	SBC.w $14E0,X				;$03B822	|
	BPL Return03B828			;$03B825	|
	INY					;$03B827	|
Return03B828:
	RTS

SubVertPosBnk3:
	LDY.b #$00
	LDA $96					;$03B82B	|
	SEC					;$03B82D	|
	SBC $D8,X				;$03B82E	|
	STA $0F					;$03B830	|
	LDA $97					;$03B832	|
	SBC.w $14D4,X				;$03B834	|
	BPL Return03B83A			;$03B837	|
	INY					;$03B839	|
Return03B83A:
	RTS

DATA_03B83B:
	db $40,$B0

DATA_03B83D:
	db $01,$FF

DATA_03B83F:
	db $30,$C0,$A0,$80,$A0,$40,$60,$B0
DATA_03B847:
	db $01,$FF,$01,$FF,$01,$00,$01,$FF

SubOffscreen3Bnk3:
	LDA.b #$06
	BRA CODE_03B859				;$03B851	|

SubOffscreen2Bnk3:
	LDA.b #$04
	BRA CODE_03B859				;$03B855	|

SubOffscreen1Bnk3:
	LDA.b #$02
CODE_03B859:
	STA $03
	BRA CODE_03B85F				;$03B85B	|

SubOffscreen0Bnk3:
	STZ $03
CODE_03B85F:
	JSR IsSprOffScreenBnk3
	BEQ Return03B8C2			;$03B862	|
	LDA $5B					;$03B864	|
	AND.b #$01				;$03B866	|
	BNE VerticalLevelBnk3			;$03B868	|
	LDA $D8,X				;$03B86A	|
	CLC					;$03B86C	|
	ADC.b #$50				;$03B86D	|
	LDA.w $14D4,X				;$03B86F	|
	ADC.b #$00				;$03B872	|
	CMP.b #$02				;$03B874	|
	BPL OffScrEraseSprBnk3			;$03B876	|
	LDA.w $167A,X				;$03B878	|
	AND.b #$04				;$03B87B	|
	BNE Return03B8C2			;$03B87D	|
	LDA $13					;$03B87F	|
	AND.b #$01				;$03B881	|
	ORA $03					;$03B883	|
	STA $01					;$03B885	|
	TAY					;$03B887	|
	LDA $1A					;$03B888	|
	CLC					;$03B88A	|
	ADC.w DATA_03B83F,Y			;$03B88B	|
	ROL $00					;$03B88E	|
	CMP $E4,X				;$03B890	|
	PHP					;$03B892	|
	LDA $1B					;$03B893	|
	LSR $00					;$03B895	|
	ADC.w DATA_03B847,Y			;$03B897	|
	PLP					;$03B89A	|
	SBC.w $14E0,X				;$03B89B	|
	STA $00					;$03B89E	|
	LSR $01					;$03B8A0	|
	BCC CODE_03B8A8				;$03B8A2	|
	EOR.b #$80				;$03B8A4	|
	STA $00					;$03B8A6	|
CODE_03B8A8:
	LDA $00
	BPL Return03B8C2			;$03B8AA	|
OffScrEraseSprBnk3:
	LDA.w $14C8,X
	CMP.b #$08				;$03B8AF	|
	BCC OffScrKillSprBnk3			;$03B8B1	|
	LDY.w $161A,X				;$03B8B3	|
	CPY.b #$FF				;$03B8B6	|
	BEQ OffScrKillSprBnk3			;$03B8B8	|
	LDA.b #$00				;$03B8BA	|
	STA.w $1938,Y				;$03B8BC	|
OffScrKillSprBnk3:
	STZ.w $14C8,X
Return03B8C2:
	RTS

VerticalLevelBnk3:
	LDA.w $167A,X
	AND.b #$04				;$03B8C6	|
	BNE Return03B8C2			;$03B8C8	|
	LDA $13					;$03B8CA	|
	LSR					;$03B8CC	|
	BCS Return03B8C2			;$03B8CD	|
	AND.b #$01				;$03B8CF	|
	STA $01					;$03B8D1	|
	TAY					;$03B8D3	|
	LDA $1C					;$03B8D4	|
	CLC					;$03B8D6	|
	ADC.w DATA_03B83B,Y			;$03B8D7	|
	ROL $00					;$03B8DA	|
	CMP $D8,X				;$03B8DC	|
	PHP					;$03B8DE	|
	LDA.w $1D				;$03B8DF	|
	LSR $00					;$03B8E2	|
	ADC.w DATA_03B83D,Y			;$03B8E4	|
	PLP					;$03B8E7	|
	SBC.w $14D4,X				;$03B8E8	|
	STA $00					;$03B8EB	|
	LDY $01					;$03B8ED	|
	BEQ CODE_03B8F5				;$03B8EF	|
	EOR.b #$80				;$03B8F1	|
	STA $00					;$03B8F3	|
CODE_03B8F5:
	LDA $00
	BPL Return03B8C2			;$03B8F7	|
	BMI OffScrEraseSprBnk3			;$03B8F9	|
IsSprOffScreenBnk3:
	LDA.w $15A0,X
	ORA.w $186C,X				;$03B8FE	|
	RTS					;$03B901	|

MagiKoopaPals:
	db $FF,$7F,$4A,$29,$00,$00,$00,$14
	db $00,$20,$92,$7E,$0A,$00,$2A,$00
	db $FF,$7F,$AD,$35,$00,$00,$00,$24
	db $00,$2C,$2F,$72,$0D,$00,$AD,$00
	db $FF,$7F,$10,$42,$00,$00,$00,$30
	db $00,$38,$CC,$65,$50,$00,$10,$01
	db $FF,$7F,$73,$4E,$00,$00,$00,$3C
	db $41,$44,$69,$59,$B3,$00,$73,$01
	db $FF,$7F,$D6,$5A,$00,$00,$00,$48
	db $A4,$50,$06,$4D,$16,$01,$D6,$01
	db $FF,$7F,$39,$67,$00,$00,$42,$54
	db $07,$5D,$A3,$40,$79,$01,$39,$02
	db $FF,$7F,$9C,$73,$00,$00,$A5,$60
	db $6A,$69,$40,$34,$DC,$01,$9C,$02
	db $FF,$7F,$FF,$7F,$00,$00,$08,$6D
	db $CD,$75,$00,$28,$3F,$02,$FF,$02
BooBossPals:
	db $FF,$7F,$63,$0C,$00,$00,$00,$0C
	db $00,$0C,$00,$0C,$00,$0C,$03,$00
	db $FF,$7F,$E7,$1C,$00,$00,$00,$1C
	db $00,$1C,$20,$1C,$81,$1C,$07,$00
	db $FF,$7F,$6B,$2D,$00,$00,$00,$2C
	db $40,$2C,$A2,$2C,$05,$2D,$0B,$00
	db $FF,$7F,$EF,$3D,$00,$00,$60,$3C
	db $C3,$3C,$26,$3D,$89,$3D,$0F,$00
	db $FF,$7F,$73,$4E,$00,$00,$E4,$4C
	db $47,$4D,$AA,$4D,$0D,$4E,$13,$10
	db $FF,$7F,$F7,$5E,$00,$00,$68,$5D
	db $CB,$5D,$2E,$5E,$91,$5E,$17,$20
	db $FF,$7F,$7B,$6F,$00,$00,$EC,$6D
	db $4F,$6E,$B2,$6E,$15,$6F,$1B,$30
	db $FF,$7F,$FF,$7F,$00,$00,$70,$7E
	db $D3,$7E,$36,$7F,$99,$7F,$1F,$40
DATA_03BA02:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF

GenTileFromSpr2:
	STA $9C
	LDA $E4,X				;$03C002	|
	SEC					;$03C004	|
	SBC.b #$08				;$03C005	|
	STA $9A					;$03C007	|
	LDA.w $14E0,X				;$03C009	|
	SBC.b #$00				;$03C00C	|
	STA $9B					;$03C00E	|
	LDA $D8,X				;$03C010	|
	CLC					;$03C012	|
	ADC.b #$08				;$03C013	|
	STA $98					;$03C015	|
	LDA.w $14D4,X				;$03C017	|
	ADC.b #$00				;$03C01A	|
	STA $99					;$03C01C	|
	JSL generate_tile			;$03C01E	|
	RTL					;$03C022	|

CODE_03C023:
	PHB
	PHK					;$03C024	|
	PLB					;$03C025	|
	JSR CODE_03C02F				;$03C026	|
	PLB					;$03C029	|
	RTL					;$03C02A	|

DATA_03C02B:
	db $74,$75,$77,$76

CODE_03C02F:
	LDY.w $160E,X
	LDA.b #$00				;$03C032	|
	STA.w $14C8,Y				;$03C034	|
	LDA.b #$06				;$03C037	|
	STA.w $1DF9				;$03C039	|
	LDA.w $160E,Y				;$03C03C	|
	BNE CODE_03C09B				;$03C03F	|
	LDA.w $009E,y				;$03C041	|
	CMP.b #$81				;$03C044	|
	BNE CODE_03C054				;$03C046	|
	LDA $14					;$03C048	|
	LSR					;$03C04A	|
	LSR					;$03C04B	|
	LSR					;$03C04C	|
	LSR					;$03C04D	|
	AND.b #$03				;$03C04E	|
	TAY					;$03C050	|
	LDA.w DATA_03C02B,Y			;$03C051	|
CODE_03C054:
	CMP.b #$74
	BCC CODE_03C09B				;$03C056	|
	CMP.b #$78				;$03C058	|
	BCS CODE_03C09B				;$03C05A	|
ADDR_03C05C:
	STZ.w $18AC
	STZ.w $141E				;$03C05F	|
	LDA.b #$35				;$03C062	|
	STA.w $9E,X				;$03C064	|
	LDA.b #$08				;$03C067	|
	STA.w $14C8,X				;$03C069	|
	LDA.b #$1F				;$03C06C	|
	STA.w $1DFC				;$03C06E	|
	LDA $D8,X				;$03C071	|
	SBC.b #$10				;$03C073	|
	STA $D8,X				;$03C075	|
	LDA.w $14D4,X				;$03C077	|
	SBC.b #$00				;$03C07A	|
	STA.w $14D4,X				;$03C07C	|
	LDA.w $15F6,X				;$03C07F	|
	PHA					;$03C082	|
	JSL InitSpriteTables			;$03C083	|
	PLA					;$03C087	|
	AND.b #$FE				;$03C088	|
	STA.w $15F6,X				;$03C08A	|
	LDA.b #$0C				;$03C08D	|
	STA.w $1602,X				;$03C08F	|
	DEC.w $160E,X				;$03C092	|
	LDA.b #$40				;$03C095	|
	STA.w $18E8				;$03C097	|
	RTS					;$03C09A	|

CODE_03C09B:
	INC.w $1570,X
	LDA.w $1570,X				;$03C09E	|
	CMP.b #$05				;$03C0A1	|
	BNE CODE_03C0A7				;$03C0A3	|
	BRA ADDR_03C05C				;$03C0A5	|

CODE_03C0A7:
	JSL CODE_05B34A
	LDA.b #$01				;$03C0AB	|
	JSL GivePoints				;$03C0AD	|
	RTS					;$03C0B1	|

DATA_03C0B2:
	db $68,$6A,$6C,$6E

DATA_03C0B6:
	db $00,$03,$01,$02,$04,$02,$00,$01
	db $00,$04,$00,$02,$00,$03,$04,$01

CODE_03C0C6:
	LDA $9D
	BNE CODE_03C0CD				;$03C0C8	|
	JSR CODE_03C11E				;$03C0CA	|
CODE_03C0CD:
	STZ $00
	LDX.b #$13				;$03C0CF	|
	LDY.b #$B0				;$03C0D1	|
CODE_03C0D3:
	STX $02
	LDA $00					;$03C0D5	|
	STA.w $0300,Y				;$03C0D7	|
	CLC					;$03C0DA	|
	ADC.b #$10				;$03C0DB	|
	STA $00					;$03C0DD	|
	LDA.b #$C4				;$03C0DF	|
	STA.w $0301,Y				;$03C0E1	|
	LDA $64					;$03C0E4	|
	ORA.b #$09				;$03C0E6	|
	STA.w $0303,Y				;$03C0E8	|
	PHX					;$03C0EB	|
	LDA $14					;$03C0EC	|
	LSR					;$03C0EE	|
	LSR					;$03C0EF	|
	LSR					;$03C0F0	|
	CLC					;$03C0F1	|
	ADC.l DATA_03C0B6,X			;$03C0F2	|
	AND.b #$03				;$03C0F6	|
	TAX					;$03C0F8	|
	LDA.l DATA_03C0B2,X			;$03C0F9	|
	STA.w $0302,Y				;$03C0FD	|
	TYA					;$03C100	|
	LSR					;$03C101	|
	LSR					;$03C102	|
	TAX					;$03C103	|
	LDA.b #$02				;$03C104	|
	STA.w $0460,X				;$03C106	|
	PLX					;$03C109	|
	INY					;$03C10A	|
	INY					;$03C10B	|
	INY					;$03C10C	|
	INY					;$03C10D	|
	DEX					;$03C10E	|
	BPL CODE_03C0D3				;$03C10F	|
	RTL					;$03C111	|

IggyPlatSpeed:
	db $FF,$01,$FF,$01

DATA_03C116:
	db $FF,$00,$FF,$00

IggyPlatBounds:
	db $E7,$18,$D7,$28

CODE_03C11E:
	LDA $9D
	ORA.w $1493				;$03C120	|
	BNE Return03C175			;$03C123	|
	LDA.w $1906				;$03C125	|
	BEQ CODE_03C12D				;$03C128	|
	DEC.w $1906				;$03C12A	|
CODE_03C12D:
	LDA $13
	AND.b #$01				;$03C12F	|
	ORA.w $1906				;$03C131	|
	BNE Return03C175			;$03C134	|
	LDA.w $1905				;$03C136	|
	AND.b #$01				;$03C139	|
	TAX					;$03C13B	|
	LDA.w $1907				;$03C13C	|
	CMP.b #$04				;$03C13F	|
	BCC CODE_03C145				;$03C141	|
	INX					;$03C143	|
	INX					;$03C144	|
CODE_03C145:
	LDA $36
	CLC					;$03C147	|
	ADC.l IggyPlatSpeed,X			;$03C148	|
	STA $36					;$03C14C	|
	PHA					;$03C14E	|
	LDA $37					;$03C14F	|
	ADC.l DATA_03C116,X			;$03C151	|
	AND.b #$01				;$03C155	|
	STA $37					;$03C157	|
	PLA					;$03C159	|
	CMP.l IggyPlatBounds,X			;$03C15A	|
	BNE Return03C175			;$03C15E	|
	INC.w $1905				;$03C160	|
	LDA.b #$40				;$03C163	|
	STA.w $1906				;$03C165	|
	INC.w $1907				;$03C168	|
	LDA.w $1907				;$03C16B	|
	CMP.b #$06				;$03C16E	|
	BNE Return03C175			;$03C170	|
	STZ.w $1907				;$03C172	|
Return03C175:
	RTS

DATA_03C176:
	db $0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D
	db $0D,$0D,$FC,$FC,$FC,$FC,$FC,$FC
	db $FB,$FB,$FB,$FB,$0C,$0C,$0C,$0C
	db $0C,$0C,$0D,$0D,$0D,$0D,$FC,$FC
	db $FC,$FC,$FC,$FC,$FB,$FB,$FB,$FB
DATA_03C19E:
	db $0E,$0E,$0E,$0D,$0D,$0D,$0C,$0C
	db $0B,$0B,$0E,$0E,$0E,$0D,$0D,$0D
	db $0C,$0C,$0B,$0B,$12,$12,$12,$11
	db $11,$11,$10,$10,$0F,$0F,$12,$12
	db $12,$11,$11,$11,$10,$10,$0F,$0F
DATA_03C1C6:
	db $02,$FE

DATA_03C1C8:
	db $00,$FF

CODE_03C1CA:
	PHB
	PHK					;$03C1CB	|
	PLB					;$03C1CC	|
	LDY.b #$00				;$03C1CD	|
	LDA.w $15B8,X				;$03C1CF	|
	BPL CODE_03C1D5				;$03C1D2	|
	INY					;$03C1D4	|
CODE_03C1D5:
	LDA $E4,X
	CLC					;$03C1D7	|
	ADC.w DATA_03C1C6,Y			;$03C1D8	|
	STA $E4,X				;$03C1DB	|
	LDA.w $14E0,X				;$03C1DD	|
	ADC.w DATA_03C1C8,Y			;$03C1E0	|
	STA.w $14E0,X				;$03C1E3	|
	LDA.b #$18				;$03C1E6	|
	STA $AA,X				;$03C1E8	|
	PLB					;$03C1EA	|
	RTL					;$03C1EB	|

DATA_03C1EC:
	db $00,$04,$07,$08,$08,$07,$04,$00
	db $00

LightSwitch:
	LDA $9D
	BNE CODE_03C22B				;$03C1F7	|
	JSL InvisBlkMainRt			;$03C1F9	|
	JSR SubOffscreen0Bnk3			;$03C1FD	|
	LDA.w $1558,X				;$03C200	|
	CMP.b #$05				;$03C203	|
	BNE CODE_03C22B				;$03C205	|
	STZ $C2,X				;$03C207	|
	LDY.b #$0B				;$03C209	|
	STY.w $1DF9				;$03C20B	|
	PHA					;$03C20E	|
	LDY.b #$09				;$03C20F	|
CODE_03C211:
	LDA.w $14C8,Y
	CMP.b #$08				;$03C214	|
	BNE CODE_03C227				;$03C216	|
	LDA.w $009E,y				;$03C218	|
	CMP.b #$C6				;$03C21B	|
	BNE CODE_03C227				;$03C21D	|
	LDA.w $00C2,y				;$03C21F	|
	EOR.b #$01				;$03C222	|
	STA.w $00C2,y				;$03C224	|
CODE_03C227:
	DEY
	BPL CODE_03C211				;$03C228	|
	PLA					;$03C22A	|
CODE_03C22B:
	LDA.w $1558,X
	LSR					;$03C22E	|
	TAY					;$03C22F	|
	LDA $1C					;$03C230	|
	PHA					;$03C232	|
	CLC					;$03C233	|
	ADC.w DATA_03C1EC,Y			;$03C234	|
	STA $1C					;$03C237	|
	LDA $1D					;$03C239	|
	PHA					;$03C23B	|
	ADC.b #$00				;$03C23C	|
	STA $1D					;$03C23E	|
	JSL GenericSprGfxRt2			;$03C240	|
	LDY.w $15EA,X				;$03C244	|
	LDA.b #$2A				;$03C247	|
	STA.w $0302,Y				;$03C249	|
	LDA.w $0303,Y				;$03C24C	|
	AND.b #$BF				;$03C24F	|
	STA.w $0303,Y				;$03C251	|
	PLA					;$03C254	|
	STA $1D					;$03C255	|
	PLA					;$03C257	|
	STA $1C					;$03C258	|
	RTS					;$03C25A	|

ChainsawMotorTiles:
	db $E0,$C2,$C0,$C2

DATA_03C25F:
	db $F2,$0E

DATA_03C261:
	db $33,$B3

CODE_03C263:
	PHB
	PHK					;$03C264	|
	PLB					;$03C265	|
	JSR ChainsawGfx				;$03C266	|
	PLB					;$03C269	|
	RTL					;$03C26A	|

ChainsawGfx:
	JSR GetDrawInfoBnk3
	PHX					;$03C26E	|
	LDA $9E,X				;$03C26F	|
	SEC					;$03C271	|
	SBC.b #$65				;$03C272	|
	TAX					;$03C274	|
	LDA.w DATA_03C25F,X			;$03C275	|
	STA $03					;$03C278	|
	LDA.w DATA_03C261,X			;$03C27A	|
	STA $04					;$03C27D	|
	PLX					;$03C27F	|
	LDA $14					;$03C280	|
	AND.b #$02				;$03C282	|
	STA $02					;$03C284	|
	LDA $00					;$03C286	|
	SEC					;$03C288	|
	SBC.b #$08				;$03C289	|
	STA.w $0300,Y				;$03C28B	|
	STA.w $0304,Y				;$03C28E	|
	STA.w $0308,Y				;$03C291	|
	LDA $01					;$03C294	|
	SEC					;$03C296	|
	SBC.b #$08				;$03C297	|
	STA.w $0301,Y				;$03C299	|
	CLC					;$03C29C	|
	ADC $03					;$03C29D	|
	CLC					;$03C29F	|
	ADC $02					;$03C2A0	|
	STA.w $0305,Y				;$03C2A2	|
	CLC					;$03C2A5	|
	ADC $03					;$03C2A6	|
	STA.w $0309,Y				;$03C2A8	|
	LDA $14					;$03C2AB	|
	LSR					;$03C2AD	|
	LSR					;$03C2AE	|
	AND.b #$03				;$03C2AF	|
	PHX					;$03C2B1	|
	TAX					;$03C2B2	|
	LDA.w ChainsawMotorTiles,X		;$03C2B3	|
	STA.w $0302,Y				;$03C2B6	|
	PLX					;$03C2B9	|
	LDA.b #$AE				;$03C2BA	|
	STA.w $0306,Y				;$03C2BC	|
	LDA.b #$8E				;$03C2BF	|
	STA.w $030A,Y				;$03C2C1	|
	LDA.b #$37				;$03C2C4	|
	STA.w $0303,Y				;$03C2C6	|
	LDA $04					;$03C2C9	|
	STA.w $0307,Y				;$03C2CB	|
	STA.w $030B,Y				;$03C2CE	|
	LDY.b #$02				;$03C2D1	|
	TYA					;$03C2D3	|
	JSL FinishOAMWrite			;$03C2D4	|
	RTS					;$03C2D8	|

TriggerInivis1Up:
	PHX
	LDX.b #$0B				;$03C2DA	|
CODE_03C2DC:
	LDA.w $14C8,X
	BEQ Generate1Up				;$03C2DF	|
	DEX					;$03C2E1	|
	BPL CODE_03C2DC				;$03C2E2	|
	PLX					;$03C2E4	|
	RTL					;$03C2E5	|

Generate1Up:
	LDA.b #$08
	STA.w $14C8,X				;$03C2E8	|
	LDA.b #$78				;$03C2EB	|
	STA $9E,X				;$03C2ED	|
	LDA $94					;$03C2EF	|
	STA $E4,X				;$03C2F1	|
	LDA $95					;$03C2F3	|
	STA.w $14E0,X				;$03C2F5	|
	LDA $96					;$03C2F8	|
	STA $D8,X				;$03C2FA	|
	LDA $97					;$03C2FC	|
	STA.w $14D4,X				;$03C2FE	|
	JSL InitSpriteTables			;$03C301	|
	LDA.b #$10				;$03C305	|
	STA.w $154C,X				;$03C307	|
	JSR PopupMushroom			;$03C30A	|
	PLX					;$03C30D	|
	RTL					;$03C30E	|

InvisMushroom:
	JSR GetDrawInfoBnk3
	JSL MarioSprInteract			;$03C312	|
	BCC Return03C347			;$03C316	|
	LDA.b #$74				;$03C318	|
	STA $9E,X				;$03C31A	|
	JSL InitSpriteTables			;$03C31C	|
	LDA.b #$20				;$03C320	|
	STA.w $154C,X				;$03C322	|
	LDA $D8,X				;$03C325	|
	SEC					;$03C327	|
	SBC.b #$0F				;$03C328	|
	STA $D8,X				;$03C32A	|
	LDA.w $14D4,X				;$03C32C	|
	SBC.b #$00				;$03C32F	|
	STA.w $14D4,X				;$03C331	|
PopupMushroom:
	LDA.b #$00
	LDY $7B					;$03C336	|
	BPL CODE_03C33B				;$03C338	|
	INC A					;$03C33A	|
CODE_03C33B:
	STA.w $157C,X
	LDA.b #$C0				;$03C33E	|
	STA $AA,X				;$03C340	|
	LDA.b #$02				;$03C342	|
	STA.w $1DFC				;$03C344	|
Return03C347:
	RTS

NinjiSpeedY:
	db $D0,$C0,$B0,$D0

Ninji:
	JSL GenericSprGfxRt2
	LDA $9D					;$03C350	|
	BNE Return03C38F			;$03C352	|
	JSR SubHorzPosBnk3			;$03C354	|
	TYA					;$03C357	|
	STA.w $157C,X				;$03C358	|
	JSR SubOffscreen0Bnk3			;$03C35B	|
	JSL SprSprPMarioSprRts			;$03C35E	|
	JSL UpdateSpritePos			;$03C362	|
	LDA.w $1588,X				;$03C366	|
	AND.b #$04				;$03C369	|
	BEQ CODE_03C385				;$03C36B	|
	STZ $AA,X				;$03C36D	|
	LDA.w $1540,X				;$03C36F	|
	BNE CODE_03C385				;$03C372	|
	LDA.b #$60				;$03C374	|
	STA.w $1540,X				;$03C376	|
	INC $C2,X				;$03C379	|
	LDA $C2,X				;$03C37B	|
	AND.b #$03				;$03C37D	|
	TAY					;$03C37F	|
	LDA.w NinjiSpeedY,Y			;$03C380	|
	STA $AA,X				;$03C383	|
CODE_03C385:
	LDA.b #$00
	LDY $AA,X				;$03C387	|
	BMI CODE_03C38C				;$03C389	|
	INC A					;$03C38B	|
CODE_03C38C:
	STA.w $1602,X
Return03C38F:
	RTS

CODE_03C390:
	PHB
	PHK					;$03C391	|
	PLB					;$03C392	|
	LDA.w $157C,X				;$03C393	|
	PHA					;$03C396	|
	LDY.w $15AC,X				;$03C397	|
	BEQ CODE_03C3A5				;$03C39A	|
	CPY.b #$05				;$03C39C	|
	BCC CODE_03C3A5				;$03C39E	|
	EOR.b #$01				;$03C3A0	|
	STA.w $157C,X				;$03C3A2	|
CODE_03C3A5:
	JSR CODE_03C3DA
	PLA					;$03C3A8	|
	STA.w $157C,X				;$03C3A9	|
	PLB					;$03C3AC	|
	RTL					;$03C3AD	|

CODE_03C3AE:
	JSL GenericSprGfxRt2
	RTS					;$03C3B2	|

DryBonesTileDispX:
	db $00,$08,$00,$00,$F8,$00,$00,$04
	db $00,$00,$FC,$00

DryBonesGfxProp:
	db $43,$43,$43,$03,$03,$03

DryBonesTileDispY:
	db $F4,$F0,$00,$F4,$F1,$00,$F4,$F0
	db $00

DryBonesTiles:
	db $00,$64,$66,$00,$64,$68,$82,$64
	db $E6

DATA_03C3D7:
	db $00,$00,$FF

CODE_03C3DA:
	LDA $9E,X
	CMP.b #$31				;$03C3DC	|
	BEQ CODE_03C3AE				;$03C3DE	|
	JSR GetDrawInfoBnk3			;$03C3E0	|
	LDA.w $15AC,X				;$03C3E3	|
	STA $05					;$03C3E6	|
	LDA.w $157C,X				;$03C3E8	|
	ASL					;$03C3EB	|
	ADC.w $157C,X				;$03C3EC	|
	STA $02					;$03C3EF	|
	PHX					;$03C3F1	|
	LDA.w $1602,X				;$03C3F2	|
	PHA					;$03C3F5	|
	ASL					;$03C3F6	|
	ADC.w $1602,X				;$03C3F7	|
	STA $03					;$03C3FA	|
	PLX					;$03C3FC	|
	LDA.w DATA_03C3D7,X			;$03C3FD	|
	STA $04					;$03C400	|
	LDX.b #$02				;$03C402	|
CODE_03C404:
	PHX
	TXA					;$03C405	|
	CLC					;$03C406	|
	ADC $02					;$03C407	|
	TAX					;$03C409	|
	PHX					;$03C40A	|
	LDA $05					;$03C40B	|
	BEQ CODE_03C414				;$03C40D	|
	TXA					;$03C40F	|
	CLC					;$03C410	|
	ADC.b #$06				;$03C411	|
	TAX					;$03C413	|
CODE_03C414:
	LDA $00
	CLC					;$03C416	|
	ADC.w DryBonesTileDispX,X		;$03C417	|
	STA.w $0300,Y				;$03C41A	|
	PLX					;$03C41D	|
	LDA.w DryBonesGfxProp,X			;$03C41E	|
	ORA $64					;$03C421	|
	STA.w $0303,Y				;$03C423	|
	PLA					;$03C426	|
	PHA					;$03C427	|
	CLC					;$03C428	|
	ADC $03					;$03C429	|
	TAX					;$03C42B	|
	LDA $01					;$03C42C	|
	CLC					;$03C42E	|
	ADC.w DryBonesTileDispY,X		;$03C42F	|
	STA.w $0301,Y				;$03C432	|
	LDA.w DryBonesTiles,X			;$03C435	|
	STA.w $0302,Y				;$03C438	|
	PLX					;$03C43B	|
	INY					;$03C43C	|
	INY					;$03C43D	|
	INY					;$03C43E	|
	INY					;$03C43F	|
	DEX					;$03C440	|
	CPX $04					;$03C441	|
	BNE CODE_03C404				;$03C443	|
	PLX					;$03C445	|
	LDY.b #$02				;$03C446	|
	TYA					;$03C448	|
	JSL FinishOAMWrite			;$03C449	|
	RTS					;$03C44D	|

CODE_03C44E:
	LDA.w $15A0,X
	ORA.w $186C,X				;$03C451	|
	BNE Return03C460			;$03C454	|
	LDY.b #$07				;$03C456	|
CODE_03C458:
	LDA.w $170B,Y
	BEQ CODE_03C461				;$03C45B	|
	DEY					;$03C45D	|
	BPL CODE_03C458				;$03C45E	|
Return03C460:
	RTL

CODE_03C461:
	LDA.b #$06
	STA.w $170B,Y				;$03C463	|
	LDA $D8,X				;$03C466	|
	SEC					;$03C468	|
	SBC.b #$10				;$03C469	|
	STA.w $1715,Y				;$03C46B	|
	LDA.w $14D4,X				;$03C46E	|
	SBC.b #$00				;$03C471	|
	STA.w $1729,Y				;$03C473	|
	LDA $E4,X				;$03C476	|
	STA.w $171F,Y				;$03C478	|
	LDA.w $14E0,X				;$03C47B	|
	STA.w $1733,Y				;$03C47E	|
	LDA.w $157C,X				;$03C481	|
	LSR					;$03C484	|
	LDA.b #$18				;$03C485	|
	BCC CODE_03C48B				;$03C487	|
	LDA.b #$E8				;$03C489	|
CODE_03C48B:
	STA.w $1747,Y
	RTL					;$03C48E	|

DATA_03C48F:
	db $01,$FF

DATA_03C491:
	db $FF,$90

DiscoBallTiles:
	db $80,$82,$84,$86,$88,$8C,$C0,$C2
	db $C2

DATA_03C49C:
	db $31,$33,$35,$37,$31,$33,$35,$37
	db $39

CODE_03C4A5:
	LDY.w $15EA,X
	LDA.b #$78				;$03C4A8	|
	STA.w $0300,Y				;$03C4AA	|
	LDA.b #$28				;$03C4AD	|
	STA.w $0301,Y				;$03C4AF	|
	PHX					;$03C4B2	|
	LDA $C2,X				;$03C4B3	|
	LDX.b #$08				;$03C4B5	|
	AND.b #$01				;$03C4B7	|
	BEQ CODE_03C4C1				;$03C4B9	|
	LDA $13					;$03C4BB	|
	LSR					;$03C4BD	|
	AND.b #$07				;$03C4BE	|
	TAX					;$03C4C0	|
CODE_03C4C1:
	LDA.w DiscoBallTiles,X
	STA.w $0302,Y				;$03C4C4	|
	LDA.w DATA_03C49C,X			;$03C4C7	|
	STA.w $0303,Y				;$03C4CA	|
	TYA					;$03C4CD	|
	LSR					;$03C4CE	|
	LSR					;$03C4CF	|
	TAY					;$03C4D0	|
	LDA.b #$02				;$03C4D1	|
	STA.w $0460,Y				;$03C4D3	|
	PLX					;$03C4D6	|
	RTS					;$03C4D7	|

DATA_03C4D8:
	db $10,$8C

DATA_03C4DA:
	db $42,$31

DarkRoomWithLight:
	LDA.w $1534,X
	BNE CODE_03C500				;$03C4DF	|
	LDY.b #$09				;$03C4E1	|
CODE_03C4E3:
	CPY.w $15E9
	BEQ CODE_03C4FA				;$03C4E6	|
	LDA.w $14C8,Y				;$03C4E8	|
	CMP.b #$08				;$03C4EB	|
	BNE CODE_03C4FA				;$03C4ED	|
	LDA.w $009E,y				;$03C4EF	|
	CMP.b #$C6				;$03C4F2	|
	BNE CODE_03C4FA				;$03C4F4	|
	STZ.w $14C8,X				;$03C4F6	|
Return03C4F9:
	RTS

CODE_03C4FA:
	DEY
	BPL CODE_03C4E3				;$03C4FB	|
	INC.w $1534,X				;$03C4FD	|
CODE_03C500:
	JSR CODE_03C4A5
	LDA.b #$FF				;$03C503	|
	STA $40					;$03C505	|
	LDA.b #$20				;$03C507	|
	STA $44					;$03C509	|
	LDA.b #$20				;$03C50B	|
	STA $43					;$03C50D	|
	LDA.b #$80				;$03C50F	|
	STA.w $0D9F				;$03C511	|
	LDA $C2,X				;$03C514	|
	AND.b #$01				;$03C516	|
	TAY					;$03C518	|
	LDA.w DATA_03C4D8,Y			;$03C519	|
	STA.w $0701				;$03C51C	|
	LDA.w DATA_03C4DA,Y			;$03C51F	|
	STA.w $0702				;$03C522	|
	LDA $9D					;$03C525	|
	BNE Return03C4F9			;$03C527	|
	LDA.w $1482				;$03C529	|
	BNE CODE_03C54D				;$03C52C	|
	LDA.b #$00				;$03C52E	|
	STA.w $1476				;$03C530	|
	LDA.b #$90				;$03C533	|
	STA.w $1478				;$03C535	|
	LDA.b #$78				;$03C538	|
	STA.w $1472				;$03C53A	|
	LDA.b #$87				;$03C53D	|
	STA.w $1474				;$03C53F	|
	LDA.b #$01				;$03C542	|
	STA.w $1486				;$03C544	|
	STZ.w $1483				;$03C547	|
	INC.w $1482				;$03C54A	|
CODE_03C54D:
	LDY.w $1483
	LDA.w $1476				;$03C550	|
	CLC					;$03C553	|
	ADC.w DATA_03C48F,Y			;$03C554	|
	STA.w $1476				;$03C557	|
	LDA.w $1478				;$03C55A	|
	CLC					;$03C55D	|
	ADC.w DATA_03C48F,Y			;$03C55E	|
	STA.w $1478				;$03C561	|
	CMP.w DATA_03C491,Y			;$03C564	|
	BNE CODE_03C572				;$03C567	|
	LDA.w $1483				;$03C569	|
	INC A					;$03C56C	|
	AND.b #$01				;$03C56D	|
	STA.w $1483				;$03C56F	|
CODE_03C572:
	LDA $13
	AND.b #$03				;$03C574	|
	BNE Return03C4F9			;$03C576	|
	LDY.b #$00				;$03C578	|
	LDA.w $1472				;$03C57A	|
	STA.w $147A				;$03C57D	|
	SEC					;$03C580	|
	SBC.w $1476				;$03C581	|
	BCS CODE_03C58A				;$03C584	|
	INY					;$03C586	|
	EOR.b #$FF				;$03C587	|
	INC A					;$03C589	|
CODE_03C58A:
	STA.w $1480
	STY.w $1484				;$03C58D	|
	STZ.w $147E				;$03C590	|
	LDY.b #$00				;$03C593	|
	LDA.w $1474				;$03C595	|
	STA.w $147C				;$03C598	|
	SEC					;$03C59B	|
	SBC.w $1478				;$03C59C	|
	BCS CODE_03C5A5				;$03C59F	|
	INY					;$03C5A1	|
	EOR.b #$FF				;$03C5A2	|
	INC A					;$03C5A4	|
CODE_03C5A5:
	STA.w $1481
	STY.w $1485				;$03C5A8	|
	STZ.w $147F				;$03C5AB	|
	LDA $C2,X				;$03C5AE	|
	STA $0F					;$03C5B0	|
	PHX					;$03C5B2	|
	REP #$10				;$03C5B3	|
	LDX.w #$0000				;$03C5B5	|
CODE_03C5B8:
	CPX.w #$005F
	BCC CODE_03C607				;$03C5BB	|
	LDA.w $147E				;$03C5BD	|
	CLC					;$03C5C0	|
	ADC.w $1480				;$03C5C1	|
	STA.w $147E				;$03C5C4	|
	BCS CODE_03C5CD				;$03C5C7	|
	CMP.b #$CF				;$03C5C9	|
	BCC CODE_03C5E0				;$03C5CB	|
CODE_03C5CD:
	SBC.b #$CF
	STA.w $147E				;$03C5CF	|
	INC.w $147A				;$03C5D2	|
	LDA.w $1484				;$03C5D5	|
	BNE CODE_03C5E0				;$03C5D8	|
	DEC.w $147A				;$03C5DA	|
	DEC.w $147A				;$03C5DD	|
CODE_03C5E0:
	LDA.w $147F
	CLC					;$03C5E3	|
	ADC.w $1481				;$03C5E4	|
	STA.w $147F				;$03C5E7	|
	BCS CODE_03C5F0				;$03C5EA	|
	CMP.b #$CF				;$03C5EC	|
	BCC CODE_03C603				;$03C5EE	|
CODE_03C5F0:
	SBC.b #$CF
	STA.w $147F				;$03C5F2	|
	INC.w $147C				;$03C5F5	|
	LDA.w $1485				;$03C5F8	|
	BNE CODE_03C603				;$03C5FB	|
	DEC.w $147C				;$03C5FD	|
	DEC.w $147C				;$03C600	|
CODE_03C603:
	LDA $0F
	BNE CODE_03C60F				;$03C605	|
CODE_03C607:
	LDA.b #$01
	STA.w $04A0,X				;$03C609	|
	DEC A					;$03C60C	|
	BRA CODE_03C618				;$03C60D	|

CODE_03C60F:
	LDA.w $147A
	STA.w $04A0,X				;$03C612	|
	LDA.w $147C				;$03C615	|
CODE_03C618:
	STA.w $04A1,X
	INX					;$03C61B	|
	INX					;$03C61C	|
	CPX.w #$01C0				;$03C61D	|
	BNE CODE_03C5B8				;$03C620	|
	SEP #$10				;$03C622	|
	PLX					;$03C624	|
	RTS					;$03C625	|

DATA_03C626:
	db $14,$28,$38,$20,$30,$4C,$40,$34
	db $2C,$1C,$08,$0C,$04,$0C,$1C,$24
	db $2C,$38,$40,$48,$50,$5C,$5C,$6C
	db $4C,$58,$24,$78,$64,$70,$78,$7C
	db $70,$68,$58,$4C,$40,$34,$24,$04
	db $18,$2C,$0C,$0C,$14,$18,$1C,$24
	db $2C,$28,$24,$30,$30,$34,$38,$3C
	db $44,$54,$48,$5C,$68,$40,$4C,$40
	db $3C,$40,$50,$54,$60,$54,$4C,$5C
	db $5C,$68,$74,$6C,$7C,$78,$68,$80
	db $18,$48,$2C,$1C

DATA_03C67A:
	db $1C,$0C,$08,$1C,$14,$08,$14,$24
	db $28,$2C,$30,$3C,$44,$4C,$44,$34
	db $40,$34,$24,$1C,$10,$0C,$18,$18
	db $2C,$28,$68,$28,$34,$34,$38,$40
	db $44,$44,$38,$3C,$44,$48,$4C,$5C
	db $5C,$54,$64,$74,$74,$88,$80,$94
	db $8C,$78,$6C,$64,$70,$7C,$8C,$98
	db $90,$98,$84,$84,$88,$78,$78,$6C
	db $5C,$50,$50,$48,$50,$5C,$64,$64
	db $74,$78,$74,$64,$60,$58,$54,$50
	db $50,$58,$30,$34

DATA_03C6CE:
	db $20,$30,$39,$47,$50,$60,$70,$7C
	db $7B,$80,$7D,$78,$6E,$60,$4F,$47
	db $41,$38,$30,$2A,$20,$10,$04,$00
	db $00,$08,$10,$20,$1A,$10,$0A,$06
	db $0F,$17,$16,$1C,$1F,$21,$10,$18
	db $20,$2C,$2E,$3B,$30,$30,$2D,$2A
	db $34,$36,$3A,$3F,$45,$4D,$5F,$54
	db $4E,$67,$70,$67,$70,$5C,$4E,$40
	db $48,$56,$57,$5F,$68,$72,$77,$6F
	db $66,$60,$67,$5C,$57,$4B,$4D,$54
	db $48,$43,$3D,$3C

DATA_03C722:
	db $18,$1E,$25,$22,$1A,$17,$20,$30
	db $41,$4F,$61,$70,$7F,$8C,$94,$92
	db $A0,$86,$93,$88,$88,$78,$66,$50
	db $40,$30,$22,$20,$2C,$30,$40,$4F
	db $59,$51,$3F,$39,$4C,$5F,$6A,$6F
	db $77,$7E,$6C,$60,$58,$48,$3D,$2F
	db $28,$38,$44,$30,$36,$27,$21,$2F
	db $39,$2A,$2F,$39,$40,$3F,$49,$50
	db $60,$59,$4C,$51,$48,$4F,$56,$67
	db $5B,$68,$75,$7D,$87,$8A,$7A,$6B
	db $70,$82,$73,$92

DATA_03C776:
	db $60,$B0,$40,$80

FireworkSfx1:
	db $26,$00,$26,$28

FireworkSfx2:
	db $00,$2B,$00,$00

FireworkSfx3:
	db $27,$00,$27,$29

FireworkSfx4:
	db $00,$2C,$00,$00

DATA_03C78A:
	db $00,$AA,$FF,$AA

DATA_03C78E:
	db $00,$7E,$27,$7E

DATA_03C792:
	db $C0,$C0,$FF,$C0

CODE_03C796:
	LDA.w $1564,X
	BEQ CODE_03C7A7				;$03C799	|
	DEC A					;$03C79B	|
	BNE Return03C7A6			;$03C79C	|
	INC.w $13C6				;$03C79E	|
	LDA.b #$FF				;$03C7A1	|
	STA.w $1493				;$03C7A3	|
Return03C7A6:
	RTS

CODE_03C7A7:
	LDA.w $156D
	AND.b #$03				;$03C7AA	|
	TAY					;$03C7AC	|
	LDA.w DATA_03C78A,Y			;$03C7AD	|
	STA.w $0701				;$03C7B0	|
	LDA.w DATA_03C78E,Y			;$03C7B3	|
	STA.w $0702				;$03C7B6	|
	LDA.w $1FEB				;$03C7B9	|
	BNE Return03C80F			;$03C7BC	|
	LDA.w $1534,X				;$03C7BE	|
	CMP.b #$04				;$03C7C1	|
	BEQ CODE_03C810				;$03C7C3	|
	LDY.b #$01				;$03C7C5	|
CODE_03C7C7:
	LDA.w $14C8,Y
	BEQ CODE_03C7D0				;$03C7CA	|
	DEY					;$03C7CC	|
	BPL CODE_03C7C7				;$03C7CD	|
	RTS					;$03C7CF	|

CODE_03C7D0:
	LDA.b #$08
	STA.w $14C8,Y				;$03C7D2	|
	LDA.b #$7A				;$03C7D5	|
	STA.w $009E,y				;$03C7D7	|
	LDA.b #$00				;$03C7DA	|
	STA.w $14E0,Y				;$03C7DC	|
	LDA.b #$A8				;$03C7DF	|
	CLC					;$03C7E1	|
	ADC $1C					;$03C7E2	|
	STA.w $00D8,y				;$03C7E4	|
	LDA $1D					;$03C7E7	|
	ADC.b #$00				;$03C7E9	|
	STA.w $14D4,Y				;$03C7EB	|
	PHX					;$03C7EE	|
	TYX					;$03C7EF	|
	JSL InitSpriteTables			;$03C7F0	|
	PLX					;$03C7F4	|
	PHX					;$03C7F5	|
	LDA.w $1534,X				;$03C7F6	|
	AND.b #$03				;$03C7F9	|
	STA.w $1534,Y				;$03C7FB	|
	TAX					;$03C7FE	|
	LDA.w DATA_03C792,X			;$03C7FF	|
	STA.w $1FEB				;$03C802	|
	LDA.w DATA_03C776,X			;$03C805	|
	STA.w $00E4,y				;$03C808	|
	PLX					;$03C80B	|
	INC.w $1534,X				;$03C80C	|
Return03C80F:
	RTS

CODE_03C810:
	LDA.b #$70
	STA.w $1564,X				;$03C812	|
	RTS					;$03C815	|

Firework:
	LDA $C2,X
	JSL execute_pointer			;$03C818	|

FireworkPtrs:
	dw CODE_03C828
	dw CODE_03C845
	dw CODE_03C88D
	dw CODE_03C941

FireworkSpeedY:
	db $E4,$E6,$E4,$E2

CODE_03C828:
	LDY.w $1534,X
	LDA.w FireworkSpeedY,Y			;$03C82B	|
	STA $AA,X				;$03C82E	|
	LDA.b #$25				;$03C830	|
	STA.w $1DFC				;$03C832	|
	LDA.b #$10				;$03C835	|
	STA.w $1564,X				;$03C837	|
	INC $C2,X				;$03C83A	|
	RTS					;$03C83C	|

DATA_03C83D:
	db $14,$0C,$10,$15

DATA_03C841:
	db $08,$10,$0C,$05

CODE_03C845:
	LDA.w $1564,X
	CMP.b #$01				;$03C848	|
	BNE CODE_03C85B				;$03C84A	|
	LDY.w $1534,X				;$03C84C	|
	LDA.w FireworkSfx1,Y			;$03C84F	|
	STA.w $1DF9				;$03C852	|
	LDA.w FireworkSfx2,Y			;$03C855	|
	STA.w $1DFC				;$03C858	|
CODE_03C85B:
	JSL UpdateYPosNoGrvty
	INC $B6,X				;$03C85F	|
	LDA $B6,X				;$03C861	|
	AND.b #$03				;$03C863	|
	BNE CODE_03C869				;$03C865	|
	INC $AA,X				;$03C867	|
CODE_03C869:
	LDA $AA,X
	CMP.b #$FC				;$03C86B	|
	BNE CODE_03C885				;$03C86D	|
	INC $C2,X				;$03C86F	|
	LDY.w $1534,X				;$03C871	|
	LDA.w DATA_03C83D,Y			;$03C874	|
	STA.w $151C,X				;$03C877	|
	LDA.w DATA_03C841,Y			;$03C87A	|
	STA.w $15AC,X				;$03C87D	|
	LDA.b #$08				;$03C880	|
	STA.w $156D				;$03C882	|
CODE_03C885:
	JSR CODE_03C96D
	RTS					;$03C888	|

DATA_03C889:
	db $FF,$80,$C0,$FF

CODE_03C88D:
	LDA.w $15AC,X
	DEC A					;$03C890	|
	BNE CODE_03C8A2				;$03C891	|
	LDY.w $1534,X				;$03C893	|
	LDA.w FireworkSfx3,Y			;$03C896	|
	STA.w $1DF9				;$03C899	|
	LDA.w FireworkSfx4,Y			;$03C89C	|
	STA.w $1DFC				;$03C89F	|
CODE_03C8A2:
	JSR CODE_03C8B1
	LDA $C2,X				;$03C8A5	|
	CMP.b #$02				;$03C8A7	|
	BNE CODE_03C8AE				;$03C8A9	|
	JSR CODE_03C8B1				;$03C8AB	|
CODE_03C8AE:
	JMP CODE_03C9E9

CODE_03C8B1:
	LDY.w $1534,X
	LDA.w $1570,X				;$03C8B4	|
	CLC					;$03C8B7	|
	ADC.w $151C,X				;$03C8B8	|
	STA.w $1570,X				;$03C8BB	|
	BCS ADDR_03C8DB				;$03C8BE	|
	CMP.w DATA_03C889,Y			;$03C8C0	|
	BCS CODE_03C8E0				;$03C8C3	|
	LDA.w $151C,X				;$03C8C5	|
	CMP.b #$02				;$03C8C8	|
	BCC CODE_03C8D4				;$03C8CA	|
	SEC					;$03C8CC	|
	SBC.b #$01				;$03C8CD	|
	STA.w $151C,X				;$03C8CF	|
	BCS CODE_03C8E4				;$03C8D2	|
CODE_03C8D4:
	LDA.b #$01
	STA.w $151C,X				;$03C8D6	|
	BRA CODE_03C8E4				;$03C8D9	|

ADDR_03C8DB:
	LDA.b #$FF
	STA.w $1570,X				;$03C8DD	|
CODE_03C8E0:
	INC $C2,X
	STZ $AA,X				;$03C8E2	|
CODE_03C8E4:
	LDA.w $151C,X
	AND.b #$FF				;$03C8E7	|
	TAY					;$03C8E9	|
	LDA.w DATA_03C8F1,Y			;$03C8EA	|
	STA.w $1602,X				;$03C8ED	|
	RTS					;$03C8F0	|

DATA_03C8F1:
	db $06,$05,$04,$03,$03,$03,$03,$02
	db $02,$02,$02,$02,$02,$02,$01,$01
	db $01,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $03,$03,$03,$03,$03,$03,$03,$03
	db $03,$03,$02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02

CODE_03C941:
	LDA $13
	AND.b #$07				;$03C943	|
	BNE CODE_03C949				;$03C945	|
	INC $AA,X				;$03C947	|
CODE_03C949:
	JSL UpdateYPosNoGrvty
	LDA.b #$07				;$03C94D	|
	LDY $AA,X				;$03C94F	|
	CPY.b #$08				;$03C951	|
	BNE CODE_03C958				;$03C953	|
	STZ.w $14C8,X				;$03C955	|
CODE_03C958:
	CPY.b #$03
	BCC CODE_03C962				;$03C95A	|
	INC A					;$03C95C	|
	CPY.b #$05				;$03C95D	|
	BCC CODE_03C962				;$03C95F	|
	INC A					;$03C961	|
CODE_03C962:
	STA.w $1602,X
	JSR CODE_03C9E9				;$03C965	|
	RTS					;$03C968	|

DATA_03C969:
	db $EC,$8E,$EC,$EC

CODE_03C96D:
	TXA
	EOR $13					;$03C96E	|
	AND.b #$03				;$03C970	|
	BNE Return03C9B8			;$03C972	|
	JSR GetDrawInfoBnk3			;$03C974	|
	LDY.b #$00				;$03C977	|
	LDA $00					;$03C979	|
	STA.w $0300,Y				;$03C97B	|
	STA.w $0304,Y				;$03C97E	|
	LDA $01					;$03C981	|
	STA.w $0301,Y				;$03C983	|
	PHX					;$03C986	|
	LDA.w $1534,X				;$03C987	|
	TAX					;$03C98A	|
	LDA $13					;$03C98B	|
	LSR					;$03C98D	|
	LSR					;$03C98E	|
	AND.b #$02				;$03C98F	|
	LSR					;$03C991	|
	ADC.w DATA_03C969,X			;$03C992	|
	STA.w $0302,Y				;$03C995	|
	PLX					;$03C998	|
	LDA $13					;$03C999	|
	ASL					;$03C99B	|
	AND.b #$0E				;$03C99C	|
	STA $02					;$03C99E	|
	LDA $13					;$03C9A0	|
	ASL					;$03C9A2	|
	ASL					;$03C9A3	|
	ASL					;$03C9A4	|
	ASL					;$03C9A5	|
	AND.b #$40				;$03C9A6	|
	ORA $02					;$03C9A8	|
	ORA.b #$31				;$03C9AA	|
	STA.w $0303,Y				;$03C9AC	|
	TYA					;$03C9AF	|
	LSR					;$03C9B0	|
	LSR					;$03C9B1	|
	TAY					;$03C9B2	|
	LDA.b #$00				;$03C9B3	|
	STA.w $0460,Y				;$03C9B5	|
Return03C9B8:
	RTS

DATA_03C9B9:
	db $36,$35,$C7,$34,$34,$34,$34,$24
	db $03,$03,$36,$35,$C7,$34,$34,$24
	db $24,$24,$24,$03,$36,$35,$C7,$34
	db $34,$34,$24,$24,$03,$24,$36,$35
	db $C7,$34,$24,$24,$24,$24,$24,$03
DATA_03C9E1:
	db $00,$01,$01,$00,$00,$FF,$FF,$00

CODE_03C9E9:
	TXA
	EOR $13					;$03C9EA	|
	STA $05					;$03C9EC	|
	LDA.w $1570,X				;$03C9EE	|
	STA $06					;$03C9F1	|
	LDA.w $1602,X				;$03C9F3	|
	STA $07					;$03C9F6	|
	LDA $E4,X				;$03C9F8	|
	STA $08					;$03C9FA	|
	LDA $D8,X				;$03C9FC	|
	SEC					;$03C9FE	|
	SBC $1C					;$03C9FF	|
	STA $09					;$03CA01	|
	LDA.w $1534,X				;$03CA03	|
	STA $0A					;$03CA06	|
	PHX					;$03CA08	|
	LDX.b #$3F				;$03CA09	|
	LDY.b #$00				;$03CA0B	|
CODE_03CA0D:
	STX $04
	LDA $0A					;$03CA0F	|
	CMP.b #$03				;$03CA11	|
	LDA.w DATA_03C626,X			;$03CA13	|
	BCC CODE_03CA1B				;$03CA16	|
	LDA.w DATA_03C6CE,X			;$03CA18	|
CODE_03CA1B:
	SEC
	SBC.b #$40				;$03CA1C	|
	STA $00					;$03CA1E	|
	PHY					;$03CA20	|
	LDA $0A					;$03CA21	|
	CMP.b #$03				;$03CA23	|
	LDA.w DATA_03C67A,X			;$03CA25	|
	BCC CODE_03CA2D				;$03CA28	|
	LDA.w DATA_03C722,X			;$03CA2A	|
CODE_03CA2D:
	SEC
	SBC.b #$50				;$03CA2E	|
	STA $01					;$03CA30	|
	LDA $00					;$03CA32	|
	BPL CODE_03CA39				;$03CA34	|
	EOR.b #$FF				;$03CA36	|
	INC A					;$03CA38	|
CODE_03CA39:
	STA.w $4202
	LDA $06					;$03CA3C	|
	STA.w $4203				;$03CA3E	|
	NOP					;$03CA41	|
	NOP					;$03CA42	|
	NOP					;$03CA43	|
	NOP					;$03CA44	|
	LDA.w $4217				;$03CA45	|
	LDY $00					;$03CA48	|
	BPL CODE_03CA4F				;$03CA4A	|
	EOR.b #$FF				;$03CA4C	|
	INC A					;$03CA4E	|
CODE_03CA4F:
	STA $02
	LDA $01					;$03CA51	|
	BPL CODE_03CA58				;$03CA53	|
	EOR.b #$FF				;$03CA55	|
	INC A					;$03CA57	|
CODE_03CA58:
	STA.w $4202
	LDA $06					;$03CA5B	|
	STA.w $4203				;$03CA5D	|
	NOP					;$03CA60	|
	NOP					;$03CA61	|
	NOP					;$03CA62	|
	NOP					;$03CA63	|
	LDA.w $4217				;$03CA64	|
	LDY $01					;$03CA67	|
	BPL CODE_03CA6E				;$03CA69	|
	EOR.b #$FF				;$03CA6B	|
	INC A					;$03CA6D	|
CODE_03CA6E:
	STA $03
	LDY.b #$00				;$03CA70	|
	LDA $07					;$03CA72	|
	CMP.b #$06				;$03CA74	|
	BCC CODE_03CA82				;$03CA76	|
	LDA $05					;$03CA78	|
	CLC					;$03CA7A	|
	ADC $04					;$03CA7B	|
	LSR					;$03CA7D	|
	LSR					;$03CA7E	|
	AND.b #$07				;$03CA7F	|
	TAY					;$03CA81	|
CODE_03CA82:
	LDA.w DATA_03C9E1,Y
	PLY					;$03CA85	|
	CLC					;$03CA86	|
	ADC $02					;$03CA87	|
	CLC					;$03CA89	|
	ADC $08					;$03CA8A	|
	STA.w $0200,Y				;$03CA8C	|
	LDA $03					;$03CA8F	|
	CLC					;$03CA91	|
	ADC $09					;$03CA92	|
	STA.w $0201,Y				;$03CA94	|
	PHX					;$03CA97	|
	LDA $05					;$03CA98	|
	AND.b #$03				;$03CA9A	|
	STA $0F					;$03CA9C	|
	ASL					;$03CA9E	|
	ASL					;$03CA9F	|
	ASL					;$03CAA0	|
	ADC $0F					;$03CAA1	|
	ADC $0F					;$03CAA3	|
	ADC $07					;$03CAA5	|
	TAX					;$03CAA7	|
	LDA.w DATA_03C9B9,X			;$03CAA8	|
	STA.w $0202,Y				;$03CAAB	|
	PLX					;$03CAAE	|
	LDA $05					;$03CAAF	|
	LSR					;$03CAB1	|
	NOP					;$03CAB2	|
	NOP					;$03CAB3	|
	PHX					;$03CAB4	|
	LDX $0A					;$03CAB5	|
	CPX.b #$03				;$03CAB7	|
	BEQ CODE_03CABD				;$03CAB9	|
	EOR $04					;$03CABB	|
CODE_03CABD:
	AND.b #$0E
	ORA.b #$31				;$03CABF	|
	STA.w $0203,Y				;$03CAC1	|
	PLX					;$03CAC4	|
	PHY					;$03CAC5	|
	TYA					;$03CAC6	|
	LSR					;$03CAC7	|
	LSR					;$03CAC8	|
	TAY					;$03CAC9	|
	LDA.b #$00				;$03CACA	|
	STA.w $0420,Y				;$03CACC	|
	PLY					;$03CACF	|
	INY					;$03CAD0	|
	INY					;$03CAD1	|
	INY					;$03CAD2	|
	INY					;$03CAD3	|
	DEX					;$03CAD4	|
	BMI CODE_03CADA				;$03CAD5	|
	JMP CODE_03CA0D				;$03CAD7	|

CODE_03CADA:
	LDX.b #$53
CODE_03CADC:
	STX $04
	LDA $0A					;$03CADE	|
	CMP.b #$03				;$03CAE0	|
	LDA.w DATA_03C626,X			;$03CAE2	|
	BCC CODE_03CAEA				;$03CAE5	|
	LDA.w DATA_03C6CE,X			;$03CAE7	|
CODE_03CAEA:
	SEC
	SBC.b #$40				;$03CAEB	|
	STA $00					;$03CAED	|
	LDA $0A					;$03CAEF	|
	CMP.b #$03				;$03CAF1	|
	LDA.w DATA_03C67A,X			;$03CAF3	|
	BCC CODE_03CAFB				;$03CAF6	|
	LDA.w DATA_03C722,X			;$03CAF8	|
CODE_03CAFB:
	SEC
	SBC.b #$50				;$03CAFC	|
	STA $01					;$03CAFE	|
	PHY					;$03CB00	|
	LDA $00					;$03CB01	|
	BPL CODE_03CB08				;$03CB03	|
	EOR.b #$FF				;$03CB05	|
	INC A					;$03CB07	|
CODE_03CB08:
	STA.w $4202
	LDA $06					;$03CB0B	|
	STA.w $4203				;$03CB0D	|
	NOP					;$03CB10	|
	NOP					;$03CB11	|
	NOP					;$03CB12	|
	NOP					;$03CB13	|
	LDA.w $4217				;$03CB14	|
	LDY $00					;$03CB17	|
	BPL CODE_03CB1E				;$03CB19	|
	EOR.b #$FF				;$03CB1B	|
	INC A					;$03CB1D	|
CODE_03CB1E:
	STA $02
	LDA $01					;$03CB20	|
	BPL CODE_03CB27				;$03CB22	|
	EOR.b #$FF				;$03CB24	|
	INC A					;$03CB26	|
CODE_03CB27:
	STA.w $4202
	LDA $06					;$03CB2A	|
	STA.w $4203				;$03CB2C	|
	NOP					;$03CB2F	|
	NOP					;$03CB30	|
	NOP					;$03CB31	|
	NOP					;$03CB32	|
	LDA.w $4217				;$03CB33	|
	LDY $01					;$03CB36	|
	BPL CODE_03CB3D				;$03CB38	|
	EOR.b #$FF				;$03CB3A	|
	INC A					;$03CB3C	|
CODE_03CB3D:
	STA $03
	LDY.b #$00				;$03CB3F	|
	LDA $07					;$03CB41	|
	CMP.b #$06				;$03CB43	|
	BCC CODE_03CB51				;$03CB45	|
	LDA $05					;$03CB47	|
	CLC					;$03CB49	|
	ADC $04					;$03CB4A	|
	LSR					;$03CB4C	|
	LSR					;$03CB4D	|
	AND.b #$07				;$03CB4E	|
	TAY					;$03CB50	|
CODE_03CB51:
	LDA.w DATA_03C9E1,Y
	PLY					;$03CB54	|
	CLC					;$03CB55	|
	ADC $02					;$03CB56	|
	CLC					;$03CB58	|
	ADC $08					;$03CB59	|
	STA.w $0300,Y				;$03CB5B	|
	LDA $03					;$03CB5E	|
	CLC					;$03CB60	|
	ADC $09					;$03CB61	|
	STA.w $0301,Y				;$03CB63	|
	PHX					;$03CB66	|
	LDA $05					;$03CB67	|
	AND.b #$03				;$03CB69	|
	STA $0F					;$03CB6B	|
	ASL					;$03CB6D	|
	ASL					;$03CB6E	|
	ASL					;$03CB6F	|
	ADC $0F					;$03CB70	|
	ADC $0F					;$03CB72	|
	ADC $07					;$03CB74	|
	TAX					;$03CB76	|
	LDA.w DATA_03C9B9,X			;$03CB77	|
	STA.w $0302,Y				;$03CB7A	|
	PLX					;$03CB7D	|
	LDA $05					;$03CB7E	|
	LSR					;$03CB80	|
	NOP					;$03CB81	|
	NOP					;$03CB82	|
	PHX					;$03CB83	|
	LDX $0A					;$03CB84	|
	CPX.b #$03				;$03CB86	|
	BEQ CODE_03CB8C				;$03CB88	|
	EOR $04					;$03CB8A	|
CODE_03CB8C:
	AND.b #$0E
	ORA.b #$31				;$03CB8E	|
	STA.w $0303,Y				;$03CB90	|
	PLX					;$03CB93	|
	PHY					;$03CB94	|
	TYA					;$03CB95	|
	LSR					;$03CB96	|
	LSR					;$03CB97	|
	TAY					;$03CB98	|
	LDA.b #$00				;$03CB99	|
	STA.w $0460,Y				;$03CB9B	|
	PLY					;$03CB9E	|
	INY					;$03CB9F	|
	INY					;$03CBA0	|
	INY					;$03CBA1	|
	INY					;$03CBA2	|
	DEX					;$03CBA3	|
	CPX.b #$3F				;$03CBA4	|
	BEQ CODE_03CBAB				;$03CBA6	|
	JMP CODE_03CADC				;$03CBA8	|

CODE_03CBAB:
	PLX
	RTS					;$03CBAC	|

ChuckSprGenDispX:
	db $14,$EC

ChuckSprGenSpeedHi:
	db $00,$FF

ChuckSprGenSpeedLo:
	db $18,$E8

CODE_03CBB3:
	JSL FindFreeSprSlot
	BMI Return03CC08			;$03CBB7	|
	LDA.b #$1B				;$03CBB9	|
	STA.w $009E,y				;$03CBBB	|
	PHX					;$03CBBE	|
	TYX					;$03CBBF	|
	JSL InitSpriteTables			;$03CBC0	|
	PLX					;$03CBC4	|
	LDA.b #$08				;$03CBC5	|
	STA.w $14C8,Y				;$03CBC7	|
	LDA $D8,X				;$03CBCA	|
	STA.w $00D8,y				;$03CBCC	|
	LDA.w $14D4,X				;$03CBCF	|
	STA.w $14D4,Y				;$03CBD2	|
	LDA $E4,X				;$03CBD5	|
	STA $01					;$03CBD7	|
	LDA.w $14E0,X				;$03CBD9	|
	STA $00					;$03CBDC	|
	PHX					;$03CBDE	|
	LDA.w $157C,X				;$03CBDF	|
	TAX					;$03CBE2	|
	LDA $01					;$03CBE3	|
	CLC					;$03CBE5	|
	ADC.l ChuckSprGenDispX,X		;$03CBE6	|
	STA.w $00E4,y				;$03CBEA	|
	LDA $00					;$03CBED	|
	ADC.l ChuckSprGenSpeedHi,X		;$03CBEF	|
	STA.w $14E0,Y				;$03CBF3	|
	LDA.l ChuckSprGenSpeedLo,X		;$03CBF6	|
	STA.w $00B6,y				;$03CBFA	|
	LDA.b #$E0				;$03CBFD	|
	STA.w $00AA,y				;$03CBFF	|
	LDA.b #$10				;$03CC02	|
	STA.w $1540,Y				;$03CC04	|
	PLX					;$03CC07	|
Return03CC08:
	RTL

CODE_03CC09:
	PHB
	PHK					;$03CC0A	|
	PLB					;$03CC0B	|
	STZ.w $1662,X				;$03CC0C	|
	JSR CODE_03CC14				;$03CC0F	|
	PLB					;$03CC12	|
	RTL					;$03CC13	|

CODE_03CC14:
	JSR CODE_03D484
	LDA.w $14C8,X				;$03CC17	|
	CMP.b #$08				;$03CC1A	|
	BNE Return03CC37			;$03CC1C	|
	LDA $9D					;$03CC1E	|
	BNE Return03CC37			;$03CC20	|
	LDA.w $151C,X				;$03CC22	|
	JSL execute_pointer			;$03CC25	|

PipeKoopaPtrs:
	dw CODE_03CC8A
	dw CODE_03CD21
	dw CODE_03CDC7
	dw CODE_03CDEF
	dw CODE_03CE0E
	dw CODE_03CE5A
	dw CODE_03CE89

Return03CC37:
	RTS

DATA_03CC38:
	db $18,$38,$58,$78,$98,$B8,$D8,$78
DATA_03CC40:
	db $40,$50,$50,$40,$30,$40,$50,$40
DATA_03CC48:
	db $50,$4A,$50,$4A,$4A,$40,$4A,$48
	db $4A

DATA_03CC51:
	db $02,$04,$06,$08,$0B,$0C,$0E,$10
	db $13

DATA_03CC5A:
	db $00,$01,$02,$03,$04,$05,$06,$00
	db $01,$02,$03,$04,$05,$06,$00,$01
	db $02,$03,$04,$05,$06,$00,$01,$02
	db $03,$04,$05,$06,$00,$01,$02,$03
	db $04,$05,$06,$00,$01,$02,$03,$04
	db $05,$06,$00,$01,$02,$03,$04,$05

CODE_03CC8A:
	LDA.w $1540,X
	BNE Return03CCDF			;$03CC8D	|
	LDA.w $1570,X				;$03CC8F	|
	BNE CODE_03CC9D				;$03CC92	|
	JSL GetRand				;$03CC94	|
	AND.b #$0F				;$03CC98	|
	STA.w $160E,X				;$03CC9A	|
CODE_03CC9D:
	LDA.w $160E,X
	ORA.w $1570,X				;$03CCA0	|
	TAY					;$03CCA3	|
	LDA.w DATA_03CC5A,Y			;$03CCA4	|
	TAY					;$03CCA7	|
	LDA.w DATA_03CC38,Y			;$03CCA8	|
	STA $E4,X				;$03CCAB	|
	LDA $C2,X				;$03CCAD	|
	CMP.b #$06				;$03CCAF	|
	LDA.w DATA_03CC40,Y			;$03CCB1	|
	BCC CODE_03CCB8				;$03CCB4	|
	LDA.b #$50				;$03CCB6	|
CODE_03CCB8:
	STA $D8,X
	LDA.b #$08				;$03CCBA	|
	LDY.w $1570,X				;$03CCBC	|
	BNE CODE_03CCCC				;$03CCBF	|
	JSR CODE_03CCE2				;$03CCC1	|
	JSL GetRand				;$03CCC4	|
	LSR					;$03CCC8	|
	LSR					;$03CCC9	|
	AND.b #$07				;$03CCCA	|
CODE_03CCCC:
	STA.w $1528,X
	TAY					;$03CCCF	|
	LDA.w DATA_03CC48,Y			;$03CCD0	|
	STA.w $1540,X				;$03CCD3	|
	INC.w $151C,X				;$03CCD6	|
	LDA.w DATA_03CC51,Y			;$03CCD9	|
	STA.w $1602,X				;$03CCDC	|
Return03CCDF:
	RTS

DATA_03CCE0:
	db $10,$20

CODE_03CCE2:
	LDY.b #$01
	JSR CODE_03CCE8				;$03CCE4	|
	DEY					;$03CCE7	|
CODE_03CCE8:
	LDA.b #$08
	STA.w $14C8,Y				;$03CCEA	|
	LDA.b #$29				;$03CCED	|
	STA.w $009E,y				;$03CCEF	|
	PHX					;$03CCF2	|
	TYX					;$03CCF3	|
	JSL InitSpriteTables			;$03CCF4	|
	PLX					;$03CCF8	|
	LDA.w DATA_03CCE0,Y			;$03CCF9	|
	STA.w $1570,Y				;$03CCFC	|
	LDA $C2,X				;$03CCFF	|
	STA.w $00C2,y				;$03CD01	|
	LDA.w $160E,X				;$03CD04	|
	STA.w $160E,Y				;$03CD07	|
	LDA $E4,X				;$03CD0A	|
	STA.w $00E4,y				;$03CD0C	|
	LDA.w $14E0,X				;$03CD0F	|
	STA.w $14E0,Y				;$03CD12	|
	LDA $D8,X				;$03CD15	|
	STA.w $00D8,y				;$03CD17	|
	LDA.w $14D4,X				;$03CD1A	|
	STA.w $14D4,Y				;$03CD1D	|
	RTS					;$03CD20	|

CODE_03CD21:
	LDA.w $1540,X
	BNE CODE_03CD2E				;$03CD24	|
	LDA.b #$40				;$03CD26	|
	STA.w $1540,X				;$03CD28	|
	INC.w $151C,X				;$03CD2B	|
CODE_03CD2E:
	LDA.b #$F8
	STA $AA,X				;$03CD30	|
	JSL UpdateYPosNoGrvty			;$03CD32	|
	RTS					;$03CD36	|

DATA_03CD37:
	db $02,$02,$02,$02,$03,$03,$03,$03
	db $03,$03,$03,$03,$02,$02,$02,$02
	db $04,$04,$04,$04,$05,$05,$04,$05
	db $05,$04,$05,$05,$04,$04,$04,$04
	db $06,$06,$06,$06,$07,$07,$07,$07
	db $07,$07,$07,$07,$06,$06,$06,$06
	db $08,$08,$08,$08,$08,$09,$09,$08
	db $08,$09,$09,$08,$08,$08,$08,$08
	db $0B,$0B,$0B,$0B,$0B,$0A,$0B,$0A
	db $0B,$0A,$0B,$0A,$0B,$0B,$0B,$0B
	db $0C,$0C,$0C,$0C,$0D,$0C,$0D,$0C
	db $0D,$0C,$0D,$0C,$0D,$0D,$0D,$0D
	db $0E,$0E,$0E,$0E,$0E,$0F,$0E,$0F
	db $0E,$0F,$0E,$0F,$0E,$0E,$0E,$0E
	db $10,$10,$10,$10,$11,$12,$11,$10
	db $11,$12,$11,$10,$11,$11,$11,$11
	db $13,$13,$13,$13,$13,$13,$13,$13
	db $13,$13,$13,$13,$13,$13,$13,$13

CODE_03CDC7:
	JSR CODE_03CEA7
	LDA.w $1540,X				;$03CDCA	|
	BNE CODE_03CDDA				;$03CDCD	|
CODE_03CDCF:
	LDA.b #$24
	STA.w $1540,X				;$03CDD1	|
	LDA.b #$03				;$03CDD4	|
	STA.w $151C,X				;$03CDD6	|
	RTS					;$03CDD9	|

CODE_03CDDA:
	LSR
	LSR					;$03CDDB	|
	STA $00					;$03CDDC	|
	LDA.w $1528,X				;$03CDDE	|
	ASL					;$03CDE1	|
	ASL					;$03CDE2	|
	ASL					;$03CDE3	|
	ASL					;$03CDE4	|
	ORA $00					;$03CDE5	|
	TAY					;$03CDE7	|
	LDA.w DATA_03CD37,Y			;$03CDE8	|
	STA.w $1602,X				;$03CDEB	|
	RTS					;$03CDEE	|

CODE_03CDEF:
	LDA.w $1540,X
	BNE CODE_03CE05				;$03CDF2	|
	LDA.w $1570,X				;$03CDF4	|
	BEQ CODE_03CDFD				;$03CDF7	|
	STZ.w $14C8,X				;$03CDF9	|
	RTS					;$03CDFC	|

CODE_03CDFD:
	STZ.w $151C,X
	LDA.b #$30				;$03CE00	|
	STA.w $1540,X				;$03CE02	|
CODE_03CE05:
	LDA.b #$10
	STA $AA,X				;$03CE07	|
	JSL UpdateYPosNoGrvty			;$03CE09	|
	RTS					;$03CE0D	|

CODE_03CE0E:
	LDA.w $1540,X
	BNE CODE_03CE2A				;$03CE11	|
	INC.w $1534,X				;$03CE13	|
	LDA.w $1534,X				;$03CE16	|
	CMP.b #$03				;$03CE19	|
	BNE CODE_03CDCF				;$03CE1B	|
	LDA.b #$05				;$03CE1D	|
	STA.w $151C,X				;$03CE1F	|
	STZ $AA,X				;$03CE22	|
	LDA.b #$23				;$03CE24	|
	STA.w $1DF9				;$03CE26	|
	RTS					;$03CE29	|

CODE_03CE2A:
	LDY.w $1570,X
	BNE CODE_03CE42				;$03CE2D	|
CODE_03CE2F:
	CMP.b #$24
	BNE CODE_03CE38				;$03CE31	|
	LDY.b #$29				;$03CE33	|
	STY.w $1DFC				;$03CE35	|
CODE_03CE38:
	LDA $14
	LSR					;$03CE3A	|
	LSR					;$03CE3B	|
	AND.b #$01				;$03CE3C	|
	STA.w $1602,X				;$03CE3E	|
	RTS					;$03CE41	|

CODE_03CE42:
	CMP.b #$10
	BNE CODE_03CE4B				;$03CE44	|
	LDY.b #$2A				;$03CE46	|
	STY.w $1DFC				;$03CE48	|
CODE_03CE4B:
	LSR
	LSR					;$03CE4C	|
	LSR					;$03CE4D	|
	TAY					;$03CE4E	|
	LDA.w DATA_03CE56,Y			;$03CE4F	|
	STA.w $1602,X				;$03CE52	|
	RTS					;$03CE55	|

DATA_03CE56:
	db $16,$16,$15,$14

CODE_03CE5A:
	JSL UpdateYPosNoGrvty
	LDA $AA,X				;$03CE5E	|
	CMP.b #$40				;$03CE60	|
	BPL CODE_03CE69				;$03CE62	|
	CLC					;$03CE64	|
	ADC.b #$03				;$03CE65	|
	STA $AA,X				;$03CE67	|
CODE_03CE69:
	LDA.w $14D4,X
	BEQ CODE_03CE87				;$03CE6C	|
	LDA $D8,X				;$03CE6E	|
	CMP.b #$85				;$03CE70	|
	BCC CODE_03CE87				;$03CE72	|
	LDA.b #$06				;$03CE74	|
	STA.w $151C,X				;$03CE76	|
	LDA.b #$80				;$03CE79	|
	STA.w $1540,X				;$03CE7B	|
	LDA.b #$20				;$03CE7E	|
	STA.w $1DFC				;$03CE80	|
	JSL CODE_028528				;$03CE83	|
CODE_03CE87:
	BRA CODE_03CE2F

CODE_03CE89:
	LDA.w $1540,X
	BNE CODE_03CE9E				;$03CE8C	|
	STZ.w $14C8,X				;$03CE8E	|
	INC.w $13C6				;$03CE91	|
	LDA.b #$FF				;$03CE94	|
	STA.w $1493				;$03CE96	|
	LDA.b #$0B				;$03CE99	|
	STA.w $1DFB				;$03CE9B	|
CODE_03CE9E:
	LDA.b #$04
	STA $AA,X				;$03CEA0	|
	JSL UpdateYPosNoGrvty			;$03CEA2	|
	RTS					;$03CEA6	|

CODE_03CEA7:
	JSL MarioSprInteract
	BCC Return03CEF1			;$03CEAB	|
	LDA $7D					;$03CEAD	|
	CMP.b #$10				;$03CEAF	|
	BMI CODE_03CEED				;$03CEB1	|
	JSL DisplayContactGfx			;$03CEB3	|
	LDA.b #$02				;$03CEB7	|
	JSL GivePoints				;$03CEB9	|
	JSL BoostMarioSpeed			;$03CEBD	|
	LDA.b #$02				;$03CEC1	|
	STA.w $1DF9				;$03CEC3	|
	LDA.w $1570,X				;$03CEC6	|
	BNE CODE_03CEDB				;$03CEC9	|
	LDA.b #$28				;$03CECB	|
	STA.w $1DFC				;$03CECD	|
	LDA.w $1534,X				;$03CED0	|
	CMP.b #$02				;$03CED3	|
	BNE CODE_03CEDB				;$03CED5	|
	JSL KillMostSprites			;$03CED7	|
CODE_03CEDB:
	LDA.b #$04
	STA.w $151C,X				;$03CEDD	|
	LDA.b #$50				;$03CEE0	|
	LDY.w $1570,X				;$03CEE2	|
	BEQ CODE_03CEE9				;$03CEE5	|
	LDA.b #$1F				;$03CEE7	|
CODE_03CEE9:
	STA.w $1540,X
	RTS					;$03CEEC	|

CODE_03CEED:
	JSL HurtMario
Return03CEF1:
	RTS

DATA_03CEF2:
	db $F8,$08,$F8,$08,$00,$00,$F8,$08
	db $F8,$08,$00,$00,$F8,$00,$00,$00
	db $00,$00,$FB,$00,$FB,$03,$00,$00
	db $F8,$08,$00,$00,$08,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$00,$00,$00
	db $00,$00,$F8,$00,$08,$00,$00,$00
	db $F8,$08,$00,$06,$00,$00,$F8,$08
	db $00,$02,$00,$00,$F8,$08,$00,$04
	db $00,$08,$F8,$08,$00,$00,$08,$00
	db $F8,$08,$00,$00,$00,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$08,$00,$00
	db $08,$00,$F8,$08,$00,$00,$08,$00
	db $F8,$08,$00,$00,$00,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$08,$00,$00
	db $00,$00,$F8,$08,$00,$00,$08,$00
	db $F8,$08,$00,$00,$00,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$08,$00,$00
	db $00,$00

DATA_03CF7C:
	db $F8,$08,$F8,$08,$00,$00,$F8,$08
	db $F8,$08,$00,$00,$F8,$00,$08,$00
	db $00,$00,$FB,$00,$FB,$03,$00,$00
	db $F8,$08,$00,$00,$08,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$00,$08,$00
	db $00,$00,$F8,$00,$08,$00,$00,$00
	db $F8,$08,$00,$06,$00,$08,$F8,$08
	db $00,$02,$00,$08,$F8,$08,$00,$04
	db $00,$08,$F8,$08,$00,$00,$08,$00
	db $F8,$08,$00,$00,$00,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$08,$00,$00
	db $08,$00,$F8,$08,$00,$00,$08,$00
	db $F8,$08,$00,$00,$00,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$08,$00,$00
	db $00,$00,$F8,$08,$00,$00,$08,$00
	db $F8,$08,$00,$00,$00,$00,$F8,$08
	db $00,$00,$00,$00,$F8,$08,$00,$00
	db $00,$00

DATA_03D006:
	db $04,$04,$14,$14,$00,$00,$04,$04
	db $14,$14,$00,$00,$00,$08,$F8,$00
	db $00,$00,$00,$08,$F8,$F8,$00,$00
	db $05,$05,$00,$F8,$F8,$00,$05,$05
	db $00,$00,$00,$00,$00,$08,$F8,$00
	db $00,$00,$00,$08,$00,$00,$00,$00
	db $05,$05,$00,$F8,$00,$00,$05,$05
	db $00,$F8,$00,$00,$05,$05,$00,$0F
	db $F8,$F8,$05,$05,$00,$F8,$F8,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$05,$05,$00,$F8
	db $F8,$00,$05,$05,$00,$F8,$F8,$00
	db $04,$04,$02,$00,$00,$00,$04,$04
	db $01,$00,$00,$00,$04,$04,$00,$00
	db $00,$00,$05,$05,$00,$F8,$F8,$00
	db $05,$05,$00,$00,$00,$00,$05,$05
	db $03,$00,$00,$00,$05,$05,$04,$00
	db $00,$00

DATA_03D090:
	db $04,$04,$14,$14,$00,$00,$04,$04
	db $14,$14,$00,$00,$00,$08,$00,$00
	db $00,$00,$00,$08,$F8,$F8,$00,$00
	db $05,$05,$00,$F8,$F8,$00,$05,$05
	db $00,$00,$00,$00,$00,$08,$00,$00
	db $00,$00,$00,$08,$08,$00,$00,$00
	db $05,$05,$00,$F8,$F8,$00,$05,$05
	db $00,$F8,$F8,$00,$05,$05,$00,$0F
	db $F8,$F8,$05,$05,$00,$F8,$F8,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$05,$05,$00,$F8
	db $F8,$00,$05,$05,$00,$F8,$F8,$00
	db $04,$04,$02,$00,$00,$00,$04,$04
	db $01,$00,$00,$00,$04,$04,$00,$00
	db $00,$00,$05,$05,$00,$F8,$F8,$00
	db $05,$05,$00,$00,$00,$00,$05,$05
	db $03,$00,$00,$00,$05,$05,$04,$00
	db $00,$00

DATA_03D11A:
	db $20,$20,$26,$26,$08,$00,$2E,$2E
	db $24,$24,$08,$00,$00,$28,$02,$00
	db $00,$00,$04,$28,$12,$12,$00,$00
	db $22,$22,$04,$12,$12,$00,$20,$20
	db $08,$00,$00,$00,$00,$28,$02,$00
	db $00,$00,$0A,$28,$13,$00,$00,$00
	db $20,$20,$0C,$02,$00,$00,$20,$20
	db $0C,$02,$00,$00,$22,$22,$06,$03
	db $12,$12,$20,$20,$06,$12,$12,$00
	db $2A,$2A,$00,$00,$00,$00,$2C,$2C
	db $00,$00,$00,$00,$20,$20,$06,$12
	db $12,$00,$20,$20,$06,$12,$12,$00
	db $22,$22,$08,$00,$00,$00,$20,$20
	db $08,$00,$00,$00,$2E,$2E,$08,$00
	db $00,$00,$4E,$4E,$60,$43,$43,$00
	db $4E,$4E,$64,$00,$00,$00,$62,$62
	db $64,$00,$00,$00,$62,$62,$64,$00
	db $00,$00

DATA_03D1A4:
	db $20,$20,$26,$26,$48,$00,$2E,$2E
	db $24,$24,$48,$00,$40,$28,$42,$00
	db $00,$00,$44,$28,$52,$52,$00,$00
	db $22,$22,$44,$52,$52,$00,$20,$20
	db $48,$00,$00,$00,$40,$28,$42,$00
	db $00,$00,$4A,$28,$53,$00,$00,$00
	db $20,$20,$4C,$1E,$1F,$00,$20,$20
	db $4C,$1F,$1E,$00,$22,$22,$44,$03
	db $52,$52,$20,$20,$44,$52,$52,$00
	db $2A,$2A,$00,$00,$00,$00,$2C,$2C
	db $00,$00,$00,$00,$20,$20,$46,$52
	db $52,$00,$20,$20,$46,$52,$52,$00
	db $22,$22,$48,$00,$00,$00,$20,$20
	db $48,$00,$00,$00,$2E,$2E,$48,$00
	db $00,$00,$4E,$4E,$66,$68,$68,$00
	db $4E,$4E,$6A,$00,$00,$00,$62,$62
	db $6A,$00,$00,$00,$62,$62,$6A,$00
	db $00,$00

LemmyGfxProp:
	db $05,$45,$05,$45,$05,$00,$05,$45
	db $05,$45,$05,$00,$05,$05,$05,$00
	db $00,$00,$05,$05,$05,$45,$00,$00
	db $05,$45,$05,$05,$45,$00,$05,$45
	db $05,$00,$00,$00,$05,$05,$05,$00
	db $00,$00,$05,$05,$05,$00,$00,$00
	db $05,$45,$05,$05,$00,$00,$05,$45
	db $45,$45,$00,$00,$05,$45,$05,$05
	db $05,$45,$05,$45,$45,$05,$45,$00
	db $05,$45,$00,$00,$00,$00,$05,$45
	db $00,$00,$00,$00,$05,$45,$45,$05
	db $45,$00,$05,$45,$05,$05,$45,$00
	db $05,$45,$05,$00,$00,$00,$05,$45
	db $05,$00,$00,$00,$05,$45,$05,$00
	db $00,$00,$07,$47,$07,$07,$47,$00
	db $07,$47,$07,$00,$00,$00,$07,$47
	db $07,$00,$00,$00,$07,$47,$07,$00
	db $00,$00

WendyGfxProp:
	db $09,$49,$09,$49,$09,$00,$09,$49
	db $09,$49,$09,$00,$09,$09,$09,$00
	db $00,$00,$09,$09,$09,$49,$00,$00
	db $09,$49,$09,$09,$49,$00,$09,$49
	db $09,$00,$00,$00,$09,$09,$09,$00
	db $00,$00,$09,$09,$09,$00,$00,$00
	db $09,$49,$09,$09,$09,$00,$09,$49
	db $49,$49,$49,$00,$09,$49,$09,$09
	db $09,$49,$09,$49,$49,$09,$49,$00
	db $09,$49,$00,$00,$00,$00,$09,$49
	db $00,$00,$00,$00,$09,$49,$49,$09
	db $49,$00,$09,$49,$09,$09,$49,$00
	db $09,$49,$09,$00,$00,$00,$09,$49
	db $09,$00,$00,$00,$09,$49,$09,$00
	db $00,$00,$05,$45,$05,$05,$45,$00
	db $05,$45,$05,$00,$00,$00,$05,$45
	db $05,$00,$00,$00,$05,$45,$05,$00
	db $00,$00

DATA_03D342:
	db $02,$02,$02,$02,$02,$04,$02,$02
	db $02,$02,$02,$04,$02,$02,$00,$04
	db $04,$04,$02,$02,$00,$00,$04,$04
	db $02,$02,$02,$00,$00,$04,$02,$02
	db $02,$04,$04,$04,$02,$02,$00,$04
	db $04,$04,$02,$02,$00,$04,$04,$04
	db $02,$02,$02,$00,$04,$04,$02,$02
	db $02,$00,$04,$04,$02,$02,$02,$00
	db $00,$00,$02,$02,$02,$00,$00,$04
	db $02,$02,$04,$04,$04,$04,$02,$02
	db $04,$04,$04,$04,$02,$02,$02,$00
	db $00,$04,$02,$02,$02,$00,$00,$04
	db $02,$02,$02,$04,$04,$04,$02,$02
	db $02,$04,$04,$04,$02,$02,$02,$04
	db $04,$04,$02,$02,$02,$00,$00,$04
	db $02,$02,$02,$04,$04,$04,$02,$02
	db $02,$04,$04,$04,$02,$02,$02,$04
	db $04,$04

DATA_03D3CC:
	db $02,$02,$02,$02,$02,$04,$02,$02
	db $02,$02,$02,$04,$02,$02,$00,$04
	db $04,$04,$02,$02,$00,$00,$04,$04
	db $02,$02,$02,$00,$00,$04,$02,$02
	db $02,$04,$04,$04,$02,$02,$00,$04
	db $04,$04,$02,$02,$00,$04,$04,$04
	db $02,$02,$02,$00,$00,$04,$02,$02
	db $02,$00,$00,$04,$02,$02,$02,$00
	db $00,$00,$02,$02,$02,$00,$00,$04
	db $02,$02,$04,$04,$04,$04,$02,$02
	db $04,$04,$04,$04,$02,$02,$02,$00
	db $00,$04,$02,$02,$02,$00,$00,$04
	db $02,$02,$02,$04,$04,$04,$02,$02
	db $02,$04,$04,$04,$02,$02,$02,$04
	db $04,$04,$02,$02,$02,$00,$00,$04
	db $02,$02,$02,$04,$04,$04,$02,$02
	db $02,$04,$04,$04,$02,$02,$02,$04
	db $04,$04

DATA_03D456:
	db $04,$04,$02,$03,$04,$02,$02,$02
	db $03,$03,$05,$04,$01,$01,$04,$04
	db $02,$02,$02,$04,$02,$02,$02

DATA_03D46D:
	db $04,$04,$02,$03,$04,$02,$02,$02
	db $04,$04,$05,$04,$01,$01,$04,$04
	db $02,$02,$02,$04,$02,$02,$02

CODE_03D484:
	JSR GetDrawInfoBnk3
	LDA.w $1602,X				;$03D487	|
	ASL					;$03D48A	|
	ASL					;$03D48B	|
	ADC.w $1602,X				;$03D48C	|
	ADC.w $1602,X				;$03D48F	|
	STA $02					;$03D492	|
	LDA $C2,X				;$03D494	|
	CMP.b #$06				;$03D496	|
	BEQ CODE_03D4DF				;$03D498	|
	PHX					;$03D49A	|
	LDA.w $1602,X				;$03D49B	|
	TAX					;$03D49E	|
	LDA.w DATA_03D456,X			;$03D49F	|
	TAX					;$03D4A2	|
CODE_03D4A3:
	PHX
	TXA					;$03D4A4	|
	CLC					;$03D4A5	|
	ADC $02					;$03D4A6	|
	TAX					;$03D4A8	|
	LDA $00					;$03D4A9	|
	CLC					;$03D4AB	|
	ADC.w DATA_03CEF2,X			;$03D4AC	|
	STA.w $0300,Y				;$03D4AF	|
	LDA $01					;$03D4B2	|
	CLC					;$03D4B4	|
	ADC.w DATA_03D006,X			;$03D4B5	|
	STA.w $0301,Y				;$03D4B8	|
	LDA.w DATA_03D11A,X			;$03D4BB	|
	STA.w $0302,Y				;$03D4BE	|
	LDA.w LemmyGfxProp,X			;$03D4C1	|
	ORA.b #$10				;$03D4C4	|
	STA.w $0303,Y				;$03D4C6	|
	PHY					;$03D4C9	|
	TYA					;$03D4CA	|
	LSR					;$03D4CB	|
	LSR					;$03D4CC	|
	TAY					;$03D4CD	|
	LDA.w DATA_03D342,X			;$03D4CE	|
	STA.w $0460,Y				;$03D4D1	|
	PLY					;$03D4D4	|
	INY					;$03D4D5	|
	INY					;$03D4D6	|
	INY					;$03D4D7	|
	INY					;$03D4D8	|
	PLX					;$03D4D9	|
	DEX					;$03D4DA	|
	BPL CODE_03D4A3				;$03D4DB	|
CODE_03D4DD:
	PLX
	RTS					;$03D4DE	|

CODE_03D4DF:
	PHX
	LDA.w $1602,X				;$03D4E0	|
	TAX					;$03D4E3	|
	LDA.w DATA_03D46D,X			;$03D4E4	|
	TAX					;$03D4E7	|
CODE_03D4E8:
	PHX
	TXA					;$03D4E9	|
	CLC					;$03D4EA	|
	ADC $02					;$03D4EB	|
	TAX					;$03D4ED	|
	LDA $00					;$03D4EE	|
	CLC					;$03D4F0	|
	ADC.w DATA_03CF7C,X			;$03D4F1	|
	STA.w $0300,Y				;$03D4F4	|
	LDA $01					;$03D4F7	|
	CLC					;$03D4F9	|
	ADC.w DATA_03D090,X			;$03D4FA	|
	STA.w $0301,Y				;$03D4FD	|
	LDA.w DATA_03D1A4,X			;$03D500	|
	STA.w $0302,Y				;$03D503	|
	LDA.w WendyGfxProp,X			;$03D506	|
	ORA.b #$10				;$03D509	|
	STA.w $0303,Y				;$03D50B	|
	PHY					;$03D50E	|
	TYA					;$03D50F	|
	LSR					;$03D510	|
	LSR					;$03D511	|
	TAY					;$03D512	|
	LDA.w DATA_03D3CC,X			;$03D513	|
	STA.w $0460,Y				;$03D516	|
	PLY					;$03D519	|
	INY					;$03D51A	|
	INY					;$03D51B	|
	INY					;$03D51C	|
	INY					;$03D51D	|
	PLX					;$03D51E	|
	DEX					;$03D51F	|
	BPL CODE_03D4E8				;$03D520	|
	BRA CODE_03D4DD				;$03D522	|

DATA_03D524:
	db $18,$20

DATA_03D526:
	db $A1,$0E,$20,$20,$88,$0E,$28,$20
	db $AB,$0E,$30,$20,$99,$0E,$38,$20
	db $A8,$0E,$40,$20,$BF,$0E,$48,$20
	db $AC,$0E,$58,$20,$88,$0E,$60,$20
	db $8B,$0E,$68,$20,$AF,$0E,$70,$20
	db $8C,$0E,$78,$20,$9E,$0E,$80,$20
	db $AD,$0E,$88,$20,$AE,$0E,$90,$20
	db $AB,$0E,$98,$20,$8C,$0E,$A8,$20
	db $99,$0E,$B0,$20,$AC,$0E,$C0,$20
	db $A8,$0E,$C8,$20,$AF,$0E,$D0,$20
	db $8C,$0E,$D8,$20,$AB,$0E,$E0,$20
	db $BD,$0E,$18,$30,$A1,$0E,$20,$30
	db $88,$0E,$28,$30,$AB,$0E,$30,$30
	db $99,$0E,$38,$30,$A8,$0E,$40,$30
	db $BE,$0E,$48,$30,$AD,$0E,$50,$30
	db $98,$0E,$58,$30,$8C,$0E,$68,$30
	db $A0,$0E,$70,$30,$AB,$0E,$78,$30
	db $99,$0E,$80,$30,$9E,$0E,$88,$30
	db $8A,$0E,$90,$30,$8C,$0E,$98,$30
	db $AC,$0E,$A0,$30,$AC,$0E,$A8,$30
	db $BE,$0E,$B0,$30,$B0,$0E,$B8,$30
	db $A8,$0E,$C0,$30,$AC,$0E,$C8,$30
	db $98,$0E,$D0,$30,$99,$0E,$D8,$30
	db $BE,$0E,$18,$40,$88,$0E,$20,$40
	db $9E,$0E,$28,$40,$8B,$0E,$38,$40
	db $98,$0E,$40,$40,$99,$0E,$48,$40
	db $AC,$0E,$58,$40,$8D,$0E,$60,$40
	db $AB,$0E,$68,$40,$99,$0E,$70,$40
	db $8C,$0E,$78,$40,$9E,$0E,$80,$40
	db $8B,$0E,$88,$40,$AC,$0E,$98,$40
	db $88,$0E,$A0,$40,$AB,$0E,$A8,$40
	db $8C,$0E,$B8,$40,$8E,$0E,$C0,$40
	db $A8,$0E,$C8,$40,$99,$0E,$D0,$40
	db $9E,$0E,$D8,$40,$8E,$0E,$18,$50
	db $AD,$0E,$20,$50,$A8,$0E,$30,$50
	db $AD,$0E,$38,$50,$88,$0E,$40,$50
	db $9B,$0E,$48,$50,$8C,$0E,$58,$50
	db $88,$0E,$68,$50,$AF,$0E,$70,$50
	db $88,$0E,$78,$50,$8A,$0E,$80,$50
	db $88,$0E,$88,$50,$AD,$0E,$90,$50
	db $99,$0E,$98,$50,$A8,$0E,$A0,$50
	db $9E,$0E,$A8,$50,$BD,$0E

CODE_03D674:
	PHX
	REP #$30				;$03D675	|
	LDX.w $1921				;$03D677	|
	BEQ CODE_03D6A8				;$03D67A	|
	DEX					;$03D67C	|
	LDY.w #$0000				;$03D67D	|
CODE_03D680:
	PHX
	TXA					;$03D681	|
	ASL					;$03D682	|
	ASL					;$03D683	|
	TAX					;$03D684	|
	LDA.w DATA_03D524,X			;$03D685	|
	STA.w $0200,Y				;$03D688	|
	LDA.w DATA_03D526,X			;$03D68B	|
	STA.w $0202,Y				;$03D68E	|
	PHY					;$03D691	|
	TYA					;$03D692	|
	LSR					;$03D693	|
	LSR					;$03D694	|
	TAY					;$03D695	|
	SEP #$20				;$03D696	|
	LDA.b #$00				;$03D698	|
	STA.w $0420,Y				;$03D69A	|
	REP #$20				;$03D69D	|
	PLY					;$03D69F	|
	PLX					;$03D6A0	|
	INY					;$03D6A1	|
	INY					;$03D6A2	|
	INY					;$03D6A3	|
	INY					;$03D6A4	|
	DEX					;$03D6A5	|
	BPL CODE_03D680				;$03D6A6	|
CODE_03D6A8:
	SEP #$30
	PLX					;$03D6AA	|
	RTS					;$03D6AB	|

DATA_03D6AC:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF

DATA_03D700:
	db $B0,$A0,$90,$80,$70,$60,$50,$40
	db $30,$20,$10,$00

CODE_03D70C:
	PHX
	LDA.w $1520				;$03D70D	|
	CLC					;$03D710	|
	ADC.w $1521				;$03D711	|
	ADC.w $1522				;$03D714	|
	ADC.w $1523				;$03D717	|
	CMP.b #$02				;$03D71A	|
	BCC CODE_03D757				;$03D71C	|
BreakBridge:
	LDX.w $1B9F
	CPX.b #$0C				;$03D721	|
	BCS CODE_03D757				;$03D723	|
	LDA.l DATA_03D700,X			;$03D725	|
	STA $9A					;$03D729	|
	STZ $9B					;$03D72B	|
	LDA.b #$B0				;$03D72D	|
	STA $98					;$03D72F	|
	STZ $99					;$03D731	|
	LDA.w $14A7				;$03D733	|
	BEQ CODE_03D74A				;$03D736	|
	CMP.b #$3C				;$03D738	|
	BNE CODE_03D757				;$03D73A	|
	JSR CODE_03D77F				;$03D73C	|
	JSR CODE_03D759				;$03D73F	|
	JSR CODE_03D77F				;$03D742	|
	INC.w $1B9F				;$03D745	|
	BRA CODE_03D757				;$03D748	|

CODE_03D74A:
	JSR CODE_03D766
	LDA.b #$40				;$03D74D	|
	STA.w $14A7				;$03D74F	|
	LDA.b #$07				;$03D752	|
	STA.w $1DFC				;$03D754	|
CODE_03D757:
	PLX
	RTL					;$03D758	|

CODE_03D759:
	REP #$20
	LDA.w #$0170				;$03D75B	|
	SEC					;$03D75E	|
	SBC $9A					;$03D75F	|
	STA $9A					;$03D761	|
	SEP #$20				;$03D763	|
	RTS					;$03D765	|

CODE_03D766:
	JSR CODE_03D76C
	JSR CODE_03D759				;$03D769	|
CODE_03D76C:
	REP #$20
	LDA $9A					;$03D76E	|
	SEC					;$03D770	|
	SBC $1A					;$03D771	|
	CMP.w #$0100				;$03D773	|
	SEP #$20				;$03D776	|
	BCS Return03D77E			;$03D778	|
	JSL CODE_028A44				;$03D77A	|
Return03D77E:
	RTS

CODE_03D77F:
	LDA $9A
	LSR					;$03D781	|
	LSR					;$03D782	|
	LSR					;$03D783	|
	STA $01					;$03D784	|
	LSR					;$03D786	|
	ORA $98					;$03D787	|
	REP #$20				;$03D789	|
	AND.w #$00FF				;$03D78B	|
	LDX $9B					;$03D78E	|
	BEQ CODE_03D798				;$03D790	|
	CLC					;$03D792	|
	ADC.w #$01B0				;$03D793	|
	LDX.b #$04				;$03D796	|
CODE_03D798:
	STX $00
	REP #$10				;$03D79A	|
	TAX					;$03D79C	|
	SEP #$20				;$03D79D	|
	LDA.b #$25				;$03D79F	|
	STA.l $7EC800,X				;$03D7A1	|
	LDA.b #$00				;$03D7A5	|
	STA.l $7FC800,X				;$03D7A7	|
	REP #$20				;$03D7AB	|
	LDA.l $7F837B				;$03D7AD	|
	TAX					;$03D7B1	|
	LDA.w #$C05A				;$03D7B2	|
	CLC					;$03D7B5	|
	ADC $00					;$03D7B6	|
	STA.l $7F837D,X				;$03D7B8	|
	ORA.w #$2000				;$03D7BC	|
	STA.l $7F8383,X				;$03D7BF	|
	LDA.w #$0240				;$03D7C3	|
	STA.l $7F837F,X				;$03D7C6	|
	STA.l $7F8385,X				;$03D7CA	|
	LDA.w #$38FC				;$03D7CE	|
	STA.l $7F8381,X				;$03D7D1	|
	STA.l $7F8387,X				;$03D7D5	|
	LDA.w #$00FF				;$03D7D9	|
	STA.l $7F8389,X				;$03D7DC	|
	TXA					;$03D7E0	|
	CLC					;$03D7E1	|
	ADC.w #$000C				;$03D7E2	|
	STA.l $7F837B				;$03D7E5	|
	SEP #$30				;$03D7E9	|
	RTS					;$03D7EB	|

IggyPlatform:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$15,$16,$17,$18,$17,$18
	db $17,$18,$17,$18,$19,$1A,$00,$00
	db $00,$00,$01,$02,$03,$04,$03,$04
	db $03,$04,$03,$04,$05,$12,$00,$00
	db $00,$00,$00,$07,$04,$03,$04,$03
	db $04,$03,$04,$03,$08,$00,$00,$00
	db $00,$00,$00,$09,$0A,$04,$03,$04
	db $03,$04,$03,$0B,$0C,$00,$00,$00
	db $00,$00,$00,$00,$0D,$0E,$04,$03
	db $04,$03,$0F,$10,$00,$00,$00,$00
	db $00,$00,$00,$00,$11,$02,$03,$04
	db $03,$04,$05,$12,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$07,$04,$03
	db $04,$03,$08,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$09,$0A,$04
	db $03,$0B,$0C,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$13,$03
	db $04,$14,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$13
	db $14,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
DATA_03D8EC:
	db $FF,$FF

DATA_03D8EE:
	db $FF,$FF,$FF,$FF,$24,$34,$25,$0B
	db $26,$36,$0E,$1B,$0C,$1C,$0D,$1D
	db $0E,$1E,$29,$39,$2A,$3A,$2B,$3B
	db $26,$38,$20,$30,$21,$31,$27,$37
	db $28,$38,$FF,$FF,$22,$32,$0E,$33
	db $0C,$1C,$0D,$1D,$0E,$3C,$2D,$3D
	db $FF,$FF,$07,$17,$0E,$23,$0E,$04
	db $0C,$1C,$0D,$1D,$0E,$09,$0E,$2C
	db $0A,$1A,$FF,$FF,$24,$34,$2B,$3B
	db $FF,$FF,$07,$17,$0E,$18,$0E,$19
	db $0A,$1A,$02,$12,$03,$13,$03,$08
	db $03,$05,$03,$05,$03,$14,$03,$15
	db $03,$05,$03,$05,$03,$08,$03,$06
	db $0F,$1F

CODE_03D958:
	REP #$10
	STZ.w $2115				;$03D95A	|
	STZ.w $2116				;$03D95D	|
	STZ.w $2117				;$03D960	|
	LDX.w #$4000				;$03D963	|
	LDA.b #$FF				;$03D966	|
CODE_03D968:
	STA.w $2118
	DEX					;$03D96B	|
	BNE CODE_03D968				;$03D96C	|
	SEP #$10				;$03D96E	|
	BIT.w $0D9B				;$03D970	|
	BVS Return03D990			;$03D973	|
	PHB					;$03D975	|
	PHK					;$03D976	|
	PLB					;$03D977	|
	LDA.b #$EC				;$03D978	|
	STA $05					;$03D97A	|
	LDA.b #$D7				;$03D97C	|
	STA $06					;$03D97E	|
	LDA.b #$03				;$03D980	|
	STA $07					;$03D982	|
	LDA.b #$10				;$03D984	|
	STA $00					;$03D986	|
	LDA.b #$08				;$03D988	|
	STA $01					;$03D98A	|
	JSR CODE_03D991				;$03D98C	|
	PLB					;$03D98F	|
Return03D990:
	RTL

CODE_03D991:
	STZ.w $2115
	LDY.b #$00				;$03D994	|
CODE_03D996:
	STY $02
	LDA.b #$00				;$03D998	|
CODE_03D99A:
	STA $03
	LDA $00					;$03D99C	|
	STA.w $2116				;$03D99E	|
	LDA $01					;$03D9A1	|
	STA.w $2117				;$03D9A3	|
	LDY $02					;$03D9A6	|
	LDA.b #$10				;$03D9A8	|
	STA $04					;$03D9AA	|
CODE_03D9AC:
	LDA [$05],Y
	STA.w $0AF6,Y				;$03D9AE	|
	ASL					;$03D9B1	|
	ASL					;$03D9B2	|
	ORA $03					;$03D9B3	|
	TAX					;$03D9B5	|
	LDA.l DATA_03D8EC,X			;$03D9B6	|
	STA.w $2118				;$03D9BA	|
	LDA.l DATA_03D8EE,X			;$03D9BD	|
	STA.w $2118				;$03D9C1	|
	INY					;$03D9C4	|
	DEC $04					;$03D9C5	|
	BNE CODE_03D9AC				;$03D9C7	|
	LDA $00					;$03D9C9	|
	CLC					;$03D9CB	|
	ADC.b #$80				;$03D9CC	|
	STA $00					;$03D9CE	|
	BCC CODE_03D9D4				;$03D9D0	|
	INC $01					;$03D9D2	|
CODE_03D9D4:
	LDA $03
	EOR.b #$01				;$03D9D6	|
	BNE CODE_03D99A				;$03D9D8	|
	TYA					;$03D9DA	|
	BNE CODE_03D996				;$03D9DB	|
	RTS					;$03D9DD	|

DATA_03D9DE:
	db $FF,$00,$FF,$FF,$02,$04,$06,$FF
	db $08,$0A,$0C,$FF,$0E,$10,$12,$FF
	db $FF,$00,$FF,$FF,$02,$04,$06,$FF
	db $08,$0A,$0C,$FF,$0E,$14,$16,$FF
	db $FF,$00,$FF,$FF,$02,$04,$06,$FF
	db $08,$0A,$0C,$FF,$0E,$18,$1A,$FF
	db $46,$48,$4A,$FF,$4C,$4E,$50,$FF
	db $52,$54,$0C,$FF,$0E,$18,$1A,$FF
	db $FF,$FF,$FF,$FF,$B2,$B4,$06,$FF
	db $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF
	db $FF,$1C,$FF,$FF,$1E,$20,$22,$FF
	db $24,$26,$28,$FF,$FF,$2A,$2C,$FF
	db $FF,$2E,$30,$FF,$32,$34,$35,$33
	db $36,$38,$39,$37,$42,$44,$45,$43
	db $FF,$2E,$30,$FF,$32,$34,$35,$33
	db $36,$38,$39,$37,$42,$44,$45,$43
	db $FF,$2E,$30,$FF,$32,$34,$35,$33
	db $36,$38,$39,$37,$3E,$40,$41,$3F
	db $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF
	db $08,$0A,$0C,$FF,$0E,$10,$12,$FF
	db $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF
	db $08,$0A,$0C,$FF,$0E,$14,$16,$FF
	db $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF
	db $08,$0A,$0C,$FF,$0E,$18,$1A,$FF
	db $6C,$6E,$FF,$FF,$72,$74,$50,$FF
	db $52,$54,$0C,$FF,$0E,$18,$1A,$FF
	db $FF,$BE,$FF,$FF,$DC,$DE,$06,$FF
	db $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF
	db $60,$62,$FF,$FF,$64,$66,$22,$FF
	db $24,$26,$28,$FF,$FF,$2A,$2C,$FF
	db $FF,$68,$69,$FF,$32,$6A,$6B,$33
	db $36,$38,$39,$37,$42,$44,$45,$43
	db $FF,$68,$69,$FF,$32,$6A,$6B,$33
	db $36,$38,$39,$37,$42,$44,$45,$43
	db $FF,$68,$69,$FF,$32,$6A,$6B,$33
	db $36,$38,$39,$37,$3E,$40,$41,$3F
	db $7A,$7C,$FF,$FF,$7E,$80,$82,$FF
	db $84,$86,$0C,$FF,$0E,$10,$12,$FF
	db $7A,$7C,$FF,$FF,$7E,$80,$06,$FF
	db $84,$86,$0C,$FF,$0E,$14,$16,$FF
	db $7A,$7C,$FF,$FF,$7E,$80,$06,$FF
	db $84,$86,$0C,$FF,$0E,$18,$1A,$FF
	db $A0,$A2,$A4,$FF,$A6,$A8,$AA,$FF
	db $52,$54,$0C,$FF,$0E,$18,$1A,$FF
	db $FF,$B8,$FF,$FF,$D6,$D8,$DA,$FF
	db $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF
	db $88,$8A,$8C,$FF,$8E,$90,$92,$FF
	db $94,$96,$28,$FF,$FF,$2A,$2C,$FF
	db $98,$9A,$9B,$99,$9C,$9E,$9F,$9D
	db $36,$38,$39,$37,$42,$44,$45,$43
	db $98,$9A,$9B,$99,$9C,$9E,$9F,$9D
	db $36,$38,$39,$37,$42,$44,$45,$43
	db $98,$9A,$9B,$99,$9C,$9E,$9F,$9D
	db $36,$38,$39,$37,$3E,$40,$41,$3F
	db $FF,$FF,$FF,$FF,$FF,$CC,$FF,$FF
	db $C0,$C2,$C4,$FF,$E0,$E2,$E4,$FF
	db $FF,$FF,$FF,$FF,$FF,$CC,$FF,$FF
	db $C6,$C8,$CA,$FF,$E6,$E8,$EA,$FF
	db $FF,$FF,$FF,$FF,$FF,$CD,$FF,$FF
	db $C5,$C3,$C1,$FF,$E5,$E3,$E1,$FF
	db $FF,$90,$92,$94,$96,$FF,$FF,$FF
	db $FF,$B0,$B2,$B4,$B6,$38,$FF,$FF
	db $FF,$D0,$D2,$D4,$D6,$58,$5A,$FF
	db $FF,$F0,$F2,$F4,$F6,$78,$7A,$FF
	db $FF,$90,$92,$94,$96,$FF,$FF,$FF
	db $FF,$98,$9A,$9C,$B6,$38,$FF,$FF
	db $FF,$D0,$D2,$D4,$D6,$58,$5A,$FF
	db $FF,$F0,$F2,$F4,$F6,$78,$7A,$FF
	db $FF,$90,$92,$94,$96,$FF,$FF,$FF
	db $FF,$98,$BA,$BC,$B6,$38,$FF,$FF
	db $FF,$D8,$DA,$DC,$D6,$58,$5A,$FF
	db $FF,$F8,$FA,$FC,$F6,$78,$7A,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$90,$92,$94,$96,$FF,$FF
	db $FF,$FF,$98,$BA,$BC,$B6,$38,$FF
	db $FF,$FF,$D8,$DA,$DC,$D6,$58,$5A
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$90,$92,$94,$96,$FF,$FF
	db $FF,$FF,$98,$BA,$BC,$B6,$38,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$90,$92,$94,$96,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$90,$92,$94,$96,$FF,$FF,$FF
	db $FF,$98,$BA,$BC,$B6,$38,$FF,$FF
	db $FF,$D8,$DA,$DC,$D6,$58,$5A,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $04,$06,$08,$0A,$0B,$09,$07,$05
	db $24,$26,$28,$2A,$2C,$29,$27,$25
	db $FF,$84,$86,$88,$89,$87,$85,$FF
	db $FF,$A4,$A6,$A8,$A9,$A7,$A5,$FF
	db $04,$06,$08,$0A,$0B,$09,$07,$05
	db $24,$26,$28,$2D,$2B,$29,$27,$25
	db $FF,$84,$86,$88,$89,$87,$85,$FF
	db $FF,$A4,$A6,$0C,$0D,$A7,$A5,$FF
	db $80,$82,$83,$8A,$82,$83,$8C,$8E
	db $A0,$A2,$A3,$C4,$A2,$A3,$AC,$AE
	db $80,$8A,$8A,$8A,$8A,$8A,$8C,$8E
	db $A0,$60,$61,$C4,$60,$61,$AC,$AE
	db $80,$03,$01,$8A,$00,$02,$8C,$8E
	db $A0,$23,$21,$C4,$20,$22,$AC,$AE
	db $80,$00,$02,$8A,$03,$01,$AA,$8E
	db $A0,$20,$22,$C4,$23,$21,$AC,$AE
	db $C0,$C2,$C4,$C4,$C4,$CA,$CC,$CE
	db $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
	db $40,$42,$44,$46,$48,$4A,$4C,$4E
	db $FF,$62,$64,$66,$68,$6A,$6C,$FF
	db $10,$12,$14,$16,$18,$1A,$1C,$1E
	db $10,$30,$32,$34,$36,$1A,$1C,$1E
KoopaPalPtrLo:
	db $BC,$A4,$98,$78,$6C

KoopaPalPtrHi:
	db $B2,$B2,$B2,$B3,$B3

DATA_03DD78:
	db $0B,$0B,$0B,$21,$00

CODE_03DD7D:
	PHX
	PHB					;$03DD7E	|
	PHK					;$03DD7F	|
	PLB					;$03DD80	|
	LDY $C2,X				;$03DD81	|
	STY.w $13FC				;$03DD83	|
	CPY.b #$04				;$03DD86	|
	BNE CODE_03DD97				;$03DD88	|
	JSR CODE_03DE8E				;$03DD8A	|
	LDA.b #$48				;$03DD8D	|
	STA $2C					;$03DD8F	|
	LDA.b #$14				;$03DD91	|
	STA $38					;$03DD93	|
	STA $39					;$03DD95	|
CODE_03DD97:
	LDA.b #$FF
	STA $5D					;$03DD99	|
	INC A					;$03DD9B	|
	STA $5E					;$03DD9C	|
	LDY.w $13FC				;$03DD9E	|
	LDX.w DATA_03DD78,Y			;$03DDA1	|
	LDA.w KoopaPalPtrLo,Y			;$03DDA4	|
	STA $00					;$03DDA7	|
	LDA.w KoopaPalPtrHi,Y			;$03DDA9	|
	STA $01					;$03DDAC	|
	STZ $02					;$03DDAE	|
	LDY.b #$0B				;$03DDB0	|
CODE_03DDB2:
	LDA [$00],Y
	STA.w $0707,Y				;$03DDB4	|
	DEY					;$03DDB7	|
	BPL CODE_03DDB2				;$03DDB8	|
	LDA.b #$80				;$03DDBA	|
	STA.w $2115				;$03DDBC	|
	STZ.w $2116				;$03DDBF	|
	STZ.w $2117				;$03DDC2	|
	TXY					;$03DDC5	|
	BEQ CODE_03DDD7				;$03DDC6	|
	JSL CODE_00BA28				;$03DDC8	|
	LDA.b #$80				;$03DDCC	|
	STA $03					;$03DDCE	|
CODE_03DDD0:
	JSR CODE_03DDE5
	DEC $03					;$03DDD3	|
	BNE CODE_03DDD0				;$03DDD5	|
CODE_03DDD7:
	LDX.b #$5F
CODE_03DDD9:
	LDA.b #$FF
	STA.l $7EC680,X				;$03DDDB	|
	DEX					;$03DDDF	|
	BPL CODE_03DDD9				;$03DDE0	|
	PLB					;$03DDE2	|
	PLX					;$03DDE3	|
	RTL					;$03DDE4	|

CODE_03DDE5:
	LDX.b #$00
	TXY					;$03DDE7	|
	LDA.b #$08				;$03DDE8	|
	STA $05					;$03DDEA	|
CODE_03DDEC:
	JSR CODE_03DE39
	PHY					;$03DDEF	|
	TYA					;$03DDF0	|
	LSR					;$03DDF1	|
	CLC					;$03DDF2	|
	ADC.b #$0F				;$03DDF3	|
	TAY					;$03DDF5	|
	JSR CODE_03DE3C				;$03DDF6	|
	LDY.b #$08				;$03DDF9	|
CODE_03DDFB:
	LDA.w $1BA3,X
	ASL					;$03DDFE	|
	ROL					;$03DDFF	|
	ROL					;$03DE00	|
	ROL					;$03DE01	|
	AND.b #$07				;$03DE02	|
	STA.w $1BA3,X				;$03DE04	|
	STA.w $2119				;$03DE07	|
	INX					;$03DE0A	|
	DEY					;$03DE0B	|
	BNE CODE_03DDFB				;$03DE0C	|
	PLY					;$03DE0E	|
	DEC $05					;$03DE0F	|
	BNE CODE_03DDEC				;$03DE11	|
	LDA.b #$07				;$03DE13	|
CODE_03DE15:
	TAX
	LDY.b #$08				;$03DE16	|
	STY $05					;$03DE18	|
CODE_03DE1A:
	LDY.w $1BA3,X
	STY.w $2119				;$03DE1D	|
	DEX					;$03DE20	|
	DEC $05					;$03DE21	|
	BNE CODE_03DE1A				;$03DE23	|
	CLC					;$03DE25	|
	ADC.b #$08				;$03DE26	|
	CMP.b #$40				;$03DE28	|
	BCC CODE_03DE15				;$03DE2A	|
	REP #$20				;$03DE2C	|
	LDA $00					;$03DE2E	|
	CLC					;$03DE30	|
	ADC.w #$0018				;$03DE31	|
	STA $00					;$03DE34	|
	SEP #$20				;$03DE36	|
	RTS					;$03DE38	|

CODE_03DE39:
	JSR CODE_03DE3C
CODE_03DE3C:
	PHX
	LDA [$00],Y				;$03DE3D	|
	PHY					;$03DE3F	|
	LDY.b #$08				;$03DE40	|
CODE_03DE42:
	ASL
	ROR.w $1BA3,X				;$03DE43	|
	INX					;$03DE46	|
	DEY					;$03DE47	|
	BNE CODE_03DE42				;$03DE48	|
	PLY					;$03DE4A	|
	INY					;$03DE4B	|
	PLX					;$03DE4C	|
	RTS					;$03DE4D	|

DATA_03DE4E:
	db $40,$41,$42,$43,$44,$45,$46,$47
	db $50,$51,$52,$53,$54,$55,$56,$57
	db $60,$61,$62,$63,$64,$65,$66,$67
	db $70,$71,$72,$73,$74,$75,$76,$77
	db $48,$49,$4A,$4B,$4C,$4D,$4E,$4F
	db $58,$59,$5A,$5B,$5C,$5D,$5E,$5F
	db $68,$69,$6A,$6B,$6C,$6D,$6E,$6F
	db $78,$79,$7A,$7B,$7C,$7D,$7E,$3F

CODE_03DE8E:
	STZ.w $2115
	REP #$20				;$03DE91	|
	LDA.w #$0A1C				;$03DE93	|
	STA $00					;$03DE96	|
	LDX.b #$00				;$03DE98	|
CODE_03DE9A:
	REP #$20
	LDA $00					;$03DE9C	|
	CLC					;$03DE9E	|
	ADC.w #$0080				;$03DE9F	|
	STA $00					;$03DEA2	|
	STA.w $2116				;$03DEA4	|
	SEP #$20				;$03DEA7	|
	LDY.b #$08				;$03DEA9	|
CODE_03DEAB:
	LDA.l DATA_03DE4E,X
	STA.w $2118				;$03DEAF	|
	INX					;$03DEB2	|
	DEY					;$03DEB3	|
	BNE CODE_03DEAB				;$03DEB4	|
	CPX.b #$40				;$03DEB6	|
	BCC CODE_03DE9A				;$03DEB8	|
	RTS					;$03DEBA	|

DATA_03DEBB:
	db $00,$01,$10,$01

DATA_03DEBF:
	db $6E,$70,$FF,$50,$FE,$FE,$FF,$57
DATA_03DEC7:
	db $72,$74,$52,$54,$3C,$3E,$55,$53
DATA_03DECF:
	db $76,$56,$56,$FF,$FF,$FF,$51,$FF
DATA_03DED7:
	db $20,$03,$30,$03,$40,$03,$50,$03

CODE_03DEDF:
	PHB
	PHK					;$03DEE0	|
	PLB					;$03DEE1	|
	LDA.w $14E0,X				;$03DEE2	|
	XBA					;$03DEE5	|
	LDA $E4,X				;$03DEE6	|
	LDY.b #$00				;$03DEE8	|
	JSR CODE_03DFAE				;$03DEEA	|
	LDA.w $14D4,X				;$03DEED	|
	XBA					;$03DEF0	|
	LDA $D8,X				;$03DEF1	|
	LDY.b #$02				;$03DEF3	|
	JSR CODE_03DFAE				;$03DEF5	|
	PHX					;$03DEF8	|
	REP #$30				;$03DEF9	|
	STZ $06					;$03DEFB	|
	LDY.w #$0003				;$03DEFD	|
	LDA.w $0D9B				;$03DF00	|
	LSR					;$03DF03	|
	BCC CODE_03DF44				;$03DF04	|
	LDA.w $1428				;$03DF06	|
	AND.w #$0003				;$03DF09	|
	ASL					;$03DF0C	|
	TAX					;$03DF0D	|
	LDA.l DATA_03DEBF,X			;$03DF0E	|
	STA.l $7EC681				;$03DF12	|
	LDA.l DATA_03DEC7,X			;$03DF16	|
	STA.l $7EC683				;$03DF1A	|
	LDA.l DATA_03DECF,X			;$03DF1E	|
	STA.l $7EC685				;$03DF22	|
	LDA.w #$0008				;$03DF26	|
	STA $06					;$03DF29	|
	LDX.w #$0380				;$03DF2B	|
	LDA.w $1BA2				;$03DF2E	|
	AND.w #$007F				;$03DF31	|
	CMP.w #$002C				;$03DF34	|
	BCC CODE_03DF3C				;$03DF37	|
	LDX.w #$0388				;$03DF39	|
CODE_03DF3C:
	TXA
	LDX.w #$000A				;$03DF3D	|
	LDY.w #$0007				;$03DF40	|
	SEC					;$03DF43	|
CODE_03DF44:
	STY $00
	BCS CODE_03DF55				;$03DF46	|
CODE_03DF48:
	LDA.w $1BA2
	AND.w #$007F				;$03DF4B	|
	ASL					;$03DF4E	|
	ASL					;$03DF4F	|
	ASL					;$03DF50	|
	ASL					;$03DF51	|
	LDX.w #$0003				;$03DF52	|
CODE_03DF55:
	STX $02
	PHA					;$03DF57	|
	LDY.w $1BA1				;$03DF58	|
	BPL CODE_03DF60				;$03DF5B	|
	CLC					;$03DF5D	|
	ADC $00					;$03DF5E	|
CODE_03DF60:
	TAY
	SEP #$20				;$03DF61	|
	LDX $06					;$03DF63	|
	LDA $00					;$03DF65	|
	STA $04					;$03DF67	|
CODE_03DF69:
	LDA.w DATA_03D9DE,Y
	INY					;$03DF6C	|
	BIT.w $1BA2				;$03DF6D	|
	BPL CODE_03DF76				;$03DF70	|
	EOR.b #$01				;$03DF72	|
	DEY					;$03DF74	|
	DEY					;$03DF75	|
CODE_03DF76:
	STA.l $7EC680,X
	INX					;$03DF7A	|
	DEC $04					;$03DF7B	|
	BPL CODE_03DF69				;$03DF7D	|
	STX $06					;$03DF7F	|
	REP #$20				;$03DF81	|
	PLA					;$03DF83	|
	SEC					;$03DF84	|
	ADC $00					;$03DF85	|
	LDX $02					;$03DF87	|
	CPX.w #$0004				;$03DF89	|
	BEQ CODE_03DF48				;$03DF8C	|
	CPX.w #$0008				;$03DF8E	|
	BNE CODE_03DF96				;$03DF91	|
	LDA.w #$0360				;$03DF93	|
CODE_03DF96:
	CPX.w #$000A
	BNE CODE_03DFA6				;$03DF99	|
	LDA.w $1427				;$03DF9B	|
	AND.w #$0003				;$03DF9E	|
	ASL					;$03DFA1	|
	TAY					;$03DFA2	|
	LDA.w DATA_03DED7,Y			;$03DFA3	|
CODE_03DFA6:
	DEX
	BPL CODE_03DF55				;$03DFA7	|
	SEP #$30				;$03DFA9	|
	PLX					;$03DFAB	|
	PLB					;$03DFAC	|
	RTL					;$03DFAD	|

CODE_03DFAE:
	PHX
	TYX					;$03DFAF	|
	REP #$20				;$03DFB0	|
	EOR.w #$FFFF				;$03DFB2	|
	INC A					;$03DFB5	|
	CLC					;$03DFB6	|
	ADC.l DATA_03DEBB,X			;$03DFB7	|
	CLC					;$03DFBB	|
	ADC $1A,X				;$03DFBC	|
	STA $3A,X				;$03DFBE	|
	SEP #$20				;$03DFC0	|
	PLX					;$03DFC2	|
	RTS					;$03DFC3	|

DATA_03DFC4:
	db $00,$0E,$1C,$2A,$38,$46,$54,$62

CODE_03DFCC:
	PHX
	LDX.w $0681				;$03DFCD	|
	LDA.b #$10				;$03DFD0	|
	STA.w $0682,X				;$03DFD2	|
	STZ.w $0683,X				;$03DFD5	|
	STZ.w $0684,X				;$03DFD8	|
	STZ.w $0685,X				;$03DFDB	|
	TXY					;$03DFDE	|
	LDX.w $1FFB				;$03DFDF	|
	BNE CODE_03E01B				;$03DFE2	|
	LDA.w $190D				;$03DFE4	|
	BEQ CODE_03DFF0				;$03DFE7	|
	REP #$20				;$03DFE9	|
	LDA.w $0701				;$03DFEB	|
	BRA CODE_03E031				;$03DFEE	|

CODE_03DFF0:
	LDA $14
	LSR					;$03DFF2	|
	BCC CODE_03E036				;$03DFF3	|
	DEC.w $1FFC				;$03DFF5	|
	BNE CODE_03E036				;$03DFF8	|
	TAX					;$03DFFA	|
	LDA.l CODE_04F708,X			;$03DFFB	|
	AND.b #$07				;$03DFFF	|
	TAX					;$03E001	|
	LDA.l DATA_04F6F8,X			;$03E002	|
	STA.w $1FFC				;$03E006	|
	LDA.l DATA_04F700,X			;$03E009	|
	STA.w $1FFB				;$03E00D	|
	TAX					;$03E010	|
	LDA.b #$08				;$03E011	|
	STA.w $1FFD				;$03E013	|
	LDA.b #$18				;$03E016	|
	STA.w $1DFC				;$03E018	|
CODE_03E01B:
	DEC.w $1FFD
	BPL CODE_03E028				;$03E01E	|
	DEC.w $1FFB				;$03E020	|
	LDA.b #$04				;$03E023	|
	STA.w $1FFD				;$03E025	|
CODE_03E028:
	TXA
	ASL					;$03E029	|
	TAX					;$03E02A	|
	REP #$20				;$03E02B	|
	LDA.l DATA_00B5DE,X			;$03E02D	|
CODE_03E031:
	STA.w $0684,Y
	SEP #$20				;$03E034	|
CODE_03E036:
	LDX.w $1429
	LDA.l DATA_03DFC4,X			;$03E039	|
	TAX					;$03E03D	|
	LDA.b #$0E				;$03E03E	|
	STA $00					;$03E040	|
CODE_03E042:
	LDA.l DATA_00B69E,X
	STA.w $0686,Y				;$03E046	|
	INX					;$03E049	|
	INY					;$03E04A	|
	DEC $00					;$03E04B	|
	BNE CODE_03E042				;$03E04D	|
	TYX					;$03E04F	|
	STZ.w $0686,X				;$03E050	|
	INX					;$03E053	|
	INX					;$03E054	|
	INX					;$03E055	|
	INX					;$03E056	|
	STX.w $0681				;$03E057	|
	PLX					;$03E05A	|
	RTL					;$03E05B	|

DATA_03E05C:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF

music_bank_3:
	dw .end-.start				;		| Length of music bank 3
	dw $1360				;		| Location of music in ARAM

.start
	db $78,$13,$BE,$14,$F2,$14,$1C,$16
	db $78,$13,$BE,$14,$F2,$14,$1C,$16
	db $78,$13,$BE,$14,$F2,$14,$1C,$16
	db $9E,$13,$AE,$13,$BE,$13,$DE,$13
	db $CE,$13,$EE,$13,$FE,$13,$0E,$14
	db $1E,$14,$2E,$14,$3E,$14,$4E,$14
	db $5E,$14,$6E,$14,$7E,$14,$8E,$14
	db $9E,$14,$AE,$14,$00,$00,$94,$21
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$97,$21
	db $BB,$21,$51,$22,$F7,$21,$33,$22
	db $15,$22,$D9,$21,$73,$22,$92,$22
	db $B4,$23,$E2,$23,$00,$00,$00,$00
	db $00,$00,$CC,$23,$0F,$24,$C9,$22
	db $B4,$23,$E2,$23,$00,$23,$00,$00
	db $1A,$23,$CC,$23,$0F,$24,$44,$24
	db $6B,$24,$AF,$24,$00,$00,$00,$00
	db $00,$00,$8E,$24,$DF,$24,$35,$25
	db $6E,$25,$B2,$25,$5C,$25,$00,$00
	db $0F,$25,$91,$25,$E2,$25,$12,$26
	db $8D,$26,$B1,$26,$61,$26,$00,$00
	db $3A,$26,$A0,$26,$E1,$26,$11,$27
	db $7E,$27,$A8,$27,$54,$27,$00,$00
	db $33,$27,$94,$27,$0F,$24,$D1,$22
	db $B4,$23,$E2,$23,$00,$23,$7E,$23
	db $50,$23,$CC,$23,$0F,$24,$14,$28
	db $54,$28,$80,$28,$4C,$28,$2C,$28
	db $FD,$27,$6B,$28,$A4,$28,$C8,$28
	db $E7,$28,$7D,$29,$23,$29,$5F,$29
	db $41,$29,$05,$29,$9F,$29,$D1,$22
	db $BE,$29,$E2,$23,$00,$23,$7E,$23
	db $50,$23,$CC,$23,$0F,$24,$14,$28
	db $F5,$29,$0D,$2A,$4C,$28,$2C,$28
	db $FD,$27,$6B,$28,$A4,$28,$47,$2A
	db $66,$2A,$00,$2B,$A2,$2A,$E0,$2A
	db $C0,$2A,$84,$2A,$24,$2B,$79,$2B
	db $43,$2B,$E2,$23,$00,$23,$E2,$2B
	db $AE,$2B,$CC,$23,$0F,$24,$47,$2C
	db $18,$2C,$0D,$2A,$4C,$28,$5F,$2C
	db $30,$2C,$6B,$28,$A4,$28,$25,$2A
	db $66,$2A,$00,$2B,$A2,$2A,$E0,$2A
	db $C0,$2A,$84,$2A,$24,$2B,$7F,$2C
	db $98,$2C,$0C,$2D,$C8,$2C,$F6,$2C
	db $E0,$2C,$B0,$2C,$00,$00,$C2,$14
	db $00,$00,$76,$1E,$C5,$1E,$F0,$1E
	db $A2,$1E,$03,$1F,$2A,$1F,$49,$1F
	db $68,$1F,$A4,$1F,$0A,$20,$4C,$20
	db $E9,$1F,$C8,$1F,$83,$1F,$2C,$20
	db $7B,$20,$A6,$20,$C8,$20,$5A,$21
	db $04,$21,$3E,$21,$22,$21,$E6,$20
	db $7A,$21,$D2,$14,$E2,$14,$2C,$15
	db $4C,$15,$3C,$15,$5C,$15,$6C,$15
	db $7C,$15,$8C,$15,$9C,$15,$AC,$15
	db $CC,$15,$BC,$15,$DC,$15,$EC,$15
	db $AE,$13,$4E,$14,$5E,$14,$6E,$14
	db $7E,$14,$8E,$14,$6E,$14,$FC,$15
	db $6E,$14,$7E,$14,$8E,$14,$9E,$14
	db $0C,$16,$00,$00,$3D,$16,$93,$17
	db $BD,$17,$1B,$17,$57,$17,$99,$16
	db $00,$00,$E7,$17,$3D,$16,$93,$17
	db $BD,$17,$1B,$17,$57,$17,$DE,$16
	db $00,$00,$E7,$17,$00,$18,$EF,$18
	db $10,$19,$89,$18,$BC,$18,$55,$18
	db $00,$00,$E7,$17,$31,$19,$E4,$19
	db $05,$1A,$8A,$19,$B7,$19,$5F,$19
	db $00,$00,$E7,$17,$C8,$1A,$AB,$1B
	db $CC,$1B,$3F,$1B,$77,$1B,$91,$1B
	db $00,$00,$E7,$17,$ED,$1B,$6E,$1C
	db $8F,$1C,$1B,$1C,$48,$1C,$5B,$1C
	db $00,$00,$E7,$17,$C8,$1A,$AB,$1B
	db $CC,$1B,$3F,$1B,$77,$1B,$91,$1B
	db $01,$1B,$E7,$17,$B0,$1C,$70,$1D
	db $90,$1D,$19,$1D,$4A,$1D,$5D,$1D
	db $E2,$1C,$AE,$1D,$3D,$16,$93,$17
	db $BD,$17,$1B,$17,$57,$17,$99,$16
	db $7C,$16,$E7,$17,$3D,$16,$93,$17
	db $BD,$17,$1B,$17,$57,$17,$DE,$16
	db $7C,$16,$E7,$17,$00,$18,$EF,$18
	db $10,$19,$89,$18,$BC,$18,$55,$18
	db $34,$18,$E7,$17,$26,$1A,$A6,$1A
	db $B7,$1A,$4E,$1A,$67,$1A,$80,$1A
	db $40,$1A,$E7,$17,$32,$16,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$3A,$16,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$C1,$1D,$D4,$1D
	db $58,$1E,$F8,$1D,$3E,$1E,$0A,$1E
	db $E6,$1D,$24,$1E,$2C,$15,$4C,$15
	db $2C,$15,$5C,$15,$6C,$15,$7C,$15
	db $6C,$15,$9C,$15,$FF,$00,$1C,$16
	db $00,$00,$DA,$04,$E2,$16,$E3,$90
	db $1B,$00,$E4,$01,$00,$DA,$12,$E2
	db $1E,$DB,$0A,$DE,$14,$19,$27,$0C
	db $6D,$B4,$0C,$2E,$B7,$B9,$30,$6E
	db $B7,$0C,$2D,$B9,$0C,$6E,$BB,$C6
	db $0C,$2D,$BB,$30,$6E,$B9,$0C,$2D
	db $B3,$0C,$6E,$B4,$0C,$2D,$B7,$B9
	db $30,$6E,$B7,$0C,$2D,$B8,$0C,$6E
	db $B9,$C6,$0C,$2D,$B9,$30,$6E,$B7
	db $0C,$2D,$B8,$00,$DA,$12,$DB,$0F
	db $DE,$14,$14,$20,$48,$6D,$B7,$18
	db $B9,$48,$B7,$0C,$B4,$B5,$30,$B7
	db $0C,$C6,$B9,$B7,$B9,$48,$B7,$18
	db $B4,$DA,$00,$DB,$05,$DE,$14,$19
	db $27,$30,$6B,$C7,$0C,$C7,$B7,$0C
	db $2C,$B9,$BC,$06,$7B,$BB,$BC,$0C
	db $69,$BB,$18,$C6,$0C,$C7,$B3,$0C
	db $2C,$B7,$BB,$06,$7B,$B9,$BB,$0C
	db $69,$B9,$18,$C6,$0C,$C7,$B2,$0C
	db $2C,$B4,$B9,$06,$7B,$B7,$B9,$0C
	db $69,$B7,$18,$C6,$0C,$C7,$06,$4B
	db $AD,$AF,$B0,$B2,$B4,$B5,$30,$6B
	db $B4,$0C,$C7,$B7,$0C,$2C,$B9,$BC
	db $06,$7B,$BB,$BC,$0C,$69,$BB,$18
	db $C6,$0C,$C7,$B3,$0C,$2C,$B7,$BB
	db $06,$7B,$B9,$BB,$0C,$69,$B9,$18
	db $C6,$0C,$C7,$B2,$0C,$2C,$B4,$B9
	db $06,$7B,$B7,$B9,$0C,$69,$B7,$18
	db $C6,$0C,$C7,$06,$4B,$AD,$AF,$B0
	db $B2,$B4,$B5,$DA,$12,$DB,$08,$DE
	db $14,$1F,$25,$0C,$6D,$B0,$0C,$2E
	db $B4,$B4,$30,$6E,$B4,$0C,$2D,$B4
	db $0C,$6E,$B7,$C6,$0C,$2D,$B7,$30
	db $6E,$B3,$0C,$2D,$AF,$0C,$6E,$AE
	db $0C,$2D,$B2,$B2,$30,$6E,$B2,$0C
	db $2D,$B2,$0C,$6E,$B4,$C6,$0C,$2D
	db $B4,$30,$6E,$B4,$0C,$2D,$B4,$DA
	db $12,$DB,$0C,$DE,$14,$1B,$26,$0C
	db $6D,$AB,$0C,$2E,$B0,$B0,$30,$6E
	db $B0,$0C,$2D,$B0,$0C,$6E,$B3,$C6
	db $0C,$2D,$B3,$30,$6E,$AF,$0C,$2D
	db $AB,$0C,$6E,$AB,$0C,$2E,$AE,$AE
	db $30,$6E,$AE,$0C,$2D,$AE,$0C,$6E
	db $B1,$C6,$0C,$2D,$B1,$30,$6E,$B1
	db $0C,$2D,$B1,$DA,$04,$DB,$08,$DE
	db $14,$19,$28,$0C,$3B,$C7,$9C,$C7
	db $9C,$C7,$9C,$C7,$9C,$C7,$9B,$C7
	db $9B,$C7,$9B,$C7,$9B,$C7,$9A,$C7
	db $9A,$C7,$9A,$C7,$9A,$C7,$99,$C7
	db $99,$C7,$99,$C7,$99,$DA,$08,$DB
	db $0C,$DE,$14,$19,$28,$0C,$6E,$98
	db $9F,$93,$9F,$98,$9F,$93,$9F,$97
	db $9F,$93,$9F,$97,$9F,$93,$9F,$96
	db $9F,$93,$9F,$96,$9F,$93,$9F,$95
	db $9C,$90,$9C,$95,$9C,$90,$9C,$DA
	db $05,$DB,$14,$DE,$00,$00,$00,$E9
	db $F3,$17,$08,$0C,$4B,$D1,$0C,$4C
	db $D2,$0C,$49,$D1,$0C,$4B,$D2,$00
	db $0C,$6E,$B9,$0C,$2D,$BB,$BC,$30
	db $6E,$B9,$0C,$2D,$B8,$0C,$6E,$B7
	db $0C,$2D,$B8,$B9,$30,$6E,$B4,$0C
	db $C7,$12,$6E,$B4,$06,$6D,$B3,$0C
	db $2C,$B2,$12,$6E,$B4,$06,$6D,$B3
	db $0C,$2C,$B2,$0C,$2E,$B4,$B2,$30
	db $4E,$B7,$C6,$00,$30,$6D,$B0,$0C
	db $C6,$AF,$C6,$AD,$AB,$AC,$AD,$B4
	db $30,$C6,$24,$B4,$18,$B0,$0C,$AF
	db $B0,$B1,$30,$B2,$06,$C7,$AB,$AD
	db $AF,$B0,$B2,$B4,$B5,$06,$7B,$B4
	db $B5,$0C,$69,$B4,$18,$C6,$0C,$C7
	db $06,$4B,$AF,$B0,$B2,$B4,$B5,$B6
	db $06,$7B,$B7,$B9,$0C,$69,$B7,$18
	db $C6,$0C,$C7,$06,$4B,$B2,$B4,$B5
	db $B7,$B9,$BB,$30,$BC,$C6,$BB,$0C
	db $C7,$06,$4B,$BB,$BC,$BB,$B9,$B7
	db $B5,$0C,$6E,$B5,$0C,$2D,$B5,$B9
	db $30,$6E,$B6,$0C,$2D,$B6,$0C,$6E
	db $B4,$0C,$2D,$B4,$B4,$30,$6E,$B1
	db $0C,$C7,$12,$6E,$AD,$06,$6D,$AD
	db $0C,$2C,$AD,$12,$6E,$AD,$06,$6D
	db $AD,$0C,$2C,$AD,$0C,$2E,$AD,$AD
	db $30,$4E,$B2,$C6,$0C,$6E,$B0,$0C
	db $2D,$B0,$B5,$30,$6E,$B0,$0C,$2D
	db $B0,$0C,$6E,$B0,$0C,$2D,$B0,$B0
	db $30,$6E,$AB,$0C,$C7,$12,$6E,$A9
	db $06,$6D,$A9,$0C,$2C,$A9,$12,$6E
	db $A9,$06,$6D,$A9,$0C,$2C,$A9,$0C
	db $2E,$A9,$A9,$30,$4E,$AF,$C6,$0C
	db $C7,$9D,$C7,$9D,$C7,$9E,$C7,$9E
	db $C7,$9C,$C7,$9C,$C7,$99,$C7,$99
	db $C7,$9A,$C7,$9A,$C7,$9A,$C7,$9A
	db $C7,$97,$C7,$97,$C7,$97,$C7,$97
	db $0C,$91,$A1,$98,$A1,$92,$A1,$98
	db $A1,$93,$9F,$98,$9F,$95,$9F,$90
	db $9F,$8E,$9D,$95,$9D,$8E,$9D,$90
	db $91,$93,$9D,$8E,$9D,$93,$9D,$8E
	db $9D,$0C,$6E,$B9,$0C,$2D,$BB,$BC
	db $30,$6E,$B9,$0C,$2D,$B8,$0C,$6E
	db $B7,$0C,$2D,$B8,$B9,$30,$6E,$C0
	db $0C,$C7,$0C,$6E,$C0,$0C,$2D,$BF
	db $C0,$18,$6E,$BC,$0C,$2E,$BC,$18
	db $6E,$B9,$30,$4E,$BC,$C6,$00,$06
	db $7B,$B4,$B5,$0C,$69,$B4,$18,$C6
	db $0C,$C7,$06,$4B,$AF,$B0,$B2,$B4
	db $B5,$B6,$06,$7B,$B7,$B9,$0C,$69
	db $B7,$18,$C6,$0C,$C7,$06,$4B,$B2
	db $B4,$B5,$B7,$B9,$BB,$30,$BC,$BB
	db $60,$BC,$0C,$6E,$B5,$0C,$2D,$B5
	db $B9,$30,$6E,$B6,$0C,$2D,$B6,$0C
	db $6E,$B4,$0C,$2D,$B4,$B4,$30,$6E
	db $BD,$0C,$C7,$0C,$6E,$B9,$0C,$2D
	db $B9,$B9,$18,$6E,$B9,$0C,$2E,$B5
	db $18,$6E,$B5,$30,$4E,$B7,$C6,$0C
	db $6E,$B0,$0C,$2D,$B0,$B5,$30,$6E
	db $B0,$0C,$2D,$B0,$0C,$6E,$B0,$0C
	db $2D,$B0,$B0,$30,$6E,$B7,$0C,$C7
	db $0C,$6E,$B5,$0C,$2D,$B5,$B5,$18
	db $6E,$B5,$0C,$2E,$B2,$18,$6E,$B2
	db $30,$4E,$B4,$C6,$0C,$C7,$98,$C7
	db $98,$C7,$98,$C7,$98,$C7,$9C,$C7
	db $9C,$C7,$99,$C7,$99,$C7,$95,$C7
	db $95,$C7,$97,$C7,$97,$C7,$9C,$C7
	db $9C,$C7,$9C,$C7,$9C,$0C,$91,$9D
	db $98,$9D,$92,$9E,$98,$9E,$93,$9F
	db $9A,$9F,$95,$A1,$9C,$A1,$8E,$9A
	db $95,$9A,$93,$9F,$9A,$9F,$98,$9F
	db $93,$9F,$98,$98,$97,$96,$0C,$6E
	db $B9,$0C,$2D,$BB,$BC,$30,$6E,$B9
	db $0C,$2D,$B8,$0C,$6E,$B7,$0C,$2D
	db $B8,$B9,$30,$6E,$C0,$0C,$C7,$00
	db $30,$6D,$B0,$0C,$C6,$AF,$C6,$AD
	db $AB,$AC,$AD,$B4,$30,$C6,$0C,$6E
	db $B5,$0C,$2D,$B5,$B9,$30,$6E,$B6
	db $0C,$2D,$B6,$0C,$6E,$B4,$0C,$2D
	db $B4,$B4,$30,$6E,$BD,$0C,$C7,$0C
	db $6E,$B0,$0C,$2D,$B0,$B5,$30,$6E
	db $B0,$0C,$2D,$B0,$0C,$6E,$B0,$0C
	db $2D,$B0,$B0,$30,$6E,$B7,$0C,$C7
	db $06,$7B,$B4,$B5,$0C,$69,$B4,$18
	db $C6,$0C,$C7,$06,$4B,$AF,$B0,$B2
	db $B4,$B5,$B6,$06,$7B,$B7,$B9,$0C
	db $69,$B7,$18,$C6,$0C,$C7,$06,$4B
	db $B2,$B4,$B5,$B7,$B9,$BB,$0C,$C7
	db $98,$C7,$98,$C7,$98,$C7,$98,$C7
	db $9C,$C7,$9C,$C7,$99,$C7,$99,$0C
	db $91,$9D,$98,$9D,$92,$9E,$98,$9E
	db $93,$9F,$9A,$9F,$95,$A1,$9C,$A1
	db $DA,$12,$18,$6D,$AD,$0C,$B4,$C7
	db $C7,$0C,$2D,$B4,$0C,$6E,$B3,$0C
	db $2D,$B4,$0C,$6E,$B5,$0C,$2D,$B4
	db $B1,$30,$6E,$AD,$0C,$2D,$AD,$0C
	db $6E,$B4,$0C,$2D,$B2,$0C,$6D,$B4
	db $0C,$2D,$B2,$0C,$6E,$B4,$0C,$2D
	db $B2,$C7,$0C,$6D,$AD,$30,$C6,$C7
	db $00,$DB,$0F,$DE,$14,$14,$20,$DA
	db $12,$18,$6D,$B9,$0C,$C0,$C7,$C7
	db $0C,$2D,$C0,$0C,$6E,$BF,$0C,$2D
	db $C0,$0C,$6E,$C1,$0C,$2D,$C0,$BD
	db $30,$6E,$B9,$0C,$2D,$B9,$0C,$6E
	db $C0,$0C,$2D,$BE,$0C,$6D,$C0,$0C
	db $2D,$BE,$0C,$6E,$C0,$0C,$2D,$BE
	db $C7,$0C,$6D,$B9,$30,$C6,$C7,$DA
	db $12,$18,$6D,$A8,$0C,$AB,$C7,$C7
	db $0C,$2D,$AB,$0C,$6E,$AA,$0C,$2D
	db $AB,$0C,$6E,$AD,$0C,$2D,$AB,$A8
	db $30,$6E,$A5,$0C,$2D,$A5,$0C,$6E
	db $AB,$0C,$2D,$AA,$0C,$6D,$AB,$0C
	db $2D,$AA,$0C,$6E,$AB,$0C,$2D,$AA
	db $C7,$0C,$6D,$A4,$30,$C6,$C7,$DB
	db $05,$DE,$19,$19,$35,$DA,$00,$30
	db $6B,$A8,$0C,$C6,$A7,$A8,$AD,$48
	db $B4,$0C,$B3,$B4,$30,$B9,$B4,$60
	db $B2,$DB,$08,$DE,$19,$18,$34,$DA
	db $00,$30,$6B,$9F,$0C,$C6,$9E,$9F
	db $A5,$48,$AB,$0C,$AA,$AB,$30,$B4
	db $AB,$60,$AA,$0C,$C7,$99,$C7,$99
	db $C7,$99,$C7,$99,$C7,$99,$C7,$99
	db $C7,$99,$C7,$99,$C7,$98,$C7,$98
	db $C7,$98,$C7,$98,$C7,$98,$C7,$98
	db $C7,$98,$C7,$98,$0C,$95,$9F,$90
	db $9F,$95,$9F,$90,$9F,$95,$9F,$90
	db $9F,$95,$9F,$90,$8F,$8E,$9E,$95
	db $9E,$8E,$9E,$95,$9E,$8E,$9E,$95
	db $9E,$8E,$9E,$90,$92,$18,$6D,$AB
	db $0C,$B2,$C7,$C7,$0C,$2D,$B2,$0C
	db $6E,$B1,$0C,$2D,$B2,$0C,$6E,$B4
	db $0C,$2D,$B2,$AF,$30,$6E,$AB,$0C
	db $2D,$B2,$18,$4E,$B0,$B0,$10,$6D
	db $B0,$10,$6E,$B2,$10,$6E,$B3,$30
	db $B4,$C7,$00,$18,$6D,$A3,$0C,$A9
	db $C7,$C7,$0C,$2D,$A9,$0C,$6E,$A8
	db $0C,$2D,$A9,$0C,$6E,$AB,$0C,$2D
	db $A9,$A6,$30,$6E,$A3,$0C,$2D,$A9
	db $18,$4E,$A8,$A8,$10,$6D,$A8,$10
	db $6E,$A9,$10,$6E,$AA,$30,$AC,$C7
	db $30,$69,$AB,$0C,$C6,$A9,$AB,$AF
	db $48,$B2,$0C,$B0,$B2,$48,$B0,$18
	db $B2,$60,$B4,$30,$69,$A3,$0C,$C6
	db $A3,$A6,$A9,$48,$AB,$0C,$A9,$AB
	db $48,$A8,$18,$AB,$60,$AC,$0C,$C7
	db $97,$C7,$97,$C7,$97,$C7,$97,$C7
	db $97,$C7,$97,$C7,$97,$C7,$97,$C7
	db $9C,$C7,$9C,$C7,$9C,$C7,$9C,$C7
	db $97,$C7,$97,$C7,$97,$C7,$97,$0C
	db $93,$9D,$8E,$9D,$93,$9D,$8E,$9D
	db $93,$9D,$8E,$9D,$93,$9D,$95,$97
	db $98,$9F,$93,$9F,$98,$9F,$93,$9F
	db $90,$A0,$97,$A0,$90,$A0,$92,$94
	db $18,$6D,$AB,$0C,$B2,$C7,$C7,$0C
	db $2D,$B2,$0C,$6E,$B1,$0C,$2D,$B2
	db $0C,$6E,$B4,$0C,$2D,$B2,$C7,$30
	db $6E,$AB,$0C,$2D,$B2,$18,$4E,$B0
	db $B0,$10,$6D,$B0,$10,$6E,$B2,$10
	db $6E,$B3,$18,$2E,$B4,$C7,$30,$4E
	db $B7,$00,$18,$6D,$B7,$0C,$BE,$C7
	db $C7,$0C,$2D,$BE,$0C,$6E,$BD,$0C
	db $2D,$BE,$0C,$6E,$C0,$0C,$2D,$BE
	db $C7,$30,$6E,$B7,$0C,$2D,$BE,$18
	db $4E,$BC,$BC,$10,$6D,$BC,$10,$6E
	db $BE,$10,$6E,$BF,$18,$2E,$C0,$C7
	db $06,$C7,$AB,$AD,$AF,$B0,$B2,$B4
	db $B5,$18,$6D,$A3,$0C,$A9,$C7,$C7
	db $0C,$2D,$A9,$0C,$6E,$A8,$0C,$2D
	db $A9,$0C,$6E,$AB,$0C,$2D,$A9,$C7
	db $30,$6E,$A3,$0C,$2D,$A9,$18,$4E
	db $A8,$A8,$10,$6D,$A8,$10,$6E,$A9
	db $10,$6E,$AA,$18,$2E,$AB,$C7,$30
	db $4E,$AF,$30,$69,$AB,$0C,$C6,$A9
	db $AB,$AF,$48,$B2,$0C,$B0,$B2,$30
	db $B0,$B2,$30,$B4,$B3,$30,$69,$A3
	db $0C,$C6,$A3,$A6,$A9,$48,$AB,$0C
	db $A9,$AB,$30,$A8,$AB,$30,$AB,$AF
	db $0C,$C7,$97,$C7,$97,$C7,$97,$C7
	db $97,$C7,$97,$C7,$97,$C7,$97,$C7
	db $97,$C7,$9C,$C7,$9C,$C7,$9C,$C7
	db $9C,$DA,$01,$18,$AF,$C7,$A7,$C6
	db $0C,$93,$9D,$8E,$9D,$93,$9D,$8E
	db $9D,$93,$9D,$8E,$9D,$93,$9D,$95
	db $97,$98,$9F,$93,$9F,$98,$9F,$93
	db $9F,$18,$8C,$C7,$93,$C6,$DA,$05
	db $DB,$14,$DE,$00,$00,$00,$E9,$F3
	db $17,$06,$18,$4C,$D1,$C7,$30,$6D
	db $D2,$DA,$04,$DB,$0A,$DE,$22,$19
	db $38,$60,$5E,$BC,$C6,$DA,$01,$60
	db $C6,$C6,$C6,$00,$DA,$04,$DB,$08
	db $DE,$20,$18,$36,$60,$5D,$B4,$C6
	db $DA,$01,$60,$C6,$C6,$C6,$DA,$04
	db $DB,$0C,$DE,$21,$1A,$37,$60,$5D
	db $AB,$C6,$DA,$01,$60,$C6,$C6,$C6
	db $DA,$04,$DB,$0A,$DE,$22,$18,$36
	db $60,$5D,$A4,$C6,$DA,$01,$60,$C6
	db $C6,$C6,$DA,$04,$DB,$0F,$10,$5D
	db $B0,$C7,$B0,$AE,$C7,$AE,$AD,$C7
	db $AD,$AC,$C7,$AC,$30,$AB,$24,$A7
	db $6C,$A6,$60,$C6,$DA,$04,$DB,$0F
	db $10,$5D,$AB,$C7,$AB,$A8,$C7,$A8
	db $A9,$C7,$A9,$A9,$C7,$A9,$30,$A6
	db $24,$A3,$6C,$A2,$60,$C6,$DA,$04
	db $DB,$0F,$10,$5D,$A8,$C7,$A8,$A4
	db $C7,$A4,$A4,$C7,$A4,$A4,$C7,$A4
	db $30,$A3,$24,$9D,$6C,$9C,$60,$C6
	db $DA,$08,$DB,$0A,$DE,$22,$19,$38
	db $10,$5D,$8C,$8C,$8C,$90,$90,$90
	db $91,$91,$91,$92,$92,$92,$30,$93
	db $24,$93,$6C,$8C,$60,$C6,$DA,$01
	db $E2,$12,$DB,$0A,$DE,$14,$19,$28
	db $18,$7C,$A7,$0C,$A8,$AB,$AD,$30
	db $AB,$0C,$AD,$AF,$C6,$AF,$30,$AD
	db $0C,$A7,$A8,$AB,$AD,$30,$AB,$0C
	db $AC,$AD,$C6,$AD,$60,$AB,$60,$77
	db $C6,$00,$DA,$02,$DB,$0A,$18,$79
	db $A7,$0C,$A8,$AB,$AD,$30,$AB,$0C
	db $AD,$AF,$C6,$AF,$30,$AD,$0C,$A7
	db $A8,$AB,$AD,$30,$AB,$0C,$AC,$AD
	db $C6,$AD,$60,$AB,$C6,$DA,$01,$DB
	db $0C,$DE,$14,$19,$28,$06,$C6,$18
	db $79,$A7,$0C,$A8,$AB,$AD,$30,$AB
	db $0C,$AD,$AF,$C6,$AF,$30,$AD,$0C
	db $A7,$A8,$AB,$AD,$30,$AB,$0C,$AC
	db $AD,$C6,$AD,$60,$AB,$60,$75,$C6
	db $DA,$01,$DB,$0A,$DE,$14,$19,$28
	db $18,$7B,$C7,$60,$98,$97,$96,$95
	db $C6,$C6,$C6,$DA,$01,$DB,$0A,$DE
	db $14,$19,$28,$18,$7B,$C7,$0C,$C7
	db $24,$9F,$30,$B0,$0C,$C7,$24,$9F
	db $30,$AF,$0C,$C7,$24,$9F,$30,$AE
	db $0C,$C7,$24,$9F,$30,$B1,$60,$C6
	db $C6,$C6,$DA,$01,$DB,$0A,$DE,$14
	db $19,$28,$18,$7B,$C7,$18,$C7,$48
	db $A8,$18,$C7,$48,$A7,$18,$C7,$48
	db $A6,$18,$C7,$48,$A5,$60,$C6,$C6
	db $C6,$DA,$01,$DB,$0A,$DE,$14,$19
	db $28,$18,$7B,$C7,$24,$C7,$3C,$AB
	db $24,$C7,$3C,$AB,$24,$C7,$3C,$AB
	db $24,$C7,$3C,$AB,$60,$C6,$C6,$C6
	db $DA,$01,$DB,$0A,$DE,$14,$19,$28
	db $18,$7B,$C7,$30,$C7,$B4,$30,$C7
	db $B3,$30,$C7,$B2,$30,$C7,$B4,$60
	db $C6,$C6,$C6,$DA,$04,$DB,$08,$DE
	db $22,$18,$14,$08,$5C,$C7,$A9,$C7
	db $A9,$AD,$C7,$24,$AA,$0C,$C7,$08
	db $A9,$A8,$C7,$A8,$A8,$C7,$24,$AB
	db $0C,$C7,$08,$C7,$E2,$1C,$DA,$04
	db $DB,$0A,$DE,$22,$18,$14,$08,$5D
	db $AC,$AD,$C7,$AF,$B0,$C7,$24,$AD
	db $0C,$C7,$08,$AC,$AB,$C7,$AC,$AD
	db $C7,$24,$B4,$0C,$C7,$08,$C7,$00
	db $DA,$04,$DB,$0C,$DE,$22,$18,$14
	db $08,$5C,$C7,$A4,$C7,$A4,$A9,$C7
	db $24,$A4,$0C,$C7,$08,$A4,$A4,$C7
	db $A4,$A4,$C7,$24,$A5,$0C,$C7,$08
	db $C7,$DA,$06,$DB,$0A,$DE,$22,$18
	db $14,$08,$5D,$B8,$B9,$C7,$BB,$BC
	db $C7,$24,$B9,$0C,$C7,$08,$B8,$B7
	db $C7,$B8,$B9,$C7,$24,$C0,$0C,$C7
	db $08,$C7,$DA,$0D,$DB,$0F,$DE,$22
	db $18,$14,$01,$C7,$08,$C7,$18,$4E
	db $C7,$9D,$C7,$9E,$C7,$9F,$C7,$9F
	db $18,$9E,$08,$C7,$C7,$9D,$18,$C6
	db $08,$C7,$C7,$AB,$DA,$0D,$DB,$0F
	db $DE,$22,$18,$14,$08,$C7,$18,$4E
	db $C7,$98,$C7,$98,$C7,$9A,$C7,$99
	db $18,$A1,$08,$C7,$C7,$A3,$18,$C6
	db $08,$C7,$C7,$A4,$DA,$08,$DB,$0A
	db $DE,$22,$18,$14,$08,$C7,$18,$5F
	db $91,$08,$C7,$C7,$91,$18,$92,$08
	db $C7,$C7,$92,$18,$93,$08,$C7,$C7
	db $93,$18,$95,$08,$95,$90,$8F,$18
	db $8E,$08,$C6,$C7,$93,$18,$C6,$08
	db $C7,$C7,$98,$DA,$04,$DB,$14,$08
	db $C7,$18,$6C,$D1,$08,$D2,$C7,$D1
	db $18,$D1,$08,$D2,$C7,$D1,$18,$D1
	db $08,$D2,$C7,$D1,$D1,$C7,$D1,$D2
	db $D1,$D1,$18,$D2,$08,$C6,$C7,$D2
	db $18,$C6,$08,$C7,$C7,$D2,$DA,$04
	db $DB,$0A,$DE,$22,$19,$38,$18,$4D
	db $B4,$08,$C7,$C7,$B4,$E3,$60,$18
	db $18,$B4,$08,$C7,$C7,$B7,$18,$B7
	db $08,$C7,$C7,$B7,$18,$B7,$C7,$00
	db $DA,$04,$DB,$08,$DE,$20,$18,$36
	db $18,$4D,$A4,$08,$C7,$C7,$A4,$18
	db $A4,$08,$C7,$C7,$A7,$18,$A7,$08
	db $C7,$C7,$A7,$18,$A7,$C7,$DA,$04
	db $DB,$0C,$DE,$21,$1A,$37,$18,$4D
	db $AD,$08,$C7,$C7,$AD,$18,$AD,$08
	db $C7,$C7,$AF,$18,$AF,$08,$C7,$C7
	db $AF,$18,$AF,$C7,$DA,$04,$DB,$0A
	db $DE,$22,$18,$36,$18,$4D,$A9,$08
	db $C7,$C7,$A9,$18,$A9,$08,$C7,$C7
	db $AB,$18,$AB,$08,$C7,$C7,$AB,$18
	db $AB,$C7,$DA,$04,$DB,$0F,$08,$4D
	db $C7,$C7,$9A,$18,$9A,$08,$C7,$C7
	db $9A,$18,$9A,$08,$C7,$C7,$9F,$18
	db $9F,$18,$C7,$18,$7D,$9F,$DA,$04
	db $DB,$0F,$08,$4C,$C7,$C7,$8E,$18
	db $8E,$08,$C7,$C7,$8E,$18,$8E,$08
	db $C7,$C7,$93,$18,$93,$18,$C7,$18
	db $7E,$93,$DA,$08,$DB,$0A,$DE,$22
	db $19,$38,$08,$5F,$C7,$C7,$8E,$18
	db $8E,$08,$C7,$C7,$8E,$18,$8E,$08
	db $C7,$C7,$93,$18,$93,$18,$C7,$18
	db $7F,$93,$DA,$00,$DB,$0A,$08,$6C
	db $C7,$C7,$D0,$18,$D0,$08,$C7,$C7
	db $D0,$18,$D0,$08,$C7,$C7,$D0,$18
	db $D0,$18,$C7,$D0,$24,$C7,$00,$DA
	db $04,$E2,$16,$E3,$90,$1C,$DB,$0A
	db $DE,$22,$19,$38,$18,$4C,$B4,$08
	db $C7,$C7,$B4,$18,$B4,$08,$C7,$C7
	db $B7,$18,$B7,$08,$C7,$C7,$B7,$18
	db $B7,$C7,$00,$DA,$04,$DB,$08,$DE
	db $20,$18,$36,$18,$4C,$A4,$08,$C7
	db $C7,$A4,$18,$A4,$08,$C7,$C7,$A7
	db $18,$A7,$08,$C7,$C7,$A7,$18,$A7
	db $C7,$DA,$04,$DB,$0C,$DE,$21,$1A
	db $37,$18,$4C,$AD,$08,$C7,$C7,$AD
	db $18,$AD,$08,$C7,$C7,$AF,$18,$AF
	db $08,$C7,$C7,$AF,$18,$AF,$C7,$DA
	db $04,$DB,$0A,$DE,$22,$18,$36,$18
	db $4C,$A9,$08,$C7,$C7,$A9,$18,$A9
	db $08,$C7,$C7,$AB,$18,$AB,$08,$C7
	db $C7,$AB,$18,$AB,$C7,$DA,$04,$DB
	db $0F,$08,$4C,$C7,$C7,$9A,$18,$9A
	db $08,$C7,$C7,$9A,$18,$9A,$08,$C7
	db $C7,$9F,$18,$9F,$08,$C7,$C7,$C7
	db $18,$7D,$9F,$DA,$04,$DB,$0F,$08
	db $4B,$C7,$C7,$8E,$18,$8E,$08,$C7
	db $C7,$8E,$18,$8E,$08,$C7,$C7,$93
	db $18,$93,$08,$C7,$C7,$C7,$18,$7E
	db $93,$DA,$08,$DB,$0A,$DE,$22,$19
	db $38,$08,$5E,$C7,$C7,$8E,$18,$8E
	db $08,$C7,$C7,$8E,$18,$8E,$08,$C7
	db $C7,$93,$18,$93,$08,$C7,$C7,$C7
	db $18,$7F,$93,$DA,$00,$DB,$0A,$08
	db $6B,$C7,$C7,$D0,$18,$D0,$08,$C7
	db $C7,$D0,$18,$D0,$08,$C7,$C7,$D0
	db $18,$D0,$C7,$08,$D0,$DB,$14,$08
	db $D1,$D1,$DA,$00,$DB,$0A,$DE,$22
	db $19,$38,$08,$5D,$A8,$C7,$AB,$AD
	db $C7,$24,$AB,$0C,$C7,$08,$AD,$AF
	db $C7,$B0,$AF,$AE,$24,$AD,$0C,$C7
	db $08,$A7,$A8,$C7,$AB,$AD,$C7,$24
	db $AB,$0C,$C7,$08,$AC,$AD,$C7,$AE
	db $AD,$AC,$24,$AB,$0C,$C7,$08,$AC
	db $00,$DA,$06,$DB,$0A,$DE,$22,$19
	db $38,$08,$5D,$A8,$C7,$AB,$AD,$C7
	db $24,$AB,$0C,$C7,$08,$AD,$AF,$C7
	db $B0,$AF,$AE,$24,$AD,$0C,$C7,$08
	db $A7,$A8,$C7,$AB,$AD,$C7,$24,$AB
	db $0C,$C7,$08,$AC,$AD,$C7,$AE,$AD
	db $AC,$24,$AB,$0C,$C7,$08,$AC,$00
	db $DA,$12,$DB,$05,$DE,$22,$19,$28
	db $60,$6B,$B4,$30,$B3,$08,$C6,$C6
	db $B3,$BB,$C6,$B9,$48,$B7,$18,$B2
	db $60,$B1,$DA,$06,$DB,$08,$DE,$14
	db $1F,$30,$08,$6B,$A4,$C7,$A4,$A8
	db $C7,$24,$A4,$0C,$C7,$08,$A8,$AB
	db $C7,$AB,$A7,$A7,$24,$A7,$0C,$C7
	db $08,$A3,$A2,$C7,$A6,$A6,$C7,$24
	db $A6,$0C,$C7,$08,$A6,$A8,$C7,$AB
	db $A8,$A8,$24,$A8,$0C,$C7,$08,$A8
	db $08,$6D,$A4,$C7,$A4,$A8,$C7,$24
	db $A4,$0C,$C7,$08,$A8,$AB,$C7,$AB
	db $A7,$A7,$24,$A7,$0C,$C7,$08,$A3
	db $A2,$C7,$A6,$A6,$C7,$24,$A6,$0C
	db $C7,$08,$A6,$A8,$C7,$AB,$A8,$A8
	db $24,$A8,$0C,$C7,$08,$A8,$DA,$06
	db $DB,$0C,$DE,$14,$1F,$30,$08,$6D
	db $9F,$C7,$A8,$A4,$C7,$24,$A8,$0C
	db $C7,$08,$A4,$A7,$C7,$A7,$AB,$AB
	db $24,$A3,$0C,$C7,$08,$9F,$9F,$C7
	db $A2,$A2,$C7,$24,$A2,$0C,$C7,$08
	db $A2,$A5,$C7,$A8,$A5,$A5,$24,$A5
	db $0C,$C7,$08,$A5,$DA,$0D,$DB,$0F
	db $01,$C7,$18,$4E,$C7,$9F,$C7,$9F
	db $C7,$9F,$C7,$9F,$C7,$9F,$C7,$9F
	db $C7,$9F,$C7,$9F,$DA,$0D,$DB,$0F
	db $18,$4E,$C7,$9C,$C7,$9C,$C7,$9B
	db $C7,$9B,$C7,$9A,$C7,$9A,$C7,$99
	db $C7,$99,$DA,$08,$DB,$0A,$DE,$14
	db $1F,$30,$18,$6F,$98,$C7,$18,$93
	db $08,$C7,$C7,$93,$18,$97,$C7,$18
	db $93,$08,$C7,$C7,$93,$18,$96,$C7
	db $18,$93,$08,$C7,$C7,$93,$18,$95
	db $C7,$18,$90,$08,$C7,$C7,$90,$DA
	db $00,$DB,$14,$18,$6B,$D1,$08,$D2
	db $C7,$D1,$18,$D1,$08,$D2,$C7,$D1
	db $18,$D1,$08,$D2,$C7,$D1,$D1,$C7
	db $D1,$D2,$D1,$D1,$18,$D1,$08,$D2
	db $C7,$D1,$18,$D1,$08,$D2,$C7,$D1
	db $18,$D1,$08,$D2,$C7,$D1,$D1,$C7
	db $D1,$D2,$D1,$D1,$08,$AD,$C7,$AF
	db $B0,$C7,$24,$AD,$0C,$C7,$08,$AC
	db $AB,$C7,$AC,$AD,$C7,$24,$A8,$0C
	db $C7,$08,$C7,$A8,$C7,$A4,$A1,$C7
	db $A8,$A4,$C7,$A1,$A4,$C7,$AB,$30
	db $C6,$C7,$00,$01,$C7,$18,$C7,$9D
	db $C7,$9E,$C7,$9F,$C7,$9F,$18,$9E
	db $08,$C7,$C7,$9E,$18,$C6,$08,$9E
	db $C7,$9F,$18,$C6,$08,$C7,$C7,$A3
	db $A4,$C7,$A4,$A6,$C7,$A6,$18,$C7
	db $98,$C7,$98,$C7,$9A,$C7,$99,$18
	db $A1,$08,$C7,$C7,$A1,$18,$C6,$08
	db $A1,$C7,$A3,$18,$C6,$08,$C7,$C7
	db $9A,$9C,$C7,$9C,$9D,$C7,$9D,$18
	db $91,$08,$C7,$C7,$91,$18,$92,$08
	db $C7,$C7,$92,$18,$93,$08,$C7,$C7
	db $93,$18,$95,$08,$95,$90,$8F,$18
	db $8E,$08,$C6,$C7,$8E,$18,$C6,$08
	db $8E,$C7,$93,$18,$C6,$08,$C7,$C7
	db $93,$95,$C7,$95,$97,$C7,$97,$18
	db $D1,$08,$D2,$C7,$D1,$18,$D1,$08
	db $D2,$C7,$D1,$18,$D1,$08,$D2,$C7
	db $D1,$D1,$C7,$D1,$D2,$D1,$D1,$18
	db $D2,$08,$C6,$C7,$D2,$18,$C6,$08
	db $D2,$C7,$D2,$18,$C6,$08,$C6,$C7
	db $D1,$D2,$C7,$D1,$D2,$D1,$D1,$08
	db $A9,$C7,$A9,$AD,$C7,$24,$AA,$0C
	db $C7,$08,$A9,$A8,$C7,$A8,$A8,$C7
	db $24,$AB,$0C,$C7,$08,$C7,$AD,$C7
	db $AD,$AD,$C7,$A9,$C7,$C7,$A9,$A9
	db $C7,$A8,$30,$C6,$C7,$08,$AD,$C7
	db $AF,$B0,$C7,$24,$AD,$0C,$C7,$08
	db $AC,$AB,$C7,$AC,$AD,$C7,$24,$B4
	db $0C,$C7,$08,$C7,$B4,$C7,$B3,$B4
	db $C7,$B0,$C7,$C7,$B0,$AD,$C7,$B0
	db $30,$C6,$C7,$00,$48,$B0,$08,$AD
	db $C6,$B0,$48,$B4,$08,$B3,$C6,$B4
	db $30,$B9,$30,$B4,$60,$B0,$01,$C7
	db $18,$C7,$9D,$C7,$9E,$C7,$9F,$C7
	db $9F,$18,$9E,$08,$C7,$C7,$9D,$18
	db $C6,$08,$C7,$C7,$AB,$18,$C6,$08
	db $B0,$C7,$B0,$AF,$C7,$AF,$AE,$C7
	db $AE,$18,$C7,$98,$C7,$98,$C7,$9A
	db $C7,$99,$18,$A1,$08,$C7,$C7,$A3
	db $18,$C6,$08,$C7,$C7,$A4,$18,$C6
	db $08,$A8,$C7,$A8,$A7,$C7,$A7,$A6
	db $C7,$A6,$18,$91,$08,$C7,$C7,$91
	db $18,$92,$08,$C7,$C7,$92,$18,$93
	db $08,$C7,$C7,$93,$18,$95,$08,$95
	db $90,$8F,$18,$8E,$08,$C6,$C7,$93
	db $18,$C6,$08,$C7,$C7,$98,$18,$C6
	db $08,$98,$C7,$98,$97,$C7,$97,$96
	db $C7,$96,$18,$D1,$08,$D2,$C7,$D1
	db $18,$D1,$08,$D2,$C7,$D1,$18,$D1
	db $08,$D2,$C7,$D1,$D1,$C7,$D1,$D2
	db $D1,$D1,$18,$D2,$08,$C6,$C7,$D2
	db $18,$C6,$08,$C7,$C7,$D2,$18,$C6
	db $08,$D2,$C7,$D1,$D2,$C7,$D1,$D2
	db $C7,$D1,$DA,$04,$18,$6C,$AD,$B4
	db $08,$B4,$C7,$B4,$B3,$C7,$B4,$B5
	db $C6,$B4,$B1,$C7,$24,$AD,$0C,$C7
	db $08,$AD,$B4,$C6,$B2,$B4,$C6,$B2
	db $B4,$C6,$B2,$B0,$C7,$AD,$30,$C6
	db $C7,$00,$DA,$04,$18,$6B,$A8,$AB
	db $08,$AB,$C7,$AB,$AA,$C7,$AB,$AD
	db $C6,$AB,$A8,$C7,$24,$A5,$0C,$C7
	db $08,$A5,$AB,$C6,$AA,$AB,$C6,$AA
	db $AB,$C6,$AA,$A8,$C7,$A4,$30,$C6
	db $C7,$18,$C7,$08,$AD,$C6,$AC,$AD
	db $C6,$B4,$C6,$C6,$AD,$AD,$C6,$AC
	db $AD,$C6,$B4,$C6,$C6,$AD,$AF,$C6
	db $B1,$18,$C7,$08,$AD,$C6,$AC,$AD
	db $C6,$B2,$C6,$C6,$AD,$AD,$C6,$AC
	db $AD,$C6,$B2,$30,$C6,$01,$C7,$18
	db $C7,$9F,$C7,$9F,$C7,$9F,$C7,$9F
	db $C7,$9E,$C7,$9E,$C7,$9E,$C7,$9E
	db $18,$C7,$99,$C7,$99,$C7,$99,$C7
	db $99,$C7,$98,$C7,$98,$C7,$98,$C7
	db $98,$18,$95,$08,$C7,$C7,$95,$18
	db $90,$08,$C7,$C7,$90,$18,$95,$08
	db $C7,$C7,$95,$18,$95,$08,$95,$90
	db $8F,$18,$8E,$08,$C7,$C7,$8E,$18
	db $95,$08,$C7,$C7,$95,$18,$8E,$08
	db $C7,$C7,$8E,$8E,$C7,$8E,$90,$C7
	db $92,$18,$D1,$08,$D2,$C7,$D1,$18
	db $D1,$08,$D2,$C7,$D1,$18,$D1,$08
	db $D2,$C7,$D1,$D1,$C7,$D1,$D2,$D1
	db $D1,$18,$D1,$08,$D2,$C7,$D1,$18
	db $D1,$08,$D2,$C7,$D1,$18,$D1,$08
	db $D2,$C7,$D1,$D2,$C7,$D1,$D2,$C7
	db $D1,$18,$AB,$B2,$08,$B2,$C7,$B2
	db $B1,$C7,$B2,$B4,$C6,$B2,$AF,$C7
	db $24,$AB,$0C,$C7,$08,$B2,$18,$B0
	db $B0,$10,$B0,$B2,$B3,$18,$B4,$C7
	db $AB,$C6,$00,$18,$A3,$A9,$08,$A9
	db $C7,$A9,$A8,$C7,$A9,$AB,$C6,$A9
	db $A6,$C7,$24,$A3,$0C,$C7,$08,$A9
	db $18,$A8,$A8,$10,$A8,$A9,$AA,$18
	db $AB,$C7,$A3,$C6,$18,$C7,$08,$AB
	db $C6,$AA,$AB,$C6,$B2,$C6,$C6,$AB
	db $AB,$C6,$AA,$AB,$C6,$B2,$C6,$C6
	db $AB,$AD,$C6,$AF,$30,$B0,$10,$B0
	db $AF,$AD,$AB,$06,$AD,$AF,$B0,$B2
	db $B3,$B4,$B5,$B6,$30,$B7,$01,$C7
	db $18,$C7,$9D,$C7,$9D,$C7,$9D,$C7
	db $9D,$C7,$9C,$10,$9C,$9D,$9E,$18
	db $9F,$C7,$9B,$C6,$18,$C7,$97,$C7
	db $97,$C7,$97,$C7,$97,$C7,$9F,$10
	db $9F,$A0,$A1,$18,$A3,$C7,$A3,$C6
	db $18,$93,$08,$C7,$C7,$93,$18,$8E
	db $08,$C7,$C7,$8E,$18,$93,$08,$C7
	db $C7,$93,$18,$93,$08,$93,$95,$97
	db $18,$98,$08,$C7,$C7,$98,$10,$98
	db $9A,$9B,$18,$9C,$C7,$93,$C6,$18
	db $D1,$08,$D2,$C7,$D1,$18,$D1,$08
	db $D2,$C7,$D1,$18,$D1,$08,$D2,$C7
	db $D1,$D1,$C7,$D1,$D2,$D1,$D1,$18
	db $D1,$08,$D2,$C7,$D1,$10,$D2,$D2
	db $D2,$18,$D1,$08,$D2,$C7,$D1,$D2
	db $C7,$D1,$D2,$D1,$D1,$08,$A9,$C7
	db $A9,$AD,$C7,$24,$AA,$0C,$C7,$08
	db $A9,$A8,$C7,$A8,$A8,$C7,$24,$AB
	db $0C,$C7,$08,$C7,$08,$AD,$C7,$AF
	db $B0,$C7,$24,$AD,$0C,$C7,$08,$AC
	db $AB,$C7,$AC,$AD,$C7,$24,$B4,$0C
	db $C7,$08,$C7,$00,$DA,$04,$DB,$0C
	db $DE,$22,$18,$14,$08,$5C,$A4,$C7
	db $A4,$A9,$C7,$24,$A4,$0C,$C7,$08
	db $A4,$A4,$C7,$A4,$A4,$C7,$24,$A5
	db $0C,$C7,$08,$C7,$48,$B0,$08,$AD
	db $C6,$B0,$60,$B4,$01,$C7,$18,$C7
	db $9D,$C7,$9E,$C7,$9F,$C7,$9F,$18
	db $9E,$08,$C7,$C7,$9D,$18,$C6,$08
	db $C7,$C7,$AB,$18,$C7,$98,$C7,$98
	db $C7,$9A,$C7,$99,$18,$A1,$08,$C7
	db $C7,$A3,$18,$C6,$08,$C7,$C7,$A4
	db $18,$91,$08,$C7,$C7,$91,$18,$92
	db $08,$C7,$C7,$92,$18,$93,$08,$C7
	db $C7,$93,$18,$95,$08,$95,$90,$8F
	db $18,$8E,$08,$C6,$C7,$93,$18,$C6
	db $08,$C7,$C7,$98,$18,$D1,$08,$D2
	db $C7,$D1,$18,$D1,$08,$D2,$C7,$D1
	db $18,$D1,$08,$D2,$C7,$D1,$D1,$C7
	db $D1,$D2,$D1,$D1,$18,$D2,$08,$C6
	db $C7,$D2,$18,$C6,$08,$C7,$C7,$D2
	db $DA,$04,$DB,$0A,$DE,$22,$19,$38
	db $18,$4D,$B4,$08,$C7,$C7,$B4,$18
	db $B4,$08,$C7,$C7,$B7,$18,$B7,$08
	db $C7,$C7,$B7,$18,$B7,$C7,$00,$DA
	db $04,$DB,$08,$DE,$20,$18,$36,$18
	db $4D,$A4,$08,$C7,$C7,$A4,$18,$A4
	db $08,$C7,$C7,$A7,$18,$A7,$08,$C7
	db $C7,$A7,$18,$A7,$C7,$DA,$04,$DB
	db $0C,$DE,$21,$1A,$37,$18,$4D,$AD
	db $08,$C7,$C7,$AD,$18,$AD,$08,$C7
	db $C7,$AF,$18,$AF,$08,$C7,$C7,$AF
	db $18,$AF,$C7,$DA,$04,$DB,$0A,$DE
	db $22,$18,$36,$18,$4D,$A9,$08,$C7
	db $C7,$A9,$18,$A9,$08,$C7,$C7,$AB
	db $18,$AB,$08,$C7,$C7,$AB,$18,$AB
	db $C7,$DA,$04,$DB,$0F,$08,$4D,$C7
	db $C7,$9A,$18,$9A,$08,$C7,$C7,$9A
	db $18,$9A,$08,$C7,$C7,$9F,$18,$9F
	db $08,$C7,$C7,$C7,$18,$7D,$9F,$DA
	db $04,$DB,$0F,$08,$4C,$C7,$C7,$8E
	db $18,$8E,$08,$C7,$C7,$8E,$18,$8E
	db $08,$C7,$C7,$93,$18,$93,$08,$C7
	db $C7,$C7,$18,$7E,$93,$DA,$08,$DB
	db $0A,$DE,$22,$19,$38,$08,$5F,$C7
	db $C7,$8E,$18,$8E,$08,$C7,$C7,$8E
	db $18,$8E,$08,$C7,$C7,$93,$18,$93
	db $08,$C7,$C7,$C7,$18,$7F,$93,$DA
	db $00,$DB,$0A,$08,$6C,$C7,$C7,$D0
	db $18,$D0,$08,$C7,$C7,$D0,$18,$D0
	db $08,$C7,$C7,$D0,$18,$D0,$C7,$08
	db $D0,$DB,$14,$08,$D1,$D1,$DA,$06
	db $DB,$0A,$DE,$22,$19,$38,$08,$6F
	db $B4,$C7,$B7,$B9,$C7,$24,$B7,$0C
	db $C7,$08,$B9,$BB,$C7,$BC,$BB,$BA
	db $24,$B9,$0C,$C7,$08,$B3,$B4,$C7
	db $B7,$B9,$C7,$24,$B7,$0C,$C7,$08
	db $B8,$B9,$C7,$BA,$B9,$B8,$24,$B7
	db $0C,$C7,$08,$B8,$00,$08,$B9,$C7
	db $BB,$BC,$C7,$24,$B9,$0C,$C7,$08
	db $B8,$B7,$C7,$B8,$B9,$C7,$24,$C0
	db $0C,$C7,$08,$C7,$00,$18,$91,$08
	db $C7,$C7,$91,$18,$92,$08,$C7,$C7
	db $92,$18,$93,$08,$C7,$C7,$93,$18
	db $95,$08,$C7,$C7,$95,$DA,$04,$DB
	db $0A,$DE,$22,$19,$38,$18,$5D,$C0
	db $08,$C7,$C7,$C0,$E3,$78,$18,$18
	db $C0,$08,$C7,$C7,$C3,$18,$C3,$08
	db $C7,$C7,$C3,$18,$C3,$C3,$00,$DA
	db $04,$DB,$0A,$DE,$22,$19,$38,$18
	db $5D,$C0,$08,$C7,$C7,$C0,$18,$C0
	db $08,$C7,$C7,$C3,$18,$C3,$08,$C7
	db $C7,$C3,$18,$C3,$C3,$00,$DA,$04
	db $DB,$08,$DE,$20,$18,$36,$18,$5D
	db $A4,$08,$C7,$C7,$A4,$18,$A4,$08
	db $C7,$C7,$A7,$18,$A7,$08,$C7,$C7
	db $A7,$18,$A7,$A7,$DA,$04,$DB,$0C
	db $DE,$21,$1A,$37,$18,$5D,$B9,$08
	db $C7,$C7,$B9,$18,$B9,$08,$C7,$C7
	db $BB,$18,$BB,$08,$C7,$C7,$BB,$18
	db $BB,$BB,$DA,$04,$DB,$0A,$DE,$22
	db $18,$36,$18,$5D,$A9,$08,$C7,$C7
	db $A9,$18,$A9,$08,$C7,$C7,$AB,$18
	db $AB,$08,$C7,$C7,$AB,$18,$AB,$AB
	db $DA,$04,$DB,$0F,$08,$5D,$C7,$C7
	db $9A,$18,$9A,$08,$C7,$C7,$9A,$18
	db $9A,$08,$C7,$C7,$9F,$18,$9F,$08
	db $C7,$C7,$9F,$08,$7D,$C7,$C7,$9F
	db $DA,$04,$DB,$0F,$08,$5C,$C7,$C7
	db $8E,$18,$8E,$08,$C7,$C7,$8E,$18
	db $8E,$08,$C7,$C7,$93,$18,$93,$08
	db $C7,$C7,$93,$08,$7E,$C7,$C7,$93
	db $DA,$08,$DB,$0A,$DE,$22,$19,$38
	db $08,$5F,$C7,$C7,$8E,$18,$8E,$08
	db $C7,$C7,$8E,$18,$8E,$08,$C7,$C7
	db $93,$18,$93,$08,$C7,$C7,$C7,$08
	db $7F,$C7,$C7,$93,$DA,$00,$DB,$0A
	db $08,$6C,$C7,$C7,$D0,$18,$D0,$08
	db $C7,$C7,$D0,$18,$D0,$08,$C7,$C7
	db $D0,$18,$D0,$C7,$08,$D0,$DB,$14
	db $08,$D1,$D1,$DA,$04,$DE,$14,$19
	db $30,$DB,$0A,$08,$4F,$B9,$C6,$B7
	db $B9,$C6,$24,$B7,$0C,$C6,$08,$B9
	db $BB,$C6,$C7,$BB,$C6,$24,$B9,$0C
	db $C6,$08,$C6,$B9,$C6,$B7,$B9,$C6
	db $24,$B7,$0C,$C6,$08,$B8,$B9,$C6
	db $C7,$B9,$C6,$24,$B7,$0C,$C6,$08
	db $B8,$DE,$16,$18,$30,$DB,$0A,$08
	db $4E,$AD,$C6,$AB,$AD,$C6,$24,$AB
	db $0C,$C6,$08,$AD,$AF,$C6,$C7,$AF
	db $C6,$24,$AD,$0C,$C6,$08,$C6,$AD
	db $C6,$AB,$AD,$C6,$24,$AB,$0C,$C7
	db $08,$AC,$AD,$C6,$C7,$AD,$C6,$24
	db $AB,$0C,$C6,$08,$AC,$00,$DE,$15
	db $19,$31,$DB,$08,$08,$4E,$A8,$C6
	db $A4,$A8,$C6,$24,$A8,$0C,$C6,$08
	db $A8,$AB,$C6,$C7,$AB,$C6,$24,$A7
	db $0C,$C6,$08,$C6,$A6,$C6,$A6,$A6
	db $C6,$24,$A6,$0C,$C6,$08,$A6,$A8
	db $C6,$C7,$A8,$C6,$24,$A8,$0C,$C6
	db $08,$A8,$DA,$06,$DB,$0C,$DE,$14
	db $1A,$30,$08,$4E,$A4,$C6,$A4,$A4
	db $C6,$24,$A4,$0C,$C6,$08,$A4,$A7
	db $C6,$C7,$A7,$C6,$24,$A3,$0C,$C6
	db $08,$C6,$A2,$C6,$A2,$A2,$C6,$24
	db $A2,$0C,$C6,$08,$A2,$A5,$C6,$C7
	db $A5,$C6,$24,$A5,$0C,$C6,$08,$A5
	db $08,$B9,$C6,$BB,$BC,$C6,$24,$B9
	db $0C,$C6,$08,$B8,$B7,$C6,$B8,$B9
	db $C6,$24,$C0,$0C,$C6,$08,$C6,$00
	db $08,$A9,$C6,$A9,$AD,$C6,$24,$AA
	db $0C,$C6,$08,$A9,$A8,$C6,$A8,$A8
	db $C6,$24,$AB,$0C,$C6,$08,$C6,$08
	db $AD,$C6,$AF,$B0,$C6,$24,$AD,$0C
	db $C6,$08,$AC,$AB,$C6,$AC,$AD,$C6
	db $24,$B4,$0C,$C6,$08,$C6,$00,$DA
	db $04,$DB,$0C,$DE,$22,$18,$14,$08
	db $5C,$A4,$C6,$A4,$A9,$C6,$24,$A4
	db $0C,$C6,$08,$A4,$A4,$C6,$A4,$A4
	db $C6,$24,$A5,$0C,$C6,$08,$C6,$DA
	db $04,$DB,$0A,$DE,$22,$19,$38,$60
	db $5E,$BC,$C6,$DA,$01,$10,$9F,$C6
	db $C6,$C6,$AF,$C6,$60,$C6,$C6,$00
	db $DA,$04,$DB,$08,$DE,$20,$18,$36
	db $60,$5D,$B4,$C6,$DA,$01,$10,$C7
	db $A3,$C6,$C6,$C6,$B3,$60,$C6,$C6
	db $DA,$04,$DB,$0C,$DE,$21,$1A,$37
	db $60,$5D,$AB,$C6,$DA,$01,$10,$C7
	db $C7,$A7,$C6,$C6,$C6,$60,$B7,$C6
	db $DA,$04,$DB,$0A,$DE,$22,$18,$36
	db $60,$5D,$A4,$C6,$DA,$01,$10,$C7
	db $C7,$C7,$AB,$C6,$C6,$60,$C6,$C6
	db $DA,$04,$DB,$0F,$10,$5D,$A4,$C7
	db $A4,$A2,$C7,$A2,$A1,$C7,$A1,$A0
	db $C7,$A0,$60,$9F,$9B,$C6,$DA,$0D
	db $DB,$0F,$10,$5D,$9C,$C7,$9C,$9C
	db $C7,$9C,$98,$C7,$98,$98,$C7,$98
	db $60,$97,$97,$C6,$DA,$08,$DB,$0A
	db $DE,$22,$19,$38,$10,$5D,$98,$C7
	db $98,$96,$C7,$96,$95,$C7,$95,$94
	db $C7,$94,$60,$93,$93,$C6
.end
	
	dw $0000				;		| Stop uploading data
	dw $0500
	
	db $E8,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00

DATA_03FDE0:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
