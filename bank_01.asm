ORG $018000

DATA_018000:
	db $80,$40,$20,$10,$08,$04,$02,$01

IsTouchingObjSide:
	LDA.w $1588,X
	AND.b #$03				;$01800B	|
	RTS					;$01800D	|

IsOnGround:
	LDA.w $1588,X
	AND.b #$04				;$018011	|
	RTS					;$018013	|

IsTouchingCeiling:
	LDA.w $1588,X
	AND.b #$08				;$018017	|
	RTS					;$018019	|

UpdateYPosNoGrvty:
	PHB
	PHK					;$01801B	|
	PLB					;$01801C	|
	JSR SubSprYPosNoGrvty			;$01801D	|
	PLB					;$018020	|
	RTL					;$018021	|

UpdateXPosNoGrvty:
	PHB
	PHK					;$018023	|
	PLB					;$018024	|
	JSR SubSprXPosNoGrvty			;$018025	|
	PLB					;$018028	|
	RTL					;$018029	|

UpdateSpritePos:
	PHB
	PHK					;$01802B	|
	PLB					;$01802C	|
	JSR SubUpdateSprPos			;$01802D	|
	PLB					;$018030	|
	RTL					;$018031	|

SprSprInteract:
	PHB
	PHK					;$018033	|
	PLB					;$018034	|
	JSR SubSprSprInteract			;$018035	|
	PLB					;$018038	|
	RTL					;$018039	|

SprSprPMarioSprRts:
	PHB
	PHK					;$01803B	|
	PLB					;$01803C	|
	JSR SubSprSprPMarioSpr			;$01803D	|
	PLB					;$018040	|
	RTL					;$018041	|

GenericSprGfxRt0:
	PHB
	PHK					;$018043	|
	PLB					;$018044	|
	JSR SubSprGfx0Entry0			;$018045	|
	PLB					;$018048	|
	RTL					;$018049	|

InvertAccum:
	EOR.b #$FF
	INC A					;$01804C	|
	RTS					;$01804D	|

CODE_01804E:
	LDA.w $1588,X
	BEQ Return018072			;$018051	|
	LDA $13					;$018053	|
	AND.b #$03				;$018055	|
	ORA $86					;$018057	|
	BNE Return018072			;$018059	|
	LDA.b #$04				;$01805B	|
	STA $00					;$01805D	|
	LDA.b #$0A				;$01805F	|
	STA $01					;$018061	|
CODE_018063:
	JSR IsSprOffScreen
	BNE Return018072			;$018066	|
	LDY.b #$03				;$018068	|
CODE_01806A:
	LDA.w $17C0,Y
	BEQ CODE_018073				;$01806D	|
	DEY					;$01806F	|
	BPL CODE_01806A				;$018070	|
Return018072:
	RTS

CODE_018073:
	LDA.b #$03
	STA.w $17C0,Y				;$018075	|
	LDA $E4,X				;$018078	|
	ADC $00					;$01807A	|
	STA.w $17C8,Y				;$01807C	|
	LDA $D8,X				;$01807F	|
	ADC $01					;$018081	|
	STA.w $17C4,Y				;$018083	|
	LDA.b #$13				;$018086	|
	STA.w $17CC,Y				;$018088	|
	RTS					;$01808B	|

CODE_01808C:
	PHB
	PHK					;$01808D	|
	PLB					;$01808E	|
	LDA.w $148F				;$01808F	|
	STA.w $1470				;$018092	|
	STZ.w $148F				;$018095	|
	STZ.w $1471				;$018098	|
	STZ.w $18C2				;$01809B	|
	LDA.w $18DF				;$01809E	|
	STA.w $18E2				;$0180A1	|
	STZ.w $18DF				;$0180A4	|
	LDX.b #$0B				;$0180A7	|
CODE_0180A9:
	STX.w $15E9
	JSR CODE_0180D2				;$0180AC	|
	JSR HandleSprite			;$0180AF	|
	DEX					;$0180B2	|
	BPL CODE_0180A9				;$0180B3	|
	LDA.w $18B8				;$0180B5	|
	BEQ CODE_0180BE				;$0180B8	|
	JSL CODE_02F808				;$0180BA	|
CODE_0180BE:
	LDA.w $18DF
	BNE CODE_0180C9				;$0180C1	|
	STZ.w $187A				;$0180C3	|
	STZ.w $188B				;$0180C6	|
CODE_0180C9:
	PLB
	RTL					;$0180CA	|

IsSprOffScreen:
	LDA.w $15A0,X
	ORA.w $186C,X				;$0180CE	|
	RTS					;$0180D1	|

CODE_0180D2:
	PHX
	TXA					;$0180D3	|
	LDX.w $1692				;$0180D4	|
	CLC					;$0180D7	|
	ADC.l DATA_07F0B4,X			;$0180D8	|
	TAX					;$0180DC	|
	LDA.l DATA_07F000,X			;$0180DD	|
	PLX					;$0180E1	|
	STA.w $15EA,X				;$0180E2	|
	LDA.w $14C8,X				;$0180E5	|
	BEQ Return018126			;$0180E8	|
	LDA $9D					;$0180EA	|
	BNE Return018126			;$0180EC	|
	LDA.w $1540,X				;$0180EE	|
	BEQ CODE_0180F6				;$0180F1	|
	DEC.w $1540,X				;$0180F3	|
CODE_0180F6:
	LDA.w $154C,X
	BEQ CODE_0180FE				;$0180F9	|
	DEC.w $154C,X				;$0180FB	|
CODE_0180FE:
	LDA.w $1558,X
	BEQ CODE_018106				;$018101	|
	DEC.w $1558,X				;$018103	|
CODE_018106:
	LDA.w $1564,X
	BEQ CODE_01810E				;$018109	|
	DEC.w $1564,X				;$01810B	|
CODE_01810E:
	LDA.w $1FE2,X
	BEQ CODE_018116				;$018111	|
	DEC.w $1FE2,X				;$018113	|
CODE_018116:
	LDA.w $15AC,X
	BEQ CODE_01811E				;$018119	|
	DEC.w $15AC,X				;$01811B	|
CODE_01811E:
	LDA.w $163E,X
	BEQ Return018126			;$018121	|
	DEC.w $163E,X				;$018123	|
Return018126:
	RTS

HandleSprite:
	LDA.w $14C8,X
	BEQ EraseSprite				;$01812A	|
	CMP.b #$08				;$01812C	|
	BNE CODE_018133				;$01812E	|
	JMP CallSpriteMain			;$018130	|

CODE_018133:
	JSL ExecutePtr

SpriteStatusRtPtr:
	dw EraseSprite
	dw CallSpriteInit
	dw HandleSprKilled
	dw HandleSprSmushed
	dw HandleSprSpinJump
	dw CODE_019A7B
	dw HandleSprLvlEnd
	dw Return018156
	dw Return0185C2
	dw HandleSprStunned
	dw HandleSprKicked
	dw HandleSprCarried
	dw HandleGoalPowerup

EraseSprite:
	LDA.b #$FF
	STA.w $161A,X				;$018153	|
Return018156:
	RTS

HandleGoalPowerup:
	JSR CallSpriteMain
	JSR SubOffscreen0Bnk1			;$01815A	|
	JSR SubUpdateSprPos			;$01815D	|
	DEC $AA,X				;$018160	|
	DEC $AA,X				;$018162	|
	JSR IsOnGround				;$018164	|
	BEQ Return01816C			;$018167	|
	JSR SetSomeYSpeed			;$018169	|
Return01816C:
	RTS

HandleSprLvlEnd:
	JSL LvlEndSprCoins
	RTS					;$018171	|

CallSpriteInit:
	LDA.b #$08
	STA.w $14C8,X				;$018174	|
	LDA $9E,X				;$018177	|
	JSL ExecutePtr				;$018179	|

SpriteInitPtr:
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitGrnBounceKoopa
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitBomb
	dw InitKeyHole
	dw InitStandardSprite
	dw InitStandardSprite
	dw InitStandardSprite
	dw UnusedInit
	dw InitStandardSprite
	dw InitStandardSprite
	dw Return01B011
	dw InitVerticalFish
	dw InitFish
	dw InitFish
	dw InitMsgPSideExit
	dw InitPiranha
	dw Return0185C2
	dw InitBulletBill
	dw InitStandardSprite
	dw InitLakitu
	dw InitMagikoopa
	dw Return018583
	dw FaceMario
	dw InitVertNetKoopa
	dw InitVertNetKoopa
	dw InitHorzNetKoopa
	dw InitHorzNetKoopa
	dw InitThwomp
	dw Return01AEA2
	dw InitBigBoo
	dw InitKoopaKid
	dw InitDownPiranha
	dw Return0185C2
	dw InitYoshiEgg
	dw InitKeyPBabyYoshi
	dw InitSpikeTop
	dw Return0185C2
	dw FaceMario
	dw FaceMario
	dw FaceMario
	dw InitFireball
	dw Return0185C2
	dw InitYoshi
	dw Return0185C2
	dw InitBigBoo
	dw InitEerie
	dw InitEerie
	dw InitUrchin
	dw InitUrchin
	dw InitUrchinWallFllw
	dw InitRipVanFish
	dw InitPSwitch
	dw Return0185C2
	dw Return0185C2
	dw Return01843D
	dw Return01843D
	dw Return01843D
	dw Return01843D
	dw Return0185C2
	dw InitDigginChuck
	dw Return0183EE
	dw Return0183EE
	dw InitGrowingPipe
	dw Return0183EE
	dw InitPiranha
	dw InitExplodingBlk
	dw InitMontyMole
	dw InitMontyMole
	dw InitPiranha
	dw InitPiranha
	dw FaceMario
	dw InitMovingLedge
	dw Return0185C2
	dw InitClimbingDoor
	dw InitChckbrdPlat
	dw Return01B25D
	dw InitChckbrdPlat
	dw Return01B25D
	dw Return01B267
	dw Return01B267
	dw InitFloatingPlat
	dw InitFallingPlat
	dw InitFloatingPlat
	dw InitOrangePlat
	dw InitBrwnChainPlat
	dw Return01AE90
	dw InitFloatingSkull
	dw InitLineBrwnPlat
	dw InitLinePlat
	dw InitLineRope
	dw InitLineGuidedSpr
	dw InitLineGuidedSpr
	dw InitLineGuidedSpr
	dw InitLineGuidedSpr
	dw Return01D6C3
	dw Return0185C2
	dw Return01843D
	dw InitPeaBouncer
	dw Return0185C2
	dw InitDinos
	dw InitDinos
	dw InitPokey
	dw InitSuperKoopa
	dw InitSuperKoopa
	dw InitSuperKoopaFthr
	dw InitPowerUp
	dw InitPowerUp
	dw InitPowerUp
	dw InitPowerUp
	dw InitPowerUp
	dw Return018583
	dw Return018583
	dw InitGoalTape
	dw Return0185C2
	dw Return0185C2
	dw Return0185C2
	dw Return0185C2
	dw InitKeyPBabyYoshi
	dw InitChangingItem
	dw InitBonusGame
	dw InitFlyingQBlock
	dw InitFlyingQBlock
	dw Return0185C2
	dw InitWiggler
	dw Return0185C2
	dw InitWingedCage
	dw Return01843D
	dw Return0185C2
	dw Return0185C2
	dw InitMsgPSideExit
	dw Return0185C2
	dw Return0185C2
	dw InitScalePlats
	dw FaceMario
	dw Return018869
	dw InitChuck
	dw InitChuck
	dw InitWhistlinChuck
	dw InitClappinChuck
	dw Return018869
	dw InitPuntinChuck
	dw InitPitchinChuck
	dw Return0183EE
	dw InitSumoBrother
	dw InitHammerBrother
	dw Return0185C2
	dw InitBubbleSpr
	dw InitBallNChain
	dw InitBanzai
	dw InitBowserScene
	dw Return0185C2
	dw Return0185C2
	dw InitGreyChainPlat
	dw InitFloatSpkBall
	dw InitFuzzBallPSpark
	dw InitFuzzBallPSpark
	dw Return0185C2
	dw Return0185C2
	dw InitReznor
	dw InitFishbone
	dw FaceMario
	dw InitWoodSpike
	dw InitWoodSpike2
	dw Return0185C2
	dw Return0185C2
	dw InitDiagBouncer
	dw InitCreateEatBlk
	dw Return0185C2
	dw InitBowsersFire
	dw FaceMario
	dw Return0185C2
	dw InitDiagBouncer
	dw Return0185C2
	dw Return0185C2
	dw Return0185C2
	dw InitTimedPlat
	dw Return0185C2
	dw InitBowserStatue
	dw InitSlidingKoopa
	dw Return0185C2
	dw FaceMario
	dw InitGreyLavaPlat
	dw InitMontyMole
	dw FaceMario
	dw FaceMario
	dw Return0185C2
	dw FaceMario
	dw Return018313
	dw Return0185C2
	dw Return0185C2

InitGreyLavaPlat:
	INC $D8,X
	INC $D8,X				;$018311	|
Return018313:
	RTS

InitBowserStatue:
	INC.w $157C,X
	JSR InitExplodingBlk			;$018317	|
	STY $C2,X				;$01831A	|
	CPY.b #$02				;$01831C	|
	BNE Return018325			;$01831E	|
	LDA.b #$01				;$018320	|
	STA.w $15F6,X				;$018322	|
Return018325:
	RTS

InitTimedPlat:
	LDY.b #$3F
	LDA $E4,X				;$018328	|
	AND.b #$10				;$01832A	|
	BNE CODE_018330				;$01832C	|
	LDY.b #$FF				;$01832E	|
CODE_018330:
	TYA
	STA.w $1570,X				;$018331	|
	RTS					;$018334	|

YoshiPal:
	db $09,$07,$05,$07

InitYoshiEgg:
	LDA $E4,X
	LSR					;$01833B	|
	LSR					;$01833C	|
	LSR					;$01833D	|
	LSR					;$01833E	|
	AND.b #$03				;$01833F	|
	TAY					;$018341	|
	LDA.w YoshiPal,Y			;$018342	|
	STA.w $15F6,X				;$018345	|
	INC.w $187B,X				;$018348	|
	RTS					;$01834B	|

DATA_01834C:
	db $10,$F0

InitDiagBouncer:
	JSR FaceMario
	LDA.w DATA_01834C,Y			;$018351	|
	STA $B6,X				;$018354	|
	LDA.b #$F0				;$018356	|
	STA $AA,X				;$018358	|
	RTS					;$01835A	|

InitWoodSpike:
	LDA $D8,X
	SEC					;$01835D	|
	SBC.b #$40				;$01835E	|
	STA $D8,X				;$018360	|
	LDA.w $14D4,X				;$018362	|
	SBC.b #$00				;$018365	|
	STA.w $14D4,X				;$018367	|
	RTS					;$01836A	|

InitWoodSpike2:
	JMP InitMontyMole

InitBowserScene:
	JSL CODE_03A0F1
	RTS					;$018372	|

InitSumoBrother:
	LDA.b #$03
	STA $C2,X				;$018375	|
	LDA.b #$70				;$018377	|
CODE_018379:
	STA.w $1540,X
	RTS					;$01837C	|

InitSlidingKoopa:
	LDA.b #$04
	BRA CODE_018379				;$01837F	|

InitGrowingPipe:
	LDA.b #$40
	STA.w $1534,X				;$018383	|
	RTS					;$018386	|

InitBanzai:
	JSR SubHorizPos
	TYA					;$01838A	|
	BNE CODE_018390				;$01838B	|
	JMP OffScrEraseSprite			;$01838D	|

CODE_018390:
	LDA.b #$09
	STA.w $1DFC				;$018392	|
	RTS					;$018395	|

InitBallNChain:
	LDA.b #$38
	BRA CODE_01839C				;$018398	|

InitGreyChainPlat:
	LDA.b #$30
CODE_01839C:
	STA.w $187B,X
	RTS					;$01839F	|

ExplodingBlkSpr:
	db $15,$0F,$00,$04

InitExplodingBlk:
	LDA $E4,X
	LSR					;$0183A6	|
	LSR					;$0183A7	|
	LSR					;$0183A8	|
	LSR					;$0183A9	|
	AND.b #$03				;$0183AA	|
	TAY					;$0183AC	|
	LDA.w ExplodingBlkSpr,Y			;$0183AD	|
	STA $C2,X				;$0183B0	|
	RTS					;$0183B2	|

DATA_0183B3:
	db $80,$40

InitScalePlats:
	LDA $D8,X
	STA.w $1534,X				;$0183B7	|
	LDA.w $14D4,X				;$0183BA	|
	STA.w $151C,X				;$0183BD	|
	LDA $E4,X				;$0183C0	|
	AND.b #$10				;$0183C2	|
	LSR					;$0183C4	|
	LSR					;$0183C5	|
	LSR					;$0183C6	|
	LSR					;$0183C7	|
	TAY					;$0183C8	|
	LDA $E4,X				;$0183C9	|
	CLC					;$0183CB	|
	ADC.w DATA_0183B3,Y			;$0183CC	|
	STA $C2,X				;$0183CF	|
	LDA.w $14E0,X				;$0183D1	|
	ADC.b #$00				;$0183D4	|
	STA.w $1602,X				;$0183D6	|
	RTS					;$0183D9	|

InitMsgPSideExit:
	LDA.b #$28
	STA.w $1564,X				;$0183DC	|
	RTS					;$0183DF	|

InitYoshi:
	DEC.w $160E,X
	INC.w $157C,X				;$0183E3	|
	LDA.w $0DC1				;$0183E6	|
	BEQ Return0183EE			;$0183E9	|
	STZ.w $14C8,X				;$0183EB	|
Return0183EE:
	RTS

DATA_0183EF:
	db $08

DATA_0183F0:
	db $00,$08

InitSpikeTop:
	JSR SubHorizPos
	TYA					;$0183F5	|
	EOR.b #$01				;$0183F6	|
	ASL					;$0183F8	|
	ASL					;$0183F9	|
	ASL					;$0183FA	|
	ASL					;$0183FB	|
	JSR CODE_01841D				;$0183FC	|
	STZ.w $164A,X				;$0183FF	|
	BRA CODE_01840E				;$018402	|

InitUrchinWallFllw:
	INC $D8,X
	BNE InitFuzzBallPSpark			;$018406	|
	INC.w $14D4,X				;$018408	|
InitFuzzBallPSpark:
	JSR InitUrchin
CODE_01840E:
	LDA.w $151C,X
	EOR.b #$10				;$018411	|
	STA.w $151C,X				;$018413	|
	LSR					;$018416	|
	LSR					;$018417	|
	STA $C2,X				;$018418	|
	RTS					;$01841A	|

InitUrchin:
	LDA $E4,X
CODE_01841D:
	LDY.b #$00
	AND.b #$10				;$01841F	|
	STA.w $151C,X				;$018421	|
	BNE CODE_018427				;$018424	|
	INY					;$018426	|
CODE_018427:
	LDA.w DATA_0183EF,Y
	STA $B6,X				;$01842A	|
	LDA.w DATA_0183F0,Y			;$01842C	|
	STA $AA,X				;$01842F	|
InitRipVanFish:
	INC.w $164A,X
	RTS					;$018434	|

InitKeyPBabyYoshi:
	LDA.b #$09
	STA.w $14C8,X				;$018437	|
	RTS					;$01843A	|

InitChangingItem:
	INC $C2,X
Return01843D:
	RTS

InitPeaBouncer:
	LDA $E4,X
	SEC					;$018440	|
	SBC.b #$08				;$018441	|
	STA $E4,X				;$018443	|
	LDA.w $14E0,X				;$018445	|
	SBC.b #$00				;$018448	|
	STA.w $14E0,X				;$01844A	|
	RTS					;$01844D	|

InitPSwitch:
	LDA $E4,X
	LSR					;$018450	|
	LSR					;$018451	|
	LSR					;$018452	|
	LSR					;$018453	|
	AND.b #$01				;$018454	|
	STA.w $151C,X				;$018456	|
	TAY					;$018459	|
	LDA.w PSwitchPal,Y			;$01845A	|
	STA.w $15F6,X				;$01845D	|
	LDA.b #$09				;$018460	|
	STA.w $14C8,X				;$018462	|
	RTS					;$018465	|

PSwitchPal:
	db $06,$02

ADDR_018468:
	JMP OffScrEraseSprite

InitLakitu:
	LDY.b #$09
CODE_01846D:
	CPY.w $15E9
	BEQ CODE_018484				;$018470	|
	LDA.w $14C8,Y				;$018472	|
	CMP.b #$08				;$018475	|
	BNE CODE_018484				;$018477	|
	LDA.w $009E,y				;$018479	|
	CMP.b #$87				;$01847C	|
	BEQ ADDR_018468				;$01847E	|
	CMP.b #$1E				;$018480	|
	BEQ ADDR_018468				;$018482	|
CODE_018484:
	DEY
	BPL CODE_01846D				;$018485	|
	STZ.w $18C0				;$018487	|
	STZ.w $18BF				;$01848A	|
	STZ.w $18B9				;$01848D	|
	LDA $D8,X				;$018490	|
	STA.w $18C3				;$018492	|
	LDA.w $14D4,X				;$018495	|
	STA.w $18C4				;$018498	|
	JSL FindFreeSprSlot			;$01849B	|
	BMI InitMontyMole			;$01849F	|
	STY.w $18E1				;$0184A1	|
	LDA.b #$87				;$0184A4	|
	STA.w $009E,y				;$0184A6	|
	LDA.b #$08				;$0184A9	|
	STA.w $14C8,Y				;$0184AB	|
	LDA $E4,X				;$0184AE	|
	STA.w $00E4,y				;$0184B0	|
	LDA.w $14E0,X				;$0184B3	|
	STA.w $14E0,Y				;$0184B6	|
	LDA $D8,X				;$0184B9	|
	STA.w $00D8,y				;$0184BB	|
	LDA.w $14D4,X				;$0184BE	|
	STA.w $14D4,Y				;$0184C1	|
	PHX					;$0184C4	|
	TYX					;$0184C5	|
	JSL InitSpriteTables			;$0184C6	|
	PLX					;$0184CA	|
	STZ.w $18E0				;$0184CB	|
InitMontyMole:
	LDA $E4,X
	AND.b #$10				;$0184D0	|
	STA.w $151C,X				;$0184D2	|
	RTS					;$0184D5	|

InitCreateEatBlk:
	LDA.b #$FF
	STA.w $1909				;$0184D8	|
	BRA InitMontyMole			;$0184DB	|

InitBulletBill:
	JSR SubHorizPos
	TYA					;$0184E0	|
	STA $C2,X				;$0184E1	|
	LDA.b #$10				;$0184E3	|
	STA.w $1540,X				;$0184E5	|
	RTS					;$0184E8	|

InitClappinChuck:
	LDA.b #$08
	BRA CODE_01851A				;$0184EB	|

InitPitchinChuck:
	LDA $E4,X
	AND.b #$30				;$0184EF	|
	LSR					;$0184F1	|
	LSR					;$0184F2	|
	LSR					;$0184F3	|
	LSR					;$0184F4	|
	STA.w $187B,X				;$0184F5	|
	LDA.b #$0A				;$0184F8	|
	BRA CODE_01851A				;$0184FA	|

InitPuntinChuck:
	LDA.b #$09
	BRA CODE_01851A				;$0184FE	|

InitWhistlinChuck:
	LDA.b #$0B
	BRA CODE_01851A				;$018502	|

InitChuck:
	LDA.b #$05
	BRA CODE_01851A				;$018506	|

InitDigginChuck:
	LDA.b #$30
	STA.w $1540,X				;$01850A	|
	LDA $E4,X				;$01850D	|
	AND.b #$10				;$01850F	|
	LSR					;$018511	|
	LSR					;$018512	|
	LSR					;$018513	|
	LSR					;$018514	|
	STA.w $157C,X				;$018515	|
	LDA.b #$04				;$018518	|
CODE_01851A:
	STA $C2,X
	JSR FaceMario				;$01851C	|
	LDA.w DATA_018526,Y			;$01851F	|
	STA.w $151C,X				;$018522	|
	RTS					;$018525	|

DATA_018526:
	db $00,$04

InitSuperKoopa:
	LDA.b #$28
	STA $AA,X				;$01852A	|
	BRA FaceMario				;$01852C	|

InitSuperKoopaFthr:
	JSR FaceMario
	LDA $E4,X				;$018531	|
	AND.b #$10				;$018533	|
	BEQ CODE_018547				;$018535	|
	LDA.b #$10				;$018537	|
	STA.w $1656,X				;$018539	|
	LDA.b #$80				;$01853C	|
	STA.w $1662,X				;$01853E	|
	LDA.b #$10				;$018541	|
	STA.w $1686,X				;$018543	|
	RTS					;$018546	|

CODE_018547:
	INC.w $1534,X
	RTS					;$01854A	|

InitPokey:
	LDA.b #$1F
	LDY.w $187A				;$01854D	|
	BNE CODE_018554				;$018550	|
	LDA.b #$07				;$018552	|
CODE_018554:
	STA $C2,X
	BRA FaceMario				;$018556	|

InitDinos:
	LDA.b #$04
	STA.w $151C,X				;$01855A	|
InitBomb:
	LDA.b #$FF
	STA.w $1540,X				;$01855F	|
	BRA FaceMario				;$018562	|

InitBubbleSpr:
	JSR InitExplodingBlk
	STY $C2,X				;$018567	|
	DEC.w $1534,X				;$018569	|
	BRA FaceMario				;$01856C	|

InitGrnBounceKoopa:
	LDA $D8,X
	AND.b #$10				;$018570	|
	STA.w $160E,X				;$018572	|
InitStandardSprite:
	JSL GetRand
	STA.w $1570,X				;$018579	|
FaceMario:
	JSR SubHorizPos
	TYA					;$01857F	|
	STA.w $157C,X				;$018580	|
Return018583:
	RTS

InitBowsersFire:
	LDA.b #$17
	STA.w $1DFC				;$018586	|
	BRA FaceMario				;$018589	|

InitPowerUp:
	INC $C2,X
	RTS					;$01858D	|

InitFishbone:
	JSL GetRand
	AND.b #$1F				;$018592	|
	STA.w $1540,X				;$018594	|
	JMP FaceMario				;$018597	|

InitDownPiranha:
	ASL.w $15F6,X
	SEC					;$01859D	|
	ROR.w $15F6,X				;$01859E	|
	LDA $D8,X				;$0185A1	|
	SEC					;$0185A3	|
	SBC.b #$10				;$0185A4	|
	STA $D8,X				;$0185A6	|
	LDA.w $14D4,X				;$0185A8	|
	SBC.b #$00				;$0185AB	|
	STA.w $14D4,X				;$0185AD	|
InitPiranha:
	LDA $E4,X
	CLC					;$0185B2	|
	ADC.b #$08				;$0185B3	|
	STA $E4,X				;$0185B5	|
	DEC $D8,X				;$0185B7	|
	LDA $D8,X				;$0185B9	|
	CMP.b #$FF				;$0185BB	|
	BNE Return0185C2			;$0185BD	|
	DEC.w $14D4,X				;$0185BF	|
Return0185C2:
	RTS

CallSpriteMain:
	STZ.w $1491
	LDA $9E,X				;$0185C6	|
	JSL ExecutePtr				;$0185C8	|

SpriteMainPtr:
	dw ShellessKoopas
	dw ShellessKoopas
	dw ShellessKoopas
	dw ShellessKoopas
	dw Spr0to13Start
	dw Spr0to13Start
	dw Spr0to13Start
	dw Spr0to13Start
	dw GreenParaKoopa
	dw GreenParaKoopa
	dw RedVertParaKoopa
	dw RedHorzParaKoopa
	dw Spr0to13Start
	dw Bobomb
	dw Keyhole
	dw Spr0to13Start
	dw WingedGoomba
	dw Spr0to13Start
	dw Return01F87B
	dw Spr0to13Start
	dw SpinyEgg
	dw Fish
	dw Fish
	dw GeneratedFish
	dw JumpingFish
	dw PSwitch
	dw ClassicPiranhas
	dw Bank3SprHandler
	dw BulletBill
	dw HoppingFlame
	dw Lakitu
	dw Magikoopa
	dw MagikoopasMagic
	dw PowerUpRt
	dw ClimbingKoopa
	dw ClimbingKoopa
	dw ClimbingKoopa
	dw ClimbingKoopa
	dw Thwomp
	dw Thwimp
	dw BigBoo
	dw KoopaKid
	dw ClassicPiranhas
	dw SumosLightning
	dw YoshiEgg
	dw Return0185C2
	dw WallFollowers
	dw SpringBoard
	dw DryBonesAndBeetle
	dw DryBonesAndBeetle
	dw DryBonesAndBeetle
	dw Fireballs
	dw BossFireball
	dw Yoshi
	dw DATA_01E41F
	dw BooPBooBlock
	dw Eerie
	dw Eerie
	dw WallFollowers
	dw WallFollowers
	dw WallFollowers
	dw RipVanFish
	dw PSwitch
	dw ParachuteSprites
	dw ParachuteSprites
	dw Dolphin
	dw Dolphin
	dw Dolphin
	dw TorpedoTed
	dw DirectionalCoins
	dw DigginChuck
	dw SwimJumpFish
	dw DigginChucksRock
	dw GrowingPipe
	dw GoalSphere
	dw PipeLakitu
	dw ExplodingBlock
	dw MontyMole
	dw MontyMole
	dw JumpingPiranha
	dw JumpingPiranha
	dw Bank3SprHandler
	dw MovingLedge
	dw Return0185C2
	dw ClimbingDoor
	dw Platforms
	dw Platforms
	dw Platforms
	dw Platforms
	dw TurnBlockBridge
	dw HorzTurnBlkBridge
	dw Platforms2
	dw Platforms2
	dw Platforms2
	dw OrangePlatform
	dw BrownChainedPlat
	dw PalaceSwitch
	dw FloatingSkulls
	dw LineFuzzyPPlats
	dw LineFuzzyPPlats
	dw LineRopePChainsaw
	dw LineRopePChainsaw
	dw LineRopePChainsaw
	dw LineGrinder
	dw LineFuzzyPPlats
	dw Return01D6C3
	dw CoinCloud
	dw PeaBouncer
	dw PeaBouncer
	dw InvisSolidPDinos
	dw InvisSolidPDinos
	dw InvisSolidPDinos
	dw Pokey
	dw RedSuperKoopa
	dw YellowSuperKoopa
	dw FeatherSuperKoopa
	dw PowerUpRt
	dw FireFlower
	dw PowerUpRt
	dw Feather
	dw PowerUpRt
	dw GrowingVine
	dw Bank3SprHandler
	dw GoalTape
	dw Bank3SprHandler
	dw BalloonKeyFlyObjs
	dw BalloonKeyFlyObjs
	dw BalloonKeyFlyObjs
	dw BalloonKeyFlyObjs
	dw ChangingItem
	dw BonusGame
	dw FlyingQBlock
	dw FlyingQBlock
	dw InitFlyingQBlock
	dw Wiggler
	dw LakituCloud
	dw WingedCage
	dw Layer3Smash
	dw YoshisHouseBirds
	dw YoshisHouseSmoke
	dw SideExit
	dw GhostHouseExit
	dw WarpBlocks
	dw ScalePlatforms
	dw GasBubble
	dw Chucks
	dw Chucks
	dw Chucks
	dw Chucks
	dw Chucks
	dw Chucks
	dw Chucks
	dw Chucks
	dw VolcanoLotus
	dw SumoBrother
	dw HammerBrother
	dw FlyingPlatform
	dw BubbleWithSprite
	dw BanzaiBnCGrayPlat
	dw BanzaiBnCGrayPlat
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw BanzaiBnCGrayPlat
	dw FloatingSpikeBall
	dw WallFollowers
	dw WallFollowers
	dw IggysBall
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw BooPBooBlock
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Grinder
	dw Fireballs
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler
	dw Bank3SprHandler

InvisSolidPDinos:
	JSL InvisBlkPDinosMain
	RTS					;$018762	|

GoalSphere:
	JSR SubSprGfx2Entry1
	LDA $9D					;$018766	|
	BNE Return018788			;$018768	|
	LDA $13					;$01876A	|
	AND.b #$1F				;$01876C	|
	ORA $9D					;$01876E	|
	JSR CODE_01B152				;$018770	|
	JSR MarioSprInteractRt			;$018773	|
	BCC Return018788			;$018776	|
	STZ.w $14C8,X				;$018778	|
	LDA.b #$FF				;$01877B	|
	STA.w $1493				;$01877D	|
	STA.w $0DDA				;$018780	|
	LDA.b #$0B				;$018783	|
	STA.w $1DFB				;$018785	|
Return018788:
	RTS

InitReznor:
	JSL ReznorInit
	RTS					;$01878D	|

Bank3SprHandler:
	JSL Bnk3CallSprMain
	RTS					;$018792	|

BanzaiBnCGrayPlat:
	JSL BanzaiPRotating
	RTS					;$018797	|

BubbleWithSprite:
	JSL BubbleSpriteMain
	RTS					;$01879C	|

HammerBrother:
	JSL HammerBrotherMain
	RTS					;$0187A1	|

FlyingPlatform:
	JSL FlyingPlatformMain
	RTS					;$0187A6	|

InitHammerBrother:
	JSL Return02DA59
	RTS					;$0187AB	|

VolcanoLotus:
	JSL VolcanoLotusMain
	RTS					;$0187B0	|

SumoBrother:
	JSL SumoBrotherMain
	RTS					;$0187B5	|

SumosLightning:
	JSL SumosLightningMain
	RTS					;$0187BA	|

JumpingPiranha:
	JSL JumpingPiranhaMain
	RTS					;$0187BF	|

GasBubble:
	JSL GasBubbleMain
	RTS					;$0187C4	|

Unused0187C5:
	JSL SumoBrotherMain
	RTS					;$0187C9	|

DirectionalCoins:
	JSL DirectionCoinsMain
	RTS					;$0187CE	|

ExplodingBlock:
	JSL ExplodingBlkMain
	RTS					;$0187D3	|

ScalePlatforms:
	JSL ScalePlatformMain
	RTS					;$0187D8	|

InitFloatingSkull:
	JSL FloatingSkullInit
	RTS					;$0187DD	|

FloatingSkulls:
	JSL FloatingSkullMain
	RTS					;$0187E2	|

GhostHouseExit:
	JSL GhostExitMain
	RTS					;$0187E7	|

WarpBlocks:
	JSL WarpBlocksMain
	RTS					;$0187EC	|

Pokey:
	JSL PokeyMain
	RTS					;$0187F1	|

RedSuperKoopa:
	JSL SuperKoopaMain
	RTS					;$0187F6	|

YellowSuperKoopa:
	JSL SuperKoopaMain
	RTS					;$0187FB	|

FeatherSuperKoopa:
	JSL SuperKoopaMain
	RTS					;$018800	|

PipeLakitu:
	JSL PipeLakituMain
	RTS					;$018805	|

DigginChuck:
	JSL ChucksMain
	RTS					;$01880A	|

SwimJumpFish:
	JSL SwimJumpFishMain
	RTS					;$01880F	|

DigginChucksRock:
	JSL ChucksRockMain
	RTS					;$018814	|

GrowingPipe:
	JSL GrowingPipeMain
	RTS					;$018819	|

YoshisHouseBirds:
	JSL BirdsMain
	RTS					;$01881E	|

YoshisHouseSmoke:
	JSL SmokeMain
	RTS					;$018823	|

SideExit:
	JSL SideExitMain
	RTS					;$018828	|

InitWiggler:
	JSL WigglerInit
	RTS					;$01882D	|

Wiggler:
	JSL WigglerMain
	RTS					;$018832	|

CoinCloud:
	JSL CoinCloudMain
	RTS					;$018837	|

TorpedoTed:
	JSL TorpedoTedMain
	RTS					;$01883C	|

Layer3Smash:
	PHB
	LDA.b #$02				;$01883E	|
	PHA					;$018840	|
	PLB					;$018841	|
	JSL Layer3SmashMain			;$018842	|
	PLB					;$018846	|
	RTS					;$018847	|

PeaBouncer:
	PHB
	LDA.b #$02				;$018849	|
	PHA					;$01884B	|
	PLB					;$01884C	|
	JSL PeaBouncerMain			;$01884D	|
	PLB					;$018851	|
	RTS					;$018852	|

RipVanFish:
	PHB
	LDA.b #$02				;$018854	|
	PHA					;$018856	|
	PLB					;$018857	|
	JSL RipVanFishMain			;$018858	|
	PLB					;$01885C	|
	RTS					;$01885D	|

WallFollowers:
	PHB
	LDA.b #$02				;$01885F	|
	PHA					;$018861	|
	PLB					;$018862	|
	JSL WallFollowersMain			;$018863	|
	PLB					;$018867	|
	RTS					;$018868	|

Return018869:
	RTS

Chucks:
	JSL ChucksMain
	RTS					;$01886E	|

InitWingedCage:
	PHB
	LDA.b #$02				;$018870	|
	PHA					;$018872	|
	PLB					;$018873	|
	JSL Return02CBFD			;$018874	|
	PLB					;$018878	|
	RTS					;$018879	|

WingedCage:
	PHB
	LDA.b #$02				;$01887B	|
	PHA					;$01887D	|
	PLB					;$01887E	|
	JSL WingedCageMain			;$01887F	|
	PLB					;$018883	|
	RTS					;$018884	|

Dolphin:
	PHB
	LDA.b #$02				;$018886	|
	PHA					;$018888	|
	PLB					;$018889	|
	JSL DolphinMain				;$01888A	|
	PLB					;$01888E	|
	RTS					;$01888F	|

InitMovingLedge:
	DEC $D8,X
	RTS					;$018892	|

MovingLedge:
	JSL MovingLedgeMain
	RTS					;$018897	|

JumpOverShells:
	TXA
	EOR $13					;$018899	|
	AND.b #$03				;$01889B	|
	BNE Return0188AB			;$01889D	|
	LDY.b #$09				;$01889F	|
JumpLoopStart:
	LDA.w $14C8,Y
	CMP.b #$0A				;$0188A4	|
	BEQ HandleJumpOver			;$0188A6	|
JumpLoopNext:
	DEY
	BPL JumpLoopStart			;$0188A9	|
Return0188AB:
	RTS

HandleJumpOver:
	LDA.w $00E4,y
	SEC					;$0188AF	|
	SBC.b #$1A				;$0188B0	|
	STA $00					;$0188B2	|
	LDA.w $14E0,Y				;$0188B4	|
	SBC.b #$00				;$0188B7	|
	STA $08					;$0188B9	|
	LDA.b #$44				;$0188BB	|
	STA $02					;$0188BD	|
	LDA.w $00D8,y				;$0188BF	|
	STA $01					;$0188C2	|
	LDA.w $14D4,Y				;$0188C4	|
	STA $09					;$0188C7	|
	LDA.b #$10				;$0188C9	|
	STA $03					;$0188CB	|
	JSL GetSpriteClippingA			;$0188CD	|
	JSL CheckForContact			;$0188D1	|
	BCC JumpLoopNext			;$0188D5	|
	JSR IsOnGround				;$0188D7	|
	BEQ JumpLoopNext			;$0188DA	|
	LDA.w $157C,Y				;$0188DC	|
	CMP.w $157C,X				;$0188DF	|
	BEQ Return0188EB			;$0188E2	|
	LDA.b #$C0				;$0188E4	|
	STA $AA,X				;$0188E6	|
	STZ.w $163E,X				;$0188E8	|
Return0188EB:
	RTS

Spr0to13SpeedX:
	db $08,$F8,$0C,$F4

Spr0to13Prop:
	db $00,$02,$03,$0D,$40,$42,$43,$45
	db $50,$50,$50,$5C,$DD,$05,$00,$20
	db $20,$00,$00,$00

ShellessKoopas:
	LDA $9D
	BEQ CODE_018952				;$018906	|
CODE_018908:
	LDA.w $163E,X		
	CMP.b #$80				;$01890B	|
	BCC CODE_01891F				;$01890D	|
	LDA $9D					;$01890F	|
	BNE CODE_01891F				;$018911	|
CODE_018913:
	JSR SetAnimationFrame
	LDA.w $1602,X				;$018916	|
	CLC					;$018919	|
	ADC.b #$05				;$01891A	|
	STA.w $1602,X				;$01891C	|
CODE_01891F:
	JSR CODE_018931
	JSR SubUpdateSprPos			;$018922	|
	STZ $B6,X				;$018925	|
	JSR IsOnGround				;$018927	|
	BEQ CODE_01892E				;$01892A	|
	STZ $AA,X				;$01892C	|
CODE_01892E:
	JMP CODE_018B03

CODE_018931:
	LDA $9E,X
	CMP.b #$02				;$018933	|
	BNE CODE_01893C				;$018935	|
	JSR MarioSprInteractRt			;$018937	|
	BRA Return018951			;$01893A	|

CODE_01893C:
	ASL.w $167A,X
	SEC					;$01893F	|
	ROR.w $167A,X				;$018940	|
	JSR MarioSprInteractRt			;$018943	|
	BCC CODE_01894B				;$018946	|
	JSR CODE_01B12A				;$018948	|
CODE_01894B:
	ASL.w $167A,X
	LSR.w $167A,X				;$01894E	|
Return018951:
	RTS

CODE_018952:
	LDA.w $163E,X		 	
	BEQ CODE_0189B4 			;$018955	|
	CMP.b #$80				;$018957	|
	BNE CODE_01896B				;$018959	|
	JSR FaceMario				;$01895B	|
	LDA $9E,X				;$01895E	|
	CMP.b #$02				;$018960	|
	BEQ CODE_018968				;$018962	|
	LDA.b #$E0				;$018964	|
	STA $AA,X				;$018966	|
CODE_018968:
	STZ.w $163E,X
CODE_01896B:
	CMP.b #$01
	BNE CODE_018908				;$01896D	|
	LDY.w $160E,X				;$01896F	|
	LDA.w $14C8,Y				;$018972	|
	CMP.b #$09				;$018975	|
	BNE CODE_018908				;$018977	|
	LDA $E4,X				;$018979	|
	SEC					;$01897B	|
	SBC.w $00E4,y				;$01897C	|
	CLC					;$01897F	|
	ADC.b #$12				;$018980	|
	CMP.b #$24				;$018982	|
	BCS CODE_018908				;$018984	|
	JSR PlayKickSfx				;$018986	|
	JSR CODE_01A755				;$018989	|
	LDY.w $157C,X				;$01898C	|
	LDA.w DATA_01A6D7,Y			;$01898F	|
	LDY.w $160E,X				;$018992	|
	STA.w $00B6,y				;$018995	|
	LDA.b #$0A				;$018998	|
	STA.w $14C8,Y				;$01899A	|
	LDA.w $1540,Y				;$01899D	|
	STA.w $00C2,y				;$0189A0	|
	LDA.b #$08				;$0189A3	|
	STA.w $1564,Y				;$0189A5	|
	LDA.w $167A,Y				;$0189A8	|
	AND.b #$10				;$0189AB	|
	BEQ CODE_0189B4				;$0189AD	|
	LDA.b #$E0				;$0189AF	|
	STA.w $00AA,y				;$0189B1	|
CODE_0189B4:
	LDA.w $1528,X
	BEQ CODE_018A15				;$0189B7	|
	JSR IsTouchingObjSide			;$0189B9	|
	BEQ CODE_0189C0				;$0189BC	|
	STZ $B6,X				;$0189BE	|
CODE_0189C0:
	JSR IsOnGround
	BEQ CODE_0189E6				;$0189C3	|
	LDA $86					;$0189C5	|
	CMP.b #$01				;$0189C7	|
	LDA.b #$02				;$0189C9	|
	BCC CODE_0189CE				;$0189CB	|
	LSR					;$0189CD	|
CODE_0189CE:
	STA $00
	LDA $B6,X				;$0189D0	|
	CMP.b #$02				;$0189D2	|
	BCC CODE_0189FD				;$0189D4	|
	BPL CODE_0189DE				;$0189D6	|
	CLC					;$0189D8	|
	ADC $00					;$0189D9	|
	CLC					;$0189DB	|
	ADC $00					;$0189DC	|
CODE_0189DE:
	SEC
	SBC $00					;$0189DF	|
	STA $B6,X				;$0189E1	|
	JSR CODE_01804E				;$0189E3	|
CODE_0189E6:
	STZ.w $1570,X
	JSR CODE_018B43				;$0189E9	|
	LDA.b #$E6				;$0189EC	|
	LDY $9E,X				;$0189EE	|
	CPY.b #$02				;$0189F0	|
	BEQ CODE_0189F6				;$0189F2	|
	LDA.b #$86				;$0189F4	|
CODE_0189F6:
	LDY.w $15EA,X
	STA.w $0302,Y				;$0189F9	|
	RTS					;$0189FC	|

CODE_0189FD:
	JSR IsOnGround 		
	BEQ CODE_018A0F				;$018A00	|
	LDA.b #$FF				;$018A02	|
	LDY $9E,X				;$018A04	|
	CPY.b #$02				;$018A06	|
	BNE CODE_018A0C				;$018A08	|
	LDA.b #$A0				;$018A0A	|
CODE_018A0C:
	STA.w $163E,X
CODE_018A0F:
	STZ.w $1528,X
	JMP CODE_018913				;$018A12	|

CODE_018A15:
	LDA.w $1534,X
	BEQ CODE_018A88				;$018A18	|
	LDY.w $160E,X				;$018A1A	|
	LDA.w $14C8,Y				;$018A1D	|
	CMP.b #$0A				;$018A20	|
	BEQ CODE_018A29				;$018A22	|
	STZ.w $1534,X				;$018A24	|
	BRA CODE_018A62				;$018A27	|

CODE_018A29:
	STA.w $1528,Y
	JSR IsTouchingObjSide			;$018A2C	|
	BEQ CODE_018A38				;$018A2F	|
	LDA.b #$00				;$018A31	|
	STA.w $00B6,y				;$018A33	|
	STA $B6,X				;$018A36	|
CODE_018A38:
	JSR IsOnGround
	BEQ CODE_018A62				;$018A3B	|
	LDA $86					;$018A3D	|
	CMP.b #$01				;$018A3F	|
	LDA.b #$02				;$018A41	|
	BCC CODE_018A46				;$018A43	|
	LSR					;$018A45	|
CODE_018A46:
	STA $00
	LDA.w $00B6,y				;$018A48	|
	CMP.b #$02				;$018A4B	|
	BCC CODE_018A69				;$018A4D	|
	BPL CODE_018A57				;$018A4F	|
	CLC					;$018A51	|
	ADC $00					;$018A52	|
	CLC					;$018A54	|
	ADC $00					;$018A55	|
CODE_018A57:
	SEC
	SBC $00					;$018A58	|
	STA.w $00B6,y				;$018A5A	|
	STA $B6,X				;$018A5D	|
	JSR CODE_01804E				;$018A5F	|
CODE_018A62:
	STZ.w $1570,X
	JSR CODE_018B43				;$018A65	|
	RTS					;$018A68	|

CODE_018A69:
	LDA.b #$00
	STA $B6,X				;$018A6B	|
	STA.w $00B6,y				;$018A6D	|
	STZ.w $1534,X				;$018A70	|
	LDA.b #$09				;$018A73	|
	STA.w $14C8,Y				;$018A75	|
	PHX					;$018A78	|
	TYX					;$018A79	|
	JSR CODE_01AA0B				;$018A7A	|
	LDA.w $1540,X				;$018A7D	|
	BEQ CODE_018A87				;$018A80	|
	LDA.b #$FF				;$018A82	|
	STA.w $1540,X				;$018A84	|
CODE_018A87:
	PLX
CODE_018A88:
	LDA $C2,X
	BEQ CODE_018A9B				;$018A8A	|
	DEC $C2,X				;$018A8C	|
	CMP.b #$08				;$018A8E	|
	LDA.b #$04				;$018A90	|
	BCS CODE_018A96				;$018A92	|
	LDA.b #$00				;$018A94	|
CODE_018A96:
	STA.w $1602,X
	BRA CODE_018B00				;$018A99	|

CODE_018A9B:
	LDA.w $1558,X
	CMP.b #$01				;$018A9E	|
	BNE Spr0to13Main			;$018AA0	|
	LDY.w $1594,X				;$018AA2	|
	LDA.w $14C8,Y				;$018AA5	|
	CMP.b #$08				;$018AA8	|
	BCC Return018AD9			;$018AAA	|
	LDA.w $00AA,y				;$018AAC	|
	BMI Return018AD9			;$018AAF	|
	LDA.w $009E,y				;$018AB1	|
	CMP.b #$21				;$018AB4	|
	BEQ Return018AD9			;$018AB6	|
	JSL GetSpriteClippingA			;$018AB8	|
	PHX					;$018ABC	|
	TYX					;$018ABD	|
	JSL GetSpriteClippingB			;$018ABE	|
	PLX					;$018AC2	|
	JSL CheckForContact			;$018AC3	|
	BCC Return018AD9			;$018AC7	|
	JSR OffScrEraseSprite			;$018AC9	|
	LDY.w $1594,X				;$018ACC	|
	LDA.b #$10				;$018ACF	|
	STA.w $1558,Y				;$018AD1	|
	LDA $9E,X				;$018AD4	|
	STA.w $160E,Y				;$018AD6	|
Return018AD9:
	RTS

ExplodeBomb:
	PHB
	LDA.b #$02				;$018ADB	|
	PHA					;$018ADD	|
	PLB					;$018ADE	|
	JSL ExplodeBombRt			;$018ADF	|
	PLB					;$018AE3	|
	RTS					;$018AE4	|

Bobomb:
	LDA.w $1534,X
	BNE ExplodeBomb				;$018AE8	|
	LDA.w $1540,X				;$018AEA	|
	BNE Spr0to13Start			;$018AED	|
	LDA.b #$09				;$018AEF	|
	STA.w $14C8,X				;$018AF1	|
	LDA.b #$40				;$018AF4	|
	STA.w $1540,X				;$018AF6	|
	JMP SubSprGfx2Entry1			;$018AF9	|

Spr0to13Start:
	LDA $9D
	BEQ Spr0to13Main			;$018AFE	|
CODE_018B00:
	JSR MarioSprInteractRt
CODE_018B03:
	JSR SubSprSprInteract
	JSR Spr0to13Gfx				;$018B06	|
	RTS					;$018B09	|

Spr0to13Main:
	JSR IsOnGround
	BEQ CODE_018B2E				;$018B0D	|
	LDY $9E,X				;$018B0F	|
	LDA.w Spr0to13Prop,Y			;$018B11	|
	LSR					;$018B14	|
	LDY.w $157C,X				;$018B15	|
	BCC CODE_018B1C				;$018B18	|
	INY					;$018B1A	|
	INY					;$018B1B	|
CODE_018B1C:
	LDA.w Spr0to13SpeedX,Y
	EOR.w $15B8,X				;$018B1F	|
	ASL					;$018B22	|
	LDA.w Spr0to13SpeedX,Y			;$018B23	|
	BCC CODE_018B2C				;$018B26	|
	CLC					;$018B28	|
	ADC.w $15B8,X				;$018B29	|
CODE_018B2C:
	STA $B6,X
CODE_018B2E:
	LDY.w $157C,X
	TYA					;$018B31	|
	INC A					;$018B32	|
	AND.w $1588,X				;$018B33	|
	AND.b #$03				;$018B36	|
	BEQ CODE_018B3C				;$018B38	|
	STZ $B6,X				;$018B3A	|
CODE_018B3C:
	JSR IsTouchingCeiling
	BEQ CODE_018B43				;$018B3F	|
	STZ $AA,X				;$018B41	|
CODE_018B43:
	JSR SubOffscreen0Bnk1
	JSR SubUpdateSprPos			;$018B46	|
	JSR SetAnimationFrame			;$018B49	|
	JSR IsOnGround				;$018B4C	|
	BEQ SpriteInAir				;$018B4F	|
SpriteOnGround:
	JSR SetSomeYSpeed
	STZ.w $151C,X				;$018B54	|
	LDY $9E,X				;$018B57	|
	LDA.w Spr0to13Prop,Y			;$018B59	|
	PHA					;$018B5C	|
	AND.b #$04				;$018B5D	|
	BEQ DontFollowMario			;$018B5F	|
	LDA.w $1570,X				;$018B61	|
	AND.b #$7F				;$018B64	|
	BNE DontFollowMario			;$018B66	|
	LDA.w $157C,X				;$018B68	|
	PHA					;$018B6B	|
	JSR FaceMario				;$018B6C	|
	PLA					;$018B6F	|
	CMP.w $157C,X				;$018B70	|
	BEQ DontFollowMario			;$018B73	|
	LDA.b #$08				;$018B75	|
	STA.w $15AC,X				;$018B77	|
DontFollowMario:
	PLA
	AND.b #$08				;$018B7B	|
	BEQ CODE_018B82				;$018B7D	|
	JSR JumpOverShells			;$018B7F	|
CODE_018B82:
	BRA CODE_018BB0

SpriteInAir:
	LDY $9E,X
	LDA.w Spr0to13Prop,Y			;$018B86	|
	BPL CODE_018B90				;$018B89	|
	JSR SetAnimationFrame			;$018B8B	|
	BRA CODE_018B93				;$018B8E	|

CODE_018B90:
	STZ.w $1570,X
CODE_018B93:
	LDA.w Spr0to13Prop,Y
	AND.b #$02				;$018B96	|
	BEQ CODE_018BB0				;$018B98	|
	LDA.w $151C,X				;$018B9A	|
	ORA.w $1558,X				;$018B9D	|
	ORA.w $1528,X				;$018BA0	|
	ORA.w $1534,X				;$018BA3	|
	BNE CODE_018BB0				;$018BA6	|
	JSR FlipSpriteDir			;$018BA8	|
	LDA.b #$01				;$018BAB	|
	STA.w $151C,X				;$018BAD	|
CODE_018BB0:
	LDA.w $1528,X
	BEQ CODE_018BBA				;$018BB3	|
	JSR CODE_018931				;$018BB5	|
	BRA CODE_018BBD				;$018BB8	|

CODE_018BBA:
	JSR MarioSprInteractRt
CODE_018BBD:
	JSR SubSprSprInteract
	JSR FlipIfTouchingObj			;$018BC0	|
Spr0to13Gfx:
	LDA.w $157C,X
	PHA					;$018BC6	|
	LDY.w $15AC,X				;$018BC7	|
	BEQ CODE_018BDE				;$018BCA	|
	LDA.b #$02				;$018BCC	|
	STA.w $1602,X				;$018BCE	|
	LDA.b #$00				;$018BD1	|
	CPY.b #$05				;$018BD3	|
	BCC CODE_018BD8				;$018BD5	|
	INC A					;$018BD7	|
CODE_018BD8:
	EOR.w $157C,X
	STA.w $157C,X				;$018BDB	|
CODE_018BDE:
	LDY $9E,X
	LDA.w Spr0to13Prop,Y			;$018BE0	|
	AND.b #$40				;$018BE3	|
	BNE CODE_018BEC				;$018BE5	|
	JSR SubSprGfx2Entry1			;$018BE7	|
	BRA DoneWithSprite			;$018BEA	|

CODE_018BEC:
	LDA.w $1602,X
	LSR					;$018BEF	|
	LDA $D8,X				;$018BF0	|
	PHA					;$018BF2	|
	SBC.b #$0F				;$018BF3	|
	STA $D8,X				;$018BF5	|
	LDA.w $14D4,X				;$018BF7	|
	PHA					;$018BFA	|
	SBC.b #$00				;$018BFB	|
	STA.w $14D4,X				;$018BFD	|
	JSR SubSprGfx1				;$018C00	|
	PLA					;$018C03	|
	STA.w $14D4,X				;$018C04	|
	PLA					;$018C07	|
	STA $D8,X				;$018C08	|
	LDA $9E,X				;$018C0A	|
	CMP.b #$08				;$018C0C	|
	BCC DoneWithSprite			;$018C0E	|
	JSR KoopaWingGfxRt			;$018C10	|
DoneWithSprite:
	PLA
	STA.w $157C,X				;$018C14	|
	RTS					;$018C17	|

SpinyEgg:
	LDA $9D
	BNE CODE_018C44				;$018C1A	|
	LDA.w $14C8,X				;$018C1C	|
	CMP.b #$08				;$018C1F	|
	BNE CODE_018C44				;$018C21	|
	JSR SetAnimationFrame			;$018C23	|
	JSR SubUpdateSprPos			;$018C26	|
	DEC $AA,X				;$018C29	|
	JSR IsOnGround				;$018C2B	|
	BEQ CODE_018C3E				;$018C2E	|
	LDA.b #$13				;$018C30	|
	STA $9E,X				;$018C32	|
	JSL InitSpriteTables			;$018C34	|
	JSR FaceMario				;$018C38	|
	JSR CODE_0197D5				;$018C3B	|
CODE_018C3E:
	JSR FlipIfTouchingObj
	JSR SubSprSprPMarioSpr			;$018C41	|
CODE_018C44:
	JSR SubOffscreen0Bnk1
	LDA.b #$02				;$018C47	|
	JSR SubSprGfx0Entry0			;$018C49	|
	RTS					;$018C4C	|

GreenParaKoopa:
	LDA $9D
	BNE CODE_018CB7				;$018C4F	|
	LDY.w $157C,X				;$018C51	|
	LDA.w Spr0to13SpeedX,Y			;$018C54	|
	EOR.w $15B8,X				;$018C57	|
	ASL					;$018C5A	|
	LDA.w Spr0to13SpeedX,Y			;$018C5B	|
	BCC CODE_018C64				;$018C5E	|
	CLC					;$018C60	|
	ADC.w $15B8,X				;$018C61	|
CODE_018C64:
	STA $B6,X
	TYA					;$018C66	|
	INC A					;$018C67	|
	AND.w $1588,X				;$018C68	|
	AND.b #$03				;$018C6B	|
	BEQ CODE_018C71				;$018C6D	|
	STZ $B6,X				;$018C6F	|
CODE_018C71:
	LDA $9E,X
	CMP.b #$08				;$018C73	|
	BNE CODE_018C8C				;$018C75	|
	JSR SubSprXPosNoGrvty			;$018C77	|
	LDY.b #$FC				;$018C7A	|
	LDA.w $1570,X				;$018C7C	|
	AND.b #$20				;$018C7F	|
	BEQ CODE_018C85				;$018C81	|
	LDY.b #$04				;$018C83	|
CODE_018C85:
	STY $AA,X
	JSR SubSprYPosNoGrvty			;$018C87	|
	BRA CODE_018C91				;$018C8A	|

CODE_018C8C:
	JSR SubUpdateSprPos
	DEC $AA,X				;$018C8F	|
CODE_018C91:
	JSR SubSprSprPMarioSpr
	JSR IsTouchingCeiling			;$018C94	|
	BEQ CODE_018C9B				;$018C97	|
	STZ $AA,X				;$018C99	|
CODE_018C9B:
	JSR IsOnGround
	BEQ CODE_018CAE				;$018C9E	|
	JSR SetSomeYSpeed			;$018CA0	|
	LDA.b #$D0				;$018CA3	|
	LDY.w $160E,X				;$018CA5	|
	BNE CODE_018CAC				;$018CA8	|
	LDA.b #$B0				;$018CAA	|
CODE_018CAC:
	STA $AA,X
CODE_018CAE:
	JSR FlipIfTouchingObj
	JSR SetAnimationFrame			;$018CB1	|
	JSR SubOffscreen0Bnk1			;$018CB4	|
CODE_018CB7:
	JMP Spr0to13Gfx

DATA_018CBA:
	db $FF,$01

DATA_018CBC:
	db $F0,$10

RedHorzParaKoopa:
	JSR SubOffscreen1Bnk1
	BRA CODE_018CC6				;$018CC1	|

RedVertParaKoopa:
	JSR SubOffscreen0Bnk1
CODE_018CC6:
	LDA $9D
	BNE CODE_018D2A				;$018CC8	|
	LDA.w $157C,X				;$018CCA	|
	PHA					;$018CCD	|
	JSR UpdateDirection			;$018CCE	|
	PLA					;$018CD1	|
	CMP.w $157C,X				;$018CD2	|
	BEQ CODE_018CDC				;$018CD5	|
	LDA.b #$08				;$018CD7	|
	STA.w $15AC,X				;$018CD9	|
CODE_018CDC:
	JSR SetAnimationFrame
	LDA $9E,X				;$018CDF	|
	CMP.b #$0A				;$018CE1	|
	BNE CODE_018CEA				;$018CE3	|
	JSR SubSprYPosNoGrvty			;$018CE5	|
	BRA CODE_018CFD				;$018CE8	|

CODE_018CEA:
	LDY.b #$FC
	LDA.w $1570,X				;$018CEC	|
	AND.b #$20				;$018CEF	|
	BEQ CODE_018CF5				;$018CF1	|
	LDY.b #$04				;$018CF3	|
CODE_018CF5:
	STY $AA,X
	JSR SubSprYPosNoGrvty			;$018CF7	|
	JSR SubSprXPosNoGrvty			;$018CFA	|
CODE_018CFD:
	LDA.w $1540,X
	BNE CODE_018D27				;$018D00	|
	INC $C2,X				;$018D02	|
	LDA $C2,X				;$018D04	|
	AND.b #$03				;$018D06	|
	BNE CODE_018D27				;$018D08	|
	LDA.w $151C,X				;$018D0A	|
	AND.b #$01				;$018D0D	|
	TAY					;$018D0F	|
	LDA $B6,X				;$018D10	|
	CLC					;$018D12	|
	ADC.w DATA_018CBA,Y			;$018D13	|
	STA $AA,X				;$018D16	|
	STA $B6,X				;$018D18	|
	CMP.w DATA_018CBC,Y			;$018D1A	|
	BNE CODE_018D27				;$018D1D	|
	INC.w $151C,X				;$018D1F	|
	LDA.b #$30				;$018D22	|
	STA.w $1540,X				;$018D24	|
CODE_018D27:
	JSR SubSprSprPMarioSpr
CODE_018D2A:
	JSR CODE_018CB7
	RTS					;$018D2D	|

WingedGoomba:
	JSR SubOffscreen0Bnk1
	LDA $9D					;$018D31	|
	BEQ CODE_018D39				;$018D33	|
	JSR CODE_018DAC				;$018D35	|
	RTS					;$018D38	|

CODE_018D39:
	JSR CODE_018DBB
	JSR SubUpdateSprPos			;$018D3C	|
	DEC $AA,X				;$018D3F	|
	LDA $C2,X				;$018D41	|
	LSR					;$018D43	|
	LSR					;$018D44	|
	LSR					;$018D45	|
	AND.b #$01				;$018D46	|
	STA.w $1602,X				;$018D48	|
	JSR CODE_018DAC				;$018D4B	|
	INC $C2,X				;$018D4E	|
	LDA.w $151C,X				;$018D50	|
	BNE CODE_018D5F				;$018D53	|
	LDA $AA,X				;$018D55	|
	BPL CODE_018D5F				;$018D57	|
	INC.w $1570,X				;$018D59	|
	INC.w $1570,X				;$018D5C	|
CODE_018D5F:
	INC.w $1570,X
	JSR IsTouchingCeiling			;$018D62	|
	BEQ CODE_018D69				;$018D65	|
	STZ $AA,X				;$018D67	|
CODE_018D69:
	JSR IsOnGround
	BEQ CODE_018DA5				;$018D6C	|
	LDA $C2,X				;$018D6E	|
	AND.b #$3F				;$018D70	|
	BNE CODE_018D77				;$018D72	|
	JSR FaceMario				;$018D74	|
CODE_018D77:
	JSR SetSomeYSpeed
	LDA.w $151C,X				;$018D7A	|
	BNE CODE_018D82				;$018D7D	|
	STZ.w $1570,X				;$018D7F	|
CODE_018D82:
	LDA.w $1540,X
	BNE CODE_018DA5				;$018D85	|
	INC.w $151C,X				;$018D87	|
	LDY.b #$F0				;$018D8A	|
	LDA.w $151C,X				;$018D8C	|
	CMP.b #$04				;$018D8F	|
	BNE CODE_018DA3				;$018D91	|
	STZ.w $151C,X				;$018D93	|
	JSL GetRand				;$018D96	|
	AND.b #$3F				;$018D9A	|
	ORA.b #$50				;$018D9C	|
	STA.w $1540,X				;$018D9E	|
	LDY.b #$D0				;$018DA1	|
CODE_018DA3:
	STY $AA,X
CODE_018DA5:
	JSR FlipIfTouchingObj
	JSR SubSprSprPMarioSpr			;$018DA8	|
	RTS					;$018DAB	|

CODE_018DAC:
	JSR GoombaWingGfxRt
	LDA.w $15EA,X				;$018DAF	|
	CLC					;$018DB2	|
	ADC.b #$04				;$018DB3	|
	STA.w $15EA,X				;$018DB5	|
	JMP SubSprGfx2Entry1			;$018DB8	|

CODE_018DBB:
	LDA.b #$F8
	LDY.w $157C,X				;$018DBD	|
	BNE CODE_018DC4				;$018DC0	|
	LDA.b #$08				;$018DC2	|
CODE_018DC4:
	STA $B6,X
	RTS					;$018DC6	|

DATA_018DC7:
	db $F7,$0B,$F6,$0D,$FD,$0C,$FC,$0D
	db $0B,$F5,$0A,$F3,$0B,$FC,$0C,$FB
DATA_018DD7:
	db $F7,$F7,$F8,$F8,$01,$01,$02,$02
GoombaWingGfxProp:
	db $46,$06

GoombaWingTiles:
	db $C6,$C6,$5D,$5D

GoombaWingTileSize:
	db $02,$02,$00,$00

GoombaWingGfxRt:
	JSR GetDrawInfoBnk1
	LDA.w $1570,X				;$018DEC	|
	LSR					;$018DEF	|
	LSR					;$018DF0	|
	AND.b #$02				;$018DF1	|
	CLC					;$018DF3	|
	ADC.w $1602,X				;$018DF4	|
	STA $05					;$018DF7	|
	ASL					;$018DF9	|
	STA $02					;$018DFA	|
	LDA.w $157C,X				;$018DFC	|
	STA $04					;$018DFF	|
	LDY.w $15EA,X				;$018E01	|
	PHX					;$018E04	|
	LDX.b #$01				;$018E05	|
CODE_018E07:
	STX $03
	TXA					;$018E09	|
	CLC					;$018E0A	|
	ADC $02					;$018E0B	|
	PHA					;$018E0D	|
	LDX $04					;$018E0E	|
	BNE CODE_018E15				;$018E10	|
	CLC					;$018E12	|
	ADC.b #$08				;$018E13	|
CODE_018E15:
	TAX
	LDA $00					;$018E16	|
	CLC					;$018E18	|
	ADC.w DATA_018DC7,X			;$018E19	|
	STA.w $0300,Y				;$018E1C	|
	PLX					;$018E1F	|
	LDA $01					;$018E20	|
	CLC					;$018E22	|
	ADC.w DATA_018DD7,X			;$018E23	|
	STA.w $0301,Y				;$018E26	|
	LDX $05					;$018E29	|
	LDA.w GoombaWingTiles,X			;$018E2B	|
	STA.w $0302,Y				;$018E2E	|
	PHY					;$018E31	|
	TYA					;$018E32	|
	LSR					;$018E33	|
	LSR					;$018E34	|
	TAY					;$018E35	|
	LDA.w GoombaWingTileSize,X		;$018E36	|
	STA.w $0460,Y				;$018E39	|
	PLY					;$018E3C	|
	LDX $03					;$018E3D	|
	LDA $04					;$018E3F	|
	LSR					;$018E41	|
	LDA.w GoombaWingGfxProp,X		;$018E42	|
	BCS CODE_018E49				;$018E45	|
	EOR.b #$40				;$018E47	|
CODE_018E49:
	ORA $64
	STA.w $0303,Y				;$018E4B	|
	TYA					;$018E4E	|
	CLC					;$018E4F	|
	ADC.b #$08				;$018E50	|
	TAY					;$018E52	|
	DEX					;$018E53	|
	BPL CODE_018E07				;$018E54	|
	PLX					;$018E56	|
	LDY.b #$FF				;$018E57	|
	LDA.b #$02				;$018E59	|
	JSR FinishOAMWriteRt			;$018E5B	|
	RTS					;$018E5E	|

SetAnimationFrame:
	INC.w $1570,X
	LDA.w $1570,X				;$018E62	|
	LSR					;$018E65	|
	LSR					;$018E66	|
	LSR					;$018E67	|
	AND.b #$01				;$018E68	|
	STA.w $1602,X				;$018E6A	|
	RTS					;$018E6D	|

PiranhaSpeed:
	db $00,$F0,$00,$10

PiranTimeInState:
	db $20,$30,$20,$30

ClassicPiranhas:
	LDA.w $1594,X
	BNE CODE_018E9A				;$018E79	|
	LDA $64					;$018E7B	|
	PHA					;$018E7D	|
	LDA.w $15D0,X				;$018E7E	|
	BNE CODE_018E87				;$018E81	|
	LDA.b #$10				;$018E83	|
	STA $64					;$018E85	|
CODE_018E87:
	JSR SubSprGfx1
	LDY.w $15EA,X				;$018E8A	|
	LDA.w $030B,Y				;$018E8D	|
	AND.b #$F1				;$018E90	|
	ORA.b #$0B				;$018E92	|
	STA.w $030B,Y				;$018E94	|
	PLA					;$018E97	|
	STA $64					;$018E98	|
CODE_018E9A:
	JSR SubOffscreen0Bnk1
	LDA $9D					;$018E9D	|
	BNE Return018EC7			;$018E9F	|
	JSR SetAnimationFrame			;$018EA1	|
	LDA.w $1594,X				;$018EA4	|
	BNE CODE_018EAC				;$018EA7	|
	JSR SubSprSprPMarioSpr			;$018EA9	|
CODE_018EAC:
	LDA $C2,X
	AND.b #$03				;$018EAE	|
	TAY					;$018EB0	|
	LDA.w $1540,X				;$018EB1	|
	BEQ ChangePiranhaState			;$018EB4	|
	LDA.w PiranhaSpeed,Y			;$018EB6	|
	LDY $9E,X				;$018EB9	|
	CPY.b #$2A				;$018EBB	|
	BNE CODE_018EC2				;$018EBD	|
	EOR.b #$FF				;$018EBF	|
	INC A					;$018EC1	|
CODE_018EC2:
	STA $AA,X
	JSR SubSprYPosNoGrvty			;$018EC4	|
Return018EC7:
	RTS

ChangePiranhaState:
	LDA $C2,X
	AND.b #$03				;$018ECA	|
	STA $00					;$018ECC	|
	BNE CODE_018EE1				;$018ECE	|
	JSR SubHorizPos				;$018ED0	|
	LDA $0F					;$018ED3	|
	CLC					;$018ED5	|
	ADC.b #$1B				;$018ED6	|
	CMP.b #$37				;$018ED8	|
	LDA.b #$01				;$018EDA	|
	STA.w $1594,X				;$018EDC	|
	BCC Return018EEE			;$018EDF	|
CODE_018EE1:
	STZ.w $1594,X
	LDY $00					;$018EE4	|
	LDA.w PiranTimeInState,Y		;$018EE6	|
	STA.w $1540,X				;$018EE9	|
	INC $C2,X				;$018EEC	|
Return018EEE:
	RTS

CODE_018EEF:
	LDY.b #$07
CODE_018EF1:
	LDA.w $170B,Y
	BEQ CODE_018F07				;$018EF4	|
	DEY					;$018EF6	|
	BPL CODE_018EF1				;$018EF7	|
	DEC.w $18FC				;$018EF9	|
	BPL ADDR_018F03				;$018EFC	|
	LDA.b #$07				;$018EFE	|
	STA.w $18FC				;$018F00	|
ADDR_018F03:
	LDY.w $18FC
Return018F06:
	RTS

CODE_018F07:
	LDA.w $15A0,X
	BNE Return018F06			;$018F0A	|
	RTS					;$018F0C	|

HoppingFlame:
	LDA $9D
	BNE CODE_018F49				;$018F0F	|
	INC.w $1602,X				;$018F11	|
	JSR SetAnimationFrame			;$018F14	|
	JSR SubUpdateSprPos			;$018F17	|
	DEC $AA,X				;$018F1A	|
	JSR CODE_018DBB				;$018F1C	|
	ASL $B6,X				;$018F1F	|
	JSR IsOnGround				;$018F21	|
	BEQ CODE_018F43				;$018F24	|
	STZ $B6,X				;$018F26	|
	JSR SetSomeYSpeed			;$018F28	|
	LDA.w $1540,X				;$018F2B	|
	BEQ CODE_018F38				;$018F2E	|
	DEC A					;$018F30	|
	BNE CODE_018F43				;$018F31	|
	JSR CODE_018F50				;$018F33	|
	BRA CODE_018F43				;$018F36	|

CODE_018F38:
	JSL GetRand
	AND.b #$1F				;$018F3C	|
	ORA.b #$20				;$018F3E	|
	STA.w $1540,X				;$018F40	|
CODE_018F43:
	JSR FlipIfTouchingObj
	JSR MarioSprInteractRt			;$018F46	|
CODE_018F49:
	JSR SubOffscreen0Bnk1
	JSR SubSprGfx2Entry1			;$018F4C	|
	RTS					;$018F4F	|

CODE_018F50:
	JSL GetRand
	AND.b #$0F				;$018F54	|
	ORA.b #$D0				;$018F56	|
	STA $AA,X				;$018F58	|
	LDA.w $148D				;$018F5A	|
	AND.b #$03				;$018F5D	|
	BNE CODE_018F64				;$018F5F	|
	JSR FaceMario				;$018F61	|
CODE_018F64:
	JSR IsSprOffScreen
	BNE Return018F96			;$018F67	|
	JSR CODE_018EEF				;$018F69	|
	LDA $E4,X				;$018F6C	|
	CLC					;$018F6E	|
	ADC.b #$04				;$018F6F	|
	STA.w $171F,Y				;$018F71	|
	LDA.w $14E0,X				;$018F74	|
	ADC.b #$00				;$018F77	|
	STA.w $1733,Y				;$018F79	|
	LDA $D8,X				;$018F7C	|
	CLC					;$018F7E	|
	ADC.b #$08				;$018F7F	|
	STA.w $1715,Y				;$018F81	|
	LDA.w $14D4,X				;$018F84	|
	ADC.b #$00				;$018F87	|
	STA.w $1729,Y				;$018F89	|
	LDA.b #$03				;$018F8C	|
	STA.w $170B,Y				;$018F8E	|
	LDA.b #$FF				;$018F91	|
	STA.w $176F,Y				;$018F93	|
Return018F96:
	RTS

Lakitu:
	LDY.b #$00
	LDA.w $1558,X				;$018F99	|
	BEQ CODE_018FA0				;$018F9C	|
	LDY.b #$02				;$018F9E	|
CODE_018FA0:
	TYA
	STA.w $1602,X				;$018FA1	|
	JSR SubSprGfx1				;$018FA4	|
	LDA.w $1558,X				;$018FA7	|
	BEQ CODE_018FB8				;$018FAA	|
	LDY.w $15EA,X				;$018FAC	|
	LDA.w $0305,Y				;$018FAF	|
	SEC					;$018FB2	|
	SBC.b #$03				;$018FB3	|
	STA.w $0305,Y				;$018FB5	|
CODE_018FB8:
	LDA.w $151C,X
	BEQ SubSprSprPMarioSpr			;$018FBB	|
	JSL CODE_02E672				;$018FBD	|
SubSprSprPMarioSpr:
	JSR SubSprSprInteract
	JMP MarioSprInteractRt			;$018FC4	|

BulletGfxProp:
	db $42,$02,$03,$83,$03,$43,$03,$43
DATA_018FCF:
	db $00,$00,$01,$01,$02,$03,$03,$02
BulletSpeedX:
	db $20,$E0,$00,$00,$18,$18,$E8,$E8
BulletSpeedY:
	db $00,$00,$E0,$20,$E8,$18,$18,$E8

BulletBill:
	LDA.b #$01
	STA.w $157C,X				;$018FE9	|
	LDA $9D					;$018FEC	|
	BNE CODE_019014				;$018FEE	|
	LDY $C2,X				;$018FF0	|
	LDA.w BulletGfxProp,Y			;$018FF2	|
	STA.w $15F6,X				;$018FF5	|
	LDA.w DATA_018FCF,Y			;$018FF8	|
	STA.w $1602,X				;$018FFB	|
	LDA.w BulletSpeedX,Y			;$018FFE	|
	STA $B6,X				;$019001	|
	LDA.w BulletSpeedY,Y			;$019003	|
	STA $AA,X				;$019006	|
	JSR SubSprXPosNoGrvty			;$019008	|
	JSR SubSprYPosNoGrvty			;$01900B	|
	JSR CODE_019140				;$01900E	|
	JSR SubSprSprPMarioSpr			;$019011	|
CODE_019014:
	JSR SubOffscreen0Bnk1
	LDA $D8,X				;$019017	|
	SEC					;$019019	|
	SBC $1C					;$01901A	|
	CMP.b #$F0				;$01901C	|
	BCC CODE_019023				;$01901E	|
	STZ.w $14C8,X				;$019020	|
CODE_019023:
	LDA.w $1540,X
	BEQ CODE_01902B				;$019026	|
	JMP CODE_019546				;$019028	|

CODE_01902B:
	JMP SubSprGfx2Entry1

DATA_01902E:
	db $40,$10

DATA_019030:
	db $03,$01

SubUpdateSprPos:
	JSR SubSprYPosNoGrvty
	LDY.b #$00				;$019035	|
	LDA.w $164A,X				;$019037	|
	BEQ CODE_019049				;$01903A	|
	INY					;$01903C	|
	LDA $AA,X				;$01903D	|
	BPL CODE_019049				;$01903F	|
	CMP.b #$E8				;$019041	|
	BCS CODE_019049				;$019043	|
	LDA.b #$E8				;$019045	|
	STA $AA,X				;$019047	|
CODE_019049:
	LDA $AA,X
	CLC					;$01904B	|
	ADC.w DATA_019030,Y			;$01904C	|
	STA $AA,X				;$01904F	|
	BMI CODE_01905D				;$019051	|
	CMP.w DATA_01902E,Y			;$019053	|
	BCC CODE_01905D				;$019056	|
	LDA.w DATA_01902E,Y			;$019058	|
	STA $AA,X				;$01905B	|
CODE_01905D:
	LDA $B6,X
	PHA					;$01905F	|
	LDY.w $164A,X				;$019060	|
	BEQ CODE_019076				;$019063	|
	ASL					;$019065	|
	ROR $B6,X				;$019066	|
	LDA $B6,X				;$019068	|
	PHA					;$01906A	|
	STA $00					;$01906B	|
	ASL					;$01906D	|
	ROR $00					;$01906E	|
	PLA					;$019070	|
	CLC					;$019071	|
	ADC $00					;$019072	|
	STA $B6,X				;$019074	|
CODE_019076:
	JSR SubSprXPosNoGrvty
	PLA					;$019079	|
	STA $B6,X				;$01907A	|
	LDA.w $15DC,X				;$01907C	|
	BNE ADDR_019085				;$01907F	|
	JSR CODE_019140				;$019081	|
	RTS					;$019084	|

ADDR_019085:
	STZ.w $1588,X
	RTS					;$019088	|

FlipIfTouchingObj:
	LDA.w $157C,X
	INC A					;$01908C	|
	AND.w $1588,X				;$01908D	|
	AND.b #$03				;$019090	|
	BEQ Return019097			;$019092	|
	JSR FlipSpriteDir			;$019094	|
Return019097:
	RTS

FlipSpriteDir:
	LDA.w $15AC,X
	BNE Return0190B1			;$01909B	|
	LDA.b #$08				;$01909D	|
	STA.w $15AC,X				;$01909F	|
CODE_0190A2:
	LDA $B6,X
	EOR.b #$FF				;$0190A4	|
	INC A					;$0190A6	|
	STA $B6,X				;$0190A7	|
	LDA.w $157C,X				;$0190A9	|
	EOR.b #$01				;$0190AC	|
	STA.w $157C,X				;$0190AE	|
Return0190B1:
	RTS

GenericSprGfxRt2:
	PHB
	PHK					;$0190B3	|
	PLB					;$0190B4	|
	JSR SubSprGfx2Entry1			;$0190B5	|
	PLB					;$0190B8	|
	RTL					;$0190B9	|

SpriteObjClippingX:
	db $0E,$02,$08,$08,$0E,$02,$07,$07
	db $07,$07,$07,$07,$0E,$02,$08,$08
	db $10,$00,$08,$08,$0D,$02,$08,$08
	db $07,$00,$04,$04,$1F,$01,$10,$10
	db $0F,$00,$08,$08,$10,$00,$08,$08
	db $0D,$02,$08,$08,$0E,$02,$08,$08
	db $0D,$02,$08,$08,$10,$00,$08,$08
	db $1F,$00,$10,$10,$08

SpriteObjClippingY:
	db $08,$08,$10,$02,$12,$12,$20,$02
	db $07,$07,$07,$07,$10,$10,$20,$0B
	db $12,$12,$20,$02,$18,$18,$20,$10
	db $04,$04,$08,$00,$10,$10,$1F,$01
	db $08,$08,$0F,$00,$08,$08,$10,$00
	db $48,$48,$50,$42,$04,$04,$08,$00
	db $00,$00,$00,$00,$08,$08,$10,$00
	db $08,$08,$10,$00,$04

DATA_019134:
	db $01,$02,$04,$08

CODE_019138:
	PHB
	PHK					;$019139	|
	PLB					;$01913A	|
	JSR CODE_019140				;$01913B	|
	PLB					;$01913E	|
	RTL					;$01913F	|

CODE_019140:
	STZ.w $1694
	STZ.w $1588,X				;$019143	|
	STZ.w $15B8,X				;$019146	|
	STZ.w $185E				;$019149	|
	LDA.w $164A,X				;$01914C	|
	STA.w $1695				;$01914F	|
	STZ.w $164A,X				;$019152	|
	JSR CODE_019211				;$019155	|
	LDA $5B					;$019158	|
	BPL CODE_0191BE				;$01915A	|
	INC.w $185E				;$01915C	|
	LDA $E4,X				;$01915F	|
	CLC					;$019161	|
	ADC $26					;$019162	|
	STA $E4,X				;$019164	|
	LDA.w $14E0,X				;$019166	|
	ADC $27					;$019169	|
	STA.w $14E0,X				;$01916B	|
	LDA $D8,X				;$01916E	|
	CLC					;$019170	|
	ADC $28					;$019171	|
	STA $D8,X				;$019173	|
	LDA.w $14D4,X				;$019175	|
	ADC $29					;$019178	|
	STA.w $14D4,X				;$01917A	|
	JSR CODE_019211				;$01917D	|
	LDA $E4,X				;$019180	|
	SEC					;$019182	|
	SBC $26					;$019183	|
	STA $E4,X				;$019185	|
	LDA.w $14E0,X				;$019187	|
	SBC $27					;$01918A	|
	STA.w $14E0,X				;$01918C	|
	LDA $D8,X				;$01918F	|
	SEC					;$019191	|
	SBC $28					;$019192	|
	STA $D8,X				;$019194	|
	LDA.w $14D4,X				;$019196	|
	SBC $29					;$019199	|
	STA.w $14D4,X				;$01919B	|
	LDA.w $1588,X				;$01919E	|
	BPL CODE_0191BE				;$0191A1	|
	AND.b #$03				;$0191A3	|
	BNE CODE_0191BE				;$0191A5	|
	LDY.b #$00				;$0191A7	|
	LDA.w $17BF				;$0191A9	|
	EOR.b #$FF				;$0191AC	|
	INC A					;$0191AE	|
	BPL CODE_0191B2				;$0191AF	|
	DEY					;$0191B1	|
CODE_0191B2:
	CLC
	ADC $E4,X				;$0191B3	|
	STA $E4,X				;$0191B5	|
	TYA					;$0191B7	|
	ADC.w $14E0,X				;$0191B8	|
	STA.w $14E0,X				;$0191BB	|
CODE_0191BE:
	LDA.w $190F,X
	BPL CODE_0191ED				;$0191C1	|
	LDA.w $1588,X				;$0191C3	|
	AND.b #$03				;$0191C6	|
	BEQ CODE_0191ED				;$0191C8	|
	TAY					;$0191CA	|
	LDA.w $15D0,X				;$0191CB	|
	BNE CODE_0191ED				;$0191CE	|
	LDA $E4,X				;$0191D0	|
	CLC					;$0191D2	|
	ADC.w Return019283,Y			;$0191D3	|
	STA $E4,X				;$0191D6	|
	LDA.w $14E0,X				;$0191D8	|
	ADC.w DATA_019285,Y			;$0191DB	|
	STA.w $14E0,X				;$0191DE	|
	LDA $B6,X				;$0191E1	|
	BNE CODE_0191ED				;$0191E3	|
	LDA.w $1588,X				;$0191E5	|
	AND.b #$FC				;$0191E8	|
	STA.w $1588,X				;$0191EA	|
CODE_0191ED:
	LDA.w $164A,X
	EOR.w $1695				;$0191F0	|
	BEQ Return019210			;$0191F3	|
	ASL					;$0191F5	|
	LDA.w $166E,X				;$0191F6	|
	AND.b #$40				;$0191F9	|
	ORA.w $1FE2,X				;$0191FB	|
	BNE Return019210			;$0191FE	|
	BCS CODE_01920C				;$019200	|
	BIT.w $0D9B				;$019202	|
	BMI CODE_01920C				;$019205	|
	JSL CODE_0284C0				;$019207	|
	RTS					;$01920B	|

CODE_01920C:
	JSL CODE_028528
Return019210:
	RTS

CODE_019211:
	LDA.w $190E
	BEQ CODE_01925B				;$019214	|
	LDA $85					;$019216	|
	BNE CODE_019258				;$019218	|
	LDY.b #$3C				;$01921A	|
	JSR CODE_01944D				;$01921C	|
	BEQ CODE_019233				;$01921F	|
	LDA.w $1693				;$019221	|
	CMP.b #$6E				;$019224	|
	BCC CODE_01925B				;$019226	|
	JSL is_page_1_water			;$019228	|
	LDA.w $1693				;$01922C	|
	BCC CODE_01925B				;$01922F	|
	BCS CODE_01923A				;$019231	|
CODE_019233:
	LDA.w $1693
	CMP.b #$06				;$019236	|
	BCS CODE_01925B				;$019238	|
CODE_01923A:
	TAY
	LDA.w $164A,X				;$01923B	|
	ORA.b #$01				;$01923E	|
	CPY.b #$04				;$019240	|
	BNE CODE_019258				;$019242	|
	PHA					;$019244	|
	LDA $9E,X				;$019245	|
	CMP.b #$35				;$019247	|
	BEQ CODE_019252				;$019249	|
	LDA.w $167A,X				;$01924B	|
	AND.b #$02				;$01924E	|
	BNE CODE_019255				;$019250	|
CODE_019252:
	JSR CODE_019330
CODE_019255:
	PLA
	ORA.b #$80				;$019256	|
CODE_019258:
	STA.w $164A,X
CODE_01925B:
	LDA.w $1686,X
	BMI Return019210			;$01925E	|
	LDA.w $185E				;$019260	|
	BEQ CODE_01926F				;$019263	|
	BIT.w $190E				;$019265	|
	BVS Return0192C0			;$019268	|
	LDA.w $166E,X				;$01926A	|
	BMI Return0192C0			;$01926D	|
CODE_01926F:
	JSR CODE_0192C9
	LDA.w $190F,X				;$019272	|
	BPL CODE_019288				;$019275	|
	LDA $B6,X				;$019277	|
	ORA.w $15AC,X				;$019279	|
	BNE CODE_019288				;$01927C	|
	LDA $13					;$01927E	|
	JSR CODE_01928E				;$019280	|
Return019283:
	RTS

DATA_019284:
	db $FC

DATA_019285:
	db $04,$FF,$00

CODE_019288:
	LDA $B6,X
	BEQ Return0192C0			;$01928A	|
	ASL					;$01928C	|
	ROL					;$01928D	|
CODE_01928E:
	AND.b #$01
	TAY					;$019290	|
	JSR CODE_019441				;$019291	|
	STA.w $1862				;$019294	|
	BEQ CODE_0192BA				;$019297	|
	LDA.w $1693				;$019299	|
	CMP.b #$11				;$01929C	|
	BCC CODE_0192BA				;$01929E	|
	CMP.b #$6E				;$0192A0	|
	BCS CODE_0192BA				;$0192A2	|
	JSR CODE_019425				;$0192A4	|
	LDA.w $1693				;$0192A7	|
	STA.w $18A7				;$0192AA	|
	LDA.w $185E				;$0192AD	|
	BEQ CODE_0192BA				;$0192B0	|
	LDA.w $1588,X				;$0192B2	|
	ORA.b #$40				;$0192B5	|
	STA.w $1588,X				;$0192B7	|
CODE_0192BA:
	LDA.w $1693
	STA.w $1860				;$0192BD	|
Return0192C0:
	RTS

DATA_0192C1:
	db $FE,$02,$FF,$00

DATA_0192C5:
	db $01,$FF

DATA_0192C7:
	db $00,$FF

CODE_0192C9:
	LDY.b #$02
	LDA $AA,X				;$0192CB	|
	BPL CODE_0192D0				;$0192CD	|
	INY					;$0192CF	|
CODE_0192D0:
	JSR CODE_019441
	STA.w $18D7				;$0192D3	|
	PHP					;$0192D6	|
	LDA.w $1693				;$0192D7	|
	STA.w $185F				;$0192DA	|
	PLP					;$0192DD	|
	BEQ Return01930F			;$0192DE	|
	LDA.w $1693				;$0192E0	|
	CPY.b #$02				;$0192E3	|
	BEQ CODE_019310				;$0192E5	|
	CMP.b #$11				;$0192E7	|
	BCC Return01930F			;$0192E9	|
	CMP.b #$6E				;$0192EB	|
	BCC CODE_0192F9				;$0192ED	|
	CMP.w $1430				;$0192EF	|
	BCC Return01930F			;$0192F2	|
	CMP.w $1431				;$0192F4	|
	BCS Return01930F			;$0192F7	|
CODE_0192F9:
	JSR CODE_019425
	LDA.w $1693				;$0192FC	|
	STA.w $1868				;$0192FF	|
	LDA.w $185E				;$019302	|
	BEQ Return01930F			;$019305	|
	LDA.w $1588,X				;$019307	|
	ORA.b #$20				;$01930A	|
	STA.w $1588,X				;$01930C	|
Return01930F:
	RTS

CODE_019310:
	CMP.b #$59
	BCC CODE_01933B				;$019312	|
	CMP.b #$5C				;$019314	|
	BCS CODE_01933B				;$019316	|
	LDY.w $1931				;$019318	|
	CPY.b #$0E				;$01931B	|
	BEQ CODE_019323				;$01931D	|
	CPY.b #$03				;$01931F	|
	BNE CODE_01933B				;$019321	|
CODE_019323:
	LDA $9E,X
	CMP.b #$35				;$019325	|
	BEQ CODE_019330				;$019327	|
	LDA.w $167A,X				;$019329	|
	AND.b #$02				;$01932C	|
	BNE CODE_01933B				;$01932E	|
CODE_019330:
	LDA.b #$05
	STA.w $14C8,X				;$019332	|
	LDA.b #$40				;$019335	|
	STA.w $1558,X				;$019337	|
	RTS					;$01933A	|

CODE_01933B:
	CMP.b #$11
	BCC CODE_0193B0				;$01933D	|
	CMP.b #$6E				;$01933F	|
	BCC CODE_0193B8				;$019341	|
	CMP.b #$D8				;$019343	|
	BCS CODE_019386				;$019345	|
	JSL CODE_00FA19				;$019347	|
	LDA [$05],Y				;$01934B	|
	CMP.b #$10				;$01934D	|
	BEQ Return0193AF			;$01934F	|
	BCS CODE_019386				;$019351	|
	LDA $00					;$019353	|
	CMP.b #$0C				;$019355	|
	BCS CODE_01935D				;$019357	|
	CMP [$05],Y				;$019359	|
	BCC Return0193AF			;$01935B	|
CODE_01935D:
	LDA [$05],Y
	STA.w $1694				;$01935F	|
	PHX					;$019362	|
	LDX $08					;$019363	|
	LDA.l DATA_00E53D,X			;$019365	|
	PLX					;$019369	|
	STA.w $15B8,X				;$01936A	|
	CMP.b #$04				;$01936D	|
	BEQ CODE_019375				;$01936F	|
	CMP.b #$FC				;$019371	|
	BNE CODE_019384				;$019373	|
CODE_019375:
	EOR $B6,X
	BPL CODE_019380				;$019377	|
	LDA $B6,X				;$019379	|
	BEQ CODE_019380				;$01937B	|
	JSR FlipSpriteDir			;$01937D	|
CODE_019380:
	JSL CODE_03C1CA
CODE_019384:
	BRA CODE_0193B8

CODE_019386:
	LDA $0C
	AND.b #$0F				;$019388	|
	CMP.b #$05				;$01938A	|
	BCS Return0193AF			;$01938C	|
	LDA.w $14C8,X				;$01938E	|
	CMP.b #$02				;$019391	|
	BEQ Return0193AF			;$019393	|
	CMP.b #$05				;$019395	|
	BEQ Return0193AF			;$019397	|
	CMP.b #$0B				;$019399	|
	BEQ Return0193AF			;$01939B	|
	LDA $D8,X				;$01939D	|
	SEC					;$01939F	|
	SBC.b #$01				;$0193A0	|
	STA $D8,X				;$0193A2	|
	LDA.w $14D4,X				;$0193A4	|
	SBC.b #$00				;$0193A7	|
	STA.w $14D4,X				;$0193A9	|
	JSR CODE_0192C9				;$0193AC	|
Return0193AF:
	RTS

CODE_0193B0:
	LDA $0C
	AND.b #$0F				;$0193B2	|
	CMP.b #$05				;$0193B4	|
	BCS Return019424			;$0193B6	|
CODE_0193B8:
	LDA.w $1686,X
	AND.b #$04				;$0193BB	|
	BNE CODE_019414				;$0193BD	|
	LDA.w $14C8,X				;$0193BF	|
	CMP.b #$02				;$0193C2	|
	BEQ Return019424			;$0193C4	|
	CMP.b #$05				;$0193C6	|
	BEQ Return019424			;$0193C8	|
	CMP.b #$0B				;$0193CA	|
	BEQ Return019424			;$0193CC	|
	LDY.w $1693				;$0193CE	|
	CPY.b #$0C				;$0193D1	|
	BEQ CODE_0193D9				;$0193D3	|
	CPY.b #$0D				;$0193D5	|
	BNE CODE_019405				;$0193D7	|
CODE_0193D9:
	LDA $13
	AND.b #$03				;$0193DB	|
	BNE CODE_019405				;$0193DD	|
	JSR IsTouchingObjSide			;$0193DF	|
	BNE CODE_019405				;$0193E2	|
	LDA.w $1931				;$0193E4	|
	CMP.b #$02				;$0193E7	|
	BEQ ADDR_0193EF				;$0193E9	|
	CMP.b #$08				;$0193EB	|
	BNE CODE_019405				;$0193ED	|
ADDR_0193EF:
	TYA
	SEC					;$0193F0	|
	SBC.b #$0C				;$0193F1	|
	TAY					;$0193F3	|
	LDA $E4,X				;$0193F4	|
	CLC					;$0193F6	|
	ADC.w DATA_0192C5,Y			;$0193F7	|
	STA $E4,X				;$0193FA	|
	LDA.w $14E0,X				;$0193FC	|
	ADC.w DATA_0192C7,Y			;$0193FF	|
	STA.w $14E0,X				;$019402	|
CODE_019405:
	LDA.w $15D0,X
	BNE CODE_019414				;$019408	|
	LDA $D8,X				;$01940A	|
	AND.b #$F0				;$01940C	|
	CLC					;$01940E	|
	ADC.w $1694				;$01940F	|
	STA $D8,X				;$019412	|
CODE_019414:
	JSR CODE_019435
	LDA.w $185E				;$019417	|
	BEQ Return019424			;$01941A	|
	LDA.w $1588,X				;$01941C	|
	ORA.b #$80				;$01941F	|
	STA.w $1588,X				;$019421	|
Return019424:
	RTS

CODE_019425:
	LDA $0A
	STA $9A					;$019427	|
	LDA $0B					;$019429	|
	STA $9B					;$01942B	|
	LDA $0C					;$01942D	|
	STA $98					;$01942F	|
	LDA $0D					;$019431	|
	STA $99					;$019433	|
CODE_019435:
	LDY $0F
	LDA.w $1588,X				;$019437	|
	ORA.w DATA_019134,Y			;$01943A	|
	STA.w $1588,X				;$01943D	|
	RTS					;$019440	|

CODE_019441:
	STY $0F
	LDA.w $1656,X				;$019443	|
	AND.b #$0F				;$019446	|
	ASL					;$019448	|
	ASL					;$019449	|
	ADC $0F					;$01944A	|
	TAY					;$01944C	|
CODE_01944D:
	LDA.w $185E
	INC A					;$019450	|
	AND $5B					;$019451	|
	BEQ CODE_0194BF				;$019453	|
	LDA $D8,X				;$019455	|
	CLC					;$019457	|
	ADC.w SpriteObjClippingY,Y		;$019458	|
	STA $0C					;$01945B	|
	AND.b #$F0				;$01945D	|
	STA $00					;$01945F	|
	LDA.w $14D4,X				;$019461	|
	ADC.b #$00				;$019464	|
	CMP $5D					;$019466	|
	BCS CODE_0194B4				;$019468	|
	STA $0D					;$01946A	|
	LDA $E4,X				;$01946C	|
	CLC					;$01946E	|
	ADC.w SpriteObjClippingX,Y		;$01946F	|
	STA $0A					;$019472	|
	STA $01					;$019474	|
	LDA.w $14E0,X				;$019476	|
	ADC.b #$00				;$019479	|
	CMP.b #$02				;$01947B	|
	BCS CODE_0194B4				;$01947D	|
	STA $0B					;$01947F	|
	LDA $01					;$019481	|
	LSR					;$019483	|
	LSR					;$019484	|
	LSR					;$019485	|
	LSR					;$019486	|
	ORA $00					;$019487	|
	STA $00					;$019489	|
	LDX $0D					;$01948B	|
	LDA.l DATA_00BA80,X			;$01948D	|
	LDY.w $185E				;$019491	|
	BEQ CODE_01949A				;$019494	|
	LDA.l DATA_00BA8E,X			;$019496	|
CODE_01949A:
	CLC
	ADC $00					;$01949B	|
	STA $05					;$01949D	|
	LDA.l DATA_00BABC,X			;$01949F	|
	LDY.w $185E				;$0194A3	|
	BEQ CODE_0194AC				;$0194A6	|
	LDA.l DATA_00BACA,X			;$0194A8	|
CODE_0194AC:
	ADC $0B
	STA $06					;$0194AE	|
	JSR CODE_019523				;$0194B0	|
	RTS					;$0194B3	|

CODE_0194B4:
	LDY $0F
	LDA.b #$00				;$0194B6	|
	STA.w $1693				;$0194B8	|
	STA.w $1694				;$0194BB	|
	RTS					;$0194BE	|

CODE_0194BF:
	LDA $D8,X
	CLC					;$0194C1	|
	ADC.w SpriteObjClippingY,Y		;$0194C2	|
	STA $0C					;$0194C5	|
	AND.b #$F0				;$0194C7	|
	STA $00					;$0194C9	|
	LDA.w $14D4,X				;$0194CB	|
	ADC.b #$00				;$0194CE	|
	STA $0D					;$0194D0	|
	REP #$20				;$0194D2	|
	LDA $0C					;$0194D4	|
	CMP.w #$01B0				;$0194D6	|
	SEP #$20				;$0194D9	|
	BCS CODE_0194B4				;$0194DB	|
	LDA $E4,X				;$0194DD	|
	CLC					;$0194DF	|
	ADC.w SpriteObjClippingX,Y		;$0194E0	|
	STA $0A					;$0194E3	|
	STA $01					;$0194E5	|
	LDA.w $14E0,X				;$0194E7	|
	ADC.b #$00				;$0194EA	|
	STA $0B					;$0194EC	|
	BMI CODE_0194B4				;$0194EE	|
	CMP $5D					;$0194F0	|
	BCS CODE_0194B4				;$0194F2	|
	LDA $01					;$0194F4	|
	LSR					;$0194F6	|
	LSR					;$0194F7	|
	LSR					;$0194F8	|
	LSR					;$0194F9	|
	ORA $00					;$0194FA	|
	STA $00					;$0194FC	|
	LDX $0B					;$0194FE	|
	LDA.l DATA_00BA60,X			;$019500	|
	LDY.w $185E				;$019504	|
	BEQ CODE_01950D				;$019507	|
	LDA.l DATA_00BA70,X			;$019509	|
CODE_01950D:
	CLC
	ADC $00					;$01950E	|
	STA $05					;$019510	|
	LDA.l DATA_00BA9C,X			;$019512	|
	LDY.w $185E				;$019516	|
	BEQ CODE_01951F				;$019519	|
	LDA.l DATA_00BAAC,X			;$01951B	|
CODE_01951F:
	ADC $0D
	STA $06					;$019521	|
CODE_019523:
	LDA.b #$7E
	STA $07					;$019525	|
	LDX.w $15E9				;$019527	|
	LDA [$05]				;$01952A	|
	STA.w $1693				;$01952C	|
	INC $07					;$01952F	|
	LDA [$05]				;$019531	|
	JSL conditional_map16			;$019533	|
	LDY $0F					;$019537	|
	CMP.b #$00				;$019539	|
	RTS					;$01953B	|

HandleSprStunned:
	LDA $9E,X
	CMP.b #$2C				;$01953E	|
YoshiShellSts9:
	BNE CODE_019554
	LDA $C2,X				;$019542	|
	BEQ CODE_01956A				;$019544	|
CODE_019546:
	LDA $64
	PHA					;$019548	|
	LDA.b #$10				;$019549	|
	STA $64					;$01954B	|
	JSR SubSprGfx2Entry1			;$01954D	|
	PLA					;$019550	|
	STA $64					;$019551	|
	RTS					;$019553	|

CODE_019554:
	CMP.b #$2F
	BEQ SetNormalStatus2			;$019556	|
	CMP.b #$85				;$019558	|
	BEQ SetNormalStatus2			;$01955A	|
	CMP.b #$7D				;$01955C	|
	BNE CODE_01956A				;$01955E	|
	STZ $AA,X				;$019560	|
SetNormalStatus2:
	LDA.b #$08
	STA.w $14C8,X				;$019564	|
	JMP CODE_01A187				;$019567	|

CODE_01956A:
	LDA $9D
	BEQ CODE_019571				;$01956C	|
	JMP CODE_0195F5				;$01956E	|

CODE_019571:
	JSR CODE_019624
	JSR SubUpdateSprPos			;$019574	|
	JSR IsOnGround				;$019577	|
	BEQ CODE_019598				;$01957A	|
	JSR CODE_0197D5				;$01957C	|
	LDA $9E,X				;$01957F	|
	CMP.b #$16				;$019581	|
	BEQ ADDR_019589				;$019583	|
	CMP.b #$15				;$019585	|
	BNE CODE_01958C				;$019587	|
ADDR_019589:
	JMP SetNormalStatus2

CODE_01958C:
	CMP.b #$2C
	BNE CODE_019598				;$01958E	|
	LDA.b #$F0				;$019590	|
	STA $AA,X				;$019592	|
	JSL CODE_01F74C				;$019594	|
CODE_019598:
	JSR IsTouchingCeiling
	BEQ CODE_0195DB				;$01959B	|
	LDA.b #$10				;$01959D	|
	STA $AA,X				;$01959F	|
	JSR IsTouchingObjSide			;$0195A1	|
	BNE CODE_0195DB				;$0195A4	|
	LDA $E4,X				;$0195A6	|
	CLC					;$0195A8	|
	ADC.b #$08				;$0195A9	|
	STA $9A					;$0195AB	|
	LDA.w $14E0,X				;$0195AD	|
	ADC.b #$00				;$0195B0	|
	STA $9B					;$0195B2	|
	LDA $D8,X				;$0195B4	|
	AND.b #$F0				;$0195B6	|
	STA $98					;$0195B8	|
	LDA.w $14D4,X				;$0195BA	|
	STA $99					;$0195BD	|
	LDA.w $1588,X				;$0195BF	|
	AND.b #$20				;$0195C2	|
	ASL					;$0195C4	|
	ASL					;$0195C5	|
	ASL					;$0195C6	|
	ROL					;$0195C7	|
	AND.b #$01				;$0195C8	|
	STA.w $1933				;$0195CA	|
	LDY.b #$00				;$0195CD	|
	LDA.w $1868				;$0195CF	|
	JSL CODE_00F160				;$0195D2	|
	LDA.b #$08				;$0195D6	|
	STA.w $1FE2,X				;$0195D8	|
CODE_0195DB:
	JSR IsTouchingObjSide
	BEQ CODE_0195F2				;$0195DE	|
	LDA $9E,X				;$0195E0	|
	CMP.b #$0D				;$0195E2	|
	BCC CODE_0195E9				;$0195E4	|
	JSR CODE_01999E				;$0195E6	|
CODE_0195E9:
	LDA $B6,X
	ASL					;$0195EB	|
	PHP					;$0195EC	|
	ROR $B6,X				;$0195ED	|
	PLP					;$0195EF	|
	ROR $B6,X				;$0195F0	|
CODE_0195F2:
	JSR SubSprSprPMarioSpr
CODE_0195F5:
	JSR CODE_01A187
	JSR SubOffscreen0Bnk1			;$0195F8	|
	RTS					;$0195FB	|

Unused0195FC:
	db $00,$00,$00,$00,$04,$05,$06,$07
	db $00,$00,$00,$00,$04,$05,$06,$07
	db $00,$00,$00,$00,$04,$05,$06,$07
	db $00,$00,$00,$00,$04,$05,$06,$07
SpriteKoopasSpawn:
	db $00,$00,$00,$00,$00,$01,$02,$03

CODE_019624:
	LDA $9E,X
	CMP.b #$0D				;$019626	|
	BNE CODE_01965C				;$019628	|
	LDA.w $1540,X				;$01962A	|
	CMP.b #$01				;$01962D	|
	BNE CODE_01964E				;$01962F	|
	LDA.b #$09				;$019631	|
	STA.w $1DFC				;$019633	|
	LDA.b #$01				;$019636	|
	STA.w $1534,X				;$019638	|
	LDA.b #$40				;$01963B	|
	STA.w $1540,X				;$01963D	|
	LDA.b #$08				;$019640	|
	STA.w $14C8,X				;$019642	|
	LDA.w $1686,X				;$019645	|
	AND.b #$F7				;$019648	|
	STA.w $1686,X				;$01964A	|
	RTS					;$01964D	|

CODE_01964E:
	CMP.b #$40
	BCS Return01965B			;$019650	|
	ASL					;$019652	|
	AND.b #$0E				;$019653	|
	EOR.w $15F6,X				;$019655	|
	STA.w $15F6,X				;$019658	|
Return01965B:
	RTS

CODE_01965C:
	LDA.w $1540,X
	ORA.w $1558,X				;$01965F	|
	STA $C2,X				;$019662	|
	LDA.w $1558,X				;$019664	|
	BEQ CODE_01969C				;$019667	|
	CMP.b #$01				;$019669	|
	BNE CODE_01969C				;$01966B	|
	LDY.w $1594,X				;$01966D	|
	LDA.w $15D0,Y				;$019670	|
	BNE CODE_01969C				;$019673	|
	JSL LoadSpriteTables			;$019675	|
	JSR FaceMario				;$019679	|
	ASL.w $15F6,X				;$01967C	|
	LSR.w $15F6,X				;$01967F	|
	LDY.w $160E,X				;$019682	|
	LDA.b #$08				;$019685	|
	CPY.b #$03				;$019687	|
	BNE CODE_019698				;$019689	|
	INC.w $187B,X				;$01968B	|
	LDA.w $166E,X				;$01968E	|
	ORA.b #$30				;$019691	|
	STA.w $166E,X				;$019693	|
	LDA.b #$0A				;$019696	|
CODE_019698:
	STA.w $14C8,X
Return01969B:
	RTS

CODE_01969C:
	LDA.w $1540,X
	BEQ Return01969B			;$01969F	|
	CMP.b #$03				;$0196A1	|
	BEQ UnstunSprite			;$0196A3	|
	CMP.b #$01				;$0196A5	|
	BNE IncrmntStunTimer			;$0196A7	|
UnstunSprite:
	LDA $9E,X
	CMP.b #$11				;$0196AB	|
	BEQ SetNormalStatus			;$0196AD	|
	CMP.b #$2E				;$0196AF	|
	BEQ SetNormalStatus			;$0196B1	|
	CMP.b #$2D				;$0196B3	|
	BEQ Return0196CA			;$0196B5	|
	CMP.b #$A2				;$0196B7	|
	BEQ SetNormalStatus			;$0196B9	|
	CMP.b #$0F				;$0196BB	|
	BEQ SetNormalStatus			;$0196BD	|
	CMP.b #$2C				;$0196BF	|
	BEQ Return0196CA			;$0196C1	|
	CMP.b #$53				;$0196C3	|
	BNE GeneralResetSpr			;$0196C5	|
	JSR CODE_019ACB				;$0196C7	|
Return0196CA:
	RTS

SetNormalStatus:
	LDA.b #$08
	STA.w $14C8,X				;$0196CD	|
	ASL.w $15F6,X				;$0196D0	|
	LSR.w $15F6,X				;$0196D3	|
	RTS					;$0196D6	|

IncrmntStunTimer:
	LDA $13
	AND.b #$01				;$0196D9	|
	BNE Return0196E0			;$0196DB	|
	INC.w $1540,X				;$0196DD	|
Return0196E0:
	RTS

GeneralResetSpr:
	JSL FindFreeSprSlot
	BMI Return0196CA			;$0196E5	|
	LDA.b #$08				;$0196E7	|
	STA.w $14C8,Y				;$0196E9	|
	LDA $9E,X				;$0196EC	|
	TAX					;$0196EE	|
	LDA.w SpriteKoopasSpawn,X		;$0196EF	|
	STA.w $009E,y				;$0196F2	|
	TYX					;$0196F5	|
	JSL InitSpriteTables			;$0196F6	|
	LDX.w $15E9				;$0196FA	|
	LDA $E4,X				;$0196FD	|
	STA.w $00E4,y				;$0196FF	|
	LDA.w $14E0,X				;$019702	|
	STA.w $14E0,Y				;$019705	|
	LDA $D8,X				;$019708	|
	STA.w $00D8,y				;$01970A	|
	LDA.w $14D4,X				;$01970D	|
	STA.w $14D4,Y				;$019710	|
	LDA.b #$00				;$019713	|
	STA.w $157C,Y				;$019715	|
	LDA.b #$10				;$019718	|
	STA.w $1564,Y				;$01971A	|
	LDA.w $164A,X				;$01971D	|
	STA.w $164A,Y				;$019720	|
	LDA.w $1540,X				;$019723	|
	STZ.w $1540,X				;$019726	|
	CMP.b #$01				;$019729	|
	BEQ CODE_019747				;$01972B	|
	LDA.b #$D0				;$01972D	|
	STA.w $00AA,y				;$01972F	|
	PHY					;$019732	|
	JSR SubHorizPos				;$019733	|
	TYA					;$019736	|
	EOR.b #$01				;$019737	|
	PLY					;$019739	|
	STA.w $157C,Y				;$01973A	|
	PHX					;$01973D	|
	TAX					;$01973E	|
	LDA.w Spr0to13SpeedX,X			;$01973F	|
	STA.w $00B6,y				;$019742	|
	PLX					;$019745	|
	RTS					;$019746	|

CODE_019747:
	PHY
	JSR SubHorizPos				;$019748	|
	LDA.w DATA_0197AD,Y			;$01974B	|
	STY $00					;$01974E	|
	PLY					;$019750	|
	STA.w $00B6,y				;$019751	|
	LDA $00					;$019754	|
	EOR.b #$01				;$019756	|
	STA.w $157C,Y				;$019758	|
	STA $01					;$01975B	|
	LDA.b #$10				;$01975D	|
	STA.w $154C,Y				;$01975F	|
	STA.w $1528,Y				;$019762	|
	LDA $9E,X				;$019765	|
	CMP.b #$07				;$019767	|
	BNE Return019775			;$019769	|
	LDY.b #$08				;$01976B	|
CODE_01976D:
	LDA.w $14C8,Y
	BEQ SpawnMovingCoin			;$019770	|
	DEY					;$019772	|
	BPL CODE_01976D				;$019773	|
Return019775:
	RTS

SpawnMovingCoin:
	LDA.b #$08
	STA.w $14C8,Y				;$019778	|
	LDA.b #$21				;$01977B	|
	STA.w $009E,y				;$01977D	|
	LDA $E4,X				;$019780	|
	STA.w $00E4,y				;$019782	|
	LDA.w $14E0,X				;$019785	|
	STA.w $14E0,Y				;$019788	|
	LDA $D8,X				;$01978B	|
	STA.w $00D8,y				;$01978D	|
	LDA.w $14D4,X				;$019790	|
	STA.w $14D4,Y				;$019793	|
	PHX					;$019796	|
	TYX					;$019797	|
	JSL InitSpriteTables			;$019798	|
	PLX					;$01979C	|
	LDA.b #$D0				;$01979D	|
	STA.w $00AA,y				;$01979F	|
	LDA $01					;$0197A2	|
	STA.w $157C,Y				;$0197A4	|
	LDA.b #$20				;$0197A7	|
	STA.w $154C,Y				;$0197A9	|
	RTS					;$0197AC	|

DATA_0197AD:
	db $C0,$40

DATA_0197AF:
	db $00,$00,$00,$F8,$F8,$F8,$F8,$F8
	db $F8,$F7,$F6,$F5,$F4,$F3,$F2,$E8
	db $E8,$E8,$E8,$00,$00,$00,$00,$FE
	db $FC,$F8,$EC,$EC,$EC,$E8,$E4,$E0
	db $DC,$D8,$D4,$D0,$CC,$C8

CODE_0197D5:
	LDA $B6,X
	PHP					;$0197D7	|
	BPL CODE_0197DD				;$0197D8	|
	JSR InvertAccum				;$0197DA	|
CODE_0197DD:
	LSR
	PLP					;$0197DE	|
	BPL CODE_0197E4				;$0197DF	|
	JSR InvertAccum				;$0197E1	|
CODE_0197E4:
	STA $B6,X
	LDA $AA,X				;$0197E6	|
	PHA					;$0197E8	|
	JSR SetSomeYSpeed			;$0197E9	|
	PLA					;$0197EC	|
	LSR					;$0197ED	|
	LSR					;$0197EE	|
	TAY					;$0197EF	|
	LDA $9E,X				;$0197F0	|
	CMP.b #$0F				;$0197F2	|
	BNE CODE_0197FB				;$0197F4	|
	TYA					;$0197F6	|
	CLC					;$0197F7	|
	ADC.b #$13				;$0197F8	|
	TAY					;$0197FA	|
CODE_0197FB:
	LDA.w DATA_0197AF,Y
	LDY.w $1588,X				;$0197FE	|
	BMI Return019805			;$019801	|
	STA $AA,X				;$019803	|
Return019805:
	RTS

CODE_019806:
	LDA.b #$06
	LDY.w $15EA,X				;$019808	|
	BNE CODE_01980F				;$01980B	|
	LDA.b #$08				;$01980D	|
CODE_01980F:
	STA.w $1602,X
	LDA.w $15EA,X				;$019812	|
	PHA					;$019815	|
	BEQ CODE_01981B				;$019816	|
	CLC					;$019818	|
	ADC.b #$08				;$019819	|
CODE_01981B:
	STA.w $15EA,X
	JSR SubSprGfx2Entry1			;$01981E	|
	PLA					;$019821	|
	STA.w $15EA,X				;$019822	|
	LDA.w $1EEB				;$019825	|
	BMI Return0198A6			;$019828	|
	LDA.w $1602,X				;$01982A	|
	CMP.b #$06				;$01982D	|
	BNE Return0198A6			;$01982F	|
	LDY.w $15EA,X				;$019831	|
	LDA.w $1558,X				;$019834	|
	BNE CODE_019842				;$019837	|
	LDA.w $1540,X				;$019839	|
	BEQ Return0198A6			;$01983C	|
	CMP.b #$30				;$01983E	|
	BCS CODE_01984D				;$019840	|
CODE_019842:
	LSR
	LDA.w $0308,Y				;$019843	|
	ADC.b #$00				;$019846	|
	BCS CODE_01984D				;$019848	|
	STA.w $0308,Y				;$01984A	|
CODE_01984D:
	LDA $9E,X
	CMP.b #$11				;$01984F	|
	BEQ Return0198A6			;$019851	|
	JSR IsSprOffScreen			;$019853	|
	BNE Return0198A6			;$019856	|
	LDA.w $15F6,X				;$019858	|
	ASL					;$01985B	|
	LDA.b #$08				;$01985C	|
	BCC CODE_019862				;$01985E	|
	LDA.b #$00				;$019860	|
CODE_019862:
	STA $00
	LDA.w $0308,Y				;$019864	|
	CLC					;$019867	|
	ADC.b #$02				;$019868	|
	STA.w $0300,Y				;$01986A	|
	CLC					;$01986D	|
	ADC.b #$04				;$01986E	|
	STA.w $0304,Y				;$019870	|
	LDA.w $0309,Y				;$019873	|
	CLC					;$019876	|
	ADC $00					;$019877	|
	STA.w $0301,Y				;$019879	|
	STA.w $0305,Y				;$01987C	|
	PHY					;$01987F	|
	LDY.b #$64				;$019880	|
	LDA $14					;$019882	|
	AND.b #$F8				;$019884	|
	BNE CODE_01988A				;$019886	|
	LDY.b #$4D				;$019888	|
CODE_01988A:
	TYA
	PLY					;$01988B	|
	STA.w $0302,Y				;$01988C	|
	STA.w $0306,Y				;$01988F	|
	LDA $64					;$019892	|
	STA.w $0303,Y				;$019894	|
	STA.w $0307,Y				;$019897	|
	TYA					;$01989A	|
	LSR					;$01989B	|
	LSR					;$01989C	|
	TAY					;$01989D	|
	LDA.b #$00				;$01989E	|
	STA.w $0460,Y				;$0198A0	|
	STA.w $0461,Y				;$0198A3	|
Return0198A6:
	RTS

DATA_0198A7:
	db $E0,$20

CODE_0198A9:
	LDA $9D
	BEQ CODE_0198B0				;$0198AB	|
	JMP CODE_019A2A				;$0198AD	|

CODE_0198B0:
	JSR SubUpdateSprPos
	LDA.w $151C,X				;$0198B3	|
	AND.b #$1F				;$0198B6	|
	BNE CODE_0198BD				;$0198B8	|
	JSR FaceMario				;$0198BA	|
CODE_0198BD:
	LDA $B6,X
	LDY.w $157C,X				;$0198BF	|
	CPY.b #$00				;$0198C2	|
	BNE CODE_0198D0				;$0198C4	|
	CMP.b #$20				;$0198C6	|
	BPL CODE_0198D8				;$0198C8	|
	INC $B6,X				;$0198CA	|
	INC $B6,X				;$0198CC	|
	BRA CODE_0198D8				;$0198CE	|

CODE_0198D0:
	CMP.b #$E0
	BMI CODE_0198D8				;$0198D2	|
	DEC $B6,X				;$0198D4	|
	DEC $B6,X				;$0198D6	|
CODE_0198D8:
	JSR IsTouchingObjSide
	BEQ CODE_0198EA				;$0198DB	|
	PHA					;$0198DD	|
	JSR CODE_01999E				;$0198DE	|
	PLA					;$0198E1	|
	AND.b #$03				;$0198E2	|
	TAY					;$0198E4	|
	LDA.w Return0198A6,Y			;$0198E5	|
	STA $B6,X				;$0198E8	|
CODE_0198EA:
	JSR IsOnGround
	BEQ CODE_0198F6				;$0198ED	|
	JSR SetSomeYSpeed			;$0198EF	|
	LDA.b #$10				;$0198F2	|
	STA $AA,X				;$0198F4	|
CODE_0198F6:
	JSR IsTouchingCeiling
	BEQ CODE_0198FD				;$0198F9	|
	STZ $AA,X				;$0198FB	|
CODE_0198FD:
	LDA $13
	AND.b #$01				;$0198FF	|
	BNE CODE_01990D				;$019901	|
	LDA.w $15F6,X				;$019903	|
	INC A					;$019906	|
	INC A					;$019907	|
	AND.b #$CF				;$019908	|
	STA.w $15F6,X				;$01990A	|
CODE_01990D:
	JMP CODE_01998C

DATA_019910:
	db $F0,$EE,$EC

HandleSprKicked:
	LDA.w $187B,X
	BEQ CODE_01991B				;$019916	|
	JMP CODE_0198A9				;$019918	|

CODE_01991B:
	LDA.w $167A,X
	AND.b #$10				;$01991E	|
	BEQ CODE_019928				;$019920	|
	JSR CODE_01AA0B				;$019922	|
	JMP CODE_01A187				;$019925	|

CODE_019928:
	LDA.w $1528,X
	BNE CODE_019939				;$01992B	|
	LDA $B6,X				;$01992D	|
	CLC					;$01992F	|
	ADC.b #$20				;$019930	|
	CMP.b #$40				;$019932	|
	BCS CODE_019939				;$019934	|
	JSR CODE_01AA0B				;$019936	|
CODE_019939:
	STZ.w $1528,X
	LDA $9D					;$01993C	|
	ORA.w $163E,X				;$01993E	|
	BEQ CODE_019946				;$019941	|
	JMP CODE_01998F				;$019943	|

CODE_019946:
	JSR UpdateDirection
	LDA.w $15B8,X				;$019949	|
	PHA					;$01994C	|
	JSR SubUpdateSprPos			;$01994D	|
	PLA					;$019950	|
	BEQ CODE_019969				;$019951	|
	STA $00					;$019953	|
	LDY.w $164A,X				;$019955	|
	BNE CODE_019969				;$019958	|
	CMP.w $15B8,X				;$01995A	|
	BEQ CODE_019969				;$01995D	|
	EOR $B6,X				;$01995F	|
	BMI CODE_019969				;$019961	|
	LDA.b #$F8				;$019963	|
	STA $AA,X				;$019965	|
	BRA CODE_019975				;$019967	|

CODE_019969:
	JSR IsOnGround
	BEQ CODE_019984				;$01996C	|
	JSR SetSomeYSpeed			;$01996E	|
	LDA.b #$10				;$019971	|
	STA $AA,X				;$019973	|
CODE_019975:
	LDA.w $1860
	CMP.b #$B5				;$019978	|
	BEQ CODE_019980				;$01997A	|
	CMP.b #$B4				;$01997C	|
	BNE CODE_019984				;$01997E	|
CODE_019980:
	LDA.b #$B8
	STA $AA,X				;$019982	|
CODE_019984:
	JSR IsTouchingObjSide
	BEQ CODE_01998C				;$019987	|
	JSR CODE_01999E				;$019989	|
CODE_01998C:
	JSR SubSprSprPMarioSpr
CODE_01998F:
	JSR SubOffscreen0Bnk1
	LDA $9E,X				;$019992	|
	CMP.b #$53				;$019994	|
	BEQ CODE_01999B				;$019996	|
	JMP CODE_019A2A				;$019998	|

CODE_01999B:
	JMP StunThrowBlock

CODE_01999E:
	LDA.b #$01
	STA.w $1DF9				;$0199A0	|
	JSR CODE_0190A2				;$0199A3	|
	LDA.w $15A0,X				;$0199A6	|
	BNE CODE_0199D2				;$0199A9	|
	LDA $E4,X				;$0199AB	|
	SEC					;$0199AD	|
	SBC $1A					;$0199AE	|
	CLC					;$0199B0	|
	ADC.b #$14				;$0199B1	|
	CMP.b #$1C				;$0199B3	|
	BCC CODE_0199D2				;$0199B5	|
	LDA.w $1588,X				;$0199B7	|
	AND.b #$40				;$0199BA	|
	ASL					;$0199BC	|
	ASL					;$0199BD	|
	ROL					;$0199BE	|
	AND.b #$01				;$0199BF	|
	STA.w $1933				;$0199C1	|
	LDY.b #$00				;$0199C4	|
	LDA.w $18A7				;$0199C6	|
	JSL CODE_00F160				;$0199C9	|
	LDA.b #$05				;$0199CD	|
	STA.w $1FE2,X				;$0199CF	|
CODE_0199D2:
	LDA $9E,X
	CMP.b #$53				;$0199D4	|
	BNE Return0199DB			;$0199D6	|
	JSR BreakThrowBlock			;$0199D8	|
Return0199DB:
	RTS

BreakThrowBlock:
	STZ.w $14C8,X
	LDY.b #$FF				;$0199DF	|
CODE_0199E1:
	JSR IsSprOffScreen
	BNE Return019A03			;$0199E4	|
	LDA $E4,X				;$0199E6	|
	STA $9A					;$0199E8	|
	LDA.w $14E0,X				;$0199EA	|
	STA $9B					;$0199ED	|
	LDA $D8,X				;$0199EF	|
	STA $98					;$0199F1	|
	LDA.w $14D4,X				;$0199F3	|
	STA $99					;$0199F6	|
	PHB					;$0199F8	|
	LDA.b #$02				;$0199F9	|
	PHA					;$0199FB	|
	PLB					;$0199FC	|
	TYA					;$0199FD	|
	JSL ShatterBlock			;$0199FE	|
	PLB					;$019A02	|
Return019A03:
	RTS

SetSomeYSpeed:
	LDA.w $1588,X
	BMI CODE_019A10				;$019A07	|
	LDA.b #$00				;$019A09	|
	LDY.w $15B8,X				;$019A0B	|
	BEQ CODE_019A12				;$019A0E	|
CODE_019A10:
	LDA.b #$18
CODE_019A12:
	STA $AA,X
	RTS					;$019A14	|

UpdateDirection:
	LDA.b #$00
	LDY $B6,X				;$019A17	|
	BEQ Return019A21			;$019A19	|
	BPL CODE_019A1E				;$019A1B	|
	INC A					;$019A1D	|
CODE_019A1E:
	STA.w $157C,X
Return019A21:
	RTS

ShellAniTiles:
	db $06,$07,$08,$07

ShellGfxProp:
	db $00,$00,$00,$40

CODE_019A2A:
	LDA $C2,X
	STA.w $1558,X				;$019A2C	|
	LDA $14					;$019A2F	|
	LSR					;$019A31	|
	LSR					;$019A32	|
	AND.b #$03				;$019A33	|
	TAY					;$019A35	|
	PHY					;$019A36	|
	LDA.w ShellAniTiles,Y			;$019A37	|
	JSR CODE_01980F				;$019A3A	|
	STZ.w $1558,X				;$019A3D	|
	PLY					;$019A40	|
	LDA.w ShellGfxProp,Y			;$019A41	|
	LDY.w $15EA,X				;$019A44	|
	EOR.w $030B,Y				;$019A47	|
	STA.w $030B,Y				;$019A4A	|
	RTS					;$019A4D	|

SpinJumpSmokeTiles:
	db $64,$62,$60,$62

HandleSprSpinJump:
	LDA.w $1540,X
	BEQ SpinJumpEraseSpr			;$019A55	|
	JSR SubSprGfx2Entry1			;$019A57	|
	LDY.w $15EA,X				;$019A5A	|
	LDA.w $1540,X				;$019A5D	|
	LSR					;$019A60	|
	LSR					;$019A61	|
	LSR					;$019A62	|
	AND.b #$03				;$019A63	|
	PHX					;$019A65	|
	TAX					;$019A66	|
	LDA.w SpinJumpSmokeTiles,X		;$019A67	|
	PLX					;$019A6A	|
	STA.w $0302,Y				;$019A6B	|
	STA.w $0303,Y				;$019A6E	|
	AND.b #$30				;$019A71	|
	STA.w $0303,Y				;$019A73	|
	RTS					;$019A76	|

SpinJumpEraseSpr:
	JSR OffScrEraseSprite
	RTS					;$019A7A	|

CODE_019A7B:
	LDA.w $1558,X
	BEQ SpinJumpEraseSpr			;$019A7E	|
	LDA.b #$04				;$019A80	|
	STA $AA,X				;$019A82	|
	ASL.w $190F,X				;$019A84	|
	LSR.w $190F,X				;$019A87	|
	LDA $B6,X				;$019A8A	|
	BEQ CODE_019A9D				;$019A8C	|
	BPL CODE_019A94				;$019A8E	|
	INC $B6,X				;$019A90	|
	BRA CODE_019A9D				;$019A92	|

CODE_019A94:
	DEC $B6,X
	JSR IsTouchingObjSide			;$019A96	|
	BEQ CODE_019A9D				;$019A99	|
	STZ $B6,X				;$019A9B	|
CODE_019A9D:
	LDA.b #$01
	STA.w $1632,X				;$019A9F	|
HandleSprKilled:
	LDA $9E,X
	CMP.b #$86				;$019AA4	|
	BNE CODE_019AAB				;$019AA6	|
	JMP CallSpriteMain			;$019AA8	|

CODE_019AAB:
	CMP.b #$1E
	BNE CODE_019AB4				;$019AAD	|
	LDY.b #$FF				;$019AAF	|
	STY.w $18E0				;$019AB1	|
CODE_019AB4:
	CMP.b #$53
	BNE CODE_019ABC				;$019AB6	|
	JSR BreakThrowBlock			;$019AB8	|
	RTS					;$019ABB	|

CODE_019ABC:
	CMP.b #$4C
	BNE CODE_019AC4				;$019ABE	|
	JSL CODE_02E463				;$019AC0	|
CODE_019AC4:
	LDA.w $1656,X
	AND.b #$80				;$019AC7	|
	BEQ CODE_019AD6				;$019AC9	|
CODE_019ACB:
	LDA.b #$04
	STA.w $14C8,X				;$019ACD	|
	LDA.b #$1F				;$019AD0	|
	STA.w $1540,X				;$019AD2	|
	RTS					;$019AD5	|

CODE_019AD6:
	LDA $9D
	BNE CODE_019ADD				;$019AD8	|
	JSR SubUpdateSprPos			;$019ADA	|
CODE_019ADD:
	JSR SubOffscreen0Bnk1
	JSR HandleSpriteDeath			;$019AE0	|
	RTS					;$019AE3	|

HandleSprSmushed:
	LDA $9D
	BNE CODE_019AFE				;$019AE6	|
	LDA.w $1540,X				;$019AE8	|
	BNE ShowSmushedGfx			;$019AEB	|
	STZ.w $14C8,X				;$019AED	|
	RTS					;$019AF0	|

ShowSmushedGfx:
	JSR SubUpdateSprPos
	JSR IsOnGround				;$019AF4	|
	BEQ CODE_019AFE				;$019AF7	|
	JSR SetSomeYSpeed			;$019AF9	|
	STZ $B6,X				;$019AFC	|
CODE_019AFE:
	LDA $9E,X
	CMP.b #$6F				;$019B00	|
	BNE CODE_019B10				;$019B02	|
	JSR SubSprGfx2Entry1			;$019B04	|
	LDY.w $15EA,X				;$019B07	|
	LDA.b #$AC				;$019B0A	|
	STA.w $0302,Y				;$019B0C	|
	RTS					;$019B0F	|

CODE_019B10:
	JMP SmushedGfxRt

HandleSpriteDeath:
	LDA.w $167A,X
	AND.b #$01				;$019B16	|
	BEQ CODE_019B1D				;$019B18	|
	JMP CallSpriteMain			;$019B1A	|

CODE_019B1D:
	STZ.w $1602,X
	LDA.w $190F,X				;$019B20	|
	AND.b #$20				;$019B23	|
	BEQ CODE_019B64				;$019B25	|
	LDA.w $1662,X				;$019B27	|
	AND.b #$40				;$019B2A	|
	BNE CODE_019B5F				;$019B2C	|
	LDA $9E,X				;$019B2E	|
	CMP.b #$1E				;$019B30	|
	BEQ CODE_019B3D				;$019B32	|
	CMP.b #$4B				;$019B34	|
	BNE CODE_019B44				;$019B36	|
	LDA.b #$01				;$019B38	|
	STA.w $1632,X				;$019B3A	|
CODE_019B3D:
	LDA.b #$01
	STA.w $1602,X				;$019B3F	|
	BRA CODE_019B4C				;$019B42	|

CODE_019B44:
	LDA.w $15F6,X
	ORA.b #$80				;$019B47	|
	STA.w $15F6,X				;$019B49	|
CODE_019B4C:
	LDA $64
	PHA					;$019B4E	|
	LDY.w $1632,X				;$019B4F	|
	BEQ CODE_019B56				;$019B52	|
	LDA.b #$10				;$019B54	|
CODE_019B56:
	STA $64
	JSR SubSprGfx1				;$019B58	|
	PLA					;$019B5B	|
	STA $64					;$019B5C	|
	RTS					;$019B5E	|

CODE_019B5F:
	LDA.b #$06
	STA.w $1602,X				;$019B61	|
CODE_019B64:
	LDA.b #$00
	CPY.b #$1C				;$019B66	|
	BEQ CODE_019B6C				;$019B68	|
	LDA.b #$80				;$019B6A	|
CODE_019B6C:
	STA $00
	LDA $64					;$019B6E	|
	PHA					;$019B70	|
	LDY.w $1632,X				;$019B71	|
	BEQ CODE_019B78				;$019B74	|
	LDA.b #$10				;$019B76	|
CODE_019B78:
	STA $64
	LDA $00					;$019B7A	|
	JSR SubSprGfx2Entry0			;$019B7C	|
	PLA					;$019B7F	|
	STA $64					;$019B80	|
	RTS					;$019B82	|

SprTilemap:
	db $82,$A0,$82,$A2,$84,$A4,$8C,$8A
	db $8E,$C8,$CA,$CA,$CE,$CC,$86,$4E
	db $E0,$E2,$E2,$CE,$E4,$E0,$E0,$A3
	db $A3,$B3,$B3,$E9,$E8,$F9,$F8,$E8
	db $E9,$F8,$F9,$E2,$E6,$AA,$A8,$A8
	db $AA,$A2,$A2,$B2,$B2,$C3,$C2,$D3
	db $D2,$C2,$C3,$D2,$D3,$E2,$E6,$CA
	db $CC,$CA,$AC,$CE,$AE,$CE,$83,$83
	db $C4,$C4,$83,$83,$C5,$C5,$8A,$A6
	db $A4,$A6,$A8,$80,$82,$80,$84,$84
	db $84,$84,$94,$94,$94,$94,$A0,$B0
	db $A0,$D0,$82,$80,$82,$00,$00,$00
	db $86,$84,$88,$EC,$8C,$A8,$AA,$8E
	db $AC,$AE,$8E,$EC,$EE,$CE,$EE,$A8
	db $EE,$40,$40,$A0,$C0,$A0,$C0,$A4
	db $C4,$A4,$C4,$A0,$C0,$A0,$C0,$40
	db $07,$27,$4C,$29,$4E,$2B,$82,$A0
	db $84,$A4,$67,$69,$88,$CE,$8E,$AE
	db $A2,$A2,$B2,$B2,$00,$40,$44,$42
	db $2C,$42,$28,$28,$28,$28,$4C,$4C
	db $4C,$4C,$83,$83,$6F,$6F,$AC,$BC
	db $AC,$A6,$8C,$AA,$86,$84,$DC,$EC
	db $DE,$EE,$06,$06,$16,$16,$07,$07
	db $17,$17,$16,$16,$06,$06,$17,$17
	db $07,$07,$84,$86,$00,$00,$00,$0E
	db $2A,$24,$02,$06,$0A,$20,$22,$28
	db $26,$2E,$40,$42,$0C,$04,$2B,$6A
	db $ED,$88,$8C,$A8,$8E,$AA,$AE,$8C
	db $88,$A8,$AE,$AC,$8C,$8E,$CE,$EE
	db $C4,$C6,$82,$84,$86,$8C,$CE,$CE
	db $88,$89,$CE,$CE,$89,$88,$F3,$CE
	db $F3,$CE,$A7,$A9

SprTilemapOffset:
	db $09,$09,$10,$09,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$37,$00,$25
	db $25,$5A,$00,$4B,$4E,$8A,$8A,$8A
	db $8A,$56,$3A,$46,$47,$69,$6B,$73
	db $00,$00,$80,$80,$80,$80,$8E,$90
	db $00,$00,$3A,$F6,$94,$95,$63,$9A
	db $A6,$AA,$AE,$B2,$C2,$C4,$D5,$D9
	db $D7,$D7,$E6,$E6,$E6,$E2,$99,$17
	db $29,$E6,$E6,$E6,$00,$E8,$00,$8A
	db $E8,$00,$ED,$EA,$7F,$EA,$EA,$3A
	db $3A,$FA,$71,$7F

GeneralSprDispX:
	db $00,$08,$00,$08

GeneralSprDispY:
	db $00,$00,$08,$08

GeneralSprGfxProp:
	db $00,$00,$00,$00,$00,$40,$00,$40
	db $00,$40,$80,$C0,$40,$40,$00,$00
	db $40,$00,$C0,$80,$40,$40,$40,$40

SubSprGfx0Entry0:
	LDY.b #$00
SubSprGfx0Entry1:
	STA $05
	STY $0F					;$019CF7	|
	JSR GetDrawInfoBnk1			;$019CF9	|
	LDY $0F					;$019CFC	|
	TYA					;$019CFE	|
	CLC					;$019CFF	|
	ADC $01					;$019D00	|
	STA $01					;$019D02	|
	LDY $9E,X				;$019D04	|
	LDA.w $1602,X				;$019D06	|
	ASL					;$019D09	|
	ASL					;$019D0A	|
	ADC.w SprTilemapOffset,Y		;$019D0B	|
	STA $02					;$019D0E	|
	LDA.w $15F6,X				;$019D10	|
	ORA $64					;$019D13	|
	STA $03					;$019D15	|
	LDY.w $15EA,X				;$019D17	|
	LDA.b #$03				;$019D1A	|
	STA $04					;$019D1C	|
	PHX					;$019D1E	|
CODE_019D1F:
	LDX $04
	LDA $00					;$019D21	|
	CLC					;$019D23	|
	ADC.w GeneralSprDispX,X			;$019D24	|
	STA.w $0300,Y				;$019D27	|
	LDA $01					;$019D2A	|
	CLC					;$019D2C	|
	ADC.w GeneralSprDispY,X			;$019D2D	|
	STA.w $0301,Y				;$019D30	|
	LDA $02					;$019D33	|
	CLC					;$019D35	|
	ADC $04					;$019D36	|
	TAX					;$019D38	|
	LDA.w SprTilemap,X			;$019D39	|
	STA.w $0302,Y				;$019D3C	|
	LDA $05					;$019D3F	|
	ASL					;$019D41	|
	ASL					;$019D42	|
	ADC $04					;$019D43	|
	TAX					;$019D45	|
	LDA.w GeneralSprGfxProp,X		;$019D46	|
	ORA $03					;$019D49	|
	STA.w $0303,Y				;$019D4B	|
	INY					;$019D4E	|
	INY					;$019D4F	|
	INY					;$019D50	|
	INY					;$019D51	|
	DEC $04					;$019D52	|
	BPL CODE_019D1F				;$019D54	|
	PLX					;$019D56	|
	LDA.b #$03				;$019D57	|
	LDY.b #$00				;$019D59	|
	JSR FinishOAMWriteRt			;$019D5B	|
	RTS					;$019D5E	|

GenericSprGfxRt1:
	PHB
	PHK					;$019D60	|
	PLB					;$019D61	|
	JSR SubSprGfx1				;$019D62	|
	PLB					;$019D65	|
	RTL					;$019D66	|

SubSprGfx1:
	LDA.w $15F6,X
	BPL SubSprGfx1Hlpr0			;$019D6A	|
	JSR SubSprGfx1Hlpr1			;$019D6C	|
	RTS					;$019D6F	|

SubSprGfx1Hlpr0:
	JSR GetDrawInfoBnk1
	LDA.w $157C,X				;$019D73	|
	STA $02					;$019D76	|
	TYA					;$019D78	|
	LDY $9E,X				;$019D79	|
	CPY.b #$0F				;$019D7B	|
	BCS CODE_019D81				;$019D7D	|
	ADC.b #$04				;$019D7F	|
CODE_019D81:
	TAY
	PHY					;$019D82	|
	LDY $9E,X				;$019D83	|
	LDA.w $1602,X				;$019D85	|
	ASL					;$019D88	|
	CLC					;$019D89	|
	ADC.w SprTilemapOffset,Y		;$019D8A	|
	TAX					;$019D8D	|
	PLY					;$019D8E	|
	LDA.w SprTilemap,X			;$019D8F	|
	STA.w $0302,Y				;$019D92	|
	LDA.w SprTilemap+1,X			;$019D95	|
	STA.w $0306,Y				;$019D98	|
	LDX.w $15E9				;$019D9B	|
	LDA $01					;$019D9E	|
	STA.w $0301,Y				;$019DA0	|
	CLC					;$019DA3	|
	ADC.b #$10				;$019DA4	|
	STA.w $0305,Y				;$019DA6	|
CODE_019DA9:
	LDA $00
	STA.w $0300,Y				;$019DAB	|
	STA.w $0304,Y				;$019DAE	|
	LDA.w $157C,X				;$019DB1	|
	LSR					;$019DB4	|
	LDA.b #$00				;$019DB5	|
	ORA.w $15F6,X				;$019DB7	|
	BCS CODE_019DBE				;$019DBA	|
	ORA.b #$40				;$019DBC	|
CODE_019DBE:
	ORA $64
	STA.w $0303,Y				;$019DC0	|
	STA.w $0307,Y				;$019DC3	|
	TYA					;$019DC6	|
	LSR					;$019DC7	|
	LSR					;$019DC8	|
	TAY					;$019DC9	|
	LDA.b #$02				;$019DCA	|
	ORA.w $15A0,X				;$019DCC	|
	STA.w $0460,Y				;$019DCF	|
	STA.w $0461,Y				;$019DD2	|
	JSR CODE_01A3DF				;$019DD5	|
	RTS					;$019DD8	|

SubSprGfx1Hlpr1:
	JSR GetDrawInfoBnk1
	LDA.w $157C,X				;$019DDC	|
	STA $02					;$019DDF	|
	TYA					;$019DE1	|
	CLC					;$019DE2	|
	ADC.b #$08				;$019DE3	|
	TAY					;$019DE5	|
	PHY					;$019DE6	|
	LDY $9E,X				;$019DE7	|
	LDA.w $1602,X				;$019DE9	|
	ASL					;$019DEC	|
	CLC					;$019DED	|
	ADC.w SprTilemapOffset,Y		;$019DEE	|
	TAX					;$019DF1	|
	PLY					;$019DF2	|
	LDA.w SprTilemap,X			;$019DF3	|
	STA.w $0306,Y				;$019DF6	|
	LDA.w SprTilemap+1,X			;$019DF9	|
	STA.w $0302,Y				;$019DFC	|
	LDX.w $15E9				;$019DFF	|
	LDA $01					;$019E02	|
	STA.w $0301,Y				;$019E04	|
	CLC					;$019E07	|
	ADC.b #$10				;$019E08	|
	STA.w $0305,Y				;$019E0A	|
	JMP CODE_019DA9				;$019E0D	|

KoopaWingDispXLo:
	db $FF,$F7,$09,$09

KoopaWingDispXHi:
	db $FF,$FF,$00,$00

KoopaWingDispY:
	db $FC,$F4,$FC,$F4

KoopaWingTiles:
	db $5D,$C6,$5D,$C6

KoopaWingGfxProp:
	db $46,$46,$06,$06

KoopaWingTileSize:
	db $00,$02,$00,$02

KoopaWingGfxRt:
	LDY.b #$00
	JSR IsOnGround				;$019E2A	|
	BNE CODE_019E35				;$019E2D	|
	LDA.w $1602,X				;$019E2F	|
	AND.b #$01				;$019E32	|
	TAY					;$019E34	|
CODE_019E35:
	STY $02
CODE_019E37:
	LDA.w $186C,X
	BNE Return019E94			;$019E3A	|
	LDA $E4,X				;$019E3C	|
	STA $00					;$019E3E	|
	LDA.w $14E0,X				;$019E40	|
	STA $04					;$019E43	|
	LDA $D8,X				;$019E45	|
	STA $01					;$019E47	|
	LDY.w $15EA,X				;$019E49	|
	PHX					;$019E4C	|
	LDA.w $157C,X				;$019E4D	|
	ASL					;$019E50	|
	ADC $02					;$019E51	|
	TAX					;$019E53	|
	LDA $00					;$019E54	|
	CLC					;$019E56	|
	ADC.w KoopaWingDispXLo,X		;$019E57	|
	STA $00					;$019E5A	|
	LDA $04					;$019E5C	|
	ADC.w KoopaWingDispXHi,X		;$019E5E	|
	PHA					;$019E61	|
	LDA $00					;$019E62	|
	SEC					;$019E64	|
	SBC $1A					;$019E65	|
	STA.w $0300,Y				;$019E67	|
	PLA					;$019E6A	|
	SBC $1B					;$019E6B	|
	BNE CODE_019E93				;$019E6D	|
	LDA $01					;$019E6F	|
	SEC					;$019E71	|
	SBC $1C					;$019E72	|
	CLC					;$019E74	|
	ADC.w KoopaWingDispY,X			;$019E75	|
	STA.w $0301,Y				;$019E78	|
	LDA.w KoopaWingTiles,X			;$019E7B	|
	STA.w $0302,Y				;$019E7E	|
	LDA $64					;$019E81	|
	ORA.w KoopaWingGfxProp,X		;$019E83	|
	STA.w $0303,Y				;$019E86	|
	TYA					;$019E89	|
	LSR					;$019E8A	|
	LSR					;$019E8B	|
	TAY					;$019E8C	|
	LDA.w KoopaWingTileSize,X		;$019E8D	|
	STA.w $0460,Y				;$019E90	|
CODE_019E93:
	PLX
Return019E94:
	RTS

CODE_019E95:
	LDA $D8,X
	PHA					;$019E97	|
	CLC					;$019E98	|
	ADC.b #$02				;$019E99	|
	STA $D8,X				;$019E9B	|
	LDA.w $14D4,X				;$019E9D	|
	PHA					;$019EA0	|
	ADC.b #$00				;$019EA1	|
	STA.w $14D4,X				;$019EA3	|
	LDA $E4,X				;$019EA6	|
	PHA					;$019EA8	|
	SEC					;$019EA9	|
	SBC.b #$02				;$019EAA	|
	STA $E4,X				;$019EAC	|
	LDA.w $14E0,X				;$019EAE	|
	PHA					;$019EB1	|
	SBC.b #$00				;$019EB2	|
	STA.w $14E0,X				;$019EB4	|
	LDA.w $15EA,X				;$019EB7	|
	PHA					;$019EBA	|
	CLC					;$019EBB	|
	ADC.b #$04				;$019EBC	|
	STA.w $15EA,X				;$019EBE	|
	LDA.w $157C,X				;$019EC1	|
	PHA					;$019EC4	|
	STZ.w $157C,X				;$019EC5	|
	LDA.w $1570,X				;$019EC8	|
	LSR					;$019ECB	|
	LSR					;$019ECC	|
	LSR					;$019ECD	|
	AND.b #$01				;$019ECE	|
	TAY					;$019ED0	|
	JSR CODE_019E35				;$019ED1	|
	LDA $E4,X				;$019ED4	|
	CLC					;$019ED6	|
	ADC.b #$04				;$019ED7	|
	STA $E4,X				;$019ED9	|
	LDA.w $14E0,X				;$019EDB	|
	ADC.b #$00				;$019EDE	|
	STA.w $14E0,X				;$019EE0	|
	LDA.w $15EA,X				;$019EE3	|
	CLC					;$019EE6	|
	ADC.b #$04				;$019EE7	|
	STA.w $15EA,X				;$019EE9	|
	INC.w $157C,X				;$019EEC	|
	JSR CODE_019E37				;$019EEF	|
	PLA					;$019EF2	|
	STA.w $157C,X				;$019EF3	|
	PLA					;$019EF6	|
	STA.w $15EA,X				;$019EF7	|
	PLA					;$019EFA	|
	STA.w $14E0,X				;$019EFB	|
	PLA					;$019EFE	|
	STA $E4,X				;$019EFF	|
	PLA					;$019F01	|
	STA.w $14D4,X				;$019F02	|
	PLA					;$019F05	|
	STA $D8,X				;$019F06	|
	RTS					;$019F08	|

SubSprGfx2Entry0:
	STA $04
	BRA CODE_019F0F				;$019F0B	|

SubSprGfx2Entry1:
	STZ $04
CODE_019F0F:
	JSR GetDrawInfoBnk1
	LDA.w $157C,X				;$019F12	|
	STA $02					;$019F15	|
	LDY $9E,X				;$019F17	|
	LDA.w $1602,X				;$019F19	|
	CLC					;$019F1C	|
	ADC.w SprTilemapOffset,Y		;$019F1D	|
	LDY.w $15EA,X				;$019F20	|
	TAX					;$019F23	|
	LDA.w SprTilemap,X			;$019F24	|
	STA.w $0302,Y				;$019F27	|
	LDX.w $15E9				;$019F2A	|
	LDA $00					;$019F2D	|
	STA.w $0300,Y				;$019F2F	|
	LDA $01					;$019F32	|
	STA.w $0301,Y				;$019F34	|
	LDA.w $157C,X				;$019F37	|
	LSR					;$019F3A	|
	LDA.b #$00				;$019F3B	|
	ORA.w $15F6,X				;$019F3D	|
	BCS CODE_019F44				;$019F40	|
	EOR.b #$40				;$019F42	|
CODE_019F44:
	ORA $04
	ORA $64					;$019F46	|
	STA.w $0303,Y				;$019F48	|
	TYA					;$019F4B	|
	LSR					;$019F4C	|
	LSR					;$019F4D	|
	TAY					;$019F4E	|
	LDA.b #$02				;$019F4F	|
	ORA.w $15A0,X				;$019F51	|
	STA.w $0460,Y				;$019F54	|
	JSR CODE_01A3DF				;$019F57	|
	RTS					;$019F5A	|

DATA_019F5B:
	db $0B,$F5,$04,$FC,$04,$00

DATA_019F61:
	db $00,$FF,$00,$FF,$00,$00

DATA_019F67:
	db $F3,$0D

DATA_019F69:
	db $FF,$00

ShellSpeedX:
	db $D2,$2E,$CC,$34,$00,$10

HandleSprCarried:
	JSR CODE_019F9B
	LDA.w $13DD				;$019F74	|
	BNE CODE_019F83				;$019F77	|
	LDA.w $1419				;$019F79	|
	BNE CODE_019F83				;$019F7C	|
	LDA.w $1499				;$019F7E	|
	BEQ CODE_019F86				;$019F81	|
CODE_019F83:
	STZ.w $15EA,X
CODE_019F86:
	LDA $64
	PHA					;$019F88	|
	LDA.w $1419				;$019F89	|
	BEQ CODE_019F92				;$019F8C	|
	LDA.b #$10				;$019F8E	|
	STA $64					;$019F90	|
CODE_019F92:
	JSR CODE_01A187
	PLA					;$019F95	|
	STA $64					;$019F96	|
	RTS					;$019F98	|

DATA_019F99:
	db $FC,$04

CODE_019F9B:
	LDA $9E,X
	CMP.b #$7D				;$019F9D	|
	BNE CODE_019FE0				;$019F9F	|
	LDA $13					;$019FA1	|
	AND.b #$03				;$019FA3	|
	BNE CODE_019FBE				;$019FA5	|
	DEC.w $1891				;$019FA7	|
	BEQ CODE_019FC4				;$019FAA	|
	LDA.w $1891				;$019FAC	|
	CMP.b #$30				;$019FAF	|
	BCS CODE_019FBE				;$019FB1	|
	LDY.b #$01				;$019FB3	|
	AND.b #$04				;$019FB5	|
	BEQ CODE_019FBB				;$019FB7	|
	LDY.b #$09				;$019FB9	|
CODE_019FBB:
	STY.w $13F3
CODE_019FBE:
	LDA $71
	CMP.b #$01				;$019FC0	|
	BCC CODE_019FCA				;$019FC2	|
CODE_019FC4:
	STZ.w $13F3
	JMP OffScrEraseSprite			;$019FC7	|

CODE_019FCA:
	PHB
	LDA.b #$02				;$019FCB	|
	PHA					;$019FCD	|
	PLB					;$019FCE	|
	JSL CODE_02D214				;$019FCF	|
	PLB					;$019FD3	|
	JSR CODE_01A0B1				;$019FD4	|
	LDY.w $15EA,X				;$019FD7	|
	LDA.b #$F0				;$019FDA	|
	STA.w $0301,Y				;$019FDC	|
	RTS					;$019FDF	|

CODE_019FE0:
	JSR CODE_019140
	LDA $71					;$019FE3	|
	CMP.b #$01				;$019FE5	|
	BCC CODE_019FF4				;$019FE7	|
	LDA.w $1419				;$019FE9	|
	BNE CODE_019FF4				;$019FEC	|
	LDA.b #$09				;$019FEE	|
	STA.w $14C8,X				;$019FF0	|
	RTS					;$019FF3	|

CODE_019FF4:
	LDA.w $14C8,X
	CMP.b #$08				;$019FF7	|
	BEQ Return01A014			;$019FF9	|
	LDA $9D					;$019FFB	|
	BEQ CODE_01A002				;$019FFD	|
	JMP CODE_01A0B1				;$019FFF	|

CODE_01A002:
	JSR CODE_019624
	JSR SubSprSprInteract			;$01A005	|
	LDA.w $1419				;$01A008	|
	BNE CODE_01A011				;$01A00B	|
	BIT $15					;$01A00D	|
	BVC CODE_01A015				;$01A00F	|
CODE_01A011:
	JSR CODE_01A0B1
Return01A014:
	RTS

CODE_01A015:
	STZ.w $1626,X
	LDY.b #$00				;$01A018	|
	LDA $9E,X				;$01A01A	|
	CMP.b #$0F				;$01A01C	|
	BNE CODE_01A026				;$01A01E	|
	LDA $72					;$01A020	|
	BNE CODE_01A026				;$01A022	|
	LDY.b #$EC				;$01A024	|
CODE_01A026:
	STY $AA,X
	LDA.b #$09				;$01A028	|
	STA.w $14C8,X				;$01A02A	|
	LDA $15					;$01A02D	|
	AND.b #$08				;$01A02F	|
	BNE CODE_01A068				;$01A031	|
	LDA $9E,X				;$01A033	|
	CMP.b #$15				;$01A035	|
	BCS CODE_01A041				;$01A037	|
	LDA $15					;$01A039	|
	AND.b #$04				;$01A03B	|
	BEQ CODE_01A079				;$01A03D	|
	BRA CODE_01A047				;$01A03F	|

CODE_01A041:
	LDA $15
	AND.b #$03				;$01A043	|
	BNE CODE_01A079				;$01A045	|
CODE_01A047:
	LDY $76
	LDA $D1					;$01A049	|
	CLC					;$01A04B	|
	ADC.w DATA_019F67,Y			;$01A04C	|
	STA $E4,X				;$01A04F	|
	LDA $D2					;$01A051	|
	ADC.w DATA_019F69,Y			;$01A053	|
	STA.w $14E0,X				;$01A056	|
	JSR SubHorizPos				;$01A059	|
	LDA.w DATA_019F99,Y			;$01A05C	|
	CLC					;$01A05F	|
	ADC $7B					;$01A060	|
	STA $B6,X				;$01A062	|
	STZ $AA,X				;$01A064	|
	BRA CODE_01A0A6				;$01A066	|

CODE_01A068:
	JSL CODE_01AB6F
	LDA.b #$90				;$01A06C	|
	STA $AA,X				;$01A06E	|
	LDA $7B					;$01A070	|
	STA $B6,X				;$01A072	|
	ASL					;$01A074	|
	ROR $B6,X				;$01A075	|
	BRA CODE_01A0A6				;$01A077	|

CODE_01A079:
	JSL CODE_01AB6F
	LDA.w $1540,X				;$01A07D	|
	STA $C2,X				;$01A080	|
	LDA.b #$0A				;$01A082	|
	STA.w $14C8,X				;$01A084	|
	LDY $76					;$01A087	|
	LDA.w $187A				;$01A089	|
	BEQ CODE_01A090				;$01A08C	|
	INY					;$01A08E	|
	INY					;$01A08F	|
CODE_01A090:
	LDA.w ShellSpeedX,Y
	STA $B6,X				;$01A093	|
	EOR $7B					;$01A095	|
	BMI CODE_01A0A6				;$01A097	|
	LDA $7B					;$01A099	|
	STA $00					;$01A09B	|
	ASL $00					;$01A09D	|
	ROR					;$01A09F	|
	CLC					;$01A0A0	|
	ADC.w ShellSpeedX,Y			;$01A0A1	|
	STA $B6,X				;$01A0A4	|
CODE_01A0A6:
	LDA.b #$10
	STA.w $154C,X				;$01A0A8	|
	LDA.b #$0C				;$01A0AB	|
	STA.w $149A				;$01A0AD	|
	RTS					;$01A0B0	|

CODE_01A0B1:
	LDY.b #$00
	LDA $76					;$01A0B3	|
	BNE CODE_01A0B8				;$01A0B5	|
	INY					;$01A0B7	|
CODE_01A0B8:
	LDA.w $1499
	BEQ CODE_01A0C4				;$01A0BB	|
	INY					;$01A0BD	|
	INY					;$01A0BE	|
	CMP.b #$05				;$01A0BF	|
	BCC CODE_01A0C4				;$01A0C1	|
	INY					;$01A0C3	|
CODE_01A0C4:
	LDA.w $1419
	BEQ CODE_01A0CD				;$01A0C7	|
	CMP.b #$02				;$01A0C9	|
	BEQ CODE_01A0D4				;$01A0CB	|
CODE_01A0CD:
	LDA.w $13DD
	ORA $74					;$01A0D0	|
	BEQ CODE_01A0D6				;$01A0D2	|
CODE_01A0D4:
	LDY.b #$05
CODE_01A0D6:
	PHY
	LDY.b #$00				;$01A0D7	|
	LDA.w $1471				;$01A0D9	|
	CMP.b #$03				;$01A0DC	|
	BEQ CODE_01A0E2				;$01A0DE	|
	LDY.b #$3D				;$01A0E0	|
CODE_01A0E2:
	LDA.w $0094,y
	STA $00					;$01A0E5	|
	LDA.w $0095,y				;$01A0E7	|
	STA $01					;$01A0EA	|
	LDA.w $0096,y				;$01A0EC	|
	STA $02					;$01A0EF	|
	LDA.w $0097,y				;$01A0F1	|
	STA $03					;$01A0F4	|
	PLY					;$01A0F6	|
	LDA $00					;$01A0F7	|
	CLC					;$01A0F9	|
	ADC.w DATA_019F5B,Y			;$01A0FA	|
	STA $E4,X				;$01A0FD	|
	LDA $01					;$01A0FF	|
	ADC.w DATA_019F61,Y			;$01A101	|
	STA.w $14E0,X				;$01A104	|
	LDA.b #$0D				;$01A107	|
	LDY $73					;$01A109	|
	BNE CODE_01A111				;$01A10B	|
	LDY $19					;$01A10D	|
	BNE CODE_01A113				;$01A10F	|
CODE_01A111:
	LDA.b #$0F
CODE_01A113:
	LDY.w $1498
	BEQ CODE_01A11A				;$01A116	|
	LDA.b #$0F				;$01A118	|
CODE_01A11A:
	CLC
	ADC $02					;$01A11B	|
	STA $D8,X				;$01A11D	|
	LDA $03					;$01A11F	|
	ADC.b #$00				;$01A121	|
	STA.w $14D4,X				;$01A123	|
	LDA.b #$01				;$01A126	|
	STA.w $148F				;$01A128	|
	STA.w $1470				;$01A12B	|
	RTS					;$01A12E	|

StunGoomba:
	LDA $14
	LSR					;$01A131	|
	LSR					;$01A132	|
	LDY.w $1540,X				;$01A133	|
	CPY.b #$30				;$01A136	|
	BCC CODE_01A13B				;$01A138	|
	LSR					;$01A13A	|
CODE_01A13B:
	AND.b #$01
	STA.w $1602,X				;$01A13D	|
	CPY.b #$08				;$01A140	|
	BNE CODE_01A14D				;$01A142	|
	JSR IsOnGround				;$01A144	|
	BEQ CODE_01A14D				;$01A147	|
	LDA.b #$D8				;$01A149	|
	STA $AA,X				;$01A14B	|
CODE_01A14D:
	LDA.b #$80
	JMP SubSprGfx2Entry0			;$01A14F	|

StunMechaKoopa:
	LDA $1A
	PHA					;$01A154	|
	LDA.w $1540,X				;$01A155	|
	CMP.b #$30				;$01A158	|
	BCS CODE_01A162				;$01A15A	|
	AND.b #$01				;$01A15C	|
	EOR $1A					;$01A15E	|
	STA $1A					;$01A160	|
CODE_01A162:
	JSL CODE_03B307
	PLA					;$01A166	|
	STA $1A					;$01A167	|
CODE_01A169:
	LDA.w $14C8,X
	CMP.b #$0B				;$01A16C	|
	BNE Return01A177			;$01A16E	|
	LDA $76					;$01A170	|
	EOR.b #$01				;$01A172	|
	STA.w $157C,X				;$01A174	|
Return01A177:
	RTS

StunFish:
	JSR SetAnimationFrame
	LDA.w $15F6,X				;$01A17B	|
	ORA.b #$80				;$01A17E	|
	STA.w $15F6,X				;$01A180	|
	JSR SubSprGfx2Entry1			;$01A183	|
	RTS					;$01A186	|

CODE_01A187:
	LDA.w $167A,X
	AND.b #$08				;$01A18A	|
	BEQ CODE_01A1D0				;$01A18C	|
	LDA $9E,X				;$01A18E	|
	CMP.b #$A2				;$01A190	|
	BEQ StunMechaKoopa			;$01A192	|
	CMP.b #$15				;$01A194	|
	BEQ StunFish				;$01A196	|
	CMP.b #$16				;$01A198	|
	BEQ StunFish				;$01A19A	|
	CMP.b #$0F				;$01A19C	|
	BEQ StunGoomba				;$01A19E	|
	CMP.b #$53				;$01A1A0	|
	BEQ StunThrowBlock			;$01A1A2	|
	CMP.b #$2C				;$01A1A4	|
	BEQ StunYoshiEgg			;$01A1A6	|
	CMP.b #$80				;$01A1A8	|
	BEQ StunKey				;$01A1AA	|
	CMP.b #$7D				;$01A1AC	|
	BEQ Return01A1D3			;$01A1AE	|
	CMP.b #$3E				;$01A1B0	|
	BEQ StunPow				;$01A1B2	|
	CMP.b #$2F				;$01A1B4	|
	BEQ StunSpringBoard			;$01A1B6	|
	CMP.b #$0D				;$01A1B8	|
	BEQ StunBomb				;$01A1BA	|
	CMP.b #$2D				;$01A1BC	|
	BEQ StunBabyYoshi			;$01A1BE	|
	CMP.b #$85				;$01A1C0	|
	BNE CODE_01A1D0				;$01A1C2	|
	JSR SubSprGfx2Entry1			;$01A1C4	|
	LDY.w $15EA,X				;$01A1C7	|
	LDA.b #$47				;$01A1CA	|
	STA.w $0302,Y				;$01A1CC	|
	RTS					;$01A1CF	|

CODE_01A1D0:
	JSR CODE_019806
Return01A1D3:
	RTS

StunThrowBlock:
	LDA.w $1540,X
	CMP.b #$40				;$01A1D7	|
	BCS CODE_01A1DE				;$01A1D9	|
	LSR					;$01A1DB	|
	BCS StunYoshiEgg			;$01A1DC	|
CODE_01A1DE:
	LDA.w $15F6,X
	INC A					;$01A1E1	|
	INC A					;$01A1E2	|
	AND.b #$0F				;$01A1E3	|
	STA.w $15F6,X				;$01A1E5	|
StunYoshiEgg:
	JSR SubSprGfx2Entry1
	RTS					;$01A1EB	|

StunBomb:
	JSR SubSprGfx2Entry1
	LDA.b #$CA				;$01A1EF	|
	BRA CODE_01A222				;$01A1F1	|

StunKey:
	JSR CODE_01A169
	JSR SubSprGfx2Entry1			;$01A1F6	|
	LDA.b #$EC				;$01A1F9	|
	BRA CODE_01A222				;$01A1FB	|

StunPow:
	LDY.w $163E,X
	BEQ CODE_01A218				;$01A200	|
	CPY.b #$01				;$01A202	|
	BNE CODE_01A209				;$01A204	|
	JMP CODE_019ACB				;$01A206	|

CODE_01A209:
	JSR SmushedGfxRt
	LDY.w $15EA,X				;$01A20C	|
	LDA.w $0303,Y				;$01A20F	|
	AND.b #$FE				;$01A212	|
	STA.w $0303,Y				;$01A214	|
	RTS					;$01A217	|

CODE_01A218:
	LDA.b #$01
	STA.w $157C,X				;$01A21A	|
	JSR SubSprGfx2Entry1			;$01A21D	|
	LDA.b #$42				;$01A220	|
CODE_01A222:
	LDY.w $15EA,X
	STA.w $0302,Y				;$01A225	|
	RTS					;$01A228	|

StunSpringBoard:
	JMP CODE_01E6F0

StunBabyYoshi:
	LDA $9D
	BNE CODE_01A27B				;$01A22E	|
	LDA $E4,X				;$01A230	|
	CLC					;$01A232	|
	ADC.b #$08				;$01A233	|
	STA $00					;$01A235	|
	LDA.w $14E0,X				;$01A237	|
	ADC.b #$00				;$01A23A	|
	STA $08					;$01A23C	|
	LDA $D8,X				;$01A23E	|
	CLC					;$01A240	|
	ADC.b #$08				;$01A241	|
	STA $01					;$01A243	|
	LDA.w $14D4,X				;$01A245	|
	ADC.b #$00				;$01A248	|
	STA $09					;$01A24A	|
	JSL CODE_02B9FA				;$01A24C	|
	JSL CODE_02EA4E				;$01A250	|
	LDA.w $163E,X				;$01A254	|
	BNE CODE_01A27E				;$01A257	|
	DEC A					;$01A259	|
	STA.w $160E,X				;$01A25A	|
	LDA.w $14C8,X				;$01A25D	|
	CMP.b #$09				;$01A260	|
	BNE CODE_01A26D				;$01A262	|
	JSR IsOnGround				;$01A264	|
	BEQ CODE_01A26D				;$01A267	|
	LDA.b #$F0				;$01A269	|
	STA $AA,X				;$01A26B	|
CODE_01A26D:
	LDY.b #$00
	LDA $14					;$01A26F	|
	AND.b #$18				;$01A271	|
	BNE CODE_01A277				;$01A273	|
	LDY.b #$03				;$01A275	|
CODE_01A277:
	TYA
	STA.w $1602,X				;$01A278	|
CODE_01A27B:
	JMP CODE_01A34F

CODE_01A27E:
	STZ.w $15EA,X
	CMP.b #$20				;$01A281	|
	BEQ CODE_01A288				;$01A283	|
	JMP CODE_01A30A				;$01A285	|

CODE_01A288:
	LDY.w $160E,X
	LDA.b #$00				;$01A28B	|
	STA.w $14C8,Y				;$01A28D	|
	LDA.b #$06				;$01A290	|
	STA.w $1DF9				;$01A292	|
	LDA.w $160E,Y				;$01A295	|
	BNE CODE_01A2F4				;$01A298	|
	LDA.w $009E,y				;$01A29A	|
	CMP.b #$81				;$01A29D	|
	BNE CODE_01A2AD				;$01A29F	|
	LDA $14					;$01A2A1	|
	LSR					;$01A2A3	|
	LSR					;$01A2A4	|
	LSR					;$01A2A5	|
	LSR					;$01A2A6	|
	AND.b #$03				;$01A2A7	|
	TAY					;$01A2A9	|
	LDA.w ChangingItemSprite,Y		;$01A2AA	|
CODE_01A2AD:
	CMP.b #$74
	BCC CODE_01A2F4				;$01A2AF	|
	CMP.b #$78				;$01A2B1	|
	BCS CODE_01A2F4				;$01A2B3	|
CODE_01A2B5:
	STZ.w $18AC
	STZ.w $141E				;$01A2B8	|
	LDA.b #$35				;$01A2BB	|
	STA.w $9E,X				;$01A2BD	|
	LDA.b #$08				;$01A2C0	|
	STA.w $14C8,X				;$01A2C2	|
	LDA.b #$1F				;$01A2C5	|
	STA.w $1DFC				;$01A2C7	|
	LDA $D8,X				;$01A2CA	|
	SBC.b #$10				;$01A2CC	|
	STA $D8,X				;$01A2CE	|
	LDA.w $14D4,X				;$01A2D0	|
	SBC.b #$00				;$01A2D3	|
	STA.w $14D4,X				;$01A2D5	|
	LDA.w $15F6,X				;$01A2D8	|
	PHA					;$01A2DB	|
	JSL InitSpriteTables			;$01A2DC	|
	PLA					;$01A2E0	|
	AND.b #$FE				;$01A2E1	|
	STA.w $15F6,X				;$01A2E3	|
	LDA.b #$0C				;$01A2E6	|
	STA.w $1602,X				;$01A2E8	|
	DEC.w $160E,X				;$01A2EB	|
	LDA.b #$40				;$01A2EE	|
	STA.w $18E8				;$01A2F0	|
	RTS					;$01A2F3	|

CODE_01A2F4:
	INC.w $1570,X
	LDA.w $1570,X				;$01A2F7	|
	CMP.b #$05				;$01A2FA	|
	BNE CODE_01A300				;$01A2FC	|
	BRA CODE_01A2B5				;$01A2FE	|

CODE_01A300:
	JSL CODE_05B34A
	LDA.b #$01				;$01A304	|
	JSL GivePoints				;$01A306	|
CODE_01A30A:
	LDA.w $163E,X
	LSR					;$01A30D	|
	LSR					;$01A30E	|
	LSR					;$01A30F	|
	TAY					;$01A310	|
	LDA.w DATA_01A35A,Y			;$01A311	|
	STA.w $1602,X				;$01A314	|
	STZ $01					;$01A317	|
	LDA.w $163E,X				;$01A319	|
	CMP.b #$20				;$01A31C	|
	BCC CODE_01A34F				;$01A31E	|
	SBC.b #$10				;$01A320	|
	LSR					;$01A322	|
	LSR					;$01A323	|
	LDY.w $157C,X				;$01A324	|
	BEQ CODE_01A32E				;$01A327	|
	EOR.b #$FF				;$01A329	|
	INC A					;$01A32B	|
	DEC $01					;$01A32C	|
CODE_01A32E:
	LDY.w $160E,X
	CLC					;$01A331	|
	ADC $E4,X				;$01A332	|
	STA.w $00E4,y				;$01A334	|
	LDA.w $14E0,X				;$01A337	|
	ADC $01					;$01A33A	|
	STA.w $14E0,Y				;$01A33C	|
	LDA $D8,X				;$01A33F	|
	SEC					;$01A341	|
	SBC.b #$02				;$01A342	|
	STA.w $00D8,y				;$01A344	|
	LDA.w $14D4,X				;$01A347	|
	SBC.b #$00				;$01A34A	|
	STA.w $14D4,Y				;$01A34C	|
CODE_01A34F:
	JSR CODE_01A169
	JSR SubSprGfx2Entry1			;$01A352	|
	JSL CODE_02EA25				;$01A355	|
	RTS					;$01A359	|

DATA_01A35A:
	db $00,$03,$02,$02,$01,$01,$01

DATA_01A361:
	db $10,$20

DATA_01A363:
	db $01,$02

GetDrawInfoBnk1:
	STZ.w $186C,X
	STZ.w $15A0,X				;$01A368	|
	LDA $E4,X				;$01A36B	|
	CMP $1A					;$01A36D	|
	LDA.w $14E0,X				;$01A36F	|
	SBC $1B					;$01A372	|
	BEQ CODE_01A379				;$01A374	|
	INC.w $15A0,X				;$01A376	|
CODE_01A379:
	LDA.w $14E0,X
	XBA					;$01A37C	|
	LDA $E4,X				;$01A37D	|
	REP #$20				;$01A37F	|
	SEC					;$01A381	|
	SBC $1A					;$01A382	|
	CLC					;$01A384	|
	ADC.w #$0040				;$01A385	|
	CMP.w #$0180				;$01A388	|
	SEP #$20				;$01A38B	|
	ROL					;$01A38D	|
	AND.b #$01				;$01A38E	|
	STA.w $15C4,X				;$01A390	|
	BNE CODE_01A3CB				;$01A393	|
	LDY.b #$00				;$01A395	|
	LDA.w $14C8,X				;$01A397	|
	CMP.b #$09				;$01A39A	|
	BEQ CODE_01A3A6				;$01A39C	|
	LDA.w $190F,X				;$01A39E	|
	AND.b #$20				;$01A3A1	|
	BEQ CODE_01A3A6				;$01A3A3	|
	INY					;$01A3A5	|
CODE_01A3A6:
	LDA $D8,X
	CLC					;$01A3A8	|
	ADC.w DATA_01A361,Y			;$01A3A9	|
	PHP					;$01A3AC	|
	CMP $1C					;$01A3AD	|
	ROL $00					;$01A3AF	|
	PLP					;$01A3B1	|
	LDA.w $14D4,X				;$01A3B2	|
	ADC.b #$00				;$01A3B5	|
	LSR $00					;$01A3B7	|
	SBC $1D					;$01A3B9	|
	BEQ CODE_01A3C6				;$01A3BB	|
	LDA.w $186C,X				;$01A3BD	|
	ORA.w DATA_01A363,Y			;$01A3C0	|
	STA.w $186C,X				;$01A3C3	|
CODE_01A3C6:
	DEY
	BPL CODE_01A3A6				;$01A3C7	|
	BRA CODE_01A3CD				;$01A3C9	|

CODE_01A3CB:
	PLA
	PLA					;$01A3CC	|
CODE_01A3CD:
	LDY.w $15EA,X
	LDA $E4,X				;$01A3D0	|
	SEC					;$01A3D2	|
	SBC $1A					;$01A3D3	|
	STA $00					;$01A3D5	|
	LDA $D8,X				;$01A3D7	|
	SEC					;$01A3D9	|
	SBC $1C					;$01A3DA	|
	STA $01					;$01A3DC	|
	RTS					;$01A3DE	|

CODE_01A3DF:
	LDA.w $186C,X
	BEQ Return01A40A			;$01A3E2	|
	PHX					;$01A3E4	|
	LSR					;$01A3E5	|
	BCC CODE_01A3F8				;$01A3E6	|
	PHA					;$01A3E8	|
	LDA.b #$01				;$01A3E9	|
	STA.w $0460,Y				;$01A3EB	|
	TYA					;$01A3EE	|
	ASL					;$01A3EF	|
	ASL					;$01A3F0	|
	TAX					;$01A3F1	|
	LDA.b #$80				;$01A3F2	|
	STA.w $0300,X				;$01A3F4	|
	PLA					;$01A3F7	|
CODE_01A3F8:
	LSR
	BCC CODE_01A409				;$01A3F9	|
	LDA.b #$01				;$01A3FB	|
	STA.w $0461,Y				;$01A3FD	|
	TYA					;$01A400	|
	ASL					;$01A401	|
	ASL					;$01A402	|
	TAX					;$01A403	|
	LDA.b #$80				;$01A404	|
	STA.w $0304,X				;$01A406	|
CODE_01A409:
	PLX
Return01A40A:
	RTS

DATA_01A40B:
	db $02,$0A

SubSprSprInteract:
	TXA
	BEQ Return01A40A			;$01A40E	|
	TAY					;$01A410	|
	EOR $13					;$01A411	|
	LSR					;$01A413	|
	BCC Return01A40A			;$01A414	|
	DEX					;$01A416	|
CODE_01A417:
	LDA.w $14C8,X
	CMP.b #$08				;$01A41A	|
	BCS CODE_01A421				;$01A41C	|
	JMP CODE_01A4B0				;$01A41E	|

CODE_01A421:
	LDA.w $1686,X
	ORA.w $1686,Y				;$01A424	|
	AND.b #$08				;$01A427	|
	ORA.w $1564,X				;$01A429	|
	ORA.w $1564,Y				;$01A42C	|
	ORA.w $15D0,X				;$01A42F	|
	ORA.w $1632,X				;$01A432	|
	EOR.w $1632,Y				;$01A435	|
	BNE CODE_01A4B0				;$01A438	|
	STX.w $1695				;$01A43A	|
	LDA $E4,X				;$01A43D	|
	STA $00					;$01A43F	|
	LDA.w $14E0,X				;$01A441	|
	STA $01					;$01A444	|
	LDA.w $00E4,y				;$01A446	|
	STA $02					;$01A449	|
	LDA.w $14E0,Y				;$01A44B	|
	STA $03					;$01A44E	|
	REP #$20				;$01A450	|
	LDA $00					;$01A452	|
	SEC					;$01A454	|
	SBC $02					;$01A455	|
	CLC					;$01A457	|
	ADC.w #$0010				;$01A458	|
	CMP.w #$0020				;$01A45B	|
	SEP #$20				;$01A45E	|
	BCS CODE_01A4B0				;$01A460	|
	LDY.b #$00				;$01A462	|
	LDA.w $1662,X				;$01A464	|
	AND.b #$0F				;$01A467	|
	BEQ CODE_01A46C				;$01A469	|
	INY					;$01A46B	|
CODE_01A46C:
	LDA $D8,X
	CLC					;$01A46E	|
	ADC.w DATA_01A40B,Y			;$01A46F	|
	STA $00					;$01A472	|
	LDA.w $14D4,X				;$01A474	|
	ADC.b #$00				;$01A477	|
	STA $01					;$01A479	|
	LDY.w $15E9				;$01A47B	|
	LDX.b #$00				;$01A47E	|
	LDA.w $1662,Y				;$01A480	|
	AND.b #$0F				;$01A483	|
	BEQ CODE_01A488				;$01A485	|
	INX					;$01A487	|
CODE_01A488:
	LDA.w $00D8,y
	CLC					;$01A48B	|
	ADC.w DATA_01A40B,X			;$01A48C	|
	STA $02					;$01A48F	|
	LDA.w $14D4,Y				;$01A491	|
	ADC.b #$00				;$01A494	|
	STA $03					;$01A496	|
	LDX.w $1695				;$01A498	|
	REP #$20				;$01A49B	|
	LDA $00					;$01A49D	|
	SEC					;$01A49F	|
	SBC $02					;$01A4A0	|
	CLC					;$01A4A2	|
	ADC.w #$000C				;$01A4A3	|
	CMP.w #$0018				;$01A4A6	|
	SEP #$20				;$01A4A9	|
	BCS CODE_01A4B0				;$01A4AB	|
	JSR CODE_01A4BA				;$01A4AD	|
CODE_01A4B0:
	DEX
	BMI CODE_01A4B6				;$01A4B1	|
	JMP CODE_01A417				;$01A4B3	|

CODE_01A4B6:
	LDX.w $15E9
	RTS					;$01A4B9	|

CODE_01A4BA:
	LDA.w $14C8,Y
	CMP.b #$08				;$01A4BD	|
	BEQ CODE_01A4CE				;$01A4BF	|
	CMP.b #$09				;$01A4C1	|
	BEQ CODE_01A4E2				;$01A4C3	|
	CMP.b #$0A				;$01A4C5	|
	BEQ CODE_01A506				;$01A4C7	|
	CMP.b #$0B				;$01A4C9	|
	BEQ CODE_01A51A				;$01A4CB	|
	RTS					;$01A4CD	|

CODE_01A4CE:
	LDA.w $14C8,X
	CMP.b #$08				;$01A4D1	|
	BEQ CODE_01A53D				;$01A4D3	|
	CMP.b #$09				;$01A4D5	|
	BEQ CODE_01A540				;$01A4D7	|
	CMP.b #$0A				;$01A4D9	|
	BEQ CODE_01A537				;$01A4DB	|
	CMP.b #$0B				;$01A4DD	|
	BEQ CODE_01A534				;$01A4DF	|
	RTS					;$01A4E1	|

CODE_01A4E2:
	LDA.w $1588,Y
	AND.b #$04				;$01A4E5	|
	BNE CODE_01A4F2				;$01A4E7	|
	LDA.w $009E,y				;$01A4E9	|
	CMP.b #$0F				;$01A4EC	|
	BEQ CODE_01A534				;$01A4EE	|
	BRA CODE_01A506				;$01A4F0	|

CODE_01A4F2:
	LDA.w $14C8,X
	CMP.b #$08				;$01A4F5	|
	BEQ CODE_01A540				;$01A4F7	|
	CMP.b #$09				;$01A4F9	|
	BEQ CODE_01A555				;$01A4FB	|
	CMP.b #$0A				;$01A4FD	|
	BEQ ADDR_01A53A				;$01A4FF	|
	CMP.b #$0B				;$01A501	|
	BEQ CODE_01A534				;$01A503	|
	RTS					;$01A505	|

CODE_01A506:
	LDA.w $14C8,X
	CMP.b #$08				;$01A509	|
	BEQ CODE_01A52E				;$01A50B	|
	CMP.b #$09				;$01A50D	|
	BEQ CODE_01A531				;$01A50F	|
	CMP.b #$0A				;$01A511	|
	BEQ CODE_01A534				;$01A513	|
	CMP.b #$0B				;$01A515	|
	BEQ CODE_01A534				;$01A517	|
	RTS					;$01A519	|

CODE_01A51A:
	LDA.w $14C8,X
	CMP.b #$08				;$01A51D	|
	BEQ CODE_01A534				;$01A51F	|
	CMP.b #$09				;$01A521	|
	BEQ CODE_01A534				;$01A523	|
	CMP.b #$0A				;$01A525	|
	BEQ CODE_01A534				;$01A527	|
	CMP.b #$0B				;$01A529	|
	BEQ CODE_01A534				;$01A52B	|
	RTS					;$01A52D	|

CODE_01A52E:
	JMP CODE_01A625

CODE_01A531:
	JMP CODE_01A642

CODE_01A534:
	JMP CODE_01A685

CODE_01A537:
	JMP CODE_01A5C4

ADDR_01A53A:
	JMP CODE_01A5C4

CODE_01A53D:
	JMP CODE_01A56D

CODE_01A540:
	JSR CODE_01A6D9
	PHX					;$01A543	|
	PHY					;$01A544	|
	TYA					;$01A545	|
	TXY					;$01A546	|
	TAX					;$01A547	|
	JSR CODE_01A6D9				;$01A548	|
	PLY					;$01A54B	|
	PLX					;$01A54C	|
	LDA.w $1558,X				;$01A54D	|
	ORA.w $1558,Y				;$01A550	|
	BNE Return01A5C3			;$01A553	|
CODE_01A555:
	LDA.w $14C8,X
	CMP.b #$09				;$01A558	|
	BNE CODE_01A56D				;$01A55A	|
	JSR IsOnGround				;$01A55C	|
	BNE CODE_01A56D				;$01A55F	|
	LDA $9E,X				;$01A561	|
	CMP.b #$0F				;$01A563	|
	BNE CODE_01A56A				;$01A565	|
	JMP CODE_01A685				;$01A567	|

CODE_01A56A:
	JMP CODE_01A5C4

CODE_01A56D:
	LDA $E4,X
	SEC					;$01A56F	|
	SBC.w $00E4,y				;$01A570	|
	LDA.w $14E0,X				;$01A573	|
	SBC.w $14E0,Y				;$01A576	|
	ROL					;$01A579	|
	AND.b #$01				;$01A57A	|
	STA $00					;$01A57C	|
	LDA.w $1686,Y				;$01A57E	|
	AND.b #$10				;$01A581	|
	BNE CODE_01A5A1				;$01A583	|
	LDY.w $15E9				;$01A585	|
	LDA.w $157C,Y				;$01A588	|
	PHA					;$01A58B	|
	LDA $00					;$01A58C	|
	STA.w $157C,Y				;$01A58E	|
	PLA					;$01A591	|
	CMP.w $157C,Y				;$01A592	|
	BEQ CODE_01A5A1				;$01A595	|
	LDA.w $15AC,Y				;$01A597	|
	BNE CODE_01A5A1				;$01A59A	|
	LDA.b #$08				;$01A59C	|
	STA.w $15AC,Y				;$01A59E	|
CODE_01A5A1:
	LDA.w $1686,X
	AND.b #$10				;$01A5A4	|
	BNE Return01A5C3			;$01A5A6	|
	LDA.w $157C,X				;$01A5A8	|
	PHA					;$01A5AB	|
	LDA $00					;$01A5AC	|
	EOR.b #$01				;$01A5AE	|
	STA.w $157C,X				;$01A5B0	|
	PLA					;$01A5B3	|
	CMP.w $157C,X				;$01A5B4	|
	BEQ Return01A5C3			;$01A5B7	|
	LDA.w $15AC,X				;$01A5B9	|
	BNE Return01A5C3			;$01A5BC	|
	LDA.b #$08				;$01A5BE	|
	STA.w $15AC,X				;$01A5C0	|
Return01A5C3:
	RTS

CODE_01A5C4:
	LDA.w $009E,y
	SEC					;$01A5C7	|
	SBC.b #$83				;$01A5C8	|
	CMP.b #$02				;$01A5CA	|
	BCS CODE_01A5DA				;$01A5CC	|
	JSR FlipSpriteDir			;$01A5CE	|
	STZ $AA,X				;$01A5D1	|
CODE_01A5D3:
	PHX
	TYX					;$01A5D4	|
	JSR CODE_01B4E2				;$01A5D5	|
	PLX					;$01A5D8	|
	RTS					;$01A5D9	|

CODE_01A5DA:
	LDX.w $15E9
	LDY.w $1695				;$01A5DD	|
	JSR CODE_01A77C				;$01A5E0	|
	LDA.b #$02				;$01A5E3	|
	STA.w $14C8,Y				;$01A5E5	|
	PHX					;$01A5E8	|
	TYX					;$01A5E9	|
	JSL CODE_01AB72				;$01A5EA	|
	PLX					;$01A5EE	|
	LDA $B6,X				;$01A5EF	|
	ASL					;$01A5F1	|
	LDA.b #$10				;$01A5F2	|
	BCC CODE_01A5F8				;$01A5F4	|
	LDA.b #$F0				;$01A5F6	|
CODE_01A5F8:
	STA.w $00B6,y
	LDA.b #$D0				;$01A5FB	|
	STA.w $00AA,y				;$01A5FD	|
	PHY					;$01A600	|
	INC.w $1626,X				;$01A601	|
	LDY.w $1626,X				;$01A604	|
	CPY.b #$08				;$01A607	|
	BCS CODE_01A611				;$01A609	|
	LDA.w Return01A61D,Y			;$01A60B	|
	STA.w $1DF9				;$01A60E	|
CODE_01A611:
	TYA
	CMP.b #$08				;$01A612	|
	BCC CODE_01A618				;$01A614	|
	LDA.b #$08				;$01A616	|
CODE_01A618:
	PLY
	JSL CODE_02ACE1				;$01A619	|
Return01A61D:
	RTS

DATA_01A61E:
	db $13,$14,$15,$16,$17,$18,$19

CODE_01A625:
	LDA $9E,X
	SEC					;$01A627	|
	SBC.b #$83				;$01A628	|
	CMP.b #$02				;$01A62A	|
	BCS CODE_01A63D				;$01A62C	|
	PHX					;$01A62E	|
	TYX					;$01A62F	|
	JSR FlipSpriteDir			;$01A630	|
	PLX					;$01A633	|
	LDA.b #$00				;$01A634	|
	STA.w $00AA,y				;$01A636	|
	JSR CODE_01B4E2				;$01A639	|
	RTS					;$01A63C	|

CODE_01A63D:
	JSR CODE_01A77C
	BRA CODE_01A64A				;$01A640	|

CODE_01A642:
	JSR IsOnGround
	BNE CODE_01A64A				;$01A645	|
	JMP CODE_01A685				;$01A647	|

CODE_01A64A:
	PHX
	LDA.w $1626,Y				;$01A64B	|
	INC A					;$01A64E	|
	STA.w $1626,Y				;$01A64F	|
	LDX.w $1626,Y				;$01A652	|
	CPX.b #$08				;$01A655	|
	BCS CODE_01A65F				;$01A657	|
	LDA.w Return01A61D,X			;$01A659	|
	STA.w $1DF9				;$01A65C	|
CODE_01A65F:
	TXA
	CMP.b #$08				;$01A660	|
	BCC CODE_01A666				;$01A662	|
	LDA.b #$08				;$01A664	|
CODE_01A666:
	PLX
	JSL GivePoints				;$01A667	|
	LDA.b #$02				;$01A66B	|
	STA.w $14C8,X				;$01A66D	|
	JSL CODE_01AB72				;$01A670	|
	LDA.w $00B6,y				;$01A674	|
	ASL					;$01A677	|
	LDA.b #$10				;$01A678	|
	BCC CODE_01A67E				;$01A67A	|
	LDA.b #$F0				;$01A67C	|
CODE_01A67E:
	STA $B6,X
	LDA.b #$D0				;$01A680	|
	STA $AA,X				;$01A682	|
	RTS					;$01A684	|

CODE_01A685:
	LDA $9E,X
	CMP.b #$83				;$01A687	|
	BEQ ADDR_01A69A				;$01A689	|
	CMP.b #$84				;$01A68B	|
	BEQ ADDR_01A69A				;$01A68D	|
	LDA.b #$02				;$01A68F	|
	STA.w $14C8,X				;$01A691	|
	LDA.b #$D0				;$01A694	|
	STA $AA,X				;$01A696	|
	BRA CODE_01A69D				;$01A698	|

ADDR_01A69A:
	JSR CODE_01B4E2
CODE_01A69D:
	LDA.w $009E,y
	CMP.b #$80				;$01A6A0	|
	BEQ CODE_01A6BB				;$01A6A2	|
	CMP.b #$83				;$01A6A4	|
	BEQ ADDR_01A6B8				;$01A6A6	|
	CMP.b #$84				;$01A6A8	|
	BEQ ADDR_01A6B8				;$01A6AA	|
	LDA.b #$02				;$01A6AC	|
	STA.w $14C8,Y				;$01A6AE	|
	LDA.b #$D0				;$01A6B1	|
	STA.w $00AA,y				;$01A6B3	|
	BRA CODE_01A6BB				;$01A6B6	|

ADDR_01A6B8:
	JSR CODE_01A5D3
CODE_01A6BB:
	JSL CODE_01AB6F
	LDA.b #$04				;$01A6BF	|
	JSL GivePoints				;$01A6C1	|
	LDA $B6,X				;$01A6C5	|
	ASL					;$01A6C7	|
	LDA.b #$10				;$01A6C8	|
	BCS CODE_01A6CE				;$01A6CA	|
	LDA.b #$F0				;$01A6CC	|
CODE_01A6CE:
	STA $B6,X
	EOR.b #$FF				;$01A6D0	|
	INC A					;$01A6D2	|
	STA.w $00B6,y				;$01A6D3	|
	RTS					;$01A6D6	|

DATA_01A6D7:
	db $30,$D0

CODE_01A6D9:
	STY $00
	JSR IsOnGround				;$01A6DB	|
	BEQ Return01A72D			;$01A6DE	|
	LDA.w $1588,Y				;$01A6E0	|
	AND.b #$04				;$01A6E3	|
	BEQ Return01A72D			;$01A6E5	|
	LDA.w $1656,X				;$01A6E7	|
	AND.b #$40				;$01A6EA	|
	BEQ Return01A72D			;$01A6EC	|
	LDA.w $1558,Y				;$01A6EE	|
	ORA.w $1558,X				;$01A6F1	|
	BNE Return01A72D			;$01A6F4	|
	STZ $02					;$01A6F6	|
	LDA $E4,X				;$01A6F8	|
	SEC					;$01A6FA	|
	SBC.w $00E4,y				;$01A6FB	|
	BMI CODE_01A702				;$01A6FE	|
	INC $02					;$01A700	|
CODE_01A702:
	CLC
	ADC.b #$08				;$01A703	|
	CMP.b #$10				;$01A705	|
	BCC Return01A72D			;$01A707	|
	LDA.w $157C,X				;$01A709	|
	CMP $02					;$01A70C	|
	BNE Return01A72D			;$01A70E	|
	LDA $9E,X				;$01A710	|
	CMP.b #$02				;$01A712	|
	BNE HopIntoShell			;$01A714	|
	LDA.b #$20				;$01A716	|
	STA.w $163E,X				;$01A718	|
	STA.w $1558,X				;$01A71B	|
	LDA.b #$23				;$01A71E	|
	STA.w $1564,X				;$01A720	|
	TYA					;$01A723	|
	STA.w $160E,X				;$01A724	|
	RTS					;$01A727	|

PlayKickSfx:
	LDA.b #$03
	STA.w $1DF9				;$01A72A	|
Return01A72D:
	RTS

HopIntoShell:
	LDA.w $1540,Y
	BNE Return01A777			;$01A731	|
	LDA.w $009E,y				;$01A733	|
	CMP.b #$0F				;$01A736	|
	BCS Return01A777			;$01A738	|
	LDA.w $1588,Y				;$01A73A	|
	AND.b #$04				;$01A73D	|
	BEQ Return01A777			;$01A73F	|
	LDA.w $15F6,Y				;$01A741	|
	BPL CODE_01A75D				;$01A744	|
	AND.b #$7F				;$01A746	|
	STA.w $15F6,Y				;$01A748	|
	LDA.b #$E0				;$01A74B	|
	STA.w $00AA,y				;$01A74D	|
	LDA.b #$20				;$01A750	|
	STA.w $1564,Y				;$01A752	|
CODE_01A755:
	LDA.b #$20
	STA $C2,X				;$01A757	|
	STA.w $1558,X				;$01A759	|
	RTS					;$01A75C	|

CODE_01A75D:
	LDA.b #$E0
	STA $AA,X				;$01A75F	|
	LDA.w $164A,X				;$01A761	|
	CMP.b #$01				;$01A764	|
	LDA.b #$18				;$01A766	|
	BCC CODE_01A76C				;$01A768	|
	LDA.b #$2C				;$01A76A	|
CODE_01A76C:
	STA.w $1558,X
	TXA					;$01A76F	|
	STA.w $1594,Y				;$01A770	|
	TYA					;$01A773	|
	STA.w $1594,X				;$01A774	|
Return01A777:
	RTS

DATA_01A778:
	db $10,$F0

DATA_01A77A:
	db $00,$FF

CODE_01A77C:
	LDA $9E,X
	CMP.b #$02				;$01A77E	|
	BNE CODE_01A7C2				;$01A780	|
	LDA.w $187B,Y				;$01A782	|
	BNE CODE_01A7C2				;$01A785	|
	LDA.w $157C,X				;$01A787	|
	CMP.w $157C,Y				;$01A78A	|
	BEQ CODE_01A7C2				;$01A78D	|
	STY $01					;$01A78F	|
	LDY.w $1534,X				;$01A791	|
	BNE CODE_01A7C0				;$01A794	|
	STZ.w $1528,X				;$01A796	|
	STZ.w $163E,X				;$01A799	|
	TAY					;$01A79C	|
	STY $00					;$01A79D	|
	LDA $E4,X				;$01A79F	|
	CLC					;$01A7A1	|
	ADC.w DATA_01A778,Y			;$01A7A2	|
	LDY $01					;$01A7A5	|
	STA.w $00E4,y				;$01A7A7	|
	LDA.w $14E0,X				;$01A7AA	|
	LDY $00					;$01A7AD	|
	ADC.w DATA_01A77A,Y			;$01A7AF	|
	LDY $01					;$01A7B2	|
	STA.w $14E0,Y				;$01A7B4	|
	TYA					;$01A7B7	|
	STA.w $160E,X				;$01A7B8	|
	LDA.b #$01				;$01A7BB	|
	STA.w $1534,X				;$01A7BD	|
CODE_01A7C0:
	PLA
	PLA					;$01A7C1	|
CODE_01A7C2:
	LDX.w $1695
	LDY.w $15E9				;$01A7C5	|
	RTS					;$01A7C8	|

SpriteToSpawn:
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $04,$04,$05,$05,$07,$00,$00,$0F
	db $0F,$0F,$0D

MarioSprInteract:
	PHB
	PHK					;$01A7DD	|
	PLB					;$01A7DE	|
	JSR MarioSprInteractRt			;$01A7DF	|
	PLB					;$01A7E2	|
	RTL					;$01A7E3	|

MarioSprInteractRt:
	LDA.w $167A,X
	AND.b #$20				;$01A7E7	|
	BNE ProcessInteract			;$01A7E9	|
	TXA					;$01A7EB	|
	EOR $13					;$01A7EC	|
	AND.b #$01				;$01A7EE	|
	ORA.w $15A0,X				;$01A7F0	|
	BEQ ProcessInteract			;$01A7F3	|
ReturnNoContact:
	CLC
	RTS					;$01A7F6	|

ProcessInteract:
	JSR SubHorizPos
	LDA $0F					;$01A7FA	|
	CLC					;$01A7FC	|
	ADC.b #$50				;$01A7FD	|
	CMP.b #$A0				;$01A7FF	|
	BCS ReturnNoContact			;$01A801	|
	JSR CODE_01AD42				;$01A803	|
	LDA $0E					;$01A806	|
	CLC					;$01A808	|
	ADC.b #$60				;$01A809	|
	CMP.b #$C0				;$01A80B	|
	BCS ReturnNoContact			;$01A80D	|
CODE_01A80F:
	LDA $71
	CMP.b #$01				;$01A811	|
	BCS ReturnNoContact			;$01A813	|
	LDA.b #$00				;$01A815	|
	BIT.w $0D9B				;$01A817	|
	BVS CODE_01A822				;$01A81A	|
	LDA.w $13F9				;$01A81C	|
	EOR.w $1632,X				;$01A81F	|
CODE_01A822:
	BNE ReturnNoContact2
	JSL GetMarioClipping			;$01A824	|
	JSL GetSpriteClippingA			;$01A828	|
	JSL CheckForContact			;$01A82C	|
	BCC ReturnNoContact2			;$01A830	|
	LDA.w $167A,X				;$01A832	|
	BPL DefaultInteractR			;$01A835	|
	SEC					;$01A837	|
	RTS					;$01A838	|

DATA_01A839:
	db $F0,$10

DefaultInteractR:
	LDA.w $1490
	BEQ CODE_01A87E				;$01A83E	|
	LDA.w $167A,X				;$01A840	|
	AND.b #$02				;$01A843	|
	BNE CODE_01A87E				;$01A845	|
CODE_01A847:
	JSL CODE_01AB6F
	INC.w $18D2				;$01A84B	|
	LDA.w $18D2				;$01A84E	|
	CMP.b #$08				;$01A851	|
	BCC CODE_01A85A				;$01A853	|
	LDA.b #$08				;$01A855	|
	STA.w $18D2				;$01A857	|
CODE_01A85A:
	JSL GivePoints
	LDY.w $18D2				;$01A85E	|
	CPY.b #$08				;$01A861	|
	BCS CODE_01A86B				;$01A863	|
	LDA.w Return01A61D,Y			;$01A865	|
	STA.w $1DF9				;$01A868	|
CODE_01A86B:
	LDA.b #$02
	STA.w $14C8,X				;$01A86D	|
	LDA.b #$D0				;$01A870	|
	STA $AA,X				;$01A872	|
	JSR SubHorizPos				;$01A874	|
	LDA.w DATA_01A839,Y			;$01A877	|
	STA $B6,X				;$01A87A	|
ReturnNoContact2:
	CLC
	RTS					;$01A87D	|

CODE_01A87E:
	STZ.w $18D2
	LDA.w $154C,X				;$01A881	|
	BNE CODE_01A895				;$01A884	|
	LDA.b #$08				;$01A886	|
	STA.w $154C,X				;$01A888	|
	LDA.w $14C8,X				;$01A88B	|
	CMP.b #$09				;$01A88E	|
	BNE CODE_01A897				;$01A890	|
	JSR CODE_01AA42				;$01A892	|
CODE_01A895:
	CLC
	RTS					;$01A896	|

CODE_01A897:
	LDA.b #$14
	STA $01					;$01A899	|
	LDA $05					;$01A89B	|
	SEC					;$01A89D	|
	SBC $01					;$01A89E	|
	ROL $00					;$01A8A0	|
	CMP $D3					;$01A8A2	|
	PHP					;$01A8A4	|
	LSR $00					;$01A8A5	|
	LDA $0B					;$01A8A7	|
	SBC.b #$00				;$01A8A9	|
	PLP					;$01A8AB	|
	SBC $D4					;$01A8AC	|
	BMI CODE_01A8E6				;$01A8AE	|
	LDA $7D					;$01A8B0	|
	BPL CODE_01A8C0				;$01A8B2	|
	LDA.w $190F,X				;$01A8B4	|
	AND.b #$10				;$01A8B7	|
	BNE CODE_01A8C0				;$01A8B9	|
	LDA.w $1697				;$01A8BB	|
	BEQ CODE_01A8E6				;$01A8BE	|
CODE_01A8C0:
	JSR IsOnGround
	BEQ CODE_01A8C9				;$01A8C3	|
	LDA $72					;$01A8C5	|
	BEQ CODE_01A8E6				;$01A8C7	|
CODE_01A8C9:
	LDA.w $1656,X
	AND.b #$10				;$01A8CC	|
	BNE CODE_01A91C				;$01A8CE	|
	LDA.w $140D				;$01A8D0	|
	ORA.w $187A				;$01A8D3	|
	BEQ CODE_01A8E6				;$01A8D6	|
CODE_01A8D8:
	LDA.b #$02
	STA.w $1DF9				;$01A8DA	|
	JSL BoostMarioSpeed			;$01A8DD	|
	JSL DisplayContactGfx			;$01A8E1	|
	RTS					;$01A8E5	|

CODE_01A8E6:
	LDA.w $13ED
	BEQ CODE_01A8F9				;$01A8E9	|
	LDA.w $190F,X				;$01A8EB	|
	AND.b #$04				;$01A8EE	|
	BNE CODE_01A8F9				;$01A8F0	|
	JSR PlayKickSfx				;$01A8F2	|
	JSR CODE_01A847				;$01A8F5	|
	RTS					;$01A8F8	|

CODE_01A8F9:
	LDA.w $1497
	BNE Return01A91B			;$01A8FC	|
	LDA.w $187A				;$01A8FE	|
	BNE Return01A91B			;$01A901	|
	LDA.w $1686,X				;$01A903	|
	AND.b #$10				;$01A906	|
	BNE CODE_01A911				;$01A908	|
	JSR SubHorizPos				;$01A90A	|
	TYA					;$01A90D	|
	STA.w $157C,X				;$01A90E	|
CODE_01A911:
	LDA $9E,X
	CMP.b #$53				;$01A913	|
	BEQ Return01A91B			;$01A915	|
	JSL HurtMario				;$01A917	|
Return01A91B:
	RTS

CODE_01A91C:
	LDA.w $140D
	ORA.w $187A				;$01A91F	|
	BEQ CODE_01A947				;$01A922	|
CODE_01A924:
	JSL DisplayContactGfx
	LDA.b #$F8				;$01A928	|
	STA $7D					;$01A92A	|
	LDA.w $187A				;$01A92C	|
	BEQ CODE_01A935				;$01A92F	|
	JSL BoostMarioSpeed			;$01A931	|
CODE_01A935:
	JSR CODE_019ACB
	JSL CODE_07FC3B				;$01A938	|
	JSR CODE_01AB46				;$01A93C	|
	LDA.b #$08				;$01A93F	|
	STA.w $1DF9				;$01A941	|
	JMP CODE_01A9F2				;$01A944	|

CODE_01A947:
	JSR CODE_01A8D8
	LDA.w $187B,X				;$01A94A	|
	BEQ CODE_01A95D				;$01A94D	|
	JSR SubHorizPos				;$01A94F	|
	LDA.b #$18				;$01A952	|
	CPY.b #$00				;$01A954	|
	BEQ CODE_01A95A				;$01A956	|
	LDA.b #$E8				;$01A958	|
CODE_01A95A:
	STA $7B
	RTS					;$01A95C	|

CODE_01A95D:
	JSR CODE_01AB46
	LDY $9E,X				;$01A960	|
	LDA.w $1686,X				;$01A962	|
	AND.b #$40				;$01A965	|
	BEQ CODE_01A9BE				;$01A967	|
	CPY.b #$72				;$01A969	|
	BCC CODE_01A979				;$01A96B	|
	PHX					;$01A96D	|
	PHY					;$01A96E	|
	JSL CODE_02EAF2				;$01A96F	|
	PLY					;$01A973	|
	PLX					;$01A974	|
	LDA.b #$02				;$01A975	|
	BRA CODE_01A99B				;$01A977	|

CODE_01A979:
	CPY.b #$6E
	BNE CODE_01A98A				;$01A97B	|
	LDA.b #$02				;$01A97D	|
	STA $C2,X				;$01A97F	|
	LDA.b #$FF				;$01A981	|
	STA.w $1540,X				;$01A983	|
	LDA.b #$6F				;$01A986	|
	BRA CODE_01A99B				;$01A988	|

CODE_01A98A:
	CPY.b #$3F
	BCC CODE_01A998				;$01A98C	|
	LDA.b #$80				;$01A98E	|
	STA.w $1540,X				;$01A990	|
	LDA.w $A79B,Y				;$01A993	|
	BRA CODE_01A99B				;$01A996	|

CODE_01A998:
	LDA.w SpriteToSpawn,Y
CODE_01A99B:
	STA $9E,X
	LDA.w $15F6,X				;$01A99D	|
	AND.b #$0E				;$01A9A0	|
	STA $0F					;$01A9A2	|
	JSL LoadSpriteTables			;$01A9A4	|
	LDA.w $15F6,X				;$01A9A8	|
	AND.b #$F1				;$01A9AB	|
	ORA $0F					;$01A9AD	|
	STA.w $15F6,X				;$01A9AF	|
	STZ $AA,X				;$01A9B2	|
	LDA $9E,X				;$01A9B4	|
	CMP.b #$02				;$01A9B6	|
	BNE Return01A9BD			;$01A9B8	|
	INC.w $151C,X				;$01A9BA	|
Return01A9BD:
	RTS

CODE_01A9BE:
	LDA $9E,X
	SEC					;$01A9C0	|
	SBC.b #$04				;$01A9C1	|
	CMP.b #$0D				;$01A9C3	|
	BCS CODE_01A9CC				;$01A9C5	|
	LDA.w $1407				;$01A9C7	|
	BNE CODE_01A9D3				;$01A9CA	|
CODE_01A9CC:
	LDA.w $1656,X
	AND.b #$20				;$01A9CF	|
	BEQ CODE_01A9E2				;$01A9D1	|
CODE_01A9D3:
	LDA.b #$03
	STA.w $14C8,X				;$01A9D5	|
	LDA.b #$20				;$01A9D8	|
	STA.w $1540,X				;$01A9DA	|
	STZ $B6,X				;$01A9DD	|
	STZ $AA,X				;$01A9DF	|
	RTS					;$01A9E1	|

CODE_01A9E2:
	LDA.w $1662,X
	AND.b #$80				;$01A9E5	|
	BEQ CODE_01AA01				;$01A9E7	|
	LDA.b #$02				;$01A9E9	|
	STA.w $14C8,X				;$01A9EB	|
	STZ $B6,X				;$01A9EE	|
	STZ $AA,X				;$01A9F0	|
CODE_01A9F2:
	LDA $9E,X
	CMP.b #$1E				;$01A9F4	|
	BNE Return01AA00			;$01A9F6	|
	LDY.w $18E1				;$01A9F8	|
	LDA.b #$1F				;$01A9FB	|
	STA.w $1540,Y				;$01A9FD	|
Return01AA00:
	RTS

CODE_01AA01:
	LDY.w $14C8,X
	STZ.w $1626,X				;$01AA04	|
	CPY.b #$08				;$01AA07	|
	BEQ SetStunnedTimer			;$01AA09	|
CODE_01AA0B:
	LDA $C2,X
	BNE SetStunnedTimer			;$01AA0D	|
	STZ.w $1540,X				;$01AA0F	|
	BRA SetAsStunned			;$01AA12	|

SetStunnedTimer:
	LDA.b #$02
	LDY $9E,X				;$01AA16	|
	CPY.b #$0F				;$01AA18	|
	BEQ CODE_01AA28				;$01AA1A	|
	CPY.b #$11				;$01AA1C	|
	BEQ CODE_01AA28				;$01AA1E	|
	CPY.b #$A2				;$01AA20	|
	BEQ CODE_01AA28				;$01AA22	|
	CPY.b #$0D				;$01AA24	|
	BNE CODE_01AA2A				;$01AA26	|
CODE_01AA28:
	LDA.b #$FF
CODE_01AA2A:
	STA.w $1540,X
SetAsStunned:
	LDA.b #$09
	STA.w $14C8,X				;$01AA2F	|
	RTS					;$01AA32	|

BoostMarioSpeed:
	LDA $74
	BNE Return01AA41			;$01AA35	|
	LDA.b #$D0				;$01AA37	|
	BIT $15					;$01AA39	|
	BPL CODE_01AA3F				;$01AA3B	|
	LDA.b #$A8				;$01AA3D	|
CODE_01AA3F:
	STA $7D
Return01AA41:
	RTL

CODE_01AA42:
	LDA.w $140D
	ORA.w $187A				;$01AA45	|
	BEQ CODE_01AA58				;$01AA48	|
	LDA $7D					;$01AA4A	|
	BMI CODE_01AA58				;$01AA4C	|
	LDA.w $1656,X				;$01AA4E	|
	AND.b #$10				;$01AA51	|
	BEQ CODE_01AA58				;$01AA53	|
	JMP CODE_01A924				;$01AA55	|

CODE_01AA58:
	LDA $15
	AND.b #$40				;$01AA5A	|
	BEQ CODE_01AA74				;$01AA5C	|
	LDA.w $1470				;$01AA5E	|
	ORA.w $187A				;$01AA61	|
	BNE CODE_01AA74				;$01AA64	|
	LDA.b #$0B				;$01AA66	|
	STA.w $14C8,X				;$01AA68	|
	INC.w $1470				;$01AA6B	|
	LDA.b #$08				;$01AA6E	|
	STA.w $1498				;$01AA70	|
	RTS					;$01AA73	|

CODE_01AA74:
	LDA $9E,X
	CMP.b #$80				;$01AA76	|
	BEQ CODE_01AAB7				;$01AA78	|
	CMP.b #$3E				;$01AA7A	|
	BEQ CODE_01AAB2				;$01AA7C	|
	CMP.b #$0D				;$01AA7E	|
	BEQ CODE_01AA97				;$01AA80	|
	CMP.b #$2D				;$01AA82	|
	BEQ CODE_01AA97				;$01AA84	|
	CMP.b #$A2				;$01AA86	|
	BEQ CODE_01AA97				;$01AA88	|
	CMP.b #$0F				;$01AA8A	|
	BNE CODE_01AA94				;$01AA8C	|
	LDA.b #$F0				;$01AA8E	|
	STA $AA,X				;$01AA90	|
	BRA CODE_01AA97				;$01AA92	|

CODE_01AA94:
	JSR CODE_01AB46
CODE_01AA97:
	JSR PlayKickSfx
	LDA.w $1540,X				;$01AA9A	|
	STA $C2,X				;$01AA9D	|
	LDA.b #$0A				;$01AA9F	|
	STA.w $14C8,X				;$01AAA1	|
	LDA.b #$10				;$01AAA4	|
	STA.w $154C,X				;$01AAA6	|
	JSR SubHorizPos				;$01AAA9	|
	LDA.w ShellSpeedX,Y			;$01AAAC	|
	STA $B6,X				;$01AAAF	|
	RTS					;$01AAB1	|

CODE_01AAB2:
	LDA.w $163E,X
	BNE Return01AB2C			;$01AAB5	|
CODE_01AAB7:
	STZ.w $154C,X
	LDA $D8,X				;$01AABA	|
	SEC					;$01AABC	|
	SBC $D3					;$01AABD	|
	CLC					;$01AABF	|
	ADC.b #$08				;$01AAC0	|
	CMP.b #$20				;$01AAC2	|
	BCC CODE_01AB31				;$01AAC4	|
	BPL CODE_01AACD				;$01AAC6	|
	LDA.b #$10				;$01AAC8	|
	STA $7D					;$01AACA	|
	RTS					;$01AACC	|

CODE_01AACD:
	LDA $7D
	BMI Return01AB2C			;$01AACF	|
	STZ $7D					;$01AAD1	|
	STZ $72					;$01AAD3	|
	INC.w $1471				;$01AAD5	|
	LDA.b #$1F				;$01AAD8	|
	LDY.w $187A				;$01AADA	|
	BEQ CODE_01AAE1				;$01AADD	|
	LDA.b #$2F				;$01AADF	|
CODE_01AAE1:
	STA $00
	LDA $D8,X				;$01AAE3	|
	SEC					;$01AAE5	|
	SBC $00					;$01AAE6	|
	STA $96					;$01AAE8	|
	LDA.w $14D4,X				;$01AAEA	|
	SBC.b #$00				;$01AAED	|
	STA $97					;$01AAEF	|
	LDA $9E,X				;$01AAF1	|
	CMP.b #$3E				;$01AAF3	|
	BNE Return01AB2C			;$01AAF5	|
	ASL.w $167A,X				;$01AAF7	|
	LSR.w $167A,X				;$01AAFA	|
	LDA.b #$0B				;$01AAFD	|
	STA.w $1DF9				;$01AAFF	|
	LDA.w $0DDA				;$01AB02	|
	BMI CODE_01AB0C				;$01AB05	|
	LDA.b #$0E				;$01AB07	|
	STA.w $1DFB				;$01AB09	|
CODE_01AB0C:
	LDA.b #$20
	STA.w $163E,X				;$01AB0E	|
	LSR.w $15F6,X				;$01AB11	|
	ASL.w $15F6,X				;$01AB14	|
	LDY.w $151C,X				;$01AB17	|
	LDA.b #$B0				;$01AB1A	|
	STA.w $14AD,Y				;$01AB1C	|
	LDA.b #$20				;$01AB1F	|
	STA.w $1887				;$01AB21	|
	CPY.b #$01				;$01AB24	|
	BNE Return01AB2C			;$01AB26	|
	JSL CODE_02B9BD				;$01AB28	|
Return01AB2C:
	RTS

DATA_01AB2D:
	db $01,$00,$FF,$FF

CODE_01AB31:
	STZ $7B
	JSR SubHorizPos				;$01AB33	|
	TYA					;$01AB36	|
	ASL					;$01AB37	|
	TAY					;$01AB38	|
	REP #$20				;$01AB39	|
	LDA $94					;$01AB3B	|
	CLC					;$01AB3D	|
	ADC.w DATA_01AB2D,Y			;$01AB3E	|
	STA $94					;$01AB41	|
	SEP #$20				;$01AB43	|
	RTS					;$01AB45	|

CODE_01AB46:
	PHY
	LDA.w $1697				;$01AB47	|
	CLC					;$01AB4A	|
	ADC.w $1626,X				;$01AB4B	|
	INC.w $1697				;$01AB4E	|
	TAY					;$01AB51	|
	INY					;$01AB52	|
	CPY.b #$08				;$01AB53	|
	BCS CODE_01AB5D				;$01AB55	|
	LDA.w Return01A61D,Y			;$01AB57	|
	STA.w $1DF9				;$01AB5A	|
CODE_01AB5D:
	TYA
	CMP.b #$08				;$01AB5E	|
	BCC CODE_01AB64				;$01AB60	|
	LDA.b #$08				;$01AB62	|
CODE_01AB64:
	JSL GivePoints
	PLY					;$01AB68	|
	RTS					;$01AB69	|

DATA_01AB6A:
	db $0C,$FC,$EC,$DC,$CC

CODE_01AB6F:
	JSR PlayKickSfx
CODE_01AB72:
	JSR IsSprOffScreen
	BNE Return01AB98			;$01AB75	|
	PHY					;$01AB77	|
	LDY.b #$03				;$01AB78	|
CODE_01AB7A:
	LDA.w $17C0,Y
	BEQ CODE_01AB83				;$01AB7D	|
	DEY					;$01AB7F	|
	BPL CODE_01AB7A				;$01AB80	|
	INY					;$01AB82	|
CODE_01AB83:
	LDA.b #$02
	STA.w $17C0,Y				;$01AB85	|
	LDA $E4,X				;$01AB88	|
	STA.w $17C8,Y				;$01AB8A	|
	LDA $D8,X				;$01AB8D	|
	STA.w $17C4,Y				;$01AB8F	|
	LDA.b #$08				;$01AB92	|
	STA.w $17CC,Y				;$01AB94	|
	PLY					;$01AB97	|
Return01AB98:
	RTL

DisplayContactGfx:
	JSR IsSprOffScreen
	BNE Return01ABCB			;$01AB9C	|
	PHY					;$01AB9E	|
	LDY.b #$03				;$01AB9F	|
CODE_01ABA1:
	LDA.w $17C0,Y
	BEQ CODE_01ABAA				;$01ABA4	|
	DEY					;$01ABA6	|
	BPL CODE_01ABA1				;$01ABA7	|
	INY					;$01ABA9	|
CODE_01ABAA:
	LDA.b #$02
	STA.w $17C0,Y				;$01ABAC	|
	LDA $94					;$01ABAF	|
	STA.w $17C8,Y				;$01ABB1	|
	LDA.w $187A				;$01ABB4	|
	CMP.b #$01				;$01ABB7	|
	LDA.b #$14				;$01ABB9	|
	BCC CODE_01ABBF				;$01ABBB	|
	LDA.b #$1E				;$01ABBD	|
CODE_01ABBF:
	CLC
	ADC $96					;$01ABC0	|
	STA.w $17C4,Y				;$01ABC2	|
	LDA.b #$08				;$01ABC5	|
	STA.w $17CC,Y				;$01ABC7	|
	PLY					;$01ABCA	|
Return01ABCB:
	RTL

SubSprXPosNoGrvty:
	TXA
	CLC					;$01ABCD	|
	ADC.b #$0C				;$01ABCE	|
	TAX					;$01ABD0	|
	JSR SubSprYPosNoGrvty			;$01ABD1	|
	LDX.w $15E9				;$01ABD4	|
	RTS					;$01ABD7	|

SubSprYPosNoGrvty:
	LDA $AA,X
	BEQ CODE_01AC09				;$01ABDA	|
	ASL					;$01ABDC	|
	ASL					;$01ABDD	|
	ASL					;$01ABDE	|
	ASL					;$01ABDF	|
	CLC					;$01ABE0	|
	ADC.w $14EC,X				;$01ABE1	|
	STA.w $14EC,X				;$01ABE4	|
	PHP					;$01ABE7	|
	PHP					;$01ABE8	|
	LDY.b #$00				;$01ABE9	|
	LDA $AA,X				;$01ABEB	|
	LSR					;$01ABED	|
	LSR					;$01ABEE	|
	LSR					;$01ABEF	|
	LSR					;$01ABF0	|
	CMP.b #$08				;$01ABF1	|
	BCC CODE_01ABF8				;$01ABF3	|
	ORA.b #$F0				;$01ABF5	|
	DEY					;$01ABF7	|
CODE_01ABF8:
	PLP
	PHA					;$01ABF9	|
	ADC $D8,X				;$01ABFA	|
	STA $D8,X				;$01ABFC	|
	TYA					;$01ABFE	|
	ADC.w $14D4,X				;$01ABFF	|
	STA.w $14D4,X				;$01AC02	|
	PLA					;$01AC05	|
	PLP					;$01AC06	|
	ADC.b #$00				;$01AC07	|
CODE_01AC09:
	STA.w $1491
	RTS					;$01AC0C	|

SpriteOffScreen1:
	db $40,$B0

SpriteOffScreen2:
	db $01,$FF

SpriteOffScreen3:
	db $30,$C0,$A0,$C0,$A0,$F0,$60,$90
SpriteOffScreen4:
	db $01,$FF,$01,$FF,$01,$FF,$01,$FF

SubOffscreen3Bnk1:
	LDA.b #$06
	STA $03					;$01AC23	|
	BRA CODE_01AC2D				;$01AC25	|

SubOffscreen2Bnk1:
	LDA.b #$04
	BRA CODE_01AC2D				;$01AC29	|

SubOffscreen1Bnk1:
	LDA.b #$02
CODE_01AC2D:
	STA $03
	BRA CODE_01AC33				;$01AC2F	|

SubOffscreen0Bnk1:
	STZ $03
CODE_01AC33:
	JSR IsSprOffScreen
	BEQ Return01ACA4			;$01AC36	|
	LDA $5B					;$01AC38	|
	AND.b #$01				;$01AC3A	|
	BNE VerticalLevel			;$01AC3C	|
	LDA $D8,X				;$01AC3E	|
	CLC					;$01AC40	|
	ADC.b #$50				;$01AC41	|
	LDA.w $14D4,X				;$01AC43	|
	ADC.b #$00				;$01AC46	|
	CMP.b #$02				;$01AC48	|
	BPL OffScrEraseSprite			;$01AC4A	|
	LDA.w $167A,X				;$01AC4C	|
	AND.b #$04				;$01AC4F	|
	BNE Return01ACA4			;$01AC51	|
	LDA $13					;$01AC53	|
	AND.b #$01				;$01AC55	|
	ORA $03					;$01AC57	|
	STA $01					;$01AC59	|
	TAY					;$01AC5B	|
	LDA $1A					;$01AC5C	|
	CLC					;$01AC5E	|
	ADC.w SpriteOffScreen3,Y		;$01AC5F	|
	ROL $00					;$01AC62	|
	CMP $E4,X				;$01AC64	|
	PHP					;$01AC66	|
	LDA $1B					;$01AC67	|
	LSR $00					;$01AC69	|
	ADC.w SpriteOffScreen4,Y		;$01AC6B	|
	PLP					;$01AC6E	|
	SBC.w $14E0,X				;$01AC6F	|
	STA $00					;$01AC72	|
	LSR $01					;$01AC74	|
	BCC CODE_01AC7C				;$01AC76	|
	EOR.b #$80				;$01AC78	|
	STA $00					;$01AC7A	|
CODE_01AC7C:
	LDA $00
	BPL Return01ACA4			;$01AC7E	|
OffScrEraseSprite:
	LDA $9E,X
	CMP.b #$1F				;$01AC82	|
	BNE CODE_01AC8E				;$01AC84	|
	STA.w $18C1				;$01AC86	|
	LDA.b #$FF				;$01AC89	|
	STA.w $18C0				;$01AC8B	|
CODE_01AC8E:
	LDA.w $14C8,X
	CMP.b #$08				;$01AC91	|
	BCC OffScrKillSprite			;$01AC93	|
	LDY.w $161A,X				;$01AC95	|
	CPY.b #$FF				;$01AC98	|
	BEQ OffScrKillSprite			;$01AC9A	|
	LDA.b #$00				;$01AC9C	|
	STA.w $1938,Y				;$01AC9E	|
OffScrKillSprite:
	STZ.w $14C8,X
Return01ACA4:
	RTS

VerticalLevel:
	LDA.w $167A,X
	AND.b #$04				;$01ACA8	|
	BNE Return01ACA4			;$01ACAA	|
	LDA $13					;$01ACAC	|
	LSR					;$01ACAE	|
	BCS Return01ACA4			;$01ACAF	|
	LDA $E4,X				;$01ACB1	|
	CMP.b #$00				;$01ACB3	|
	LDA.w $14E0,X				;$01ACB5	|
	SBC.b #$00				;$01ACB8	|
	CMP.b #$02				;$01ACBA	|
	BCS OffScrEraseSprite			;$01ACBC	|
	LDA $13					;$01ACBE	|
	LSR					;$01ACC0	|
	AND.b #$01				;$01ACC1	|
	STA $01					;$01ACC3	|
	TAY					;$01ACC5	|
	BEQ CODE_01ACD2				;$01ACC6	|
	LDA $9E,X				;$01ACC8	|
	CMP.b #$22				;$01ACCA	|
	BEQ Return01ACA4			;$01ACCC	|
	CMP.b #$24				;$01ACCE	|
	BEQ Return01ACA4			;$01ACD0	|
CODE_01ACD2:
	LDA $1C
	CLC					;$01ACD4	|
	ADC.w SpriteOffScreen1,Y		;$01ACD5	|
	ROL $00					;$01ACD8	|
	CMP $D8,X				;$01ACDA	|
	PHP					;$01ACDC	|
	LDA.w $1D				;$01ACDD	|
	LSR $00					;$01ACE0	|
	ADC.w SpriteOffScreen2,Y		;$01ACE2	|
	PLP					;$01ACE5	|
	SBC.w $14D4,X				;$01ACE6	|
	STA $00					;$01ACE9	|
	LDY $01					;$01ACEB	|
	BEQ CODE_01ACF3				;$01ACED	|
	EOR.b #$80				;$01ACEF	|
	STA $00					;$01ACF1	|
CODE_01ACF3:
	LDA $00
	BPL Return01ACA4			;$01ACF5	|
	BMI OffScrEraseSprite			;$01ACF7	|
GetRand:
	PHY
	LDY.b #$01				;$01ACFA	|
	JSL CODE_01AD07				;$01ACFC	|
	DEY					;$01AD00	|
	JSL CODE_01AD07				;$01AD01	|
	PLY					;$01AD05	|
	RTL					;$01AD06	|

CODE_01AD07:
	LDA.w $148B
	ASL					;$01AD0A	|
	ASL					;$01AD0B	|
	SEC					;$01AD0C	|
	ADC.w $148B				;$01AD0D	|
	STA.w $148B				;$01AD10	|
	ASL.w $148C				;$01AD13	|
	LDA.b #$20				;$01AD16	|
	BIT.w $148C				;$01AD18	|
	BCC CODE_01AD21				;$01AD1B	|
	BEQ CODE_01AD26				;$01AD1D	|
	BNE CODE_01AD23				;$01AD1F	|
CODE_01AD21:
	BNE CODE_01AD26
CODE_01AD23:
	INC.w $148C
CODE_01AD26:
	LDA.w $148C
	EOR.w $148B				;$01AD29	|
	STA.w $148D,Y				;$01AD2C	|
	RTL					;$01AD2F	|

SubHorizPos:
	LDY.b #$00
	LDA $D1					;$01AD32	|
	SEC					;$01AD34	|
	SBC $E4,X				;$01AD35	|
	STA $0F					;$01AD37	|
	LDA $D2					;$01AD39	|
	SBC.w $14E0,X				;$01AD3B	|
	BPL Return01AD41			;$01AD3E	|
	INY					;$01AD40	|
Return01AD41:
	RTS

CODE_01AD42:
	LDY.b #$00
	LDA $D3					;$01AD44	|
	SEC					;$01AD46	|
	SBC $D8,X				;$01AD47	|
	STA $0E					;$01AD49	|
	LDA $D4					;$01AD4B	|
	SBC.w $14D4,X				;$01AD4D	|
	BPL Return01AD53			;$01AD50	|
	INY					;$01AD52	|
Return01AD53:
	RTS

DATA_01AD54:
	db $FF,$FF,$FF,$FF,$FF

InitFlyingQBlock:
	LDA $E4,X
	LSR					;$01AD5B	|
	LSR					;$01AD5C	|
	LSR					;$01AD5D	|
	LSR					;$01AD5E	|
	AND.b #$03				;$01AD5F	|
	STA.w $151C,X				;$01AD61	|
	INC.w $157C,X				;$01AD64	|
	RTS					;$01AD67	|

DATA_01AD68:
	db $FF,$01

DATA_01AD6A:
	db $F4,$0C

DATA_01AD6C:
	db $F0,$10

FlyingQBlock:
	LDA.w $163E,X
	BEQ CODE_01AD80				;$01AD71	|
	STZ.w $15EA,X				;$01AD73	|
	LDA.w $187A				;$01AD76	|
	BNE CODE_01AD80				;$01AD79	|
	LDA.b #$04				;$01AD7B	|
	STA.w $15EA,X				;$01AD7D	|
CODE_01AD80:
	JSR SubSprGfx2Entry1
	LDY.w $15EA,X				;$01AD83	|
	LDA.w $0301,Y				;$01AD86	|
	DEC A					;$01AD89	|
	STA.w $0301,Y				;$01AD8A	|
	STZ.w $1528,X				;$01AD8D	|
	LDA $C2,X				;$01AD90	|
	BNE CODE_01ADF8				;$01AD92	|
	JSR CODE_019E95				;$01AD94	|
	LDA $9D					;$01AD97	|
	BNE CODE_01ADF8				;$01AD99	|
	LDA $13					;$01AD9B	|
	AND.b #$01				;$01AD9D	|
	BNE CODE_01ADB7				;$01AD9F	|
	LDA.w $1594,X				;$01ADA1	|
	AND.b #$01				;$01ADA4	|
	TAY					;$01ADA6	|
	LDA $AA,X				;$01ADA7	|
	CLC					;$01ADA9	|
	ADC.w DATA_01AD68,Y			;$01ADAA	|
	STA $AA,X				;$01ADAD	|
	CMP.w DATA_01AD6A,Y			;$01ADAF	|
	BNE CODE_01ADB7				;$01ADB2	|
	INC.w $1594,X				;$01ADB4	|
CODE_01ADB7:
	JSR SubSprYPosNoGrvty
	LDA $9E,X				;$01ADBA	|
	CMP.b #$83				;$01ADBC	|
	BEQ CODE_01ADE8				;$01ADBE	|
	LDA.w $1540,X				;$01ADC0	|
	BNE CODE_01ADE6				;$01ADC3	|
	LDA $13					;$01ADC5	|
	AND.b #$03				;$01ADC7	|
	BNE CODE_01ADE6				;$01ADC9	|
	LDA.w $1534,X				;$01ADCB	|
	AND.b #$01				;$01ADCE	|
	TAY					;$01ADD0	|
	LDA $B6,X				;$01ADD1	|
	CLC					;$01ADD3	|
	ADC.w DATA_01AD68,Y			;$01ADD4	|
	STA $B6,X				;$01ADD7	|
	CMP.w DATA_01AD6C,Y			;$01ADD9	|
	BNE CODE_01ADE6				;$01ADDC	|
	INC.w $1534,X				;$01ADDE	|
	LDA.b #$20				;$01ADE1	|
	STA.w $1540,X				;$01ADE3	|
CODE_01ADE6:
	BRA CODE_01ADEC

CODE_01ADE8:
	LDA.b #$F4
	STA $B6,X				;$01ADEA	|
CODE_01ADEC:
	JSR SubSprXPosNoGrvty
	LDA.w $1491				;$01ADEF	|
	STA.w $1528,X				;$01ADF2	|
	INC.w $1570,X				;$01ADF5	|
CODE_01ADF8:
	JSR SubSprSprInteract
	JSR CODE_01B457				;$01ADFB	|
	JSR SubOffscreen0Bnk1			;$01ADFE	|
	LDA.w $1558,X				;$01AE01	|
	CMP.b #$08				;$01AE04	|
	BNE CODE_01AE5E				;$01AE06	|
	LDY $C2,X				;$01AE08	|
	CPY.b #$02				;$01AE0A	|
	BEQ CODE_01AE5E				;$01AE0C	|
	PHA					;$01AE0E	|
	INC $C2,X				;$01AE0F	|
	LDA.b #$50				;$01AE11	|
	STA.w $163E,X				;$01AE13	|
	LDA $E4,X				;$01AE16	|
	STA $9A					;$01AE18	|
	LDA.w $14E0,X				;$01AE1A	|
	STA $9B					;$01AE1D	|
	LDA $D8,X				;$01AE1F	|
	STA $98					;$01AE21	|
	LDA.w $14D4,X				;$01AE23	|
	STA $99					;$01AE26	|
	LDA.b #$FF				;$01AE28	|
	STA.w $161A,X				;$01AE2A	|
	LDY.w $151C,X				;$01AE2D	|
	LDA $19					;$01AE30	|
	BNE CODE_01AE38				;$01AE32	|
	INY					;$01AE34	|
	INY					;$01AE35	|
	INY					;$01AE36	|
	INY					;$01AE37	|
CODE_01AE38:
	LDA.w DATA_01AE88,Y
	STA $05					;$01AE3B	|
	PHB					;$01AE3D	|
	LDA.b #$02				;$01AE3E	|
	PHA					;$01AE40	|
	PLB					;$01AE41	|
	PHX					;$01AE42	|
	JSL CODE_02887D				;$01AE43	|
	PLX					;$01AE47	|
	LDY.w $185E				;$01AE48	|
	LDA.b #$01				;$01AE4B	|
	STA.w $1528,Y				;$01AE4D	|
	LDA.w $009E,y				;$01AE50	|
	CMP.b #$75				;$01AE53	|
	BNE CODE_01AE5C				;$01AE55	|
	LDA.b #$FF				;$01AE57	|
	STA.w $00C2,y				;$01AE59	|
CODE_01AE5C:
	PLB
	PLA					;$01AE5D	|
CODE_01AE5E:
	LSR
	TAY					;$01AE5F	|
	LDA.w DATA_01AE7F,Y			;$01AE60	|
	STA $00					;$01AE63	|
	LDY.w $15EA,X				;$01AE65	|
	LDA.w $0301,Y				;$01AE68	|
	SEC					;$01AE6B	|
	SBC $00					;$01AE6C	|
	STA.w $0301,Y				;$01AE6E	|
	LDA $C2,X				;$01AE71	|
	CMP.b #$01				;$01AE73	|
	LDA.b #$2A				;$01AE75	|
	BCC CODE_01AE7B				;$01AE77	|
	LDA.b #$2E				;$01AE79	|
CODE_01AE7B:
	STA.w $0302,Y
	RTS					;$01AE7E	|

DATA_01AE7F:
	db $00,$03,$05,$07,$08,$08,$07,$05
	db $03

DATA_01AE88:
	db $06,$02,$04,$05,$06,$01,$01,$05

Return01AE90:
	RTS

PalaceSwitch:
	JSL CODE_02CD2D
	RTS					;$01AE95	|

InitThwomp:
	LDA $D8,X
	STA.w $151C,X				;$01AE98	|
	LDA $E4,X				;$01AE9B	|
	CLC					;$01AE9D	|
	ADC.b #$08				;$01AE9E	|
	STA $E4,X				;$01AEA0	|
Return01AEA2:
	RTS

Thwomp:
	JSR ThwompGfx
	LDA.w $14C8,X				;$01AEA6	|
	CMP.b #$08				;$01AEA9	|
	BNE Return01AEA2			;$01AEAB	|
	LDA $9D					;$01AEAD	|
	BNE Return01AEA2			;$01AEAF	|
	JSR SubOffscreen0Bnk1			;$01AEB1	|
	JSR MarioSprInteractRt			;$01AEB4	|
	LDA $C2,X				;$01AEB7	|
	JSL ExecutePtr				;$01AEB9	|

ThwompStatePtrs:
	dw CODE_01AEC3
	dw CODE_01AEFA
	dw CODE_01AF24

CODE_01AEC3:
	LDA.w $186C,X
	BNE CODE_01AEEE				;$01AEC6	|
	LDA.w $15A0,X				;$01AEC8	|
	BNE Return01AEF9			;$01AECB	|
	JSR SubHorizPos				;$01AECD	|
	TYA					;$01AED0	|
	STA.w $157C,X				;$01AED1	|
	STZ.w $1528,X				;$01AED4	|
	LDA $0F					;$01AED7	|
	CLC					;$01AED9	|
	ADC.b #$40				;$01AEDA	|
	CMP.b #$80				;$01AEDC	|
	BCS CODE_01AEE5				;$01AEDE	|
	LDA.b #$01				;$01AEE0	|
	STA.w $1528,X				;$01AEE2	|
CODE_01AEE5:
	LDA $0F
	CLC					;$01AEE7	|
	ADC.b #$24				;$01AEE8	|
	CMP.b #$50				;$01AEEA	|
	BCS Return01AEF9			;$01AEEC	|
CODE_01AEEE:
	LDA.b #$02
	STA.w $1528,X				;$01AEF0	|
	INC $C2,X				;$01AEF3	|
	LDA.b #$00				;$01AEF5	|
	STA $AA,X				;$01AEF7	|
Return01AEF9:
	RTS

CODE_01AEFA:
	JSR SubSprYPosNoGrvty
	LDA $AA,X				;$01AEFD	|
	CMP.b #$3E				;$01AEFF	|
	BCS CODE_01AF07				;$01AF01	|
	ADC.b #$04				;$01AF03	|
	STA $AA,X				;$01AF05	|
CODE_01AF07:
	JSR CODE_019140
	JSR IsOnGround				;$01AF0A	|
	BEQ Return01AF23			;$01AF0D	|
	JSR SetSomeYSpeed			;$01AF0F	|
	LDA.b #$18				;$01AF12	|
	STA.w $1887				;$01AF14	|
	LDA.b #$09				;$01AF17	|
	STA.w $1DFC				;$01AF19	|
	LDA.b #$40				;$01AF1C	|
	STA.w $1540,X				;$01AF1E	|
	INC $C2,X				;$01AF21	|
Return01AF23:
	RTS

CODE_01AF24:
	LDA.w $1540,X
	BNE Return01AF3F			;$01AF27	|
	STZ.w $1528,X				;$01AF29	|
	LDA $D8,X				;$01AF2C	|
	CMP.w $151C,X				;$01AF2E	|
	BNE CODE_01AF38				;$01AF31	|
	LDA.b #$00				;$01AF33	|
	STA $C2,X				;$01AF35	|
	RTS					;$01AF37	|

CODE_01AF38:
	LDA.b #$F0
	STA $AA,X				;$01AF3A	|
	JSR SubSprYPosNoGrvty			;$01AF3C	|
Return01AF3F:
	RTS

ThwompDispX:
	db $FC,$04,$FC,$04,$00

ThwompDispY:
	db $00,$00,$10,$10,$08

ThwompTiles:
	db $8E,$8E,$AE,$AE,$C8

ThwompGfxProp:
	db $03,$43,$03,$43,$03

ThwompGfx:
	JSR GetDrawInfoBnk1
	LDA.w $1528,X				;$01AF57	|
	STA $02					;$01AF5A	|
	PHX					;$01AF5C	|
	LDX.b #$03				;$01AF5D	|
	CMP.b #$00				;$01AF5F	|
	BEQ CODE_01AF64				;$01AF61	|
	INX					;$01AF63	|
CODE_01AF64:
	LDA $00
	CLC					;$01AF66	|
	ADC.w ThwompDispX,X			;$01AF67	|
	STA.w $0300,Y				;$01AF6A	|
	LDA $01					;$01AF6D	|
	CLC					;$01AF6F	|
	ADC.w ThwompDispY,X			;$01AF70	|
	STA.w $0301,Y				;$01AF73	|
	LDA.w ThwompGfxProp,X			;$01AF76	|
	ORA $64					;$01AF79	|
	STA.w $0303,Y				;$01AF7B	|
	LDA.w ThwompTiles,X			;$01AF7E	|
	CPX.b #$04				;$01AF81	|
	BNE CODE_01AF8F				;$01AF83	|
	PHX					;$01AF85	|
	LDX $02					;$01AF86	|
	CPX.b #$02				;$01AF88	|
	BNE CODE_01AF8E				;$01AF8A	|
	LDA.b #$CA				;$01AF8C	|
CODE_01AF8E:
	PLX
CODE_01AF8F:
	STA.w $0302,Y
	INY					;$01AF92	|
	INY					;$01AF93	|
	INY					;$01AF94	|
	INY					;$01AF95	|
	DEX					;$01AF96	|
	BPL CODE_01AF64				;$01AF97	|
	PLX					;$01AF99	|
	LDA.b #$04				;$01AF9A	|
	JMP CODE_01B37E				;$01AF9C	|

Thwimp:
	LDA.w $14C8,X
	CMP.b #$08				;$01AFA2	|
	BNE CODE_01B006				;$01AFA4	|
	LDA $9D					;$01AFA6	|
	BNE CODE_01B006				;$01AFA8	|
	JSR SubOffscreen0Bnk1			;$01AFAA	|
	JSR MarioSprInteractRt			;$01AFAD	|
	JSR SubSprXPosNoGrvty			;$01AFB0	|
	JSR SubSprYPosNoGrvty			;$01AFB3	|
	JSR CODE_019140				;$01AFB6	|
	LDA $AA,X				;$01AFB9	|
	BMI CODE_01AFC3				;$01AFBB	|
	CMP.b #$40				;$01AFBD	|
	BCS CODE_01AFC8				;$01AFBF	|
	ADC.b #$05				;$01AFC1	|
CODE_01AFC3:
	CLC
	ADC.b #$03				;$01AFC4	|
	BRA CODE_01AFCA				;$01AFC6	|

CODE_01AFC8:
	LDA.b #$40
CODE_01AFCA:
	STA $AA,X
	JSR IsTouchingCeiling			;$01AFCC	|
	BEQ CODE_01AFD5				;$01AFCF	|
	LDA.b #$10				;$01AFD1	|
	STA $AA,X				;$01AFD3	|
CODE_01AFD5:
	JSR IsOnGround
	BEQ CODE_01B006				;$01AFD8	|
	JSR SetSomeYSpeed			;$01AFDA	|
	STZ $B6,X				;$01AFDD	|
	STZ $AA,X				;$01AFDF	|
	LDA.w $1540,X				;$01AFE1	|
	BEQ CODE_01AFFC				;$01AFE4	|
	DEC A					;$01AFE6	|
	BNE CODE_01B006				;$01AFE7	|
	LDA.b #$A0				;$01AFE9	|
	STA $AA,X				;$01AFEB	|
	INC $C2,X				;$01AFED	|
	LDA $C2,X				;$01AFEF	|
	LSR					;$01AFF1	|
	LDA.b #$10				;$01AFF2	|
	BCC CODE_01AFF8				;$01AFF4	|
	LDA.b #$F0				;$01AFF6	|
CODE_01AFF8:
	STA $B6,X
	BRA CODE_01B006				;$01AFFA	|

CODE_01AFFC:
	LDA.b #$01
	STA.w $1DF9				;$01AFFE	|
	LDA.b #$40				;$01B001	|
	STA.w $1540,X				;$01B003	|
CODE_01B006:
	LDA.b #$01
	JMP SubSprGfx0Entry0			;$01B008	|

InitVerticalFish:
	JSR FaceMario
	INC.w $151C,X				;$01B00E	|
Return01B011:
	RTS

DATA_01B012:
	db $10,$F0

InitFish:
	JSR SubHorizPos
	LDA.w DATA_01B012,Y			;$01B017	|
	STA $B6,X				;$01B01A	|
	RTS					;$01B01C	|

DATA_01B01D:
	db $08,$F8

DATA_01B01F:
	db $00,$00,$08,$F8

DATA_01B023:
	db $F0,$10

DATA_01B025:
	db $E0,$E8,$D0,$D8

DATA_01B029:
	db $08,$F8,$10,$F0,$04,$FC,$14,$EC
DATA_01B031:
	db $03,$0C

Fish:
	LDA.w $14C8,X
	CMP.b #$08				;$01B036	|
	BNE CODE_01B03E				;$01B038	|
	LDA $9D					;$01B03A	|
	BEQ CODE_01B041				;$01B03C	|
CODE_01B03E:
	JMP CODE_01B10A

CODE_01B041:
	JSR SetAnimationFrame
	LDA.w $164A,X				;$01B044	|
	BNE CODE_01B0A7				;$01B047	|
	JSR SubUpdateSprPos			;$01B049	|
	JSR IsTouchingObjSide			;$01B04C	|
	BEQ CODE_01B054				;$01B04F	|
	JSR FlipSpriteDir			;$01B051	|
CODE_01B054:
	JSR IsOnGround
	BEQ CODE_01B09C				;$01B057	|
	LDA.w $190E				;$01B059	|
	BEQ CODE_01B062				;$01B05C	|
	JSL CODE_0284BC				;$01B05E	|
CODE_01B062:
	JSL GetRand
	ADC $13					;$01B066	|
	AND.b #$07				;$01B068	|
	TAY					;$01B06A	|
	LDA.w DATA_01B029,Y			;$01B06B	|
	STA $B6,X				;$01B06E	|
	JSL GetRand				;$01B070	|
	LDA.w $148E				;$01B074	|
	AND.b #$03				;$01B077	|
	TAY					;$01B079	|
	LDA.w DATA_01B025,Y			;$01B07A	|
	STA $AA,X				;$01B07D	|
	LDA.w $148D				;$01B07F	|
	AND.b #$40				;$01B082	|
	BNE CODE_01B08E				;$01B084	|
	LDA.w $15F6,X				;$01B086	|
	EOR.b #$80				;$01B089	|
	STA.w $15F6,X				;$01B08B	|
CODE_01B08E:
	JSL GetRand
	LDA.w $148D				;$01B092	|
	AND.b #$80				;$01B095	|
	BNE CODE_01B09C				;$01B097	|
	JSR UpdateDirection			;$01B099	|
CODE_01B09C:
	LDA.w $1602,X
	CLC					;$01B09F	|
	ADC.b #$02				;$01B0A0	|
	STA.w $1602,X				;$01B0A2	|
	BRA CODE_01B0EA				;$01B0A5	|

CODE_01B0A7:
	JSR CODE_019140
	JSR UpdateDirection			;$01B0AA	|
	ASL.w $15F6,X				;$01B0AD	|
	LSR.w $15F6,X				;$01B0B0	|
	LDA.w $1588,X				;$01B0B3	|
	LDY.w $151C,X				;$01B0B6	|
	AND.w DATA_01B031,Y			;$01B0B9	|
	BNE CODE_01B0C3				;$01B0BC	|
	LDA.w $1540,X				;$01B0BE	|
	BNE CODE_01B0CA				;$01B0C1	|
CODE_01B0C3:
	LDA.b #$80
	STA.w $1540,X				;$01B0C5	|
	INC $C2,X				;$01B0C8	|
CODE_01B0CA:
	LDA $C2,X
	AND.b #$01				;$01B0CC	|
	TAY					;$01B0CE	|
	LDA.w $151C,X				;$01B0CF	|
	BEQ CODE_01B0D6				;$01B0D2	|
	INY					;$01B0D4	|
	INY					;$01B0D5	|
CODE_01B0D6:
	LDA.w DATA_01B01D,Y
	STA $B6,X				;$01B0D9	|
	LDA.w DATA_01B01F,Y			;$01B0DB	|
	STA $AA,X				;$01B0DE	|
	JSR SubSprXPosNoGrvty			;$01B0E0	|
	AND.b #$0C				;$01B0E3	|
	BNE CODE_01B0EA				;$01B0E5	|
	JSR SubSprYPosNoGrvty			;$01B0E7	|
CODE_01B0EA:
	JSR SubSprSprInteract
	JSR MarioSprInteractRt			;$01B0ED	|
	BCC CODE_01B10A				;$01B0F0	|
	LDA.w $164A,X				;$01B0F2	|
	BEQ CODE_01B107				;$01B0F5	|
	LDA.w $1490				;$01B0F7	|
	BNE CODE_01B107				;$01B0FA	|
	LDA.w $187A				;$01B0FC	|
	BNE CODE_01B10A				;$01B0FF	|
	JSL HurtMario				;$01B101	|
	BRA CODE_01B10A				;$01B105	|

CODE_01B107:
	JSR CODE_01B12A
CODE_01B10A:
	LDA.w $1602,X
	LSR					;$01B10D	|
	EOR.b #$01				;$01B10E	|
	STA $00					;$01B110	|
	LDA.w $15F6,X				;$01B112	|
	AND.b #$FE				;$01B115	|
	ORA $00					;$01B117	|
	STA.w $15F6,X				;$01B119	|
	JSR SubSprGfx2Entry1			;$01B11C	|
	JSR SubOffscreen0Bnk1			;$01B11F	|
	LSR.w $15F6,X				;$01B122	|
	SEC					;$01B125	|
	ROL.w $15F6,X				;$01B126	|
	RTS					;$01B129	|

CODE_01B12A:
	LDA.b #$10
	STA.w $149A				;$01B12C	|
	LDA.b #$03				;$01B12F	|
	STA.w $1DF9				;$01B131	|
	JSR SubHorizPos				;$01B134	|
	LDA.w DATA_01B023,Y			;$01B137	|
	STA $B6,X				;$01B13A	|
	LDA.b #$E0				;$01B13C	|
	STA $AA,X				;$01B13E	|
	LDA.b #$02				;$01B140	|
	STA.w $14C8,X				;$01B142	|
	STY $76					;$01B145	|
	LDA.b #$01				;$01B147	|
	JSL GivePoints				;$01B149	|
	RTS					;$01B14D	|

CODE_01B14E:
	LDA $13
	AND.b #$03				;$01B150	|
CODE_01B152:
	ORA.w $186C,X
	ORA $9D					;$01B155	|
	BNE Return01B191			;$01B157	|
	JSL GetRand				;$01B159	|
	AND.b #$0F				;$01B15D	|
	CLC					;$01B15F	|
	LDY.b #$00				;$01B160	|
	ADC.b #$FC				;$01B162	|
	BPL CODE_01B167				;$01B164	|
	DEY					;$01B166	|
CODE_01B167:
	CLC
	ADC $E4,X				;$01B168	|
	STA $02					;$01B16A	|
	TYA					;$01B16C	|
	ADC.w $14E0,X				;$01B16D	|
	PHA					;$01B170	|
	LDA $02					;$01B171	|
	CMP $1A					;$01B173	|
	PLA					;$01B175	|
	SBC $1B					;$01B176	|
	BNE Return01B191			;$01B178	|
	LDA.w $148E				;$01B17A	|
	AND.b #$0F				;$01B17D	|
	CLC					;$01B17F	|
	ADC.b #$FE				;$01B180	|
	ADC $D8,X				;$01B182	|
	STA $00					;$01B184	|
	LDA.w $14D4,X				;$01B186	|
	ADC.b #$00				;$01B189	|
	STA $01					;$01B18B	|
	JSL CODE_0285BA				;$01B18D	|
Return01B191:
	RTS

GeneratedFish:
	JSR CODE_01B209
	LDA $9D					;$01B195	|
	BNE Return01B1B0			;$01B197	|
	JSR SetAnimationFrame			;$01B199	|
	JSR SubSprXPosNoGrvty			;$01B19C	|
	JSR SubSprYPosNoGrvty			;$01B19F	|
	JSR CODE_019140				;$01B1A2	|
	LDA $AA,X				;$01B1A5	|
	CMP.b #$20				;$01B1A7	|
	BPL CODE_01B1AE				;$01B1A9	|
	CLC					;$01B1AB	|
	ADC.b #$01				;$01B1AC	|
CODE_01B1AE:
	STA $AA,X
Return01B1B0:
	RTS

DATA_01B1B1:
	db $D0,$D0,$B0

JumpingFish:
	LDA $9D
	BNE CODE_01B209				;$01B1B6	|
	LDA.w $164A,X				;$01B1B8	|
	STA.w $151C,X				;$01B1BB	|
	JSR SubUpdateSprPos			;$01B1BE	|
	LDA.w $164A,X				;$01B1C1	|
	BEQ CODE_01B1EA				;$01B1C4	|
	LDA $C2,X				;$01B1C6	|
	CMP.b #$03				;$01B1C8	|
	BEQ CODE_01B1DE				;$01B1CA	|
	INC $C2,X				;$01B1CC	|
	TAY					;$01B1CE	|
	LDA.w DATA_01B1B1,Y			;$01B1CF	|
	STA $AA,X				;$01B1D2	|
	LDA.b #$10				;$01B1D4	|
	STA.w $1540,X				;$01B1D6	|
	STZ.w $164A,X				;$01B1D9	|
	BRA CODE_01B206				;$01B1DC	|

CODE_01B1DE:
	DEC $AA,X
	LDA $13					;$01B1E0	|
	AND.b #$03				;$01B1E2	|
	BNE CODE_01B1E8				;$01B1E4	|
	DEC $AA,X				;$01B1E6	|
CODE_01B1E8:
	BRA CODE_01B206

CODE_01B1EA:
	INC.w $1570,X
	INC.w $1570,X				;$01B1ED	|
	CMP.w $151C,X				;$01B1F0	|
	BEQ CODE_01B206				;$01B1F3	|
	LDA.b #$10				;$01B1F5	|
	STA.w $1540,X				;$01B1F7	|
	LDA $C2,X				;$01B1FA	|
	CMP.b #$03				;$01B1FC	|
	BNE CODE_01B206				;$01B1FE	|
	STZ $C2,X				;$01B200	|
	LDA.b #$D0				;$01B202	|
	STA $AA,X				;$01B204	|
CODE_01B206:
	JSR SetAnimationFrame
CODE_01B209:
	JSR SubSprSprPMarioSpr
	JSR UpdateDirection			;$01B20C	|
	JMP CODE_01B10A				;$01B20F	|

DATA_01B212:
	db $08,$F8,$10,$F0

InitFloatSpkBall:
	JSR FaceMario
	LDY.w $157C,X				;$01B219	|
	LDA $E4,X				;$01B21C	|
	AND.b #$10				;$01B21E	|
	BEQ CODE_01B224				;$01B220	|
	INY					;$01B222	|
	INY					;$01B223	|
CODE_01B224:
	LDA.w DATA_01B212,Y
	STA $B6,X				;$01B227	|
	BRA InitFloatingPlat			;$01B229	|

InitFallingPlat:
	INC.w $1602,X
InitOrangePlat:
	LDA.w $190E
	BNE InitFloatingPlat			;$01B231	|
	INC $C2,X				;$01B233	|
	RTS					;$01B235	|

InitFloatingPlat:
	LDA.b #$03
	STA.w $151C,X				;$01B238	|
CODE_01B23B:
	JSR CODE_019140
	LDA.w $164A,X				;$01B23E	|
	BNE Return01B25D			;$01B241	|
	DEC.w $151C,X				;$01B243	|
	BMI CODE_01B262				;$01B246	|
	LDA $D8,X				;$01B248	|
	CLC					;$01B24A	|
	ADC.b #$08				;$01B24B	|
	STA $D8,X				;$01B24D	|
	LDA.w $14D4,X				;$01B24F	|
	ADC.b #$00				;$01B252	|
	STA.w $14D4,X				;$01B254	|
	CMP.b #$02				;$01B257	|
	BCS Return01B25D			;$01B259	|
	BRA CODE_01B23B				;$01B25B	|

Return01B25D:
	RTS

InitChckbrdPlat:
	INC.w $1602,X
	RTS					;$01B261	|

CODE_01B262:
	LDA.b #$01
	STA.w $14C8,X				;$01B264	|
Return01B267:
	RTS

DATA_01B268:
	db $FF,$01

DATA_01B26A:
	db $F0,$10

Platforms:
	JSR CODE_01B2D1
	LDA $9D					;$01B26F	|
	BNE Return01B2C2			;$01B271	|
	LDA.w $1540,X				;$01B273	|
	BNE CODE_01B2A5				;$01B276	|
	INC $C2,X				;$01B278	|
	LDA $C2,X				;$01B27A	|
	AND.b #$03				;$01B27C	|
	BNE CODE_01B2A5				;$01B27E	|
	LDA.w $151C,X				;$01B280	|
	AND.b #$01				;$01B283	|
	TAY					;$01B285	|
	LDA $AA,X				;$01B286	|
	CLC					;$01B288	|
	ADC.w DATA_01B268,Y			;$01B289	|
	STA $AA,X				;$01B28C	|
	STA $B6,X				;$01B28E	|
	CMP.w DATA_01B26A,Y			;$01B290	|
	BNE CODE_01B2A5				;$01B293	|
	INC.w $151C,X				;$01B295	|
	LDA.b #$18				;$01B298	|
	LDY $9E,X				;$01B29A	|
	CPY.b #$55				;$01B29C	|
	BNE CODE_01B2A2				;$01B29E	|
	LDA.b #$08				;$01B2A0	|
CODE_01B2A2:
	STA.w $1540,X
CODE_01B2A5:
	LDA $9E,X
	CMP.b #$57				;$01B2A7	|
	BCS CODE_01B2B0				;$01B2A9	|
	JSR SubSprXPosNoGrvty			;$01B2AB	|
	BRA CODE_01B2B6				;$01B2AE	|

CODE_01B2B0:
	JSR SubSprYPosNoGrvty
	STZ.w $1491				;$01B2B3	|
CODE_01B2B6:
	LDA.w $1491
	STA.w $1528,X				;$01B2B9	|
	JSR CODE_01B457				;$01B2BC	|
	JSR SubOffscreen1Bnk1			;$01B2BF	|
Return01B2C2:
	RTS

DATA_01B2C3:
	db $00,$01,$00,$01,$00,$00,$00,$00
	db $01,$01,$00,$00,$00,$00

CODE_01B2D1:
	LDA $9E,X
	SEC					;$01B2D3	|
	SBC.b #$55				;$01B2D4	|
	TAY					;$01B2D6	|
	LDA.w DATA_01B2C3,Y			;$01B2D7	|
	BEQ CODE_01B2DF				;$01B2DA	|
	JMP CODE_01B395				;$01B2DC	|

CODE_01B2DF:
	JSR GetDrawInfoBnk1
	LDA.w $1602,X				;$01B2E2	|
	STA $01					;$01B2E5	|
	LDA $D8,X				;$01B2E7	|
	SEC					;$01B2E9	|
	SBC $1C					;$01B2EA	|
	STA.w $0301,Y				;$01B2EC	|
	STA.w $0305,Y				;$01B2EF	|
	STA.w $0309,Y				;$01B2F2	|
	LDX $01					;$01B2F5	|
	BEQ CODE_01B2FF				;$01B2F7	|
	STA.w $030D,Y				;$01B2F9	|
	STA.w $0311,Y				;$01B2FC	|
CODE_01B2FF:
	LDX.w $15E9
	LDA $E4,X				;$01B302	|
	SEC					;$01B304	|
	SBC $1A					;$01B305	|
	STA.w $0300,Y				;$01B307	|
	CLC					;$01B30A	|
	ADC.b #$10				;$01B30B	|
	STA.w $0304,Y				;$01B30D	|
	CLC					;$01B310	|
	ADC.b #$10				;$01B311	|
	STA.w $0308,Y				;$01B313	|
	LDX $01					;$01B316	|
	BEQ CODE_01B326				;$01B318	|
	CLC					;$01B31A	|
	ADC.b #$10				;$01B31B	|
	STA.w $030C,Y				;$01B31D	|
	CLC					;$01B320	|
	ADC.b #$10				;$01B321	|
	STA.w $0310,Y				;$01B323	|
CODE_01B326:
	LDX.w $15E9
	LDA $01					;$01B329	|
	BEQ CODE_01B344				;$01B32B	|
	LDA.b #$EA				;$01B32D	|
	STA.w $0302,Y				;$01B32F	|
	LDA.b #$EB				;$01B332	|
	STA.w $0306,Y				;$01B334	|
	STA.w $030A,Y				;$01B337	|
	STA.w $030E,Y				;$01B33A	|
	LDA.b #$EC				;$01B33D	|
	STA.w $0312,Y				;$01B33F	|
	BRA CODE_01B359				;$01B342	|

CODE_01B344:
	LDA.b #$60
	STA.w $0302,Y				;$01B346	|
	LDA.b #$61				;$01B349	|
	STA.w $0306,Y				;$01B34B	|
	STA.w $030A,Y				;$01B34E	|
	STA.w $030E,Y				;$01B351	|
	LDA.b #$62				;$01B354	|
	STA.w $0312,Y				;$01B356	|
CODE_01B359:
	LDA $64
	ORA.w $15F6,X				;$01B35B	|
	STA.w $0303,Y				;$01B35E	|
	STA.w $0307,Y				;$01B361	|
	STA.w $030B,Y				;$01B364	|
	STA.w $030F,Y				;$01B367	|
	STA.w $0313,Y				;$01B36A	|
	LDA $01					;$01B36D	|
	BNE CODE_01B376				;$01B36F	|
	LDA.b #$62				;$01B371	|
	STA.w $030A,Y				;$01B373	|
CODE_01B376:
	LDA.b #$04
	LDY $01					;$01B378	|
	BNE CODE_01B37E				;$01B37A	|
	LDA.b #$02				;$01B37C	|
CODE_01B37E:
	LDY.b #$02
	JMP FinishOAMWriteRt			;$01B380	|

DiagPlatTiles:
	db $CB,$E4,$CC,$E5,$CC,$E5,$CC,$E4
	db $CB

FlyRockPlatTiles:
	db $85,$88,$86,$89,$86,$89,$86,$88
	db $85

CODE_01B395:
	JSR GetDrawInfoBnk1
	PHY					;$01B398	|
	LDY.b #$00				;$01B399	|
	LDA $9E,X				;$01B39B	|
	CMP.b #$5E				;$01B39D	|
	BNE CODE_01B3A2				;$01B39F	|
	INY					;$01B3A1	|
CODE_01B3A2:
	STY $00
	PLY					;$01B3A4	|
	LDA $D8,X				;$01B3A5	|
	SEC					;$01B3A7	|
	SBC $1C					;$01B3A8	|
	STA.w $0301,Y				;$01B3AA	|
	STA.w $0309,Y				;$01B3AD	|
	STA.w $0311,Y				;$01B3B0	|
	LDX $00					;$01B3B3	|
	BEQ CODE_01B3BD				;$01B3B5	|
	STA.w $0319,Y				;$01B3B7	|
	STA.w $0321,Y				;$01B3BA	|
CODE_01B3BD:
	CLC
	ADC.b #$10				;$01B3BE	|
	STA.w $0305,Y				;$01B3C0	|
	STA.w $030D,Y				;$01B3C3	|
	LDX $00					;$01B3C6	|
	BEQ CODE_01B3D0				;$01B3C8	|
	STA.w $0315,Y				;$01B3CA	|
	STA.w $031D,Y				;$01B3CD	|
CODE_01B3D0:
	LDA.b #$08
	LDX $00					;$01B3D2	|
	BNE CODE_01B3D8				;$01B3D4	|
	LDA.b #$04				;$01B3D6	|
CODE_01B3D8:
	STA $01
	DEC A					;$01B3DA	|
	STA $02					;$01B3DB	|
	LDX.w $15E9				;$01B3DD	|
	LDA.w $15F6,X				;$01B3E0	|
	STA $03					;$01B3E3	|
	LDA $9E,X				;$01B3E5	|
	CMP.b #$5B				;$01B3E7	|
	LDA.b #$00				;$01B3E9	|
	BCS CODE_01B3EF				;$01B3EB	|
	LDA.b #$09				;$01B3ED	|
CODE_01B3EF:
	PHA
	LDA $E4,X				;$01B3F0	|
	SEC					;$01B3F2	|
	SBC $1A					;$01B3F3	|
	PLX					;$01B3F5	|
CODE_01B3F6:
	STA.w $0300,Y
	CLC					;$01B3F9	|
	ADC.b #$08				;$01B3FA	|
	PHA					;$01B3FC	|
	LDA.w DiagPlatTiles,X			;$01B3FD	|
	STA.w $0302,Y				;$01B400	|
	LDA $64					;$01B403	|
	ORA $03					;$01B405	|
	PHX					;$01B407	|
	LDX $01					;$01B408	|
	CPX $02					;$01B40A	|
	PLX					;$01B40C	|
	BCS CODE_01B411				;$01B40D	|
	ORA.b #$40				;$01B40F	|
CODE_01B411:
	STA.w $0303,Y
	PLA					;$01B414	|
	INY					;$01B415	|
	INY					;$01B416	|
	INY					;$01B417	|
	INY					;$01B418	|
	INX					;$01B419	|
	DEC $01					;$01B41A	|
	BPL CODE_01B3F6				;$01B41C	|
	LDX.w $15E9				;$01B41E	|
	LDY.w $15EA,X				;$01B421	|
	LDA $00					;$01B424	|
	BNE CODE_01B444				;$01B426	|
	LDA $9E,X				;$01B428	|
	CMP.b #$5B				;$01B42A	|
	BCS CODE_01B43A				;$01B42C	|
	LDA.b #$85				;$01B42E	|
	STA.w $0312,Y				;$01B430	|
	LDA.b #$88				;$01B433	|
	STA.w $030E,Y				;$01B435	|
	BRA CODE_01B444				;$01B438	|

CODE_01B43A:
	LDA.b #$CB
	STA.w $0312,Y				;$01B43C	|
	LDA.b #$E4				;$01B43F	|
	STA.w $030E,Y				;$01B441	|
CODE_01B444:
	LDA.b #$08
	LDY $00					;$01B446	|
	BNE CODE_01B44C				;$01B448	|
	LDA.b #$04				;$01B44A	|
CODE_01B44C:
	JMP CODE_01B37E

InvisBlkMainRt:
	PHB
	PHK					;$01B450	|
	PLB					;$01B451	|
	JSR CODE_01B457				;$01B452	|
	PLB					;$01B455	|
	RTL					;$01B456	|

CODE_01B457:
	JSR ProcessInteract
	BCC CODE_01B4B2				;$01B45A	|
	LDA $D8,X				;$01B45C	|
	SEC					;$01B45E	|
	SBC $1C					;$01B45F	|
	STA $00					;$01B461	|
	LDA $80					;$01B463	|
	CLC					;$01B465	|
	ADC.b #$18				;$01B466	|
	CMP $00					;$01B468	|
	BPL CODE_01B4B4				;$01B46A	|
	LDA $7D					;$01B46C	|
	BMI CODE_01B4B2				;$01B46E	|
	LDA $77					;$01B470	|
	AND.b #$08				;$01B472	|
	BNE CODE_01B4B2				;$01B474	|
	LDA.b #$10				;$01B476	|
	STA $7D					;$01B478	|
	LDA.b #$01				;$01B47A	|
	STA.w $1471				;$01B47C	|
	LDA.b #$1F				;$01B47F	|
	LDY.w $187A				;$01B481	|
	BEQ CODE_01B488				;$01B484	|
	LDA.b #$2F				;$01B486	|
CODE_01B488:
	STA $01
	LDA $D8,X				;$01B48A	|
	SEC					;$01B48C	|
	SBC $01					;$01B48D	|
	STA $96					;$01B48F	|
	LDA.w $14D4,X				;$01B491	|
	SBC.b #$00				;$01B494	|
	STA $97					;$01B496	|
	LDA $77					;$01B498	|
	AND.b #$03				;$01B49A	|
	BNE CODE_01B4B0				;$01B49C	|
	LDY.b #$00				;$01B49E	|
	LDA.w $1528,X				;$01B4A0	|
	BPL CODE_01B4A6				;$01B4A3	|
	DEY					;$01B4A5	|
CODE_01B4A6:
	CLC
	ADC $94					;$01B4A7	|
	STA $94					;$01B4A9	|
	TYA					;$01B4AB	|
	ADC $95					;$01B4AC	|
	STA $95					;$01B4AE	|
CODE_01B4B0:
	SEC
	RTS					;$01B4B1	|

CODE_01B4B2:
	CLC
	RTS					;$01B4B3	|

CODE_01B4B4:
	LDA.w $190F,X
	LSR					;$01B4B7	|
	BCS CODE_01B4B2				;$01B4B8	|
	LDA.b #$00				;$01B4BA	|
	LDY $73					;$01B4BC	|
	BNE CODE_01B4C4				;$01B4BE	|
	LDY $19					;$01B4C0	|
	BNE CODE_01B4C6				;$01B4C2	|
CODE_01B4C4:
	LDA.b #$08
CODE_01B4C6:
	LDY.w $187A
	BEQ CODE_01B4CD				;$01B4C9	|
	ADC.b #$08				;$01B4CB	|
CODE_01B4CD:
	CLC
	ADC $80					;$01B4CE	|
	CMP $00					;$01B4D0	|
	BCC CODE_01B505				;$01B4D2	|
	LDA $7D					;$01B4D4	|
	BPL CODE_01B4F7				;$01B4D6	|
	LDA.b #$10				;$01B4D8	|
	STA $7D					;$01B4DA	|
	LDA $9E,X				;$01B4DC	|
	CMP.b #$83				;$01B4DE	|
	BCC CODE_01B4F2				;$01B4E0	|
CODE_01B4E2:
	LDA.b #$0F
	STA.w $1564,X				;$01B4E4	|
	LDA $C2,X				;$01B4E7	|
	BNE CODE_01B4F2				;$01B4E9	|
	INC $C2,X				;$01B4EB	|
	LDA.b #$10				;$01B4ED	|
	STA.w $1558,X				;$01B4EF	|
CODE_01B4F2:
	LDA.b #$01
	STA.w $1DF9				;$01B4F4	|
CODE_01B4F7:
	CLC
	RTS					;$01B4F8	|

DATA_01B4F9:
	db $0E,$F1,$10,$E0,$1F,$F1

DATA_01B4FF:
	db $00,$FF,$00,$FF,$00,$FF

CODE_01B505:
	JSR SubHorizPos
	LDA $9E,X				;$01B508	|
	CMP.b #$A9				;$01B50A	|
	BEQ CODE_01B520				;$01B50C	|
	CMP.b #$9C				;$01B50E	|
	BEQ CODE_01B51E				;$01B510	|
	CMP.b #$BB				;$01B512	|
	BEQ CODE_01B51E				;$01B514	|
	CMP.b #$60				;$01B516	|
	BEQ CODE_01B51E				;$01B518	|
	CMP.b #$49				;$01B51A	|
	BNE CODE_01B522				;$01B51C	|
CODE_01B51E:
	INY
	INY					;$01B51F	|
CODE_01B520:
	INY
	INY					;$01B521	|
CODE_01B522:
	LDA.w DATA_01B4F9,Y
	CLC					;$01B525	|
	ADC $E4,X				;$01B526	|
	STA $94					;$01B528	|
	LDA.w DATA_01B4FF,Y			;$01B52A	|
	ADC.w $14E0,X				;$01B52D	|
	STA $95					;$01B530	|
	STZ $7B					;$01B532	|
	CLC					;$01B534	|
	RTS					;$01B535	|

OrangePlatform:
	LDA $C2,X
	BEQ Platforms2				;$01B538	|
	JSR CODE_01B2D1				;$01B53A	|
	LDA $9D					;$01B53D	|
	BNE Return01B558			;$01B53F	|
	JSR SubSprXPosNoGrvty			;$01B541	|
	LDA.w $1491				;$01B544	|
	STA.w $1528,X				;$01B547	|
	JSR CODE_01B457				;$01B54A	|
	BCC Return01B558			;$01B54D	|
	LDA.b #$01				;$01B54F	|
	STA.w $1B9A				;$01B551	|
	LDA.b #$08				;$01B554	|
	STA $B6,X				;$01B556	|
Return01B558:
	RTS

FloatingSpikeBall:
	LDA.w $14C8,X
	CMP.b #$08				;$01B55C	|
	BEQ Platforms2				;$01B55E	|
	JMP CODE_01B666				;$01B560	|

Platforms2:
	LDA $9D
	BEQ CODE_01B56A				;$01B565	|
	JMP CODE_01B64E				;$01B567	|

CODE_01B56A:
	LDA.w $1588,X
	AND.b #$0C				;$01B56D	|
	BNE CODE_01B574				;$01B56F	|
	JSR SubSprYPosNoGrvty			;$01B571	|
CODE_01B574:
	STZ.w $1491
	LDA $9E,X				;$01B577	|
	CMP.b #$A4				;$01B579	|
	BNE CODE_01B580				;$01B57B	|
	JSR SubSprXPosNoGrvty			;$01B57D	|
CODE_01B580:
	LDA $AA,X
	CMP.b #$40				;$01B582	|
	BPL CODE_01B588				;$01B584	|
	INC $AA,X				;$01B586	|
CODE_01B588:
	LDA.w $164A,X
	BEQ CODE_01B5A6				;$01B58B	|
	LDY.b #$F8				;$01B58D	|
	LDA $9E,X				;$01B58F	|
	CMP.b #$5D				;$01B591	|
	BCC CODE_01B597				;$01B593	|
	LDY.b #$FC				;$01B595	|
CODE_01B597:
	STY $00
	LDA $AA,X				;$01B599	|
	BPL CODE_01B5A1				;$01B59B	|
	CMP $00					;$01B59D	|
	BCC CODE_01B5A6				;$01B59F	|
CODE_01B5A1:
	SEC
	SBC.b #$02				;$01B5A2	|
	STA $AA,X				;$01B5A4	|
CODE_01B5A6:
	LDA $7D
	PHA					;$01B5A8	|
	LDA $9E,X				;$01B5A9	|
	CMP.b #$A4				;$01B5AB	|
	BNE CODE_01B5B5				;$01B5AD	|
	JSR MarioSprInteractRt			;$01B5AF	|
	CLC					;$01B5B2	|
	BRA CODE_01B5B8				;$01B5B3	|

CODE_01B5B5:
	JSR CODE_01B457
CODE_01B5B8:
	PLA
	STA $00					;$01B5B9	|
	STZ.w $185E				;$01B5BB	|
	BCC CODE_01B5E7				;$01B5BE	|
	LDA $9E,X				;$01B5C0	|
	CMP.b #$5D				;$01B5C2	|
	BCC CODE_01B5DA				;$01B5C4	|
	LDY.b #$03				;$01B5C6	|
	LDA $19					;$01B5C8	|
	BNE CODE_01B5CD				;$01B5CA	|
	DEY					;$01B5CC	|
CODE_01B5CD:
	STY $00
	LDA $AA,X				;$01B5CF	|
	CMP $00					;$01B5D1	|
	BPL CODE_01B5DA				;$01B5D3	|
	CLC					;$01B5D5	|
	ADC.b #$02				;$01B5D6	|
	STA $AA,X				;$01B5D8	|
CODE_01B5DA:
	INC.w $185E
	LDA $00					;$01B5DD	|
	CMP.b #$20				;$01B5DF	|
	BCC CODE_01B5E7				;$01B5E1	|
	LSR					;$01B5E3	|
	LSR					;$01B5E4	|
	STA $AA,X				;$01B5E5	|
CODE_01B5E7:
	LDA.w $185E
	CMP.w $151C,X				;$01B5EA	|
	STA.w $151C,X				;$01B5ED	|
	BEQ CODE_01B610				;$01B5F0	|
	LDA.w $185E				;$01B5F2	|
	BNE CODE_01B610				;$01B5F5	|
	LDA $7D					;$01B5F7	|
	BPL CODE_01B610				;$01B5F9	|
	LDY.b #$08				;$01B5FB	|
	LDA $19					;$01B5FD	|
	BNE CODE_01B603				;$01B5FF	|
	LDY.b #$06				;$01B601	|
CODE_01B603:
	STY $00
	LDA $AA,X				;$01B605	|
	CMP.b #$20				;$01B607	|
	BPL CODE_01B610				;$01B609	|
	CLC					;$01B60B	|
	ADC $00					;$01B60C	|
	STA $AA,X				;$01B60E	|
CODE_01B610:
	LDA.b #$01
	AND $13					;$01B612	|
	BNE CODE_01B64E				;$01B614	|
	LDA $AA,X				;$01B616	|
	BEQ CODE_01B624				;$01B618	|
	BPL CODE_01B61F				;$01B61A	|
	CLC					;$01B61C	|
	ADC.b #$02				;$01B61D	|
CODE_01B61F:
	SEC
	SBC.b #$01				;$01B620	|
	STA $AA,X				;$01B622	|
CODE_01B624:
	LDY.w $185E
	BEQ CODE_01B631				;$01B627	|
	LDY.b #$05				;$01B629	|
	LDA $19					;$01B62B	|
	BNE CODE_01B631				;$01B62D	|
	LDY.b #$02				;$01B62F	|
CODE_01B631:
	STY $00
	LDA $D8,X				;$01B633	|
	PHA					;$01B635	|
	SEC					;$01B636	|
	SBC $00					;$01B637	|
	STA $D8,X				;$01B639	|
	LDA.w $14D4,X				;$01B63B	|
	PHA					;$01B63E	|
	SBC.b #$00				;$01B63F	|
	STA.w $14D4,X				;$01B641	|
	JSR CODE_019140				;$01B644	|
	PLA					;$01B647	|
	STA.w $14D4,X				;$01B648	|
	PLA					;$01B64B	|
	STA $D8,X				;$01B64C	|
CODE_01B64E:
	JSR SubOffscreen0Bnk1
	LDA $9E,X				;$01B651	|
	CMP.b #$A4				;$01B653	|
	BEQ CODE_01B666				;$01B655	|
	JMP CODE_01B2D1				;$01B657	|

DATA_01B65A:
	db $F8,$08,$F8,$08

DATA_01B65E:
	db $F8,$F8,$08,$08

FloatMineGfxProp:
	db $31,$71,$A1,$F1

CODE_01B666:
	JSR GetDrawInfoBnk1
	PHX					;$01B669	|
	LDX.b #$03				;$01B66A	|
CODE_01B66C:
	LDA $00
	CLC					;$01B66E	|
	ADC.w DATA_01B65A,X			;$01B66F	|
	STA.w $0300,Y				;$01B672	|
	LDA $01					;$01B675	|
	CLC					;$01B677	|
	ADC.w DATA_01B65E,X			;$01B678	|
	STA.w $0301,Y				;$01B67B	|
	LDA $14					;$01B67E	|
	LSR					;$01B680	|
	LSR					;$01B681	|
	AND.b #$04				;$01B682	|
	LSR					;$01B684	|
	ADC.b #$AA				;$01B685	|
	STA.w $0302,Y				;$01B687	|
	LDA.w FloatMineGfxProp,X		;$01B68A	|
	STA.w $0303,Y				;$01B68D	|
	INY					;$01B690	|
	INY					;$01B691	|
	INY					;$01B692	|
	INY					;$01B693	|
	DEX					;$01B694	|
	BPL CODE_01B66C				;$01B695	|
	PLX					;$01B697	|
	LDY.b #$02				;$01B698	|
	LDA.b #$03				;$01B69A	|
	JMP FinishOAMWriteRt			;$01B69C	|

BlkBridgeLength:
	db $20,$00

TurnBlkBridgeSpeed:
	db $01,$FF

BlkBridgeTiming:
	db $40,$40

TurnBlockBridge:
	JSR SubOffscreen0Bnk1
	JSR CODE_01B710				;$01B6A8	|
	JSR CODE_01B852				;$01B6AB	|
	JSR CODE_01B6B2				;$01B6AE	|
	RTS					;$01B6B1	|

CODE_01B6B2:
	LDA $C2,X
	AND.b #$01				;$01B6B4	|
	TAY					;$01B6B6	|
	LDA.w $151C,X				;$01B6B7	|
	CMP.w BlkBridgeLength,Y			;$01B6BA	|
	BEQ CODE_01B6D1				;$01B6BD	|
	LDA.w $1540,X				;$01B6BF	|
	ORA $9D					;$01B6C2	|
	BNE Return01B6D0			;$01B6C4	|
	LDA.w $151C,X				;$01B6C6	|
	CLC					;$01B6C9	|
	ADC.w TurnBlkBridgeSpeed,Y		;$01B6CA	|
	STA.w $151C,X				;$01B6CD	|
Return01B6D0:
	RTS

CODE_01B6D1:
	LDA.w BlkBridgeTiming,Y
	STA.w $1540,X				;$01B6D4	|
	INC $C2,X				;$01B6D7	|
	RTS					;$01B6D9	|

HorzTurnBlkBridge:
	JSR SubOffscreen0Bnk1
	JSR CODE_01B710				;$01B6DD	|
	JSR CODE_01B852				;$01B6E0	|
	JSR CODE_01B6E7				;$01B6E3	|
	RTS					;$01B6E6	|

CODE_01B6E7:
	LDY $C2,X
	LDA.w $151C,X				;$01B6E9	|
	CMP.w BlkBridgeLength,Y			;$01B6EC	|
	BEQ CODE_01B703				;$01B6EF	|
	LDA.w $1540,X				;$01B6F1	|
	ORA $9D					;$01B6F4	|
	BNE Return01B702			;$01B6F6	|
	LDA.w $151C,X				;$01B6F8	|
	CLC					;$01B6FB	|
	ADC.w TurnBlkBridgeSpeed,Y		;$01B6FC	|
	STA.w $151C,X				;$01B6FF	|
Return01B702:
	RTS

CODE_01B703:
	LDA.w BlkBridgeTiming,Y
	STA.w $1540,X				;$01B706	|
	LDA $C2,X				;$01B709	|
	EOR.b #$01				;$01B70B	|
	STA $C2,X				;$01B70D	|
	RTS					;$01B70F	|

CODE_01B710:
	JSR GetDrawInfoBnk1
	STZ $00					;$01B713	|
	STZ $01					;$01B715	|
	STZ $02					;$01B717	|
	STZ $03					;$01B719	|
	LDA $C2,X				;$01B71B	|
	AND.b #$02				;$01B71D	|
	TAY					;$01B71F	|
	LDA.w $151C,X				;$01B720	|
	STA.w $0000,Y				;$01B723	|
	LSR					;$01B726	|
	STA.w $0001,Y				;$01B727	|
	LDY.w $15EA,X				;$01B72A	|
	LDA $D8,X				;$01B72D	|
	SEC					;$01B72F	|
	SBC $1C					;$01B730	|
	STA.w $0311,Y				;$01B732	|
	PHA					;$01B735	|
	PHA					;$01B736	|
	PHA					;$01B737	|
	SEC					;$01B738	|
	SBC $02					;$01B739	|
	STA.w $0309,Y				;$01B73B	|
	PLA					;$01B73E	|
	SEC					;$01B73F	|
	SBC $03					;$01B740	|
	STA.w $030D,Y				;$01B742	|
	PLA					;$01B745	|
	CLC					;$01B746	|
	ADC $02					;$01B747	|
	STA.w $0301,Y				;$01B749	|
	PLA					;$01B74C	|
	CLC					;$01B74D	|
	ADC $03					;$01B74E	|
	STA.w $0305,Y				;$01B750	|
	LDA $E4,X				;$01B753	|
	SEC					;$01B755	|
	SBC $1A					;$01B756	|
	STA.w $0310,Y				;$01B758	|
	PHA					;$01B75B	|
	PHA					;$01B75C	|
	PHA					;$01B75D	|
	SEC					;$01B75E	|
	SBC $00					;$01B75F	|
	STA.w $0308,Y				;$01B761	|
	PLA					;$01B764	|
	SEC					;$01B765	|
	SBC $01					;$01B766	|
	STA.w $030C,Y				;$01B768	|
	PLA					;$01B76B	|
	CLC					;$01B76C	|
	ADC $00					;$01B76D	|
	STA.w $0300,Y				;$01B76F	|
	PLA					;$01B772	|
	CLC					;$01B773	|
	ADC $01					;$01B774	|
	STA.w $0304,Y				;$01B776	|
	LDA $C2,X				;$01B779	|
	LSR					;$01B77B	|
	LSR					;$01B77C	|
	LDA.b #$40				;$01B77D	|
	STA.w $0306,Y				;$01B77F	|
	STA.w $030E,Y				;$01B782	|
	STA.w $0312,Y				;$01B785	|
	STA.w $030A,Y				;$01B788	|
	STA.w $0302,Y				;$01B78B	|
	LDA $64					;$01B78E	|
	STA.w $030F,Y				;$01B790	|
	STA.w $0307,Y				;$01B793	|
	STA.w $030B,Y				;$01B796	|
	STA.w $0313,Y				;$01B799	|
	ORA.b #$60				;$01B79C	|
	STA.w $0303,Y				;$01B79E	|
	LDA $00					;$01B7A1	|
	PHA					;$01B7A3	|
	LDA $02					;$01B7A4	|
	PHA					;$01B7A6	|
	LDA.b #$04				;$01B7A7	|
	JSR CODE_01B37E				;$01B7A9	|
	PLA					;$01B7AC	|
	STA $02					;$01B7AD	|
	PLA					;$01B7AF	|
	STA $00					;$01B7B0	|
	RTS					;$01B7B2	|

FinishOAMWrite:
	PHB
	PHK					;$01B7B4	|
	PLB					;$01B7B5	|
	JSR FinishOAMWriteRt			;$01B7B6	|
	PLB					;$01B7B9	|
	RTL					;$01B7BA	|

FinishOAMWriteRt:
	STY $0B
	STA $08					;$01B7BD	|
	LDY.w $15EA,X				;$01B7BF	|
	LDA $D8,X				;$01B7C2	|
	STA $00					;$01B7C4	|
	SEC					;$01B7C6	|
	SBC $1C					;$01B7C7	|
	STA $06					;$01B7C9	|
	LDA.w $14D4,X				;$01B7CB	|
	STA $01					;$01B7CE	|
	LDA $E4,X				;$01B7D0	|
	STA $02					;$01B7D2	|
	SEC					;$01B7D4	|
	SBC $1A					;$01B7D5	|
	STA $07					;$01B7D7	|
	LDA.w $14E0,X				;$01B7D9	|
	STA $03					;$01B7DC	|
CODE_01B7DE:
	TYA
	LSR					;$01B7DF	|
	LSR					;$01B7E0	|
	TAX					;$01B7E1	|
	LDA $0B					;$01B7E2	|
	BPL CODE_01B7F0				;$01B7E4	|
	LDA.w $0460,X				;$01B7E6	|
	AND.b #$02				;$01B7E9	|
	STA.w $0460,X				;$01B7EB	|
	BRA CODE_01B7F3				;$01B7EE	|

CODE_01B7F0:
	STA.w $0460,X
CODE_01B7F3:
	LDX.b #$00
	LDA.w $0300,Y				;$01B7F5	|
	SEC					;$01B7F8	|
	SBC $07					;$01B7F9	|
	BPL CODE_01B7FE				;$01B7FB	|
	DEX					;$01B7FD	|
CODE_01B7FE:
	CLC
	ADC $02					;$01B7FF	|
	STA $04					;$01B801	|
	TXA					;$01B803	|
	ADC $03					;$01B804	|
	STA $05					;$01B806	|
	JSR CODE_01B844				;$01B808	|
	BCC CODE_01B819				;$01B80B	|
	TYA					;$01B80D	|
	LSR					;$01B80E	|
	LSR					;$01B80F	|
	TAX					;$01B810	|
	LDA.w $0460,X				;$01B811	|
	ORA.b #$01				;$01B814	|
	STA.w $0460,X				;$01B816	|
CODE_01B819:
	LDX.b #$00
	LDA.w $0301,Y				;$01B81B	|
	SEC					;$01B81E	|
	SBC $06					;$01B81F	|
	BPL CODE_01B824				;$01B821	|
	DEX					;$01B823	|
CODE_01B824:
	CLC
	ADC $00					;$01B825	|
	STA $09					;$01B827	|
	TXA					;$01B829	|
	ADC $01					;$01B82A	|
	STA $0A					;$01B82C	|
	JSR CODE_01C9BF				;$01B82E	|
	BCC CODE_01B838				;$01B831	|
	LDA.b #$F0				;$01B833	|
	STA.w $0301,Y				;$01B835	|
CODE_01B838:
	INY
	INY					;$01B839	|
	INY					;$01B83A	|
	INY					;$01B83B	|
	DEC $08					;$01B83C	|
	BPL CODE_01B7DE				;$01B83E	|
	LDX.w $15E9				;$01B840	|
	RTS					;$01B843	|

CODE_01B844:
	REP #$20
	LDA $04					;$01B846	|
	SEC					;$01B848	|
	SBC $1A					;$01B849	|
	CMP.w #$0100				;$01B84B	|
	SEP #$20				;$01B84E	|
	RTS					;$01B850	|

	RTS					;$01B851	|

CODE_01B852:
	LDA.w $15C4,X
	BNE Return01B8B1			;$01B855	|
	LDA $71					;$01B857	|
	CMP.b #$01				;$01B859	|
	BCS Return01B8B1			;$01B85B	|
	JSR CODE_01B8FF				;$01B85D	|
	BCC Return01B8B1			;$01B860	|
	LDA $D8,X				;$01B862	|
	SEC					;$01B864	|
	SBC $1C					;$01B865	|
	STA $02					;$01B867	|
	SEC					;$01B869	|
	SBC $0D					;$01B86A	|
	STA $09					;$01B86C	|
	LDA $80					;$01B86E	|
	CLC					;$01B870	|
	ADC.b #$18				;$01B871	|
	CMP $09					;$01B873	|
	BCS ADDR_01B8B2				;$01B875	|
	LDA $7D					;$01B877	|
	BMI Return01B8B1			;$01B879	|
	STZ $7D					;$01B87B	|
	LDA.b #$01				;$01B87D	|
	STA.w $1471				;$01B87F	|
	LDA $0D					;$01B882	|
	CLC					;$01B884	|
	ADC.b #$1F				;$01B885	|
	LDY.w $187A				;$01B887	|
	BEQ CODE_01B88F				;$01B88A	|
	CLC					;$01B88C	|
	ADC.b #$10				;$01B88D	|
CODE_01B88F:
	STA $00
	LDA $D8,X				;$01B891	|
	SEC					;$01B893	|
	SBC $00					;$01B894	|
	STA $96					;$01B896	|
	LDA.w $14D4,X				;$01B898	|
	SBC.b #$00				;$01B89B	|
	STA $97					;$01B89D	|
	LDY.b #$00				;$01B89F	|
	LDA.w $1491				;$01B8A1	|
	BPL CODE_01B8A7				;$01B8A4	|
	DEY					;$01B8A6	|
CODE_01B8A7:
	CLC
	ADC $94					;$01B8A8	|
	STA $94					;$01B8AA	|
	TYA					;$01B8AC	|
	ADC $95					;$01B8AD	|
	STA $95					;$01B8AF	|
Return01B8B1:
	RTS

ADDR_01B8B2:
	LDA $02
	CLC					;$01B8B4	|
	ADC $0D					;$01B8B5	|
	STA $02					;$01B8B7	|
	LDA.b #$FF				;$01B8B9	|
	LDY $73					;$01B8BB	|
	BNE ADDR_01B8C3				;$01B8BD	|
	LDY $19					;$01B8BF	|
	BNE ADDR_01B8C5				;$01B8C1	|
ADDR_01B8C3:
	LDA.b #$08
ADDR_01B8C5:
	CLC
	ADC $80					;$01B8C6	|
	CMP $02					;$01B8C8	|
	BCC ADDR_01B8D5				;$01B8CA	|
	LDA $7D					;$01B8CC	|
	BPL Return01B8D4			;$01B8CE	|
	LDA.b #$10				;$01B8D0	|
	STA $7D					;$01B8D2	|
Return01B8D4:
	RTS

ADDR_01B8D5:
	LDA $0E
	CLC					;$01B8D7	|
	ADC.b #$10				;$01B8D8	|
	STA $00					;$01B8DA	|
	LDY.b #$00				;$01B8DC	|
	LDA $E4,X				;$01B8DE	|
	SEC					;$01B8E0	|
	SBC $1A					;$01B8E1	|
	CMP $7E					;$01B8E3	|
	BCC ADDR_01B8EF				;$01B8E5	|
	LDA $00					;$01B8E7	|
	EOR.b #$FF				;$01B8E9	|
	INC A					;$01B8EB	|
	STA $00					;$01B8EC	|
	DEY					;$01B8EE	|
ADDR_01B8EF:
	LDA $E4,X
	CLC					;$01B8F1	|
	ADC $00					;$01B8F2	|
	STA $94					;$01B8F4	|
	TYA					;$01B8F6	|
	ADC.w $14E0,X				;$01B8F7	|
	STA $95					;$01B8FA	|
	STZ $7B					;$01B8FC	|
	RTS					;$01B8FE	|

CODE_01B8FF:
	LDA $00
	STA $0E					;$01B901	|
	LDA $02					;$01B903	|
	STA $0D					;$01B905	|
	LDA $E4,X				;$01B907	|
	SEC					;$01B909	|
	SBC $00					;$01B90A	|
	STA $04					;$01B90C	|
	LDA.w $14E0,X				;$01B90E	|
	SBC.b #$00				;$01B911	|
	STA $0A					;$01B913	|
	LDA $00					;$01B915	|
	ASL					;$01B917	|
	CLC					;$01B918	|
	ADC.b #$10				;$01B919	|
	STA $06					;$01B91B	|
	LDA $D8,X				;$01B91D	|
	SEC					;$01B91F	|
	SBC $02					;$01B920	|
	STA $05					;$01B922	|
	LDA.w $14D4,X				;$01B924	|
	SBC.b #$00				;$01B927	|
	STA $0B					;$01B929	|
	LDA $02					;$01B92B	|
	ASL					;$01B92D	|
	CLC					;$01B92E	|
	ADC.b #$10				;$01B92F	|
	STA $07					;$01B931	|
	JSL GetMarioClipping			;$01B933	|
	JSL CheckForContact			;$01B937	|
	RTS					;$01B93B	|

HorzNetKoopaSpeed:
	db $08,$F8

InitHorzNetKoopa:
	JSR SubHorizPos
	LDA.w HorzNetKoopaSpeed,Y		;$01B941	|
	STA $B6,X				;$01B944	|
	BRA CODE_01B950				;$01B946	|

InitVertNetKoopa:
	INC $C2,X
	INC $B6,X				;$01B94A	|
	LDA.b #$F8				;$01B94C	|
	STA $AA,X				;$01B94E	|
CODE_01B950:
	LDA $E4,X
	LDY.b #$00				;$01B952	|
	AND.b #$10				;$01B954	|
	BNE CODE_01B959				;$01B956	|
	INY					;$01B958	|
CODE_01B959:
	TYA
	STA.w $1632,X				;$01B95A	|
	LDA.w $15F6,X				;$01B95D	|
	AND.b #$02				;$01B960	|
	BNE Return01B968			;$01B962	|
	ASL $B6,X				;$01B964	|
	ASL $AA,X				;$01B966	|
Return01B968:
	RTS

DATA_01B969:
	db $02,$02,$03,$04,$03,$02,$02,$02
	db $01,$02

DATA_01B973:
	db $01,$01,$00,$00,$00,$01,$01,$01
	db $01,$01

DATA_01B97D:
	db $03,$0C

ClimbingKoopa:
	LDA.w $1540,X
	BEQ CODE_01B9FB				;$01B982	|
	CMP.b #$30				;$01B984	|
	BCC CODE_01B9A0				;$01B986	|
	CMP.b #$40				;$01B988	|
	BCC CODE_01B9A3				;$01B98A	|
	BNE CODE_01B9A0				;$01B98C	|
	LDY $9D					;$01B98E	|
	BNE CODE_01B9A0				;$01B990	|
	LDA.w $1632,X				;$01B992	|
	EOR.b #$01				;$01B995	|
	STA.w $1632,X				;$01B997	|
	JSR FlipSpriteDir			;$01B99A	|
	JSR CODE_01BA7F				;$01B99D	|
CODE_01B9A0:
	JMP CODE_01BA37

CODE_01B9A3:
	LDY $D8,X
	PHY					;$01B9A5	|
	LDY.w $14D4,X				;$01B9A6	|
	PHY					;$01B9A9	|
	LDY.b #$00				;$01B9AA	|
	CMP.b #$38				;$01B9AC	|
	BCC CODE_01B9B1				;$01B9AE	|
	INY					;$01B9B0	|
CODE_01B9B1:
	LDA $C2,X
	BEQ CODE_01B9CC				;$01B9B3	|
	INY					;$01B9B5	|
	INY					;$01B9B6	|
	LDA $D8,X				;$01B9B7	|
	SEC					;$01B9B9	|
	SBC.b #$0C				;$01B9BA	|
	STA $D8,X				;$01B9BC	|
	LDA.w $14D4,X				;$01B9BE	|
	SBC.b #$00				;$01B9C1	|
	STA.w $14D4,X				;$01B9C3	|
	LDA.w $1632,X				;$01B9C6	|
	BEQ CODE_01B9CC				;$01B9C9	|
	INY					;$01B9CB	|
CODE_01B9CC:
	LDA.w $1EEB
	BPL CODE_01B9D6				;$01B9CF	|
	INY					;$01B9D1	|
	INY					;$01B9D2	|
	INY					;$01B9D3	|
	INY					;$01B9D4	|
	INY					;$01B9D5	|
CODE_01B9D6:
	LDA.w DATA_01B969,Y
	STA.w $1602,X				;$01B9D9	|
	LDA.w DATA_01B973,Y			;$01B9DC	|
	STA $00					;$01B9DF	|
	LDA.w $15F6,X				;$01B9E1	|
	PHA					;$01B9E4	|
	AND.b #$FE				;$01B9E5	|
	ORA $00					;$01B9E7	|
	STA.w $15F6,X				;$01B9E9	|
	JSR SubSprGfx1				;$01B9EC	|
	PLA					;$01B9EF	|
	STA.w $15F6,X				;$01B9F0	|
	PLA					;$01B9F3	|
	STA.w $14D4,X				;$01B9F4	|
	PLA					;$01B9F7	|
	STA $D8,X				;$01B9F8	|
	RTS					;$01B9FA	|

CODE_01B9FB:
	LDA $9D
	BNE CODE_01BA53				;$01B9FD	|
	JSR CODE_019140				;$01B9FF	|
	LDY $C2,X				;$01BA02	|
	LDA.w $1588,X				;$01BA04	|
	AND.w DATA_01B97D,Y			;$01BA07	|
	BEQ CODE_01BA14				;$01BA0A	|
CODE_01BA0C:
	JSR FlipSpriteDir
	JSR CODE_01BA7F				;$01BA0F	|
	BRA CODE_01BA37				;$01BA12	|

CODE_01BA14:
	LDA.w $185F
	LDY $AA,X				;$01BA17	|
	BEQ CODE_01BA27				;$01BA19	|
	BPL CODE_01BA1F				;$01BA1B	|
	BMI CODE_01BA2A				;$01BA1D	|
CODE_01BA1F:
	CMP.b #$07
	BCC CODE_01BA0C				;$01BA21	|
	CMP.b #$1D				;$01BA23	|
	BCS CODE_01BA0C				;$01BA25	|
CODE_01BA27:
	LDA.w $1860
CODE_01BA2A:
	CMP.b #$07
	BCC CODE_01BA32				;$01BA2C	|
	CMP.b #$1D				;$01BA2E	|
	BCC CODE_01BA37				;$01BA30	|
CODE_01BA32:
	LDA.b #$50
	STA.w $1540,X				;$01BA34	|
CODE_01BA37:
	LDA $9D
	BNE CODE_01BA53				;$01BA39	|
	INC.w $1570,X				;$01BA3B	|
	JSR UpdateDirection			;$01BA3E	|
	LDA $C2,X				;$01BA41	|
	BNE CODE_01BA4A				;$01BA43	|
	JSR SubSprXPosNoGrvty			;$01BA45	|
	BRA CODE_01BA4D				;$01BA48	|

CODE_01BA4A:
	JSR SubSprYPosNoGrvty
CODE_01BA4D:
	JSR MarioSprInteractRt
	JSR SubOffscreen0Bnk1			;$01BA50	|
CODE_01BA53:
	LDA.w $157C,X
	PHA					;$01BA56	|
	LDA.w $1570,X				;$01BA57	|
	AND.b #$08				;$01BA5A	|
	LSR					;$01BA5C	|
	LSR					;$01BA5D	|
	LSR					;$01BA5E	|
	STA.w $157C,X				;$01BA5F	|
	LDA $64					;$01BA62	|
	PHA					;$01BA64	|
	LDA.w $1632,X				;$01BA65	|
	STA.w $1602,X				;$01BA68	|
	LDA.w $1632,X				;$01BA6B	|
	BEQ CODE_01BA74				;$01BA6E	|
	LDA.b #$10				;$01BA70	|
	STA $64					;$01BA72	|
CODE_01BA74:
	JSR SubSprGfx1
	PLA					;$01BA77	|
	STA $64					;$01BA78	|
	PLA					;$01BA7A	|
	STA.w $157C,X				;$01BA7B	|
	RTS					;$01BA7E	|

CODE_01BA7F:
	LDA $AA,X
	EOR.b #$FF				;$01BA81	|
	INC A					;$01BA83	|
	STA $AA,X				;$01BA84	|
	RTS					;$01BA86	|

InitClimbingDoor:
	LDA $E4,X
	CLC					;$01BA89	|
	ADC.b #$08				;$01BA8A	|
	STA $E4,X				;$01BA8C	|
	LDA $D8,X				;$01BA8E	|
	ADC.b #$07				;$01BA90	|
	STA $D8,X				;$01BA92	|
	RTS					;$01BA94	|

DATA_01BA95:
	db $30,$54

DATA_01BA97:
	db $00,$01,$02,$04,$06,$09,$0C,$0D
	db $14,$0D,$0C,$09,$06,$04,$02,$01
DATA_01BAA7:
	db $00,$00,$00,$00,$00,$01,$01,$01
	db $02,$01,$01,$01,$00,$00,$00,$00
DATA_01BAB7:
	db $00,$10,$00,$00,$10,$00,$01,$11
	db $01,$05,$15,$05,$05,$15,$05,$00
	db $00,$00,$03,$13,$03

Return01BACC:
	RTS

ClimbingDoor:
	JSR SubOffscreen0Bnk1
	LDA.w $154C,X				;$01BAD0	|
	CMP.b #$01				;$01BAD3	|
	BNE CODE_01BAF5				;$01BAD5	|
	LDA.b #$0F				;$01BAD7	|
	STA.w $1DF9				;$01BAD9	|
	LDA.b #$19				;$01BADC	|
	JSL GenTileFromSpr2			;$01BADE	|
	LDA.b #$1F				;$01BAE2	|
	STA.w $1540,X				;$01BAE4	|
	STA.w $149D				;$01BAE7	|
	LDA $94					;$01BAEA	|
	SEC					;$01BAEC	|
	SBC.b #$10				;$01BAED	|
	SEC					;$01BAEF	|
	SBC $E4,X				;$01BAF0	|
	STA.w $1878				;$01BAF2	|
CODE_01BAF5:
	LDA.w $1540,X
	ORA.w $154C,X				;$01BAF8	|
	BNE CODE_01BB16				;$01BAFB	|
	JSL GetSpriteClippingA			;$01BAFD	|
	JSR CODE_01BC1D				;$01BB01	|
	JSL CheckForContact			;$01BB04	|
	BCC CODE_01BB16				;$01BB08	|
	LDA.w $149E				;$01BB0A	|
	CMP.b #$01				;$01BB0D	|
	BNE CODE_01BB16				;$01BB0F	|
	LDA.b #$06				;$01BB11	|
	STA.w $154C,X				;$01BB13	|
CODE_01BB16:
	LDA.w $1540,X
	BEQ Return01BACC			;$01BB19	|
	CMP.b #$01				;$01BB1B	|
	BNE CODE_01BB27				;$01BB1D	|
	PHA					;$01BB1F	|
	LDA.b #$1A				;$01BB20	|
	JSL GenTileFromSpr2			;$01BB22	|
	PLA					;$01BB26	|
CODE_01BB27:
	CMP.b #$10
	BNE CODE_01BB33				;$01BB29	|
	LDA.w $13F9				;$01BB2B	|
	EOR.b #$01				;$01BB2E	|
	STA.w $13F9				;$01BB30	|
CODE_01BB33:
	LDA.b #$30
	STA.w $15EA,X				;$01BB35	|
	STA $03					;$01BB38	|
	TAY					;$01BB3A	|
	LDA $E4,X				;$01BB3B	|
	SEC					;$01BB3D	|
	SBC $1A					;$01BB3E	|
	STA $00					;$01BB40	|
	LDA $D8,X				;$01BB42	|
	SEC					;$01BB44	|
	SBC $1C					;$01BB45	|
	STA $01					;$01BB47	|
	LDA.w $1540,X				;$01BB49	|
	LSR					;$01BB4C	|
	STA $02					;$01BB4D	|
	TAX					;$01BB4F	|
	LDA.w DATA_01BAA7,X			;$01BB50	|
	STA $06					;$01BB53	|
	LDA $00					;$01BB55	|
	CLC					;$01BB57	|
	ADC.w DATA_01BA97,X			;$01BB58	|
	STA.w $0300,Y				;$01BB5B	|
	STA.w $0304,Y				;$01BB5E	|
	STA.w $0308,Y				;$01BB61	|
	LDA $06					;$01BB64	|
	CMP.b #$02				;$01BB66	|
	BEQ CODE_01BB8E				;$01BB68	|
	LDA $00					;$01BB6A	|
	CLC					;$01BB6C	|
	ADC.b #$20				;$01BB6D	|
	SEC					;$01BB6F	|
	SBC.w DATA_01BA97,X			;$01BB70	|
	STA.w $030C,Y				;$01BB73	|
	STA.w $0310,Y				;$01BB76	|
	STA.w $0314,Y				;$01BB79	|
	LDA $06					;$01BB7C	|
	BNE CODE_01BB8E				;$01BB7E	|
	LDA $00					;$01BB80	|
	CLC					;$01BB82	|
	ADC.b #$10				;$01BB83	|
	STA.w $0318,Y				;$01BB85	|
	STA.w $031C,Y				;$01BB88	|
	STA.w $0320,Y				;$01BB8B	|
CODE_01BB8E:
	LDA $01
	STA.w $0301,Y				;$01BB90	|
	STA.w $030D,Y				;$01BB93	|
	STA.w $0319,Y				;$01BB96	|
	CLC					;$01BB99	|
	ADC.b #$10				;$01BB9A	|
	STA.w $0305,Y				;$01BB9C	|
	STA.w $0311,Y				;$01BB9F	|
	STA.w $031D,Y				;$01BBA2	|
	CLC					;$01BBA5	|
	ADC.b #$10				;$01BBA6	|
	STA.w $0309,Y				;$01BBA8	|
	STA.w $0315,Y				;$01BBAB	|
	STA.w $0321,Y				;$01BBAE	|
	LDA.b #$08				;$01BBB1	|
	STA $07					;$01BBB3	|
	LDA $06					;$01BBB5	|
	ASL					;$01BBB7	|
	ASL					;$01BBB8	|
	ASL					;$01BBB9	|
	ADC $06					;$01BBBA	|
	TAX					;$01BBBC	|
CODE_01BBBD:
	LDA.w DATA_01BAB7,X
	STA.w $0302,Y				;$01BBC0	|
	INY					;$01BBC3	|
	INY					;$01BBC4	|
	INY					;$01BBC5	|
	INY					;$01BBC6	|
	INX					;$01BBC7	|
	DEC $07					;$01BBC8	|
	BPL CODE_01BBBD				;$01BBCA	|
	LDY $03					;$01BBCC	|
	LDX.b #$08				;$01BBCE	|
CODE_01BBD0:
	LDA $64
	ORA.b #$09				;$01BBD2	|
	CPX.b #$06				;$01BBD4	|
	BCS CODE_01BBDA				;$01BBD6	|
	ORA.b #$40				;$01BBD8	|
CODE_01BBDA:
	CPX.b #$00
	BEQ CODE_01BBE6				;$01BBDC	|
	CPX.b #$03				;$01BBDE	|
	BEQ CODE_01BBE6				;$01BBE0	|
	CPX.b #$06				;$01BBE2	|
	BNE CODE_01BBE8				;$01BBE4	|
CODE_01BBE6:
	ORA.b #$80
CODE_01BBE8:
	STA.w $0303,Y
	INY					;$01BBEB	|
	INY					;$01BBEC	|
	INY					;$01BBED	|
	INY					;$01BBEE	|
	DEX					;$01BBEF	|
	BPL CODE_01BBD0				;$01BBF0	|
	LDA $06					;$01BBF2	|
	PHA					;$01BBF4	|
	LDX.w $15E9				;$01BBF5	|
	LDA.b #$08				;$01BBF8	|
	JSR CODE_01B37E				;$01BBFA	|
	LDY.b #$0C				;$01BBFD	|
	PLA					;$01BBFF	|
	BEQ Return01BC1C			;$01BC00	|
	CMP.b #$02				;$01BC02	|
	BNE CODE_01BC11				;$01BC04	|
	LDA.b #$03				;$01BC06	|
	STA.w $0463,Y				;$01BC08	|
	STA.w $0464,Y				;$01BC0B	|
	STA.w $0465,Y				;$01BC0E	|
CODE_01BC11:
	LDA.b #$03
	STA.w $0466,Y				;$01BC13	|
	STA.w $0467,Y				;$01BC16	|
	STA.w $0468,Y				;$01BC19	|
Return01BC1C:
	RTS

CODE_01BC1D:
	LDA $94
	STA $00					;$01BC1F	|
	LDA $96					;$01BC21	|
	STA $01					;$01BC23	|
	LDA.b #$10				;$01BC25	|
	STA $02					;$01BC27	|
	STA $03					;$01BC29	|
	LDA $95					;$01BC2B	|
	STA $08					;$01BC2D	|
	LDA $97					;$01BC2F	|
	STA $09					;$01BC31	|
	RTS					;$01BC33	|

MagiKoopasMagicPals:
	db $05,$07,$09,$0B

MagikoopasMagic:
	LDA $9D
	BEQ CODE_01BC3F				;$01BC3A	|
	JMP CODE_01BCBD				;$01BC3C	|

CODE_01BC3F:
	JSR CODE_01B14E
	JSR SubSprYPosNoGrvty			;$01BC42	|
	JSR SubSprXPosNoGrvty			;$01BC45	|
	LDA $AA,X				;$01BC48	|
	PHA					;$01BC4A	|
	LDA.b #$FF				;$01BC4B	|
	STA $AA,X				;$01BC4D	|
	JSR CODE_019140				;$01BC4F	|
	PLA					;$01BC52	|
	STA $AA,X				;$01BC53	|
	JSR IsTouchingCeiling			;$01BC55	|
	BEQ CODE_01BCBD				;$01BC58	|
	LDA.w $15A0,X				;$01BC5A	|
	BNE CODE_01BCBD				;$01BC5D	|
	LDA.b #$01				;$01BC5F	|
	STA.w $1DF9				;$01BC61	|
	STZ.w $14C8,X				;$01BC64	|
	LDA.w $185F				;$01BC67	|
	SEC					;$01BC6A	|
	SBC.b #$11				;$01BC6B	|
	CMP.b #$1D				;$01BC6D	|
	BCS CODE_01BCB9				;$01BC6F	|
	JSL GetRand				;$01BC71	|
	ADC.w $148E				;$01BC75	|
	ADC $7B					;$01BC78	|
	ADC $13					;$01BC7A	|
	LDY.b #$78				;$01BC7C	|
	CMP.b #$35				;$01BC7E	|
	BEQ StoreSpriteNum			;$01BC80	|
	LDY.b #$21				;$01BC82	|
	CMP.b #$08				;$01BC84	|
	BCC StoreSpriteNum			;$01BC86	|
	LDY.b #$27				;$01BC88	|
	CMP.b #$F7				;$01BC8A	|
	BCS StoreSpriteNum			;$01BC8C	|
	LDY.b #$07				;$01BC8E	|
StoreSpriteNum:
	STY $9E,X
	LDA.b #$08				;$01BC92	|
	STA.w $14C8,X				;$01BC94	|
	JSL InitSpriteTables			;$01BC97	|
	LDA $9B					;$01BC9B	|
	STA.w $14E0,X				;$01BC9D	|
	LDA $9A					;$01BCA0	|
	AND.b #$F0				;$01BCA2	|
	STA $E4,X				;$01BCA4	|
	LDA $99					;$01BCA6	|
	STA.w $14D4,X				;$01BCA8	|
	LDA $98					;$01BCAB	|
	AND.b #$F0				;$01BCAD	|
	STA $D8,X				;$01BCAF	|
	LDA.b #$02				;$01BCB1	|
	STA $9C					;$01BCB3	|
	JSL generate_tile			;$01BCB5	|
CODE_01BCB9:
	JSR CODE_01BD98
	RTS					;$01BCBC	|

CODE_01BCBD:
	JSR SubSprSprPMarioSpr
	LDA $13					;$01BCC0	|
	LSR					;$01BCC2	|
	LSR					;$01BCC3	|
	AND.b #$03				;$01BCC4	|
	TAY					;$01BCC6	|
	LDA.w MagiKoopasMagicPals,Y		;$01BCC7	|
	STA.w $15F6,X				;$01BCCA	|
	JSR MagiKoopasMagicGfx			;$01BCCD	|
	JSR SubOffscreen0Bnk1			;$01BCD0	|
	LDA $D8,X				;$01BCD3	|
	SEC					;$01BCD5	|
	SBC $1C					;$01BCD6	|
	CMP.b #$E0				;$01BCD8	|
	BCC Return01BCDF			;$01BCDA	|
	STZ.w $14C8,X				;$01BCDC	|
Return01BCDF:
	RTS

MagiKoopasMagicDisp:
	db $00,$01,$02,$05,$08,$0B,$0E,$0F
	db $10,$0F,$0E,$0B,$08,$05,$02,$01

MagiKoopasMagicGfx:
	JSR GetDrawInfoBnk1
	LDA $14					;$01BCF3	|
	LSR					;$01BCF5	|
	AND.b #$0F				;$01BCF6	|
	STA $03					;$01BCF8	|
	CLC					;$01BCFA	|
	ADC.b #$0C				;$01BCFB	|
	AND.b #$0F				;$01BCFD	|
	STA $02					;$01BCFF	|
	LDA $01					;$01BD01	|
	SEC					;$01BD03	|
	SBC.b #$04				;$01BD04	|
	STA $01					;$01BD06	|
	LDA $00					;$01BD08	|
	SEC					;$01BD0A	|
	SBC.b #$04				;$01BD0B	|
	STA $00					;$01BD0D	|
	LDX $02					;$01BD0F	|
	LDA $01					;$01BD11	|
	CLC					;$01BD13	|
	ADC.w MagiKoopasMagicDisp,X		;$01BD14	|
	STA.w $0301,Y				;$01BD17	|
	LDX $03					;$01BD1A	|
	LDA $00					;$01BD1C	|
	CLC					;$01BD1E	|
	ADC.w MagiKoopasMagicDisp,X		;$01BD1F	|
	STA.w $0300,Y				;$01BD22	|
	LDA $02					;$01BD25	|
	CLC					;$01BD27	|
	ADC.b #$05				;$01BD28	|
	AND.b #$0F				;$01BD2A	|
	STA $02					;$01BD2C	|
	TAX					;$01BD2E	|
	LDA $01					;$01BD2F	|
	CLC					;$01BD31	|
	ADC.w MagiKoopasMagicDisp,X		;$01BD32	|
	STA.w $0305,Y				;$01BD35	|
	LDA $03					;$01BD38	|
	CLC					;$01BD3A	|
	ADC.b #$05				;$01BD3B	|
	AND.b #$0F				;$01BD3D	|
	STA $03					;$01BD3F	|
	TAX					;$01BD41	|
	LDA $00					;$01BD42	|
	CLC					;$01BD44	|
	ADC.w MagiKoopasMagicDisp,X		;$01BD45	|
	STA.w $0304,Y				;$01BD48	|
	LDA $02					;$01BD4B	|
	CLC					;$01BD4D	|
	ADC.b #$05				;$01BD4E	|
	AND.b #$0F				;$01BD50	|
	STA $02					;$01BD52	|
	TAX					;$01BD54	|
	LDA $01					;$01BD55	|
	CLC					;$01BD57	|
	ADC.w MagiKoopasMagicDisp,X		;$01BD58	|
	STA.w $0309,Y				;$01BD5B	|
	LDA $03					;$01BD5E	|
	CLC					;$01BD60	|
	ADC.b #$05				;$01BD61	|
	AND.b #$0F				;$01BD63	|
	STA $03					;$01BD65	|
	TAX					;$01BD67	|
	LDA $00					;$01BD68	|
	CLC					;$01BD6A	|
	ADC.w MagiKoopasMagicDisp,X		;$01BD6B	|
	STA.w $0308,Y				;$01BD6E	|
	LDX.w $15E9				;$01BD71	|
	LDA.w $15F6,X				;$01BD74	|
	ORA $64					;$01BD77	|
	STA.w $0303,Y				;$01BD79	|
	STA.w $0307,Y				;$01BD7C	|
	STA.w $030B,Y				;$01BD7F	|
	LDA.b #$88				;$01BD82	|
	STA.w $0302,Y				;$01BD84	|
	LDA.b #$89				;$01BD87	|
	STA.w $0306,Y				;$01BD89	|
	LDA.b #$98				;$01BD8C	|
	STA.w $030A,Y				;$01BD8E	|
	LDY.b #$00				;$01BD91	|
	LDA.b #$02				;$01BD93	|
	JMP FinishOAMWriteRt			;$01BD95	|

CODE_01BD98:
	LDY.b #$03
CODE_01BD9A:
	LDA.w $17C0,Y
	BEQ CODE_01BDA3				;$01BD9D	|
	DEY					;$01BD9F	|
	BPL CODE_01BD9A				;$01BDA0	|
	RTS					;$01BDA2	|

CODE_01BDA3:
	LDA.b #$01
	STA.w $17C0,Y				;$01BDA5	|
	LDA $E4,X				;$01BDA8	|
	STA.w $17C8,Y				;$01BDAA	|
	LDA $D8,X				;$01BDAD	|
	STA.w $17C4,Y				;$01BDAF	|
	LDA.b #$1B				;$01BDB2	|
	STA.w $17CC,Y				;$01BDB4	|
	RTS					;$01BDB7	|

InitMagikoopa:
	LDY.b #$09
CODE_01BDBA:
	CPY.w $15E9
	BEQ CODE_01BDCF				;$01BDBD	|
	LDA.w $14C8,Y				;$01BDBF	|
	BEQ CODE_01BDCF				;$01BDC2	|
	LDA.w $009E,y				;$01BDC4	|
	CMP.b #$1F				;$01BDC7	|
	BNE CODE_01BDCF				;$01BDC9	|
	STZ.w $14C8,X				;$01BDCB	|
	RTS					;$01BDCE	|

CODE_01BDCF:
	DEY
	BPL CODE_01BDBA				;$01BDD0	|
	STZ.w $18BF				;$01BDD2	|
	RTS					;$01BDD5	|

Magikoopa:
	LDA.b #$01
	STA.w $15D0,X				;$01BDD8	|
	LDA.w $15A0,X				;$01BDDB	|
	BEQ CODE_01BDE2				;$01BDDE	|
	STZ $C2,X				;$01BDE0	|
CODE_01BDE2:
	LDA $C2,X
	AND.b #$03				;$01BDE4	|
	JSL ExecutePtr				;$01BDE6	|

MagiKoopaPtrs:
	dw CODE_01BDF2
	dw CODE_01BE5F
	dw CODE_01BE6E
	dw CODE_01BF16

CODE_01BDF2:
	LDA.w $18BF
	BEQ CODE_01BDFB				;$01BDF5	|
	STZ.w $14C8,X				;$01BDF7	|
	RTS					;$01BDFA	|

CODE_01BDFB:
	LDA $9D
	BNE Return01BE5E			;$01BDFD	|
	LDY.b #$24				;$01BDFF	|
	STY $40					;$01BE01	|
	LDA.w $1540,X				;$01BE03	|
	BNE Return01BE5E			;$01BE06	|
	JSL GetRand				;$01BE08	|
	CMP.b #$D1				;$01BE0C	|
	BCS Return01BE5E			;$01BE0E	|
	CLC					;$01BE10	|
	ADC $1C					;$01BE11	|
	AND.b #$F0				;$01BE13	|
	STA $D8,X				;$01BE15	|
	LDA $1D					;$01BE17	|
	ADC.b #$00				;$01BE19	|
	STA.w $14D4,X				;$01BE1B	|
	JSL GetRand				;$01BE1E	|
	CLC					;$01BE22	|
	ADC $1A					;$01BE23	|
	AND.b #$F0				;$01BE25	|
	STA $E4,X				;$01BE27	|
	LDA $1B					;$01BE29	|
	ADC.b #$00				;$01BE2B	|
	STA.w $14E0,X				;$01BE2D	|
	JSR SubHorizPos				;$01BE30	|
	LDA $0F					;$01BE33	|
	CLC					;$01BE35	|
	ADC.b #$20				;$01BE36	|
	CMP.b #$40				;$01BE38	|
	BCC Return01BE5E			;$01BE3A	|
	STZ $AA,X				;$01BE3C	|
	LDA.b #$01				;$01BE3E	|
	STA $B6,X				;$01BE40	|
	JSR CODE_019140				;$01BE42	|
	JSR IsOnGround				;$01BE45	|
	BEQ Return01BE5E			;$01BE48	|
	LDA.w $1862				;$01BE4A	|
	BNE Return01BE5E			;$01BE4D	|
	INC $C2,X				;$01BE4F	|
	STZ.w $1570,X				;$01BE51	|
	JSR CODE_01BE82				;$01BE54	|
	JSR SubHorizPos				;$01BE57	|
	TYA					;$01BE5A	|
	STA.w $157C,X				;$01BE5B	|
Return01BE5E:
	RTS

CODE_01BE5F:
	JSR CODE_01C004
	STZ.w $1602,X				;$01BE62	|
	JSR SubSprGfx1				;$01BE65	|
	RTS					;$01BE68	|

DATA_01BE69:
	db $04,$02,$00

DATA_01BE6C:
	db $10,$F8

CODE_01BE6E:
	STZ.w $15D0,X
	JSR SubSprSprPMarioSpr			;$01BE71	|
	JSR SubHorizPos				;$01BE74	|
	TYA					;$01BE77	|
	STA.w $157C,X				;$01BE78	|
	LDA.w $1540,X				;$01BE7B	|
	BNE CODE_01BE86				;$01BE7E	|
	INC $C2,X				;$01BE80	|
CODE_01BE82:
	LDY.b #$34
	STY $40					;$01BE84	|
CODE_01BE86:
	CMP.b #$40
	BNE CODE_01BE96				;$01BE88	|
	PHA					;$01BE8A	|
	LDA $9D					;$01BE8B	|
	ORA.w $15A0,X				;$01BE8D	|
	BNE CODE_01BE95				;$01BE90	|
	JSR CODE_01BF1D				;$01BE92	|
CODE_01BE95:
	PLA
CODE_01BE96:
	LSR
	LSR					;$01BE97	|
	LSR					;$01BE98	|
	LSR					;$01BE99	|
	LSR					;$01BE9A	|
	LSR					;$01BE9B	|
	TAY					;$01BE9C	|
	PHY					;$01BE9D	|
	LDA.w $1540,X				;$01BE9E	|
	LSR					;$01BEA1	|
	LSR					;$01BEA2	|
	LSR					;$01BEA3	|
	AND.b #$01				;$01BEA4	|
	ORA.w DATA_01BE69,Y			;$01BEA6	|
	STA.w $1602,X				;$01BEA9	|
	JSR SubSprGfx1				;$01BEAC	|
	LDA.w $1602,X				;$01BEAF	|
	SEC					;$01BEB2	|
	SBC.b #$02				;$01BEB3	|
	CMP.b #$02				;$01BEB5	|
	BCC CODE_01BEC6				;$01BEB7	|
	LSR					;$01BEB9	|
	BCC CODE_01BEC6				;$01BEBA	|
	LDA.w $15EA,X				;$01BEBC	|
	TAX					;$01BEBF	|
	INC.w $0301,X				;$01BEC0	|
	LDX.w $15E9				;$01BEC3	|
CODE_01BEC6:
	PLY
	CPY.b #$01				;$01BEC7	|
	BNE CODE_01BECE				;$01BEC9	|
	JSR CODE_01B14E				;$01BECB	|
CODE_01BECE:
	LDA.w $1602,X
	CMP.b #$04				;$01BED1	|
	BCC Return01BF15			;$01BED3	|
	LDY.w $157C,X				;$01BED5	|
	LDA $E4,X				;$01BED8	|
	CLC					;$01BEDA	|
	ADC.w DATA_01BE6C,Y			;$01BEDB	|
	SEC					;$01BEDE	|
	SBC $1A					;$01BEDF	|
	LDY.w $15EA,X				;$01BEE1	|
	STA.w $0308,Y				;$01BEE4	|
	LDA $D8,X				;$01BEE7	|
	SEC					;$01BEE9	|
	SBC $1C					;$01BEEA	|
	CLC					;$01BEEC	|
	ADC.b #$10				;$01BEED	|
	STA.w $0309,Y				;$01BEEF	|
	LDA.w $157C,X				;$01BEF2	|
	LSR					;$01BEF5	|
	LDA.b #$00				;$01BEF6	|
	BCS CODE_01BEFC				;$01BEF8	|
	ORA.b #$40				;$01BEFA	|
CODE_01BEFC:
	ORA $64
	ORA.w $15F6,X				;$01BEFE	|
	STA.w $030B,Y				;$01BF01	|
	LDA.b #$99				;$01BF04	|
	STA.w $030A,Y				;$01BF06	|
	TYA					;$01BF09	|
	LSR					;$01BF0A	|
	LSR					;$01BF0B	|
	TAY					;$01BF0C	|
	LDA.b #$00				;$01BF0D	|
	ORA.w $15A0,X				;$01BF0F	|
	STA.w $0462,Y				;$01BF12	|
Return01BF15:
	RTS

CODE_01BF16:
	JSR CODE_01BFE3
	JSR SubSprGfx1				;$01BF19	|
	RTS					;$01BF1C	|

CODE_01BF1D:
	LDY.b #$09
CODE_01BF1F:
	LDA.w $14C8,Y
	BEQ CODE_01BF28				;$01BF22	|
	DEY					;$01BF24	|
	BPL CODE_01BF1F				;$01BF25	|
	RTS					;$01BF27	|

CODE_01BF28:
	LDA.b #$10
	STA.w $1DF9				;$01BF2A	|
	LDA.b #$08				;$01BF2D	|
	STA.w $14C8,Y				;$01BF2F	|
	LDA.b #$20 				;$01BF32	|
	STA.w $009E,y				;$01BF34	|
	LDA $E4,X				;$01BF37	|
	STA.w $00E4,y				;$01BF39	|
	LDA.w $14E0,X				;$01BF3C	|
	STA.w $14E0,Y				;$01BF3F	|
	LDA $D8,X				;$01BF42	|
	CLC					;$01BF44	|
	ADC.b #$0A				;$01BF45	|
	STA.w $00D8,y				;$01BF47	|
	LDA.w $14D4,X				;$01BF4A	|
	ADC.b #$00				;$01BF4D	|
	STA.w $14D4,Y				;$01BF4F	|
	TYX					;$01BF52	|
	JSL InitSpriteTables			;$01BF53	|
	LDA.b #$20				;$01BF57	|
	JSR CODE_01BF6A				;$01BF59	|
	LDX.w $15E9				;$01BF5C	|
	LDA $00					;$01BF5F	|
	STA.w $00AA,y				;$01BF61	|
	LDA $01					;$01BF64	|
	STA.w $00B6,y				;$01BF66	|
	RTS					;$01BF69	|

CODE_01BF6A:
	STA $01
	PHX					;$01BF6C	|
	PHY					;$01BF6D	|
	JSR CODE_01AD42				;$01BF6E	|
	STY $02					;$01BF71	|
	LDA $0E					;$01BF73	|
	BPL CODE_01BF7C				;$01BF75	|
	EOR.b #$FF				;$01BF77	|
	CLC					;$01BF79	|
	ADC.b #$01				;$01BF7A	|
CODE_01BF7C:
	STA $0C
	JSR SubHorizPos				;$01BF7E	|
	STY $03					;$01BF81	|
	LDA $0F					;$01BF83	|
	BPL CODE_01BF8C				;$01BF85	|
	EOR.b #$FF				;$01BF87	|
	CLC					;$01BF89	|
	ADC.b #$01				;$01BF8A	|
CODE_01BF8C:
	STA $0D
	LDY.b #$00				;$01BF8E	|
	LDA $0D					;$01BF90	|
	CMP $0C					;$01BF92	|
	BCS CODE_01BF9F				;$01BF94	|
	INY					;$01BF96	|
	PHA					;$01BF97	|
	LDA $0C					;$01BF98	|
	STA $0D					;$01BF9A	|
	PLA					;$01BF9C	|
	STA $0C					;$01BF9D	|
CODE_01BF9F:
	LDA.b #$00
	STA $0B					;$01BFA1	|
	STA $00					;$01BFA3	|
	LDX $01					;$01BFA5	|
CODE_01BFA7:
	LDA $0B
	CLC					;$01BFA9	|
	ADC $0C					;$01BFAA	|
	CMP $0D					;$01BFAC	|
	BCC CODE_01BFB4				;$01BFAE	|
	SBC $0D					;$01BFB0	|
	INC $00					;$01BFB2	|
CODE_01BFB4:
	STA $0B
	DEX					;$01BFB6	|
	BNE CODE_01BFA7				;$01BFB7	|
	TYA					;$01BFB9	|
	BEQ CODE_01BFC6				;$01BFBA	|
	LDA $00					;$01BFBC	|
	PHA					;$01BFBE	|
	LDA $01					;$01BFBF	|
	STA $00					;$01BFC1	|
	PLA					;$01BFC3	|
	STA $01					;$01BFC4	|
CODE_01BFC6:
	LDA $00
	LDY $02					;$01BFC8	|
	BEQ CODE_01BFD3				;$01BFCA	|
	EOR.b #$FF				;$01BFCC	|
	CLC					;$01BFCE	|
	ADC.b #$01				;$01BFCF	|
	STA $00					;$01BFD1	|
CODE_01BFD3:
	LDA $01
	LDY $03					;$01BFD5	|
	BEQ CODE_01BFE0				;$01BFD7	|
	EOR.b #$FF				;$01BFD9	|
	CLC					;$01BFDB	|
	ADC.b #$01				;$01BFDC	|
	STA $01					;$01BFDE	|
CODE_01BFE0:
	PLY
	PLX					;$01BFE1	|
	RTS					;$01BFE2	|

CODE_01BFE3:
	LDA.w $1540,X
	BNE Return01C000			;$01BFE6	|
	LDA.b #$02				;$01BFE8	|
	STA.w $1540,X				;$01BFEA	|
	DEC.w $1570,X				;$01BFED	|
	LDA.w $1570,X				;$01BFF0	|
	CMP.b #$00				;$01BFF3	|
	BNE CODE_01C001				;$01BFF5	|
	INC $C2,X				;$01BFF7	|
	LDA.b #$10				;$01BFF9	|
	STA.w $1540,X				;$01BFFB	|
	PLA					;$01BFFE	|
	PLA					;$01BFFF	|
Return01C000:
	RTS

CODE_01C001:
	JMP CODE_01C028

CODE_01C004:
	LDA.w $1540,X
	BNE CODE_01C05E				;$01C007	|
	LDA.b #$04				;$01C009	|
	STA.w $1540,X				;$01C00B	|
	INC.w $1570,X				;$01C00E	|
	LDA.w $1570,X				;$01C011	|
	CMP.b #$09				;$01C014	|
	BNE CODE_01C01C				;$01C016	|
	LDY.b #$24				;$01C018	|
	STY $40					;$01C01A	|
CODE_01C01C:
	CMP.b #$09
	BNE CODE_01C028				;$01C01E	|
	INC $C2,X				;$01C020	|
	LDA.b #$70				;$01C022	|
	STA.w $1540,X				;$01C024	|
	RTS					;$01C027	|

CODE_01C028:
	LDA.w $1570,X
	DEC A					;$01C02B	|
	ASL					;$01C02C	|
	ASL					;$01C02D	|
	ASL					;$01C02E	|
	ASL					;$01C02F	|
	TAX					;$01C030	|
	STZ $00					;$01C031	|
	LDY.w $0681				;$01C033	|
CODE_01C036:
	LDA.l MagiKoopaPals,X
	STA.w $0684,Y				;$01C03A	|
	INY					;$01C03D	|
	INX					;$01C03E	|
	INC $00					;$01C03F	|
	LDA $00					;$01C041	|
	CMP.b #$10				;$01C043	|
	BNE CODE_01C036				;$01C045	|
	LDX.w $0681				;$01C047	|
	LDA.b #$10				;$01C04A	|
	STA.w $0682,X				;$01C04C	|
	LDA.b #$F0				;$01C04F	|
	STA.w $0683,X				;$01C051	|
	STZ.w $0694,X				;$01C054	|
	TXA					;$01C057	|
	CLC					;$01C058	|
	ADC.b #$12				;$01C059	|
	STA.w $0681				;$01C05B	|
CODE_01C05E:
	LDX.w $15E9
	RTS					;$01C061	|

	JSR InitGoalTape			;$01C062	|
	LDA $D8,X				;$01C065	|
	SEC					;$01C067	|
	SBC.b #$4C				;$01C068	|
	STA $D8,X				;$01C06A	|
	LDA.w $14D4,X				;$01C06C	|
	SBC.b #$00				;$01C06F	|
	STA.w $14D4,X				;$01C071	|
	RTS					;$01C074	|

InitGoalTape:
	LDA $E4,X
	SEC					;$01C077	|
	SBC.b #$08				;$01C078	|
	STA $C2,X				;$01C07A	|
	LDA.w $14E0,X				;$01C07C	|
	SBC.b #$00				;$01C07F	|
	STA.w $151C,X				;$01C081	|
	LDA $D8,X				;$01C084	|
	STA.w $1528,X				;$01C086	|
	LDA.w $14D4,X				;$01C089	|
	STA.w $187B,X				;$01C08C	|
	AND.b #$01				;$01C08F	|
	STA.w $14D4,X				;$01C091	|
	STA.w $1534,X				;$01C094	|
	RTS					;$01C097	|

GoalTape:
	JSR CODE_01C12D
	LDA $9D					;$01C09B	|
	BNE Return01C0A4			;$01C09D	|
	LDA.w $1602,X				;$01C09F	|
	BEQ CODE_01C0A7				;$01C0A2	|
Return01C0A4:
	RTS

DATA_01C0A5:
	db $10,$F0

CODE_01C0A7:
	LDA.w $1540,X
	BNE CODE_01C0B4				;$01C0AA	|
	LDA.b #$7C				;$01C0AC	|
	STA.w $1540,X				;$01C0AE	|
	INC.w $1588,X				;$01C0B1	|
CODE_01C0B4:
	LDA.w $1588,X
	AND.b #$01				;$01C0B7	|
	TAY					;$01C0B9	|
	LDA.w DATA_01C0A5,Y			;$01C0BA	|
	STA $AA,X				;$01C0BD	|
	JSR SubSprYPosNoGrvty			;$01C0BF	|
	LDA $C2,X				;$01C0C2	|
	STA $00					;$01C0C4	|
	LDA.w $151C,X				;$01C0C6	|
	STA $01					;$01C0C9	|
	REP #$20				;$01C0CB	|
	LDA $94					;$01C0CD	|
	SEC					;$01C0CF	|
	SBC $00					;$01C0D0	|
	CMP.w #$0010				;$01C0D2	|
	SEP #$20				;$01C0D5	|
	BCS Return01C12C			;$01C0D7	|
	LDA.w $1528,X				;$01C0D9	|
	CMP $96					;$01C0DC	|
	LDA.w $1534,X				;$01C0DE	|
	AND.b #$01				;$01C0E1	|
	SBC $97					;$01C0E3	|
	BCC Return01C12C			;$01C0E5	|
	LDA.w $187B,X				;$01C0E7	|
	LSR					;$01C0EA	|
	LSR					;$01C0EB	|
	STA.w $141C				;$01C0EC	|
	LDA.b #$0C				;$01C0EF	|
	STA.w $1DFB				;$01C0F1	|
	LDA.b #$FF				;$01C0F4	|
	STA.w $0DDA				;$01C0F6	|
	LDA.b #$FF				;$01C0F9	|
	STA.w $1493				;$01C0FB	|
	STZ.w $1490				;$01C0FE	|
	INC.w $1602,X				;$01C101	|
	JSR MarioSprInteractRt			;$01C104	|
	BCC CODE_01C125				;$01C107	|
	LDA.b #$09				;$01C109	|
	STA.w $1DFC				;$01C10B	|
	INC.w $160E,X				;$01C10E	|
	LDA.w $1528,X				;$01C111	|
	SEC					;$01C114	|
	SBC $D8,X				;$01C115	|
	STA.w $1594,X				;$01C117	|
	LDA.b #$80				;$01C11A	|
	STA.w $1540,X				;$01C11C	|
	JSL CODE_07F252				;$01C11F	|
	BRA CODE_01C128				;$01C123	|

CODE_01C125:
	STZ.w $1686,X
CODE_01C128:
	JSL TriggerGoalTape
Return01C12C:
	RTS

CODE_01C12D:
	LDA.w $160E,X
	BNE CODE_01C175				;$01C130	|
	JSR GetDrawInfoBnk1			;$01C132	|
	LDA $00					;$01C135	|
	SEC					;$01C137	|
	SBC.b #$08				;$01C138	|
	STA.w $0300,Y				;$01C13A	|
	CLC					;$01C13D	|
	ADC.b #$08				;$01C13E	|
	STA.w $0304,Y				;$01C140	|
	CLC					;$01C143	|
	ADC.b #$08				;$01C144	|
	STA.w $0308,Y				;$01C146	|
	LDA $01					;$01C149	|
	CLC					;$01C14B	|
	ADC.b #$08				;$01C14C	|
	STA.w $0301,Y				;$01C14E	|
	STA.w $0305,Y				;$01C151	|
	STA.w $0309,Y				;$01C154	|
	LDA.b #$D4				;$01C157	|
	STA.w $0302,Y				;$01C159	|
	INC A					;$01C15C	|
	STA.w $0306,Y				;$01C15D	|
	STA.w $030A,Y				;$01C160	|
	LDA.b #$32				;$01C163	|
	STA.w $0303,Y				;$01C165	|
	STA.w $0307,Y				;$01C168	|
	STA.w $030B,Y				;$01C16B	|
	LDY.b #$00				;$01C16E	|
	LDA.b #$02				;$01C170	|
	JMP FinishOAMWriteRt			;$01C172	|

CODE_01C175:
	LDA.w $1540,X
	BEQ CODE_01C17F				;$01C178	|
	JSL CODE_07F1CA				;$01C17A	|
	RTS					;$01C17E	|

CODE_01C17F:
	STZ.w $14C8,X
	RTS					;$01C182	|

GrowingVine:
	LDA $64
	PHA					;$01C185	|
	LDA.w $1540,X				;$01C186	|
	CMP.b #$20				;$01C189	|
	BCC CODE_01C191				;$01C18B	|
	LDA.b #$10				;$01C18D	|
	STA $64					;$01C18F	|
CODE_01C191:
	JSR SubSprGfx2Entry1
	LDY.w $15EA,X				;$01C194	|
	LDA $14					;$01C197	|
	LSR					;$01C199	|
	LSR					;$01C19A	|
	LSR					;$01C19B	|
	LSR					;$01C19C	|
	LDA.b #$AC				;$01C19D	|
	BCC CODE_01C1A3				;$01C19F	|
	LDA.b #$AE				;$01C1A1	|
CODE_01C1A3:
	STA.w $0302,Y
	PLA					;$01C1A6	|
	STA $64					;$01C1A7	|
	LDA $9D					;$01C1A9	|
	BNE Return01C1ED			;$01C1AB	|
	LDA.b #$F0				;$01C1AD	|
	STA $AA,X				;$01C1AF	|
	JSR SubSprYPosNoGrvty			;$01C1B1	|
	LDA.w $1540,X				;$01C1B4	|
	CMP.b #$20				;$01C1B7	|
	BCS CODE_01C1CB				;$01C1B9	|
	JSR CODE_019140				;$01C1BB	|
	LDA.w $1588,X				;$01C1BE	|
	BNE CODE_01C1C8				;$01C1C1	|
	LDA.w $14D4,X				;$01C1C3	|
	BPL CODE_01C1CB				;$01C1C6	|
CODE_01C1C8:
	JMP OffScrEraseSprite

CODE_01C1CB:
	LDA $D8,X
	AND.b #$0F				;$01C1CD	|
	CMP.b #$00				;$01C1CF	|
	BNE Return01C1ED			;$01C1D1	|
	LDA $E4,X				;$01C1D3	|
	STA $9A					;$01C1D5	|
	LDA.w $14E0,X				;$01C1D7	|
	STA $9B					;$01C1DA	|
	LDA $D8,X				;$01C1DC	|
	STA $98					;$01C1DE	|
	LDA.w $14D4,X				;$01C1E0	|
	STA $99					;$01C1E3	|
	LDA.b #$03				;$01C1E5	|
	STA $9C					;$01C1E7	|
	JSL generate_tile			;$01C1E9	|
Return01C1ED:
	RTS

DATA_01C1EE:
	db $FF,$01

DATA_01C1F0:
	db $F0,$10

BalloonKeyFlyObjs:
	LDA.w $14C8,X
	CMP.b #$0C				;$01C1F5	|
	BEQ CODE_01C255				;$01C1F7	|
	LDA $9D					;$01C1F9	|
	BNE CODE_01C255				;$01C1FB	|
	LDA $9E,X				;$01C1FD	|
	CMP.b #$7D				;$01C1FF	|
	BNE CODE_01C21D				;$01C201	|
	LDA.w $1540,X				;$01C203	|
	BEQ CODE_01C21D				;$01C206	|
	LDA $64					;$01C208	|
	PHA					;$01C20A	|
	LDA.b #$10				;$01C20B	|
	STA $64					;$01C20D	|
	JSR CODE_01C61A				;$01C20F	|
	PLA					;$01C212	|
	STA $64					;$01C213	|
	LDA.b #$F8				;$01C215	|
	STA $AA,X				;$01C217	|
	JSR SubSprYPosNoGrvty			;$01C219	|
	RTS					;$01C21C	|

CODE_01C21D:
	LDA $13
	AND.b #$01				;$01C21F	|
	BNE CODE_01C239				;$01C221	|
	LDA.w $151C,X				;$01C223	|
	AND.b #$01				;$01C226	|
	TAY					;$01C228	|
	LDA $AA,X				;$01C229	|
	CLC					;$01C22B	|
	ADC.w DATA_01C1EE,Y			;$01C22C	|
	STA $AA,X				;$01C22F	|
	CMP.w DATA_01C1F0,Y			;$01C231	|
	BNE CODE_01C239				;$01C234	|
	INC.w $151C,X				;$01C236	|
CODE_01C239:
	LDA.b #$0C
	STA $B6,X				;$01C23B	|
	JSR SubSprXPosNoGrvty			;$01C23D	|
	LDA $AA,X				;$01C240	|
	PHA					;$01C242	|
	CLC					;$01C243	|
	SEC					;$01C244	|
	SBC.b #$02				;$01C245	|
	STA $AA,X				;$01C247	|
	JSR SubSprYPosNoGrvty			;$01C249	|
	PLA					;$01C24C	|
	STA $AA,X				;$01C24D	|
	JSR SubOffscreen0Bnk1			;$01C24F	|
	INC.w $1570,X				;$01C252	|
CODE_01C255:
	LDA $9E,X
	CMP.b #$7D				;$01C257	|
	BNE CODE_01C262				;$01C259	|
	LDA.b #$01				;$01C25B	|
	STA.w $157C,X				;$01C25D	|
	BRA CODE_01C27F				;$01C260	|

CODE_01C262:
	LDA $C2,X
	CMP.b #$02				;$01C264	|
	BNE CODE_01C27C				;$01C266	|
	LDA $13					;$01C268	|
	AND.b #$03				;$01C26A	|
	BNE CODE_01C271				;$01C26C	|
	JSR CODE_01B14E				;$01C26E	|
CODE_01C271:
	LDA $14
	LSR					;$01C273	|
	AND.b #$0E				;$01C274	|
	EOR.w $15F6,X				;$01C276	|
	STA.w $15F6,X				;$01C279	|
CODE_01C27C:
	JSR CODE_019E95
CODE_01C27F:
	LDA $C2,X
	BEQ CODE_01C287				;$01C281	|
	JSR GetDrawInfoBnk1			;$01C283	|
	RTS					;$01C286	|

CODE_01C287:
	JSR CODE_01C61A
	JSR MarioSprInteractRt			;$01C28A	|
	BCC Return01C2D2			;$01C28D	|
	LDA $9E,X				;$01C28F	|
	CMP.b #$7E				;$01C291	|
	BNE CODE_01C2A6				;$01C293	|
	JSR CODE_01C4F0				;$01C295	|
	LDA.b #$05				;$01C298	|
	JSL ADDR_05B329				;$01C29A	|
	LDA.b #$03				;$01C29E	|
	JSL GivePoints				;$01C2A0	|
	BRA ADDR_01C30F				;$01C2A4	|

CODE_01C2A6:
	CMP.b #$7F
	BNE CODE_01C2AF				;$01C2A8	|
	JSR GiveMario1Up			;$01C2AA	|
	BRA ADDR_01C30F				;$01C2AD	|

CODE_01C2AF:
	CMP.b #$80
	BNE CODE_01C2CE				;$01C2B1	|
	LDA $7D					;$01C2B3	|
	BMI Return01C2D2			;$01C2B5	|
	LDA.b #$09				;$01C2B7	|
	STA.w $14C8,X				;$01C2B9	|
	LDA.b #$D0				;$01C2BC	|
	STA $7D					;$01C2BE	|
	STZ $AA,X				;$01C2C0	|
	STZ.w $1540,X				;$01C2C2	|
	LDA.w $167A,X				;$01C2C5	|
	AND.b #$7F				;$01C2C8	|
	STA.w $167A,X				;$01C2CA	|
	RTS					;$01C2CD	|

CODE_01C2CE:
	CMP.b #$7D
	BEQ CODE_01C2D3				;$01C2D0	|
Return01C2D2:
	RTS

CODE_01C2D3:
	LDY.b #$0B
CODE_01C2D5:
	LDA.w $14C8,Y
	CMP.b #$0B				;$01C2D8	|
	BNE CODE_01C2E8				;$01C2DA	|
	LDA.w $009E,y				;$01C2DC	|
	CMP.b #$7D				;$01C2DF	|
	BEQ CODE_01C2E8				;$01C2E1	|
	LDA.b #$09				;$01C2E3	|
	STA.w $14C8,Y				;$01C2E5	|
CODE_01C2E8:
	DEY
	BPL CODE_01C2D5				;$01C2E9	|
	LDA.b #$00				;$01C2EB	|
	LDY.w $13F3				;$01C2ED	|
	BNE CODE_01C2F4				;$01C2F0	|
	LDA.b #$0B				;$01C2F2	|
CODE_01C2F4:
	STA.w $14C8,X
	LDA $7D					;$01C2F7	|
	STA $AA,X				;$01C2F9	|
	LDA $7B					;$01C2FB	|
	STA $B6,X				;$01C2FD	|
	LDA.b #$09				;$01C2FF	|
	STA.w $13F3				;$01C301	|
	LDA.b #$FF				;$01C304	|
	STA.w $1891				;$01C306	|
	LDA.b #$1E				;$01C309	|
	STA.w $1DF9				;$01C30B	|
	RTS					;$01C30E	|

ADDR_01C30F:
	STZ.w $14C8,X
	RTS					;$01C312	|

ChangingItemSprite:
	db $74,$75,$77,$76

ChangingItem:
	LDA.b #$01
	STA.w $151C,X				;$01C319	|
	LDA.w $15D0,X				;$01C31C	|
	BNE CODE_01C324				;$01C31F	|
	INC.w $187B,X				;$01C321	|
CODE_01C324:
	LDA.w $187B,X
	LSR					;$01C327	|
	LSR					;$01C328	|
	LSR					;$01C329	|
	LSR					;$01C32A	|
	LSR					;$01C32B	|
	LSR					;$01C32C	|
	AND.b #$03				;$01C32D	|
	TAY					;$01C32F	|
	LDA.w ChangingItemSprite,Y		;$01C330	|
	STA $9E,X				;$01C333	|
	JSL LoadSpriteTables			;$01C335	|
	JSR PowerUpRt				;$01C339	|
	LDA.b #$81				;$01C33C	|
	STA $9E,X				;$01C33E	|
	JSL LoadSpriteTables			;$01C340	|
	RTS					;$01C344	|

EatenBerryGfxProp:
	db $02,$02,$04,$06

FireFlower:
	LDA $14
	AND.b #$08				;$01C34B	|
	LSR					;$01C34D	|
	LSR					;$01C34E	|
	LSR					;$01C34F	|
	STA.w $157C,X				;$01C350	|
PowerUpRt:
	LDA.w $160E,X
	BEQ CODE_01C371				;$01C356	|
DrawBerryGfx:
	JSR SubSprGfx2Entry1
	LDY.w $15EA,X				;$01C35B	|
	LDA.b #$80				;$01C35E	|
	STA.w $0302,Y				;$01C360	|
	PHX					;$01C363	|
	LDX.w $18D6				;$01C364	|
	LDA.w EatenBerryGfxProp,X		;$01C367	|
	ORA $64					;$01C36A	|
	STA.w $0303,Y				;$01C36C	|
	PLX					;$01C36F	|
	RTS					;$01C370	|

CODE_01C371:
	LDA $64
	PHA					;$01C373	|
	JSR CODE_01C4AC				;$01C374	|
	LDA.w $1534,X				;$01C377	|
	BEQ CODE_01C38F				;$01C37A	|
	LDA $9D					;$01C37C	|
	BNE CODE_01C387				;$01C37E	|
	LDA.b #$10				;$01C380	|
	STA $AA,X				;$01C382	|
	JSR SubSprYPosNoGrvty			;$01C384	|
CODE_01C387:
	LDA $14
	AND.b #$0C				;$01C389	|
	BNE CODE_01C3AB				;$01C38B	|
	PLA					;$01C38D	|
	RTS					;$01C38E	|

CODE_01C38F:
	LDA.w $1540,X
	BEQ CODE_01C3AE				;$01C392	|
	JSR CODE_019140				;$01C394	|
	LDA.w $1528,X				;$01C397	|
	BNE CODE_01C3A0				;$01C39A	|
	LDA.b #$10				;$01C39C	|
	STA $64					;$01C39E	|
CODE_01C3A0:
	LDA $9D
	BNE CODE_01C3AB				;$01C3A2	|
	LDA.b #$FC				;$01C3A4	|
	STA $AA,X				;$01C3A6	|
	JSR SubSprYPosNoGrvty			;$01C3A8	|
CODE_01C3AB:
	JMP CODE_01C48D

CODE_01C3AE:
	LDA $9D
	BNE CODE_01C3AB				;$01C3B0	|
	LDA.w $14C8,X				;$01C3B2	|
	CMP.b #$0C				;$01C3B5	|
	BEQ CODE_01C3AB				;$01C3B7	|
	LDA $9E,X				;$01C3B9	|
	CMP.b #$76				;$01C3BB	|
	BNE CODE_01C3BF				;$01C3BD	|
CODE_01C3BF:
	INC.w $1570,X
	JSR CODE_018DBB				;$01C3C2	|
	LDA $9E,X				;$01C3C5	|
	CMP.b #$75				;$01C3C7	|
	BNE CODE_01C3D2				;$01C3C9	|
	LDA.w $151C,X				;$01C3CB	|
	BNE CODE_01C3D2				;$01C3CE	|
	STZ $B6,X				;$01C3D0	|
CODE_01C3D2:
	CMP.b #$76
	BEQ CODE_01C3E1				;$01C3D4	|
	CMP.b #$21				;$01C3D6	|
	BEQ CODE_01C3E1				;$01C3D8	|
	LDA.w $151C,X				;$01C3DA	|
	BNE CODE_01C3E1				;$01C3DD	|
	ASL $B6,X				;$01C3DF	|
CODE_01C3E1:
	LDA $C2,X
	BEQ CODE_01C3F3				;$01C3E3	|
	BMI CODE_01C3F1				;$01C3E5	|
	JSR CODE_019140				;$01C3E7	|
	LDA.w $1588,X				;$01C3EA	|
	BNE CODE_01C3F1				;$01C3ED	|
	STZ $C2,X				;$01C3EF	|
CODE_01C3F1:
	BRA CODE_01C437

CODE_01C3F3:
	LDA.w $0D9B
	CMP.b #$C1				;$01C3F6	|
	BEQ CODE_01C42C				;$01C3F8	|
	BIT.w $0D9B				;$01C3FA	|
	BVC CODE_01C42C				;$01C3FD	|
	STZ.w $1588,X				;$01C3FF	|
	STZ $B6,X				;$01C402	|
	LDA.w $14D4,X				;$01C404	|
	BNE ADDR_01C41E				;$01C407	|
	LDA $D8,X				;$01C409	|
	CMP.b #$A0				;$01C40B	|
	BCC ADDR_01C41E				;$01C40D	|
	AND.b #$F0				;$01C40F	|
	STA $D8,X				;$01C411	|
	LDA.w $1588,X				;$01C413	|
	ORA.b #$04				;$01C416	|
	STA.w $1588,X				;$01C418	|
	JSR CODE_018DBB				;$01C41B	|
ADDR_01C41E:
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty			;$01C421	|
	INC $AA,X				;$01C424	|
	INC $AA,X				;$01C426	|
	INC $AA,X				;$01C428	|
	BRA CODE_01C42F				;$01C42A	|

CODE_01C42C:
	JSR SubUpdateSprPos
CODE_01C42F:
	LDA $13
	AND.b #$03				;$01C431	|
	BEQ CODE_01C437				;$01C433	|
	DEC $AA,X				;$01C435	|
CODE_01C437:
	JSR SubOffscreen0Bnk1
	JSR IsTouchingCeiling			;$01C43A	|
	BEQ CODE_01C443				;$01C43D	|
	LDA.b #$00				;$01C43F	|
	STA $AA,X				;$01C441	|
CODE_01C443:
	JSR IsOnGround
	BNE CODE_01C44A				;$01C446	|
	BRA CODE_01C47E				;$01C448	|

CODE_01C44A:
	LDA $9E,X
	CMP.b #$21				;$01C44C	|
	BNE CODE_01C46C				;$01C44E	|
	JSR CODE_018DBB				;$01C450	|
	LDA $AA,X				;$01C453	|
	INC A					;$01C455	|
	PHA					;$01C456	|
	JSR SetSomeYSpeed			;$01C457	|
	PLA					;$01C45A	|
	LSR					;$01C45B	|
	JSR CODE_01CCEC				;$01C45C	|
	CMP.b #$FC				;$01C45F	|
	BCS CODE_01C46A				;$01C461	|
	LDY.w $1588,X				;$01C463	|
	BMI CODE_01C46A				;$01C466	|
	STA $AA,X				;$01C468	|
CODE_01C46A:
	BRA CODE_01C47E

CODE_01C46C:
	JSR SetSomeYSpeed
	LDA.w $151C,X				;$01C46F	|
	BNE CODE_01C47A				;$01C472	|
	LDA $9E,X				;$01C474	|
	CMP.b #$76				;$01C476	|
	BNE CODE_01C47E				;$01C478	|
CODE_01C47A:
	LDA.b #$C8
	STA $AA,X				;$01C47C	|
CODE_01C47E:
	LDA.w $1558,X
	ORA $C2,X				;$01C481	|
	BNE CODE_01C48D				;$01C483	|
	JSR IsTouchingObjSide			;$01C485	|
	BEQ CODE_01C48D				;$01C488	|
	JSR FlipSpriteDir			;$01C48A	|
CODE_01C48D:
	LDA.w $1540,X
	CMP.b #$36				;$01C490	|
	BCS CODE_01C4A8				;$01C492	|
	LDA $C2,X				;$01C494	|
	BEQ CODE_01C49C				;$01C496	|
	CMP.b #$FF				;$01C498	|
	BNE CODE_01C4A1				;$01C49A	|
CODE_01C49C:
	LDA.w $1632,X
	BEQ CODE_01C4A5				;$01C49F	|
CODE_01C4A1:
	LDA.b #$10
	STA $64					;$01C4A3	|
CODE_01C4A5:
	JSR CODE_01C61A
CODE_01C4A8:
	PLA
	STA $64					;$01C4A9	|
Return01C4AB:
	RTS

CODE_01C4AC:
	JSR CODE_01A80F
	BCC Return01C4AB			;$01C4AF	|
	LDA.w $151C,X				;$01C4B1	|
	BEQ CODE_01C4BA				;$01C4B4	|
	LDA $C2,X				;$01C4B6	|
	BNE Return01C4FA			;$01C4B8	|
CODE_01C4BA:
	LDA.w $154C,X
	BNE Return01C4FA			;$01C4BD	|
CODE_01C4BF:
	LDA.w $1540,X
	CMP.b #$18				;$01C4C2	|
	BCS Return01C4FA			;$01C4C4	|
	STZ.w $14C8,X				;$01C4C6	|
	LDA $9E,X				;$01C4C9	|
	CMP.b #$21				;$01C4CB	|
	BNE TouchedPowerUp			;$01C4CD	|
	JSL CODE_05B34A				;$01C4CF	|
	LDA.w $15F6,X				;$01C4D3	|
	AND.b #$0E				;$01C4D6	|
	CMP.b #$02				;$01C4D8	|
	BEQ CODE_01C4E0				;$01C4DA	|
	LDA.b #$01				;$01C4DC	|
	BRA CODE_01C4EC				;$01C4DE	|

CODE_01C4E0:
	LDA.w $18DD
	INC.w $18DD				;$01C4E3	|
	CMP.b #$0A				;$01C4E6	|
	BCC CODE_01C4EC				;$01C4E8	|
	LDA.b #$0A				;$01C4EA	|
CODE_01C4EC:
	JSL GivePoints
CODE_01C4F0:
	LDY.b #$03
CODE_01C4F2:
	LDA.w $17C0,Y
	BEQ CODE_01C4FB				;$01C4F5	|
	DEY					;$01C4F7	|
	BPL CODE_01C4F2				;$01C4F8	|
Return01C4FA:
	RTS

CODE_01C4FB:
	LDA.b #$05
	STA.w $17C0,Y				;$01C4FD	|
	LDA $E4,X				;$01C500	|
	STA.w $17C8,Y				;$01C502	|
	LDA $D8,X				;$01C505	|
	STA.w $17C4,Y				;$01C507	|
	LDA.b #$10				;$01C50A	|
	STA.w $17CC,Y				;$01C50C	|
	RTS					;$01C50F	|

ItemBoxSprite:
	db $00,$01,$01,$01,$00,$01,$04,$02
	db $00,$00,$00,$00,$00,$01,$04,$02
	db $00,$00,$00,$00

GivePowerPtrIndex:
	db $00,$01,$01,$01,$04,$04,$04,$01
	db $02,$02,$02,$02,$03,$03,$01,$03
	db $05,$05,$05,$05

TouchedPowerUp:
	SEC
	SBC.b #$74				;$01C539	|
	ASL					;$01C53B	|
	ASL					;$01C53C	|
	ORA $19					;$01C53D	|
	TAY					;$01C53F	|
	LDA.w ItemBoxSprite,Y			;$01C540	|
	BEQ NoItem				;$01C543	|
	STA.w $0DC2				;$01C545	|
	LDA.b #$0B				;$01C548	|
	STA.w $1DFC				;$01C54A	|
NoItem:
	LDA.w GivePowerPtrIndex,Y
	JSL ExecutePtr				;$01C550	|

HandlePowerUpPtrs:
	dw GiveMarioMushroom
	dw CODE_01C56F
	dw GiveMarioStar
	dw GiveMarioCape
	dw GiveMarioFire
	dw GiveMario1Up

	RTS					;$01C560	|

GiveMarioMushroom:
	LDA.b #$02
	STA $71					;$01C563	|
	LDA.b #$2F				;$01C565	|
	STA.w $1496,Y				;$01C567	|
	STA $9D					;$01C56A	|
	JMP CODE_01C56F				;$01C56C	|

CODE_01C56F:
	LDA.b #$04
	LDY.w $1534,X				;$01C571	|
	BNE CODE_01C57A				;$01C574	|
	JSL GivePoints				;$01C576	|
CODE_01C57A:
	LDA.b #$0A
	STA.w $1DF9				;$01C57C	|
	RTS					;$01C57F	|

CODE_01C580:
	LDA.b #$FF
	STA.w $1490				;$01C582	|
	LDA.b #$0D				;$01C585	|
	STA.w $1DFB				;$01C587	|
	ASL.w $0DDA				;$01C58A	|
	SEC					;$01C58D	|
	ROR.w $0DDA				;$01C58E	|
	RTL					;$01C591	|

GiveMarioStar:
	JSL CODE_01C580
	BRA CODE_01C56F				;$01C596	|

GiveMarioCape:
	LDA.b #$02
	STA $19					;$01C59A	|
	LDA.b #$0D				;$01C59C	|
	STA.w $1DF9				;$01C59E	|
	LDA.b #$04				;$01C5A1	|
	JSL GivePoints				;$01C5A3	|
	JSL CODE_01C5AE				;$01C5A7	|
	INC $9D					;$01C5AB	|
	RTS					;$01C5AD	|

CODE_01C5AE:
	LDA $81
	ORA $7F					;$01C5B0	|
	BNE Return01C5EB			;$01C5B2	|
	LDA.b #$03				;$01C5B4	|
	STA $71					;$01C5B6	|
	LDA.b #$18				;$01C5B8	|
	STA.w $1496				;$01C5BA	|
	LDY.b #$03				;$01C5BD	|
CODE_01C5BF:
	LDA.w $17C0,Y
	BEQ CODE_01C5D4				;$01C5C2	|
	DEY					;$01C5C4	|
	BPL CODE_01C5BF				;$01C5C5	|
	DEC.w $1863				;$01C5C7	|
	BPL CODE_01C5D1				;$01C5CA	|
	LDA.b #$03				;$01C5CC	|
	STA.w $1863				;$01C5CE	|
CODE_01C5D1:
	LDY.w $1863
CODE_01C5D4:
	LDA.b #$81
	STA.w $17C0,Y				;$01C5D6	|
	LDA.b #$1B				;$01C5D9	|
	STA.w $17CC,Y				;$01C5DB	|
	LDA $96					;$01C5DE	|
	CLC					;$01C5E0	|
	ADC.b #$08				;$01C5E1	|
	STA.w $17C4,Y				;$01C5E3	|
	LDA $94					;$01C5E6	|
	STA.w $17C8,Y				;$01C5E8	|
Return01C5EB:
	RTL

GiveMarioFire:
	LDA.b #$20
	STA.w $149B				;$01C5EE	|
	STA $9D					;$01C5F1	|
	LDA.b #$04				;$01C5F3	|
	STA $71					;$01C5F5	|
	LDA.b #$03				;$01C5F7	|
	STA $19					;$01C5F9	|
	JMP CODE_01C56F				;$01C5FB	|

GiveMario1Up:
	LDA.b #$08
	CLC					;$01C600	|
	ADC.w $1594,X				;$01C601	|
	JSL GivePoints				;$01C604	|
	RTS					;$01C608	|

PowerUpTiles:
	db $24,$26,$48,$0E,$24,$00,$00,$00
	db $00,$E4,$E8,$24,$EC

StarPalValues:
	db $00,$04,$08,$04

CODE_01C61A:
	JSR GetDrawInfoBnk1
	STZ $0A					;$01C61D	|
	LDA.w $140F				;$01C61F	|
	BNE CODE_01C636				;$01C622	|
	LDA.w $0D9B				;$01C624	|
	CMP.b #$C1				;$01C627	|
	BEQ CODE_01C636				;$01C629	|
	BIT.w $0D9B				;$01C62B	|
	BVC CODE_01C636				;$01C62E	|
	LDA.b #$D8				;$01C630	|
	STA.w $15EA,X				;$01C632	|
	TAY					;$01C635	|
CODE_01C636:
	LDA $9E,X
	CMP.b #$21				;$01C638	|
	BNE PowerUpGfxRt			;$01C63A	|
	JSL CoinSprGfx				;$01C63C	|
	RTS					;$01C640	|

CoinSprGfx:
	JSR CoinSprGfxSub
	RTL					;$01C644	|

CoinSprGfxSub:
	JSR GetDrawInfoBnk1
	LDA $00					;$01C648	|
	STA.w $0300,Y				;$01C64A	|
	LDA $01					;$01C64D	|
	STA.w $0301,Y				;$01C64F	|
	LDA.b #$E8				;$01C652	|
	STA.w $0302,Y				;$01C654	|
	LDA.w $15F6,X				;$01C657	|
	ORA $64					;$01C65A	|
	STA.w $0303,Y				;$01C65C	|
	TXA					;$01C65F	|
	CLC					;$01C660	|
	ADC $14					;$01C661	|
	LSR					;$01C663	|
	LSR					;$01C664	|
	AND.b #$03				;$01C665	|
	BNE CODE_01C670				;$01C667	|
	LDY.b #$02				;$01C669	|
	BRA CODE_01C69A				;$01C66B	|

MovingCoinTiles:
	db $EA,$FA,$EA

CODE_01C670:
	PHX
	TAX					;$01C671	|
	LDA $00					;$01C672	|
	CLC					;$01C674	|
	ADC.b #$04				;$01C675	|
	STA.w $0300,Y				;$01C677	|
	STA.w $0304,Y				;$01C67A	|
	LDA $01					;$01C67D	|
	CLC					;$01C67F	|
	ADC.b #$08				;$01C680	|
	STA.w $0305,Y				;$01C682	|
	LDA.l MovingCoinTiles-1,X		;$01C685	|
	STA.w $0302,Y				;$01C689	|
	STA.w $0306,Y				;$01C68C	|
	LDA.w $0303,Y				;$01C68F	|
	ORA.b #$80				;$01C692	|
	STA.w $0307,Y				;$01C694	|
	PLX					;$01C697	|
	LDY.b #$00				;$01C698	|
CODE_01C69A:
	LDA.b #$01
	JSL FinishOAMWrite			;$01C69C	|
	RTS					;$01C6A0	|

PowerUpGfxRt:
	CMP.b #$76
	BNE NoFlashingPal			;$01C6A3	|
	LDA $13					;$01C6A5	|
	LSR					;$01C6A7	|
	AND.b #$03				;$01C6A8	|
	PHY					;$01C6AA	|
	TAY					;$01C6AB	|
	LDA.w StarPalValues,Y			;$01C6AC	|
	PLY					;$01C6AF	|
	STA $0A					;$01C6B0	|
NoFlashingPal:
	LDA $00
	STA.w $0300,Y				;$01C6B4	|
	LDA $01					;$01C6B7	|
	DEC A					;$01C6B9	|
	STA.w $0301,Y				;$01C6BA	|
	LDA.w $157C,X				;$01C6BD	|
	LSR					;$01C6C0	|
	LDA.b #$00				;$01C6C1	|
	BCS CODE_01C6C7				;$01C6C3	|
	ORA.b #$40				;$01C6C5	|
CODE_01C6C7:
	ORA $64
	ORA.w $15F6,X				;$01C6C9	|
	EOR $0A					;$01C6CC	|
	STA.w $0303,Y				;$01C6CE	|
	LDA $9E,X				;$01C6D1	|
	SEC					;$01C6D3	|
	SBC.b #$74				;$01C6D4	|
	TAX					;$01C6D6	|
	LDA.w PowerUpTiles,X			;$01C6D7	|
	STA.w $0302,Y				;$01C6DA	|
	LDX.w $15E9				;$01C6DD	|
	LDA.b #$00				;$01C6E0	|
	JSR CODE_01B37E				;$01C6E2	|
	RTS					;$01C6E5	|

DATA_01C6E6:
	db $02,$FE

DATA_01C6E8:
	db $20,$E0

DATA_01C6EA:
	db $0A,$F6,$08

Feather:
	LDA $9D
	BNE CODE_01C744				;$01C6EF	|
	LDA $C2,X				;$01C6F1	|
	BEQ CODE_01C701				;$01C6F3	|
	JSR CODE_019140				;$01C6F5	|
	LDA.w $1588,X				;$01C6F8	|
	BNE CODE_01C6FF				;$01C6FB	|
	STZ $C2,X				;$01C6FD	|
CODE_01C6FF:
	BRA CODE_01C741

CODE_01C701:
	LDA.w $14C8,X
	CMP.b #$0C				;$01C704	|
	BEQ CODE_01C744				;$01C706	|
	LDA.w $154C,X				;$01C708	|
	BEQ CODE_01C715				;$01C70B	|
	JSR SubSprYPosNoGrvty			;$01C70D	|
	INC $AA,X				;$01C710	|
	JMP CODE_01C741				;$01C712	|

CODE_01C715:
	LDA.w $1528,X
	AND.b #$01				;$01C718	|
	TAY					;$01C71A	|
	LDA $B6,X				;$01C71B	|
	CLC					;$01C71D	|
	ADC.w DATA_01C6E6,Y			;$01C71E	|
	STA $B6,X				;$01C721	|
	CMP.w DATA_01C6E8,Y			;$01C723	|
	BNE CODE_01C72B				;$01C726	|
	INC.w $1528,X				;$01C728	|
CODE_01C72B:
	LDA $B6,X
	BPL CODE_01C730				;$01C72D	|
	INY					;$01C72F	|
CODE_01C730:
	LDA.w DATA_01C6EA,Y
	CLC					;$01C733	|
	ADC.b #$06				;$01C734	|
	STA $AA,X				;$01C736	|
	JSR SubOffscreen0Bnk1			;$01C738	|
	JSR SubSprXPosNoGrvty			;$01C73B	|
	JSR SubSprYPosNoGrvty			;$01C73E	|
CODE_01C741:
	JSR UpdateDirection
CODE_01C744:
	JSR CODE_01C4AC
	JMP CODE_01C61A				;$01C747	|

InitBrwnChainPlat:
	LDA.b #$80
	STA.w $151C,X				;$01C74C	|
	LDA.b #$01				;$01C74F	|
	STA.w $1528,X				;$01C751	|
	LDA $E4,X				;$01C754	|
	CLC					;$01C756	|
	ADC.b #$78				;$01C757	|
	STA $E4,X				;$01C759	|
	LDA.w $14E0,X				;$01C75B	|
	ADC.b #$00				;$01C75E	|
	STA.w $14E0,X				;$01C760	|
	LDA $D8,X				;$01C763	|
	CLC					;$01C765	|
	ADC.b #$68				;$01C766	|
	STA $D8,X				;$01C768	|
	LDA.w $14D4,X				;$01C76A	|
	ADC.b #$00				;$01C76D	|
	STA.w $14D4,X				;$01C76F	|
	RTS					;$01C772	|

BrownChainedPlat:
	JSR SubOffscreen2Bnk1
	LDA $9D					;$01C776	|
	BNE CODE_01C795				;$01C778	|
	LDA $13					;$01C77A	|
	AND.b #$03				;$01C77C	|
	ORA.w $1602,X				;$01C77E	|
	BNE CODE_01C795				;$01C781	|
	LDA.b #$01				;$01C783	|
	LDY.w $1504,X				;$01C785	|
	BEQ CODE_01C795				;$01C788	|
	BMI CODE_01C78E				;$01C78A	|
	LDA.b #$FF				;$01C78C	|
CODE_01C78E:
	CLC
	ADC.w $1504,X				;$01C78F	|
	STA.w $1504,X				;$01C792	|
CODE_01C795:
	LDA.w $151C,X
	PHA					;$01C798	|
	LDA.w $1528,X				;$01C799	|
	PHA					;$01C79C	|
	LDA.b #$00				;$01C79D	|
	SEC					;$01C79F	|
	SBC.w $151C,X				;$01C7A0	|
	STA.w $151C,X				;$01C7A3	|
	LDA.b #$02				;$01C7A6	|
	SBC.w $1528,X				;$01C7A8	|
	AND.b #$01				;$01C7AB	|
	STA.w $1528,X				;$01C7AD	|
	JSR CODE_01CACB				;$01C7B0	|
	JSR CODE_01CB20				;$01C7B3	|
	JSR CODE_01CB53				;$01C7B6	|
	PLA					;$01C7B9	|
	STA.w $1528,X				;$01C7BA	|
	PLA					;$01C7BD	|
	STA.w $151C,X				;$01C7BE	|
	LDA.w $14B8				;$01C7C1	|
	PHA					;$01C7C4	|
	SEC					;$01C7C5	|
	SBC $C2,X				;$01C7C6	|
	STA.w $1491				;$01C7C8	|
	PLA					;$01C7CB	|
	STA $C2,X				;$01C7CC	|
	LDY.w $15EA,X				;$01C7CE	|
	LDA.w $14BA				;$01C7D1	|
	SEC					;$01C7D4	|
	SBC $1C					;$01C7D5	|
	SEC					;$01C7D7	|
	SBC.b #$08				;$01C7D8	|
	STA.w $0301,Y				;$01C7DA	|
	LDA.w $14B8				;$01C7DD	|
	SEC					;$01C7E0	|
	SBC $1A					;$01C7E1	|
	SEC					;$01C7E3	|
	SBC.b #$08				;$01C7E4	|
	STA.w $0300,Y				;$01C7E6	|
	LDA.b #$A2				;$01C7E9	|
	STA.w $0302,Y				;$01C7EB	|
	LDA.b #$31				;$01C7EE	|
	STA.w $0303,Y				;$01C7F0	|
	LDY.b #$00				;$01C7F3	|
	LDA.w $14BA				;$01C7F5	|
	SEC					;$01C7F8	|
	SBC.w $14B2				;$01C7F9	|
	BPL CODE_01C802				;$01C7FC	|
	EOR.b #$FF				;$01C7FE	|
	INC A					;$01C800	|
	INY					;$01C801	|
CODE_01C802:
	STY $00
	STA.w $4205				;$01C804	|
	STZ.w $4204				;$01C807	|
	LDA.b #$05				;$01C80A	|
	STA.w $4206				;$01C80C	|
	JSR DoNothing				;$01C80F	|
	LDA.w $4214				;$01C812	|
	STA $02					;$01C815	|
	STA $06					;$01C817	|
	LDA.w $4215				;$01C819	|
	STA $03					;$01C81C	|
	STA $07					;$01C81E	|
	LDY.b #$00				;$01C820	|
	LDA.w $14B8				;$01C822	|
	SEC					;$01C825	|
	SBC.w $14B0				;$01C826	|
	BPL CODE_01C82F				;$01C829	|
	EOR.b #$FF				;$01C82B	|
	INC A					;$01C82D	|
	INY					;$01C82E	|
CODE_01C82F:
	STY $01
	STA.w $4205				;$01C831	|
	STZ.w $4204				;$01C834	|
	LDA.b #$05				;$01C837	|
	STA.w $4206				;$01C839	|
	JSR DoNothing				;$01C83C	|
	LDA.w $4214				;$01C83F	|
	STA $04					;$01C842	|
	STA $08					;$01C844	|
	LDA.w $4215				;$01C846	|
	STA $05					;$01C849	|
	STA $09					;$01C84B	|
	LDY.w $15EA,X				;$01C84D	|
	INY					;$01C850	|
	INY					;$01C851	|
	INY					;$01C852	|
	INY					;$01C853	|
	LDA.w $14B2				;$01C854	|
	SEC					;$01C857	|
	SBC $1C					;$01C858	|
	SEC					;$01C85A	|
	SBC.b #$08				;$01C85B	|
	STA $0A					;$01C85D	|
	STA.w $0301,Y				;$01C85F	|
	LDA.w $14B0				;$01C862	|
	SEC					;$01C865	|
	SBC $1A					;$01C866	|
	SEC					;$01C868	|
	SBC.b #$08				;$01C869	|
	STA $0B					;$01C86B	|
	STA.w $0300,Y				;$01C86D	|
	LDA.b #$A2				;$01C870	|
	STA.w $0302,Y				;$01C872	|
	LDA.b #$31				;$01C875	|
	STA.w $0303,Y				;$01C877	|
	LDX.b #$03				;$01C87A	|
CODE_01C87C:
	INY
	INY					;$01C87D	|
	INY					;$01C87E	|
	INY					;$01C87F	|
	LDA $00					;$01C880	|
	BNE CODE_01C88E				;$01C882	|
	LDA $0A					;$01C884	|
	CLC					;$01C886	|
	ADC $07					;$01C887	|
	STA.w $0301,Y				;$01C889	|
	BRA CODE_01C896				;$01C88C	|

CODE_01C88E:
	LDA $0A
	SEC					;$01C890	|
	SBC $07					;$01C891	|
	STA.w $0301,Y				;$01C893	|
CODE_01C896:
	LDA $06
	CLC					;$01C898	|
	ADC $02					;$01C899	|
	STA $06					;$01C89B	|
	LDA $07					;$01C89D	|
	ADC $03					;$01C89F	|
	STA $07					;$01C8A1	|
	LDA $01					;$01C8A3	|
	BNE CODE_01C8B1				;$01C8A5	|
	LDA $0B					;$01C8A7	|
	CLC					;$01C8A9	|
	ADC $09					;$01C8AA	|
	STA.w $0300,Y				;$01C8AC	|
	BRA CODE_01C8B9				;$01C8AF	|

CODE_01C8B1:
	LDA $0B
	SEC					;$01C8B3	|
	SBC $09					;$01C8B4	|
	STA.w $0300,Y				;$01C8B6	|
CODE_01C8B9:
	LDA $08
	CLC					;$01C8BB	|
	ADC $04					;$01C8BC	|
	STA $08					;$01C8BE	|
	LDA $09					;$01C8C0	|
	ADC $05					;$01C8C2	|
	STA $09					;$01C8C4	|
	LDA.b #$A2				;$01C8C6	|
	STA.w $0302,Y				;$01C8C8	|
	LDA.b #$31				;$01C8CB	|
	STA.w $0303,Y				;$01C8CD	|
	DEX					;$01C8D0	|
	BPL CODE_01C87C				;$01C8D1	|
	LDX.b #$03				;$01C8D3	|
CODE_01C8D5:
	STX $02
	INY					;$01C8D7	|
	INY					;$01C8D8	|
	INY					;$01C8D9	|
	INY					;$01C8DA	|
	LDA.w $14BA				;$01C8DB	|
	SEC					;$01C8DE	|
	SBC $1C					;$01C8DF	|
	SEC					;$01C8E1	|
	SBC.b #$10				;$01C8E2	|
	STA.w $0301,Y				;$01C8E4	|
	LDA.w $14B8				;$01C8E7	|
	SEC					;$01C8EA	|
	SBC $1A					;$01C8EB	|
	CLC					;$01C8ED	|
	ADC.w DATA_01C9B7,X			;$01C8EE	|
	STA.w $0300,Y				;$01C8F1	|
	LDA.w BrwnChainPlatTiles,X		;$01C8F4	|
	STA.w $0302,Y				;$01C8F7	|
	LDA.b #$31				;$01C8FA	|
	STA.w $0303,Y				;$01C8FC	|
	DEX					;$01C8FF	|
	BPL CODE_01C8D5				;$01C900	|
	LDX.w $15E9				;$01C902	|
	LDA.b #$09				;$01C905	|
	STA $08					;$01C907	|
	LDA.w $14B2				;$01C909	|
	SEC					;$01C90C	|
	SBC.b #$08				;$01C90D	|
	STA $00					;$01C90F	|
	LDA.w $14B3				;$01C911	|
	SBC.b #$00				;$01C914	|
	STA $01					;$01C916	|
	LDA.w $14B0				;$01C918	|
	SEC					;$01C91B	|
	SBC.b #$08				;$01C91C	|
	STA $02					;$01C91E	|
	LDA.w $14B1				;$01C920	|
	SBC.b #$00				;$01C923	|
	STA $03					;$01C925	|
	LDY.w $15EA,X				;$01C927	|
	LDA.w $0305,Y				;$01C92A	|
	STA $06					;$01C92D	|
	LDA.w $0304,Y				;$01C92F	|
	STA $07					;$01C932	|
CODE_01C934:
	TYA
	LSR					;$01C935	|
	LSR					;$01C936	|
	TAX					;$01C937	|
	LDA.b #$02				;$01C938	|
	STA.w $0460,X				;$01C93A	|
	LDX.b #$00				;$01C93D	|
	LDA.w $0300,Y				;$01C93F	|
	SEC					;$01C942	|
	SBC $07					;$01C943	|
	BPL CODE_01C948				;$01C945	|
	DEX					;$01C947	|
CODE_01C948:
	CLC
	ADC $02					;$01C949	|
	STA $04					;$01C94B	|
	TXA					;$01C94D	|
	ADC $03					;$01C94E	|
	STA $05					;$01C950	|
	JSR CODE_01B844				;$01C952	|
	BCC CODE_01C960				;$01C955	|
	TYA					;$01C957	|
	LSR					;$01C958	|
	LSR					;$01C959	|
	TAX					;$01C95A	|
	LDA.b #$03				;$01C95B	|
	STA.w $0460,X				;$01C95D	|
CODE_01C960:
	LDX.b #$00
	LDA.w $0301,Y				;$01C962	|
	SEC					;$01C965	|
	SBC $06					;$01C966	|
	BPL CODE_01C96B				;$01C968	|
	DEX					;$01C96A	|
CODE_01C96B:
	CLC
	ADC $00					;$01C96C	|
	STA $09					;$01C96E	|
	TXA					;$01C970	|
	ADC $01					;$01C971	|
	STA $0A					;$01C973	|
	JSR CODE_01C9BF				;$01C975	|
	BCC CODE_01C97F				;$01C978	|
	LDA.b #$F0				;$01C97A	|
	STA.w $0301,Y				;$01C97C	|
CODE_01C97F:
	LDA $08
	CMP.b #$09				;$01C981	|
	BNE CODE_01C999				;$01C983	|
	LDA $04					;$01C985	|
	STA.w $14B8				;$01C987	|
	LDA $05					;$01C98A	|
	STA.w $14B9				;$01C98C	|
	LDA $09					;$01C98F	|
	STA.w $14BA				;$01C991	|
	LDA $0A					;$01C994	|
	STA.w $14BB				;$01C996	|
CODE_01C999:
	INY
	INY					;$01C99A	|
	INY					;$01C99B	|
	INY					;$01C99C	|
	DEC $08					;$01C99D	|
	BPL CODE_01C934				;$01C99F	|
	LDX.w $15E9				;$01C9A1	|
	LDY.w $15EA,X				;$01C9A4	|
	LDA.b #$F0				;$01C9A7	|
	STA.w $0305,Y				;$01C9A9	|
	LDA $9D					;$01C9AC	|
	BNE Return01C9B6			;$01C9AE	|
	JSR CODE_01CCF0				;$01C9B0	|
	JMP CODE_01C9EC				;$01C9B3	|

Return01C9B6:
	RTS

DATA_01C9B7:
	db $E0,$F0,$00,$10

BrwnChainPlatTiles:
	db $60,$61,$61,$62

CODE_01C9BF:
	REP #$20
	LDA $09					;$01C9C1	|
	PHA					;$01C9C3	|
	CLC					;$01C9C4	|
	ADC.w #$0010				;$01C9C5	|
	STA $09					;$01C9C8	|
	SEC					;$01C9CA	|
	SBC $1C					;$01C9CB	|
	CMP.w #$0100				;$01C9CD	|
	PLA					;$01C9D0	|
	STA $09					;$01C9D1	|
	SEP #$20				;$01C9D3	|
Return01C9D5:
	RTS

DATA_01C9D6:
	db $01,$FF

DATA_01C9D8:
	db $40,$C0

CODE_01C9DA:
	LDA.w $160E,X
	BEQ Return01C9EB			;$01C9DD	|
	STZ.w $160E,X				;$01C9DF	|
CODE_01C9E2:
	PHX
	JSL CODE_00E2BD				;$01C9E3	|
	PLX					;$01C9E7	|
	STX.w $15E9				;$01C9E8	|
Return01C9EB:
	RTS

CODE_01C9EC:
	LDA.w $14B9
	XBA					;$01C9EF	|
	LDA.w $14B8				;$01C9F0	|
	REP #$20				;$01C9F3	|
	SEC					;$01C9F5	|
	SBC $1A					;$01C9F6	|
	CLC					;$01C9F8	|
	ADC.w #$0010				;$01C9F9	|
	CMP.w #$0120				;$01C9FC	|
	SEP #$20				;$01C9FF	|
	ROL					;$01CA01	|
	AND.b #$01				;$01CA02	|
	ORA $9D					;$01CA04	|
	STA.w $15C4,X				;$01CA06	|
	BNE Return01C9D5			;$01CA09	|
	JSR CODE_01CA9C				;$01CA0B	|
	STZ.w $1602,X				;$01CA0E	|
	BCC CODE_01C9DA				;$01CA11	|
	LDA.b #$01				;$01CA13	|
	STA.w $160E,X				;$01CA15	|
	LDA.w $14BA				;$01CA18	|
	SEC					;$01CA1B	|
	SBC $1C					;$01CA1C	|
	STA $03					;$01CA1E	|
	SEC					;$01CA20	|
	SBC.b #$08				;$01CA21	|
	STA $0E					;$01CA23	|
	LDA $80					;$01CA25	|
	CLC					;$01CA27	|
	ADC.b #$18				;$01CA28	|
	CMP $0E					;$01CA2A	|
	BCS Return01CA9B			;$01CA2C	|
	LDA $7D					;$01CA2E	|
	BMI CODE_01C9E2				;$01CA30	|
	STZ $7D					;$01CA32	|
	LDA.b #$03				;$01CA34	|
	STA.w $1471				;$01CA36	|
	STA.w $1602,X				;$01CA39	|
	LDA.b #$28				;$01CA3C	|
	LDY.w $187A				;$01CA3E	|
	BEQ CODE_01CA45				;$01CA41	|
	LDA.b #$38				;$01CA43	|
CODE_01CA45:
	STA $0F
	LDA.w $14BA				;$01CA47	|
	SEC					;$01CA4A	|
	SBC $0F					;$01CA4B	|
	STA $96					;$01CA4D	|
	LDA.w $14BB				;$01CA4F	|
	SBC.b #$00				;$01CA52	|
	STA $97					;$01CA54	|
	LDA $77					;$01CA56	|
	AND.b #$03				;$01CA58	|
	BNE CODE_01CA6E				;$01CA5A	|
	LDY.b #$00				;$01CA5C	|
	LDA.w $1491				;$01CA5E	|
	BPL CODE_01CA64				;$01CA61	|
	DEY					;$01CA63	|
CODE_01CA64:
	CLC
	ADC $94					;$01CA65	|
	STA $94					;$01CA67	|
	TYA					;$01CA69	|
	ADC $95					;$01CA6A	|
	STA $95					;$01CA6C	|
CODE_01CA6E:
	JSR CODE_01C9E2
	LDA $16					;$01CA71	|
	BMI CODE_01CA79				;$01CA73	|
	LDA.b #$FF				;$01CA75	|
	STA $78					;$01CA77	|
CODE_01CA79:
	LDA $13
	LSR					;$01CA7B	|
	BCC Return01CA9B			;$01CA7C	|
	LDA.w $151C,X				;$01CA7E	|
	CLC					;$01CA81	|
	ADC.b #$80				;$01CA82	|
	LDA.w $1528,X				;$01CA84	|
	ADC.b #$00				;$01CA87	|
	AND.b #$01				;$01CA89	|
	TAY					;$01CA8B	|
	LDA.w $1504,X				;$01CA8C	|
	CMP.w DATA_01C9D8,Y			;$01CA8F	|
	BEQ Return01CA9B			;$01CA92	|
	CLC					;$01CA94	|
	ADC.w DATA_01C9D6,Y			;$01CA95	|
	STA.w $1504,X				;$01CA98	|
Return01CA9B:
	RTS

CODE_01CA9C:
	LDA.w $14B8
	SEC					;$01CA9F	|
	SBC.b #$18				;$01CAA0	|
	STA $04					;$01CAA2	|
	LDA.w $14B9				;$01CAA4	|
	SBC.b #$00				;$01CAA7	|
	STA $0A					;$01CAA9	|
	LDA.b #$40				;$01CAAB	|
	STA $06					;$01CAAD	|
	LDA.w $14BA				;$01CAAF	|
	SEC					;$01CAB2	|
	SBC.b #$0C				;$01CAB3	|
	STA $05					;$01CAB5	|
	LDA.w $14BB				;$01CAB7	|
	SBC.b #$00				;$01CABA	|
	STA $0B					;$01CABC	|
	LDA.b #$13				;$01CABE	|
	STA $07					;$01CAC0	|
	JSL GetMarioClipping			;$01CAC2	|
	JSL CheckForContact			;$01CAC6	|
	RTS					;$01CACA	|

CODE_01CACB:
	LDA.b #$50
	STA.w $14BC				;$01CACD	|
	STZ.w $14BF				;$01CAD0	|
	STZ.w $14BD				;$01CAD3	|
	STZ.w $14C0				;$01CAD6	|
	LDA $E4,X				;$01CAD9	|
	STA.w $14B4				;$01CADB	|
	LDA.w $14E0,X				;$01CADE	|
	STA.w $14B5				;$01CAE1	|
	LDA.w $14B4				;$01CAE4	|
	SEC					;$01CAE7	|
	SBC.w $14BC				;$01CAE8	|
	STA.w $14B0				;$01CAEB	|
	LDA.w $14B5				;$01CAEE	|
	SBC.w $14BD				;$01CAF1	|
	STA.w $14B1				;$01CAF4	|
	LDA $D8,X				;$01CAF7	|
	STA.w $14B6				;$01CAF9	|
	LDA.w $14D4,X				;$01CAFC	|
	STA.w $14B7				;$01CAFF	|
	LDA.w $14B6				;$01CB02	|
	SEC					;$01CB05	|
	SBC.w $14BF				;$01CB06	|
	STA.w $14B2				;$01CB09	|
	LDA.w $14B7				;$01CB0C	|
	SBC.w $14C0				;$01CB0F	|
	STA.w $14B3				;$01CB12	|
	LDA.w $151C,X				;$01CB15	|
	STA $36					;$01CB18	|
	LDA.w $1528,X				;$01CB1A	|
	STA $37					;$01CB1D	|
	RTS					;$01CB1F	|

CODE_01CB20:
	LDA $37
	STA.w $1866				;$01CB22	|
	PHX					;$01CB25	|
	REP #$30				;$01CB26	|
	LDA $36					;$01CB28	|
	ASL					;$01CB2A	|
	AND.w #$01FF				;$01CB2B	|
	TAX					;$01CB2E	|
	LDA.l CircleCoords,X			;$01CB2F	|
	STA.w $14C2				;$01CB33	|
	LDA $36					;$01CB36	|
	CLC					;$01CB38	|
	ADC.w #$0080				;$01CB39	|
	STA $00					;$01CB3C	|
	ASL					;$01CB3E	|
	AND.w #$01FF				;$01CB3F	|
	TAX					;$01CB42	|
	LDA.l CircleCoords,X			;$01CB43	|
	STA.w $14C5				;$01CB47	|
	SEP #$30				;$01CB4A	|
	LDA $01					;$01CB4C	|
	STA.w $1867				;$01CB4E	|
	PLX					;$01CB51	|
	RTS					;$01CB52	|

CODE_01CB53:
	REP #$20
	LDA.w $14C5				;$01CB55	|
	STA $02					;$01CB58	|
	LDA.w $14BC				;$01CB5A	|
	STA $00					;$01CB5D	|
	SEP #$20				;$01CB5F	|
	JSR CODE_01CC28				;$01CB61	|
	LDA.w $1867				;$01CB64	|
	LSR					;$01CB67	|
	REP #$20				;$01CB68	|
	LDA $04					;$01CB6A	|
	BCC CODE_01CB72				;$01CB6C	|
	EOR.w #$FFFF				;$01CB6E	|
	INC A					;$01CB71	|
CODE_01CB72:
	STA $08
	LDA $06					;$01CB74	|
	BCC CODE_01CB7C				;$01CB76	|
	EOR.w #$FFFF				;$01CB78	|
	INC A					;$01CB7B	|
CODE_01CB7C:
	STA $0A
	LDA.w $14C2				;$01CB7E	|
	STA $02					;$01CB81	|
	LDA.w $14BF				;$01CB83	|
	STA $00					;$01CB86	|
	SEP #$20				;$01CB88	|
	JSR CODE_01CC28				;$01CB8A	|
	LDA.w $1866				;$01CB8D	|
	LSR					;$01CB90	|
	REP #$20				;$01CB91	|
	LDA $04					;$01CB93	|
	BCC CODE_01CB9B				;$01CB95	|
	EOR.w #$FFFF				;$01CB97	|
	INC A					;$01CB9A	|
CODE_01CB9B:
	STA $04
	LDA $06					;$01CB9D	|
	BCC CODE_01CBA5				;$01CB9F	|
	EOR.w #$FFFF				;$01CBA1	|
	INC A					;$01CBA4	|
CODE_01CBA5:
	STA $06
	LDA $04					;$01CBA7	|
	CLC					;$01CBA9	|
	ADC $08					;$01CBAA	|
	STA $04					;$01CBAC	|
	LDA $06					;$01CBAE	|
	ADC $0A					;$01CBB0	|
	STA $06					;$01CBB2	|
	LDA $05					;$01CBB4	|
	CLC					;$01CBB6	|
	ADC.w $14B0				;$01CBB7	|
	STA.w $14B8				;$01CBBA	|
	LDA.w $14C5				;$01CBBD	|
	STA $02					;$01CBC0	|
	LDA.w $14BF				;$01CBC2	|
	STA $00					;$01CBC5	|
	SEP #$20				;$01CBC7	|
	JSR CODE_01CC28				;$01CBC9	|
	LDA.w $1867				;$01CBCC	|
	LSR					;$01CBCF	|
	REP #$20				;$01CBD0	|
	LDA $04					;$01CBD2	|
	BCC CODE_01CBDA				;$01CBD4	|
	EOR.w #$FFFF				;$01CBD6	|
	INC A					;$01CBD9	|
CODE_01CBDA:
	STA $08
	LDA $06					;$01CBDC	|
	BCC CODE_01CBE4				;$01CBDE	|
	EOR.w #$FFFF				;$01CBE0	|
	INC A					;$01CBE3	|
CODE_01CBE4:
	STA $0A
	LDA.w $14C2				;$01CBE6	|
	STA $02					;$01CBE9	|
	LDA.w $14BC				;$01CBEB	|
	STA $00					;$01CBEE	|
	SEP #$20				;$01CBF0	|
	JSR CODE_01CC28				;$01CBF2	|
	LDA.w $1866				;$01CBF5	|
	LSR					;$01CBF8	|
	REP #$20				;$01CBF9	|
	LDA $04					;$01CBFB	|
	BCC CODE_01CC03				;$01CBFD	|
	EOR.w #$FFFF				;$01CBFF	|
	INC A					;$01CC02	|
CODE_01CC03:
	STA $04
	LDA $06					;$01CC05	|
	BCC CODE_01CC0D				;$01CC07	|
	EOR.w #$FFFF				;$01CC09	|
	INC A					;$01CC0C	|
CODE_01CC0D:
	STA $06
	LDA $04					;$01CC0F	|
	SEC					;$01CC11	|
	SBC $08					;$01CC12	|
	STA $04					;$01CC14	|
	LDA $06					;$01CC16	|
	SBC $0A					;$01CC18	|
	STA $06					;$01CC1A	|
	LDA.w $14B2				;$01CC1C	|
	SEC					;$01CC1F	|
	SBC $05					;$01CC20	|
	STA.w $14BA				;$01CC22	|
	SEP #$20				;$01CC25	|
	RTS					;$01CC27	|

CODE_01CC28:
	LDA $00
	STA.w $4202				;$01CC2A	|
	LDA $02					;$01CC2D	|
	STA.w $4203				;$01CC2F	|
	JSR DoNothing				;$01CC32	|
	LDA.w $4216				;$01CC35	|
	STA $04					;$01CC38	|
	LDA.w $4217				;$01CC3A	|
	STA $05					;$01CC3D	|
	LDA $00					;$01CC3F	|
	STA.w $4202				;$01CC41	|
	LDA $03					;$01CC44	|
	STA.w $4203				;$01CC46	|
	JSR DoNothing				;$01CC49	|
	LDA.w $4216				;$01CC4C	|
	CLC					;$01CC4F	|
	ADC $05					;$01CC50	|
	STA $05					;$01CC52	|
	LDA.w $4217				;$01CC54	|
	ADC.b #$00				;$01CC57	|
	STA $06					;$01CC59	|
	LDA $01					;$01CC5B	|
	STA.w $4202				;$01CC5D	|
	LDA $02					;$01CC60	|
	STA.w $4203				;$01CC62	|
	JSR DoNothing				;$01CC65	|
	LDA.w $4216				;$01CC68	|
	CLC					;$01CC6B	|
	ADC $05					;$01CC6C	|
	STA $05					;$01CC6E	|
	LDA.w $4217				;$01CC70	|
	ADC $06					;$01CC73	|
	STA $06					;$01CC75	|
	LDA $01					;$01CC77	|
	STA.w $4202				;$01CC79	|
	LDA $03					;$01CC7C	|
	STA.w $4203				;$01CC7E	|
	JSR DoNothing				;$01CC81	|
	LDA.w $4216				;$01CC84	|
	CLC					;$01CC87	|
	ADC $06					;$01CC88	|
	STA $06					;$01CC8A	|
	LDA.w $4217				;$01CC8C	|
	ADC.b #$00				;$01CC8F	|
	STA $07					;$01CC91	|
	RTS					;$01CC93	|

DoNothing:
	NOP
	NOP					;$01CC95	|
	NOP					;$01CC96	|
	NOP					;$01CC97	|
	NOP					;$01CC98	|
	NOP					;$01CC99	|
	NOP					;$01CC9A	|
	NOP					;$01CC9B	|
	RTS					;$01CC9C	|

CODE_01CC9D:
	LDA.w $14B5
	ORA.w $14B7				;$01CCA0	|
	BNE CODE_01CCC5				;$01CCA3	|
	JSR CODE_01CCC7				;$01CCA5	|
	JSR CODE_01CB20				;$01CCA8	|
	JSR CODE_01CB53				;$01CCAB	|
	LDA.w $14BA				;$01CCAE	|
	AND.b #$F0				;$01CCB1	|
	STA $00					;$01CCB3	|
	LDA.w $14B8				;$01CCB5	|
	LSR					;$01CCB8	|
	LSR					;$01CCB9	|
	LSR					;$01CCBA	|
	LSR					;$01CCBB	|
	ORA $00					;$01CCBC	|
	TAY					;$01CCBE	|
	LDA.w $0AF6,Y				;$01CCBF	|
	CMP.b #$15				;$01CCC2	|
	RTL					;$01CCC4	|

CODE_01CCC5:
	CLC
	RTL					;$01CCC6	|

CODE_01CCC7:
	REP #$20
	LDA $2A					;$01CCC9	|
	STA.w $14B0				;$01CCCB	|
	LDA $2C					;$01CCCE	|
	STA.w $14B2				;$01CCD0	|
	LDA.w $14B4				;$01CCD3	|
	SEC					;$01CCD6	|
	SBC.w $14B0				;$01CCD7	|
	STA.w $14BC				;$01CCDA	|
	LDA.w $14B6				;$01CCDD	|
	SEC					;$01CCE0	|
	SBC.w $14B2				;$01CCE1	|
	STA.w $14BF				;$01CCE4	|
	SEP #$20				;$01CCE7	|
	RTS					;$01CCE9	|

	RTS					;$01CCEA	|

	RTS					;$01CCEB	|

CODE_01CCEC:
	EOR.b #$FF
	INC A					;$01CCEE	|
	RTS					;$01CCEF	|

CODE_01CCF0:
	LDA.w $1504,X
	ASL					;$01CCF3	|
	ASL					;$01CCF4	|
	ASL					;$01CCF5	|
	ASL					;$01CCF6	|
	CLC					;$01CCF7	|
	ADC.w $1510,X				;$01CCF8	|
	STA.w $1510,X				;$01CCFB	|
	PHP					;$01CCFE	|
	LDY.b #$00				;$01CCFF	|
	LDA.w $1504,X				;$01CD01	|
	LSR					;$01CD04	|
	LSR					;$01CD05	|
	LSR					;$01CD06	|
	LSR					;$01CD07	|
	CMP.b #$08				;$01CD08	|
	BCC CODE_01CD0F				;$01CD0A	|
	ORA.b #$F0				;$01CD0C	|
	DEY					;$01CD0E	|
CODE_01CD0F:
	PLP
	ADC.w $151C,X				;$01CD10	|
	STA.w $151C,X				;$01CD13	|
	TYA					;$01CD16	|
	ADC.w $1528,X				;$01CD17	|
	STA.w $1528,X				;$01CD1A	|
	RTS					;$01CD1D	|

DATA_01CD1E:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF

PipeKoopaKids:
	JSL CODE_03CC09
	RTS					;$01CD2E	|

InitKoopaKid:
	LDA $D8,X
	LSR					;$01CD31	|
	LSR					;$01CD32	|
	LSR					;$01CD33	|
	LSR					;$01CD34	|
	STA $C2,X				;$01CD35	|
	CMP.b #$05				;$01CD37	|
	BCC CODE_01CD4E				;$01CD39	|
	LDA.b #$78				;$01CD3B	|
	STA $E4,X				;$01CD3D	|
	LDA.b #$40				;$01CD3F	|
	STA $D8,X				;$01CD41	|
	LDA.b #$01				;$01CD43	|
	STA.w $14D4,X				;$01CD45	|
	LDA.b #$80				;$01CD48	|
	STA.w $1540,X				;$01CD4A	|
	RTS					;$01CD4D	|

CODE_01CD4E:
	LDY.b #$90
	STY $D8,X				;$01CD50	|
	CMP.b #$03				;$01CD52	|
	BCC CODE_01CD5E				;$01CD54	|
	JSL CODE_00FCF5				;$01CD56	|
	JSR FaceMario				;$01CD5A	|
	RTS					;$01CD5D	|

CODE_01CD5E:
	LDA.b #$01
	STA.w $157C,X				;$01CD60	|
	LDA.b #$20				;$01CD63	|
	STA $38					;$01CD65	|
	STA $39					;$01CD67	|
	JSL CODE_03DD7D				;$01CD69	|
	LDY $C2,X				;$01CD6D	|
	LDA.w DATA_01CD92,Y			;$01CD6F	|
	STA.w $187B,X				;$01CD72	|
	CMP.b #$01				;$01CD75	|
	BEQ CODE_01CD87				;$01CD77	|
	CMP.b #$00				;$01CD79	|
	BNE CODE_01CD81				;$01CD7B	|
	LDA.b #$70				;$01CD7D	|
	STA $E4,X				;$01CD7F	|
CODE_01CD81:
	LDA.b #$01
	STA.w $14E0,X				;$01CD83	|
	RTS					;$01CD86	|

CODE_01CD87:
	LDA.b #$26
	STA.w $1534,X				;$01CD89	|
	LDA.b #$D8				;$01CD8C	|
	STA.w $160E,X				;$01CD8E	|
	RTS					;$01CD91	|

DATA_01CD92:
	db $01,$01,$00,$02,$02,$03,$03

DATA_01CD99:
	db $00,$09,$12

DATA_01CD9C:
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $08

DATA_01CDA5:
	db $00,$80

CODE_01CDA7:
	JSR GetDrawInfoBnk1
	RTS					;$01CDAA	|

WallKoopaKids:
	STZ.w $13FB
	LDA.w $1602,X				;$01CDAE	|
	CMP.b #$1B				;$01CDB1	|
	BCS CODE_01CDD5				;$01CDB3	|
	LDA.w $15AC,X				;$01CDB5	|
	CMP.b #$08				;$01CDB8	|
	LDY.w $157C,X				;$01CDBA	|
	LDA.w DATA_01CDA5,Y			;$01CDBD	|
	BCS CODE_01CDC4				;$01CDC0	|
	EOR.b #$80				;$01CDC2	|
CODE_01CDC4:
	STA $00
	LDY $C2,X				;$01CDC6	|
	LDA.w DATA_01CD99,Y			;$01CDC8	|
	LDY.w $1602,X				;$01CDCB	|
	CLC					;$01CDCE	|
	ADC.w DATA_01CD9C,Y			;$01CDCF	|
	CLC					;$01CDD2	|
	ADC $00					;$01CDD3	|
CODE_01CDD5:
	STA.w $1BA2
	JSL CODE_03DEDF				;$01CDD8	|
	JSR CODE_01CDA7				;$01CDDC	|
	LDA $9D					;$01CDDF	|
	BNE Return01CE3D			;$01CDE1	|
	JSR CODE_01D2A8				;$01CDE3	|
	JSR CODE_01D3B1				;$01CDE6	|
	LDA.w $187B,X				;$01CDE9	|
	CMP.b #$01				;$01CDEC	|
	BEQ CODE_01CE0B				;$01CDEE	|
	LDA.w $163E,X				;$01CDF0	|
	BNE CODE_01CE0B				;$01CDF3	|
	LDA.w $157C,X				;$01CDF5	|
	PHA					;$01CDF8	|
	JSR SubHorizPos				;$01CDF9	|
	TYA					;$01CDFC	|
	STA.w $157C,X				;$01CDFD	|
	PLA					;$01CE00	|
	CMP.w $157C,X				;$01CE01	|
	BEQ CODE_01CE0B				;$01CE04	|
	LDA.b #$10				;$01CE06	|
	STA.w $15AC,X				;$01CE08	|
CODE_01CE0B:
	LDA.w $151C,X
	JSL ExecutePtr				;$01CE0E	|

MortonPtrs1:
	dw CODE_01CE1E
	dw CODE_01CE3E
	dw CODE_01CE5F
	dw CODE_01CF7D
	dw CODE_01CFE0
	dw CODE_01D043

CODE_01CE1E:
	LDA.w $187B,X
	CMP.b #$01				;$01CE21	|
	BNE CODE_01CE34				;$01CE23	|
	STZ.w $1411				;$01CE25	|
	INC.w $18A8				;$01CE28	|
	STZ.w $18AA				;$01CE2B	|
	INC $9D					;$01CE2E	|
	INC.w $151C,X				;$01CE30	|
	RTS					;$01CE33	|

CODE_01CE34:
	LDA $1A
	CMP.b #$7E				;$01CE36	|
	BCC Return01CE3D			;$01CE38	|
	INC.w $151C,X				;$01CE3A	|
Return01CE3D:
	RTS

CODE_01CE3E:
	STZ $7B
	JSR SubSprYPosNoGrvty			;$01CE40	|
	LDA $AA,X				;$01CE43	|
	CMP.b #$40				;$01CE45	|
	BPL CODE_01CE4C				;$01CE47	|
	CLC					;$01CE49	|
	ADC.b #$03				;$01CE4A	|
CODE_01CE4C:
	STA $AA,X
	JSR CODE_01D0C0				;$01CE4E	|
	BCC Return01CE3D			;$01CE51	|
	INC.w $151C,X				;$01CE53	|
	LDA $C2,X				;$01CE56	|
	CMP.b #$02				;$01CE58	|
	BCC Return01CE3D			;$01CE5A	|
	JMP CODE_01CEA8				;$01CE5C	|

CODE_01CE5F:
	LDA $C2,X
	JSL ExecutePtr				;$01CE61	|

MortonPtrs2:
	dw CODE_01D116
	dw CODE_01D116
	dw CODE_01CE6B

CODE_01CE6B:
	LDA.w $1528,X
	JSL ExecutePtr				;$01CE6E	|

Ptrs01CE72:
	dw CODE_01CE78
	dw CODE_01CEB6
	dw CODE_01CEFD

CODE_01CE78:
	STZ $36
	STZ $37					;$01CE7A	|
	LDA.w $1540,X				;$01CE7C	|
	BEQ CODE_01CEA5				;$01CE7F	|
	LDY.b #$03				;$01CE81	|
	AND.b #$30				;$01CE83	|
	BNE CODE_01CE88				;$01CE85	|
	INY					;$01CE87	|
CODE_01CE88:
	TYA
	LDY.w $15AC,X				;$01CE89	|
	BEQ CODE_01CE90				;$01CE8C	|
	LDA.b #$05				;$01CE8E	|
CODE_01CE90:
	STA.w $1602,X
	LDA.w $1540,X				;$01CE93	|
	AND.b #$3F				;$01CE96	|
	CMP.b #$2E				;$01CE98	|
	BNE Return01CEA4			;$01CE9A	|
	LDA.b #$30				;$01CE9C	|
	STA.w $163E,X				;$01CE9E	|
	JSR CODE_01D059				;$01CEA1	|
Return01CEA4:
	RTS

CODE_01CEA5:
	INC.w $1528,X
CODE_01CEA8:
	LDA.b #$FF
	STA.w $1540,X				;$01CEAA	|
	RTS					;$01CEAD	|

DATA_01CEAE:
	db $30,$D0

DATA_01CEB0:
	db $1B,$1C,$1D,$1B

DATA_01CEB4:
	db $14,$EC

CODE_01CEB6:
	LDA.w $1540,X
	BNE CODE_01CEDC				;$01CEB9	|
	JSR SubHorizPos				;$01CEBB	|
	TYA					;$01CEBE	|
	CMP.w $14E0,X				;$01CEBF	|
	BNE CODE_01CEDC				;$01CEC2	|
	INC.w $1528,X				;$01CEC4	|
	LDA.w DATA_01CEB4,Y			;$01CEC7	|
	STA.w $160E,X				;$01CECA	|
	LDA.b #$30				;$01CECD	|
	STA.w $1540,X				;$01CECF	|
	LDA.b #$60				;$01CED2	|
	STA.w $1558,X				;$01CED4	|
	LDA.b #$D8				;$01CED7	|
	STA $AA,X				;$01CED9	|
	RTS					;$01CEDB	|

CODE_01CEDC:
	JSR SubHorizPos
	LDA $B6,X				;$01CEDF	|
	CMP.w DATA_01CEAE,Y			;$01CEE1	|
	BEQ CODE_01CEEC				;$01CEE4	|
	CLC					;$01CEE6	|
	ADC.w DATA_01D4E7,Y			;$01CEE7	|
	STA $B6,X				;$01CEEA	|
CODE_01CEEC:
	JSR SubSprXPosNoGrvty
	LDA $14					;$01CEEF	|
	LSR					;$01CEF1	|
	LSR					;$01CEF2	|
	AND.b #$03				;$01CEF3	|
	TAY					;$01CEF5	|
	LDA.w DATA_01CEB0,Y			;$01CEF6	|
	STA.w $1602,X				;$01CEF9	|
	RTS					;$01CEFC	|

CODE_01CEFD:
	LDA.w $1540,X
	BEQ CODE_01CF1C				;$01CF00	|
	DEC A					;$01CF02	|
	BNE CODE_01CF0F				;$01CF03	|
	LDA.w $160E,X				;$01CF05	|
	STA $B6,X				;$01CF08	|
	LDA.b #$08				;$01CF0A	|
	STA.w $1DFC				;$01CF0C	|
CODE_01CF0F:
	LDA $B6,X
	BEQ Return01CF1B			;$01CF11	|
	BPL CODE_01CF19				;$01CF13	|
	INC $B6,X				;$01CF15	|
	INC $B6,X				;$01CF17	|
CODE_01CF19:
	DEC $B6,X
Return01CF1B:
	RTS

CODE_01CF1C:
	JSR CODE_01D0C0
	BCC CODE_01CF2F				;$01CF1F	|
	LDA $AA,X				;$01CF21	|
	BMI CODE_01CF2F				;$01CF23	|
	STZ $B6,X				;$01CF25	|
	STZ $AA,X				;$01CF27	|
	STZ.w $1528,X				;$01CF29	|
	JMP CODE_01CEA8				;$01CF2C	|

CODE_01CF2F:
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty			;$01CF32	|
	LDA $13					;$01CF35	|
	LSR					;$01CF37	|
	BCS CODE_01CF44				;$01CF38	|
	LDA $AA,X				;$01CF3A	|
	BMI CODE_01CF42				;$01CF3C	|
	CMP.b #$70				;$01CF3E	|
	BCS CODE_01CF44				;$01CF40	|
CODE_01CF42:
	INC $AA,X
CODE_01CF44:
	LDA.w $1558,X
	BNE CODE_01CF4F				;$01CF47	|
	LDA $36					;$01CF49	|
	ORA $37					;$01CF4B	|
	BEQ CODE_01CF67				;$01CF4D	|
CODE_01CF4F:
	LDA $B6,X
	ASL					;$01CF51	|
	LDA.b #$04				;$01CF52	|
	LDY.b #$00				;$01CF54	|
	BCC CODE_01CF5B				;$01CF56	|
	LDA.b #$FC				;$01CF58	|
	DEY					;$01CF5A	|
CODE_01CF5B:
	CLC
	ADC $36					;$01CF5C	|
	STA $36					;$01CF5E	|
	TYA					;$01CF60	|
	ADC $37					;$01CF61	|
	AND.b #$01				;$01CF63	|
	STA $37					;$01CF65	|
CODE_01CF67:
	LDA.b #$06
	LDY $AA,X				;$01CF69	|
	BMI CODE_01CF79				;$01CF6B	|
	CPY.b #$08				;$01CF6D	|
	BCC CODE_01CF79				;$01CF6F	|
	LDA.b #$05				;$01CF71	|
	CPY.b #$10				;$01CF73	|
	BCC CODE_01CF79				;$01CF75	|
	LDA.b #$02				;$01CF77	|
CODE_01CF79:
	STA.w $1602,X
	RTS					;$01CF7C	|

CODE_01CF7D:
	JSR SubSprYPosNoGrvty
	INC $AA,X				;$01CF80	|
	JSR CODE_01D0C0				;$01CF82	|
	LDA.w $1540,X				;$01CF85	|
	BEQ CODE_01CFB7				;$01CF88	|
	CMP.b #$40				;$01CF8A	|
	BCC CODE_01CF9E				;$01CF8C	|
	BEQ CODE_01CFC6				;$01CF8E	|
	LDY.b #$06				;$01CF90	|
	LDA $14					;$01CF92	|
	AND.b #$04				;$01CF94	|
	BEQ CODE_01CF99				;$01CF96	|
	INY					;$01CF98	|
CODE_01CF99:
	TYA
	STA.w $1602,X				;$01CF9A	|
	RTS					;$01CF9D	|

CODE_01CF9E:
	LDY.w $18A6
	LDA $38					;$01CFA1	|
	CMP.b #$20				;$01CFA3	|
	BEQ CODE_01CFA9				;$01CFA5	|
	INC $38					;$01CFA7	|
CODE_01CFA9:
	LDA $39
	CMP.b #$20				;$01CFAB	|
	BEQ CODE_01CFB1				;$01CFAD	|
	DEC $39					;$01CFAF	|
CODE_01CFB1:
	LDA.b #$07
	STA.w $1602,X				;$01CFB3	|
	RTS					;$01CFB6	|

CODE_01CFB7:
	LDA.b #$02
	STA.w $151C,X				;$01CFB9	|
	LDA $C2,X				;$01CFBC	|
	BEQ Return01CFC5			;$01CFBE	|
	LDA.b #$20				;$01CFC0	|
	STA.w $164A,X				;$01CFC2	|
Return01CFC5:
	RTS

CODE_01CFC6:
	INC.w $1626,X
	LDA.w $1626,X				;$01CFC9	|
	CMP.b #$03				;$01CFCC	|
	BCC Return01CFDF			;$01CFCE	|
CODE_01CFD0:
	LDA.b #$1F
	STA.w $1DF9				;$01CFD2	|
	LDA.b #$04				;$01CFD5	|
	STA.w $151C,X				;$01CFD7	|
	LDA.b #$13				;$01CFDA	|
	STA.w $1540,X				;$01CFDC	|
Return01CFDF:
	RTS

CODE_01CFE0:
	LDY.w $1540,X
	BEQ CODE_01CFFC				;$01CFE3	|
	LDA $D8,X				;$01CFE5	|
	SEC					;$01CFE7	|
	SBC.b #$01				;$01CFE8	|
	STA $D8,X				;$01CFEA	|
	BCS CODE_01CFF1				;$01CFEC	|
	DEC.w $14D4,X				;$01CFEE	|
CODE_01CFF1:
	DEC $39
	TYA					;$01CFF3	|
	AND.b #$03				;$01CFF4	|
	BEQ CODE_01CFFA				;$01CFF6	|
	DEC $38					;$01CFF8	|
CODE_01CFFA:
	BRA CODE_01D00F

CODE_01CFFC:
	LDA $36
	CLC					;$01CFFE	|
	ADC.b #$06				;$01CFFF	|
	STA $36					;$01D001	|
	LDA $37					;$01D003	|
	ADC.b #$00				;$01D005	|
	AND.b #$01				;$01D007	|
	STA $37					;$01D009	|
	INC $38					;$01D00B	|
	INC $39					;$01D00D	|
CODE_01D00F:
	LDA $39
	CMP.b #$A0				;$01D011	|
	BCC Return01D042			;$01D013	|
	LDA.w $15A0,X				;$01D015	|
	BNE CODE_01D032				;$01D018	|
	LDA.b #$01				;$01D01A	|
	STA.w $17C0				;$01D01C	|
	LDA $E4,X				;$01D01F	|
	SBC.b #$08				;$01D021	|
	STA.w $17C8				;$01D023	|
	LDA $D8,X				;$01D026	|
	ADC.b #$08				;$01D028	|
	STA.w $17C4				;$01D02A	|
	LDA.b #$1B				;$01D02D	|
	STA.w $17CC				;$01D02F	|
CODE_01D032:
	LDA.b #$D0
	STA $D8,X				;$01D034	|
	JSL CODE_03DEDF				;$01D036	|
	INC.w $151C,X				;$01D03A	|
	LDA.b #$30				;$01D03D	|
	STA.w $1540,X				;$01D03F	|
Return01D042:
	RTS

CODE_01D043:
	LDA.w $1540,X
	BNE Return01D056			;$01D046	|
	INC.w $13C6				;$01D048	|
	DEC.w $1493				;$01D04B	|
	LDA.b #$0B				;$01D04E	|
	STA.w $1DFB				;$01D050	|
	STZ.w $14C8,X				;$01D053	|
Return01D056:
	RTS

DATA_01D057:
	db $FF,$F1

CODE_01D059:
	LDA.b #$17
	STA.w $1DFC				;$01D05B	|
	LDY.b #$04				;$01D05E	|
CODE_01D060:
	LDA.w $14C8,Y
	BEQ CODE_01D069				;$01D063	|
	DEY					;$01D065	|
	BPL CODE_01D060				;$01D066	|
	RTS					;$01D068	|

CODE_01D069:
	LDA.b #$08
	STA.w $14C8,Y				;$01D06B	|
	LDA.b #$34				;$01D06E	|
	STA.w $009E,y				;$01D070	|
	LDA $E4,X				;$01D073	|
	STA $00					;$01D075	|
	LDA.w $14E0,X				;$01D077	|
	STA $01					;$01D07A	|
	LDA $D8,X				;$01D07C	|
	CLC					;$01D07E	|
	ADC.b #$03				;$01D07F	|
	STA.w $00D8,y				;$01D081	|
	LDA.w $14D4,X				;$01D084	|
	ADC.b #$00				;$01D087	|
	STA.w $14D4,Y				;$01D089	|
	LDA.w $157C,X				;$01D08C	|
	PHX					;$01D08F	|
	TAX					;$01D090	|
	LDA $00					;$01D091	|
	CLC					;$01D093	|
	ADC.w DATA_01D057,X			;$01D094	|
	STA.w $00E4,y				;$01D097	|
	LDA $01					;$01D09A	|
	ADC.b #$FF				;$01D09C	|
	STA.w $14E0,Y				;$01D09E	|
	PLX					;$01D0A1	|
	PHX					;$01D0A2	|
	TYX					;$01D0A3	|
	JSL InitSpriteTables			;$01D0A4	|
	PLX					;$01D0A8	|
	PHX					;$01D0A9	|
	LDA.w $157C,X				;$01D0AA	|
	STA.w $157C,Y				;$01D0AD	|
	TAX					;$01D0B0	|
	LDA.w DATA_01D0BE,X			;$01D0B1	|
	STA.w $00B6,y				;$01D0B4	|
	LDA.b #$30				;$01D0B7	|
	STA.w $1540,Y				;$01D0B9	|
	PLX					;$01D0BC	|
	RTS					;$01D0BD	|

DATA_01D0BE:
	db $20,$E0

CODE_01D0C0:
	LDA $AA,X
	BMI CODE_01D0DC				;$01D0C2	|
	LDA.w $14D4,X				;$01D0C4	|
	BNE CODE_01D0DC				;$01D0C7	|
	LDA $39					;$01D0C9	|
	LSR					;$01D0CB	|
	TAY					;$01D0CC	|
	LDA $D8,X				;$01D0CD	|
	CMP.w $D0D6,Y				;$01D0CF	|
	BCC CODE_01D0DC				;$01D0D2	|
	LDA.w DATA_01D0DE-8,Y			;$01D0D4	|
	STA $D8,X				;$01D0D7	|
	STZ $AA,X				;$01D0D9	|
	RTS					;$01D0DB	|

CODE_01D0DC:
	CLC
	RTS					;$01D0DD	|

DATA_01D0DE:
	db $80,$83,$85,$88,$8A,$8B,$8D,$8F
	db $90,$91,$91,$92,$92,$93,$93,$94
	db $94,$95,$95,$96,$96,$97,$97,$98
	db $98,$98,$99,$99,$9A,$9A,$9B,$9B
	db $9C,$9C,$9C,$9C,$9D,$9D,$9D,$9D
	db $9E,$9E,$9E,$9E,$9E,$9F,$9F,$9F
	db $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F

CODE_01D116:
	LDA.w $1528,X
	JSL ExecutePtr				;$01D119	|

MortonPtrs3:
	dw CODE_01D146
	dw CODE_01D23F

	RTS					;$01D121	|

DATA_01D122:
	db $F0,$00,$10,$00,$F0,$00,$10,$00
	db $E8,$00,$18,$00

DATA_01D12E:
	db $00,$F0,$00,$10,$00,$F0,$00,$10
	db $00,$E8,$00,$18,$26,$26,$D8,$D8
DATA_01D13E:
	db $90,$30,$30,$90

DATA_01D142:
	db $00,$01,$02,$01

CODE_01D146:
	LDA $14
	LSR					;$01D148	|
	LDY.w $1626,X				;$01D149	|
	CPY.b #$02				;$01D14C	|
	BCS CODE_01D151				;$01D14E	|
	LSR					;$01D150	|
CODE_01D151:
	AND.b #$03
	TAY					;$01D153	|
	LDA.w DATA_01D142,Y			;$01D154	|
	LDY.w $15AC,X				;$01D157	|
	BEQ CODE_01D15E				;$01D15A	|
	LDA.b #$05				;$01D15C	|
CODE_01D15E:
	STA.w $1602,X
	LDA.w $164A,X				;$01D161	|
	BEQ CODE_01D17C				;$01D164	|
	LDY $E4,X				;$01D166	|
	CPY.b #$50				;$01D168	|
	BCC CODE_01D17C				;$01D16A	|
	CPY.b #$80				;$01D16C	|
	BCS CODE_01D17C				;$01D16E	|
	DEC.w $164A,X				;$01D170	|
	LSR					;$01D173	|
	BCS CODE_01D17C				;$01D174	|
	INC.w $1534,X				;$01D176	|
	DEC.w $160E,X				;$01D179	|
CODE_01D17C:
	LDA.w $1534,X
	STA $05					;$01D17F	|
	STA $06					;$01D181	|
	STA $0B					;$01D183	|
	STA $0C					;$01D185	|
	LDA.w $160E,X				;$01D187	|
	STA $07					;$01D18A	|
	STA $08					;$01D18C	|
	STA $09					;$01D18E	|
	STA $0A					;$01D190	|
	LDA $36					;$01D192	|
	ASL					;$01D194	|
	BEQ CODE_01D19A				;$01D195	|
	JMP CODE_01D224				;$01D197	|

CODE_01D19A:
	LDY.w $1594,X
	TYA					;$01D19D	|
	LSR					;$01D19E	|
	BCS CODE_01D1B5				;$01D19F	|
	LDA $E4,X				;$01D1A1	|
	CPY.b #$00				;$01D1A3	|
	BNE CODE_01D1AE				;$01D1A5	|
	CMP.w $1534,X				;$01D1A7	|
	BCC CODE_01D215				;$01D1AA	|
	BRA CODE_01D1D8				;$01D1AC	|

CODE_01D1AE:
	CMP.w $160E,X
	BCS CODE_01D215				;$01D1B1	|
	BRA CODE_01D1D8				;$01D1B3	|

CODE_01D1B5:
	LDA.w $157C,X
	BNE CODE_01D1BE				;$01D1B8	|
	INY					;$01D1BA	|
	INY					;$01D1BB	|
	INY					;$01D1BC	|
	INY					;$01D1BD	|
CODE_01D1BE:
	LDA.w $0005,Y
	STA $E4,X				;$01D1C1	|
	LDY.w $1594,X				;$01D1C3	|
	LDA $D8,X				;$01D1C6	|
	CPY.b #$03				;$01D1C8	|
	BEQ ADDR_01D1D3				;$01D1CA	|
	CMP.w DATA_01D13E,Y			;$01D1CC	|
	BCC CODE_01D215				;$01D1CF	|
	BRA CODE_01D1D8				;$01D1D1	|

ADDR_01D1D3:
	CMP.w DATA_01D13E,Y
	BCS CODE_01D215				;$01D1D6	|
CODE_01D1D8:
	LDA.w $1626,X
	CMP.b #$02				;$01D1DB	|
	BCC CODE_01D1E1				;$01D1DD	|
	LDA.b #$02				;$01D1DF	|
CODE_01D1E1:
	ASL
	ASL					;$01D1E2	|
	ADC.w $1594,X				;$01D1E3	|
	TAY					;$01D1E6	|
	LDA.w DATA_01D122,Y			;$01D1E7	|
	STA $B6,X				;$01D1EA	|
	LDA.w DATA_01D12E,Y			;$01D1EC	|
	STA $AA,X				;$01D1EF	|
	JSR SubSprXPosNoGrvty			;$01D1F1	|
	JSR SubSprYPosNoGrvty			;$01D1F4	|
	LDA.w $1594,X				;$01D1F7	|
	LDY.w $157C,X				;$01D1FA	|
	BNE CODE_01D201				;$01D1FD	|
	EOR.b #$02				;$01D1FF	|
CODE_01D201:
	CMP.b #$02
	BNE Return01D214			;$01D203	|
	JSR SubHorizPos				;$01D205	|
	LDA $0F					;$01D208	|
	CLC					;$01D20A	|
	ADC.b #$10				;$01D20B	|
	CMP.b #$20				;$01D20D	|
	BCS Return01D214			;$01D20F	|
	INC.w $1528,X				;$01D211	|
Return01D214:
	RTS

CODE_01D215:
	LDY.w $157C,X
	LDA.w $1594,X				;$01D218	|
	CLC					;$01D21B	|
	ADC.w DATA_01D23D,Y			;$01D21C	|
	AND.b #$03				;$01D21F	|
	STA.w $1594,X				;$01D221	|
CODE_01D224:
	LDY.w $157C,X
	LDA $36					;$01D227	|
	CLC					;$01D229	|
	ADC.w DATA_01D239,Y			;$01D22A	|
	STA $36					;$01D22D	|
	LDA $37					;$01D22F	|
	ADC.w DATA_01D23B,Y			;$01D231	|
	AND.b #$01				;$01D234	|
	STA $37					;$01D236	|
	RTS					;$01D238	|

DATA_01D239:
	db $FC,$04

DATA_01D23B:
	db $FF,$00

DATA_01D23D:
	db $FF,$01

CODE_01D23F:
	LDA.w $1540,X
	BEQ CODE_01D25E				;$01D242	|
	CMP.b #$01				;$01D244	|
	BNE Return01D2A7			;$01D246	|
	STZ.w $1528,X				;$01D248	|
	JSR SubHorizPos				;$01D24B	|
	TYA					;$01D24E	|
	STA.w $157C,X				;$01D24F	|
	ASL					;$01D252	|
	EOR.b #$02				;$01D253	|
	STA.w $1594,X				;$01D255	|
	LDA.b #$0A				;$01D258	|
	STA.w $15AC,X				;$01D25A	|
	RTS					;$01D25D	|

CODE_01D25E:
	LDA.b #$06
	STA.w $1602,X				;$01D260	|
	JSR SubSprYPosNoGrvty			;$01D263	|
	LDA $AA,X				;$01D266	|
	CMP.b #$70				;$01D268	|
	BCS CODE_01D271				;$01D26A	|
	CLC					;$01D26C	|
	ADC.b #$04				;$01D26D	|
	STA $AA,X				;$01D26F	|
CODE_01D271:
	LDA $36
	ORA $37					;$01D273	|
	BEQ CODE_01D286				;$01D275	|
	LDA $36					;$01D277	|
	CLC					;$01D279	|
	ADC.b #$08				;$01D27A	|
	STA $36					;$01D27C	|
	LDA $37					;$01D27E	|
	ADC.b #$00				;$01D280	|
	AND.b #$01				;$01D282	|
	STA $37					;$01D284	|
CODE_01D286:
	JSR CODE_01D0C0
	BCC Return01D2A7			;$01D289	|
	LDA.b #$20				;$01D28B	|
	STA.w $1887				;$01D28D	|
	LDA $72					;$01D290	|
	BNE CODE_01D299				;$01D292	|
	LDA.b #$28				;$01D294	|
	STA.w $18BD				;$01D296	|
CODE_01D299:
	LDA.b #$09
	STA.w $1DFC				;$01D29B	|
	LDA.b #$28				;$01D29E	|
	STA.w $1540,X				;$01D2A0	|
	STZ $36					;$01D2A3	|
	STZ $37					;$01D2A5	|
Return01D2A7:
	RTS

CODE_01D2A8:
	LDA.w $151C,X
	CMP.b #$03				;$01D2AB	|
	BCS Return01D318			;$01D2AD	|
	LDA.w $187B,X				;$01D2AF	|
	CMP.b #$03				;$01D2B2	|
	BNE CODE_01D2BD				;$01D2B4	|
	LDA.w $1528,X				;$01D2B6	|
	CMP.b #$03				;$01D2B9	|
	BCS Return01D318			;$01D2BB	|
CODE_01D2BD:
	JSL GetMarioClipping
	JSR CODE_01D40B				;$01D2C1	|
	JSL CheckForContact			;$01D2C4	|
	BCC Return01D318			;$01D2C8	|
	LDA.w $1FE2,X				;$01D2CA	|
	BNE Return01D318			;$01D2CD	|
	LDA.b #$08				;$01D2CF	|
	STA.w $1FE2,X				;$01D2D1	|
	LDA $72					;$01D2D4	|
	BEQ CODE_01D319				;$01D2D6	|
	LDA.w $1602,X				;$01D2D8	|
	CMP.b #$10				;$01D2DB	|
	BCS CODE_01D2E3				;$01D2DD	|
	CMP.b #$06				;$01D2DF	|
	BCS ADDR_01D31E				;$01D2E1	|
CODE_01D2E3:
	LDA $96
	CLC					;$01D2E5	|
	ADC.b #$08				;$01D2E6	|
	CMP $D8,X				;$01D2E8	|
	BCS ADDR_01D31E				;$01D2EA	|
	LDA.w $1594,X				;$01D2EC	|
	LSR					;$01D2EF	|
	BCS CODE_01D334				;$01D2F0	|
	LDA $7D					;$01D2F2	|
	BMI Return01D31D			;$01D2F4	|
	JSR CODE_01D351				;$01D2F6	|
	LDA.b #$D0				;$01D2F9	|
	STA $7D					;$01D2FB	|
	LDA.b #$02				;$01D2FD	|
	STA.w $1DF9				;$01D2FF	|
	LDA.w $1602,X				;$01D302	|
	CMP.b #$1B				;$01D305	|
	BCC CODE_01D379				;$01D307	|
ADDR_01D309:
	LDY.b #$20
	LDA $E4,X				;$01D30B	|
	SEC					;$01D30D	|
	SBC.b #$08				;$01D30E	|
	CMP $94					;$01D310	|
	BMI ADDR_01D316				;$01D312	|
	LDY.b #$E0				;$01D314	|
ADDR_01D316:
	STY $7B
Return01D318:
	RTS

CODE_01D319:
	JSL HurtMario
Return01D31D:
	RTS

ADDR_01D31E:
	LDA.b #$01
	STA.w $1DF9				;$01D320	|
	LDA $7D					;$01D323	|
	BPL ADDR_01D32C				;$01D325	|
	LDA.b #$10				;$01D327	|
	STA $7D					;$01D329	|
	RTS					;$01D32B	|

ADDR_01D32C:
	JSR ADDR_01D309
	LDA.b #$D0				;$01D32F	|
	STA $7D					;$01D331	|
	RTS					;$01D333	|

CODE_01D334:
	LDA.b #$01
	STA.w $1DF9				;$01D336	|
	LDA $7D					;$01D339	|
	BPL CODE_01D342				;$01D33B	|
	LDA.b #$20				;$01D33D	|
	STA $7D					;$01D33F	|
	RTS					;$01D341	|

CODE_01D342:
	LDY.b #$20
	LDA $E4,X				;$01D344	|
	BPL CODE_01D34A				;$01D346	|
	LDY.b #$E0				;$01D348	|
CODE_01D34A:
	STY $7B
	LDA.b #$B0				;$01D34C	|
	STA $7D					;$01D34E	|
	RTS					;$01D350	|

CODE_01D351:
	LDA $E4,X
	PHA					;$01D353	|
	SEC					;$01D354	|
	SBC.b #$08				;$01D355	|
	STA $E4,X				;$01D357	|
	LDA.w $14E0,X				;$01D359	|
	PHA					;$01D35C	|
	SBC.b #$00				;$01D35D	|
	STA.w $14E0,X				;$01D35F	|
	LDA $D8,X				;$01D362	|
	PHA					;$01D364	|
	CLC					;$01D365	|
	ADC.b #$08				;$01D366	|
	STA $D8,X				;$01D368	|
	JSL DisplayContactGfx			;$01D36A	|
	PLA					;$01D36E	|
	STA $D8,X				;$01D36F	|
	PLA					;$01D371	|
	STA.w $14E0,X				;$01D372	|
	PLA					;$01D375	|
	STA $E4,X				;$01D376	|
	RTS					;$01D378	|

CODE_01D379:
	LDA.b #$18
	STA $38					;$01D37B	|
	PHX					;$01D37D	|
	LDA $39					;$01D37E	|
	LSR					;$01D380	|
	TAX					;$01D381	|
	LDA.b #$28				;$01D382	|
	STA $39					;$01D384	|
	LSR					;$01D386	|
	TAY					;$01D387	|
	LDA.w $D0D6,Y				;$01D388	|
	SEC					;$01D38B	|
	SBC.w $D0D6,X				;$01D38C	|
	PLX					;$01D38F	|
	CLC					;$01D390	|
	ADC $D8,X				;$01D391	|
	STA $D8,X				;$01D393	|
	LDA.w $14D4,X				;$01D395	|
	ADC.b #$00				;$01D398	|
	STA.w $14D4,X				;$01D39A	|
	STZ $B6,X				;$01D39D	|
	STZ $AA,X				;$01D39F	|
	LDA.b #$80				;$01D3A1	|
	STA.w $1540,X				;$01D3A3	|
	LDA.b #$03				;$01D3A6	|
	STA.w $151C,X				;$01D3A8	|
	LDA.b #$28				;$01D3AB	|
	STA.w $1DFC				;$01D3AD	|
	RTS					;$01D3B0	|

CODE_01D3B1:
	LDA.w $151C,X
	CMP.b #$03				;$01D3B4	|
	BCS Return01D40A			;$01D3B6	|
	LDY.b #$0A				;$01D3B8	|
CODE_01D3BA:
	STY.w $1695
	LDA.w $170B,Y				;$01D3BD	|
	CMP.b #$05				;$01D3C0	|
	BNE CODE_01D405				;$01D3C2	|
	LDA.w $171F,Y				;$01D3C4	|
	STA $00					;$01D3C7	|
	LDA.w $1733,Y				;$01D3C9	|
	STA $08					;$01D3CC	|
	LDA.w $1715,Y				;$01D3CE	|
	STA $01					;$01D3D1	|
	LDA.w $1729,Y				;$01D3D3	|
	STA $09					;$01D3D6	|
	LDA.b #$08				;$01D3D8	|
	STA $02					;$01D3DA	|
	STA $03					;$01D3DC	|
	PHY					;$01D3DE	|
	JSR CODE_01D40B				;$01D3DF	|
	PLY					;$01D3E2	|
	JSL CheckForContact			;$01D3E3	|
	BCC CODE_01D405				;$01D3E7	|
	LDA.b #$01				;$01D3E9	|
	STA.w $170B,Y				;$01D3EB	|
	LDA.b #$0F				;$01D3EE	|
	STA.w $176F,Y				;$01D3F0	|
	LDA.b #$01				;$01D3F3	|
	STA.w $1DF9				;$01D3F5	|
	INC.w $1626,X				;$01D3F8	|
	LDA.w $1626,X				;$01D3FB	|
	CMP.b #$0C				;$01D3FE	|
	BCC CODE_01D405				;$01D400	|
	JSR CODE_01CFD0				;$01D402	|
CODE_01D405:
	DEY
	CPY.b #$07				;$01D406	|
	BNE CODE_01D3BA				;$01D408	|
Return01D40A:
	RTS

CODE_01D40B:
	LDA $E4,X
	SEC					;$01D40D	|
	SBC.b #$08				;$01D40E	|
	STA $04					;$01D410	|
	LDA.w $14E0,X				;$01D412	|
	SBC.b #$00				;$01D415	|
	STA $0A					;$01D417	|
	LDA.b #$10				;$01D419	|
	STA $06					;$01D41B	|
	LDA.b #$10				;$01D41D	|
	STA $07					;$01D41F	|
	LDA.w $1602,X				;$01D421	|
	CMP.b #$69				;$01D424	|
	LDA.b #$08				;$01D426	|
	BCC CODE_01D42C				;$01D428	|
	ADC.b #$0A				;$01D42A	|
CODE_01D42C:
	CLC
	ADC $D8,X				;$01D42D	|
	STA $05					;$01D42F	|
	LDA.w $14D4,X				;$01D431	|
	ADC.b #$00				;$01D434	|
	STA $0B					;$01D436	|
	RTS					;$01D438	|

DATA_01D439:
	db $A8,$B0,$B8,$C0,$C8

	STZ.w $14C8,X				;$01D43E	|
	RTS					;$01D441	|

DATA_01D442:
	db $00,$F0,$00,$10

LudwigFireTiles:
	db $4A,$4C,$6A,$6C

DATA_01D44A:
	db $45,$45,$05,$05

BossFireball:
	LDA $9D
	ORA.w $13FB				;$01D450	|
	BNE CODE_01D487				;$01D453	|
	LDA.w $1540,X				;$01D455	|
	CMP.b #$10				;$01D458	|
	BCS CODE_01D487				;$01D45A	|
	TAY					;$01D45C	|
	BNE CODE_01D468				;$01D45D	|
	JSR SetAnimationFrame			;$01D45F	|
	JSR SetAnimationFrame			;$01D462	|
	JSR MarioSprInteractRt			;$01D465	|
CODE_01D468:
	JSR SubSprXPosNoGrvty
	LDA $E4,X				;$01D46B	|
	CLC					;$01D46D	|
	ADC.b #$20				;$01D46E	|
	STA $00					;$01D470	|
	LDA.w $14E0,X				;$01D472	|
	ADC.b #$00				;$01D475	|
	STA $01					;$01D477	|
	REP #$20				;$01D479	|
	LDA $00					;$01D47B	|
	CMP.w #$0230				;$01D47D	|
	SEP #$20				;$01D480	|
	BCC CODE_01D487				;$01D482	|
	STZ.w $14C8,X				;$01D484	|
CODE_01D487:
	JSR GetDrawInfoBnk1
	LDA.w $1602,X				;$01D48A	|
	ASL					;$01D48D	|
	STA $03					;$01D48E	|
	LDA.w $157C,X				;$01D490	|
	ASL					;$01D493	|
	STA $02					;$01D494	|
	LDA.w DATA_01D439,X			;$01D496	|
	STA.w $15EA,X				;$01D499	|
	TAY					;$01D49C	|
	PHX					;$01D49D	|
	LDA.w $1540,X				;$01D49E	|
	LDX.b #$01				;$01D4A1	|
	CMP.b #$08				;$01D4A3	|
	BCC CODE_01D4A8				;$01D4A5	|
	DEX					;$01D4A7	|
CODE_01D4A8:
	PHX
	PHX					;$01D4A9	|
	TXA					;$01D4AA	|
	CLC					;$01D4AB	|
	ADC $02					;$01D4AC	|
	TAX					;$01D4AE	|
	LDA $00					;$01D4AF	|
	CLC					;$01D4B1	|
	ADC.w DATA_01D442,X			;$01D4B2	|
	STA.w $0300,Y				;$01D4B5	|
	LDA $14					;$01D4B8	|
	LSR					;$01D4BA	|
	LSR					;$01D4BB	|
	ROR					;$01D4BC	|
	AND.b #$80				;$01D4BD	|
	ORA.w DATA_01D44A,X			;$01D4BF	|
	STA.w $0303,Y				;$01D4C2	|
	LDA $01					;$01D4C5	|
	INC A					;$01D4C7	|
	INC A					;$01D4C8	|
	STA.w $0301,Y				;$01D4C9	|
	PLA					;$01D4CC	|
	CLC					;$01D4CD	|
	ADC $03					;$01D4CE	|
	TAX					;$01D4D0	|
	LDA.w LudwigFireTiles,X			;$01D4D1	|
	STA.w $0302,Y				;$01D4D4	|
	PLX					;$01D4D7	|
	INY					;$01D4D8	|
	INY					;$01D4D9	|
	INY					;$01D4DA	|
	INY					;$01D4DB	|
	DEX					;$01D4DC	|
	BPL CODE_01D4A8				;$01D4DD	|
	PLX					;$01D4DF	|
	LDY.b #$02				;$01D4E0	|
	LDA.b #$01				;$01D4E2	|
	JMP FinishOAMWriteRt			;$01D4E4	|

DATA_01D4E7:
	db $01,$FF

DATA_01D4E9:
	db $0F,$00

DATA_01D4EB:
	db $00,$02,$04,$06,$08,$0A,$0C,$0E
	db $0E,$0C,$0A,$08,$06,$04,$02,$00

ParachuteSprites:
	LDA.w $14C8,X
	CMP.b #$08				;$01D4FE	|
	BEQ CODE_01D505				;$01D500	|
	JMP CODE_01D671				;$01D502	|

CODE_01D505:
	LDA $9D
	BNE CODE_01D558				;$01D507	|
	LDA.w $1540,X				;$01D509	|
	BNE CODE_01D558				;$01D50C	|
	LDA $13					;$01D50E	|
	LSR					;$01D510	|
	BCC CODE_01D51A				;$01D511	|
	INC $D8,X				;$01D513	|
	BNE CODE_01D51A				;$01D515	|
	INC.w $14D4,X				;$01D517	|
CODE_01D51A:
	LDA.w $151C,X
	BNE CODE_01D558				;$01D51D	|
	LDA $13					;$01D51F	|
	LSR					;$01D521	|
	BCC CODE_01D53A				;$01D522	|
	LDA $C2,X				;$01D524	|
	AND.b #$01				;$01D526	|
	TAY					;$01D528	|
	LDA.w $1570,X				;$01D529	|
	CLC					;$01D52C	|
	ADC.w DATA_01D4E7,Y			;$01D52D	|
	STA.w $1570,X				;$01D530	|
	CMP.w DATA_01D4E9,Y			;$01D533	|
	BNE CODE_01D53A				;$01D536	|
	INC $C2,X				;$01D538	|
CODE_01D53A:
	LDA $B6,X
	PHA					;$01D53C	|
	LDY.w $1570,X				;$01D53D	|
	LDA $C2,X				;$01D540	|
	LSR					;$01D542	|
	LDA.w DATA_01D4EB,Y			;$01D543	|
	BCC CODE_01D54B				;$01D546	|
	EOR.b #$FF				;$01D548	|
	INC A					;$01D54A	|
CODE_01D54B:
	CLC
	ADC $B6,X				;$01D54C	|
	STA $B6,X				;$01D54E	|
	JSR SubSprXPosNoGrvty			;$01D550	|
	PLA					;$01D553	|
	STA $B6,X				;$01D554	|
	BRA CODE_01D558				;$01D556	|

CODE_01D558:
	JSR SubOffscreen0Bnk1
	JMP CODE_01D5B3				;$01D55B	|

DATA_01D55E:
	db $0D,$0D,$0D,$0D,$0C,$0C,$0C,$0C
	db $0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D
DATA_01D56E:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $01,$01,$01,$01,$01,$01,$01,$01
DATA_01D57E:
	db $F8,$F8,$FA,$FA,$FC,$FC,$FE,$FE
	db $02,$02,$04,$04,$06,$06,$08,$08
DATA_01D58E:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $00,$00,$00,$00,$00,$00,$00,$00
DATA_01D59E:
	db $0E,$0E,$0F,$0F,$10,$10,$10,$10
	db $10,$10,$10,$10,$0F,$0F,$0E,$0E
DATA_01D5AE:
	db $0F,$0D

DATA_01D5B0:
	db $01,$05,$00

CODE_01D5B3:
	STZ.w $185E
	LDY.b #$F0				;$01D5B6	|
	LDA.w $1540,X				;$01D5B8	|
	BEQ CODE_01D5C7				;$01D5BB	|
	LSR					;$01D5BD	|
	EOR.b #$0F				;$01D5BE	|
	STA.w $185E				;$01D5C0	|
	CLC					;$01D5C3	|
	ADC.b #$F0				;$01D5C4	|
	TAY					;$01D5C6	|
CODE_01D5C7:
	STY $00
	LDA $D8,X				;$01D5C9	|
	PHA					;$01D5CB	|
	CLC					;$01D5CC	|
	ADC $00					;$01D5CD	|
	STA $D8,X				;$01D5CF	|
	LDA.w $14D4,X				;$01D5D1	|
	PHA					;$01D5D4	|
	ADC.b #$FF				;$01D5D5	|
	STA.w $14D4,X				;$01D5D7	|
	LDA.w $15F6,X				;$01D5DA	|
	PHA					;$01D5DD	|
	AND.b #$F1				;$01D5DE	|
	ORA.b #$06				;$01D5E0	|
	STA.w $15F6,X				;$01D5E2	|
	LDY.w $1570,X				;$01D5E5	|
	LDA.w DATA_01D55E,Y			;$01D5E8	|
	STA.w $1602,X				;$01D5EB	|
	LDA.w DATA_01D56E,Y			;$01D5EE	|
	STA.w $157C,X				;$01D5F1	|
	JSR SubSprGfx2Entry1			;$01D5F4	|
	PLA					;$01D5F7	|
	STA.w $15F6,X				;$01D5F8	|
	LDA.w $15EA,X				;$01D5FB	|
	CLC					;$01D5FE	|
	ADC.b #$04				;$01D5FF	|
	STA.w $15EA,X				;$01D601	|
	LDY.w $1570,X				;$01D604	|
	LDA $E4,X				;$01D607	|
	PHA					;$01D609	|
	CLC					;$01D60A	|
	ADC.w DATA_01D57E,Y			;$01D60B	|
	STA $E4,X				;$01D60E	|
	LDA.w $14E0,X				;$01D610	|
	PHA					;$01D613	|
	ADC.w DATA_01D58E,Y			;$01D614	|
	STA.w $14E0,X				;$01D617	|
	STZ $00					;$01D61A	|
	LDA.w DATA_01D59E,Y			;$01D61C	|
	SEC					;$01D61F	|
	SBC.w $185E				;$01D620	|
	BPL CODE_01D627				;$01D623	|
	DEC $00					;$01D625	|
CODE_01D627:
	CLC
	ADC $D8,X				;$01D628	|
	STA $D8,X				;$01D62A	|
	LDA.w $14D4,X				;$01D62C	|
	ADC $00					;$01D62F	|
	STA.w $14D4,X				;$01D631	|
	LDA.w $1602,X				;$01D634	|
	SEC					;$01D637	|
	SBC.b #$0C				;$01D638	|
	CMP.b #$01				;$01D63A	|
	BNE CODE_01D642				;$01D63C	|
	CLC					;$01D63E	|
	ADC.w $157C,X				;$01D63F	|
CODE_01D642:
	STA.w $1602,X
	LDA.w $1540,X				;$01D645	|
	BEQ CODE_01D64D				;$01D648	|
	STZ.w $1602,X				;$01D64A	|
CODE_01D64D:
	LDY.w $1602,X
	LDA.w DATA_01D5B0,Y			;$01D650	|
	JSR SubSprGfx0Entry0			;$01D653	|
	JSR SubSprSprPMarioSpr			;$01D656	|
	LDA.w $1540,X				;$01D659	|
	BEQ CODE_01D693				;$01D65C	|
	DEC A					;$01D65E	|
	BNE CODE_01D681				;$01D65F	|
	STZ $AA,X				;$01D661	|
	PLA					;$01D663	|
	PLA					;$01D664	|
	PLA					;$01D665	|
	STA.w $14D4,X				;$01D666	|
	PLA					;$01D669	|
	STA $D8,X				;$01D66A	|
	LDA.b #$80				;$01D66C	|
	STA.w $1540,X				;$01D66E	|
CODE_01D671:
	LDA $9E,X
	SEC					;$01D673	|
	SBC.b #$3F				;$01D674	|
	TAY					;$01D676	|
	LDA.w DATA_01D5AE,Y			;$01D677	|
	STA $9E,X				;$01D67A	|
	JSL LoadSpriteTables			;$01D67C	|
	RTS					;$01D680	|

CODE_01D681:
	JSR CODE_019140
	JSR IsOnGround				;$01D684	|
	BEQ CODE_01D68C				;$01D687	|
	JSR SetSomeYSpeed			;$01D689	|
CODE_01D68C:
	JSR SubSprYPosNoGrvty
	INC $AA,X				;$01D68F	|
	BRA CODE_01D6B5				;$01D691	|

CODE_01D693:
	TXA
	EOR $13					;$01D694	|
	LSR					;$01D696	|
	BCC CODE_01D6B5				;$01D697	|
	JSR CODE_019140				;$01D699	|
	JSR IsTouchingObjSide			;$01D69C	|
	BEQ CODE_01D6AB				;$01D69F	|
	LDA.b #$01				;$01D6A1	|
	STA.w $151C,X				;$01D6A3	|
	LDA.b #$07				;$01D6A6	|
	STA.w $1570,X				;$01D6A8	|
CODE_01D6AB:
	JSR IsOnGround
	BEQ CODE_01D6B5				;$01D6AE	|
	LDA.b #$20				;$01D6B0	|
	STA.w $1540,X				;$01D6B2	|
CODE_01D6B5:
	PLA
	STA.w $14E0,X				;$01D6B6	|
	PLA					;$01D6B9	|
	STA $E4,X				;$01D6BA	|
	PLA					;$01D6BC	|
	STA.w $14D4,X				;$01D6BD	|
	PLA					;$01D6C0	|
	STA $D8,X				;$01D6C1	|
Return01D6C3:
	RTS

InitLineRope:
	CPX.b #$06
	BCC CODE_01D6E0				;$01D6C6	|
	LDA.w $1692				;$01D6C8	|
	BEQ CODE_01D6E0				;$01D6CB	|
	INC.w $1662,X				;$01D6CD	|
	BRA CODE_01D6E0				;$01D6D0	|

InitLinePlat:
	LDA $E4,X
	AND.b #$10				;$01D6D4	|
	EOR.b #$10				;$01D6D6	|
	STA.w $1602,X				;$01D6D8	|
	BEQ CODE_01D6E0				;$01D6DB	|
	INC.w $1662,X				;$01D6DD	|
CODE_01D6E0:
	INC.w $1540,X
	JSR LineFuzzyPPlats			;$01D6E3	|
	JSR LineFuzzyPPlats			;$01D6E6	|
	INC.w $1626,X				;$01D6E9	|
Return01D6EC:
	RTS

InitLineGuidedSpr:
	INC.w $187B,X
	LDA $E4,X				;$01D6F0	|
	AND.b #$10				;$01D6F2	|
	BNE CODE_01D707				;$01D6F4	|
	LDA $E4,X				;$01D6F6	|
	SEC					;$01D6F8	|
	SBC.b #$40				;$01D6F9	|
	STA $E4,X				;$01D6FB	|
	LDA.w $14E0,X				;$01D6FD	|
	SBC.b #$01				;$01D700	|
	STA.w $14E0,X				;$01D702	|
	BRA InitLineBrwnPlat			;$01D705	|

CODE_01D707:
	INC.w $157C,X
	LDA $E4,X				;$01D70A	|
	CLC					;$01D70C	|
	ADC.b #$0F				;$01D70D	|
	STA $E4,X				;$01D70F	|
InitLineBrwnPlat:
	LDA.b #$02
	STA.w $1540,X				;$01D713	|
	RTS					;$01D716	|

DATA_01D717:
	db $F8,$00

LineRopePChainsaw:
	TXA
	ASL					;$01D71A	|
	ASL					;$01D71B	|
	EOR $14					;$01D71C	|
	STA $02					;$01D71E	|
	AND.b #$07				;$01D720	|
	ORA $9D					;$01D722	|
	BNE LineGrinder				;$01D724	|
	LDA $02					;$01D726	|
	LSR					;$01D728	|
	LSR					;$01D729	|
	LSR					;$01D72A	|
	AND.b #$01				;$01D72B	|
	TAY					;$01D72D	|
	LDA.w DATA_01D717,Y			;$01D72E	|
	STA $00					;$01D731	|
	LDA.b #$F2				;$01D733	|
	STA $01					;$01D735	|
	JSR CODE_018063				;$01D737	|
LineGrinder:
	LDA $13
	AND.b #$07				;$01D73C	|
	ORA.w $1626,X				;$01D73E	|
	ORA $9D					;$01D741	|
	BNE LineFuzzyPPlats			;$01D743	|
	LDA.b #$04				;$01D745	|
	STA.w $1DFA				;$01D747	|
LineFuzzyPPlats:
	JMP CODE_01D9A7

CODE_01D74D:
	JSR SubOffscreen1Bnk1
	LDA.w $1540,X				;$01D750	|
	BNE CODE_01D75C				;$01D753	|
	LDA $9D					;$01D755	|
	ORA.w $1626,X				;$01D757	|
	BNE Return01D6EC			;$01D75A	|
CODE_01D75C:
	LDA $C2,X
	JSL ExecutePtr				;$01D75E	|

Ptrs01D762:
	dw CODE_01D7F4
	dw CODE_01D768
	dw CODE_01DB44

CODE_01D768:
	LDA $9D
	BNE Return01D791			;$01D76A	|
	LDA.w $157C,X				;$01D76C	|
	BNE CODE_01D792				;$01D76F	|
	LDY.w $1534,X				;$01D771	|
	JSR CODE_01D7B0				;$01D774	|
	INC.w $1534,X				;$01D777	|
	LDA.w $187B,X				;$01D77A	|
	BEQ CODE_01D787				;$01D77D	|
	LDA $13					;$01D77F	|
	LSR					;$01D781	|
	BCC CODE_01D787				;$01D782	|
	INC.w $1534,X				;$01D784	|
CODE_01D787:
	LDA.w $1534,X
	CMP.w $1570,X				;$01D78A	|
	BCC Return01D791			;$01D78D	|
	STZ $C2,X				;$01D78F	|
Return01D791:
	RTS

CODE_01D792:
	LDY.w $1570,X
	DEY					;$01D795	|
	JSR CODE_01D7B0				;$01D796	|
	DEC.w $1570,X				;$01D799	|
	BEQ CODE_01D7AD				;$01D79C	|
	LDA.w $187B,X				;$01D79E	|
	BEQ Return01D7AF			;$01D7A1	|
	LDA $13					;$01D7A3	|
	LSR					;$01D7A5	|
	BCC Return01D7AF			;$01D7A6	|
	DEC.w $1570,X				;$01D7A8	|
	BNE Return01D7AF			;$01D7AB	|
CODE_01D7AD:
	STZ $C2,X
Return01D7AF:
	RTS

CODE_01D7B0:
	PHB
	LDA.b #$07				;$01D7B1	|
	PHA					;$01D7B3	|
	PLB					;$01D7B4	|
	LDA.w $151C,X				;$01D7B5	|
	STA $04					;$01D7B8	|
	LDA.w $1528,X				;$01D7BA	|
	STA $05					;$01D7BD	|
	LDA ($04),Y				;$01D7BF	|
	AND.b #$0F				;$01D7C1	|
	STA $06					;$01D7C3	|
	LDA ($04),Y				;$01D7C5	|
	PLB					;$01D7C7	|
	LSR					;$01D7C8	|
	LSR					;$01D7C9	|
	LSR					;$01D7CA	|
	LSR					;$01D7CB	|
	STA $07					;$01D7CC	|
	LDA $D8,X				;$01D7CE	|
	AND.b #$F0				;$01D7D0	|
	CLC					;$01D7D2	|
	ADC $07					;$01D7D3	|
	STA $D8,X				;$01D7D5	|
	LDA $E4,X				;$01D7D7	|
	AND.b #$F0				;$01D7D9	|
	CLC					;$01D7DB	|
	ADC $06					;$01D7DC	|
	STA $E4,X				;$01D7DE	|
	RTS					;$01D7E0	|

DATA_01D7E1:
	db $FC,$04,$FC,$04

DATA_01D7E5:
	db $FF,$00,$FF,$00

DATA_01D7E9:
	db $FC,$FC,$04,$04

DATA_01D7ED:
	db $FF,$FF,$00,$00

CODE_01D7F1:
	JMP CODE_01D89F

CODE_01D7F4:
	LDY.b #$03
CODE_01D7F6:
	STY.w $1695
	LDA $E4,X				;$01D7F9	|
	CLC					;$01D7FB	|
	ADC.w DATA_01D7E1,Y			;$01D7FC	|
	STA $02					;$01D7FF	|
	LDA.w $14E0,X				;$01D801	|
	ADC.w DATA_01D7E5,Y			;$01D804	|
	STA $03					;$01D807	|
	LDA $D8,X				;$01D809	|
	CLC					;$01D80B	|
	ADC.w DATA_01D7E9,Y			;$01D80C	|
	STA $00					;$01D80F	|
	LDA.w $14D4,X				;$01D811	|
	ADC.w DATA_01D7ED,Y			;$01D814	|
	STA $01					;$01D817	|
	LDA.w $1540,X				;$01D819	|
	BNE CODE_01D83A				;$01D81C	|
	LDA $00					;$01D81E	|
	AND.b #$F0				;$01D820	|
	STA $04					;$01D822	|
	LDA $D8,X				;$01D824	|
	AND.b #$F0				;$01D826	|
	CMP $04					;$01D828	|
	BNE CODE_01D83A				;$01D82A	|
	LDA $02					;$01D82C	|
	AND.b #$F0				;$01D82E	|
	STA $05					;$01D830	|
	LDA $E4,X				;$01D832	|
	AND.b #$F0				;$01D834	|
	CMP $05					;$01D836	|
	BEQ CODE_01D861				;$01D838	|
CODE_01D83A:
	JSR CODE_01D94D		
	BNE CODE_01D7F1				;$01D83D	|
	LDA.w $1693				;$01D83F	|
	CMP.b #$94				;$01D842	|
	BEQ CODE_01D851				;$01D844	|
	CMP.b #$95				;$01D846	|
	BNE CODE_01D856				;$01D848	|
	LDA.w $14AF				;$01D84A	|
	BEQ CODE_01D861				;$01D84D	|
	BNE CODE_01D856				;$01D84F	|
CODE_01D851:
	LDA.w $14AF
	BNE CODE_01D861				;$01D854	|
CODE_01D856:
	LDA.w $1693
	CMP.b #$76				;$01D859	|
	BCC CODE_01D861				;$01D85B	|
	CMP.b #$9A				;$01D85D	|
	BCC CODE_01D895				;$01D85F	|
CODE_01D861:
	LDY.w $1695
	DEY					;$01D864	|
	BPL CODE_01D7F6				;$01D865	|
	LDA $C2,X				;$01D867	|
	CMP.b #$02				;$01D869	|
	BEQ Return01D894			;$01D86B	|
	LDA.b #$02				;$01D86D	|
	STA $C2,X				;$01D86F	|
	LDY.w $160E,X				;$01D871	|
	LDA.w $157C,X				;$01D874	|
	BEQ CODE_01D87E				;$01D877	|
	TYA					;$01D879	|
	CLC					;$01D87A	|
	ADC.b #$20				;$01D87B	|
	TAY					;$01D87D	|
CODE_01D87E:
	LDA.w DATA_01DD11,Y
	BPL CODE_01D884				;$01D881	|
	ASL					;$01D883	|
CODE_01D884:
	PHY
	ASL					;$01D885	|
	STA $AA,X 				;$01D886	|
	PLY					;$01D888	|
	LDA.w DATA_01DD51,Y			;$01D889	|
	ASL					;$01D88C	|
	STA $B6,X				;$01D88D	|
	LDA.b #$10				;$01D88F	|
	STA.w $1540,X				;$01D891	|
Return01D894:
	RTS

CODE_01D895:
	PHA
	SEC					;$01D896	|
	SBC.b #$76				;$01D897	|
	TAY					;$01D899	|
	PLA					;$01D89A	|
	CMP.b #$96				;$01D89B	|
	BCC CODE_01D8A4				;$01D89D	|
CODE_01D89F:
	LDY.w $160E,X
	BRA CODE_01D8C8				;$01D8A2	|

CODE_01D8A4:
	LDA $D8,X
	STA $08					;$01D8A6	|
	LDA.w $14D4,X				;$01D8A8	|
	STA $09					;$01D8AB	|
	LDA $E4,X				;$01D8AD	|
	STA $0A					;$01D8AF	|
	LDA.w $14E0,X				;$01D8B1	|
	STA $0B					;$01D8B4	|
	LDA $00					;$01D8B6	|
	STA $D8,X				;$01D8B8	|
	LDA $01					;$01D8BA	|
	STA.w $14D4,X				;$01D8BC	|
	LDA $02					;$01D8BF	|
	STA $E4,X				;$01D8C1	|
	LDA $03					;$01D8C3	|
	STA.w $14E0,X				;$01D8C5	|
CODE_01D8C8:
	PHB
	LDA.b #$07				;$01D8C9	|
	PHA					;$01D8CB	|
	PLB					;$01D8CC	|
	LDA.w CODE_01FBF3,Y			;$01D8CD	|
	STA.w $151C,X				;$01D8D0	|
	LDA.w CODE_01FC13,Y			;$01D8D3	|
	STA.w $1528,X				;$01D8D6	|
	PLB					;$01D8D9	|
	LDA.w DATA_01DCD1,Y			;$01D8DA	|
	STA.w $1570,X				;$01D8DD	|
	STZ.w $1534,X				;$01D8E0	|
	TYA					;$01D8E3	|
	STA.w $160E,X				;$01D8E4	|
	LDA.w $1540,X				;$01D8E7	|
	BNE CODE_01D933				;$01D8EA	|
	STZ.w $157C,X				;$01D8EC	|
	LDA.w DATA_01DCF1,Y			;$01D8EF	|
	BEQ CODE_01D8FF				;$01D8F2	|
	TAY					;$01D8F4	|
	LDA $D8,X				;$01D8F5	|
	CPY.b #$01				;$01D8F7	|
	BNE CODE_01D8FD				;$01D8F9	|
	EOR.b #$0F				;$01D8FB	|
CODE_01D8FD:
	BRA CODE_01D901

CODE_01D8FF:
	LDA $E4,X
CODE_01D901:
	AND.b #$0F
	CMP.b #$0A				;$01D903	|
	BCC CODE_01D910				;$01D905	|
	LDA $C2,X				;$01D907	|
	CMP.b #$02				;$01D909	|
	BEQ CODE_01D910				;$01D90B	|
	INC.w $157C,X				;$01D90D	|
CODE_01D910:
	LDA $D8,X
	STA $0C					;$01D912	|
	LDA $E4,X				;$01D914	|
	STA $0D					;$01D916	|
	JSR CODE_01D768				;$01D918	|
	LDA $0C					;$01D91B	|
	SEC					;$01D91D	|
	SBC $D8,X				;$01D91E	|
	CLC					;$01D920	|
	ADC.b #$08				;$01D921	|
	CMP.b #$10				;$01D923	|
	BCS CODE_01D938				;$01D925	|
	LDA $0D					;$01D927	|
	SEC					;$01D929	|
	SBC $E4,X				;$01D92A	|
	CLC					;$01D92C	|
	ADC.b #$08				;$01D92D	|
	CMP.b #$10				;$01D92F	|
	BCS CODE_01D938				;$01D931	|
CODE_01D933:
	LDA.b #$01
	STA $C2,X				;$01D935	|
	RTS					;$01D937	|

CODE_01D938:
	LDA $08
	STA $D8,X				;$01D93A	|
	LDA $09					;$01D93C	|
	STA.w $14D4,X				;$01D93E	|
	LDA $0A					;$01D941	|
	STA $E4,X				;$01D943	|
	LDA $0B					;$01D945	|
	STA.w $14E0,X				;$01D947	|
	JMP CODE_01D861				;$01D94A	|

CODE_01D94D:
	LDA $00
	AND.b #$F0				;$01D94F	|
	STA $06					;$01D951	|
	LDA $02					;$01D953	|
	LSR					;$01D955	|
	LSR					;$01D956	|
	LSR					;$01D957	|
	LSR					;$01D958	|
	PHA					;$01D959	|
	ORA $06					;$01D95A	|
	PHA					;$01D95C	|
	LDA $5B					;$01D95D	|
	AND.b #$01				;$01D95F	|
	BEQ CODE_01D977				;$01D961	|
	PLA					;$01D963	|
	LDX $01					;$01D964	|
	CLC					;$01D966	|
	ADC.l DATA_00BA80,X			;$01D967	|
	STA $05					;$01D96B	|
	LDA.l DATA_00BABC,X			;$01D96D	|
	ADC $03					;$01D971	|
	STA $06					;$01D973	|
	BRA CODE_01D989				;$01D975	|

CODE_01D977:
	PLA
	LDX $03					;$01D978	|
	CLC					;$01D97A	|
	ADC.l DATA_00BA60,X			;$01D97B	|
	STA $05					;$01D97F	|
	LDA.l DATA_00BA9C,X			;$01D981	|
	ADC $01					;$01D985	|
	STA $06					;$01D987	|
CODE_01D989:
	LDA.b #$7E
	STA $07					;$01D98B	|
	LDX.w $15E9				;$01D98D	|
	LDA [$05]				;$01D990	|
	STA.w $1693				;$01D992	|
	INC $07					;$01D995	|
	LDA [$05]				;$01D997	|
	PLY					;$01D999	|
	STY $05					;$01D99A	|
	PHA					;$01D99C	|
	LDA $05					;$01D99D	|
	AND.b #$07				;$01D99F	|
	TAY					;$01D9A1	|
	PLA					;$01D9A2	|
	AND.w DATA_018000,Y			;$01D9A3	|
	RTS					;$01D9A6	|

CODE_01D9A7:
	LDA $9E,X		
	CMP.b #$64				;$01D9A9	|
	BEQ CODE_01D9D3				;$01D9AB	|
	CMP.b #$65				;$01D9AD	|
	BCC CODE_01D9D0 			;$01D9AF	|
	CMP.b #$68				;$01D9B1	|
	BNE CODE_01D9BA				;$01D9B3	|
	JSR CODE_01DBD4				;$01D9B5	|
	BRA CODE_01D9C1				;$01D9B8	|

CODE_01D9BA:
	CMP.b #$67
	BNE CODE_01D9C6				;$01D9BC	|
	JSR CODE_01DC0B				;$01D9BE	|
CODE_01D9C1:
	JSR MarioSprInteractRt
	BRA CODE_01D9CD				;$01D9C4	|

CODE_01D9C6:
	JSR MarioSprInteractRt
	JSL CODE_03C263				;$01D9C9	|
CODE_01D9CD:
	JMP CODE_01D74D

CODE_01D9D0:
	JMP CODE_01DAA2

CODE_01D9D3:
	JSR CODE_01DC54
	LDA $E4,X				;$01D9D6	|
	PHA					;$01D9D8	|
	LDA $D8,X				;$01D9D9	|
	PHA					;$01D9DB	|
	JSR CODE_01D74D				;$01D9DC	|
	PLA					;$01D9DF	|
	SEC					;$01D9E0	|
	SBC $D8,X				;$01D9E1	|
	EOR.b #$FF				;$01D9E3	|
	INC A					;$01D9E5	|
	STA.w $185E				;$01D9E6	|
	PLA					;$01D9E9	|
	SEC					;$01D9EA	|
	SBC $E4,X				;$01D9EB	|
	EOR.b #$FF				;$01D9ED	|
	INC A					;$01D9EF	|
	STA.w $18B6				;$01D9F0	|
	LDA $77					;$01D9F3	|
	AND.b #$03				;$01D9F5	|
	BNE Return01DA09			;$01D9F7	|
	JSR CODE_01A80F				;$01D9F9	|
	BCS CODE_01DA0A				;$01D9FC	|
CODE_01D9FE:
	LDA.w $163E,X
	BEQ Return01DA09			;$01DA01	|
	STZ.w $163E,X				;$01DA03	|
	STZ.w $18BE				;$01DA06	|
Return01DA09:
	RTS

CODE_01DA0A:
	LDA.w $14C8,X
	BEQ CODE_01DA37				;$01DA0D	|
	LDA.w $1470				;$01DA0F	|
	ORA.w $187A				;$01DA12	|
	BNE CODE_01D9FE				;$01DA15	|
	LDA.b #$03				;$01DA17	|
	STA.w $163E,X				;$01DA19	|
	LDA.w $154C,X				;$01DA1C	|
	BNE Return01DA8F			;$01DA1F	|
	LDA.w $18BE				;$01DA21	|
	BNE CODE_01DA2F				;$01DA24	|
	LDA $15					;$01DA26	|
	AND.b #$08				;$01DA28	|
	BEQ Return01DA8F			;$01DA2A	|
	STA.w $18BE				;$01DA2C	|
CODE_01DA2F:
	BIT $16
	BPL CODE_01DA3F				;$01DA31	|
	LDA.b #$B0				;$01DA33	|
	STA $7D					;$01DA35	|
CODE_01DA37:
	STZ.w $18BE
	LDA.b #$10				;$01DA3A	|
	STA.w $154C,X				;$01DA3C	|
CODE_01DA3F:
	LDY.b #$00
	LDA.w $185E				;$01DA41	|
	BPL CODE_01DA47				;$01DA44	|
	DEY					;$01DA46	|
CODE_01DA47:
	CLC
	ADC $96					;$01DA48	|
	STA $96					;$01DA4A	|
	TYA					;$01DA4C	|
	ADC $97					;$01DA4D	|
	STA $97					;$01DA4F	|
	LDA $D8,X				;$01DA51	|
	STA $00					;$01DA53	|
	LDA.w $14D4,X				;$01DA55	|
	STA $01					;$01DA58	|
	REP #$20				;$01DA5A	|
	LDA $96					;$01DA5C	|
	SEC					;$01DA5E	|
	SBC $00					;$01DA5F	|
	CMP.w #$0000				;$01DA61	|
	BPL CODE_01DA68				;$01DA64	|
	INC $96					;$01DA66	|
CODE_01DA68:
	SEP #$20
	LDA.w $18B6				;$01DA6A	|
	JSR CODE_01DA90				;$01DA6D	|
	LDA $E4,X				;$01DA70	|
	SEC					;$01DA72	|
	SBC.b #$08				;$01DA73	|
	CMP $94					;$01DA75	|
	BEQ CODE_01DA84				;$01DA77	|
	BPL CODE_01DA7F				;$01DA79	|
	LDA.b #$FF				;$01DA7B	|
	BRA CODE_01DA81				;$01DA7D	|

CODE_01DA7F:
	LDA.b #$01
CODE_01DA81:
	JSR CODE_01DA90
CODE_01DA84:
	LDA.w $1626,X
	BEQ Return01DA8F			;$01DA87	|
	STZ.w $1626,X				;$01DA89	|
	STZ.w $1540,X				;$01DA8C	|
Return01DA8F:
	RTS

CODE_01DA90:
	LDY.b #$00
	CMP.b #$00				;$01DA92	|
	BPL CODE_01DA97				;$01DA94	|
	DEY					;$01DA96	|
CODE_01DA97:
	CLC
	ADC $94					;$01DA98	|
	STA $94					;$01DA9A	|
	TYA					;$01DA9C	|
	ADC $95					;$01DA9D	|
	STA $95					;$01DA9F	|
	RTS					;$01DAA1	|

CODE_01DAA2:
	LDY.b #$18
	LDA.w $1602,X				;$01DAA4	|
	BEQ CODE_01DAAB				;$01DAA7	|
	LDY.b #$28 				;$01DAA9	|
CODE_01DAAB:
	STY $00
	LDA $E4,X				;$01DAAD	|
	PHA					;$01DAAF	|
	SEC					;$01DAB0	|
	SBC $00					;$01DAB1	|
	STA $E4,X				;$01DAB3	|
	LDA.w $14E0,X				;$01DAB5	|
	PHA					;$01DAB8	|
	SBC.b #$00				;$01DAB9	|
	STA.w $14E0,X				;$01DABB	|
	LDA $D8,X				;$01DABE	|
	PHA					;$01DAC0	|
	SEC					;$01DAC1	|
	SBC.b #$08				;$01DAC2	|
	STA $D8,X				;$01DAC4	|
	LDA.w $14D4,X				;$01DAC6	|
	PHA					;$01DAC9	|
	SBC.b #$00				;$01DACA	|
	STA.w $14D4,X				;$01DACC	|
	JSR CODE_01B2DF 			;$01DACF	|
	PLA 					;$01DAD2	|
	STA.w $14D4,X				;$01DAD3	|
	PLA					;$01DAD6	|
	STA $D8,X				;$01DAD7	|
	PLA					;$01DAD9	|
	STA.w $14E0,X				;$01DADA	|
	PLA					;$01DADD	|
	STA $E4,X				;$01DADE	|
	LDA $E4,X				;$01DAE0	|
	PHA					;$01DAE2	|
	JSR CODE_01D74D 			;$01DAE3	|
	PLA					;$01DAE6	|
	SEC					;$01DAE7	|
	SBC $E4,X				;$01DAE8	|
	LDY.w $1528,X				;$01DAEA	|
	PHY					;$01DAED	|
	EOR.b #$FF				;$01DAEE	|
	INC A					;$01DAF0	|
	STA.w $1528,X				;$01DAF1	|
	LDY.b #$18				;$01DAF4	|
	LDA.w $1602,X				;$01DAF6	|
	BEQ CODE_01DAFD				;$01DAF9	|
	LDY.b #$28				;$01DAFB	|
CODE_01DAFD:
	STY $00
	LDA $E4,X				;$01DAFF	|
	PHA					;$01DB01	|
	SEC					;$01DB02	|
	SBC $00					;$01DB03	|
	STA $E4,X				;$01DB05	|
	LDA.w $14E0,X				;$01DB07	|
	PHA					;$01DB0A	|
	SBC.b #$00				;$01DB0B	|
	STA.w $14E0,X				;$01DB0D	|
	LDA $D8,X				;$01DB10	|
	PHA					;$01DB12	|
	SEC					;$01DB13	|
	SBC.b #$08				;$01DB14	|
	STA $D8,X				;$01DB16	|
	LDA.w $14D4,X				;$01DB18	|
	PHA					;$01DB1B	|
	SBC.b #$00				;$01DB1C	|
	STA.w $14D4,X				;$01DB1E	|
	JSR CODE_01B457				;$01DB21	|
	BCC CODE_01DB31				;$01DB24	|
	LDA.w $1626,X				;$01DB26	|
	BEQ CODE_01DB31				;$01DB29	|
	STZ.w $1626,X				;$01DB2B	|
	STZ.w $1540,X				;$01DB2E	|
CODE_01DB31:
	PLA
	STA.w $14D4,X				;$01DB32	|
	PLA					;$01DB35	|
	STA $D8,X				;$01DB36	|
	PLA					;$01DB38	|
	STA.w $14E0,X				;$01DB39	|
	PLA					;$01DB3C	|
	STA $E4,X				;$01DB3D	|
	PLA					;$01DB3F	|
	STA.w $1528,X				;$01DB40	|
	RTS					;$01DB43	|

CODE_01DB44:
	LDA $9D
	BNE Return01DB59			;$01DB46	|
	JSR SubUpdateSprPos			;$01DB48	|
	LDA.w $1540,X				;$01DB4B	|
	BNE Return01DB59			;$01DB4E	|
	LDA $AA,X				;$01DB50	|
	CMP.b #$20				;$01DB52	|
	BMI Return01DB59			;$01DB54	|
	JSR CODE_01D7F4				;$01DB56	|
Return01DB59:
	RTS

DATA_01DB5A:
	db $18,$E8

Grinder:
	JSR CODE_01DBA2
	LDA.w $14C8,X				;$01DB5F	|
	CMP.b #$08				;$01DB62	|
	BNE Return01DB95			;$01DB64	|
	LDA $9D					;$01DB66	|
	BNE Return01DB95			;$01DB68	|
	LDA $13					;$01DB6A	|
	AND.b #$03				;$01DB6C	|
	BNE CODE_01DB75				;$01DB6E	|
	LDA.b #$04				;$01DB70	|
	STA.w $1DFA				;$01DB72	|
CODE_01DB75:
	JSR SubOffscreen0Bnk1
	JSR MarioSprInteractRt			;$01DB78	|
	LDY.w $157C,X				;$01DB7B	|
	LDA.w DATA_01DB5A,Y			;$01DB7E	|
	STA $B6,X				;$01DB81	|
	JSR SubUpdateSprPos			;$01DB83	|
	JSR IsOnGround				;$01DB86	|
	BEQ CODE_01DB8D				;$01DB89	|
	STZ $AA,X				;$01DB8B	|
CODE_01DB8D:
	JSR IsTouchingObjSide
	BEQ Return01DB95			;$01DB90	|
	JSR FlipSpriteDir			;$01DB92	|
Return01DB95:
	RTS

DATA_01DB96:
	db $F8,$08,$F8,$08

DATA_01DB9A:
	db $00,$00,$10,$10

DATA_01DB9E:
	db $03,$43,$83,$C3

CODE_01DBA2:
	JSR GetDrawInfoBnk1
	PHX					;$01DBA5	|
	LDX.b #$03				;$01DBA6	|
CODE_01DBA8:
	LDA $00
	CLC					;$01DBAA	|
	ADC.w DATA_01DB96,X			;$01DBAB	|
	STA.w $0300,Y				;$01DBAE	|
	LDA $01					;$01DBB1	|
	CLC					;$01DBB3	|
	ADC.w DATA_01DB9A,X			;$01DBB4	|
	STA.w $0301,Y				;$01DBB7	|
	LDA $14					;$01DBBA	|
	AND.b #$02				;$01DBBC	|
	ORA.b #$6C				;$01DBBE	|
	STA.w $0302,Y				;$01DBC0	|
	LDA.w DATA_01DB9E,X			;$01DBC3	|
	STA.w $0303,Y				;$01DBC6	|
	INY					;$01DBC9	|
	INY					;$01DBCA	|
	INY					;$01DBCB	|
	INY					;$01DBCC	|
	DEX					;$01DBCD	|
	BPL CODE_01DBA8				;$01DBCE	|
CODE_01DBD0:
	LDA.b #$03
	BRA CODE_01DC03				;$01DBD2	|

CODE_01DBD4:
	JSR SubSprGfx2Entry1
	LDY.w $15EA,X				;$01DBD7	|
	LDA.w $0300,Y				;$01DBDA	|
	SEC					;$01DBDD	|
	SBC.b #$08				;$01DBDE	|
	STA.w $0300,Y				;$01DBE0	|
	LDA.w $0301,Y				;$01DBE3	|
	SEC					;$01DBE6	|
	SBC.b #$08				;$01DBE7	|
	STA.w $0301,Y				;$01DBE9	|
	PHX					;$01DBEC	|
	LDA $14					;$01DBED	|
	LSR					;$01DBEF	|
	LSR					;$01DBF0	|
	AND.b #$01				;$01DBF1	|
	TAX					;$01DBF3	|
	LDA.b #$C8				;$01DBF4	|
	STA.w $0302,Y				;$01DBF6	|
	LDA.w DATA_01DC09,X			;$01DBF9	|
	ORA $64					;$01DBFC	|
	STA.w $0303,Y				;$01DBFE	|
	LDA.b #$00				;$01DC01	|
CODE_01DC03:
	PLX
CODE_01DC04:
	LDY.b #$02
	JMP FinishOAMWriteRt			;$01DC06	|

DATA_01DC09:
	db $05,$45

CODE_01DC0B:
	JSR GetDrawInfoBnk1
	PHX					;$01DC0E	|
	LDX.b #$03				;$01DC0F	|
CODE_01DC11:
	LDA $00
	CLC					;$01DC13	|
	ADC.w DATA_01DC3B,X			;$01DC14	|
	STA.w $0300,Y				;$01DC17	|
	LDA $01					;$01DC1A	|
	CLC					;$01DC1C	|
	ADC.w DATA_01DC3F,X			;$01DC1D	|
	STA.w $0301,Y				;$01DC20	|
	LDA $14					;$01DC23	|
	AND.b #$02				;$01DC25	|
	ORA.b #$6C				;$01DC27	|
	STA.w $0302,Y				;$01DC29	|
	LDA.w DATA_01DC43,X			;$01DC2C	|
	STA.w $0303,Y				;$01DC2F	|
	INY					;$01DC32	|
	INY					;$01DC33	|
	INY					;$01DC34	|
	INY					;$01DC35	|
	DEX					;$01DC36	|
	BPL CODE_01DC11				;$01DC37	|
	BRA CODE_01DBD0				;$01DC39	|

DATA_01DC3B:
	db $F0,$00,$F0,$00

DATA_01DC3F:
	db $F0,$F0,$00,$00

DATA_01DC43:
	db $33,$73,$B3,$F3

RopeMotorTiles:
	db $C0,$C2,$E0,$C2

LineGuideRopeTiles:
	db $C0,$CE,$CE,$CE,$CE,$CE,$CE,$CE
	db $CE

CODE_01DC54:
	JSR GetDrawInfoBnk1
	LDA $00					;$01DC57	|
	SEC					;$01DC59	|
	SBC.b #$08				;$01DC5A	|
	STA $00					;$01DC5C	|
	LDA $01					;$01DC5E	|
	SEC					;$01DC60	|
	SBC.b #$08				;$01DC61	|
	STA $01					;$01DC63	|
	TXA					;$01DC65	|
	ASL					;$01DC66	|
	ASL					;$01DC67	|
	EOR $14					;$01DC68	|
	LSR					;$01DC6A	|
	LSR					;$01DC6B	|
	LSR					;$01DC6C	|
	AND.b #$03				;$01DC6D	|
	STA $02					;$01DC6F	|
	LDA.b #$05				;$01DC71	|
	CPX.b #$06				;$01DC73	|
	BCC CODE_01DC7E				;$01DC75	|
	LDY.w $1692				;$01DC77	|
	BEQ CODE_01DC7E				;$01DC7A	|
	LDA.b #$09				;$01DC7C	|
CODE_01DC7E:
	STA $03
	LDY.w $15EA,X				;$01DC80	|
	LDX.b #$00				;$01DC83	|
CODE_01DC85:
	LDA $00
	STA.w $0300,Y				;$01DC87	|
	LDA $01					;$01DC8A	|
	STA.w $0301,Y				;$01DC8C	|
	CLC					;$01DC8F	|
	ADC.b #$10				;$01DC90	|
	STA $01					;$01DC92	|
	LDA.w LineGuideRopeTiles,X		;$01DC94	|
	CPX.b #$00				;$01DC97	|
	BNE CODE_01DCA2				;$01DC99	|
	PHX					;$01DC9B	|
	LDX $02					;$01DC9C	|
	LDA.w RopeMotorTiles,X			;$01DC9E	|
	PLX					;$01DCA1	|
CODE_01DCA2:
	STA.w $0302,Y
	LDA.b #$37				;$01DCA5	|
	CPX.b #$01				;$01DCA7	|
	BCC CODE_01DCAD				;$01DCA9	|
	LDA.b #$31				;$01DCAB	|
CODE_01DCAD:
	STA.w $0303,Y
	INY					;$01DCB0	|
	INY					;$01DCB1	|
	INY					;$01DCB2	|
	INY					;$01DCB3	|
	INX					;$01DCB4	|
	CPX $03					;$01DCB5	|
	BNE CODE_01DC85				;$01DCB7	|
	LDA.b #$DE				;$01DCB9	|
	STA.w $02FE,Y				;$01DCBB	|
	LDX.w $15E9				;$01DCBE	|
	LDA.b #$04				;$01DCC1	|
	CPX.b #$06				;$01DCC3	|
	BCC CODE_01DCCE				;$01DCC5	|
	LDY.w $1692				;$01DCC7	|
	BEQ CODE_01DCCE				;$01DCCA	|
	LDA.b #$08				;$01DCCC	|
CODE_01DCCE:
	JMP CODE_01DC04

DATA_01DCD1:
	db $15,$15,$15,$15,$0C,$10,$10,$10
	db $10,$0C,$0C,$10,$10,$10,$10,$0C
	db $15,$15,$10,$10,$10,$10,$10,$10
	db $10,$10,$10,$10,$10,$10,$15,$15
DATA_01DCF1:
	db $00,$00,$00,$00,$00,$00,$01,$02
	db $00,$00,$00,$00,$02,$01,$00,$00
	db $00,$00,$01,$02,$01,$02,$00,$00
	db $00,$00,$02,$02,$00,$00,$00,$00
DATA_01DD11:
	db $00,$10,$00,$F0,$F4,$FC,$F0,$10
	db $04,$0C,$0C,$00,$10,$F0,$FC,$F4
	db $F0,$10,$F0,$10,$F0,$10,$F8,$F8
	db $08,$08,$10,$10,$00,$00,$F0,$10
	db $10,$00,$F0,$F0,$0C,$04,$10,$F0
	db $00,$F4,$F4,$FC,$F0,$10,$00,$0C
	db $10,$F0,$10,$00,$10,$F0,$08,$08
	db $F8,$F8,$F0,$F0,$00,$00,$10,$F0
DATA_01DD51:
	db $10,$00,$10,$00,$0C,$10,$04,$00
	db $10,$0C,$0C,$10,$04,$00,$10,$0C
	db $10,$10,$08,$08,$08,$08,$10,$10
	db $10,$10,$00,$00,$10,$10,$10,$10
	db $00,$F0,$00,$F0,$F4,$F0,$00,$FC
	db $F0,$F4,$F4,$F0,$00,$FC,$F0,$F4
	db $F0,$F0,$F8,$F8,$F8,$F8,$F0,$F0
	db $F0,$F0,$00,$00,$F0,$F0,$F0

DATA_01DD90:
	db $F0

DATA_01DD91:
	db $50,$78,$A0,$A0,$A0,$78,$50,$50
DATA_01DD99:
	db $78

DATA_01DD9A:
	db $F0,$F0,$F0,$18,$40,$40,$40,$18
DATA_01DDA2:
	db $18,$03,$00,$00,$01,$01,$02,$02
	db $03,$FF

InitBonusGame:
	LDA.w $1B94
	BEQ CODE_01DDB5				;$01DDAF	|
	STZ.w $14C8,X				;$01DDB1	|
	RTS					;$01DDB4	|

CODE_01DDB5:
	LDX.b #$09
CODE_01DDB7:
	LDA.b #$08
	STA.w $14C8,X				;$01DDB9	|
	LDA.b #$82				;$01DDBC	|
	STA.w $9E,X				;$01DDBE	|
	LDA.w DATA_01DD90,X			;$01DDC1	|
	STA $E4,X				;$01DDC4	|
	LDA.b #$00				;$01DDC6	|
	STA.w $14E0,X				;$01DDC8	|
	LDA.w DATA_01DD99,X			;$01DDCB	|
	STA $D8,X				;$01DDCE	|
	ASL					;$01DDD0	|
	LDA.b #$00				;$01DDD1	|
	BCS CODE_01DDD6				;$01DDD3	|
	INC A					;$01DDD5	|
CODE_01DDD6:
	STA.w $14D4,X
	JSL InitSpriteTables			;$01DDD9	|
	LDA.w DATA_01DDA2,X			;$01DDDD	|
	STA.w $157C,X				;$01DDE0	|
	TXA					;$01DDE3	|
	CLC					;$01DDE4	|
	ADC $13					;$01DDE5	|
	AND.b #$07				;$01DDE7	|
	STA.w $1570,X				;$01DDE9	|
	DEX					;$01DDEC	|
	BNE CODE_01DDB7				;$01DDED	|
	STZ.w $188F				;$01DDEF	|
	STZ.w $1890				;$01DDF2	|
	JSL GetRand				;$01DDF5	|
	EOR $13					;$01DDF9	|
	ADC $14					;$01DDFB	|
	AND.b #$07				;$01DDFD	|
	TAY					;$01DDFF	|
	LDA.w DATA_01DE21,Y			;$01DE00	|
	STA.w $1579				;$01DE03	|
	LDA.b #$01				;$01DE06	|
	STA $CB					;$01DE08	|
	INC.w $1B94				;$01DE0A	|
	LDX.w $15E9				;$01DE0D	|
	RTS					;$01DE10	|

DATA_01DE11:
	db $10,$00,$F0,$00

DATA_01DE15:
	db $00,$10,$00,$F0

DATA_01DE19:
	db $A0,$A0,$50,$50

DATA_01DE1D:
	db $F0,$40,$40,$F0

DATA_01DE21:
	db $01,$01,$01,$04,$04,$04,$07,$07
	db $07

BonusGame:
	STZ.w $15A0,X
	CPX.b #$01				;$01DE2D	|
	BNE CODE_01DE34				;$01DE2F	|
	JSR CODE_01E26A				;$01DE31	|
CODE_01DE34:
	JSR CODE_01DF19
	LDA $9D					;$01DE37	|
	BNE Return01DE40			;$01DE39	|
	LDA.w $188F				;$01DE3B	|
	BEQ CODE_01DE41				;$01DE3E	|
Return01DE40:
	RTS

CODE_01DE41:
	LDA $C2,X
	BNE CODE_01DE8C				;$01DE43	|
	LDA $14					;$01DE45	|
	AND.b #$03				;$01DE47	|
	BNE CODE_01DE58				;$01DE49	|
	INC.w $1570,X				;$01DE4B	|
	LDA.w $1570,X				;$01DE4E	|
	CMP.b #$09				;$01DE51	|
	BNE CODE_01DE58				;$01DE53	|
	STZ.w $1570,X				;$01DE55	|
CODE_01DE58:
	JSR MarioSprInteractRt
	BCC CODE_01DE8C				;$01DE5B	|
	LDA $7D					;$01DE5D	|
	BPL CODE_01DE8C				;$01DE5F	|
	LDA.b #$F4				;$01DE61	|
	LDY $19					;$01DE63	|
	BEQ CODE_01DE69				;$01DE65	|
	LDA.b #$00				;$01DE67	|
CODE_01DE69:
	CLC
	ADC $D8,X				;$01DE6A	|
	SEC					;$01DE6C	|
	SBC $1C					;$01DE6D	|
	CMP $80					;$01DE6F	|
	BCS CODE_01DE8C				;$01DE71	|
	LDA.b #$10				;$01DE73	|
	STA $7D					;$01DE75	|
	LDA.b #$0B				;$01DE77	|
	STA.w $1DF9				;$01DE79	|
	INC $C2,X				;$01DE7C	|
	LDY.w $1570,X				;$01DE7E	|
	LDA.w DATA_01DE21,Y			;$01DE81	|
	STA.w $1570,X				;$01DE84	|
	LDA.b #$10				;$01DE87	|
	STA.w $1540,X				;$01DE89	|
CODE_01DE8C:
	LDY.w $157C,X
	BMI Return01DEAF			;$01DE8F	|
	LDA $E4,X				;$01DE91	|
	CMP.w DATA_01DE19,Y			;$01DE93	|
	BNE CODE_01DE9F				;$01DE96	|
	LDA $D8,X				;$01DE98	|
	CMP.w DATA_01DE1D,Y			;$01DE9A	|
	BEQ CODE_01DEB0				;$01DE9D	|
CODE_01DE9F:
	LDA.w DATA_01DE11,Y
	STA $B6,X				;$01DEA2	|
	LDA.w DATA_01DE15,Y			;$01DEA4	|
	STA $AA,X				;$01DEA7	|
	JSR SubSprXPosNoGrvty			;$01DEA9	|
	JSR SubSprYPosNoGrvty			;$01DEAC	|
Return01DEAF:
	RTS

CODE_01DEB0:
	LDY.b #$09
CODE_01DEB2:
	LDA.w $00C2,y
	BEQ CODE_01DED7				;$01DEB5	|
	LDA.w $00D8,y				;$01DEB7	|
	CLC					;$01DEBA	|
	ADC.b #$04				;$01DEBB	|
	AND.b #$F8				;$01DEBD	|
	STA.w $00D8,y				;$01DEBF	|
	LDA.w $00E4,y				;$01DEC2	|
	CLC					;$01DEC5	|
	ADC.b #$04				;$01DEC6	|
	AND.b #$F8				;$01DEC8	|
	STA.w $00E4,y				;$01DECA	|
	DEY					;$01DECD	|
	BNE CODE_01DEB2				;$01DECE	|
	INC.w $188F				;$01DED0	|
	JSR CODE_01DFD9				;$01DED3	|
	RTS					;$01DED6	|

CODE_01DED7:
	LDA.w $157C,X
	INC A					;$01DEDA	|
	AND.b #$03				;$01DEDB	|
	TAY					;$01DEDD	|
	STA.w $157C,X				;$01DEDE	|
	BRA CODE_01DE9F				;$01DEE1	|

DATA_01DEE3:
	db $58

DATA_01DEE4:
	db $59

DATA_01DEE5:
	db $83

DATA_01DEE6:
	db $83,$48,$49,$58,$59,$83,$83,$48
	db $49,$34,$35,$83,$83,$24,$25,$34
	db $35,$83,$83,$24,$25,$36,$37,$83
	db $83,$26,$27,$36,$37,$83,$83,$26
	db $27

DATA_01DF07:
	db $04,$04,$04,$08,$08,$08,$0A,$0A
	db $0A

DATA_01DF10:
	db $00,$03,$05,$07,$08,$08,$07,$05
	db $03

CODE_01DF19:
	LDA.w $1540,X
	LSR					;$01DF1C	|
	TAY					;$01DF1D	|
	LDA.w DATA_01DF10,Y			;$01DF1E	|
	STA $00					;$01DF21	|
	LDY.w $15EA,X				;$01DF23	|
	LDA $E4,X				;$01DF26	|
	SEC					;$01DF28	|
	SBC $1A					;$01DF29	|
	STA.w $0310,Y				;$01DF2B	|
	STA.w $0300,Y				;$01DF2E	|
	STA.w $0308,Y				;$01DF31	|
	CLC					;$01DF34	|
	ADC.b #$08				;$01DF35	|
	STA.w $0304,Y				;$01DF37	|
	STA.w $030C,Y				;$01DF3A	|
	LDA.w $154C,X				;$01DF3D	|
	CLC					;$01DF40	|
	BEQ CODE_01DF4E				;$01DF41	|
	LSR					;$01DF43	|
	LSR					;$01DF44	|
	LSR					;$01DF45	|
	LSR					;$01DF46	|
	BRA CODE_01DF4D				;$01DF47	|

	CLC					;$01DF49	|
	ADC.w $15E9				;$01DF4A	|
CODE_01DF4D:
	LSR
CODE_01DF4E:
	PHP
	LDA $D8,X				;$01DF4F	|
	SEC					;$01DF51	|
	SBC $00					;$01DF52	|
	SEC					;$01DF54	|
	SBC $1C					;$01DF55	|
	STA.w $0311,Y				;$01DF57	|
	PLP					;$01DF5A	|
	BCS CODE_01DF6C				;$01DF5B	|
	STA.w $0301,Y				;$01DF5D	|
	STA.w $0305,Y				;$01DF60	|
	CLC					;$01DF63	|
	ADC.b #$08				;$01DF64	|
	STA.w $0309,Y				;$01DF66	|
	STA.w $030D,Y				;$01DF69	|
CODE_01DF6C:
	LDA.w $1570,X
	PHX					;$01DF6F	|
	PHA					;$01DF70	|
	ASL					;$01DF71	|
	ASL					;$01DF72	|
	TAX					;$01DF73	|
	LDA.w DATA_01DEE3,X			;$01DF74	|
	STA.w $0302,Y				;$01DF77	|
	LDA.w DATA_01DEE4,X			;$01DF7A	|
	STA.w $0306,Y				;$01DF7D	|
	LDA.w DATA_01DEE5,X			;$01DF80	|
	STA.w $030A,Y				;$01DF83	|
	LDA.w DATA_01DEE6,X			;$01DF86	|
	STA.w $030E,Y				;$01DF89	|
	LDA.b #$E4				;$01DF8C	|
	STA.w $0312,Y				;$01DF8E	|
	PLX					;$01DF91	|
	LDA $64					;$01DF92	|
	ORA.w DATA_01DF07,X			;$01DF94	|
	STA.w $0303,Y				;$01DF97	|
	STA.w $0307,Y				;$01DF9A	|
	STA.w $030B,Y				;$01DF9D	|
	STA.w $030F,Y				;$01DFA0	|
	ORA.b #$01				;$01DFA3	|
	STA.w $0313,Y				;$01DFA5	|
	PLX					;$01DFA8	|
	TYA					;$01DFA9	|
	LSR					;$01DFAA	|
	LSR					;$01DFAB	|
	TAY					;$01DFAC	|
	LDA.b #$00				;$01DFAD	|
	STA.w $0460,Y				;$01DFAF	|
	STA.w $0461,Y				;$01DFB2	|
	STA.w $0462,Y				;$01DFB5	|
	STA.w $0463,Y				;$01DFB8	|
	LDA.b #$02				;$01DFBB	|
	STA.w $0464,Y				;$01DFBD	|
	RTS					;$01DFC0	|

DATA_01DFC1:
	db $00,$01,$02,$02,$03,$04,$04,$05
	db $06,$06,$07,$00,$00,$08,$04,$02
	db $08,$06,$03,$08,$07,$01,$08,$05

CODE_01DFD9:
	LDA.b #$07
	STA $00					;$01DFDB	|
CODE_01DFDD:
	LDX.b #$02
CODE_01DFDF:
	STX $01
	LDA $00					;$01DFE1	|
	ASL					;$01DFE3	|
	ADC $00					;$01DFE4	|
	CLC					;$01DFE6	|
	ADC $01					;$01DFE7	|
	TAY					;$01DFE9	|
	LDA.w DATA_01DFC1,Y			;$01DFEA	|
	TAY					;$01DFED	|
	LDA.w DATA_01DD9A,Y			;$01DFEE	|
	STA $02					;$01DFF1	|
	LDA.w DATA_01DD91,Y			;$01DFF3	|
	STA $03					;$01DFF6	|
	LDY.b #$09				;$01DFF8	|
CODE_01DFFA:
	LDA.w $00D8,y
	CMP $02					;$01DFFD	|
	BNE CODE_01E008				;$01DFFF	|
	LDA.w $00E4,y				;$01E001	|
	CMP $03					;$01E004	|
	BEQ CODE_01E00D				;$01E006	|
CODE_01E008:
	DEY
	CPY.b #$01				;$01E009	|
	BNE CODE_01DFFA				;$01E00B	|
CODE_01E00D:
	LDA.w $1570,Y
	STA $04,X				;$01E010	|
	STY $07,X				;$01E012	|
	DEX					;$01E014	|
	BPL CODE_01DFDF				;$01E015	|
	LDA $04					;$01E017	|
	CMP $05					;$01E019	|
	BNE CODE_01E035				;$01E01B	|
	CMP $06					;$01E01D	|
	BNE CODE_01E035				;$01E01F	|
	INC.w $1890				;$01E021	|
	LDA.b #$70				;$01E024	|
	LDY $07					;$01E026	|
	STA.w $154C,Y				;$01E028	|
	LDY $08					;$01E02B	|
	STA.w $154C,Y				;$01E02D	|
	LDY $09					;$01E030	|
	STA.w $154C,Y				;$01E032	|
CODE_01E035:
	DEC $00
	BPL CODE_01DFDD				;$01E037	|
	LDX.w $15E9				;$01E039	|
	LDY.b #$29				;$01E03C	|
	LDA.w $1890				;$01E03E	|
	STA.w $1920				;$01E041	|
	BNE CODE_01E04C				;$01E044	|
	LDA.b #$58				;$01E046	|
	STA.w $14AB				;$01E048	|
	INY					;$01E04B	|
CODE_01E04C:
	STY.w $1DFC
	RTS					;$01E04F	|

InitFireball:
	LDA $D8,X
	STA.w $1528,X				;$01E052	|
	LDA.w $14D4,X				;$01E055	|
	STA.w $151C,X				;$01E058	|
CODE_01E05B:
	LDA $D8,X
	CLC					;$01E05D	|
	ADC.b #$10				;$01E05E	|
	STA $D8,X				;$01E060	|
	LDA.w $14D4,X				;$01E062	|
	ADC.b #$00				;$01E065	|
	STA.w $14D4,X				;$01E067	|
	JSR CODE_019140				;$01E06A	|
	LDA.w $164A,X				;$01E06D	|
	BEQ CODE_01E05B				;$01E070	|
	JSR CODE_01E0E2				;$01E072	|
	LDA.b #$20				;$01E075	|
	STA.w $1540,X				;$01E077	|
	RTS					;$01E07A	|

DATA_01E07B:
	db $F0,$DC,$D0,$C8,$C0,$B8,$B2,$AC
	db $A6,$A0,$9A,$96,$92,$8C,$88,$84
	db $80,$04,$08,$0C,$10,$14

DATA_01E091:
	db $70,$20

Fireballs:
	STZ.w $15D0,X
	LDA.w $1540,X				;$01E096	|
	BEQ CODE_01E0A7				;$01E099	|
	STA.w $15D0,X				;$01E09B	|
	DEC A					;$01E09E	|
	BNE Return01E0A6			;$01E09F	|
	LDA.b #$27				;$01E0A1	|
	STA.w $1DFC				;$01E0A3	|
Return01E0A6:
	RTS

CODE_01E0A7:
	LDA $9D
	BEQ CODE_01E0AE				;$01E0A9	|
	JMP CODE_01E12D				;$01E0AB	|

CODE_01E0AE:
	JSR MarioSprInteractRt
	JSR SetAnimationFrame			;$01E0B1	|
	JSR SetAnimationFrame			;$01E0B4	|
	LDA.w $15F6,X				;$01E0B7	|
	AND.b #$7F				;$01E0BA	|
	LDY $AA,X				;$01E0BC	|
	BMI CODE_01E0C8				;$01E0BE	|
	INC.w $1602,X				;$01E0C0	|
	INC.w $1602,X				;$01E0C3	|
	ORA.b #$80				;$01E0C6	|
CODE_01E0C8:
	STA.w $15F6,X
	JSR CODE_019140				;$01E0CB	|
	LDA.w $164A,X				;$01E0CE	|
	BEQ CODE_01E106				;$01E0D1	|
	LDA $AA,X				;$01E0D3	|
	BMI CODE_01E106				;$01E0D5	|
	JSL GetRand				;$01E0D7	|
	AND.b #$3F				;$01E0DB	|
	ADC.b #$60				;$01E0DD	|
	STA.w $1540,X				;$01E0DF	|
CODE_01E0E2:
	LDA $D8,X
	SEC					;$01E0E4	|
	SBC.w $1528,X				;$01E0E5	|
	STA $00					;$01E0E8	|
	LDA.w $14D4,X				;$01E0EA	|
	SBC.w $151C,X				;$01E0ED	|
	LSR					;$01E0F0	|
	ROR $00					;$01E0F1	|
	LDA $00					;$01E0F3	|
	LSR					;$01E0F5	|
	LSR					;$01E0F6	|
	LSR					;$01E0F7	|
	TAY					;$01E0F8	|
	LDA.w DATA_01E07B,Y			;$01E0F9	|
	BMI CODE_01E103				;$01E0FC	|
	STA.w $1564,X				;$01E0FE	|
	LDA.b #$80				;$01E101	|
CODE_01E103:
	STA $AA,X
	RTS					;$01E105	|

CODE_01E106:
	JSR SubSprYPosNoGrvty
	LDA $14					;$01E109	|
	AND.b #$07				;$01E10B	|
	ORA $C2,X				;$01E10D	|
	BNE CODE_01E115				;$01E10F	|
	JSL CODE_0285DF				;$01E111	|
CODE_01E115:
	LDA.w $1564,X
	BNE CODE_01E12A				;$01E118	|
	LDA $AA,X				;$01E11A	|
	BMI CODE_01E125				;$01E11C	|
	LDY $C2,X				;$01E11E	|
	CMP.w DATA_01E091,Y			;$01E120	|
	BCS CODE_01E12A				;$01E123	|
CODE_01E125:
	CLC
	ADC.b #$02				;$01E126	|
	STA $AA,X				;$01E128	|
CODE_01E12A:
	JSR SubOffscreen0Bnk1
CODE_01E12D:
	LDA $C2,X
	BEQ CODE_01E198				;$01E12F	|
	LDY $9D					;$01E131	|
	BNE CODE_01E164				;$01E133	|
	LDA.w $1588,X				;$01E135	|
	AND.b #$04				;$01E138	|
	BEQ CODE_01E151				;$01E13A	|
	STZ $AA,X				;$01E13C	|
	LDA.w $1558,X				;$01E13E	|
	BEQ CODE_01E14A				;$01E141	|
	CMP.b #$01				;$01E143	|
	BNE CODE_01E14F				;$01E145	|
	JMP CODE_019ACB				;$01E147	|

CODE_01E14A:
	LDA.b #$80
	STA.w $1558,X				;$01E14C	|
CODE_01E14F:
	BRA CODE_01E164

CODE_01E151:
	TXA
	ASL					;$01E152	|
	ASL					;$01E153	|
	CLC					;$01E154	|
	ADC $13					;$01E155	|
	LDY.b #$F0				;$01E157	|
	AND.b #$04				;$01E159	|
	BEQ CODE_01E15F				;$01E15B	|
	LDY.b #$10				;$01E15D	|
CODE_01E15F:
	STY $B6,X
	JSR SubSprXPosNoGrvty			;$01E161	|
CODE_01E164:
	LDA $D8,X
	CMP.b #$F0				;$01E166	|
	BCC CODE_01E16D				;$01E168	|
	STZ.w $14C8,X				;$01E16A	|
CODE_01E16D:
	JSR SubSprGfx2Entry1
	LDY.w $15EA,X				;$01E170	|
	PHX					;$01E173	|
	LDA $14					;$01E174	|
	AND.b #$0C				;$01E176	|
	LSR					;$01E178	|
	ADC.w $15E9				;$01E179	|
	LSR					;$01E17C	|
	AND.b #$03				;$01E17D	|
	TAX					;$01E17F	|
	LDA.w BowserFlameTiles,X		;$01E180	|
	STA.w $0302,Y				;$01E183	|
	LDA.w DATA_01E194,X			;$01E186	|
	ORA $64					;$01E189	|
	STA.w $0303,Y				;$01E18B	|
	PLX					;$01E18E	|
	RTS					;$01E18F	|

BowserFlameTiles:
	db $2A,$2C,$2A,$2C

DATA_01E194:
	db $05,$05,$45,$45

CODE_01E198:
	LDA.b #$01
	JSR SubSprGfx0Entry0			;$01E19A	|
	REP #$20				;$01E19D	|
	LDA.w #$0008				;$01E19F	|
	ASL					;$01E1A2	|
	ASL					;$01E1A3	|
	ASL					;$01E1A4	|
	ASL					;$01E1A5	|
	ASL					;$01E1A6	|
	CLC					;$01E1A7	|
	ADC.w #$8500				;$01E1A8	|
	STA.w $0D8B				;$01E1AB	|
	CLC					;$01E1AE	|
	ADC.w #$0200				;$01E1AF	|
	STA.w $0D95				;$01E1B2	|
	SEP #$20				;$01E1B5	|
	RTS					;$01E1B7	|

InitKeyHole:
	LDA $E4,X
	CLC					;$01E1BA	|
	ADC.b #$08				;$01E1BB	|
	STA $E4,X				;$01E1BD	|
	LDA.w $14E0,X				;$01E1BF	|
	ADC.b #$00				;$01E1C2	|
	STA.w $14E0,X				;$01E1C4	|
	RTS					;$01E1C7	|

Keyhole:
	LDY.b #$0B
CODE_01E1CA:
	LDA.w $14C8,Y
	CMP.b #$08				;$01E1CD	|
	BCC CODE_01E1D8				;$01E1CF	|
	LDA.w $009E,y				;$01E1D1	|
	CMP.b #$80				;$01E1D4	|
	BEQ CODE_01E1DB				;$01E1D6	|
CODE_01E1D8:
	DEY
	BPL CODE_01E1CA				;$01E1D9	|
CODE_01E1DB:
	LDA.w $187A
	BEQ CODE_01E1E5				;$01E1DE	|
	LDA.w $191C				;$01E1E0	|
	BNE CODE_01E1ED				;$01E1E3	|
CODE_01E1E5:
	TYA
	STA.w $151C,X				;$01E1E6	|
	BMI CODE_01E23A				;$01E1E9	|
	BRA CODE_01E1F3				;$01E1EB	|

CODE_01E1ED:
	JSL GetMarioClipping
	BRA CODE_01E201				;$01E1F1	|

CODE_01E1F3:
	LDA.w $14C8,Y
	CMP.b #$0B				;$01E1F6	|
	BNE CODE_01E23A				;$01E1F8	|
	PHX					;$01E1FA	|
	TYX					;$01E1FB	|
	JSL GetSpriteClippingB			;$01E1FC	|
	PLX					;$01E200	|
CODE_01E201:
	JSL GetSpriteClippingA
	JSL CheckForContact			;$01E205	|
	BCC CODE_01E23A				;$01E209	|
	LDA.w $154C,X				;$01E20B	|
	BNE CODE_01E23A				;$01E20E	|
	LDA.b #$30				;$01E210	|
	STA.w $1434				;$01E212	|
	LDA.b #$10				;$01E215	|
	STA.w $1DFB				;$01E217	|
	INC.w $13FB				;$01E21A	|
	INC $9D					;$01E21D	|
	LDA.w $14E0,X				;$01E21F	|
	STA.w $1437				;$01E222	|
	LDA $E4,X				;$01E225	|
	STA.w $1436				;$01E227	|
	LDA.w $14D4,X				;$01E22A	|
	STA.w $1439				;$01E22D	|
	LDA $D8,X				;$01E230	|
	STA.w $1438				;$01E232	|
	LDA.b #$30				;$01E235	|
	STA.w $154C,X				;$01E237	|
CODE_01E23A:
	JSR GetDrawInfoBnk1
	LDA $00					;$01E23D	|
	STA.w $0300,Y				;$01E23F	|
	STA.w $0304,Y				;$01E242	|
	LDA $01					;$01E245	|
	STA.w $0301,Y				;$01E247	|
	CLC					;$01E24A	|
	ADC.b #$08				;$01E24B	|
	STA.w $0305,Y				;$01E24D	|
	LDA.b #$EB				;$01E250	|
	STA.w $0302,Y				;$01E252	|
	LDA.b #$FB				;$01E255	|
	STA.w $0306,Y				;$01E257	|
	LDA.b #$30				;$01E25A	|
	STA.w $0303,Y				;$01E25C	|
	STA.w $0307,Y				;$01E25F	|
	LDY.b #$00				;$01E262	|
	LDA.b #$01				;$01E264	|
	JSR FinishOAMWriteRt			;$01E266	|
	RTS					;$01E269	|

CODE_01E26A:
	LDA $13
	AND.b #$3F				;$01E26C	|
	BNE CODE_01E27B				;$01E26E	|
	LDA.w $1890				;$01E270	|
	BEQ CODE_01E27B				;$01E273	|
	DEC.w $1890				;$01E275	|
	JSR CODE_01E281				;$01E278	|
CODE_01E27B:
	LDA.b #$01
	STA.w $18B8				;$01E27D	|
	RTS					;$01E280	|

CODE_01E281:
	LDY.b #$07
CODE_01E283:
	LDA.w $1892,Y
	BEQ CODE_01E28C				;$01E286	|
	DEY					;$01E288	|
	BPL CODE_01E283				;$01E289	|
	RTS					;$01E28B	|

CODE_01E28C:
	LDA.b #$01
	STA.w $1892,Y				;$01E28E	|
	LDA.b #$00				;$01E291	|
	STA.w $1E02,Y				;$01E293	|
	LDA.b #$01				;$01E296	|
	STA.w $1E2A,Y				;$01E298	|
	LDA.b #$18				;$01E29B	|
	STA.w $1E16,Y				;$01E29D	|
	LDA.b #$00				;$01E2A0	|
	STA.w $1E3E,Y				;$01E2A2	|
	LDA.b #$01				;$01E2A5	|
	STA.w $1E66,Y				;$01E2A7	|
	LDA.b #$10				;$01E2AA	|
	STA.w $1E52,Y				;$01E2AC	|
	RTS					;$01E2AF	|

DATA_01E2B0:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $13,$14,$15,$16,$17,$18,$19

MontyMole:
	JSR SubOffscreen0Bnk1
	LDA $C2,X				;$01E2D2	|
	JSL ExecutePtr				;$01E2D4	|

Ptrs01E2D8:
	dw CODE_01E2E0
	dw CODE_01E309
	dw CODE_01E37F
	dw CODE_01E393

CODE_01E2E0:
	JSR SubHorizPos
	LDA $0F					;$01E2E3	|
	CLC					;$01E2E5	|
	ADC.b #$60				;$01E2E6	|
	CMP.b #$C0				;$01E2E8	|
	BCS CODE_01E305				;$01E2EA	|
	LDA.w $15A0,X				;$01E2EC	|
	BNE CODE_01E305				;$01E2EF	|
	INC $C2,X				;$01E2F1	|
	LDY.w $0DB3				;$01E2F3	|
	LDA.w $1F11,Y				;$01E2F6	|
	TAY					;$01E2F9	|
	LDA.b #$68				;$01E2FA	|
	CPY.b #$01				;$01E2FC	|
	BEQ CODE_01E302				;$01E2FE	|
	LDA.b #$20				;$01E300	|
CODE_01E302:
	STA.w $1540,X
CODE_01E305:
	JSR GetDrawInfoBnk1
	RTS					;$01E308	|

CODE_01E309:
	LDA.w $1540,X
	ORA.w $15D0,X				;$01E30C	|
	BNE CODE_01E343				;$01E30F	|
	INC $C2,X				;$01E311	|
	LDA.b #$B0				;$01E313	|
	STA $AA,X				;$01E315	|
	JSR IsSprOffScreen			;$01E317	|
	BNE CODE_01E320				;$01E31A	|
	TAY					;$01E31C	|
	JSR CODE_0199E1				;$01E31D	|
CODE_01E320:
	JSR FaceMario
	LDA $9E,X				;$01E323	|
	CMP.b #$4E				;$01E325	|
	BNE CODE_01E343				;$01E327	|
	LDA $E4,X				;$01E329	|
	STA $9A					;$01E32B	|
	LDA.w $14E0,X				;$01E32D	|
	STA $9B					;$01E330	|
	LDA $D8,X				;$01E332	|
	STA $98					;$01E334	|
	LDA.w $14D4,X				;$01E336	|
	STA $99					;$01E339	|
	LDA.b #$08				;$01E33B	|
	STA $9C					;$01E33D	|
	JSL generate_tile			;$01E33F	|
CODE_01E343:
	LDA $9E,X
	CMP.b #$4D				;$01E345	|
	BNE CODE_01E363				;$01E347	|
	LDA $14					;$01E349	|
	LSR					;$01E34B	|
	LSR					;$01E34C	|
	LSR					;$01E34D	|
	LSR					;$01E34E	|
	AND.b #$01				;$01E34F	|
	TAY					;$01E351	|
	LDA.w DATA_01E35F,Y			;$01E352	|
	STA.w $1602,X				;$01E355	|
	LDA.w DATA_01E361,Y			;$01E358	|
	JSR SubSprGfx0Entry0			;$01E35B	|
	RTS					;$01E35E	|

DATA_01E35F:
	db $01,$02

DATA_01E361:
	db $00,$05

CODE_01E363:
	LDA $14
	ASL					;$01E365	|
	ASL					;$01E366	|
	AND.b #$C0				;$01E367	|
	ORA.b #$31				;$01E369	|
	STA.w $15F6,X				;$01E36B	|
	LDA.b #$03				;$01E36E	|
	STA.w $1602,X				;$01E370	|
	JSR SubSprGfx2Entry1			;$01E373	|
	LDA.w $15F6,X				;$01E376	|
	AND.b #$3F				;$01E379	|
	STA.w $15F6,X				;$01E37B	|
	RTS					;$01E37E	|

CODE_01E37F:
	JSR CODE_01E3EF
	LDA.b #$02				;$01E382	|
	STA.w $1602,X				;$01E384	|
	JSR IsOnGround				;$01E387	|
	BEQ Return01E38E			;$01E38A	|
	INC $C2,X				;$01E38C	|
Return01E38E:
	RTS

DATA_01E38F:
	db $10,$F0

DATA_01E391:
	db $18,$E8

CODE_01E393:
	JSR CODE_01E3EF
	LDA.w $151C,X				;$01E396	|
	BNE CODE_01E3C7				;$01E399	|
	JSR SetAnimationFrame			;$01E39B	|
	JSR SetAnimationFrame			;$01E39E	|
	JSL GetRand				;$01E3A1	|
	AND.b #$01				;$01E3A5	|
	BNE Return01E3C6			;$01E3A7	|
	JSR FaceMario				;$01E3A9	|
	LDA $B6,X				;$01E3AC	|
	CMP.w DATA_01E391,Y			;$01E3AE	|
	BEQ Return01E3C6			;$01E3B1	|
	CLC					;$01E3B3	|
	ADC.w DATA_01EBB4,Y			;$01E3B4	|
	STA $B6,X				;$01E3B7	|
	TYA					;$01E3B9	|
	LSR					;$01E3BA	|
	ROR					;$01E3BB	|
	EOR $B6,X				;$01E3BC	|
	BPL Return01E3C6			;$01E3BE	|
	JSR CODE_01804E				;$01E3C0	|
	JSR SetAnimationFrame			;$01E3C3	|
Return01E3C6:
	RTS

CODE_01E3C7:
	JSR IsOnGround
	BEQ CODE_01E3E9				;$01E3CA	|
	JSR SetAnimationFrame			;$01E3CC	|
	JSR SetAnimationFrame			;$01E3CF	|
	LDY.w $157C,X				;$01E3D2	|
	LDA.w DATA_01E38F,Y			;$01E3D5	|
	STA $B6,X				;$01E3D8	|
	LDA.w $1558,X				;$01E3DA	|
	BNE Return01E3E8			;$01E3DD	|
	LDA.b #$50				;$01E3DF	|
	STA.w $1558,X				;$01E3E1	|
	LDA.b #$D8				;$01E3E4	|
	STA $AA,X				;$01E3E6	|
Return01E3E8:
	RTS

CODE_01E3E9:
	LDA.b #$01
	STA.w $1602,X				;$01E3EB	|
	RTS					;$01E3EE	|

CODE_01E3EF:
	LDA $64
	PHA					;$01E3F1	|
	LDA.w $1540,X				;$01E3F2	|
	BEQ CODE_01E3FB				;$01E3F5	|
	LDA.b #$10				;$01E3F7	|
	STA $64					;$01E3F9	|
CODE_01E3FB:
	JSR SubSprGfx2Entry1
	PLA					;$01E3FE	|
	STA $64					;$01E3FF	|
	LDA $9D					;$01E401	|
	BNE CODE_01E41C				;$01E403	|
	JSR SubSprSprPMarioSpr			;$01E405	|
	JSR SubUpdateSprPos			;$01E408	|
	JSR IsOnGround				;$01E40B	|
	BEQ CODE_01E413				;$01E40E	|
	JSR SetSomeYSpeed			;$01E410	|
CODE_01E413:
	JSR IsTouchingObjSide
	BEQ Return01E41B			;$01E416	|
	JSR FlipSpriteDir			;$01E418	|
Return01E41B:
	RTS

CODE_01E41C:
	PLA
	PLA					;$01E41D	|
	RTS					;$01E41E	|

DATA_01E41F:
	db $08,$F8,$02,$03,$04,$04,$04,$04
	db $04,$04,$04,$04

DryBonesAndBeetle:
	LDA.w $14C8,X
	CMP.b #$08				;$01E42E	|
	BEQ CODE_01E43E				;$01E430	|
	ASL.w $15F6,X				;$01E432	|
	SEC					;$01E435	|
	ROR.w $15F6,X				;$01E436	|
	JMP CODE_01E5BF				;$01E439	|

DATA_01E43C:
	db $08,$F8

CODE_01E43E:
	LDA.w $1534,X
	BEQ CODE_01E4C0				;$01E441	|
	JSR SubSprGfx2Entry1			;$01E443	|
	LDY.w $1540,X				;$01E446	|
	BNE CODE_01E453				;$01E449	|
	STZ.w $1534,X				;$01E44B	|
	PHY					;$01E44E	|
	JSR FaceMario				;$01E44F	|
	PLY					;$01E452	|
CODE_01E453:
	LDA.b #$48
	CPY.b #$10				;$01E455	|
	BCC CODE_01E45F				;$01E457	|
	CPY.b #$F0				;$01E459	|
	BCS CODE_01E45F				;$01E45B	|
	LDA.b #$2E				;$01E45D	|
CODE_01E45F:
	LDY.w $15EA,X
	STA.w $0302,Y				;$01E462	|
	TYA					;$01E465	|
	CLC					;$01E466	|
	ADC.b #$04				;$01E467	|
	STA.w $15EA,X				;$01E469	|
	PHX					;$01E46C	|
	LDA.w $157C,X				;$01E46D	|
	TAX					;$01E470	|
	LDA.w $0300,Y				;$01E471	|
	CLC					;$01E474	|
	ADC.w DATA_01E43C,X			;$01E475	|
	PLX					;$01E478	|
	STA.w $0304,Y				;$01E479	|
	LDA.w $0301,Y				;$01E47C	|
	STA.w $0305,Y				;$01E47F	|
	LDA.w $0303,Y				;$01E482	|
	STA.w $0307,Y				;$01E485	|
	LDA.w $0302,Y				;$01E488	|
	DEC A					;$01E48B	|
	STA.w $0306,Y				;$01E48C	|
	LDA.w $1540,X				;$01E48F	|
	BEQ CODE_01E4AC				;$01E492	|
	CMP.b #$40				;$01E494	|
	BCS CODE_01E4AC				;$01E496	|
	LSR					;$01E498	|
	LSR					;$01E499	|
	PHP					;$01E49A	|
	LDA.w $0300,Y				;$01E49B	|
	ADC.b #$00				;$01E49E	|
	STA.w $0300,Y				;$01E4A0	|
	PLP					;$01E4A3	|
	LDA.w $0304,Y				;$01E4A4	|
	ADC.b #$00				;$01E4A7	|
	STA.w $0304,Y				;$01E4A9	|
CODE_01E4AC:
	LDY.b #$02
	LDA.b #$01				;$01E4AE	|
	JSR FinishOAMWriteRt			;$01E4B0	|
	JSR SubUpdateSprPos			;$01E4B3	|
	JSR IsOnGround				;$01E4B6	|
	BEQ Return01E4BF			;$01E4B9	|
	STZ $AA,X				;$01E4BB	|
	STZ $B6,X				;$01E4BD	|
Return01E4BF:
	RTS

CODE_01E4C0:
	LDA $9D
	ORA.w $163E,X				;$01E4C2	|
	BEQ CODE_01E4CA				;$01E4C5	|
	JMP CODE_01E5B6				;$01E4C7	|

CODE_01E4CA:
	LDY.w $157C,X
	LDA.w DATA_01E41F,Y			;$01E4CD	|
	EOR.w $15B8,X				;$01E4D0	|
	ASL					;$01E4D3	|
	LDA.w DATA_01E41F,Y			;$01E4D4	|
	BCC CODE_01E4DD				;$01E4D7	|
	CLC					;$01E4D9	|
	ADC.w $15B8,X				;$01E4DA	|
CODE_01E4DD:
	STA $B6,X
	LDA.w $1540,X				;$01E4DF	|
	BNE CODE_01E4ED				;$01E4E2	|
	TYA					;$01E4E4	|
	INC A					;$01E4E5	|
	AND.w $1588,X				;$01E4E6	|
	AND.b #$03				;$01E4E9	|
	BEQ CODE_01E4EF				;$01E4EB	|
CODE_01E4ED:
	STZ $B6,X
CODE_01E4EF:
	JSR IsTouchingCeiling
	BEQ CODE_01E4F6				;$01E4F2	|
	STZ $AA,X				;$01E4F4	|
CODE_01E4F6:
	JSR SubOffscreen0Bnk1
	JSR SubUpdateSprPos			;$01E4F9	|
	LDA $9E,X				;$01E4FC	|
	CMP.b #$31				;$01E4FE	|
	BNE CODE_01E51E				;$01E500	|
	LDA.w $1540,X				;$01E502	|
	BEQ CODE_01E542				;$01E505	|
	LDY.b #$00				;$01E507	|
	CMP.b #$70				;$01E509	|
	BCS CODE_01E518				;$01E50B	|
	INY					;$01E50D	|
	INY					;$01E50E	|
	CMP.b #$08				;$01E50F	|
	BCC CODE_01E518				;$01E511	|
	CMP.b #$68				;$01E513	|
	BCS CODE_01E518				;$01E515	|
	INY					;$01E517	|
CODE_01E518:
	TYA
	STA.w $1602,X				;$01E519	|
	BRA CODE_01E563				;$01E51C	|

CODE_01E51E:
	CMP.b #$30
	BEQ CODE_01E52D				;$01E520	|
	CMP.b #$32				;$01E522	|
	BNE CODE_01E542				;$01E524	|
	LDA.w $13BF				;$01E526	|
	CMP.b #$31				;$01E529	|
	BNE CODE_01E542				;$01E52B	|
CODE_01E52D:
	LDA.w $1540,X
	BEQ CODE_01E542				;$01E530	|
	CMP.b #$01				;$01E532	|
	BNE CODE_01E53A				;$01E534	|
	JSL CODE_03C44E				;$01E536	|
CODE_01E53A:
	LDA.b #$02
	STA.w $1602,X				;$01E53C	|
	JMP CODE_01E5B6				;$01E53F	|

CODE_01E542:
	JSR IsOnGround
	BEQ CODE_01E563				;$01E545	|
	JSR SetSomeYSpeed			;$01E547	|
	JSR SetAnimationFrame			;$01E54A	|
	LDA $9E,X				;$01E54D	|
	CMP.b #$32				;$01E54F	|
	BNE CODE_01E557				;$01E551	|
	STZ $C2,X				;$01E553	|
	BRA CODE_01E561				;$01E555	|

CODE_01E557:
	LDA.w $1570,X
	AND.b #$7F				;$01E55A	|
	BNE CODE_01E561				;$01E55C	|
	JSR FaceMario				;$01E55E	|
CODE_01E561:
	BRA CODE_01E57B

CODE_01E563:
	STZ.w $1570,X
	LDA $9E,X				;$01E566	|
	CMP.b #$32				;$01E568	|
	BNE CODE_01E57B				;$01E56A	|
	LDA $C2,X				;$01E56C	|
	BNE CODE_01E57B				;$01E56E	|
	INC $C2,X				;$01E570	|
	JSR FlipSpriteDir			;$01E572	|
	JSR SubSprXPosNoGrvty			;$01E575	|
	JSR SubSprXPosNoGrvty			;$01E578	|
CODE_01E57B:
	LDA $9E,X
	CMP.b #$31				;$01E57D	|
	BNE CODE_01E598				;$01E57F	|
	LDA $13					;$01E581	|
	LSR					;$01E583	|
	BCC CODE_01E589				;$01E584	|
	INC.w $1528,X				;$01E586	|
CODE_01E589:
	LDA.w $1528,X
	BNE CODE_01E5B6				;$01E58C	|
	INC.w $1528,X				;$01E58E	|
	LDA.b #$A0				;$01E591	|
	STA.w $1540,X				;$01E593	|
	BRA CODE_01E5B6				;$01E596	|

CODE_01E598:
	CMP.b #$30
	BEQ CODE_01E5A7				;$01E59A	|
	CMP.b #$32				;$01E59C	|
	BNE CODE_01E5B6				;$01E59E	|
	LDA.w $13BF				;$01E5A0	|
	CMP.b #$31				;$01E5A3	|
	BNE CODE_01E5B6				;$01E5A5	|
CODE_01E5A7:
	LDA.w $1570,X
	CLC					;$01E5AA	|
	ADC.b #$40				;$01E5AB	|
	AND.b #$7F				;$01E5AD	|
	BNE CODE_01E5B6				;$01E5AF	|
	LDA.b #$3F				;$01E5B1	|
	STA.w $1540,X				;$01E5B3	|
CODE_01E5B6:
	JSR CODE_01E5C4
	JSR SubSprSprInteract			;$01E5B9	|
	JSR FlipIfTouchingObj			;$01E5BC	|
CODE_01E5BF:
	JSL CODE_03C390
	RTS					;$01E5C3	|

CODE_01E5C4:
	JSR MarioSprInteractRt
	BCC Return01E610			;$01E5C7	|
	LDA $D3					;$01E5C9	|
	CLC					;$01E5CB	|
	ADC.b #$14				;$01E5CC	|
	CMP $D8,X				;$01E5CE	|
	BPL CODE_01E604				;$01E5D0	|
	LDA.w $1697				;$01E5D2	|
	BNE CODE_01E5DB				;$01E5D5	|
	LDA $7D					;$01E5D7	|
	BMI CODE_01E604				;$01E5D9	|
CODE_01E5DB:
	LDA $9E,X
	CMP.b #$31				;$01E5DD	|
	BNE CODE_01E5EB				;$01E5DF	|
	LDA.w $1540,X				;$01E5E1	|
	SEC					;$01E5E4	|
	SBC.b #$08				;$01E5E5	|
	CMP.b #$60				;$01E5E7	|
	BCC CODE_01E604				;$01E5E9	|
CODE_01E5EB:
	JSR CODE_01AB46
	JSL DisplayContactGfx			;$01E5EE	|
	LDA.b #$07				;$01E5F2	|
	STA.w $1DF9				;$01E5F4	|
	JSL BoostMarioSpeed			;$01E5F7	|
	INC.w $1534,X				;$01E5FB	|
	LDA.b #$FF				;$01E5FE	|
	STA.w $1540,X				;$01E600	|
	RTS					;$01E603	|

CODE_01E604:
	JSL HurtMario
	LDA.w $1497				;$01E608	|
	BNE Return01E610			;$01E60B	|
	JSR FaceMario				;$01E60D	|
Return01E610:
	RTS

DATA_01E611:
	db $00,$01,$02,$02,$02,$01,$01,$00
	db $00

DATA_01E61A:
	db $1E,$1B,$18,$18,$18,$1A,$1C,$1D
	db $1E

SpringBoard:
	LDA $9D
	BEQ CODE_01E62A				;$01E625	|
	JMP CODE_01E6F0				;$01E627	|

CODE_01E62A:
	JSR SubOffscreen0Bnk1
	JSR SubUpdateSprPos			;$01E62D	|
	JSR IsOnGround				;$01E630	|
	BEQ CODE_01E638				;$01E633	|
	JSR CODE_0197D5				;$01E635	|
CODE_01E638:
	JSR IsTouchingObjSide
	BEQ CODE_01E649				;$01E63B	|
	JSR FlipSpriteDir			;$01E63D	|
	LDA $B6,X				;$01E640	|
	ASL					;$01E642	|
	PHP					;$01E643	|
	ROR $B6,X				;$01E644	|
	PLP					;$01E646	|
	ROR $B6,X				;$01E647	|
CODE_01E649:
	JSR IsTouchingCeiling
	BEQ CODE_01E650				;$01E64C	|
	STZ $AA,X				;$01E64E	|
CODE_01E650:
	LDA.w $1540,X
	BEQ CODE_01E6B0				;$01E653	|
	LSR					;$01E655	|
	TAY					;$01E656	|
	LDA.w $187A				;$01E657	|
	CMP.b #$01				;$01E65A	|
	LDA.w DATA_01E61A,Y			;$01E65C	|
	BCC CODE_01E664				;$01E65F	|
	CLC					;$01E661	|
	ADC.b #$12				;$01E662	|
CODE_01E664:
	STA $00
	LDA.w DATA_01E611,Y			;$01E666	|
	STA.w $1602,X				;$01E669	|
	LDA $D8,X				;$01E66C	|
	SEC					;$01E66E	|
	SBC $00					;$01E66F	|
	STA $96					;$01E671	|
	LDA.w $14D4,X				;$01E673	|
	SBC.b #$00				;$01E676	|
	STA $97					;$01E678	|
	STZ $72					;$01E67A	|
	STZ $7B					;$01E67C	|
	LDA.b #$02				;$01E67E	|
	STA.w $1471				;$01E680	|
	LDA.w $1540,X				;$01E683	|
	CMP.b #$07				;$01E686	|
	BCS CODE_01E6AE				;$01E688	|
	STZ.w $1471				;$01E68A	|
	LDY.b #$B0				;$01E68D	|
	LDA $17					;$01E68F	|
	BPL CODE_01E69A				;$01E691	|
	LDA.b #$01				;$01E693	|
	STA.w $140D				;$01E695	|
	BRA CODE_01E69E				;$01E698	|

CODE_01E69A:
	LDA $15
	BPL CODE_01E6A7				;$01E69C	|
CODE_01E69E:
	LDA.b #$0B
	STA $72					;$01E6A0	|
	LDY.b #$80				;$01E6A2	|
	STY.w $1406				;$01E6A4	|
CODE_01E6A7:
	STY $7D
	LDA.b #$08				;$01E6A9	|
	STA.w $1DFC				;$01E6AB	|
CODE_01E6AE:
	BRA CODE_01E6F0

CODE_01E6B0:
	JSR ProcessInteract
	BCC CODE_01E6F0				;$01E6B3	|
	STZ.w $154C,X				;$01E6B5	|
	LDA $D8,X				;$01E6B8	|
	SEC					;$01E6BA	|
	SBC $96					;$01E6BB	|
	CLC					;$01E6BD	|
	ADC.b #$04				;$01E6BE	|
	CMP.b #$1C				;$01E6C0	|
	BCC CODE_01E6CE				;$01E6C2	|
	BPL CODE_01E6E7				;$01E6C4	|
	LDA $7D					;$01E6C6	|
	BPL CODE_01E6F0				;$01E6C8	|
	STZ $7D					;$01E6CA	|
	BRA CODE_01E6F0				;$01E6CC	|

CODE_01E6CE:
	BIT $15
	BVC CODE_01E6E2				;$01E6D0	|
	LDA.w $1470				;$01E6D2	|
	ORA.w $187A				;$01E6D5	|
	BNE CODE_01E6E2				;$01E6D8	|
	LDA.b #$0B				;$01E6DA	|
	STA.w $14C8,X				;$01E6DC	|
	STZ.w $1602,X				;$01E6DF	|
CODE_01E6E2:
	JSR CODE_01AB31
	BRA CODE_01E6F0				;$01E6E5	|

CODE_01E6E7:
	LDA $7D
	BMI CODE_01E6F0				;$01E6E9	|
	LDA.b #$11				;$01E6EB	|
	STA.w $1540,X				;$01E6ED	|
CODE_01E6F0:
	LDY.w $1602,X
	LDA.w DATA_01E6FD,Y			;$01E6F3	|
	TAY					;$01E6F6	|
	LDA.b #$02				;$01E6F7	|
	JSR SubSprGfx0Entry1			;$01E6F9	|
	RTS					;$01E6FC	|

DATA_01E6FD:
	db $00,$02,$00

SmushedGfxRt:
	JSR GetDrawInfoBnk1
	JSR IsSprOffScreen			;$01E703	|
	BNE Return01E75A			;$01E706	|
	LDA $00					;$01E708	|
	STA.w $0300,Y				;$01E70A	|
	CLC					;$01E70D	|
	ADC.b #$08				;$01E70E	|
	STA.w $0304,Y				;$01E710	|
	LDA $01					;$01E713	|
	CLC					;$01E715	|
	ADC.b #$08				;$01E716	|
	STA.w $0301,Y				;$01E718	|
	STA.w $0305,Y				;$01E71B	|
	PHX					;$01E71E	|
	LDA $9E,X				;$01E71F	|
	TAX					;$01E721	|
	LDA.b #$FE				;$01E722	|
	CPX.b #$3E				;$01E724	|
	BEQ CODE_01E73A				;$01E726	|
	LDA.b #$EE				;$01E728	|
	CPX.b #$BD				;$01E72A	|
	BEQ CODE_01E73A				;$01E72C	|
	CPX.b #$04				;$01E72E	|
	BCC CODE_01E73A				;$01E730	|
	LDA.b #$C7				;$01E732	|
	CPX.b #$0F				;$01E734	|
	BCS CODE_01E73A				;$01E736	|
	LDA.b #$4D				;$01E738	|
CODE_01E73A:
	STA.w $0302,Y
	STA.w $0306,Y				;$01E73D	|
	PLX					;$01E740	|
	LDA $64					;$01E741	|
	ORA.w $15F6,X				;$01E743	|
	STA.w $0303,Y				;$01E746	|
	ORA.b #$40				;$01E749	|
	STA.w $0307,Y				;$01E74B	|
	TYA					;$01E74E	|
	LSR					;$01E74F	|
	LSR					;$01E750	|
	TAY					;$01E751	|
	LDA.b #$00				;$01E752	|
	STA.w $0460,Y				;$01E754	|
	STA.w $0461,Y				;$01E757	|
Return01E75A:
	RTS

PSwitch:
	LDA.w $1564,X
	CMP.b #$01				;$01E75E	|
	BNE Return01E76E			;$01E760	|
	STA.w $1F11				;$01E762	|
	STA.w $1FB8				;$01E765	|
	STZ.w $14C8,X				;$01E768	|
	INC.w $1426				;$01E76B	|
Return01E76E:
	RTS

DATA_01E76F:
	db $FC,$04,$FE,$02,$FB,$05,$FD,$03
	db $FA,$06,$FC,$04,$FB,$05,$FD,$03
DATA_01E77F:
	db $00,$FF,$03,$04,$FF,$FE,$04,$03
	db $FE,$FF,$03,$03,$FF,$00,$03,$03
	db $F8,$FC,$00,$04

DATA_01E793:
	db $0E,$0F,$10,$11,$12,$11,$10,$0F
	db $1A,$1B,$1C,$1D,$1E,$1D,$1C,$1B
	db $1A

LakituCloud:
	LDA $9D
	BEQ NoCloudGfx				;$01E7A6	|
CODE_01E7A8:
	JMP LakituCloudGfx

NoCloudGfx:
	LDY.w $18E0
	BEQ CODE_01E7C5				;$01E7AE	|
	LDA $14					;$01E7B0	|
	AND.b #$03				;$01E7B2	|
	BNE CODE_01E7C5				;$01E7B4	|
	LDA.w $18E0				;$01E7B6	|
	BEQ CODE_01E7C5				;$01E7B9	|
	DEC.w $18E0				;$01E7BB	|
	BNE CODE_01E7C5				;$01E7BE	|
	LDA.b #$1F				;$01E7C0	|
	STA.w $1540,X				;$01E7C2	|
CODE_01E7C5:
	LDA.w $1540,X
	BEQ CODE_01E7DB				;$01E7C8	|
	DEC A					;$01E7CA	|
	BNE CODE_01E7A8				;$01E7CB	|
	STZ.w $14C8,X				;$01E7CD	|
	LDA.b #$FF				;$01E7D0	|
	STA.w $18C0				;$01E7D2	|
	LDA.b #$1E				;$01E7D5	|
	STA.w $18C1				;$01E7D7	|
	RTS					;$01E7DA	|

CODE_01E7DB:
	LDY.b #$09
CODE_01E7DD:
	LDA.w $14C8,Y
	CMP.b #$08				;$01E7E0	|
	BNE CODE_01E7F2				;$01E7E2	|
	LDA.w $009E,y				;$01E7E4	|
	CMP.b #$1E				;$01E7E7	|
	BNE CODE_01E7F2				;$01E7E9	|
	TYA					;$01E7EB	|
	STA.w $160E,X				;$01E7EC	|
	JMP CODE_01E898				;$01E7EF	|

CODE_01E7F2:
	DEY
	BPL CODE_01E7DD				;$01E7F3	|
	LDA $C2,X				;$01E7F5	|
	BNE CODE_01E840				;$01E7F7	|
	LDA.w $151C,X				;$01E7F9	|
	BEQ CODE_01E804				;$01E7FC	|
	JSR SubSprXPosNoGrvty			;$01E7FE	|
	JSR SubSprYPosNoGrvty			;$01E801	|
CODE_01E804:
	LDA.w $154C,X
	BNE CODE_01E83D				;$01E807	|
	JSR ProcessInteract			;$01E809	|
	BCC CODE_01E83D				;$01E80C	|
	LDA $7D					;$01E80E	|
	BMI CODE_01E83D				;$01E810	|
	INC $C2,X				;$01E812	|
	LDA.b #$11				;$01E814	|
	LDY.w $187A				;$01E816	|
	BEQ CODE_01E81D				;$01E819	|
	LDA.b #$22				;$01E81B	|
CODE_01E81D:
	CLC
	ADC $D3					;$01E81E	|
	STA $D8,X				;$01E820	|
	LDA $D4					;$01E822	|
	ADC.b #$00				;$01E824	|
	STA.w $14D4,X				;$01E826	|
	LDA $D1					;$01E829	|
	STA $E4,X				;$01E82B	|
	LDA $D2					;$01E82D	|
	STA.w $14E0,X				;$01E82F	|
	LDA.b #$10				;$01E832	|
	STA $AA,X				;$01E834	|
	STA.w $151C,X				;$01E836	|
	LDA $7B					;$01E839	|
	STA $B6,X				;$01E83B	|
CODE_01E83D:
	JMP LakituCloudGfx

CODE_01E840:
	JSR LakituCloudGfx
	PHB					;$01E843	|
	LDA.b #$02				;$01E844	|
	PHA					;$01E846	|
	PLB					;$01E847	|
	JSL CODE_02D214				;$01E848	|
	PLB					;$01E84C	|
	LDA $AA,X				;$01E84D	|
	CLC					;$01E84F	|
	ADC.b #$03				;$01E850	|
	STA $7D					;$01E852	|
	LDA $14					;$01E854	|
	LSR					;$01E856	|
	LSR					;$01E857	|
	LSR					;$01E858	|
	AND.b #$07				;$01E859	|
	TAY					;$01E85B	|
	LDA.w $187A				;$01E85C	|
	BEQ CODE_01E866				;$01E85F	|
	TYA					;$01E861	|
	CLC					;$01E862	|
	ADC.b #$08				;$01E863	|
	TAY					;$01E865	|
CODE_01E866:
	LDA $D1
	STA $E4,X				;$01E868	|
	LDA $D2					;$01E86A	|
	STA.w $14E0,X				;$01E86C	|
	LDA $D3					;$01E86F	|
	CLC					;$01E871	|
	ADC.w DATA_01E793,Y			;$01E872	|
	STA $D8,X				;$01E875	|
	LDA $D4					;$01E877	|
	ADC.b #$00				;$01E879	|
	STA.w $14D4,X				;$01E87B	|
	STZ $72					;$01E87E	|
	INC.w $1471				;$01E880	|
	INC.w $18C2				;$01E883	|
	LDA $16					;$01E886	|
	AND.b #$80				;$01E888	|
	BEQ Return01E897			;$01E88A	|
	LDA.b #$C0				;$01E88C	|
	STA $7D					;$01E88E	|
	LDA.b #$10				;$01E890	|
	STA.w $154C,X				;$01E892	|
	STZ $C2,X				;$01E895	|
Return01E897:
	RTS

CODE_01E898:
	PHY
	JSR CODE_01E98D				;$01E899	|
	LDA $14					;$01E89C	|
	LSR					;$01E89E	|
	LSR					;$01E89F	|
	LSR					;$01E8A0	|
	AND.b #$07				;$01E8A1	|
	TAY					;$01E8A3	|
	LDA.w DATA_01E793,Y			;$01E8A4	|
	STA $00					;$01E8A7	|
	PLY					;$01E8A9	|
	LDA $E4,X				;$01E8AA	|
	STA.w $00E4,y				;$01E8AC	|
	LDA.w $14E0,X				;$01E8AF	|
	STA.w $14E0,Y				;$01E8B2	|
	LDA $D8,X				;$01E8B5	|
	SEC					;$01E8B7	|
	SBC $00					;$01E8B8	|
	STA.w $00D8,y				;$01E8BA	|
	LDA.w $14D4,X				;$01E8BD	|
	SBC.b #$00				;$01E8C0	|
	STA.w $14D4,Y				;$01E8C2	|
	LDA.b #$10				;$01E8C5	|
	STA.w $154C,X				;$01E8C7	|
LakituCloudGfx:
	JSR GetDrawInfoBnk1
	LDA.w $186C,X				;$01E8CD	|
	BNE Return01E897			;$01E8D0	|
	LDA.b #$F8				;$01E8D2	|
	STA $0C					;$01E8D4	|
	LDA.b #$FC				;$01E8D6	|
	STA $0D					;$01E8D8	|
	LDA.b #$00				;$01E8DA	|
	LDY $C2,X				;$01E8DC	|
	BNE CODE_01E8E2				;$01E8DE	|
	LDA.b #$30				;$01E8E0	|
CODE_01E8E2:
	STA $0E
	STA.w $18B6				;$01E8E4	|
	ORA.b #$04				;$01E8E7	|
	STA $0F					;$01E8E9	|
	LDA $00					;$01E8EB	|
	STA.w $14B0				;$01E8ED	|
	LDA $01					;$01E8F0	|
	STA.w $14B2				;$01E8F2	|
	LDA $14					;$01E8F5	|
	LSR					;$01E8F7	|
	LSR					;$01E8F8	|
	AND.b #$0C				;$01E8F9	|
	STA $02					;$01E8FB	|
	LDA.b #$03				;$01E8FD	|
	STA $03					;$01E8FF	|
CODE_01E901:
	LDA $03
	TAX					;$01E903	|
	LDY $0C,X				;$01E904	|
	CLC					;$01E906	|
	ADC $02					;$01E907	|
	TAX					;$01E909	|
	LDA.w DATA_01E76F,X			;$01E90A	|
	CLC					;$01E90D	|
	ADC.w $14B0				;$01E90E	|
	STA.w $0300,Y				;$01E911	|
	LDA.w DATA_01E77F,X			;$01E914	|
	CLC					;$01E917	|
	ADC.w $14B2				;$01E918	|
	STA.w $0301,Y				;$01E91B	|
	LDX.w $15E9				;$01E91E	|
	LDA.b #$60				;$01E921	|
	STA.w $0302,Y				;$01E923	|
	LDA.w $1540,X				;$01E926	|
	BEQ CODE_01E935				;$01E929	|
	LSR					;$01E92B	|
	LSR					;$01E92C	|
	LSR					;$01E92D	|
	TAX					;$01E92E	|
	LDA.w CloudTiles,X			;$01E92F	|
	STA.w $0302,Y				;$01E932	|
CODE_01E935:
	LDA $64
	STA.w $0303,Y				;$01E937	|
	INY					;$01E93A	|
	INY					;$01E93B	|
	INY					;$01E93C	|
	INY					;$01E93D	|
	DEC $03					;$01E93E	|
	BPL CODE_01E901				;$01E940	|
	LDX.w $15E9				;$01E942	|
	LDA.b #$F8				;$01E945	|
	STA.w $15EA,X				;$01E947	|
	LDY.b #$02				;$01E94A	|
	LDA.b #$01				;$01E94C	|
	JSR FinishOAMWriteRt			;$01E94E	|
	LDA.w $18B6				;$01E951	|
	STA.w $15EA,X				;$01E954	|
	LDY.b #$02				;$01E957	|
	LDA.b #$01				;$01E959	|
	JSR FinishOAMWriteRt			;$01E95B	|
	LDA.w $15A0,X				;$01E95E	|
	BNE Return01E984			;$01E961	|
	LDA.w $14B0				;$01E963	|
	CLC					;$01E966	|
	ADC.b #$04				;$01E967	|
	STA.w $0208				;$01E969	|
	LDA.w $14B2				;$01E96C	|
	CLC					;$01E96F	|
	ADC.b #$07				;$01E970	|
	STA.w $0209				;$01E972	|
	LDA.b #$4D				;$01E975	|
	STA.w $020A				;$01E977	|
	LDA.b #$39				;$01E97A	|
	STA.w $020B				;$01E97C	|
	LDA.b #$00				;$01E97F	|
	STA.w $0422				;$01E981	|
Return01E984:
	RTS

CloudTiles:
	db $66,$64,$62,$60

DATA_01E989:
	db $20,$E0

DATA_01E98B:
	db $10,$F0

CODE_01E98D:
	LDA $9D
	BNE Return01E984			;$01E98F	|
	JSR SubHorizPos				;$01E991	|
	TYA					;$01E994	|
	LDY.w $160E,X				;$01E995	|
	STA.w $157C,Y				;$01E998	|
	STA $00					;$01E99B	|
	LDY $00					;$01E99D	|
	LDA.w $18BF				;$01E99F	|
	BEQ CODE_01E9BD				;$01E9A2	|
	PHY					;$01E9A4	|
	PHX					;$01E9A5	|
	LDA.w $160E,X				;$01E9A6	|
	TAX					;$01E9A9	|
	JSR SubOffscreen0Bnk1			;$01E9AA	|
	LDA.w $14C8,X				;$01E9AD	|
	PLX					;$01E9B0	|
	CMP.b #$00				;$01E9B1	|
	BNE CODE_01E9B8				;$01E9B3	|
	STZ.w $14C8,X				;$01E9B5	|
CODE_01E9B8:
	PLY
	TYA					;$01E9B9	|
	EOR.b #$01				;$01E9BA	|
	TAY					;$01E9BC	|
CODE_01E9BD:
	LDA $13
	AND.b #$01				;$01E9BF	|
	BNE CODE_01E9E6				;$01E9C1	|
	LDA $B6,X				;$01E9C3	|
	CMP.w DATA_01E989,Y			;$01E9C5	|
	BEQ CODE_01E9D0				;$01E9C8	|
	CLC					;$01E9CA	|
	ADC.w DATA_01EBB4,Y			;$01E9CB	|
	STA $B6,X				;$01E9CE	|
CODE_01E9D0:
	LDA.w $1534,X
	AND.b #$01				;$01E9D3	|
	TAY					;$01E9D5	|
	LDA $AA,X				;$01E9D6	|
	CLC					;$01E9D8	|
	ADC.w DATA_01EBB4,Y			;$01E9D9	|
	STA $AA,X				;$01E9DC	|
	CMP.w DATA_01E98B,Y			;$01E9DE	|
	BNE CODE_01E9E6				;$01E9E1	|
	INC.w $1534,X				;$01E9E3	|
CODE_01E9E6:
	LDA $B6,X
	PHA					;$01E9E8	|
	LDY.w $18BF				;$01E9E9	|
	BNE CODE_01E9F9				;$01E9EC	|
	LDA.w $17BD				;$01E9EE	|
	ASL					;$01E9F1	|
	ASL					;$01E9F2	|
	ASL					;$01E9F3	|
	CLC					;$01E9F4	|
	ADC $B6,X				;$01E9F5	|
	STA $B6,X				;$01E9F7	|
CODE_01E9F9:
	JSR SubSprXPosNoGrvty
	PLA					;$01E9FC	|
	STA $B6,X				;$01E9FD	|
	JSR SubSprYPosNoGrvty			;$01E9FF	|
	LDY.w $160E,X				;$01EA02	|
	LDA $13					;$01EA05	|
	AND.b #$7F				;$01EA07	|
	ORA.w $151C,Y				;$01EA09	|
	BNE Return01EA16			;$01EA0C	|
	LDA.b #$20				;$01EA0E	|
	STA.w $1558,Y				;$01EA10	|
	JSR CODE_01EA21				;$01EA13	|
Return01EA16:
	RTS

DATA_01EA17:
	db $10,$F0

CODE_01EA19:
	PHB
	PHK					;$01EA1A	|
	PLB					;$01EA1B	|
	JSR CODE_01EA21				;$01EA1C	|
	PLB					;$01EA1F	|
	RTL					;$01EA20	|

CODE_01EA21:
	JSL FindFreeSprSlot
	BMI Return01EA6F			;$01EA25	|
	LDA.b #$08				;$01EA27	|
	STA.w $14C8,Y				;$01EA29	|
	LDA.w $14AE				;$01EA2C	|
	CMP.b #$01				;$01EA2F	|
	LDA.b #$14				;$01EA31	|
	BCC CODE_01EA37				;$01EA33	|
	LDA.b #$21				;$01EA35	|
CODE_01EA37:
	STA.w $009E,y
	LDA $E4,X				;$01EA3A	|
	STA.w $00E4,y				;$01EA3C	|
	LDA.w $14E0,X				;$01EA3F	|
	STA.w $14E0,Y				;$01EA42	|
	LDA $D8,X				;$01EA45	|
	STA.w $00D8,y				;$01EA47	|
	LDA.w $14D4,X				;$01EA4A	|
	STA.w $14D4,Y				;$01EA4D	|
	PHX					;$01EA50	|
	TYX					;$01EA51	|
	JSL InitSpriteTables			;$01EA52	|
	LDA.b #$D8				;$01EA56	|
	STA $AA,X				;$01EA58	|
	JSR SubHorizPos				;$01EA5A	|
	LDA.w DATA_01EA17,Y			;$01EA5D	|
	STA $B6,X				;$01EA60	|
	LDA $9E,X				;$01EA62	|
	CMP.b #$21				;$01EA64	|
	BNE CODE_01EA6D				;$01EA66	|
	LDA.b #$02				;$01EA68	|
	STA.w $15F6,X				;$01EA6A	|
CODE_01EA6D:
	TXY
	PLX					;$01EA6E	|
Return01EA6F:
	RTS

CODE_01EA70:
	LDX.w $18E2
	BEQ Return01EA8E			;$01EA73	|
	STZ.w $188B				;$01EA75	|
	STZ.w $191C				;$01EA78	|
	LDA.w $15E9				;$01EA7B	|
	PHA					;$01EA7E	|
	DEX					;$01EA7F	|
	STX.w $15E9				;$01EA80	|
	PHB					;$01EA83	|
	PHK					;$01EA84	|
	PLB					;$01EA85	|
	JSR CODE_01EA8F				;$01EA86	|
	PLB					;$01EA89	|
	PLA					;$01EA8A	|
	STA.w $15E9				;$01EA8B	|
Return01EA8E:
	RTL

CODE_01EA8F:
	LDA.w $18E8
	ORA.w $13C6				;$01EA92	|
	BEQ CODE_01EA9A				;$01EA95	|
	JMP CODE_01EB48				;$01EA97	|

CODE_01EA9A:
	STZ.w $18DC
	LDA $C2,X				;$01EA9D	|
	CMP.b #$02				;$01EA9F	|
	BCC CODE_01EAA7				;$01EAA1	|
	LDA.b #$30				;$01EAA3	|
	BRA CODE_01EAB2				;$01EAA5	|

CODE_01EAA7:
	LDY.b #$00
	LDA $7B					;$01EAA9	|
	BEQ CODE_01EADF				;$01EAAB	|
	BPL CODE_01EAB2				;$01EAAD	|
	EOR.b #$FF				;$01EAAF	|
	INC A					;$01EAB1	|
CODE_01EAB2:
	LSR
	LSR					;$01EAB3	|
	LSR					;$01EAB4	|
	LSR					;$01EAB5	|
	TAY					;$01EAB6	|
	LDA $9D					;$01EAB7	|
	BNE CODE_01EAD0				;$01EAB9	|
	DEC.w $1570,X				;$01EABB	|
	BPL CODE_01EAD0				;$01EABE	|
	LDA.w DATA_01EDF5,Y			;$01EAC0	|
	STA.w $1570,X				;$01EAC3	|
	DEC.w $18AD				;$01EAC6	|
	BPL CODE_01EAD0				;$01EAC9	|
	LDA.b #$02				;$01EACB	|
	STA.w $18AD				;$01EACD	|
CODE_01EAD0:
	LDY.w $18AD
	LDA.w YoshiWalkFrames,Y			;$01EAD3	|
	TAY					;$01EAD6	|
	LDA $C2,X				;$01EAD7	|
	CMP.b #$02				;$01EAD9	|
	BCS CODE_01EB2E				;$01EADB	|
	BRA CODE_01EAE2				;$01EADD	|

CODE_01EADF:
	STZ.w $1570,X
CODE_01EAE2:
	LDA $72
	BEQ CODE_01EAF0				;$01EAE4	|
	LDY.b #$02				;$01EAE6	|
	LDA $7D					;$01EAE8	|
	BPL CODE_01EAF0				;$01EAEA	|
	LDY.b #$05				;$01EAEC	|
	BRA CODE_01EAF0				;$01EAEE	|

CODE_01EAF0:
	LDA.w $15AC,X
	BEQ CODE_01EAF7				;$01EAF3	|
	LDY.b #$03				;$01EAF5	|
CODE_01EAF7:
	LDA $72
	BNE CODE_01EB21				;$01EAF9	|
	LDA.w $151C,X				;$01EAFB	|
	BEQ CODE_01EB0C				;$01EAFE	|
	LDY.b #$07				;$01EB00	|
	LDA $15					;$01EB02	|
	AND.b #$08				;$01EB04	|
	BEQ CODE_01EB0A				;$01EB06	|
	LDY.b #$06				;$01EB08	|
CODE_01EB0A:
	BRA CODE_01EB21

CODE_01EB0C:
	LDA.w $18AF
	BEQ CODE_01EB16				;$01EB0F	|
	DEC.w $18AF				;$01EB11	|
	BRA CODE_01EB1C				;$01EB14	|

CODE_01EB16:
	LDA $15
	AND.b #$04				;$01EB18	|
	BEQ CODE_01EB21				;$01EB1A	|
CODE_01EB1C:
	LDY.b #$04
	INC.w $18DC				;$01EB1E	|
CODE_01EB21:
	LDA $C2,X
	CMP.b #$01				;$01EB23	|
	BEQ CODE_01EB2E				;$01EB25	|
	LDA.w $151C,X				;$01EB27	|
	BNE CODE_01EB2E				;$01EB2A	|
	LDY.b #$04				;$01EB2C	|
CODE_01EB2E:
	LDA.w $187A
	BEQ CODE_01EB44				;$01EB31	|
	LDA.w $1419				;$01EB33	|
	CMP.b #$01				;$01EB36	|
	BNE CODE_01EB44				;$01EB38	|
	LDA $13					;$01EB3A	|
	AND.b #$08				;$01EB3C	|
	LSR					;$01EB3E	|
	LSR					;$01EB3F	|
	LSR					;$01EB40	|
	ADC.b #$08				;$01EB41	|
	TAY					;$01EB43	|
CODE_01EB44:
	TYA
	STA.w $1602,X				;$01EB45	|
CODE_01EB48:
	LDA $C2,X
	CMP.b #$01				;$01EB4A	|
	BNE CODE_01EB97				;$01EB4C	|
	LDY.w $157C,X				;$01EB4E	|
	LDA $94					;$01EB51	|
	CLC					;$01EB53	|
	ADC.w YoshiPositionX,Y			;$01EB54	|
	STA $E4,X				;$01EB57	|
	LDA $95					;$01EB59	|
	ADC.w DATA_01EDF3,Y			;$01EB5B	|
	STA.w $14E0,X				;$01EB5E	|
	LDY.w $1602,X				;$01EB61	|
	LDA $96					;$01EB64	|
	CLC					;$01EB66	|
	ADC.b #$10				;$01EB67	|
	STA $D8,X				;$01EB69	|
	LDA $97					;$01EB6B	|
	ADC.b #$00				;$01EB6D	|
	STA.w $14D4,X				;$01EB6F	|
	LDA.w DATA_01EDE4,Y			;$01EB72	|
	STA.w $188B				;$01EB75	|
	LDA.b #$01				;$01EB78	|
	LDY.w $1602,X				;$01EB7A	|
	CPY.b #$03				;$01EB7D	|
	BNE BackOnYoshi				;$01EB7F	|
	INC A					;$01EB81	|
BackOnYoshi:
	STA.w $187A
	LDA.b #$01				;$01EB85	|
	STA.w $0DC1				;$01EB87	|
	LDA.w $15F6,X				;$01EB8A	|
	STA.w $13C7				;$01EB8D	|
	LDA.w $157C,X				;$01EB90	|
	EOR.b #$01				;$01EB93	|
	STA $76					;$01EB95	|
CODE_01EB97:
	LDA $64
	PHA					;$01EB99	|
	LDA.w $187A				;$01EB9A	|
	BEQ CODE_01EBAD				;$01EB9D	|
	LDA.w $1419				;$01EB9F	|
	BEQ CODE_01EBAD				;$01EBA2	|
	LDA.w $1405				;$01EBA4	|
	BNE CODE_01EBB0				;$01EBA7	|
	LDA.b #$10				;$01EBA9	|
	STA $64					;$01EBAB	|
CODE_01EBAD:
	JSR HandleOffYoshi
CODE_01EBB0:
	PLA
	STA $64					;$01EBB1	|
	RTS					;$01EBB3	|

DATA_01EBB4:
	db $01,$FF,$01,$00,$FF,$00,$20,$E0
	db $0A,$0E

DATA_01EBBE:
	db $E8,$18

DATA_01EBC0:
	db $10,$F0

GrowingAniSequence:
	db $0C,$0B,$0C,$0B,$0A,$0B,$0A,$0B

Yoshi:
	STZ.w $13FB
	LDA.w $141E				;$01EBCD	|
	STA.w $1410				;$01EBD0	|
	STZ.w $141E				;$01EBD3	|
	STZ.w $18E7				;$01EBD6	|
	STZ.w $191B				;$01EBD9	|
	LDA.w $14C8,X				;$01EBDC	|
	CMP.b #$08				;$01EBDF	|
	BEQ CODE_01EBE9				;$01EBE1	|
	STZ.w $0DC1				;$01EBE3	|
	JMP HandleOffYoshi			;$01EBE6	|

CODE_01EBE9:
	TXA
	INC A					;$01EBEA	|
	STA.w $18DF				;$01EBEB	|
	LDA.w $187A				;$01EBEE	|
	BNE CODE_01EC04				;$01EBF1	|
	JSR SubOffscreen0Bnk1			;$01EBF3	|
	LDA.w $14C8,X				;$01EBF6	|
	BNE CODE_01EC04				;$01EBF9	|
	LDA.w $1B95				;$01EBFB	|
	BNE Return01EC03			;$01EBFE	|
	STZ.w $0DC1				;$01EC00	|
Return01EC03:
	RTS

CODE_01EC04:
	LDA.w $187A
	BEQ CODE_01EC0E				;$01EC07	|
	LDA.w $1419				;$01EC09	|
	BNE CODE_01EC61				;$01EC0C	|
CODE_01EC0E:
	LDA.w $18DE
	BNE CODE_01EC61				;$01EC11	|
	LDA.w $18E8				;$01EC13	|
	BEQ CODE_01EC4C				;$01EC16	|
	DEC.w $18E8				;$01EC18	|
	STA $9D					;$01EC1B	|
	STA.w $13FB				;$01EC1D	|
	CMP.b #$01				;$01EC20	|
	BNE CODE_01EC40				;$01EC22	|
	STZ $9D					;$01EC24	|
	STZ.w $13FB				;$01EC26	|
	LDY.w $0DB3				;$01EC29	|
	LDA.w $1F11,Y				;$01EC2C	|
	DEC A					;$01EC2F	|
	ORA.w $0EF8				;$01EC30	|
	ORA.w $0109				;$01EC33	|
	BNE CODE_01EC40				;$01EC36	|
	INC.w $0EF8				;$01EC38	|
	LDA.b #$03				;$01EC3B	|
	STA.w $1426				;$01EC3D	|
CODE_01EC40:
	DEC A
	LSR					;$01EC41	|
	LSR					;$01EC42	|
	LSR					;$01EC43	|
	TAY					;$01EC44	|
	LDA.w GrowingAniSequence,Y		;$01EC45	|
	STA.w $1602,X				;$01EC48	|
	RTS					;$01EC4B	|

CODE_01EC4C:
	LDA $9D
	BEQ CODE_01EC61				;$01EC4E	|
CODE_01EC50:
	LDY.w $187A
	BEQ Return01EC5A			;$01EC53	|
	LDY.b #$06				;$01EC55	|
	STY.w $188B				;$01EC57	|
Return01EC5A:
	RTS

DATA_01EC5B:
	db $F0,$10

DATA_01EC5D:
	db $FA,$06

DATA_01EC5F:
	db $FF,$00

CODE_01EC61:
	LDA $72
	BNE CODE_01EC6A				;$01EC63	|
	LDA.w $18DE				;$01EC65	|
	BNE CODE_01EC6D				;$01EC68	|
CODE_01EC6A:
	JMP CODE_01ECE1

CODE_01EC6D:
	DEC.w $18DE
	CMP.b #$01				;$01EC70	|
	BNE CODE_01EC78				;$01EC72	|
	STZ $9D					;$01EC74	|
	BRA CODE_01EC6A				;$01EC76	|

CODE_01EC78:
	INC.w $13FB
	JSR CODE_01EC50				;$01EC7B	|
	STY $9D					;$01EC7E	|
	CMP.b #$02				;$01EC80	|
	BNE Return01EC8A			;$01EC82	|
	JSL FindFreeSprSlot			;$01EC84	|
	BPL CODE_01EC8B				;$01EC88	|
Return01EC8A:
	RTS

CODE_01EC8B:
	LDA.b #$09
	STA.w $14C8,Y				;$01EC8D	|
	LDA.b #$2C				;$01EC90	|
	STA.w $009E,y				;$01EC92	|
	PHY					;$01EC95	|
	PHY					;$01EC96	|
	LDY.w $157C,X				;$01EC97	|
	STY $0F					;$01EC9A	|
	LDA $E4,X				;$01EC9C	|
	CLC					;$01EC9E	|
	ADC.w DATA_01EC5D,Y			;$01EC9F	|
	PLY					;$01ECA2	|
	STA.w $00E4,y				;$01ECA3	|
	LDY.w $157C,X				;$01ECA6	|
	LDA.w $14E0,X				;$01ECA9	|
	ADC.w DATA_01EC5F,Y			;$01ECAC	|
	PLY					;$01ECAF	|
	STA.w $14E0,Y				;$01ECB0	|
	LDA $D8,X				;$01ECB3	|
	CLC					;$01ECB5	|
	ADC.b #$08				;$01ECB6	|
	STA.w $00D8,y				;$01ECB8	|
	LDA.w $14D4,X				;$01ECBB	|
	ADC.b #$00				;$01ECBE	|
	STA.w $14D4,Y				;$01ECC0	|
	PHX					;$01ECC3	|
	TYX					;$01ECC4	|
	JSL InitSpriteTables			;$01ECC5	|
	LDY $0F					;$01ECC9	|
	LDA.w DATA_01EC5B,Y			;$01ECCB	|
	STA $B6,X				;$01ECCE	|
	LDA.b #$F0				;$01ECD0	|
	STA $AA,X				;$01ECD2	|
	LDA.b #$10				;$01ECD4	|
	STA.w $154C,X				;$01ECD6	|
	LDA.w $18DA				;$01ECD9	|
	STA.w $151C,X				;$01ECDC	|
	PLX					;$01ECDF	|
	RTS					;$01ECE0	|

CODE_01ECE1:
	LDA $C2,X
	CMP.b #$01				;$01ECE3	|
	BNE CODE_01ECEA				;$01ECE5	|
	JMP CODE_01ED70				;$01ECE7	|

CODE_01ECEA:
	JSR SubUpdateSprPos
	JSR IsOnGround				;$01ECED	|
	BEQ CODE_01ED01				;$01ECF0	|
	JSR SetSomeYSpeed			;$01ECF2	|
	LDA $C2,X				;$01ECF5	|
	CMP.b #$02				;$01ECF7	|
	BCS CODE_01ED01				;$01ECF9	|
	STZ $B6,X				;$01ECFB	|
	LDA.b #$F0				;$01ECFD	|
	STA $AA,X				;$01ECFF	|
CODE_01ED01:
	JSR UpdateDirection
	JSR IsTouchingObjSide			;$01ED04	|
	BEQ CODE_01ED0C				;$01ED07	|
	JSR CODE_0190A2				;$01ED09	|
CODE_01ED0C:
	LDA.b #$04
	CLC					;$01ED0E	|
	ADC $E4,X				;$01ED0F	|
	STA $04					;$01ED11	|
	LDA.w $14E0,X				;$01ED13	|
	ADC.b #$00				;$01ED16	|
	STA $0A					;$01ED18	|
	LDA.b #$13				;$01ED1A	|
	CLC					;$01ED1C	|
	ADC $D8,X				;$01ED1D	|
	STA $05					;$01ED1F	|
	LDA.w $14D4,X				;$01ED21	|
	ADC.b #$00				;$01ED24	|
	STA $0B					;$01ED26	|
	LDA.b #$08				;$01ED28	|
	STA $07					;$01ED2A	|
	STA $06					;$01ED2C	|
	JSL GetMarioClipping			;$01ED2E	|
	JSL CheckForContact			;$01ED32	|
	BCC CODE_01ED70				;$01ED36	|
	LDA $72					;$01ED38	|
	BEQ CODE_01ED70				;$01ED3A	|
	LDA.w $1470				;$01ED3C	|
	ORA.w $187A				;$01ED3F	|
	BNE CODE_01ED70				;$01ED42	|
	LDA $7D					;$01ED44	|
	BMI CODE_01ED70				;$01ED46	|
SetOnYoshi:
	LDY.b #$01
	JSR CODE_01EDCE				;$01ED4A	|
	STZ $7B					;$01ED4D	|
	STZ $7D					;$01ED4F	|
	LDA.b #$0C				;$01ED51	|
	STA.w $18AF				;$01ED53	|
	LDA.b #$01				;$01ED56	|
	STA $C2,X				;$01ED58	|
	LDA.b #$02				;$01ED5A	|
	STA.w $1DFA				;$01ED5C	|
	LDA.b #$1F				;$01ED5F	|
	STA.w $1DFC				;$01ED61	|
	JSL DisabledAddSmokeRt			;$01ED64	|
	LDA.b #$20				;$01ED68	|
	STA.w $163E,X				;$01ED6A	|
	INC.w $1697				;$01ED6D	|
CODE_01ED70:
	LDA $C2,X
	CMP.b #$01				;$01ED72	|
	BNE Return01EDCB			;$01ED74	|
	JSR CODE_01F622				;$01ED76	|
	LDA $15					;$01ED79	|
	AND.b #$03				;$01ED7B	|
	BEQ CODE_01ED95				;$01ED7D	|
	DEC A					;$01ED7F	|
	CMP.w $157C,X				;$01ED80	|
	BEQ CODE_01ED95				;$01ED83	|
	LDA.w $15AC,X				;$01ED85	|
	ORA.w $151C,X				;$01ED88	|
	ORA.w $18DC				;$01ED8B	|
	BNE CODE_01ED95				;$01ED8E	|
	LDA.b #$10				;$01ED90	|
	STA.w $15AC,X				;$01ED92	|
CODE_01ED95:
	LDA.w $13F3
	BNE CODE_01ED9E				;$01ED98	|
	BIT $18					;$01ED9A	|
	BPL Return01EDCB			;$01ED9C	|
CODE_01ED9E:
	LDA.b #$02
	STA.w $1FE2,X				;$01EDA0	|
	STZ $C2,X				;$01EDA3	|
	LDA.b #$03				;$01EDA5	|
	STA.w $1DFA				;$01EDA7	|
	STZ.w $0DC1				;$01EDAA	|
	LDA $7B					;$01EDAD	|
	STA $B6,X				;$01EDAF	|
	LDA.b #$A0				;$01EDB1	|
	LDY $72					;$01EDB3	|
	BNE CODE_01EDC1				;$01EDB5	|
	JSR SubHorizPos				;$01EDB7	|
	LDA.w DATA_01EBC0,Y			;$01EDBA	|
	STA $7B					;$01EDBD	|
	LDA.b #$C0				;$01EDBF	|
CODE_01EDC1:
	STA $7D
	STZ.w $187A				;$01EDC3	|
	STZ $AA,X				;$01EDC6	|
	JSR CODE_01EDCC				;$01EDC8	|
Return01EDCB:
	RTS

CODE_01EDCC:
	LDY.b #$00
CODE_01EDCE:
	LDA $D8,X
	SEC					;$01EDD0	|
	SBC.w DATA_01EDE2,Y			;$01EDD1	|
	STA $96					;$01EDD4	|
	STA $D3					;$01EDD6	|
	LDA.w $14D4,X				;$01EDD8	|
	SBC.b #$00				;$01EDDB	|
	STA $97					;$01EDDD	|
	STA $D4					;$01EDDF	|
	RTS					;$01EDE1	|

DATA_01EDE2:
	db $04,$10

DATA_01EDE4:
	db $06,$05,$05,$05,$0A,$05,$05,$0A
	db $0A,$0B

YoshiWalkFrames:
	db $02,$01,$00

YoshiPositionX:
	db $02,$FE

DATA_01EDF3:
	db $00,$FF

DATA_01EDF5:
	db $03,$02,$01,$00

YoshiHeadTiles:
	db $00,$01,$02,$03,$02,$10,$04,$05
	db $00,$00,$FF,$FF,$00

YoshiBodyTiles:
	db $06,$07,$08,$09,$0A,$0B,$06,$0C
	db $0A,$0D,$0E,$0F,$0C

YoshiHeadDispX:
	db $0A,$09,$0A,$06,$0A,$0A,$0A,$10
	db $0A,$0A,$00,$00,$0A,$F6,$F7,$F6
	db $FA,$F6,$F6,$F6,$F0,$F6,$F6,$00
	db $00,$F6

DATA_01EE2D:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
	db $00,$FF

YoshiPositionY:
	db $00,$01,$01,$00,$04,$00,$00,$04
	db $03,$03,$00,$00,$04

YoshiHeadDispY:
	db $00,$00,$01,$00,$00,$00,$00,$08
	db $00,$00,$00,$00,$05

HandleOffYoshi:
	LDA.w $1602,X
	PHA					;$01EE64	|
	LDY.w $15AC,X				;$01EE65	|
	CPY.b #$08				;$01EE68	|
	BNE CODE_01EE7D				;$01EE6A	|
	LDA.w $1419				;$01EE6C	|
	ORA $9D					;$01EE6F	|
	BNE CODE_01EE7D				;$01EE71	|
	LDA.w $157C,X				;$01EE73	|
	STA $76					;$01EE76	|
	EOR.b #$01				;$01EE78	|
	STA.w $157C,X				;$01EE7A	|
CODE_01EE7D:
	LDA.w $1419
	BMI CODE_01EE8A				;$01EE80	|
	CMP.b #$02				;$01EE82	|
	BNE CODE_01EE8A				;$01EE84	|
	INC A					;$01EE86	|
	STA.w $1602,X				;$01EE87	|
CODE_01EE8A:
	JSR CODE_01EF18
	LDY $0E					;$01EE8D	|
	LDA.w $0302,Y				;$01EE8F	|
	STA $00					;$01EE92	|
	STZ $01					;$01EE94	|
	LDA.b #$06				;$01EE96	|
	STA.w $0302,Y				;$01EE98	|
	LDY.w $15EA,X				;$01EE9B	|
	LDA.w $0302,Y				;$01EE9E	|
	STA $02					;$01EEA1	|
	STZ $03					;$01EEA3	|
	LDA.b #$08				;$01EEA5	|
	STA.w $0302,Y				;$01EEA7	|
	REP #$20				;$01EEAA	|
	LDA $00					;$01EEAC	|
	ASL					;$01EEAE	|
	ASL					;$01EEAF	|
	ASL					;$01EEB0	|
	ASL					;$01EEB1	|
	ASL					;$01EEB2	|
	CLC					;$01EEB3	|
	ADC.w #$8500				;$01EEB4	|
	STA.w $0D8B				;$01EEB7	|
	CLC					;$01EEBA	|
	ADC.w #$0200				;$01EEBB	|
	STA.w $0D95				;$01EEBE	|
	LDA $02					;$01EEC1	|
	ASL					;$01EEC3	|
	ASL					;$01EEC4	|
	ASL					;$01EEC5	|
	ASL					;$01EEC6	|
	ASL					;$01EEC7	|
	CLC					;$01EEC8	|
	ADC.w #$8500				;$01EEC9	|
	STA.w $0D8D				;$01EECC	|
	CLC					;$01EECF	|
	ADC.w #$0200				;$01EED0	|
	STA.w $0D97				;$01EED3	|
	SEP #$20				;$01EED6	|
	PLA					;$01EED8	|
	STA.w $1602,X				;$01EED9	|
	JSR CODE_01F0A2				;$01EEDC	|
	LDA.w $1410				;$01EEDF	|
	CMP.b #$02				;$01EEE2	|
	BCC Return01EF17			;$01EEE4	|
	LDA.w $187A				;$01EEE6	|
	BEQ CODE_01EF13				;$01EEE9	|
	LDA $72					;$01EEEB	|
	BNE CODE_01EF00				;$01EEED	|
	LDA $7B					;$01EEEF	|
	BPL CODE_01EEF6				;$01EEF1	|
	EOR.b #$FF				;$01EEF3	|
	INC A					;$01EEF5	|
CODE_01EEF6:
	CMP.b #$28
	LDA.b #$01				;$01EEF8	|
	BCS CODE_01EF13				;$01EEFA	|
	LDA.b #$00				;$01EEFC	|
	BRA CODE_01EF13				;$01EEFE	|

CODE_01EF00:
	LDA $14
	LSR					;$01EF02	|
	LSR					;$01EF03	|
	LDY $7D					;$01EF04	|
	BMI CODE_01EF0A				;$01EF06	|
	LSR					;$01EF08	|
	LSR					;$01EF09	|
CODE_01EF0A:
	AND.b #$01
	BNE CODE_01EF13				;$01EF0C	|
	LDY.b #$21				;$01EF0E	|
	STY.w $1DFC				;$01EF10	|
CODE_01EF13:
	JSL CODE_02BB23
Return01EF17:
	RTS

CODE_01EF18:
	LDY.w $1602,X
	STY.w $185E				;$01EF1B	|
	LDA.w YoshiHeadTiles,Y			;$01EF1E	|
	STA.w $1602,X				;$01EF21	|
	STA $0F					;$01EF24	|
	LDA $D8,X				;$01EF26	|
	PHA					;$01EF28	|
	CLC					;$01EF29	|
	ADC.w YoshiPositionY,Y			;$01EF2A	|
	STA $D8,X				;$01EF2D	|
	LDA.w $14D4,X				;$01EF2F	|
	PHA					;$01EF32	|
	ADC.b #$00				;$01EF33	|
	STA.w $14D4,X				;$01EF35	|
	TYA					;$01EF38	|
	LDY.w $157C,X				;$01EF39	|
	BEQ CODE_01EF41				;$01EF3C	|
	CLC					;$01EF3E	|
	ADC.b #$0D				;$01EF3F	|
CODE_01EF41:
	TAY
	LDA $E4,X				;$01EF42	|
	PHA					;$01EF44	|
	CLC					;$01EF45	|
	ADC.w YoshiHeadDispX,Y			;$01EF46	|
	STA $E4,X				;$01EF49	|
	LDA.w $14E0,X				;$01EF4B	|
	PHA					;$01EF4E	|
	ADC.w DATA_01EE2D,Y			;$01EF4F	|
	STA.w $14E0,X				;$01EF52	|
	LDA.w $15EA,X				;$01EF55	|
	PHA					;$01EF58	|
	LDA.w $15AC,X				;$01EF59	|
	ORA.w $1419				;$01EF5C	|
	BEQ CODE_01EF66				;$01EF5F	|
	LDA.b #$04				;$01EF61	|
	STA.w $15EA,X				;$01EF63	|
CODE_01EF66:
	LDA.w $15EA,X
	STA $0E					;$01EF69	|
	JSR SubSprGfx2Entry1			;$01EF6B	|
	PHX					;$01EF6E	|
	LDY.w $15EA,X				;$01EF6F	|
	LDX.w $185E				;$01EF72	|
	LDA.w $0301,Y				;$01EF75	|
	CLC					;$01EF78	|
	ADC.w YoshiHeadDispY,X			;$01EF79	|
	STA.w $0301,Y				;$01EF7C	|
	PLX					;$01EF7F	|
	PLA					;$01EF80	|
	CLC					;$01EF81	|
	ADC.b #$04				;$01EF82	|
	STA.w $15EA,X				;$01EF84	|
	PLA					;$01EF87	|
	STA.w $14E0,X				;$01EF88	|
	PLA					;$01EF8B	|
	STA $E4,X				;$01EF8C	|
	LDY.w $185E				;$01EF8E	|
	LDA.w YoshiBodyTiles,Y			;$01EF91	|
	STA.w $1602,X				;$01EF94	|
	LDA $D8,X				;$01EF97	|
	CLC					;$01EF99	|
	ADC.b #$10				;$01EF9A	|
	STA $D8,X				;$01EF9C	|
	BCC CODE_01EFA3				;$01EF9E	|
	INC.w $14D4,X				;$01EFA0	|
CODE_01EFA3:
	JSR SubSprGfx2Entry1
	PLA					;$01EFA6	|
	STA.w $14D4,X				;$01EFA7	|
	PLA					;$01EFAA	|
	STA $D8,X				;$01EFAB	|
	LDY $0E					;$01EFAD	|
	LDA $0F					;$01EFAF	|
	BPL CODE_01EFB8				;$01EFB1	|
	LDA.b #$F0				;$01EFB3	|
	STA.w $0301,Y				;$01EFB5	|
CODE_01EFB8:
	LDA $C2,X
	BNE CODE_01EFC6				;$01EFBA	|
	LDA $14					;$01EFBC	|
	AND.b #$30				;$01EFBE	|
	BNE CODE_01EFDB				;$01EFC0	|
	LDA.b #$2A				;$01EFC2	|
	BRA CODE_01EFFA				;$01EFC4	|

CODE_01EFC6:
	CMP.b #$02
	BNE CODE_01EFDB				;$01EFC8	|
	LDA.w $151C,X				;$01EFCA	|
	ORA.w $13C6				;$01EFCD	|
	BNE CODE_01EFDB				;$01EFD0	|
	LDA $14					;$01EFD2	|
	AND.b #$10				;$01EFD4	|
	BEQ CODE_01EFFD				;$01EFD6	|
	BRA CODE_01EFF8				;$01EFD8	|

Return01EFDA:
	RTS

CODE_01EFDB:
	LDA.w $1594,X
	CMP.b #$03				;$01EFDE	|
	BEQ CODE_01EFEE				;$01EFE0	|
	LDA.w $151C,X				;$01EFE2	|
	BEQ CODE_01EFF3				;$01EFE5	|
	LDA.w $0302,Y				;$01EFE7	|
	CMP.b #$24				;$01EFEA	|
	BEQ CODE_01EFF3				;$01EFEC	|
CODE_01EFEE:
	LDA.b #$2A
	STA.w $0302,Y				;$01EFF0	|
CODE_01EFF3:
	LDA.w $18AE
	BEQ CODE_01EFFD				;$01EFF6	|
CODE_01EFF8:
	LDA.b #$0C
CODE_01EFFA:
	STA.w $0302,Y
CODE_01EFFD:
	LDA.w $1564,X
	LDY.w $18AC				;$01F000	|
	BEQ CODE_01F00F				;$01F003	|
	CPY.b #$26				;$01F005	|
	BCS CODE_01F038				;$01F007	|
	LDA $14					;$01F009	|
	AND.b #$18				;$01F00B	|
	BNE CODE_01F038				;$01F00D	|
CODE_01F00F:
	LDA.w $1564,X
	CMP.b #$00				;$01F012	|
	BEQ Return01EFDA			;$01F014	|
	LDY.b #$00				;$01F016	|
	CMP.b #$0F				;$01F018	|
	BCC CODE_01F03A				;$01F01A	|
	CMP.b #$1C				;$01F01C	|
	BCC CODE_01F038				;$01F01E	|
	BNE CODE_01F02F				;$01F020	|
	LDA $0E					;$01F022	|
	PHA					;$01F024	|
	JSL SetTreeTile				;$01F025	|
	JSR CODE_01F0D3				;$01F029	|
	PLA					;$01F02C	|
	STA $0E					;$01F02D	|
CODE_01F02F:
	INC.w $13FB
	LDA.b #$00				;$01F032	|
	LDY.b #$2A				;$01F034	|
	BRA CODE_01F03A				;$01F036	|

CODE_01F038:
	LDY.b #$04
CODE_01F03A:
	PHA
	TYA					;$01F03B	|
	LDY $0E					;$01F03C	|
	STA.w $0302,Y				;$01F03E	|
	PLA					;$01F041	|
	CMP.b #$0F				;$01F042	|
	BCS Return01F0A0			;$01F044	|
	CMP.b #$05				;$01F046	|
	BCC Return01F0A0			;$01F048	|
	SBC.b #$05				;$01F04A	|
	LDY.w $157C,X				;$01F04C	|
	BEQ CODE_01F054				;$01F04F	|
	CLC					;$01F051	|
	ADC.b #$0A				;$01F052	|
CODE_01F054:
	LDY.w $1602,X
	CPY.b #$0A				;$01F057	|
	BNE CODE_01F05E				;$01F059	|
	CLC					;$01F05B	|
	ADC.b #$14				;$01F05C	|
CODE_01F05E:
	STA $02
	JSR IsSprOffScreen			;$01F060	|
	BNE Return01F0A0			;$01F063	|
	LDA $E4,X				;$01F065	|
	SEC					;$01F067	|
	SBC $1A					;$01F068	|
	STA $00					;$01F06A	|
	LDA $D8,X				;$01F06C	|
	SEC					;$01F06E	|
	SBC $1C					;$01F06F	|
	STA $01					;$01F071	|
	PHX					;$01F073	|
	LDX $02					;$01F074	|
	LDA $00					;$01F076	|
	CLC					;$01F078	|
	ADC.l DATA_03C176,X			;$01F079	|
	STA.w $0300				;$01F07D	|
	LDA $01					;$01F080	|
	CLC					;$01F082	|
	ADC.l DATA_03C19E,X			;$01F083	|
	STA.w $0301				;$01F087	|
	LDA.b #$3F				;$01F08A	|
	STA.w $0302				;$01F08C	|
	PLX					;$01F08F	|
	LDY.w $15EA,X				;$01F090	|
	LDA.w $0303,Y				;$01F093	|
	ORA.b #$01				;$01F096	|
	STA.w $0303				;$01F098	|
	LDA.b #$00				;$01F09B	|
	STA.w $0460				;$01F09D	|
Return01F0A0:
	RTS

Return01F0A1:
	RTS

CODE_01F0A2:
	LDA $C2,X
	CMP.b #$01				;$01F0A4	|
	BNE CODE_01F0AC				;$01F0A6	|
	JSL CODE_02D0D4				;$01F0A8	|
CODE_01F0AC:
	LDA.w $1410
	CMP.b #$01				;$01F0AF	|
	BEQ Return01F0A1			;$01F0B1	|
	LDA.w $14A3				;$01F0B3	|
	CMP.b #$10				;$01F0B6	|
	BNE CODE_01F0C4				;$01F0B8	|
	LDA.w $18AE				;$01F0BA	|
	BNE CODE_01F0C4				;$01F0BD	|
	LDA.b #$06				;$01F0BF	|
	STA.w $18AE				;$01F0C1	|
CODE_01F0C4:
	LDA.w $1594,X
	JSL ExecutePtr				;$01F0C7	|

Ptrs01F0CB:
	dw CODE_01F14B
	dw CODE_01F314
	dw CODE_01F332
	dw CODE_01F12E

CODE_01F0D3:
	LDA.b #$06
	STA.w $1DF9				;$01F0D5	|
	JSL CODE_05B34A				;$01F0D8	|
	LDA.w $18D6				;$01F0DC	|
	BEQ Return01F12D			;$01F0DF	|
	STZ.w $18D6				;$01F0E1	|
	CMP.b #$01				;$01F0E4	|
	BNE CODE_01F0F9				;$01F0E6	|
	INC.w $18D4				;$01F0E8	|
	LDA.w $18D4				;$01F0EB	|
	CMP.b #$0A				;$01F0EE	|
	BNE Return01F12D			;$01F0F0	|
	STZ.w $18D4				;$01F0F2	|
	LDA.b #$74				;$01F0F5	|
	BRA CODE_01F125				;$01F0F7	|

CODE_01F0F9:
	CMP.b #$03
	BNE CODE_01F116				;$01F0FB	|
	LDA.b #$29				;$01F0FD	|
	STA.w $1DFC				;$01F0FF	|
	LDA.w $0F32				;$01F102	|
	CLC					;$01F105	|
	ADC.b #$02				;$01F106	|
	CMP.b #$0A				;$01F108	|
	BCC CODE_01F111				;$01F10A	|
	SBC.b #$0A				;$01F10C	|
	INC.w $0F31				;$01F10E	|
CODE_01F111:
	STA.w $0F32
	BRA Return01F12D			;$01F114	|

CODE_01F116:
	INC.w $18D5
	LDA.w $18D5				;$01F119	|
	CMP.b #$02				;$01F11C	|
	BNE Return01F12D			;$01F11E	|
	STZ.w $18D5				;$01F120	|
	LDA.b #$6A				;$01F123	|
CODE_01F125:
	STA.w $18DA
	LDY.b #$20				;$01F128	|
	STY.w $18DE				;$01F12A	|
Return01F12D:
	RTS

CODE_01F12E:
	LDA.w $1558,X
	BNE Return01F136			;$01F131	|
	STZ.w $1594,X				;$01F133	|
Return01F136:
	RTS

YoshiShellAbility:
	db $00,$00,$01,$02,$00,$00,$01,$02
	db $01,$01,$01,$03,$02,$02

YoshiAbilityIndex:
	db $03,$02,$02,$03,$01,$00

CODE_01F14B:
	LDA.w $1B95
	BEQ CODE_01F155				;$01F14E	|
	LDA.b #$02				;$01F150	|
	STA.w $141E				;$01F152	|
CODE_01F155:
	LDA.w $18AC
	BEQ CODE_01F1A2				;$01F158	|
	LDY.w $160E,X				;$01F15A	|
	LDA.w $009E,y				;$01F15D	|
	CMP.b #$80				;$01F160	|
	BNE CODE_01F167				;$01F162	|
	INC.w $191C				;$01F164	|
CODE_01F167:
	CMP.b #$0D
	BCS CODE_01F1A2				;$01F169	|
	PHY					;$01F16B	|
	LDA.w $187B,Y				;$01F16C	|
	CMP.b #$01				;$01F16F	|
	LDA.b #$03				;$01F171	|
	BCS CODE_01F195				;$01F173	|
	LDA.w $15F6,X				;$01F175	|
	LSR					;$01F178	|
	AND.b #$07				;$01F179	|
	TAY					;$01F17B	|
	LDA.w YoshiAbilityIndex,Y		;$01F17C	|
	ASL					;$01F17F	|
	ASL					;$01F180	|
	STA $00					;$01F181	|
	PLY					;$01F183	|
	PHY					;$01F184	|
	LDA.w $15F6,Y				;$01F185	|
	LSR					;$01F188	|
	AND.b #$07				;$01F189	|
	TAY					;$01F18B	|
	LDA.w YoshiAbilityIndex,Y		;$01F18C	|
	ORA $00					;$01F18F	|
	TAY					;$01F191	|
	LDA.w YoshiShellAbility,Y		;$01F192	|
CODE_01F195:
	PHA
	AND.b #$02				;$01F196	|
	STA.w $141E				;$01F198	|
	PLA					;$01F19B	|
	AND.b #$01				;$01F19C	|
	STA.w $18E7				;$01F19E	|
	PLY					;$01F1A1	|
CODE_01F1A2:
	LDA $14
	AND.b #$03				;$01F1A4	|
	BNE CODE_01F1C6				;$01F1A6	|
	LDA.w $18AC				;$01F1A8	|
	BEQ CODE_01F1C6				;$01F1AB	|
	DEC.w $18AC				;$01F1AD	|
	BNE CODE_01F1C6				;$01F1B0	|
	LDY.w $160E,X				;$01F1B2	|
	LDA.b #$00				;$01F1B5	|
	STA.w $14C8,Y				;$01F1B7	|
	DEC A					;$01F1BA	|
	STA.w $160E,X				;$01F1BB	|
	LDA.b #$1B				;$01F1BE	|
	STA.w $1564,X				;$01F1C0	|
	JMP CODE_01F0D3				;$01F1C3	|

CODE_01F1C6:
	LDA.w $18AE
	BEQ CODE_01F1DF				;$01F1C9	|
	DEC.w $18AE				;$01F1CB	|
	BNE Return01F1DE			;$01F1CE	|
	INC.w $1594,X				;$01F1D0	|
	STZ.w $151C,X				;$01F1D3	|
	LDA.b #$FF				;$01F1D6	|
	STA.w $160E,X				;$01F1D8	|
	STZ.w $1564,X				;$01F1DB	|
Return01F1DE:
	RTS

CODE_01F1DF:
	LDA $C2,X
	CMP.b #$01				;$01F1E1	|
	BNE Return01F1DE			;$01F1E3	|
	BIT $16					;$01F1E5	|
	BVC Return01F1DE			;$01F1E7	|
	LDA.w $18AC				;$01F1E9	|
	BNE CODE_01F1F1				;$01F1EC	|
	JMP CODE_01F309				;$01F1EE	|

CODE_01F1F1:
	STZ.w $18AC
	LDY.w $160E,X				;$01F1F4	|
	PHY					;$01F1F7	|
	PHY					;$01F1F8	|
	LDY.w $157C,X				;$01F1F9	|
	LDA $E4,X				;$01F1FC	|
	CLC					;$01F1FE	|
	ADC.w DATA_01F305,Y			;$01F1FF	|
	PLY					;$01F202	|
	STA.w $00E4,y				;$01F203	|
	LDY.w $157C,X				;$01F206	|
	LDA.w $14E0,X				;$01F209	|
	ADC.w DATA_01F307,Y			;$01F20C	|
	PLY					;$01F20F	|
	STA.w $14E0,Y				;$01F210	|
	LDA $D8,X				;$01F213	|
	STA.w $00D8,y				;$01F215	|
	LDA.w $14D4,X				;$01F218	|
	STA.w $14D4,Y				;$01F21B	|
	LDA.b #$00				;$01F21E	|
	STA.w $00C2,y				;$01F220	|
	STA.w $15D0,Y				;$01F223	|
	STA.w $1626,Y				;$01F226	|
	LDA.w $18DC				;$01F229	|
	CMP.b #$01				;$01F22C	|
	LDA.b #$0A				;$01F22E	|
	BCC CODE_01F234				;$01F230	|
	LDA.b #$09				;$01F232	|
CODE_01F234:
	STA.w $14C8,Y
	PHX					;$01F237	|
	LDA.w $157C,X				;$01F238	|
	STA.w $157C,Y				;$01F23B	|
	TAX					;$01F23E	|
	BCC CODE_01F243				;$01F23F	|
	INX					;$01F241	|
	INX					;$01F242	|
CODE_01F243:
	LDA.w DATA_01F301,X
	STA.w $00B6,y				;$01F246	|
	LDA.b #$00				;$01F249	|
	STA.w $00AA,y				;$01F24B	|
	PLX					;$01F24E	|
	LDA.b #$10				;$01F24F	|
	STA.w $1558,X				;$01F251	|
	LDA.b #$03				;$01F254	|
	STA.w $1594,X				;$01F256	|
	LDA.b #$FF				;$01F259	|
	STA.w $160E,X				;$01F25B	|
	LDA.w $009E,y				;$01F25E	|
	CMP.b #$0D				;$01F261	|
	BCS CODE_01F2DF				;$01F263	|
	LDA.w $187B,Y				;$01F265	|
	BNE CODE_01F27C				;$01F268	|
	LDA.w $15F6,Y				;$01F26A	|
	AND.b #$0E				;$01F26D	|
	CMP.b #$08				;$01F26F	|
	BEQ CODE_01F27C				;$01F271	|
	LDA.w $15F6,X				;$01F273	|
	AND.b #$0E				;$01F276	|
	CMP.b #$08				;$01F278	|
	BNE CODE_01F2DF				;$01F27A	|
CODE_01F27C:
	PHX
	TYX					;$01F27D	|
	STZ.w $14C8,X				;$01F27E	|
	LDA.b #$02				;$01F281	|
	STA $00					;$01F283	|
	JSR CODE_01F295				;$01F285	|
	JSR CODE_01F295				;$01F288	|
	JSR CODE_01F295				;$01F28B	|
	PLX					;$01F28E	|
	LDA.b #$17				;$01F28F	|
	STA.w $1DFC				;$01F291	|
	RTS					;$01F294	|

CODE_01F295:
	JSR CODE_018EEF
	LDA.b #$11				;$01F298	|
	STA.w $170B,Y				;$01F29A	|
	LDA $E4,X				;$01F29D	|
	STA.w $171F,Y				;$01F29F	|
	LDA.w $14E0,X				;$01F2A2	|
	STA.w $1733,Y				;$01F2A5	|
	LDA $D8,X				;$01F2A8	|
	STA.w $1715,Y				;$01F2AA	|
	LDA.w $14D4,X				;$01F2AD	|
	STA.w $1729,Y				;$01F2B0	|
	LDA.b #$00				;$01F2B3	|
	STA.w $1779,Y				;$01F2B5	|
	PHX					;$01F2B8	|
	LDA.w $157C,X				;$01F2B9	|
	LSR					;$01F2BC	|
	LDX $00					;$01F2BD	|
	LDA.w DATA_01F2D9,X			;$01F2BF	|
	BCC CODE_01F2C7				;$01F2C2	|
	EOR.b #$FF				;$01F2C4	|
	INC A					;$01F2C6	|
CODE_01F2C7:
	STA.w $1747,Y
	LDA.w DATA_01F2DC,X			;$01F2CA	|
	STA.w $173D,Y				;$01F2CD	|
	LDA.b #$A0				;$01F2D0	|
	STA.w $176F,Y				;$01F2D2	|
	PLX					;$01F2D5	|
	DEC $00					;$01F2D6	|
	RTS					;$01F2D8	|

DATA_01F2D9:
	db $28,$24,$24

DATA_01F2DC:
	db $00,$F8,$08

CODE_01F2DF:
	LDA.b #$20
	STA.w $1DF9				;$01F2E1	|
	LDA.w $1686,Y				;$01F2E4	|
	AND.b #$40				;$01F2E7	|
	BEQ Return01F2FE			;$01F2E9	|
	PHX					;$01F2EB	|
	LDX.w $9E,Y				;$01F2EC	|
	LDA.l SpriteToSpawn,X			;$01F2EF	|
	PLX					;$01F2F3	|
	STA.w $009E,y				;$01F2F4	|
	PHX					;$01F2F7	|
	TYX					;$01F2F8	|
	JSL LoadSpriteTables			;$01F2F9	|
	PLX					;$01F2FD	|
Return01F2FE:
	RTS

DATA_01F2FF:
	db $20,$E0

DATA_01F301:
	db $30,$D0,$10,$F0

DATA_01F305:
	db $10,$F0

DATA_01F307:
	db $00,$FF

CODE_01F309:
	LDA.b #$12
	STA.w $14A3				;$01F30B	|
	LDA.b #$21				;$01F30E	|
	STA.w $1DFC				;$01F310	|
	RTS					;$01F313	|

CODE_01F314:
	LDA.w $151C,X
	CLC					;$01F317	|
	ADC.b #$03				;$01F318	|
	STA.w $151C,X				;$01F31A	|
	CMP.b #$20				;$01F31D	|
	BCS CODE_01F328				;$01F31F	|
CODE_01F321:
	JSR CODE_01F3FE
	JSR CODE_01F4B2				;$01F324	|
	RTS					;$01F327	|

CODE_01F328:
	LDA.b #$08
	STA.w $1558,X				;$01F32A	|
	INC.w $1594,X				;$01F32D	|
	BRA CODE_01F321				;$01F330	|

CODE_01F332:
	LDA.w $1558,X
	BNE CODE_01F321				;$01F335	|
	LDA.w $151C,X				;$01F337	|
	SEC					;$01F33A	|
	SBC.b #$04				;$01F33B	|
	BMI CODE_01F344				;$01F33D	|
	STA.w $151C,X				;$01F33F	|
	BRA CODE_01F321				;$01F342	|

CODE_01F344:
	STZ.w $151C,X
	STZ.w $1594,X				;$01F347	|
	LDY.w $160E,X				;$01F34A	|
	BMI CODE_01F370				;$01F34D	|
	LDA.w $1686,Y				;$01F34F	|
	AND.b #$02				;$01F352	|
	BEQ CODE_01F373				;$01F354	|
	LDA.b #$07				;$01F356	|
	STA.w $14C8,Y				;$01F358	|
	LDA.b #$FF				;$01F35B	|
	STA.w $18AC				;$01F35D	|
	LDA.w $009E,y				;$01F360	|
	CMP.b #$0D				;$01F363	|
	BCS CODE_01F370				;$01F365	|
	PHX					;$01F367	|
	TAX					;$01F368	|
	LDA.w SpriteToSpawn,X			;$01F369	|
	STA.w $009E,y				;$01F36C	|
	PLX					;$01F36F	|
CODE_01F370:
	JMP CODE_01F3FA

CODE_01F373:
	LDA.b #$00
	STA.w $14C8,Y				;$01F375	|
	LDA.b #$1B				;$01F378	|
	STA.w $1564,X				;$01F37A	|
	LDA.b #$FF				;$01F37D	|
	STA.w $160E,X				;$01F37F	|
	STY $00					;$01F382	|
	LDA.w $009E,y				;$01F384	|
	CMP.b #$9D				;$01F387	|
	BNE CODE_01F39F				;$01F389	|
	LDA.w $00C2,y				;$01F38B	|
	CMP.b #$03				;$01F38E	|
	BNE CODE_01F39F				;$01F390	|
	LDA.b #$74				;$01F392	|
	STA.w $009E,y				;$01F394	|
	LDA.w $167A,Y				;$01F397	|
	ORA.b #$40				;$01F39A	|
	STA.w $167A,Y				;$01F39C	|
CODE_01F39F:
	LDA.w $009E,y
	CMP.b #$81				;$01F3A2	|
	BNE CODE_01F3BA				;$01F3A4	|
	LDA.w $187B,Y				;$01F3A6	|
	LSR					;$01F3A9	|
	LSR					;$01F3AA	|
	LSR					;$01F3AB	|
	LSR					;$01F3AC	|
	LSR					;$01F3AD	|
	LSR					;$01F3AE	|
	AND.b #$03				;$01F3AF	|
	TAY					;$01F3B1	|
	LDA.w ChangingItemSprite,Y		;$01F3B2	|
	LDY $00					;$01F3B5	|
	STA.w $009E,y				;$01F3B7	|
CODE_01F3BA:
	PHA
	LDY $00					;$01F3BB	|
	LDA.w $167A,Y				;$01F3BD	|
	ASL					;$01F3C0	|
	ASL					;$01F3C1	|
	PLA					;$01F3C2	|
	BCC CODE_01F3DB				;$01F3C3	|
	PHX					;$01F3C5	|
	TYX					;$01F3C6	|
	STZ $C2,X				;$01F3C7	|
	JSR CODE_01C4BF				;$01F3C9	|
	PLX					;$01F3CC	|
	LDY.w $18DC				;$01F3CD	|
	LDA.w DATA_01F3D9,Y			;$01F3D0	|
	STA.w $1602,X				;$01F3D3	|
	JMP CODE_01F321				;$01F3D6	|

DATA_01F3D9:
	db $00,$04

CODE_01F3DB:
	CMP.b #$7E
	BNE CODE_01F3F7				;$01F3DD	|
	LDA.w $00C2,y				;$01F3DF	|
	BEQ CODE_01F3F7				;$01F3E2	|
	CMP.b #$02				;$01F3E4	|
	BNE ADDR_01F3F1				;$01F3E6	|
	LDA.b #$08				;$01F3E8	|
	STA $71					;$01F3EA	|
	LDA.b #$03				;$01F3EC	|
	STA.w $1DFC				;$01F3EE	|
ADDR_01F3F1:
	JSR CODE_01F6CD
	JMP CODE_01F321				;$01F3F4	|

CODE_01F3F7:
	JSR CODE_01F0D3
CODE_01F3FA:
	JMP CODE_01F321

Return01F3FD:
	RTS

CODE_01F3FE:
	LDA.w $15A0,X
	ORA.w $186C,X				;$01F401	|
	ORA.w $1419				;$01F404	|
	BNE Return01F3FD			;$01F407	|
	LDY.w $1602,X				;$01F409	|
	LDA.w DATA_01F61A,Y			;$01F40C	|
	STA.w $185E				;$01F40F	|
	CLC					;$01F412	|
	ADC $D8,X				;$01F413	|
	SEC					;$01F415	|
	SBC $1C					;$01F416	|
	STA $01					;$01F418	|
	LDA.w $157C,X				;$01F41A	|
	BNE CODE_01F424				;$01F41D	|
	TYA					;$01F41F	|
	CLC					;$01F420	|
	ADC.b #$08				;$01F421	|
	TAY					;$01F423	|
CODE_01F424:
	LDA.w DATA_01F60A,Y
	STA $0D					;$01F427	|
	LDA $E4,X				;$01F429	|
	SEC					;$01F42B	|
	SBC $1A					;$01F42C	|
	CLC					;$01F42E	|
	ADC $0D					;$01F42F	|
	STA $00					;$01F431	|
	LDA.w $157C,X				;$01F433	|
	BNE CODE_01F43C				;$01F436	|
	BCS Return01F3FD			;$01F438	|
	BRA CODE_01F43E				;$01F43A	|

CODE_01F43C:
	BCC Return01F3FD
CODE_01F43E:
	LDA.w $151C,X
	STA.w $4205				;$01F441	|
	STZ.w $4204				;$01F444	|
	LDA.b #$04				;$01F447	|
	STA.w $4206				;$01F449	|
	NOP					;$01F44C	|
	NOP					;$01F44D	|
	NOP					;$01F44E	|
	NOP					;$01F44F	|
	NOP					;$01F450	|
	NOP					;$01F451	|
	NOP					;$01F452	|
	NOP					;$01F453	|
	LDA.w $157C,X				;$01F454	|
	STA $07					;$01F457	|
	LSR					;$01F459	|
	LDA.w $4215				;$01F45A	|
	BCC CODE_01F462				;$01F45D	|
	EOR.b #$FF				;$01F45F	|
	INC A					;$01F461	|
CODE_01F462:
	STA $05
	LDA.b #$04				;$01F464	|
	STA $06					;$01F466	|
	LDY.b #$0C				;$01F468	|
CODE_01F46A:
	LDA $00
	STA.w $0200,Y				;$01F46C	|
	CLC					;$01F46F	|
	ADC $05					;$01F470	|
	STA $00					;$01F472	|
	LDA $05					;$01F474	|
	BPL CODE_01F47C				;$01F476	|
	BCC Return01F4B1			;$01F478	|
	BRA CODE_01F47E				;$01F47A	|

CODE_01F47C:
	BCS Return01F4B1
CODE_01F47E:
	LDA $01
	STA.w $0201,Y				;$01F480	|
	LDA $06					;$01F483	|
	CMP.b #$01				;$01F485	|
	LDA.b #$76				;$01F487	|
	BCS CODE_01F48D				;$01F489	|
	LDA.b #$66				;$01F48B	|
CODE_01F48D:
	STA.w $0202,Y
	LDA $07					;$01F490	|
	LSR					;$01F492	|
	LDA.b #$09				;$01F493	|
	BCS CODE_01F499				;$01F495	|
	ORA.b #$40				;$01F497	|
CODE_01F499:
	ORA $64
	STA.w $0203,Y				;$01F49B	|
	PHY					;$01F49E	|
	TYA					;$01F49F	|
	LSR					;$01F4A0	|
	LSR					;$01F4A1	|
	TAY					;$01F4A2	|
	LDA.b #$00				;$01F4A3	|
	STA.w $0420,Y				;$01F4A5	|
	PLY					;$01F4A8	|
	INY					;$01F4A9	|
	INY					;$01F4AA	|
	INY					;$01F4AB	|
	INY					;$01F4AC	|
	DEC $06					;$01F4AD	|
	BPL CODE_01F46A				;$01F4AF	|
Return01F4B1:
	RTS

CODE_01F4B2:
	LDA.w $160E,X
	BMI CODE_01F524				;$01F4B5	|
	LDY.b #$00				;$01F4B7	|
	LDA $0D					;$01F4B9	|
	BMI CODE_01F4C3				;$01F4BB	|
	CLC					;$01F4BD	|
	ADC.w $151C,X				;$01F4BE	|
	BRA CODE_01F4CC				;$01F4C1	|

CODE_01F4C3:
	LDA.w $151C,X
	EOR.b #$FF				;$01F4C6	|
	INC A					;$01F4C8	|
	CLC					;$01F4C9	|
	ADC $0D					;$01F4CA	|
CODE_01F4CC:
	SEC
	SBC.b #$04				;$01F4CD	|
	BPL CODE_01F4D2				;$01F4CF	|
	DEY					;$01F4D1	|
CODE_01F4D2:
	PHY
	CLC					;$01F4D3	|
	ADC $E4,X				;$01F4D4	|
	LDY.w $160E,X				;$01F4D6	|
	STA.w $00E4,y				;$01F4D9	|
	PLY					;$01F4DC	|
	TYA					;$01F4DD	|
	ADC.w $14E0,X				;$01F4DE	|
	LDY.w $160E,X				;$01F4E1	|
	STA.w $14E0,Y				;$01F4E4	|
	LDA.b #$FC				;$01F4E7	|
	STA $00					;$01F4E9	|
	LDA.w $1662,Y				;$01F4EB	|
	AND.b #$40				;$01F4EE	|
	BNE CODE_01F4FD				;$01F4F0	|
	LDA.w $190F,Y				;$01F4F2	|
	AND.b #$20				;$01F4F5	|
	BEQ CODE_01F4FD				;$01F4F7	|
	LDA.b #$F8				;$01F4F9	|
	STA $00					;$01F4FB	|
CODE_01F4FD:
	STZ $01
	LDA $00					;$01F4FF	|
	CLC					;$01F501	|
	ADC.w $185E				;$01F502	|
	BPL CODE_01F509				;$01F505	|
	DEC $01					;$01F507	|
CODE_01F509:
	CLC
	ADC $D8,X				;$01F50A	|
	STA.w $00D8,y				;$01F50C	|
	LDA.w $14D4,X				;$01F50F	|
	ADC $01					;$01F512	|
	STA.w $14D4,Y				;$01F514	|
	LDA.b #$00				;$01F517	|
	STA.w $00AA,y				;$01F519	|
	STA.w $00B6,y				;$01F51C	|
	INC A					;$01F51F	|
	STA.w $15D0,Y				;$01F520	|
	RTS					;$01F523	|

CODE_01F524:
	PHY
	LDY.b #$00				;$01F525	|
	LDA $0D					;$01F527	|
	BMI CODE_01F531				;$01F529	|
	CLC					;$01F52B	|
	ADC.w $151C,X				;$01F52C	|
	BRA CODE_01F53A				;$01F52F	|

CODE_01F531:
	LDA.w $151C,X
	EOR.b #$FF				;$01F534	|
	INC A					;$01F536	|
	CLC					;$01F537	|
	ADC $0D					;$01F538	|
CODE_01F53A:
	CLC
	ADC.b #$00				;$01F53B	|
	BPL CODE_01F540				;$01F53D	|
	DEY					;$01F53F	|
CODE_01F540:
	CLC
	ADC $E4,X				;$01F541	|
	STA $00					;$01F543	|
	TYA					;$01F545	|
	ADC.w $14E0,X				;$01F546	|
	STA $08					;$01F549	|
	PLY					;$01F54B	|
	LDA.w $185E				;$01F54C	|
	CLC					;$01F54F	|
	ADC.b #$02				;$01F550	|
	CLC					;$01F552	|
	ADC $D8,X				;$01F553	|
	STA $01					;$01F555	|
	LDA.w $14D4,X				;$01F557	|
	ADC.b #$00				;$01F55A	|
	STA $09					;$01F55C	|
	LDA.b #$08				;$01F55E	|
	STA $02					;$01F560	|
	LDA.b #$04				;$01F562	|
	STA $03					;$01F564	|
	LDY.b #$0B				;$01F566	|
CODE_01F568:
	STY.w $1695
	CPY.w $15E9				;$01F56B	|
	BEQ CODE_01F586				;$01F56E	|
	LDA.w $160E,X				;$01F570	|
	BPL CODE_01F586				;$01F573	|
	LDA.w $14C8,Y				;$01F575	|
	CMP.b #$08				;$01F578	|
	BCC CODE_01F586				;$01F57A	|
	LDA.w $1632,Y				;$01F57C	|
	BNE CODE_01F586				;$01F57F	|
	PHY					;$01F581	|
	JSR TryEatSprite			;$01F582	|
	PLY					;$01F585	|
CODE_01F586:
	DEY
	BPL CODE_01F568				;$01F587	|
	JSL CODE_02B9FA				;$01F589	|
	RTS					;$01F58D	|

TryEatSprite:
	PHX
	TYX					;$01F58F	|
	JSL GetSpriteClippingA			;$01F590	|
	PLX					;$01F594	|
	JSL CheckForContact			;$01F595	|
	BCC Return01F609			;$01F599	|
	LDA.w $1686,Y				;$01F59B	|
	LSR					;$01F59E	|
	BCC EatSprite				;$01F59F	|
	LDA.b #$01				;$01F5A1	|
	STA.w $1DF9				;$01F5A3	|
	RTS					;$01F5A6	|

EatSprite:
	LDA.w $009E,y
	CMP.b #$70				;$01F5AA	|
	BNE CODE_01F5FB				;$01F5AC	|
SpltPokeyInto2Sprs:
	STY.w $185E
	LDA $01					;$01F5B1	|
	SEC					;$01F5B3	|
	SBC.w $00D8,y				;$01F5B4	|
	CLC					;$01F5B7	|
	ADC.b #$00				;$01F5B8	|
	PHX					;$01F5BA	|
	TYX					;$01F5BB	|
	JSL RemovePokeySegment			;$01F5BC	|
	PLX					;$01F5C0	|
	JSL FindFreeSprSlot			;$01F5C1	|
	BMI Return01F609			;$01F5C5	|
	LDA.b #$08				;$01F5C7	|
	STA.w $14C8,Y				;$01F5C9	|
	LDA.b #$70				;$01F5CC	|
	STA.w $009E,y				;$01F5CE	|
	LDA $00					;$01F5D1	|
	STA.w $00E4,y				;$01F5D3	|
	LDA $08					;$01F5D6	|
	STA.w $14E0,Y				;$01F5D8	|
	LDA $01					;$01F5DB	|
	STA.w $00D8,y				;$01F5DD	|
	LDA $09					;$01F5E0	|
	STA.w $14D4,Y				;$01F5E2	|
	PHX					;$01F5E5	|
	TYX					;$01F5E6	|
	JSL InitSpriteTables			;$01F5E7	|
	LDX.w $185E				;$01F5EB	|
	LDA $C2,X				;$01F5EE	|
	AND $0D					;$01F5F0	|
	STA.w $00C2,y				;$01F5F2	|
	LDA.b #$01				;$01F5F5	|
	STA.w $1534,Y				;$01F5F7	|
	PLX					;$01F5FA	|
CODE_01F5FB:
	TYA
	STA.w $160E,X				;$01F5FC	|
	LDA.b #$02				;$01F5FF	|
	STA.w $1594,X				;$01F601	|
	LDA.b #$0A				;$01F604	|
	STA.w $1558,X				;$01F606	|
Return01F609:
	RTS

DATA_01F60A:
	db $F5,$F5,$F5,$F5,$F5,$F5,$F5,$F0
	db $13,$13,$13,$13,$13,$13,$13,$18
DATA_01F61A:
	db $08,$08,$08,$08,$08,$08,$08,$13

CODE_01F622:
	LDA.w $163E,X
	ORA $9D					;$01F625	|
	BNE Return01F667			;$01F627	|
	LDY.b #$0B				;$01F629	|
CODE_01F62B:
	STY.w $1695
	TYA					;$01F62E	|
	EOR $13					;$01F62F	|
	AND.b #$01				;$01F631	|
	BNE CODE_01F661				;$01F633	|
	TYA					;$01F635	|
	CMP.w $160E,X				;$01F636	|
	BEQ CODE_01F661				;$01F639	|
	CPY.w $15E9				;$01F63B	|
	BEQ CODE_01F661				;$01F63E	|
	LDA.w $14C8,Y				;$01F640	|
	CMP.b #$08				;$01F643	|
	BCC CODE_01F661				;$01F645	|
	LDA.w $009E,y				;$01F647	|
	LDA.w $14C8,Y				;$01F64A	|
	CMP.b #$09				;$01F64D	|
	BEQ CODE_01F661				;$01F64F	|
	LDA.w $167A,Y				;$01F651	|
	AND.b #$02				;$01F654	|
	ORA.w $15D0,Y				;$01F656	|
	ORA.w $1632,Y				;$01F659	|
	BNE CODE_01F661				;$01F65C	|
	JSR CODE_01F668				;$01F65E	|
CODE_01F661:
	LDY.w $1695
	DEY					;$01F664	|
	BPL CODE_01F62B				;$01F665	|
Return01F667:
	RTS

CODE_01F668:
	PHX
	TYX					;$01F669	|
	JSL GetSpriteClippingB			;$01F66A	|
	PLX					;$01F66E	|
	JSL GetSpriteClippingA			;$01F66F	|
	JSL CheckForContact			;$01F673	|
	BCC Return01F667			;$01F677	|
	LDA.w $009E,y				;$01F679	|
	CMP.b #$9D				;$01F67C	|
	BEQ Return01F667			;$01F67E	|
	CMP.b #$15				;$01F680	|
	BEQ CODE_01F69E				;$01F682	|
	CMP.b #$16				;$01F684	|
	BEQ CODE_01F69E				;$01F686	|
	CMP.b #$04				;$01F688	|
	BCS CODE_01F6A3				;$01F68A	|
	CMP.b #$02				;$01F68C	|
	BEQ CODE_01F6A3				;$01F68E	|
	LDA.w $163E,Y				;$01F690	|
	BPL CODE_01F6A3				;$01F693	|
CODE_01F695:
	PHY
	PHX					;$01F696	|
	TYX					;$01F697	|
	JSR CODE_01B12A				;$01F698	|
	PLX					;$01F69B	|
	PLY					;$01F69C	|
	RTS					;$01F69D	|

CODE_01F69E:
	LDA.w $164A,Y
	BEQ CODE_01F695				;$01F6A1	|
CODE_01F6A3:
	LDA.w $009E,y
	CMP.b #$BF				;$01F6A6	|
	BNE CODE_01F6B4				;$01F6A8	|
	LDA $96					;$01F6AA	|
	SEC					;$01F6AC	|
	SBC.w $00D8,y				;$01F6AD	|
	CMP.b #$E8				;$01F6B0	|
	BMI Return01F6DC			;$01F6B2	|
CODE_01F6B4:
	LDA.w $009E,y
	CMP.b #$7E				;$01F6B7	|
	BNE CODE_01F6DD				;$01F6B9	|
	LDA.w $00C2,y				;$01F6BB	|
	BEQ Return01F6DC			;$01F6BE	|
	CMP.b #$02				;$01F6C0	|
	BNE CODE_01F6CD				;$01F6C2	|
	LDA.b #$08				;$01F6C4	|
	STA $71					;$01F6C6	|
	LDA.b #$03				;$01F6C8	|
	STA.w $1DFC				;$01F6CA	|
CODE_01F6CD:
	LDA.b #$40
	STA.w $14AA				;$01F6CF	|
	LDA.b #$02				;$01F6D2	|
	STA.w $141E				;$01F6D4	|
	LDA.b #$00				;$01F6D7	|
	STA.w $14C8,Y				;$01F6D9	|
Return01F6DC:
	RTS

CODE_01F6DD:
	CMP.b #$4E
	BEQ CODE_01F6E5				;$01F6DF	|
	CMP.b #$4D				;$01F6E1	|
	BNE CODE_01F6EC				;$01F6E3	|
CODE_01F6E5:
	LDA.w $00C2,y
	CMP.b #$02				;$01F6E8	|
	BCC Return01F6DC			;$01F6EA	|
CODE_01F6EC:
	LDA $05
	CLC					;$01F6EE	|
	ADC.b #$0D				;$01F6EF	|
	CMP $01					;$01F6F1	|
	BMI Return01F74B			;$01F6F3	|
	LDA.w $14C8,Y				;$01F6F5	|
	CMP.b #$0A				;$01F6F8	|
	BNE CODE_01F70E				;$01F6FA	|
	PHX					;$01F6FC	|
	TYX					;$01F6FD	|
	JSR SubHorizPos				;$01F6FE	|
	STY $00					;$01F701	|
	LDA $B6,X				;$01F703	|
	PLX					;$01F705	|
	ASL					;$01F706	|
	ROL					;$01F707	|
	AND.b #$01				;$01F708	|
	CMP $00					;$01F70A	|
	BNE Return01F74B			;$01F70C	|
CODE_01F70E:
	LDA.w $1490
	BNE Return01F74B			;$01F711	|
	LDA.b #$10				;$01F713	|
	STA.w $163E,X				;$01F715	|
	LDA.b #$03				;$01F718	|
	STA.w $1DFA				;$01F71A	|
	LDA.b #$13				;$01F71D	|
	STA.w $1DFC				;$01F71F	|
	LDA.b #$02				;$01F722	|
	STA $C2,X				;$01F724	|
	STZ.w $187A				;$01F726	|
	LDA.b #$C0				;$01F729	|
	STA $7D					;$01F72B	|
	STZ $7B					;$01F72D	|
	JSR SubHorizPos				;$01F72F	|
	LDA.w DATA_01EBBE,Y			;$01F732	|
	STA $B6,X				;$01F735	|
	STZ.w $1594,X				;$01F737	|
	STZ.w $151C,X				;$01F73A	|
	STZ.w $18AE				;$01F73D	|
	STZ.w $0DC1				;$01F740	|
	LDA.b #$30				;$01F743	|
	STA.w $1497				;$01F745	|
	JSR CODE_01EDCC				;$01F748	|
Return01F74B:
	RTS

CODE_01F74C:
	LDA.b #$08
	STA.w $14C8,X				;$01F74E	|
CODE_01F751:
	LDA.b #$20
	STA.w $1540,X				;$01F753	|
	LDA.b #$0A				;$01F756	|
	STA.w $1DFC				;$01F758	|
	RTL					;$01F75B	|

DATA_01F75C:
	db $00,$01,$01,$01

YoshiEggTiles:
	db $62,$02,$02,$00

YoshiEgg:
	LDA.w $187B,X
	BEQ CODE_01F799				;$01F767	|
	JSR IsSprOffScreen			;$01F769	|
	BNE CODE_01F78D				;$01F76C	|
	JSR SubHorizPos				;$01F76E	|
	LDA $0F					;$01F771	|
	CLC					;$01F773	|
	ADC.b #$20				;$01F774	|
	CMP.b #$40				;$01F776	|
	BCS CODE_01F78D				;$01F778	|
	STZ.w $187B,X				;$01F77A	|
	JSL CODE_01F751				;$01F77D	|
	LDA.b #$2D				;$01F781	|
	LDY.w $18E2				;$01F783	|
	BEQ CODE_01F78A				;$01F786	|
	LDA.b #$78				;$01F788	|
CODE_01F78A:
	STA.w $151C,X
CODE_01F78D:
	JSR SubSprGfx2Entry1
	LDY.w $15EA,X				;$01F790	|
	LDA.b #$00				;$01F793	|
	STA.w $0302,Y				;$01F795	|
	RTS					;$01F798	|

CODE_01F799:
	LDA.w $1540,X
	BEQ CODE_01F7C2				;$01F79C	|
	LSR					;$01F79E	|
	LSR					;$01F79F	|
	LSR					;$01F7A0	|
	TAY					;$01F7A1	|
	LDA.w YoshiEggTiles,Y			;$01F7A2	|
	PHA					;$01F7A5	|
	LDA.w DATA_01F75C,Y			;$01F7A6	|
	PHA					;$01F7A9	|
	JSR SubSprGfx2Entry1			;$01F7AA	|
	LDY.w $15EA,X				;$01F7AD	|
	PLA					;$01F7B0	|
	STA $00					;$01F7B1	|
	LDA.w $0303,Y				;$01F7B3	|
	AND.b #$FE				;$01F7B6	|
	ORA $00					;$01F7B8	|
	STA.w $0303,Y				;$01F7BA	|
	PLA					;$01F7BD	|
	STA.w $0302,Y				;$01F7BE	|
	RTS					;$01F7C1	|

CODE_01F7C2:
	JSR CODE_01F7C8
	JMP CODE_01F83D				;$01F7C5	|

CODE_01F7C8:
	JSR IsSprOffScreen
	BNE Return01F82C			;$01F7CB	|
	LDA $E4,X				;$01F7CD	|
	STA $00					;$01F7CF	|
	LDA $D8,X				;$01F7D1	|
	STA $02					;$01F7D3	|
	LDA.w $14D4,X				;$01F7D5	|
	STA $03					;$01F7D8	|
	PHX					;$01F7DA	|
	LDY.b #$03				;$01F7DB	|
	LDX.b #$0B				;$01F7DD	|
CODE_01F7DF:
	LDA.w $17F0,X
	BEQ CODE_01F7F4				;$01F7E2	|
CODE_01F7E4:
	DEX
	BPL CODE_01F7DF				;$01F7E5	|
	DEC.w $185D				;$01F7E7	|
	BPL CODE_01F7F1				;$01F7EA	|
	LDA.b #$0B				;$01F7EC	|
	STA.w $185D				;$01F7EE	|
CODE_01F7F1:
	LDX.w $185D
CODE_01F7F4:
	LDA.b #$03
	STA.w $17F0,X				;$01F7F6	|
	LDA $00					;$01F7F9	|
	CLC					;$01F7FB	|
	ADC.w DATA_01F831,Y			;$01F7FC	|
	STA.w $1808,X				;$01F7FF	|
	LDA $02					;$01F802	|
	CLC					;$01F804	|
	ADC.w DATA_01F82D,Y			;$01F805	|
	STA.w $17FC,X				;$01F808	|
	LDA $03					;$01F80B	|
	STA.w $1814,X				;$01F80D	|
	LDA.w DATA_01F835,Y			;$01F810	|
	STA.w $1820,X				;$01F813	|
	LDA.w DATA_01F839,Y			;$01F816	|
	STA.w $182C,X				;$01F819	|
	TYA					;$01F81C	|
	ASL					;$01F81D	|
	ASL					;$01F81E	|
	ASL					;$01F81F	|
	ASL					;$01F820	|
	ASL					;$01F821	|
	ASL					;$01F822	|
	ORA.b #$28				;$01F823	|
	STA.w $1850,X				;$01F825	|
	DEY					;$01F828	|
	BPL CODE_01F7E4				;$01F829	|
	PLX					;$01F82B	|
Return01F82C:
	RTS

DATA_01F82D:
	db $00,$00,$08,$08

DATA_01F831:
	db $00,$08,$00,$08

DATA_01F835:
	db $E8,$E8,$F4,$F4

DATA_01F839:
	db $FA,$06,$FD,$03

CODE_01F83D:
	LDA.w $151C,X
	STA $9E,X				;$01F840	|
	CMP.b #$35				;$01F842	|
	BEQ CODE_01F86C				;$01F844	|
	CMP.b #$2D				;$01F846	|
	BNE CODE_01F867				;$01F848	|
	LDA.b #$09				;$01F84A	|
	STA.w $14C8,X				;$01F84C	|
	LDA.w $15F6,X				;$01F84F	|
	AND.b #$0E				;$01F852	|
	PHA					;$01F854	|
	JSL InitSpriteTables			;$01F855	|
	PLA					;$01F859	|
	STA $00					;$01F85A	|
	LDA.w $15F6,X				;$01F85C	|
	AND.b #$F1				;$01F85F	|
	ORA $00					;$01F861	|
	STA.w $15F6,X				;$01F863	|
	RTS					;$01F866	|

CODE_01F867:
	JSL InitSpriteTables
	RTS					;$01F86B	|

CODE_01F86C:
	JSL InitSpriteTables
	JMP CODE_01A2B5				;$01F870	|

DATA_01F873:
	db $08,$F8

UnusedInit:
	JSR FaceMario
	STA.w $1534,X				;$01F878	|
Return01F87B:
	RTS

InitEerie:
	JSR SubHorizPos
	LDA.w EerieSpeedX,Y			;$01F87F	|
	STA $B6,X				;$01F882	|
InitBigBoo:
	JSL GetRand
	STA.w $1570,X				;$01F888	|
	RTS					;$01F88B	|

EerieSpeedX:
	db $10,$F0

EerieSpeedY:
	db $18,$E8

Eerie:
	LDA.w $14C8,X
	CMP.b #$08				;$01F893	|
	BNE CODE_01F8C9				;$01F895	|
	LDA $9D					;$01F897	|
	BNE CODE_01F8C9				;$01F899	|
	JSR SubSprXPosNoGrvty			;$01F89B	|
	LDA $9E,X				;$01F89E	|
	CMP.b #$39				;$01F8A0	|
	BNE CODE_01F8C0				;$01F8A2	|
	LDA $C2,X				;$01F8A4	|
	AND.b #$01				;$01F8A6	|
	TAY					;$01F8A8	|
	LDA $AA,X				;$01F8A9	|
	CLC					;$01F8AB	|
	ADC.w DATA_01EBB4,Y			;$01F8AC	|
	STA $AA,X				;$01F8AF	|
	CMP.w EerieSpeedY,Y			;$01F8B1	|
	BNE CODE_01F8B8				;$01F8B4	|
	INC $C2,X				;$01F8B6	|
CODE_01F8B8:
	JSR SubSprYPosNoGrvty
	JSR SubOffscreen3Bnk1			;$01F8BB	|
	BRA CODE_01F8C3				;$01F8BE	|

CODE_01F8C0:
	JSR SubOffscreen0Bnk1
CODE_01F8C3:
	JSR MarioSprInteractRt
	JSR SetAnimationFrame			;$01F8C6	|
CODE_01F8C9:
	JSR UpdateDirection
	JMP SubSprGfx2Entry1			;$01F8CC	|

DATA_01F8CF:
	db $08,$F8

DATA_01F8D1:
	db $01,$02,$02,$01

BigBoo:
	JSR SubOffscreen1Bnk1
	LDA.b #$20				;$01F8D8	|
	BRA CODE_01F8E1				;$01F8DA	|

BooPBooBlock:
	JSR SubOffscreen0Bnk1
	LDA.b #$10				;$01F8DF	|
CODE_01F8E1:
	STA.w $18B6
	LDA.w $14C8,X				;$01F8E4	|
	CMP.b #$08				;$01F8E7	|
	BNE CODE_01F8EF				;$01F8E9	|
	LDA $9D					;$01F8EB	|
	BEQ CODE_01F8F2				;$01F8ED	|
CODE_01F8EF:
	JMP CODE_01F9CE

CODE_01F8F2:
	JSR SubHorizPos
	LDA.w $1540,X				;$01F8F5	|
	BNE CODE_01F914				;$01F8F8	|
	LDA.b #$20				;$01F8FA	|
	STA.w $1540,X				;$01F8FC	|
	LDA $C2,X				;$01F8FF	|
	BEQ CODE_01F90C				;$01F901	|
	LDA $0F					;$01F903	|
	CLC					;$01F905	|
	ADC.b #$0A				;$01F906	|
	CMP.b #$14				;$01F908	|
	BCC CODE_01F92F				;$01F90A	|
CODE_01F90C:
	STZ $C2,X
	CPY $76					;$01F90E	|
	BNE CODE_01F914				;$01F910	|
	INC $C2,X				;$01F912	|
CODE_01F914:
	LDA $0F
	CLC					;$01F916	|
	ADC.b #$0A				;$01F917	|
	CMP.b #$14				;$01F919	|
	BCC CODE_01F92F				;$01F91B	|
	LDA.w $15AC,X				;$01F91D	|
	BNE CODE_01F971				;$01F920	|
	TYA					;$01F922	|
	CMP.w $157C,X				;$01F923	|
	BEQ CODE_01F92F				;$01F926	|
	LDA.b #$1F				;$01F928	|
	STA.w $15AC,X				;$01F92A	|
	BRA CODE_01F971				;$01F92D	|

CODE_01F92F:
	STZ.w $1602,X
	LDA $C2,X				;$01F932	|
	BEQ CODE_01F989				;$01F934	|
	LDA.b #$03				;$01F936	|
	STA.w $1602,X				;$01F938	|
	LDY $9E,X				;$01F93B	|
	CPY.b #$28				;$01F93D	|
	BEQ CODE_01F948				;$01F93F	|
	LDA.b #$00				;$01F941	|
	CPY.b #$AF				;$01F943	|
	BEQ CODE_01F948				;$01F945	|
	INC A					;$01F947	|
CODE_01F948:
	AND $13
	BNE CODE_01F96F				;$01F94A	|
	INC.w $1570,X				;$01F94C	|
	LDA.w $1570,X				;$01F94F	|
	BNE CODE_01F959				;$01F952	|
	LDA.b #$20				;$01F954	|
	STA.w $1558,X				;$01F956	|
CODE_01F959:
	LDA $B6,X
	BEQ CODE_01F962				;$01F95B	|
	BPL CODE_01F961				;$01F95D	|
	INC A					;$01F95F	|
	INC A					;$01F960	|
CODE_01F961:
	DEC A
CODE_01F962:
	STA $B6,X
	LDA $AA,X				;$01F964	|
	BEQ CODE_01F96D				;$01F966	|
	BPL CODE_01F96C				;$01F968	|
	INC A					;$01F96A	|
	INC A					;$01F96B	|
CODE_01F96C:
	DEC A
CODE_01F96D:
	STA $AA,X
CODE_01F96F:
	BRA CODE_01F9C8

CODE_01F971:
	CMP.b #$10
	BNE CODE_01F97F				;$01F973	|
	PHA					;$01F975	|
	LDA.w $157C,X				;$01F976	|
	EOR.b #$01				;$01F979	|
	STA.w $157C,X				;$01F97B	|
	PLA					;$01F97E	|
CODE_01F97F:
	LSR
	LSR					;$01F980	|
	LSR					;$01F981	|
	TAY					;$01F982	|
	LDA.w DATA_01F8D1,Y			;$01F983	|
	STA.w $1602,X				;$01F986	|
CODE_01F989:
	STZ.w $1570,X
	LDA $13					;$01F98C	|
	AND.b #$07				;$01F98E	|
	BNE CODE_01F9C8				;$01F990	|
	JSR SubHorizPos				;$01F992	|
	LDA $B6,X				;$01F995	|
	CMP.w DATA_01F8CF,Y			;$01F997	|
	BEQ CODE_01F9A2				;$01F99A	|
	CLC					;$01F99C	|
	ADC.w DATA_01EBB4,Y			;$01F99D	|
	STA $B6,X				;$01F9A0	|
CODE_01F9A2:
	LDA $D3
	PHA					;$01F9A4	|
	SEC					;$01F9A5	|
	SBC.w $18B6				;$01F9A6	|
	STA $D3					;$01F9A9	|
	LDA $D4					;$01F9AB	|
	PHA					;$01F9AD	|
	SBC.b #$00				;$01F9AE	|
	STA $D4					;$01F9B0	|
	JSR CODE_01AD42				;$01F9B2	|
	PLA					;$01F9B5	|
	STA $D4					;$01F9B6	|
	PLA					;$01F9B8	|
	STA $D3					;$01F9B9	|
	LDA $AA,X				;$01F9BB	|
	CMP.w DATA_01F8CF,Y			;$01F9BD	|
	BEQ CODE_01F9C8				;$01F9C0	|
	CLC					;$01F9C2	|
	ADC.w DATA_01EBB4,Y			;$01F9C3	|
	STA $AA,X				;$01F9C6	|
CODE_01F9C8:
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty			;$01F9CB	|
CODE_01F9CE:
	LDA $9E,X
	CMP.b #$AF				;$01F9D0	|
	BNE CODE_01FA3D				;$01F9D2	|
	LDA $B6,X				;$01F9D4	|
	BPL CODE_01F9DB				;$01F9D6	|
	EOR.b #$FF				;$01F9D8	|
	INC A					;$01F9DA	|
CODE_01F9DB:
	LDY.b #$00
	CMP.b #$08				;$01F9DD	|
	BCS CODE_01FA09				;$01F9DF	|
	PHA					;$01F9E1	|
	LDA.w $1662,X				;$01F9E2	|
	PHA					;$01F9E5	|
	LDA.w $167A,X				;$01F9E6	|
	PHA					;$01F9E9	|
	ORA.b #$80				;$01F9EA	|
	STA.w $167A,X				;$01F9EC	|
	LDA.b #$0C				;$01F9EF	|
	STA.w $1662,X				;$01F9F1	|
	JSR CODE_01B457				;$01F9F4	|
	PLA					;$01F9F7	|
	STA.w $167A,X				;$01F9F8	|
	PLA					;$01F9FB	|
	STA.w $1662,X				;$01F9FC	|
	PLA					;$01F9FF	|
	LDY.b #$01				;$01FA00	|
	CMP.b #$04				;$01FA02	|
	BCS CODE_01FA15				;$01FA04	|
	INY					;$01FA06	|
	BRA CODE_01FA15				;$01FA07	|

CODE_01FA09:
	LDA.w $14C8,X
	CMP.b #$08				;$01FA0C	|
	BNE CODE_01FA15				;$01FA0E	|
	PHY					;$01FA10	|
	JSR MarioSprInteractRt			;$01FA11	|
	PLY					;$01FA14	|
CODE_01FA15:
	TYA
	STA.w $1602,X				;$01FA16	|
	JSR SubSprGfx2Entry1			;$01FA19	|
	LDA.w $1602,X				;$01FA1C	|
	LDY.w $15EA,X				;$01FA1F	|
	PHX					;$01FA22	|
	TAX					;$01FA23	|
	LDA.w BooBlockTiles,X			;$01FA24	|
	STA.w $0302,Y				;$01FA27	|
	LDA.w $0303,Y				;$01FA2A	|
	AND.b #$F1				;$01FA2D	|
	ORA.w BooBlockGfxProp,X			;$01FA2F	|
	STA.w $0303,Y				;$01FA32	|
	PLX					;$01FA35	|
	RTS					;$01FA36	|

BooBlockTiles:
	db $8C,$C8,$CA

BooBlockGfxProp:
	db $0E,$02,$02

CODE_01FA3D:
	LDA.w $14C8,X
	CMP.b #$08				;$01FA40	|
	BNE CODE_01FA47				;$01FA42	|
	JSR MarioSprInteractRt			;$01FA44	|
CODE_01FA47:
	JSL CODE_038398
	RTS					;$01FA4B	|

DATA_01FA4C:
	db $40,$00

IggyBallTiles:
	db $4A,$4C,$4A,$4C

DATA_01FA52:
	db $35,$35,$F5,$F5

DATA_01FA56:
	db $10,$F0

IggysBall:
	JSR SubSprGfx2Entry1
	LDY.w $157C,X				;$01FA5B	|
	LDA.w DATA_01FA4C,Y			;$01FA5E	|
	STA $00					;$01FA61	|
	LDY.w $15EA,X				;$01FA63	|
	LDA $14					;$01FA66	|
	LSR					;$01FA68	|
	LSR					;$01FA69	|
	AND.b #$03				;$01FA6A	|
	PHX					;$01FA6C	|
	TAX					;$01FA6D	|
	LDA.w IggyBallTiles,X			;$01FA6E	|
	STA.w $0302,Y				;$01FA71	|
	LDA.w DATA_01FA52,X			;$01FA74	|
	EOR $00					;$01FA77	|
	STA.w $0303,Y				;$01FA79	|
	PLX					;$01FA7C	|
	LDA $9D					;$01FA7D	|
	BNE Return01FAB3			;$01FA7F	|
	LDY.w $157C,X				;$01FA81	|
	LDA.w DATA_01FA56,Y			;$01FA84	|
	STA $B6,X				;$01FA87	|
	JSR SubSprXPosNoGrvty			;$01FA89	|
	JSR SubSprYPosNoGrvty			;$01FA8C	|
	LDA $AA,X				;$01FA8F	|
	CMP.b #$40				;$01FA91	|
	BPL CODE_01FA9A				;$01FA93	|
	CLC					;$01FA95	|
	ADC.b #$04				;$01FA96	|
	STA $AA,X				;$01FA98	|
CODE_01FA9A:
	JSR CODE_01FF98
	BCC CODE_01FAA3				;$01FA9D	|
	LDA.b #$F0				;$01FA9F	|
	STA $AA,X				;$01FAA1	|
CODE_01FAA3:
	JSR MarioSprInteractRt
	LDA $D8,X				;$01FAA6	|
	CMP.b #$44				;$01FAA8	|
	BCC Return01FAB3			;$01FAAA	|
	CMP.b #$50				;$01FAAC	|
	BCS Return01FAB3			;$01FAAE	|
	JSR CODE_019ACB				;$01FAB0	|
Return01FAB3:
	RTS

DATA_01FAB4:
	db $FF,$01,$00,$80,$60,$A0,$40,$D0
	db $D8,$C0,$C8,$0C,$F4

KoopaKid:
	LDA $C2,X
	JSL ExecutePtr				;$01FAC3	|

KoopaKidPtrs:
	dw WallKoopaKids
	dw WallKoopaKids
	dw WallKoopaKids
	dw PlatformKoopaKids
	dw PlatformKoopaKids
	dw PipeKoopaKids
	dw PipeKoopaKids

DATA_01FAD5:
	db $00,$FC,$F8,$F8,$F8,$F8,$F8,$F8
DATA_01FADD:
	db $F8,$F8,$F8,$F4,$F0,$F0,$EC,$EC
DATA_01FAE5:
	db $00,$01,$02,$00,$01,$02,$00,$01
	db $02,$00,$01,$02,$00,$01,$02,$01

PlatformKoopaKids:
	LDA $9D
	ORA.w $154C,X				;$01FAF7	|
	BNE CODE_01FB1A				;$01FAFA	|
	JSR SubHorizPos				;$01FAFC	|
	STY $00					;$01FAFF	|
	LDA $36					;$01FB01	|
	ASL					;$01FB03	|
	ROL					;$01FB04	|
	AND.b #$01				;$01FB05	|
	CMP $00					;$01FB07	|
	BNE CODE_01FB1A				;$01FB09	|
	INC.w $1534,X				;$01FB0B	|
	LDA.w $1534,X				;$01FB0E	|
	AND.b #$7F				;$01FB11	|
	BNE CODE_01FB1A				;$01FB13	|
	LDA.b #$7F				;$01FB15	|
	STA.w $1564,X				;$01FB17	|
CODE_01FB1A:
	STZ.w $15A0,X
	LDA.w $163E,X				;$01FB1D	|
	BEQ CODE_01FB36				;$01FB20	|
	DEC A					;$01FB22	|
	BNE Return01FB35			;$01FB23	|
	INC.w $13C6				;$01FB25	|
	LDA.b #$FF				;$01FB28	|
	STA.w $1493				;$01FB2A	|
	LDA.b #$0B				;$01FB2D	|
	STA.w $1DFB				;$01FB2F	|
	STZ.w $14C8,X				;$01FB32	|
Return01FB35:
	RTS

CODE_01FB36:
	JSL LoadTweakerBytes
	LDA $9D					;$01FB3A	|
	BEQ CODE_01FB41				;$01FB3C	|
	JMP CODE_01FC08				;$01FB3E	|

CODE_01FB41:
	LDA.w $160E,X
	BEQ CODE_01FB7B				;$01FB44	|
	JSR SubSprXPosNoGrvty			;$01FB46	|
	JSR SubSprYPosNoGrvty			;$01FB49	|
	LDA $AA,X				;$01FB4C	|
	CMP.b #$40				;$01FB4E	|
	BPL CODE_01FB56				;$01FB50	|
	INC $AA,X				;$01FB52	|
	INC $AA,X				;$01FB54	|
CODE_01FB56:
	LDA $D8,X
	CMP.b #$58				;$01FB58	|
	BCC CODE_01FB6E				;$01FB5A	|
	CMP.b #$80				;$01FB5C	|
	BCS CODE_01FB6E				;$01FB5E	|
	LDA.b #$20				;$01FB60	|
	STA.w $1DFC				;$01FB62	|
	LDA.b #$50				;$01FB65	|
	STA.w $163E,X				;$01FB67	|
	JSL KillMostSprites			;$01FB6A	|
CODE_01FB6E:
	LDA $E4,X
	STA.w $14B8				;$01FB70	|
	LDA $D8,X				;$01FB73	|
	STA.w $14BA				;$01FB75	|
	JMP CODE_01FC0E				;$01FB78	|

CODE_01FB7B:
	JSR SubSprXPosNoGrvty
	LDA $13					;$01FB7E	|
	AND.b #$1F				;$01FB80	|
	ORA.w $1564,X				;$01FB82	|
	BNE CODE_01FB99				;$01FB85	|
	LDA.w $157C,X				;$01FB87	|
	PHA					;$01FB8A	|
	JSR FaceMario				;$01FB8B	|
	PLA					;$01FB8E	|
	CMP.w $157C,X				;$01FB8F	|
	BEQ CODE_01FB99				;$01FB92	|
	LDA.b #$10				;$01FB94	|
	STA.w $15AC,X				;$01FB96	|
CODE_01FB99:
	STZ $AA,X
	STZ $B6,X				;$01FB9B	|
	LDA $36					;$01FB9D	|
	BPL CODE_01FBA4				;$01FB9F	|
	CLC					;$01FBA1	|
	ADC.b #$08				;$01FBA2	|
CODE_01FBA4:
	LSR
	LSR					;$01FBA5	|
	LSR					;$01FBA6	|
	LSR					;$01FBA7	|
	TAY					;$01FBA8	|
	STY $00					;$01FBA9	|
	EOR.b #$FF				;$01FBAB	|
	INC A					;$01FBAD	|
	AND.b #$0F				;$01FBAE	|
	STA $01					;$01FBB0	|
	LDA.w $154C,X				;$01FBB2	|
	BNE CODE_01FBD9				;$01FBB5	|
	LDA $37					;$01FBB7	|
	BNE CODE_01FBC9				;$01FBB9	|
	LDA $E4,X				;$01FBBB	|
	CMP.b #$78				;$01FBBD	|
	BCC CODE_01FBC5				;$01FBBF	|
	LDA.b #$FF				;$01FBC1	|
	BRA CODE_01FBEE				;$01FBC3	|

CODE_01FBC5:
	LDA.b #$01
	BRA CODE_01FBEE				;$01FBC7	|

CODE_01FBC9:
	LDY $01
	LDA $E4,X				;$01FBCB	|
	CMP.b #$78				;$01FBCD	|
	BCS CODE_01FBD5				;$01FBCF	|
	LDA.b #$01				;$01FBD1	|
	BRA CODE_01FBEE				;$01FBD3	|

CODE_01FBD5:
	LDA.b #$FF
	BRA CODE_01FBEE				;$01FBD7	|

CODE_01FBD9:
	LDA $37
	BNE CODE_01FBE7				;$01FBDB	|
	LDY $00					;$01FBDD	|
	LDA.w DATA_01FADD,Y			;$01FBDF	|
	EOR.b #$FF				;$01FBE2	|
	INC A					;$01FBE4	|
	BRA CODE_01FBEC				;$01FBE5	|

CODE_01FBE7:
	LDY $01
	LDA.w DATA_01FADD,Y			;$01FBE9	|
CODE_01FBEC:
	ASL
	ASL					;$01FBED	|
CODE_01FBEE:
	STA $B6,X
	INC.w $1570,X				;$01FBF0	|
CODE_01FBF3:
	LDA $B6,X
	BEQ CODE_01FBFA				;$01FBF5	|
	INC.w $1570,X				;$01FBF7	|
CODE_01FBFA:
	LDA.w $1570,X
	LSR					;$01FBFD	|
	LSR					;$01FBFE	|
	AND.b #$0F				;$01FBFF	|
	TAY					;$01FC01	|
	LDA.w DATA_01FAE5,Y			;$01FC02	|
	STA.w $1602,X				;$01FC05	|
CODE_01FC08:
	JSR CODE_01FD50
	JSR CODE_01FC62				;$01FC0B	|
CODE_01FC0E:
	LDA.w $154C,X
	BNE CODE_01FC4E				;$01FC11	|
CODE_01FC13:
	LDA.w $157C,X
	PHA					;$01FC16	|
	LDY.w $15AC,X				;$01FC17	|
	BEQ CODE_01FC2A				;$01FC1A	|
	CPY.b #$08				;$01FC1C	|
	BCC CODE_01FC25				;$01FC1E	|
	EOR.b #$01				;$01FC20	|
	STA.w $157C,X				;$01FC22	|
CODE_01FC25:
	LDA.b #$06
	STA.w $1602,X				;$01FC27	|
CODE_01FC2A:
	LDA.w $1564,X
	BEQ CODE_01FC46				;$01FC2D	|
	PHA					;$01FC2F	|
	LSR					;$01FC30	|
	LSR					;$01FC31	|
	LSR					;$01FC32	|
	TAY					;$01FC33	|
	LDA.w DATA_01FD95,Y			;$01FC34	|
	STA.w $1602,X				;$01FC37	|
	PLA					;$01FC3A	|
	CMP.b #$28				;$01FC3B	|
	BNE CODE_01FC46				;$01FC3D	|
	LDA $9D					;$01FC3F	|
	BNE CODE_01FC46				;$01FC41	|
	JSR ThrowBall				;$01FC43	|
CODE_01FC46:
	JSR CODE_01FEBC
	PLA					;$01FC49	|
	STA.w $157C,X				;$01FC4A	|
	RTS					;$01FC4D	|

CODE_01FC4E:
	CMP.b #$10
	BCC CODE_01FC5A				;$01FC50	|
CODE_01FC52:
	LDA.b #$03
	STA.w $1602,X				;$01FC54	|
	JMP CODE_01FEBC				;$01FC57	|

CODE_01FC5A:
	CMP.b #$08
	BCC CODE_01FC52				;$01FC5C	|
	JSR CODE_01FF5B				;$01FC5E	|
Return01FC61:
	RTS

CODE_01FC62:
	LDA $71
	CMP.b #$01				;$01FC64	|
	BCS Return01FC61			;$01FC66	|
	LDA.w $160E,X				;$01FC68	|
	BNE Return01FC61			;$01FC6B	|
	LDA $E4,X				;$01FC6D	|
	CMP.b #$20				;$01FC6F	|
	BCC CODE_01FC77				;$01FC71	|
	CMP.b #$D8				;$01FC73	|
	BCC CODE_01FC84				;$01FC75	|
CODE_01FC77:
	LDA.w $14B8
	STA $E4,X				;$01FC7A	|
	LDA.w $14BA				;$01FC7C	|
	STA $D8,X				;$01FC7F	|
	INC.w $160E,X				;$01FC81	|
CODE_01FC84:
	LDA.w $14B8
	SEC					;$01FC87	|
	SBC.b #$08				;$01FC88	|
	STA $00					;$01FC8A	|
	LDA.w $14BA				;$01FC8C	|
	CLC					;$01FC8F	|
	ADC.b #$60				;$01FC90	|
	STA $01					;$01FC92	|
	LDA.b #$0F				;$01FC94	|
	STA $02					;$01FC96	|
	LDA.b #$0C				;$01FC98	|
	STA $03					;$01FC9A	|
	STZ $08					;$01FC9C	|
	STZ $09					;$01FC9E	|
	LDA $7E					;$01FCA0	|
	CLC					;$01FCA2	|
	ADC.b #$02				;$01FCA3	|
	STA $04					;$01FCA5	|
	LDA $80					;$01FCA7	|
	CLC					;$01FCA9	|
	ADC.b #$10				;$01FCAA	|
	STA $05					;$01FCAC	|
	LDA.b #$0C				;$01FCAE	|
	STA $06					;$01FCB0	|
	LDA.b #$0E				;$01FCB2	|
	STA $07					;$01FCB4	|
	STZ $0A					;$01FCB6	|
	STZ $0B					;$01FCB8	|
	JSL CheckForContact			;$01FCBA	|
	BCC CODE_01FD0A				;$01FCBE	|
	LDA.w $1558,X				;$01FCC0	|
	BNE Return01FD09			;$01FCC3	|
	LDA.b #$08				;$01FCC5	|
	STA.w $1558,X				;$01FCC7	|
	LDA $72					;$01FCCA	|
	BEQ CODE_01FD05				;$01FCCC	|
	LDA.b #$28				;$01FCCE	|
	STA.w $1DFC				;$01FCD0	|
	JSL BoostMarioSpeed			;$01FCD3	|
	LDA $E4,X				;$01FCD7	|
	PHA					;$01FCD9	|
	LDA $D8,X				;$01FCDA	|
	PHA					;$01FCDC	|
	LDA.w $14B8				;$01FCDD	|
	SEC					;$01FCE0	|
	SBC.b #$08				;$01FCE1	|
	STA $E4,X				;$01FCE3	|
	LDA.w $14BA				;$01FCE5	|
	SEC					;$01FCE8	|
	SBC.b #$10				;$01FCE9	|
	STA $D8,X				;$01FCEB	|
	STZ.w $15A0,X				;$01FCED	|
	JSL DisplayContactGfx			;$01FCF0	|
	PLA					;$01FCF4	|
	STA $D8,X				;$01FCF5	|
	PLA					;$01FCF7	|
	STA $E4,X				;$01FCF8	|
	LDA.w $154C,X				;$01FCFA	|
	BNE Return01FD09			;$01FCFD	|
	LDA.b #$18				;$01FCFF	|
	STA.w $154C,X				;$01FD01	|
	RTS					;$01FD04	|

CODE_01FD05:
	JSL HurtMario
Return01FD09:
	RTS

CODE_01FD0A:
	LDY.b #$0A
CODE_01FD0C:
	STY.w $1695
	LDA.w $170B,Y				;$01FD0F	|
	CMP.b #$05				;$01FD12	|
	BNE CODE_01FD4A				;$01FD14	|
	LDA.w $171F,Y				;$01FD16	|
	SEC					;$01FD19	|
	SBC $1A					;$01FD1A	|
	STA $04					;$01FD1C	|
	STZ $0A					;$01FD1E	|
	LDA.w $1715,Y				;$01FD20	|
	SEC					;$01FD23	|
	SBC $1C					;$01FD24	|
	STA $05					;$01FD26	|
	STZ $0B					;$01FD28	|
	LDA.b #$08				;$01FD2A	|
	STA $06					;$01FD2C	|
	STA $07					;$01FD2E	|
	JSL CheckForContact			;$01FD30	|
	BCC CODE_01FD4A				;$01FD34	|
	LDA.b #$01				;$01FD36	|
	STA.w $170B,Y				;$01FD38	|
	LDA.b #$0F				;$01FD3B	|
	STA.w $176F,Y				;$01FD3D	|
	LDA.b #$01				;$01FD40	|
	STA.w $1DF9				;$01FD42	|
	LDA.b #$10				;$01FD45	|
	STA.w $154C,X				;$01FD47	|
CODE_01FD4A:
	DEY
	CPY.b #$07				;$01FD4B	|
	BNE CODE_01FD0C				;$01FD4D	|
	RTS					;$01FD4F	|

CODE_01FD50:
	LDA $E4,X
	CLC					;$01FD52	|
	ADC.b #$08				;$01FD53	|
	STA.w $14B4				;$01FD55	|
	LDA.w $14E0,X				;$01FD58	|
	ADC.b #$00				;$01FD5B	|
	STA.w $14B5				;$01FD5D	|
	LDA $D8,X				;$01FD60	|
	CLC					;$01FD62	|
	ADC.b #$2F				;$01FD63	|
	STA.w $14B6				;$01FD65	|
	LDA.w $14D4,X				;$01FD68	|
	ADC.b #$00				;$01FD6B	|
	STA.w $14B7				;$01FD6D	|
	REP #$20				;$01FD70	|
	LDA $36					;$01FD72	|
	EOR.w #$01FF				;$01FD74	|
	INC A					;$01FD77	|
	AND.w #$01FF				;$01FD78	|
	STA $36					;$01FD7B	|
	SEP #$20				;$01FD7D	|
	PHX					;$01FD7F	|
	JSL CODE_01CC9D				;$01FD80	|
	PLX					;$01FD84	|
	REP #$20				;$01FD85	|
	LDA $36					;$01FD87	|
	EOR.w #$01FF				;$01FD89	|
	INC A					;$01FD8C	|
	AND.w #$01FF				;$01FD8D	|
	STA $36					;$01FD90	|
	SEP #$20				;$01FD92	|
	RTS					;$01FD94	|

DATA_01FD95:
	db $04,$0B,$0B,$0B,$0B,$0A,$0A,$09
	db $09,$08,$08,$07,$04,$05,$05,$05
BallPositionDispX:
	db $08,$F8

ThrowBall:
	LDY.b #$05
CODE_01FDA9:
	LDA.w $14C8,Y
	BEQ GenerateBall			;$01FDAC	|
	DEY					;$01FDAE	|
	BPL CODE_01FDA9				;$01FDAF	|
	RTS					;$01FDB1	|

GenerateBall:
	LDA.b #$20
	STA.w $1DF9				;$01FDB4	|
	LDA.b #$08				;$01FDB7	|
	STA.w $14C8,Y				;$01FDB9	|
	LDA.b #$A7				;$01FDBC	|
	STA.w $009E,y				;$01FDBE	|
	PHX					;$01FDC1	|
	TYX					;$01FDC2	|
	JSL InitSpriteTables			;$01FDC3	|
	PLX					;$01FDC7	|
	PHX					;$01FDC8	|
	LDA.w $157C,X				;$01FDC9	|
	STA.w $157C,Y				;$01FDCC	|
	TAX					;$01FDCF	|
	LDA.w $14B8				;$01FDD0	|
	SEC					;$01FDD3	|
	SBC.b #$08				;$01FDD4	|
	ADC.w BallPositionDispX,X		;$01FDD6	|
	STA.w $00E4,y				;$01FDD9	|
	LDA.b #$00				;$01FDDC	|
	STA.w $14E0,Y				;$01FDDE	|
	LDA.w $14BA				;$01FDE1	|
	SEC					;$01FDE4	|
	SBC.b #$18				;$01FDE5	|
	STA.w $00D8,y				;$01FDE7	|
	LDA.b #$00				;$01FDEA	|
	SBC.b #$00				;$01FDEC	|
	STA.w $14D4,Y				;$01FDEE	|
	PLX					;$01FDF1	|
	RTS					;$01FDF2	|

DATA_01FDF3:
	db $F7,$FF,$00,$F8,$F7,$FF,$00,$F8
	db $F8,$00,$00,$F8,$FB,$03,$00,$F8
	db $F8,$00,$00,$F8,$FA,$02,$00,$F8
	db $00,$00,$F8,$00,$00,$F8,$00,$F8
	db $00,$00,$00,$00,$FB,$F8,$00,$F8
	db $F4,$F8,$00,$F8,$00,$F8,$00,$F8
	db $09,$09,$00,$10,$09,$09,$00,$10
	db $08,$08,$00,$10,$05,$05,$00,$10
	db $08,$08,$00,$10,$06,$06,$00,$10
	db $00,$08,$08,$08,$00,$10,$00,$10
	db $00,$08,$00,$08,$05,$10,$00,$10
	db $0C,$10,$00,$10,$00,$10,$00,$10
DATA_01FE53:
	db $FA,$F2,$00,$09,$F9,$F1,$00,$08
	db $F8,$F0,$00,$08,$FE,$F6,$00,$08
	db $FC,$F4,$00,$08,$FF,$F7,$00,$08
	db $00,$F0,$F8,$F0,$00,$00,$00,$00
	db $00,$00,$00,$00,$FC,$00,$00,$00
	db $F9,$00,$00,$00,$00,$08,$00,$08
DATA_01FE83:
	db $00,$0C,$02,$0A,$00,$0C,$22,$0A
	db $00,$0C,$20,$0A,$00,$0C,$20,$0A
	db $00,$0C,$20,$0A,$00,$0C,$20,$0A
	db $24,$1C,$04,$1C,$0E,$0D,$0E,$0D
	db $0E,$1D,$0E,$1D,$4A,$0D,$0E,$0D
	db $4A,$0D,$0E,$0D,$20,$0A,$20,$0A
DATA_01FEB3:
	db $06,$02,$08

DATA_01FEB6:
	db $02

DATA_01FEB7:
	db $00,$02,$00,$37,$3B

CODE_01FEBC:
	LDY $C2,X
	LDA.w DATA_01FEB7,Y			;$01FEBE	|
	STA $0D					;$01FEC1	|
	STY $05					;$01FEC3	|
	LDY.w $15EA,X				;$01FEC5	|
	LDA.w $157C,X				;$01FEC8	|
	LSR					;$01FECB	|
	ROR					;$01FECC	|
	LSR					;$01FECD	|
	AND.b #$40				;$01FECE	|
	EOR.b #$40				;$01FED0	|
	STA $02					;$01FED2	|
	LDA.w $1602,X				;$01FED4	|
	ASL					;$01FED7	|
	ASL					;$01FED8	|
	STA $03					;$01FED9	|
	PHX					;$01FEDB	|
	LDX.b #$03				;$01FEDC	|
CODE_01FEDE:
	PHX
	TXA					;$01FEDF	|
	CLC					;$01FEE0	|
	ADC $03					;$01FEE1	|
	TAX					;$01FEE3	|
	PHX					;$01FEE4	|
	LDA $02					;$01FEE5	|
	BEQ CODE_01FEEE				;$01FEE7	|
	TXA					;$01FEE9	|
	CLC					;$01FEEA	|
	ADC.b #$30				;$01FEEB	|
	TAX					;$01FEED	|
CODE_01FEEE:
	LDA.w $14B8
	SEC					;$01FEF1	|
	SBC.b #$08				;$01FEF2	|
	CLC					;$01FEF4	|
	ADC.w DATA_01FDF3,X			;$01FEF5	|
	STA.w $0300,Y				;$01FEF8	|
	PLX					;$01FEFB	|
	LDA.w $14BA				;$01FEFC	|
	CLC					;$01FEFF	|
	ADC.b #$60				;$01FF00	|
	CLC					;$01FF02	|
	ADC.w DATA_01FE53,X			;$01FF03	|
	STA.w $0301,Y				;$01FF06	|
	LDA.w DATA_01FE83,X			;$01FF09	|
	STA.w $0302,Y				;$01FF0C	|
	PHX					;$01FF0F	|
	LDX $05					;$01FF10	|
	CPX.b #$03				;$01FF12	|
	BNE CODE_01FF22				;$01FF14	|
	CMP.b #$05				;$01FF16	|
	BCS CODE_01FF22				;$01FF18	|
	LSR					;$01FF1A	|
	TAX					;$01FF1B	|
	LDA.w DATA_01FEB3,X			;$01FF1C	|
	STA.w $0302,Y				;$01FF1F	|
CODE_01FF22:
	LDA.w $0302,Y
	CMP.b #$4A				;$01FF25	|
	LDA $0D					;$01FF27	|
	BCC CODE_01FF2D				;$01FF29	|
	LDA.b #$35				;$01FF2B	|
CODE_01FF2D:
	ORA $02
	STA.w $0303,Y				;$01FF2F	|
	PLA					;$01FF32	|
	AND.b #$03				;$01FF33	|
	TAX					;$01FF35	|
	PHY					;$01FF36	|
	TYA					;$01FF37	|
	LSR					;$01FF38	|
	LSR					;$01FF39	|
	TAY					;$01FF3A	|
	LDA.w DATA_01FEB6,X			;$01FF3B	|
	STA.w $0460,Y				;$01FF3E	|
	PLY					;$01FF41	|
	INY					;$01FF42	|
	INY					;$01FF43	|
	INY					;$01FF44	|
	INY					;$01FF45	|
	PLX					;$01FF46	|
	DEX					;$01FF47	|
	BPL CODE_01FEDE				;$01FF48	|
	PLX					;$01FF4A	|
	LDY.b #$FF				;$01FF4B	|
	LDA.b #$03				;$01FF4D	|
	JSR FinishOAMWriteRt			;$01FF4F	|
	RTS					;$01FF52	|

DATA_01FF53:
	db $2C,$2E,$2C,$2E

DATA_01FF57:
	db $00,$00,$40,$00

CODE_01FF5B:
	PHX
	LDY $C2,X				;$01FF5C	|
	LDA.w DATA_01FEB7,Y			;$01FF5E	|
	STA $0D					;$01FF61	|
	LDY.b #$70				;$01FF63	|
	LDA.w $14B8				;$01FF65	|
	SEC					;$01FF68	|
	SBC.b #$08				;$01FF69	|
	STA.w $0300,Y				;$01FF6B	|
	LDA.w $14BA				;$01FF6E	|
	CLC					;$01FF71	|
	ADC.b #$60				;$01FF72	|
	STA.w $0301,Y				;$01FF74	|
	LDA $14					;$01FF77	|
	LSR					;$01FF79	|
	AND.b #$03				;$01FF7A	|
	TAX					;$01FF7C	|
	LDA.w DATA_01FF53,X			;$01FF7D	|
	STA.w $0302,Y				;$01FF80	|
	LDA.b #$30				;$01FF83	|
	ORA.w DATA_01FF57,X			;$01FF85	|
	ORA $0D					;$01FF88	|
	STA.w $0303,Y				;$01FF8A	|
	TYA					;$01FF8D	|
	LSR					;$01FF8E	|
	LSR					;$01FF8F	|
	TAY					;$01FF90	|
	LDA.b #$02				;$01FF91	|
	STA.w $0460,Y				;$01FF93	|
	PLX					;$01FF96	|
	RTS					;$01FF97	|

CODE_01FF98:
	LDA $E4,X
	CLC					;$01FF9A	|
	ADC.b #$08				;$01FF9B	|
	STA.w $14B4				;$01FF9D	|
	LDA.w $14E0,X				;$01FFA0	|
	ADC.b #$00				;$01FFA3	|
	STA.w $14B5				;$01FFA5	|
	LDA $D8,X				;$01FFA8	|
	CLC					;$01FFAA	|
	ADC.b #$0F				;$01FFAB	|
	STA.w $14B6				;$01FFAD	|
	LDA.w $14D4,X				;$01FFB0	|
	ADC.b #$00				;$01FFB3	|
	STA.w $14B7				;$01FFB5	|
	PHX					;$01FFB8	|
	JSL CODE_01CC9D				;$01FFB9	|
	PLX					;$01FFBD	|
	RTS					;$01FFBE	|

DATA_01FFBF:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF
