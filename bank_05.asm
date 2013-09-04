ORG $058000

TilesetMAP16Loc:
	db $70,$8B,$00,$BC,$00,$C8,$00,$D4
	db $00,$E3,$00,$E3,$00,$C8,$70,$8B
	db $00,$C8,$00,$D4,$00,$D4,$00,$D4
	db $70,$8B,$00,$E3,$00,$D4

CODE_05801E:
	PHP
	SEP #$20				;$05801F	|
	REP #$10				;$058021	|
	LDX.w #$0000				;$058023	|
CODE_058026:
	LDA.b #$25
	STA.l $7EB900,X				;$058028	|
	STA.l $7EBB00,X				;$05802C	|
	INX					;$058030	|
	CPX.w #$0200				;$058031	|
	BNE CODE_058026				;$058034	|
	STZ.w $1928				;$058036	|
	LDA $6A					;$058039	|
	CMP.b #$FF				;$05803B	|
	BNE CODE_058074				;$05803D	|
	REP #$10				;$05803F	|
	LDY.w #$0000				;$058041	|
	LDX $68					;$058044	|
	CPX.w #$E8FE				;$058046	|
	BCC CODE_05804E				;$058049	|
	LDY.w #$0001				;$05804B	|
CODE_05804E:
	LDX.w #$0000
	TYA					;$058051	|
CODE_058052:
	STA.l $7EBD00,X
	STA.l $7EBF00,X				;$058056	|
	INX					;$05805A	|
	CPX.w #$0200				;$05805B	|
	BNE CODE_058052				;$05805E	|
	LDA.b #$0C				;$058060	|
	STA $6A					;$058062	|
	STZ.w $1932				;$058064	|
	STZ.w $1931				;$058067	|
	LDX.w #$B900				;$05806A	|
	STX $0D					;$05806D	|
	REP #$20				;$05806F	|
	JSR CODE_058126				;$058071	|
CODE_058074:
	SEP #$20
	LDX.w #$0000				;$058076	|
CODE_058079:
	LDA.b #$00
	JSR CODE_05833A				;$05807B	|
	DEX					;$05807E	|
	LDA.b #$25				;$05807F	|
	JSR CODE_0582C8				;$058081	|
	CPX.w #$0200				;$058084	|
	BNE CODE_058079				;$058087	|
	STZ.w $1928				;$058089	|
	JSR LoadLevel				;$05808C	|
	SEP #$30				;$05808F	|
	LDA.w $0100				;$058091	|
	CMP.b #$22				;$058094	|
	BPL CODE_05809C				;$058096	|
	JSL CODE_02A751				;$058098	|
CODE_05809C:
	PLP
	RTL					;$05809D	|

CODE_05809E:
	PHP
	SEP #$20				;$05809F	|
	STZ.w $1928				;$0580A1	|
	REP #$30				;$0580A4	|
	LDA.w #$FFFF				;$0580A6	|
	STA $4D					;$0580A9	|
	STA $4F					;$0580AB	|
	JSR CODE_05877E				;$0580AD	|
	LDA $45					;$0580B0	|
	STA $47					;$0580B2	|
	LDA $49					;$0580B4	|
	STA $4B					;$0580B6	|
	LDA.w #$0202				;$0580B8	|
	STA $55					;$0580BB	|
CODE_0580BD:
	REP #$30
	JSL CODE_0588EC				;$0580BF	|
	JSL CODE_058955				;$0580C3	|
	JSL CODE_0087AD				;$0580C7	|
	REP #$30				;$0580CB	|
	INC $47					;$0580CD	|
	INC $4B					;$0580CF	|
	SEP #$30				;$0580D1	|
	LDA $47					;$0580D3	|
	LSR					;$0580D5	|
	LSR					;$0580D6	|
	LSR					;$0580D7	|
	REP #$30				;$0580D8	|
	AND.w #$0006				;$0580DA	|
	TAX					;$0580DD	|
	LDA.w #$0133				;$0580DE	|
	ASL					;$0580E1	|
	TAY					;$0580E2	|
	LDA.w #$0007				;$0580E3	|
	STA $00					;$0580E6	|
	LDA.l MAP16AppTable,X			;$0580E8	|
CODE_0580EC:
	STA.w $0FBE,Y
	INY					;$0580EF	|
	INY					;$0580F0	|
	CLC					;$0580F1	|
	ADC.w #$0008				;$0580F2	|
	DEC $00					;$0580F5	|
	BPL CODE_0580EC				;$0580F7	|
	SEP #$20				;$0580F9	|
	INC.w $1928				;$0580FB	|
	LDA.w $1928				;$0580FE	|
	CMP.b #$20				;$058101	|
	BNE CODE_0580BD				;$058103	|
	LDA.w $0D9D				;$058105	|
	STA.w $212C				;$058108	|
	STA.w $212E				;$05810B	|
	LDA.w $0D9E				;$05810E	|
	STA.w $212D				;$058111	|
	STA.w $212F				;$058114	|
	REP #$20				;$058117	|
	LDA.w #$FFFF				;$058119	|
	STA $4D					;$05811C	|
	STA $4F					;$05811E	|
	STA $51					;$058120	|
	STA $53					;$058122	|
	PLP					;$058124	|
	RTL					;$058125	|

CODE_058126:
	PHP
	REP #$30				;$058127	|
	LDY.w #$0000				;$058129	|
	STY $03					;$05812C	|
	STY $05					;$05812E	|
	SEP #$30				;$058130	|
	LDA.b #$7E				;$058132	|
	STA $0F					;$058134	|
CODE_058136:
	SEP #$20
	REP #$10				;$058138	|
	LDY $03					;$05813A	|
	LDA [$68],Y				;$05813C	|
	STA $07					;$05813E	|
	INY					;$058140	|
	REP #$20				;$058141	|
	STY $03					;$058143	|
	SEP #$20				;$058145	|
	AND.b #$80				;$058147	|
	BEQ CODE_05816A				;$058149	|
	LDA $07					;$05814B	|
	AND.b #$7F				;$05814D	|
	STA $07					;$05814F	|
	LDA [$68],Y				;$058151	|
	INY					;$058153	|
	REP #$20				;$058154	|
	STY $03					;$058156	|
	LDY $05					;$058158	|
CODE_05815A:
	SEP #$20
	STA [$0D],Y				;$05815C	|
	INY					;$05815E	|
	DEC $07					;$05815F	|
	BPL CODE_05815A				;$058161	|
	REP #$20				;$058163	|
	STY $05					;$058165	|
	JMP CODE_058188				;$058167	|

CODE_05816A:
	REP #$20
	LDY $03					;$05816C	|
	SEP #$20				;$05816E	|
	LDA [$68],Y				;$058170	|
	INY					;$058172	|
	REP #$20				;$058173	|
	STY $03					;$058175	|
	LDY $05					;$058177	|
	SEP #$20				;$058179	|
	STA [$0D],Y				;$05817B	|
	REP #$20				;$05817D	|
	INY					;$05817F	|
	STY $05					;$058180	|
	SEP #$20				;$058182	|
	DEC $07					;$058184	|
	BPL CODE_05816A				;$058186	|
CODE_058188:
	REP #$20
	LDY $03					;$05818A	|
	SEP #$20				;$05818C	|
	LDA [$68],Y				;$05818E	|
	CMP.b #$FF				;$058190	|
	BNE CODE_058136				;$058192	|
	INY					;$058194	|
	LDA [$68],Y				;$058195	|
	CMP.b #$FF				;$058197	|
	BNE CODE_058136				;$058199	|
	REP #$20				;$05819B	|
	LDA.w #$9100				;$05819D	|
	STA $00					;$0581A0	|
	LDX.w #$0000				;$0581A2	|
CODE_0581A5:
	LDA $00
	STA.w $0FBE,X				;$0581A7	|
	LDA $00					;$0581AA	|
	CLC					;$0581AC	|
	ADC.w #$0008				;$0581AD	|
	STA $00					;$0581B0	|
	INX					;$0581B2	|
	INX					;$0581B3	|
	CPX.w #$0400				;$0581B4	|
	BNE CODE_0581A5				;$0581B7	|
	PLP					;$0581B9	|
	RTS					;$0581BA	|

DATA_0581BB:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$E0,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $FE,$00,$7F,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$E0,$00,$00,$03,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

CODE_0581FB:
	SEP #$30
	LDA.w $1931				;$0581FD	|
	ASL					;$058200	|
	TAX					;$058201	|
	LDA.b #$05				;$058202	|
	STA $0F					;$058204	|
	LDA.b #$00				;$058206	|
	STA $84					;$058208	|
	LDA.b #$C4				;$05820A	|
	STA.w $1430				;$05820C	|
	LDA.b #$CA				;$05820F	|
	STA.w $1431				;$058211	|
	REP #$20				;$058214	|
	LDA.w #$E55E				;$058216	|
	STA $82					;$058219	|
	LDA.l TilesetMAP16Loc,X			;$05821B	|
	STA $00					;$05821F	|
	LDA.w #$8000				;$058221	|
	STA $02					;$058224	|
	LDA.w #$81BB				;$058226	|
	STA $0D					;$058229	|
	STZ $04					;$05822B	|
	STZ $09					;$05822D	|
	STZ $0B					;$05822F	|
	REP #$10				;$058231	|
	LDY.w #$0000				;$058233	|
	TYX					;$058236	|
CODE_058237:
	SEP #$20
	LDA [$0D],Y				;$058239	|
	STA $0C					;$05823B	|
CODE_05823D:
	ASL $0C
	BCC CODE_058253				;$05823F	|
	REP #$20				;$058241	|
	LDA $02					;$058243	|
	STA.w $0FBE,X				;$058245	|
	LDA $02					;$058248	|
	CLC					;$05824A	|
	ADC.w #$0008				;$05824B	|
	STA $02					;$05824E	|
	JMP CODE_058262				;$058250	|

CODE_058253:
	REP #$20
	LDA $00					;$058255	|
	STA.w $0FBE,X				;$058257	|
	LDA $00					;$05825A	|
	CLC					;$05825C	|
	ADC.w #$0008				;$05825D	|
	STA $00					;$058260	|
CODE_058262:
	SEP #$20
	INX					;$058264	|
	INX					;$058265	|
	INC $09					;$058266	|
	INC $0B					;$058268	|
	LDA $0B					;$05826A	|
	CMP.b #$08				;$05826C	|
	BNE CODE_05823D				;$05826E	|
	STZ $0B					;$058270	|
	INY					;$058272	|
	CPY.w #$0040				;$058273	|
	BNE CODE_058237				;$058276	|
	LDA.w $1931				;$058278	|
	BEQ CODE_058281				;$05827B	|
	CMP.b #$07				;$05827D	|
	BNE CODE_0582C5				;$05827F	|
CODE_058281:
	LDA.b #$FF
	STA.w $1430				;$058283	|
	STA.w $1431				;$058286	|
	REP #$30				;$058289	|
	LDA.w #$E5C8				;$05828B	|
	STA $82					;$05828E	|
	LDA.w #$01C4				;$058290	|
	ASL					;$058293	|
	TAY					;$058294	|
	LDA.w #$8A70				;$058295	|
	STA $00					;$058298	|
	LDX.w #$0003				;$05829A	|
CODE_05829D:
	LDA $00
	STA.w $0FBE,Y				;$05829F	|
	CLC					;$0582A2	|
	ADC.w #$0008				;$0582A3	|
	STA $00					;$0582A6	|
	INY					;$0582A8	|
	INY					;$0582A9	|
	DEX					;$0582AA	|
	BPL CODE_05829D				;$0582AB	|
	LDA.w #$01EC				;$0582AD	|
	ASL					;$0582B0	|
	TAY					;$0582B1	|
	LDX.w #$0003				;$0582B2	|
CODE_0582B5:
	LDA $00
	STA.w $0FBE,Y				;$0582B7	|
	CLC					;$0582BA	|
	ADC.w #$0008				;$0582BB	|
	STA $00					;$0582BE	|
	INY					;$0582C0	|
	INY					;$0582C1	|
	DEX					;$0582C2	|
	BPL CODE_0582B5				;$0582C3	|
CODE_0582C5:
	SEP #$30
	RTS					;$0582C7	|

CODE_0582C8:
	STA.l $7EC800,X
	STA.l $7ECA00,X				;$0582CC	|
	STA.l $7ECC00,X				;$0582D0	|
	STA.l $7ECE00,X				;$0582D4	|
	STA.l $7ED000,X				;$0582D8	|
	STA.l $7ED200,X				;$0582DC	|
	STA.l $7ED400,X				;$0582E0	|
	STA.l $7ED600,X				;$0582E4	|
	STA.l $7ED800,X				;$0582E8	|
	STA.l $7EDA00,X				;$0582EC	|
	STA.l $7EDC00,X				;$0582F0	|
	STA.l $7EDE00,X				;$0582F4	|
	STA.l $7EE000,X				;$0582F8	|
	STA.l $7EE200,X				;$0582FC	|
	STA.l $7EE400,X				;$058300	|
	STA.l $7EE600,X				;$058304	|
	STA.l $7EE800,X				;$058308	|
	STA.l $7EEA00,X				;$05830C	|
	STA.l $7EEC00,X				;$058310	|
	STA.l $7EEE00,X				;$058314	|
	STA.l $7EF000,X				;$058318	|
	STA.l $7EF200,X				;$05831C	|
	STA.l $7EF400,X				;$058320	|
	STA.l $7EF600,X				;$058324	|
	STA.l $7EF800,X				;$058328	|
	STA.l $7EFA00,X				;$05832C	|
	STA.l $7EFC00,X				;$058330	|
	STA.l $7EFE00,X				;$058334	|
	INX					;$058338	|
	RTS					;$058339	|

CODE_05833A:
	STA.l $7FC800,X
	STA.l $7FCA00,X				;$05833E	|
	STA.l $7FCC00,X				;$058342	|
	STA.l $7FCE00,X				;$058346	|
	STA.l $7FD000,X				;$05834A	|
	STA.l $7FD200,X				;$05834E	|
	STA.l $7FD400,X				;$058352	|
	STA.l $7FD600,X				;$058356	|
	STA.l $7FD800,X				;$05835A	|
	STA.l $7FDA00,X				;$05835E	|
	STA.l $7FDC00,X				;$058362	|
	STA.l $7FDE00,X				;$058366	|
	STA.l $7FE000,X				;$05836A	|
	STA.l $7FE200,X				;$05836E	|
	STA.l $7FE400,X				;$058372	|
	STA.l $7FE600,X				;$058376	|
	STA.l $7FE800,X				;$05837A	|
	STA.l $7FEA00,X				;$05837E	|
	STA.l $7FEC00,X				;$058382	|
	STA.l $7FEE00,X				;$058386	|
	STA.l $7FF000,X				;$05838A	|
	STA.l $7FF200,X				;$05838E	|
	STA.l $7FF400,X				;$058392	|
	STA.l $7FF600,X				;$058396	|
	STA.l $7FF800,X				;$05839A	|
	STA.l $7FFA00,X				;$05839E	|
	STA.l $7FFC00,X				;$0583A2	|
	STA.l $7FFE00,X				;$0583A6	|
	INX					;$0583AA	|
	RTS					;$0583AB	|

LoadLevel:
	PHP
	SEP #$30				;$0583AD	|
	STZ.w $1933				;$0583AF	|
	JSR CODE_0584E3				;$0583B2	|
	JSR CODE_0581FB				;$0583B5	|
LoadAgain:
	LDA.w $1925
	CMP.b #$09				;$0583BB	|
	BEQ LoadLevelDone			;$0583BD	|
	CMP.b #$0B				;$0583BF	|
	BEQ LoadLevelDone			;$0583C1	|
	CMP.b #$10				;$0583C3	|
	BEQ LoadLevelDone			;$0583C5	|
	LDY.b #$00				;$0583C7	|
	LDA [$65],Y				;$0583C9	|
	CMP.b #$FF				;$0583CB	|
	BEQ LevLoadNotEmpty			;$0583CD	|
	JSR LoadLevelData			;$0583CF	|
LevLoadNotEmpty:
	SEP #$30
	LDA.w $1925				;$0583D4	|
	BEQ LoadLevelDone			;$0583D7	|
	CMP.b #$0A				;$0583D9	|
	BEQ LoadLevelDone			;$0583DB	|
	CMP.b #$0C				;$0583DD	|
	BEQ LoadLevelDone			;$0583DF	|
	CMP.b #$0D				;$0583E1	|
	BEQ LoadLevelDone			;$0583E3	|
	CMP.b #$0E				;$0583E5	|
	BEQ LoadLevelDone			;$0583E7	|
	CMP.b #$11				;$0583E9	|
	BEQ LoadLevelDone			;$0583EB	|
	CMP.b #$1E				;$0583ED	|
	BEQ LoadLevelDone			;$0583EF	|
	INC.w $1933				;$0583F1	|
	LDA.w $1933				;$0583F4	|
	CMP.b #$02				;$0583F7	|
	BEQ LoadLevelDone			;$0583F9	|
	LDA $68					;$0583FB	|
	CLC					;$0583FD	|
	ADC.b #$05				;$0583FE	|
	STA $65					;$058400	|
	LDA $69					;$058402	|
	ADC.b #$00				;$058404	|
	STA $66					;$058406	|
	LDA $6A					;$058408	|
	STA $67					;$05840A	|
	STZ.w $1928				;$05840C	|
	JMP LoadAgain				;$05840F	|

LoadLevelDone:
	STZ.w $1933
	PLP					;$058415	|
	RTS					;$058416	|

VerticalTable:
	db $00,$00,$80,$01,$81,$02,$82,$03
	db $83,$00,$01,$00,$00,$01,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$80
LevMainScrnTbl:
	db $15,$15,$17,$15,$15,$15,$17,$15
	db $17,$15,$15,$15,$15,$15,$04,$04
	db $15,$17,$15,$15,$15,$15,$15,$15
	db $15,$15,$15,$15,$15,$15,$01,$02
LevSubScrnTbl:
	db $02,$02,$00,$02,$02,$02,$00,$02
	db $00,$00,$02,$00,$02,$02,$13,$13
	db $00,$00,$02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02,$16,$15
LevCGADSUBtable:
	db $24,$24,$24,$24,$24,$24,$20,$24
	db $24,$20,$24,$20,$70,$70,$24,$24
	db $20,$FF,$24,$24,$24,$24,$24,$24
	db $24,$24,$24,$24,$24,$24,$21,$22
SpecialLevTable:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$C0,$00,$80,$00,$00,$00,$00
	db $C1,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
LevXYPPCCCTtbl:
	db $20,$20,$20,$30,$30,$30,$30,$30
	db $30,$30,$30,$30,$30,$30,$20,$20
	db $30,$30,$30,$30,$30,$30,$30,$30
	db $30,$30,$30,$30,$30,$30,$30,$30
TimerTable:
	db $00,$02,$03,$04

LevelMusicTable:
	db $02,$06,$01,$08,$07,$03,$05,$12

CODE_0584E3:
	LDY.b #$00
	LDA [$65],Y				;$0584E5	|
	TAX					;$0584E7	|
	AND.b #$1F				;$0584E8	|
	INC A					;$0584EA	|
	STA $5D					;$0584EB	|
	TXA					;$0584ED	|
	LSR					;$0584EE	|
	LSR					;$0584EF	|
	LSR					;$0584F0	|
	LSR					;$0584F1	|
	LSR					;$0584F2	|
	STA.w $1930				;$0584F3	|
	INY					;$0584F6	|
	LDA [$65],Y				;$0584F7	|
	AND.b #$1F				;$0584F9	|
	STA.w $1925				;$0584FB	|
	TAX					;$0584FE	|
	LDA.l LevXYPPCCCTtbl,X			;$0584FF	|
	STA $64					;$058503	|
	LDA.l LevMainScrnTbl,X			;$058505	|
	STA.w $0D9D				;$058509	|
	LDA.l LevSubScrnTbl,X			;$05850C	|
	STA.w $0D9E				;$058510	|
	LDA.l LevCGADSUBtable,X			;$058513	|
	STA $40					;$058517	|
	LDA.l SpecialLevTable,X			;$058519	|
	STA.w $0D9B				;$05851D	|
	LDA.l VerticalTable,X			;$058520	|
	STA $5B					;$058524	|
	LSR					;$058526	|
	LDA $5D					;$058527	|
	LDX.b #$01				;$058529	|
	BCC LevelModeEven			;$05852B	|
	TAX					;$05852D	|
	LDA.b #$01				;$05852E	|
LevelModeEven:
	STA $5E
	STX $5F					;$058532	|
	LDA [$65],Y				;$058534	|
	LSR					;$058536	|
	LSR					;$058537	|
	LSR					;$058538	|
	LSR					;$058539	|
	LSR					;$05853A	|
	STA.w $192F				;$05853B	|
	INY					;$05853E	|
	LDA [$65],Y				;$05853F	|
	STA $00					;$058541	|
	TAX					;$058543	|
	AND.b #$0F				;$058544	|
	STA.w $192B				;$058546	|
	TXA					;$058549	|
	LSR					;$05854A	|
	LSR					;$05854B	|
	LSR					;$05854C	|
	LSR					;$05854D	|
	AND.b #$07				;$05854E	|
	TAX					;$058550	|
	LDA.l LevelMusicTable,X			;$058551	|
	LDX.w $0DDA				;$058555	|
	BPL CODE_05855C				;$058558	|
	ORA.b #$80				;$05855A	|
CODE_05855C:
	CMP.w $0DDA
	BNE CODE_058563				;$05855F	|
	ORA.b #$40				;$058561	|
CODE_058563:
	STA.w $0DDA
	LDA $00					;$058566	|
	AND.b #$80				;$058568	|
	LSR					;$05856A	|
	LSR					;$05856B	|
	LSR					;$05856C	|
	LSR					;$05856D	|
	ORA.b #$01				;$05856E	|
	STA $3E					;$058570	|
	INY					;$058572	|
	LDA [$65],Y				;$058573	|
	STA $00					;$058575	|
	LSR					;$058577	|
	LSR					;$058578	|
	LSR					;$058579	|
	LSR					;$05857A	|
	LSR					;$05857B	|
	LSR					;$05857C	|
	TAX					;$05857D	|
	LDA.w $141A				;$05857E	|
	BNE CODE_058590				;$058581	|
	LDA.l TimerTable,X			;$058583	|
	STA.w $0F31				;$058587	|
	STZ.w $0F32				;$05858A	|
	STZ.w $0F33				;$05858D	|
CODE_058590:
	LDA $00
	AND.b #$07				;$058592	|
	STA.w $192D				;$058594	|
	LDA $00					;$058597	|
	AND.b #$38				;$058599	|
	LSR					;$05859B	|
	LSR					;$05859C	|
	LSR					;$05859D	|
	STA.w $192E				;$05859E	|
	INY					;$0585A1	|
	LDA [$65],Y				;$0585A2	|
	AND.b #$0F				;$0585A4	|
	STA.w $1931				;$0585A6	|
	STA.w $1932				;$0585A9	|
	LDA [$65],Y				;$0585AC	|
	AND.b #$C0				;$0585AE	|
	ASL					;$0585B0	|
	ROL					;$0585B1	|
	ROL					;$0585B2	|
	STA.w $13BE				;$0585B3	|
	LDA [$65],Y				;$0585B6	|
	AND.b #$30				;$0585B8	|
	LSR					;$0585BA	|
	LSR					;$0585BB	|
	LSR					;$0585BC	|
	LSR					;$0585BD	|
	CMP.b #$03				;$0585BE	|
	BNE HeaderVHscroll			;$0585C0	|
	STZ.w $1411				;$0585C2	|
	LDA.b #$00				;$0585C5	|
HeaderVHscroll:
	STA.w $1412
	LDA $65					;$0585CA	|
	CLC					;$0585CC	|
	ADC.b #$05				;$0585CD	|
	STA $65					;$0585CF	|
	LDA $66					;$0585D1	|
	ADC.b #$00				;$0585D3	|
	STA $66					;$0585D5	|
	RTS					;$0585D7	|

CODE_0585D8:
	LDA $5A
	BNE CODE_0585E2				;$0585DA	|
	LDA $59					;$0585DC	|
	CMP.b #$02				;$0585DE	|
	BCC Return0585FE			;$0585E0	|
CODE_0585E2:
	LDA $0A
	AND.b #$0F				;$0585E4	|
	STA $00					;$0585E6	|
	LDA $0B					;$0585E8	|
	AND.b #$0F				;$0585EA	|
	STA $01					;$0585EC	|
	LDA $0A					;$0585EE	|
	AND.b #$F0				;$0585F0	|
	ORA $01					;$0585F2	|
	STA $0A					;$0585F4	|
	LDA $0B					;$0585F6	|
	AND.b #$F0				;$0585F8	|
	ORA $00					;$0585FA	|
	STA $0B					;$0585FC	|
Return0585FE:
	RTS

LoadLevelData:
	SEP #$30
	LDY.b #$00				;$058601	|
	LDA [$65],Y				;$058603	|
	STA $0A					;$058605	|
	INY					;$058607	|
	LDA [$65],Y				;$058608	|
	STA $0B					;$05860A	|
	INY					;$05860C	|
	LDA [$65],Y				;$05860D	|
	STA $59					;$05860F	|
	INY					;$058611	|
	TYA					;$058612	|
	CLC					;$058613	|
	ADC $65					;$058614	|
	STA $65					;$058616	|
	LDA $66					;$058618	|
	ADC.b #$00				;$05861A	|
	STA $66					;$05861C	|
	LDA $0B					;$05861E	|
	LSR					;$058620	|
	LSR					;$058621	|
	LSR					;$058622	|
	LSR					;$058623	|
	STA $5A					;$058624	|
	LDA $0A					;$058626	|
	AND.b #$60				;$058628	|
	LSR					;$05862A	|
	ORA $5A					;$05862B	|
	STA $5A					;$05862D	|
	LDA $5B					;$05862F	|
	LDY.w $1933				;$058631	|
	BEQ CODE_058637				;$058634	|
	LSR					;$058636	|
CODE_058637:
	AND.b #$01
	BEQ CODE_05863E				;$058639	|
	JSR CODE_0585D8				;$05863B	|
CODE_05863E:
	LDA $0A
	AND.b #$0F				;$058640	|
	ASL					;$058642	|
	ASL					;$058643	|
	ASL					;$058644	|
	ASL					;$058645	|
	STA $57					;$058646	|
	LDA $0B					;$058648	|
	AND.b #$0F				;$05864A	|
	ORA $57					;$05864C	|
	STA $57					;$05864E	|
	REP #$20				;$058650	|
	LDA.w $1933				;$058652	|
	AND.w #$00FF				;$058655	|
	ASL					;$058658	|
	TAX					;$058659	|
	LDA.l LoadBlkPtrs,X			;$05865A	|
	STA $03					;$05865E	|
	LDA.l LoadBlkTable2,X			;$058660	|
	STA $06					;$058664	|
	LDA.w $1925				;$058666	|
	AND.w #$001F				;$058669	|
	ASL					;$05866C	|
	TAY					;$05866D	|
	SEP #$20				;$05866E	|
	LDA.b #$00				;$058670	|
	STA $05					;$058672	|
	STA $08					;$058674	|
	LDA [$03],Y				;$058676	|
	STA $00					;$058678	|
	LDA [$06],Y				;$05867A	|
	STA $0D					;$05867C	|
	INY					;$05867E	|
	LDA [$03],Y				;$05867F	|
	STA $01					;$058681	|
	LDA [$06],Y				;$058683	|
	STA $0E					;$058685	|
	LDA.b #$00				;$058687	|
	STA $02					;$058689	|
	STA $0F					;$05868B	|
	LDA $0A					;$05868D	|
	AND.b #$80				;$05868F	|
	ASL					;$058691	|
	ADC.w $1928				;$058692	|
	STA.w $1928				;$058695	|
	STA.w $1BA1				;$058698	|
	ASL					;$05869B	|
	CLC					;$05869C	|
	ADC.w $1928				;$05869D	|
	TAY					;$0586A0	|
	LDA [$00],Y				;$0586A1	|
	STA $6B					;$0586A3	|
	LDA [$0D],Y				;$0586A5	|
	STA $6E					;$0586A7	|
	INY					;$0586A9	|
	LDA [$00],Y				;$0586AA	|
	STA $6C					;$0586AC	|
	LDA [$0D],Y				;$0586AE	|
	STA $6F					;$0586B0	|
	INY					;$0586B2	|
	LDA [$00],Y				;$0586B3	|
	STA $6D					;$0586B5	|
	LDA [$0D],Y				;$0586B7	|
	STA $70					;$0586B9	|
	LDA $0A					;$0586BB	|
	AND.b #$10				;$0586BD	|
	BEQ LoadNoHiCoord			;$0586BF	|
	INC $6C					;$0586C1	|
	INC $6F					;$0586C3	|
LoadNoHiCoord:
	LDA $5A
	BNE LevLoadJsrNrm			;$0586C7	|
	JSR LevLoadExtObj			;$0586C9	|
	JMP LevLoadContinue			;$0586CC	|

LevLoadJsrNrm:
	JSR LevLoadNrmObj
LevLoadContinue:
	SEP #$20
	REP #$10				;$0586D4	|
	LDY.w #$0000				;$0586D6	|
	LDA [$65],Y				;$0586D9	|
	CMP.b #$FF				;$0586DB	|
	BEQ LevelDataEnd			;$0586DD	|
	JMP LoadLevelData			;$0586DF	|

LevelDataEnd:
	RTS

LevLoadExtObj:
	SEP #$30
	JSL CODE_0DA100				;$0586E5	|
	RTS					;$0586E9	|

LevLoadNrmObj:
	SEP #$30
	JSL CODE_0DA40F				;$0586EC	|
	RTS					;$0586F0	|

CODE_0586F1:
	PHP
	REP #$30				;$0586F2	|
	JSR CODE_05877E				;$0586F4	|
	SEP #$20				;$0586F7	|
	LDA $5B					;$0586F9	|
	AND.b #$01				;$0586FB	|
	BNE CODE_058713				;$0586FD	|
	REP #$20				;$0586FF	|
	LDA $55					;$058701	|
	AND.w #$00FF				;$058703	|
	TAX					;$058706	|
	LDA $1A					;$058707	|
	AND.w #$FFF0				;$058709	|
	CMP $4D,X				;$05870C	|
	BEQ CODE_058737				;$05870E	|
	JMP CODE_058724				;$058710	|

CODE_058713:
	REP #$20
	LDA $55					;$058715	|
	AND.w #$00FF				;$058717	|
	TAX					;$05871A	|
	LDA $1C					;$05871B	|
	AND.w #$FFF0				;$05871D	|
	CMP $4D,X				;$058720	|
	BEQ CODE_058737				;$058722	|
CODE_058724:
	STA $4D,X
	TXA					;$058726	|
	EOR.w #$0002				;$058727	|
	TAX					;$05872A	|
	LDA.w #$FFFF				;$05872B	|
	STA $4D,X				;$05872E	|
	JSL CODE_05881A				;$058730	|
	JMP CODE_058774				;$058734	|

CODE_058737:
	SEP #$20
	LDA $5B					;$058739	|
	AND.b #$02				;$05873B	|
	BNE CODE_058753				;$05873D	|
	REP #$20				;$05873F	|
	LDA $56					;$058741	|
	AND.w #$00FF				;$058743	|
	TAX					;$058746	|
	LDA $1E					;$058747	|
	AND.w #$FFF0				;$058749	|
	CMP $51,X				;$05874C	|
	BEQ CODE_058774				;$05874E	|
	JMP CODE_058764				;$058750	|

CODE_058753:
	REP #$20
	LDA $56					;$058755	|
	AND.w #$00FF				;$058757	|
	TAX					;$05875A	|
	LDA $20					;$05875B	|
	AND.w #$FFF0				;$05875D	|
	CMP $51,X				;$058760	|
	BEQ CODE_058774				;$058762	|
CODE_058764:
	STA $51,X
	TXA					;$058766	|
	EOR.w #$0002				;$058767	|
	TAX					;$05876A	|
	LDA.w #$FFFF				;$05876B	|
	STA $51,X				;$05876E	|
	JSL CODE_058883				;$058770	|
CODE_058774:
	PLP
	RTL					;$058775	|

MAP16AppTable:
	db $B0,$8A,$E0,$84,$F0,$8A,$30,$8B

CODE_05877E:
	PHP
	SEP #$20				;$05877F	|
	LDA $5B					;$058781	|
	AND.b #$01				;$058783	|
	BNE CODE_0587CB				;$058785	|
	REP #$20				;$058787	|
	LDA $1A					;$058789	|
	LSR					;$05878B	|
	LSR					;$05878C	|
	LSR					;$05878D	|
	LSR					;$05878E	|
	TAY					;$05878F	|
	SEC					;$058790	|
	SBC.w #$0008				;$058791	|
	STA $45					;$058794	|
	TYA					;$058796	|
	CLC					;$058797	|
	ADC.w #$0017				;$058798	|
	STA $47					;$05879B	|
	SEP #$30				;$05879D	|
	LDA $55					;$05879F	|
	TAX					;$0587A1	|
	LDA $45,X				;$0587A2	|
	LSR					;$0587A4	|
	LSR					;$0587A5	|
	LSR					;$0587A6	|
	REP #$30				;$0587A7	|
	AND.w #$0006				;$0587A9	|
	TAX					;$0587AC	|
	LDA.w #$0133				;$0587AD	|
	ASL					;$0587B0	|
	TAY					;$0587B1	|
	LDA.w #$0007				;$0587B2	|
	STA $00					;$0587B5	|
	LDA.l MAP16AppTable,X			;$0587B7	|
CODE_0587BB:
	STA.w $0FBE,Y
	INY					;$0587BE	|
	INY					;$0587BF	|
	CLC					;$0587C0	|
	ADC.w #$0008				;$0587C1	|
	DEC $00					;$0587C4	|
	BPL CODE_0587BB				;$0587C6	|
	JMP CODE_0587E1				;$0587C8	|

CODE_0587CB:
	REP #$20
	LDA $1C					;$0587CD	|
	LSR					;$0587CF	|
	LSR					;$0587D0	|
	LSR					;$0587D1	|
	LSR					;$0587D2	|
	TAY					;$0587D3	|
	SEC					;$0587D4	|
	SBC.w #$0008				;$0587D5	|
	STA $45					;$0587D8	|
	TYA					;$0587DA	|
	CLC					;$0587DB	|
	ADC.w #$0017				;$0587DC	|
	STA $47					;$0587DF	|
CODE_0587E1:
	SEP #$20
	LDA $5B					;$0587E3	|
	AND.b #$02				;$0587E5	|
	BNE CODE_058802				;$0587E7	|
	REP #$20				;$0587E9	|
	LDA $1E					;$0587EB	|
	LSR					;$0587ED	|
	LSR					;$0587EE	|
	LSR					;$0587EF	|
	LSR					;$0587F0	|
	TAY					;$0587F1	|
	SEC					;$0587F2	|
	SBC.w #$0008				;$0587F3	|
	STA $49					;$0587F6	|
	TYA					;$0587F8	|
	CLC					;$0587F9	|
	ADC.w #$0017				;$0587FA	|
	STA $4B					;$0587FD	|
	JMP CODE_058818				;$0587FF	|

CODE_058802:
	REP #$20
	LDA $20					;$058804	|
	LSR					;$058806	|
	LSR					;$058807	|
	LSR					;$058808	|
	LSR					;$058809	|
	TAY					;$05880A	|
	SEC					;$05880B	|
	SBC.w #$0008				;$05880C	|
	STA $49					;$05880F	|
	TYA					;$058811	|
	CLC					;$058812	|
	ADC.w #$0017				;$058813	|
	STA $4B					;$058816	|
CODE_058818:
	PLP
	RTS					;$058819	|

CODE_05881A:
	SEP #$30
	LDA.w $1925				;$05881C	|
	JSL ExecutePtrLong			;$05881F	|

PtrsLong058823:
	dl CODE_0589CE
	dl CODE_0589CE
	dl CODE_0589CE
	dl CODE_058A9B
	dl CODE_058A9B
	dl CODE_0589CE
	dl CODE_0589CE
	dl CODE_058A9B
	dl CODE_058A9B
	dl Return058A9A
	dl CODE_058A9B
	dl Return058A9A
	dl CODE_0589CE
	dl CODE_058A9B
	dl CODE_0589CE
	dl CODE_0589CE
	dl Return058A9A
	dl CODE_0589CE
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl CODE_0589CE
	dl CODE_0589CE

CODE_058883:
	SEP #$30
	LDA.w $1925				;$058885	|
	JSL ExecutePtrLong			;$058888	|

PtrsLong05888C:
	dl Return058C70
	dl CODE_058B8D
	dl CODE_058B8D
	dl CODE_058B8D
	dl CODE_058B8D
	dl CODE_058C71
	dl CODE_058C71
	dl CODE_058C71
	dl CODE_058C71
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl CODE_058B8D
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl CODE_058B8D

CODE_0588EC:
	SEP #$30
	LDA.w $1925				;$0588EE	|
	JSL ExecutePtrLong			;$0588F1	|

PtrsLong0588F5:
	dl CODE_0589CE
	dl CODE_0589CE
	dl CODE_0589CE
	dl CODE_058A9B
	dl CODE_058A9B
	dl CODE_0589CE
	dl CODE_0589CE
	dl CODE_058A9B
	dl CODE_058A9B
	dl Return058A9A
	dl CODE_058A9B
	dl Return058A9A
	dl CODE_0589CE
	dl CODE_058A9B
	dl CODE_0589CE
	dl CODE_0589CE
	dl Return058A9A
	dl CODE_0589CE
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl Return058A9A
	dl CODE_0589CE
	dl CODE_0589CE

CODE_058955:
	SEP #$30
	LDA.w $1925				;$058957	|
	JSL ExecutePtrLong			;$05895A	|

PtrsLong05895E:
	dl CODE_058D7A
	dl CODE_058B8D
	dl CODE_058B8D
	dl CODE_058B8D
	dl CODE_058B8D
	dl CODE_058C71
	dl CODE_058C71
	dl CODE_058C71
	dl CODE_058C71
	dl Return058C70
	dl CODE_058D7A
	dl Return058C70
	dl CODE_058D7A
	dl CODE_058D7A
	dl CODE_058D7A
	dl CODE_058B8D
	dl Return058C70
	dl CODE_058D7A
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl Return058C70
	dl CODE_058D7A
	dl CODE_058B8D

DATA_0589BE:
	db $80,$00,$40,$00,$20,$00,$10,$00
	db $08,$00,$04,$00,$02,$00,$01,$00

CODE_0589CE:
	PHP
	REP #$30				;$0589CF	|
	LDA.w $1925				;$0589D1	|
	AND.w #$00FF				;$0589D4	|
	ASL					;$0589D7	|
	TAX					;$0589D8	|
	SEP #$20				;$0589D9	|
	LDA.l Ptrs00BDA8,X			;$0589DB	|
	STA $0A					;$0589DF	|
	LDA.l Ptrs00BDA8+1,X			;$0589E1	|
	STA $0B					;$0589E5	|
	LDA.l Ptrs00BE28,X			;$0589E7	|
	STA $0D					;$0589EB	|
	LDA.l Ptrs00BE28+1,X			;$0589ED	|
	STA $0E					;$0589F1	|
	LDA.b #$00				;$0589F3	|
	STA $0C					;$0589F5	|
	STA $0F					;$0589F7	|
	LDA $55					;$0589F9	|
	TAX					;$0589FB	|
	LDA $45,X				;$0589FC	|
	AND.b #$0F				;$0589FE	|
	ASL					;$058A00	|
	STA.w $1BE5				;$058A01	|
	LDY.w #$0020				;$058A04	|
	LDA $45,X				;$058A07	|
	AND.b #$10				;$058A09	|
	BEQ CODE_058A10				;$058A0B	|
	LDY.w #$0024				;$058A0D	|
CODE_058A10:
	TYA
	STA.w $1BE4				;$058A11	|
	REP #$20				;$058A14	|
	LDA $45,X				;$058A16	|
	AND.w #$01F0				;$058A18	|
	LSR					;$058A1B	|
	LSR					;$058A1C	|
	LSR					;$058A1D	|
	LSR					;$058A1E	|
	STA $00					;$058A1F	|
	ASL					;$058A21	|
	CLC					;$058A22	|
	ADC $00					;$058A23	|
	TAY					;$058A25	|
	LDA [$0A],Y				;$058A26	|
	STA $6B					;$058A28	|
	LDA [$0D],Y				;$058A2A	|
	STA $6E					;$058A2C	|
	SEP #$20				;$058A2E	|
	INY					;$058A30	|
	INY					;$058A31	|
	LDA [$0A],Y				;$058A32	|
	STA $6D					;$058A34	|
	LDA [$0D],Y				;$058A36	|
	STA $70					;$058A38	|
	SEP #$10				;$058A3A	|
	LDY.b #$0D				;$058A3C	|
	LDA.w $1931				;$058A3E	|
	CMP.b #$10				;$058A41	|
	BMI CODE_058A47				;$058A43	|
	LDY.b #$05				;$058A45	|
CODE_058A47:
	STY $0C
	REP #$30				;$058A49	|
	LDA $45,X				;$058A4B	|
	AND.w #$000F				;$058A4D	|
	STA $08					;$058A50	|
	LDX.w #$0000				;$058A52	|
CODE_058A55:
	LDY $08
	LDA [$6B],Y				;$058A57	|
	AND.w #$00FF				;$058A59	|
	STA $00					;$058A5C	|
	LDA [$6E],Y				;$058A5E	|
	STA $01					;$058A60	|
	LDA $00					;$058A62	|
	ASL					;$058A64	|
	TAY					;$058A65	|
	LDA.w $0FBE,Y				;$058A66	|
	STA $0A					;$058A69	|
	LDY.w #$0000				;$058A6B	|
	LDA [$0A],Y				;$058A6E	|
	STA.w $1BE6,X				;$058A70	|
	INY					;$058A73	|
	INY					;$058A74	|
	LDA [$0A],Y				;$058A75	|
	STA.w $1BE8,X				;$058A77	|
	INY					;$058A7A	|
	INY					;$058A7B	|
	LDA [$0A],Y				;$058A7C	|
	STA.w $1C66,X				;$058A7E	|
	INY					;$058A81	|
	INY					;$058A82	|
	LDA [$0A],Y				;$058A83	|
	STA.w $1C68,X				;$058A85	|
	INX					;$058A88	|
	INX					;$058A89	|
	INX					;$058A8A	|
	INX					;$058A8B	|
	LDA $08					;$058A8C	|
	CLC					;$058A8E	|
	ADC.w #$0010				;$058A8F	|
	STA $08					;$058A92	|
	CMP.w #$01B0				;$058A94	|
	BCC CODE_058A55				;$058A97	|
	PLP					;$058A99	|
Return058A9A:
	RTL

CODE_058A9B:
	PHP
	REP #$30				;$058A9C	|
	LDA.w $1925				;$058A9E	|
	AND.w #$00FF				;$058AA1	|
	ASL					;$058AA4	|
	TAX					;$058AA5	|
	SEP #$20				;$058AA6	|
	LDA.l Ptrs00BDA8,X			;$058AA8	|
	STA $0A					;$058AAC	|
	LDA.l Ptrs00BDA8+1,X			;$058AAE	|
	STA $0B					;$058AB2	|
	LDA.l Ptrs00BE28,X			;$058AB4	|
	STA $0D					;$058AB8	|
	LDA.l Ptrs00BE28+1,X			;$058ABA	|
	STA $0E					;$058ABE	|
	LDA.b #$00				;$058AC0	|
	STA $0C					;$058AC2	|
	STA $0F					;$058AC4	|
	LDA $55					;$058AC6	|
	TAX					;$058AC8	|
	LDY.w #$0020				;$058AC9	|
	LDA $45,X				;$058ACC	|
	AND.b #$10				;$058ACE	|
	BEQ CODE_058AD5				;$058AD0	|
	LDY.w #$0028				;$058AD2	|
CODE_058AD5:
	TYA
	STA $00					;$058AD6	|
	LDA $45,X				;$058AD8	|
	LSR					;$058ADA	|
	LSR					;$058ADB	|
	AND.b #$03				;$058ADC	|
	ORA $00					;$058ADE	|
	STA.w $1BE4				;$058AE0	|
	LDA $45,X				;$058AE3	|
	AND.b #$03				;$058AE5	|
	ASL					;$058AE7	|
	ASL					;$058AE8	|
	ASL					;$058AE9	|
	ASL					;$058AEA	|
	ASL					;$058AEB	|
	ASL					;$058AEC	|
	STA.w $1BE5				;$058AED	|
	REP #$20				;$058AF0	|
	LDA $45,X				;$058AF2	|
	AND.w #$01F0				;$058AF4	|
	LSR					;$058AF7	|
	LSR					;$058AF8	|
	LSR					;$058AF9	|
	LSR					;$058AFA	|
	STA $00					;$058AFB	|
	ASL					;$058AFD	|
	CLC					;$058AFE	|
	ADC $00					;$058AFF	|
	TAY					;$058B01	|
	LDA [$0A],Y				;$058B02	|
	STA $6B					;$058B04	|
	LDA [$0D],Y				;$058B06	|
	STA $6E					;$058B08	|
	SEP #$20				;$058B0A	|
	INY					;$058B0C	|
	INY					;$058B0D	|
	LDA [$0A],Y				;$058B0E	|
	STA $6D					;$058B10	|
	LDA [$0D],Y				;$058B12	|
	STA $70					;$058B14	|
	SEP #$10				;$058B16	|
	LDY.b #$0D				;$058B18	|
	LDA.w $1931				;$058B1A	|
	CMP.b #$10				;$058B1D	|
	BMI CODE_058B23				;$058B1F	|
	LDY.b #$05				;$058B21	|
CODE_058B23:
	STY $0C
	REP #$30				;$058B25	|
	LDA $45,X				;$058B27	|
	AND.w #$000F				;$058B29	|
	ASL					;$058B2C	|
	ASL					;$058B2D	|
	ASL					;$058B2E	|
	ASL					;$058B2F	|
	STA $08					;$058B30	|
	LDX.w #$0000				;$058B32	|
CODE_058B35:
	LDY $08
	LDA [$6B],Y				;$058B37	|
	AND.w #$00FF				;$058B39	|
	STA $00					;$058B3C	|
	LDA [$6E],Y				;$058B3E	|
	STA $01					;$058B40	|
	LDA $00					;$058B42	|
	ASL					;$058B44	|
	TAY					;$058B45	|
	LDA.w $0FBE,Y				;$058B46	|
	STA $0A					;$058B49	|
	LDY.w #$0000				;$058B4B	|
	LDA [$0A],Y				;$058B4E	|
	STA.w $1BE6,X				;$058B50	|
	INY					;$058B53	|
	INY					;$058B54	|
	LDA [$0A],Y				;$058B55	|
	STA.w $1C66,X				;$058B57	|
	INX					;$058B5A	|
	INX					;$058B5B	|
	INY					;$058B5C	|
	INY					;$058B5D	|
	LDA [$0A],Y				;$058B5E	|
	STA.w $1BE6,X				;$058B60	|
	INY					;$058B63	|
	INY					;$058B64	|
	LDA [$0A],Y				;$058B65	|
	STA.w $1C66,X				;$058B67	|
	INX					;$058B6A	|
	INX					;$058B6B	|
	LDA $08					;$058B6C	|
	TAY					;$058B6E	|
	CLC					;$058B6F	|
	ADC.w #$0001				;$058B70	|
	STA $08					;$058B73	|
	AND.w #$000F				;$058B75	|
	BNE CODE_058B84				;$058B78	|
	TYA					;$058B7A	|
	AND.w #$FFF0				;$058B7B	|
	CLC					;$058B7E	|
	ADC.w #$0100				;$058B7F	|
	STA $08					;$058B82	|
CODE_058B84:
	LDA $08
	AND.w #$010F				;$058B86	|
	BNE CODE_058B35				;$058B89	|
	PLP					;$058B8B	|
	RTL					;$058B8C	|

CODE_058B8D:
	PHP
	REP #$30				;$058B8E	|
	LDA.w $1925				;$058B90	|
	AND.w #$00FF				;$058B93	|
	ASL					;$058B96	|
	TAX					;$058B97	|
	SEP #$20				;$058B98	|
	LDY.w #$0000				;$058B9A	|
	LDA.w $1931				;$058B9D	|
	CMP.b #$03				;$058BA0	|
	BNE CODE_058BA7				;$058BA2	|
	LDY.w #$1000				;$058BA4	|
CODE_058BA7:
	STY $03
	LDA.l Ptrs00BDE8,X			;$058BA9	|
	STA $0A					;$058BAD	|
	LDA.l Ptrs00BDE8+1,X			;$058BAF	|
	STA $0B					;$058BB3	|
	LDA.l Ptrs00BE68,X			;$058BB5	|
	STA $0D					;$058BB9	|
	LDA.l Ptrs00BE68+1,X			;$058BBB	|
	STA $0E					;$058BBF	|
	LDA.b #$00				;$058BC1	|
	STA $0C					;$058BC3	|
	STA $0F					;$058BC5	|
	LDA $56					;$058BC7	|
	TAX					;$058BC9	|
	LDA $49,X				;$058BCA	|
	AND.b #$0F				;$058BCC	|
	ASL					;$058BCE	|
	STA.w $1CE7				;$058BCF	|
	LDY.w #$0030				;$058BD2	|
	LDA $49,X				;$058BD5	|
	AND.b #$10				;$058BD7	|
	BEQ CODE_058BDE				;$058BD9	|
	LDY.w #$0034				;$058BDB	|
CODE_058BDE:
	TYA
	STA.w $1CE6				;$058BDF	|
	REP #$30				;$058BE2	|
	LDA $49,X				;$058BE4	|
	AND.w #$01F0				;$058BE6	|
	LSR					;$058BE9	|
	LSR					;$058BEA	|
	LSR					;$058BEB	|
	LSR					;$058BEC	|
	STA $00					;$058BED	|
	ASL					;$058BEF	|
	CLC					;$058BF0	|
	ADC $00					;$058BF1	|
	TAY					;$058BF3	|
	LDA [$0A],Y				;$058BF4	|
	STA $6B					;$058BF6	|
	LDA [$0D],Y				;$058BF8	|
	STA $6E					;$058BFA	|
	SEP #$20				;$058BFC	|
	INY					;$058BFE	|
	INY					;$058BFF	|
	LDA [$0A],Y				;$058C00	|
	STA $6D					;$058C02	|
	LDA [$0D],Y				;$058C04	|
	STA $70					;$058C06	|
	SEP #$10				;$058C08	|
	LDY.b #$0D				;$058C0A	|
	LDA.w $1931				;$058C0C	|
	CMP.b #$10				;$058C0F	|
	BMI CODE_058C15				;$058C11	|
	LDY.b #$05				;$058C13	|
CODE_058C15:
	STY $0C
	REP #$30				;$058C17	|
	LDA $49,X				;$058C19	|
	AND.w #$000F				;$058C1B	|
	STA $08					;$058C1E	|
	LDX.w #$0000				;$058C20	|
CODE_058C23:
	LDY $08
	LDA [$6B],Y				;$058C25	|
	AND.w #$00FF				;$058C27	|
	STA $00					;$058C2A	|
	LDA [$6E],Y				;$058C2C	|
	STA $01					;$058C2E	|
	LDA $00					;$058C30	|
	ASL					;$058C32	|
	TAY					;$058C33	|
	LDA.w $0FBE,Y				;$058C34	|
	STA $0A					;$058C37	|
	LDY.w #$0000				;$058C39	|
	LDA [$0A],Y				;$058C3C	|
	ORA $03					;$058C3E	|
	STA.w $1CE8,X				;$058C40	|
	INY					;$058C43	|
	INY					;$058C44	|
	LDA [$0A],Y				;$058C45	|
	ORA $03					;$058C47	|
	STA.w $1CEA,X				;$058C49	|
	INY					;$058C4C	|
	INY					;$058C4D	|
	LDA [$0A],Y				;$058C4E	|
	ORA $03					;$058C50	|
	STA.w $1D68,X				;$058C52	|
	INY					;$058C55	|
	INY					;$058C56	|
	LDA [$0A],Y				;$058C57	|
	ORA $03					;$058C59	|
	STA.w $1D6A,X				;$058C5B	|
	INX					;$058C5E	|
	INX					;$058C5F	|
	INX					;$058C60	|
	INX					;$058C61	|
	LDA $08					;$058C62	|
	CLC					;$058C64	|
	ADC.w #$0010				;$058C65	|
	STA $08					;$058C68	|
	CMP.w #$01B0				;$058C6A	|
	BCC CODE_058C23				;$058C6D	|
	PLP					;$058C6F	|
Return058C70:
	RTL

CODE_058C71:
	PHP
	REP #$30				;$058C72	|
	LDA.w $1925				;$058C74	|
	AND.w #$00FF				;$058C77	|
	ASL					;$058C7A	|
	TAX					;$058C7B	|
	SEP #$20				;$058C7C	|
	LDY.w #$0000				;$058C7E	|
	LDA.w $1931				;$058C81	|
	CMP.b #$03				;$058C84	|
	BNE CODE_058C8B				;$058C86	|
	LDY.w #$1000				;$058C88	|
CODE_058C8B:
	STY $03
	LDA.l Ptrs00BDE8,X			;$058C8D	|
	STA $0A					;$058C91	|
	LDA.l Ptrs00BDE8+1,X			;$058C93	|
	STA $0B					;$058C97	|
	LDA.l Ptrs00BE68,X			;$058C99	|
	STA $0D					;$058C9D	|
	LDA.l Ptrs00BE68+1,X			;$058C9F	|
	STA $0E					;$058CA3	|
	LDA.b #$00				;$058CA5	|
	STA $0C					;$058CA7	|
	STA $0F					;$058CA9	|
	LDA $56					;$058CAB	|
	TAX					;$058CAD	|
	LDY.w #$0030				;$058CAE	|
	LDA $49,X				;$058CB1	|
	AND.b #$10				;$058CB3	|
	BEQ CODE_058CBA				;$058CB5	|
	LDY.w #$0038				;$058CB7	|
CODE_058CBA:
	TYA
	STA $00					;$058CBB	|
	LDA $49,X				;$058CBD	|
	LSR					;$058CBF	|
	LSR					;$058CC0	|
	AND.b #$03				;$058CC1	|
	ORA $00					;$058CC3	|
	STA.w $1CE6				;$058CC5	|
	LDA $49,X				;$058CC8	|
	AND.b #$03				;$058CCA	|
	ASL					;$058CCC	|
	ASL					;$058CCD	|
	ASL					;$058CCE	|
	ASL					;$058CCF	|
	ASL					;$058CD0	|
	ASL					;$058CD1	|
	STA.w $1CE7				;$058CD2	|
	REP #$20				;$058CD5	|
	LDA $49,X				;$058CD7	|
	AND.w #$01F0				;$058CD9	|
	LSR					;$058CDC	|
	LSR					;$058CDD	|
	LSR					;$058CDE	|
	LSR					;$058CDF	|
	STA $00					;$058CE0	|
	ASL					;$058CE2	|
	CLC					;$058CE3	|
	ADC $00					;$058CE4	|
	TAY					;$058CE6	|
	LDA [$0A],Y				;$058CE7	|
	STA $6B					;$058CE9	|
	LDA [$0D],Y				;$058CEB	|
	STA $6E					;$058CED	|
	SEP #$20				;$058CEF	|
	INY					;$058CF1	|
	INY					;$058CF2	|
	LDA [$0A],Y				;$058CF3	|
	STA $6D					;$058CF5	|
	LDA [$0D],Y				;$058CF7	|
	STA $70					;$058CF9	|
	SEP #$10				;$058CFB	|
	LDY.b #$0D				;$058CFD	|
	LDA.w $1931				;$058CFF	|
	CMP.b #$10				;$058D02	|
	BMI CODE_058D08				;$058D04	|
	LDY.b #$05				;$058D06	|
CODE_058D08:
	STY $0C
	REP #$30				;$058D0A	|
	LDA $49,X				;$058D0C	|
	AND.w #$000F				;$058D0E	|
	ASL					;$058D11	|
	ASL					;$058D12	|
	ASL					;$058D13	|
	ASL					;$058D14	|
	STA $08					;$058D15	|
	LDX.w #$0000				;$058D17	|
CODE_058D1A:
	LDY $08
	LDA [$6B],Y				;$058D1C	|
	AND.w #$00FF				;$058D1E	|
	STA $00					;$058D21	|
	LDA [$6E],Y				;$058D23	|
	STA $01					;$058D25	|
	LDA $00					;$058D27	|
	ASL					;$058D29	|
	TAY					;$058D2A	|
	LDA.w $0FBE,Y				;$058D2B	|
	STA $0A					;$058D2E	|
	LDY.w #$0000				;$058D30	|
	LDA [$0A],Y				;$058D33	|
	ORA $03					;$058D35	|
	STA.w $1CE8,X				;$058D37	|
	INY					;$058D3A	|
	INY					;$058D3B	|
	LDA [$0A],Y				;$058D3C	|
	ORA $03					;$058D3E	|
	STA.w $1D68,X				;$058D40	|
	INX					;$058D43	|
	INX					;$058D44	|
	INY					;$058D45	|
	INY					;$058D46	|
	LDA [$0A],Y				;$058D47	|
	ORA $03					;$058D49	|
	STA.w $1CE8,X				;$058D4B	|
	INY					;$058D4E	|
	INY					;$058D4F	|
	LDA [$0A],Y				;$058D50	|
	ORA $03					;$058D52	|
	STA.w $1D68,X				;$058D54	|
	INX					;$058D57	|
	INX					;$058D58	|
	LDA $08					;$058D59	|
	TAY					;$058D5B	|
	CLC					;$058D5C	|
	ADC.w #$0001				;$058D5D	|
	STA $08					;$058D60	|
	AND.w #$000F				;$058D62	|
	BNE CODE_058D71				;$058D65	|
	TYA					;$058D67	|
	AND.w #$FFF0				;$058D68	|
	CLC					;$058D6B	|
	ADC.w #$0100				;$058D6C	|
	STA $08					;$058D6F	|
CODE_058D71:
	LDA $08
	AND.w #$010F				;$058D73	|
	BNE CODE_058D1A				;$058D76	|
	PLP					;$058D78	|
	RTL					;$058D79	|

CODE_058D7A:
	PHP
	SEP #$30				;$058D7B	|
	LDA.w $1928				;$058D7D	|
	AND.b #$0F				;$058D80	|
	ASL					;$058D82	|
	STA.w $1CE7				;$058D83	|
	LDY.b #$30				;$058D86	|
	LDA.w $1928				;$058D88	|
	AND.b #$10				;$058D8B	|
	BEQ CODE_058D91				;$058D8D	|
	LDY.b #$34				;$058D8F	|
CODE_058D91:
	TYA
	STA.w $1CE6				;$058D92	|
	REP #$20				;$058D95	|
	LDA.w #$B900				;$058D97	|
	STA $6B					;$058D9A	|
	LDA.w #$BD00				;$058D9C	|
	STA $6E					;$058D9F	|
	LDA.w #$9100				;$058DA1	|
	STA $0A					;$058DA4	|
	LDA.w $1928				;$058DA6	|
	AND.w #$00F0				;$058DA9	|
	BEQ CODE_058DBE				;$058DAC	|
	LDA $6B					;$058DAE	|
	CLC					;$058DB0	|
	ADC.w #$01B0				;$058DB1	|
	STA $6B					;$058DB4	|
	LDA $6E					;$058DB6	|
	CLC					;$058DB8	|
	ADC.w #$01B0				;$058DB9	|
	STA $6E					;$058DBC	|
CODE_058DBE:
	SEP #$20
	LDA.b #$7E				;$058DC0	|
	STA $6D					;$058DC2	|
	LDA.b #$7E				;$058DC4	|
	STA $70					;$058DC6	|
	LDY.b #$0D				;$058DC8	|
	STY $0C					;$058DCA	|
	REP #$30				;$058DCC	|
	LDA.w $1928				;$058DCE	|
	AND.w #$000F				;$058DD1	|
	STA $08					;$058DD4	|
	LDX.w #$0000				;$058DD6	|
CODE_058DD9:
	LDY $08
	LDA [$6B],Y				;$058DDB	|
	AND.w #$00FF				;$058DDD	|
	STA $00					;$058DE0	|
	LDA [$6E],Y				;$058DE2	|
	STA $01					;$058DE4	|
	LDA $00					;$058DE6	|
	ASL					;$058DE8	|
	ASL					;$058DE9	|
	ASL					;$058DEA	|
	TAY					;$058DEB	|
	LDA [$0A],Y				;$058DEC	|
	STA.w $1CE8,X				;$058DEE	|
	INY					;$058DF1	|
	INY					;$058DF2	|
	LDA [$0A],Y				;$058DF3	|
	STA.w $1CEA,X				;$058DF5	|
	INY					;$058DF8	|
	INY					;$058DF9	|
	LDA [$0A],Y				;$058DFA	|
	STA.w $1D68,X				;$058DFC	|
	INY					;$058DFF	|
	INY					;$058E00	|
	LDA [$0A],Y				;$058E01	|
	STA.w $1D6A,X				;$058E03	|
	INX					;$058E06	|
	INX					;$058E07	|
	INX					;$058E08	|
	INX					;$058E09	|
	LDA $08					;$058E0A	|
	CLC					;$058E0C	|
	ADC.w #$0010				;$058E0D	|
	STA $08					;$058E10	|
	CMP.w #$01B0				;$058E12	|
	BCC CODE_058DD9				;$058E15	|
	PLP					;$058E17	|
	RTL					;$058E18	|

DATA_058E19:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF

Layer3Ptr:
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059294
	dl DATA_059AE0
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_05A221
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_0595DE
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_059A17
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_059087
	dl DATA_059549
	dl DATA_059549
	dl DATA_0595DE
	dl DATA_059549
	dl DATA_059549
	dl DATA_05A221

DATA_059087:
	db $58,$06,$00,$03,$87,$39,$88,$39
	db $58,$12,$00,$03,$87,$39,$88,$39
	db $58,$26,$00,$03,$97,$39,$98,$39
	db $58,$2C,$00,$03,$87,$39,$88,$39
	db $58,$32,$00,$03,$97,$39,$98,$39
	db $58,$38,$00,$03,$87,$39,$88,$39
	db $58,$46,$00,$03,$85,$39,$86,$39
	db $58,$4C,$00,$03,$97,$39,$98,$39
	db $58,$52,$00,$03,$85,$39,$86,$39
	db $58,$58,$00,$03,$97,$39,$98,$39
	db $58,$66,$00,$03,$95,$39,$96,$39
	db $58,$6C,$00,$03,$95,$39,$96,$39
	db $58,$72,$00,$03,$95,$39,$96,$39
	db $58,$78,$00,$03,$95,$39,$96,$39
	db $58,$84,$00,$2F,$80,$3D,$81,$3D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $81,$7D,$80,$7D,$58,$A4,$00,$2F
	db $90,$3D,$91,$3D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$91,$7D,$90,$7D
	db $58,$C4,$80,$13,$83,$3D,$83,$BD
	db $83,$3D,$83,$BD,$83,$3D,$83,$BD
	db $83,$3D,$83,$BD,$83,$3D,$83,$BD
	db $58,$C5,$80,$13,$84,$3D,$84,$BD
	db $84,$3D,$84,$BD,$84,$3D,$84,$BD
	db $84,$3D,$84,$BD,$84,$3D,$84,$BD
	db $58,$C7,$C0,$12,$93,$39,$58,$C8
	db $C0,$12,$94,$39,$58,$C9,$C0,$12
	db $93,$39,$58,$CA,$C0,$12,$94,$39
	db $58,$CB,$C0,$12,$93,$39,$58,$CC
	db $C0,$12,$94,$39,$58,$CD,$C0,$12
	db $93,$39,$58,$CE,$C0,$12,$94,$39
	db $58,$CF,$C0,$12,$93,$39,$58,$D0
	db $C0,$12,$94,$39,$58,$D1,$C0,$12
	db $93,$39,$58,$D2,$C0,$12,$94,$39
	db $58,$D3,$C0,$12,$93,$39,$58,$D4
	db $C0,$12,$94,$39,$58,$D5,$C0,$12
	db $93,$39,$58,$D6,$C0,$12,$94,$39
	db $58,$D7,$C0,$12,$93,$39,$58,$D8
	db $C0,$12,$94,$39,$58,$DA,$80,$13
	db $83,$3D,$83,$BD,$83,$3D,$83,$BD
	db $83,$3D,$83,$BD,$83,$3D,$83,$BD
	db $83,$3D,$83,$BD,$58,$DB,$80,$13
	db $84,$3D,$84,$BD,$84,$3D,$84,$BD
	db $84,$3D,$84,$BD,$84,$3D,$84,$BD
	db $84,$3D,$84,$BD,$5A,$04,$00,$2F
	db $90,$BD,$91,$BD,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$82,$3D,$82,$7D
	db $82,$3D,$82,$7D,$91,$FD,$90,$FD
	db $5A,$24,$00,$2F,$80,$BD,$81,$BD
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $92,$3D,$92,$7D,$92,$3D,$92,$7D
	db $81,$FD,$80,$FD,$FF

DATA_059294:
	db $50,$A8,$00,$1F,$99,$3D,$9A,$3D
	db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D
	db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D
	db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D
	db $FE,$2C,$FE,$2C,$50,$C8,$00,$1F
	db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D
	db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D
	db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD
	db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C
	db $50,$E8,$00,$1F,$9B,$3D,$9C,$3D
	db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD
	db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D
	db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D
	db $FE,$2C,$FE,$2C,$51,$08,$00,$1F
	db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D
	db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD
	db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D
	db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C
	db $51,$28,$00,$1F,$99,$3D,$9A,$3D
	db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D
	db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D
	db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D
	db $FE,$2C,$FE,$2C,$51,$48,$00,$1F
	db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D
	db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D
	db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD
	db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C
	db $51,$68,$00,$1F,$9B,$3D,$9C,$3D
	db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD
	db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D
	db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D
	db $FE,$2C,$FE,$2C,$51,$88,$00,$1F
	db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D
	db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD
	db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D
	db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C
	db $51,$A8,$00,$1F,$99,$3D,$9A,$3D
	db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D
	db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D
	db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D
	db $FE,$2C,$FE,$2C,$51,$C8,$00,$1F
	db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D
	db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D
	db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD
	db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C
	db $51,$E8,$00,$1F,$9B,$3D,$9C,$3D
	db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD
	db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D
	db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D
	db $FE,$2C,$FE,$2C,$52,$08,$00,$1F
	db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D
	db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD
	db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D
	db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C
	db $52,$28,$00,$1F,$99,$3D,$9A,$3D
	db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D
	db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D
	db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D
	db $FE,$2C,$FE,$2C,$52,$48,$00,$1F
	db $8B,$3D,$8C,$3D,$C1,$2D,$C2,$2D
	db $C3,$2D,$B4,$AD,$A3,$2D,$A4,$2D
	db $C7,$2D,$C8,$2D,$B4,$AD,$BA,$AD
	db $D5,$2D,$CC,$2D,$FE,$2C,$FE,$2C
	db $52,$68,$00,$1F,$9B,$3D,$9C,$3D
	db $D1,$2D,$D2,$2D,$D3,$2D,$B7,$AD
	db $D5,$2D,$B4,$2D,$D7,$2D,$C7,$2D
	db $D9,$2D,$D9,$6D,$DB,$2D,$DC,$2D
	db $FE,$2C,$FE,$2C,$52,$88,$00,$1F
	db $89,$3D,$8A,$3D,$A1,$2D,$A2,$2D
	db $A3,$2D,$A4,$2D,$A5,$2D,$B4,$AD
	db $D5,$2D,$C7,$AD,$FD,$2C,$AA,$2D
	db $AB,$2D,$AC,$2D,$FE,$2C,$FE,$2C
	db $52,$A8,$00,$1F,$99,$3D,$9A,$3D
	db $A1,$AD,$B2,$2D,$B3,$2D,$B4,$2D
	db $A5,$AD,$B6,$2D,$B7,$2D,$B8,$2D
	db $B4,$2D,$BA,$2D,$BB,$2D,$BC,$2D
	db $FE,$2C,$FE,$2C,$52,$C7,$00,$23
	db $CD,$2D,$CE,$2D,$CF,$2D,$E1,$2D
	db $E2,$2D,$E3,$2D,$E4,$2D,$E5,$2D
	db $E6,$2D,$E7,$2D,$E8,$2D,$E9,$2D
	db $EA,$2D,$EB,$2D,$EC,$2D,$ED,$2D
	db $EE,$2D,$CD,$6D,$52,$E7,$00,$23
	db $DD,$2D,$DE,$2D,$DF,$2D,$F1,$2D
	db $F2,$2D,$DE,$2D,$DF,$2D,$F1,$2D
	db $F2,$2D,$DE,$2D,$DF,$2D,$F1,$2D
	db $F2,$2D,$DE,$2D,$DF,$2D,$F1,$2D
	db $F2,$2D,$DD,$6D,$FF

DATA_059549:
	db $58,$00,$00,$3F,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$7D,$39,$7E,$39
	db $7D,$39,$7E,$39,$58,$20,$47,$7E
	db $8E,$39,$5C,$00,$00,$3F,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$7D,$39
	db $7E,$39,$7D,$39,$7E,$39,$5C,$20
	db $47,$7E,$8E,$39,$FF

DATA_0595DE:
	db $53,$A0,$00,$03,$FF,$60,$9E,$61
	db $53,$B8,$00,$01,$9E,$21,$53,$B9
	db $40,$0C,$FF,$20,$53,$C0,$00,$03
	db $FF,$60,$9E,$E1,$53,$D8,$00,$01
	db $9E,$A1,$53,$D9,$40,$0C,$FF,$20
	db $53,$E0,$40,$08,$FF,$60,$53,$E5
	db $00,$01,$9E,$61,$53,$EA,$00,$0B
	db $9E,$21,$FF,$20,$FF,$20,$FF,$20
	db $FF,$60,$9E,$61,$53,$FB,$00,$01
	db $9E,$21,$53,$FC,$40,$06,$FF,$20
	db $58,$00,$40,$08,$FF,$60,$58,$05
	db $00,$01,$9E,$E1,$58,$0A,$00,$0B
	db $9E,$A1,$FF,$20,$FF,$20,$FF,$20
	db $FF,$60,$9E,$E1,$58,$1B,$00,$01
	db $9E,$A1,$58,$1C,$40,$06,$FF,$20
	db $58,$60,$80,$0F,$FF,$20,$FF,$20
	db $8F,$61,$8F,$E1,$FF,$20,$FF,$20
	db $FF,$60,$FF,$60,$58,$61,$80,$0F
	db $FF,$20,$FF,$20,$FC,$60,$FC,$60
	db $FF,$20,$FF,$20,$9E,$61,$9E,$E1
	db $58,$62,$00,$03,$FF,$60,$9E,$61
	db $58,$82,$00,$03,$FF,$60,$9E,$E1
	db $58,$E2,$40,$06,$FF,$20,$58,$E6
	db $00,$03,$FF,$60,$9E,$61,$59,$02
	db $40,$06,$FF,$20,$59,$06,$00,$03
	db $FF,$60,$9E,$E1,$58,$6C,$00,$01
	db $9E,$21,$58,$6D,$40,$24,$FF,$20
	db $58,$8C,$00,$01,$9E,$A1,$58,$8D
	db $40,$24,$FF,$20,$58,$B2,$00,$01
	db $9E,$21,$58,$B3,$40,$18,$FF,$20
	db $58,$D2,$00,$01,$9E,$A1,$58,$D3
	db $40,$18,$FF,$20,$58,$FC,$00,$07
	db $FC,$20,$8F,$21,$FF,$20,$FF,$20
	db $59,$1C,$00,$07,$FC,$20,$8F,$A1
	db $FF,$20,$FF,$20,$59,$2E,$00,$0B
	db $9E,$21,$FF,$20,$FF,$20,$FF,$20
	db $FF,$60,$9E,$61,$59,$4E,$00,$0B
	db $9E,$A1,$FF,$20,$FF,$20,$FF,$20
	db $FF,$60,$9E,$E1,$59,$38,$00,$01
	db $9E,$21,$59,$39,$40,$0C,$FF,$20
	db $59,$58,$00,$01,$9E,$A1,$59,$59
	db $40,$0C,$FF,$20,$59,$A4,$00,$01
	db $9E,$21,$59,$A5,$40,$0E,$FF,$20
	db $59,$AD,$00,$05,$FF,$60,$FF,$60
	db $9E,$61,$59,$C4,$00,$01,$9E,$A1
	db $59,$C5,$40,$0E,$FF,$20,$59,$CD
	db $00,$05,$FF,$60,$FF,$60,$9E,$E1
	db $59,$E0,$00,$03,$FF,$60,$9E,$61
	db $5A,$00,$00,$03,$FF,$60,$9E,$E1
	db $59,$E8,$00,$01,$9E,$21,$59,$E9
	db $40,$12,$FF,$20,$59,$F3,$00,$05
	db $FF,$60,$FF,$60,$9E,$61,$5A,$08
	db $00,$01,$9E,$A1,$5A,$09,$40,$12
	db $FF,$20,$5A,$13,$00,$05,$FF,$60
	db $FF,$60,$9E,$E1,$59,$FC,$00,$07
	db $9E,$21,$FF,$20,$FF,$20,$FF,$20
	db $5A,$1C,$00,$07,$9E,$A1,$FF,$20
	db $FF,$20,$FF,$20,$5A,$2E,$00,$03
	db $FC,$20,$8F,$21,$5A,$30,$40,$0C
	db $FF,$20,$5A,$37,$00,$05,$FF,$60
	db $FF,$60,$9E,$61,$5A,$4E,$00,$03
	db $FC,$20,$8F,$A1,$5A,$50,$40,$0C
	db $FF,$20,$5A,$57,$00,$05,$FF,$60
	db $FF,$60,$9E,$E1,$5A,$6C,$00,$0B
	db $9E,$21,$FF,$20,$FF,$20,$FF,$20
	db $FF,$60,$9E,$61,$5A,$8C,$00,$0B
	db $9E,$A1,$FF,$20,$FF,$20,$FF,$20
	db $FF,$60,$9E,$E1,$57,$A0,$00,$03
	db $FF,$60,$9E,$61,$57,$B8,$00,$01
	db $9E,$21,$57,$B9,$40,$0C,$FF,$20
	db $57,$C0,$00,$03,$FF,$60,$9E,$E1
	db $57,$D8,$00,$01,$9E,$A1,$57,$D9
	db $40,$0C,$FF,$20,$57,$E0,$40,$08
	db $FF,$60,$57,$E5,$00,$01,$9E,$61
	db $57,$EA,$00,$0B,$9E,$21,$FF,$20
	db $FF,$20,$FF,$20,$FF,$20,$9E,$61
	db $57,$FB,$00,$01,$9E,$21,$57,$FC
	db $40,$06,$FF,$20,$5C,$00,$40,$08
	db $FF,$60,$5C,$05,$00,$01,$9E,$E1
	db $5C,$0A,$00,$0B,$9E,$A1,$FF,$20
	db $FF,$20,$FF,$20,$FF,$60,$9E,$E1
	db $5C,$1B,$00,$01,$9E,$A1,$5C,$1C
	db $40,$06,$FF,$20,$5C,$60,$80,$0F
	db $FF,$20,$FF,$20,$8F,$61,$8F,$E1
	db $FF,$20,$FF,$20,$FF,$60,$FF,$60
	db $5C,$61,$80,$0F,$FF,$20,$FF,$20
	db $FC,$60,$FC,$60,$FF,$20,$FF,$20
	db $9E,$61,$9E,$E1,$5C,$62,$00,$03
	db $FF,$60,$9E,$61,$5C,$82,$00,$03
	db $FF,$60,$9E,$E1,$5C,$E2,$40,$06
	db $FF,$20,$5C,$E6,$00,$03,$FF,$60
	db $9E,$61,$5D,$02,$40,$06,$FF,$20
	db $5D,$06,$00,$03,$FF,$60,$9E,$E1
	db $5C,$6C,$00,$01,$9E,$21,$5C,$6D
	db $40,$24,$FF,$20,$5C,$8C,$00,$01
	db $9E,$A1,$5C,$8D,$40,$24,$FF,$20
	db $5C,$B2,$00,$01,$9E,$21,$5C,$B3
	db $40,$18,$FF,$20,$5C,$D2,$00,$01
	db $9E,$A1,$5C,$D3,$40,$18,$FF,$20
	db $5C,$FC,$00,$07,$FC,$20,$8F,$21
	db $FF,$20,$FF,$20,$5D,$1C,$00,$07
	db $FC,$20,$8F,$A1,$FF,$20,$FF,$20
	db $5D,$2E,$00,$0B,$9E,$21,$FF,$20
	db $FF,$20,$FF,$20,$FF,$60,$9E,$61
	db $5D,$4E,$00,$0B,$9E,$A1,$FF,$20
	db $FF,$20,$FF,$20,$FF,$60,$9E,$E1
	db $5D,$38,$00,$01,$9E,$21,$5D,$39
	db $40,$0C,$FF,$20,$5D,$58,$00,$01
	db $9E,$A1,$5D,$59,$40,$0C,$FF,$20
	db $5D,$A4,$00,$01,$9E,$21,$5D,$A5
	db $40,$0E,$FF,$20,$5D,$AD,$00,$05
	db $FF,$60,$FF,$60,$9E,$61,$5D,$C4
	db $00,$01,$9E,$A1,$5D,$C5,$40,$0E
	db $FF,$20,$5D,$CD,$00,$05,$FF,$60
	db $FF,$60,$9E,$E1,$5D,$E0,$00,$03
	db $FF,$60,$9E,$61,$5E,$00,$00,$03
	db $FF,$60,$9E,$E1,$5D,$E8,$00,$01
	db $9E,$21,$5D,$E9,$40,$12,$FF,$20
	db $5D,$F3,$00,$05,$FF,$60,$FF,$60
	db $9E,$61,$5E,$08,$00,$01,$9E,$A1
	db $5E,$09,$40,$12,$FF,$20,$5E,$13
	db $00,$05,$FF,$60,$FF,$60,$9E,$E1
	db $5D,$FC,$00,$07,$9E,$21,$FF,$20
	db $FF,$20,$FF,$20,$5E,$1C,$00,$07
	db $9E,$A1,$FF,$20,$FF,$20,$FF,$20
	db $5E,$2E,$00,$03,$FC,$20,$8F,$21
	db $5E,$30,$40,$0C,$FF,$20,$5E,$37
	db $00,$05,$FF,$60,$FF,$60,$9E,$61
	db $5E,$4E,$00,$03,$FC,$20,$8F,$A1
	db $5E,$50,$40,$0C,$FF,$20,$5E,$57
	db $00,$05,$FF,$60,$FF,$60,$9E,$E1
	db $5E,$6C,$00,$0B,$9E,$21,$FF,$20
	db $FF,$20,$FF,$20,$FF,$60,$9E,$61
	db $5E,$8C,$00,$0B,$9E,$A1,$FF,$20
	db $FF,$20,$FF,$20,$FF,$60,$9E,$E1
	db $FF

DATA_059A17:
	db $51,$67,$00,$01,$9F,$39,$51,$93
	db $00,$01,$9F,$29,$51,$D1,$00,$01
	db $9F,$39,$52,$5A,$00,$01,$9F,$39
	db $52,$77,$00,$01,$9F,$29,$52,$79
	db $80,$03,$9F,$29,$9F,$39,$52,$8C
	db $00,$01,$9F,$29,$53,$3D,$00,$01
	db $9F,$39,$55,$67,$00,$01,$9F,$39
	db $55,$93,$00,$01,$9F,$29,$55,$D1
	db $00,$01,$9F,$39,$56,$5A,$00,$01
	db $9F,$39,$56,$77,$00,$01,$9F,$29
	db $56,$79,$80,$03,$9F,$29,$9F,$39
	db $56,$8C,$00,$01,$9F,$29,$57,$3D
	db $00,$01,$9F,$39,$58,$07,$00,$01
	db $9F,$39,$58,$33,$00,$01,$9F,$29
	db $58,$71,$00,$01,$9F,$39,$58,$FA
	db $00,$01,$9F,$39,$59,$17,$00,$01
	db $9F,$29,$59,$19,$80,$03,$9F,$29
	db $9F,$39,$59,$2C,$00,$01,$9F,$29
	db $59,$DD,$00,$01,$9F,$39,$5C,$07
	db $00,$01,$9F,$39,$5C,$33,$00,$01
	db $9F,$29,$5C,$71,$00,$01,$9F,$39
	db $5C,$FA,$00,$01,$9F,$39,$5D,$17
	db $00,$01,$9F,$29,$5D,$19,$80,$03
	db $9F,$29,$9F,$39,$5D,$2C,$00,$01
	db $9F,$29,$5D,$DD,$00,$01,$9F,$39
	db $FF

DATA_059AE0:
	db $58,$03,$00,$03,$80,$01,$81,$01
	db $58,$07,$00,$03,$80,$01,$81,$01
	db $58,$0F,$00,$07,$80,$01,$81,$01
	db $80,$01,$81,$01,$58,$15,$00,$0B
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $80,$01,$81,$01,$58,$20,$00,$0F
	db $80,$01,$81,$01,$86,$15,$87,$15
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $58,$22,$80,$05,$86,$15,$96,$15
	db $90,$15,$58,$23,$80,$05,$87,$15
	db $97,$15,$91,$15,$58,$2C,$80,$05
	db $86,$15,$96,$15,$90,$15,$58,$2D
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $58,$2F,$80,$05,$86,$15,$96,$15
	db $90,$15,$58,$30,$80,$05,$87,$15
	db $97,$15,$91,$15,$58,$32,$80,$05
	db $86,$15,$96,$15,$90,$15,$58,$33
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $58,$36,$00,$03,$80,$01,$81,$01
	db $58,$3A,$00,$03,$80,$01,$81,$01
	db $58,$3C,$80,$05,$86,$15,$96,$15
	db $90,$15,$58,$3D,$80,$05,$87,$15
	db $97,$15,$91,$15,$58,$45,$00,$03
	db $82,$15,$83,$15,$58,$8D,$00,$03
	db $80,$01,$81,$01,$58,$9E,$00,$03
	db $80,$01,$81,$01,$58,$BD,$00,$03
	db $80,$01,$81,$01,$58,$C7,$00,$03
	db $80,$01,$81,$01,$58,$D9,$00,$01
	db $81,$01,$58,$DC,$00,$07,$80,$01
	db $81,$01,$82,$15,$83,$15,$58,$E4
	db $00,$03,$80,$01,$81,$01,$58,$E8
	db $00,$07,$80,$01,$81,$01,$80,$01
	db $81,$01,$58,$F9,$00,$0D,$80,$01
	db $81,$01,$80,$01,$81,$01,$82,$15
	db $83,$15,$82,$15,$59,$02,$80,$05
	db $86,$15,$96,$15,$90,$15,$59,$03
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $59,$05,$00,$0B,$80,$01,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $59,$0C,$80,$05,$86,$15,$96,$15
	db $90,$15,$59,$0D,$80,$05,$87,$15
	db $97,$15,$91,$15,$59,$0F,$80,$05
	db $86,$15,$96,$15,$90,$15,$59,$10
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $59,$12,$80,$05,$86,$15,$96,$15
	db $90,$15,$59,$13,$80,$05,$87,$15
	db $97,$15,$91,$15,$59,$1A,$00,$0B
	db $80,$01,$81,$01,$86,$15,$87,$15
	db $82,$15,$83,$15,$59,$1C,$80,$05
	db $86,$15,$96,$15,$90,$15,$59,$1D
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $59,$24,$00,$0F,$80,$01,$81,$01
	db $82,$15,$83,$15,$82,$15,$83,$15
	db $80,$01,$81,$01,$59,$39,$00,$03
	db $80,$01,$81,$01,$59,$47,$00,$07
	db $80,$01,$81,$01,$82,$15,$83,$15
	db $59,$5A,$00,$0B,$80,$01,$81,$01
	db $90,$15,$91,$15,$80,$01,$81,$01
	db $59,$64,$00,$17,$80,$01,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $80,$01,$81,$01,$59,$87,$00,$03
	db $80,$01,$81,$01,$59,$8B,$00,$07
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $59,$98,$00,$03,$80,$01,$81,$01
	db $59,$A8,$00,$07,$80,$01,$81,$01
	db $82,$15,$83,$15,$59,$B9,$00,$03
	db $80,$01,$81,$01,$59,$C5,$00,$03
	db $80,$01,$81,$01,$59,$C9,$00,$07
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $59,$D6,$00,$0F,$80,$01,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $80,$01,$81,$01,$59,$E2,$80,$05
	db $86,$15,$96,$15,$90,$15,$59,$E3
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $59,$EA,$00,$0B,$80,$01,$81,$01
	db $86,$15,$87,$15,$82,$15,$83,$15
	db $59,$EC,$80,$05,$86,$15,$96,$15
	db $90,$15,$59,$ED,$80,$05,$87,$15
	db $97,$15,$91,$15,$59,$EF,$80,$05
	db $86,$15,$96,$15,$90,$15,$59,$F0
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $59,$F2,$80,$05,$86,$15,$96,$15
	db $90,$15,$59,$F3,$80,$05,$87,$15
	db $97,$15,$91,$15,$59,$F7,$00,$07
	db $82,$15,$83,$15,$82,$15,$83,$15
	db $59,$FC,$80,$05,$86,$15,$96,$15
	db $90,$15,$59,$FD,$80,$05,$87,$15
	db $97,$15,$91,$15,$5A,$14,$00,$0F
	db $80,$01,$81,$01,$82,$15,$83,$15
	db $80,$01,$81,$01,$82,$15,$83,$15
	db $5A,$20,$00,$01,$81,$01,$5A,$27
	db $00,$03,$80,$01,$81,$01,$5A,$35
	db $00,$0B,$80,$01,$81,$01,$80,$01
	db $81,$01,$82,$15,$83,$15,$5A,$40
	db $00,$07,$80,$01,$81,$01,$80,$01
	db $81,$01,$5A,$56,$00,$03,$80,$01
	db $81,$01,$5A,$5A,$00,$03,$80,$01
	db $81,$01,$5A,$60,$00,$09,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $5A,$67,$00,$03,$80,$01,$81,$01
	db $5A,$79,$00,$07,$80,$01,$81,$01
	db $80,$01,$81,$01,$5A,$80,$00,$0B
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $80,$01,$81,$01,$5A,$98,$00,$03
	db $80,$01,$81,$01,$5A,$9C,$00,$03
	db $80,$01,$81,$01,$5A,$A0,$00,$05
	db $83,$15,$80,$01,$81,$01,$5A,$A5
	db $00,$07,$80,$01,$81,$01,$80,$01
	db $81,$01,$5A,$C0,$00,$07,$82,$15
	db $83,$15,$82,$15,$83,$15,$5A,$C6
	db $00,$03,$80,$01,$81,$01,$5A,$CA
	db $00,$03,$80,$01,$81,$01,$5A,$E0
	db $00,$0D,$83,$15,$82,$15,$83,$15
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $5A,$E9,$00,$03,$80,$01,$81,$01
	db $5C,$03,$00,$03,$80,$01,$81,$01
	db $5C,$07,$00,$03,$80,$01,$81,$01
	db $5C,$0F,$00,$07,$80,$01,$81,$01
	db $80,$01,$81,$01,$5C,$15,$00,$0B
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $80,$01,$81,$01,$5C,$20,$00,$0F
	db $80,$01,$81,$01,$86,$15,$87,$15
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $5C,$22,$80,$05,$86,$15,$96,$15
	db $90,$15,$5C,$23,$80,$05,$87,$15
	db $97,$15,$91,$15,$5C,$2C,$80,$05
	db $86,$15,$96,$15,$90,$15,$5C,$2D
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $5C,$2F,$80,$05,$86,$15,$96,$15
	db $90,$15,$5C,$30,$80,$05,$87,$15
	db $97,$15,$91,$15,$5C,$32,$80,$05
	db $86,$15,$96,$15,$90,$15,$5C,$33
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $5C,$36,$00,$03,$80,$01,$81,$01
	db $5C,$3A,$00,$03,$80,$01,$81,$01
	db $5C,$3C,$80,$05,$86,$15,$96,$15
	db $90,$15,$5C,$3D,$80,$05,$87,$15
	db $97,$15,$91,$15,$5C,$45,$00,$03
	db $82,$15,$83,$15,$5C,$8D,$00,$03
	db $80,$01,$81,$01,$5C,$9E,$00,$03
	db $80,$01,$81,$01,$5C,$BD,$00,$03
	db $80,$01,$81,$01,$5C,$C7,$00,$03
	db $80,$01,$81,$01,$5C,$D9,$00,$01
	db $81,$01,$5C,$DC,$00,$07,$80,$01
	db $81,$01,$82,$15,$83,$15,$5C,$E4
	db $00,$03,$80,$01,$81,$01,$5C,$E8
	db $00,$07,$80,$01,$81,$01,$80,$01
	db $81,$01,$5C,$F9,$00,$0D,$80,$01
	db $81,$01,$80,$01,$81,$01,$82,$15
	db $83,$15,$82,$15,$5D,$02,$80,$05
	db $86,$15,$96,$15,$90,$15,$5D,$03
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $5D,$05,$00,$0B,$80,$01,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $5D,$0C,$80,$05,$86,$15,$96,$15
	db $90,$15,$5D,$0D,$80,$05,$87,$15
	db $97,$15,$91,$15,$5D,$0F,$80,$05
	db $86,$15,$96,$15,$90,$15,$5D,$10
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $5D,$12,$80,$05,$86,$15,$96,$15
	db $90,$15,$5D,$13,$80,$05,$87,$15
	db $97,$15,$91,$15,$5D,$1A,$00,$0B
	db $80,$01,$81,$01,$86,$15,$87,$15
	db $82,$15,$83,$15,$5D,$1C,$80,$05
	db $86,$15,$96,$15,$90,$15,$5D,$1D
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $5D,$24,$00,$0F,$80,$01,$81,$01
	db $82,$15,$83,$15,$82,$15,$83,$15
	db $80,$01,$81,$01,$5D,$39,$00,$03
	db $80,$01,$81,$01,$5D,$47,$00,$07
	db $80,$01,$81,$01,$82,$15,$83,$15
	db $5D,$5A,$00,$0B,$80,$01,$81,$01
	db $90,$15,$91,$15,$80,$01,$81,$01
	db $5D,$64,$00,$17,$80,$01,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $80,$01,$81,$01,$5D,$87,$00,$03
	db $80,$01,$81,$01,$5D,$8B,$00,$07
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $5D,$98,$00,$03,$80,$01,$81,$01
	db $5D,$A8,$00,$07,$80,$01,$81,$01
	db $82,$15,$83,$15,$5D,$B9,$00,$03
	db $80,$01,$81,$01,$5D,$C5,$00,$03
	db $80,$01,$81,$01,$5D,$C9,$00,$07
	db $80,$01,$81,$01,$80,$01,$81,$01
	db $5D,$D6,$00,$0F,$80,$01,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $80,$01,$81,$01,$5D,$E2,$80,$05
	db $86,$15,$96,$15,$90,$15,$5D,$E3
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $5D,$EA,$00,$0B,$80,$01,$81,$01
	db $86,$15,$87,$15,$82,$15,$83,$15
	db $5D,$EC,$80,$05,$86,$15,$96,$15
	db $90,$15,$5D,$ED,$80,$05,$87,$15
	db $97,$15,$91,$15,$5D,$EF,$80,$05
	db $86,$15,$96,$15,$90,$15,$5D,$F0
	db $80,$05,$87,$15,$97,$15,$91,$15
	db $5D,$F2,$80,$05,$86,$15,$96,$15
	db $90,$15,$5D,$F3,$80,$05,$87,$15
	db $97,$15,$91,$15,$5D,$F7,$00,$07
	db $82,$15,$83,$15,$82,$15,$83,$15
	db $5D,$FC,$80,$05,$86,$15,$96,$15
	db $90,$15,$5D,$FD,$80,$05,$87,$15
	db $97,$15,$91,$15,$5E,$14,$00,$0F
	db $80,$01,$81,$01,$82,$15,$83,$15
	db $80,$01,$81,$01,$82,$15,$83,$15
	db $5E,$20,$00,$01,$81,$01,$5E,$27
	db $00,$03,$80,$01,$81,$01,$5E,$35
	db $00,$0B,$80,$01,$81,$01,$80,$01
	db $81,$01,$82,$15,$83,$15,$5E,$40
	db $00,$07,$80,$01,$81,$01,$80,$01
	db $81,$01,$5E,$56,$00,$03,$80,$01
	db $81,$01,$5E,$5A,$00,$03,$80,$01
	db $81,$01,$5E,$60,$00,$09,$81,$01
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $5E,$67,$00,$03,$80,$01,$81,$01
	db $5E,$79,$00,$07,$80,$01,$81,$01
	db $80,$01,$81,$01,$5E,$80,$00,$0B
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $80,$01,$81,$01,$5E,$98,$00,$03
	db $80,$01,$81,$01,$5E,$9C,$00,$03
	db $80,$01,$81,$01,$5E,$A0,$00,$05
	db $83,$15,$80,$01,$81,$01,$5E,$A5
	db $00,$07,$80,$01,$81,$01,$80,$01
	db $81,$01,$5E,$C0,$00,$07,$82,$15
	db $83,$15,$82,$15,$83,$15,$5E,$C6
	db $00,$03,$80,$01,$81,$01,$5E,$CA
	db $00,$03,$80,$01,$81,$01,$5E,$E0
	db $00,$0D,$83,$15,$82,$15,$83,$15
	db $82,$15,$83,$15,$80,$01,$81,$01
	db $5E,$E9,$00,$03,$80,$01,$81,$01
	db $FF

DATA_05A221:
	db $53,$DA,$00,$05,$F9,$11,$FA,$11
	db $FB,$11,$53,$FA,$00,$05,$FC,$11
	db $FD,$11,$FE,$11,$58,$3C,$00,$01
	db $DA,$11,$58,$6D,$00,$05,$F9,$11
	db $FA,$11,$FB,$11,$58,$8D,$00,$05
	db $FC,$11,$FD,$11,$FE,$11,$58,$E5
	db $00,$07,$92,$11,$95,$11,$98,$11
	db $AD,$11,$59,$05,$00,$07,$B1,$11
	db $B5,$11,$C4,$51,$B9,$11,$59,$25
	db $00,$07,$BD,$11,$C4,$11,$C4,$51
	db $D8,$11,$59,$45,$00,$0D,$D6,$11
	db $D8,$11,$C9,$11,$CA,$11,$F9,$15
	db $FA,$15,$FB,$15,$59,$65,$00,$0D
	db $C9,$11,$CA,$11,$CB,$11,$DA,$11
	db $FC,$15,$FD,$15,$FE,$15,$59,$85
	db $00,$0D,$CB,$11,$DA,$11,$CB,$11
	db $92,$11,$95,$11,$98,$11,$AD,$11
	db $59,$A4,$00,$0F,$F3,$11,$F4,$11
	db $F5,$11,$FC,$38,$B1,$11,$B5,$11
	db $C4,$51,$B9,$11,$59,$C4,$00,$0F
	db $F6,$11,$F7,$11,$F8,$11,$DA,$05
	db $BD,$11,$C4,$11,$C4,$51,$D8,$11
	db $59,$CF,$00,$05,$F9,$15,$FA,$15
	db $FB,$15,$59,$E3,$00,$1D,$CB,$15
	db $FC,$11,$FD,$11,$FE,$11,$FC,$38
	db $D6,$11,$D8,$11,$C9,$11,$CA,$11
	db $F3,$15,$F4,$15,$F5,$15,$FC,$15
	db $FD,$15,$FE,$15,$5A,$08,$00,$17
	db $C9,$11,$CA,$11,$CB,$11,$DA,$11
	db $F6,$15,$F7,$15,$F8,$15,$F9,$55
	db $FC,$0D,$F3,$15,$F4,$15,$F5,$15
	db $5A,$28,$00,$19,$CB,$11,$DA,$11
	db $CB,$11,$DA,$11,$FD,$15,$FD,$15
	db $FE,$15,$DA,$55,$F9,$15,$F6,$15
	db $F7,$15,$F8,$15,$FB,$15,$5A,$49
	db $00,$17,$DA,$15,$F9,$05,$FA,$05
	db $FB,$05,$FC,$38,$FC,$38,$DA,$15
	db $FE,$15,$FC,$15,$FD,$15,$FE,$15
	db $DA,$55,$5A,$6A,$00,$09,$FC,$05
	db $FD,$05,$FE,$05,$FC,$38,$DA,$05
	db $58,$F6,$00,$05,$F9,$11,$FA,$11
	db $FB,$11,$59,$13,$00,$0B,$F9,$11
	db $FA,$11,$FB,$11,$FC,$11,$FD,$11
	db $FE,$11,$59,$31,$00,$09,$F9,$15
	db $FA,$15,$FB,$15,$FD,$11,$FE,$11
	db $59,$51,$00,$11,$FC,$15,$FD,$15
	db $FE,$15,$F3,$11,$F4,$11,$F5,$11
	db $FC,$11,$FD,$11,$FE,$11,$59,$72
	db $00,$0B,$FC,$15,$F9,$15,$F6,$11
	db $F7,$11,$F8,$11,$DA,$51,$59,$92
	db $00,$0D,$DA,$15,$FE,$15,$FC,$11
	db $FD,$11,$FE,$11,$FC,$11,$DA,$55
	db $57,$DA,$00,$05,$F9,$11,$FA,$11
	db $FB,$11,$57,$FA,$00,$05,$FC,$11
	db $FD,$11,$FE,$11,$5C,$3C,$00,$01
	db $DA,$11,$5C,$6D,$00,$05,$F9,$11
	db $FA,$11,$FB,$11,$5C,$8D,$00,$05
	db $FC,$11,$FD,$11,$FE,$11,$5C,$E5
	db $00,$07,$92,$11,$95,$11,$98,$11
	db $AD,$11,$5D,$05,$00,$07,$B1,$11
	db $B5,$11,$C4,$51,$B9,$11,$5D,$25
	db $00,$07,$BD,$11,$C4,$11,$C4,$51
	db $D8,$11,$5D,$45,$00,$0D,$D6,$11
	db $D8,$11,$C9,$11,$CA,$11,$F9,$51
	db $FA,$51,$FB,$51,$5D,$65,$00,$0D
	db $C9,$11,$CA,$11,$CB,$11,$DA,$11
	db $FC,$51,$FD,$51,$FE,$51,$5D,$85
	db $00,$0D,$CB,$11,$DA,$11,$CB,$11
	db $92,$11,$95,$11,$98,$11,$AD,$11
	db $5D,$A4,$00,$0F,$F3,$11,$F4,$11
	db $F5,$11,$FC,$38,$B1,$11,$B5,$11
	db $C4,$51,$B9,$11,$5D,$C4,$00,$0F
	db $F6,$11,$F7,$11,$F8,$11,$DA,$05
	db $BD,$11,$C4,$11,$C4,$51,$D8,$11
	db $5D,$CF,$00,$05,$F9,$15,$FA,$15
	db $FB,$15,$5D,$E3,$00,$1D,$CB,$15
	db $FC,$11,$FD,$11,$FE,$11,$FC,$38
	db $D6,$11,$D8,$11,$C9,$11,$CA,$11
	db $F3,$15,$F4,$15,$F5,$15,$FC,$15
	db $FD,$15,$FE,$15,$5E,$08,$00,$17
	db $C9,$11,$CA,$11,$CB,$11,$DA,$11
	db $F6,$15,$F7,$15,$F8,$15,$F9,$55
	db $FC,$0D,$F3,$15,$F4,$15,$F5,$15
	db $5E,$28,$00,$19,$CB,$11,$DA,$11
	db $CB,$11,$DA,$11,$FD,$15,$FD,$15
	db $FE,$15,$DA,$55,$F9,$15,$F6,$15
	db $F7,$15,$F8,$15,$FB,$15,$5E,$49
	db $00,$17,$DA,$15,$F9,$05,$FA,$05
	db $FB,$05,$FC,$38,$FC,$38,$DA,$15
	db $FE,$15,$FC,$15,$FD,$15,$FE,$15
	db $DA,$55,$5E,$6A,$00,$09,$FC,$05
	db $FD,$05,$FE,$05,$FC,$38,$DA,$05
	db $5C,$F6,$00,$05,$F9,$11,$FA,$11
	db $FB,$11,$5D,$13,$00,$0B,$F9,$11
	db $FA,$11,$FB,$11,$FC,$11,$FD,$11
	db $FE,$11,$5D,$31,$00,$09,$F9,$15
	db $FA,$15,$FB,$15,$FD,$11,$FE,$11
	db $5D,$51,$00,$11,$FC,$15,$FD,$15
	db $FE,$15,$F3,$11,$F4,$11,$F5,$11
	db $FC,$11,$FD,$11,$FE,$11,$5D,$72
	db $00,$0B,$FC,$15,$F9,$15,$F6,$11
	db $F7,$11,$F8,$11,$DA,$51,$5D,$92
	db $00,$0D,$DA,$15,$FE,$15,$FC,$11
	db $FD,$11,$FE,$11,$FC,$11,$DA,$55
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF

DATA_05A580:
	db $51,$A7,$51,$87,$51,$67,$51,$47
	db $51,$27,$51,$07,$50,$E7,$50,$C7
DATA_05A590:
	db $14,$45,$3F,$08,$00,$29,$AA,$27
	db $26,$84,$95,$A9,$15,$13,$CE,$A7
	db $A4,$25,$A5,$05,$A6,$2A,$28

DATA_05A5A7:
	db $8D,$00,$8D,$00,$8D,$00,$8D,$00
	db $00,$00,$91,$02,$1D,$04,$18,$05
	db $1D,$06,$B7,$08,$B2,$07,$0B,$03
	db $3C,$08,$9D,$09,$9E,$0A,$A0,$04
	db $2C,$0A,$A6,$06,$30,$07,$11,$09
	db $A4,$05,$8F,$03,$09,$01,$0A,$02
	db $91,$01

DATA_05A5D9:
	db $16,$44,$4B,$42,$4E,$4C,$44,$1A
	db $1F,$1F,$1F,$13,$47,$48,$52,$1F
	db $48,$D2,$03,$48,$4D,$4E,$52,$40
	db $54,$51,$1F,$0B,$40,$4D,$43,$1B
	db $1F,$1F,$08,$CD,$53,$47,$48,$52
	db $1F,$52,$53,$51,$40,$4D,$46,$44
	db $1F,$1F,$4B,$40,$4D,$C3,$56,$44
	db $1F,$1F,$1F,$1F,$45,$48,$4D,$43
	db $1F,$1F,$1F,$1F,$53,$47,$40,$D3
	db $0F,$51,$48,$4D,$42,$44,$52,$52
	db $1F,$13,$4E,$40,$43,$52,$53,$4E
	db $4E,$CB,$48,$52,$1F,$1F,$4C,$48
	db $52,$52,$48,$4D,$46,$1F,$40,$46
	db $40,$48,$4D,$9A,$0B,$4E,$4E,$4A
	db $52,$1F,$1F,$4B,$48,$4A,$44,$1F
	db $01,$4E,$56,$52,$44,$D1,$48,$52
	db $1F,$40,$53,$1F,$48,$53,$1F,$40
	db $46,$40,$48,$4D,$9A,$1C,$1F,$12
	db $16,$08,$13,$02,$07,$1F,$0F,$00
	db $0B,$00,$02,$04,$1F,$9C,$13,$47
	db $44,$1F,$1F,$4F,$4E,$56,$44,$51
	db $1F,$1F,$4E,$45,$1F,$53,$47,$C4
	db $52,$56,$48,$53,$42,$47,$1F,$1F
	db $58,$4E,$54,$1F,$1F,$1F,$47,$40
	db $55,$C4,$4F,$54,$52,$47,$44,$43
	db $1F,$1F,$56,$48,$4B,$4B,$1F,$1F
	db $53,$54,$51,$CD,$9F,$1F,$1F,$1F
	db $1F,$1F,$1F,$48,$4D,$53,$4E,$1F
	db $1F,$1F,$1F,$1F,$9B,$18,$4E,$54
	db $51,$1F,$4F,$51,$4E,$46,$51,$44
	db $52,$52,$1F,$56,$48,$4B,$CB,$40
	db $4B,$52,$4E,$1F,$1F,$1F,$41,$44
	db $1F,$1F,$1F,$52,$40,$55,$44,$43
	db $9B,$07,$44,$4B,$4B,$4E,$1A,$1F
	db $1F,$1F,$12,$4E,$51,$51,$58,$1F
	db $08,$5D,$CC,$4D,$4E,$53,$1F,$1F
	db $47,$4E,$4C,$44,$1D,$1F,$1F,$41
	db $54,$53,$1F,$1F,$88,$47,$40,$55
	db $44,$1F,$1F,$1F,$1F,$46,$4E,$4D
	db $44,$1F,$1F,$1F,$1F,$53,$CE,$51
	db $44,$52,$42,$54,$44,$1F,$1F,$4C
	db $58,$1F,$45,$51,$48,$44,$4D,$43
	db $D2,$56,$47,$4E,$1F,$56,$44,$51
	db $44,$1F,$1F,$42,$40,$4F,$53,$54
	db $51,$44,$C3,$41,$58,$1F,$01,$4E
	db $56,$52,$44,$51,$9B,$1F,$1F,$1F
	db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F
	db $1F,$1F,$1F,$1F,$1F,$60,$E1,$1F
	db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F
	db $1C,$1F,$18,$4E,$52,$47,$48,$62
	db $E3,$07,$4E,$4E,$51,$40,$58,$1A
	db $1F,$1F,$13,$47,$40,$4D,$4A,$1F
	db $58,$4E,$D4,$45,$4E,$51,$1F,$51
	db $44,$52,$42,$54,$48,$4D,$46,$1F
	db $1F,$1F,$4C,$44,$9B,$0C,$58,$1F
	db $4D,$40,$4C,$44,$1F,$1F,$48,$52
	db $1F,$18,$4E,$52,$47,$48,$9B,$0E
	db $4D,$1F,$1F,$1F,$4C,$58,$1F,$1F
	db $1F,$56,$40,$58,$1F,$1F,$1F,$53
	db $CE,$51,$44,$52,$42,$54,$44,$1F
	db $4C,$58,$1F,$45,$51,$48,$44,$4D
	db $43,$52,$9D,$01,$4E,$56,$52,$44
	db $51,$1F,$53,$51,$40,$4F,$4F,$44
	db $43,$1F,$1F,$4C,$C4,$48,$4D,$1F
	db $53,$47,$40,$53,$1F,$44,$46,$46
	db $9B,$9F,$08,$53,$1F,$48,$52,$1F
	db $4F,$4E,$52,$52,$48,$41,$4B,$44
	db $1F,$1F,$53,$CE,$45,$48,$4B,$4B
	db $1F,$48,$4D,$1F,$53,$47,$44,$1F
	db $43,$4E,$53,$53,$44,$C3,$4B,$48
	db $4D,$44,$1F,$41,$4B,$4E,$42,$4A
	db $52,$1B,$1F,$1F,$1F,$1F,$13,$CE
	db $45,$48,$4B,$4B,$1F,$48,$4D,$1F
	db $53,$47,$44,$1F,$58,$44,$4B,$4B
	db $4E,$D6,$4E,$4D,$44,$52,$1D,$1F
	db $49,$54,$52,$53,$1F,$46,$4E,$1F
	db $56,$44,$52,$D3,$53,$47,$44,$4D
	db $1F,$4D,$4E,$51,$53,$47,$1F,$1F
	db $53,$4E,$1F,$53,$47,$C4,$53,$4E
	db $4F,$1F,$1F,$1F,$1F,$1F,$4E,$45
	db $1F,$1F,$1F,$1F,$1F,$53,$47,$C4
	db $4C,$4E,$54,$4D,$53,$40,$48,$4D
	db $9B,$1C,$0F,$0E,$08,$0D,$13,$1F
	db $0E,$05,$1F,$00,$03,$15,$08,$02
	db $04,$9C,$18,$4E,$54,$1F,$1F,$42
	db $40,$4D,$1F,$1F,$47,$4E,$4B,$43
	db $1F,$1F,$40,$CD,$44,$57,$53,$51
	db $40,$1F,$48,$53,$44,$4C,$1F,$1F
	db $48,$4D,$1F,$53,$47,$C4,$41,$4E
	db $57,$1F,$40,$53,$1F,$1F,$53,$47
	db $44,$1F,$53,$4E,$4F,$1F,$4E,$C5
	db $53,$47,$44,$1F,$52,$42,$51,$44
	db $44,$4D,$1B,$1F,$1F,$1F,$1F,$1F
	db $13,$CE,$54,$52,$44,$1F,$48,$53
	db $1D,$1F,$1F,$4F,$51,$44,$52,$52
	db $1F,$53,$47,$C4,$12,$04,$0B,$04
	db $02,$13,$1F,$01,$54,$53,$53,$4E
	db $4D,$9B,$9F,$1C,$0F,$0E,$08,$0D
	db $13,$1F,$0E,$05,$1F,$00,$03,$15
	db $08,$02,$04,$9C,$13,$4E,$1F,$1F
	db $1F,$4F,$48,$42,$4A,$1F,$1F,$1F
	db $54,$4F,$1F,$1F,$1F,$C0,$52,$47
	db $44,$4B,$4B,$1D,$1F,$1F,$54,$52
	db $44,$1F,$1F,$53,$47,$44,$1F,$97
	db $4E,$51,$1F,$1F,$18,$1F,$1F,$01
	db $54,$53,$53,$4E,$4D,$1B,$1F,$1F
	db $13,$CE,$53,$47,$51,$4E,$56,$1F
	db $1F,$1F,$1F,$40,$1F,$1F,$1F,$52
	db $47,$44,$4B,$CB,$54,$4F,$56,$40
	db $51,$43,$52,$1D,$1F,$1F,$4B,$4E
	db $4E,$4A,$1F,$1F,$54,$CF,$40,$4D
	db $43,$1F,$4B,$44,$53,$1F,$46,$4E
	db $1F,$4E,$45,$1F,$1F,$53,$47,$C4
	db $41,$54,$53,$53,$4E,$4D,$9B,$13
	db $4E,$1F,$43,$4E,$1F,$40,$1F,$52
	db $4F,$48,$4D,$1F,$49,$54,$4C,$4F
	db $9D,$4F,$51,$44,$52,$52,$1F,$1F
	db $1F,$1F,$53,$47,$44,$1F,$1F,$1F
	db $1F,$1F,$80,$01,$54,$53,$53,$4E
	db $4D,$1B,$1F,$1F,$1F,$1F,$00,$1F
	db $12,$54,$4F,$44,$D1,$0C,$40,$51
	db $48,$4E,$1F,$1F,$1F,$52,$4F,$48
	db $4D,$1F,$1F,$49,$54,$4C,$CF,$42
	db $40,$4D,$1F,$41,$51,$44,$40,$4A
	db $1F,$52,$4E,$4C,$44,$1F,$1F,$4E
	db $C5,$53,$47,$44,$1F,$1F,$1F,$41
	db $4B,$4E,$42,$4A,$52,$1F,$1F,$1F
	db $40,$4D,$C3,$43,$44,$45,$44,$40
	db $53,$1F,$52,$4E,$4C,$44,$1F,$4E
	db $45,$1F,$53,$47,$C4,$53,$4E,$54
	db $46,$47,$44,$51,$1F,$44,$4D,$44
	db $4C,$48,$44,$52,$9B,$1C,$0F,$0E
	db $08,$0D,$13,$1F,$0E,$05,$1F,$00
	db $03,$15,$08,$02,$04,$9C,$13,$47
	db $48,$52,$1F,$1F,$1F,$46,$40,$53
	db $44,$1F,$1F,$4C,$40,$51,$4A,$D2
	db $53,$47,$44,$1F,$4C,$48,$43,$43
	db $4B,$44,$1F,$4E,$45,$1F,$53,$47
	db $48,$D2,$40,$51,$44,$40,$1B,$1F
	db $1F,$1F,$01,$58,$1F,$42,$54,$53
	db $53,$48,$4D,$C6,$53,$47,$44,$1F
	db $53,$40,$4F,$44,$1F,$47,$44,$51
	db $44,$1D,$1F,$58,$4E,$D4,$42,$40
	db $4D,$1F,$42,$4E,$4D,$53,$48,$4D
	db $54,$44,$1F,$1F,$45,$51,$4E,$CC
	db $42,$4B,$4E,$52,$44,$1F,$1F,$1F
	db $53,$4E,$1F,$1F,$1F,$1F,$53,$47
	db $48,$D2,$4F,$4E,$48,$4D,$53,$9B
	db $1C,$0F,$0E,$08,$0D,$13,$1F,$0E
	db $05,$1F,$00,$03,$15,$08,$02,$04
	db $9C,$13,$47,$44,$1F,$41,$48,$46
	db $1F,$42,$4E,$48,$4D,$52,$1F,$1F
	db $40,$51,$C4,$03,$51,$40,$46,$4E
	db $4D,$1F,$02,$4E,$48,$4D,$52,$1B
	db $1F,$1F,$1F,$08,$C5,$58,$4E,$54
	db $1F,$1F,$4F,$48,$42,$4A,$1F,$54
	db $4F,$1F,$1F,$45,$48,$55,$C4,$4E
	db $45,$1F,$1F,$53,$47,$44,$52,$44
	db $1F,$1F,$48,$4D,$1F,$1F,$4E,$4D
	db $C4,$40,$51,$44,$40,$1D,$1F,$1F
	db $58,$4E,$54,$1F,$1F,$46,$44,$53
	db $1F,$40,$CD,$44,$57,$53,$51,$40
	db $1F,$0C,$40,$51,$48,$4E,$9B,$9F
	db $16,$47,$44,$4D,$1F,$58,$4E,$54
	db $1F,$1F,$52,$53,$4E,$4C,$4F,$1F
	db $4E,$CD,$40,$4D,$1F,$44,$4D,$44
	db $4C,$58,$1D,$1F,$1F,$58,$4E,$54
	db $1F,$42,$40,$CD,$49,$54,$4C,$4F
	db $1F,$47,$48,$46,$47,$1F,$1F,$48
	db $45,$1F,$1F,$58,$4E,$D4,$47,$4E
	db $4B,$43,$1F,$1F,$1F,$1F,$53,$47
	db $44,$1F,$1F,$1F,$49,$54,$4C,$CF
	db $41,$54,$53,$53,$4E,$4D,$1B,$1F
	db $1F,$14,$52,$44,$1F,$14,$4F,$1F
	db $4E,$CD,$53,$47,$44,$1F,$02,$4E
	db $4D,$53,$51,$4E,$4B,$1F,$0F,$40
	db $43,$1F,$53,$CE,$49,$54,$4C,$4F
	db $1F,$47,$48,$46,$47,$1F,$1F,$48
	db $4D,$1F,$1F,$53,$47,$C4,$52,$47
	db $40,$4B,$4B,$4E,$56,$1F,$56,$40
	db $53,$44,$51,$9B,$08,$45,$1F,$1F
	db $58,$4E,$54,$1F,$40,$51,$44,$1F
	db $1F,$48,$4D,$1F,$40,$CD,$40,$51
	db $44,$40,$1F,$53,$47,$40,$53,$1F
	db $58,$4E,$54,$1F,$47,$40,$55,$C4
	db $40,$4B,$51,$44,$40,$43,$58,$1F
	db $1F,$1F,$42,$4B,$44,$40,$51,$44
	db $43,$9D,$58,$4E,$54,$1F,$42,$40
	db $4D,$1F,$1F,$51,$44,$53,$54,$51
	db $4D,$1F,$53,$CE,$53,$47,$44,$1F
	db $4C,$40,$4F,$1F,$52,$42,$51,$44
	db $44,$4D,$1F,$1F,$41,$D8,$4F,$51
	db $44,$52,$52,$48,$4D,$46,$1F,$1F
	db $1F,$1F,$12,$13,$00,$11,$13,$9D
	db $53,$47,$44,$4D,$1F,$12,$04,$0B
	db $04,$02,$13,$9B,$9F,$18,$4E,$54
	db $1F,$1F,$1F,$46,$44,$53,$1F,$1F
	db $1F,$1F,$01,$4E,$4D,$54,$D2,$12
	db $53,$40,$51,$52,$1F,$1F,$48,$45
	db $1F,$1F,$58,$4E,$54,$1F,$42,$54
	db $D3,$53,$47,$44,$1F,$1F,$53,$40
	db $4F,$44,$1F,$1F,$40,$53,$1F,$1F
	db $53,$47,$C4,$44,$4D,$43,$1F,$1F
	db $4E,$45,$1F,$44,$40,$42,$47,$1F
	db $40,$51,$44,$40,$9B,$08,$45,$1F
	db $58,$4E,$54,$1F,$42,$4E,$4B,$4B
	db $44,$42,$53,$1F,$64,$6B,$EB,$01
	db $4E,$4D,$54,$52,$1F,$1F,$12,$53
	db $40,$51,$52,$1F,$1F,$1F,$58,$4E
	db $D4,$42,$40,$4D,$1F,$1F,$1F,$4F
	db $4B,$40,$58,$1F,$1F,$40,$1F,$1F
	db $45,$54,$CD,$41,$4E,$4D,$54,$52
	db $1F,$46,$40,$4C,$44,$9B,$0F,$51
	db $44,$52,$52,$1F,$14,$4F,$1F,$1F
	db $1F,$4E,$4D,$1F,$1F,$53,$47,$C4
	db $02,$4E,$4D,$53,$51,$4E,$4B,$1F
	db $0F,$40,$43,$1F,$1F,$56,$47,$48
	db $4B,$C4,$49,$54,$4C,$4F,$48,$4D
	db $46,$1F,$1F,$1F,$40,$4D,$43,$1F
	db $1F,$58,$4E,$D4,$42,$40,$4D,$1F
	db $1F,$42,$4B,$48,$4D,$46,$1F,$1F
	db $53,$4E,$1F,$53,$47,$C4,$45,$44
	db $4D,$42,$44,$1B,$1F,$1F,$1F,$1F
	db $13,$4E,$1F,$46,$4E,$1F,$48,$CD
	db $53,$47,$44,$1F,$1F,$43,$4E,$4E
	db $51,$1F,$1F,$40,$53,$1F,$1F,$53
	db $47,$C4,$44,$4D,$43,$1F,$1F,$4E
	db $45,$1F,$53,$47,$48,$52,$1F,$40
	db $51,$44,$40,$9D,$54,$52,$44,$1F
	db $14,$4F,$1F,$40,$4B,$52,$4E,$9B
	db $1C,$0F,$0E,$08,$0D,$13,$1F,$0E
	db $05,$1F,$00,$03,$15,$08,$02,$04
	db $9C,$0E,$4D,$44,$1F,$1F,$1F,$4E
	db $45,$1F,$1F,$1F,$18,$4E,$52,$47
	db $48,$5D,$D2,$45,$51,$48,$44,$4D
	db $43,$52,$1F,$48,$52,$1F,$53,$51
	db $40,$4F,$4F,$44,$C3,$48,$4D,$1F
	db $1F,$53,$47,$44,$1F,$42,$40,$52
	db $53,$4B,$44,$1F,$1F,$41,$D8,$08
	db $46,$46,$58,$1F,$0A,$4E,$4E,$4F
	db $40,$1B,$1F,$1F,$1F,$1F,$1F,$13
	db $CE,$43,$44,$45,$44,$40,$53,$1F
	db $1F,$47,$48,$4C,$1D,$1F,$1F,$4F
	db $54,$52,$C7,$47,$48,$4C,$1F,$48
	db $4D,$53,$4E,$1F,$1F,$53,$47,$44
	db $1F,$4B,$40,$55,$C0,$4F,$4E,$4E
	db $4B,$9B,$14,$52,$44,$1F,$1F,$0C
	db $40,$51,$48,$4E,$5D,$52,$1F,$1F
	db $42,$40,$4F,$C4,$53,$4E,$1F,$1F
	db $1F,$52,$4E,$40,$51,$1F,$1F,$53
	db $47,$51,$4E,$54,$46,$C7,$53,$47
	db $44,$1F,$40,$48,$51,$1A,$1F,$11
	db $54,$4D,$1F,$45,$40,$52,$53,$9D
	db $49,$54,$4C,$4F,$1D,$1F,$40,$4D
	db $43,$1F,$47,$4E,$4B,$43,$1F,$53
	db $47,$C4,$18,$1F,$01,$54,$53,$53
	db $4E,$4D,$1B,$1F,$1F,$13,$4E,$1F
	db $4A,$44,$44,$CF,$41,$40,$4B,$40
	db $4D,$42,$44,$1D,$1F,$1F,$54,$52
	db $44,$1F,$4B,$44,$45,$D3,$40,$4D
	db $43,$1F,$1F,$51,$48,$46,$47,$53
	db $1F,$1F,$4E,$4D,$1F,$53,$47,$C4
	db $02,$4E,$4D,$53,$51,$4E,$4B,$1F
	db $0F,$40,$43,$9B,$13,$47,$44,$1F
	db $51,$44,$43,$1F,$43,$4E,$53,$1F
	db $1F,$40,$51,$44,$40,$D2,$4E,$4D
	db $1F,$1F,$53,$47,$44,$1F,$1F,$4C
	db $40,$4F,$1F,$1F,$47,$40,$55,$C4
	db $53,$56,$4E,$1F,$1F,$1F,$1F,$1F
	db $1F,$43,$48,$45,$45,$44,$51,$44
	db $4D,$D3,$44,$57,$48,$53,$52,$1B
	db $1F,$1F,$1F,$1F,$1F,$1F,$08,$45
	db $1F,$58,$4E,$D4,$47,$40,$55,$44
	db $1F,$1F,$53,$47,$44,$1F,$53,$48
	db $4C,$44,$1F,$40,$4D,$C3,$52,$4A
	db $48,$4B,$4B,$1D,$1F,$1F,$41,$44
	db $1F,$52,$54,$51,$44,$1F,$53,$CE
	db $4B,$4E,$4E,$4A,$1F,$45,$4E,$51
	db $1F,$53,$47,$44,$4C,$9B,$9F,$13
	db $47,$48,$52,$1F,$1F,$48,$52,$1F
	db $1F,$40,$1F,$1F,$06,$47,$4E,$52
	db $D3,$07,$4E,$54,$52,$44,$1B,$1F
	db $1F,$1F,$1F,$1F,$02,$40,$4D,$1F
	db $58,$4E,$D4,$45,$48,$4D,$43,$1F
	db $1F,$1F,$53,$47,$44,$1F,$1F,$1F
	db $44,$57,$48,$53,$9E,$07,$44,$44
	db $1D,$1F,$1F,$47,$44,$44,$1D,$1F
	db $1F,$47,$44,$44,$1B,$1B,$9B,$03
	db $4E,$4D,$5D,$53,$1F,$46,$44,$53
	db $1F,$4B,$4E,$52,$53,$9A,$9F,$9F
	db $9F,$18,$4E,$54,$1F,$42,$40,$4D
	db $1F,$1F,$52,$4B,$48,$43,$44,$1F
	db $53,$47,$C4,$52,$42,$51,$44,$44
	db $4D,$1F,$1F,$1F,$4B,$44,$45,$53
	db $1F,$1F,$1F,$4E,$D1,$51,$48,$46
	db $47,$53,$1F,$1F,$41,$58,$1F,$4F
	db $51,$44,$52,$52,$48,$4D,$C6,$53
	db $47,$44,$1F,$0B,$1F,$4E,$51,$1F
	db $11,$1F,$01,$54,$53,$53,$4E,$4D
	db $D2,$4E,$4D,$1F,$1F,$1F,$53,$4E
	db $4F,$1F,$1F,$1F,$4E,$45,$1F,$1F
	db $53,$47,$C4,$42,$4E,$4D,$53,$51
	db $4E,$4B,$4B,$44,$51,$1B,$1F,$1F
	db $1F,$1F,$18,$4E,$D4,$4C,$40,$58
	db $1F,$41,$44,$1F,$40,$41,$4B,$44
	db $1F,$53,$4E,$1F,$52,$44,$C4,$45
	db $54,$51,$53,$47,$44,$51,$1F,$40
	db $47,$44,$40,$43,$9B,$13,$47,$44
	db $51,$44,$1F,$1F,$1F,$40,$51,$44
	db $1F,$1F,$1F,$45,$48,$55,$C4,$44
	db $4D,$53,$51,$40,$4D,$42,$44,$52
	db $1F,$1F,$53,$4E,$1F,$1F,$53,$47
	db $C4,$12,$53,$40,$51,$1F,$1F,$1F
	db $16,$4E,$51,$4B,$43,$1F,$1F,$1F
	db $1F,$48,$CD,$03,$48,$4D,$4E,$52
	db $40,$54,$51,$1F,$1F,$1F,$1F,$1F
	db $0B,$40,$4D,$43,$9B,$05,$48,$4D
	db $43,$1F,$1F,$53,$47,$44,$4C,$1F
	db $40,$4B,$4B,$1F,$40,$4D,$C3,$58
	db $4E,$54,$1F,$1F,$1F,$42,$40,$4D
	db $1F,$1F,$1F,$53,$51,$40,$55,$44
	db $CB,$41,$44,$53,$56,$44,$44,$4D
	db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$4C
	db $40,$4D,$D8,$43,$48,$45,$45,$44
	db $51,$44,$4D,$53,$1F,$4F,$4B,$40
	db $42,$44,$52,$9B,$07,$44,$51,$44
	db $1D,$1F,$1F,$1F,$53,$47,$44,$1F
	db $1F,$42,$4E,$48,$4D,$D2,$58,$4E
	db $54,$1F,$1F,$1F,$42,$4E,$4B,$4B
	db $44,$42,$53,$1F,$1F,$1F,$4E,$D1
	db $53,$47,$44,$1F,$53,$48,$4C,$44
	db $1F,$51,$44,$4C,$40,$48,$4D,$48
	db $4D,$C6,$42,$40,$4D,$1F,$1F,$42
	db $47,$40,$4D,$46,$44,$1F,$1F,$1F
	db $58,$4E,$54,$D1,$4F,$51,$4E,$46
	db $51,$44,$52,$52,$1B,$1F,$1F,$02
	db $40,$4D,$1F,$58,$4E,$D4,$45,$48
	db $4D,$43,$1F,$1F,$53,$47,$44,$1F
	db $1F,$52,$4F,$44,$42,$48,$40,$CB
	db $46,$4E,$40,$4B,$9E,$9F,$00,$4C
	db $40,$59,$48,$4D,$46,$1A,$1F,$1F
	db $05,$44,$56,$1F,$47,$40,$55,$C4
	db $4C,$40,$43,$44,$1F,$48,$53,$1F
	db $1F,$53,$47,$48,$52,$1F,$45,$40
	db $51,$9B,$01,$44,$58,$4E,$4D,$43
	db $1F,$1F,$4B,$48,$44,$52,$1F,$1F
	db $1F,$53,$47,$C4,$12,$4F,$44,$42
	db $48,$40,$4B,$1F,$1F,$1F,$1F,$1F
	db $1F,$19,$4E,$4D,$44,$9B,$02,$4E
	db $4C,$4F,$4B,$44,$53,$44,$1F,$1F
	db $48,$53,$1F,$1F,$1F,$40,$4D,$C3
	db $58,$4E,$54,$1F,$42,$40,$4D,$1F
	db $44,$57,$4F,$4B,$4E,$51,$44,$1F
	db $1F,$C0,$52,$53,$51,$40,$4D,$46
	db $44,$1F,$4D,$44,$56,$1F,$56,$4E
	db $51,$4B,$43,$9B,$06,$0E,$0E,$03
	db $1F,$0B,$14,$02,$0A,$9A

DATA_05B0FF:
	db $50,$C7,$41,$E2,$FC,$38,$FF

DATA_05B106:
	db $4C,$50

DATA_05B108:
	db $50,$00

DATA_05B10A:
	db $04,$FC

CODE_05B10C:
	PHB
	PHK					;$05B10D	|
	PLB					;$05B10E	|
	LDX.w $1B88				;$05B10F	|
	LDA.w $1B89				;$05B112	|
	CMP.w DATA_05B108,X			;$05B115	|
	BNE CODE_05B191				;$05B118	|
	TXA					;$05B11A	|
	BEQ CODE_05B132				;$05B11B	|
	STZ.w $1426				;$05B11D	|
	STZ.w $1B88				;$05B120	|
	STZ $41					;$05B123	|
	STZ $42					;$05B125	|
	STZ $43					;$05B127	|
	STZ.w $0D9F				;$05B129	|
	LDA.b #$02				;$05B12C	|
	STA $44					;$05B12E	|
	BRA CODE_05B18E				;$05B130	|

CODE_05B132:
	LDA.w $0109
	ORA.w $13D2				;$05B135	|
	BEQ CODE_05B16E				;$05B138	|
	LDA.w $1DF5				;$05B13A	|
	BEQ CODE_05B16E				;$05B13D	|
	LDA $13					;$05B13F	|
	AND.b #$03				;$05B141	|
	BNE CODE_05B18E				;$05B143	|
	DEC.w $1DF5				;$05B145	|
	BNE CODE_05B18E				;$05B148	|
	LDA.w $13D2				;$05B14A	|
	BEQ CODE_05B16E				;$05B14D	|
	PLB					;$05B14F	|
	INC.w $1DE9				;$05B150	|
	LDA.b #$01				;$05B153	|
	STA.w $13CE				;$05B155	|
	BRA CODE_05B165				;$05B158	|

CODE_05B15A:
	PLB
	LDA.b #$8E				;$05B15B	|
	STA.w $1F19				;$05B15D	|
side_exit_level:
	STZ.w $0109				;$05B160	|
	LDA.b #$00				;$05B163	|
CODE_05B165:
	STA.w $0DD5
	LDA.b #$0B				;$05B168	|
	STA.w $0100				;$05B16A	|
	RTL					;$05B16D	|

CODE_05B16E:
	LDA $15
	AND.b #$F0				;$05B170	|
	BEQ CODE_05B18E				;$05B172	|
	EOR $16					;$05B174	|
	AND.b #$F0				;$05B176	|
	BEQ CODE_05B186				;$05B178	|
	LDA $17					;$05B17A	|
	AND.b #$C0				;$05B17C	|
	BEQ CODE_05B18E				;$05B17E	|
	EOR $18					;$05B180	|
	AND.b #$C0				;$05B182	|
	BNE CODE_05B18E				;$05B184	|
CODE_05B186:
	LDA.w $0109
	BNE CODE_05B15A				;$05B189	|
	INC.w $1B88				;$05B18B	|
CODE_05B18E:
	JMP CODE_05B299

CODE_05B191:
	CMP.w DATA_05B106,X
	BNE CODE_05B1A0				;$05B194	|
	TXA					;$05B196	|
	BEQ CODE_05B1A3				;$05B197	|
	JSR CODE_05B31B				;$05B199	|
	LDA.b #$09				;$05B19C	|
	STA $12					;$05B19E	|
CODE_05B1A0:
	JMP CODE_05B250

CODE_05B1A3:
	LDX.b #$16
CODE_05B1A5:
	LDY.b #$01
	LDA.w DATA_05A590,X			;$05B1A7	|
	BPL CODE_05B1AF				;$05B1AA	|
	INY					;$05B1AC	|
	AND.b #$7F				;$05B1AD	|
CODE_05B1AF:
	CPY.w $1426
	BNE CODE_05B1B9				;$05B1B2	|
	CMP.w $13BF				;$05B1B4	|
	BEQ CODE_05B1BC				;$05B1B7	|
CODE_05B1B9:
	DEX
	BNE CODE_05B1A5				;$05B1BA	|
CODE_05B1BC:
	LDY.w $1426
	CPY.b #$03				;$05B1BF	|
	BNE CODE_05B1C5				;$05B1C1	|
	LDX.b #$18				;$05B1C3	|
CODE_05B1C5:
	CPX.b #$04
	BCS CODE_05B1D1				;$05B1C7	|
	INX					;$05B1C9	|
	STX.w $13D2				;$05B1CA	|
	DEX					;$05B1CD	|
	JSR CODE_05B2EB				;$05B1CE	|
CODE_05B1D1:
	CPX.b #$16
	BNE CODE_05B1DB				;$05B1D3	|
	LDA.w $187A				;$05B1D5	|
	BEQ CODE_05B1DB				;$05B1D8	|
	INX					;$05B1DA	|
CODE_05B1DB:
	TXA
	ASL					;$05B1DC	|
	TAX					;$05B1DD	|
	REP #$20				;$05B1DE	|
	LDA.w DATA_05A5A7,X			;$05B1E0	|
	STA $00					;$05B1E3	|
	REP #$10				;$05B1E5	|
	LDA.l $7F837B				;$05B1E7	|
	TAX					;$05B1EB	|
	LDY.w #$000E				;$05B1EC	|
CODE_05B1EF:
	LDA.w DATA_05A580,Y
	STA.l $7F837D,X				;$05B1F2	|
	LDA.w #$2300				;$05B1F6	|
	STA.l $7F837F,X				;$05B1F9	|
	PHY					;$05B1FD	|
	SEP #$20				;$05B1FE	|
	LDA.b #$12				;$05B200	|
	STA $02					;$05B202	|
	STZ $03					;$05B204	|
	LDY $00					;$05B206	|
CODE_05B208:
	LDA.b #$1F
	BIT.w $0003				;$05B20A	|
	BMI CODE_05B218				;$05B20D	|
	LDA.w DATA_05A5D9,Y			;$05B20F	|
	STA.w $0003				;$05B212	|
	AND.b #$7F				;$05B215	|
	INY					;$05B217	|
CODE_05B218:
	STA.l $7F8381,X
	LDA.b #$39				;$05B21C	|
	STA.l $7F8382,X				;$05B21E	|
	INX					;$05B222	|
	INX					;$05B223	|
	DEC $02					;$05B224	|
	BNE CODE_05B208				;$05B226	|
	STY $00					;$05B228	|
	REP #$20				;$05B22A	|
	INX					;$05B22C	|
	INX					;$05B22D	|
	INX					;$05B22E	|
	INX					;$05B22F	|
	PLY					;$05B230	|
	DEY					;$05B231	|
	DEY					;$05B232	|
	BPL CODE_05B1EF				;$05B233	|
	LDA.w #$00FF				;$05B235	|
	STA.l $7F837D,X				;$05B238	|
	TXA					;$05B23C	|
	STA.l $7F837B				;$05B23D	|
	SEP #$30				;$05B241	|
	LDA.b #$01				;$05B243	|
	STA.w $13D5				;$05B245	|
	STZ $22					;$05B248	|
	STZ $23					;$05B24A	|
	STZ $24					;$05B24C	|
	STZ $25					;$05B24E	|
CODE_05B250:
	LDX.w $1B88
	LDA.w $1B89				;$05B253	|
	CLC					;$05B256	|
	ADC.w DATA_05B10A,X			;$05B257	|
	STA.w $1B89				;$05B25A	|
	CLC					;$05B25D	|
	ADC.b #$80				;$05B25E	|
	XBA					;$05B260	|
	LDA.b #$80				;$05B261	|
	SEC					;$05B263	|
	SBC.w $1B89				;$05B264	|
	REP #$20				;$05B267	|
	LDX.b #$00				;$05B269	|
	LDY.b #$50				;$05B26B	|
CODE_05B26D:
	CPX.w $1B89
	BCC CODE_05B275				;$05B270	|
	LDA.w #$00FF				;$05B272	|
CODE_05B275:
	STA.w $04EC,Y
	STA.w $053C,X				;$05B278	|
	INX					;$05B27B	|
	INX					;$05B27C	|
	DEY					;$05B27D	|
	DEY					;$05B27E	|
	BNE CODE_05B26D				;$05B27F	|
	SEP #$20				;$05B281	|
	LDA.b #$22				;$05B283	|
	STA $41					;$05B285	|
	LDY.w $13D2				;$05B287	|
	BEQ CODE_05B28E				;$05B28A	|
	LDA.b #$20				;$05B28C	|
CODE_05B28E:
	STA $43
	LDA.b #$22				;$05B290	|
	STA $44					;$05B292	|
	LDA.b #$80				;$05B294	|
	STA.w $0D9F				;$05B296	|
CODE_05B299:
	PLB
	RTL					;$05B29A	|

DATA_05B29B:
	db $AD,$35,$AD,$75,$AD,$B5,$AD,$F5
	db $A7,$35,$A7,$75,$B7,$35,$B7,$75
	db $BD,$37,$BD,$77,$BD,$B7,$BD,$F7
	db $A7,$37,$A7,$77,$B7,$37,$B7,$77
	db $AD,$39,$AD,$79,$AD,$B9,$AD,$F9
	db $A7,$39,$A7,$79,$B7,$39,$B7,$79
	db $BD,$3B,$BD,$7B,$BD,$BB,$BD,$FB
	db $A7,$3B,$A7,$7B,$B7,$3B,$B7,$7B
DATA_05B2DB:
	db $50,$4F,$58,$4F,$50,$57,$58,$57
	db $92,$4F,$9A,$4F,$92,$57,$9A,$57

CODE_05B2EB:
	PHX
	TXA					;$05B2EC	|
	ASL					;$05B2ED	|
	ASL					;$05B2EE	|
	ASL					;$05B2EF	|
	ASL					;$05B2F0	|
	TAX					;$05B2F1	|
	STZ $00					;$05B2F2	|
	REP #$20				;$05B2F4	|
	LDY.b #$1C				;$05B2F6	|
CODE_05B2F8:
	LDA.w DATA_05B29B,X
	STA.w $0202,Y				;$05B2FB	|
	PHX					;$05B2FE	|
	LDX $00					;$05B2FF	|
	LDA.w DATA_05B2DB,X			;$05B301	|
	STA.w $0200,Y				;$05B304	|
	PLX					;$05B307	|
	INX					;$05B308	|
	INX					;$05B309	|
	INC $00					;$05B30A	|
	INC $00					;$05B30C	|
	DEY					;$05B30E	|
	DEY					;$05B30F	|
	DEY					;$05B310	|
	DEY					;$05B311	|
	BPL CODE_05B2F8				;$05B312	|
	STZ.w $0400				;$05B314	|
	SEP #$20				;$05B317	|
	PLX					;$05B319	|
	RTS					;$05B31A	|

CODE_05B31B:
	LDY.b #$1C
	LDA.b #$F0				;$05B31D	|
CODE_05B31F:
	STA.w $0201,Y
	DEY					;$05B322	|
	DEY					;$05B323	|
	DEY					;$05B324	|
	DEY					;$05B325	|
	BPL CODE_05B31F				;$05B326	|
	RTS					;$05B328	|

ADDR_05B329:
	PHA
	LDA.b #$01				;$05B32A	|
	STA.w $1DFC				;$05B32C	|
	PLA					;$05B32F	|
CODE_05B330:
	STA $00
	CLC					;$05B332	|
	ADC.w $13CC				;$05B333	|
	STA.w $13CC				;$05B336	|
	LDA.w $0DC0				;$05B339	|
	BEQ Return05B35A			;$05B33C	|
	SEC					;$05B33E	|
	SBC $00					;$05B33F	|
	BPL CODE_05B345				;$05B341	|
	LDA.b #$00				;$05B343	|
CODE_05B345:
	STA.w $0DC0
	BRA Return05B35A			;$05B348	|

CODE_05B34A:
	INC.w $13CC
	LDA.b #$01				;$05B34D	|
	STA.w $1DFC				;$05B34F	|
	LDA.w $0DC0				;$05B352	|
	BEQ Return05B35A			;$05B355	|
	DEC.w $0DC0				;$05B357	|
Return05B35A:
	RTL

level_bit_masks:
	db $80,$40,$20,$10,$08,$04,$02,$01

	TYA					;$05B363	|
	AND.b #$07				;$05B364	|
	PHA					;$05B366	|
	TYA					;$05B367	|
	LSR					;$05B368	|
	LSR					;$05B369	|
	LSR					;$05B36A	|
	TAX					;$05B36B	|
	LDA.w $1F02,X				;$05B36C	|
	PLX					;$05B36F	|
	AND.l level_bit_masks,X			;$05B370	|
	RTL					;$05B374	|

DATA_05B375:
	db $50,$00,$00,$7F,$58,$2C,$59,$2C
	db $55,$2C,$56,$2C,$66,$EC,$65,$EC
	db $57,$2C,$58,$2C,$59,$2C,$57,$2C
	db $58,$2C,$59,$2C,$57,$2C,$58,$2C
	db $59,$2C,$38,$2C,$39,$2C,$66,$EC
	db $65,$EC,$57,$2C,$58,$2C,$59,$2C
	db $57,$2C,$58,$2C,$59,$2C,$57,$2C
	db $58,$2C,$59,$2C,$38,$2C,$39,$2C
	db $56,$6C,$55,$2C,$68,$2C,$69,$2C
	db $65,$2C,$66,$2C,$56,$EC,$55,$AC
	db $67,$2C,$68,$2C,$69,$2C,$67,$2C
	db $68,$2C,$69,$2C,$67,$2C,$68,$2C
	db $69,$2C,$48,$2C,$49,$2C,$56,$EC
	db $55,$AC,$67,$2C,$68,$2C,$69,$2C
	db $67,$2C,$68,$2C,$69,$2C,$67,$2C
	db $68,$2C,$69,$2C,$48,$2C,$49,$2C
	db $66,$6C,$65,$6C,$50,$40,$80,$33
	db $55,$2C,$65,$2C,$38,$2C,$48,$2C
	db $55,$2C,$65,$2C,$38,$2C,$48,$2C
	db $55,$2C,$65,$2C,$38,$2C,$48,$2C
	db $55,$2C,$65,$2C,$38,$2C,$48,$2C
	db $55,$2C,$65,$2C,$38,$2C,$48,$2C
	db $55,$2C,$65,$2C,$38,$2C,$48,$2C
	db $55,$2C,$65,$2C,$50,$41,$80,$33
	db $56,$2C,$66,$2C,$39,$2C,$49,$2C
	db $56,$2C,$66,$2C,$39,$2C,$49,$2C
	db $56,$2C,$66,$2C,$39,$2C,$49,$2C
	db $56,$2C,$66,$2C,$39,$2C,$49,$2C
	db $56,$2C,$66,$2C,$39,$2C,$49,$2C
	db $56,$2C,$66,$2C,$39,$2C,$49,$2C
	db $56,$2C,$66,$2C,$50,$5E,$80,$33
	db $66,$EC,$56,$EC,$39,$6C,$49,$6C
	db $56,$6C,$66,$6C,$39,$6C,$49,$6C
	db $56,$6C,$66,$6C,$39,$6C,$49,$6C
	db $56,$6C,$66,$6C,$39,$6C,$49,$6C
	db $56,$6C,$66,$6C,$39,$6C,$49,$6C
	db $56,$6C,$66,$6C,$39,$6C,$49,$6C
	db $56,$6C,$66,$6C,$50,$5F,$80,$33
	db $65,$EC,$55,$EC,$38,$6C,$48,$6C
	db $55,$6C,$65,$6C,$38,$6C,$48,$6C
	db $55,$6C,$65,$6C,$38,$6C,$48,$6C
	db $55,$6C,$65,$6C,$38,$6C,$48,$6C
	db $55,$6C,$65,$6C,$38,$6C,$48,$6C
	db $55,$6C,$65,$6C,$38,$6C,$48,$6C
	db $55,$6C,$65,$6C,$53,$40,$00,$7F
	db $69,$AC,$67,$AC,$68,$AC,$69,$AC
	db $67,$AC,$68,$AC,$69,$AC,$48,$AC
	db $49,$AC,$56,$6C,$55,$2C,$67,$AC
	db $68,$AC,$69,$AC,$67,$AC,$68,$AC
	db $69,$AC,$67,$AC,$68,$AC,$69,$AC
	db $48,$AC,$49,$AC,$66,$EC,$65,$EC
	db $57,$2C,$58,$2C,$59,$2C,$57,$2C
	db $58,$2C,$57,$2C,$58,$2C,$59,$2C
	db $59,$AC,$57,$AC,$58,$AC,$59,$AC
	db $57,$AC,$58,$AC,$59,$AC,$38,$AC
	db $39,$AC,$66,$6C,$65,$6C,$57,$AC
	db $58,$AC,$59,$AC,$57,$AC,$58,$AC
	db $59,$AC,$57,$AC,$58,$AC,$59,$AC
	db $38,$AC,$39,$AC,$56,$EC,$55,$AC
	db $67,$2C,$68,$2C,$69,$2C,$67,$2C
	db $68,$2C,$67,$2C,$68,$2C,$69,$2C
	db $50,$AA,$00,$13,$98,$3C,$A9,$3C
	db $2F,$38,$AE,$28,$E0,$B8,$2C,$38
	db $4B,$28,$F0,$28,$F1,$28,$98,$68
	db $50,$CA,$00,$15,$4F,$3C,$8A,$3C
	db $8B,$28,$8C,$28,$8D,$38,$35,$38
	db $45,$28,$2A,$28,$2B,$28,$60,$28
	db $A2,$28,$50,$EA,$00,$15,$99,$3C
	db $9A,$3C,$9B,$28,$9C,$28,$9D,$38
	db $9E,$38,$9F,$28,$5A,$28,$5B,$28
	db $90,$28,$A0,$28,$51,$0A,$00,$13
	db $5C,$28,$5C,$68,$71,$28,$71,$68
	db $5C,$28,$72,$28,$73,$28,$71,$68
	db $75,$28,$89,$28,$51,$3B,$00,$03
	db $7B,$39,$7C,$39,$51,$23,$00,$2F
	db $B0,$28,$B1,$28,$B2,$28,$B3,$28
	db $B4,$28,$B5,$38,$F5,$38,$2C,$38
	db $AC,$3C,$F2,$3C,$F3,$3C,$F4,$3C
	db $E0,$B8,$3C,$38,$FB,$38,$74,$38
	db $F3,$28,$F8,$28,$F5,$3C,$2C,$3C
	db $AC,$3C,$B5,$3C,$F5,$3C,$98,$68
	db $51,$43,$00,$31,$6A,$28,$6B,$28
	db $6C,$28,$6D,$28,$6E,$28,$6F,$38
	db $C6,$38,$C7,$38,$D8,$3C,$C9,$3C
	db $CA,$3C,$CB,$3C,$D0,$B8,$CD,$38
	db $CE,$38,$CF,$38,$CA,$28,$A1,$28
	db $C6,$3C,$C7,$3C,$D8,$3C,$A5,$3C
	db $A3,$3C,$B6,$3C,$C8,$28,$51,$63
	db $00,$31,$D0,$3C,$D1,$28,$D2,$28
	db $D3,$28,$61,$28,$62,$38,$63,$38
	db $D7,$38,$D8,$3C,$D9,$3C,$DA,$3C
	db $DB,$3C,$DC,$38,$DD,$38,$DE,$38
	db $DF,$38,$DA,$28,$29,$28,$63,$3C
	db $D7,$3C,$D8,$3C,$2D,$3C,$4C,$3C
	db $4D,$3C,$CC,$28,$51,$83,$00,$31
	db $E0,$3C,$E1,$28,$E2,$28,$E3,$28
	db $E4,$28,$E5,$38,$E6,$38,$E7,$38
	db $E8,$3C,$E9,$3C,$EA,$3C,$EB,$3C
	db $EC,$38,$ED,$38,$EE,$38,$EF,$38
	db $EA,$28,$F7,$28,$E6,$3C,$E7,$3C
	db $E8,$3C,$5D,$3C,$5E,$3C,$5F,$3C
	db $FA,$28,$51,$A3,$00,$2F,$5C,$28
	db $A4,$28,$FC,$28,$FC,$28,$A6,$38
	db $75,$28,$A7,$28,$A8,$38,$FC,$28
	db $FC,$28,$FC,$28,$FC,$28,$AA,$38
	db $5C,$68,$AB,$38,$71,$68,$FC,$28
	db $FC,$28,$A7,$28,$A8,$38,$FC,$28
	db $AD,$3C,$A7,$28,$AF,$3C,$53,$07
	db $00,$25,$F6,$38,$FC,$28,$36,$38
	db $37,$38,$37,$38,$54,$38,$20,$39
	db $36,$38,$37,$38,$37,$38,$36,$38
	db $FC,$28,$46,$38,$47,$38,$AE,$39
	db $AF,$39,$C5

B5L3TMAP1:
	db $39,$C6,$39,$BF,$39,$FF

DATA_05B6FE:
	db $51,$E5,$40,$2E,$FC,$38,$52,$08
	db $40,$1C,$FC,$38,$52,$25,$40,$2E
	db $FC,$38,$52,$48,$40,$1C,$FC,$38
	db $52,$65,$40,$2E,$FC,$38,$52,$A5
	db $40,$1C,$FC,$38,$51,$ED,$00,$1F
	db $76,$31,$71,$31,$74,$31,$82,$30
	db $83,$30,$FC,$38,$71,$31,$FC,$38
	db $24,$38,$24,$38,$24,$38,$73,$31
	db $76,$31,$6F,$31,$2F,$31,$72,$31
	db $52,$2D,$00,$1F,$76,$31,$71,$31
	db $74,$31,$82,$30,$83,$30,$FC,$38
	db $2C,$31,$FC,$38,$24,$38,$24,$38
	db $24,$38,$73,$31,$76,$31,$6F,$31
	db $2F,$31,$72,$31,$52,$6D,$00,$1F
	db $76,$31,$71,$31,$74,$31,$82,$30
	db $83,$30,$FC,$38,$2D,$31,$FC,$38
	db $24,$38,$24,$38,$24,$38,$73,$31
	db $76,$31,$6F,$31,$2F,$31,$72,$31
	db $51,$E7,$00,$0B,$73,$31,$74,$31
	db $71,$31,$31,$31,$73,$31,$FC,$38
	db $52,$27,$00,$0B,$73,$31,$74,$31
	db $71,$31,$31,$31,$73,$31,$FC,$38
	db $52,$67,$00,$0B,$73,$31,$74,$31
	db $71,$31,$31,$31,$73,$31,$FC,$38
	db $52,$A7,$00,$05,$73,$31,$79,$30
	db $7C,$30,$FF,$51,$E5,$40,$2E,$FC
	db $38,$52,$08,$40,$1C,$FC,$38,$52
	db $25,$40,$2E,$FC,$38,$52,$48,$40
	db $1C,$FC,$38,$52,$65,$40,$2E,$FC
	db $38,$52,$A5,$40,$1C,$FC,$38,$51
	db $EA,$00,$1F,$76,$31,$71,$31,$74
	db $31,$82,$30,$83,$30,$FC,$38,$71
	db $31,$FC,$38,$24,$38,$24,$38,$24
	db $38,$73,$31,$76,$31,$6F,$31,$2F
	db $31,$72,$31,$52,$2A,$00,$1F,$76
	db $31,$71,$31,$74,$31,$82,$30,$83
	db $30,$FC,$38,$2C,$31,$FC,$38,$24
	db $38,$24,$38,$24,$38,$73,$31,$76
	db $31,$6F,$31,$2F,$31,$72,$31,$52
	db $6A,$00,$1F,$76,$31,$71,$31,$74
	db $31,$82,$30,$83,$30,$FC,$38,$2D
	db $31,$FC,$38,$24,$38,$24,$38,$24
	db $38,$73,$31,$76,$31,$6F,$31,$2F
	db $31,$72,$31,$52,$AA,$00,$13,$73
	db $31,$74,$31,$71,$31,$31,$31,$73
	db $31,$FC,$38,$7C,$30,$71,$31,$2F
	db $31,$71,$31,$FF

DATA_05B872:
	db $51,$E5,$40,$2F,$FC,$38,$52,$25
	db $40,$2F,$FC,$38,$52,$65,$40,$2F
	db $FC,$38,$52,$A5,$40,$1C,$FC,$38
	db $52,$0A,$00,$19,$6D,$31,$FC,$38
	db $6F,$31,$70,$31,$71,$31,$72,$31
	db $73,$31,$74,$31,$FC,$38,$75,$31
	db $71,$31,$76,$31,$73,$31,$52,$4A
	db $00,$19,$6E,$31,$FC,$38,$6F,$31
	db $70,$31,$71,$31,$72,$31,$73,$31
	db $74,$31,$FC,$38,$75,$31,$71,$31
	db $76,$31,$73,$31,$FF

DATA_05B8C7:
	db $51,$C6,$00,$21,$2D,$39,$7A,$38
	db $79,$38,$2F,$39,$82,$38,$79,$38
	db $7B,$38,$73,$39,$FC,$38,$71,$39
	db $79,$38,$7C,$38,$FC,$38,$31,$39
	db $71,$39,$80,$38,$73,$39,$52,$06
	db $00,$29,$2D,$39,$7A,$38,$79,$38
	db $2F,$39,$82,$38,$79,$38,$7B,$38
	db $73,$39,$FC,$38,$81,$38,$82,$38
	db $2F,$39,$84,$38,$7A,$38,$7B,$38
	db $2F,$39,$FC,$38,$31,$39,$71,$39
	db $80,$38,$73,$39,$FF

DATA_05B91C:
	db $51,$CD,$00,$0F,$2D,$39,$7A,$38
	db $79,$38,$2F,$39,$82,$38,$79,$38
	db $7B,$38,$73,$39,$52,$0D,$00,$05
	db $73,$39,$79,$38,$7C,$38,$FF

DATA_05B93B:
	db $00,$06

DATA_05B93D:
	db $40,$06

DATA_05B93F:
	db $80,$06,$40,$07,$A0,$0E,$00,$08
	db $00,$05,$40,$05,$80,$05,$C0,$05
	db $80,$07,$C0,$07,$A0,$0D,$C0,$06
	db $00,$07,$C0,$04,$40,$04,$80,$04
	db $00,$04,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00

DATA_05B96B:
	db $00,$00,$00,$00,$00,$00,$01,$01
	db $01,$01,$01,$01,$01,$01,$02,$02
	db $02,$02

DATA_05B97D:
	db $02,$00,$00,$00,$00,$00,$00,$00
	db $00,$01,$00,$02,$02,$00

DATA_05B98B:
	db $00,$05,$0A,$0F,$14,$14,$19,$14
	db $0A,$14,$00,$05,$00,$14

AnimatedTileData:
	db $00,$95,$00,$97,$00,$99,$00,$9B
	db $80,$95,$80,$97,$80,$99,$80,$9B
	db $00,$96,$00,$96,$00,$96,$00,$96
	db $80,$9D,$80,$9F,$80,$A1,$80,$A3
	db $00,$96,$00,$98,$00,$9A,$00,$9C
	db $80,$6D,$80,$6F,$00,$7C,$80,$7C
	db $20,$AC,$20,$AC,$20,$AC,$20,$AC
	db $20,$AC,$20,$AC,$20,$AC,$20,$AC
	db $80,$93,$80,$93,$80,$93,$80,$93
	db $00,$A4,$80,$A4,$00,$A4,$80,$A4
	db $20,$AC,$20,$AC,$20,$AC,$20,$AC
	db $00,$AC,$00,$AC,$00,$AC,$00,$AC
	db $00,$91,$00,$91,$00,$91,$00,$91
	db $80,$96,$80,$98,$80,$9A,$80,$9C
	db $00,$9D,$00,$9F,$00,$A1,$00,$A3
	db $80,$8E,$80,$90,$80,$92,$80,$94
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $00,$9D,$00,$9F,$00,$A1,$00,$A3
DATA_05BA39:
	db $80,$8E,$80,$90,$80,$92,$80,$94
	db $00,$7D,$00,$7F,$00,$81,$00,$83
	db $00,$83,$00,$81,$00,$7F,$00,$7D
	db $00,$9E,$00,$A0,$00,$A2,$00,$A0
	db $00,$9D,$00,$9F,$00,$A1,$00,$A3
	db $00,$A5,$00,$A7,$00,$A9,$00,$AB
	db $80,$A5,$80,$A7,$80,$A9,$80,$AB
	db $80,$AB,$80,$A9,$80,$A7,$80,$A5
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $80,$9E,$80,$A0,$80,$A2,$80,$A0
	db $80,$7D,$80,$7F,$80,$81,$80,$83
	db $00,$7E,$00,$80,$00,$82,$00,$84
	db $80,$7E,$80,$80,$80,$82,$80,$84
	db $80,$83,$80,$81,$80,$7F,$80,$7D
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $80,$A6,$80,$A8,$80,$AA,$80,$A8
	db $00,$8E,$00,$90,$00,$92,$00,$94
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $80,$9E,$80,$A0,$80,$A2,$80,$A0
	db $00,$A6,$00,$A8,$00,$AA,$00,$A8
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $00,$95,$00,$95,$00,$95,$00,$95
	db $80,$91,$80,$91,$80,$91,$80,$91
	db $80,$96,$80,$98,$80,$9A,$80,$9C
	db $80,$96,$80,$98,$80,$9A,$80,$9C
	db $80,$96,$80,$98,$80,$9A,$80,$9C
	db $00,$95,$00,$97,$00,$99,$00,$9B
	db $80,$AC,$80,$AC,$80,$AC,$80,$AC
	db $00,$93,$00,$93,$00,$93,$00,$93
	db $80,$93,$80,$93,$80,$93,$80,$93

CODE_05BB39:
	PHB
	PHK					;$05BB3A	|
	PLB					;$05BB3B	|
	LDA $14					;$05BB3C	|
	AND.b #$07				;$05BB3E	|
	STA $00					;$05BB40	|
	ASL					;$05BB42	|
	ADC $00					;$05BB43	|
	TAY					;$05BB45	|
	ASL					;$05BB46	|
	TAX					;$05BB47	|
	REP #$20				;$05BB48	|
	LDA $14					;$05BB4A	|
	AND.w #$0018				;$05BB4C	|
	LSR					;$05BB4F	|
	LSR					;$05BB50	|
	STA $00					;$05BB51	|
	LDA.w DATA_05B93B,X			;$05BB53	|
	STA.w $0D80				;$05BB56	|
	LDA.w DATA_05B93D,X			;$05BB59	|
	STA.w $0D7E				;$05BB5C	|
	LDA.w DATA_05B93F,X			;$05BB5F	|
	STA.w $0D7C				;$05BB62	|
	LDX.b #$04				;$05BB65	|
CODE_05BB67:
	PHY
	PHX					;$05BB68	|
	SEP #$20				;$05BB69	|
	TYA					;$05BB6B	|
	LDX.w DATA_05B96B,Y			;$05BB6C	|
	BEQ CODE_05BB88				;$05BB6F	|
	DEX					;$05BB71	|
	BNE CODE_05BB81				;$05BB72	|
	LDX.w DATA_05B97D,Y			;$05BB74	|
	LDY.w $14AD,X				;$05BB77	|
	BEQ CODE_05BB88				;$05BB7A	|
	CLC					;$05BB7C	|
	ADC.b #$26				;$05BB7D	|
	BRA CODE_05BB88				;$05BB7F	|

CODE_05BB81:
	LDY.w $1931
	CLC					;$05BB84	|
	ADC.w DATA_05B98B,Y			;$05BB85	|
CODE_05BB88:
	REP #$30
	AND.w #$00FF				;$05BB8A	|
	ASL					;$05BB8D	|
	ASL					;$05BB8E	|
	ASL					;$05BB8F	|
	ORA $00					;$05BB90	|
	TAY					;$05BB92	|
	LDA.w AnimatedTileData,Y		;$05BB93	|
	SEP #$10				;$05BB96	|
	PLX					;$05BB98	|
	STA.w $0D76,X				;$05BB99	|
	PLY					;$05BB9C	|
	INY					;$05BB9D	|
	DEX					;$05BB9E	|
	DEX					;$05BB9F	|
	BPL CODE_05BB67				;$05BBA0	|
	SEP #$20				;$05BBA2	|
	PLB					;$05BBA4	|
	RTL					;$05BBA5	|

DATA_05BBA6:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF

CODE_05BC00:
	PHB
	PHK					;$05BC01	|
	PLB					;$05BC02	|
	JSR CODE_05BC76				;$05BC03	|
	JSR CODE_05BCA5				;$05BC06	|
	JSR CODE_05BC4A				;$05BC09	|
	LDA.w $1462				;$05BC0C	|
	SEC					;$05BC0F	|
	SBC $1A					;$05BC10	|
	CLC					;$05BC12	|
	ADC.w $17BD				;$05BC13	|
	STA.w $17BD				;$05BC16	|
	LDA.w $1464				;$05BC19	|
	SEC					;$05BC1C	|
	SBC $1C					;$05BC1D	|
	CLC					;$05BC1F	|
	ADC.w $17BC				;$05BC20	|
	STA.w $17BC				;$05BC23	|
	LDA.w $1466				;$05BC26	|
	SEC					;$05BC29	|
	SBC $1E					;$05BC2A	|
	LDY.w $143F				;$05BC2C	|
	DEY					;$05BC2F	|
	BNE CODE_05BC33				;$05BC30	|
	TYA					;$05BC32	|
CODE_05BC33:
	STA.w $17BF
	LDA.w $1468				;$05BC36	|
	SEC					;$05BC39	|
	SBC $20					;$05BC3A	|
	STA.w $17BE				;$05BC3C	|
	LDA.w $13D5				;$05BC3F	|
	BNE CODE_05BC47				;$05BC42	|
	JSR CODE_05C40C				;$05BC44	|
CODE_05BC47:
	PLB
	RTL					;$05BC48	|

Return05BC49:
	RTS

CODE_05BC4A:
	REP #$20
	LDY.w $1403				;$05BC4C	|
	BNE CODE_05BC5F				;$05BC4F	|
	LDA.w $1466				;$05BC51	|
	SEC					;$05BC54	|
	SBC.w $1462				;$05BC55	|
	STA $26					;$05BC58	|
	LDA.w $1468				;$05BC5A	|
	BRA CODE_05BC69				;$05BC5D	|

CODE_05BC5F:
	LDA $22
	SEC					;$05BC61	|
	SBC.w $1462				;$05BC62	|
	STA $26					;$05BC65	|
	LDA $24					;$05BC67	|
CODE_05BC69:
	SEC
	SBC.w $1464				;$05BC6A	|
	STA $28					;$05BC6D	|
	SEP #$20				;$05BC6F	|
	RTS					;$05BC71	|

CODE_05BC72:
	JSR CODE_05BC4A
	RTL					;$05BC75	|

CODE_05BC76:
	STZ.w $1456
	LDA.w $9D				;$05BC79	|
	BNE Return05BC49			;$05BC7C	|
	LDA.w $143E				;$05BC7E	|
	BEQ Return05BC49			;$05BC81	|
	JSL ExecutePtr				;$05BC83	|

Ptrs05BC87:
	dw CODE_05C04D
	dw CODE_05C04D
	dw Return05BC49
	dw Return05BC49
	dw ADDR_05C283
	dw ADDR_05C69E
	dw Return05BC49
	dw Return05BFF5
	dw CODE_05C51F
	dw Return05BC49
	dw ADDR_05C32E
	dw CODE_05C727
	dw CODE_05C787
	dw Return05BC49
	dw Return05BC49

CODE_05BCA5:
	LDA.b #$04
	STA.w $1456				;$05BCA7	|
	LDA.w $143F				;$05BCAA	|
	BEQ Return05BC49			;$05BCAD	|
	LDY.w $9D				;$05BCAF	|
	BNE Return05BC49			;$05BCB2	|
	JSL ExecutePtr				;$05BCB4	|

Ptrs05BCB8:
	dw CODE_05C04D
	dw CODE_05C198
	dw CODE_05C955
	dw CODE_05C5BB
	dw ADDR_05C283
	dw Return05BC49
	dw ADDR_05C659
	dw Return05BFF5
	dw CODE_05C51F
	dw CODE_05C7C1
	dw ADDR_05C32E
	dw CODE_05C727
	dw CODE_05C787
	dw CODE_05C7BC
	dw CODE_05C81C

CODE_05BCD6:
	PHB
	PHK					;$05BCD7	|
	PLB					;$05BCD8	|
	STZ.w $1456				;$05BCD9	|
	JSR CODE_05BCE9				;$05BCDC	|
	LDA.b #$04				;$05BCDF	|
	STA.w $1456				;$05BCE1	|
	JSR CODE_05BD0E				;$05BCE4	|
	PLB					;$05BCE7	|
	RTL					;$05BCE8	|

CODE_05BCE9:
	LDA.w $143E
	JSL ExecutePtr				;$05BCEC	|

Ptrs05BCF0:
	dw CODE_05BD36
	dw CODE_05BD36
	dw CODE_05BF6A
	dw CODE_05BF0A
	dw ADDR_05BDDD
	dw ADDR_05BFBA
	dw ADDR_05BF97
	dw Return05BD35
	dw CODE_05BEA6
	dw Return05BC49
	dw ADDR_05BE3A
	dw CODE_05BFF6
	dw CODE_05C005
	dw CODE_05C01A
	dw CODE_05C036

CODE_05BD0E:
	LDA.w $143F
	BEQ Return05BD35			;$05BD11	|
	JSL ExecutePtr				;$05BD13	|

Ptrs05BD17:
	dw CODE_05BD4C
	dw CODE_05BD4C
	dw Return05BC49
	dw CODE_05BF20
	dw ADDR_05BDF0
	dw Return05BC49
	dw Return05BC49
	dw Return05BD35
	dw CODE_05BEC6
	dw CODE_05C022
	dw ADDR_05BE4D
	dw Return05BC49
	dw Return05BC49
	dw Return05BC49
	dw Return05BC49

Return05BD35:
	RTS

CODE_05BD36:
	STZ.w $1411
	LDA.w $1440				;$05BD39	|
	ASL					;$05BD3C	|
	TAY					;$05BD3D	|
	REP #$20				;$05BD3E	|
	LDA.w DATA_05C9D1,Y			;$05BD40	|
	STA.w $143E				;$05BD43	|
	LDA.w DATA_05C9DB,Y			;$05BD46	|
	STA.w $1440				;$05BD49	|
CODE_05BD4C:
	LDX.w $1456
	REP #$20				;$05BD4F	|
	STZ.w $1446,X				;$05BD51	|
	STZ.w $1448,X				;$05BD54	|
	STZ.w $144E,X				;$05BD57	|
	STZ.w $1450,X				;$05BD5A	|
	SEP #$20				;$05BD5D	|
	TXA					;$05BD5F	|
	LSR					;$05BD60	|
	LSR					;$05BD61	|
	TAX					;$05BD62	|
	LDY.w $1440				;$05BD63	|
	LDA.w $1456				;$05BD66	|
	BEQ CODE_05BD6E				;$05BD69	|
	LDY.w $1441				;$05BD6B	|
CODE_05BD6E:
	LDA.w DATA_05CA61,Y
	STA.w $1442,X				;$05BD71	|
	LDA.w DATA_05CA68,Y			;$05BD74	|
	STA.w $1444,X				;$05BD77	|
	RTS					;$05BD7A	|

	LDA.w $1440				;$05BD7B	|
	ASL					;$05BD7E	|
	TAY					;$05BD7F	|
	REP #$20				;$05BD80	|
	LDA.w DATA_05C9E5,Y			;$05BD82	|
	STA.w $143E				;$05BD85	|
	LDA.w DATA_05C9E7,Y			;$05BD88	|
	STA.w $1440				;$05BD8B	|
	REP #$20				;$05BD8E	|
	LDY.w $1440				;$05BD90	|
	LDA.w $1456				;$05BD93	|
	AND.w #$00FF				;$05BD96	|
	BEQ ADDR_05BD9E				;$05BD99	|
	LDY.w $1441				;$05BD9B	|
ADDR_05BD9E:
	LDA.w $1456
	AND.w #$00FF				;$05BDA1	|
	LSR					;$05BDA4	|
	LSR					;$05BDA5	|
	TAX					;$05BDA6	|
	LDA.w DATA_05C9E9,Y			;$05BDA7	|
	STA.w $1442,X				;$05BDAA	|
	LDA.w DATA_05CBC7,Y			;$05BDAD	|
	AND.w #$00FF				;$05BDB0	|
	BEQ ADDR_05BDB9				;$05BDB3	|
	EOR.w #$FFFF				;$05BDB5	|
	INC A					;$05BDB8	|
ADDR_05BDB9:
	LDX.w $1456
	CLC					;$05BDBC	|
	ADC.w $1464,X				;$05BDBD	|
	AND.w #$00FF				;$05BDC0	|
	STA.w $144E,X				;$05BDC3	|
	STZ.w $1450,X				;$05BDC6	|
CODE_05BDC9:
	STZ.w $1446,X
	STZ.w $1448,X				;$05BDCC	|
CODE_05BDCF:
	SEP #$20
	TXA					;$05BDD1	|
	LSR					;$05BDD2	|
	LSR					;$05BDD3	|
	AND.b #$FF				;$05BDD4	|
	TAX					;$05BDD6	|
	LDA.b #$FF				;$05BDD7	|
	STA.w $1444,X				;$05BDD9	|
	RTS					;$05BDDC	|

ADDR_05BDDD:
	LDA.w $1440
	ASL					;$05BDE0	|
	TAY					;$05BDE1	|
	REP #$20				;$05BDE2	|
	LDA.w DATA_05CA08,Y			;$05BDE4	|
	STA.w $143E				;$05BDE7	|
	LDA.w DATA_05CA0C,Y			;$05BDEA	|
	STA.w $1440				;$05BDED	|
ADDR_05BDF0:
	REP #$20
	LDY.w $1440				;$05BDF2	|
	LDA.w $1456				;$05BDF5	|
	AND.w #$00FF				;$05BDF8	|
	BEQ ADDR_05BE00				;$05BDFB	|
	LDY.w $1441				;$05BDFD	|
ADDR_05BE00:
	LDA.w $1456
	AND.w #$00FF				;$05BE03	|
	LSR					;$05BE06	|
	LSR					;$05BE07	|
	TAX					;$05BE08	|
	LDA.w DATA_05CA10,Y			;$05BE09	|
	STA.w $1442,X				;$05BE0C	|
	PHA					;$05BE0F	|
	TYA					;$05BE10	|
	ASL					;$05BE11	|
	TAY					;$05BE12	|
	LDA.w DATA_05CA12,Y			;$05BE13	|
	STA $00					;$05BE16	|
	PLA					;$05BE18	|
	TAY					;$05BE19	|
	LDX.w $1456				;$05BE1A	|
	LDA $00					;$05BE1D	|
	CPY.b #$01				;$05BE1F	|
	BEQ ADDR_05BE27				;$05BE21	|
	EOR.w #$FFFF				;$05BE23	|
	INC A					;$05BE26	|
ADDR_05BE27:
	CLC
	ADC.w $1464,X				;$05BE28	|
	STA.w $144E,X				;$05BE2B	|
	STZ.w $1446,X				;$05BE2E	|
	STZ.w $1448,X				;$05BE31	|
	STZ.w $1450,X				;$05BE34	|
	SEP #$20				;$05BE37	|
	RTS					;$05BE39	|

ADDR_05BE3A:
	LDA.w $1440
	ASL					;$05BE3D	|
	TAY					;$05BE3E	|
	REP #$20				;$05BE3F	|
	LDA.w DATA_05CA16,Y			;$05BE41	|
	STA.w $143E				;$05BE44	|
	LDA.w DATA_05CA1E,Y			;$05BE47	|
	STA.w $1440				;$05BE4A	|
ADDR_05BE4D:
	REP #$20
	LDY.w $1440				;$05BE4F	|
	LDA.w $1456				;$05BE52	|
	AND.w #$00FF				;$05BE55	|
	BEQ ADDR_05BE5D				;$05BE58	|
	LDY.w $1441				;$05BE5A	|
ADDR_05BE5D:
	LDA.w $1456
	AND.w #$00FF				;$05BE60	|
	LSR					;$05BE63	|
	LSR					;$05BE64	|
	TAX					;$05BE65	|
	LDA.w DATA_05CA26,Y			;$05BE66	|
	STA.w $1442,X				;$05BE69	|
	TAY					;$05BE6C	|
	LDX.w $1456				;$05BE6D	|
	LDA.w #$0F17				;$05BE70	|
	CPY.b #$01				;$05BE73	|
	BEQ ADDR_05BE7B				;$05BE75	|
	EOR.w #$FFFF				;$05BE77	|
	INC A					;$05BE7A	|
ADDR_05BE7B:
	STA.w $1450,X
	STZ.w $1446,X				;$05BE7E	|
	STZ.w $1448,X				;$05BE81	|
	STZ.w $144E,X				;$05BE84	|
	SEP #$20				;$05BE87	|
	RTS					;$05BE89	|

CODE_05BE8A:
	PHB
	PHK					;$05BE8B	|
	PLB					;$05BE8C	|
	REP #$20				;$05BE8D	|
	LDA.w DATA_05CA26			;$05BE8F	|
	STA.w $1460				;$05BE92	|
	STZ.w $1458				;$05BE95	|
	STZ.w $145A				;$05BE98	|
	STZ.w $145C				;$05BE9B	|
	LDA $1C					;$05BE9E	|
	STA $24					;$05BEA0	|
	SEP #$20				;$05BEA2	|
	PLB					;$05BEA4	|
	RTL					;$05BEA5	|

CODE_05BEA6:
	STZ.w $1411
	LDA.w $1440				;$05BEA9	|
	ASL					;$05BEAC	|
	TAY					;$05BEAD	|
	REP #$20				;$05BEAE	|
	LDA.w DATA_05CA3E,Y			;$05BEB0	|
	STA.w $143E				;$05BEB3	|
	LDA.w DATA_05CA42,Y			;$05BEB6	|
	STA.w $1440				;$05BEB9	|
	STZ $1A					;$05BEBC	|
	STZ.w $1462				;$05BEBE	|
	STZ $1E					;$05BEC1	|
	STZ.w $1466				;$05BEC3	|
CODE_05BEC6:
	REP #$20
	LDY.w $1440				;$05BEC8	|
	LDA.w $1456				;$05BECB	|
	AND.w #$00FF				;$05BECE	|
	BEQ CODE_05BED6				;$05BED1	|
	LDY.w $1441				;$05BED3	|
CODE_05BED6:
	LDA.w $1456
	AND.w #$00FF				;$05BED9	|
	LSR					;$05BEDC	|
	LSR					;$05BEDD	|
	TAX					;$05BEDE	|
	LDA.w DATA_05CA46,Y			;$05BEDF	|
	STA.w $1442,X				;$05BEE2	|
	TAX					;$05BEE5	|
	TYA					;$05BEE6	|
	ASL					;$05BEE7	|
	TAY					;$05BEE8	|
	LDA.w DATA_05CBED,Y			;$05BEE9	|
	AND.w #$00FF				;$05BEEC	|
	CPX.b #$01				;$05BEEF	|
	BEQ CODE_05BEF7				;$05BEF1	|
	EOR.w #$FFFF				;$05BEF3	|
	INC A					;$05BEF6	|
CODE_05BEF7:
	LDX.w $1456
	CLC					;$05BEFA	|
	ADC.w $1462,X				;$05BEFB	|
	AND.w #$00FF				;$05BEFE	|
	STA.w $1450,X				;$05BF01	|
	STZ.w $144E,X				;$05BF04	|
	JMP CODE_05BDC9				;$05BF07	|

CODE_05BF0A:
	STZ.w $1414
	LDA.w $1440				;$05BF0D	|
	ASL					;$05BF10	|
	TAY					;$05BF11	|
	REP #$20				;$05BF12	|
	LDA.w DATA_05CA48,Y			;$05BF14	|
	STA.w $143E				;$05BF17	|
	LDA.w DATA_05CA52,Y			;$05BF1A	|
	STA.w $1440				;$05BF1D	|
CODE_05BF20:
	REP #$20
	LDY.w $1440				;$05BF22	|
	LDA.w $1456				;$05BF25	|
	AND.w #$00FF				;$05BF28	|
	BEQ CODE_05BF30				;$05BF2B	|
	LDY.w $1441				;$05BF2D	|
CODE_05BF30:
	LDA.w $1456
	AND.w #$00FF				;$05BF33	|
	LSR					;$05BF36	|
	LSR					;$05BF37	|
	TAX					;$05BF38	|
	LDA.w DATA_05CA5C,Y			;$05BF39	|
	STA.w $1442,X				;$05BF3C	|
	TAX					;$05BF3F	|
	TYA					;$05BF40	|
	ASL					;$05BF41	|
	TAY					;$05BF42	|
	LDA.w DATA_05CBF5,Y			;$05BF43	|
	AND.w #$00FF				;$05BF46	|
	CPX.b #$01				;$05BF49	|
	BEQ CODE_05BF51				;$05BF4B	|
	EOR.w #$FFFF				;$05BF4D	|
	INC A					;$05BF50	|
CODE_05BF51:
	LDX.w $1456
	CLC					;$05BF54	|
	ADC.w $1464,X				;$05BF55	|
	AND.w #$00FF				;$05BF58	|
	STA.w $144E,X				;$05BF5B	|
	STZ.w $1450,X				;$05BF5E	|
	STZ.w $1448,X				;$05BF61	|
	STZ.w $1448,X				;$05BF64	|
	JMP CODE_05BDCF				;$05BF67	|

CODE_05BF6A:
	LDY.w $1440
	LDA.w DATA_05C94F,Y			;$05BF6D	|
	STA.w $1440				;$05BF70	|
	LDA.w DATA_05C952,Y			;$05BF73	|
	STA.w $1441				;$05BF76	|
	REP #$20				;$05BF79	|
	LDA.w #$0200				;$05BF7B	|
	JSR CODE_05BFD2				;$05BF7E	|
	LDA.w $1440				;$05BF81	|
	CLC					;$05BF84	|
	ADC.b #$0A				;$05BF85	|
	TAX					;$05BF87	|
	LDY.b #$01				;$05BF88	|
	JSR CODE_05C95B				;$05BF8A	|
	REP #$20				;$05BF8D	|
	LDA.w $1468				;$05BF8F	|
	STA $20					;$05BF92	|
	JMP CODE_05C32B				;$05BF94	|

ADDR_05BF97:
	STZ.w $1411
	REP #$20				;$05BF9A	|
	STZ $1A					;$05BF9C	|
	STZ.w $1462				;$05BF9E	|
	STZ $1E					;$05BFA1	|
	STZ.w $1466				;$05BFA3	|
	LDA.w #$0600				;$05BFA6	|
	STA.w $143E				;$05BFA9	|
	STZ.w $144C				;$05BFAC	|
	STZ.w $1454				;$05BFAF	|
	SEP #$20				;$05BFB2	|
	LDA.b #$60				;$05BFB4	|
	STA.w $1441				;$05BFB6	|
	RTS					;$05BFB9	|

ADDR_05BFBA:
	STZ.w $1411
	REP #$20				;$05BFBD	|
	STZ $1E					;$05BFBF	|
	STZ.w $1466				;$05BFC1	|
	LDA.w #$03C0				;$05BFC4	|
	STA $20					;$05BFC7	|
	STA.w $1468				;$05BFC9	|
	STZ.w $1440				;$05BFCC	|
	LDA.w #$0005				;$05BFCF	|
CODE_05BFD2:
	STZ.w $1444
CODE_05BFD5:
	STZ.w $1442
	STA.w $143E				;$05BFD8	|
	STZ.w $1446				;$05BFDB	|
	STZ.w $1448				;$05BFDE	|
	STZ.w $144E				;$05BFE1	|
	STZ.w $1450				;$05BFE4	|
	STZ.w $144A				;$05BFE7	|
	STZ.w $144C				;$05BFEA	|
	STZ.w $1452				;$05BFED	|
	STZ.w $1454				;$05BFF0	|
	SEP #$20				;$05BFF3	|
Return05BFF5:
	RTS

CODE_05BFF6:
	REP #$20
	LDA.w #$0B00				;$05BFF8	|
	BRA CODE_05BFD2				;$05BFFB	|

DATA_05BFFD:
	db $00,$00,$02,$00

DATA_05C001:
	db $80,$00,$00,$01

CODE_05C005:
	STZ.w $1411
	LDA.w $1440				;$05C008	|
	ASL					;$05C00B	|
	TAY					;$05C00C	|
	REP #$20				;$05C00D	|
	LDA.w DATA_05BFFD,Y			;$05C00F	|
	STA.w $1440				;$05C012	|
	LDA.w #$000C				;$05C015	|
	BRA CODE_05BFD2				;$05C018	|

CODE_05C01A:
	REP #$20
	LDA.w #$0D00				;$05C01C	|
	JSR CODE_05BFD2				;$05C01F	|
CODE_05C022:
	STZ.w $1413
	REP #$20				;$05C025	|
	STZ.w $144A				;$05C027	|
	STZ.w $144C				;$05C02A	|
	STZ.w $1452				;$05C02D	|
	STZ.w $1454				;$05C030	|
	SEP #$20				;$05C033	|
	RTS					;$05C035	|

CODE_05C036:
	LDY.w $1440
	LDA.w DATA_05C808,Y			;$05C039	|
	STA.w $1444				;$05C03C	|
	LDA.w DATA_05C80B,Y			;$05C03F	|
	STA.w $1445				;$05C042	|
	REP #$20				;$05C045	|
	LDA.w #$0E00				;$05C047	|
	JMP CODE_05BFD5				;$05C04A	|

CODE_05C04D:
	LDA.w $1456
	LSR					;$05C050	|
	LSR					;$05C051	|
	TAX					;$05C052	|
	LDA.w $1444,X				;$05C053	|
	BNE CODE_05C05F				;$05C056	|
	LDX.w $1456				;$05C058	|
	STZ.w $1446,X				;$05C05B	|
	RTS					;$05C05E	|

CODE_05C05F:
	REP #$20
	LDA.w $1442,X				;$05C061	|
	TAY					;$05C064	|
	LDA.w DATA_05CA6E,Y			;$05C065	|
	AND.w #$00FF				;$05C068	|
	STA $04					;$05C06B	|
	LDA.w DATA_05CABE,Y			;$05C06D	|
	AND.w #$00FF				;$05C070	|
	STA $06					;$05C073	|
	LDA.w $1456				;$05C075	|
	AND.w #$00FF				;$05C078	|
	TAX					;$05C07B	|
	LDA.w $1462,X				;$05C07C	|
	STA $00					;$05C07F	|
	LDA.w $1464,X				;$05C081	|
	STA $02					;$05C084	|
	LDX.b #$02				;$05C086	|
	LDA.w DATA_05CA6F,Y			;$05C088	|
	AND.w #$00FF				;$05C08B	|
	CMP $04					;$05C08E	|
	BNE CODE_05C098				;$05C090	|
	STZ $04					;$05C092	|
	STX $08					;$05C094	|
	BRA CODE_05C0AD				;$05C096	|

CODE_05C098:
	ASL
	ASL					;$05C099	|
	ASL					;$05C09A	|
	ASL					;$05C09B	|
	SEC					;$05C09C	|
	SBC $00					;$05C09D	|
	STA $00					;$05C09F	|
	BPL CODE_05C0A9				;$05C0A1	|
	LDX.b #$00				;$05C0A3	|
	EOR.w #$FFFF				;$05C0A5	|
	INC A					;$05C0A8	|
CODE_05C0A9:
	STA $04
	STX $08					;$05C0AB	|
CODE_05C0AD:
	LDX.b #$00
	LDA.w DATA_05CABF,Y			;$05C0AF	|
	AND.w #$00FF				;$05C0B2	|
	CMP $06					;$05C0B5	|
	BNE CODE_05C0BD				;$05C0B7	|
	STZ $06					;$05C0B9	|
	BRA CODE_05C0D0				;$05C0BB	|

CODE_05C0BD:
	ASL
	ASL					;$05C0BE	|
	ASL					;$05C0BF	|
	ASL					;$05C0C0	|
	SEC					;$05C0C1	|
	SBC $02					;$05C0C2	|
	STA $02					;$05C0C4	|
	BPL CODE_05C0CE				;$05C0C6	|
	LDX.b #$02				;$05C0C8	|
	EOR.w #$FFFF				;$05C0CA	|
	INC A					;$05C0CD	|
CODE_05C0CE:
	STA $06
CODE_05C0D0:
	LDA $5B
	LSR					;$05C0D2	|
	BCS CODE_05C0D7				;$05C0D3	|
	LDX $08					;$05C0D5	|
CODE_05C0D7:
	STX $55
	LDA.w #$FFFF				;$05C0D9	|
	STA $08					;$05C0DC	|
	LDA $04					;$05C0DE	|
	STA $0A					;$05C0E0	|
	LDA $06					;$05C0E2	|
	STA $0C					;$05C0E4	|
	CMP $04					;$05C0E6	|
	BCC CODE_05C0F5				;$05C0E8	|
	STA $0A					;$05C0EA	|
	LDA $04					;$05C0EC	|
	STA $0C					;$05C0EE	|
	LDA.w #$0001				;$05C0F0	|
	STA $08					;$05C0F3	|
CODE_05C0F5:
	LDA $0A
	STA.w $4204				;$05C0F7	|
	SEP #$20				;$05C0FA	|
	LDA.w DATA_05CB0F,Y			;$05C0FC	|
	STA.w $4206				;$05C0FF	|
	NOP					;$05C102	|
	NOP					;$05C103	|
	NOP					;$05C104	|
	NOP					;$05C105	|
	NOP					;$05C106	|
	NOP					;$05C107	|
	REP #$20				;$05C108	|
	LDA.w $4214				;$05C10A	|
	BNE CODE_05C123				;$05C10D	|
	LDA.w $1456				;$05C10F	|
	AND.w #$00FF				;$05C112	|
	LSR					;$05C115	|
	LSR					;$05C116	|
	TAX					;$05C117	|
	INC.w $1442,X				;$05C118	|
	SEP #$20				;$05C11B	|
	DEC.w $1444,X				;$05C11D	|
	JMP CODE_05C04D				;$05C120	|

CODE_05C123:
	STA $0A
	LDA $0C					;$05C125	|
	ASL					;$05C127	|
	ASL					;$05C128	|
	ASL					;$05C129	|
	ASL					;$05C12A	|
	STA $0C					;$05C12B	|
	LDY.b #$10				;$05C12D	|
	LDA.w #$0000				;$05C12F	|
	STA $0E					;$05C132	|
CODE_05C134:
	ASL $0C
	ROL					;$05C136	|
	CMP $0A					;$05C137	|
	BCC CODE_05C13D				;$05C139	|
	SBC $0A					;$05C13B	|
CODE_05C13D:
	ROL $0E
	DEY					;$05C13F	|
	BNE CODE_05C134				;$05C140	|
	LDA.w $1456				;$05C142	|
	AND.w #$00FF				;$05C145	|
	LSR					;$05C148	|
	LSR					;$05C149	|
	TAX					;$05C14A	|
	LDA.w $1442,X				;$05C14B	|
	TAY					;$05C14E	|
	LDA.w DATA_05CB0F,Y			;$05C14F	|
	AND.w #$00FF				;$05C152	|
	ASL					;$05C155	|
	ASL					;$05C156	|
	ASL					;$05C157	|
	ASL					;$05C158	|
	STA $0A					;$05C159	|
	LDX.b #$02				;$05C15B	|
CODE_05C15D:
	LDA $08
	BMI CODE_05C165				;$05C15F	|
	LDA $0A					;$05C161	|
	BRA CODE_05C167				;$05C163	|

CODE_05C165:
	LDA $0E
CODE_05C167:
	BIT $00,X
	BPL CODE_05C16F				;$05C169	|
	EOR.w #$FFFF				;$05C16B	|
	INC A					;$05C16E	|
CODE_05C16F:
	PHX
	PHA					;$05C170	|
	TXA					;$05C171	|
	CLC					;$05C172	|
	ADC.w $1456				;$05C173	|
	TAX					;$05C176	|
	PLA					;$05C177	|
	LDY.b #$00				;$05C178	|
	CMP.w $1446,X				;$05C17A	|
	BEQ CODE_05C18D				;$05C17D	|
	BPL CODE_05C183				;$05C17F	|
	LDY.b #$02				;$05C181	|
CODE_05C183:
	LDA.w $1446,X
	CLC					;$05C186	|
	ADC.w DATA_05CB5F,Y			;$05C187	|
	STA.w $1446,X				;$05C18A	|
CODE_05C18D:
	JSR CODE_05C4F9
	PLX					;$05C190	|
	DEX					;$05C191	|
	DEX					;$05C192	|
	BPL CODE_05C15D				;$05C193	|
	SEP #$20				;$05C195	|
	RTS					;$05C197	|

CODE_05C198:
	JSR CODE_05C04D
	REP #$20				;$05C19B	|
	LDA.w $1466				;$05C19D	|
	STA.w $1462				;$05C1A0	|
	LDA $20					;$05C1A3	|
	CLC					;$05C1A5	|
	ADC.w $1888				;$05C1A6	|
	STA $20					;$05C1A9	|
	SEP #$20				;$05C1AB	|
	RTS					;$05C1AD	|

	LDA.w $1456				;$05C1AE	|
	LSR					;$05C1B1	|
	LSR					;$05C1B2	|
	TAX					;$05C1B3	|
	LDA.w $1444,X				;$05C1B4	|
	BMI ADDR_05C1D4				;$05C1B7	|
	DEC.w $1444,X				;$05C1B9	|
	LDA.w $1444,X				;$05C1BC	|
	CMP.b #$20				;$05C1BF	|
	BCC ADDR_05C1D1				;$05C1C1	|
	REP #$20				;$05C1C3	|
	LDX.w $1456				;$05C1C5	|
	LDA.w $1464,X				;$05C1C8	|
	EOR.w #$0001				;$05C1CB	|
	STA.w $1464,X				;$05C1CE	|
ADDR_05C1D1:
	JMP CODE_05C32B

ADDR_05C1D4:
	REP #$30
	LDY.w $1456				;$05C1D6	|
	LDA.w $144E,Y				;$05C1D9	|
	TAX					;$05C1DC	|
	LDA.w $1464,Y				;$05C1DD	|
	CMP.w $144E,Y				;$05C1E0	|
	BCC ADDR_05C1EB				;$05C1E3	|
	STA $04					;$05C1E5	|
	STX $02					;$05C1E7	|
	BRA ADDR_05C1EF				;$05C1E9	|

ADDR_05C1EB:
	STA $02
	STX $04					;$05C1ED	|
ADDR_05C1EF:
	SEP #$10
	LDA $02					;$05C1F1	|
	CMP $04					;$05C1F3	|
	BCC ADDR_05C24D				;$05C1F5	|
	SEP #$20				;$05C1F7	|
	LDA.w $1456				;$05C1F9	|
	AND.b #$FF				;$05C1FC	|
	LSR					;$05C1FE	|
	LSR					;$05C1FF	|
	TAX					;$05C200	|
	LDA.b #$30				;$05C201	|
	STA.w $1444,X				;$05C203	|
	REP #$20				;$05C206	|
	LDX.w $1456				;$05C208	|
	STZ.w $1448,X				;$05C20B	|
	STZ.w $1450,X				;$05C20E	|
	LDY.w $1440				;$05C211	|
	LDA.w $1456				;$05C214	|
	AND.w #$00FF				;$05C217	|
	BEQ ADDR_05C21F				;$05C21A	|
	LDY.w $1441				;$05C21C	|
ADDR_05C21F:
	LDA.w DATA_05CBC7,Y
	AND.w #$00FF				;$05C222	|
	STA $00					;$05C225	|
	TXA					;$05C227	|
	LSR					;$05C228	|
	LSR					;$05C229	|
	TAX					;$05C22A	|
	LDA.w $1442,X				;$05C22B	|
	EOR.w #$0001				;$05C22E	|
	STA.w $1442,X				;$05C231	|
	AND.w #$00FF				;$05C234	|
	BNE ADDR_05C241				;$05C237	|
	LDA $00					;$05C239	|
	EOR.w #$FFFF				;$05C23B	|
	INC A					;$05C23E	|
	STA $00					;$05C23F	|
ADDR_05C241:
	LDX.w $1456
	LDA $00					;$05C244	|
	CLC					;$05C246	|
	ADC.w $144E,X				;$05C247	|
	STA.w $144E,X				;$05C24A	|
ADDR_05C24D:
	LDA.w $1456
	AND.w #$00FF				;$05C250	|
	LSR					;$05C253	|
	LSR					;$05C254	|
	TAY					;$05C255	|
	LDA.w $1442,Y				;$05C256	|
	TAX					;$05C259	|
	LDA.w DATA_05CBC8,X			;$05C25A	|
	AND.w #$00FF				;$05C25D	|
	CPX.b #$01				;$05C260	|
	BEQ ADDR_05C268				;$05C262	|
	EOR.w #$FFFF				;$05C264	|
	INC A					;$05C267	|
ADDR_05C268:
	LDX.w $1456
	LDY.b #$00				;$05C26B	|
	CMP.w $1448,X				;$05C26D	|
	BEQ ADDR_05C280				;$05C270	|
	BPL ADDR_05C276				;$05C272	|
	LDY.b #$02				;$05C274	|
ADDR_05C276:
	LDA.w $1448,X
	CLC					;$05C279	|
	ADC.w DATA_05CB7B,Y			;$05C27A	|
	STA.w $1448,X				;$05C27D	|
ADDR_05C280:
	JMP ADDR_05C31D

ADDR_05C283:
	REP #$20
	LDY.w $1456				;$05C285	|
	LDA.w $144E,Y				;$05C288	|
	SEC					;$05C28B	|
	SBC.w $1464,Y				;$05C28C	|
	BPL ADDR_05C295				;$05C28F	|
	EOR.w #$FFFF				;$05C291	|
	INC A					;$05C294	|
ADDR_05C295:
	STA $02
	LDA.w $1456				;$05C297	|
	AND.w #$00FF				;$05C29A	|
	LSR					;$05C29D	|
	LSR					;$05C29E	|
	TAX					;$05C29F	|
	LDA.w $1442,X				;$05C2A0	|
	AND.w #$00FF				;$05C2A3	|
	TAY					;$05C2A6	|
	LSR					;$05C2A7	|
	TAX					;$05C2A8	|
	LDA $02					;$05C2A9	|
	STA.w $4204				;$05C2AB	|
	SEP #$20				;$05C2AE	|
	LDA.w DATA_05CBE3,X			;$05C2B0	|
	STA.w $4206				;$05C2B3	|
	NOP					;$05C2B6	|
	NOP					;$05C2B7	|
	NOP					;$05C2B8	|
	NOP					;$05C2B9	|
	NOP					;$05C2BA	|
	NOP					;$05C2BB	|
	REP #$20				;$05C2BC	|
	LDA.w $4214				;$05C2BE	|
	BNE ADDR_05C2E5				;$05C2C1	|
	LDA.w $1456				;$05C2C3	|
	AND.w #$00FF				;$05C2C6	|
	LSR					;$05C2C9	|
	LSR					;$05C2CA	|
	TAX					;$05C2CB	|
	LDA.w $1442,X				;$05C2CC	|
	TAY					;$05C2CF	|
	LDX.w $1456				;$05C2D0	|
	LDA.w #$0200				;$05C2D3	|
	CPY.b #$01				;$05C2D6	|
	BNE ADDR_05C2DE				;$05C2D8	|
	EOR.w #$FFFF				;$05C2DA	|
	INC A					;$05C2DD	|
ADDR_05C2DE:
	CLC
	ADC.w $1464,X				;$05C2DF	|
	STA.w $1464,X				;$05C2E2	|
ADDR_05C2E5:
	LDX.w $1440
	LDA.w $1456				;$05C2E8	|
	AND.w #$00FF				;$05C2EB	|
	BEQ ADDR_05C2F3				;$05C2EE	|
	LDX.w $1441				;$05C2F0	|
ADDR_05C2F3:
	LDA.w DATA_05CBE3,X
	AND.w #$00FF				;$05C2F6	|
	ASL					;$05C2F9	|
	ASL					;$05C2FA	|
	ASL					;$05C2FB	|
	ASL					;$05C2FC	|
	CPY.b #$01				;$05C2FD	|
	BEQ ADDR_05C305				;$05C2FF	|
	EOR.w #$FFFF				;$05C301	|
	INC A					;$05C304	|
ADDR_05C305:
	LDX.w $1456
	LDY.b #$00				;$05C308	|
	CMP.w $1448,X				;$05C30A	|
	BEQ ADDR_05C31D				;$05C30D	|
	BPL ADDR_05C313				;$05C30F	|
	LDY.b #$02				;$05C311	|
ADDR_05C313:
	LDA.w $1448,X
	CLC					;$05C316	|
	ADC.w DATA_05CB9B,Y			;$05C317	|
	STA.w $1448,X				;$05C31A	|
ADDR_05C31D:
	LDA.w $1456
	AND.w #$00FF				;$05C320	|
	CLC					;$05C323	|
	ADC.w #$0002				;$05C324	|
	TAX					;$05C327	|
CODE_05C328:
	JSR CODE_05C4F9
CODE_05C32B:
	SEP #$20
	RTS					;$05C32D	|

ADDR_05C32E:
	REP #$20
	LDY.w $1456				;$05C330	|
	LDA.w $1450,Y				;$05C333	|
	SEC					;$05C336	|
	SBC.w $1462,Y				;$05C337	|
	BPL ADDR_05C340				;$05C33A	|
	EOR.w #$FFFF				;$05C33C	|
	INC A					;$05C33F	|
ADDR_05C340:
	STA $02
	LDA.w $1456				;$05C342	|
	AND.w #$00FF				;$05C345	|
	LSR					;$05C348	|
	LSR					;$05C349	|
	TAX					;$05C34A	|
	LDA.w $1442,X				;$05C34B	|
	AND.w #$00FF				;$05C34E	|
	TAY					;$05C351	|
	LSR					;$05C352	|
	TAX					;$05C353	|
	LDA $02					;$05C354	|
	STA.w $4204				;$05C356	|
	SEP #$20				;$05C359	|
	LDA.w DATA_05CBE5,X			;$05C35B	|
	STA.w $4206				;$05C35E	|
	NOP					;$05C361	|
	NOP					;$05C362	|
	NOP					;$05C363	|
	NOP					;$05C364	|
	NOP					;$05C365	|
	NOP					;$05C366	|
	REP #$20				;$05C367	|
	LDA.w $4214				;$05C369	|
	BNE ADDR_05C39F				;$05C36C	|
	LDA.w $1456				;$05C36E	|
	AND.w #$00FF				;$05C371	|
	LSR					;$05C374	|
	LSR					;$05C375	|
	TAX					;$05C376	|
	LDA.w $1442,X				;$05C377	|
	TAY					;$05C37A	|
	LDX.w $1456				;$05C37B	|
	LDA.w #$0600				;$05C37E	|
	CPY.b #$01				;$05C381	|
	BNE ADDR_05C389				;$05C383	|
	EOR.w #$FFFF				;$05C385	|
	INC A					;$05C388	|
ADDR_05C389:
	CLC
	ADC.w $1462,X				;$05C38A	|
	STA.w $1462,X				;$05C38D	|
	LDA.w #$FFF8				;$05C390	|
	STA.w $0045,X				;$05C393	|
	LDA.w #$0017				;$05C396	|
	STA.w $0047,X				;$05C399	|
	STZ.w $95				;$05C39C	|
ADDR_05C39F:
	LDA.w $1456
	AND.w #$00FF				;$05C3A2	|
	LSR					;$05C3A5	|
	LSR					;$05C3A6	|
	TAX					;$05C3A7	|
	LDA.w $1442,X				;$05C3A8	|
	AND.w #$00FF				;$05C3AB	|
	PHA					;$05C3AE	|
	SEP #$20				;$05C3AF	|
	LDX.b #$02				;$05C3B1	|
	LDY.b #$00				;$05C3B3	|
	CMP.b #$01				;$05C3B5	|
	BEQ ADDR_05C3BD				;$05C3B7	|
	LDX.b #$00				;$05C3B9	|
	LDY.b #$01				;$05C3BB	|
ADDR_05C3BD:
	TXA
	STA.w $0055,Y				;$05C3BE	|
	REP #$20				;$05C3C1	|
	PLA					;$05C3C3	|
	TAY					;$05C3C4	|
	LDX.w $1440				;$05C3C5	|
	LDA.w $1456				;$05C3C8	|
	AND.w #$00FF				;$05C3CB	|
	BEQ ADDR_05C3D3				;$05C3CE	|
	LDX.w $1441				;$05C3D0	|
ADDR_05C3D3:
	LDA.w DATA_05CBE5,X
	AND.w #$00FF				;$05C3D6	|
	ASL					;$05C3D9	|
	ASL					;$05C3DA	|
	ASL					;$05C3DB	|
	ASL					;$05C3DC	|
	CPY.b #$01				;$05C3DD	|
	BEQ ADDR_05C3E5				;$05C3DF	|
	EOR.w #$FFFF				;$05C3E1	|
	INC A					;$05C3E4	|
ADDR_05C3E5:
	LDX.w $1456
	LDY.b #$00				;$05C3E8	|
	CMP.w $1446,X				;$05C3EA	|
	BEQ ADDR_05C3FD				;$05C3ED	|
	BPL ADDR_05C3F3				;$05C3EF	|
	LDY.b #$02				;$05C3F1	|
ADDR_05C3F3:
	LDA.w $1446,X
	CLC					;$05C3F6	|
	ADC.w DATA_05CBA3,Y			;$05C3F7	|
	STA.w $1446,X				;$05C3FA	|
ADDR_05C3FD:
	LDX.w $1456
	JSR CODE_05C4F9				;$05C400	|
	SEP #$20				;$05C403	|
	RTS					;$05C405	|

DATA_05C406:
	db $FF,$01

DATA_05C408:
	db $FC,$04

DATA_05C40A:
	db $30,$A0

CODE_05C40C:
	LDA.w $1403
	BEQ CODE_05C414				;$05C40F	|
	JMP CODE_05C494				;$05C411	|

CODE_05C414:
	REP #$20
	LDY.w $1931				;$05C416	|
	CPY.b #$01				;$05C419	|
	BEQ CODE_05C421				;$05C41B	|
	CPY.b #$03				;$05C41D	|
	BNE CODE_05C428				;$05C41F	|
CODE_05C421:
	LDA $1A
	LSR					;$05C423	|
	STA $22					;$05C424	|
	BRA CODE_05C491				;$05C426	|

CODE_05C428:
	LDY.w $9D
	BNE CODE_05C48D				;$05C42B	|
	LDA.w $1460				;$05C42D	|
	AND.w #$00FF				;$05C430	|
	TAY					;$05C433	|
	LDA.w DATA_05CBEB			;$05C434	|
	AND.w #$00FF				;$05C437	|
	ASL					;$05C43A	|
	ASL					;$05C43B	|
	ASL					;$05C43C	|
	ASL					;$05C43D	|
	CPY.b #$01				;$05C43E	|
	BEQ CODE_05C446				;$05C440	|
	EOR.w #$FFFF				;$05C442	|
	INC A					;$05C445	|
CODE_05C446:
	LDY.b #$00
	CMP.w $1458				;$05C448	|
	BEQ CODE_05C45B				;$05C44B	|
	BPL CODE_05C451				;$05C44D	|
	LDY.b #$02				;$05C44F	|
CODE_05C451:
	LDA.w $1458
	CLC					;$05C454	|
	ADC.w DATA_05CBBB,Y			;$05C455	|
	STA.w $1458				;$05C458	|
CODE_05C45B:
	LDA.w $145C
	AND.w #$00FF				;$05C45E	|
	CLC					;$05C461	|
	ADC.w $1458				;$05C462	|
	STA.w $145C				;$05C465	|
	AND.w #$FF00				;$05C468	|
	BPL CODE_05C470				;$05C46B	|
	ORA.w #$00FF				;$05C46D	|
CODE_05C470:
	XBA
	CLC					;$05C471	|
	ADC $22					;$05C472	|
	STA $22					;$05C474	|
	LDA.w $17BD				;$05C476	|
	AND.w #$00FF				;$05C479	|
	CMP.w #$0080				;$05C47C	|
	BCC CODE_05C484				;$05C47F	|
	ORA.w #$FF00				;$05C481	|
CODE_05C484:
	STA $00
	LDA $22					;$05C486	|
	CLC					;$05C488	|
	ADC $00					;$05C489	|
	STA $22					;$05C48B	|
CODE_05C48D:
	LDA $1C
	STA $24					;$05C48F	|
CODE_05C491:
	SEP #$20
	RTS					;$05C493	|

CODE_05C494:
	DEC A
	BNE CODE_05C4EC				;$05C495	|
	LDA.w $9D				;$05C497	|
	BNE CODE_05C4EC				;$05C49A	|
	LDY.w $1460				;$05C49C	|
	LDA $14					;$05C49F	|
	AND.b #$03				;$05C4A1	|
	BNE CODE_05C4C0				;$05C4A3	|
	LDA.w $145A				;$05C4A5	|
	BNE CODE_05C4AF				;$05C4A8	|
	DEC.w $1B9D				;$05C4AA	|
	BNE CODE_05C4EC				;$05C4AD	|
CODE_05C4AF:
	CMP.w DATA_05C408,Y
	BEQ CODE_05C4BB				;$05C4B2	|
	CLC					;$05C4B4	|
	ADC.w DATA_05C406,Y			;$05C4B5	|
	STA.w $145A				;$05C4B8	|
CODE_05C4BB:
	LDA.b #$4B
	STA.w $1B9D				;$05C4BD	|
CODE_05C4C0:
	LDA $24
	CMP.w DATA_05C40A,Y			;$05C4C2	|
	BNE CODE_05C4CD				;$05C4C5	|
	TYA					;$05C4C7	|
	EOR.b #$01				;$05C4C8	|
	STA.w $1460				;$05C4CA	|
CODE_05C4CD:
	LDA.w $145A
	ASL					;$05C4D0	|
	ASL					;$05C4D1	|
	ASL					;$05C4D2	|
	ASL					;$05C4D3	|
	CLC					;$05C4D4	|
	ADC.w $145C				;$05C4D5	|
	STA.w $145C				;$05C4D8	|
	LDA.w $145A				;$05C4DB	|
	PHP					;$05C4DE	|
	LSR					;$05C4DF	|
	LSR					;$05C4E0	|
	LSR					;$05C4E1	|
	LSR					;$05C4E2	|
	PLP					;$05C4E3	|
	BPL CODE_05C4E8				;$05C4E4	|
	ORA.b #$F0				;$05C4E6	|
CODE_05C4E8:
	ADC $24
	STA $24					;$05C4EA	|
CODE_05C4EC:
	LDA $22
	SEC					;$05C4EE	|
	ADC.w $17BD				;$05C4EF	|
	STA $22					;$05C4F2	|
	LDA.b #$01				;$05C4F4	|
	STA $23					;$05C4F6	|
	RTS					;$05C4F8	|

CODE_05C4F9:
	LDA.w $144E,X
	AND.w #$00FF				;$05C4FC	|
	CLC					;$05C4FF	|
	ADC.w $1446,X				;$05C500	|
	STA.w $144E,X				;$05C503	|
	AND.w #$FF00				;$05C506	|
	BPL CODE_05C50E				;$05C509	|
	ORA.w #$00FF				;$05C50B	|
CODE_05C50E:
	XBA
	CLC					;$05C50F	|
	ADC.w $1462,X				;$05C510	|
	STA.w $1462,X				;$05C513	|
	LDA $08					;$05C516	|
	EOR.w #$FFFF				;$05C518	|
	INC A					;$05C51B	|
	STA $08					;$05C51C	|
	RTS					;$05C51E	|

CODE_05C51F:
	REP #$30
	LDY.w $1456				;$05C521	|
	REP #$30				;$05C524	|
	LDA.w $1450,Y				;$05C526	|
	TAX					;$05C529	|
	LDA.w $1462,Y				;$05C52A	|
	CMP.w $1450,Y				;$05C52D	|
	BCC CODE_05C538				;$05C530	|
	STA $04					;$05C532	|
	STX $02					;$05C534	|
	BRA CODE_05C53C				;$05C536	|

CODE_05C538:
	STA $02
	STX $04					;$05C53A	|
CODE_05C53C:
	SEP #$10
	LDA $02					;$05C53E	|
	CMP $04					;$05C540	|
	BCC CODE_05C585				;$05C542	|
	LDY.w $1440				;$05C544	|
	LDA.w $1456				;$05C547	|
	BEQ CODE_05C54F				;$05C54A	|
	LDY.w $1441				;$05C54C	|
CODE_05C54F:
	TYA
	ASL					;$05C550	|
	TAY					;$05C551	|
	LDA.w DATA_05CBEE,Y			;$05C552	|
	AND.w #$00FF				;$05C555	|
	STA $00					;$05C558	|
	LDA.w $1456				;$05C55A	|
	AND.w #$00FF				;$05C55D	|
	LSR					;$05C560	|
	LSR					;$05C561	|
	TAX					;$05C562	|
	LDA.w $1442,X				;$05C563	|
	EOR.w #$0001				;$05C566	|
	STA.w $1442,X				;$05C569	|
	AND.w #$00FF				;$05C56C	|
	BNE CODE_05C579				;$05C56F	|
	LDA $00					;$05C571	|
	EOR.w #$FFFF				;$05C573	|
	INC A					;$05C576	|
	STA $00					;$05C577	|
CODE_05C579:
	LDX.w $1456
	LDA $00					;$05C57C	|
	CLC					;$05C57E	|
	ADC.w $1450,X				;$05C57F	|
	STA.w $1450,X				;$05C582	|
CODE_05C585:
	LDA.w $1456
	AND.w #$00FF				;$05C588	|
	LSR					;$05C58B	|
	LSR					;$05C58C	|
	TAX					;$05C58D	|
	LDA.w $1442,X				;$05C58E	|
	TAX					;$05C591	|
	LDA.w DATA_05CBF1,X			;$05C592	|
	AND.w #$00FF				;$05C595	|
	CPX.b #$01				;$05C598	|
	BEQ CODE_05C5A0				;$05C59A	|
	EOR.w #$FFFF				;$05C59C	|
	INC A					;$05C59F	|
CODE_05C5A0:
	LDX.w $1456
	LDY.b #$00				;$05C5A3	|
	CMP.w $1446,X				;$05C5A5	|
	BEQ CODE_05C5B8				;$05C5A8	|
	BPL CODE_05C5AE				;$05C5AA	|
	LDY.b #$02				;$05C5AC	|
CODE_05C5AE:
	LDA.w $1446,X
	CLC					;$05C5B1	|
	ADC.w DATA_05CBC3,Y			;$05C5B2	|
	STA.w $1446,X				;$05C5B5	|
CODE_05C5B8:
	JMP CODE_05C328

CODE_05C5BB:
	REP #$30
	LDY.w $1456				;$05C5BD	|
	REP #$30				;$05C5C0	|
	LDA.w $144E,Y				;$05C5C2	|
	TAX					;$05C5C5	|
	LDA.w $1464,Y				;$05C5C6	|
	CMP.w $144E,Y				;$05C5C9	|
	BCC CODE_05C5D4				;$05C5CC	|
	STA $04					;$05C5CE	|
	STX $02					;$05C5D0	|
	BRA CODE_05C5D8				;$05C5D2	|

CODE_05C5D4:
	STA $02
	STX $04					;$05C5D6	|
CODE_05C5D8:
	SEP #$10
	LDA $02					;$05C5DA	|
	CMP $04					;$05C5DC	|
	BCC CODE_05C621				;$05C5DE	|
	LDY.w $1440				;$05C5E0	|
	LDA.w $1456				;$05C5E3	|
	BEQ CODE_05C5EB				;$05C5E6	|
	LDY.w $1441				;$05C5E8	|
CODE_05C5EB:
	TYA
	ASL					;$05C5EC	|
	TAY					;$05C5ED	|
	LDA.w DATA_05CBF6,Y			;$05C5EE	|
	AND.w #$00FF				;$05C5F1	|
	STA $00					;$05C5F4	|
	LDA.w $1456				;$05C5F6	|
	AND.w #$00FF				;$05C5F9	|
	LSR					;$05C5FC	|
	LSR					;$05C5FD	|
	TAX					;$05C5FE	|
	LDA.w $1442,X				;$05C5FF	|
	EOR.w #$0001				;$05C602	|
	STA.w $1442,X				;$05C605	|
	AND.w #$00FF				;$05C608	|
	BNE CODE_05C615				;$05C60B	|
	LDA $00					;$05C60D	|
	EOR.w #$FFFF				;$05C60F	|
	INC A					;$05C612	|
	STA $00					;$05C613	|
CODE_05C615:
	LDX.w $1456
	LDA $00					;$05C618	|
	CLC					;$05C61A	|
	ADC.w $144E,X				;$05C61B	|
	STA.w $144E,X				;$05C61E	|
CODE_05C621:
	LDA.w $1456
	AND.w #$00FF				;$05C624	|
	LSR					;$05C627	|
	LSR					;$05C628	|
	TAX					;$05C629	|
	LDA.w $1442,X				;$05C62A	|
	TAX					;$05C62D	|
	LDA.w DATA_05CBF1,X			;$05C62E	|
	AND.w #$00FF				;$05C631	|
	CPX.b #$01				;$05C634	|
	BEQ CODE_05C63C				;$05C636	|
	EOR.w #$FFFF				;$05C638	|
	INC A					;$05C63B	|
CODE_05C63C:
	LDX.w $1456
	LDY.b #$00				;$05C63F	|
	CMP.w $1448,X				;$05C641	|
	BEQ CODE_05C654				;$05C644	|
	BPL CODE_05C64A				;$05C646	|
	LDY.b #$02				;$05C648	|
CODE_05C64A:
	LDA.w $1448,X
	CLC					;$05C64D	|
	ADC.w DATA_05CBC3,Y			;$05C64E	|
	STA.w $1448,X				;$05C651	|
CODE_05C654:
	INX
	INX					;$05C655	|
	JMP CODE_05C328				;$05C656	|

ADDR_05C659:
	LDA.w $1441
	BEQ ADDR_05C674				;$05C65C	|
	DEC.w $1441				;$05C65E	|
	CMP.w #$B020				;$05C661	|
	ASL.w $14A5				;$05C664	|
	AND.w #$D001				;$05C667	|
	PHP					;$05C66A	|
	LDA.w $1464				;$05C66B	|
	EOR.w #$8D01				;$05C66E	|
	STZ $14					;$05C671	|
	RTS					;$05C673	|

ADDR_05C674:
	STZ $56
	REP #$20				;$05C676	|
	LDA.w $144C				;$05C678	|
	CMP.w #$FFC0				;$05C67B	|
	BEQ ADDR_05C684				;$05C67E	|
	DEC A					;$05C680	|
	STA.w $144C				;$05C681	|
ADDR_05C684:
	LDA.w $1468
	CMP.w #$0031				;$05C687	|
	BPL ADDR_05C68F				;$05C68A	|
	STZ.w $144C				;$05C68C	|
ADDR_05C68F:
	BNE ADDR_05C696
	LDY.b #$20				;$05C691	|
	STY.w $1441				;$05C693	|
ADDR_05C696:
	LDX.b #$06
	JSR CODE_05C4F9				;$05C698	|
	JMP CODE_05C32B				;$05C69B	|

ADDR_05C69E:
	LDA.w #$8502
	EOR $64,X				;$05C6A1	|
	LSR $C2,X				;$05C6A3	|
	JSR $40AE				;$05C6A5	|
	TRB $D0					;$05C6A8	|
	JSL $1446AD				;$05C6AA	|
	CMP.w #$0080				;$05C6AE	|
	BEQ ADDR_05C6B4				;$05C6B1	|
	INC A					;$05C6B3	|
ADDR_05C6B4:
	STA.w $1446
	LDY $5E					;$05C6B7	|
	DEY					;$05C6B9	|
	CPY.w $1463				;$05C6BA	|
	BNE ADDR_05C6EC				;$05C6BD	|
	INC.w $1440				;$05C6BF	|
	STZ.w $1446				;$05C6C2	|
	LDA.w #$FCF0				;$05C6C5	|
	STA.w $1B97				;$05C6C8	|
	BRA ADDR_05C6EC				;$05C6CB	|

	LDY.b #$16				;$05C6CD	|
	STY.w $212C				;$05C6CF	|
	LDA.w $144C				;$05C6D2	|
	CMP.w #$FF80				;$05C6D5	|
	BEQ ADDR_05C6DB				;$05C6D8	|
	DEC A					;$05C6DA	|
ADDR_05C6DB:
	STA.w $144C
	STA.w $1448				;$05C6DE	|
	LDA.w $1468				;$05C6E1	|
	BNE ADDR_05C6EC				;$05C6E4	|
	STZ.w $144C				;$05C6E6	|
	STZ.w $1448				;$05C6E9	|
ADDR_05C6EC:
	LDX.b #$06
ADDR_05C6EE:
	JSR CODE_05C4F9
	DEX					;$05C6F1	|
	DEX					;$05C6F2	|
	BPL ADDR_05C6EE				;$05C6F3	|
	SEP #$20				;$05C6F5	|
	LDA.w $1463				;$05C6F7	|
	SEC					;$05C6FA	|
	SBC $5E					;$05C6FB	|
	INC A					;$05C6FD	|
	INC A					;$05C6FE	|
	XBA					;$05C6FF	|
	LDA.w $1462				;$05C700	|
	REP #$20				;$05C703	|
	LDY.b #$82				;$05C705	|
	CMP.w #$0000				;$05C707	|
	BPL ADDR_05C711				;$05C70A	|
	LDA.w #$0000				;$05C70C	|
	LDY.b #$02				;$05C70F	|
ADDR_05C711:
	STA.w $1466
	STA $1E					;$05C714	|
	STY $5B					;$05C716	|
	JMP CODE_05C32B				;$05C718	|

DATA_05C71B:
	db $20,$00,$C1,$00

DATA_05C71F:
	db $C0,$FF,$40,$00

DATA_05C723:
	db $FF,$FF,$01,$00

CODE_05C727:
	LDX.w $14AF
	BEQ CODE_05C72E				;$05C72A	|
	LDX.b #$02				;$05C72C	|
CODE_05C72E:
	CPX.w $1443
	BEQ CODE_05C74A				;$05C731	|
	DEC.w $1445				;$05C733	|
	BPL CODE_05C73B				;$05C736	|
	STX.w $1443				;$05C738	|
CODE_05C73B:
	LDA.w $1468
	EOR.b #$01				;$05C73E	|
	STA.w $1468				;$05C740	|
	STZ.w $144C				;$05C743	|
	STZ.w $144D				;$05C746	|
	RTS					;$05C749	|

CODE_05C74A:
	LDA.b #$10
	STA.w $1445				;$05C74C	|
	REP #$20				;$05C74F	|
	LDA.w $1468				;$05C751	|
	CMP.w DATA_05C71B,X			;$05C754	|
	BNE CODE_05C770				;$05C757	|
	CPX.b #$00				;$05C759	|
	BNE CODE_05C769				;$05C75B	|
	LDA.w #$0009				;$05C75D	|
	STA.w $1DFC				;$05C760	|
	LDA.w #$0020				;$05C763	|
	STA.w $1887				;$05C766	|
CODE_05C769:
	LDX.b #$00
	STX.w $14AF				;$05C76B	|
	BRA CODE_05C784				;$05C76E	|

CODE_05C770:
	LDA.w $144C
	CMP.w DATA_05C71F,X			;$05C773	|
	BEQ CODE_05C77F				;$05C776	|
	CLC					;$05C778	|
	ADC.w DATA_05C723,X			;$05C779	|
	STA.w $144C				;$05C77C	|
CODE_05C77F:
	LDX.b #$06
	JSR CODE_05C4F9				;$05C781	|
CODE_05C784:
	JMP CODE_05C32B

CODE_05C787:
	LDA.b #$02
	STA $55					;$05C789	|
	STA $56					;$05C78B	|
	LDA.w $1456				;$05C78D	|
	LSR					;$05C790	|
	LSR					;$05C791	|
	TAX					;$05C792	|
	LDY.w $1440,X				;$05C793	|
	LDX.w $1456				;$05C796	|
	REP #$20				;$05C799	|
	LDA.w $1446,X				;$05C79B	|
	CMP.w DATA_05C001,Y			;$05C79E	|
	BEQ CODE_05C7A4				;$05C7A1	|
	INC A					;$05C7A3	|
CODE_05C7A4:
	STA.w $1446,X
	LDA $5E					;$05C7A7	|
	DEC A					;$05C7A9	|
	XBA					;$05C7AA	|
	AND.w #$FF00				;$05C7AB	|
	CMP.w $1462,X				;$05C7AE	|
	BNE CODE_05C7B6				;$05C7B1	|
	STZ.w $1446,X				;$05C7B3	|
CODE_05C7B6:
	JSR CODE_05C4F9
	JMP CODE_05C32B				;$05C7B9	|

CODE_05C7BC:
	LDA.w $1B9A
	BEQ CODE_05C7ED				;$05C7BF	|
CODE_05C7C1:
	LDA.b #$02
	STA $56					;$05C7C3	|
	REP #$20				;$05C7C5	|
	LDA.w $144A				;$05C7C7	|
	CMP.w #$0400				;$05C7CA	|
	BEQ CODE_05C7D0				;$05C7CD	|
	INC A					;$05C7CF	|
CODE_05C7D0:
	STA.w $144A
	LDX.b #$04				;$05C7D3	|
	JSR CODE_05C4F9				;$05C7D5	|
	LDA.w $17BD				;$05C7D8	|
	AND.w #$00FF				;$05C7DB	|
	CMP.w #$0080				;$05C7DE	|
	BCC CODE_05C7E6				;$05C7E1	|
	ORA.w #$FF00				;$05C7E3	|
CODE_05C7E6:
	CLC
	ADC.w $1466				;$05C7E7	|
	STA.w $1466				;$05C7EA	|
CODE_05C7ED:
	JMP CODE_05C32B

DATA_05C7F0:
	db $00,$00,$F0,$02,$B0,$08,$00,$00
	db $00,$00,$70,$03

DATA_05C7FC:
	db $D0,$00,$50,$03,$30,$0A,$08,$00
	db $40,$00,$80,$03

DATA_05C808:
	db $00,$06,$08

DATA_05C80B:
	db $03,$01,$02

DATA_05C80E:
	db $C0,$00

DATA_05C810:
	db $00,$00,$B0,$00

DATA_05C814:
	db $80,$FF,$C0,$00

DATA_05C818:
	db $FF,$FF,$01,$00

CODE_05C81C:
	REP #$20
	STZ $00					;$05C81E	|
	LDY.w $1445				;$05C820	|
	STY $00					;$05C823	|
	LDY.b #$00				;$05C825	|
	LDX.w $1444				;$05C827	|
	CPX.b #$08				;$05C82A	|
	BCC CODE_05C830				;$05C82C	|
	LDY.b #$02				;$05C82E	|
CODE_05C830:
	LDA.w $1466
	CMP.w DATA_05C7F0,X			;$05C833	|
	BCC CODE_05C84C				;$05C836	|
	CMP.w DATA_05C7FC,X			;$05C838	|
	BCS CODE_05C84C				;$05C83B	|
	STZ.w $1442				;$05C83D	|
	LDA.w DATA_05C80E,Y			;$05C840	|
	STA.w $1468				;$05C843	|
	STZ.w $144C				;$05C846	|
	STZ.w $1454				;$05C849	|
CODE_05C84C:
	INX
	INX					;$05C84D	|
	DEC $00					;$05C84E	|
	BNE CODE_05C830				;$05C850	|
	SEP #$20				;$05C852	|
	LDA.w $1442				;$05C854	|
	ORA.w $140E				;$05C857	|
	STA.w $1442				;$05C85A	|
	BEQ CODE_05C87D				;$05C85D	|
	REP #$20				;$05C85F	|
	LDA.w $1468				;$05C861	|
	CMP.w DATA_05C810,Y			;$05C864	|
	BEQ CODE_05C87D				;$05C867	|
	LDA.w $144C				;$05C869	|
	CMP.w DATA_05C814,Y			;$05C86C	|
	BEQ CODE_05C875				;$05C86F	|
	CLC					;$05C871	|
	ADC.w DATA_05C818,Y			;$05C872	|
CODE_05C875:
	STA.w $144C
	LDX.b #$06				;$05C878	|
	JSR CODE_05C4F9				;$05C87A	|
CODE_05C87D:
	SEP #$20
	RTS					;$05C87F	|

DATA_05C880:
	db $00,$00,$C0,$01,$00,$03,$00,$08
	db $38,$08,$00,$0A,$00,$00,$80,$03
	db $50,$04,$90,$08,$60,$09,$80,$0E
	db $00,$40,$00,$40,$00,$40,$00,$40
	db $00,$40,$00,$00

DATA_05C8A4:
	db $08,$00,$00,$03,$10,$04,$38,$08
	db $70,$08,$00,$0B,$08,$00,$50,$04
	db $A0,$04,$60,$09,$40,$0A,$FF,$0F
	db $00,$50,$00,$50,$00,$50,$00,$50
	db $00,$50,$80,$00

DATA_05C8C8:
	db $C0,$00,$B0,$00,$70,$00,$C0,$00
	db $C0,$00,$C0,$00,$00,$00,$00,$00
	db $C0,$00,$B0,$00,$A0,$00,$70,$00
	db $B0,$00,$B0,$00,$B0,$00,$00,$00
	db $00,$00,$B0,$00,$20,$00,$20,$00
	db $20,$00,$10,$00,$10,$00,$10,$00
	db $00,$00,$00,$00,$10,$00

DATA_05C8FE:
	db $00,$01,$00,$01,$00,$08,$00,$01
	db $00,$01,$00,$08,$00,$00,$00,$00
	db $80,$01,$00,$FF,$00,$FF,$00,$00
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $00,$FF,$00,$FF,$00,$F8,$00,$F8
	db $00,$F8,$00,$F8,$00,$F8,$00,$F8
	db $00,$00,$00,$00,$40,$FE

DATA_05C934:
	db $80,$40,$01,$80,$00,$00,$80,$00
	db $40,$00,$00,$20,$40,$00,$20,$00
	db $00,$20,$80,$80,$20,$80,$80,$20
	db $00,$00,$A0

DATA_05C94F:
	db $00,$0C,$18

DATA_05C952:
	db $05,$05,$05

CODE_05C955:
	LDX.w $1440
	LDY.w $1441				;$05C958	|
CODE_05C95B:
	REP #$20
CODE_05C95D:
	LDA.w $1466
	CMP.w DATA_05C880,X			;$05C960	|
	BCC CODE_05C97B				;$05C963	|
	CMP.w DATA_05C8A4,X			;$05C965	|
	BCS CODE_05C97B				;$05C968	|
	TXA					;$05C96A	|
	LSR					;$05C96B	|
	AND.w #$00FE				;$05C96C	|
	STA.w $1442				;$05C96F	|
	LDA.w #$00C1				;$05C972	|
	STA.w $1468				;$05C975	|
	STZ.w $1444				;$05C978	|
CODE_05C97B:
	INX
	INX					;$05C97C	|
	DEY					;$05C97D	|
	BNE CODE_05C95D				;$05C97E	|
	SEP #$20				;$05C980	|
	LDA.w $1444				;$05C982	|
	BEQ CODE_05C98B				;$05C985	|
	DEC.w $1444				;$05C987	|
	RTS					;$05C98A	|

CODE_05C98B:
	LDA.w $1442
	CLC					;$05C98E	|
	ADC.w $1443				;$05C98F	|
	TAY					;$05C992	|
	LSR					;$05C993	|
	TAX					;$05C994	|
	REP #$20				;$05C995	|
	LDA.w $1468				;$05C997	|
	SEC					;$05C99A	|
	SBC.w DATA_05C8C8,Y			;$05C99B	|
	EOR.w DATA_05C8FE,Y			;$05C99E	|
	BPL CODE_05C9A9				;$05C9A1	|
	LDA.w DATA_05C8FE,Y			;$05C9A3	|
	JMP CODE_05C875				;$05C9A6	|

CODE_05C9A9:
	LDA.w DATA_05C8C8,Y
	STA.w $1468				;$05C9AC	|
	SEP #$20				;$05C9AF	|
	LDA.w DATA_05C934,X			;$05C9B1	|
	STA.w $1444				;$05C9B4	|
	LDA.w $1443				;$05C9B7	|
	CLC					;$05C9BA	|
	ADC.b #$12				;$05C9BB	|
	CMP.b #$36				;$05C9BD	|
	BCC CODE_05C9CD				;$05C9BF	|
	LDA.b #$09				;$05C9C1	|
	STA.w $1DFC				;$05C9C3	|
	LDA.b #$20				;$05C9C6	|
	STA.w $1887				;$05C9C8	|
	LDA.b #$00				;$05C9CB	|
CODE_05C9CD:
	STA.w $1443
	RTS					;$05C9D0	|

DATA_05C9D1:
	db $01,$01,$01,$00,$01,$01,$01,$00
	db $01,$09

DATA_05C9DB:
	db $01,$00,$02,$00,$04,$03,$05,$00
	db $06,$00

DATA_05C9E5:
	db $00,$01

DATA_05C9E7:
	db $00,$00

DATA_05C9E9:
	db $00,$00,$02,$02,$02,$00,$02,$05
	db $02,$02,$05,$00,$00,$02,$01,$00
	db $03,$02,$03,$04,$03,$01,$00,$01
	db $00,$00,$03,$00,$00,$00,$00

DATA_05CA08:
	db $00,$04,$00,$04

DATA_05CA0C:
	db $00,$00,$00,$01

DATA_05CA10:
	db $00,$01

DATA_05CA12:
	db $40,$01,$E0,$00

DATA_05CA16:
	db $05,$00,$00,$05,$05,$02,$02,$05
DATA_05CA1E:
	db $00,$00,$00,$01,$02,$03,$04,$03
DATA_05CA26:
	db $01,$00,$01,$01,$00,$06,$00,$06
	db $00,$00,$00,$01,$00,$01,$08,$00
	db $00,$08,$00,$00,$00,$01,$01,$00
DATA_05CA3E:
	db $00,$08,$00,$08

DATA_05CA42:
	db $00,$00,$00,$01

DATA_05CA46:
	db $01,$01

DATA_05CA48:
	db $00,$03,$00,$03,$00,$03,$00,$03
	db $00,$03

DATA_05CA52:
	db $00,$00,$00,$01,$00,$02,$00,$03
	db $00,$04

DATA_05CA5C:
	db $01,$00,$00,$00,$00

DATA_05CA61:
	db $01,$18,$1E,$29,$2D,$35,$47

DATA_05CA68:
	db $16,$05,$0A,$03,$07,$11

DATA_05CA6E:
	db $09

DATA_05CA6F:
	db $00,$09,$14,$1C,$24,$28,$33,$3C
	db $43,$4B,$54,$60,$67,$74,$77,$7B
	db $83,$8A,$8D,$90,$99,$A0,$B0,$00
	db $09,$14,$2C,$3C,$B0,$00,$09,$11
	db $1D,$2C,$32,$41,$48,$63,$6B,$70
	db $00,$27,$37,$70,$00,$07,$12,$27
	db $32,$48,$5B,$70,$00,$20,$28,$3A
	db $40,$5F,$66,$6B,$6B,$80,$80,$89
	db $92,$96,$9A,$9E,$A0,$B0,$00,$10
	db $1A,$20,$2B,$30,$3B,$40,$4B

DATA_05CABE:
	db $50

DATA_05CABF:
	db $0C,$0C,$06,$0B,$08,$0C,$03,$02
	db $09,$03,$09,$02,$06,$06,$07,$05
	db $08,$05,$0A,$04,$08,$04,$04,$0C
	db $0C,$07,$07,$05,$05,$0C,$0C,$08
	db $0C,$0C,$07,$07,$0A,$0A,$0C,$0C
	db $00,$00,$0A,$0A,$00,$00,$09,$09
	db $03,$03,$0C,$0C,$0C,$0C,$08,$08
	db $05,$05,$02,$02,$09,$09,$01,$01
	db $01,$02,$03,$07,$08,$08,$0C,$0C
	db $02,$02,$0A,$0A,$02,$02,$0A,$0A
DATA_05CB0F:
	db $07,$07,$07,$07,$07,$07,$07,$07
	db $07,$07,$07,$07,$07,$07,$07,$07
	db $07,$07,$07,$07,$07,$07,$07,$07
	db $07,$07,$07,$07,$07,$07,$07,$07
	db $07,$07,$07,$07,$07,$07,$07,$07
	db $07,$07,$07,$07,$07,$07,$07,$07
	db $07,$07,$07,$07,$08,$08,$08,$08
	db $08,$08,$10,$08,$40,$08,$04,$08
	db $10,$08,$08,$10,$10,$08,$08,$08
	db $08,$08,$08,$08,$08,$08,$08,$08
DATA_05CB5F:
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
	db $01,$00,$FF,$FF

DATA_05CB7B:
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
	db $01,$00,$FF,$FF,$04,$00,$FC,$FF
DATA_05CB9B:
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
DATA_05CBA3:
	db $04,$00,$FC,$FF,$04,$00,$FC,$FF
	db $04,$00,$FC,$FF,$04,$00,$FC,$FF
	db $01,$00,$FF,$FF,$01,$00,$FF,$FF
DATA_05CBBB:
	db $04,$00,$FC,$FF,$04,$00,$FC,$FF
DATA_05CBC3:
	db $01,$00,$FF,$FF

DATA_05CBC7:
	db $30

DATA_05CBC8:
	db $70,$80,$10,$28,$30,$30,$30,$30
	db $14,$02,$30,$30,$30,$30,$70,$80
	db $70,$80,$70,$80,$70,$80,$70,$80
	db $70,$80,$18

DATA_05CBE3:
	db $18,$18

DATA_05CBE5:
	db $18,$18,$08,$20,$06,$06

DATA_05CBEB:
	db $04,$04

DATA_05CBED:
	db $60

DATA_05CBEE:
	db $42,$D0,$B2

DATA_05CBF1:
	db $80,$80,$80,$80

DATA_05CBF5:
	db $90

DATA_05CBF6:
	db $72,$60,$42,$20,$10,$40,$22,$20
	db $10

CODE_05CBFF:
	PHB
	PHK					;$05CC00	|
	PLB					;$05CC01	|
	JSR CODE_05CC07				;$05CC02	|
	PLB					;$05CC05	|
	RTL					;$05CC06	|

CODE_05CC07:
	LDA.w $13D9
	JSL ExecutePtr				;$05CC0A	|

Ptrs05CC0E:
	dw CODE_05CC66
	dw CODE_05CD76
	dw CODE_05CECA
	dw Return05CFE9

DATA_05CC16:
	db $51,$0D,$00,$09,$30,$28,$31,$28
	db $32,$28,$33,$28,$34,$28,$51,$49
	db $00,$19,$0C,$38,$18,$38,$1E,$38
	db $1B,$38,$1C,$38,$0E,$38,$FC,$38
	db $0C,$38,$15,$38,$0E,$38,$0A,$38
	db $1B,$38,$28,$38,$51,$A9,$00,$19
	db $76,$38,$FC,$38,$FC,$38,$FC,$38
	db $26,$38,$05,$38,$00,$38,$77,$38
	db $FC,$38,$FC,$38,$FC,$38,$FC,$38
	db $FC,$38,$FF

DATA_05CC61:
	db $40,$41,$42,$43,$44

CODE_05CC66:
	LDY.b #$00
	LDX.w $0DB3				;$05CC68	|
	LDA.w $0F48,X				;$05CC6B	|
CODE_05CC6E:
	CMP.b #$0A
	BCC CODE_05CC77				;$05CC70	|
	SBC.b #$0A				;$05CC72	|
	INY					;$05CC74	|
	BRA CODE_05CC6E				;$05CC75	|

CODE_05CC77:
	CPY.w $0F32
	BNE CODE_05CC84				;$05CC7A	|
	CPY.w $0F33				;$05CC7C	|
	BNE CODE_05CC84				;$05CC7F	|
	INC.w $18E4				;$05CC81	|
CODE_05CC84:
	LDA.b #$01
	STA.w $13D5				;$05CC86	|
	LDA.b #$08				;$05CC89	|
	TSB $3E					;$05CC8B	|
	REP #$30				;$05CC8D	|
	STZ $22					;$05CC8F	|
	STZ $24					;$05CC91	|
	LDY.w #$004A				;$05CC93	|
	TYA					;$05CC96	|
	CLC					;$05CC97	|
	ADC.l $7F837B				;$05CC98	|
	TAX					;$05CC9C	|
CODE_05CC9D:
	LDA.w DATA_05CC16,Y
	STA.l $7F837D,X				;$05CCA0	|
	DEX					;$05CCA4	|
	DEX					;$05CCA5	|
	DEY					;$05CCA6	|
	DEY					;$05CCA7	|
	BPL CODE_05CC9D				;$05CCA8	|
	LDA.l $7F837B				;$05CCAA	|
	TAX					;$05CCAE	|
	SEP #$20				;$05CCAF	|
	LDA.w $0DB3				;$05CCB1	|
	BEQ CODE_05CCC8				;$05CCB4	|
	LDY.w #$0000				;$05CCB6	|
CODE_05CCB9:
	LDA.w DATA_05CC61,Y
	STA.l $7F8381,X				;$05CCBC	|
	INX					;$05CCC0	|
	INX					;$05CCC1	|
	INY					;$05CCC2	|
	CPY.w #$0005				;$05CCC3	|
	BNE CODE_05CCB9				;$05CCC6	|
CODE_05CCC8:
	LDY.w #$0002
	LDA.b #$04				;$05CCCB	|
	CLC					;$05CCCD	|
	ADC.l $7F837B				;$05CCCE	|
	TAX					;$05CCD2	|
CODE_05CCD3:
	LDA.w $0F31,Y
	STA.l $7F83AF,X				;$05CCD6	|
	DEY					;$05CCDA	|
	DEX					;$05CCDB	|
	DEX					;$05CCDC	|
	BPL CODE_05CCD3				;$05CCDD	|
	LDA.l $7F837B				;$05CCDF	|
	TAX					;$05CCE3	|
CODE_05CCE4:
	LDA.l $7F83AF,X
	AND.b #$0F				;$05CCE8	|
	BNE CODE_05CCF9				;$05CCEA	|
	LDA.b #$FC				;$05CCEC	|
	STA.l $7F83AF,X				;$05CCEE	|
	INX					;$05CCF2	|
	INX					;$05CCF3	|
	CPX.w #$0004				;$05CCF4	|
	BNE CODE_05CCE4				;$05CCF7	|
CODE_05CCF9:
	SEP #$10
	JSR CODE_05CE4C				;$05CCFB	|
	REP #$20				;$05CCFE	|
	STZ $00					;$05CD00	|
	LDA $02					;$05CD02	|
	STA.w $0F40				;$05CD04	|
	LDX.b #$42				;$05CD07	|
	LDY.b #$00				;$05CD09	|
	JSR CODE_05CDFD				;$05CD0B	|
	LDX.b #$00				;$05CD0E	|
CODE_05CD10:
	LDA.l $7F83BD,X
	AND.w #$000F				;$05CD14	|
	BNE CODE_05CD26				;$05CD17	|
	LDA.w #$38FC				;$05CD19	|
	STA.l $7F83BD,X				;$05CD1C	|
	INX					;$05CD20	|
	INX					;$05CD21	|
	CPX.b #$08				;$05CD22	|
	BNE CODE_05CD10				;$05CD24	|
CODE_05CD26:
	SEP #$20
	INC.w $13D9				;$05CD28	|
	LDA.b #$28				;$05CD2B	|
	STA.w $1424				;$05CD2D	|
	LDA.b #$4A				;$05CD30	|
	CLC					;$05CD32	|
	ADC.l $7F837B				;$05CD33	|
	INC A					;$05CD37	|
	STA.l $7F837B				;$05CD38	|
	SEP #$30				;$05CD3C	|
	RTS					;$05CD3E	|

DATA_05CD3F:
	db $52,$0A,$00,$15,$0B,$38,$18,$38
	db $17,$38,$1E,$38,$1C,$38,$28,$38
	db $FC,$38,$64,$28,$26,$38,$FC,$38
	db $FC,$38,$51,$F3,$00,$03,$FC,$38
	db $FC,$38,$FF

DATA_05CD62:
	db $B7

DATA_05CD63:
	db $C3,$B8,$B9,$BA,$BB,$BA,$BF,$BC
	db $BD,$BE,$BF,$C0,$C3,$C1,$B9,$C2
	db $C4,$B7,$C5

CODE_05CD76:
	LDA.w $1900
	BEQ CODE_05CDD5				;$05CD79	|
	DEC.w $1424				;$05CD7B	|
	BPL Return05CDE8			;$05CD7E	|
	LDY.b #$22				;$05CD80	|
	TYA					;$05CD82	|
	CLC					;$05CD83	|
	ADC.l $7F837B				;$05CD84	|
	TAX					;$05CD88	|
CODE_05CD89:
	LDA.w DATA_05CD3F,Y
	STA.l $7F837D,X				;$05CD8C	|
	DEX					;$05CD90	|
	DEY					;$05CD91	|
	BPL CODE_05CD89				;$05CD92	|
	LDA.l $7F837B				;$05CD94	|
	TAX					;$05CD98	|
	LDA.w $1900				;$05CD99	|
	AND.b #$0F				;$05CD9C	|
	ASL					;$05CD9E	|
	TAY					;$05CD9F	|
	LDA.w DATA_05CD63,Y			;$05CDA0	|
	STA.l $7F8395,X				;$05CDA3	|
	LDA.w DATA_05CD62,Y			;$05CDA7	|
	STA.l $7F839D,X				;$05CDAA	|
	LDA.w $1900				;$05CDAE	|
	AND.b #$F0				;$05CDB1	|
	LSR					;$05CDB3	|
	LSR					;$05CDB4	|
	LSR					;$05CDB5	|
	LSR					;$05CDB6	|
	BEQ CODE_05CDC9				;$05CDB7	|
	ASL					;$05CDB9	|
	TAY					;$05CDBA	|
	LDA.w DATA_05CD63,Y			;$05CDBB	|
	STA.l $7F8393,X				;$05CDBE	|
	LDA.w DATA_05CD62,Y			;$05CDC2	|
	STA.l $7F839B,X				;$05CDC5	|
CODE_05CDC9:
	LDA.b #$22
	CLC					;$05CDCB	|
	ADC.l $7F837B				;$05CDCC	|
	INC A					;$05CDD0	|
	STA.l $7F837B				;$05CDD1	|
CODE_05CDD5:
	DEC.w $13D6
	BPL Return05CDE8			;$05CDD8	|
	LDA.w $1900				;$05CDDA	|
	STA.w $1424				;$05CDDD	|
	INC.w $13D9				;$05CDE0	|
	LDA.b #$11				;$05CDE3	|
	STA.w $1DFC				;$05CDE5	|
Return05CDE8:
	RTS

DATA_05CDE9:
	db $00,$00

DATA_05CDEB:
	db $10,$27,$00,$00,$E8,$03,$00,$00
	db $64,$00,$00,$00,$0A,$00,$00,$00
	db $01,$00

CODE_05CDFD:
	LDA.l $7F837B,X
	AND.w #$FF00				;$05CE01	|
	STA.l $7F837B,X				;$05CE04	|
CODE_05CE08:
	PHX
	TYX					;$05CE09	|
	LDA $02					;$05CE0A	|
	SEC					;$05CE0C	|
	SBC.w DATA_05CDEB,X			;$05CE0D	|
	STA $06					;$05CE10	|
	LDA $00					;$05CE12	|
	SBC.w DATA_05CDE9,X			;$05CE14	|
	STA $04					;$05CE17	|
	PLX					;$05CE19	|
	BCC CODE_05CE2F				;$05CE1A	|
	LDA $06					;$05CE1C	|
	STA $02					;$05CE1E	|
	LDA $04					;$05CE20	|
	STA $00					;$05CE22	|
	LDA.l $7F837B,X				;$05CE24	|
	INC A					;$05CE28	|
	STA.l $7F837B,X				;$05CE29	|
	BRA CODE_05CE08				;$05CE2D	|

CODE_05CE2F:
	INX
	INX					;$05CE30	|
	INY					;$05CE31	|
	INY					;$05CE32	|
	INY					;$05CE33	|
	INY					;$05CE34	|
	CPY.b #$14				;$05CE35	|
	BNE CODE_05CDFD				;$05CE37	|
	RTS					;$05CE39	|

DATA_05CE3A:
	db $00,$00,$64,$00,$C8,$00,$2C,$01
DATA_05CE42:
	db $00,$0A,$14,$1E,$28,$32,$3C,$46
	db $50,$5A

CODE_05CE4C:
	REP #$20
	LDA.w $0F31				;$05CE4E	|
	ASL					;$05CE51	|
	TAX					;$05CE52	|
	LDA.w DATA_05CE3A,X			;$05CE53	|
	STA $00					;$05CE56	|
	LDA.w $0F32				;$05CE58	|
	TAX					;$05CE5B	|
	LDA.w DATA_05CE42,X			;$05CE5C	|
	AND.w #$00FF				;$05CE5F	|
	CLC					;$05CE62	|
	ADC $00					;$05CE63	|
	STA $00					;$05CE65	|
	LDA.w $0F33				;$05CE67	|
	AND.w #$00FF				;$05CE6A	|
	CLC					;$05CE6D	|
	ADC $00					;$05CE6E	|
	STA $00					;$05CE70	|
	SEP #$20				;$05CE72	|
	LDA $00					;$05CE74	|
	STA.w $4202				;$05CE76	|
	LDA.b #$32				;$05CE79	|
	STA.w $4203				;$05CE7B	|
	NOP					;$05CE7E	|
	NOP					;$05CE7F	|
	NOP					;$05CE80	|
	NOP					;$05CE81	|
	LDA.w $4216				;$05CE82	|
	STA $02					;$05CE85	|
	LDA.w $4217				;$05CE87	|
	STA $03					;$05CE8A	|
	LDA $01					;$05CE8C	|
	STA.w $4202				;$05CE8E	|
	LDA.b #$32				;$05CE91	|
	STA.w $4203				;$05CE93	|
	NOP					;$05CE96	|
	NOP					;$05CE97	|
	NOP					;$05CE98	|
	NOP					;$05CE99	|
	LDA.w $4216				;$05CE9A	|
	CLC					;$05CE9D	|
	ADC $03					;$05CE9E	|
	STA $03					;$05CEA0	|
	RTS					;$05CEA2	|

DATA_05CEA3:
	db $51,$B1,$00,$09,$FC,$38,$FC,$38
	db $FC,$38,$FC,$38,$00,$38,$51,$F3
	db $00,$03,$FC,$38,$FC,$38,$52,$13
	db $00,$03,$FC,$38,$FC,$38,$FF

DATA_05CEC2:
	db $0A,$00,$64,$00

DATA_05CEC6:
	db $01,$00,$0A,$00

CODE_05CECA:
	PHB
	PHK					;$05CECB	|
	PLB					;$05CECC	|
	REP #$20				;$05CECD	|
	LDX.b #$00				;$05CECF	|
	LDA.w $0DB3				;$05CED1	|
	AND.w #$00FF				;$05CED4	|
	BEQ CODE_05CEDB				;$05CED7	|
	LDX.b #$03				;$05CED9	|
CODE_05CEDB:
	LDY.b #$02
	LDA.w $0F40				;$05CEDD	|
	BEQ CODE_05CF05				;$05CEE0	|
	CMP.w #$0063				;$05CEE2	|
	BCS CODE_05CEE9				;$05CEE5	|
	LDY.b #$00				;$05CEE7	|
CODE_05CEE9:
	SEC
	SBC.w DATA_05CEC2,Y			;$05CEEA	|
	STA.w $0F40				;$05CEED	|
	STA $02					;$05CEF0	|
	LDA.w DATA_05CEC6,Y			;$05CEF2	|
	CLC					;$05CEF5	|
	ADC.w $0F34,X				;$05CEF6	|
	STA.w $0F34,X				;$05CEF9	|
	LDA.w $0F36,X				;$05CEFC	|
	ADC.w #$0000				;$05CEFF	|
	STA.w $0F36,X				;$05CF02	|
CODE_05CF05:
	LDX.w $1900
	BEQ CODE_05CF36				;$05CF08	|
	SEP #$20				;$05CF0A	|
	LDA $13					;$05CF0C	|
	AND.b #$03				;$05CF0E	|
	BNE CODE_05CF34				;$05CF10	|
	LDX.w $0DB3				;$05CF12	|
	LDA.w $0F48,X				;$05CF15	|
	CLC					;$05CF18	|
	ADC.b #$01				;$05CF19	|
	STA.w $0F48,X				;$05CF1B	|
	LDA.w $1900				;$05CF1E	|
	DEC A					;$05CF21	|
	STA.w $1900				;$05CF22	|
	AND.b #$0F				;$05CF25	|
	CMP.b #$0F				;$05CF27	|
	BNE CODE_05CF34				;$05CF29	|
	LDA.w $1900				;$05CF2B	|
	SEC					;$05CF2E	|
	SBC.b #$06				;$05CF2F	|
	STA.w $1900				;$05CF31	|
CODE_05CF34:
	REP #$20
CODE_05CF36:
	LDA.w $0F40
	BNE CODE_05CF4D				;$05CF39	|
	LDX.w $1900				;$05CF3B	|
	BNE CODE_05CF4D				;$05CF3E	|
	LDX.b #$30				;$05CF40	|
	STX.w $13D6				;$05CF42	|
	INC.w $13D9				;$05CF45	|
	LDX.b #$12				;$05CF48	|
	STX.w $1DFC				;$05CF4A	|
CODE_05CF4D:
	LDY.b #$1E
	TYA					;$05CF4F	|
	CLC					;$05CF50	|
	ADC.l $7F837B				;$05CF51	|
	TAX					;$05CF55	|
	INC A					;$05CF56	|
	STA $0A					;$05CF57	|
CODE_05CF59:
	LDA.w DATA_05CEA3,Y
	STA.l $7F837D,X				;$05CF5C	|
	DEX					;$05CF60	|
	DEX					;$05CF61	|
	DEY					;$05CF62	|
	DEY					;$05CF63	|
	BPL CODE_05CF59				;$05CF64	|
	LDA.w $0F40				;$05CF66	|
	BEQ CODE_05CFA0				;$05CF69	|
	STZ $00					;$05CF6B	|
	LDA.l $7F837B				;$05CF6D	|
	CLC					;$05CF71	|
	ADC.w #$0006				;$05CF72	|
	TAX					;$05CF75	|
	LDY.b #$00				;$05CF76	|
	JSR CODE_05CDFD				;$05CF78	|
	LDA.l $7F837B				;$05CF7B	|
	CLC					;$05CF7F	|
	ADC.w #$0008				;$05CF80	|
	STA $00					;$05CF83	|
	LDA.l $7F837B				;$05CF85	|
	TAX					;$05CF89	|
CODE_05CF8A:
	LDA.l $7F8381,X
	AND.w #$000F				;$05CF8E	|
	BNE CODE_05CFA0				;$05CF91	|
	LDA.w #$38FC				;$05CF93	|
	STA.l $7F8381,X				;$05CF96	|
	INX					;$05CF9A	|
	INX					;$05CF9B	|
	CPX $00					;$05CF9C	|
	BNE CODE_05CF8A				;$05CF9E	|
CODE_05CFA0:
	SEP #$20
	REP #$10				;$05CFA2	|
	LDA.w $1424				;$05CFA4	|
	BEQ CODE_05CFDC				;$05CFA7	|
	LDA.l $7F837B				;$05CFA9	|
	TAX					;$05CFAD	|
	LDA.w $1900				;$05CFAE	|
	AND.b #$0F				;$05CFB1	|
	ASL					;$05CFB3	|
	TAY					;$05CFB4	|
	LDA.w DATA_05CD62,Y			;$05CFB5	|
	STA.l $7F8391,X				;$05CFB8	|
	LDA.w DATA_05CD63,Y			;$05CFBC	|
	STA.l $7F8399,X				;$05CFBF	|
	LDA.w $1900				;$05CFC3	|
	AND.b #$F0				;$05CFC6	|
	LSR					;$05CFC8	|
	LSR					;$05CFC9	|
	LSR					;$05CFCA	|
	BEQ CODE_05CFDC				;$05CFCB	|
	TAY					;$05CFCD	|
	LDA.w DATA_05CD62,Y			;$05CFCE	|
	STA.l $7F838F,X				;$05CFD1	|
	LDA.w DATA_05CD63,Y			;$05CFD5	|
	STA.l $7F8397,X				;$05CFD8	|
CODE_05CFDC:
	REP #$20
	SEP #$10				;$05CFDE	|
	LDA $0A					;$05CFE0	|
	STA.l $7F837B				;$05CFE2	|
	SEP #$30				;$05CFE6	|
	PLB					;$05CFE8	|
Return05CFE9:
	RTS

DATA_05CFEA:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$22,$01
	db $22,$01,$22,$01,$22,$01,$D8,$01
	db $D9,$C1,$D9,$01,$D8,$C1,$22,$01
	db $DF,$01,$22,$01,$DF,$01,$EE,$C1
	db $DE,$C1,$ED,$C1,$DD,$C1,$DA,$01
	db $DA,$C1,$DA,$01,$DA,$C1,$DD,$01
	db $ED,$01,$DE,$01,$EE,$01,$DF,$01
	db $22,$01,$DF,$01,$22,$01,$22,$01
	db $D8,$01,$22,$01,$D9,$01,$22,$01
	db $EB,$01,$EB,$01,$EB,$C1,$EB,$C1
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$EB,$01,$EC,$C1
	db $DC,$C1,$DC,$01,$EC,$01,$DB,$01
	db $DB,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$EC,$C1,$DC,$C1,$DC,$01
	db $EC,$01,$22,$01,$22,$01,$D6,$01
	db $E6,$01,$D7,$01,$E7,$01,$EA,$01
	db $EA,$01,$EA,$C1,$EA,$C1,$D9,$C1
	db $22,$01,$D8,$C1,$22,$01,$E7,$C1
	db $D7,$C1,$E6,$C1,$D6,$C1,$22,$01
	db $22,$01,$DB,$01,$DB,$01,$D9,$41
	db $D8,$81,$D8,$41,$D9,$81,$ED,$81
	db $DD,$81,$EE,$81,$DE,$81,$DE,$41
	db $EE,$41,$DD,$41,$ED,$41,$22,$01
	db $D9,$41,$22,$01,$D8,$41,$EB,$41
	db $EB,$81,$22,$01,$EB,$41,$22,$01
	db $22,$01,$EB,$81,$22,$01,$22,$01
	db $EB,$41,$22,$01,$22,$01,$DC,$41
	db $EC,$41,$EC,$81,$DC,$81,$EC,$81
	db $DC,$81,$22,$01,$22,$01,$22,$01
	db $22,$01,$DC,$41,$EC,$41,$D7,$41
	db $E7,$41,$D6,$41,$E6,$41,$D8,$81
	db $22,$01,$D9,$81,$22,$01,$E6,$81
	db $D6,$81,$E7,$81,$D7,$81,$EB,$81
	db $22,$01,$EB,$41,$EB,$81,$EB,$01
	db $EB,$C1,$EB,$C1,$22,$01,$A8,$11
	db $B8,$11,$A9,$11,$B9,$11,$A6,$11
	db $B6,$11,$A7,$11,$B7,$11,$A6,$11
	db $B6,$11,$A7,$11,$B7,$11,$20,$68
	db $20,$68,$20,$28,$20,$28,$20,$28
	db $20,$28,$22,$09,$22,$09,$22,$01
	db $22,$01,$EC,$C1,$DC,$C1,$DC,$01
	db $EC,$01,$22,$01,$22,$01,$EA,$01
	db $EA,$01,$EA,$C1,$EA,$C1,$EE,$C1
	db $DE,$C1,$ED,$C1,$DD,$C1,$DD,$01
	db $ED,$01,$DE,$01,$EE,$01,$EB,$C1
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$EB,$01,$EC,$C1
	db $DC,$C1,$DC,$01,$EC,$01,$DB,$01
	db $DB,$01,$22,$01,$22,$01,$D6,$01
	db $E6,$01,$D7,$01,$E7,$01,$ED,$81
	db $DD,$81,$EE,$81,$DE,$81,$DF,$01
	db $22,$01,$DF,$01,$22,$01,$D7,$41
	db $E7,$41,$D6,$41,$E6,$41,$22,$01
	db $EB,$41,$22,$01,$22,$01,$EC,$81
	db $DC,$81,$22,$01,$22,$01,$22,$01
	db $22,$01,$EB,$81,$22,$01,$D9,$41
	db $D8,$81,$D8,$41,$D9,$81,$EB,$C1
	db $EB,$C1,$EB,$C1,$22,$01,$22,$01
	db $22,$01,$DB,$01,$DB,$01,$E7,$C1
	db $D7,$C1,$E6,$C1,$D6,$C1,$22,$01
	db $DF,$01,$22,$01,$DF,$01,$E6,$81
	db $D6,$81,$E7,$81,$D7,$81,$D8,$01
	db $D9,$C1,$D9,$01,$D8,$C1,$EA,$01
	db $EA,$01,$EA,$C1,$EA,$C1,$EA,$01
	db $EA,$01,$EA,$C1,$EA,$C1,$D6,$01
	db $E6,$01,$D7,$01,$E7,$01,$DA,$01
	db $DA,$C1,$DA,$01,$DA,$C1,$A4,$11
	db $B4,$11,$A5,$11,$B5,$11,$22,$11
	db $90,$11,$22,$11,$91,$11,$C2,$11
	db $D2,$11,$C3,$11,$D3,$11,$23,$38
	db $71,$38,$23,$38,$71,$38,$23,$28
	db $71,$28,$23,$28,$71,$28,$23,$30
	db $71,$30,$23,$30,$71,$30,$22,$01
	db $22,$01,$22,$01,$EB,$01,$22,$01
	db $EB,$41,$22,$01,$22,$01,$22,$01
	db $22,$01,$EB,$81,$22,$01,$22,$15
	db $AC,$15,$22,$15,$AD,$15,$EA,$01
	db $EA,$01,$EA,$C1,$EA,$C1,$DA,$01
	db $DA,$C1,$DA,$01,$DA,$C1,$DA,$01
	db $DA,$C1,$DA,$01,$DA,$C1,$E7,$C1
	db $D7,$C1,$E6,$C1,$D6,$C1,$EB,$C1
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$C9,$05
	db $C8,$05,$C9,$05,$C8,$05,$84,$11
	db $94,$11,$85,$11,$95,$11,$22,$01
	db $22,$01,$22,$01,$22,$01,$88,$15
	db $98,$15,$89,$15,$99,$15,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$8C,$15
	db $9C,$15,$8D,$15,$9D,$15,$9E,$10
	db $64,$10,$9F,$10,$65,$10,$BC,$15
	db $AE,$15,$BD,$15,$AF,$15,$82,$19
	db $92,$19,$83,$19,$93,$19,$C8,$19
	db $F8,$19,$C9,$19,$F9,$19,$AA,$11
	db $BA,$11,$AA,$51,$BA,$51,$56,$19
	db $EA,$09,$56,$59,$EA,$C9,$A0,$11
	db $B0,$11,$A1,$11,$B1,$11,$A2,$11
	db $B2,$11,$A3,$11,$B3,$11,$CC,$15
	db $CE,$15,$CD,$15,$CF,$15,$22,$01
	db $22,$01,$22,$01,$22,$01,$86,$99
	db $86,$19,$86,$D9,$86,$59,$96,$99
	db $96,$19,$96,$D9,$96,$59,$86,$9D
	db $86,$1D,$86,$DD,$86,$5D,$96,$9D
	db $96,$1D,$96,$DD,$96,$5D,$86,$99
	db $86,$19,$86,$D9,$86,$59,$96,$99
	db $96,$19,$96,$D9,$96,$59,$86,$9D
	db $86,$1D,$86,$DD,$86,$5D,$96,$9D
	db $96,$1D,$96,$DD,$96,$5D,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$80,$1C
	db $90,$1C,$81,$1C,$90,$5C,$22,$01
	db $22,$01,$22,$01,$22,$01,$80,$14
	db $90,$14,$81,$14,$90,$54,$22,$01
	db $22,$01,$22,$01,$22,$01,$22,$01
	db $22,$01,$22,$01,$22,$01,$82,$1D
	db $92,$1D,$83,$1D,$93,$1D,$22,$01
	db $22,$01,$22,$01,$22,$01,$86,$99
	db $86,$19,$86,$D9,$86,$59,$22,$01
	db $22,$01,$22,$01,$22,$01,$86,$99
	db $86,$19,$86,$D9,$86,$59,$8A,$15
	db $9A,$15,$8B,$15,$9B,$15,$8C,$15
	db $9C,$15,$8D,$15,$9D,$15,$C0,$11
	db $D0,$11,$C1,$11,$D1,$11,$22,$11
	db $22,$11,$22,$11,$22,$11,$22,$1D
	db $82,$1C,$22,$1D,$83,$1C,$22,$1D
	db $82,$14,$22,$1D,$83,$14,$80,$19
	db $90,$19,$81,$19,$91,$19,$8E,$19
	db $9E,$19,$8F,$19,$9F,$19,$A0,$19
	db $B0,$19,$A1,$19,$B1,$19,$A4,$19
	db $B4,$19,$A5,$19,$B5,$19,$A8,$19
	db $B8,$19,$A9,$19,$B9,$19,$BE,$19
	db $CE,$19,$BF,$19,$CF,$19,$C4,$19
	db $D4,$19,$C5,$19,$D5,$19,$22,$09
	db $C6,$0D,$22,$09,$C7,$0D,$22,$09
	db $FC,$0D,$FE,$0D,$FD,$0D,$CC,$0D
	db $E4,$0D,$CD,$0D,$E5,$0D,$E0,$0D
	db $F0,$0D,$E1,$0D,$F1,$0D,$F4,$0D
	db $22,$09,$F5,$0D,$22,$09,$E8,$0D
	db $22,$09,$22,$09,$22,$09,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$75,$3C
	db $75,$3C,$75,$3C,$75,$3C,$22,$09
	db $79,$14,$22,$09,$9D,$14,$22,$09
	db $78,$54,$22,$09,$22,$09,$22,$09
	db $22,$09,$22,$09,$79,$14,$22,$09
	db $9D,$14,$78,$14,$9D,$14,$9D,$14
	db $78,$54,$79,$54,$22,$09,$79,$14
	db $22,$09,$22,$09,$22,$09,$22,$09
	db $22,$09,$78,$54,$22,$09,$22,$09
	db $22,$09,$78,$14,$22,$09,$9D,$14
	db $22,$09,$79,$54,$22,$09,$22,$09
	db $9D,$14,$22,$09,$78,$54,$22,$09
	db $78,$14,$22,$09,$22,$09,$22,$09
	db $22,$09,$22,$09,$79,$54,$78,$14
	db $9D,$14,$9D,$14,$9D,$14,$56,$10
	db $9E,$10,$57,$10,$9F,$10,$9E,$10
	db $9E,$10,$9F,$10,$9F,$10,$22,$15
	db $AC,$15,$22,$15,$AD,$15,$22,$09
	db $22,$09,$22,$09,$48,$19,$22,$09
	db $39,$19,$22,$09,$22,$09,$22,$09
	db $22,$09,$37,$15,$47,$15,$38,$15
	db $48,$19,$58,$19,$49,$19,$49,$59
	db $59,$59,$48,$59,$58,$59,$37,$55
	db $47,$55,$22,$09,$22,$09,$22,$09
	db $22,$09,$57,$15,$5A,$1D,$58,$19
	db $5B,$19,$59,$19,$59,$19,$60,$19
	db $70,$19,$60,$59,$70,$59,$3A,$19
	db $4A,$19,$3B,$19,$4B,$11,$48,$19
	db $58,$19,$48,$59,$58,$59,$22,$09
	db $22,$09,$7A,$1D,$22,$09,$7B,$1D
	db $22,$09,$7B,$1D,$22,$09,$7B,$1D
	db $22,$09,$7A,$5D,$22,$09,$CA,$19
	db $FA,$19,$CB,$19,$FB,$19,$7E,$18
	db $22,$09,$22,$09,$22,$09,$7F,$10
	db $22,$09,$22,$09,$22,$09,$7F,$10
	db $22,$09,$22,$09,$7E,$18,$7E,$18
	db $22,$09,$22,$09,$7F,$10,$22,$09
	db $22,$09,$22,$09,$7E,$18,$22,$09
	db $22,$09,$22,$09,$7F,$10,$3F,$10
	db $3F,$10,$3F,$10,$3F,$10,$6F,$51
	db $7F,$51,$6E,$51,$7E,$51,$F3,$51
	db $FF,$51,$87,$51,$97,$51,$08,$00
	db $09,$00,$0A,$00,$0B,$00,$00,$00
	db $00,$00,$00,$00,$00,$00

DATA_05D608:
	db $FF,$1F,$20,$FF,$0B,$0D,$0E,$0F
	db $28,$09,$10,$21,$22,$23,$24,$25
	db $27,$60,$FF,$12,$02,$07,$FF,$FF
	db $4E,$FF,$4D,$4A,$4C,$4B,$36,$35
	db $61,$63,$62,$48,$46,$06,$05,$04
	db $00,$01,$03,$19,$FF,$1D,$1A,$14
	db $44,$45,$42,$3E,$40,$41,$43,$3D
	db $3B,$39,$38,$4F,$17,$1B,$15,$29
	db $1C,$30,$2A,$32,$2C,$37,$34,$2E
	db $6D,$6C,$6B,$6A,$69,$64,$65,$66
	db $67,$68,$56,$53,$54,$5F,$57,$59
	db $51,$5A,$5D,$50,$5C

Empty05D665:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF

DATA_05D708:
	db $00,$60,$C0,$00

DATA_05D70C:
	db $60,$90,$C0,$00

DATA_05D710:
	db $03,$01,$01,$00,$00,$02,$02,$01
	db $00,$00,$00,$00,$00,$00,$00,$00
DATA_05D720:
	db $02,$02,$01,$00,$01,$02,$01,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
DATA_05D730:
	db $00,$30,$60,$80,$A0,$B0,$C0,$E0
	db $10,$30,$50,$60,$70,$90,$00,$00
DATA_05D740:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $01,$01,$01,$01,$01,$01,$01,$01
DATA_05D750:
	db $10,$80,$00,$E0,$10,$70,$00,$E0
DATA_05D758:
	db $00,$00,$00,$00,$01,$01,$01,$01
DATA_05D760:
	db $05,$01,$02,$06,$08,$01

PtrsLong05D766:
	dl LevelData078000
	dl DATA_07801E
	dl DATA_07804E
	dl DATA_07809F
	dl DATA_0780B1
	dl DATA_078090

PtrsLong05D778:
	dl DATA_078018
	dl $FFD900
	dl $FFD900
	dl $FFE684
	dl $FFDF59
	dl $FFE8EE

DATA_05D78A:
	db $03,$00,$00,$00,$00,$00

DATA_05D790:
	db $70,$70,$60,$70,$70,$70

CODE_05D796:
	PHB
	PHK					;$05D797	|
	PLB					;$05D798	|
	SEP #$30				;$05D799	|
	STZ.w $13CF				;$05D79B	|
	LDA.w $1B95				;$05D79E	|
	BNE CODE_05D7A8				;$05D7A1	|
	LDY.w $1425				;$05D7A3	|
	BEQ CODE_05D7AB				;$05D7A6	|
CODE_05D7A8:
	JSR CODE_05DBAC
CODE_05D7AB:
	LDA.w $141A
	BNE CODE_05D7B3				;$05D7AE	|
	JMP CODE_05D83E				;$05D7B0	|

CODE_05D7B3:
	LDX $95
	LDA $5B					;$05D7B5	|
	AND.b #$01				;$05D7B7	|
	BEQ CODE_05D7BD				;$05D7B9	|
	LDX $97					;$05D7BB	|
CODE_05D7BD:
	LDA.w $19B8,X
	STA.w $17BB				;$05D7C0	|
	STA $0E					;$05D7C3	|
	LDA.w $0DD6				;$05D7C5	|
	LSR					;$05D7C8	|
	LSR					;$05D7C9	|
	TAY					;$05D7CA	|
	LDA.w $1F11,Y				;$05D7CB	|
	BEQ CODE_05D7D2				;$05D7CE	|
	LDA.b #$01				;$05D7D0	|
CODE_05D7D2:
	STA $0F
	LDA.w $1B93				;$05D7D4	|
	BEQ CODE_05D83B				;$05D7D7	|
	REP #$30				;$05D7D9	|
	LDA.w #$0000				;$05D7DB	|
	SEP #$20				;$05D7DE	|
	LDY $0E					;$05D7E0	|
	LDA.w DATA_05F800,Y			;$05D7E2	|
	STA $0E					;$05D7E5	|
	STA.w $17BB				;$05D7E7	|
	LDA.w DATA_05FA00,Y			;$05D7EA	|
	STA $00					;$05D7ED	|
	AND.b #$0F				;$05D7EF	|
	TAX					;$05D7F1	|
	LDA.l DATA_05D730,X			;$05D7F2	|
	STA $96					;$05D7F6	|
	LDA.l DATA_05D740,X			;$05D7F8	|
	STA $97					;$05D7FC	|
	LDA $00					;$05D7FE	|
	AND.b #$30				;$05D800	|
	LSR					;$05D802	|
	LSR					;$05D803	|
	LSR					;$05D804	|
	LSR					;$05D805	|
	TAX					;$05D806	|
	LDA.l DATA_05D708,X			;$05D807	|
	STA $1C					;$05D80B	|
	LDA $00					;$05D80D	|
	LSR					;$05D80F	|
	LSR					;$05D810	|
	LSR					;$05D811	|
	LSR					;$05D812	|
	LSR					;$05D813	|
	LSR					;$05D814	|
	TAX					;$05D815	|
	LDA.l DATA_05D70C,X			;$05D816	|
	STA $20					;$05D81A	|
	LDA.w DATA_05FC00,Y			;$05D81C	|
	STA $01					;$05D81F	|
	LSR					;$05D821	|
	LSR					;$05D822	|
	LSR					;$05D823	|
	LSR					;$05D824	|
	LSR					;$05D825	|
	TAX					;$05D826	|
	LDA.l DATA_05D750,X			;$05D827	|
	STA $94					;$05D82B	|
	LDA.l DATA_05D758,X			;$05D82D	|
	STA $95					;$05D831	|
	LDA.w DATA_05FE00,Y			;$05D833	|
	AND.b #$07				;$05D836	|
	STA.w $192A				;$05D838	|
CODE_05D83B:
	JMP CODE_05D8B7

CODE_05D83E:
	STZ $0F
	LDY.b #$00				;$05D840	|
	LDA.w $0109				;$05D842	|
	BNE CODE_05D8A2				;$05D845	|
	REP #$30				;$05D847	|
	STZ $1A					;$05D849	|
	STZ $1E					;$05D84B	|
	LDX.w $0DD6				;$05D84D	|
	LDA.w $1F1F,X				;$05D850	|
	AND.w #$000F				;$05D853	|
	STA $00					;$05D856	|
	LDA.w $1F21,X				;$05D858	|
	AND.w #$000F				;$05D85B	|
	ASL					;$05D85E	|
	ASL					;$05D85F	|
	ASL					;$05D860	|
	ASL					;$05D861	|
	STA $02					;$05D862	|
	LDA.w $1F1F,X				;$05D864	|
	AND.w #$0010				;$05D867	|
	ASL					;$05D86A	|
	ASL					;$05D86B	|
	ASL					;$05D86C	|
	ASL					;$05D86D	|
	ORA $00					;$05D86E	|
	STA $00					;$05D870	|
	LDA.w $1F21,X				;$05D872	|
	AND.w #$0010				;$05D875	|
	ASL					;$05D878	|
	ASL					;$05D879	|
	ASL					;$05D87A	|
	ASL					;$05D87B	|
	ASL					;$05D87C	|
	ORA $02					;$05D87D	|
	ORA $00					;$05D87F	|
	TAX					;$05D881	|
	LDA.w $0DD6				;$05D882	|
	AND.w #$00FF				;$05D885	|
	LSR					;$05D888	|
	LSR					;$05D889	|
	TAY					;$05D88A	|
	LDA.w $1F11,Y				;$05D88B	|
	AND.w #$000F				;$05D88E	|
	BEQ CODE_05D899				;$05D891	|
	TXA					;$05D893	|
	CLC					;$05D894	|
	ADC.w #$0400				;$05D895	|
	TAX					;$05D898	|
CODE_05D899:
	SEP #$20
	LDA.l $7ED000,X				;$05D89B	|
	STA.w $13BF				;$05D89F	|
CODE_05D8A2:
	CMP.b #$25
	BCC CODE_05D8A9				;$05D8A4	|
	SEC					;$05D8A6	|
	SBC.b #$24				;$05D8A7	|
CODE_05D8A9:
	STA.w $17BB
	STA $0E					;$05D8AC	|
	LDA.w $1F11,Y				;$05D8AE	|
	BEQ CODE_05D8B5				;$05D8B1	|
	LDA.b #$01				;$05D8B3	|
CODE_05D8B5:
	STA $0F
CODE_05D8B7:
	REP #$30
	LDA $0E					;$05D8B9	|
	ASL					;$05D8BB	|
	CLC					;$05D8BC	|
	ADC $0E					;$05D8BD	|
	TAY					;$05D8BF	|
	SEP #$20				;$05D8C0	|
	LDA.w Layer1Ptrs,Y			;$05D8C2	|
	STA $65					;$05D8C5	|
	LDA.w Layer1Ptrs+1,Y			;$05D8C7	|
	STA $66					;$05D8CA	|
	LDA.w Layer1Ptrs+2,Y			;$05D8CC	|
	STA $67					;$05D8CF	|
	LDA.w Layer2Ptrs,Y			;$05D8D1	|
	STA $68					;$05D8D4	|
	LDA.w Layer2Ptrs+1,Y			;$05D8D6	|
	STA $69					;$05D8D9	|
	LDA.w Layer2Ptrs+2,Y			;$05D8DB	|
	STA $6A					;$05D8DE	|
	REP #$20				;$05D8E0	|
	LDA $0E					;$05D8E2	|
	ASL					;$05D8E4	|
	TAY					;$05D8E5	|
	LDA.w #$0000				;$05D8E6	|
	SEP #$20				;$05D8E9	|
	LDA.w Ptrs05EC00,Y			;$05D8EB	|
	STA $CE					;$05D8EE	|
	LDA.w $EC01,Y				;$05D8F0	|
	STA $CF					;$05D8F3	|
	LDA.b #$07				;$05D8F5	|
	STA $D0					;$05D8F7	|
	LDA [$CE]				;$05D8F9	|
	AND.b #$3F				;$05D8FB	|
	STA.w $1692				;$05D8FD	|
	LDA [$CE]				;$05D900	|
	AND.b #$C0				;$05D902	|
	STA.w $190E				;$05D904	|
	REP #$10				;$05D907	|
	SEP #$20				;$05D909	|
	LDY $0E					;$05D90B	|
	LDA.w DATA_05F000,Y			;$05D90D	|
	LSR					;$05D910	|
	LSR					;$05D911	|
	LSR					;$05D912	|
	LSR					;$05D913	|
	TAX					;$05D914	|
	LDA.l DATA_05D720,X			;$05D915	|
	STA.w $1413				;$05D919	|
	LDA.l DATA_05D710,X			;$05D91C	|
	STA.w $1414				;$05D920	|
	LDA.b #$01				;$05D923	|
	STA.w $1411				;$05D925	|
	LDA.w DATA_05F200,Y			;$05D928	|
	AND.b #$C0				;$05D92B	|
	CLC					;$05D92D	|
	ASL					;$05D92E	|
	ROL					;$05D92F	|
	ROL					;$05D930	|
	STA.w $1BE3				;$05D931	|
	STZ $1D					;$05D934	|
	STZ $21					;$05D936	|
	LDA.w DATA_05F600,Y			;$05D938	|
	AND.b #$80				;$05D93B	|
	STA.w $141F				;$05D93D	|
	LDA.w DATA_05F600,Y			;$05D940	|
	AND.b #$60				;$05D943	|
	LSR					;$05D945	|
	LSR					;$05D946	|
	LSR					;$05D947	|
	LSR					;$05D948	|
	LSR					;$05D949	|
	STA $5B					;$05D94A	|
	LDA.w $1B93				;$05D94C	|
	BNE CODE_05D9A1				;$05D94F	|
	LDA.w DATA_05F000,Y			;$05D951	|
	AND.b #$0F				;$05D954	|
	TAX					;$05D956	|
	LDA.l DATA_05D730,X			;$05D957	|
	STA $96					;$05D95B	|
	LDA.l DATA_05D740,X			;$05D95D	|
	STA $97					;$05D961	|
	LDA.w DATA_05F200,Y			;$05D963	|
	STA $02					;$05D966	|
	AND.b #$07				;$05D968	|
	TAX					;$05D96A	|
	LDA.l DATA_05D750,X			;$05D96B	|
	STA $94					;$05D96F	|
	LDA.l DATA_05D758,X			;$05D971	|
	STA $95					;$05D975	|
	LDA $02					;$05D977	|
	AND.b #$38				;$05D979	|
	LSR					;$05D97B	|
	LSR					;$05D97C	|
	LSR					;$05D97D	|
	STA.w $192A				;$05D97E	|
	LDA.w DATA_05F400,Y			;$05D981	|
	STA $02					;$05D984	|
	AND.b #$03				;$05D986	|
	TAX					;$05D988	|
	LDA.l DATA_05D70C,X			;$05D989	|
	STA $20					;$05D98D	|
	LDA $02					;$05D98F	|
	AND.b #$0C				;$05D991	|
	LSR					;$05D993	|
	LSR					;$05D994	|
	TAX					;$05D995	|
	LDA.l DATA_05D708,X			;$05D996	|
	STA $1C					;$05D99A	|
	LDA.w DATA_05F600,Y			;$05D99C	|
	STA $01					;$05D99F	|
CODE_05D9A1:
	LDA $5B
	AND.b #$01				;$05D9A3	|
	BEQ CODE_05D9B8				;$05D9A5	|
	LDY.w #$0000				;$05D9A7	|
	LDA [$65],Y				;$05D9AA	|
	AND.b #$1F				;$05D9AC	|
	STA $97					;$05D9AE	|
	INC A					;$05D9B0	|
	STA $5F					;$05D9B1	|
	LDA.b #$01				;$05D9B3	|
	STA.w $1412				;$05D9B5	|
CODE_05D9B8:
	LDA.w $141A
	BNE CODE_05D9EC				;$05D9BB	|
	LDA $02					;$05D9BD	|
	LSR					;$05D9BF	|
	LSR					;$05D9C0	|
	LSR					;$05D9C1	|
	LSR					;$05D9C2	|
	STA.w $13CD				;$05D9C3	|
	STZ.w $13CE				;$05D9C6	|
	LDY.w $13BF				;$05D9C9	|
	LDA.w DATA_05D608,Y			;$05D9CC	|
	STA.w $1DEA				;$05D9CF	|
	SEP #$10				;$05D9D2	|
	LDX.w $13BF				;$05D9D4	|
	LDA.w $1EA2,X				;$05D9D7	|
	AND.b #$40				;$05D9DA	|
	BEQ CODE_05D9EC				;$05D9DC	|
	STA.w $13CF				;$05D9DE	|
	LDA $02					;$05D9E1	|
	LSR					;$05D9E3	|
	LSR					;$05D9E4	|
	LSR					;$05D9E5	|
	LSR					;$05D9E6	|
	STA $95					;$05D9E7	|
	JMP CODE_05DA17				;$05D9E9	|

CODE_05D9EC:
	REP #$10
	LDA $01					;$05D9EE	|
	AND.b #$1F				;$05D9F0	|
	STA $01					;$05D9F2	|
	LDA $5B					;$05D9F4	|
	AND.b #$01				;$05D9F6	|
	BNE CODE_05DA01				;$05D9F8	|
	LDA $01					;$05D9FA	|
	STA $95					;$05D9FC	|
	JMP CODE_05DA17				;$05D9FE	|

CODE_05DA01:
	LDA $01
	STA $97					;$05DA03	|
	STA $1D					;$05DA05	|
	SEP #$10				;$05DA07	|
	LDY.w $1414				;$05DA09	|
	CPY.b #$03				;$05DA0C	|
	BEQ CODE_05DA12				;$05DA0E	|
	STA $21					;$05DA10	|
CODE_05DA12:
	LDA.b #$01
	STA.w $1412				;$05DA14	|
CODE_05DA17:
	SEP #$30
	LDA.w $13BF				;$05DA19	|
	CMP.b #$52				;$05DA1C	|
	BCC CODE_05DA24				;$05DA1E	|
	LDX.b #$03				;$05DA20	|
	BRA CODE_05DA38				;$05DA22	|

CODE_05DA24:
	LDX.b #$04
	LDY.b #$04				;$05DA26	|
	LDA [$65],Y				;$05DA28	|
	AND.b #$0F				;$05DA2A	|
CODE_05DA2C:
	CMP.l DATA_05D760,X
	BEQ CODE_05DA38				;$05DA30	|
	DEX					;$05DA32	|
	BPL CODE_05DA2C				;$05DA33	|
CODE_05DA35:
	JMP CODE_05DAD7

CODE_05DA38:
	LDA.w $141A
	BNE CODE_05DA35				;$05DA3B	|
	LDA.w $141D				;$05DA3D	|
	BNE CODE_05DA35				;$05DA40	|
	LDA.w $141F				;$05DA42	|
	BNE CODE_05DA35				;$05DA45	|
	LDA.w $13BF				;$05DA47	|
	CMP.b #$31				;$05DA4A	|
	BEQ CODE_05DA5E				;$05DA4C	|
	CMP.b #$32				;$05DA4E	|
	BEQ CODE_05DA5E				;$05DA50	|
	CMP.b #$34				;$05DA52	|
	BEQ CODE_05DA5E				;$05DA54	|
	CMP.b #$35				;$05DA56	|
	BEQ CODE_05DA5E				;$05DA58	|
	CMP.b #$40				;$05DA5A	|
	BNE CODE_05DA60				;$05DA5C	|
CODE_05DA5E:
	LDX.b #$05
CODE_05DA60:
	LDA.w $13CF
	BNE CODE_05DAD0				;$05DA63	|
	LDA.l DATA_05D790,X			;$05DA65	|
	STA $96					;$05DA69	|
	LDA.b #$01				;$05DA6B	|
	STA $97					;$05DA6D	|
	LDA.b #$30				;$05DA6F	|
	STA $94					;$05DA71	|
	STZ $95					;$05DA73	|
	LDA.b #$C0				;$05DA75	|
	STA $1C					;$05DA77	|
	STA $20					;$05DA79	|
	STZ.w $192A				;$05DA7B	|
	LDA.b #$EE				;$05DA7E	|
	STA $CE					;$05DA80	|
	LDA.b #$C3				;$05DA82	|
	STA $CF					;$05DA84	|
	LDA.b #$07				;$05DA86	|
	STA $D0					;$05DA88	|
	LDA [$CE]				;$05DA8A	|
	AND.b #$3F				;$05DA8C	|
	STA.w $1692				;$05DA8E	|
	LDA [$CE]				;$05DA91	|
	AND.b #$C0				;$05DA93	|
	STA.w $190E				;$05DA95	|
	STZ.w $1413				;$05DA98	|
	STZ.w $1414				;$05DA9B	|
	STZ.w $1411				;$05DA9E	|
	STZ $5B					;$05DAA1	|
	LDA.l DATA_05D78A,X			;$05DAA3	|
	STA.w $1BE3				;$05DAA7	|
	STX $00					;$05DAAA	|
	TXA					;$05DAAC	|
	ASL					;$05DAAD	|
	CLC					;$05DAAE	|
	ADC $00					;$05DAAF	|
	TAY					;$05DAB1	|
	LDA.w PtrsLong05D766,Y			;$05DAB2	|
	STA $65					;$05DAB5	|
	LDA.w PtrsLong05D766+1,Y		;$05DAB7	|
	STA $66					;$05DABA	|
	LDA.w PtrsLong05D766+2,Y		;$05DABC	|
	STA $67					;$05DABF	|
	LDA.w PtrsLong05D778,Y			;$05DAC1	|
	STA $68					;$05DAC4	|
	LDA.w PtrsLong05D778+1,Y		;$05DAC6	|
	STA $69					;$05DAC9	|
	LDA.w PtrsLong05D778+2,Y		;$05DACB	|
	STA $6A					;$05DACE	|
CODE_05DAD0:
	LDA.l DATA_05D760,X
	STA.w $1931				;$05DAD4	|
CODE_05DAD7:
	LDA.w $141A
	BEQ CODE_05DAEB				;$05DADA	|
	LDA.w $1425				;$05DADC	|
	BNE CODE_05DAEB				;$05DADF	|
	LDA.w $13BF				;$05DAE1	|
	CMP.b #$24				;$05DAE4	|
	BNE CODE_05DAEB				;$05DAE6	|
	JSR CODE_05DAEF				;$05DAE8	|
CODE_05DAEB:
	PLB
	SEP #$30				;$05DAEC	|
	RTL					;$05DAEE	|

CODE_05DAEF:
	SEP #$30
	LDY.b #$04				;$05DAF1	|
	LDA [$65],Y				;$05DAF3	|
	AND.b #$C0				;$05DAF5	|
	CLC					;$05DAF7	|
	ROL					;$05DAF8	|
	ROL					;$05DAF9	|
	ROL					;$05DAFA	|
	JSL ExecutePtrLong			;$05DAFB	|

PtrsLong05DAFF:
	dl CODE_05DB3E
	dl CODE_05DB6E
	dl CODE_05DB82

ChocIsld2Layer1:
	dw DATA_06EC24
	dw DATA_06EC7E
	dw DATA_06EC7E
	dw DATA_06E985
	dw DATA_06E9FB
	dw DATA_06EAB0
	dw DATA_06EB0B
	dw DATA_06EB72
	dw DATA_06EBBE

ChocIsld2Sprites:
	dw DATA_07D899
	dw DATA_07D8A1
	dw DATA_07D8A1
	dw DATA_07D7E5
	dw DATA_07D7EA
	dw DATA_07D825
	dw DATA_07D84B
	dw DATA_07D86E
	dw DATA_07D888

ChocIsld2Layer2:
	dw DATA_0CDF59
	dw DATA_0CDF59
	dw DATA_0CDF59
	dw DATA_0CDF59
	dw DATA_0CDF59
	dw DATA_0CDF59
	dw DATA_0CDF59
	dw DATA_0CDF59
	dw DATA_0CDF59

CODE_05DB3E:
	LDX.b #$00
	LDA.w $1422				;$05DB40	|
	CMP.b #$04				;$05DB43	|
	BEQ CODE_05DB49				;$05DB45	|
	LDX.b #$02				;$05DB47	|
CODE_05DB49:
	REP #$20
	LDA.l ChocIsld2Layer1,X			;$05DB4B	|
	STA $65					;$05DB4F	|
	LDA.l ChocIsld2Sprites,X		;$05DB51	|
	STA $CE					;$05DB55	|
	LDA.l ChocIsld2Layer2,X			;$05DB57	|
	STA $68					;$05DB5B	|
	SEP #$20				;$05DB5D	|
	LDA [$CE]				;$05DB5F	|
	AND.b #$7F				;$05DB61	|
	STA.w $1692				;$05DB63	|
	LDA [$CE]				;$05DB66	|
	AND.b #$80				;$05DB68	|
	STA.w $190E				;$05DB6A	|
	RTS					;$05DB6D	|

CODE_05DB6E:
	LDX.b #$0A
	LDA.w $0DC0				;$05DB70	|
	CMP.b #$16				;$05DB73	|
	BPL CODE_05DB7F				;$05DB75	|
	LDX.b #$08				;$05DB77	|
	CMP.b #$0A				;$05DB79	|
	BPL CODE_05DB7F				;$05DB7B	|
	LDX.b #$06				;$05DB7D	|
CODE_05DB7F:
	JMP CODE_05DB49

CODE_05DB82:
	LDX.b #$0C
	LDA.w $0F31				;$05DB84	|
	CMP.b #$02				;$05DB87	|
	BMI CODE_05DBA6				;$05DB89	|
	LDA.w $0F32				;$05DB8B	|
	CMP.b #$03				;$05DB8E	|
	BMI CODE_05DBA6				;$05DB90	|
	BNE CODE_05DB9B				;$05DB92	|
	LDA.w $0F33				;$05DB94	|
	CMP.b #$05				;$05DB97	|
	BMI CODE_05DBA6				;$05DB99	|
CODE_05DB9B:
	LDX.b #$0E
	LDA.w $0F32				;$05DB9D	|
	CMP.b #$05				;$05DBA0	|
	BMI CODE_05DBA6				;$05DBA2	|
	LDX.b #$10				;$05DBA4	|
CODE_05DBA6:
	JMP CODE_05DB49

DATA_05DBA9:
	db $00,$C8,$00

CODE_05DBAC:
	LDY.b #$00
	LDA.w $1B95				;$05DBAE	|
	BEQ CODE_05DBB5				;$05DBB1	|
	LDY.b #$01				;$05DBB3	|
CODE_05DBB5:
	LDX $95
	LDA $5B					;$05DBB7	|
	AND.b #$01				;$05DBB9	|
	BEQ CODE_05DBBF				;$05DBBB	|
	LDX $97					;$05DBBD	|
CODE_05DBBF:
	LDA.w DATA_05DBA9,Y
	STA.w $19B8,X				;$05DBC2	|
	INC.w $141A				;$05DBC5	|
	RTS					;$05DBC8	|

DATA_05DBC9:
	db $50,$88,$00,$03,$FE,$38,$FE,$38
	db $FF,$B8,$3C,$B9,$3C,$BA,$3C,$BB
	db $3C,$BA,$3C,$BA,$BC,$BC,$3C,$BD
	db $3C,$BE,$3C,$BF,$3C,$C0,$3C,$B7
	db $BC,$C1,$3C,$B9,$3C,$C2,$3C,$C2
	db $BC

CODE_05DBF2:
	PHB
	PHK					;$05DBF3	|
	PLB					;$05DBF4	|
	LDX.b #$08				;$05DBF5	|
CODE_05DBF7:
	LDA.w DATA_05DBC9,X
	STA.l $7F837D,X				;$05DBFA	|
	DEX					;$05DBFE	|
	BPL CODE_05DBF7				;$05DBFF	|
	LDX.b #$00				;$05DC01	|
	LDA.w $0DB3				;$05DC03	|
	BEQ CODE_05DC0A				;$05DC06	|
	LDX.b #$01				;$05DC08	|
CODE_05DC0A:
	LDA.w $0DB4,X
	INC A					;$05DC0D	|
	JSR CODE_05DC3A				;$05DC0E	|
	CPX.b #$00				;$05DC11	|
	BEQ CODE_05DC23				;$05DC13	|
	CLC					;$05DC15	|
	ADC.b #$22				;$05DC16	|
	STA.l $7F8383				;$05DC18	|
	LDA.b #$39				;$05DC1C	|
	STA.l $7F8384				;$05DC1E	|
	TXA					;$05DC22	|
CODE_05DC23:
	CLC
	ADC.b #$22				;$05DC24	|
	STA.l $7F8381				;$05DC26	|
	LDA.b #$39				;$05DC2A	|
	STA.l $7F8382				;$05DC2C	|
	LDA.b #$08				;$05DC30	|
	STA.l $7F837B				;$05DC32	|
	SEP #$20				;$05DC36	|
	PLB					;$05DC38	|
	RTL					;$05DC39	|

CODE_05DC3A:
	LDX.b #$00
CODE_05DC3C:
	CMP.b #$0A
	BCC Return05DC45			;$05DC3E	|
	SBC.b #$0A				;$05DC40	|
	INX					;$05DC42	|
	BRA CODE_05DC3C				;$05DC43	|

Return05DC45:
	RTS

Empty05DC46:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF

Layer1Ptrs:
	dl DATA_068654
	dl DATA_06BA69
	dl DATA_06BC33
	dl DATA_0688BF
	dl DATA_069807
	dl DATA_069961
	dl DATA_069BB5
	dl DATA_069DC0
	dl DATA_06876E
	dl DATA_06962D
	dl DATA_06A134
	dl DATA_06BD0F
	dl DATA_06D000
	dl DATA_06D0F4
	dl DATA_06C3A3
	dl DATA_06BEAD
	dl DATA_06C1C4
	dl DATA_06C783
	dl DATA_068000
	dl DATA_06A2F2
	dl DATA_06868D
	dl DATA_0691E5
	dl DATA_0691E5
	dl DATA_0691E5
	dl DATA_078C14
	dl DATA_068000
	dl DATA_0789CC
	dl DATA_06EE36
	dl DATA_0786E3
	dl LevelData078100
	dl DATA_068000
	dl DATA_06E20A
	dl DATA_06D9D9
	dl DATA_06E7A2
	dl DATA_06E444
	dl DATA_06ECC9
	dl DATA_06E897
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068561
	dl DATA_06858B
	dl DATA_068258
	dl DATA_06825E
	dl DATA_06825E
	dl DATA_068258
	dl DATA_068258
	dl DATA_068258
	dl DATA_068252
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_078935
	dl DATA_06E76E
	dl DATA_06C199
	dl DATA_0788CB
	dl DATA_06C375
	dl DATA_06A270
	dl DATA_069D83
	dl DATA_06994F
	dl DATA_068603
	dl DATA_06C949
	dl DATA_0685B5
	dl DATA_07977C
	dl DATA_06887D
	dl DATA_0687AE
	dl DATA_06BCEE
	dl DATA_068636
	dl DATA_06EC24
	dl DATA_06EB0B
	dl DATA_06E985
	dl DATA_06E444
	dl DATA_06E444
	dl DATA_069D4C
	dl DATA_078BEA
	dl DATA_078B4A
	dl DATA_068636
	dl DATA_06E307
	dl DATA_06EDE7
	dl DATA_06BBC9
	dl DATA_068636
	dl DATA_06C6EC
	dl DATA_06C559
	dl DATA_06C495
	dl DATA_06D1D6
	dl DATA_06989D
	dl DATA_068636
	dl DATA_06BDB6
	dl DATA_06BDB6
	dl DATA_068636
	dl DATA_069473
	dl DATA_06A44F
	dl DATA_068636
	dl DATA_06A09D
	dl DATA_069F64
	dl DATA_069E2E
	dl DATA_06978E
	dl DATA_0785B4
	dl DATA_068621
	dl DATA_06A2F2
	dl DATA_06A374
	dl DATA_06A2F2
	dl DATA_06EEFD
	dl DATA_068621
	dl DATA_06A420
	dl DATA_06A374
	dl DATA_06D0DC
	dl DATA_069B1E
	dl DATA_06E5D0
	dl DATA_06E5D0
	dl DATA_078DAB
	dl DATA_078CC6
	dl DATA_06989D
	dl DATA_06987B
	dl DATA_068621
	dl DATA_06E815
	dl DATA_0693DC
	dl DATA_0698F0
	dl DATA_06863C
	dl DATA_068654
	dl DATA_068FFD
	dl DATA_068EAD
	dl DATA_068BDE
	dl DATA_07802D
	dl DATA_0688DD
	dl DATA_068A2F
	dl DATA_06AD09
	dl DATA_0780C3
	dl DATA_06B817
	dl DATA_06AE7D
	dl DATA_06A461
	dl DATA_068000
	dl LevelDataSpr07A600
	dl DATA_07ABF9
	dl DATA_079B58
	dl DATA_079DE2
	dl DATA_07A028
	dl DATA_068000
	dl DATA_0799D6
	dl DATA_079803
	dl DATA_0792CA
	dl DATA_078EA4
	dl DATA_06F05D
	dl DATA_06A95F
	dl DATA_06B2D1
	dl DATA_06A600
	dl DATA_0686D0
	dl DATA_06B4E0
	dl DATA_06DABE
	dl DATA_06D23A
	dl DATA_06DF5B
	dl DATA_06D40B
	dl DATA_06872B
	dl DATA_06E183
	dl DATA_06D6F3
	dl DATA_068000
	dl DATA_07BF65
	dl DATA_07BDE5
	dl DATA_07BC11
	dl DATA_07BABE
	dl DATA_068000
	dl DATA_07B26B
	dl DATA_07B46E
	dl DATA_07B540
	dl DATA_07B908
	dl DATA_068000
	dl DATA_068000
	dl DATA_07AF25
	dl DATA_068000
	dl DATA_07AFE3
	dl DATA_068000
	dl DATA_07AD35
	dl DATA_07B031
	dl DATA_07B124
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_06858B
	dl DATA_068561
	dl DATA_068258
	dl DATA_06825E
	dl DATA_06825E
	dl DATA_068258
	dl DATA_068258
	dl DATA_068258
	dl DATA_068252
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_068000
	dl DATA_079AC1
	dl DATA_06D942
	dl DATA_07AAC9
	dl DATA_068FB1
	dl DATA_079D84
	dl LevelData
	dl DATA_06E128
	dl DATA_06B1B5
	dl DATA_06ACA8
	dl DATA_07B3C6
	dl DATA_07B3C6
	dl DATA_06A56D
	dl DATA_07AD2F
	dl DATA_07B896
	dl DATA_07B87D
	dl DATA_068BB3
	dl DATA_0689F8
	dl DATA_07AA77
	dl DATA_07AA16
	dl DATA_07A961
	dl DATA_07A8D9
	dl DATA_07A83F
	dl DATA_07A802
	dl DATA_07A765
	dl DATA_07A707
	dl DATA_07A68E
	dl DATA_07AFCE
	dl DATA_07AF16
	dl DATA_068838
	dl DATA_0687F3
	dl DATA_079803
	dl DATA_068621
	dl DATA_079969
	dl DATA_079969
	dl DATA_079867
	dl DATA_068636
	dl DATA_06E104
	dl DATA_07BD8A
	dl DATA_07BD75
	dl DATA_0795F0
	dl DATA_0793E2
	dl DATA_079233
	dl DATA_079221
	dl DATA_06DF46
	dl DATA_068621
	dl DATA_06DABE
	dl DATA_06DABE
	dl DATA_06AE18
	dl DATA_068687
	dl DATA_06F35D
	dl DATA_06F164
	dl DATA_06F4FC
	dl DATA_06A8E9
	dl DATA_06BA33
	dl DATA_06BA06
	dl DATA_06B7ED
	dl DATA_06B666
	dl DATA_06B620
	dl DATA_06B422
	dl DATA_068687
	dl DATA_06B23A
	dl DATA_06D914
	dl DATA_068621
	dl DATA_06DED2
	dl DATA_06AD09
	dl DATA_06916F
	dl DATA_068E6D
	dl DATA_079F22
	dl DATA_068F93

Layer2Ptrs:
	dl $FFE674
	dl $FFDD44
	dl $FFDD44
	dl $FFEC82
	dl $FFEF80
	dl $FFEC82
	dl $FFDE54
	dl $FFF45A
	dl $FFE674
	dl DATA_06956D
	dl $FFDAB9
	dl $FFF45A
	dl $FFDD44
	dl $FFDD44
	dl DATA_06C46E
	dl $FFDD44
	dl $FFDD44
	dl $FFDAB9
	dl $FFDE54
	dl $FFEF80
	dl $FFE674
	dl $FFDE54
	dl $FFDE54
	dl $FFD900
	dl $FFDAB9
	dl $FFD900
	dl DATA_078B1D
	dl $FFF45A
	dl $FFE7C0
	dl $FFE8FE
	dl $FFD900
	dl $FFE103
	dl $FFF45A
	dl $FFEF80
	dl $FFDE54
	dl $FFE7C0
	dl $FFDF59
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFE674
	dl $FFDF59
	dl $FFDD44
	dl $FFDF59
	dl $FFDF59
	dl $FFE8FE
	dl $FFDE54
	dl DATA_06861B
	dl $FFD900
	dl $FFE472
	dl $FFDF59
	dl $FFE684
	dl $FFE674
	dl $FFE674
	dl $FFDD44
	dl $FFF45A
	dl $FFDF59
	dl $FFDF59
	dl $FFDF59
	dl $FFDE54
	dl $FFDE54
	dl $FFE8FE
	dl $FFF45A
	dl DATA_078BB7
	dl $FFF45A
	dl $FFF45A
	dl $FFDD44
	dl $FFE8FE
	dl $FFF45A
	dl $FFE674
	dl $FFF45A
	dl DATA_06C514
	dl $FFDD44
	dl $FFEF80
	dl $FFD900
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFDE54
	dl $FFEF80
	dl $FFF45A
	dl $FFE674
	dl DATA_069EBF
	dl $FFF45A
	dl $FFE8FE
	dl $FFE8FE
	dl DATA_06861B
	dl $FFEF80
	dl $FFEF80
	dl $FFEF80
	dl $FFF45A
	dl DATA_06861B
	dl $FFEF80
	dl $FFEF80
	dl $FFDD44
	dl $FFE674
	dl $FFDE54
	dl $FFDE54
	dl $FFE8EE
	dl $FFF175
	dl $FFEF80
	dl $FFEF80
	dl DATA_06861B
	dl $FFEF80
	dl $FFE674
	dl $FFEF80
	dl $FFDE54
	dl $FFE674
	dl $FFE103
	dl $FFDF59
	dl $FFDF59
	dl $FFD900
	dl $FFD900
	dl $FFEC82
	dl $FFEF80
	dl $FFE7C0
	dl $FFE8FE
	dl $FFE8FE
	dl $FFE8FE
	dl $FFD900
	dl $FFE103
	dl $FFF45A
	dl $FFE8FE
	dl $FFF45A
	dl DATA_07A134
	dl $FFD900
	dl $FFE8FE
	dl $FFEF80
	dl DATA_07937C
	dl $FFE8FE
	dl $FFE8FE
	dl $FFE8FE
	dl $FFE684
	dl $FFE8FE
	dl $FFE674
	dl $FFF45A
	dl DATA_06DB8D
	dl $FFEC82
	dl $FFEC82
	dl $FFDAB9
	dl $FFE674
	dl $FFEC82
	dl $FFEC82
	dl $FFD900
	dl $FFDC71
	dl $FFEC82
	dl $FFE7C0
	dl $FFDF59
	dl $FFD900
	dl $FFDD44
	dl $FFE472
	dl $FFD900
	dl $FFDF59
	dl $FFD900
	dl $FFD900
	dl $FFDAB9
	dl $FFD900
	dl $FFE684
	dl $FFD900
	dl $FFE8FE
	dl $FFE684
	dl $FFE684
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFD900
	dl $FFE674
	dl $FFE674
	dl $FFF45A
	dl $FFDF59
	dl $FFE8FE
	dl $FFDF59
	dl $FFDAB9
	dl $FFE8FE
	dl $FFE8FE
	dl $FFDD44
	dl $FFDD44
	dl $FFD900
	dl $FFF45A
	dl $FFDD44
	dl $FFDD44
	dl $FFE8FE
	dl $FFE8FE
	dl $FFF45A
	dl $FFE103
	dl DATA_07A9E3
	dl DATA_07A934
	dl $FFE103
	dl $FFF45A
	dl $FFF45A
	dl $FFF45A
	dl $FFE103
	dl $FFDD44
	dl $FFDD44
	dl $FFE674
	dl $FFE674
	dl $FFEF80
	dl DATA_06861B
	dl $FFEF80
	dl $FFEF80
	dl $FFEF80
	dl $FFF45A
	dl $FFE8FE
	dl $FFDD44
	dl $FFE7C0
	dl DATA_07975E
	dl DATA_0795A5
	dl $FFE674
	dl $FFE8FE
	dl DATA_06861B
	dl DATA_06861B
	dl DATA_06DB8D
	dl DATA_06DB8D
	dl $FFEF80
	dl $FFF45A
	dl DATA_06F42A
	dl $FFE8FE
	dl $FFE8FE
	dl $06A93E
	dl $FFE8FE
	dl $FFE8FE
	dl $FFF45A
	dl DATA_06B74B
	dl $FFF45A
	dl $FFE8FE
	dl $FFF45A
	dl $FFE674
	dl $FFE8FE
	dl DATA_06861B
	dl $FFEF80
	dl $FFEF80
	dl $FFE103
	dl $FFE8FE
	dl $FFF45A
	dl $FFDF59

Ptrs05EC00:
	dw DATA_07C407
	dw DATA_07CE1C
	dw DATA_07CEBF
	dw DATA_07C4C5
	dw DATA_07C7B5
	dw DATA_07C7D9
	dw DATA_07C844
	dw DATA_07C904
	dw DATA_07C49D
	dw DATA_07C751
	dw DATA_07C948
	dw DATA_07CF06
	dw DATA_07D1F5
	dw DATA_07D25A
	dw DATA_07D0D7
	dw DATA_07CFAF
	dw DATA_07D043
	dw DATA_07D157
	dw DATA_07E76D
	dw DATA_07C9CA
	dw DATA_07C446
	dw DATA_07C6D5
	dw DATA_07C6D5
	dw DATA_07C6D5
	dw DATA_07DC2D
	dw DATA_07E76D
	dw DATA_07DBBB
	dw DATA_07D95E
	dw DATA_07DB0F
	dw DATA_07DA93
	dw DATA_07E76D
	dw DATA_07D648
	dw DATA_07D4CD
	dw DATA_07D74C
	dw DATA_07D6D9
	dw DATA_07D8BE
	dw DATA_07D7BF
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07C3DB
	dw DATA_07C3E3
	dw DATA_07C367
	dw DATA_07C359
	dw DATA_07C354
	dw DATA_07C34F
	dw DATA_07C34A
	dw DATA_07C345
	dw DATA_07C340
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07C3EE
	dw DATA_07D741
	dw DATA_07D02F
	dw DATA_07DB95
	dw DATA_07D0CF
	dw DATA_07C9AA
	dw DATA_07C8EA
	dw DATA_07C3F5
	dw DATA_07C441
	dw DATA_07C3F0
	dw DATA_07C427
	dw DATA_07DDCF
	dw DATA_07C4C0
	dw DATA_07C44B
	dw DATA_07C3F0
	dw DATA_07D51D
	dw DATA_07D899
	dw DATA_07D84B
	dw DATA_07D7E5
	dw DATA_07D6D9
	dw DATA_07D6D9
	dw DATA_07C8CD
	dw DATA_07DC22
	dw DATA_07DBF9
	dw DATA_07C414
	dw DATA_07D668
	dw DATA_07D956
	dw DATA_07CEBA
	dw DATA_07D152
	dw DATA_07C3EE
	dw DATA_07D111
	dw DATA_07D0F4
	dw DATA_07D304
	dw DATA_07C7BD
	dw DATA_07C414
	dw DATA_07CF4D
	dw DATA_07CF4D
	dw DATA_07C414
	dw DATA_07C749
	dw DATA_07CA0C
	dw DATA_07C943
	dw DATA_07C3EE
	dw DATA_07C926
	dw DATA_07C915
	dw DATA_07C7A7
	dw DATA_07DADD
	dw DATA_07C40C
	dw DATA_07C9CA
	dw DATA_07C9DB
	dw DATA_07C9CA
	dw DATA_07D9B1
	dw DATA_07C3F5
	dw DATA_07C9F2
	dw DATA_07C9DB
	dw DATA_07C3F0
	dw DATA_07C3EE
	dw DATA_07D6D9
	dw DATA_07D6D9
	dw DATA_07DC61
	dw DATA_07DC3B
	dw DATA_07C7BD
	dw DATA_07C3EE
	dw DATA_07C3F5
	dw DATA_07D799
	dw DATA_07C3EE
	dw DATA_07C7CB
	dw DATA_07C3F0
	dw DATA_07C407
	dw DATA_07C66F
	dw DATA_07C5F4
	dw DATA_07C593
	dw DATA_07E759
	dw DATA_07C4CA
	dw DATA_07C532
	dw DATA_07CBDC
	dw DATA_07E76D
	dw DATA_07CDC8
	dw DATA_07CC25
	dw DATA_07CA17
	dw DATA_07E76D
	dw DATA_07C422
	dw DATA_07E19D
	dw DATA_07DF08
	dw DATA_07DFB1
	dw DATA_07E032
	dw DATA_07E76D
	dw DATA_07DE4F
	dw DATA_07DE01
	dw DATA_07DD7B
	dw DATA_07DD14
	dw DATA_07D9EF
	dw DATA_07CB2A
	dw DATA_07CCD4
	dw DATA_07CA87
	dw DATA_07C450
	dw DATA_07CD68
	dw DATA_07D522
	dw DATA_07D30C
	dw DATA_07D577
	dw DATA_07D380
	dw DATA_07C478
	dw DATA_07D5F5
	dw DATA_07D445
	dw DATA_07E76D
	dw DATA_07E6F4
	dw DATA_07E650
	dw DATA_07E5DF
	dw DATA_07E574
	dw DATA_07E76D
	dw DATA_07E3DC
	dw DATA_07E428
	dw DATA_07E466
	dw DATA_07E4F1
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E221
	dw DATA_07E76D
	dw DATA_07E29E
	dw DATA_07E76D
	dw DATA_07E1C5
	dw DATA_07E2AF
	dw DATA_07E335
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07C3E3
	dw DATA_07C3DB
	dw DATA_07C367
	dw DATA_07C359
	dw DATA_07C354
	dw DATA_07C34F
	dw DATA_07C34A
	dw DATA_07C345
	dw DATA_07C340
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07E76D
	dw DATA_07C3EE
	dw DATA_07C3EE
	dw DATA_07E19D
	dw DATA_07C661
	dw DATA_07DF94
	dw DATA_07DA7F
	dw DATA_07D5CF
	dw DATA_07CCBA
	dw DATA_07CBC5
	dw DATA_07E402
	dw DATA_07E402
	dw DATA_07CA6D
	dw DATA_07E1C0
	dw DATA_07E4EC
	dw DATA_07C3EE
	dw DATA_07C57F
	dw DATA_07C3EE
	dw DATA_07E183
	dw DATA_07E160
	dw DATA_07E131
	dw DATA_07E114
	dw DATA_07C422
	dw DATA_07E0E8
	dw DATA_07E0C5
	dw DATA_07E08D
	dw DATA_07E067
	dw DATA_07C3F0
	dw DATA_07C3F0
	dw DATA_07C498
	dw DATA_07C473
	dw DATA_07DE01
	dw DATA_07C3F5
	dw DATA_07DE3B
	dw DATA_07DE3B
	dw DATA_07DE0F
	dw DATA_07C414
	dw DATA_07D5C7
	dw DATA_07C3EE
	dw DATA_07C3F0
	dw DATA_07DDB8
	dw DATA_07DDB3
	dw DATA_07C3EE
	dw DATA_07DD76
	dw DATA_07C3F5
	dw DATA_07C40C
	dw DATA_07D522
	dw DATA_07D522
	dw DATA_07CC11
	dw DATA_07E024
	dw DATA_07DA44
	dw DATA_07DA12
	dw DATA_07C3F0
	dw DATA_07CB01
	dw DATA_07CE14
	dw DATA_07CE0C
	dw DATA_07CDC0
	dw DATA_07CD94
	dw DATA_07C3EE
	dw DATA_07CD63
	dw DATA_07C6D0
	dw DATA_07C3EE
	dw DATA_07D4C5
	dw DATA_07C3F5
	dw DATA_07D56C
	dw DATA_07CBDC
	dw DATA_07C6BF
	dw DATA_07C5EF
	dw DATA_07DFE0
	dw DATA_07C659

DATA_05F000:
	db $07,$5B,$19,$2B,$1B,$5B,$5B,$5B
	db $27,$37,$18,$19,$59,$5B,$29,$1B
	db $5B,$58,$05,$5B,$2B,$5B,$1B,$1B
	db $51,$0B,$4B,$1B,$07,$52,$0B,$1B
	db $57,$1B,$5B,$5B,$5B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$57,$57,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$6C,$18,$19
	db $1A,$51,$0D,$1A,$2B,$5B,$1B,$5A
	db $6B,$2B,$2B,$18,$0B,$1B,$1B,$5B
	db $59,$58,$19,$57,$49,$0B,$5B,$52
	db $19,$0B,$6C,$0C,$48,$18,$5A,$0B
	db $59,$59,$0B,$5A,$2A,$0B,$6C,$7D
	db $5B,$5A,$00,$2B,$5B,$5B,$5B,$17
	db $2B,$5B,$58,$18,$6C,$59,$58,$01
	db $17,$5B,$1B,$2B,$1B,$6C,$5A,$2A
	db $07,$1B,$18,$5B,$0B,$5B,$5B,$5B
	db $0B,$0D,$58,$5B,$0B,$1A,$1B,$58
	db $5B,$48,$0B,$1B,$0A,$4B,$5B,$57
	db $52,$17,$57,$2B,$17,$29,$1C,$5B
	db $59,$2B,$56,$1C,$0B,$5B,$1C,$1B
	db $1A,$0B,$05,$58,$5B,$19,$0B,$0B
	db $58,$0B,$5B,$0B,$01,$5B,$5B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$57,$57,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$6C,$6C,$1B,$5A,$16
	db $1A,$19,$16,$16,$58,$5C,$1A,$0B
	db $5D,$19,$19,$19,$1B,$1B,$73,$4B
	db $1A,$59,$59,$1B,$1B,$1B,$1B,$2B
	db $2B,$09,$2B,$0B,$0B,$09,$0B,$29
	db $52,$1B,$48,$4B,$6C,$5B,$2B,$2B
	db $2B,$29,$5B,$0B,$4B,$01,$5B,$49
	db $1B,$1B,$57,$48,$1B,$19,$0B,$6C
	db $28,$2B,$1B,$5A,$1B,$19,$19,$1B
DATA_05F200:
	db $20,$00,$80,$01,$00,$01,$00,$00
	db $00,$C0,$38,$39,$00,$00,$00,$00
	db $00,$F8,$00,$00,$00,$00,$00,$00
	db $F8,$00,$C0,$00,$00,$01,$00,$80
	db $01,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$01,$01,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$10,$A0,$20
	db $18,$A0,$18,$18,$00,$01,$18,$00
	db $01,$10,$10,$10,$00,$10,$10,$10
	db $31,$30,$20,$01,$C0,$00,$00,$18
	db $20,$00,$10,$01,$C1,$20,$01,$00
	db $39,$39,$00,$18,$00,$00,$10,$C0
	db $01,$18,$01,$00,$00,$03,$03,$00
	db $00,$01,$00,$10,$10,$31,$30,$20
	db $38,$00,$00,$00,$00,$10,$01,$18
	db $20,$00,$80,$00,$01,$00,$00,$00
	db $00,$01,$00,$28,$00,$00,$00,$00
	db $01,$C0,$00,$00,$00,$C0,$00,$00
	db $01,$00,$00,$00,$01,$00,$00,$00
	db $38,$00,$00,$00,$00,$00,$00,$40
	db $00,$00,$01,$01,$00,$28,$00,$00
	db $F8,$00,$00,$00,$01,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$01,$01,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$10,$10,$00,$18,$28
	db $18,$F8,$28,$28,$1B,$19,$18,$00
	db $00,$20,$20,$20,$00,$00,$F8,$C0
	db $00,$00,$00,$00,$80,$18,$10,$10
	db $10,$03,$00,$03,$00,$01,$00,$20
	db $18,$10,$D1,$D1,$10,$18,$00,$00
	db $01,$01,$01,$00,$D1,$10,$10,$D0
	db $09,$11,$01,$C0,$00,$20,$00,$10
	db $20,$00,$01,$01,$80,$20,$00,$10
DATA_05F400:
	db $0A,$9A,$8A,$0A,$0A,$AA,$AA,$0A
	db $0A,$0A,$0A,$0A,$0A,$9A,$0A,$9A
	db $9A,$0A,$02,$0A,$0A,$9A,$9A,$9A
	db $03,$0A,$BA,$8A,$BA,$00,$0A,$0A
	db $0A,$0A,$9A,$9A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$00,$00,$00
	db $00,$00,$00,$00,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$09,$0A,$0A
	db $0A,$0A,$0A,$0A,$00,$0A,$0A,$0A
	db $9A,$9A,$0A,$0A,$0B,$00,$0A,$03
	db $0A,$00,$0A,$0A,$0A,$0A,$0A,$00
	db $0A,$0A,$00,$0A,$0A,$00,$0A,$03
	db $0A,$0A,$00,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$03
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$7A,$0A,$9A,$0A,$9A,$9A,$0A
	db $0A,$02,$FA,$0A,$0A,$0A,$6A,$9A
	db $7A,$0A,$0A,$8A,$0A,$7A,$9A,$7A
	db $A0,$9A,$FA,$0A,$9A,$0A,$9A,$9A
	db $0A,$0A,$05,$9A,$0A,$0A,$9A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$03,$9A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$00,$00,$00
	db $00,$00,$00,$00,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$00
	db $0A,$0A,$0A,$0A,$0A,$0A,$03,$0A
	db $0A,$09,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$00,$0A
	db $03,$0A,$0B,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$00,$0A,$03,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$00,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
DATA_05F600:
	db $00,$00,$80,$00,$00,$80,$00,$00
	db $00,$00,$00,$00,$80,$80,$00,$80
	db $00,$00,$64,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$80,$80,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$03,$64,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $10,$07,$00,$00,$00,$00,$00,$00
	db $04,$00,$00,$64,$09,$00,$01,$00
	db $04,$00,$00,$00,$00,$00,$00,$67
	db $02,$00,$60,$00,$02,$04,$04,$00
	db $00,$01,$00,$00,$00,$10,$07,$60
	db $00,$00,$00,$00,$00,$00,$01,$00
	db $00,$00,$80,$80,$00,$00,$00,$00
	db $00,$66,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$80,$00,$00,$00,$00
	db $00,$80,$00,$00,$00,$00,$00,$00
	db $00,$00,$80,$00,$00,$00,$00,$00
	db $00,$00,$E4,$00,$80,$00,$00,$00
	db $80,$00,$80,$00,$E0,$80,$80,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$03
	db $00,$03,$00,$00,$01,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$64,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$03,$00,$03,$00,$03,$00,$00
	db $00,$00,$01,$00,$00,$00,$00,$00
	db $07,$06,$00,$00,$00,$60,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$05,$00,$00,$00,$00
DATA_05F800:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$0F
	db $1C,$10,$0A,$06,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$06,$00,$00,$00,$00,$23
	db $01,$00,$00,$00,$00,$0D,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$1D,$00,$00,$00,$00,$14
	db $00,$00,$00,$00,$05,$00,$00,$00
	db $00,$00,$00,$00,$00,$15,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$13,$23,$00,$02,$0F
	db $17,$1F,$00,$18,$00,$00,$0B,$00
	db $00,$2C,$06,$05,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $27,$00,$00,$00,$16,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$1A
	db $00,$00,$00,$00,$00,$19,$00,$0A
	db $23,$00,$00,$00,$00,$03,$00,$00
DATA_05FA00:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$AB
	db $A9,$C2,$A6,$AA,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$AA,$02
	db $AA,$00,$A8,$00,$00,$00,$00,$A8
	db $A8,$AA,$00,$AA,$00,$AB,$A9,$00
	db $00,$AB,$00,$00,$00,$00,$00,$00
	db $00,$00,$02,$00,$00,$00,$00,$AB
	db $AA,$00,$00,$00,$A9,$00,$AA,$AB
	db $00,$00,$00,$00,$00,$A9,$00,$AB
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$A8,$AA,$00,$AB,$A9
	db $A7,$AA,$00,$AA,$00,$00,$A7,$00
	db $00,$AB,$AB,$A9,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $AA,$00,$00,$00,$A8,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$A7
	db $00,$00,$00,$00,$00,$AB,$00,$AB
	db $AA,$00,$00,$00,$00,$A9,$00,$00
DATA_05FC00:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$0E
	db $2A,$25,$64,$04,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$21,$68
	db $26,$00,$08,$00,$00,$00,$00,$6D
	db $70,$2B,$00,$0D,$00,$2D,$27,$00
	db $00,$2D,$00,$00,$00,$00,$00,$00
	db $00,$00,$6A,$00,$00,$00,$00,$02
	db $6A,$00,$00,$00,$70,$00,$0E,$21
	db $00,$00,$00,$00,$00,$2B,$00,$0A
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$08,$04,$00,$05,$03
	db $26,$68,$00,$30,$00,$00,$2A,$00
	db $00,$69,$70,$08,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $2A,$00,$00,$00,$29,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$2E
	db $00,$00,$00,$00,$00,$2F,$00,$2F
	db $32,$00,$00,$00,$00,$28,$00,$00
DATA_05FE00:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$03
	db $03,$03,$07,$03,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$03,$01
	db $03,$00,$06,$00,$00,$00,$00,$04
	db $06,$03,$00,$03,$00,$03,$00,$00
	db $00,$03,$00,$00,$00,$00,$00,$00
	db $00,$00,$03,$00,$00,$00,$00,$00
	db $03,$00,$00,$00,$03,$00,$03,$02
	db $00,$00,$00,$00,$00,$04,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$04,$03,$00,$03,$03
	db $04,$03,$00,$03,$00,$00,$05,$00
	db $00,$03,$03,$06,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $03,$00,$00,$00,$03,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$02
	db $00,$00,$00,$00,$00,$03,$00,$02
	db $03,$00,$00,$00,$00,$03,$00,$00
