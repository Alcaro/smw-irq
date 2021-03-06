ORG $008000
reset_start:
	SEI					;$008000	\ Disable IRQ
	STZ.w $4200				;$008001	 | Disable IRQ, NMI and joypad reading
	STZ.w $420C				;$008004	 | Disable HDMA
	STZ.w $420B				;$008007	 | Disable DMA
	STZ.w $2140				;$00800A	 |\ Clear SPC I/O ports
	STZ.w $2141				;$00800D	 | |
	STZ.w $2142				;$008010	 | |
	STZ.w $2143				;$008013	 |/
	LDA.b #$80				;$008016	 |\ Enable F-blank
	STA.w $2100				;$008018	 |/
	CLC					;$00801B	 |\ Disable emulation mode
	XCE					;$00801C	 |/
	REP #$38				;$00801D	 | Disable decimal mode, Enable 16 bit A/X/Y
	LDA.w #$0000				;$00801F	 |\ Set up the direct page
	TCD					;$008022	 |/
	LDA.w #$01FF				;$008023	 |\ Set up the stack
	TCS					;$008026	 |/
	LDA.w #$F0A9				;$008027	 |\ Upload OAM clear routine
	STA.l $7F8000				;$00802A	 | | LDA #$F0
	LDX.w #$017D				;$00802E	 | | Loop counter
	LDY.w #$03FD				;$008031	 | | Current address
RAM_routine_upload:				;		 | |
	LDA.w #$008D				;$008034	 | | STA $XXXX
	STA.l $7F8002,X				;$008037	 | |
	TYA					;$00803B	 | | Set the address to store to
	STA.l $7F8003,X				;$00803C	 | |
	SEC					;$008040	 | | Decrement by four for new address
	SBC.w #$0004				;$008041	 | |
	TAY					;$008044	 | |
	DEX					;$008045	 | | Decrememnt loop
	DEX					;$008046	 | |
	DEX					;$008047	 | |
	BPL RAM_routine_upload			;$008048	 | |
	SEP #$30				;$00804A	 | | 8 bit A/X/Y
	LDA.b #$6B				;$00804C	 | | RTL
	STA.l $7F8182				;$00804E	 |/
	JSR upload_SPC_engine			;$008052	 | Upload the SPC engine
	STZ.w $0100				;$008055	 | Clear game mode
	STZ.w $0109				;$008058	 | Clear level number(used for OW bypass)
	JSR clear_non_stack			;$00805B	 | RAM clear routine
	JSR upload_samples			;$00805E	 | Upload SPC samples
	JSR setup_window_HDMA			;$008061	 | Set up HDMA for window settings
	LDA.b #$03				;$008064	 |\ Set up OAM registers( 8x8 and 16x16)
	STA.w $2101				;$008066	 |/
	INC $10					;$008069	/
game_loop:
	LDA $10					;$00806B	\ Main wait loop
	BEQ game_loop				;$00806D	 | $10 is set in NMI to $00
	CLI					;$00806F	 | Enable interrupts
	INC $13					;$008070	 | Increment frame counter
	JSR run_game_mode			;$008072	 | Run the game
	STZ $10					;$008075	 | Clear $10
	BRA game_loop				;$008077	/ Back to the wait loop

SPC_upload_loop:
	PHP					;$008079	\ Preserve processor flags
	REP #$30				;$00807A	 |  16 bit A/X/Y
	LDY.w #$0000				;$00807C	 |
	LDA.w #$BBAA				;$00807F	 |\ Value to check if the SPC is ready
.SPC_wait					;		 | |
	CMP.w $2140				;$008082	 | | Wait for the SPC to be ready
	BNE .SPC_wait				;$008085	 |/
	SEP #$20				;$008087	 | 8 bit A
	LDA.b #$CC				;$008089	 |\ Byte used to enable SPC block upload
	BRA send_SPC_block			;$00808B	 |/
SPC_transfer_bytes:				;		 |\
	LDA [$00],Y				;$00808D	 | | Load the Byte into the low byte
	INY					;$00808F	 | | Increase the index
	XBA					;$008090	 | | Move it to the high byte
	LDA.b #$00				;$008091	 |/ Set the validation byte to the low byte
	BRA start_block_upload			;$008093	 |
next_byte:					;		 |\
	XBA					;$008095	 | | Switch the high and low byte
	LDA [$00],Y				;$008096	 | | Load a new low byte
	INY					;$008098	 | | Increase the index
	XBA					;$008099	 |/ Switch the new low byte to the high byte
.SPC_wait					;		 |\ SPC wait loop
	CMP.w $2140				;$00809A	 | | Wait till $2140 matches the validation byte
	BNE .SPC_wait				;$00809D	 |/
	INC A					;$00809F	 | Increment the validation byte
start_block_upload:				;		 |\
	REP #$20				;$0080A0	 | | 16 bit A
	STA.w $2140				;$0080A2	 | | Store to $2140/$2141
	SEP #$20				;$0080A5	 | | 8 bit A
	DEX					;$0080A7	 |/ Decrement byte counter
	BNE next_byte				;$0080A8	 |
.SPC_wait					;		 |\ SPC wait loop
	CMP.w $2140				;$0080AA	 | |
	BNE .SPC_wait				;$0080AD	 |/
.add_three					;		 |\
	ADC.b #$03				;$0080AD	 | | If A is 0 add 3 again
	BEQ .add_three				;$0080B1	 |/
send_SPC_block:					;		 |
	PHA					;$0080B3	 | Preserve A to store to $2140 later
	REP #$20				;$0080B4	 | 16 bit A
	LDA [$00],Y				;$0080B6	 |\ Get data length
	INY					;$0080B8	 | |
	INY					;$0080B9	 | |
	TAX					;$0080BA	 |/
	LDA [$00],Y				;$0080BB	 |\ Get address to write to in SPC RAM
	INY					;$0080BD	 | |
	INY					;$0080BE	 |/
	STA.w $2142				;$0080BF	 | Store the address of SPC RAM to write to
	SEP #$20				;$0080C2	 | 8 bit A
	CPX.w #$0001				;$0080C4	 |
	LDA.b #$00				;$0080C7	 |\ Store the carry flag in $2141
	ROL					;$0080C9	 | |
	STA.w $2141				;$0080CA	 |/
	ADC.b #$7F				;$0080CD	 | if A is one this sets the overflow flag
	PLA					;$0080CF	 |\ Store the A pushed earlier
	STA.w $2140				;$0080D0	 |/
.SPC_wait					;		 |\ SPC wait loop
	CMP.w $2140				;$0080D3	 | |
	BNE .SPC_wait				;$0080D6	 |/
	BVS SPC_transfer_bytes			;$0080D8	 | If the overflow is not set, keep uploading
	STZ.w $2140				;$0080DA	 |\ Clear SPC I/O ports
	STZ.w $2141				;$0080DD	 | |
	STZ.w $2142				;$0080E0	 | |
	STZ.w $2143				;$0080E3	 |/
	PLP					;$0080E6	 | Restore processor flag
	RTS					;$0080E7	/

upload_SPC_engine:
	LDA.b #SPC_engine			;$0080E8	\
	STA.w $0000				;$0080EA	 | Set up pointer at $00 to the SPC data ($0E8000)
	LDA.b #SPC_engine>>8			;$0080ED	 |
	STA.w $0001				;$0080EF	 |
	LDA.b #SPC_engine>>16			;$0080F2	 |
	STA.w $0002				;$0080F4	 |
upload_data_to_SPC:				;		/
	SEI					;$0080F7	\ Prevent interrupts from interrupting SPC upload
	JSR SPC_upload_loop			;$0080F8	 | Main SPC upload loop
	CLI					;$0080FB	 | Enable interrupts again
	RTS					;$0080FC	/

upload_samples:
	LDA.b #sample_table			;$0080FD	\ Set up pointer at $00 to the SPC data ($0F8000)
	STA.w $0000				;$0080FF	 |
	LDA.b #sample_table>>8			;$008102	 |
	STA.w $0001				;$008104	 |
	LDA.b #sample_table>>16			;$008107	 |
	STA.w $0002				;$008109	 |
	BRA start_SPC_upload			;$00810C	/

upload_music_bank_1:
	LDA.b #music_bank_1			;$00810E	\ Set up pointer at $00 to the SPC data ($0E98B1)
	STA.w $0000				;$008110	 |
	LDA.b #music_bank_1>>8			;$008113	 | Map Music
	STA.w $0001				;$008115	 |
	LDA.b #music_bank_1>>16			;$008118	 |
	STA.w $0002				;$00811A	/
start_SPC_upload:				;		\
	LDA.b #$FF				;$00811D	 |\ Tell the SPC to enable the upload routine
	STA.w $2141				;$00811F	 |/
	JSR upload_data_to_SPC			;$008122	 | Enter the SNES side SPC upload
	LDX.b #$03				;$008125	 |\ 
SPC_clear_loop:					;		 | | Clear out all SPC I/O ports and mirrors
	STZ.w $2140,X				;$008127	 | |
	STZ.w $1DF9,X				;$00812A	 | |
	STZ.w $1DFD,X				;$00812D	 | |
	DEX					;$008130	 | |
	BPL SPC_clear_loop			;$008131	 |/
SPC_upload_return:				;		 |
	RTS					;$008133	/

upload_level_music:
	LDA.w $1425				;$008134	\ Load bank 2 music if you are going to a bonus game
	BNE upload_music_bank_2			;$008137	 |
	LDA.w $0109				;$008139	 | Load bank 2 music if this is the intro level
	CMP.b #$E9				;$00813C	 |
	BEQ upload_music_bank_2			;$00813E	 |
	ORA.w $141A				;$008140	 | If you are transitioning levels reupload music
	ORA.w $141D				;$008143	 |
	BNE SPC_upload_return			;$008146	/
upload_music_bank_2:
	LDA.b #music_bank_2			;$008148	\ Set up pointer at $00 to the SPC data ($0EAED6)
	STA.w $0000				;$00814A	 |
	LDA.b #music_bank_2>>8			;$00814D	 |
	STA.w $0001				;$00814F	 | Level music
	LDA.b #music_bank_2>>16			;$008152	 |
	STA.w $0002				;$008154	 |
	BRA start_SPC_upload			;$008157	/

upload_music_bank_3:
	LDA.b #music_bank_3			;$008159	\ Set up pointer at $00 to the SPC data ($03E400)
	STA.w $0000				;$00815B	 |
	LDA.b #music_bank_3>>8			;$00815E	 |
	STA.w $0001				;$008160	 | Credits music
	LDA.b #music_bank_3>>16			;$008163	 |
	STA.w $0002				;$008165	 |
	BRA start_SPC_upload			;$008168	/

NMI_start:					;		\
	SEI					;$00816A	 | Disable interrupts to stop interrupting an interrupt
	PHP					;$00816B	 |\
	REP #$30				;$00816C	 | | Push pretty much everything(except direct page)
	PHA					;$00816E	 | | Make sure you push 16 bit values to the stack
	PHX					;$00816F	 | |
	PHY					;$008170	 | |
	PHB					;$008171	 | |
	PHK					;$008172	 | | Also set the bank to 00
	PLB					;$008173	 |/
	SEP #$30				;$008174	 | 8 bit A/X/Y
	LDA.w $4210				;$008176	 | Read to clear the n flag
	LDA.w $1DFB				;$008179	 |\ If playing a sound in $1DFB branch to keep playing
	BNE .keep_playing			;$00817C	 |/
	LDY.w $2142				;$00817E	 |\ Check if $1DFF matches the current playing sound
	CPY.w $1DFF				;$008181	 | |
	BNE .sound_update			;$008184	 |/
.keep_playing					;		 |
	STA.w $2142				;$008186	 |\ Keep the current sound playing
	STA.w $1DFF				;$008189	 | | Then mirror and clear $1DFB
	STZ.w $1DFB				;$00818C	 |/
.sound_update					;		 |
	LDA.w $1DF9				;$00818F	 |\ Update the remaining sound ports and clear mirrors
	STA.w $2140				;$008192	 | |
	LDA.w $1DFA				;$008195	 | |
	STA.w $2141				;$008198	 | |
	LDA.w $1DFC				;$00819B	 | |
	STA.w $2143				;$00819E	 | |
	STZ.w $1DF9				;$0081A1	 | |
	STZ.w $1DFA				;$0081A4	 | |
	STZ.w $1DFC				;$0081A7	 |/
	LDA.b #$80				;$0081AA	 |\ Force blank
	STA.w $2100				;$0081AC	 |/
	STZ.w $420C				;$0081AF	 | Disable HDMA
	LDA $41					;$0081B2	 |\ Update layer 1 and 2 window mask settings
	STA.w $2123				;$0081B4	 |/
	LDA $42					;$0081B7	 |\ Update layer 3 and 4 window mask settings
	STA.w $2124				;$0081B9	 |/
	LDA $43					;$0081BC	 |\ Update sprite and color window settings
	STA.w $2125				;$0081BE	 |/
	LDA $44					;$0081C1	 |\ Initial color addition settings
	STA.w $2130				;$0081C3	 |/
	LDA.w $0D9B				;$0081C6	 |\ Check for a regular level
	BPL .regular_level_NMI			;$0081C9	 | |
	JMP .mode_7_NMI				;$0081CB	 |/ Otherwise go to mode 7 routines
.regular_level_NMI				;		 |
	LDA $40					;$0081CE	 |\ Set up color math on all layers in $40 but three
	AND.b #$FB				;$0081D0	 | |
	STA.w $2131				;$0081D2	 |/
	LDA.b #$09				;$0081D5	 |\ Mode 1 with layer 3 priority
	STA.w $2105				;$0081D7	 |/
	LDA $10					;$0081DA	 |\ If the game is not lagging skip to regular NMI
	BEQ .no_lag				;$0081DC	 |/
	LDA.w $0D9B				;$0081DE	 |\ Check if we are in a regular level
	LSR					;$0081E1	 | |
	BEQ .lagging_level_NMI			;$0081E2	 | |
	JMP .lagging_OW_NMI			;$0081E4	 |/ Otherwise process as the OW
.no_lag						;		 |
	INC $10					;$0081E7	 | Allow the game loop to run after NMI
	JSR upload_palette			;$0081E9	 | Upload special and normal palettes
	LDA.w $0D9B				;$0081EC	 |\ Separate the current level mode
	LSR					;$0081EF	 |/
	BNE .OW_NMI				;$0081F0	 | $0D9B was 02, run OW code
	BCS .transition_NMI			;$0081F2	 | $0D9B was 01(transition), Skip the status bar draw
	JSR draw_status_bar			;$0081F4	 | Draw the status bar
.transition_NMI					;		 |
	LDA.w $13C6				;$0081F7	 |\ Skip the end credits code 
	CMP.b #$08				;$0081FA	 | | if the current cutscene is not $08 (end credits)
	BNE .not_end_credits			;$0081FC	 |/
	LDA.w $1FFE				;$0081FE	 |\ Skip updating the credits BG
	BEQ .draw_mario				;$008201	 |/ If a new BG is not yet needed
	JSL DMA_credits_BG			;$008203	 | Update the Credits BG
	BRA .draw_mario				;$008207	 | Continue with NMI by drawing mario
.not_end_credits				;		 |
	JSL generic_layer_1_and_2_upload	;$008209	 | Primary level data DMA
	LDA.w $143A				;$00820D	 |\ Check if the transition screens need DMAed
	BEQ .skip_transition_DMA		;$008210	 |/
	JSR DMA_transition_screen		;$008212	 | DMA start/bonus/game over/time up transition screens
	BRA .skip_OW_NMI			;$008215	 | Skip past regular and OW NMI
.skip_transition_DMA				;		 |
	JSR DMA_animated_level_tiles		;$008217	 | DMA animated level tiles (plus animated palettes)
.draw_mario					;		 |
	JSR restore_SP1_tiles			;$00821A	 | DMA $0BF6 to VRAM, redundant due to graphics upload
	JSR dynamic_sprite_DMA			;$00821D	 | DMA Mario/Yoshi/Vertical fireball
	BRA .skip_OW_NMI			;$008220	 | Skip over a majority of the OW NMI
.OW_NMI						;		 |
	LDA.w $13D9				;$008222	 |\ If not switching submaps, skip OW layer DMA
	CMP.b #$0A				;$008225	 | | and handle the regular OW routines
	BNE .regular_OW_handle			;$008227	 |/
	LDY.w $1DE8				;$008229	 |
	DEY					;$00822C	 |\ If submap loading is finished, skip layer data DMA
	DEY					;$00822D	 | | and handle the regular OW routines
	CPY.b #$04				;$00822E	 | |
	BCS .regular_OW_handle			;$008230	 |/
	JSR DMA_OW_tilemap			;$008232	 | OW layer 1 and 2 DMA
	BRA .regular_OW_bypass			;$008235	 | Skip over various unneeded OW DMAs
.regular_OW_handle				;		 |
	JSR DMA_animated_OW_tiles		;$008237	 | DMA animated OW tiles (plus animated palettes)
	JSR dynamic_sprite_DMA			;$00823A	 | DMA Mario/Yoshi/Vertical fireball
.skip_OW_NMI:					;		 |
	JSR _load_stripe_image_			;$00823D	 | Upload Stripe image data
	JSR DMA_OAM				;$008240	 | DMA Sprite tiles to the screen
.regular_OW_bypass				;		 |
	JSR update_controllers			;$008243	 | Run the controller update routine
.lagging_level_NMI				;		 |
	LDA $1A					;$008246	 |\ Set layer 1 X position from mirrors
	STA.w $210D				;$008248	 | | $210D is a write twice register 
	LDA $1B					;$00824B	 | |
	STA.w $210D				;$00824D	 |/
	LDA $1C					;$008250	 |\ Set layer 1 Y position from mirrors
	CLC					;$008252	 | | 
	ADC.w $1888				;$008253	 | | $1888/9 are used as relative Y offsets
	STA.w $210E				;$008256	 | | $210E is a write twice register
	LDA $1D					;$008259	 | |
	ADC.w $1889				;$00825B	 | |
	STA.w $210E				;$00825E	 |/
	LDA $1E					;$008261	 |\ Set layer 2 X position from mirrors
	STA.w $210F				;$008263	 | | $210F is a write twice register 
	LDA $1F					;$008266	 | |
	STA.w $210F				;$008268	 |/
	LDA $20					;$00826B	 |\ Set layer 2 Y position from mirrors
	STA.w $2110				;$00826D	 | | $2110 is a write twice register 
	LDA $21					;$008270	 | |
	STA.w $2110				;$008272	 |/
	LDA.w $0D9B				;$008275	 |\ If we are in a level, skip to level NMI return
	BEQ .level_NMI_return			;$008278	 |/
.lagging_OW_NMI					;		 |
	LDA.b #$81				;$00827A	 | Load Enable NMI and autojoy enabled
	LDY.w $13C6				;$00827C	 |\ Skip to NMI return if the credits are not playing
	CPY.b #$08				;$00827F	 | |
	BNE .NMI_return				;$008281	 |/
	LDY.w $0DAE				;$008283	 |\ Set screen brightness from mirror
	STY.w $2100				;$008286	 |/
	LDY.w $0D9F				;$008289	 |\ Enable HDMA channels
	STY.w $420C				;$00828C	 |/
	JMP IRQ_NMI_return			;$00828F	 | Finish off NMI
.level_NMI_return				;		 |
	LDY.b #$24				;$008292	 | Load the V timer scanline
.mode_7_NMI_return				;		 |
	LDA.w $4211				;$008294	 | Read to clear the IRQ flag
	STY.w $4209				;$008297	 | Set the V timer low byte (generally #$24)
	STZ.w $420A				;$00829A	 | Clear the V timer high byte
	STZ $11					;$00829D	 | Set IRQ id flag to 0 (IRQ #1)
	LDA.b #$A1				;$00829F	 | Load Enable NMI, vertical IRQ, and autojoy enabled
.NMI_return					;		 |
	STA.w $4200				;$0082A1	 | Store NMI/IRQ/autojoy enabled status
	STZ.w $2111				;$0082A4	 |\ Reset layer X three scroll position
	STZ.w $2111				;$0082A7	 |/
	STZ.w $2112				;$0082AA	 |\ Reset layer Y three scroll position
	STZ.w $2112				;$0082AD	 |/
	LDA.w $0DAE				;$0082B0	 |\ Mirror brightness and force blank settings
	STA.w $2100				;$0082B3	 |/ to the display register
	LDA.w $0D9F				;$0082B6	 |\ Enable HDMA channels based off the HDMA mirror
	STA.w $420C				;$0082B9	 |/
	REP #$30				;$0082BC	 |\ Restore everything saved at the beginning of NMI
	PLB					;$0082BE	 | |
	PLY					;$0082BF	 | |
	PLX					;$0082C0	 | |
	PLA					;$0082C1	 | |
	PLP					;$0082C2	 |/
	RTI					;$0082C3	/ Return from NMI

.mode_7_NMI					;		\ 
	LDA $10					;$0082C4	 |\ if mode 7 is lagging branch
	BNE .lagging_mode_7_NMI			;$0082C6	 | |
	INC $10					;$0082C8	 |/ Otherwise increment the lag counter
	LDA.w $143A				;$0082CA	 |\ Check if the transition screens need DMAed
	BEQ .skip_mode_7_transition_DMA		;$0082CD	 |/
	JSR DMA_transition_screen		;$0082CF	 | DMA start/bonus/game over/time up transition screens
	BRA .draw_status_bar			;$0082D2	 | Skip dynamic graphics DMA
.skip_mode_7_transition_DMA			;		 |
	JSR restore_SP1_tiles			;$0082D4	 | DMA $0BF6 to VRAM, redundant due to graphics upload
	JSR dynamic_sprite_DMA			;$0082D7	 | DMA Mario/Yoshi/Vertical fireball graphics
	BIT.w $0D9B				;$0082DA	 |\ If we are in a platform boss fight
	BVC .draw_status_bar			;$0082DD	 |/ Draw the status bar
	JSR DMA_mode_7_animations		;$0082DF	 | <--some animation stuff, investigate more
	LDA.w $0D9B				;$0082E2	 |\ If we are fighting bowser, don't draw the status bar
	LSR					;$0082E5	 | |
	BCS .skip_status_bar			;$0082E6	 |/
.draw_status_bar				;		 |
	JSR draw_status_bar			;$0082E8	 | Draw the status bar
.skip_status_bar				;		 |
	JSR upload_palette			;$0082ED	 | Upload any pending palette changes
	JSR _load_stripe_image_			;$0082EE	 | Load stripe images from $12
	JSR DMA_OAM				;$0082F1	 | DMA sprite tiles to OAM
	JSR update_controllers			;$0082F4	 | Update the controller input
.lagging_mode_7_NMI				;		 |
	LDA.b #$09				;$0082F7	 |
	STA.w $2105				;$0082F9	 |
	LDA $2A					;$0082FC	 |\ Set the mode 7 center X position
	CLC					;$0082FE	 | |
	ADC.b #$80				;$0082FF	 | | Offset the center by #$80
	STA.w $211F				;$008301	 | |
	LDA $2B					;$008304	 | |
	ADC.b #$00				;$008306	 | | Handle carry if needed
	STA.w $211F				;$008308	 |/
	LDA $2C					;$00830B	 |\ Set the mode 7 center Y position
	CLC					;$00830D	 | |
	ADC.b #$80				;$00830E	 | | Offset the center by #$80
	STA.w $2120				;$008310	 | |
	LDA $2D					;$008313	 | |
	ADC.b #$00				;$008315	 | | Handle carry if needed
	STA.w $2120				;$008317	 |/
	LDA $2E					;$00831A	 |\ Update mode 7 matrix value A
	STA.w $211B				;$00831C	 | |
	LDA $2F					;$00831F	 | |
	STA.w $211B				;$008321	 |/
	LDA $30					;$008324	 |\ Update mode 7 matrix value B
	STA.w $211C				;$008326	 | |
	LDA $31					;$008329	 | |
	STA.w $211C				;$00832B	 |/
	LDA $32					;$00832E	 |\ Update mode 7 matrix value C
	STA.w $211D				;$008330	 | |
	LDA $33					;$008333	 | |
	STA.w $211D				;$008335	 |/
	LDA $34					;$008338	 |\ Update mode 7 matrix value D
	STA.w $211E				;$00833A	 | |
	LDA $35					;$00833D	 | |
	STA.w $211E				;$00833F	 |/
	JSR mode_7_static_BG_scroll		;$008342	 |
	LDA.w $0D9B				;$008345	 |\ If we are not at bowser there are a few extra
	LSR					;$008348	 | | Items we still need to process otherwise
	BCC .skip_bowser			;$008349	 |/ We can finish off NMI
	LDA.w $0DAE				;$00834B	 |\ Set the screen brightness from $0DAE
	STA.w $2100				;$00834E	 |/
	LDA.w $0D9F				;$008351	 |\ Enable HDMA channels
	STA.w $420C				;$008354	 |/
	LDA.b #$81				;$008357	 | Enable NMI and autojoy
	JMP mode_7_scroll			;$008359	 | Set the mode 7 scroll values -- statusbar unused
.skip_bowser					;		 |
	LDY.b #$24				;$00835C	 | Load the VTimer trigger
	BIT.w $0D9B				;$00835E	 |\ If we are running in the platform boss mode
	BVC .skip_vtimer_change			;$008361	 |/ skip to the end of NMI
	LDA.w $13FC				;$008363	 |\ If we are fighting Morton or Roy
	ASL					;$008366	 | |
	TAX					;$008367	 | |
	LDA.w boss_ceiling_height,X		;$008368	 | | Check against the boss ceiling height
	CMP.b #$2A				;$00836B	 | | Instead of something simple like CMP #$02 : BCC
	BNE .skip_vtimer_change			;$00836D	 |/ Skip the VTimer change
	LDY.b #$2D				;$00836F	 | Load alternative VTimer trigger position
.skip_vtimer_change				;		 |
	JMP .mode_7_NMI_return			;$008371	/ Finish off mode 7 NMI

IRQ_start:					;		\
	SEI					;$008374	 | Disable interrupts to stop interrupting an interrupt
	PHP					;$008375	 |\
	REP #$30				;$008376	 | | Push pretty much everything(except direct page)
	PHA					;$008378	 | | Make sure you push 16 bit values to the stack
	PHX					;$008379	 | |
	PHY					;$00837A	 | |
	PHB					;$00837B	 | |
	PHK					;$00837C	 | | Also set the bank to 00
	PLB					;$00837D	 |/
	SEP #$30				;$00837E	 | 8 bit A/X/Y
	LDA.w $4211				;$008380	 |\ Read the IRQ status flag
	BPL IRQ_return				;$008383	 |/ If the IRQ status flag is not triggered skip IRQ
	LDA.b #$81				;$008385	 | Load NMI enabled, autojoy enabled
	LDY.w $0D9B				;$008387	 |\ If we are in a mode 7 level branch
	BMI mode_7_IRQ				;$00838A	 |/
IRQ_NMI_return:					;		 |
	STA.w $4200				;$00838C	 | Store interrupt enabled flags
	LDY.b #$1F				;$00838F	 |\ wait for H-Blank to occur 
	JSR wait_for_hblank			;$008391	 |/
	LDA $22					;$008394	 |\ Set layer 3 X position
	STA.w $2111				;$008396	 | |
	LDA $23					;$008399	 | |
	STA.w $2111				;$00839B	 |/
	LDA $24					;$00839E	 |\ Set layer 3 Y position
	STA.w $2112				;$0083A0	 | |
	LDA $25					;$0083A3	 | |
	STA.w $2112				;$0083A5	 |/
mode_7_IRQ_return:				;		 |
	LDA $3E					;$0083A8	 |\ Set the BG mode
	STA.w $2105				;$0083AA	 |/
	LDA $40					;$0083AD	 |\ Set any color math settings
	STA.w $2131				;$0083AF	 |/
IRQ_return:					;		 |
	REP #$30				;$0083B2	 |\ Restore everything saved at the beginning of NMI
	PLB					;$0083B4	 | |
	PLY					;$0083B5	 | |
	PLX					;$0083B6	 | |
	PLA					;$0083B7	 | |
	PLP					;$0083B8	 |/
EmptyHandler:					;		 |
	RTI					;$0083B9	/ Return from NMI

mode_7_IRQ:					;		\ 
	BIT.w $0D9B				;$0083DA	 |\ Platform bosses have only one IRQ
	BVC .platform_bosses			;$0083BD	 |/ So skip the differentiation code
	LDY $11					;$0083BF	 |\ If we are in the First IRQ branch
	BEQ .first_IRQ				;$0083C1	 |/
	STA.w $4200				;$0083C3	 | Store Interrupt flags
	LDY.b #$14				;$0083C6	 |\ short wait for HBlank, use a short wait to
	JSR wait_for_hblank			;$0083C8	 |/ account for the JSR of the scroll routine
	JSR mode_7_static_BG_scroll		;$0083CB	 | Set the status bar scroll
	BRA mode_7_IRQ_return			;$0083CE	/

.first_IRQ					;		\ 
	INC $11					;$0083D0	 | Set first IRQ as triggered
	LDA.w $4211				;$0083D2	 | Reread the IRQ flag, this is unneeded
	LDA.b #$AE				;$0083D5	 |\ Offset the V timer based on the layer 1 relative
	SEC					;$0083D7	 | | Y position.
	SBC.w $1888				;$0083D8	 | |
	STA.w $4209				;$0083DB	 | |
	STZ.w $420A				;$0083DE	 |/
	LDA.b #$A1				;$0083E1	 | Load NMI, IRQ, and autojoy enabled
.platform_bosses				;		 |
	LDY.w $1493				;$0083E3	 |\ if the level isn't ending, run mode 7 scrolling
	BEQ mode_7_scroll			;$0083E6	 |/
	LDY.w $1495				;$0083E8	 |\ Also, if the fade timer is less than #$40
	CPY.b #$40				;$0083EB	 | | keep on setting the mode 7 scroll
	BCC mode_7_scroll			;$0083ED	 |/
	LDA.b #$81				;$0083EF	 | Load NMI and autojoy enabled
	BRA IRQ_NMI_return			;$0083F1	/ Finish off mode 7 IRQ

mode_7_scroll:					;		\ 
	STA.w $4200				;$0083F3	 | Store the interrupt flags
	JSR full_wait_for_hblank		;$0083F6	 |\ Wait for the next H-Blank
	NOP					;$0083F9	 | |
	NOP					;$0083FA	 |/
	LDA.b #$07				;$0083FB	 |\ Enable mode 7
	STA.w $2105				;$0083FD	 |/
	LDA $3A					;$008400	 |\ Set layer 1 X position
	STA.w $210D				;$008402	 | |
	LDA $3B					;$008405	 | |
	STA.w $210D				;$008407	 |/
	LDA $3C					;$00840A	 |\ Set layer 1 X position
	STA.w $210E				;$00840C	 | |
	LDA $3D					;$00840F	 | |
	STA.w $210E				;$008411	 |/
	BRA IRQ_return				;$008414	/ Finish off IRQ

mode_7_static_BG_scroll:			;		\ 
	LDA.b #$59				;$008416	 |\ set layer 1 tilemap address to $5800, mirror X
	STA.w $2107				;$008418	 |/
	LDA.b #$07				;$00841B	 |\ set layer 1 base character address to $7000
	STA.w $210B				;$00841D	 |/
	LDA $1A					;$008420	 |\ Set layer 1 X position.
	STA.w $210D				;$008422	 | |
	LDA $1B					;$008425	 | |
	STA.w $210D				;$008427	 |/
	LDA $1C					;$00842A	 |\ Set relative layer 1 Y position.
	CLC					;$00842C	 | |
	ADC.w $1888				;$00842D	 | | Add in the relative amount.
	STA.w $210E				;$008430	 | |
	LDA $1D					;$008433	 | |
	STA.w $210E				;$008435	 |/
	RTS					;$008438	/

full_wait_for_hblank:				;		\ 
	LDY.b #$20				;$008439	 | Use 166 cycle delay
wait_for_hblank:				;		 |
	BIT.w $4212				;$00843B	 |\ Wait for HBlank to occur
	BVS full_wait_for_hblank		;$00843E	 |/ Only use the full delay if HBlank already passed
.wait_for_hblank_end				;		 |
	BIT.w $4212				;$008440	 |\ Wait for HBlank to end so we can wait for the next
	BVC .wait_for_hblank_end		;$008443	 |/
.waste_scanline					;		 |
	DEY					;$008445	 |\ Wait for the next HBlank (minus 6 cycles)
	BNE .waste_scanline			;$008446	 |/ Remember taken branches cost 3 cycles.
	RTS					;$008448	/

DMA_OAM:					;		\ 
	STZ.w $4300				;$008449	 | DMA mode 0 (p)
	REP #$20				;$00844C	 | 16 bit A
	STZ.w $2102				;$00844E	 | Set OAM address to 00
	LDA.w #$0004				;$008451	 |\ Set DMA destination to $2104
	STA.w $4301				;$008454	 |/ Set DMA source low byte to #$00
	LDA.w #$0002				;$008457	 |\ Set DMA source to $000200
	STA.w $4303				;$00845A	 |/
	LDA.w #$0220				;$00845D	 |\ Transfer #$0220 bytes
	STA.w $4305				;$008460	 |/
	LDY.b #$01				;$008463	 |\ Run DMA channel 0
	STY.w $420B				;$008465	 |/
	SEP #$20				;$008468	 | 8 bit A
	LDA.b #$80				;$00846A	 |\ Enable sprite rotation priority
	STA.w $2103				;$00846C	 |/
	LDA $3F					;$00846F	 |\ Set OAM rotation address
	STA.w $2102				;$008471	 |/
	RTS					;$008474	/ Finished with OAM DMA

DATA_008475:
	db $00,$00,$08,$00,$10,$00,$18,$00
	db $20,$00,$28,$00,$30,$00,$38,$00
	db $40,$00,$48,$00,$50,$00,$58,$00
	db $60,$00,$68,$00,$70,$00,$78

CODE_008494:
	LDY.b #$1E
CODE_008496:
	LDX.w DATA_008475,Y
	LDA.w $0423,X				;$008499	|
	ASL					;$00849C	|
	ASL					;$00849D	|
	ORA.w $0422,X				;$00849E	|
	ASL					;$0084A1	|
	ASL					;$0084A2	|
	ORA.w $0421,X				;$0084A3	|
	ASL					;$0084A6	|
	ASL					;$0084A7	|
	ORA.w $0420,X				;$0084A8	|
	STA.w $0400,Y				;$0084AB	|
	LDA.w $0427,X				;$0084AE	|
	ASL					;$0084B1	|
	ASL					;$0084B2	|
	ORA.w $0426,X				;$0084B3	|
	ASL					;$0084B6	|
	ASL					;$0084B7	|
	ORA.w $0425,X				;$0084B8	|
	ASL					;$0084BB	|
	ASL					;$0084BC	|
	ORA.w $0424,X				;$0084BD	|
	STA.w $0401,Y				;$0084C0	|
	DEY					;$0084C3	|
	DEY					;$0084C4	|
	BPL CODE_008496				;$0084C5	|
	RTS					;$0084C7	|

load_stripe_image:				;		\ 
	PHB					;$0084C8	 |\ Set data bank to $00
	PHK					;$0084C9	 | |
	PLB					;$0084CA	 |/
	JSR _load_stripe_image_			;$0084CB	 | Upload the stripe image
	PLB					;$0084CE	 | Restore bank
	RTL					;$0084CF	/ Done with stripe image uploading

stripe_images:
	dl $7F837D				;		|$7F837D
	dl DATA_05B375				;		|$05B375
	dl DATA_04A400				;		|$04A400
	dl DATA_05B0FF				;		|$05B0FF
	dl DATA_05B91C				;		|$05B91C
	dl DATA_0CB800				;		|$0CB800
	dl DATA_05B872				;		|$05B872
	dl DATA_04819F				;		|$04819F
	dl DATA_0481E0				;		|$0481E0
	dl DATA_04F499				;		|$04F499
	dl DATA_05B8C7				;		|$05B8C7
	dl DATA_0CBFF1				;		|$0CBFF1
	dl DATA_0CBFC3				;		|$0CBFC3
	dl DATA_0CBF8E				;		|$0CBF8E
	dl DATA_0CBF59				;		|$0CBF59
	dl DATA_0CBF24				;		|$0CBF24
	dl DATA_0CBEEF				;		|$0CBEEF
	dl DATA_0CBEBA				;		|$0CBEBA
	dl DATA_0CBE85				;		|$0CBE85
	dl DATA_0CC165				;		|$0CC165
	dl DATA_0CC130				;		|$0CC130
	dl DATA_0CC0FB				;		|$0CC0FB
	dl DATA_0CC0C6				;		|$0CC0C6
	dl DATA_0CC091				;		|$0CC091
	dl DATA_0CC05C				;		|$0CC05C
	dl DATA_0CC027				;		|$0CC027
	dl DATA_0CBFF2				;		|$0CBFF2
	dl DATA_0CBFF1				;		|$0CBFF1
	dl DATA_0CC2CE				;		|$0CC2CE
	dl DATA_0CC299				;		|$0CC299
	dl DATA_0CC264				;		|$0CC264
	dl DATA_0CC22F				;		|$0CC22F
	dl DATA_0CC1FA				;		|$0CC1FA
	dl DATA_0CC1C5				;		|$0CC1C5
	dl DATA_0CC190				;		|$0CC190
	dl DATA_0CC46C				;		|$0CC46C
	dl DATA_0CC437				;		|$0CC437
	dl DATA_0CC402				;		|$0CC402
	dl DATA_0CC3CD				;		|$0CC3CD
	dl DATA_0CC398				;		|$0CC398
	dl DATA_0CC363				;		|$0CC363
	dl DATA_0CC32E				;		|$0CC32E
	dl DATA_0CC2F9				;		|$0CC2F9
	dl DATA_0CBFF1				;		|$0CBFF1
	dl DATA_0CC5DD				;		|$0CC5DD
	dl DATA_0CC5A8				;		|$0CC5A8
	dl DATA_0CC573				;		|$0CC573
	dl DATA_0CC53E				;		|$0CC53E
	dl DATA_0CC509				;		|$0CC509
	dl DATA_0CC4D4				;		|$0CC4D4
	dl DATA_0CC49F				;		|$0CC49F
	dl DATA_0CC785				;		|$0CC785
	dl DATA_0CC750				;		|$0CC750
	dl DATA_0CC71B				;		|$0CC71B
	dl DATA_0CC6E6				;		|$0CC6E6
	dl DATA_0CC6B1				;		|$0CC6B1
	dl DATA_0CC67C				;		|$0CC67C
	dl DATA_0CC647				;		|$0CC647
	dl DATA_0CC612				;		|$0CC612
	dl DATA_0CC92D				;		|$0CC92D
	dl DATA_0CC8F8				;		|$0CC8F8
	dl DATA_0CC8C3				;		|$0CC8C3
	dl DATA_0CC88E				;		|$0CC88E
	dl DATA_0CC859				;		|$0CC859
	dl DATA_0CC824				;		|$0CC824
	dl DATA_0CC7EF				;		|$0CC7EF
	dl DATA_0CC7BA				;		|$0CC7BA
	dl DATA_0CBA56				;		|$0CBA56
	dl DATA_0CBBB9				;		|$0CBBB9
	dl DATA_0CB9BF				;		|$0CB9BF
	dl DATA_0C9380				;		|$0C9380
	dl DATA_0CB636				;		|$0CB636
	dl DATA_0DF300				;		|$0DF300
	dl DATA_0DF42D				;		|$0DF42D
	dl DATA_0DF572				;		|$0DF572
	dl DATA_0DF66B				;		|$0DF66B
	dl DATA_0DF742				;		|$0DF742
	dl DATA_0DF837				;		|$0DF837
	dl DATA_0DF8FA				;		|$0DF8FA
	dl DATA_0DF9CD				;		|$0DF9CD
	dl DATA_0DFA98				;		|$0DFA98
	dl DATA_0DFB73				;		|$0DFB73
	dl DATA_0DFC58				;		|$0DFC58
	dl DATA_0DFCD5				;		|$0DFCD5
	dl DATA_0DFD5C				;		|$0DFD5C
	dl DATA_0CBD02				;		|$0CBD02

_load_stripe_image_:				;		\
	LDY $12					;$0085D2	 | Load the stripe index pointer
	LDA.w stripe_images,Y			;$0085D4	 |\ Load and store the low byte
	STA $00					;$0085D7	 |/
	LDA.w stripe_images+1,Y			;$0085D9	 |\ Load and store the high byte
	STA $01					;$0085DC	 |/
	LDA.w stripe_images+2,Y			;$0085DE	 |\ Load and store the bank byte
	STA $02					;$0085E1	 |/
	JSR DMA_stripe_image			;$0085E3	 | DMA the actual stripe image
	LDA $12					;$0085E6	 |
	BNE .skip_RAM_clear			;$0085E8	 |
	STA.l $7F837B				;$0085EA	 |\ Set the stripe RAM index to #$0000
	STA.l $7F837C				;$0085EE	 |/
	DEC A					;$0085F2	 |\ Set as "end of data"
	STA.l $7F837D				;$0085F3	 |/
.skip_RAM_clear					;		 |
	STZ $12					;$0085F7	 | Clear the stripe index
	RTS					;$0085F9	/ Done loading stripe image data

CODE_0085FA:
	JSR TurnOffIO
	LDA.b #$FC				;$0085FD	|
	STA $00					;$0085FF	|
	STZ.w $2115				;$008601	|
	STZ.w $2116				;$008604	|
	LDA.b #$50				;$008607	|
	STA.w $2117				;$008609	|
	LDX.b #$06				;$00860C	|
CODE_00860E:
	LDA.w DATA_008649,X
	STA.w $4310,X				;$008611	|
	DEX					;$008614	|
	BPL CODE_00860E				;$008615	|
	LDY.b #$02				;$008617	|
	STY.w $420B				;$008619	|
	LDA.b #$38				;$00861C	|
	STA $00					;$00861E	|
	LDA.b #$80				;$008620	|
	STA.w $2115				;$008622	|
	STZ.w $2116				;$008625	|
	LDA.b #$50				;$008628	|
	STA.w $2117				;$00862A	|
	LDX.b #$06				;$00862D	|
CODE_00862F:
	LDA.w DATA_008649,X
	STA.w $4310,X				;$008632	|
	DEX					;$008635	|
	BPL CODE_00862F				;$008636	|
	LDA.b #$19				;$008638	|
	STA.w $4311				;$00863A	|
	STY.w $420B				;$00863D	|
	STZ $3F					;$008640	|
	JSL $7F8000				;$008642	|
	JMP DMA_OAM				;$008646	|

DATA_008649:
	db $08,$18,$00,$00,$00,$00,$10

update_controllers:				;		\ 
	LDA.w $4218				;$008650	 |\ Load controller 1 low byte data
	AND.b #$F0				;$008653	 | | Filter out potentially invalid bits
	STA.w $0DA4				;$008655	 | | Store the filtered value in $0DA4 and Y
	TAY					;$008658	 | |
	EOR.w $0DAC				;$008659	 | | Flip any disabled bits off
	AND.w $0DA4				;$00865C	 | | Reset any disabled bits turned on
	STA.w $0DA8				;$00865F	 | | Store controller data
	STY.w $0DAC				;$008662	 |/
	LDA.w $4219				;$008665	 |\ Load controller 1 high byte data
	STA.w $0DA2				;$008668	 | | Store the raw value in $0DA2 and Y
	TAY					;$00866B	 | |
	EOR.w $0DAA				;$00866C	 | | Flip any disabled bits off
	AND.w $0DA2				;$00866F	 | | Reset any disabled bits turned on
	STA.w $0DA6				;$008672	 | | Store controller data
	STY.w $0DAA				;$008675	 |/
	LDA.w $421A				;$008678	 |\ Load controller 2 low byte data
	AND.b #$F0				;$00867B	 | | Filter out potentially invalid bits
	STA.w $0DA5				;$00867D	 | | Store the filtered value in $0DA5 and Y
	TAY					;$008680	 | |
	EOR.w $0DAD				;$008681	 | | Flip any disabled bits off
	AND.w $0DA5				;$008684	 | | Reset any disabled bits turned on
	STA.w $0DA9				;$008687	 | | Store controller data
	STY.w $0DAD				;$00868A	 |/
	LDA.w $421B				;$00868D	 |\ Load controller 2 high byte data
	STA.w $0DA3				;$008690	 | | Store the raw value in $0DA3 and Y
	TAY					;$008693	 | |
	EOR.w $0DAB				;$008694	 | | Flip any disabled bits off
	AND.w $0DA3				;$008697	 | | Reset any disabled bits turned on
	STA.w $0DA7				;$00869A	 | | Store controller data
	STY.w $0DAB				;$00869D	 |/
	LDX.w $0DA0				;$0086A0	 |\ Check for the second controller
	BPL .single_controller			;$0086A3	 |/
	LDX.w $0DB3				;$0086A5	 | Load current player
.single_controller				;		 |
	LDA.w $0DA4,X				;$0086A8	 |\ Update $15 t0 current button press high byte
	AND.b #$C0				;$0086AB	 | | Share bit 6 with X/Y
	ORA.w $0DA2,X				;$0086AD	 | | 
	STA $15					;$0086B0	 |/
	LDA.w $0DA4,X				;$0086B2	 |\ Update $17 to current button press low byte
	STA $17					;$0086B5	 |/
	LDA.w $0DA8,X				;$0086B7	 |\ Update $16 t0 current frame press high byte
	AND.b #$40				;$0086BA	 | | Share bit 6 with X/Y
	ORA.w $0DA6,X				;$0086BC	 | | 
	STA $16					;$0086BF	 |/
	LDA.w $0DA8,X				;$0086C1	 |\ Update $18 to current frame press low byte
	STA $18					;$0086C4	 |/
	RTS					;$0086C6	/

CODE_0086C7:
	REP #$30
	LDX.w #$0062				;$0086C9	|
	LDA.w #$0202				;$0086CC	|
CODE_0086CF:
	STA.w $0420,X
	DEX					;$0086D2	|
	DEX					;$0086D3	|
	BPL CODE_0086CF				;$0086D4	|
	SEP #$30				;$0086D6	|
	LDA.b #$F0				;$0086D8	|
	JSL $7F812E				;$0086DA	|
	RTS					;$0086DE	|

execute_pointer:				;		\ 
	STY $03					;$0086DF	 | Preserve Y
	PLY					;$0086E1	 |\ Pull the high byte and bank byte and store it in $00
	STY $00					;$0086E2	 |/ to create a pointer to the pointer table 
	REP #$30				;$0086E4	 | 16 bit AXY
	AND.w #$00FF				;$0086E6	 | Allow for a maximum of 256 pointers
	ASL					;$0086E9	 |\ Get the pointer table index and store it in Y
	TAY					;$0086EA	 |/
	PLA					;$0086EB	 |\ Pull the high byte and bank byte and store it in $01
	STA $01					;$0086EC	 |/ to create a pointer to the pointer table 
	INY					;$0086EE	 | Increment to the first byte of the pointer table
	LDA [$00],Y				;$0086EF	 | Load the pointer
	STA $00					;$0086F1	 | And store the pointer
	SEP #$30				;$0086F3	 | 8 bit AXY
	LDY $03					;$0086F5	 | Restore Y
	JML [$0000]				;$0086F7	/ Jump to the pointer

execute_pointer_long:				;		\ 
	STY $05					;$0086FA	 | Preserve Y
	PLY					;$0086FC	 |\ Pull the high byte and bank byte and store it in $02
	STY $02					;$0086FD	 |/ to create a pointer to the pointer table 
	REP #$30				;$0086FF	 | 16 bit AXY
	AND.w #$00FF				;$008701	 | Allow for a maximum of 256 pointers
	STA $03					;$008704	 |\ Multiply the pointer by three
	ASL					;$008706	 | |
	ADC $03					;$008707	 | |
	TAY					;$008709	 |/
	PLA					;$00870A	 |\ Pull the high byte and bank byte and store it in $03
	STA $03					;$00870B	 |/ to create a pointer to the pointer table 
	INY					;$00870D	 | Increment to the first byte of the pointer table
	LDA [$02],Y				;$00870E	 |\ Load and store the first two bytes of the pointer
	STA $00					;$008710	 |/ 
	INY					;$008712	 | Move to the next byte in the pointer table
	LDA [$02],Y				;$008713	 |\ Load and store the last byte of the pointer
	STA $01					;$008715	 |/ (Also rereads the high byte)
	SEP #$30				;$008717	 | 8 bit AXY
	LDY $05					;$008719	 | Restore Y
	JML [$0000]				;$00871B	/ Jump to the pointer

DMA_stripe_image:
	REP #$10				;$00871E	\ 16 bit XY
	STA.w $4314				;$008720	 |\ Store DMA source bank
	LDY.w #$0000				;$008723	 |/
.next_block					;		 |
	LDA [$00],Y				;$008726	 |\ Continue while end of data bit not set
	BPL .upload_stripe_block		;$008728	 |/
	SEP #$30				;$00872A	 | 8 bit AXY
	RTS					;$00872C	/ Done with stripe image DMA

.upload_stripe_block				;		\ 
	STA $04					;$00872D	 | preserve the first header byte
	INY					;$00872F	 |\ Load and preserve the second header byte
	LDA [$00],Y				;$008730	 | |
	STA $03					;$008732	 |/
	INY					;$008734	 |\ Load the third header byte
	LDA [$00],Y				;$008735	 |/
	STZ $07					;$008737	 |\ Store bit 7 of the third header byte in $07
	ASL					;$008739	 | |
	ROL $07					;$00873A	 |/
	LDA.b #$18				;$00873C	 |\ Set DMA destination address to $2118
	STA.w $4311				;$00873E	 |/
	LDA [$00],Y				;$008741	 |\ Reload the third header byte
	AND.b #$40				;$008743	 | | Test for and set $05 to the RLE encoding state
	LSR					;$008745	 | |
	LSR					;$008746	 | |
	LSR					;$008747	 | |
	STA $05					;$008748	 |/
	STZ $06					;$00874A	 | Zero out $06 (used for 16 bit access)
	ORA.b #$01				;$00874C	 |\ Set DMA transfer mode to 1 and if the RLE bit
	STA.w $4310				;$00874E	 |/ Set, fixed transfer mode will also be set.
	REP #$20				;$008751	 | 16 bit A
	LDA $03					;$008753	 |\ Load header bytes 1 and 2 (VRAM destination)
	STA.w $2116				;$008755	 |/
	LDA [$00],Y				;$008758	 |\ Load leader bytes 3 and 4
	XBA					;$00875A	 | | Swap the endianess of the bytes
	AND.w #$3FFF				;$00875B	 | | Isolate the "Length" component of the upload
	TAX					;$00875E	 | |
	INX					;$00875F	 |/ And increment the length.
	INY					;$008760	 |\ Move to the actual stripe data
	INY					;$008761	 | |
	TYA					;$008762	 | |
	CLC					;$008763	 | |
	ADC $00					;$008764	 | | Add the current index to the pointer
	STA.w $4312				;$008766	 |/ Store this as the DMA source address
	STX.w $4315				;$008769	 | Store the DMA transfer size
	LDA $05					;$00876C	 |\ If the RLE bit is not set skip the RLE DMA
	BEQ .not_RLE				;$00876E	 |/
	SEP #$20				;$008770	 | 8 bit A
	LDA $07					;$008772	 |\ Set VRAM increment depending on stripe direction
	STA.w $2115				;$008774	 |/
	LDA.b #$02				;$008777	 |\ Start DMA on channel 1 to DMA the first RLE byte
	STA.w $420B				;$008779	 |/
	LDA.b #$19				;$00877C	 |\ Set DMA destination to $2119
	STA.w $4311				;$00877E	 |/
	REP #$21				;$008781	 | 16 bit A and clear carry
	LDA $03					;$008783	 |\ Reset the VRAM destination address
	STA.w $2116				;$008785	 |/
	TYA					;$008788	 |\ Set the new DMA source address
	ADC $00					;$008789	 | |
	INC A					;$00878B	 | |
	STA.w $4312				;$00878C	 |/
	STX.w $4315				;$00878F	 | Reset the number of bytes to transfer
	LDX.w #$0002				;$008792	 | Load "two bytes" to move forward in stripe data
.not_RLE					;		 |
	STX $03					;$008795	 |\ Update the Y index to after the current stripe data
	TYA					;$008797	 | |
	CLC					;$008798	 | |
	ADC $03					;$008799	 | |
	TAY					;$00879B	 |/
	SEP #$20				;$00879C	 | 8 bit A
	LDA $07					;$00879E	 |\ Load the direction for VRAM incrementing setting and
	ORA.b #$80				;$0087A0	 | | Set VRAM increment after $2119
	STA.w $2115				;$0087A2	 |/
	LDA.b #$02				;$0087A5	 |\ Run DMA on channel 1, second RLE byte or non-RLE
	STA.w $420B				;$0087A7	 |/
	JMP .next_block				;$0087AA	/ Continue and read the next block

generic_layer_1_and_2_upload:			;		\ 
	SEP #$30				;$0087AD	 | 8 bit AXY
	LDA.w $1BE4				;$0087AF	 |\ if a kayer 1 VRAM destination is set, 
	BNE .layer_1_direction_check		;$0087B2	 |/ Handle layer 1 tilemap DMA
	JMP .layer_2_upload_check		;$0087B4	/ If not, jump to the layer 2 DMA check

.layer_1_direction_check			;		\ 
	LDA $5B					;$0087B7	 |\ If the layer 1 data is not vertical
	AND.b #$01				;$0087B9	 | | Branch and handle horizontal uploads
	BEQ .horizontal_layer_1_DMA		;$0087BB	 |/
	JMP .vertical_layer_1			;$0087BD	/ Handle vertical layer 1 data (includes OW)

.horizontal_layer_1_DMA				;		\ 
	LDY.b #$81				;$0087C0	 |\ Set VRAM increment after $2119 writes and
	STY.w $2115				;$0087C2	 |/ Set address increment by 32 for "vertical" writes
	LDA.w $1BE5				;$0087C5	 |\ Set the VRAM destination for layer 1 tilemap 
	STA.w $2116				;$0087C8	 | | Left, upper screen 8x8 strip
	LDA.w $1BE4				;$0087CB	 | |
	STA.w $2117				;$0087CE	 |/
	LDX.b #$06				;$0087D1	 | Number of DMA settings to copy
.left_upper_layer_1_DMA_setup			;		 |
	LDA.w .layer_1_DMA_settings_1,X		;$0087D3	 |\ Generic DMA copy loop
	STA.w $4310,X				;$0087D6	 | | Transfer mode: 1, Destination: $2118
	DEX					;$0087D9	 | | source: $001BE6, size: #$0040
	BPL .left_upper_layer_1_DMA_setup	;$0087DA	 |/
	LDA.b #$02				;$0087DC	 |\ Run DMA on channel 1
	STA.w $420B				;$0087DE	 |/
	STY.w $2115				;$0087E1	 | Rewrite VRAM increment and remap setting
	LDA.w $1BE5				;$0087E4	 |\ Write the next VRAM address
	STA.w $2116				;$0087E7	 | | Which is #$0800 bytes higher
	LDA.w $1BE4				;$0087EA	 | | Left, lower screen 8x8 strip
	CLC					;$0087ED	 | |
	ADC.b #$08				;$0087EE	 | |
	STA.w $2117				;$0087F0	 |/
	LDX.b #$06				;$0087F3	 | Number of DMA settings to copy
.left_lower_layer_1_DMA_setup			;		 |
	LDA.w .layer_1_DMA_settings_2,X		;$0087F5	 |\ Generic DMA copy loop
	STA.w $4310,X				;$0087F8	 | | Transfer mode: 1, Destination: $2118
	DEX					;$0087FB	 | | source: $001C26, size: #$002C
	BPL .left_lower_layer_1_DMA_setup	;$0087FC	 |/
	LDA.b #$02				;$0087FE	 |\ Run DMA on channel 1
	STA.w $420B				;$008800	 |/
	STY.w $2115				;$008803	 | Rewrite VRAM increment and remap setting
	LDA.w $1BE5				;$008806	 |\ Write the next VRAM address
	INC A					;$008809	 | | Which is a single byte higher
	STA.w $2116				;$00880A	 | | Right, upper screen 8x8 strip
	LDA.w $1BE4				;$00880D	 | |
	STA.w $2117				;$008810	 |/
	LDX.b #$06				;$008813	 | Number of DMA settings to copy
.right_upper_layer_1_DMA_setup			;		 |
	LDA.w .layer_1_DMA_settings_3,X		;$008815	 |\ Generic DMA copy loop
	STA.w $4310,X				;$008818	 | | Transfer mode: 1, Destination: $2118
	DEX					;$00881B	 | | source: $001C66, size: #$0040
	BPL .right_upper_layer_1_DMA_setup	;$00881C	 |/
	LDA.b #$02				;$00881E	 |\ Run DMA on channel 1
	STA.w $420B				;$008820	 |/
	STY.w $2115				;$008823	 | Rewrite VRAM increment and remap setting
	LDA.w $1BE5				;$008826	 |\ Write the next VRAM address
	INC A					;$008829	 | | Which is #$0801 bytes higher
	STA.w $2116				;$00882A	 | | Right, lower screen 8x8 strip
	LDA.w $1BE4				;$00882D	 | |
	CLC					;$008830	 | |
	ADC.b #$08				;$008831	 | |
	STA.w $2117				;$008833	 |/
	LDX.b #$06				;$008836	 | Number of DMA settings to copy
.right_lower_layer_1_DMA_setup			;		 |
	LDA.w .layer_1_DMA_settings_4,X		;$008838	 |\ Generic DMA copy loop
	STA.w $4310,X				;$00883B	 | | Transfer mode: 1, Destination: $2118
	DEX					;$00883E	 | | source: $001CA6, size: #$002C
	BPL .right_lower_layer_1_DMA_setup	;$00883F	 |/
	LDA.b #$02				;$008841	 |\ Run DMA on channel 1
	STA.w $420B				;$008843	 |/
	JMP .layer_2_upload_check		;$008846	/

.vertical_layer_1				;		\ 
	LDY.b #$80				;$008849	 |\ Set VRAM increment after $2119 writes and
	STY.w $2115				;$00884B	 |/ Set address increment by 1 for "horizontal" writes
	LDA.w $1BE5				;$00884E	 |\ Set the VRAM destination for layer 1 tilemap
	STA.w $2116				;$008851	 | | Lower, left screen 8x8 strip
	LDA.w $1BE4				;$008854	 | |
	STA.w $2117				;$008857	 |/
	LDX.b #$06				;$00885A	 | Number of DMA settings to copy
.lower_left_layer_1_DMA_setup			;		 |
	LDA.w .layer_1_DMA_settings_1,X		;$00885C	 |\ Generic DMA copy loop
	STA.w $4310,X				;$00885F	 | | Transfer mode: 1, Destination: $2118
	DEX					;$008862	 | | source: $001BE6, size: #$0040
	BPL .lower_left_layer_1_DMA_setup	;$008863	 |/
	LDA.b #$02				;$008865	 |\ Run DMA on channel 1
	STA.w $420B				;$008867	 |/
	STY.w $2115				;$00886A	 | Rewrite VRAM increment and remap setting
	LDA.w $1BE5				;$00886D	 |\ Write the next VRAM address
	STA.w $2116				;$008870	 | | Which is #$0400 bytes higher
	LDA.w $1BE4				;$008873	 | | Lower, right screen 8x8 strip
	CLC					;$008876	 | |
	ADC.b #$04				;$008877	 | |
	STA.w $2117				;$008879	 |/
	LDX.b #$06				;$00887C	 | Number of DMA settings to copy
.lower_right_layer_1_DMA_setup			;		 |
	LDA.w .layer_1_DMA_settings_2,X		;$00887E	 |\ Generic DMA copy loop
	STA.w $4310,X				;$008881	 | | Transfer mode: 1, Destination: $2118
	DEX					;$008884	 | | source: $001C26, size: #$002C
	BPL .lower_right_layer_1_DMA_setup	;$008885	 |/
	LDA.b #$40				;$008887	 |\ Change the Transfer size to #$0040
	STA.w $4315				;$008889	 |/ For writing the full vertical data
	LDA.b #$02				;$00888C	 |\ Run DMA on channel 1
	STA.w $420B				;$00888E	 |/
	STY.w $2115				;$008891	 | Rewrite VRAM increment and remap setting
	LDA.w $1BE5				;$008894	 |\ Write the next VRAM address
	CLC					;$008897	 | | Which is #$0020 bytes higher
	ADC.b #$20				;$008898	 | | Upper, left screen 8x8 strip
	STA.w $2116				;$00889A	 | |
	LDA.w $1BE4				;$00889D	 | |
	STA.w $2117				;$0088A0	 |/
	LDX.b #$06				;$0088A3	 | Number of DMA settings to copy
.upper_left_layer_1_DMA_setup				;		 |
	LDA.w .layer_1_DMA_settings_3,X		;$0088A5	 |\ Generic DMA copy loop
	STA.w $4310,X				;$0088A8	 | | Transfer mode: 1, Destination: $2118
	DEX					;$0088AB	 | | source: $001C66, size: #$0040
	BPL .upper_left_layer_1_DMA_setup	;$0088AC	 |/
	LDA.b #$02				;$0088AE	 |\ Run DMA on channel 1
	STA.w $420B				;$0088B0	 |/
	STY.w $2115				;$0088B3	 | Rewrite VRAM increment and remap setting
	LDA.w $1BE5				;$0088B6	 |\ Write the next VRAM address
	CLC					;$0088B9	 | | Which is #$0420 bytes higher
	ADC.b #$20				;$0088BA	 | | Upper, right screen 8x8 strip
	STA.w $2116				;$0088BC	 | |
	LDA.w $1BE4				;$0088BF	 | |
	CLC					;$0088C2	 | |
	ADC.b #$04				;$0088C3	 |/
	STA.w $2117				;$0088C5	 |
	LDX.b #$06				;$0088C8	 | Number of DMA settings to copy
.upper_right_layer_1_DMA_setup			;		 |
	LDA.w .layer_1_DMA_settings_4,X		;$0088CA	 |\ Generic DMA copy loop
	STA.w $4310,X				;$0088CD	 | | Transfer mode: 1, Destination: $2118
	DEX					;$0088D0	 | | source: $001CA6, size: #$002C
	BPL .upper_right_layer_1_DMA_setup	;$0088D1	 |/
	LDA.b #$40				;$0088D3	 |\ Change the Transfer size to #$0040
	STA.w $4315				;$0088D5	 |/ For writing the full vertical data
	LDA.b #$02				;$0088D8	 |\ Run DMA on channel 1
	STA.w $420B				;$0088DA	 |/
.layer_2_upload_check				;		 |
	LDA.b #$00				;$0088DD	 |\ Reset the VRAM upload address
	STA.w $1BE4				;$0088DF	 |/
	LDA.w $1CE6				;$0088E2	 |\ if a kayer 1 VRAM destination is set, 
	BNE .layer_2_direction_check		;$0088E5	 |/ Handle layer 1 tilemap DMA
	JMP .return				;$0088E7	/ No more data to upload, return

.layer_2_direction_check			;		\ 
	LDA $5B					;$0088EA	 |\ If the layer 2 data is not vertical
	AND.b #$02				;$0088EC	 | | Branch and handle horizontal uploads
	BEQ .horizontal_layer_2_DMA		;$0088EE	 |/
	JMP .vertical_layer_2			;$0088F0	/ Handle vertical layer 2 data

.horizontal_layer_2_DMA				;		\ 
	LDY.b #$81				;$0088F3	 |\ Set VRAM increment after $2119 writes and
	STY.w $2115				;$0088F5	 |/ Set address increment by 32 for "vertical" writes
	LDA.w $1CE7				;$0088F8	 |\ Set the VRAM destination for layer 2 tilemap 
	STA.w $2116				;$0088FB	 | | Left, upper screen 8x8 strip
	LDA.w $1CE6				;$0088FE	 | |
	STA.w $2117				;$008901	 |/
	LDX.b #$06				;$008904	 | Number of DMA settings to copy Number of DMA settings to copy
.left_upper_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_1,X		;$008906	 |\ Generic DMA copy loop
	STA.w $4310,X				;$008909	 | | Transfer mode: 1, Destination: $2118
	DEX					;$00890C	 | | source: $001CE8, size: #$0040
	BPL .left_upper_layer_2_DMA_setup	;$00890D	 |/
	LDA.b #$02				;$00890F	 |\ Run DMA on channel 1
	STA.w $420B				;$008911	 |/
	STY.w $2115				;$008914	 | Rewrite VRAM increment and remap setting
	LDA.w $1CE7				;$008917	 |\ Write the next VRAM address
	STA.w $2116				;$00891A	 | | Which is #$0800 bytes higher
	LDA.w $1CE6				;$00891D	 | | Left, lower screen 8x8 strip
	CLC					;$008920	 | |
	ADC.b #$08				;$008921	 | |
	STA.w $2117				;$008923	 |/
	LDX.b #$06				;$008926	 | Number of DMA settings to copy
.left_lower_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_2,X		;$008928	 |\ Generic DMA copy loop
	STA.w $4310,X				;$00892B	 | | Transfer mode: 1, Destination: $2118
	DEX					;$00892E	 | | source: $001D28, size: #$002C
	BPL .left_lower_layer_2_DMA_setup	;$00892F	 |/
	LDA.b #$02				;$008931	 |\ Run DMA on channel 1
	STA.w $420B				;$008933	 |/
	STY.w $2115				;$008936	 | Rewrite VRAM increment and remap setting
	LDA.w $1CE7				;$008939	 |\ Write the next VRAM address
	INC A					;$00893C	 | | Which is a single byte higher
	STA.w $2116				;$00893D	 | | Right, upper screen 8x8 strip
	LDA.w $1CE6				;$008940	 | |
	STA.w $2117				;$008943	 |/
	LDX.b #$06				;$008946	 | Number of DMA settings to copy
.right_upper_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_3,X		;$008848	 |\ Generic DMA copy loop
	STA.w $4310,X				;$00894B	 | | Transfer mode: 1, Destination: $2118
	DEX					;$00894E	 | | source: $001D68, size: #$0040
	BPL .right_upper_layer_2_DMA_setup	;$00894F	 |/
	LDA.b #$02				;$008951	 |\ Run DMA on channel 1
	STA.w $420B				;$008953	 |/
	STY.w $2115				;$008956	 | Rewrite VRAM increment and remap setting
	LDA.w $1CE7				;$008959	 |\ Write the next VRAM address
	INC A					;$00895C	 | | Which is #$0801 bytes higher
	STA.w $2116				;$00895D	 | | Right, lower screen 8x8 strip
	LDA.w $1CE6				;$008960	 | |
	CLC					;$008963	 | |
	ADC.b #$08				;$008964	 | |
	STA.w $2117				;$008966	 |/
	LDX.b #$06				;$008969	 | Number of DMA settings to copy
.right_lower_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_4,X		;$00896B	 |\ Generic DMA copy loop
	STA.w $4310,X				;$00896E	 | | Transfer mode: 1, Destination: $2118
	DEX					;$008971	 | | source: $001DA8, size: #$002C
	BPL .right_lower_layer_2_DMA_setup	;$008972	 |/
	LDA.b #$02				;$008974	 |\ Run DMA on channel 1
	STA.w $420B				;$008976	 |/
	JMP .return				;$008979	/

.vertical_layer_2				;		\ 
	LDY.b #$80				;$00897C	 |\ Set VRAM increment after $2119 writes and
	STY.w $2115				;$00897E	 |/ Set address increment by 1 for "horizontal" writes
	LDA.w $1CE7				;$008981	 |\ Set the VRAM destination for layer 2 tilemap
	STA.w $2116				;$008984	 | | Lower, left screen 8x8 strip
	LDA.w $1CE6				;$008987	 | |
	STA.w $2117				;$00898A	 |/
	LDX.b #$06				;$00898D	 | Number of DMA settings to copy
.lower_left_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_1,X		;$00898F	 |\ Generic DMA copy loop
	STA.w $4310,X				;$008992	 | | Transfer mode: 1, Destination: $2118
	DEX					;$008995	 | | source: $001CE8, size: #$0040
	BPL .lower_left_layer_2_DMA_setup	;$008996	 |/
	LDA.b #$02				;$008998	 |\ Run DMA on channel 1
	STA.w $420B				;$00899A	 |/
	STY.w $2115				;$00899D	 | Rewrite VRAM increment and remap setting
	LDA.w $1CE7				;$0089A0	 |\ Write the next VRAM address
	STA.w $2116				;$0089A3	 | | Which is #$0400 bytes higher
	LDA.w $1CE6				;$0089A6	 | | Lower, right screen 8x8 strip
	CLC					;$0089A9	 | |
	ADC.b #$04				;$0089AA	 | |
	STA.w $2117				;$0089AC	 |/
	LDX.b #$06				;$0089AF	 | Number of DMA settings to copy
.lower_right_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_2,X		;$0089B1	 |\ Generic DMA copy loop
	STA.w $4310,X				;$0089B4	 | | Transfer mode: 1, Destination: $2118
	DEX					;$0089B7	 | | source: $001D28, size: #$002C
	BPL .lower_right_layer_2_DMA_setup	;$0089B8	 |/
	LDA.b #$40				;$0089BA	 |\ Change the Transfer size to #$0040
	STA.w $4315				;$0089BC	 |/ For writing the full vertical data
	LDA.b #$02				;$0089BF	 |\ Run DMA on channel 1
	STA.w $420B				;$0089C1	 |/
	STY.w $2115				;$0089C4	 | Rewrite VRAM increment and remap setting
	LDA.w $1CE7				;$0089C7	 |\ Write the next VRAM address
	CLC					;$0089CA	 | | Which is #$0020 bytes higher
	ADC.b #$20				;$0089CB	 | | Upper, left screen 8x8 strip
	STA.w $2116				;$0089CD	 | |
	LDA.w $1CE6				;$0089D0	 | |
	STA.w $2117				;$0089D3	 |/
	LDX.b #$06				;$0089D6	 | Number of DMA settings to copy
.upper_left_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_3,X		;$0089D8	 |\ Generic DMA copy loop
	STA.w $4310,X				;$0089DB	 | | Transfer mode: 1, Destination: $2118
	DEX					;$0089DE	 | | source: $001D68, size: #$0040
	BPL .upper_left_layer_2_DMA_setup	;$0089DF	 |/
	LDA.b #$02				;$0089E1	 |\ Run DMA on channel 1
	STA.w $420B				;$0089E3	 |/
	STY.w $2115				;$0089E6	 | Rewrite VRAM increment and remap setting
	LDA.w $1CE7				;$0089E9	 |\ Write the next VRAM address
	CLC					;$0089EC	 | | Which is #$0420 bytes higher
	ADC.b #$20				;$0089ED	 | | Upper, right screen 8x8 strip
	STA.w $2116				;$0089EF	 | |
	LDA.w $1CE6				;$0089F2	 | |
	CLC					;$0089F5	 | |
	ADC.b #$04				;$0089F6	 |/
	STA.w $2117				;$0089F8	 |
	LDX.b #$06				;$0089FB	 | Number of DMA settings to copy
.upper_right_layer_2_DMA_setup			;		 |
	LDA.w .layer_2_DMA_settings_4,X		;$0089FD	 |\ Generic DMA copy loop
	STA.w $4310,X				;$008A00	 | | Transfer mode: 1, Destination: $2118
	DEX					;$008A03	 | | source: $001DA8, size: #$002C
	BPL .upper_right_layer_2_DMA_setup	;$008A04	 |/
	LDA.b #$40				;$008A06	 |\ Change the Transfer size to #$0040
	STA.w $4315				;$008A08	 |/ For writing the full vertical data
	LDA.b #$02				;$008A0B	 |\ Run DMA on channel 1
	STA.w $420B				;$008A0D	 |/
.return						;		 |
	LDA.b #$00				;$008A10	 |\ Reset the VRAM upload address
	STA.w $1CE6				;$008A12	 |/
	RTL					;$008A15	/ Return from generic layer uploader

.layer_1_DMA_settings_1
	db $01,$18,$E6,$1B,$00,$40,$00

.layer_1_DMA_settings_2
	db $01,$18,$26,$1C,$00,$2C,$00

.layer_1_DMA_settings_3
	db $01,$18,$66,$1C,$00,$40,$00

.layer_1_DMA_settings_4
	db $01,$18,$A6,$1C,$00,$2C,$00

.layer_2_DMA_settings_1
	db $01,$18,$E8,$1C,$00,$40,$00

.layer_2_DMA_settings_2
	db $01,$18,$28,$1D,$00,$2C,$00

.layer_2_DMA_settings_3
	db $01,$18,$68,$1D,$00,$40,$00

.layer_2_DMA_settings_4
	db $01,$18,$A8,$1D,$00,$2C,$00

clear_non_stack:
	REP #$30
	LDX.w #$1FFE				;$008A50	|
CODE_008A53:
	STZ $00,X
CODE_008A55:
	DEX
	DEX					;$008A56	|
	CPX.w #$01FF				;$008A57	|
	BPL CODE_008A61				;$008A5A	|
	CPX.w #$0100				;$008A5C	|
	BPL CODE_008A55				;$008A5F	|
CODE_008A61:
	CPX.w #$FFFE
	BNE CODE_008A53				;$008A64	|
	LDA.w #$0000				;$008A66	|
	STA.l $7F837B				;$008A69	|
	STZ.w $0681				;$008A6D	|
	SEP #$30				;$008A70	|
	LDA.b #$FF				;$008A72	|
	STA.l $7F837D				;$008A74	|
	RTS					;$008A78	|

SetUpScreen:
	STZ.w $2133
	STZ.w $2106				;$008A7C	|
	LDA.b #$23				;$008A7F	|
	STA.w $2107				;$008A81	|
	LDA.b #$33				;$008A84	|
	STA.w $2108				;$008A86	|
	LDA.b #$53				;$008A89	|
	STA.w $2109				;$008A8B	|
	LDA.b #$00				;$008A8E	|
	STA.w $210B				;$008A90	|
	LDA.b #$04				;$008A93	|
	STA.w $210C				;$008A95	|
	STZ $41					;$008A98	|
	STZ $42					;$008A9A	|
	STZ $43					;$008A9C	|
	STZ.w $212A				;$008A9E	|
	STZ.w $212B				;$008AA1	|
	STZ.w $212E				;$008AA4	|
	STZ.w $212F				;$008AA7	|
	LDA.b #$02				;$008AAA	|
	STA $44					;$008AAC	|
	LDA.b #$80				;$008AAE	|
	STA.w $211A				;$008AB0	|
	RTS					;$008AB3	|

DATA_008AB4:
	db $00,$00,$FE,$00,$00,$00,$FE,$00
DATA_008ABC:
	db $00,$00,$02,$00,$00,$00,$02,$00
	db $00,$00,$00,$01,$FF,$FF,$00,$10
	db $F0

CODE_008ACD:
	LDA $39
	STA $00					;$008ACF	|
	REP #$30				;$008AD1	|
	JSR CODE_008AE8				;$008AD3	|
	LDA $38					;$008AD6	|
	STA $00					;$008AD8	|
	REP #$30				;$008ADA	|
	LDA $2E					;$008ADC	|
	STA $34					;$008ADE	|
	LDA $30					;$008AE0	|
	EOR.w #$FFFF				;$008AE2	|
	INC A					;$008AE5	|
	STA $32					;$008AE6	|
CODE_008AE8:
	LDA $36
	ASL					;$008AEA	|
	PHA					;$008AEB	|
	XBA					;$008AEC	|
	AND.w #$0003				;$008AED	|
	ASL					;$008AF0	|
	TAY					;$008AF1	|
	PLA					;$008AF2	|
	AND.w #$00FE				;$008AF3	|
	EOR.w DATA_008AB4,Y			;$008AF6	|
	CLC					;$008AF9	|
	ADC.w DATA_008ABC,Y			;$008AFA	|
	TAX					;$008AFD	|
	JSR CODE_008B2B				;$008AFE	|
	CPY.w #$0004				;$008B01	|
	BCC CODE_008B0A				;$008B04	|
	EOR.w #$FFFF				;$008B06	|
	INC A					;$008B09	|
CODE_008B0A:
	STA $30
	TXA					;$008B0C	|
	EOR.w #$00FE				;$008B0D	|
	CLC					;$008B10	|
	ADC.w #$0002				;$008B11	|
	AND.w #$01FF				;$008B14	|
	TAX					;$008B17	|
	JSR CODE_008B2B				;$008B18	|
	DEY					;$008B1B	|
	DEY					;$008B1C	|
	CPY.w #$0004				;$008B1D	|
	BCS CODE_008B26				;$008B20	|
	EOR.w #$FFFF				;$008B22	|
	INC A					;$008B25	|
CODE_008B26:
	STA $2E
	SEP #$30				;$008B28	|
	RTS					;$008B2A	|

CODE_008B2B:
	SEP #$20
	LDA.w DATA_008B58,X			;$008B2D	|
	BEQ CODE_008B34				;$008B30	|
	LDA $00					;$008B32	|
CODE_008B34:
	STA $01
	LDA.w DATA_008B57,X			;$008B36	|
	STA.w $4202				;$008B39	|
	LDA $00					;$008B3C	|
	STA.w $4203				;$008B3E	|
	NOP					;$008B41	|
	NOP					;$008B42	|
	NOP					;$008B43	|
	NOP					;$008B44	|
	LDA.w $4217				;$008B45	|
	CLC					;$008B48	|
	ADC $01					;$008B49	|
	XBA					;$008B4B	|
	LDA.w $4216				;$008B4C	|
	REP #$20				;$008B4F	|
	LSR					;$008B51	|
	LSR					;$008B52	|
	LSR					;$008B53	|
	LSR					;$008B54	|
	LSR					;$008B55	|
	RTS					;$008B56	|

DATA_008B57:
	db $00

DATA_008B58:
	db $00,$03,$00,$06,$00,$09,$00,$0C
	db $00,$0F,$00,$12,$00,$15,$00,$19
	db $00,$1C,$00,$1F,$00,$22,$00,$25
	db $00,$28,$00,$2B,$00,$2E,$00,$31
	db $00,$35,$00,$38,$00,$3B,$00,$3E
	db $00,$41,$00,$44,$00,$47,$00,$4A
	db $00,$4D,$00,$50,$00,$53,$00,$56
	db $00,$59,$00,$5C,$00,$5F,$00,$61
	db $00,$64,$00,$67,$00,$6A,$00,$6D
	db $00,$70,$00,$73,$00,$75,$00,$78
	db $00,$7B,$00,$7E,$00,$80,$00,$83
	db $00,$86,$00,$88,$00,$8B,$00,$8E
	db $00,$90,$00,$93,$00,$95,$00,$98
	db $00,$9B,$00,$9D,$00,$9F,$00,$A2
	db $00,$A4,$00,$A7,$00,$A9,$00,$AB
	db $00,$AE,$00,$B0,$00,$B2,$00,$B5
	db $00,$B7,$00,$B9,$00,$BB,$00,$BD
	db $00,$BF,$00,$C1,$00,$C3,$00,$C5
	db $00,$C7,$00,$C9,$00,$CB,$00,$CD
	db $00,$CF,$00,$D1,$00,$D3,$00,$D4
	db $00,$D6,$00,$D8,$00,$D9,$00,$DB
	db $00,$DD,$00,$DE,$00,$E0,$00,$E1
	db $00,$E3,$00,$E4,$00,$E6,$00,$E7
	db $00,$E8,$00,$EA,$00,$EB,$00,$EC
	db $00,$ED,$00,$EE,$00,$EF,$00,$F1
	db $00,$F2,$00,$F3,$00,$F4,$00,$F4
	db $00,$F5,$00,$F6,$00,$F7,$00,$F8
	db $00,$F9,$00,$F9,$00,$FA,$00,$FB
	db $00,$FB,$00,$FC,$00,$FC,$00,$FD
	db $00,$FD,$00,$FE,$00,$FE,$00,$FE
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $00,$FF,$00,$FF,$00,$FF,$00,$00
	db $01,$B7,$3C,$B7,$BC,$B8,$3C,$B9
	db $3C,$BA,$3C,$BB,$3C,$BA,$3C,$BA
	db $BC,$BC,$3C,$BD,$3C,$BE,$3C,$BF
	db $3C,$C0,$3C,$B7,$BC,$C1,$3C,$B9
	db $3C,$C2,$3C,$C2,$BC,$B7,$3C,$C0
	db $FC,$3A,$38,$3B,$38,$3B,$38,$3A
	db $78

DATA_008C89:
	db $30,$28,$31,$28,$32,$28,$33,$28
	db $34,$28,$FC,$38,$FC,$3C,$FC,$3C
	db $FC,$3C,$FC,$3C,$FC,$38,$FC,$38
	db $4A,$38,$FC,$38,$FC,$38,$4A,$78
	db $FC,$38,$3D,$3C,$3E,$3C,$3F,$3C
	db $FC,$38,$FC,$38,$FC,$38,$2E,$3C
	db $26,$38,$FC,$38,$FC,$38,$00,$38
	db $26,$38,$FC,$38,$00,$38,$FC,$38
	db $FC,$38,$FC,$38,$64,$28,$26,$38
	db $FC,$38,$FC,$38,$FC,$38,$4A,$38
	db $FC,$38,$FC,$38,$4A,$78,$FC,$38
	db $FE,$3C,$FE,$3C,$00,$3C,$FC,$38
	db $FC,$38,$FC,$38,$FC,$38,$FC,$38
	db $FC,$38,$FC,$38,$00,$38,$3A,$B8
	db $3B,$B8,$3B,$B8,$3A,$F8

GM04DoDMA:
	LDA.b #$80
	STA.w $2115				;$008D01	|
	LDA.b #$2E				;$008D04	|
	STA.w $2116				;$008D06	|
	LDA.b #$50				;$008D09	|
	STA.w $2117				;$008D0B	|
	LDX.b #$06				;$008D0E	|
CODE_008D10:
	LDA.w DATA_008D90,X
	STA.w $4310,X				;$008D13	|
	DEX					;$008D16	|
	BPL CODE_008D10				;$008D17	|
	LDA.b #$02				;$008D19	|
	STA.w $420B				;$008D1B	|
	LDA.b #$80				;$008D1E	|
	STA.w $2115				;$008D20	|
	LDA.b #$42				;$008D23	|
	STA.w $2116				;$008D25	|
	LDA.b #$50				;$008D28	|
	STA.w $2117				;$008D2A	|
	LDX.b #$06				;$008D2D	|
CODE_008D2F:
	LDA.w DATA_008D97,X
	STA.w $4310,X				;$008D32	|
	DEX					;$008D35	|
	BPL CODE_008D2F				;$008D36	|
	LDA.b #$02				;$008D38	|
	STA.w $420B				;$008D3A	|
	LDA.b #$80				;$008D3D	|
	STA.w $2115				;$008D3F	|
	LDA.b #$63				;$008D42	|
	STA.w $2116				;$008D44	|
	LDA.b #$50				;$008D47	|
	STA.w $2117				;$008D49	|
	LDX.b #$06				;$008D4C	|
CODE_008D4E:
	LDA.w DATA_008D9E,X
	STA.w $4310,X				;$008D51	|
	DEX					;$008D54	|
	BPL CODE_008D4E				;$008D55	|
	LDA.b #$02				;$008D57	|
	STA.w $420B				;$008D59	|
	LDA.b #$80				;$008D5C	|
	STA.w $2115				;$008D5E	|
	LDA.b #$8E				;$008D61	|
	STA.w $2116				;$008D63	|
	LDA.b #$50				;$008D66	|
	STA.w $2117				;$008D68	|
	LDX.b #$06				;$008D6B	|
CODE_008D6D:
	LDA.w DATA_008DA5,X
	STA.w $4310,X				;$008D70	|
	DEX					;$008D73	|
	BPL CODE_008D6D				;$008D74	|
	LDA.b #$02				;$008D76	|
	STA.w $420B				;$008D78	|
	LDX.b #$36				;$008D7B	|
	LDY.b #$6C				;$008D7D	|
CODE_008D7F:
	LDA.w DATA_008C89,Y
	STA.w $0EF9,X				;$008D82	|
	DEY					;$008D85	|
	DEY					;$008D86	|
	DEX					;$008D87	|
	BPL CODE_008D7F				;$008D88	|
	LDA.b #$28				;$008D8A	|
	STA.w $0F30				;$008D8C	|
	RTS					;$008D8F	|

DATA_008D90:
	db $01,$18,$81,$8C,$00,$08,$00

DATA_008D97:
	db $01,$18,$89,$8C,$00,$38,$00

DATA_008D9E:
	db $01,$18,$C1,$8C,$00,$36,$00

DATA_008DA5:
	db $01,$18,$F7,$8C,$00,$08,$00

draw_status_bar:
	STZ.w $2115
	LDA.b #$42				;$008DAF	|
	STA.w $2116				;$008DB1	|
	LDA.b #$50				;$008DB4	|
	STA.w $2117				;$008DB6	|
	LDX.b #$06				;$008DB9	|
CODE_008DBB:
	LDA.w DMAdata_StBr1,X
	STA.w $4310,X				;$008DBE	|
	DEX					;$008DC1	|
	BPL CODE_008DBB				;$008DC2	|
	LDA.b #$02				;$008DC4	|
	STA.w $420B				;$008DC6	|
	STZ.w $2115				;$008DC9	|
	LDA.b #$63				;$008DCC	|
	STA.w $2116				;$008DCE	|
	LDA.b #$50				;$008DD1	|
	STA.w $2117				;$008DD3	|
	LDX.b #$06				;$008DD6	|
CODE_008DD8:
	LDA.w DMAdata_StBr2,X
	STA.w $4310,X				;$008DDB	|
	DEX					;$008DDE	|
	BPL CODE_008DD8				;$008DDF	|
	LDA.b #$02				;$008DE1	|
	STA.w $420B				;$008DE3	|
	RTS					;$008DE6	|

DMAdata_StBr1:
	db $00,$18,$F9,$0E,$00,$1C,$00

DMAdata_StBr2:
	db $00,$18,$15,$0F,$00,$1B,$00

DATA_008DF5:
	db $40,$41,$42,$43

DATA_008DF9:
	db $44,$24,$26,$48,$0E

DATA_008DFE:
	db $00,$02,$04

DATA_008E01:
	db $02,$08,$0A,$00,$04

DATA_008E06:
	db $B7

DATA_008E07:
	db $C3,$B8,$B9,$BA,$BB,$BA,$BF,$BC
	db $BD,$BE,$BF,$C0,$C3,$C1,$B9,$C2
	db $C4,$B7,$C5

CODE_008E1A:
	LDA.w $1493
	ORA $9D					;$008E1D	|
	BNE CODE_008E6F				;$008E1F	|
	LDA.w $0D9B				;$008E21	|
	CMP.b #$C1				;$008E24	|
	BEQ CODE_008E6F				;$008E26	|
	DEC.w $0F30				;$008E28	|
	BPL CODE_008E6F				;$008E2B	|
	LDA.b #$28				;$008E2D	|
	STA.w $0F30				;$008E2F	|
	LDA.w $0F31				;$008E32	|
	ORA.w $0F32				;$008E35	|
	ORA.w $0F33				;$008E38	|
	BEQ CODE_008E6F				;$008E3B	|
	LDX.b #$02				;$008E3D	|
CODE_008E3F:
	DEC.w $0F31,X
	BPL CODE_008E4C				;$008E42	|
	LDA.b #$09				;$008E44	|
	STA.w $0F31,X				;$008E46	|
	DEX					;$008E49	|
	BPL CODE_008E3F				;$008E4A	|
CODE_008E4C:
	LDA.w $0F31
	BNE CODE_008E60				;$008E4F	|
	LDA.w $0F32				;$008E51	|
	AND.w $0F33				;$008E54	|
	CMP.b #$09				;$008E57	|
	BNE CODE_008E60				;$008E59	|
	LDA.b #$FF				;$008E5B	|
	STA.w $1DF9				;$008E5D	|
CODE_008E60:
	LDA.w $0F31
	ORA.w $0F32				;$008E63	|
	ORA.w $0F33				;$008E66	|
	BNE CODE_008E6F				;$008E69	|
	JSL kill_player				;$008E6B	|
CODE_008E6F:
	LDA.w $0F31
	STA.w $0F25				;$008E72	|
	LDA.w $0F32				;$008E75	|
	STA.w $0F26				;$008E78	|
	LDA.w $0F33				;$008E7B	|
	STA.w $0F27				;$008E7E	|
	LDX.b #$10				;$008E81	|
	LDY.b #$00				;$008E83	|
CODE_008E85:
	LDA.w $0F31,Y
	BNE CODE_008E95				;$008E88	|
	LDA.b #$FC				;$008E8A	|
	STA.w $0F15,X				;$008E8C	|
	INY					;$008E8F	|
	INX					;$008E90	|
	CPY.b #$02				;$008E91	|
	BNE CODE_008E85				;$008E93	|
CODE_008E95:
	LDX.b #$03
CODE_008E97:
	LDA.w $0F36,X
	STA $00					;$008E9A	|
	STZ $01					;$008E9C	|
	REP #$20				;$008E9E	|
	LDA.w $0F34,X				;$008EA0	|
	SEC					;$008EA3	|
	SBC.w #$423F				;$008EA4	|
	LDA $00					;$008EA7	|
	SBC.w #$000F				;$008EA9	|
	BCC CODE_008EBF				;$008EAC	|
	SEP #$20				;$008EAE	|
	LDA.b #$0F				;$008EB0	|
	STA.w $0F36,X				;$008EB2	|
	LDA.b #$42				;$008EB5	|
	STA.w $0F35,X				;$008EB7	|
	LDA.b #$3F				;$008EBA	|
	STA.w $0F34,X				;$008EBC	|
CODE_008EBF:
	SEP #$20
	DEX					;$008EC1	|
	DEX					;$008EC2	|
	DEX					;$008EC3	|
	BPL CODE_008E97				;$008EC4	|
	LDA.w $0F36				;$008EC6	|
	STA $00					;$008EC9	|
	STZ $01					;$008ECB	|
	LDA.w $0F35				;$008ECD	|
	STA $03					;$008ED0	|
	LDA.w $0F34				;$008ED2	|
	STA $02					;$008ED5	|
	LDX.b #$14				;$008ED7	|
	LDY.b #$00				;$008ED9	|
	JSR CODE_009012				;$008EDB	|
	LDX.b #$00				;$008EDE	|
CODE_008EE0:
	LDA.w $0F29,X
	BNE CODE_008EEF				;$008EE3	|
	LDA.b #$FC				;$008EE5	|
	STA.w $0F29,X				;$008EE7	|
	INX					;$008EEA	|
	CPX.b #$06				;$008EEB	|
	BNE CODE_008EE0				;$008EED	|
CODE_008EEF:
	LDA.w $0DB3
	BEQ CODE_008F1D				;$008EF2	|
	LDA.w $0F39				;$008EF4	|
	STA $00					;$008EF7	|
	STZ $01					;$008EF9	|
	LDA.w $0F38				;$008EFB	|
	STA $03					;$008EFE	|
	LDA.w $0F37				;$008F00	|
	STA $02					;$008F03	|
	LDX.b #$14				;$008F05	|
	LDY.b #$00				;$008F07	|
	JSR CODE_009012				;$008F09	|
	LDX.b #$00				;$008F0C	|
CODE_008F0E:
	LDA.w $0F29,X
	BNE CODE_008F1D				;$008F11	|
	LDA.b #$FC				;$008F13	|
	STA.w $0F29,X				;$008F15	|
	INX					;$008F18	|
	CPX.b #$06				;$008F19	|
	BNE CODE_008F0E				;$008F1B	|
CODE_008F1D:
	LDA.w $13CC
	BEQ CODE_008F3B				;$008F20	|
	DEC.w $13CC				;$008F22	|
	INC.w $0DBF				;$008F25	|
	LDA.w $0DBF				;$008F28	|
	CMP.b #$64				;$008F2B	|
	BCC CODE_008F3B				;$008F2D	|
	INC.w $18E4				;$008F2F	|
	LDA.w $0DBF				;$008F32	|
	SEC					;$008F35	|
	SBC.b #$64				;$008F36	|
	STA.w $0DBF				;$008F38	|
CODE_008F3B:
	LDA.w $0DBE
	BMI CODE_008F49				;$008F3E	|
	CMP.b #$62				;$008F40	|
	BCC CODE_008F49				;$008F42	|
	LDA.b #$62				;$008F44	|
	STA.w $0DBE				;$008F46	|
CODE_008F49:
	LDA.w $0DBE
	INC A					;$008F4C	|
	JSR HexToDec				;$008F4D	|
	TXY					;$008F50	|
	BNE CODE_008F55				;$008F51	|
	LDX.b #$FC				;$008F53	|
CODE_008F55:
	STX.w $0F16
	STA.w $0F17				;$008F58	|
	LDX.w $0DB3				;$008F5B	|
	LDA.w $0F48,X				;$008F5E	|
	CMP.b #$64				;$008F61	|
	BCC CODE_008F73				;$008F63	|
	LDA.b #$FF				;$008F65	|
	STA.w $1425				;$008F67	|
	LDA.w $0F48,X				;$008F6A	|
	SEC					;$008F6D	|
	SBC.b #$64				;$008F6E	|
	STA.w $0F48,X				;$008F70	|
CODE_008F73:
	LDA.w $0DBF
	JSR HexToDec				;$008F76	|
	TXY					;$008F79	|
	BNE CODE_008F7E				;$008F7A	|
	LDX.b #$FC				;$008F7C	|
CODE_008F7E:
	STA.w $0F14
	STX.w $0F13				;$008F81	|
	SEP #$20				;$008F84	|
	LDX.w $0DB3				;$008F86	|
	STZ $00					;$008F89	|
	STZ $01					;$008F8B	|
	STZ $03					;$008F8D	|
	LDA.w $0F48,X				;$008F8F	|
	STA $02					;$008F92	|
	LDX.b #$09				;$008F94	|
	LDY.b #$10				;$008F96	|
	JSR CODE_009051				;$008F98	|
	LDX.b #$00				;$008F9B	|
CODE_008F9D:
	LDA.w $0F1E,X
	BNE CODE_008FAF				;$008FA0	|
	LDA.b #$FC				;$008FA2	|
	STA.w $0F1E,X				;$008FA4	|
	STA.w $0F03,X				;$008FA7	|
	INX					;$008FAA	|
	CPX.b #$01				;$008FAB	|
	BNE CODE_008F9D				;$008FAD	|
CODE_008FAF:
	LDA.w $0F1E,X
	ASL					;$008FB2	|
	TAY					;$008FB3	|
	LDA.w DATA_008E06,Y			;$008FB4	|
	STA.w $0F03,X				;$008FB7	|
	LDA.w DATA_008E07,Y			;$008FBA	|
	STA.w $0F1E,X				;$008FBD	|
	INX					;$008FC0	|
	CPX.b #$02				;$008FC1	|
	BNE CODE_008FAF				;$008FC3	|
	JSR CODE_009079				;$008FC5	|
	LDA.w $0DB3				;$008FC8	|
	BEQ CODE_008FD8				;$008FCB	|
	LDX.b #$04				;$008FCD	|
CODE_008FCF:
	LDA.w DATA_008DF5,X
	STA.w $0EF9,X				;$008FD2	|
	DEX					;$008FD5	|
	BPL CODE_008FCF				;$008FD6	|
CODE_008FD8:
	LDA.w $1422
	CMP.b #$05				;$008FDB	|
	BCC CODE_008FE1				;$008FDD	|
	LDA.b #$00				;$008FDF	|
CODE_008FE1:
	DEC A
	STA $00					;$008FE2	|
	LDX.b #$00				;$008FE4	|
CODE_008FE6:
	LDY.b #$FC
	LDA $00					;$008FE8	|
	BMI CODE_008FEE				;$008FEA	|
	LDY.b #$2E				;$008FEC	|
CODE_008FEE:
	TYA
	STA.w $0EFF,X				;$008FEF	|
	DEC $00					;$008FF2	|
	INX					;$008FF4	|
	CPX.b #$04				;$008FF5	|
	BNE CODE_008FE6				;$008FF7	|
	RTS					;$008FF9	|

DATA_008FFA:
	db $01,$00

DATA_008FFC:
	db $A0,$86,$00,$00,$10,$27,$00,$00
	db $E8,$03,$00,$00,$64,$00,$00,$00
	db $0A,$00,$00,$00,$01,$00

CODE_009012:
	SEP #$20
	STZ.w $0F15,X				;$009014	|
CODE_009017:
	REP #$20
	LDA $02					;$009019	|
	SEC					;$00901B	|
	SBC.w DATA_008FFC,Y			;$00901C	|
	STA $06					;$00901F	|
	LDA $00					;$009021	|
	SBC.w DATA_008FFA,Y			;$009023	|
	STA $04					;$009026	|
	BCC CODE_009039				;$009028	|
	LDA $06					;$00902A	|
	STA $02					;$00902C	|
	LDA $04					;$00902E	|
	STA $00					;$009030	|
	SEP #$20				;$009032	|
	INC.w $0F15,X				;$009034	|
	BRA CODE_009017				;$009037	|

CODE_009039:
	INX
	INY					;$00903A	|
	INY					;$00903B	|
	INY					;$00903C	|
	INY					;$00903D	|
	CPY.b #$18				;$00903E	|
	BNE CODE_009012				;$009040	|
	SEP #$20				;$009042	|
	RTS					;$009044	|

HexToDec:
	LDX.b #$00
CODE_009047:
	CMP.b #$0A
	BCC Return009050			;$009049	|
	SBC.b #$0A				;$00904B	|
	INX					;$00904D	|
	BRA CODE_009047				;$00904E	|

Return009050:
	RTS

CODE_009051:
	SEP #$20
	STZ.w $0F15,X				;$009053	|
CODE_009056:
	REP #$20
	LDA $02					;$009058	|
	SEC					;$00905A	|
	SBC.w DATA_008FFC,Y			;$00905B	|
	STA $06					;$00905E	|
	BCC CODE_00906D				;$009060	|
	LDA $06					;$009062	|
	STA $02					;$009064	|
	SEP #$20				;$009066	|
	INC.w $0F15,X				;$009068	|
	BRA CODE_009056				;$00906B	|

CODE_00906D:
	INX
	INY					;$00906E	|
	INY					;$00906F	|
	INY					;$009070	|
	INY					;$009071	|
	CPY.b #$18				;$009072	|
	BNE CODE_009051				;$009074	|
	SEP #$20				;$009076	|
	RTS					;$009078	|

CODE_009079:
	LDY.b #$E0
	BIT.w $0D9B				;$00907B	|
	BVC CODE_00908E				;$00907E	|
	LDY.b #$00				;$009080	|
	LDA.w $0D9B				;$009082	|
	CMP.b #$C1				;$009085	|
	BEQ CODE_00908E				;$009087	|
	LDA.b #$F0				;$009089	|
	STA.w $0201,Y				;$00908B	|
CODE_00908E:
	STY $01
	LDY.w $0DC2				;$009090	|
	BEQ Return0090D0			;$009093	|
	LDA.w DATA_008E01,Y			;$009095	|
	STA $00					;$009098	|
	CPY.b #$03				;$00909A	|
	BNE CODE_0090AB				;$00909C	|
	LDA $13					;$00909E	|
	LSR					;$0090A0	|
	AND.b #$03				;$0090A1	|
	PHY					;$0090A3	|
	TAY					;$0090A4	|
	LDA.w DATA_008DFE,Y			;$0090A5	|
	PLY					;$0090A8	|
	STA $00					;$0090A9	|
CODE_0090AB:
	LDY $01
	LDA.b #$78				;$0090AD	|
	STA.w $0200,Y				;$0090AF	|
	LDA.b #$0F				;$0090B2	|
	STA.w $0201,Y				;$0090B4	|
	LDA.b #$30				;$0090B7	|
	ORA $00					;$0090B9	|
	STA.w $0203,Y				;$0090BB	|
	LDX.w $0DC2				;$0090BE	|
	LDA.w DATA_008DF9,X			;$0090C1	|
	STA.w $0202,Y				;$0090C4	|
	TYA					;$0090C7	|
	LSR					;$0090C8	|
	LSR					;$0090C9	|
	TAY					;$0090CA	|
	LDA.b #$02				;$0090CB	|
	STA.w $0420,Y				;$0090CD	|
Return0090D0:
	RTS

DATA_0090D1:
	db $00,$FF,$4D,$4C,$03,$4D,$5D,$FF
	db $03,$00,$4C,$03,$04,$15,$00,$02
	db $00,$4A,$4E,$FF,$4C,$4B,$4A,$03
	db $5F,$05,$04,$03,$02,$00,$FF,$01
	db $4A,$5F,$05,$04,$00,$4D,$5D,$03
	db $02,$01,$00,$FF,$5B,$14,$5F,$01
	db $5E,$FF,$FF,$FF

DATA_009105:
	db $10,$FF,$00,$5C,$13,$00,$5D,$FF
	db $03,$00,$5C,$13,$14,$15,$00,$12
	db $00,$03,$5E,$FF,$5C,$4B,$5A,$03
	db $5F,$05,$14,$13,$12,$10,$FF,$11
	db $03,$5F,$05,$14,$00,$00,$5D,$03
	db $12,$11,$10,$FF,$5B,$01,$5F,$01
	db $5E,$FF,$FF,$FF

DATA_009139:
	db $34,$00,$34,$34,$34,$34,$30,$00
	db $34,$34,$34,$34,$74,$34,$34,$34
	db $34,$34,$34,$00,$34,$34,$34,$34
	db $34,$34,$34,$34,$34,$34,$00,$34
	db $34,$34,$34,$34,$34,$34,$34,$34
	db $34,$34,$34,$34,$34,$34,$34,$34
	db $34

DATA_00916A:
	db $34,$00,$B4,$34,$34,$B4,$F0,$00
	db $B4,$B4,$34,$34,$74,$B4,$B4,$34
	db $B4,$B4,$34,$00,$34,$B4,$34,$B4
	db $B4,$B4,$34,$34,$34,$34,$00,$34
	db $B4,$B4,$B4,$34,$B4,$B4,$B4,$B4
	db $34,$34,$34,$34,$F4,$B4,$F4,$B4
	db $B4

CODE_00919B:
	LDA $71
	CMP.b #$0A				;$00919D	|
	BNE CODE_0091A6				;$00919F	|
	JSR CODE_00C593				;$0091A1	|
	BRA Return0091B0			;$0091A4	|

CODE_0091A6:
	LDA.w $141A
	BNE Return0091B0			;$0091A9	|
	LDA.b #$1E				;$0091AB	|
	STA.w $0DC0				;$0091AD	|
Return0091B0:
	RTS

CODE_0091B1:
	JSR CODE_00A82D
	LDX.b #$00				;$0091B4	|
	LDA.b #$B0				;$0091B6	|
	LDY.w $1425				;$0091B8	|
	BEQ CODE_0091CA				;$0091BB	|
	STZ.w $0F31				;$0091BD	|
	STZ.w $0F32				;$0091C0	|
	STZ.w $0F33				;$0091C3	|
	LDX.b #$26				;$0091C6	|
	LDA.b #$A4				;$0091C8	|
CODE_0091CA:
	STA $00
	STZ $01					;$0091CC	|
	LDY.b #$70				;$0091CE	|
CODE_0091D0:
	JSR CODE_0091E9
	INX					;$0091D3	|
	CPX.b #$08				;$0091D4	|
	BNE CODE_0091DF				;$0091D6	|
	LDA.w $0DB3				;$0091D8	|
	BEQ CODE_0091DF				;$0091DB	|
	LDX.b #$0E				;$0091DD	|
CODE_0091DF:
	TYA
	SEC					;$0091E0	|
	SBC.b #$08				;$0091E1	|
	TAY					;$0091E3	|
	BNE CODE_0091D0				;$0091E4	|
	JMP CODE_008494				;$0091E6	|

CODE_0091E9:
	LDA.w DATA_009139,X
	STA.w $030B,Y				;$0091EC	|
	LDA.w DATA_00916A,X			;$0091EF	|
	STA.w $030F,Y				;$0091F2	|
	LDA $00					;$0091F5	|
	STA.w $0308,Y				;$0091F7	|
	STA.w $030C,Y				;$0091FA	|
	SEC					;$0091FD	|
	SBC.b #$08				;$0091FE	|
	STA $00					;$009200	|
	BCS CODE_009206				;$009202	|
	DEC $01					;$009204	|
CODE_009206:
	PHY
	TYA					;$009207	|
	LSR					;$009208	|
	LSR					;$009209	|
	TAY					;$00920A	|
	LDA $01					;$00920B	|
	AND.b #$01				;$00920D	|
	STA.w $0462,Y				;$00920F	|
	STA.w $0463,Y				;$009212	|
	PLY					;$009215	|
	LDA.w DATA_0090D1,X			;$009216	|
	BMI Return00922E			;$009219	|
	STA.w $030A,Y				;$00921B	|
	LDA.w DATA_009105,X			;$00921E	|
	STA.w $030E,Y				;$009221	|
	LDA.b #$68				;$009224	|
	STA.w $0309,Y				;$009226	|
	LDA.b #$70				;$009229	|
	STA.w $030D,Y				;$00922B	|
Return00922E:
	RTS

CODE_00922F:
	STZ.w $0703
	STZ.w $0704				;$009232	|
	STZ.w $2121				;$009235	|
	LDX.b #$06				;$009238	|
CODE_00923A:
	LDA.w DATA_009249,X
	STA.w $4320,X				;$00923D	|
	DEX					;$009240	|
	BPL CODE_00923A				;$009241	|
	LDA.b #$04				;$009243	|
	STA.w $420B				;$009245	|
	RTS					;$009248	|

DATA_009249:
	db $00,$22,$03,$07,$00,$00,$02

setup_window_HDMA:
	LDX.b #$04				;$009250	\ Index for DMA set up
.loop						;                |\ Upload to $4374 to $4370
	LDA.w window_HDMA_settings,X		;$009252	 | |
	STA.w $4370,X				;$009255	 | |
	DEX					;$009258	 | |
	BPL .loop				;$009259	 |/
	LDA.b #$00				;$00925B	 |\ HDMA Data bank $00
	STA.w $4377				;$00925D	 |/
DisableHDMA:					;                |
	STZ.w $0D9F				;$009260	 | Disable HDMA
clear_window_HDMA:				;                |
	REP #$10				;$009263	 | 16 bit x/y
	LDX.w #$01BE				;$009265	 |\
	LDA.b #$FF				;$009268	 | | Initialize the HDMA table to FF00
.loop						;                | |
	STA.w $04A0,X				;$00926A	 | |
	STZ.w $04A1,X				;$00926D	 | |
	DEX					;$009270	 | |
	DEX					;$009271	 | |
	BPL .loop				;$009272	 |/
	SEP #$10				;$009274	 | 8 bit x/y
	RTS					;$009276	/

window_HDMA_settings:
	db $41,$26
	dl window_HDMA_data

window_HDMA_data:
	db $F0
	dw $04A0
	db $F0
	dw $0580
	db $00

CODE_009283:
	JSR clear_window_HDMA
	LDA.w $0D9B				;$009286	|
	LSR					;$009289	|
	BCS CODE_0092A0				;$00928A	|
	REP #$10				;$00928C	|
	LDX.w #$01BE				;$00928E	|
WindowHDMAenable:
	STZ.w $04A0,X
	LDA.b #$FF				;$009294	|
	STA.w $04A1,X				;$009296	|
	INX					;$009299	|
	INX					;$00929A	|
	CPX.w #$01C0				;$00929B	|
	BCC WindowHDMAenable			;$00929E	|
CODE_0092A0:
	LDA.b #$80
	STA.w $0D9F				;$0092A2	|
	SEP #$10				;$0092A5	|
	RTS					;$0092A7	|

CODE_0092A8:
	JSR clear_window_HDMA
	REP #$10				;$0092AB	|
	LDX.w #$0198				;$0092AD	|
	BRA WindowHDMAenable			;$0092B0	|

CODE_0092B2:
	LDA.b #$58
	STA.w $04A0				;$0092B4	|
	STA.w $04AA				;$0092B7	|
	STA.w $04B4				;$0092BA	|
	STZ.w $04A9				;$0092BD	|
	STZ.w $04B3				;$0092C0	|
	STZ.w $04BD				;$0092C3	|
	LDX.b #$04				;$0092C6	|
CODE_0092C8:
	LDA.w DATA_009313,X
	STA.w $4350,X				;$0092CB	|
	LDA.w DATA_009318,X			;$0092CE	|
	STA.w $4360,X				;$0092D1	|
	LDA.w DATA_00931D,X			;$0092D4	|
	STA.w $4370,X				;$0092D7	|
	DEX					;$0092DA	|
	BPL CODE_0092C8				;$0092DB	|
	LDA.b #$00				;$0092DD	|
	STA.w $4357				;$0092DF	|
	STA.w $4367				;$0092E2	|
	STA.w $4377				;$0092E5	|
	LDA.b #$E0				;$0092E8	|
	STA.w $0D9F				;$0092EA	|
CODE_0092ED:
	REP #$30
	LDY.w #$0008				;$0092EF	|
	LDX.w #$0014				;$0092F2	|
CODE_0092F5:
	LDA.w $001A,y
	STA.w $04A1,X				;$0092F8	|
	STA.w $04A4,X				;$0092FB	|
	LDA.w $1462,Y				;$0092FE	|
	STA.w $04A7,X				;$009301	|
	TXA					;$009304	|
	SEC					;$009305	|
	SBC.w #$000A				;$009306	|
	TAX					;$009309	|
	DEY					;$00930A	|
	DEY					;$00930B	|
	DEY					;$00930C	|
	DEY					;$00930D	|
	BPL CODE_0092F5				;$00930E	|
	SEP #$30				;$009310	|
	RTS					;$009312	|

DATA_009313:
	db $02,$0D,$A0,$04,$00

DATA_009318:
	db $02,$0F,$AA,$04,$00

DATA_00931D:
	db $02,$11,$B4,$04,$00

run_game_mode:
	LDA.w $0100
	JSL execute_pointer			;$009325	|

Ptrs009329:
	dw CODE_009391
	dw CODE_00940F
	dw CODE_009F6F
	dw CODE_0096AE
	dw CODE_009A8B
	dw CODE_009F6F
	dw CODE_00941B
	dw GAMEMODE_07
	dw CODE_009CD1
	dw CODE_009B1A
	dw CODE_009DFA
	dw CODE_009F6F
	dw CODE_00A087
	dw CODE_009F6F
	dw CODE_00A1BE
	dw TmpFade
	dw CODE_00968E
	dw CODE_0096D5
	dw GM04Load
	dw TmpFade
	dw CODE_00A1DA
	dw CODE_009F6F
	dw CODE_009750
	dw CODE_009759
	dw CODE_009F6F
	dw CODE_009468
	dw CODE_009F6F
	dw CODE_0094FD
	dw CODE_009F6F
	dw CODE_009583
	dw CODE_009F6F
	dw CODE_0095AB
	dw CODE_009F6F
	dw CODE_0095BC
	dw CODE_009F6F
	dw CODE_0095C1
	dw CODE_009F6F
	dw CODE_00962C
	dw CODE_009F6F
	dw CODE_00963D
	dw CODE_009F7C
	dw Return00968D

TurnOffIO:
	STZ.w $4200
	STZ.w $420C				;$009380	|
	LDA.b #$80				;$009383	|
	STA.w $2100				;$009385	|
	RTS					;$009388	|

nintendo_positions:
	db $60,$70,$80,$90

nintendo_tiles:
	db $02,$04,$06,$08

CODE_009391:
	JSR CODE_0085FA
	JSR SetUpScreen				;$009394	|
	JSR CODE_00A993				;$009397	|
	LDY.b #$0C				;$00939A	|
	LDX.b #$03				;$00939C	|
CODE_00939E:
	LDA.w nintendo_positions,X
	STA.w $0200,Y				;$0093A1	|
	LDA.b #$70				;$0093A4	|
	STA.w $0201,Y				;$0093A6	|
	LDA.w nintendo_tiles,X			;$0093A9	|
	STA.w $0202,Y				;$0093AC	|
	LDA.b #$30				;$0093AF	|
	STA.w $0203,Y				;$0093B1	|
	DEY					;$0093B4	|
	DEY					;$0093B5	|
	DEY					;$0093B6	|
	DEY					;$0093B7	|
	DEX					;$0093B8	|
	BPL CODE_00939E				;$0093B9	|
	LDA.b #$AA				;$0093BB	|
	STA.w $0400				;$0093BD	|
	LDA.b #$01				;$0093C0	|
	STA.w $1DFC				;$0093C2	|
	LDA.b #$40				;$0093C5	|
	STA.w $1DF5				;$0093C7	|
CODE_0093CA:
	LDA.b #$0F
	STA.w $0DAE				;$0093CC	|
	LDA.b #$01				;$0093CF	|
	STA.w $0DAF				;$0093D1	|
	STZ.w $192E				;$0093D4	|
	JSR LoadPalette				;$0093D7	|
	STZ.w $0701				;$0093DA	|
	STZ.w $0702				;$0093DD	|
	JSR CODE_00922F				;$0093E0	|
	STZ.w $1B92				;$0093E3	|
	LDX.b #$10				;$0093E6	|
	LDY.b #$04				;$0093E8	|
CODE_0093EA:
	LDA.b #$01
	STA.w $0D9B				;$0093EC	|
	LDA.b #$20				;$0093EF	|
	JSR ScreenSettings			;$0093F1	|
CODE_0093F4:
	INC.w $0100
Mode04Finish:
	LDA.b #$81
	STA.w $4200				;$0093F9	|
	RTS					;$0093FC	|

ScreenSettings:
	STA.w $2131
	STA $40					;$009400	|
	STX.w $212C				;$009402	|
	STY.w $212D				;$009405	|
	STZ.w $212E				;$009408	|
	STZ.w $212F				;$00940B	|
	RTS					;$00940E	|

CODE_00940F:
	DEC.w $1DF5
	BNE Return00941A			;$009412	|
	JSR CODE_00B888				;$009414	|
CODE_009417:
	INC.w $0100
Return00941A:
	RTS

CODE_00941B:
	JSR SetUp0DA0GM4
	JSR CODE_009CBE				;$00941E	|
	BEQ CODE_00942E				;$009421	|
	LDA.b #$EC				;$009423	|
	JSR CODE_009440				;$009425	|
	INC.w $0100				;$009428	|
	JMP CODE_009C9F				;$00942B	|

CODE_00942E:
	DEC.w $1DF5
	BNE Return00941A			;$009431	|
	INC.w $1DF5				;$009433	|
	LDA.w $1433				;$009436	|
	CLC					;$009439	|
	ADC.b #$04				;$00943A	|
	CMP.b #$F0				;$00943C	|
	BCS CODE_009417				;$00943E	|
CODE_009440:
	STA.w $1433
CODE_009443:
	JSR CODE_00CA61
	LDA.b #$80				;$009446	|
	STA $00					;$009448	|
	LDA.b #$70				;$00944A	|
	STA $01					;$00944C	|
	JMP CODE_00CA88				;$00944E	|

CutsceneBgColor:
	db $02,$00,$04,$01,$00,$06,$04

CutsceneCastlePal:
	db $03,$06,$05,$06,$03,$03,$06,$06
DATA_009460:
	db $03,$FF,$FF,$C9,$0F,$FF,$CC,$C9

CODE_009468:
	JSR CODE_0085FA
	JSR Clear_1A_13D3			;$00946B	|
	JSR SetUpScreen				;$00946E	|
	LDX.w $13C6				;$009471	|
	LDA.b #$18				;$009474	|
	STA.w $1931				;$009476	|
	LDA.b #$14				;$009479	|
	STA.w $192B				;$00947B	|
	LDA.w CutsceneBgColor-1,X		;$00947E	|
	STA.w $192F				;$009481	|
	LDA.w CutsceneCastlePal,X		;$009484	|
	STA.w $1930				;$009487	|
	STZ.w $192E				;$00948A	|
	LDA.b #$01				;$00948D	|
	STA.w $192D				;$00948F	|
	CPX.b #$08				;$009492	|
	BNE CODE_0094B2				;$009494	|
	JSR CODE_00955E				;$009496	|
	LDA.b #$D2				;$009499	|
	STA $12					;$00949B	|
	JSR _load_stripe_image_			;$00949D	|
	JSR upload_music_bank_3			;$0094A0	|
	JSL CODE_0C93DD				;$0094A3	|
	JSR DisableHDMA				;$0094A7	|
	INC.w $1931				;$0094AA	|
	INC.w $192B				;$0094AD	|
	BRA CODE_0094D7				;$0094B0	|

CODE_0094B2:
	LDA.b #$15
	STA.w $1DFB				;$0094B4	|
	LDA.w DATA_009460,X			;$0094B7	|
	STA $12					;$0094BA	|
	JSR _load_stripe_image_			;$0094BC	|
	LDA.b #$CF				;$0094BF	|
	STA $12					;$0094C1	|
	JSR _load_stripe_image_			;$0094C3	|
	REP #$20				;$0094C6	|
	LDA.w #$0090				;$0094C8	|
	STA $94					;$0094CB	|
	LDA.w #$0058				;$0094CD	|
	STA $96					;$0094D0	|
	SEP #$20				;$0094D2	|
	INC.w $148F				;$0094D4	|
CODE_0094D7:
	JSR UploadSpriteGFX
	JSR LoadPalette				;$0094DA	|
	JSR CODE_00922F				;$0094DD	|
	LDX.b #$0B				;$0094E0	|
CODE_0094E2:
	STZ $1A,X
	DEX					;$0094E4	|
	BPL CODE_0094E2				;$0094E5	|
	LDA.b #$20				;$0094E7	|
	STA $64					;$0094E9	|
	JSR CODE_00A635				;$0094EB	|
	STZ $76					;$0094EE	|
	STZ $72					;$0094F0	|
	JSL set_player_pose			;$0094F2	|
	LDX.b #$17				;$0094F6	|
	LDY.b #$00				;$0094F8	|
	JSR CODE_009622				;$0094FA	|
CODE_0094FD:
	JSL $7F8000
	LDA.w $13C6				;$009501	|
	CMP.b #$08				;$009504	|
	BEQ CODE_009557				;$009506	|
	LDA $17					;$009508	|
	AND.b #$00				;$00950A	|
	CMP.b #$30				;$00950C	|
	BNE CODE_009529				;$00950E	|
	LDA $15					;$009510	|
	AND.b #$08				;$009512	|
	BEQ ADDR_009523				;$009514	|
	LDA.w $13C6				;$009516	|
	INC A					;$009519	|
	CMP.b #$09				;$00951A	|
	BCC ADDR_009520				;$00951C	|
	LDA.b #$01				;$00951E	|
ADDR_009520:
	STA.w $13C6
ADDR_009523:
	LDA.b #$18
	STA.w $0100				;$009525	|
	RTS					;$009528	|

CODE_009529:
	JSL CODE_0CC97E
	REP #$20				;$00952D	|
	LDA $1A					;$00952F	|
	PHA					;$009531	|
	LDA $1C					;$009532	|
	PHA					;$009534	|
	LDA $1E					;$009535	|
	STA $1A					;$009537	|
	LDA $20					;$009539	|
	STA $1C					;$00953B	|
	SEP #$20				;$00953D	|
	JSL CODE_00E2BD				;$00953F	|
	REP #$20				;$009543	|
	PLA					;$009545	|
	STA $1C					;$009546	|
	PLA					;$009548	|
	STA $1A					;$009549	|
	SEP #$20				;$00954B	|
	LDA.b #$0C				;$00954D	|
	STA $71					;$00954F	|
	JSR CODE_00C47E				;$009551	|
	JMP CODE_008494				;$009554	|

CODE_009557:
	JSL CODE_0C938D
	JMP CODE_008494				;$00955B	|

CODE_00955E:
	LDY.b #$2F
	JSL CODE_00BA28				;$009560	|
	LDA.b #$80				;$009564	|
	STA.w $2115				;$009566	|
	REP #$30				;$009569	|
	LDA.w #$4600				;$00956B	|
	STA.w $2116				;$00956E	|
	LDX.w #$0200				;$009571	|
CODE_009574:
	LDA [$00]
	STA.w $2118				;$009576	|
	INC $00					;$009579	|
	INC $00					;$00957B	|
	DEX					;$00957D	|
	BNE CODE_009574				;$00957E	|
	SEP #$30				;$009580	|
	RTS					;$009582	|

CODE_009583:
	INC.w $13C6
	LDA.b #$28				;$009586	|
	LDY.b #$01				;$009588	|
	JSR CODE_0096CF				;$00958A	|
	DEC.w $0100				;$00958D	|
	LDA.b #$16				;$009590	|
	STA.w $192B				;$009592	|
	JSR GM04Load				;$009595	|
	DEC.w $0100				;$009598	|
	JSR TurnOffIO				;$00959B	|
	JSR CODE_0085FA				;$00959E	|
	JSR CODE_00A993				;$0095A1	|
	JSL CODE_0CA3C9				;$0095A4	|
	JSR CODE_00961E				;$0095A8	|
CODE_0095AB:
	JSL $7F8000
	JSL CODE_0C939A				;$0095AF	|
	INC $14					;$0095B3	|
	JSL CODE_05BB39				;$0095B5	|
	JMP CODE_008494				;$0095B9	|

CODE_0095BC:
	JSL CODE_0C93AD
	RTS					;$0095C0	|

CODE_0095C1:
	JSR CODE_0085FA
	JSR Clear_1A_13D3			;$0095C4	|
	JSR SetUpScreen				;$0095C7	|
	JSL CODE_0CAD8C				;$0095CA	|
	JSL CODE_05801E				;$0095CE	|
	LDA.w $1DE9				;$0095D2	|
	CMP.b #$0A				;$0095D5	|
	BNE CODE_0095E0				;$0095D7	|
	LDA.b #$13				;$0095D9	|
	STA.w $192B				;$0095DB	|
	BRA CODE_0095E9				;$0095DE	|

CODE_0095E0:
	CMP.b #$0C
	BNE CODE_0095E9				;$0095E2	|
	LDA.b #$17				;$0095E4	|
	STA.w $192B				;$0095E6	|
CODE_0095E9:
	JSR UploadSpriteGFX
	JSR LoadPalette				;$0095EC	|
	JSL CODE_05809E				;$0095EF	|
	JSR CODE_00A5F9				;$0095F3	|
	JSL CODE_0CADF6				;$0095F6	|
	LDA.w $1DE9				;$0095FA	|
	CMP.b #$0C				;$0095FD	|
	BNE CODE_009612				;$0095FF	|
	LDX.b #$0B				;$009601	|
CODE_009603:
	LDA.w BowserEndPalette,X
	STA.w $0807,X				;$009606	|
	LDA.w DATA_00B3CC,X			;$009609	|
	STA.w $0827,X				;$00960C	|
	DEX					;$00960F	|
	BPL CODE_009603				;$009610	|
CODE_009612:
	JSR CODE_00922F
	JSR CODE_0092B2				;$009615	|
	JSR _load_stripe_image_			;$009618	|
	JSR CODE_00962C				;$00961B	|
CODE_00961E:
	LDX.b #$15
	LDY.b #$02				;$009620	|
CODE_009622:
	JSR KeepModeActive
	LDA.b #$09				;$009625	|
	STA $3E					;$009627	|
	JMP CODE_0093EA				;$009629	|

CODE_00962C:
	STZ.w $0D84
	JSR CODE_0092ED				;$00962F	|
	JSL $7F8000				;$009632	|
	JSL CODE_0C93A5				;$009636	|
	JMP CODE_008494				;$00963A	|

CODE_00963D:
	JSR CODE_0085FA
	JSR Clear_1A_13D3			;$009640	|
	JSR SetUpScreen				;$009643	|
	JSR CODE_00955E				;$009646	|
	LDA.b #$19				;$009649	|
	STA.w $192B				;$00964B	|
	LDA.b #$03				;$00964E	|
	STA.w $192F				;$009650	|
	LDA.b #$03				;$009653	|
	STA.w $1930				;$009655	|
	JSR UploadSpriteGFX			;$009658	|
	JSR LoadPalette				;$00965B	|
	LDX.b #$0B				;$00965E	|
CODE_009660:
	LDA.w TheEndPalettes,X
	STA.w $08A7,X				;$009663	|
	LDA.w DATA_00B71A,X			;$009666	|
	STA.w $08C7,X				;$009669	|
	LDA.w DATA_00B726,X			;$00966C	|
	STA.w $08E7,X				;$00966F	|
	DEX					;$009672	|
	BPL CODE_009660				;$009673	|
	JSR CODE_00922F				;$009675	|
	LDA.b #$D5				;$009678	|
	STA $12					;$00967A	|
	JSR _load_stripe_image_			;$00967C	|
	JSL CODE_0CAADF				;$00967F	|
	JSR CODE_008494				;$009683	|
	LDX.b #$14				;$009686	|
	LDY.b #$00				;$009688	|
	JMP CODE_009622				;$00968A	|

Return00968D:
	RTS

CODE_00968E:
	JSR CODE_0085FA
	LDA.w $1425				;$009691	|
	BNE CODE_0096A8				;$009694	|
	LDA.w $141A				;$009696	|
	ORA.w $141D				;$009699	|
	ORA.w $0109				;$00969C	|
	BNE CODE_0096AB				;$00969F	|
	LDA.w $13C1				;$0096A1	|
	CMP.b #$56				;$0096A4	|
	BEQ CODE_0096AB				;$0096A6	|
CODE_0096A8:
	JSR CODE_0091B1
CODE_0096AB:
	JMP CODE_0093CA

CODE_0096AE:
	STZ.w $4200
	JSR clear_non_stack			;$0096B1	|
	LDX.b #$07				;$0096B4	|
	LDA.b #$FF				;$0096B6	|
CODE_0096B8:
	STA.w $0101,X
	DEX					;$0096BB	|
	BPL CODE_0096B8				;$0096BC	|
	LDA.w $0109				;$0096BE	|
	BNE CODE_0096CB				;$0096C1	|
	JSR upload_music_bank_1			;$0096C3	|
	LDA.b #$01				;$0096C6	|
	STA.w $1DFB				;$0096C8	|
CODE_0096CB:
	LDA.b #$EB
	LDY.b #$00				;$0096CD	|
CODE_0096CF:
	STA.w $0109
	STY.w $1F11				;$0096D2	|
CODE_0096D5:
	STZ.w $4200
	JSR disable_controls			;$0096D8	|
	LDA.w $141A				;$0096DB	|
	BNE CODE_0096E9				;$0096DE	|
	LDA.w $141D				;$0096E0	|
	BEQ CODE_0096E9				;$0096E3	|
	JSL CODE_04DC09				;$0096E5	|
CODE_0096E9:
	STZ.w $13D5
	STZ.w $13D9				;$0096EC	|
	LDA.b #$50				;$0096EF	|
	STA.w $13D6				;$0096F1	|
	JSL CODE_05D796				;$0096F4	|
	LDX.b #$07				;$0096F8	|
CODE_0096FA:
	LDA $1A,X
	STA.w $1462,X				;$0096FC	|
	DEX					;$0096FF	|
	BPL CODE_0096FA				;$009700	|
	JSR upload_level_music			;$009702	|
	JSR CODE_00A635				;$009705	|
	LDA.b #$20				;$009708	|
	STA $5E					;$00970A	|
	JSR CODE_00A796				;$00970C	|
	INC.w $1404				;$00970F	|
	JSL CODE_00F6DB				;$009712	|
	JSL CODE_05801E				;$009716	|
	LDA.w $0109				;$00971A	|
	BEQ CODE_009728				;$00971D	|
	CMP.b #$E9				;$00971F	|
	BNE CODE_009740				;$009721	|
	LDA.b #$13				;$009723	|
	STA.w $0DDA				;$009725	|
CODE_009728:
	LDA.w $0DDA
	CMP.b #$40				;$00972B	|
	BCS CODE_00973B				;$00972D	|
	LDY.w $0D9B				;$00972F	|
	CPY.b #$C1				;$009732	|
	BNE CODE_009738				;$009734	|
	LDA.b #$16				;$009736	|
CODE_009738:
	STA.w $1DFB
CODE_00973B:
	AND.b #$BF
	STA.w $0DDA				;$00973D	|
CODE_009740:
	STZ.w $0DAE
	STZ.w $0DAF				;$009743	|
	INC.w $0100				;$009746	|
	JMP Mode04Finish			;$009749	|

CODE_00974C:
	JSR HexToDec
	RTL					;$00974F	|

CODE_009750:
	JSR CODE_0085FA
	JSR CODE_00A82D				;$009753	|
	JMP CODE_0093CA				;$009756	|

CODE_009759:
	JSL $7F8000
	LDA.w $143C				;$00975D	|
	BNE CODE_00978B				;$009760	|
	DEC.w $143D				;$009762	|
	BNE CODE_00978E				;$009765	|
	LDA.w $0DBE				;$009767	|
	BPL CODE_009788				;$00976A	|
	STZ.w $0DC1				;$00976C	|
	LDA.w $0DB4				;$00976F	|
	ORA.w $0DB5				;$009772	|
	BPL CODE_009788				;$009775	|
	LDX.b #$0C				;$009777	|
CODE_009779:
	STZ.w $1F2F,X
	STZ.w $0006,X				;$00977C	|
	STZ.w $1FEE,X				;$00977F	|
	DEX					;$009782	|
	BPL CODE_009779				;$009783	|
	INC.w $13C9				;$009785	|
CODE_009788:
	JMP CODE_009E62

CODE_00978B:
	SEC
	SBC.b #$04				;$00978C	|
CODE_00978E:
	STA.w $143C
	CLC					;$009791	|
	ADC.b #$A0				;$009792	|
	STA $00					;$009794	|
	ROL $01					;$009796	|
	LDX.w $143B				;$009798	|
	LDY.b #$48				;$00979B	|
CODE_00979D:
	CPY.b #$28
	BNE CODE_0097AE				;$00979F	|
	LDA.b #$78				;$0097A1	|
	SEC					;$0097A3	|
	SBC.w $143C				;$0097A4	|
	STA $00					;$0097A7	|
	ROL					;$0097A9	|
	EOR.b #$01				;$0097AA	|
	STA $01					;$0097AC	|
CODE_0097AE:
	JSR CODE_0091E9
	INX					;$0097B1	|
	TYA					;$0097B2	|
	SEC					;$0097B3	|
	SBC.b #$08				;$0097B4	|
	TAY					;$0097B6	|
	BNE CODE_00979D				;$0097B7	|
	JMP CODE_008494				;$0097B9	|

CODE_0097BC:
	LDA.b #$0F
	STA.w $0DAE				;$0097BE	|
	STZ.w $0DB0				;$0097C1	|
	JSR GMPPMosaic				;$0097C4	|
	LDA.b #$20				;$0097C7	|
	STA $38					;$0097C9	|
	STA $39					;$0097CB	|
	STZ.w $1888				;$0097CD	|
	JSR CODE_0085FA				;$0097D0	|
	LDA.b #$FF				;$0097D3	|
	STA.w $1931				;$0097D5	|
	JSL CODE_03D958				;$0097D8	|
	BIT.w $0D9B				;$0097DC	|
	BVC CODE_009801				;$0097DF	|
	JSR CODE_009925				;$0097E1	|
	LDY.w $13FC				;$0097E4	|
	CPY.b #$03				;$0097E7	|
	BCC CODE_0097F1				;$0097E9	|
	BNE CODE_00983B				;$0097EB	|
	LDA.b #$18				;$0097ED	|
	BRA CODE_0097FC				;$0097EF	|

CODE_0097F1:
	LDA.b #$03
	STA.w $13F9				;$0097F3	|
	LDA.b #$C8				;$0097F6	|
	STA $3F					;$0097F8	|
	LDA.b #$12				;$0097FA	|
CODE_0097FC:
	DEC.w $1931
	BRA CODE_00983D				;$0097FF	|

CODE_009801:
	JSR CODE_00ADD9
	JSR CODE_0092A8				;$009804	|
	LDX.b #$50				;$009807	|
	JSR CODE_009A3D				;$009809	|
	REP #$20				;$00980C	|
	LDA.w #$0050				;$00980E	|
	STA $94					;$009811	|
	LDA.w #$FFD0				;$009813	|
	STA $96					;$009816	|
	STZ $1A					;$009818	|
	STZ.w $1462				;$00981A	|
	LDA.w #$FF90				;$00981D	|
	STA $1C					;$009820	|
	STA.w $1464				;$009822	|
	LDA.w #$0080				;$009825	|
	STA $2A					;$009828	|
	LDA.w #$0050				;$00982A	|
	STA $2C					;$00982D	|
	LDA.w #$0080				;$00982F	|
	STA $3A					;$009832	|
	LDA.w #$0010				;$009834	|
	STA $3C					;$009837	|
	SEP #$20				;$009839	|
CODE_00983B:
	LDA.b #$13
CODE_00983D:
	STA.w $192B
	JSR UploadSpriteGFX			;$009840	|
	LDA.b #$11				;$009843	|
	STA.w $212E				;$009845	|
	STZ.w $212D				;$009848	|
	STZ.w $212F				;$00984B	|
	LDA.b #$02				;$00984E	|
	STA $41					;$009850	|
	LDA.b #$32				;$009852	|
	STA $43					;$009854	|
	LDA.b #$20				;$009856	|
	STA $44					;$009858	|
	JSR GM04DoDMA				;$00985A	|
	JSR CODE_008ACD				;$00985D	|
CODE_009860:
	JSL CODE_00E2BD
	JSR CODE_00A2F3				;$009864	|
	JSR CODE_00C593				;$009867	|
	STZ $7D					;$00986A	|
	JSL CODE_01808C				;$00986C	|
	JSL $7F8000				;$009870	|
	RTS					;$009874	|

DATA_009875:
	db $01,$00,$FF,$FF,$40,$00,$C0,$01

CODE_00987D:
	JSR CODE_008ACD
	BIT.w $0D9B				;$009880	|
	BVC CODE_009888				;$009883	|
	JMP CODE_009A52				;$009885	|

CODE_009888:
	JSL $7F8000
	JSL CODE_03C0C6				;$00988C	|
	RTS					;$009890	|

mode_7_VRAM_addresses:
	dw $129E,$121E,$119E,$111E
	dw $161E,$159E,$151E,$149E
	dw $141E,$139E,$131E,$169E 

DMA_mode_7_animations:				;		\ 
	LDA.w $0D9B				;$0098A9	 |\ If we are at bowser skip uploading lava tiles
	LSR					;$0098AC	 | |
	BCS .bowser				;$0098AD	 |/
	LDA $14					;$0098AF	 |\ Get the animation index relative
	LSR					;$0098B1	 | | To the frame counter
	LSR					;$0098B2	 | | ($14 >> 2) & #$06
	AND.b #$06				;$0098B3	 | |
	TAX					;$0098B5	 |/
	REP #$20				;$0098B6	 | 16 bit A
	LDY.b #$80				;$0098B8	 |\ Set VRAM increment after writes to $2119
	STY.w $2115				;$0098BA	 |/
	LDA.w #$1801				;$0098BD	 |\ Set DMA transfer mode 1, DMA destination $2118
	STA.w $4320				;$0098C0	 |/
	LDA.w #$7800				;$0098C3	 |\ Set VRAM destination address $7800
	STA.w $2116				;$0098C6	 |/
	LDA.l mode_7_lava_tile_pointers,X	;$0098C9	 |\ Load the lava animation pointer and 
	STA.w $4322				;$0098CD	 |/ Store it to the DMA source
	LDY.b #$7E				;$0098D0	 |\ Set the DMA source bank to $7E
	STY.w $4324				;$0098D2	 |/
	LDA.w #$0080				;$0098D5	 |\ Set the transfer to by #$80 bytes
	STA.w $4325				;$0098D8	 |/
	LDY.b #$04				;$0098DB	 |\ Run DMA on channel 2
	STY.w $420B				;$0098DD	 |/
	CLC					;$0098E0	 | Clear the carry to distinguish bowser from others
.bowser						;		 |
	REP #$20				;$0098E1	 | 16 bit A
	LDA.w #$0004				;$0098E3	 | Number of bytes to transfer per iteration 
	LDY.b #$06				;$0098E6	 | Number of DMA transfers
	BCC .not_bowser				;$0098E8	 | If the carry is clear, we are not at bowser
	LDA.w #$0008				;$0098EA	 | Number of bytes to transfer per iteration
	LDY.b #$16				;$0098ED	 | Number of DMA transfers
.not_bowser					;		 |
	STA $00					;$0098EF	 |
	LDA.w #$C680				;$0098F1	 |\ Store the initial mode 7 tilemap address
	STA $02					;$0098F4	 |/
	STZ.w $2115				;$0098F6	 | Set increment after $2118 writes
	LDA.w #$1800				;$0098F9	 |\ Set DMA transfer mode 0, DMA destination $2118
	STA.w $4320				;$0098FC	 |/
	LDX.b #$7E				;$0098FF	 |\ Set DMA source bank $7E
	STX.w $4324				;$009901	 |/
	LDX.b #$04				;$009904	 | Load DMA channel 2 for all transfers
.upload_loop					;		 |
	LDA.w mode_7_VRAM_addresses,Y		;$009906	 |\ Load and store the target DMA address
	STA.w $2116				;$009909	 |/
	LDA $02					;$00990C	 |\ Load and store the DMA source offset
	STA.w $4322				;$00990E	 |/
	CLC					;$009911	 |\ Add the DMA size to the source offset
	ADC $00					;$009912	 | |
	STA $02					;$009914	 |/
	LDA $00					;$009916	 |\ Load the number of bytes to transfer
	STA.w $4325				;$009918	 |/ #$04 bytes for non-bowser, #$08 bytes for bowser
	STX.w $420B				;$00991B	 | Run DMA on channel 2
	DEY					;$00991E	 |\ Decrement pointer index and loop until 
	DEY					;$00991F	 | | The pointer index is less than zero
	BPL .upload_loop			;$009920	 |/
	SEP #$20				;$009922	 | 8 bit A
	RTS					;$009924	 / Finsihed with mode 7 animated tile DMA

CODE_009925:
	STZ $97
	REP #$20				;$009927	|
	LDA.w #$0020				;$009929	|
	STA $94					;$00992C	|
	STZ $1A					;$00992E	|
	STZ.w $1462				;$009930	|
	STZ $1C					;$009933	|
	STZ.w $1464				;$009935	|
	LDA.w #$0080				;$009938	|
	STA $2A					;$00993B	|
	LDA.w #$00A0				;$00993D	|
	STA $2C					;$009940	|
	SEP #$20				;$009942	|
	JSR CODE_00AE15				;$009944	|
	JSL CODE_01808C				;$009947	|
	LDA.w $0D9B				;$00994B	|
	LSR					;$00994E	|
	LDX.b #$C0				;$00994F	|
	LDA.b #$A0				;$009951	|
	BCC CODE_00995B				;$009953	|
	STZ.w $1411				;$009955	|
	JMP CODE_009A17				;$009958	|

CODE_00995B:
	REP #$30
	LDA.w $13FC				;$00995D	|
	AND.w #$00FF				;$009960	|
	ASL					;$009963	|
	TAX					;$009964	|
	LDY.w #$02C0				;$009965	|
	LDA.w boss_ceiling_height,X		;$009968	|
	BPL CODE_009970				;$00996B	|
	LDY.w #$FB80				;$00996D	|
CODE_009970:
	CMP.w #$0012
	BNE CODE_009978				;$009973	|
	LDY.w #$0320				;$009975	|
CODE_009978:
	STY $00
	LDX.w #$0000				;$00997A	|
	LDA.w #$C05A				;$00997D	|
CODE_009980:
	STA.l $7F837D,X
	XBA					;$009984	|
	CLC					;$009985	|
	ADC.w #$0080				;$009986	|
	XBA					;$009989	|
	STA.l $7F8401,X				;$00998A	|
	XBA					;$00998E	|
	SEC					;$00998F	|
	SBC $00					;$009990	|
	XBA					;$009992	|
	STA.l $7F8485,X				;$009993	|
	LDA.w #$7F00				;$009997	|
	STA.l $7F837F,X				;$00999A	|
	STA.l $7F8403,X				;$00999E	|
	STA.l $7F8487,X				;$0099A2	|
	LDY.w #$0010				;$0099A6	|
CODE_0099A9:
	LDA.w #$38A2
	STA.l $7F8381,X				;$0099AC	|
	INC A					;$0099B0	|
	STA.l $7F8383,X				;$0099B1	|
	LDA.w #$38B2				;$0099B5	|
	STA.l $7F83C1,X				;$0099B8	|
	INC A					;$0099BC	|
	STA.l $7F83C3,X				;$0099BD	|
	LDA.w #$2C80				;$0099C1	|
	STA.l $7F8405,X				;$0099C4	|
	INC A					;$0099C8	|
	STA.l $7F8407,X				;$0099C9	|
	INC A					;$0099CD	|
	STA.l $7F8445,X				;$0099CE	|
	INC A					;$0099D2	|
	STA.l $7F8447,X				;$0099D3	|
	LDA.w #$28A0				;$0099D7	|
	STA.l $7F8489,X				;$0099DA	|
	INC A					;$0099DE	|
	STA.l $7F848B,X				;$0099DF	|
	LDA.w #$28B0				;$0099E3	|
	STA.l $7F84C9,X				;$0099E6	|
	INC A					;$0099EA	|
	STA.l $7F84CB,X				;$0099EB	|
	INX					;$0099EF	|
	INX					;$0099F0	|
	INX					;$0099F1	|
	INX					;$0099F2	|
	DEY					;$0099F3	|
	BNE CODE_0099A9				;$0099F4	|
	TXA					;$0099F6	|
	CLC					;$0099F7	|
	ADC.w #$014C				;$0099F8	|
	TAX					;$0099FB	|
	LDA.w #$C05E				;$0099FC	|
	CPX.w #$0318				;$0099FF	|
	BCS CODE_009A07				;$009A02	|
	JMP CODE_009980				;$009A04	|

CODE_009A07:
	LDA.w #$00FF
	STA.l $7F837D,X				;$009A0A	|
	SEP #$30				;$009A0E	|
	JSR _load_stripe_image_			;$009A10	|
	LDX.b #$B0				;$009A13	|
	LDA.b #$90				;$009A15	|
CODE_009A17:
	STA $96
	JSR CODE_009A1F				;$009A19	|
	JMP CODE_009283				;$009A1C	|

CODE_009A1F:
	LDY.b #$10
	LDA.b #$32				;$009A21	|
CODE_009A23:
	STA.l $7EC800,X
	STA.l $7EC9B0,X				;$009A27	|
	STA.l $7FC800,X				;$009A2B	|
	STA.l $7FC9B0,X				;$009A2F	|
	INX					;$009A33	|
	DEY					;$009A34	|
	BNE CODE_009A23				;$009A35	|
	CPX.b #$C0				;$009A37	|
	BNE Return009A4D			;$009A39	|
	LDX.b #$D0				;$009A3B	|
CODE_009A3D:
	LDY.b #$10
	LDA.b #$05				;$009A3F	|
CODE_009A41:
	STA.l $7EC800,X
	STA.l $7EC9B0,X				;$009A45	|
	INX					;$009A49	|
	DEY					;$009A4A	|
	BNE CODE_009A41				;$009A4B	|
Return009A4D:
	RTS

DATA_009A4E:
	db $FF,$01,$18,$30

CODE_009A52:
	LDA.w $0D9B
	LSR					;$009A55	|
	BCS CODE_009A6F				;$009A56	|
	JSL CODE_00F6DB				;$009A58	|
	JSL CODE_05BC00				;$009A5C	|
	LDA.w $13FC				;$009A60	|
	CMP.b #$04				;$009A63	|
	BEQ CODE_009A6F				;$009A65	|
	JSR CODE_0086C7				;$009A67	|
	JSL CODE_02827D				;$009A6A	|
	RTS					;$009A6E	|

CODE_009A6F:
	JSL $7F8000
	RTS					;$009A73	|

SetUp0DA0GM4:
	LDA.w $4016
	LSR					;$009A77	|
	LDA.w $4017				;$009A78	|
	ROL					;$009A7B	|
	AND.b #$03				;$009A7C	|
	BEQ CODE_009A87				;$009A7E	|
	CMP.b #$03				;$009A80	|
	BNE CODE_009A86				;$009A82	|
	ORA.b #$80				;$009A84	|
CODE_009A86:
	DEC A
CODE_009A87:
	STA.w $0DA0
	RTS					;$009A8A	|

CODE_009A8B:
	JSR SetUp0DA0GM4
	JSR GM04Load				;$009A8E	|
	STZ.w $0F31				;$009A91	|
	JSR CODE_0085FA				;$009A94	|
	LDA.b #$03				;$009A97	|
	STA $12					;$009A99	|
	JSR _load_stripe_image_			;$009A9B	|
	JSR CODE_00ADA6				;$009A9E	|
	JSR CODE_00922F				;$009AA1	|
	JSL CODE_04F675				;$009AA4	|
	LDA.b #$01				;$009AA8	|
	STA.w $0D9B				;$009AAA	|
	LDA.b #$33				;$009AAD	|
	STA $41					;$009AAF	|
	LDA.b #$00				;$009AB1	|
	STA $42					;$009AB3	|
	LDA.b #$23				;$009AB5	|
	STA $43					;$009AB7	|
	LDA.b #$12				;$009AB9	|
	STA $44					;$009ABB	|
	JSR CODE_009443				;$009ABD	|
	LDA.b #$10				;$009AC0	|
	STA.w $1DF5				;$009AC2	|
	JMP Mode04Finish			;$009AC5	|

DATA_009AC8:
	db $01,$FF,$FF

CODE_009ACB:
	PHY
	JSR SetUp0DA0GM4			;$009ACC	|
	PLY					;$009ACF	|
CODE_009AD0:
	INC.w $1B91
	JSR CODE_009E82				;$009AD3	|
	LDX.w $1B92				;$009AD6	|
	LDA $16					;$009AD9	|
	AND.b #$90				;$009ADB	|
	BNE CODE_009AE3				;$009ADD	|
	LDA $18					;$009ADF	|
	BPL CODE_009AEA				;$009AE1	|
CODE_009AE3:
	LDA.b #$01
	STA.w $1DFC				;$009AE5	|
	BRA CODE_009B11				;$009AE8	|

CODE_009AEA:
	PLA
	PLA					;$009AEB	|
	LDA $16					;$009AEC	|
	AND.b #$20				;$009AEE	|
	LSR					;$009AF0	|
	LSR					;$009AF1	|
	LSR					;$009AF2	|
	ORA $16					;$009AF3	|
	AND.b #$0C				;$009AF5	|
	BEQ Return009B16			;$009AF7	|
	LDY.b #$06				;$009AF9	|
	STY.w $1DFC				;$009AFB	|
	STZ.w $1B91				;$009AFE	|
	LSR					;$009B01	|
	LSR					;$009B02	|
	TAY					;$009B03	|
	TXA					;$009B04	|
	ADC.w DATA_009AC8-1,Y			;$009B05	|
	BPL CODE_009B0D				;$009B08	|
	LDA $8A					;$009B0A	|
	DEC A					;$009B0C	|
CODE_009B0D:
	CMP $8A
	BCC CODE_009B13				;$009B0F	|
CODE_009B11:
	LDA.b #$00
CODE_009B13:
	STA.w $1B92
Return009B16:
	RTS

DATA_009B17:
	db $04,$02,$01

CODE_009B1A:
	REP #$20
	LDA.w #$39C9				;$009B1C	|
	LDY.b #$60				;$009B1F	|
	JSR CODE_009D30				;$009B21	|
	LDA $16					;$009B24	|
	ORA $18					;$009B26	|
	AND.b #$40				;$009B28	|
	BEQ CODE_009B38				;$009B2A	|
CODE_009B2C:
	DEC.w $0100
	DEC.w $0100				;$009B2F	|
	JSR CODE_009B11				;$009B32	|
	JMP CODE_009CB0				;$009B35	|

CODE_009B38:
	LDY.b #$08
	JSR CODE_009AD0				;$009B3A	|
	CPX.b #$03				;$009B3D	|
	BNE CODE_009B6D				;$009B3F	|
	LDY.b #$02				;$009B41	|
CODE_009B43:
	LSR.w $0DDE
	BCC CODE_009B67				;$009B46	|
	PHY					;$009B48	|
	LDA.w DATA_009CCB,Y			;$009B49	|
	XBA					;$009B4C	|
	LDA.w DATA_009CCE,Y			;$009B4D	|
	REP #$10				;$009B50	|
	TAX					;$009B52	|
	LDY.w #$008F				;$009B53	|
	LDA.b #$00				;$009B56	|
CODE_009B58:
	STA.l $700000,X
	STA.l $7001AD,X				;$009B5C	|
	INX					;$009B60	|
	DEY					;$009B61	|
	BNE CODE_009B58				;$009B62	|
	SEP #$10				;$009B64	|
	PLY					;$009B66	|
CODE_009B67:
	DEY
	BPL CODE_009B43				;$009B68	|
	JMP CODE_009C89				;$009B6A	|

CODE_009B6D:
	STX.w $1B92
	LDA.w DATA_009B17,X			;$009B70	|
	ORA.w $0DDE				;$009B73	|
	STA.w $0DDE				;$009B76	|
	STA $05					;$009B79	|
	LDX.b #$00				;$009B7B	|
	JMP CODE_009D3C				;$009B7D	|

CODE_009B80:
	PHB
	PHK					;$009B81	|
	PLB					;$009B82	|
	JSR CODE_009B88				;$009B83	|
	PLB					;$009B86	|
	RTL					;$009B87	|

CODE_009B88:
	DEC A
	JSL execute_pointer			;$009B89	|

Ptrs009B8D:
	dw CODE_009B91
	dw CODE_009B9A

CODE_009B91:
	LDY.b #$0C
	JSR CODE_009D29				;$009B93	|
	INC.w $13C9				;$009B96	|
	RTS					;$009B99	|

CODE_009B9A:
	LDY.b #$00
	JSR CODE_009AD0				;$009B9C	|
	TXA					;$009B9F	|
	BNE ADDR_009BA5				;$009BA0	|
	JMP CODE_009E17				;$009BA2	|

ADDR_009BA5:
	JMP CODE_009C89

CODE_009BA8:
	PHB
	PHK					;$009BA9	|
	PLB					;$009BAA	|
	JSR CODE_009BB0				;$009BAB	|
	PLB					;$009BAE	|
	RTL					;$009BAF	|

CODE_009BB0:
	LDY.b #$06
	JSR CODE_009AD0				;$009BB2	|
	TXA					;$009BB5	|
	BNE CODE_009BC4				;$009BB6	|
	STZ.w $1DFC				;$009BB8	|
	LDA.b #$05				;$009BBB	|
	STA.w $1DF9				;$009BBD	|
	JSL CODE_009BC9				;$009BC0	|
CODE_009BC4:
	JSL CODE_009C13
	RTS					;$009BC8	|

CODE_009BC9:
	PHB
	PHK					;$009BCA	|
	PLB					;$009BCB	|
	LDX.w $010A				;$009BCC	|
	LDA.w DATA_009CCB,X			;$009BCF	|
	XBA					;$009BD2	|
	LDA.w DATA_009CCE,X			;$009BD3	|
	REP #$10				;$009BD6	|
	TAX					;$009BD8	|
CODE_009BD9:
	LDY.w #$0000
	STY $8A					;$009BDC	|
CODE_009BDE:
	LDA.w $1F49,Y
	STA.l $700000,X				;$009BE1	|
	CLC					;$009BE5	|
	ADC $8A					;$009BE6	|
	STA $8A					;$009BE8	|
	BCC CODE_009BEE				;$009BEA	|
	INC $8B					;$009BEC	|
CODE_009BEE:
	INX
	INY					;$009BEF	|
	CPY.w #$008D				;$009BF0	|
	BCC CODE_009BDE				;$009BF3	|
	REP #$20				;$009BF5	|
	LDA.w #$5A5A				;$009BF7	|
	SEC					;$009BFA	|
	SBC $8A					;$009BFB	|
	STA.l $700000,X				;$009BFD	|
	CPX.w #$01AD				;$009C01	|
	BCS CODE_009C0F				;$009C04	|
	TXA					;$009C06	|
	ADC.w #$0120				;$009C07	|
	TAX					;$009C0A	|
	SEP #$20				;$009C0B	|
	BRA CODE_009BD9				;$009C0D	|

CODE_009C0F:
	SEP #$30
	PLB					;$009C11	|
	RTL					;$009C12	|

CODE_009C13:
	INC.w $1B87
	INC.w $1B88				;$009C16	|
	LDY.b #$1B				;$009C19	|
	JSR CODE_009D29				;$009C1B	|
	RTL					;$009C1E	|

IntroControlData:
	db $41

ItrCntrlrSqnc:
	db $0F,$C1,$30,$00,$10,$42,$20,$41
	db $70,$81,$11,$00,$80,$82,$0C,$00
	db $30,$C1,$30,$41,$60,$C1,$10,$00
	db $40,$01,$30,$E1,$01,$00,$60,$41
	db $4E,$80,$10,$00,$30,$41,$58,$00
	db $20,$60,$01,$00,$30,$60,$01,$00
	db $30,$60,$01,$00,$30,$60,$01,$00
	db $30,$60,$01,$00,$30,$41,$1A,$C1
	db $30,$00,$30,$FF

GAMEMODE_07:
	JSR SetUp0DA0GM4
	JSR CODE_009CBE				;$009C67	|
	BNE CODE_009C9F				;$009C6A	|
	JSR disable_controls			;$009C6C	|
	LDX.w $1DF4				;$009C6F	|
	DEC.w $1DF5				;$009C72	|
	BNE CODE_009C82				;$009C75	|
	LDA.w ItrCntrlrSqnc,X			;$009C77	|
	STA.w $1DF5				;$009C7A	|
	INX					;$009C7D	|
	INX					;$009C7E	|
	STX.w $1DF4				;$009C7F	|
CODE_009C82:
	LDA.w $9C1D,X
	CMP.b #$FF				;$009C85	|
	BNE CODE_009C8F				;$009C87	|
CODE_009C89:
	LDY.b #$02
CODE_009C8B:
	STY.w $0100
	RTS					;$009C8E	|

CODE_009C8F:
	AND.b #$DF
	STA $15					;$009C91	|
	CMP.w $9C1D,X				;$009C93	|
	BNE CODE_009C9A				;$009C96	|
	AND.b #$9F				;$009C98	|
CODE_009C9A:
	STA $16
	JMP CODE_00A1DA				;$009C9C	|

CODE_009C9F:
	JSL $7F8000
	LDA.b #$04				;$009CA3	|
	STA.w $212C				;$009CA5	|
	LDA.b #$13				;$009CA8	|
	STA.w $212D				;$009CAA	|
	STZ.w $0D9F				;$009CAD	|
CODE_009CB0:
	LDA.b #$E9
	STA.w $0109				;$009CB2	|
	JSR CODE_WRITEOW			;$009CB5	|
	JSR CODE_009D38				;$009CB8	|
	JMP CODE_009417				;$009CBB	|

CODE_009CBE:
	LDA $17
	AND.b #$C0				;$009CC0	|
	BNE Return009CCA			;$009CC2	|
	LDA $15					;$009CC4	|
	AND.b #$F0				;$009CC6	|
	BNE Return009CCA			;$009CC8	|
Return009CCA:
	RTS

DATA_009CCB:
	db $00,$00,$01

DATA_009CCE:
	db $00,$8F,$1E

CODE_009CD1:
	REP #$20
	LDA.w #$7393				;$009CD3	|
	LDY.b #$20				;$009CD6	|
	JSR CODE_009D30				;$009CD8	|
	LDY.b #$02				;$009CDB	|
	JSR CODE_009ACB				;$009CDD	|
	INC.w $0100				;$009CE0	|
	CPX.b #$03				;$009CE3	|
	BNE CODE_009CEF				;$009CE5	|
	STZ.w $0DDE				;$009CE7	|
	LDX.b #$00				;$009CEA	|
	JMP CODE_009D3A				;$009CEC	|

CODE_009CEF:
	STX.w $010A
	JSR CODE_009DB5				;$009CF2	|
	BNE CODE_009D22				;$009CF5	|
	PHX					;$009CF7	|
	STZ.w $0109				;$009CF8	|
	LDA.b #$8F				;$009CFB	|
	STA $00					;$009CFD	|
CODE_009CFF:
	LDA.l $700000,X
	PHX					;$009D03	|
	TYX					;$009D04	|
	STA.l $700000,X				;$009D05	|
	PLX					;$009D09	|
	INX					;$009D0A	|
	INY					;$009D0B	|
	DEC $00					;$009D0C	|
	BNE CODE_009CFF				;$009D0E	|
	PLX					;$009D10	|
	LDY.w #$0000				;$009D11	|
CODE_009D14:
	LDA.l $700000,X
	STA.w $1F49,Y				;$009D18	|
	INX					;$009D1B	|
	INY					;$009D1C	|
	CPY.w #$008D				;$009D1D	|
	BCC CODE_009D14				;$009D20	|
CODE_009D22:
	SEP #$10
	LDY.b #$12				;$009D24	|
	INC.w $0100				;$009D26	|
CODE_009D29:
	STY $12
	LDX.b #$00				;$009D2B	|
	JMP CODE_009ED4				;$009D2D	|

CODE_009D30:
	STA.w $0701
	STY $40					;$009D33	|
	SEP #$20				;$009D35	|
	RTS					;$009D37	|

CODE_009D38:
	LDX.b #$CB
CODE_009D3A:
	STZ $05
CODE_009D3C:
	REP #$10
	LDY.w #$0000				;$009D3E	|
CODE_009D41:
	LDA.l DATA_05B6FE,X
	PHX					;$009D45	|
	TYX					;$009D46	|
	STA.l $7F837D,X				;$009D47	|
	PLX					;$009D4B	|
	INX					;$009D4C	|
	INY					;$009D4D	|
	CPY.w #$00CC				;$009D4E	|
	BNE CODE_009D41				;$009D51	|
	SEP #$10				;$009D53	|
	LDA.b #$84				;$009D55	|
	STA $00					;$009D57	|
	LDX.b #$02				;$009D59	|
CODE_009D5B:
	STX $04
	LSR $05					;$009D5D	|
	BCS CODE_009DA6				;$009D5F	|
	JSR CODE_009DB5				;$009D61	|
	BNE CODE_009DA6				;$009D64	|
	LDA.l $70008C,X				;$009D66	|
	SEP #$10				;$009D6A	|
	CMP.b #$60				;$009D6C	|
	BCC CODE_009D76				;$009D6E	|
	LDY.b #$87				;$009D70	|
	LDA.b #$88				;$009D72	|
	BRA CODE_009D7A				;$009D74	|

CODE_009D76:
	JSR HexToDec
	TXY					;$009D79	|
CODE_009D7A:
	LDX $00
	STA.l $7F8381,X				;$009D7C	|
	TYA					;$009D80	|
	BNE CODE_009D85				;$009D81	|
	LDY.b #$FC				;$009D83	|
CODE_009D85:
	TYA
	STA.l $7F837F,X				;$009D86	|
	LDA.b #$38				;$009D8A	|
	STA.l $7F8380,X				;$009D8C	|
	STA.l $7F8382,X				;$009D90	|
	REP #$20				;$009D94	|
	LDY.b #$03				;$009D96	|
CODE_009D98:
	LDA.w #$38FC
	STA.l $7F8383,X				;$009D9B	|
	INX					;$009D9F	|
	INX					;$009DA0	|
	DEY					;$009DA1	|
	BNE CODE_009D98				;$009DA2	|
	SEP #$20				;$009DA4	|
CODE_009DA6:
	SEP #$10
	LDA $00					;$009DA8	|
	SEC					;$009DAA	|
	SBC.b #$24				;$009DAB	|
	STA $00					;$009DAD	|
	LDX $04					;$009DAF	|
	DEX					;$009DB1	|
	BPL CODE_009D5B				;$009DB2	|
	RTS					;$009DB4	|

CODE_009DB5:
	LDA.w DATA_009CCB,X
	XBA					;$009DB8	|
	LDA.w DATA_009CCE,X			;$009DB9	|
	REP #$30				;$009DBC	|
	TAX					;$009DBE	|
	CLC					;$009DBF	|
	ADC.w #$01AD				;$009DC0	|
	TAY					;$009DC3	|
CODE_009DC4:
	PHX
	PHY					;$009DC5	|
	LDA.l $70008D,X				;$009DC6	|
	STA $8A					;$009DCA	|
	SEP #$20				;$009DCC	|
	LDY.w #$008D				;$009DCE	|
CODE_009DD1:
	LDA.l $700000,X
	CLC					;$009DD5	|
	ADC $8A					;$009DD6	|
	STA $8A					;$009DD8	|
	BCC CODE_009DDE				;$009DDA	|
	INC $8B					;$009DDC	|
CODE_009DDE:
	INX
	DEY					;$009DDF	|
	BNE CODE_009DD1				;$009DE0	|
	REP #$20				;$009DE2	|
	PLY					;$009DE4	|
	PLX					;$009DE5	|
	LDA $8A					;$009DE6	|
	CMP.w #$5A5A				;$009DE8	|
	BEQ CODE_009DF7				;$009DEB	|
	CPX.w #$01AC				;$009DED	|
	BCS CODE_009DF7				;$009DF0	|
	PHX					;$009DF2	|
	TYX					;$009DF3	|
	PLY					;$009DF4	|
	BRA CODE_009DC4				;$009DF5	|

CODE_009DF7:
	SEP #$20
	RTS					;$009DF9	|

CODE_009DFA:
	LDA $16
	ORA $18					;$009DFC	|
	AND.b #$40				;$009DFE	|
	BEQ CODE_009E08				;$009E00	|
	DEC.w $0100				;$009E02	|
	JMP CODE_009B2C				;$009E05	|

CODE_009E08:
	LDY.b #$04
	JSR CODE_009ACB				;$009E0A	|
	STX.w $0DB2				;$009E0D	|
	JSR CODE_00A195				;$009E10	|
	JSL CODE_04DAAD				;$009E13	|
CODE_009E17:
	LDA.b #$80
	STA.w $1DFB				;$009E19	|
	LDA.b #$FF				;$009E1C	|
	STA.w $0DB5				;$009E1E	|
	LDX.w $0DB2				;$009E21	|
	LDA.b #$04				;$009E24	|
CODE_009E26:
	STA.w $0DB4,X
	DEX					;$009E29	|
	BPL CODE_009E26				;$009E2A	|
	STA.w $0DBE				;$009E2C	|
	STZ.w $0DBF				;$009E2F	|
	STZ.w $0DC1				;$009E32	|
	STZ $19					;$009E35	|
	STZ.w $0DC2				;$009E37	|
	STZ.w $13C9				;$009E3A	|
	REP #$20				;$009E3D	|
	STZ.w $0DB6				;$009E3F	|
	STZ.w $0DB8				;$009E42	|
	STZ.w $0DBA				;$009E45	|
	STZ.w $0DC2				;$009E48	|
	STZ.w $0F48				;$009E4B	|
	STZ.w $0F34				;$009E4E	|
	STZ.w $0F37				;$009E51	|
	SEP #$20				;$009E54	|
	STZ.w $0F36				;$009E56	|
	STZ.w $0F39				;$009E59	|
	STZ.w $0DD5				;$009E5C	|
	STZ.w $0DB3				;$009E5F	|
CODE_009E62:
	JSR KeepModeActive
	LDY.b #$0B				;$009E65	|
	JMP CODE_009C8B				;$009E67	|

DATA_009E6A:
	db $02,$00,$04,$00,$02,$00,$02,$00
	db $04,$00

DATA_009E74:
	db $CB,$51,$E8,$51,$08,$52,$C4,$51
	db $E5,$51

DATA_009E7E:
	db $01,$02,$04,$08

CODE_009E82:
	LDX.w $1B92
	LDA.w DATA_009E7E,X			;$009E85	|
	TAX					;$009E88	|
	LDA.w $1B91				;$009E89	|
	EOR.b #$1F				;$009E8C	|
	AND.b #$18				;$009E8E	|
	BNE CODE_009E94				;$009E90	|
	LDX.b #$00				;$009E92	|
CODE_009E94:
	STX $00
	LDA.l $7F837B				;$009E96	|
	TAX					;$009E9A	|
	REP #$20				;$009E9B	|
	LDA.w DATA_009E6A,Y			;$009E9D	|
	STA $8A					;$009EA0	|
	STA $02					;$009EA2	|
	LDA.w DATA_009E74,Y			;$009EA4	|
CODE_009EA7:
	XBA
	STA.l $7F837D,X				;$009EA8	|
	XBA					;$009EAC	|
	CLC					;$009EAD	|
	ADC.w #$0040				;$009EAE	|
	PHA					;$009EB1	|
	LDA.w #$0100				;$009EB2	|
	STA.l $7F837F,X				;$009EB5	|
	LDA.w #$38FC				;$009EB9	|
	LSR $00					;$009EBC	|
	BCC CODE_009EC3				;$009EBE	|
	LDA.w #$3D2E				;$009EC0	|
CODE_009EC3:
	STA.l $7F8381,X
	PLA					;$009EC7	|
	INX					;$009EC8	|
	INX					;$009EC9	|
	INX					;$009ECA	|
	INX					;$009ECB	|
	INX					;$009ECC	|
	INX					;$009ECD	|
	DEC $02					;$009ECE	|
	BNE CODE_009EA7				;$009ED0	|
	SEP #$20				;$009ED2	|
CODE_009ED4:
	TXA
	STA.l $7F837B				;$009ED5	|
	LDA.b #$FF				;$009ED9	|
	STA.l $7F837D,X				;$009EDB	|
	RTS					;$009EDF	|

TBL_009EE0:
	db $28

DATA_009EE1:
	db $03,$4D,$01,$52,$01,$53,$01,$5B
	db $08,$5C,$02,$57,$04,$30,$01

TBL_009EF0:
	db $01,$01,$02,$00,$02,$00,$68,$00
	db $78,$00,$68,$00,$78,$00,$06,$00
	db $07,$00,$06,$00,$07,$00

CODE_WRITEOW:
	LDX.b #$8D
CODE_009F08:
	STZ.w $1F48,X
	DEX					;$009F0B	|
	BNE CODE_009F08				;$009F0C	|
	LDX.b #$0E				;$009F0E	|
CODE_009F10:
	LDY.w TBL_009EE0,X
	LDA.w DATA_009EE1,X			;$009F13	|
	STA.w $1F49,Y				;$009F16	|
	DEX					;$009F19	|
	DEX					;$009F1A	|
	BPL CODE_009F10				;$009F1B	|
	LDX.b #$15				;$009F1D	|
CODE_009F1F:
	LDA.w TBL_009EF0,X
	STA.w $1FB8,X				;$009F22	|
	DEX					;$009F25	|
	BPL CODE_009F1F				;$009F26	|
	RTS					;$009F28	|

KeepModeActive:
	LDA.b #$01
CODE_009F2B:
	STA.w $0DB1
	RTS					;$009F2E	|

DATA_009F2F:
	db $01,$FF

DATA_009F31:
	db $F0,$10

DATA_009F33:
	db $0F,$00,$00,$F0

TmpFade:
	DEC.w $0DB1
	BPL Return009F6E			;$009F3A	|
	JSR KeepModeActive			;$009F3C	|
	LDY.w $0DAF				;$009F3F	|
	LDA.w $0DB0				;$009F42	|
	CLC					;$009F45	|
	ADC.w DATA_009F31,Y			;$009F46	|
	STA.w $0DB0				;$009F49	|
CODE_009F4C:
	LDA.w $0DAE
	CLC					;$009F4F	|
	ADC.w DATA_009F2F,Y			;$009F50	|
	STA.w $0DAE				;$009F53	|
	CMP.w DATA_009F33,Y			;$009F56	|
	BNE CODE_009F66				;$009F59	|
GMPPMosaic:
	INC.w $0100
	LDA.w $0DAF				;$009F5E	|
	EOR.b #$01				;$009F61	|
	STA.w $0DAF				;$009F63	|
CODE_009F66:
	LDA.b #$03
	ORA.w $0DB0				;$009F68	|
	STA.w $2106				;$009F6B	|
Return009F6E:
	RTS

CODE_009F6F:
	DEC.w $0DB1
	BPL Return009F6E			;$009F72	|
	JSR KeepModeActive			;$009F74	|
CODE_009F77:
	LDY.w $0DAF
	BRA CODE_009F4C				;$009F7A	|

CODE_009F7C:
	DEC.w $0DB1
	BPL Return009F6E			;$009F7F	|
	LDA.b #$08				;$009F81	|
	JSR CODE_009F2B				;$009F83	|
	BRA CODE_009F77				;$009F86	|

DATA_009F88:
	db $01,$02,$C0,$01,$80,$81,$01,$02
	db $C0,$01,$02,$81,$01,$02,$80,$01
	db $02,$81,$01,$02,$81,$01,$02,$C0
	db $01,$02,$C0,$01,$02,$81,$01,$02
	db $80,$01,$02,$80,$01,$02,$80,$01
	db $02,$81,$01,$02,$81,$01,$02,$80

CODE_009FB8:
	LDA.w $1931
	ASL					;$009FBB	|
	CLC					;$009FBC	|
	ADC.w $1931				;$009FBD	|
	STA $00					;$009FC0	|
	LDA.w $1BE3				;$009FC2	|
	BEQ CODE_00A012				;$009FC5	|
	DEC A					;$009FC7	|
	CLC					;$009FC8	|
	ADC $00					;$009FC9	|
	TAX					;$009FCB	|
	LDA.w DATA_009F88,X			;$009FCC	|
	BMI CODE_009FEA				;$009FCF	|
	STA.w $1403				;$009FD1	|
	LSR					;$009FD4	|
	PHP					;$009FD5	|
	JSR CODE_00A045				;$009FD6	|
	LDA.b #$70				;$009FD9	|
	PLP					;$009FDB	|
	BEQ CODE_009FE0				;$009FDC	|
	LDA.b #$40				;$009FDE	|
CODE_009FE0:
	STA $24
	STZ $25					;$009FE2	|
	JSL CODE_05BC72				;$009FE4	|
	BRA CODE_00A01B				;$009FE8	|

CODE_009FEA:
	ASL
	BMI CODE_00A012				;$009FEB	|
	BEQ CODE_00A007				;$009FED	|
	LDA.w $1931				;$009FEF	|
	CMP.b #$01				;$009FF2	|
	BEQ CODE_009FFA				;$009FF4	|
	CMP.b #$03				;$009FF6	|
	BNE CODE_00A01F				;$009FF8	|
CODE_009FFA:
	REP #$20
	LDA $1A					;$009FFC	|
	LSR					;$009FFE	|
	STA $22					;$009FFF	|
	SEP #$20				;$00A001	|
	LDA.b #$C0				;$00A003	|
	BRA CODE_00A017				;$00A005	|

CODE_00A007:
	LDX.b #$07
CODE_00A009:
	LDA.w DATA_00B66C,X
	STA.w $071B,X				;$00A00C	|
	DEX					;$00A00F	|
	BPL CODE_00A009				;$00A010	|
CODE_00A012:
	INC.w $13D5
	LDA.b #$D0				;$00A015	|
CODE_00A017:
	STA $24
	STZ $25					;$00A019	|
CODE_00A01B:
	LDA.b #$04
	TRB $40					;$00A01D	|
CODE_00A01F:
	LDA.w $1BE3
	BEQ Return00A044			;$00A022	|
	DEC A					;$00A024	|
	CLC					;$00A025	|
	ADC $00					;$00A026	|
	STA $01					;$00A028	|
	ASL					;$00A02A	|
	CLC					;$00A02B	|
	ADC $01					;$00A02C	|
	TAX					;$00A02E	|
	LDA.l Layer3Ptr,X			;$00A02F	|
	STA $00					;$00A033	|
	LDA.l Layer3Ptr+1,X			;$00A035	|
	STA $01					;$00A039	|
	LDA.l Layer3Ptr+2,X			;$00A03B	|
	STA $02					;$00A03F	|
	JSR DMA_stripe_image			;$00A041	|
Return00A044:
	RTS

CODE_00A045:
	REP #$30
	LDX.w #$0100				;$00A047	|
CODE_00A04A:
	LDY.w #$0058
	LDA.w #$0000				;$00A04D	|
CODE_00A050:
	STA.l $7EE300,X
	INX					;$00A054	|
	INX					;$00A055	|
	DEY					;$00A056	|
	BNE CODE_00A050				;$00A057	|
	TXA					;$00A059	|
	CLC					;$00A05A	|
	ADC.w #$0100				;$00A05B	|
	TAX					;$00A05E	|
	CPX.w #$1B00				;$00A05F	|
	BCC CODE_00A04A				;$00A062	|
	SEP #$30				;$00A064	|
	LDA.b #$80				;$00A066	|
	TSB $5B					;$00A068	|
	RTS					;$00A06A	|

DATA_00A06B:
	db $00,$00,$EF,$FF,$EF,$FF,$EF,$FF
	db $F0,$00,$F0,$00,$F0,$00

DATA_00A079:
	db $00,$00,$D8,$FF,$80,$00,$28,$01
	db $D8,$FF,$80,$00,$28,$01

CODE_00A087:
	JSR TurnOffIO
	LDA.w $1B9C				;$00A08A	|
	BEQ CODE_00A093				;$00A08D	|
	JSL CODE_04853B				;$00A08F	|
CODE_00A093:
	JSR Clear_1A_13D3
	LDA.w $0109				;$00A096	|
	BEQ CODE_00A0B0				;$00A099	|
	LDA.b #$B0				;$00A09B	|
	STA.w $1DF5				;$00A09D	|
	STZ.w $1F11				;$00A0A0	|
	LDA.b #$F0				;$00A0A3	|
	STA.w $0DB0				;$00A0A5	|
	LDA.b #$10				;$00A0A8	|
	STA.w $0100				;$00A0AA	|
	JMP Mode04Finish			;$00A0AD	|

CODE_00A0B0:
	JSR CODE_0085FA
	JSR upload_music_bank_1			;$00A0B3	|
	JSR SetUpScreen				;$00A0B6	|
	STZ.w $0DDA				;$00A0B9	|
	LDX.w $0DB3				;$00A0BC	|
	LDA.w $0DBE				;$00A0BF	|
	BPL CODE_00A0C7				;$00A0C2	|
	INC.w $1B87				;$00A0C4	|
CODE_00A0C7:
	STA.w $0DB4,X
	LDA $19					;$00A0CA	|
	STA.w $0DB8,X				;$00A0CC	|
	LDA.w $0DBF				;$00A0CF	|
	STA.w $0DB6,X				;$00A0D2	|
	LDA.w $0DC1				;$00A0D5	|
	BEQ CODE_00A0DD				;$00A0D8	|
	LDA.w $13C7				;$00A0DA	|
CODE_00A0DD:
	STA.w $0DBA,X
	LDA.w $0DC2				;$00A0E0	|
	STA.w $0DBC,X				;$00A0E3	|
	LDA.b #$03				;$00A0E6	|
	STA $44					;$00A0E8	|
	LDA.b #$30				;$00A0EA	|
	LDX.b #$15				;$00A0EC	|
	LDY.w $13C9				;$00A0EE	|
	BEQ CODE_00A11B				;$00A0F1	|
	JSR CODE_00A195				;$00A0F3	|
	LDA.w $1F2E				;$00A0F6	|
	BNE CODE_00A101				;$00A0F9	|
	JSR CODE_009C89				;$00A0FB	|
	JMP CODE_0093F4				;$00A0FE	|

CODE_00A101:
	JSL CODE_04DAAD
	REP #$20				;$00A105	|
	LDA.w #$318C				;$00A107	|
	STA.w $0701				;$00A10A	|
	SEP #$20				;$00A10D	|
	LDA.b #$30				;$00A10F	|
	STA $43					;$00A111	|
	LDA.b #$20				;$00A113	|
	STA $44					;$00A115	|
	LDA.b #$B3				;$00A117	|
	LDX.b #$17				;$00A119	|
CODE_00A11B:
	LDY.b #$02
	JSR ScreenSettings			;$00A11D	|
	STX.w $212E				;$00A120	|
	STY.w $212F				;$00A123	|
	JSL CODE_04DC09				;$00A126	|
	LDX.w $0DB3				;$00A12A	|
	LDA.w $1F11,X				;$00A12D	|
	ASL					;$00A130	|
	TAX					;$00A131	|
	REP #$20				;$00A132	|
	LDA.w DATA_00A06B,X			;$00A134	|
	STA $1A					;$00A137	|
	STA $1E					;$00A139	|
	LDA.w DATA_00A079,X			;$00A13B	|
	STA $1C					;$00A13E	|
	STA $20					;$00A140	|
	SEP #$20				;$00A142	|
	JSR UploadSpriteGFX			;$00A144	|
	LDY.b #$14				;$00A147	|
	JSL CODE_00BA28				;$00A149	|
	JSR CODE_00AD25				;$00A14D	|
	JSR CODE_00922F				;$00A150	|
	LDA.b #$06				;$00A153	|
	STA $12					;$00A155	|
	JSR _load_stripe_image_			;$00A157	|
	JSL CODE_05DBF2				;$00A15A	|
	JSR _load_stripe_image_			;$00A15E	|
	JSL CODE_048D91				;$00A161	|
	JSL CODE_04D6E9				;$00A165	|
	LDA.b #$F0				;$00A169	|
	STA $3F					;$00A16B	|
	JSR CODE_008494				;$00A16D	|
	JSR _load_stripe_image_			;$00A170	|
	STZ.w $13D9				;$00A173	|
	JSR KeepModeActive			;$00A176	|
	LDA.b #$02				;$00A179	|
	STA.w $0D9B				;$00A17B	|
	REP #$10				;$00A17E	|
	LDX.w #$01BE				;$00A180	|
	LDA.b #$FF				;$00A183	|
CODE_00A185:
	STZ.w $04A0,X
	STA.w $04A1,X				;$00A188	|
	DEX					;$00A18B	|
	DEX					;$00A18C	|
	BPL CODE_00A185				;$00A18D	|
	JSR CODE_0092A0				;$00A18F	|
	JMP CODE_0093F4				;$00A192	|

CODE_00A195:
	REP #$10
	LDX.w #$008C				;$00A197	|
CODE_00A19A:
	LDA.w $1F49,X
	STA.w $1EA2,X				;$00A19D	|
	DEX					;$00A1A0	|
	BPL CODE_00A19A				;$00A1A1	|
	SEP #$10				;$00A1A3	|
	RTS					;$00A1A5	|

Clear_1A_13D3:
	REP #$10
	SEP #$20				;$00A1A8	|
	LDX.w #$00BD				;$00A1AA	|
CODE_00A1AD:
	STZ $1A,X
	DEX					;$00A1AF	|
	BPL CODE_00A1AD				;$00A1B0	|
	LDX.w #$07CE				;$00A1B2	|
CODE_00A1B5:
	STZ.w $13D3,X
	DEX					;$00A1B8	|
	BPL CODE_00A1B5				;$00A1B9	|
	SEP #$10				;$00A1BB	|
	RTS					;$00A1BD	|

CODE_00A1BE:
	JSR SetUp0DA0GM4
	INC $14					;$00A1C1	|
	JSL $7F8000				;$00A1C3	|
	JSL GameMode_0E_Prim			;$00A1C7	|
	JMP CODE_008494				;$00A1CB	|

GrndShakeDispYLo:
	db $FE,$00,$02,$00

GrndShakeDispYHi:
	db $FF,$00,$00,$00

DATA_00A1D6:
	db $12,$22,$12,$02

CODE_00A1DA:
	LDA.w $1426
	BEQ CODE_00A1E4				;$00A1DD	|
	JSL CODE_05B10C				;$00A1DF	|
	RTS					;$00A1E3	|

CODE_00A1E4:
	LDA.w $1425
	BEQ CODE_00A200				;$00A1E7	|
	LDA.w $14AB				;$00A1E9	|
	BEQ CODE_00A200				;$00A1EC	|
	CMP.b #$40				;$00A1EE	|
	BCS CODE_00A200				;$00A1F0	|
	JSR disable_controls			;$00A1F2	|
	CMP.b #$1C				;$00A1F5	|
	BCS CODE_00A200				;$00A1F7	|
	JSR SetMarioPeaceImg			;$00A1F9	|
	LDA.b #$0D				;$00A1FC	|
	STA $71					;$00A1FE	|
CODE_00A200:
	ORA $71
	ORA.w $1493				;$00A202	|
	BEQ CODE_00A211				;$00A205	|
	LDA.b #$04				;$00A207	|
	TRB $15					;$00A209	|
	LDA.b #$40				;$00A20B	|
	TRB $16					;$00A20D	|
	TRB $18					;$00A20F	|
CODE_00A211:
	LDA.w $13D3
	BEQ CODE_00A21B				;$00A214	|
	DEC.w $13D3				;$00A216	|
	BRA CODE_00A242				;$00A219	|

CODE_00A21B:
	LDA $16
	AND.b #$10				;$00A21D	|
	BEQ CODE_00A242				;$00A21F	|
	LDA.w $1493				;$00A221	|
	BNE CODE_00A242				;$00A224	|
	LDA $71					;$00A226	|
	CMP.b #$09				;$00A228	|
	BCS CODE_00A242				;$00A22A	|
	LDA.b #$3C				;$00A22C	|
	STA.w $13D3				;$00A22E	|
	LDY.b #$12				;$00A231	|
	LDA.w $13D4				;$00A233	|
	EOR.b #$01				;$00A236	|
	STA.w $13D4				;$00A238	|
	BEQ CODE_00A23F				;$00A23B	|
	LDY.b #$11				;$00A23D	|
CODE_00A23F:
	STY.w $1DF9
CODE_00A242:
	LDA.w $13D4
	BEQ CODE_00A28A				;$00A245	|
	BRA CODE_00A25B				;$00A247	|

	BIT.w $0DA7				;$00A249	|
	BVS ADDR_00A259				;$00A24C	|
	LDA.w $0DA3				;$00A24E	|
	BPL CODE_00A25B				;$00A251	|
	LDA $13					;$00A253	|
	AND.b #$0F				;$00A255	|
	BNE CODE_00A25B				;$00A257	|
ADDR_00A259:
	BRA CODE_00A28A

CODE_00A25B:
	LDA $15
	AND.b #$20				;$00A25D	|
	BEQ Return00A289			;$00A25F	|
	LDY.w $13BF				;$00A261	|
	LDA.w $1EA2,Y				;$00A264	|
	BPL Return00A289			;$00A267	|
	LDA.w $0DD5				;$00A269	|
	BEQ CODE_00A270				;$00A26C	|
	BPL Return00A289			;$00A26E	|
CODE_00A270:
	LDA.b #$80
	BRA CODE_00A27E				;$00A272	|

	LDA.b #$01				;$00A274	|
	BIT $15					;$00A276	|
	BPL ADDR_00A27B				;$00A278	|
	INC A					;$00A27A	|
ADDR_00A27B:
	STA.w $13CE
CODE_00A27E:
	STA.w $0DD5
	INC.w $1DE9				;$00A281	|
	LDA.b #$0B				;$00A284	|
	STA.w $0100				;$00A286	|
Return00A289:
	RTS

CODE_00A28A:
	LDA.w $0D9B
	BPL CODE_00A295				;$00A28D	|
	JSR CODE_00987D				;$00A28F	|
	JMP CODE_00A2A9				;$00A292	|

CODE_00A295:
	JSL $7F8000
	JSL CODE_00F6DB				;$00A299	|
	JSL CODE_05BC00				;$00A29D	|
	JSL CODE_0586F1				;$00A2A1	|
	JSL CODE_05BB39				;$00A2A5	|
CODE_00A2A9:
	LDA $1C
	PHA					;$00A2AB	|
	LDA $1D					;$00A2AC	|
	PHA					;$00A2AE	|
	STZ.w $1888				;$00A2AF	|
	STZ.w $1889				;$00A2B2	|
	LDA.w $1887				;$00A2B5	|
	BEQ CODE_00A2D5				;$00A2B8	|
	DEC.w $1887				;$00A2BA	|
	AND.b #$03				;$00A2BD	|
	TAY					;$00A2BF	|
	LDA.w GrndShakeDispYLo,Y		;$00A2C0	|
	STA.w $1888				;$00A2C3	|
	CLC					;$00A2C6	|
	ADC $1C					;$00A2C7	|
	STA $1C					;$00A2C9	|
	LDA.w GrndShakeDispYHi,Y		;$00A2CB	|
	STA.w $1889				;$00A2CE	|
	ADC $1D					;$00A2D1	|
	STA $1D					;$00A2D3	|
CODE_00A2D5:
	JSR CODE_008E1A
	JSL CODE_00E2BD				;$00A2D8	|
	JSR CODE_00A2F3				;$00A2DC	|
	JSR CODE_00C47E				;$00A2DF	|
	JSL CODE_01808C				;$00A2E2	|
	JSL CODE_028AB1				;$00A2E6	|
	PLA					;$00A2EA	|
	STA $1D					;$00A2EB	|
	PLA					;$00A2ED	|
	STA $1C					;$00A2EE	|
	JMP CODE_008494				;$00A2F0	|

CODE_00A2F3:
	REP #$20
	LDA $94					;$00A2F5	|
	STA $D1					;$00A2F7	|
	LDA $96					;$00A2F9	|
	STA $D3					;$00A2FB	|
	SEP #$20				;$00A2FD	|
	RTS					;$00A2FF	|

dynamic_sprite_DMA:				;		\ 
	REP #$20				;$00A300	 | 16 bit A, 8 bit XY
	LDX.b #$04				;$00A302	 | Load DMA channel 2
	LDY.w $0D84				;$00A304	 | Get number of tiles to load (0 means 1 tile)
	BEQ .skip_palette_DMA			;$00A307	 | Don't upload palettes if there is only one tile
	LDY.b #$86				;$00A309	 |\ Set CGRAM address
	STY.w $2121				;$00A30B	 |/
	LDA.w #$2200				;$00A30E	 |\ DMA transfer mode 0, and DMA to address $2122
	STA.w $4320				;$00A311	 |/
	LDA.w $0D82				;$00A314	 |\ Set the palette source addres using $0D82
	STA.w $4322				;$00A317	 |/
	LDY.b #$00				;$00A31A	 |\ Source bank is #$00
	STY.w $4324				;$00A31C	 |/
	LDA.w #$0014				;$00A31F	 |\ Transfer #$14 bytes
	STA.w $4325				;$00A322	 |/
	STX.w $420B				;$00A325	 | Run DMA channel 2
.skip_palette_DMA				;		 |
	LDY.b #$80				;$00A328	 |\ Set increment VRAM after writing $2119 
	STY.w $2115				;$00A32A	 |/
	LDA.w #$1801				;$00A32D	 |\ Set DMA transfer mode 1, and DMA to address $2118
	STA.w $4320				;$00A330	 |/
	LDA.w #$67F0				;$00A333	 |\ Set VRAM write address to $67F0
	STA.w $2116				;$00A336	 |/
	LDA.w $0D99				;$00A339	 |\ Set tile #$7F decompressed pointer
	STA.w $4322				;$00A33C	 |/
	LDY.b #$7E				;$00A33F	 |\ Set DMA source bank to $7E
	STY.w $4324				;$00A341	 |/
	LDA.w #$0020				;$00A344	 |\ Transfer #$20 bytes
	STA.w $4325				;$00A347	 |/
	STX.w $420B				;$00A34A	 | Start transfer on DMA channel 2
	LDA.w #$6000				;$00A34D	 |\ Set VRAM address to $6000
	STA.w $2116				;$00A350	 |/
	LDX.b #$00				;$00A353	 | Start the DMA counter
.DMA_upper_16x8_loop				;		 |
	LDA.w $0D85,X				;$00A355	 |\ Set the next DMA source address (upper 8x8 strips)
	STA.w $4322				;$00A358	 |/
	LDA.w #$0040				;$00A35B	 |\ Transfer #$40 bytes
	STA.w $4325				;$00A35E	 |/
	LDY.b #$04				;$00A361	 |\ Run DMA on channel 2
	STY.w $420B				;$00A363	 |/
	INX					;$00A366	 |\ Check if all tiles have been uploaded
	INX					;$00A367	 | |
	CPX.w $0D84				;$00A368	 |/
	BCC .DMA_upper_16x8_loop		;$00A36B	 | Continue uploading if more tiles are ready
	LDA.w #$6100				;$00A36D	 |\ Set VRAM address to $6000
	STA.w $2116				;$00A370	 |/
	LDX.b #$00				;$00A373	 | Start the DMA counter
.DMA_lower_16x8_loop				;		 |
	LDA.w $0D8F,X				;$00A375	 |\ Set the next DMA source address (lower 8x8 strips)
	STA.w $4322				;$00A378	 |/
	LDA.w #$0040				;$00A37B	 |\ Transfer #$40 bytes
	STA.w $4325				;$00A37E	 |/
	LDY.b #$04				;$00A381	 |\ Run DMA on channel 2
	STY.w $420B				;$00A383	 |/
	INX					;$00A386	 |\ Check if all tiles have been uploaded
	INX					;$00A387	 | |
	CPX.w $0D84				;$00A388	 |/
	BCC .DMA_lower_16x8_loop		;$00A38B	 | Continue uploading if more tiles are ready
	SEP #$20				;$00A38D	 | Restore 8 bit AXY
	RTS					;$00A38F	/ Finished with dynamic sprite DMA

DMA_animated_level_tiles:			;		\ 
	REP #$20				;$00A390	 | 16 bit A
	LDY.b #$80				;$00A392	 |\ Set VRAM increment after writing to $2119
	STY.w $2115				;$00A394	 |/
	LDA.w #$1801				;$00A397	 |\ DMA transfer mode 1, DMA targe address $2118
	STA.w $4320				;$00A39A	 |/
	LDY.b #$7E				;$00A39D	 |\ DMA source bank $7E
	STY.w $4324				;$00A39F	 |/
	LDX.b #$04				;$00A3A2	 | Load DMA channel 2
	LDA.w $0D80				;$00A3A4	 |\ Check for if tiles are ready for DMA in slot 0
	BEQ .skip_slot_0			;$00A3A7	 |/
	STA.w $2116				;$00A3A9	 | Store the VRAM destination
	LDA.w $0D7A				;$00A3AC	 |\ Set the DMA source address from $0D7A
	STA.w $4322				;$00A3AF	 |/
	LDA.w #$0080				;$00A3B2	 |\ Transfer #$80 bytes
	STA.w $4325				;$00A3B5	 |/
	STX.w $420B				;$00A3B8	 | Run channel 2 DMA
.skip_slot_0					;		 |
	LDA.w $0D7E     			;$00A3BB	 |\ Check for if tiles are ready for DMA in slot 1
	BEQ .skip_slot_1			;$00A3BE	 |/
	STA.w $2116				;$00A3C0	 | Store the VRAM destination
	LDA.w $0D78				;$00A3C3	 |\ Set the DMA source address from $0D78
	STA.w $4322				;$00A3C6	 |/
	LDA.w #$0080				;$00A3C9	 |\ Transfer #$80 bytes
	STA.w $4325				;$00A3CC	 |/
	STX.w $420B				;$00A3CF	 | Run channel 2 DMA
.skip_slot_1					;		 |
	LDA.w $0D7C     			;$00A3D2	 |\ Check for if tiles are ready for DMA in slot 1
	BEQ .skip_slot_2			;$00A3D5	 |/
	STA.w $2116				;$00A3D7	 | Store the VRAM destination
	CMP.w #$0800				;$00A3DA	 |\ If the destination is $0800 branch to handle
	BEQ .berry_upload			;$00A3DD	 |/ The berry uniquely
	LDA.w $0D76				;$00A3DF	 |\ Set the DMA source address from $0D76
	STA.w $4322				;$00A3E2	 |/
	LDA.w #$0080				;$00A3E5	 |\ Transfer #$80 bytes
	STA.w $4325				;$00A3E8	 |/
	STX.w $420B				;$00A3EB	 | Run channel 2 DMA
	BRA .skip_slot_2			;$00A3EE	 | Skip over the berry DMA
						;		 |
.berry_upload					;		 |
	LDA.w $0D76				;$00A3F0	 |\ Set the DMA source address from $0D78
	STA.w $4322				;$00A3F3	 |/
	LDA.w #$0040				;$00A3F6	 |\ Transfer #$40 bytes
	STA.w $4325				;$00A3F9	 |/
	STX.w $420B				;$00A3FC	 | Run channel 2 DMA
	LDA.w #$0900				;$00A3FF	 |\ Move VRAM destination to the next row
	STA.w $2116				;$00A402	 |/
	LDA.w $0D76				;$00A405	 |\ Set the DMA source address from $0D78
	CLC					;$00A408	 | |
	ADC.w #$0040				;$00A409	 | | Add #$40 to offset to the next row
	STA.w $4322				;$00A40C	 |/
	LDA.w #$0040				;$00A40F	 |\ Transfer #$40 bytes
	STA.w $4325				;$00A412	 |/
	STX.w $420B				;$00A415	 | Run channel 2 DMA
.skip_slot_2					;$00A418	 |
	SEP #$20				;		 | 8 bit AXY
	LDA.b #$64				;$00A41A	 | Use color address #$64 (yoshi coin color)
animate_yellow_level_tile:			;		 |
	STZ $00					;$00A41C	 | Clear the palette offset
animate_red_level_tile:				;		 |
	STA.w $2121				;$00A41E	 | Store the color address
	LDA $14					;$00A421	 |\ Use the frame counter to cycle the colors
	AND.b #$1C				;$00A423	 | | 
	LSR					;$00A425	 | | (($14) & #$1C) >> 1  (0 to 14 decimal)
	ADC $00					;$00A426	 | | Add the palette offset
	TAY					;$00A428	 |/
	LDA.w animated_palettes,Y		;$00A429	 |\ Store the animate color to CGRAM
	STA.w $2122				;$00A42C	 | |
	LDA.w animated_palettes+1,Y		;$00A42F	 | |
	STA.w $2122				;$00A432	 |/
	RTS					;$00A435	/

restore_SP1_tiles:				;		\ (This routine is pretty much useless in vanilla SMW) 
	LDA.w $1935				;$00A436	 |\ Check for a request to DMA tiles 4A-4F and 5A-5F 
	BEQ .return				;$00A439	 |/
	STZ.w $1935				;$00A43B	 | Prevent continuous tile uploading
	REP #$20				;$00A43E	 | 16 bit A
	LDY.b #$80				;$00A440	 |\ Set VRAM to increment after $2119 writes
	STY.w $2115				;$00A442	 |/
	LDA.w #$64A0				;$00A445	 |\ Set VRAM destination to $64A0
	STA.w $2116				;$00A448	 |/
	LDA.w #$1801				;$00A44B	 |\ Set DMA transfer mode 1 with DMA destination $2118
	STA.w $4320				;$00A44E	 |/
	LDA.w #$0BF6				;$00A451	 |\ Set DMA source to $000BF6
	STA.w $4322				;$00A454	 | |
	LDY.b #$00				;$00A457	 | |
	STY.w $4324				;$00A459	 |/
	LDA.w #$00C0				;$00A45C	 |\ Set the transfer to #$C0 bytes
	STA.w $4325				;$00A45F	 |/
	LDX.b #$04				;$00A462	 |\ Run DMA on channel 2
	STX.w $420B				;$00A464	 |/
	LDA.w #$65A0				;$00A467	 |\ Set VRAM destination to $65A0
	STA.w $2116				;$00A46A	 |/
	LDA.w #$0CB6				;$00A46D	 |\ Set DMA source to $000CB6
	STA.w $4322				;$00A470	 |/
	LDA.w #$00C0				;$00A473	 |\ Set the transfer to #$C0 bytes
	STA.w $4325				;$00A476	 |/
	STX.w $420B				;$00A479	 | Run DMA on channel 2
	SEP #$20				;$00A47C	 | 8 bit A
.return						;		 |
	RTS					;$00A47E	/ Done with tile 4A-4F and 5A-5F DMA

RAM_color_pointers:
	db $82,$06,$00,$05,$09,$00,$03,$07,$00

upload_palette:
	LDY.w $0680				;$00A488	\ Load the RAM palette pointer index
	LDX.w RAM_color_pointers+2,Y		;$00A48B	 |\ Load and store the pointers bank
	STX $02					;$00A48E	 |/
	STZ $01					;$00A490	 |\ Zero out the low and high byte of the pointer
	STZ $00					;$00A492	 |/
	STZ $04					;$00A494	 | Clear $04 for 16 bit access of $03
	LDA.w RAM_color_pointers+1,Y		;$00A496	 |\ Load the low and high byte into A
	XBA					;$00A499	 | |
	LDA.w RAM_color_pointers,Y		;$00A49A	 | |
	REP #$10				;$00A49D	 | | 16 bit X/Y
	TAY					;$00A49F	 |/ Use Y as the pointer index
.continue_upload				;		 |
	LDA [$00],Y				;$00A4A0	 |\ If number of bytes to transfer is zero
	BEQ .finished_upload			;$00A4A2	 |/ then the transfer is complete
	STX.w $4324				;$00A4A4	 | Set the source address bank
	STA.w $4325				;$00A4A7	 |\ Store the DMA size to the DMA register
	STA $03					;$00A4AA	 |/ and set the DMA size to a scratch RAM address
	STZ.w $4326				;$00A4AC	 | Clear the high size byte -- it is unneeded
	INY					;$00A4AF	 | Increase Y to the destination CGRAM address
	LDA [$00],Y				;$00A4B0	 |\ Set the CGRAM write address
	STA.w $2121				;$00A4B2	 |/
	REP #$20				;$00A4B5	 | 
	LDA.w #$2200				;$00A4B7	 |\ set DMA transfer mode #$00
	STA.w $4320				;$00A4BA	 |/ and set B-Bus destination to $2122
	INY					;$00A4BD	 |\ Increment Y to data
	TYA					;$00A4BE	 | | Move pointer to A
	STA.w $4322				;$00A4BF	 |/ Store the pointer as Source high/low byte.
	CLC					;$00A4C2	 |\ Add number of bytes transfered to pointer
	ADC $03					;$00A4C3	 | |
	TAY					;$00A4C5	 |/ Return pointer to Y
	SEP #$20				;$00A4C6	 |
	LDA.b #$04				;$00A4C8	 |\ Run DMA on channel 2
	STA.w $420B				;$00A4CA	 |/
	BRA .continue_upload			;$00A4CD	 | continue the transfer until there is no more data
.finished_upload:				;		 |
	SEP #$10				;$00A4CF	 | 
	JSR set_BG_color			;$00A4D1	 | Upload the BG color
	LDA.w $0680				;$00A4D4	 |\ if not special upload, don't clear the special
	BNE .skip_special_clear			;$00A4D7	 |/ upload index or number of bytes to transfer
	STZ.w $0681				;$00A4D9	 |\ Reset special palette index
	STZ.w $0682				;$00A4DC	 | | Clear number of bytes to transfer
.skip_special_clear				;		 | |
	STZ.w $0680				;$00A4DF	 |/ Return to special upload mode
palette_upload_return:				;		 |
	RTS					;$00A4E2	/ Finished uploading palettes

DMA_animated_OW_tiles:				;		\ 
	REP #$10				;$00A4E3	 | 16 bit XY
	LDA.b #$80				;$00A4E5	 |\ Set VRAM increment after writing to $2119
	STA.w $2115				;$00A4E7	 |/
	LDY.w #$0750				;$00A4EA	 |\ Set VRAM destination to #$0750
	STY.w $2116				;$00A4ED	 |/
	LDY.w #$1801				;$00A4F0	 |\ Set DMA transfer mode 1, DMA address $2118
	STY.w $4320				;$00A4F3	 |/
	LDY.w #$0AF6				;$00A4F6	 |\ Set DMA source as $0AF6 (OW animated tiles)
	STY.w $4322				;$00A4F9	 |/
	STZ.w $4324				;$00A4FC	 | Set DMA source bank as #$00
	LDY.w #$0160				;$00A4FF	 |\ Transfer #$160 bytes
	STY.w $4325				;$00A502	 |/
	LDA.b #$04				;$00A505	 |\ Run DMA channel 2
	STA.w $420B				;$00A507	 |/
	SEP #$10				;$00A50A	 | 8 bit XY
	LDA.w $13D9				;$00A50C	 |\ If the submap is switching don't bother
	CMP.b #$0A				;$00A50F	 | | updating the level tile palette animation
	BEQ palette_upload_return		;$00A511	 |/
	LDA.b #$6D				;$00A513	 | Load CGRAM color address
	JSR animate_yellow_level_tile		;$00A515	 | Set the yellow level tile palette animation
	LDA.b #$10				;$00A518	 |\ Set the palette table offset as #$10 (16 bytes)
	STA $00					;$00A51A	 |/
	LDA.b #$7D				;$00A51C	 | Load CGRAM color address
	JMP animate_red_level_tile		;$00A51E	/ Set the red level tile palette animation and return

OW_VRAM_DMA_offset:
	db $00,$04,$08,$0C

OW_layer_2_DMA_offsets:
	db $00,$08,$10,$18

DMA_OW_tilemap:					;		\ 
	LDA.b #$80				;$00A529	 |\ Set VRAM mode increment after $2119 writes
	STA.w $2115				;$00A52B	 |/
	STZ.w $2116				;$00A52E	 |\ Set the VRAM address to $3000 plus the block
	LDA.b #$30				;$00A531	 | | Offset, $3000 is the layer 2 tilemap
	CLC					;$00A533	 | |
	ADC.w OW_VRAM_DMA_offset,Y		;$00A534	 | |
	STA.w $2117				;$00A537	 |/
	LDX.b #$06				;$00A53A	 | Number of settings to load
.layer_2_DMA_copy_loop				;		 |\ DMA copy loop
	LDA.w .OW_layer_2_DMA_settings,X	;$00A53C	 | | DMA mode 1, destination $2118
	STA.w $4310,X				;$00A53F	 | | Source $7F4000, size $0800 byte
	DEX					;$00A542	 | |
	BPL .layer_2_DMA_copy_loop		;$00A543	 |/
	LDA.w $0DD6				;$00A545	 |\ Check the map of the current player
	LSR					;$00A548	 | |
	LSR					;$00A549	 | |
	TAX					;$00A54A	 | |
	LDA.w $1F11,X				;$00A54B	 | |
	BEQ .main_OW_DMA			;$00A54E	 |/ And branch if they are not going to a submap
	LDA.b #$60				;$00A550	 |\ Set the DMA source high byte to submap tile data
	STA.w $4313				;$00A552	 |/
.main_OW_DMA					;		 |
	LDA.w $4313				;$00A555	 |\ Offset the DMA source high byte to the current 
	CLC					;$00A558	 | | Block of layer 2 data
	ADC.w OW_layer_2_DMA_offsets,Y		;$00A559	 | |
	STA.w $4313				;$00A55C	 |/
	LDA.b #$02				;$00A55F	 |\ Run DMA on channel 1
	STA.w $420B				;$00A561	 |/
	LDA.b #$80				;$00A564	 |\ Set VRAM mode increment after $2119 writes
	STA.w $2115				;$00A566	 |/
	STZ.w $2116				;$00A569	 |\ Set the VRAM address to $2000 plus the block
	LDA.b #$20				;$00A56C	 | | Offset, $2000 is the layer 1 tilemap
	CLC					;$00A56E	 | |
	ADC.w OW_VRAM_DMA_offset,Y		;$00A56F	 | |
	STA.w $2117				;$00A572	 |/
	LDX.b #$06				;$00A575	 | Number of settings to load
.layer_1_DMA_copy_loop				;		 |\ DMA copy loop
	LDA.w .OW_layer_1_DMA_settings,X	;$00A577	 | | DMA mode 1, destination $2118
	STA.w $4310,X				;$00A57A	 | | Source $7EE400, size $0800 bytes
	DEX					;$00A57D	 | |
	BPL .layer_1_DMA_copy_loop		;$00A57E	 |/
	LDA.b #$02				;$00A580	 |\ Run DMA on channel 1
	STA.w $420B				;$00A582	 |/
	RTS					;$00A585	 / Finished with OW DMA

.OW_layer_2_DMA_settings
	db $01,$18,$00,$40,$7F,$00,$08

.OW_layer_1_DMA_settings
	db $01,$18,$00,$E4,$7E,$00,$08

CODE_00A594:
	PHB
	PHK					;$00A595	|
	PLB					;$00A596	|
	JSR CODE_00AD25				;$00A597	|
	PLB					;$00A59A	|
	RTL					;$00A59B	|

GM04Load:
	JSR CODE_0085FA
	JSR disable_controls			;$00A59F	|
	STZ.w $143A				;$00A5A2	|
	JSR SetUpScreen				;$00A5A5	|
	JSR GM04DoDMA				;$00A5A8	|
	JSL CODE_05809E				;$00A5AB	|
	LDA.w $0D9B				;$00A5AF	|
	BPL CODE_00A5B9				;$00A5B2	|
	JSR CODE_0097BC				;$00A5B4	|
	BRA CODE_00A5CF				;$00A5B7	|

CODE_00A5B9:
	JSR UploadSpriteGFX
	JSR LoadPalette				;$00A5BC	|
	JSL CODE_05BE8A				;$00A5BF	|
	JSR CODE_009FB8				;$00A5C3	|
	JSR CODE_00A5F9				;$00A5C6	|
	JSR DisableHDMA				;$00A5C9	|
	JSR CODE_009860				;$00A5CC	|
CODE_00A5CF:
	JSR CODE_00922F
	JSR KeepModeActive			;$00A5D2	|
	JSR CODE_008E1A				;$00A5D5	|
	REP #$30				;$00A5D8	|
	PHB					;$00A5DA	|
	LDX.w #$0703				;$00A5DB	|
	LDY.w #$0905				;$00A5DE	|
	LDA.w #$01EF				;$00A5E1	|
	MVN $00,$00				;$00A5E4	|
	PLB					;$00A5E7	|
	LDX.w $0701				;$00A5E8	|
	STX.w $0903				;$00A5EB	|
	SEP #$30				;$00A5EE	|
	JSR CODE_00919B				;$00A5F0	|
	JSR CODE_008494				;$00A5F3	|
	JMP CODE_0093F4				;$00A5F6	|

CODE_00A5F9:
	LDA.b #$E7
	TRB $14					;$00A5FB	|
CODE_00A5FD:
	JSL CODE_05BB39
	JSR DMA_animated_level_tiles		;$00A601	|
	INC $14					;$00A604	|
	LDA $14					;$00A606	|
	AND.b #$07				;$00A608	|
	BNE CODE_00A5FD				;$00A60A	|
	RTS					;$00A60C	|

DATA_00A60D:
	db $00,$01,$01,$01

DATA_00A611:
	db $0D,$00,$F3,$FF,$FE,$FF,$FE,$FF
	db $00,$00,$00,$00

DATA_00A61D:
	db $0A,$00,$00,$00,$1A,$1A,$0A,$0A
DATA_00A625:
	db $00,$80,$40,$00,$01,$02,$40,$00
	db $40,$00,$00,$00,$00,$02,$00,$00

CODE_00A635:
	LDA.w $14AD
	ORA.w $14AE				;$00A638	|
	ORA.w $190C				;$00A63B	|
	BNE CODE_00A64A				;$00A63E	|
	LDA.w $1490				;$00A640	|
	BEQ CODE_00A660				;$00A643	|
	LDA.w $0DDA				;$00A645	|
	BPL CODE_00A64F				;$00A648	|
CODE_00A64A:
	LDA.w $0DDA
	AND.b #$7F				;$00A64D	|
CODE_00A64F:
	ORA.b #$40
	STA.w $0DDA				;$00A651	|
	STZ.w $14AD				;$00A654	|
	STZ.w $14AE				;$00A657	|
	STZ.w $190C				;$00A65A	|
	STZ.w $1490				;$00A65D	|
CODE_00A660:
	LDA.w $13F4
	ORA.w $13F5				;$00A663	|
	ORA.w $13F6				;$00A666	|
	ORA.w $13F7				;$00A669	|
	ORA.w $13F8				;$00A66C	|
	BEQ CODE_00A674				;$00A66F	|
	STA.w $141B				;$00A671	|
CODE_00A674:
	LDX.b #$23
CODE_00A676:
	STZ $70,X
	DEX					;$00A678	|
	BNE CODE_00A676				;$00A679	|
	LDX.b #$37				;$00A67B	|
CODE_00A67D:
	STZ.w $13D9,X
	DEX					;$00A680	|
	BNE CODE_00A67D				;$00A681	|
	ASL.w $13CB				;$00A683	|
	STZ.w $149A				;$00A686	|
	STZ.w $1498				;$00A689	|
	STZ.w $1495				;$00A68C	|
	STZ.w $1419				;$00A68F	|
	LDY.b #$01				;$00A692	|
	LDX.w $1931				;$00A694	|
	CPX.b #$10				;$00A697	|
	BCS CODE_00A6CC				;$00A699	|
	LDA.w DATA_00A625,X			;$00A69B	|
	LSR					;$00A69E	|
	BEQ CODE_00A6CC				;$00A69F	|
	LDA.w $141D				;$00A6A1	|
	ORA.w $141A				;$00A6A4	|
	ORA.w $141F				;$00A6A7	|
	BNE CODE_00A6CC				;$00A6AA	|
	LDA.w $13CF				;$00A6AC	|
	BEQ CODE_00A6B6				;$00A6AF	|
	JSR CODE_00C90A				;$00A6B1	|
	BRA CODE_00A6CC				;$00A6B4	|

CODE_00A6B6:
	STZ $72
	STY $76					;$00A6B8	|
	STY $89					;$00A6BA	|
	LDX.b #$0A				;$00A6BC	|
	LDY.b #$00				;$00A6BE	|
	LDA.w $0DC1				;$00A6C0	|
	BEQ CODE_00A6C7				;$00A6C3	|
	LDY.b #$0F				;$00A6C5	|
CODE_00A6C7:
	STX $71
	STY $88					;$00A6C9	|
	RTS					;$00A6CB	|

CODE_00A6CC:
	LDA $1C
	CMP.b #$C0				;$00A6CE	|
	BEQ CODE_00A6D5				;$00A6D0	|
	INC.w $13F1				;$00A6D2	|
CODE_00A6D5:
	LDA.w $192A
	BEQ CODE_00A6E0				;$00A6D8	|
	CMP.b #$05				;$00A6DA	|
	BNE CODE_00A716				;$00A6DC	|
	ROR $86					;$00A6DE	|
CODE_00A6E0:
	STY $76
	LDA.b #$24				;$00A6E2	|
	STA $72					;$00A6E4	|
	STZ $9D					;$00A6E6	|
	LDA.w $1434				;$00A6E8	|
	BEQ CODE_00A704				;$00A6EB	|
	LDA.w $0DDA				;$00A6ED	|
	ORA.b #$7F				;$00A6F0	|
	STA.w $0DDA				;$00A6F2	|
	LDA $94					;$00A6F5	|
	ORA.b #$04				;$00A6F7	|
	STA.w $1436				;$00A6F9	|
	LDA $96					;$00A6FC	|
	CLC					;$00A6FE	|
	ADC.b #$10				;$00A6FF	|
	STA.w $1438				;$00A701	|
CODE_00A704:
	LDA.w $1B95
	BEQ Return00A715			;$00A707	|
	LDA.b #$08				;$00A709	|
	STA $71					;$00A70B	|
	LDA.b #$A0				;$00A70D	|
	STA $96					;$00A70F	|
	LDA.b #$90				;$00A711	|
	STA $7D					;$00A713	|
Return00A715:
	RTS

CODE_00A716:
	CMP.b #$06
	BCC CODE_00A740				;$00A718	|
	BNE CODE_00A734				;$00A71A	|
	STY $76					;$00A71C	|
	STY.w $13DF				;$00A71E	|
	LDA.b #$FF				;$00A721	|
	STA.w $1419				;$00A723	|
	LDA.b #$08				;$00A726	|
	TSB $94					;$00A728	|
	LDA.b #$02				;$00A72A	|
	TSB $96					;$00A72C	|
	LDX.b #$07				;$00A72E	|
	LDY.b #$20				;$00A730	|
	BRA CODE_00A6C7				;$00A732	|

CODE_00A734:
	STY $85
	LDA.w $13CF				;$00A736	|
	ORA.w $1434				;$00A739	|
	BNE CODE_00A6E0				;$00A73C	|
	LDA.b #$04				;$00A73E	|
CODE_00A740:
	CLC
	ADC.b #$03				;$00A741	|
	STA $89					;$00A743	|
	TAY					;$00A745	|
	LSR					;$00A746	|
	DEC A					;$00A747	|
	STA.w $1419				;$00A748	|
	LDA.w $A609,Y				;$00A74B	|
	STA $76					;$00A74E	|
	LDX.b #$05				;$00A750	|
	CPY.b #$06				;$00A752	|
	BCC CODE_00A768				;$00A754	|
	LDA.b #$08				;$00A756	|
	TSB $94					;$00A758	|
	LDX.b #$06				;$00A75A	|
	CPY.b #$07				;$00A75C	|
	LDY.b #$1E				;$00A75E	|
	BCC CODE_00A76A				;$00A760	|
	LDY.b #$0F				;$00A762	|
	LDA $19					;$00A764	|
	BEQ CODE_00A76A				;$00A766	|
CODE_00A768:
	LDY.b #$1C
CODE_00A76A:
	STY $7D
	JSR CODE_00A6C7				;$00A76C	|
	LDA.w $187A				;$00A76F	|
	BEQ Return00A795			;$00A772	|
	LDX $89					;$00A774	|
	LDA $88					;$00A776	|
	CLC					;$00A778	|
	ADC.w DATA_00A61D,X			;$00A779	|
	STA $88					;$00A77C	|
	TXA					;$00A77E	|
	ASL					;$00A77F	|
	TAX					;$00A780	|
	REP #$20				;$00A781	|
	LDA $94					;$00A783	|
	CLC					;$00A785	|
	ADC.w $A609,X				;$00A786	|
	STA $94					;$00A789	|
	LDA $96					;$00A78B	|
	CLC					;$00A78D	|
	ADC.w DATA_00A611,X			;$00A78E	|
	STA $96					;$00A791	|
	SEP #$20				;$00A793	|
Return00A795:
	RTS

CODE_00A796:
	REP #$20
	LDY.w $1414				;$00A798	|
	BEQ CODE_00A7B9				;$00A79B	|
	DEY					;$00A79D	|
	BNE CODE_00A7A7				;$00A79E	|
	LDA $20					;$00A7A0	|
	SEC					;$00A7A2	|
	SBC $1C					;$00A7A3	|
	BRA CODE_00A7B6				;$00A7A5	|

CODE_00A7A7:
	LDA $1C
	LSR					;$00A7A9	|
	DEY					;$00A7AA	|
	BEQ CODE_00A7AF				;$00A7AB	|
	LSR					;$00A7AD	|
	LSR					;$00A7AE	|
CODE_00A7AF:
	EOR.w #$FFFF
	INC A					;$00A7B2	|
	CLC					;$00A7B3	|
	ADC $20					;$00A7B4	|
CODE_00A7B6:
	STA.w $1417
CODE_00A7B9:
	LDA.w #$0080
	STA.w $142A				;$00A7BC	|
	SEP #$20				;$00A7BF	|
	RTS					;$00A7C1	|

DMA_transition_screen:				;		\ 
	REP #$20				;$00A7C2	 | 16 bit A, 8 bit XY
	LDX.b #$80				;$00A7C4	 |\ Set VRAM to increment after writing $2119
	STX.w $2115				;$00A7C6	 |/
	LDA.w #$6000				;$00A7C9	 |\ Set VRAM address to $6000 (layer three)
	STA.w $2116				;$00A7CC	 |/
	LDA.w #$1801				;$00A7CF	 |\ DMA mode 01(p, p+1), increment DMA address
	STA.w $4320				;$00A7D2	 |/ With $2118 as the destination.
	LDA.w #$977B				;$00A7D5	 |\ Set DMA source to $7F977B
	STA.w $4322				;$00A7D8	 |/
	LDX.b #$7F				;$00A7DB	 |\ Set DMA source bank to #$7F
	STX.w $4324				;$00A7DD	 |/
	LDA.w #$00C0				;$00A7E0	 |\ Set DMA size to #$C0 bytes
	STA.w $4325				;$00A7E3	 |/
	LDX.b #$04				;$00A7E6	 |\ Start DMA channel 3
	STX.w $420B				;$00A7E8	 |/
	LDA.w #$6100				;$00A7EB	 |\ Set VRAM address to $6100 (layer three)
	STA.w $2116				;$00A7EE	 |/
	LDA.w #$983B				;$00A7F1	 |\ Set DMA source to $7F983B
	STA.w $4322				;$00A7F4	 |/
	LDA.w #$00C0				;$00A7F7	 |\ Set DMA size to #$C0 bytes
	STA.w $4325				;$00A7FA	 |/
	STX.w $420B				;$00A7FD	 | Start DMA channel 3
	LDA.w #$64A0				;$00A800	 |\ Set VRAM address to $64A0 (layer three)
	STA.w $2116				;$00A803	 |/
	LDA.w #$98FB				;$00A806	 |\ Set DMA source to $7F98FB
	STA.w $4322				;$00A809	 |/
	LDA.w #$00C0				;$00A80C	 |\ Set DMA size to #$C0 bytes
	STA.w $4325				;$00A80F	 |/
	STX.w $420B				;$00A812	 | Start DMA channel 3
	LDA.w #$65A0				;$00A815	 |\ Set VRAM address to $65A0 (layer three)
	STA.w $2116				;$00A818	 |/
	LDA.w #$99BB				;$00A81B	 |\ Set DMA source to $7F99BB
	STA.w $4322				;$00A81E	 |/
	LDA.w #$00C0				;$00A821	 |\ Set DMA size to #$C0 bytes
	STA.w $4325				;$00A824	 |/
	STX.w $420B				;$00A827	 | Start DMA channel 3
	SEP #$20				;$00A82A	 | Restore 8 bit A
	RTS					;$00A82C	/ Done with transition screen DMA

CODE_00A82D:
	LDY.b #$0F
	JSL CODE_00BA28				;$00A82F	|
	LDA.w $1425				;$00A833	|
	REP #$30				;$00A836	|
	BEQ CODE_00A842				;$00A838	|
	LDA $00					;$00A83A	|
	CLC					;$00A83C	|
	ADC.w #$0030				;$00A83D	|
	STA $00					;$00A840	|
CODE_00A842:
	LDX.w #$0000
CODE_00A845:
	LDY.w #$0008
CODE_00A848:
	LDA [$00]
	STA.l $7F977B,X				;$00A84A	|
	INX					;$00A84E	|
	INX					;$00A84F	|
	INC $00					;$00A850	|
	INC $00					;$00A852	|
	DEY					;$00A854	|
	BNE CODE_00A848				;$00A855	|
	LDY.w #$0008				;$00A857	|
CODE_00A85A:
	LDA [$00]
	AND.w #$00FF				;$00A85C	|
	STA.l $7F977B,X				;$00A85F	|
	INX					;$00A863	|
	INX					;$00A864	|
	INC $00					;$00A865	|
	DEY					;$00A867	|
	BNE CODE_00A85A				;$00A868	|
	CPX.w #$0300				;$00A86A	|
	BCC CODE_00A845				;$00A86D	|
	SEP #$30				;$00A86F	|
	LDY.b #$00				;$00A871	|
	JSL CODE_00BA28				;$00A873	|
	REP #$30				;$00A877	|
	LDA.w #$B3F0				;$00A879	|
	STA $00					;$00A87C	|
	LDA.w #$7EB3				;$00A87E	|
	STA $01					;$00A881	|
	LDX.w #$0000				;$00A883	|
CODE_00A886:
	LDY.w #$0008
CODE_00A889:
	LDA [$00]
	STA.w $0BF6,X				;$00A88B	|
	INX					;$00A88E	|
	INX					;$00A88F	|
	INC $00					;$00A890	|
	INC $00					;$00A892	|
	DEY					;$00A894	|
	BNE CODE_00A889				;$00A895	|
	LDY.w #$0008				;$00A897	|
CODE_00A89A:
	LDA [$00]
	AND.w #$00FF				;$00A89C	|
	STA.w $0BF6,X				;$00A89F	|
	INX					;$00A8A2	|
	INX					;$00A8A3	|
	INC $00					;$00A8A4	|
	DEY					;$00A8A6	|
	BNE CODE_00A89A				;$00A8A7	|
	CPX.w #$00C0				;$00A8A9	|
	BNE CODE_00A8B3				;$00A8AC	|
	LDA.w #$B570				;$00A8AE	|
	STA $00					;$00A8B1	|
CODE_00A8B3:
	CPX.w #$0180
	BCC CODE_00A886				;$00A8B6	|
	SEP #$30				;$00A8B8	|
	LDA.b #$01				;$00A8BA	|
	STA.w $143A				;$00A8BC	|
	STA.w $1935				;$00A8BF	|
	RTS					;$00A8C2	|

SPRITEGFXLIST:
	db $00,$01,$13,$02,$00,$01,$12,$03
	db $00,$01,$13,$05,$00,$01,$13,$04
	db $00,$01,$13,$06,$00,$01,$13,$09
	db $00,$01,$13,$04,$00,$01,$06,$11
	db $00,$01,$13,$20,$00,$01,$13,$0F
	db $00,$01,$13,$23,$00,$01,$0D,$14
	db $00,$01,$24,$0E,$00,$01,$0A,$22
	db $00,$01,$13,$0E,$00,$01,$13,$14
	db $00,$00,$00,$08,$10,$0F,$1C,$1D
	db $00,$01,$24,$22,$00,$01,$25,$22
	db $00,$22,$13,$2D,$00,$01,$0F,$22
	db $00,$26,$2E,$22,$21,$0B,$25,$0A
	db $00,$0D,$24,$22,$2C,$30,$2D,$0E
OBJECTGFXLIST:
	db $14,$17,$19,$15,$14,$17,$1B,$18
	db $14,$17,$1B,$16,$14,$17,$0C,$1A
	db $14,$17,$1B,$08,$14,$17,$0C,$07
	db $14,$17,$0C,$16,$14,$17,$1B,$15
	db $14,$17,$19,$16,$14,$17,$0D,$1A
	db $14,$17,$1B,$08,$14,$17,$1B,$18
	db $14,$17,$19,$1F,$14,$17,$0D,$07
	db $14,$17,$19,$1A,$14,$17,$14,$14
	db $0E,$0F,$17,$17,$1C,$1D,$08,$1E
	db $1C,$1D,$08,$1E,$1C,$1D,$08,$1E
	db $1C,$1D,$08,$1E,$1C,$1D,$08,$1E
	db $1C,$1D,$08,$1E,$1C,$1D,$08,$1E
	db $14,$17,$19,$2C,$19,$17,$1B,$18

CODE_00A993:
	STZ.w $2116
	LDA.b #$40				;$00A996	|
	STA.w $2117				;$00A998	|
	LDA.b #$03				;$00A99B	|
	STA $0F					;$00A99D	|
	LDA.b #$28				;$00A99F	|
	STA $0E					;$00A9A1	|
CODE_00A9A3:
	LDA $0E
	TAY					;$00A9A5	|
	JSL CODE_00BA28				;$00A9A6	|
	REP #$30				;$00A9AA	|
	LDX.w #$03FF				;$00A9AC	|
	LDY.w #$0000				;$00A9AF	|
CODE_00A9B2:
	LDA [$00],Y
	STA.w $2118				;$00A9B4	|
	INY					;$00A9B7	|
	INY					;$00A9B8	|
	DEX					;$00A9B9	|
	BPL CODE_00A9B2				;$00A9BA	|
	SEP #$30				;$00A9BC	|
	INC $0E					;$00A9BE	|
	DEC $0F					;$00A9C0	|
	BPL CODE_00A9A3				;$00A9C2	|
	STZ.w $2116				;$00A9C4	|
	LDA.b #$60				;$00A9C7	|
	STA.w $2117				;$00A9C9	|
	LDY.b #$00				;$00A9CC	|
	JSR UploadGFXFile			;$00A9CE	|
	RTS					;$00A9D1	|

DATA_00A9D2:
	db $78,$70,$68,$60

DATA_00A9D6:
	db $18,$10,$08,$00

UploadSpriteGFX:
	LDA.b #$80
	STA.w $2115				;$00A9DC	|
	LDX.b #$03				;$00A9DF	|
	LDA.w $192B				;$00A9E1	|
	ASL					;$00A9E4	|
	ASL					;$00A9E5	|
	TAY					;$00A9E6	|
CODE_00A9E7:
	LDA.w SPRITEGFXLIST,Y
	STA $04,X				;$00A9EA	|
	INY					;$00A9EC	|
	DEX					;$00A9ED	|
	BPL CODE_00A9E7				;$00A9EE	|
	LDA.b #$03				;$00A9F0	|
	STA $0F					;$00A9F2	|
GFXTransferLoop:
	LDX $0F
	STZ.w $2116				;$00A9F6	|
	LDA.w DATA_00A9D2,X			;$00A9F9	|
	STA.w $2117				;$00A9FC	|
	LDY $04,X				;$00A9FF	|
	LDA.w $0101,X				;$00AA01	|
	CMP $04,X				;$00AA04	|
	BEQ DontUploadSpr			;$00AA06	|
	JSR UploadGFXFile			;$00AA08	|
DontUploadSpr:
	DEC $0F
	BPL GFXTransferLoop			;$00AA0D	|
	LDX.b #$03				;$00AA0F	|
UpdtCrrntSpritGFX:
	LDA $04,X
	STA.w $0101,X				;$00AA13	|
	DEX					;$00AA16	|
	BPL UpdtCrrntSpritGFX			;$00AA17	|
	LDA.w $1931				;$00AA19	|
	CMP.b #$FE				;$00AA1C	|
	BCS SetallFGBG80			;$00AA1E	|
	LDX.b #$03				;$00AA20	|
	LDA.w $1931				;$00AA22	|
	ASL					;$00AA25	|
	ASL					;$00AA26	|
	TAY					;$00AA27	|
PrepLoadFGBG:
	LDA.w OBJECTGFXLIST,Y
	STA $04,X				;$00AA2B	|
	INY					;$00AA2D	|
	DEX					;$00AA2E	|
	BPL PrepLoadFGBG			;$00AA2F	|
	LDA.b #$03				;$00AA31	|
	STA $0F					;$00AA33	|
CODE_00AA35:
	LDX $0F
	STZ.w $2116				;$00AA37	|
	LDA.w DATA_00A9D6,X			;$00AA3A	|
	STA.w $2117				;$00AA3D	|
	LDY $04,X				;$00AA40	|
	LDA.w $0105,X				;$00AA42	|
	CMP $04,X				;$00AA45	|
	BEQ NoUploadFGBG			;$00AA47	|
	JSR UploadGFXFile			;$00AA49	|
NoUploadFGBG:
	DEC $0F
	BPL CODE_00AA35				;$00AA4E	|
	LDX.b #$03				;$00AA50	|
UpdateCurrentFGBG:
	LDA $04,X
	STA.w $0105,X				;$00AA54	|
	DEX					;$00AA57	|
	BPL UpdateCurrentFGBG			;$00AA58	|
	RTS					;$00AA5A	|

SetallFGBG80:
	BEQ NoUpdateVRAM80
	JSR CODE_00AB42				;$00AA5D	|
NoUpdateVRAM80:
	LDX.b #$03
	LDA.b #$80				;$00AA62	|
Store80:
	STA.w $0105,X
	DEX					;$00AA67	|
	BPL Store80				;$00AA68	|
	RTS					;$00AA6A	|

UploadGFXFile:
	JSL CODE_00BA28
	CPY.b #$01				;$00AA6F	|
	BNE SkipSpecial				;$00AA71	|
	LDA.w $1EEB				;$00AA73	|
	BPL SkipSpecial				;$00AA76	|
	LDY.b #$31				;$00AA78	|
	JSL CODE_00BA28				;$00AA7A	|
	LDY.b #$01				;$00AA7E	|
SkipSpecial:
	REP #$20
	LDA.w #$0000				;$00AA82	|
	LDX.w $1931				;$00AA85	|
	CPX.b #$11				;$00AA88	|
	BCC CODE_00AA90				;$00AA8A	|
	CPY.b #$08				;$00AA8C	|
	BEQ JumpTo_____				;$00AA8E	|
CODE_00AA90:
	CPY.b #$1E
	BEQ JumpTo_____				;$00AA92	|
	BNE CODE_00AA99				;$00AA94	|
JumpTo_____:
	JMP FilterSomeRAM

CODE_00AA99:
	STA $0A
	LDA.w #$FFFF				;$00AA9B	|
	CPY.b #$01				;$00AA9E	|
	BEQ CODE_00AAA9				;$00AAA0	|
	CPY.b #$17				;$00AAA2	|
	BEQ CODE_00AAA9				;$00AAA4	|
	LDA.w #$0000				;$00AAA6	|
CODE_00AAA9:
	STA.w $1BBC
	LDY.b #$7F				;$00AAAC	|
CODE_00AAAE:
	LDA.w $1BBC
	BEQ CODE_00AACD				;$00AAB1	|
	CPY.b #$7E				;$00AAB3	|
	BCC CODE_00AABE				;$00AAB5	|
CODE_00AAB7:
	LDA.w #$FF00
	STA $0A					;$00AABA	|
	BNE CODE_00AACD				;$00AABC	|
CODE_00AABE:
	CPY.b #$6E
	BCC CODE_00AAC8				;$00AAC0	|
	CPY.b #$70				;$00AAC2	|
	BCS CODE_00AAC8				;$00AAC4	|
	BCC CODE_00AAB7				;$00AAC6	|
CODE_00AAC8:
	LDA.w #$0000
	STA $0A					;$00AACB	|
CODE_00AACD:
	LDX.b #$07
CODE_00AACF:
	LDA [$00]
	STA.w $2118				;$00AAD1	|
	XBA					;$00AAD4	|
	ORA [$00]				;$00AAD5	|
	STA.w $1BB2,X				;$00AAD7	|
	INC $00					;$00AADA	|
	INC $00					;$00AADC	|
	DEX					;$00AADE	|
	BPL CODE_00AACF				;$00AADF	|
	LDX.b #$07				;$00AAE1	|
CODE_00AAE3:
	LDA [$00]
	AND.w #$00FF				;$00AAE5	|
	STA $0C					;$00AAE8	|
	LDA [$00]				;$00AAEA	|
	XBA					;$00AAEC	|
	ORA.w $1BB2,X				;$00AAED	|
	AND $0A					;$00AAF0	|
	ORA $0C					;$00AAF2	|
	STA.w $2118				;$00AAF4	|
	INC $00					;$00AAF7	|
	DEX					;$00AAF9	|
	BPL CODE_00AAE3				;$00AAFA	|
	DEY					;$00AAFC	|
	BPL CODE_00AAAE				;$00AAFD	|
	SEP #$20				;$00AAFF	|
	RTS					;$00AB01	|

FilterSomeRAM:
	LDA.w #$FF00
	STA $0A					;$00AB05	|
	LDY.b #$7F				;$00AB07	|
UploadSomethingToVRAM:
	CPY.b #$08
	BCS CODE_00AB0D				;$00AB0B	|
CODE_00AB0D:
	LDX.b #$07
AddressWrite1:
	LDA [$00]
	STA.w $2118				;$00AB11	|
	XBA					;$00AB14	|
	ORA [$00]				;$00AB15	|
	STA.w $1BB2,X				;$00AB17	|
	INC $00					;$00AB1A	|
	INC $00					;$00AB1C	|
	DEX					;$00AB1E	|
	BPL AddressWrite1			;$00AB1F	|
	LDX.b #$07				;$00AB21	|
AddressWrite2:
	LDA [$00]
	AND.w #$00FF				;$00AB25	|
	STA $0C					;$00AB28	|
	LDA [$00]				;$00AB2A	|
	XBA					;$00AB2C	|
	ORA.w $1BB2,X				;$00AB2D	|
	AND $0A					;$00AB30	|
	ORA $0C					;$00AB32	|
	STA.w $2118				;$00AB34	|
	INC $00					;$00AB37	|
	DEX					;$00AB39	|
	BPL AddressWrite2			;$00AB3A	|
	DEY					;$00AB3C	|
	BPL UploadSomethingToVRAM		;$00AB3D	|
	SEP #$20				;$00AB3F	|
	RTS					;$00AB41	|

CODE_00AB42:
	LDY.b #$27
	JSL CODE_00BA28				;$00AB44	|
	REP #$10				;$00AB48	|
	LDY.w #$0000				;$00AB4A	|
	LDX.w #$03FF				;$00AB4D	|
CODE_00AB50:
	LDA [$00],Y
	STA $0F					;$00AB52	|
	JSR CODE_00ABC4				;$00AB54	|
	LDA $04					;$00AB57	|
	STA.w $2119				;$00AB59	|
	JSR CODE_00ABC4				;$00AB5C	|
	LDA $04					;$00AB5F	|
	STA.w $2119				;$00AB61	|
	STZ $04					;$00AB64	|
	ROL $0F					;$00AB66	|
	ROL $04					;$00AB68	|
	ROL $0F					;$00AB6A	|
	ROL $04					;$00AB6C	|
	INY					;$00AB6E	|
	LDA [$00],Y				;$00AB6F	|
	STA $0F					;$00AB71	|
	ROL $0F					;$00AB73	|
	ROL $04					;$00AB75	|
	LDA $04					;$00AB77	|
	STA.w $2119				;$00AB79	|
	JSR CODE_00ABC4				;$00AB7C	|
	LDA $04					;$00AB7F	|
	STA.w $2119				;$00AB81	|
	JSR CODE_00ABC4				;$00AB84	|
	LDA $04					;$00AB87	|
	STA.w $2119				;$00AB89	|
	STZ $04					;$00AB8C	|
	ROL $0F					;$00AB8E	|
	ROL $04					;$00AB90	|
	INY					;$00AB92	|
	LDA [$00],Y				;$00AB93	|
	STA $0F					;$00AB95	|
	ROL $0F					;$00AB97	|
	ROL $04					;$00AB99	|
	ROL $0F					;$00AB9B	|
	ROL $04					;$00AB9D	|
	LDA $04					;$00AB9F	|
	STA.w $2119				;$00ABA1	|
	JSR CODE_00ABC4				;$00ABA4	|
	LDA $04					;$00ABA7	|
	STA.w $2119				;$00ABA9	|
	JSR CODE_00ABC4				;$00ABAC	|
	LDA $04					;$00ABAF	|
	STA.w $2119				;$00ABB1	|
	INY					;$00ABB4	|
	DEX					;$00ABB5	|
	BPL CODE_00AB50				;$00ABB6	|
	LDX.w #$2000				;$00ABB8	|
CODE_00ABBB:
	STZ.w $2119
	DEX					;$00ABBE	|
	BNE CODE_00ABBB				;$00ABBF	|
	SEP #$10				;$00ABC1	|
	RTS					;$00ABC3	|

CODE_00ABC4:
	STZ $04
	ROL $0F					;$00ABC6	|
	ROL $04					;$00ABC8	|
	ROL $0F					;$00ABCA	|
	ROL $04					;$00ABCC	|
	ROL $0F					;$00ABCE	|
	ROL $04					;$00ABD0	|
	RTS					;$00ABD2	|

DATA_00ABD3:
	db $00,$18,$30,$48,$60,$78,$90,$A8
	db $00,$14,$28,$3C

DATA_00ABDF:
	db $00,$00,$38,$00,$70,$00,$A8,$00
	db $E0,$00,$18,$01,$50,$01

LoadPalette:
	REP #$30
	LDA.w #$7FDD				;$00ABEF	|
	STA $04					;$00ABF2	|
	LDX.w #$0002				;$00ABF4	|
	JSR LoadCol8Pal				;$00ABF7	|
	LDA.w #$7FFF				;$00ABFA	|
	STA $04					;$00ABFD	|
	LDX.w #$0102				;$00ABFF	|
	JSR LoadCol8Pal				;$00AC02	|
	LDA.w #$B170				;$00AC05	|
	STA $00					;$00AC08	|
	LDA.w #$0010				;$00AC0A	|
	STA $04					;$00AC0D	|
	LDA.w #$0007				;$00AC0F	|
	STA $06					;$00AC12	|
	LDA.w #$0001				;$00AC14	|
	STA $08					;$00AC17	|
	JSR LoadColors				;$00AC19	|
	LDA.w #$B250				;$00AC1C	|
	STA $00					;$00AC1F	|
	LDA.w #$0084				;$00AC21	|
	STA $04					;$00AC24	|
	LDA.w #$0005				;$00AC26	|
	STA $06					;$00AC29	|
	LDA.w #$0009				;$00AC2B	|
	STA $08					;$00AC2E	|
	JSR LoadColors				;$00AC30	|
	LDA.w $192F				;$00AC33	|
	AND.w #$000F				;$00AC36	|
	ASL					;$00AC39	|
	TAY					;$00AC3A	|
	LDA.w Palettes,Y			;$00AC3B	|
	STA.w $0701				;$00AC3E	|
	LDA.w #$B190				;$00AC41	|
	STA $00					;$00AC44	|
	LDA.w $192D				;$00AC46	|
	AND.w #$000F				;$00AC49	|
	TAY					;$00AC4C	|
	LDA.w DATA_00ABD3,Y			;$00AC4D	|
	AND.w #$00FF				;$00AC50	|
	CLC					;$00AC53	|
	ADC $00					;$00AC54	|
	STA $00					;$00AC56	|
	LDA.w #$0044				;$00AC58	|
	STA $04					;$00AC5B	|
	LDA.w #$0005				;$00AC5D	|
	STA $06					;$00AC60	|
	LDA.w #$0001				;$00AC62	|
	STA $08					;$00AC65	|
	JSR LoadColors				;$00AC67	|
	LDA.w #$B318				;$00AC6A	|
	STA $00					;$00AC6D	|
	LDA.w $192E				;$00AC6F	|
	AND.w #$000F				;$00AC72	|
	TAY					;$00AC75	|
	LDA.w DATA_00ABD3,Y			;$00AC76	|
	AND.w #$00FF				;$00AC79	|
	CLC					;$00AC7C	|
	ADC $00					;$00AC7D	|
	STA $00					;$00AC7F	|
	LDA.w #$01C4				;$00AC81	|
	STA $04					;$00AC84	|
	LDA.w #$0005				;$00AC86	|
	STA $06					;$00AC89	|
	LDA.w #$0001				;$00AC8B	|
	STA $08					;$00AC8E	|
	JSR LoadColors				;$00AC90	|
	LDA.w #$B0B0				;$00AC93	|
	STA $00					;$00AC96	|
	LDA.w $1930				;$00AC98	|
	AND.w #$000F				;$00AC9B	|
	TAY					;$00AC9E	|
	LDA.w DATA_00ABD3,Y			;$00AC9F	|
	AND.w #$00FF				;$00ACA2	|
	CLC					;$00ACA5	|
	ADC $00					;$00ACA6	|
	STA $00					;$00ACA8	|
	LDA.w #$0004				;$00ACAA	|
	STA $04					;$00ACAD	|
	LDA.w #$0005				;$00ACAF	|
	STA $06					;$00ACB2	|
	LDA.w #$0001				;$00ACB4	|
	STA $08					;$00ACB7	|
	JSR LoadColors				;$00ACB9	|
	LDA.w #$B674				;$00ACBC	|
	STA $00					;$00ACBF	|
	LDA.w #$0052				;$00ACC1	|
	STA $04					;$00ACC4	|
	LDA.w #$0006				;$00ACC6	|
	STA $06					;$00ACC9	|
	LDA.w #$0002				;$00ACCB	|
	STA $08					;$00ACCE	|
	JSR LoadColors				;$00ACD0	|
	LDA.w #$B674				;$00ACD3	|
	STA $00					;$00ACD6	|
	LDA.w #$0132				;$00ACD8	|
	STA $04					;$00ACDB	|
	LDA.w #$0006				;$00ACDD	|
	STA $06					;$00ACE0	|
	LDA.w #$0002				;$00ACE2	|
	STA $08					;$00ACE5	|
	JSR LoadColors				;$00ACE7	|
	SEP #$30				;$00ACEA	|
	RTS					;$00ACEC	|

LoadCol8Pal:
	LDY.w #$0007
CODE_00ACF0:
	LDA $04
	STA.w $0703,X				;$00ACF2	|
	TXA					;$00ACF5	|
	CLC					;$00ACF6	|
	ADC.w #$0020				;$00ACF7	|
	TAX					;$00ACFA	|
	DEY					;$00ACFB	|
	BPL CODE_00ACF0				;$00ACFC	|
	RTS					;$00ACFE	|

LoadColors:
	LDX $04
	LDY $06					;$00AD01	|
CODE_00AD03:
	LDA ($00)
	STA.w $0703,X				;$00AD05	|
	INC $00					;$00AD08	|
	INC $00					;$00AD0A	|
	INX					;$00AD0C	|
	INX					;$00AD0D	|
	DEY					;$00AD0E	|
	BPL CODE_00AD03				;$00AD0F	|
	LDA $04					;$00AD11	|
	CLC					;$00AD13	|
	ADC.w #$0020				;$00AD14	|
	STA $04					;$00AD17	|
	DEC $08					;$00AD19	|
	BPL LoadColors				;$00AD1B	|
	RTS					;$00AD1D	|

DATA_00AD1E:
	db $01,$00,$03,$04,$03,$05,$02

CODE_00AD25:
	REP #$30
	LDY.w #$B3D8				;$00AD27	|
	LDA.w $1EEA				;$00AD2A	|
	BPL CODE_00AD32				;$00AD2D	|
	LDY.w #$B732				;$00AD2F	|
CODE_00AD32:
	STY $00
	LDA.w $1931				;$00AD34	|
	AND.w #$000F				;$00AD37	|
	DEC A					;$00AD3A	|
	TAY					;$00AD3B	|
	LDA.w DATA_00AD1E,Y			;$00AD3C	|
	AND.w #$00FF				;$00AD3F	|
	ASL					;$00AD42	|
	TAY					;$00AD43	|
	LDA.w DATA_00ABDF,Y			;$00AD44	|
	CLC					;$00AD47	|
	ADC $00					;$00AD48	|
	STA $00					;$00AD4A	|
	LDA.w #$0082				;$00AD4C	|
	STA $04					;$00AD4F	|
	LDA.w #$0006				;$00AD51	|
	STA $06					;$00AD54	|
	LDA.w #$0003				;$00AD56	|
	STA $08					;$00AD59	|
	JSR LoadColors				;$00AD5B	|
	LDA.w #$B528				;$00AD5E	|
	STA $00					;$00AD61	|
	LDA.w #$0052				;$00AD63	|
	STA $04					;$00AD66	|
	LDA.w #$0006				;$00AD68	|
	STA $06					;$00AD6B	|
	LDA.w #$0005				;$00AD6D	|
	STA $08					;$00AD70	|
	JSR LoadColors				;$00AD72	|
	LDA.w #$B57C				;$00AD75	|
	STA $00					;$00AD78	|
	LDA.w #$0102				;$00AD7A	|
	STA $04					;$00AD7D	|
	LDA.w #$0006				;$00AD7F	|
	STA $06					;$00AD82	|
	LDA.w #$0007				;$00AD84	|
	STA $08					;$00AD87	|
	JSR LoadColors				;$00AD89	|
	LDA.w #$B5EC				;$00AD8C	|
	STA $00					;$00AD8F	|
	LDA.w #$0010				;$00AD91	|
	STA $04					;$00AD94	|
	LDA.w #$0007				;$00AD96	|
	STA $06					;$00AD99	|
	LDA.w #$0001				;$00AD9B	|
	STA $08					;$00AD9E	|
	JSR LoadColors				;$00ADA0	|
	SEP #$30				;$00ADA3	|
	RTS					;$00ADA5	|

CODE_00ADA6:
	REP #$30
	LDA.w #$B63C				;$00ADA8	|
	STA $00					;$00ADAB	|
	LDA.w #$0010				;$00ADAD	|
	STA $04					;$00ADB0	|
	LDA.w #$0007				;$00ADB2	|
	STA $06					;$00ADB5	|
	LDA.w #$0000				;$00ADB7	|
	STA $08					;$00ADBA	|
	JSR LoadColors				;$00ADBC	|
	LDA.w #$B62C				;$00ADBF	|
	STA $00					;$00ADC2	|
	LDA.w #$0030				;$00ADC4	|
	STA $04					;$00ADC7	|
	LDA.w #$0007				;$00ADC9	|
	STA $06					;$00ADCC	|
	LDA.w #$0000				;$00ADCE	|
	STA $08					;$00ADD1	|
	JSR LoadColors				;$00ADD3	|
	SEP #$30				;$00ADD6	|
	RTS					;$00ADD8	|

CODE_00ADD9:
	JSR LoadPalette
	REP #$30				;$00ADDC	|
	LDA.w #$0017				;$00ADDE	|
	STA.w $0701				;$00ADE1	|
	LDA.w #$B170				;$00ADE4	|
	STA $00					;$00ADE7	|
	LDA.w #$0010				;$00ADE9	|
	STA $04					;$00ADEC	|
	LDA.w #$0007				;$00ADEE	|
	STA $06					;$00ADF1	|
	LDA.w #$0001				;$00ADF3	|
	STA $08					;$00ADF6	|
	JSR LoadColors				;$00ADF8	|
	LDA.w #$B65C				;$00ADFB	|
	STA $00					;$00ADFE	|
	LDA.w #$0000				;$00AE00	|
	STA $04					;$00AE03	|
	LDA.w #$0007				;$00AE05	|
	STA $06					;$00AE08	|
	LDA.w #$0000				;$00AE0A	|
	STA $08					;$00AE0D	|
	JSR LoadColors				;$00AE0F	|
	SEP #$30				;$00AE12	|
	RTS					;$00AE14	|

CODE_00AE15:
	LDA.b #$02
	STA.w $192E				;$00AE17	|
	LDA.b #$07				;$00AE1A	|
	STA.w $192D				;$00AE1C	|
	JSR LoadPalette				;$00AE1F	|
	REP #$30				;$00AE22	|
	LDA.w #$0017				;$00AE24	|
	STA.w $0701				;$00AE27	|
	LDA.w #$B5F4				;$00AE2A	|
	STA $00					;$00AE2D	|
	LDA.w #$0018				;$00AE2F	|
	STA $04					;$00AE32	|
	LDA.w #$0003				;$00AE34	|
	STA $06					;$00AE37	|
	STZ $08					;$00AE39	|
	JSR LoadColors				;$00AE3B	|
	SEP #$30				;$00AE3E	|
	RTS					;$00AE40	|

RGB_offsets:
	db $00,$05,$0A

channel_intensity:
	db $20,$40,$80

set_BG_color:					;		\ 
	LDX.b #$02				;$00AE47	 | Load number of color channels to process
.next_channel					;		 |
	REP #$20				;$00AE49	 | Use 16 bit A to get the full color
	LDA.w $0701				;$00AE4B	 | Load the current BG color
	LDY.w RGB_offsets,X			;$00AE4E	 | Get the number of bits to shift
.loop						;		 |\ Get the current channel to the last 5 bits of A
	DEY					;$00AE51	 | |
	BMI .set_channel_intensity		;$00AE52	 | |
	LSR					;$00AE54	 | |
	BRA .loop				;$00AE55	 |/
.set_channel_intensity				;		 |
	SEP #$20				;$00AE57	 |\ Isolate color channel bits
	AND.b #$1F				;$00AE59	 |/
	ORA.w channel_intensity,X		;$00AE5B	 | Set which color channel to set
	STA.w $2132				;$00AE5E	 | Store color intensity
	DEX					;$00AE61	 |\ Decrement to do the next color channel
	BPL .next_channel			;$00AE62	 |/
	RTS					;$00AE64	/ Return after BG set

DATA_00AE65:
	db $1F,$00,$E0,$03,$00,$7C

DATA_00AE6B:
	db $FF,$FF,$E0,$FF,$00,$FC

DATA_00AE71:
	db $01,$00,$20,$00,$00,$04

DATA_00AE77:
	db $00,$00,$00,$00,$01,$00,$00,$00
	db $00,$80,$00,$80,$20,$80,$00,$04
	db $80,$80,$80,$80,$08,$82,$40,$10
	db $20,$84,$20,$84,$44,$88,$10,$22
	db $88,$88,$88,$88,$22,$91,$88,$44
	db $48,$92,$48,$92,$92,$A4,$24,$49
	db $A4,$A4,$A4,$A4,$49,$A9,$94,$52
	db $AA,$AA,$94,$52,$AA,$AA,$54,$55
	db $AA,$AA,$AA,$AA,$AA,$D5,$AA,$AA
	db $AA,$D5,$AA,$D5,$B5,$D6,$6A,$AD
	db $DA,$DA,$DA,$DA,$6D,$DB,$DA,$B6
	db $B6,$ED,$B6,$ED,$DD,$EE,$76,$BB
	db $EE,$EE,$EE,$EE,$BB,$F7,$EE,$DD
	db $DE,$FB,$DE,$FB,$F7,$FD,$BE,$EF
	db $FE,$FE,$FE,$FE,$DF,$FF,$FE,$FB
	db $FE,$FF,$FE,$FF,$FF,$FF,$FE,$FF
DATA_00AEF7:
	db $00,$80,$00,$40,$00,$20,$00,$10
	db $00,$08,$00,$04,$00,$02,$00,$01
	db $80,$00,$40,$00,$20,$00,$10,$00
	db $08,$00,$04,$00,$02,$00,$01,$00

CODE_00AF17:
	LDY.w $1493
	LDA $13					;$00AF1A	|
	LSR					;$00AF1C	|
	BCC CODE_00AF25				;$00AF1D	|
	DEY					;$00AF1F	|
	BEQ CODE_00AF25				;$00AF20	|
	STY.w $1493				;$00AF22	|
CODE_00AF25:
	CPY.b #$A0
	BCS CODE_00AF35				;$00AF27	|
	LDA.b #$04				;$00AF29	|
	TRB $40					;$00AF2B	|
	LDA.b #$09				;$00AF2D	|
	STA $3E					;$00AF2F	|
	JSL CODE_05CBFF				;$00AF31	|
CODE_00AF35:
	LDA $13
	AND.b #$03				;$00AF37	|
	BNE Return00AFA2			;$00AF39	|
	LDA.w $1495				;$00AF3B	|
	CMP.b #$40				;$00AF3E	|
	BCS Return00AFA2			;$00AF40	|
	JSR CODE_00AFA3				;$00AF42	|
	LDA.w #$01FE				;$00AF45	|
	STA.w $0905				;$00AF48	|
	LDX.w #$00EE				;$00AF4B	|
CODE_00AF4E:
	LDA.w #$0007
	STA $00					;$00AF51	|
CODE_00AF53:
	LDA.w $0905,X
	STA $02					;$00AF56	|
	LDA.w $0703,X				;$00AF58	|
	JSR CODE_00AFC0				;$00AF5B	|
	LDA $04					;$00AF5E	|
	STA.w $0905,X				;$00AF60	|
	DEX					;$00AF63	|
	DEX					;$00AF64	|
	DEC $00					;$00AF65	|
	BNE CODE_00AF53				;$00AF67	|
	TXA					;$00AF69	|
	SEC					;$00AF6A	|
	SBC.w #$0012				;$00AF6B	|
	TAX					;$00AF6E	|
	BPL CODE_00AF4E				;$00AF6F	|
	LDX.w #$0004				;$00AF71	|
CODE_00AF74:
	LDA.w $091F,X
	STA $02					;$00AF77	|
	LDA.w $071D,X				;$00AF79	|
	JSR CODE_00AFC0				;$00AF7C	|
	LDA $04					;$00AF7F	|
	STA.w $091F,X				;$00AF81	|
	DEX					;$00AF84	|
	DEX					;$00AF85	|
	BPL CODE_00AF74				;$00AF86	|
	LDA.w $0701				;$00AF88	|
	STA $02					;$00AF8B	|
	LDA.w $0903				;$00AF8D	|
	JSR CODE_00AFC0				;$00AF90	|
	LDA $04					;$00AF93	|
	STA.w $0701				;$00AF95	|
	SEP #$30				;$00AF98	|
	STZ.w $0A05				;$00AF9A	|
	LDA.b #$03				;$00AF9D	|
	STA.w $0680				;$00AF9F	|
Return00AFA2:
	RTS

CODE_00AFA3:
	TAY
	INC A					;$00AFA4	|
	INC A					;$00AFA5	|
	STA.w $1495				;$00AFA6	|
	TYA					;$00AFA9	|
	LSR					;$00AFAA	|
	LSR					;$00AFAB	|
	LSR					;$00AFAC	|
	LSR					;$00AFAD	|
	REP #$30				;$00AFAE	|
	AND.w #$0002				;$00AFB0	|
	STA $0C					;$00AFB3	|
	TYA					;$00AFB5	|
	AND.w #$001E				;$00AFB6	|
	TAY					;$00AFB9	|
	LDA.w DATA_00AEF7,Y			;$00AFBA	|
	STA $0E					;$00AFBD	|
	RTS					;$00AFBF	|

CODE_00AFC0:
	STA $0A
	AND.w #$001F				;$00AFC2	|
	ASL					;$00AFC5	|
	ASL					;$00AFC6	|
	STA $06					;$00AFC7	|
	LDA $0A					;$00AFC9	|
	AND.w #$03E0				;$00AFCB	|
	LSR					;$00AFCE	|
	LSR					;$00AFCF	|
	LSR					;$00AFD0	|
	STA $08					;$00AFD1	|
	LDA $0B					;$00AFD3	|
	AND.w #$007C				;$00AFD5	|
	STA $0A					;$00AFD8	|
	STZ $04					;$00AFDA	|
	LDY.w #$0004				;$00AFDC	|
CODE_00AFDF:
	PHY
	LDA.w $0006,Y				;$00AFE0	|
	ORA $0C					;$00AFE3	|
	TAY					;$00AFE5	|
	LDA.w DATA_00AE77,Y			;$00AFE6	|
	PLY					;$00AFE9	|
	AND $0E					;$00AFEA	|
	BEQ CODE_00AFF9				;$00AFEC	|
	LDA.w DATA_00AE6B,Y			;$00AFEE	|
	BIT.w $1493				;$00AFF1	|
	BPL CODE_00AFF9				;$00AFF4	|
	LDA.w DATA_00AE71,Y			;$00AFF6	|
CODE_00AFF9:
	CLC
	ADC $02					;$00AFFA	|
	AND.w DATA_00AE65,Y			;$00AFFC	|
	TSB $04					;$00AFFF	|
	DEY					;$00B001	|
	DEY					;$00B002	|
	BPL CODE_00AFDF				;$00B003	|
	RTS					;$00B005	|

CODE_00B006:
	PHB
	PHK					;$00B007	|
	PLB					;$00B008	|
	JSR CODE_00AFA3				;$00B009	|
	LDX.w #$006E				;$00B00C	|
CODE_00B00F:
	LDY.w #$0008
CODE_00B012:
	LDA.w $0907,X
	STA $02					;$00B015	|
	LDA.w $0783,X				;$00B017	|
	PHY					;$00B01A	|
	JSR CODE_00AFC0				;$00B01B	|
	PLY					;$00B01E	|
	LDA $04					;$00B01F	|
	STA.w $0907,X				;$00B021	|
	LDA.w $0783,X				;$00B024	|
	SEC					;$00B027	|
	SBC $04					;$00B028	|
	STA.w $0979,X				;$00B02A	|
	DEX					;$00B02D	|
	DEX					;$00B02E	|
	DEY					;$00B02F	|
	BNE CODE_00B012				;$00B030	|
	TXA					;$00B032	|
	SEC					;$00B033	|
	SBC.w #$0010				;$00B034	|
	TAX					;$00B037	|
	BPL CODE_00B00F				;$00B038	|
	SEP #$30				;$00B03A	|
	PLB					;$00B03C	|
	RTL					;$00B03D	|

CODE_00B03E:
	JSR CODE_00AF35
	LDA.w $0680				;$00B041	|
	CMP.b #$03				;$00B044	|
	BNE Return00B090			;$00B046	|
	LDA.b #$00				;$00B048	|
	STA $02					;$00B04A	|
	REP #$30				;$00B04C	|
	LDA.w $0D82				;$00B04E	|
	STA $00					;$00B051	|
	LDY.w #$0014				;$00B053	|
CODE_00B056:
	LDA [$00],Y
	STA.w $0A11,Y				;$00B058	|
	DEY					;$00B05B	|
	DEY					;$00B05C	|
	BPL CODE_00B056				;$00B05D	|
	LDA.w #$81EE				;$00B05F	|
	STA.w $0A05				;$00B062	|
	LDX.w #$00CE				;$00B065	|
CODE_00B068:
	LDA.w #$0007
	STA $00					;$00B06B	|
CODE_00B06D:
	LDA.w $0A25,X
	STA $02					;$00B070	|
	LDA.w $0823,X				;$00B072	|
	JSR CODE_00AFC0				;$00B075	|
	LDA $04					;$00B078	|
	STA.w $0A25,X				;$00B07A	|
	DEX					;$00B07D	|
	DEX					;$00B07E	|
	DEC $00					;$00B07F	|
	BNE CODE_00B06D				;$00B081	|
	TXA					;$00B083	|
	SEC					;$00B084	|
	SBC.w #$0012				;$00B085	|
	TAX					;$00B088	|
	BPL CODE_00B068				;$00B089	|
	SEP #$30				;$00B08B	|
	STZ.w $0AF5				;$00B08D	|
Return00B090:
	RTS

DATA_00B091:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF

Palettes:
	db $9F,$5B,$FB,$6F,$80,$5D,$00,$00
	db $22,$1D,$C3,$24,$93,$73,$FF,$7F
	db $49,$3A,$8B,$42,$CD,$4A,$0F,$53
	db $51,$5B,$93,$63,$FF,$7F,$00,$00
	db $20,$7F,$80,$7F,$E0,$7F,$E0,$7F
	db $42,$39,$08,$52,$CE,$6A,$12,$63
	db $55,$6B,$98,$73,$42,$39,$08,$52
	db $CE,$6A,$42,$39,$08,$52,$CE,$6A
	db $D6,$4E,$18,$57,$5A,$5F,$9C,$67
	db $DE,$6F,$FF,$77,$FF,$7F,$00,$00
	db $20,$7F,$80,$7F,$E0,$7F,$E0,$7F
	db $A3,$20,$48,$31,$AC,$3D,$CE,$39
	db $32,$3E,$B6,$4A,$A2,$20,$25,$2D
	db $68,$35,$8A,$35,$E4,$24,$52,$4A
	db $C8,$50,$CC,$59,$6D,$52,$EB,$58
	db $4C,$65,$D0,$5A,$80,$5D,$39,$7F
	db $93,$7E,$A8,$65,$48,$56,$28,$57
	db $62,$14,$46,$35,$A9,$45,$0D,$52
	db $B1,$62,$77,$7B,$00,$00,$1E,$7B
	db $9F,$7B,$99,$7F,$F6,$7F,$FC,$7F
	db $00,$00,$C5,$24,$49,$2D,$AD,$2D
	db $53,$22,$18,$3F,$60,$10,$81,$18
	db $A3,$1C,$E4,$1C,$09,$29,$4B,$25
	db $60,$09,$A4,$01,$E8,$01,$2C,$02
	db $91,$02,$F5,$02,$FF,$7F,$00,$00
	db $E0,$7E,$20,$7F,$80,$7F,$E0,$7F
	db $93,$73,$00,$00,$FB,$0C,$EB,$2F
	db $93,$73,$00,$00,$DD,$7F,$7F,$2D
	db $93,$73,$00,$00,$AB,$7A,$FF,$7F
	db $93,$73,$00,$00,$9B,$1E,$7F,$3B
	db $00,$00,$AF,$0D,$79,$2E,$E0,$25
	db $1C,$2B,$20,$03,$00,$00,$6B,$2D
	db $EF,$3D,$73,$4E,$18,$63,$9C,$73
	db $00,$00,$E9,$00,$0D,$22,$8E,$05
	db $33,$1A,$B7,$32,$00,$00,$E0,$2D
	db $E0,$52,$7F,$15,$5F,$32,$3F,$4B
	db $00,$00,$C8,$59,$CE,$72,$CB,$39
	db $30,$3E,$B3,$4A,$00,$00,$16,$00
	db $1B,$00,$5F,$01,$1F,$02,$1F,$03
	db $00,$00,$EC,$49,$4F,$52,$B2,$5A
	db $15,$67,$DB,$7F,$00,$00,$16,$00
	db $1B,$00,$5F,$01,$1F,$02,$1F,$03
	db $00,$00,$C9,$08,$4E,$19,$D3,$29
	db $78,$3E,$1D,$53,$00,$00,$C8,$14
	db $09,$1D,$6C,$29,$CF,$35,$32,$42
	db $EF,$55,$B5,$6E,$F7,$76,$39,$7F
	db $7B,$7F,$BD,$7F,$00,$00,$C9,$2C
	db $4E,$41,$D3,$55,$78,$6E,$1D,$7F
	db $00,$00,$E9,$01,$AC,$02,$2F,$03
	db $99,$03,$FE,$53,$00,$00,$00,$00
	db $00,$00,$8F,$3C,$D8,$61,$7F,$7E
	db $00,$00,$C5,$24,$49,$2D,$AD,$2D
	db $53,$22,$18,$3F,$00,$00,$16,$00
	db $1B,$00,$5F,$01,$1F,$02,$1F,$03
	db $CE,$39,$00,$00,$18,$63,$34,$7F
	db $95,$7F,$F8,$7F,$00,$00,$B7,$32
	db $FB,$67,$00,$02,$20,$03,$E0,$03
	db $00,$00,$71,$0D,$3F,$7C,$9B,$1E
	db $7F,$13,$FF,$03,$00,$00,$17,$28
	db $1F,$40,$29,$45,$AD,$59,$10,$66
	db $00,$00,$71,$0D,$9B,$1E,$7F,$3B
	db $FF,$7F,$FF,$7F,$00,$00,$CE,$39
	db $94,$52,$18,$63,$9C,$73,$5F,$2C
	db $00,$00,$FF,$01,$1F,$03,$FF,$03
	db $B7,$00,$3F,$02,$00,$00,$08,$6D
	db $AD,$6D,$31,$7E,$B7,$00,$3F,$02
	db $00,$00,$11,$00,$17,$00,$1F,$00
	db $B7,$00,$3F,$02,$00,$00,$E0,$01
	db $E0,$02,$E0,$03,$B7,$00,$3F,$02
	db $5F,$63,$1D,$58,$0A,$00,$1F,$39
	db $C4,$44,$08,$4E,$70,$67,$B6,$30
	db $DF,$35,$FF,$03,$3F,$4F,$1D,$58
	db $40,$11,$E0,$3F,$07,$3C,$AE,$7C
	db $B3,$7D,$00,$2F,$5F,$16,$FF,$03
	db $5F,$63,$1D,$58,$29,$25,$FF,$7F
	db $08,$00,$17,$00,$1F,$00,$7B,$57
	db $DF,$0D,$FF,$03,$1F,$3B,$1D,$58
	db $29,$25,$FF,$7F,$40,$11,$E0,$01
	db $E0,$02,$7B,$57,$DF,$0D,$FF,$03
	db $00,$00,$C5,$24,$49,$2D,$AD,$2D
	db $53,$22,$18,$3F,$23,$25,$C4,$35
	db $25,$3E,$86,$46,$E7,$4E,$1F,$40
	db $00,$00,$C6,$41,$54,$73,$FA,$7F
	db $FD,$7F,$08,$6D,$00,$00,$34,$34
	db $3A,$44,$9F,$65,$16,$01,$7F,$02
	db $00,$00,$C5,$24,$49,$2D,$AD,$2D
	db $53,$22,$18,$3F,$00,$00,$AE,$2D
	db $32,$3E,$B6,$4A,$F9,$52,$F3,$2C
	db $00,$00,$6B,$51,$6D,$4E,$B3,$4F
	db $BF,$30,$1D,$37,$32,$2E,$0D,$4A
	db $88,$10,$4A,$21,$6D,$29,$CF,$3D
	db $00,$00,$40,$29,$E0,$3D,$80,$52
	db $B7,$00,$3F,$02,$00,$00,$CE,$39
	db $94,$52,$18,$63,$B7,$00,$3F,$02
	db $00,$00,$70,$7E,$D3,$7E,$36,$7F
	db $99,$7F,$1F,$40,$00,$00,$CE,$39
	db $94,$52,$18,$63,$9C,$73,$5F,$2C
	db $00,$00,$DF,$4E,$DE,$5A,$BD,$66
	db $7C,$72,$1F,$40,$00,$00,$F5,$7F
	db $F7,$7F,$F9,$7F,$FC,$7F,$FF,$7F
BowserEndPalette:
	db $00,$00,$FB,$63,$0C,$03,$0B,$02
	db $35,$15,$5F,$1A

DATA_00B3CC:
	db $00,$00,$34,$34,$3A,$44,$9F,$65
	db $16,$01,$7F,$02,$00,$00,$28,$12
	db $A8,$12,$48,$13,$7B,$32,$BF,$5B
	db $60,$7D,$00,$00,$DE,$7B,$48,$13
	db $60,$7D,$7B,$32,$BF,$37,$7F,$2D
	db $00,$00,$68,$32,$E8,$32,$48,$13
	db $FF,$5E,$7F,$6F,$60,$7D,$00,$00
	db $DE,$7B,$3B,$57,$A0,$7E,$F6,$01
	db $A8,$12,$48,$13,$00,$00,$28,$12
	db $A8,$12,$48,$13,$7B,$32,$BF,$5B
	db $28,$7E,$00,$00,$DE,$7B,$48,$13
	db $28,$7E,$7B,$32,$BF,$37,$FF,$03
	db $00,$00,$12,$32,$75,$3E,$3B,$57
	db $7B,$32,$BF,$5B,$28,$7E,$00,$00
	db $DE,$7B,$3B,$57,$28,$7E,$7B,$32
	db $C4,$38,$48,$13,$C7,$2C,$F0,$69
	db $B2,$66,$D5,$67,$34,$66,$DE,$53
	db $FF,$7F,$C7,$2C,$60,$45,$80,$66
	db $F7,$7F,$1F,$03,$7F,$03,$FF,$47
	db $2C,$41,$F0,$69,$B2,$66,$D5,$67
	db $1F,$00,$FF,$7F,$C7,$2C,$C7,$2C
	db $F0,$69,$B2,$66,$D5,$67,$2C,$41
	db $D5,$3A,$9C,$5B,$00,$00,$EC,$49
	db $2E,$56,$F1,$62,$26,$31,$BF,$5B
	db $00,$00,$00,$00,$DE,$7B,$95,$57
	db $28,$7E,$26,$31,$BF,$37,$7F,$2D
	db $00,$00,$26,$31,$89,$3D,$EC,$49
	db $26,$31,$BF,$5B,$28,$7E,$00,$00
	db $DE,$7B,$3B,$57,$C6,$32,$26,$31
	db $7F,$03,$7F,$03,$00,$00,$05,$1A
	db $C5,$0A,$EF,$22,$75,$1A,$59,$43
	db $60,$7D,$00,$00,$39,$77,$EF,$22
	db $60,$7D,$18,$1E,$5C,$37,$09,$7E
	db $00,$00,$60,$36,$20,$4B,$EF,$22
	db $5A,$4E,$3A,$53,$60,$7D,$00,$00
	db $7B,$32,$EF,$22,$19,$21,$F6,$01
	db $E6,$2D,$A8,$36,$C7,$2C,$F0,$69
	db $00,$00,$00,$00,$34,$66,$F9,$7F
	db $FF,$7F,$00,$00,$60,$45,$80,$66
	db $F7,$7F,$1F,$03,$7F,$03,$FF,$47
	db $2C,$41,$F0,$69,$B2,$66,$D5,$67
	db $1F,$00,$FF,$7F,$C7,$2C,$C7,$2C
	db $F0,$69,$B2,$66,$D5,$67,$2C,$41
	db $D5,$3A,$9C,$5B,$00,$00,$E7,$2C
	db $6B,$3D,$EF,$4D,$73,$5E,$F7,$6E
	db $FF,$7F,$F1,$7F,$BF,$01,$00,$7E
	db $BF,$03,$E0,$03,$FC,$7F,$FF,$7F
	db $00,$00,$4F,$19,$78,$3E,$3E,$57
	db $20,$7E,$E0,$7E,$E0,$7F,$00,$00
	db $31,$52,$F6,$66,$9C,$7B,$85,$16
	db $4B,$2F,$F1,$47,$00,$00,$4F,$19
	db $78,$3E,$3E,$57,$FF,$03,$DE,$7B
	db $1F,$7C,$00,$00,$4F,$19,$78,$3E
	db $3E,$57,$7F,$2D,$4B,$2F,$F1,$47
	db $FF,$7F,$00,$00,$71,$0D,$7F,$03
	db $FF,$4F,$3F,$4F,$E0,$7F,$FF,$7F
	db $00,$00,$E0,$01,$AD,$7D,$80,$03
	db $B7,$00,$3F,$02,$FF,$7F,$00,$00
	db $16,$00,$1F,$00,$08,$6D,$DD,$2D
	db $5F,$63,$FF,$7F,$00,$00,$80,$02
	db $E0,$03,$08,$6D,$1A,$26,$3B,$57
	db $FF,$7F,$00,$00,$E0,$7E,$20,$7F
	db $80,$7F,$E0,$7F,$E0,$7F,$FF,$7F
	db $00,$00,$E0,$7E,$20,$7F,$80,$7F
	db $E0,$7F,$E0,$7F,$00,$00,$1B,$00
	db $2D,$46,$F3,$5E,$85,$16,$4B,$2F
	db $F1,$47

DATA_00B5DE:
	db $00,$00,$E7,$2C,$6B,$3D,$EF,$4D
	db $73,$5E,$F7,$6E,$FF,$7F,$93,$73
	db $00,$00,$FF,$03,$3B,$57,$93,$73
	db $75,$3E,$12,$32,$AF,$25,$93,$73
	db $3B,$57,$FF,$7F,$00,$00,$93,$73
	db $00,$00,$3B,$57,$6C,$7E

animated_palettes:
	db $DF,$02,$5F,$03,$FF,$27,$FF,$5F
	db $FF,$73,$FF,$5F,$FF,$27,$5F,$03
	db $BF,$01,$1F,$00,$1B,$00,$18,$00
	db $18,$00,$1B,$00,$1F,$00,$BF,$01
	db $7F,$43,$00,$00,$60,$7F,$3F,$17
	db $7F,$43,$00,$00,$FF,$1C,$20,$03
	db $7F,$43,$00,$00,$20,$03,$60,$7F
	db $7F,$43,$BF,$5B,$7B,$32,$E7,$08
	db $00,$7E,$20,$7E,$A0,$7E,$E0,$7E
	db $20,$7F,$80,$7F,$E0,$7F,$E0,$7F
	db $00,$00,$E0,$1C,$E8,$3D,$F0,$5E
	db $F8,$7F,$FF,$7F,$85,$16,$4B,$2F
	

DATA_00B66C:
	db $93,$73,$00,$00,$71,$0D,$9B,$1E
	db $FF,$7F,$00,$00,$20,$03,$16,$00
	db $1F,$00,$7F,$01,$9F,$02,$FF,$7F
	db $00,$00,$20,$03,$7D,$34,$1E,$55
	db $FF,$65,$1F,$7B,$FF,$7F,$00,$00
	db $20,$03,$80,$03,$F1,$1F,$F9,$03
	db $FF,$4F

DATA_00B69E:
	db $FF,$7F,$C0,$18,$FB,$63,$0C,$03
	db $0B,$02,$35,$15,$5F,$1A,$9B,$77
	db $60,$18,$97,$5B,$A8,$02,$A7,$01
	db $D1,$0C,$FB,$11,$37,$6F,$00,$18
	db $33,$53,$45,$02,$43,$01,$6E,$04
	db $97,$09,$D3,$66,$00,$10,$CF,$4A
	db $E1,$01,$E0,$00,$0A,$00,$33,$01
	db $6F,$5E,$00,$00,$6B,$42,$80,$01
	db $80,$00,$06,$00,$CF,$00,$0B,$56
	db $00,$00,$07,$3A,$20,$01,$20,$00
	db $02,$00,$6B,$00,$A7,$4D,$00,$00
	db $A3,$31,$C0,$00,$00,$00,$00,$00
	db $07,$00,$43,$45,$00,$00,$40,$29
	db $60,$00,$00,$00,$00,$00,$03,$00
TheEndPalettes:
	db $C4,$44,$20,$03,$DF,$4A,$00,$02
	db $3B,$01,$08,$4E

DATA_00B71A:
	db $C4,$44,$1F,$39,$DF,$4A,$74,$28
	db $3F,$01,$08,$4E

DATA_00B726:
	db $D2,$28,$1E,$55,$5F,$63,$1F,$7B
	db $FB,$01,$DE,$02,$00,$00,$33,$15
	db $B7,$25,$3B,$36,$AF,$25,$BF,$5B
	db $C6,$5A,$00,$00,$DE,$7B,$3B,$36
	db $C6,$5A,$AF,$25,$BF,$37,$7F,$2D
	db $00,$00,$33,$15,$B7,$25,$3B,$36
	db $FF,$5E,$7F,$6F,$C6,$5A,$00,$00
	db $DE,$7B,$3B,$57,$C6,$5A,$AF,$25
	db $A8,$12,$48,$13,$00,$00,$B7,$25
	db $3B,$36,$BF,$46,$AF,$25,$5F,$5B
	db $C6,$5A,$00,$00,$DE,$7B,$BF,$46
	db $C6,$5A,$AF,$25,$BF,$37,$FF,$03
	db $00,$00,$85,$16,$4B,$2F,$F1,$47
	db $AF,$25,$5F,$5B,$C6,$5A,$00,$00
	db $DE,$7B,$3B,$57,$C6,$5A,$AF,$25
	db $C4,$38,$48,$13,$E7,$1C,$F3,$19
	db $B9,$32,$7F,$4B,$10,$76,$B9,$2E
	db $FF,$7F,$E7,$1C,$60,$45,$80,$66
	db $F7,$7F,$1F,$03,$7F,$03,$FF,$47
	db $E7,$1C,$F3,$19,$B9,$32,$7F,$4B
	db $1F,$00,$FF,$7F,$E7,$1C,$E7,$1C
	db $F3,$19,$B9,$32,$7F,$4B,$C6,$58
	db $D5,$3A,$9C,$5B,$00,$00,$6D,$1D
	db $D0,$29,$33,$36,$6B,$2D,$F9,$4E
	db $00,$00,$00,$00,$DE,$7B,$33,$36
	db $82,$30,$6B,$2D,$BF,$37,$7F,$2D
	db $00,$00,$A7,$00,$2B,$15,$8E,$21
	db $6B,$2D,$F9,$4E,$82,$30,$00,$00
	db $DE,$7B,$F9,$4E,$82,$30,$6B,$2D
	db $82,$30,$48,$13,$00,$00,$71,$21
	db $F5,$31,$79,$32,$F6,$41,$3B,$57
	db $60,$7D,$00,$00,$39,$77,$79,$32
	db $60,$7D,$18,$1E,$5C,$37,$09,$7E
	db $00,$00,$60,$36,$20,$4B,$EF,$22
	db $7A,$52,$3A,$53,$60,$7D,$00,$00
	db $8E,$21,$79,$32,$19,$21,$75,$3E
	db $35,$11,$98,$1D,$C7,$2C,$F0,$69
	db $00,$00,$00,$00,$34,$66,$F9,$7F
	db $FF,$7F,$00,$00,$60,$45,$80,$66
	db $F7,$7F,$1F,$03,$7F,$03,$FF,$47
	db $2C,$41,$F0,$69,$B2,$66,$D5,$67
	db $1F,$00,$FF,$7F,$C7,$2C,$C7,$2C
	db $F0,$69,$B2,$66,$D5,$67,$2C,$41
	db $D5,$3A,$9C,$5B,$C0,$BF,$08,$00
	db $80,$08

CODE_00B888:
	REP #$10
	LDY.w #$BFC0				;$00B88A	|
	STY $8A					;$00B88D	|
	LDA.b #$08				;$00B88F	|
	STA $8C					;$00B891	|
	LDY.w #$2000				;$00B893	|
	STY $00					;$00B896	|
	LDA.b #$7E				;$00B898	|
	STA $02					;$00B89A	|
	JSR CODE_00B8DE				;$00B89C	|
	LDA.b #$7E				;$00B89F	|
	STA $8F					;$00B8A1	|
	REP #$30				;$00B8A3	|
	LDA.w #$ACFE				;$00B8A5	|
	STA $8D					;$00B8A8	|
	LDX.w #$23FF				;$00B8AA	|
CODE_00B8AD:
	LDY.w #$0008
CODE_00B8B0:
	LDA.l $7E2000,X
	AND.w #$00FF				;$00B8B4	|
	STA [$8D]				;$00B8B7	|
	DEX					;$00B8B9	|
	DEC $8D					;$00B8BA	|
	DEC $8D					;$00B8BC	|
	DEY					;$00B8BE	|
	BNE CODE_00B8B0				;$00B8BF	|
	LDY.w #$0008				;$00B8C1	|
CODE_00B8C4:
	DEX
	LDA.l $7E2000,X				;$00B8C5	|
	STA [$8D]				;$00B8C9	|
	DEX					;$00B8CB	|
	BMI CODE_00B8D7				;$00B8CC	|
	DEC $8D					;$00B8CE	|
	DEC $8D					;$00B8D0	|
	DEY					;$00B8D2	|
	BNE CODE_00B8C4				;$00B8D3	|
	BRA CODE_00B8AD				;$00B8D5	|

CODE_00B8D7:
	LDA.w #$8000
	STA $8A					;$00B8DA	|
	SEP #$20				;$00B8DC	|
CODE_00B8DE:
	REP #$10
	LDY.w #$0000				;$00B8E0	|
CODE_00B8E3:
	JSR ReadByte
	CMP.b #$FF				;$00B8E6	|
	BNE CODE_00B8ED				;$00B8E8	|
	SEP #$10				;$00B8EA	|
	RTS					;$00B8EC	|

CODE_00B8ED:
	STA $8F
	AND.b #$E0				;$00B8EF	|
	CMP.b #$E0				;$00B8F1	|
	BEQ CODE_00B8FF				;$00B8F3	|
	PHA					;$00B8F5	|
	LDA $8F					;$00B8F6	|
	REP #$20				;$00B8F8	|
	AND.w #$001F				;$00B8FA	|
	BRA CODE_00B911				;$00B8FD	|

CODE_00B8FF:
	LDA $8F
	ASL					;$00B901	|
	ASL					;$00B902	|
	ASL					;$00B903	|
	AND.b #$E0				;$00B904	|
	PHA					;$00B906	|
	LDA $8F					;$00B907	|
	AND.b #$03				;$00B909	|
	XBA					;$00B90B	|
	JSR ReadByte				;$00B90C	|
	REP #$20				;$00B90F	|
CODE_00B911:
	INC A
	STA $8D					;$00B912	|
	SEP #$20				;$00B914	|
	PLA					;$00B916	|
	BEQ CODE_00B930				;$00B917	|
	BMI CODE_00B966				;$00B919	|
	ASL					;$00B91B	|
	BPL CODE_00B93F				;$00B91C	|
	ASL					;$00B91E	|
	BPL CODE_00B94C				;$00B91F	|
	JSR ReadByte				;$00B921	|
	LDX $8D					;$00B924	|
CODE_00B926:
	STA [$00],Y
	INC A					;$00B928	|
	INY					;$00B929	|
	DEX					;$00B92A	|
	BNE CODE_00B926				;$00B92B	|
	JMP CODE_00B8E3				;$00B92D	|

CODE_00B930:
	JSR ReadByte
	STA [$00],Y				;$00B933	|
	INY					;$00B935	|
	LDX $8D					;$00B936	|
	DEX					;$00B938	|
	STX $8D					;$00B939	|
	BNE CODE_00B930				;$00B93B	|
	BRA CODE_00B8E3				;$00B93D	|

CODE_00B93F:
	JSR ReadByte
	LDX $8D					;$00B942	|
CODE_00B944:
	STA [$00],Y
	INY					;$00B946	|
	DEX					;$00B947	|
	BNE CODE_00B944				;$00B948	|
	BRA CODE_00B8E3				;$00B94A	|

CODE_00B94C:
	JSR ReadByte
	XBA					;$00B94F	|
	JSR ReadByte				;$00B950	|
	LDX $8D					;$00B953	|
CODE_00B955:
	XBA
	STA [$00],Y				;$00B956	|
	INY					;$00B958	|
	DEX					;$00B959	|
	BEQ CODE_00B963				;$00B95A	|
	XBA					;$00B95C	|
	STA [$00],Y				;$00B95D	|
	INY					;$00B95F	|
	DEX					;$00B960	|
	BNE CODE_00B955				;$00B961	|
CODE_00B963:
	JMP CODE_00B8E3

CODE_00B966:
	JSR ReadByte
	XBA					;$00B969	|
	JSR ReadByte				;$00B96A	|
	TAX					;$00B96D	|
CODE_00B96E:
	PHY
	TXY					;$00B96F	|
	LDA [$00],Y				;$00B970	|
	TYX					;$00B972	|
	PLY					;$00B973	|
	STA [$00],Y				;$00B974	|
	INY					;$00B976	|
	INX					;$00B977	|
	REP #$20				;$00B978	|
	DEC $8D					;$00B97A	|
	SEP #$20				;$00B97C	|
	BNE CODE_00B96E				;$00B97E	|
	JMP CODE_00B8E3				;$00B980	|

ReadByte:
	LDA [$8A]
	LDX $8A					;$00B985	|
	INX					;$00B987	|
	BNE CODE_00B98F				;$00B988	|
	LDX.w #$8000				;$00B98A	|
	INC $8C					;$00B98D	|
CODE_00B98F:
	STX $8A
	RTS					;$00B991	|

DATA_00B992:
	db $F9,$31,$BB,$52,$7D,$63,$6C,$10
	db $57,$A1,$15,$9C,$63,$D2,$CB,$E5
	db $1E,$AF,$BD,$10,$48,$E8,$74,$B4
	db $AD,$E4,$80,$66,$7E,$88,$7F,$43
	db $A1,$65,$CD,$CA,$E5,$B5,$21,$44
	db $6C,$A3,$7B,$F0,$B9,$06,$36,$85
	db $BB,$00

DATA_00B9C4:
	db $D9,$E2,$EC,$F5,$FF,$89,$93,$9D
	db $A6,$AF,$BA,$C3,$CD,$D5,$DD,$E6
	db $EF,$F7,$FF,$89,$93,$9A,$A3,$A9
	db $B2,$BB,$C3,$CC,$D4,$DC,$E6,$EE
	db $F6,$FF,$88,$91,$9A,$A3,$AE,$B7
	db $C0,$C6,$CB,$D0,$D7,$E0,$E9,$F1
	db $F3,$F8

DATA_00B9F6:
	db $08,$08,$08,$08,$08,$09,$09,$09
	db $09,$09,$09,$09,$09,$09,$09,$09
	db $09,$09,$09,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
	db $0A,$0A,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B

CODE_00BA28:
	PHB
	PHY					;$00BA29	|
	PHK					;$00BA2A	|
	PLB					;$00BA2B	|
	LDA.w DATA_00B992,Y			;$00BA2C	|
	STA $8A					;$00BA2F	|
	LDA.w DATA_00B9C4,Y			;$00BA31	|
	STA $8B					;$00BA34	|
	LDA.w DATA_00B9F6,Y			;$00BA36	|
	STA $8C					;$00BA39	|
	LDA.b #$00				;$00BA3B	|
	STA $00					;$00BA3D	|
	LDA.b #$AD				;$00BA3F	|
	STA $01					;$00BA41	|
	LDA.b #$7E				;$00BA43	|
	STA $02					;$00BA45	|
	JSR CODE_00B8DE				;$00BA47	|
	PLY					;$00BA4A	|
	PLB					;$00BA4B	|
	RTL					;$00BA4C	|

DATA_00BA4D:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF

DATA_00BA60:
	db $00,$B0,$60,$10,$C0,$70,$20,$D0
	db $80,$30,$E0,$90,$40,$F0,$A0,$50
DATA_00BA70:
	db $00,$B0,$60,$10,$C0,$70,$20,$D0
	db $80,$30,$E0,$90,$40,$F0,$A0,$50
DATA_00BA80:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00

DATA_00BA8E:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00

DATA_00BA9C:
	db $C8,$C9,$CB,$CD,$CE,$D0,$D2,$D3
	db $D5,$D7,$D8,$DA,$DC,$DD,$DF,$E1
DATA_00BAAC:
	db $E3,$E4,$E6,$E8,$E9,$EB,$ED,$EE
	db $F0,$F2,$F3,$F5,$F7,$F8,$FA,$FC
DATA_00BABC:
	db $C8,$CA,$CC,$CE,$D0,$D2,$D4,$D6
	db $D8,$DA,$DC,$DE,$E0,$E2

DATA_00BACA:
	db $E4,$E6,$E8,$EA,$EC,$EE,$F0,$F2
	db $F4,$F6,$F8,$FA,$FC,$FE

DATA_00BAD8:
	db $00,$C8,$7E,$B0,$C9,$7E,$60,$CB
	db $7E,$10,$CD,$7E,$C0,$CE,$7E,$70
	db $D0,$7E,$20,$D2,$7E,$D0,$D3,$7E
	db $80,$D5,$7E,$30,$D7,$7E,$E0,$D8
	db $7E,$90,$DA,$7E,$40,$DC,$7E,$F0
	db $DD,$7E,$A0,$DF,$7E,$50,$E1,$7E
DATA_00BB08:
	db $00,$E3,$7E,$B0,$E4,$7E,$60,$E6
	db $7E,$10,$E8,$7E,$C0,$E9,$7E,$70
	db $EB,$7E,$20,$ED,$7E,$D0,$EE,$7E
	db $80,$F0,$7E,$30,$F2,$7E,$E0,$F3
	db $7E,$90,$F5,$7E,$40,$F7,$7E,$F0
	db $F8,$7E,$A0,$FA,$7E,$50,$FC,$7E
DATA_00BB38:
	db $00,$C8,$7E,$00,$CA,$7E,$00,$CC
	db $7E,$00,$CE,$7E,$00,$D0,$7E,$00
	db $D2,$7E,$00,$D4,$7E,$00,$D6,$7E
	db $00,$D8,$7E,$00,$DA,$7E,$00,$DC
	db $7E,$00,$DE,$7E,$00,$E0,$7E,$00
	db $E2,$7E

DATA_00BB62:
	db $00,$E3,$7E,$B0,$E4,$7E,$60,$E6
	db $7E,$10,$E8,$7E,$C0,$E9,$7E,$70
	db $EB,$7E,$20,$ED,$7E,$D0,$EE,$7E
	db $80,$F0,$7E,$30,$F2,$7E,$E0,$F3
	db $7E,$90,$F5,$7E,$40,$F7,$7E,$F0
	db $F8,$7E,$A0,$FA,$7E,$50,$FC,$7E
DATA_00BB92:
	db $00,$C8,$7E,$B0,$C9,$7E,$60,$CB
	db $7E,$10,$CD,$7E,$C0,$CE,$7E,$70
	db $D0,$7E,$20,$D2,$7E,$D0,$D3,$7E
	db $80,$D5,$7E,$30,$D7,$7E,$E0,$D8
	db $7E,$90,$DA,$7E,$40,$DC,$7E,$F0
	db $DD,$7E,$A0,$DF,$7E,$50,$E1,$7E
DATA_00BBC2:
	db $00,$E4,$7E,$00,$E6,$7E,$00,$E8
	db $7E,$00,$EA,$7E,$00,$EC,$7E,$00
	db $EE,$7E,$00,$F0,$7E,$00,$F2,$7E
	db $00,$F4,$7E,$00,$F6,$7E,$00,$F8
	db $7E,$00,$FA,$7E,$00,$FC,$7E,$00
	db $FE,$7E

DATA_00BBEC:
	db $00,$C8,$7E,$00,$CA,$7E,$00,$CC
	db $7E,$00,$CE,$7E,$00,$D0,$7E,$00
	db $D2,$7E,$00,$D4,$7E,$00,$D6,$7E
	db $00,$D8,$7E,$00,$DA,$7E,$00,$DC
	db $7E,$00,$DE,$7E,$00,$E0,$7E,$00
	db $E2,$7E

DATA_00BC16:
	db $00,$E4,$7E,$00,$E6,$7E,$00,$E8
	db $7E,$00,$EA,$7E,$00,$EC,$7E,$00
	db $EE,$7E,$00,$F0,$7E,$00,$F2,$7E
	db $00,$F4,$7E,$00,$F6,$7E,$00,$F8
	db $7E,$00,$FA,$7E,$00,$FC,$7E,$00
	db $FE,$7E

DATA_00BC40:
	db $00,$C8,$7F,$B0,$C9,$7F,$60,$CB
	db $7F,$10,$CD,$7F,$C0,$CE,$7F,$70
	db $D0,$7F,$20,$D2,$7F,$D0,$D3,$7F
	db $80,$D5,$7F,$30,$D7,$7F,$E0,$D8
	db $7F,$90,$DA,$7F,$40,$DC,$7F,$F0
	db $DD,$7F,$A0,$DF,$7F,$50,$E1,$7F
DATA_00BC70:
	db $00,$E3,$7F,$B0,$E4,$7F,$60,$E6
	db $7F,$10,$E8,$7F,$C0,$E9,$7F,$70
	db $EB,$7F,$20,$ED,$7F,$D0,$EE,$7F
	db $80,$F0,$7F,$30,$F2,$7F,$E0,$F3
	db $7F,$90,$F5,$7F,$40,$F7,$7F,$F0
	db $F8,$7F,$A0,$FA,$7F,$50,$FC,$7F
DATA_00BCA0:
	db $00,$C8,$7F,$00,$CA,$7F,$00,$CC
	db $7F,$00,$CE,$7F,$00,$D0,$7F,$00
	db $D2,$7F,$00,$D4,$7F,$00,$D6,$7F
	db $00,$D8,$7F,$00,$DA,$7F,$00,$DC
	db $7F,$00,$DE,$7F,$00,$E0,$7F,$00
	db $E2,$7F

DATA_00BCCA:
	db $00,$E3,$7F,$B0,$E4,$7F,$60,$E6
	db $7F,$10,$E8,$7F,$C0,$E9,$7F,$70
	db $EB,$7F,$20,$ED,$7F,$D0,$EE,$7F
	db $80,$F0,$7F,$30,$F2,$7F,$E0,$F3
	db $7F,$90,$F5,$7F,$40,$F7,$7F,$F0
	db $F8,$7F,$A0,$FA,$7F,$50,$FC,$7F
DATA_00BCFA:
	db $00,$C8,$7F,$B0,$C9,$7F,$60,$CB
	db $7F,$10,$CD,$7F,$C0,$CE,$7F,$70
	db $D0,$7F,$20,$D2,$7F,$D0,$D3,$7F
	db $80,$D5,$7F,$30,$D7,$7F,$E0,$D8
	db $7F,$90,$DA,$7F,$40,$DC,$7F,$F0
	db $DD,$7F,$A0,$DF,$7F,$50,$E1,$7F
DATA_00BD2A:
	db $00,$E4,$7F,$00,$E6,$7F,$00,$E8
	db $7F,$00,$EA,$7F,$00,$EC,$7F,$00
	db $EE,$7F,$00,$F0,$7F,$00,$F2,$7F
	db $00,$F4,$7F,$00,$F6,$7F,$00,$F8
	db $7F,$00,$FA,$7F,$00,$FC,$7F,$00
	db $FE,$7F

DATA_00BD54:
	db $00,$C8,$7F,$00,$CA,$7F,$00,$CC
	db $7F,$00,$CE,$7F,$00,$D0,$7F,$00
	db $D2,$7F,$00,$D4,$7F,$00,$D6,$7F
	db $00,$D8,$7F,$00,$DA,$7F,$00,$DC
	db $7F,$00,$DE,$7F,$00,$E0,$7F,$00
	db $E2,$7F

DATA_00BD7E:
	db $00,$E4,$7F,$00,$E6,$7F,$00,$E8
	db $7F,$00,$EA,$7F,$00,$EC,$7F,$00
	db $EE,$7F,$00,$F0,$7F,$00,$F2,$7F
	db $00,$F4,$7F,$00,$F6,$7F,$00,$F8
	db $7F,$00,$FA,$7F,$00,$FC,$7F,$00
	db $FE,$7F

Ptrs00BDA8:
	dw DATA_00BAD8
	dw DATA_00BAD8
	dw DATA_00BAD8
	dw DATA_00BB38
	dw DATA_00BB38
	dw DATA_00BB92
	dw DATA_00BB92
	dw DATA_00BBEC
	dw DATA_00BBEC
	dw $0000
	dw DATA_00BBEC
	dw $0000
	dw DATA_00BAD8
	dw DATA_00BBEC
	dw DATA_00BAD8
	dw DATA_00BAD8
	dw $0000
	dw DATA_00BAD8
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw DATA_00BAD8
	dw DATA_00BAD8

Ptrs00BDE8:
	dw DATA_00BB08
	dw DATA_00BB08
	dw DATA_00BB08
	dw DATA_00BB62
	dw DATA_00BB62
	dw DATA_00BBC2
	dw DATA_00BBC2
	dw DATA_00BC16
	dw DATA_00BC16
	dw $0000
	dw DATA_00BC16
	dw $0000
	dw DATA_00BB08
	dw DATA_00BC16
	dw DATA_00BB08
	dw DATA_00BB08
	dw $0000
	dw DATA_00BB08
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw DATA_00BB08
	dw DATA_00BB08

Ptrs00BE28:
	dw DATA_00BC40
	dw DATA_00BC40
	dw DATA_00BC40
	dw DATA_00BCA0
	dw DATA_00BCA0
	dw DATA_00BCFA
	dw DATA_00BCFA
	dw DATA_00BD54
	dw DATA_00BD54
	dw $0000
	dw DATA_00BD54
	dw $0000
	dw DATA_00BC40
	dw DATA_00BD54
	dw DATA_00BC40
	dw DATA_00BC40
	dw $0000
	dw DATA_00BC40
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw DATA_00BC40
	dw DATA_00BC40

Ptrs00BE68:
	dw DATA_00BC70
	dw DATA_00BC70
	dw DATA_00BC70
	dw DATA_00BCCA
	dw DATA_00BCCA
	dw DATA_00BD2A
	dw DATA_00BD2A
	dw DATA_00BD7E
	dw DATA_00BD7E
	dw $0000
	dw DATA_00BD7E
	dw $0000
	dw DATA_00BC70
	dw DATA_00BD7E
	dw DATA_00BC70
	dw DATA_00BC70
	dw $0000
	dw DATA_00BC70
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw DATA_00BC70
	dw DATA_00BC70

LoadBlkPtrs:
	dw Ptrs00BDA8
	dw Ptrs00BDE8
LoadBlkTable2:
	dw Ptrs00BE28
	dw Ptrs00BE68

generate_tile:
	PHP
	REP #$30				;$00BEB1	|
	PHX					;$00BEB3	|
	LDA $9C					;$00BEB4	|
	AND.w #$00FF				;$00BEB6	|
	BNE CODE_00BEBE				;$00BEB9	|
ADDR_00BEBB:
	JMP CODE_00BFB9

CODE_00BEBE:
	LDA $9A
	STA $0C					;$00BEC0	|
	LDA $98					;$00BEC2	|
	STA $0E					;$00BEC4	|
	LDA.w #$0000				;$00BEC6	|
	SEP #$20				;$00BEC9	|
	LDA $5B					;$00BECB	|
	STA $09					;$00BECD	|
	LDA.w $1933				;$00BECF	|
	BEQ CODE_00BED6				;$00BED2	|
	LSR $09					;$00BED4	|
CODE_00BED6:
	LDY $0E
	LDA $09					;$00BED8	|
	AND.b #$01				;$00BEDA	|
	BEQ CODE_00BEEC				;$00BEDC	|
	LDA $9B					;$00BEDE	|
	STA $00					;$00BEE0	|
	LDA $99					;$00BEE2	|
	STA $9B					;$00BEE4	|
	LDA $00					;$00BEE6	|
	STA $99					;$00BEE8	|
	LDY $0C					;$00BEEA	|
CODE_00BEEC:
	CPY.w #$0200
	BCS ADDR_00BEBB				;$00BEEF	|
	LDA.w $1933				;$00BEF1	|
	ASL					;$00BEF4	|
	TAX					;$00BEF5	|
	LDA.l LoadBlkPtrs,X			;$00BEF6	|
	STA $65					;$00BEFA	|
	LDA.l LoadBlkPtrs+1,X			;$00BEFC	|
	STA $66					;$00BF00	|
	STZ $67					;$00BF02	|
	LDA.w $1925				;$00BF04	|
	ASL					;$00BF07	|
	TAY					;$00BF08	|
	LDA [$65],Y				;$00BF09	|
	STA $04					;$00BF0B	|
	INY					;$00BF0D	|
	LDA [$65],Y				;$00BF0E	|
	STA $05					;$00BF10	|
	STZ $06					;$00BF12	|
	LDA $9B					;$00BF14	|
	STA $07					;$00BF16	|
	ASL					;$00BF18	|
	CLC					;$00BF19	|
	ADC $07					;$00BF1A	|
	TAY					;$00BF1C	|
	LDA [$04],Y				;$00BF1D	|
	STA $6B					;$00BF1F	|
	STA $6E					;$00BF21	|
	INY					;$00BF23	|
	LDA [$04],Y				;$00BF24	|
	STA $6C					;$00BF26	|
	STA $6F					;$00BF28	|
	LDA.b #$7E				;$00BF2A	|
	STA $6D					;$00BF2C	|
	INC A					;$00BF2E	|
	STA $70					;$00BF2F	|
	LDA $09					;$00BF31	|
	AND.b #$01				;$00BF33	|
	BEQ CODE_00BF41				;$00BF35	|
	LDA $99					;$00BF37	|
	LSR					;$00BF39	|
	LDA $9B					;$00BF3A	|
	AND.b #$01				;$00BF3C	|
	JMP CODE_00BF46				;$00BF3E	|

CODE_00BF41:
	LDA $9B
	LSR					;$00BF43	|
	LDA $99					;$00BF44	|
CODE_00BF46:
	ROL
	ASL					;$00BF47	|
	ASL					;$00BF48	|
	ORA.b #$20				;$00BF49	|
	STA $04					;$00BF4B	|
	CPX.w #$0000				;$00BF4D	|
	BEQ CODE_00BF57				;$00BF50	|
	CLC					;$00BF52	|
	ADC.b #$10				;$00BF53	|
	STA $04					;$00BF55	|
CODE_00BF57:
	LDA $98
	AND.b #$F0				;$00BF59	|
	CLC					;$00BF5B	|
	ASL					;$00BF5C	|
	ROL					;$00BF5D	|
	STA $05					;$00BF5E	|
	ROL					;$00BF60	|
	AND.b #$03				;$00BF61	|
	ORA $04					;$00BF63	|
	STA $06					;$00BF65	|
	LDA $9A					;$00BF67	|
	AND.b #$F0				;$00BF69	|
	LSR					;$00BF6B	|
	LSR					;$00BF6C	|
	LSR					;$00BF6D	|
	STA $04					;$00BF6E	|
	LDA $05					;$00BF70	|
	AND.b #$C0				;$00BF72	|
	ORA $04					;$00BF74	|
	STA $07					;$00BF76	|
	REP #$20				;$00BF78	|
	LDA $09					;$00BF7A	|
	AND.w #$0001				;$00BF7C	|
	BNE CODE_00BF9B				;$00BF7F	|
	LDA $1A					;$00BF81	|
	SEC					;$00BF83	|
	SBC.w #$0080				;$00BF84	|
	TAX					;$00BF87	|
	LDY $1C					;$00BF88	|
	LDA.w $1933				;$00BF8A	|
	BEQ CODE_00BFB2				;$00BF8D	|
	LDX $1E					;$00BF8F	|
	LDA $20					;$00BF91	|
	SEC					;$00BF93	|
	SBC.w #$0080				;$00BF94	|
	TAY					;$00BF97	|
	JMP CODE_00BFB2				;$00BF98	|

CODE_00BF9B:
	LDX $1A
	LDA $1C					;$00BF9D	|
	SEC					;$00BF9F	|
	SBC.w #$0080				;$00BFA0	|
	TAY					;$00BFA3	|
	LDA.w $1933				;$00BFA4	|
	BEQ CODE_00BFB2				;$00BFA7	|
	LDA $1E					;$00BFA9	|
	SEC					;$00BFAB	|
	SBC.w #$0080				;$00BFAC	|
	TAX					;$00BFAF	|
	LDY $20					;$00BFB0	|
CODE_00BFB2:
	STX $08
	STY $0A					;$00BFB4	|
	JSR CODE_00BFBC				;$00BFB6	|
CODE_00BFB9:
	PLX
	PLP					;$00BFBA	|
	RTL					;$00BFBB	|

CODE_00BFBC:
	SEP #$30
	LDA $9C					;$00BFBE	|
	DEC A					;$00BFC0	|
	PHK					;$00BFC1	|
	PER $0003				;$00BFC2	|
	JML execute_pointer			;$00BFC5	|

TileGenerationPtr:
	dw CODE_00C074
	dw CODE_00C077
	dw CODE_00C077
	dw CODE_00C077
	dw CODE_00C077
	dw CODE_00C077
	dw CODE_00C077
	dw CODE_00C077
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C4
	dw CODE_00C0C1
	dw CODE_00C0C1
	dw CODE_00C1AC
	dw CODE_00C334
	dw CODE_00C334
	dw CODE_00C3D1

DATA_00BFFF:
	db $00,$00,$80,$00,$00,$01

DATA_00C005:
	db $80,$40,$20,$10,$08,$04,$02,$01

CODE_00C00D:
	REP #$30
	LDA $9A					;$00C00F	|
	AND.w #$FF00				;$00C011	|
	LSR					;$00C014	|
	LSR					;$00C015	|
	LSR					;$00C016	|
	LSR					;$00C017	|
	LSR					;$00C018	|
	LSR					;$00C019	|
	STA $04					;$00C01A	|
	LDA $9A					;$00C01C	|
	AND.w #$0080				;$00C01E	|
	LSR					;$00C021	|
	LSR					;$00C022	|
	LSR					;$00C023	|
	LSR					;$00C024	|
	LSR					;$00C025	|
	LSR					;$00C026	|
	LSR					;$00C027	|
	ORA $04					;$00C028	|
	STA $04					;$00C02A	|
	LDA $98					;$00C02C	|
	AND.w #$0100				;$00C02E	|
	BEQ CODE_00C03A				;$00C031	|
	LDA $04					;$00C033	|
	ORA.w #$0002				;$00C035	|
	STA $04					;$00C038	|
CODE_00C03A:
	LDA.w $13BE
	AND.w #$000F				;$00C03D	|
	ASL					;$00C040	|
	TAX					;$00C041	|
	LDA.l DATA_00BFFF,X			;$00C042	|
	CLC					;$00C046	|
	ADC $04					;$00C047	|
	STA $04					;$00C049	|
	TAY					;$00C04B	|
	LDA $9A					;$00C04C	|
	AND.w #$0070				;$00C04E	|
	LSR					;$00C051	|
	LSR					;$00C052	|
	LSR					;$00C053	|
	LSR					;$00C054	|
	TAX					;$00C055	|
	SEP #$20				;$00C056	|
	LDA.w $19F8,Y				;$00C058	|
	ORA.l DATA_00C005,X			;$00C05B	|
	STA.w $19F8,Y				;$00C05F	|
	RTS					;$00C062	|

DATA_00C063:
	db $7F,$BF,$DF,$EF,$F7,$FB,$FD,$FE
TileToGeneratePg0:
	db $25,$25,$25,$06,$49,$48,$2B,$A2
	db $C6

CODE_00C074:
	JSR CODE_00C00D
CODE_00C077:
	REP #$30
	LDA $98					;$00C079	|
	AND.w #$01F0				;$00C07B	|
	STA $04					;$00C07E	|
	LDA $9A					;$00C080	|
	LSR					;$00C082	|
	LSR					;$00C083	|
	LSR					;$00C084	|
	LSR					;$00C085	|
	AND.w #$000F				;$00C086	|
	ORA $04					;$00C089	|
	TAY					;$00C08B	|
	LDA $9C					;$00C08C	|
	AND.w #$00FF				;$00C08E	|
	TAX					;$00C091	|
	SEP #$20				;$00C092	|
	LDA [$6E],Y				;$00C094	|
	AND.b #$FE				;$00C096	|
	STA [$6E],Y				;$00C098	|
	LDA.l TileToGeneratePg0,X		;$00C09A	|
	STA [$6B],Y				;$00C09E	|
	REP #$20				;$00C0A0	|
	AND.w #$00FF				;$00C0A2	|
	ASL					;$00C0A5	|
	TAY					;$00C0A6	|
	JMP CODE_00C0FB				;$00C0A7	|

DATA_00C0AA:
	db $80,$40,$20,$10,$08,$04,$02,$01
TileToGeneratePg1:
	db $52,$1B,$23,$1E,$32,$13,$15,$16
	db $2B,$2C,$12,$68,$69,$32,$5E

CODE_00C0C1:
	JSR CODE_00C00D
CODE_00C0C4:
	REP #$30
	LDA $98					;$00C0C6	|
	AND.w #$01F0				;$00C0C8	|
	STA $04					;$00C0CB	|
	LDA $9A					;$00C0CD	|
	LSR					;$00C0CF	|
	LSR					;$00C0D0	|
	LSR					;$00C0D1	|
	LSR					;$00C0D2	|
	AND.w #$000F				;$00C0D3	|
	ORA $04					;$00C0D6	|
	TAY					;$00C0D8	|
	LDA $9C					;$00C0D9	|
	SEC					;$00C0DB	|
	SBC.w #$0009				;$00C0DC	|
	AND.w #$00FF				;$00C0DF	|
	TAX					;$00C0E2	|
	SEP #$20				;$00C0E3	|
	LDA [$6E],Y				;$00C0E5	|
	ORA.b #$01				;$00C0E7	|
	STA [$6E],Y				;$00C0E9	|
	LDA.l TileToGeneratePg1,X		;$00C0EB	|
	STA [$6B],Y				;$00C0EF	|
	REP #$20				;$00C0F1	|
	AND.w #$00FF				;$00C0F3	|
	ORA.w #$0100				;$00C0F6	|
	ASL					;$00C0F9	|
	TAY					;$00C0FA	|
CODE_00C0FB:
	LDA $5B
	STA $00					;$00C0FD	|
	LDA.w $1933				;$00C0FF	|
	BEQ CODE_00C106				;$00C102	|
	LSR $00					;$00C104	|
CODE_00C106:
	LDA $00
	AND.w #$0001				;$00C108	|
	BNE CODE_00C127				;$00C10B	|
	LDA $08					;$00C10D	|
	AND.w #$FFF0				;$00C10F	|
	BMI CODE_00C11A				;$00C112	|
	CMP $0C					;$00C114	|
	BEQ CODE_00C13E				;$00C116	|
	BCS CODE_00C124				;$00C118	|
CODE_00C11A:
	CLC
	ADC.w #$0200				;$00C11B	|
	CMP $0C					;$00C11E	|
	BEQ CODE_00C124				;$00C120	|
	BCS CODE_00C13E				;$00C122	|
CODE_00C124:
	JMP Return00C1AB

CODE_00C127:
	LDA $0A
	AND.w #$FFF0				;$00C129	|
	BMI CODE_00C134				;$00C12C	|
	CMP $0E					;$00C12E	|
	BEQ CODE_00C13E				;$00C130	|
	BCS Return00C1AB			;$00C132	|
CODE_00C134:
	CLC
	ADC.w #$0200				;$00C135	|
	CMP $0E					;$00C138	|
	BEQ Return00C1AB			;$00C13A	|
	BCC Return00C1AB			;$00C13C	|
CODE_00C13E:
	LDA.l $7F837B
	TAX					;$00C142	|
	SEP #$20				;$00C143	|
	LDA $06					;$00C145	|
	STA.l $7F837D,X				;$00C147	|
	STA.l $7F8385,X				;$00C14B	|
	LDA $07					;$00C14F	|
	STA.l $7F837E,X				;$00C151	|
	CLC					;$00C155	|
	ADC.b #$20				;$00C156	|
	STA.l $7F8386,X				;$00C158	|
	LDA.b #$00				;$00C15C	|
	STA.l $7F837F,X				;$00C15E	|
	STA.l $7F8387,X				;$00C162	|
	LDA.b #$03				;$00C166	|
	STA.l $7F8380,X				;$00C168	|
	STA.l $7F8388,X				;$00C16C	|
	LDA.b #$FF				;$00C170	|
	STA.l $7F838D,X				;$00C172	|
	LDA.b #$0D				;$00C176	|
	STA $06					;$00C178	|
	REP #$20				;$00C17A	|
	LDA.w $0FBE,Y				;$00C17C	|
	STA $04					;$00C17F	|
	LDY.w #$0000				;$00C181	|
	LDA [$04],Y				;$00C184	|
	STA.l $7F8381,X				;$00C186	|
	INY					;$00C18A	|
	INY					;$00C18B	|
	LDA [$04],Y				;$00C18C	|
	STA.l $7F8389,X				;$00C18E	|
	INY					;$00C192	|
	INY					;$00C193	|
	LDA [$04],Y				;$00C194	|
	STA.l $7F8383,X				;$00C196	|
	INY					;$00C19A	|
	INY					;$00C19B	|
	LDA [$04],Y				;$00C19C	|
	STA.l $7F838B,X				;$00C19E	|
	TXA					;$00C1A2	|
	CLC					;$00C1A3	|
	ADC.w #$0010				;$00C1A4	|
	STA.l $7F837B				;$00C1A7	|
Return00C1AB:
	RTS

CODE_00C1AC:
	JSR CODE_00C00D
	REP #$30				;$00C1AF	|
	LDA $98					;$00C1B1	|
	AND.w #$01F0				;$00C1B3	|
	STA $04					;$00C1B6	|
	LDA $9A					;$00C1B8	|
	LSR					;$00C1BA	|
	LSR					;$00C1BB	|
	LSR					;$00C1BC	|
	LSR					;$00C1BD	|
	AND.w #$000F				;$00C1BE	|
	ORA $04					;$00C1C1	|
	TAY					;$00C1C3	|
	SEP #$20				;$00C1C4	|
	LDA.b #$25				;$00C1C6	|
	STA [$6B],Y				;$00C1C8	|
	REP #$20				;$00C1CA	|
	TYA					;$00C1CC	|
	CLC					;$00C1CD	|
	ADC.w #$0010				;$00C1CE	|
	TAY					;$00C1D1	|
	SEP #$20				;$00C1D2	|
	LDA.b #$25				;$00C1D4	|
	STA [$6B],Y				;$00C1D6	|
	REP #$20				;$00C1D8	|
	AND.w #$00FF				;$00C1DA	|
	ASL					;$00C1DD	|
	TAY					;$00C1DE	|
	LDA $5B					;$00C1DF	|
	STA $00					;$00C1E1	|
	LDA.w $1933				;$00C1E3	|
	BEQ CODE_00C1EA				;$00C1E6	|
	LSR $00					;$00C1E8	|
CODE_00C1EA:
	LDA $00
	AND.w #$0001				;$00C1EC	|
	BNE CODE_00C20B				;$00C1EF	|
	LDA $08					;$00C1F1	|
	AND.w #$FFF0				;$00C1F3	|
	BMI CODE_00C1FE				;$00C1F6	|
	CMP $0C					;$00C1F8	|
	BEQ CODE_00C222				;$00C1FA	|
	BCS Return00C1AB			;$00C1FC	|
CODE_00C1FE:
	CLC
	ADC.w #$0200				;$00C1FF	|
	CMP $0C					;$00C202	|
	BCC Return00C1AB			;$00C204	|
	BEQ Return00C1AB			;$00C206	|
	JMP CODE_00C222				;$00C208	|

CODE_00C20B:
	LDA $0A
	AND.w #$FFF0				;$00C20D	|
	BMI CODE_00C218				;$00C210	|
	CMP $0E					;$00C212	|
	BEQ CODE_00C222				;$00C214	|
	BCS Return00C1AB			;$00C216	|
CODE_00C218:
	CLC
	ADC.w #$0200				;$00C219	|
	CMP $0E					;$00C21C	|
	BEQ Return00C1AB			;$00C21E	|
	BCC Return00C1AB			;$00C220	|
CODE_00C222:
	LDA.l $7F837B
	TAX					;$00C226	|
	SEP #$20				;$00C227	|
	LDA $06					;$00C229	|
	STA.l $7F837D,X				;$00C22B	|
	STA.l $7F8389,X				;$00C22F	|
	LDA $07					;$00C233	|
	STA.l $7F837E,X				;$00C235	|
	INC A					;$00C239	|
	STA.l $7F838A,X				;$00C23A	|
	LDA.b #$80				;$00C23E	|
	STA.l $7F837F,X				;$00C240	|
	STA.l $7F838B,X				;$00C244	|
	LDA.b #$07				;$00C248	|
	STA.l $7F8380,X				;$00C24A	|
	STA.l $7F838C,X				;$00C24E	|
	LDA.b #$FF				;$00C252	|
	STA.l $7F8395,X				;$00C254	|
	LDA.b #$0D				;$00C258	|
	STA $06					;$00C25A	|
	REP #$20				;$00C25C	|
	LDA.w $0FBE,Y				;$00C25E	|
	STA $04					;$00C261	|
	LDY.w #$0000				;$00C263	|
	LDA [$04],Y				;$00C266	|
	STA.l $7F8381,X				;$00C268	|
	STA.l $7F8385,X				;$00C26C	|
	INY					;$00C270	|
	INY					;$00C271	|
	LDA [$04],Y				;$00C272	|
	STA.l $7F838D,X				;$00C274	|
	STA.l $7F8391,X				;$00C278	|
	INY					;$00C27C	|
	INY					;$00C27D	|
	LDA [$04],Y				;$00C27E	|
	STA.l $7F8383,X				;$00C280	|
	STA.l $7F8387,X				;$00C284	|
	INY					;$00C288	|
	INY					;$00C289	|
	LDA [$04],Y				;$00C28A	|
	STA.l $7F838F,X				;$00C28C	|
	STA.l $7F8393,X				;$00C290	|
	TXA					;$00C294	|
	CLC					;$00C295	|
	ADC.w #$0018				;$00C296	|
	STA.l $7F837B				;$00C299	|
	RTS					;$00C29D	|

FlippedGateBgTiles:
	db $99,$9C,$8B,$1C,$8B,$1C,$8B,$1C
	db $8B,$1C,$99,$DC,$9B,$1C,$F8,$1C
	db $F8,$1C,$F8,$1C,$F8,$1C,$9B,$5C
	db $9B,$1C,$F8,$1C,$F8,$1C,$F8,$1C
	db $F8,$1C,$9B,$5C,$9B,$1C,$F8,$1C
	db $F8,$1C,$F8,$1C,$F8,$1C,$9B,$5C
	db $9B,$1C,$F8,$1C,$F8,$1C,$F8,$1C
	db $F8,$1C,$9B,$5C,$99,$1C,$8B,$9C
	db $8B,$9C,$8B,$9C,$8B,$9C,$99,$5C
	db $BA,$9C,$AB,$1C,$AB,$1C,$AB,$1C
	db $AB,$1C,$BA,$DC,$AA,$1C,$82,$1C
	db $82,$1C,$82,$1C,$82,$1C,$AA,$5C
	db $AA,$1C,$82,$1C,$82,$1C,$82,$1C
	db $82,$1C,$AA,$5C,$AA,$1C,$82,$1C
	db $82,$1C,$82,$1C,$82,$1C,$AA,$5C
	db $AA,$1C,$82,$1C,$82,$1C,$82,$1C
	db $82,$1C,$AA,$5C,$BA,$1C,$AB,$9C
	db $AB,$9C,$AB,$9C,$AB,$9C,$BA,$5C
DATA_00C32E:
	db $9E,$C2

DATA_00C330:
	db $00,$E6,$C2,$00

CODE_00C334:
	INC $07
	LDA $07					;$00C336	|
	CLC					;$00C338	|
	ADC.b #$20				;$00C339	|
	STA $07					;$00C33B	|
	LDA $06					;$00C33D	|
	ADC.b #$00				;$00C33F	|
	STA $06					;$00C341	|
	LDA $9C					;$00C343	|
	SEC					;$00C345	|
	SBC.b #$19				;$00C346	|
	STA $00					;$00C348	|
	ASL					;$00C34A	|
	CLC					;$00C34B	|
	ADC $00					;$00C34C	|
	TAX					;$00C34E	|
	LDA.l DATA_00C330,X			;$00C34F	|
	STA $04					;$00C353	|
	REP #$30				;$00C355	|
	LDA.l DATA_00C32E,X			;$00C357	|
	STA $02					;$00C35B	|
	LDA.l $7F837B				;$00C35D	|
	TAX					;$00C361	|
	LDY.w #$0005				;$00C362	|
CODE_00C365:
	SEP #$20
	LDA $06					;$00C367	|
	STA.l $7F837D,X				;$00C369	|
	LDA $07					;$00C36D	|
	STA.l $7F837E,X				;$00C36F	|
	LDA.b #$00				;$00C373	|
	STA.l $7F837F,X				;$00C375	|
	LDA.b #$0B				;$00C379	|
	STA.l $7F8380,X				;$00C37B	|
	LDA $07					;$00C37F	|
	CLC					;$00C381	|
	ADC.b #$20				;$00C382	|
	STA $07					;$00C384	|
	LDA $06					;$00C386	|
	ADC.b #$00				;$00C388	|
	STA $06					;$00C38A	|
	REP #$20				;$00C38C	|
	TXA					;$00C38E	|
	CLC					;$00C38F	|
	ADC.w #$0010				;$00C390	|
	TAX					;$00C393	|
	DEY					;$00C394	|
	BPL CODE_00C365				;$00C395	|
	LDA.l $7F837B				;$00C397	|
	TAX					;$00C39B	|
	LDY.w #$0000				;$00C39C	|
CODE_00C39F:
	LDA.w #$0005
	STA $00					;$00C3A2	|
CODE_00C3A4:
	LDA [$02],Y
	STA.l $7F8381,X				;$00C3A6	|
	INY					;$00C3AA	|
	INY					;$00C3AB	|
	INX					;$00C3AC	|
	INX					;$00C3AD	|
	DEC $00					;$00C3AE	|
	BPL CODE_00C3A4				;$00C3B0	|
	TXA					;$00C3B2	|
	CLC					;$00C3B3	|
	ADC.w #$0004				;$00C3B4	|
	TAX					;$00C3B7	|
	CPY.w #$0048				;$00C3B8	|
	BNE CODE_00C39F				;$00C3BB	|
	LDA.w #$00FF				;$00C3BD	|
	STA.l $7F837D,X				;$00C3C0	|
	LDA.l $7F837B				;$00C3C4	|
	CLC					;$00C3C8	|
	ADC.w #$0060				;$00C3C9	|
	STA.l $7F837B				;$00C3CC	|
	RTS					;$00C3D0	|

CODE_00C3D1:
	REP #$30
	LDA $98					;$00C3D3	|
	AND.w #$01F0				;$00C3D5	|
	STA $04					;$00C3D8	|
	LDA $9A					;$00C3DA	|
	LSR					;$00C3DC	|
	LSR					;$00C3DD	|
	LSR					;$00C3DE	|
	LSR					;$00C3DF	|
	AND.w #$000F				;$00C3E0	|
	ORA $04					;$00C3E3	|
	TAY					;$00C3E5	|
	LDA.l $7F837B				;$00C3E6	|
	TAX					;$00C3EA	|
	SEP #$20				;$00C3EB	|
	LDA.b #$25				;$00C3ED	|
	STA [$6B],Y				;$00C3EF	|
	INY					;$00C3F1	|
	LDA.b #$25				;$00C3F2	|
	STA [$6B],Y				;$00C3F4	|
	REP #$20				;$00C3F6	|
	TYA					;$00C3F8	|
	CLC					;$00C3F9	|
	ADC.w #$0010				;$00C3FA	|
	TAY					;$00C3FD	|
	SEP #$20				;$00C3FE	|
	LDA.b #$25				;$00C400	|
	STA [$6B],Y				;$00C402	|
	DEY					;$00C404	|
	LDA.b #$25				;$00C405	|
	STA [$6B],Y				;$00C407	|
	LDY.w #$0003				;$00C409	|
CODE_00C40C:
	LDA $06
	STA.l $7F837D,X				;$00C40E	|
	LDA $07					;$00C412	|
	STA.l $7F837E,X				;$00C414	|
	LDA.b #$40				;$00C418	|
	STA.l $7F837F,X				;$00C41A	|
	LDA.b #$06				;$00C41E	|
	STA.l $7F8380,X				;$00C420	|
	REP #$20				;$00C424	|
	LDA.w #$18F8				;$00C426	|
	STA.l $7F8381,X				;$00C429	|
	TXA					;$00C42D	|
	CLC					;$00C42E	|
	ADC.w #$0006				;$00C42F	|
	TAX					;$00C432	|
	SEP #$20				;$00C433	|
	LDA $07					;$00C435	|
	CLC					;$00C437	|
	ADC.b #$20				;$00C438	|
	STA $07					;$00C43A	|
	LDA $06					;$00C43C	|
	ADC.b #$00				;$00C43E	|
	STA $06					;$00C440	|
	DEY					;$00C442	|
	BPL CODE_00C40C				;$00C443	|
	LDA.b #$FF				;$00C445	|
	STA.l $7F837D,X				;$00C447	|
	REP #$20				;$00C44B	|
	TXA					;$00C44D	|
	STA.l $7F837B				;$00C44E	|
	RTS					;$00C452	|

DATA_00C453:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$80,$40,$20
	db $10,$08,$04,$02,$01,$80,$40,$20
	db $10,$08,$04,$02,$01

DATA_00C470:
	db $90,$00,$90,$00

DATA_00C474:
	db $04,$FC,$04,$FC

DATA_00C478:
	db $30,$33,$33,$30,$01,$00

CODE_00C47E:
	STZ $78
	LDA.w $13CB				;$00C480	|
	BPL CODE_00C48C				;$00C483	|
	JSL CODE_01C580				;$00C485	|
	STZ.w $13CB				;$00C489	|
CODE_00C48C:
	LDY.w $1434
	BEQ CODE_00C4BA				;$00C48F	|
	STY.w $13FB				;$00C491	|
	STY $9D					;$00C494	|
	LDX.w $1435				;$00C496	|
	LDA.w $1433				;$00C499	|
	CMP.w DATA_00C470,X			;$00C49C	|
	BNE CODE_00C4BC				;$00C49F	|
	DEY					;$00C4A1	|
	BNE CODE_00C4B7				;$00C4A2	|
	INC.w $1435				;$00C4A4	|
	TXA					;$00C4A7	|
	LSR					;$00C4A8	|
	BCC CODE_00C4F8				;$00C4A9	|
	JSR CODE_00FCEC				;$00C4AB	|
	LDA.b #$02				;$00C4AE	|
	LDY.b #$0B				;$00C4B0	|
	JSR CODE_00C9FE				;$00C4B2	|
	LDY.b #$00				;$00C4B5	|
CODE_00C4B7:
	STY.w $1434
CODE_00C4BA:
	BRA CODE_00C4F8

CODE_00C4BC:
	CLC
	ADC.w DATA_00C474,X			;$00C4BD	|
	STA.w $1433				;$00C4C0	|
	LDA.b #$22				;$00C4C3	|
	STA $41					;$00C4C5	|
	LDA.b #$02				;$00C4C7	|
	STA $42					;$00C4C9	|
	LDA.w DATA_00C478,X			;$00C4CB	|
	STA $43					;$00C4CE	|
	LDA.b #$12				;$00C4D0	|
	STA $44					;$00C4D2	|
	REP #$20				;$00C4D4	|
	LDA.w #$CB93				;$00C4D6	|
	STA $04					;$00C4D9	|
	STZ $06					;$00C4DB	|
	SEP #$20				;$00C4DD	|
	LDA.w $1436				;$00C4DF	|
	SEC					;$00C4E2	|
	SBC $1A					;$00C4E3	|
	CLC					;$00C4E5	|
	ADC.b #$04				;$00C4E6	|
	STA $00					;$00C4E8	|
	LDA.w $1438				;$00C4EA	|
	SEC					;$00C4ED	|
	SBC $1C					;$00C4EE	|
	CLC					;$00C4F0	|
	ADC.b #$10				;$00C4F1	|
	STA $01					;$00C4F3	|
	JSR CODE_00CA88				;$00C4F5	|
CODE_00C4F8:
	LDA.w $13FB
	BEQ CODE_00C500				;$00C4FB	|
	JMP CODE_00C58F				;$00C4FD	|

CODE_00C500:
	LDA $9D
	BNE CODE_00C569				;$00C502	|
	INC $14					;$00C504	|
	LDX.b #$13				;$00C506	|
CODE_00C508:
	LDA.w $1495,X
	BEQ CODE_00C510				;$00C50B	|
	DEC.w $1495,X				;$00C50D	|
CODE_00C510:
	DEX
	BNE CODE_00C508				;$00C511	|
	LDA $14					;$00C513	|
	AND.b #$03				;$00C515	|
	BNE CODE_00C569				;$00C517	|
	LDA.w $1425				;$00C519	|
	BEQ CODE_00C533				;$00C51C	|
	LDA.w $14AB				;$00C51E	|
	CMP.b #$44				;$00C521	|
	BNE CODE_00C52A				;$00C523	|
	LDY.b #$14				;$00C525	|
	STY.w $1DFB				;$00C527	|
CODE_00C52A:
	CMP.b #$01
	BNE CODE_00C533				;$00C52C	|
	LDY.b #$0B				;$00C52E	|
	STY.w $0100				;$00C530	|
CODE_00C533:
	LDY.w $14AD
	CPY.w $14AE				;$00C536	|
	BCS CODE_00C53E				;$00C539	|
	LDY.w $14AE				;$00C53B	|
CODE_00C53E:
	LDA.w $0DDA
	BMI CODE_00C54F				;$00C541	|
	CPY.b #$01				;$00C543	|
	BNE CODE_00C54F				;$00C545	|
	LDY.w $190C				;$00C547	|
	BNE CODE_00C54F				;$00C54A	|
	STA.w $1DFB				;$00C54C	|
CODE_00C54F:
	CMP.b #$FF
	BEQ CODE_00C55C				;$00C551	|
	CPY.b #$1E				;$00C553	|
	BNE CODE_00C55C				;$00C555	|
	LDA.b #$24				;$00C557	|
	STA.w $1DFC				;$00C559	|
CODE_00C55C:
	LDX.b #$06
CODE_00C55E:
	LDA.w $14A8,X
	BEQ CODE_00C566				;$00C561	|
	DEC.w $14A8,X				;$00C563	|
CODE_00C566:
	DEX
	BNE CODE_00C55E				;$00C567	|
CODE_00C569:
	JSR CODE_00C593
	LDA $16					;$00C56C	|
	AND.b #$20				;$00C56E	|
	BEQ CODE_00C58F				;$00C570	|
	LDA $15					;$00C572	|
	AND.b #$08				;$00C574	|
	BRA CODE_00C585				;$00C576	|

	LDA $19					;$00C578	|
	INC A					;$00C57A	|
	CMP.b #$04				;$00C57B	|
	BCC ADDR_00C581				;$00C57D	|
	LDA.b #$00				;$00C57F	|
ADDR_00C581:
	STA $19
	BRA CODE_00C58F				;$00C583	|

CODE_00C585:
	PHB
	LDA.b #$02				;$00C586	|
	PHA					;$00C588	|
	PLB					;$00C589	|
	JSL CODE_028008				;$00C58A	|
	PLB					;$00C58E	|
CODE_00C58F:
	STZ.w $1402
Return00C592:
	RTS

CODE_00C593:
	LDA $71					;$00C593	\ Execute animation code.
	JSL execute_pointer			;$00C595	/

animation_pointers:
	dw no_animation
	dw hurt_animation
	dw mushroom_animation
	dw cape_animation
	dw flower_animation
	dw horizontal_pipe_animation
	dw vertical_pipe_animation
	dw slanted_pipe_animation
	dw yoshi_wings_animation
	dw death_animation
	dw castle_enter_animation
	dw UnknownAniB
	dw castle_destroy_animation
	dw Return00C592

UnknownAniB:
	STZ.w $13DE
	STZ.w $13ED				;$00C5B8	|
	LDA.w $1493				;$00C5BB	|
	BEQ CODE_00C5CE				;$00C5BE	|
	JSL CODE_0CAB13				;$00C5C0	|
	LDA.w $0100				;$00C5C4	|
	CMP.b #$14				;$00C5C7	|
	BEQ CODE_00C5D1				;$00C5C9	|
	JMP CODE_00C95B				;$00C5CB	|

CODE_00C5CE:
	STZ.w $0D9F
CODE_00C5D1:
	LDA.b #$01
	STA.w $1B88				;$00C5D3	|
	LDA.b #$07				;$00C5D6	|
	STA.w $1928				;$00C5D8	|
	JSR disable_controls			;$00C5DB	|
	JMP no_special_collision		;$00C5DE	|

DATA_00C5E1:
	db $10,$30,$31,$32,$33,$34,$0E

DATA_00C5E8:
	db $26

DATA_00C5E9:
	db $11,$02,$48,$00,$60,$01,$09,$80
	db $08,$00,$20,$04,$60,$00,$01,$FF
	db $01,$02,$48,$00,$60,$41,$2C,$C1
	db $04,$27,$04,$2F,$08,$25,$01,$2F
	db $04,$27,$04,$00,$08,$41,$1B,$C1
	db $04,$27,$04,$2F,$08,$25,$01,$2F
	db $04,$27,$04,$00,$04,$01,$08,$20
	db $01,$01,$10,$00,$08,$41,$12,$81
	db $0A,$00,$40,$82,$10,$02,$20,$00
	db $30,$01,$01,$00,$50,$22,$01,$FF
	db $01,$02,$48,$00,$60,$01,$09,$80
	db $08,$00,$20,$04,$60,$00,$20,$10
	db $20,$01,$58,$00,$2C,$31,$01,$3A
	db $10,$31,$01,$3A,$10,$31,$01,$3A
	db $20,$28,$A0,$28,$40,$29,$04,$28
	db $04,$29,$04,$28,$04,$29,$04,$28
	db $40,$22,$01,$FF,$01,$02,$48,$00
	db $60,$01,$09,$80,$08,$00,$20,$04
	db $60,$10,$20,$31,$01,$18,$60,$31
	db $01,$3B,$80,$31,$01,$3C,$40,$FF
	db $01,$02,$48,$00,$60,$02,$30,$01
	db $84,$00,$20,$23,$01,$01,$16,$02
	db $20,$20,$01,$01,$20,$02,$20,$01
	db $02,$00,$80,$FF,$01,$02,$48,$00
	db $60,$02,$28,$01,$83,$00,$28,$24
	db $01,$02,$01,$00,$FF,$00,$40,$20
	db $01,$00,$40,$02,$60,$00,$30,$FF
	db $01,$02,$48,$00,$60,$01,$4E,$00
	db $40,$26,$01,$00,$1E,$20,$01,$00
	db $20,$08,$10,$20,$01,$2D,$18,$00
	db $A0,$20,$01,$2E,$01,$FF

DATA_00C6DF:
	db $01,$00,$10,$A0,$84,$50,$BC,$D8

castle_destroy_animation:
	JSR disable_controls
	STZ.w $13DE				;$00C6EA	|
	JSR apply_player_speeds			;$00C6ED	|
	LDA $7D					;$00C6F0	|
	BMI CODE_00C73F				;$00C6F2	|
	LDA $96					;$00C6F4	|
	CMP.b #$58				;$00C6F6	|
	BCS CODE_00C739				;$00C6F8	|
	LDY $94					;$00C6FA	|
	CPY.b #$40				;$00C6FC	|
	BCC CODE_00C73F				;$00C6FE	|
	CPY.b #$60				;$00C700	|
	BCC CODE_00C71C				;$00C702	|
	LDY $1C					;$00C704	|
	BEQ CODE_00C73F				;$00C706	|
	CLC					;$00C708	|
	ADC $1C					;$00C709	|
	CMP.b #$1C				;$00C70B	|
	BMI CODE_00C73F				;$00C70D	|
	SEC					;$00C70F	|
	SBC $1C					;$00C710	|
	LDX.b #$D0				;$00C712	|
	LDY $76					;$00C714	|
	BEQ CODE_00C730				;$00C716	|
	LDY.b #$00				;$00C718	|
	BRA CODE_00C72E				;$00C71A	|

CODE_00C71C:
	CMP.b #$4C
	BCC CODE_00C73F				;$00C71E	|
	LDA.b #$1B				;$00C720	|
	STA.w $1DFC				;$00C722	|
	INC.w $143E				;$00C725	|
	LDA.b #$4C				;$00C728	|
	LDY.b #$F4				;$00C72A	|
	LDX.b #$C0				;$00C72C	|
CODE_00C72E:
	STY $7B
CODE_00C730:
	STX $7D
	LDX.b #$01				;$00C732	|
	STX.w $1DF9				;$00C734	|
	BRA CODE_00C73D				;$00C737	|

CODE_00C739:
	STZ $72
	LDA.b #$58				;$00C73B	|
CODE_00C73D:
	STA $96
CODE_00C73F:
	LDX.w $13C6
	LDA $8F					;$00C742	|
	CLC					;$00C744	|
	ADC.w DATA_00C6DF,X			;$00C745	|
	TAX					;$00C748	|
	LDA $88					;$00C749	|
	BNE CODE_00C764				;$00C74B	|
	INC $8F					;$00C74D	|
	INC $8F					;$00C74F	|
	INX					;$00C751	|
	INX					;$00C752	|
	LDA.w DATA_00C5E9,X			;$00C753	|
	STA $88					;$00C756	|
	LDA.w DATA_00C5E8,X			;$00C758	|
	CMP.b #$2D				;$00C75B	|
	BNE CODE_00C764				;$00C75D	|
	LDA.b #$1E				;$00C75F	|
	STA.w $1DF9				;$00C761	|
CODE_00C764:
	LDA.w DATA_00C5E8,X
	CMP.b #$FF				;$00C767	|
	BNE CODE_00C76E				;$00C769	|
	JMP Return00C7F8			;$00C76B	|

CODE_00C76E:
	PHA
	AND.b #$10				;$00C76F	|
	BEQ CODE_00C777				;$00C771	|
	JSL CODE_0CD4A4				;$00C773	|
CODE_00C777:
	PLA
	TAY					;$00C778	|
	AND.b #$20				;$00C779	|
	BNE CODE_00C789				;$00C77B	|
	STY $15					;$00C77D	|
	TYA					;$00C77F	|
	AND.b #$BF				;$00C780	|
	STA $16					;$00C782	|
	JSR CODE_00CD39				;$00C784	|
	BRA CODE_00C7F6				;$00C787	|

CODE_00C789:
	TYA
	AND.b #$0F				;$00C78A	|
	CMP.b #$07				;$00C78C	|
	BCS CODE_00C7E9				;$00C78E	|
	DEC A					;$00C790	|
	BPL CODE_00C7A2				;$00C791	|
	LDA.w $1498				;$00C793	|
	BEQ CODE_00C79D				;$00C796	|
	LDA.b #$09				;$00C798	|
	STA.w $1DF9				;$00C79A	|
CODE_00C79D:
	INC.w $143E
	BRA CODE_00C7F6				;$00C7A0	|

CODE_00C7A2:
	BNE CODE_00C7A9
	INC.w $1445				;$00C7A4	|
	BRA CODE_00C7F6				;$00C7A7	|

CODE_00C7A9:
	DEC A
	BNE CODE_00C7B6				;$00C7AA	|
	LDA.b #$0E				;$00C7AC	|
	STA.w $1DF9				;$00C7AE	|
	INC.w $1446				;$00C7B1	|
	BRA CODE_00C7F6				;$00C7B4	|

CODE_00C7B6:
	DEC A
	BNE CODE_00C7C0				;$00C7B7	|
	LDY.b #$88				;$00C7B9	|
	STY.w $1445				;$00C7BB	|
	BRA CODE_00C7F6				;$00C7BE	|

CODE_00C7C0:
	DEC A
	BNE CODE_00C7CE				;$00C7C1	|
	LDA.b #$38				;$00C7C3	|
	STA.w $1446				;$00C7C5	|
	LDA.b #$07				;$00C7C8	|
	TRB $94					;$00C7CA	|
	BRA CODE_00C7F6				;$00C7CC	|

CODE_00C7CE:
	DEC A
	BNE CODE_00C7DF				;$00C7CF	|
	LDA.b #$09				;$00C7D1	|
	STA.w $1DFC				;$00C7D3	|
	LDA.b #$D8				;$00C7D6	|
	STA $7B					;$00C7D8	|
	INC.w $143E				;$00C7DA	|
	BRA CODE_00C79D				;$00C7DD	|

CODE_00C7DF:
	LDA.b #$20
	STA.w $1498				;$00C7E1	|
	INC.w $148F				;$00C7E4	|
	BRA CODE_00C7F6				;$00C7E7	|

CODE_00C7E9:
	TAY
	LDA.w $C5DA,Y				;$00C7EA	|
	STA.w $13E0				;$00C7ED	|
	STZ.w $148F				;$00C7F0	|
	JSR aerial_physics			;$00C7F3	|
CODE_00C7F6:
	DEC $88
Return00C7F8:
	RTS

DATA_00C7F9:
	db $C0,$FF,$A0,$00

yoshi_wings_animation:
	JSR disable_controls
	LDA.b #$0B				;$00C800	|
	STA $72					;$00C802	|
	JSR aerial_physics			;$00C804	|
	LDA $7D					;$00C807	|
	BPL CODE_00C80F				;$00C809	|
	CMP.b #$90				;$00C80B	|
	BCC CODE_00C814				;$00C80D	|
CODE_00C80F:
	SEC
	SBC.b #$0D				;$00C810	|
	STA $7D					;$00C812	|
CODE_00C814:
	LDA.b #$02
	LDY $7B					;$00C816	|
	BEQ CODE_00C827				;$00C818	|
	BMI CODE_00C81E				;$00C81A	|
	LDA.b #$FE				;$00C81C	|
CODE_00C81E:
	CLC
	ADC $7B					;$00C81F	|
	STA $7B					;$00C821	|
	BVC CODE_00C827				;$00C823	|
	STZ $7B					;$00C825	|
CODE_00C827:
	JSR apply_player_speeds
	REP #$20				;$00C82A	|
	LDY.w $1B95				;$00C82C	|
	LDA $80					;$00C82F	|
	CMP.w DATA_00C7F9,Y			;$00C831	|
	SEP #$20				;$00C834	|
	BPL CODE_00C845				;$00C836	|
	STZ $71					;$00C838	|
	TYA					;$00C83A	|
	BNE CODE_00C845				;$00C83B	|
	INY					;$00C83D	|
	INY					;$00C83E	|
	STY.w $1B95				;$00C83F	|
	JSR go_to_sublevel			;$00C842	|
CODE_00C845:
	JMP CODE_00CD8F

DATA_00C848:
	db $01,$5F,$00,$30,$08,$30,$00,$20
	db $40,$01,$00,$30,$01,$80,$FF,$01
	db $3F,$00,$30,$20,$01,$80,$06,$00
	db $3A,$01,$38,$00,$30,$08,$30,$00
	db $20,$40,$01,$00,$30,$01,$80,$FF

castle_enter_animation:
	STZ.w $13E2
	LDX.w $1931				;$00C873	|
	BIT.w DATA_00A625,X			;$00C876	|
	BMI CODE_00C889				;$00C879	|
	BVS ADDR_00C883				;$00C87B	|
	JSL CODE_02F57C				;$00C87D	|
	BRA CODE_00C88D				;$00C881	|

ADDR_00C883:
	JSL ADDR_02F58C
	BRA CODE_00C88D				;$00C887	|

CODE_00C889:
	JSL CODE_02F584
CODE_00C88D:
	LDX $88
	LDA $16					;$00C88F	|
	ORA $18					;$00C891	|
	JSR disable_controls			;$00C893	|
	BMI CODE_00C8FB				;$00C896	|
	STZ.w $13DE				;$00C898	|
	DEC $89					;$00C89B	|
	BNE CODE_00C8A8				;$00C89D	|
	INX					;$00C89F	|
	INX					;$00C8A0	|
	STX $88					;$00C8A1	|
	LDA.w DATA_00C848-1,X			;$00C8A3	|
	STA $89					;$00C8A6	|
CODE_00C8A8:
	LDA.w DATA_00C848-2,X
	CMP.b #$FF				;$00C8AB	|
	BEQ CODE_00C8FB				;$00C8AD	|
	AND.b #$DF				;$00C8AF	|
	STA $15					;$00C8B1	|
	CMP.w DATA_00C848-2,X			;$00C8B3	|
	BEQ CODE_00C8BC				;$00C8B6	|
	LDY.b #$80				;$00C8B8	|
	STY $18					;$00C8BA	|
CODE_00C8BC:
	ASL
	BPL CODE_00C8D1				;$00C8BD	|
	JSR disable_controls			;$00C8BF	|
	LDY.b #$B0				;$00C8C2	|
	LDX.w $1931				;$00C8C4	|
	BIT.w DATA_00A625,X			;$00C8C7	|
	BMI CODE_00C8CE				;$00C8CA	|
	LDY.b #$7F				;$00C8CC	|
CODE_00C8CE:
	STY.w $18D9
CODE_00C8D1:
	JSR apply_player_speeds
	LDA.b #$24				;$00C8D4	|
	STA $72					;$00C8D6	|
	LDA.b #$6F				;$00C8D8	|
	LDY.w $187A				;$00C8DA	|
	BEQ CODE_00C8E1				;$00C8DD	|
	LDA.b #$5F				;$00C8DF	|
CODE_00C8E1:
	LDX.w $1931
	BIT.w DATA_00A625,X			;$00C8E4	|
	BVC CODE_00C8EC				;$00C8E7	|
	SEC					;$00C8E9	|
	SBC.b #$10				;$00C8EA	|
CODE_00C8EC:
	CMP $96
	BCS CODE_00C8F8				;$00C8EE	|
	INC A					;$00C8F0	|
	STA $96					;$00C8F1	|
	STZ $72					;$00C8F3	|
	STZ.w $140D				;$00C8F5	|
CODE_00C8F8:
	JMP use_land_physics

CODE_00C8FB:
	INC.w $141D
	LDA.b #$0F				;$00C8FE	|
	STA.w $0100				;$00C900	|
	CPX.b #$11				;$00C903	|
	BCC CODE_00C90A				;$00C905	|
	INC.w $0DC1				;$00C907	|
CODE_00C90A:
	LDA.b #$01
	STA.w $1B9B				;$00C90C	|
	LDA.b #$03				;$00C90F	|
	STA.w $1DFA				;$00C911	|
	RTS					;$00C914	|

ending_level:
	JSR disable_controls
	STZ.w $18C2				;$00C918	|
	STZ.w $13DE				;$00C91B	|
	STZ.w $13ED				;$00C91E	|
	LDA $5B					;$00C921	|
	LSR					;$00C923	|
	BCS CODE_00C944				;$00C924	|
	LDA.w $13C6				;$00C926	|
	ORA.w $13D2				;$00C929	|
	BEQ CODE_00C96B				;$00C92C	|
	LDA $72					;$00C92E	|
	BEQ CODE_00C935				;$00C930	|
	JSR not_frozen_physics			;$00C932	|
CODE_00C935:
	LDA.w $13D2
	BNE CODE_00C948				;$00C938	|
	JSR CODE_00B03E				;$00C93A	|
	LDA.w $1495				;$00C93D	|
	CMP.b #$40				;$00C940	|
	BCC Return00C96A			;$00C942	|
CODE_00C944:
	JSL CODE_05CBFF
CODE_00C948:
	LDY.b #$01
	STY $9D					;$00C94A	|
	LDA $13					;$00C94C	|
	LSR					;$00C94E	|
	BCC Return00C96A			;$00C94F	|
	DEC.w $1493				;$00C951	|
	BNE Return00C96A			;$00C954	|
	LDA.w $13D2				;$00C956	|
	BNE CODE_00C962				;$00C959	|
CODE_00C95B:
	LDY.b #$0B
	LDA.b #$01				;$00C95D	|
	JMP CODE_00C9FE				;$00C95F	|

CODE_00C962:
	LDA.b #$A0
	STA.w $1DF5				;$00C964	|
	INC.w $1426				;$00C967	|
Return00C96A:
	RTS

CODE_00C96B:
	JSR CODE_00AF17
	LDA.w $1B99				;$00C96E	|
	BNE CODE_00C9AF				;$00C971	|
	LDA.w $1493				;$00C973	|
	CMP.b #$28				;$00C976	|
	BCC CODE_00C984				;$00C978	|
	LDA.b #$01				;$00C97A	|
	STA $76					;$00C97C	|
	STA $15					;$00C97E	|
	LDA.b #$05				;$00C980	|
	STA $7B					;$00C982	|
CODE_00C984:
	LDA $72
	BEQ CODE_00C98B				;$00C986	|
	JSR CODE_00D76B				;$00C988	|
CODE_00C98B:
	LDA $7B
	BNE CODE_00C9A4				;$00C98D	|
	STZ.w $1411				;$00C98F	|
	JSR CODE_00CA3E				;$00C992	|
	INC.w $1B99				;$00C995	|
	LDA.b #$40				;$00C998	|
	STA.w $1492				;$00C99A	|
	ASL					;$00C99D	|
	STA.w $1494				;$00C99E	|
	STZ.w $1495				;$00C9A1	|
CODE_00C9A4:
	JMP no_special_collision

DATA_00C9A7:
	db $25,$07,$40,$0E,$20,$1A,$34,$32

CODE_00C9AF:
	JSR SetMarioPeaceImg
	LDA.w $1492				;$00C9B2	|
	BEQ CODE_00C9C2				;$00C9B5	|
	DEC.w $1492				;$00C9B7	|
	BNE Return00C9C1			;$00C9BA	|
	LDA.b #$11				;$00C9BC	|
	STA.w $1DFB				;$00C9BE	|
Return00C9C1:
	RTS

CODE_00C9C2:
	JSR CODE_00CA44
	LDA.b #$01				;$00C9C5	|
	STA $15					;$00C9C7	|
	JSR no_special_collision		;$00C9C9	|
	LDA.w $1433				;$00C9CC	|
	BNE Return00CA30			;$00C9CF	|
	LDA.w $141C				;$00C9D1	|
	INC A					;$00C9D4	|
	CMP.b #$03				;$00C9D5	|
	BNE CODE_00C9DF				;$00C9D7	|
	LDA.b #$01				;$00C9D9	|
	STA.w $1F11				;$00C9DB	|
	LSR					;$00C9DE	|
CODE_00C9DF:
	LDY.b #$0C
	LDX.w $1425				;$00C9E1	|
	BEQ CODE_00C9F8				;$00C9E4	|
	LDX.b #$FF				;$00C9E6	|
	STX.w $1425				;$00C9E8	|
	LDX.b #$F0				;$00C9EB	|
	STX.w $0DB0				;$00C9ED	|
	STZ.w $1493				;$00C9F0	|
	STZ.w $0DDA				;$00C9F3	|
	LDY.b #$10				;$00C9F6	|
CODE_00C9F8:
	STZ.w $0DAE
	STZ.w $0DAF				;$00C9FB	|
CODE_00C9FE:
	STA.w $0DD5
	LDA.w $13C6				;$00CA01	|
	BEQ CODE_00CA25				;$00CA04	|
	LDX.b #$08				;$00CA06	|
	LDA.w $13BF				;$00CA08	|
	CMP.b #$13				;$00CA0B	|
	BNE CODE_00CA12				;$00CA0D	|
	INC.w $0DD5				;$00CA0F	|
CODE_00CA12:
	CMP.b #$31
	BEQ CODE_00CA20				;$00CA14	|
CODE_00CA16:
	CMP.w DATA_00C9A7-1,X
	BEQ CODE_00CA20				;$00CA19	|
	DEX					;$00CA1B	|
	BNE CODE_00CA16				;$00CA1C	|
	BRA CODE_00CA25				;$00CA1E	|

CODE_00CA20:
	STX.w $13C6
	LDY.b #$18				;$00CA23	|
CODE_00CA25:
	STY.w $0100
	INC.w $1DE9				;$00CA28	|
CODE_00CA2B:
	LDA.b #$01
	STA.w $13CE				;$00CA2D	|
Return00CA30:
	RTS

SetMarioPeaceImg:
	LDA.b #$26
	LDY.w $187A				;$00CA33	|
	BEQ CODE_00CA3A				;$00CA36	|
	LDA.b #$14				;$00CA38	|
CODE_00CA3A:
	STA.w $13E0
	RTS					;$00CA3D	|

CODE_00CA3E:
	LDA.b #$F0
	STA.w $1433				;$00CA40	|
	RTS					;$00CA43	|

CODE_00CA44:
	LDA.w $1433
	BNE CODE_00CA4A				;$00CA47	|
	RTS					;$00CA49	|

CODE_00CA4A:
	JSR CODE_00CA61
	LDA.b #$FC				;$00CA4D	|
	JSR CODE_00CA6D				;$00CA4F	|
	LDA.b #$33				;$00CA52	|
	STA $41					;$00CA54	|
	STA $43					;$00CA56	|
	LDA.b #$03				;$00CA58	|
	STA $42					;$00CA5A	|
	LDA.b #$22				;$00CA5C	|
	STA $44					;$00CA5E	|
	RTS					;$00CA60	|

CODE_00CA61:
	REP #$20
	LDA.w #DATA_00CB12			;$00CA63	|
	STA $04					;$00CA66	|
	STA $06					;$00CA68	|
	SEP #$20				;$00CA6A	|
	RTS					;$00CA6C	|

CODE_00CA6D:
	CLC
	ADC.w $1433				;$00CA6E	|
	STA.w $1433				;$00CA71	|
	LDA $7E					;$00CA74	|
	CLC					;$00CA76	|
	ADC.b #$08				;$00CA77	|
	STA $00					;$00CA79	|
	LDA.b #$18				;$00CA7B	|
	LDY $19					;$00CA7D	|
	BEQ CODE_00CA83				;$00CA7F	|
	LDA.b #$10				;$00CA81	|
CODE_00CA83:
	CLC
	ADC $80					;$00CA84	|
	STA $01					;$00CA86	|
CODE_00CA88:
	REP #$30
	AND.w #$00FF				;$00CA8A	|
	ASL					;$00CA8D	|
	DEC A					;$00CA8E	|
	ASL					;$00CA8F	|
	TAY					;$00CA90	|
	SEP #$20				;$00CA91	|
	LDX.w #$0000				;$00CA93	|
CODE_00CA96:
	LDA $01
	CMP.w $1433				;$00CA98	|
	BCC CODE_00CABD				;$00CA9B	|
	LDA.b #$FF				;$00CA9D	|
	STA.w $04A0,X				;$00CA9F	|
	STZ.w $04A1,X				;$00CAA2	|
	CPY.w #$01C0				;$00CAA5	|
	BCS CODE_00CAB1				;$00CAA8	|
	STA.w $04A0,Y				;$00CAAA	|
	INC A					;$00CAAD	|
	STA.w $04A1,Y				;$00CAAE	|
CODE_00CAB1:
	INX
	INX					;$00CAB2	|
	DEY					;$00CAB3	|
	DEY					;$00CAB4	|
	LDA $01					;$00CAB5	|
	BEQ CODE_00CB0A				;$00CAB7	|
	DEC $01					;$00CAB9	|
	BRA CODE_00CA96				;$00CABB	|

CODE_00CABD:
	JSR CODE_00CC14
	CLC					;$00CAC0	|
	ADC $00					;$00CAC1	|
	BCC CODE_00CAC7				;$00CAC3	|
	LDA.b #$FF				;$00CAC5	|
CODE_00CAC7:
	STA.w $04A1,X
	LDA $00					;$00CACA	|
	SEC					;$00CACC	|
	SBC $02					;$00CACD	|
	BCS CODE_00CAD3				;$00CACF	|
	LDA.b #$00				;$00CAD1	|
CODE_00CAD3:
	STA.w $04A0,X
	CPY.w #$01E0				;$00CAD6	|
	BCS CODE_00CAFE				;$00CAD9	|
	LDA $07					;$00CADB	|
	BNE CODE_00CAE7				;$00CADD	|
	LDA.b #$00				;$00CADF	|
	STA.w $04A1,Y				;$00CAE1	|
	DEC A					;$00CAE4	|
	BRA CODE_00CAFB				;$00CAE5	|

CODE_00CAE7:
	LDA $03
	ADC $00					;$00CAE9	|
	BCC CODE_00CAEF				;$00CAEB	|
	LDA.b #$FF				;$00CAED	|
CODE_00CAEF:
	STA.w $04A1,Y
	LDA $00					;$00CAF2	|
	SEC					;$00CAF4	|
	SBC $03					;$00CAF5	|
	BCS CODE_00CAFB				;$00CAF7	|
	LDA.b #$00				;$00CAF9	|
CODE_00CAFB:
	STA.w $04A0,Y
CODE_00CAFE:
	INX
	INX					;$00CAFF	|
	DEY					;$00CB00	|
	DEY					;$00CB01	|
	LDA $01					;$00CB02	|
	BEQ CODE_00CB0A				;$00CB04	|
	DEC $01					;$00CB06	|
	BNE CODE_00CABD				;$00CB08	|
CODE_00CB0A:
	LDA.b #$80
	STA.w $0D9F				;$00CB0C	|
	SEP #$10				;$00CB0F	|
	RTS					;$00CB11	|

DATA_00CB12:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE
	db $FD,$FD,$FD,$FD,$FC,$FC,$FC,$FB
	db $FB,$FB,$FA,$FA,$F9,$F9,$F8,$F8
	db $F7,$F7,$F6,$F6,$F5,$F5,$F4,$F3
	db $F3,$F2,$F1,$F1,$F0,$EF,$EE,$EE
	db $ED,$EC,$EB,$EA,$E9,$E9,$E8,$E7
	db $E6,$E5,$E4,$E3,$E2,$E1,$DF,$DE
	db $DD,$DC,$DB,$DA,$D8,$D7,$D6,$D5
	db $D3,$D2,$D0,$CF,$CD,$CC,$CA,$C9
	db $C7,$C6,$C4,$C2,$C1,$BF,$BD,$BB
	db $B9,$B7,$B6,$B4,$B1,$AF,$AD,$AB
	db $A9,$A7,$A4,$A2,$9F,$9D,$9A,$97
	db $95,$92,$8F,$8C,$89,$86,$82,$7F
	db $7B,$78,$74,$70,$6C,$67,$63,$5E
	db $59,$53,$4D,$46,$3F,$37,$2D,$1F
	db $00,$54,$53,$52,$52,$51,$50,$50
	db $4F,$4E,$4E,$4D,$4C,$4C,$4B,$4A
	db $4A,$4B,$48,$48,$47,$46,$46,$45
	db $44,$44,$43,$42,$42,$41,$40,$40
	db $3F,$3E,$3E,$3D,$3C,$3C,$3B,$3A
	db $3A,$39,$38,$38,$37,$36,$36,$35
	db $34,$34,$33,$32,$32,$31,$33,$35
	db $38,$3A,$3C,$3E,$3F,$41,$43,$44
	db $45,$47,$48,$49,$4A,$4B,$4C,$4D
	db $4E,$4E,$4F,$50,$50,$51,$51,$52
	db $52,$53,$53,$53,$53,$53,$53,$53
	db $53,$53,$53,$53,$53,$53,$52,$52
	db $51,$51,$50,$50,$4F,$4E,$4E,$4D
	db $4C,$4B,$4A,$49,$48,$47,$45,$44
	db $43,$41,$3F,$3E,$3C,$3A,$38,$35
	db $33,$30,$2D,$2A,$26,$23,$1E,$18
	db $11,$00

CODE_00CC14:
	PHY
	LDA $01					;$00CC15	|
	STA.w $4205				;$00CC17	|
	STZ.w $4204				;$00CC1A	|
	LDA.w $1433				;$00CC1D	|
	STA.w $4206				;$00CC20	|
	NOP					;$00CC23	|
	NOP					;$00CC24	|
	NOP					;$00CC25	|
	NOP					;$00CC26	|
	NOP					;$00CC27	|
	NOP					;$00CC28	|
	REP #$20				;$00CC29	|
	LDA.w $4214				;$00CC2B	|
	LSR					;$00CC2E	|
	TAY					;$00CC2F	|
	SEP #$20				;$00CC30	|
	LDA ($06),Y				;$00CC32	|
	STA.w $4202				;$00CC34	|
	LDA.w $1433				;$00CC37	|
	STA.w $4203				;$00CC3A	|
	NOP					;$00CC3D	|
	NOP					;$00CC3E	|
	NOP					;$00CC3F	|
	NOP					;$00CC40	|
	LDA.w $4217				;$00CC41	|
	STA $03					;$00CC44	|
	LDA ($04),Y				;$00CC46	|
	STA.w $4202				;$00CC48	|
	LDA.w $1433				;$00CC4B	|
	STA.w $4203				;$00CC4E	|
	NOP					;$00CC51	|
	NOP					;$00CC52	|
	NOP					;$00CC53	|
	NOP					;$00CC54	|
	LDA.w $4217				;$00CC55	|
	STA $02					;$00CC58	|
	PLY					;$00CC5A	|
	RTS					;$00CC5B	|

free_roaming_speeds:
	dw $0000,$0000,$0002,$0006
	dw $FFFE,$FFFA
	
no_animation:					;		\
	LDA $17					;$00CC68	 |\ If L isn't held, don't cycle the debug action.
	AND.b #$20				;$00CC6A	 | |
	BEQ .no_cycle				;$00CC6C	 |/
	LDA $18					;$00CC6E	 |\ If A isn't pressed, don't cycle the debug action.
	CMP.b #$80				;$00CC70	 | |
	BNE .no_cycle				;$00CC72	 |/
	INC.w $1E01				;$00CC74	 | Increase the debug action.
	LDA.w $1E01				;$00CC77	 |\ If the debug action is $03,
	CMP.b #$03				;$00CC7A	 | |
	BCC .no_cycle				;$00CC7C	 | | reset it to $00.
	STZ.w $1E01				;$00CC7E	 |/
.no_cycle					;		 |
	LDA.w $1E01				;$00CC81	 |
	BRA .skip_debug				;$00CC84	/ Skip the debugging code.
						;		\
	LSR					;$00CC86	 |\ If the debug action is $01,
	BEQ .instant_run			;$00CC87	 |/ do instant running.
	LDA.b #$FF				;$00CC89	 |\ Make the player invincible.
	STA.w $1497				;$00CC8B	 |/
	LDA $15					;$00CC8E	 |\
	AND.b #$03				;$00CC90	 | | Isolate the left and right controller flags,
	ASL					;$00CC92	 | |
	ASL					;$00CC93	 | | multiply by two,
	LDX.b #$00				;$00CC94	 | | and run free roaming with the X position.
	JSR .free_roam				;$00CC96	 |/
	LDA $15					;$00CC99	 |\ Isolate the up and down controller flags,
	AND.b #$0C				;$00CC9B	 | |
	LDX.b #$02				;$00CC9D	 |/ and run free roaming with the Y position.
.free_roam					;		 |
	BIT $15					;$00CC9F	 |\ If X or Y is pressed,
	BVC .not_fast				;$00CCA1	 | | increase the speed.
	ORA.b #$02				;$00CCA3	 | |
.not_fast					;		 | |
	TAY					;$00CCA5	 |/
	REP #$20				;$00CCA6	 |\
	LDA $94,X				;$00CCA8	 | | Move the player's X or Y position by
	CLC					;$00CCAA	 | |
	ADC.w free_roaming_speeds,Y		;$00CCAB	 | | the free roaming speed.
	STA $94,X				;$00CCAE	 | |
	SEP #$20				;$00CCB0	 |/
	RTS					;$00CCB2	/

.instant_run					;		\
	LDA.b #$70				;$00CCB3	 |\
	STA.w $13E4				;$00CCB5	 | | Set the maximum dash time
	STA.w $149F				;$00CCB8	 |/ and flying time.
.skip_debug					;		 |
	LDA.w $1493				;$00CCBB	 | If $1493 is non-zero,
	BEQ .not_ending_level			;$00CCBE	 |
	JMP ending_level			;$00CCC0	/ run level ending code.

.not_ending_level
	JSR screen_scrolling			;$00CCC3	\ Process screen scrolling.
	LDA $9D					;$00CCC6	 |\ If sprites are locked, return.
	BNE .return				;$00CCC8	 |/
	STZ.w $13E8				;$00CCCA	 | Clear the cape spin interaction flag.
	STZ.w $13DE				;$00CCCD	 | Clear the looking up flag.
	LDA.w $18BD				;$00CCD0	 |\ If the player is not frozen,
	BEQ not_frozen_physics			;$00CCD3	 |/ run regular physics.
	DEC.w $18BD				;$00CCD5	 | Decrease the freeze timer.
	STZ $7B					;$00CCD8	 | Freeze the player's X position.
	LDA.b #$0F				;$00CCDA	 |\ Make the player face the screen.
	STA.w $13E0				;$00CCDC	 |/
.return						;		 |
	RTS					;$00CCDF	/

not_frozen_physics:				;		\
	LDA.w $0D9B				;$00CCE0	 |\ If fighting the mode 7 koopalings,
	BPL no_special_collision		;$00CCE3	 | | use special collision.
	LSR					;$00CCE5	 | |
	BCS no_special_collision		;$00CCE6	 |/
	BIT.w $0D9B				;$00CCE8	 |\ If fighting Morton, Roy, or Ludwig,
	BVS .not_platform			;$00CCEB	 |/ don't use the platform collision.
	LDA $72					;$00CCED	 |\ If in the air,
	BNE .not_platform			;$00CCEF	 |/ use a solid boss room.
	REP #$20				;$00CCF1	 |\
	LDA.w $1436				;$00CCF3	 | | Set the player's platform X position.
	STA $94					;$00CCF6	 | |
	LDA.w $1438				;$00CCF8	 | | Set the player's platform Y position.
	STA $96					;$00CCFB	 | |
	SEP #$20				;$00CCFD	 |/
	JSR apply_player_speeds			;$00CCFF	 | Apply the player's speeds.
	REP #$20				;$00CD02	 |\
	LDA $94					;$00CD04	 | |
	STA.w $1436				;$00CD06	 | | Update the platform X position,
	STA.w $14B4				;$00CD09	 | |
	LDA $96					;$00CD0C	 | | and update the platform Y position.
	AND.w #$FFF0				;$00CD0E	 | |
	STA.w $1438				;$00CD11	 | |
	STA.w $14B6				;$00CD14	 |/
	JSR boss_platform_collision		;$00CD17	 | Apply the platform collision.
	BRA .apply_boss_room_collision		;$00CD1A	/

.not_platform					;		\
	JSR apply_player_speeds			;$00CD1C	 | Apply the player's speeds.
.apply_boss_room_collision			;		 |
	JSR boss_room_collision			;$00CD1F	 | Apply boss room collision.
	BRA skip_standard_collision		;$00CD22	/ 

no_special_collision:				;		\
	LDA $7D					;$00CD24	 |\ If the player is rising
	BPL .no_hit_ceiling			;$00CD26	 | |
	LDA $77					;$00CD28	 | |
	AND.b #$08				;$00CD2A	 | | and hit the ceiling,
	BEQ .no_hit_ceiling			;$00CD2C	 | |
	STZ $7D					;$00CD2E	 |/ clear his Y speed.
.no_hit_ceiling					;		 |
	JSR apply_player_speeds			;$00CD30	 | Apply the player's speeds.
	JSR level_collision			;$00CD33	 | Apply standard level collision.
skip_standard_collision:			;		 |
	JSR check_y_position			;$00CD36	 | Check the player's Y position.
CODE_00CD39:					;		 |
	STZ.w $13DD				;$00CD39	 | Clear the turning around pose.
	LDY.w $13F3				;$00CD3C	 |\ If the player is still getting a P-balloon,
	BNE p_balloon				;$00CD3F	 |/ run the inflation code.
	LDA.w $18BE				;$00CD41	 |\ If the player can climb on air,
	BEQ .no_climb_on_air			;$00CD44	 | |
	LDA.b #$1F				;$00CD46	 | | set the climbing flag.
	STA $8B					;$00CD48	 |/
.no_climb_on_air				;		 |
	LDA $74					;$00CD4A	 |
	BNE CODE_00CD72				;$00CD4C	 |
	LDA.w $148F				;$00CD4E	 |
	ORA.w $187A				;$00CD51	 |
	BNE CODE_00CD79				;$00CD54	 |
	LDA $8B					;$00CD56	 |
	AND.b #$1B				;$00CD58	 |
	CMP.b #$1B				;$00CD5A	 |
	BNE CODE_00CD79				;$00CD5C	 |
	LDA $15					;$00CD5E	 |
	AND.b #$0C				;$00CD60	 |
	BEQ CODE_00CD79				;$00CD62	 |
	LDY $72					;$00CD64	 |
	BNE CODE_00CD72				;$00CD66	 |
	AND.b #$08				;$00CD68	 |
	BNE CODE_00CD72				;$00CD6A	 |
	LDA $8B					;$00CD6C	 |
	AND.b #$04				;$00CD6E	 |
	BEQ CODE_00CD79				;$00CD70	 |
CODE_00CD72:
	LDA $8B
	STA $74					;$00CD74	|
	JMP CODE_00DB17				;$00CD76	|

CODE_00CD79:
	LDA $75
	BEQ use_land_physics			;$00CD7B	|
	JSR water_physics			;$00CD7D	|
	BRA CODE_00CD8F				;$00CD80	|

use_land_physics:
	JSR land_physics			;$00CD82	|
	JSR powerup_physics			;$00CD85	|
	JSR aerial_physics			;$00CD88	|
CODE_00CD8B:
	JSL set_player_pose
CODE_00CD8F:
	LDY.w $187A				;$00CD8F	|
	BNE set_yoshi_pose			;$00CD92	|
	RTS					;$00CD94	|

p_balloon:
	LDA.b #$42				;$00CD95	|
	LDX $19					;$00CD97	|
	BEQ CODE_00CD9D				;$00CD99	|
	LDA.b #$43				;$00CD9B	|
CODE_00CD9D:
	DEY
	BEQ CODE_00CDA5				;$00CD9E	|
	STY.w $13F3				;$00CDA0	|
	LDA.b #$0F				;$00CDA3	|
CODE_00CDA5:
	STA.w $13E0				;$00CDA5	|
	RTS					;$00CDA8	|

yoshi_poses:
	db $20,$21,$27,$28

set_yoshi_pose:					;		\
	LDX.w $14A3				;$00CDAD	 |\ If Yoshi isn't sticking his tongue out,
	BEQ .load_pose				;$00CDB0	 |/ skip to loading the pose.
	LDY.b #$03				;$00CDB2	 | Get ready to lose pose $27.
	CPX.b #$0C				;$00CDB4	 |\ If he's still at the beginning of sticking his tongue out,
	BCS .load_pose				;$00CDB6	 |/
	LDY.b #$04				;$00CDB8	 | Use pose $28.
.load_pose					;		 |
	LDA.w yoshi_poses-1,Y			;$00CDBA	 | Load the pose.
	DEY					;$00CDBD	 |\ If the player isn't turning around or sticking
	BNE .set_pose				;$00CDBE	 | | Yoshi's tongue out,
	LDY $73					;$00CDC0	 | | and the player is ducking,
	BEQ .set_pose				;$00CDC2	 | |
	LDA.b #$1D				;$00CDC4	 | | use pose $1D.
.set_pose					;		 | |
	STA.w $13E0				;$00CDC6	 |/ set the player's pose.
	LDA.w $141E				;$00CDC9	 |\ If the shoot fireballs while on Yoshi flag is set,
	CMP.b #$01				;$00CDCC	 | |
	BNE return_00CDDC			;$00CDCE	 |/
	BIT $16					;$00CDD0	 |\ and X or Y is tapped,
	BVC return_00CDDC			;$00CDD2	 |/
	LDA.b #$08				;$00CDD4	 |\
	STA.w $18DB				;$00CDD6	 |/
	JSR shoot_fireball			;$00CDD9	 | then shoot a fireball.
return_00CDDC:					;		 |
	RTS					;$00CDDC	/

screen_scrolling:
	LDA.w $1411
	BEQ return_00CDDC			;$00CDE0	|
	LDY.w $13FE				;$00CDE2	|
	LDA.w $13FD				;$00CDE5	|
	STA $9D					;$00CDE8	|
	BNE CODE_00CE4C				;$00CDEA	|
	LDA.w $1400				;$00CDEC	|
	BEQ CODE_00CDF6				;$00CDEF	|
	STZ.w $13FE				;$00CDF1	|
	BRA CODE_00CE48				;$00CDF4	|

CODE_00CDF6:
	LDA $17
	AND.b #$CF				;$00CDF8	|
	ORA $15					;$00CDFA	|
	BNE CODE_00CE49				;$00CDFC	|
	LDA $17					;$00CDFE	|
	AND.b #$30				;$00CE00	|
	BEQ CODE_00CE49				;$00CE02	|
	CMP.b #$30				;$00CE04	|
	BEQ CODE_00CE49				;$00CE06	|
ScrollScreen:
	LSR
	LSR					;$00CE09	|
	LSR					;$00CE0A	|
	INC.w $1401				;$00CE0B	|
	LDX.w $1401				;$00CE0E	|
	CPX.b #$10				;$00CE11	|
	BCC CODE_00CE4C				;$00CE13	|
	TAX					;$00CE15	|
	REP #$20				;$00CE16	|
	LDA.w $142A				;$00CE18	|
	CMP.w DATA_00F6CB,X			;$00CE1B	|
	SEP #$20				;$00CE1E	|
	BEQ CODE_00CE4C				;$00CE20	|
	LDA.b #$01				;$00CE22	|
	TRB.w $142A				;$00CE24	|
	INC.w $13FD				;$00CE27	|
	LDA.b #$00				;$00CE2A	|
	CPX.b #$02				;$00CE2C	|
	BNE CODE_00CE33				;$00CE2E	|
	LDA $5E					;$00CE30	|
	DEC A					;$00CE32	|
CODE_00CE33:
	REP #$20
	XBA					;$00CE35	|
	AND.w #$FF00				;$00CE36	|
	CMP $1A					;$00CE39	|
	SEP #$20				;$00CE3B	|
	BEQ CODE_00CE44				;$00CE3D	|
	LDY.b #$0E				;$00CE3F	|
	STY.w $1DFC				;$00CE41	|
CODE_00CE44:
	TXA
	STA.w $13FE				;$00CE45	|
CODE_00CE48:
	TAY
CODE_00CE49:
	STZ.w $1401
CODE_00CE4C:
	LDX.b #$00
	LDA $76					;$00CE4E	|
	ASL					;$00CE50	|
	STA.w $13FF				;$00CE51	|
	REP #$20				;$00CE54	|
	LDA.w $142A				;$00CE56	|
	CMP.w DATA_00F6CB,Y			;$00CE59	|
	BEQ CODE_00CE6D				;$00CE5C	|
	CLC					;$00CE5E	|
	ADC.w DATA_00F6BF,Y			;$00CE5F	|
	LDY.w $13FF				;$00CE62	|
	CMP.w DATA_00F6B3,Y			;$00CE65	|
	BNE CODE_00CE70				;$00CE68	|
	STX.w $13FE				;$00CE6A	|
CODE_00CE6D:
	STX.w $13FD
CODE_00CE70:
	STA.w $142A
	STX.w $1400				;$00CE73	|
	SEP #$20				;$00CE76	|
CODE_00CE78:
	RTS

DATA_00CE79:
	db $2A,$2B,$2C,$2D,$2E,$2F

DATA_00CE7F:
	db $2C,$2C,$2C,$2B,$2B,$2C,$2C,$2B
	db $2B,$2C,$2D,$2A,$2A,$2D,$2D,$2A
	db $2A,$2D,$2D,$2A,$2A,$2D,$2E,$2A
	db $2A,$2E

DATA_00CE99:
	db $00,$00,$25,$44,$00,$00,$0F,$45
DATA_00CEA1:
	db $00,$00,$00,$00,$01,$01,$01,$01
DATA_00CEA9:
	db $02,$07,$06,$09,$02,$07,$06,$09

set_player_pose:
	LDA.w $14A2				;$00CEB1	|
	BNE lbl14A2Not0				;$00CEB4	|
	LDX.w $13DF				;$00CEB6	|
	LDA $72					;$00CEB9	|
	BEQ MarioAnimAir			;$00CEBB	|
	LDY.b #$04				;$00CEBD	|
	BIT $7D					;$00CEBF	|
	BPL CODE_00CECD				;$00CEC1	|
	CMP.b #$0C				;$00CEC3	|
	BEQ CODE_00CEFD				;$00CEC5	|
	LDA $75					;$00CEC7	|
	BNE CODE_00CEFD				;$00CEC9	|
	BRA MrioNtInWtr				;$00CECB	|

CODE_00CECD:
	INX
	CPX.b #$05				;$00CECE	|
	BCS CODE_00CED6				;$00CED0	|
	LDX.b #$05				;$00CED2	|
	BRA CODE_00CF0A				;$00CED4	|

CODE_00CED6:
	CPX.b #$0B
	BCC CODE_00CF0A				;$00CED8	|
	LDX.b #$07				;$00CEDA	|
	BRA CODE_00CF0A				;$00CEDC	|

MarioAnimAir:
	LDA $7B
	BNE CODE_00CEF0				;$00CEE0	|
	LDY.b #$08				;$00CEE2	|
MrioNtInWtr:
	TXA
	BEQ CODE_00CF0A				;$00CEE5	|
	DEX					;$00CEE7	|
	CPX.b #$03				;$00CEE8	|
	BCC CODE_00CF0A				;$00CEEA	|
	LDX.b #$02				;$00CEEC	|
	BRA CODE_00CF0A				;$00CEEE	|

CODE_00CEF0:
	BPL CODE_00CEF5
	EOR.b #$FF				;$00CEF2	|
	INC A					;$00CEF4	|
CODE_00CEF5:
	LSR
	LSR					;$00CEF6	|
	LSR					;$00CEF7	|
	TAY					;$00CEF8	|
	LDA.w DATA_00DC7C,Y			;$00CEF9	|
	TAY					;$00CEFC	|
CODE_00CEFD:
	INX
	CPX.b #$03				;$00CEFE	|
	BCS CODE_00CF04				;$00CF00	|
	LDX.b #$05				;$00CF02	|
CODE_00CF04:
	CPX.b #$07
	BCC CODE_00CF0A				;$00CF06	|
	LDX.b #$03				;$00CF08	|
CODE_00CF0A:
	STX.w $13DF
	TYA					;$00CF0D	|
	LDY $75					;$00CF0E	|
	BEQ CODE_00CF13				;$00CF10	|
	ASL					;$00CF12	|
CODE_00CF13:
	STA.w $14A2
lbl14A2Not0:
	LDA.w $140D
	ORA.w $14A6				;$00CF19	|
	BEQ CODE_00CF4E				;$00CF1C	|
	STZ $73					;$00CF1E	|
	LDA $14					;$00CF20	|
	AND.b #$06				;$00CF22	|
	TAX					;$00CF24	|
	TAY					;$00CF25	|
	LDA $72					;$00CF26	|
	BEQ CODE_00CF2F				;$00CF28	|
	LDA $7D					;$00CF2A	|
	BMI CODE_00CF2F				;$00CF2C	|
	INY					;$00CF2E	|
CODE_00CF2F:
	LDA.w DATA_00CEA9,Y
	STA.w $13DF				;$00CF32	|
	LDA $19					;$00CF35	|
	BEQ CODE_00CF3A				;$00CF37	|
	INX					;$00CF39	|
CODE_00CF3A:
	LDA.w DATA_00CEA1,X
	STA $76					;$00CF3D	|
	LDY $19					;$00CF3F	|
	CPY.b #$02				;$00CF41	|
	BNE CODE_00CF48				;$00CF43	|
	JSR CODE_00D044				;$00CF45	|
CODE_00CF48:
	LDA.w DATA_00CE99,X
	JMP CODE_00D01A				;$00CF4B	|

CODE_00CF4E:
	LDA.w $13ED
	BEQ CODE_00CF62				;$00CF51	|
	BPL CODE_00CF85				;$00CF53	|
	LDA.w $13E1				;$00CF55	|
	LSR					;$00CF58	|
	LSR					;$00CF59	|
	ORA $76					;$00CF5A	|
	TAY					;$00CF5C	|
	LDA.w DATA_00CE7F,Y			;$00CF5D	|
	BRA CODE_00CF85				;$00CF60	|

CODE_00CF62:
	LDA.b #$3C
	LDY.w $148F				;$00CF64	|
	BEQ CODE_00CF6B				;$00CF67	|
	LDA.b #$1D				;$00CF69	|
CODE_00CF6B:
	LDY $73
	BNE CODE_00CF85				;$00CF6D	|
	LDA.w $149C				;$00CF6F	|
	BEQ CODE_00CF7E				;$00CF72	|
	LDA.b #$3F				;$00CF74	|
	LDY $72					;$00CF76	|
	BEQ CODE_00CF85				;$00CF78	|
	LDA.b #$16				;$00CF7A	|
	BRA CODE_00CF85				;$00CF7C	|

CODE_00CF7E:
	LDA.b #$0E
	LDY.w $149A				;$00CF80	|
	BEQ CODE_00CF88				;$00CF83	|
CODE_00CF85:
	JMP CODE_00D01A

CODE_00CF88:
	LDA.b #$1D
	LDY.w $1498				;$00CF8A	|
	BNE CODE_00CF85				;$00CF8D	|
	LDA.b #$0F				;$00CF8F	|
	LDY.w $1499				;$00CF91	|
	BNE CODE_00CF85				;$00CF94	|
	LDA.b #$00				;$00CF96	|
	LDX.w $18C2				;$00CF98	|
	BNE MarioAnimNoAbs1			;$00CF9B	|
	LDA $72					;$00CF9D	|
	BEQ CODE_00CFB7				;$00CF9F	|
	LDY.w $14A0				;$00CFA1	|
	BNE CODE_00CFBC				;$00CFA4	|
	LDY.w $1407				;$00CFA6	|
	BEQ CODE_00CFAE				;$00CFA9	|
	LDA.w CODE_00CE78,Y			;$00CFAB	|
CODE_00CFAE:
	LDY.w $148F
	BEQ CODE_00D01A				;$00CFB1	|
	LDA.b #$09				;$00CFB3	|
	BRA CODE_00D01A				;$00CFB5	|

CODE_00CFB7:
	LDA.w $13DD
	BNE CODE_00D01A				;$00CFBA	|
CODE_00CFBC:
	LDA $7B
	BPL MarioAnimNoAbs1			;$00CFBE	|
	EOR.b #$FF				;$00CFC0	|
	INC A					;$00CFC2	|
MarioAnimNoAbs1:
	TAX
	BNE CODE_00CFD4				;$00CFC4	|
	XBA					;$00CFC6	|
	LDA $15					;$00CFC7	|
	AND.b #$08				;$00CFC9	|
	BEQ CODE_00D002				;$00CFCB	|
	LDA.b #$03				;$00CFCD	|
	STA.w $13DE				;$00CFCF	|
	BRA CODE_00D002				;$00CFD2	|

CODE_00CFD4:
	LDA $86
	BEQ CODE_00CFE3				;$00CFD6	|
	LDA $15					;$00CFD8	|
	AND.b #$03				;$00CFDA	|
	BEQ CODE_00D003				;$00CFDC	|
	LDA.b #$68				;$00CFDE	|
	STA.w $13E5				;$00CFE0	|
CODE_00CFE3:
	LDA.w $13DB
	LDY.w $1496				;$00CFE6	|
	BNE CODE_00D003				;$00CFE9	|
	DEC A					;$00CFEB	|
	BPL CODE_00CFF3				;$00CFEC	|
	LDY $19					;$00CFEE	|
	LDA.w NumWalkingFrames,Y		;$00CFF0	|
CODE_00CFF3:
	XBA
	TXA					;$00CFF4	|
	LSR					;$00CFF5	|
	LSR					;$00CFF6	|
	LSR					;$00CFF7	|
	ORA.w $13E5				;$00CFF8	|
	TAY					;$00CFFB	|
	LDA.w DATA_00DC7C,Y			;$00CFFC	|
	STA.w $1496				;$00CFFF	|
CODE_00D002:
	XBA
CODE_00D003:
	STA.w $13DB
	CLC					;$00D006	|
	ADC.w $13DE				;$00D007	|
	LDY.w $148F				;$00D00A	|
	BEQ CODE_00D014				;$00D00D	|
	CLC					;$00D00F	|
	ADC.b #$07				;$00D010	|
	BRA CODE_00D01A				;$00D012	|

CODE_00D014:
	CPX.b #$2F
	BCC CODE_00D01A				;$00D016	|
	ADC.b #$03				;$00D018	|
CODE_00D01A:
	LDY.w $13E3
	BEQ MarioAnimNo45			;$00D01D	|
	TYA					;$00D01F	|
	AND.b #$01				;$00D020	|
	STA $76					;$00D022	|
	LDA.b #$10				;$00D024	|
	CPY.b #$06				;$00D026	|
	BCC MarioAnimNo45			;$00D028	|
	LDA.w $13DB				;$00D02A	|
	CLC					;$00D02D	|
	ADC.b #$11				;$00D02E	|
MarioAnimNo45:
	STA.w $13E0
	RTL					;$00D033	|

DATA_00D034:
	db $0C,$00,$F4,$FF,$08,$00,$F8,$FF
DATA_00D03C:
	db $10,$00,$10,$00,$02,$00,$02,$00

CODE_00D044:
	LDY.b #$01
	STY.w $13E8				;$00D046	|
	ASL					;$00D049	|
	TAY					;$00D04A	|
	REP #$20				;$00D04B	|
	LDA $94					;$00D04D	|
	CLC					;$00D04F	|
	ADC.w DATA_00D034,Y			;$00D050	|
	STA.w $13E9				;$00D053	|
	LDA $96					;$00D056	|
	CLC					;$00D058	|
	ADC.w DATA_00D03C,Y			;$00D059	|
	STA.w $13EB				;$00D05C	|
	SEP #$20				;$00D05F	|
	RTS					;$00D061	|

powerup_physics:				;		\
	LDA $19					;$00D062	 |\ If the player is caped,
	CMP.b #$02				;$00D064	 |/
	BNE .not_caped				;$00D066	 |
	BIT $16					;$00D068	 |\ and X or Y are tapped,
	BVC .return				;$00D06A	 |/
	LDA $73					;$00D06C	 |\ and the player is neither ducking,
	ORA.w $187A				;$00D06E	 | | nor on Yoshi,
	ORA.w $140D				;$00D071	 | | nor spin jumping,
	BNE .return				;$00D074	 |/
	LDA.b #$12				;$00D076	 |\ then set the cape spin timer
	STA.w $14A6				;$00D078	 |/
	LDA.b #$04				;$00D07B	 |\ and play the cape spin sound.
	STA.w $1DFC				;$00D07D	 |/
	RTS					;$00D080	/

.not_caped					;		\
	CMP.b #$03				;$00D081	 |\ If the player is fiery,
	BNE .return				;$00D083	 |/ 
	LDA $73					;$00D085	 |\ and not on Yoshi,
	ORA.w $187A				;$00D087	 | |
	BNE .return				;$00D08A	 |/
	BIT $16					;$00D08C	 |\ and X or Y are tapped,
	BVS .shoot_fireball			;$00D08E	 |/ shoot a fireball.
	LDA.w $140D				;$00D090	 |\ If the player is spinjumping,
	BEQ .return				;$00D093	 |/
	INC.w $13E2				;$00D095	 | increment the spinjump fireball timer.
	LDA.w $13E2				;$00D098	 |\ Every 16 frames,
	AND.b #$0F				;$00D09B	 | | shoot a fireball,
	BNE .return				;$00D09D	 |/
	TAY					;$00D09F	 |
	LDA.w $13E2				;$00D0A0	 |\
	AND.b #$10				;$00D0A3	 | |
	BEQ .face_left				;$00D0A5	 | | and also flip the player's direction.
	INY					;$00D0A7	 | |
.face_left					;		 | |
	STY $76					;$00D0A8	 |/
.shoot_fireball					;		 |
	JSR shoot_fireball			;$00D0AA	 | Shoot a fireball.
.return						;		 |
	RTS					;$00D0AD	/

DATA_00D0AE:
	db $7C,$00,$80,$00,$00,$06,$00,$01

death_animation:
	STZ $19					;$00D0B6	\ Clear the player's powerup.
	LDA.b #$3E				;$00D0B8	 |\ Set the death pose.
	STA.w $13E0				;$00D0BA	 |/
	LDA $13					;$00D0BD	 |\
	AND.b #$03				;$00D0BF	 | | Every four frames,
	BNE .no_decrement			;$00D0C1	 | |
	DEC.w $1496				;$00D0C3	 | | decrease the player animation timer.
.no_decrement					;		 |/
	LDA.w $1496				;$00D0C6	 |\ If it's not zero,
	BNE .not_done				;$00D0C9	 |/ keep letting the player fall.
	LDA.b #$80				;$00D0CB	 |\ Exit the level without events occuring.
	STA.w $0DD5				;$00D0CD	 |/
	LDA.w $1B9B				;$00D0D0	 |\ If yoshi has not been left behind,
	BNE .keep_yoshi				;$00D0D3	 | |
	STZ.w $0DC1				;$00D0D5	 | | get rid of him.
.keep_yoshi					;		 |/
	DEC.w $0DBE				;$00D0D8	 |\ Decrease the player's lives.
	BPL .not_game_over			;$00D0DB	 |/ If it's negative, show "GAME OVER"
	LDA.b #$0A				;$00D0DD	 |\ Play the game over music.
	STA.w $1DFB				;$00D0DF	 |/
	LDX.b #$14				;$00D0E2	 | Show the "GAME OVER" message.
	BRA .show_message			;$00D0E4	/

.not_game_over
	LDY.b #$0B				;$00D0E6	\ Load the fade to OW game mode.
	LDA.w $0F31				;$00D0E8	 |\ If the hundreds place of the time,
	ORA.w $0F32				;$00D0EB	 | | the tens place,
	ORA.w $0F33				;$00D0EE	 | | and the ones place are zero,
	BNE .not_time_up			;$00D0F1	 | |
	LDX.b #$1D				;$00D0F3	 | | show the "TIME UP" message.
.show_message					;		 |/
	STX.w $143B				;$00D0F5	 | Set the death message.
	LDA.b #$C0				;$00D0F8	 |\ Set the death message timer.
	STA.w $143C				;$00D0FA	 |/
	LDA.b #$FF				;$00D0FD	 |\ Set how long the death message should persist.
	STA.w $143D				;$00D0FF	 |/
	LDY.b #$15				;$00D102	 | Load the "GAME OVER" or "TIME UP" game mode,
.not_time_up					;		 |
	STY.w $0100				;$00D104	 | and set the game mode.
	RTS					;$00D107	/

.not_done
	CMP.b #$26				;$00D108	\ Keep the player still for a bit.
	BCS .return				;$00D10A	 |
	STZ $7B					;$00D10C	 | Clear the player's X speed,
	JSR apply_player_speeds			;$00D10E	 | apply the player's X and Y speeds,
	JSR CODE_00D92E				;$00D111	 | update the player's gravity,
	LDA $13					;$00D114	 |\
	LSR					;$00D116	 | |
	LSR					;$00D117	 | | and flip the player's direction every four frames.
	AND.b #$01				;$00D118	 | |
	STA $76					;$00D11A	 |/
.return						;		 |
	RTS					;$00D11C	/

growing_hurt_poses:
	db $00,$3D,$00,$3D,$00,$3D,$46,$3D
	db $46,$3D,$46,$3D

hurt_animation:
	LDA.w $1496				;$00D129	\ If the animation timer has ended,
	BEQ set_invincibility			;$00D12C	 | set temporary invincibility.
	LSR					;$00D12E	 |\
	LSR					;$00D12F	 | | Divide the timer by four,
set_growing_poses:				;		 | |
	TAY					;$00D130	 | |
	LDA.w growing_hurt_poses,Y		;$00D131	 | | and set the player's pose based on the timer
	STA.w $13E0				;$00D134	 |/ and the sequence of hurt poses.
decrement_animation_timer:			;		 |
	LDA.w $1496				;$00D137	 |\ If the animation timer is nonzero,
	BEQ .return				;$00D13A	 | |
	DEC.w $1496				;$00D13C	 |/ decrement it.
.return						;		 |
	RTS					;$00D13F	/

set_invincibility:
	LDA.b #$7F				;$00D140	\ Set invincibility for $7F frames.
	STA.w $1497				;$00D142	 |
	BRA reset_animation			;$00D145	/ Reset the animation.

mushroom_animation:
	LDA.w $1496				;$00D147	\ If the animation timer has ended,
	BEQ .set_powerup			;$00D14A	 | set the player's powerup.
	LSR					;$00D14C	 |\
	LSR					;$00D14D	 | | Divide the timer by four,
	EOR.b #$FF				;$00D14E	 | |
	INC A					;$00D150	 | |
	CLC					;$00D151	 | |
	ADC.b #$0B				;$00D152	 |/ and set the player's pose based on the timer
	BRA set_growing_poses			;$00D154	/ and the reversed sequence of hurt poses.

.set_powerup
	INC $19					;$00D156	\ Set the player as big.
reset_animation:				;		 |
	LDA.b #$00				;$00D158	 |\ Reset the player animation,
	STA $71					;$00D15A	 | |
	STZ $9D					;$00D15C	 |/ and clear the lock sprites flag.
return_00D15E:					;		 |
	RTS					;$00D15E	/

cape_animation:
	LDA.b #$7F				;$00D15F	\ Hide all of the player.
	STA $78					;$00D161	 |
	DEC.w $1496				;$00D163	 |\ Decrement the animation timer.
	BNE return_00D15E			;$00D166	 |/ If it's not zero, return.
	LDA $19					;$00D168	 |\ If the player is small or big,
	LSR					;$00D16A	 | |
	BEQ set_invincibility			;$00D16B	 |/ set invincibility.
	BNE reset_animation			;$00D16D	/ Reset the animation.

flower_animation:				;		\
	LDA.w $13ED				;$00D16F	 |\ If the player is cape-sliding on the ground
	AND.b #$80				;$00D172	 | |
	ORA.w $1407				;$00D174	 | | or flying in the air,
	BEQ CODE_00D187				;$00D177	 |/
	STZ.w $1407				;$00D179	 |\ stop flying,
	LDA.w $13ED				;$00D17C	 | |
	AND.b #$7F				;$00D17F	 | |
	STA.w $13ED				;$00D181	 | | stop cape-sliding on the ground,
	STZ.w $13E0				;$00D184	 |/ and reset the player's pose.
CODE_00D187:					;		 |
	DEC.w $149B				;$00D187	 |\ Decrease the palette cycle timer.
	BEQ reset_animation			;$00D18A	 |/ If it's zero, reset the animation.
	RTS					;$00D18C	/

pipe_x_speeds:
	db $F8,$08

pipe_y_speeds:
	db $00,$00,$F0

DATA_00D192:
	db $10

DATA_00D193:
	db $00,$63,$1C,$00

horizontal_pipe_animation:
	JSR disable_controls
	STZ.w $13DE				;$00D19A	|
	JSL set_player_pose			;$00D19D	|
	JSL CODE_00CFBC				;$00D1A1	|
	JSR CODE_00D1F4				;$00D1A5	|
	LDA.w $187A				;$00D1A8	|
	BEQ CODE_00D1B2				;$00D1AB	|
	LDA.b #$29				;$00D1AD	|
	STA.w $13E0				;$00D1AF	|
CODE_00D1B2:
	REP #$20
	LDA $96					;$00D1B4	|
	SEC					;$00D1B6	|
	SBC.w #$0008				;$00D1B7	|
	AND.w #$FFF0				;$00D1BA	|
	ORA.w #$000E				;$00D1BD	|
	STA $96					;$00D1C0	|
	SEP #$20				;$00D1C2	|
	LDA $89					;$00D1C4	|
	LSR					;$00D1C6	|
	TAY					;$00D1C7	|
	INY					;$00D1C8	|
	LDA.w DATA_00D192,Y			;$00D1C9	|
	LDX.w $148F				;$00D1CC	|
	BEQ CODE_00D1DB				;$00D1CF	|
	EOR.b #$1C				;$00D1D1	|
	DEC.w $1499				;$00D1D3	|
	BPL CODE_00D1DB				;$00D1D6	|
	INC.w $1499				;$00D1D8	|
CODE_00D1DB:
	LDX $88
	CPX.b #$1D				;$00D1DD	|
	BCS CODE_00D1F0				;$00D1DF	|
	CPY.b #$03				;$00D1E1	|
	BCC CODE_00D1ED				;$00D1E3	|
	REP #$20				;$00D1E5	|
	INC $96					;$00D1E7	|
	INC $96					;$00D1E9	|
	SEP #$20				;$00D1EB	|
CODE_00D1ED:
	LDA.w DATA_00D193,Y
CODE_00D1F0:
	STA $78
	BRA CODE_00D22D				;$00D1F2	|

CODE_00D1F4:
	LDA.w $14A2
	BEQ CODE_00D1FC				;$00D1F7	|
	DEC.w $14A2				;$00D1F9	|
CODE_00D1FC:
	JMP decrement_animation_timer

PipeCntrBoundryX:
	db $0A,$06

PipeCntringSpeed:
	db $FF,$01

vertical_pipe_animation:
	JSR disable_controls
	STZ.w $13DF				;$00D206	|
	LDA.b #$0F				;$00D209	|
	LDY.w $187A				;$00D20B	|
	BEQ CODE_00D22A				;$00D20E	|
	LDX.b #$00				;$00D210	|
	LDY $76					;$00D212	|
	LDA $94					;$00D214	|
	AND.b #$0F				;$00D216	|
	CMP.w PipeCntrBoundryX,Y		;$00D218	|
	BEQ CODE_00D228				;$00D21B	|
	BPL CODE_00D220				;$00D21D	|
	INX					;$00D21F	|
CODE_00D220:
	LDA $94
	CLC					;$00D222	|
	ADC.w PipeCntringSpeed,X		;$00D223	|
	STA $94					;$00D226	|
CODE_00D228:
	LDA.b #$21
CODE_00D22A:
	STA.w $13E0
CODE_00D22D:
	LDA.b #$40
	STA $15					;$00D22F	|
	LDA.b #$02				;$00D231	|
	STA.w $13F9				;$00D233	|
	LDA $89					;$00D236	|
	CMP.b #$04				;$00D238	|
	LDY $88					;$00D23A	|
	BEQ CODE_00D268				;$00D23C	|
	AND.b #$03				;$00D23E	|
	TAY					;$00D240	|
	DEC $88					;$00D241	|
	BNE CODE_00D24E				;$00D243	|
	BCS CODE_00D24E				;$00D245	|
	LDA.b #$7F				;$00D247	|
	STA $78					;$00D249	|
	INC.w $1405				;$00D24B	|
CODE_00D24E:
	LDA $7B
	ORA $7D					;$00D250	|
	BNE CODE_00D259				;$00D252	|
	LDA.b #$04				;$00D254	|
	STA.w $1DF9				;$00D256	|
CODE_00D259:
	LDA.w pipe_x_speeds,Y
	STA $7B					;$00D25C	|
	LDA.w pipe_y_speeds,Y			;$00D25E	|
	STA $7D					;$00D261	|
	STZ $72					;$00D263	|
	JMP apply_player_speeds			;$00D265	|

CODE_00D268:
	BCC go_to_sublevel
CODE_00D26A:
	STZ.w $13F9
	STZ.w $1419				;$00D26D	|
	JMP reset_animation			;$00D270	|

go_to_sublevel:
	INC.w $141A				;$00D273	\ Increase the sub-level counter,
	LDA.b #$0F				;$00D276	 |
	STA.w $0100				;$00D278	 | and fade in to another level.
	RTS					;$00D27B	/

	LDA $96					;$00D27C	|
	SEC					;$00D27E	|
	SBC $D3					;$00D27F	|
	CLC					;$00D281	|
	ADC $88					;$00D282	|
	STA $88					;$00D284	|
	RTS					;$00D286	|

slanted_pipe_animation:
	JSR disable_controls
	LDA.b #$02				;$00D28A	|
	STA.w $13F9				;$00D28C	|
	LDA.b #$0C				;$00D28F	|
	STA $72					;$00D291	|
	JSR CODE_00CD8B				;$00D293	|
	DEC $88					;$00D296	|
	BNE CODE_00D29D				;$00D298	|
	JMP CODE_00D26A				;$00D29A	|

CODE_00D29D:
	LDA $88
	CMP.b #$18				;$00D29F	|
	BCC CODE_00D2AA				;$00D2A1	|
	BNE CODE_00D2B2				;$00D2A3	|
	LDA.b #$09				;$00D2A5	|
	STA.w $1DFC				;$00D2A7	|
CODE_00D2AA:
	STZ.w $13F9
	STZ.w $1419				;$00D2AD	|
	STZ $9D					;$00D2B0	|
CODE_00D2B2:
	LDA.b #$40
	STA $7B					;$00D2B4	|
	LDA.b #$C0				;$00D2B6	|
	STA $7D					;$00D2B8	|
	JMP apply_player_speeds			;$00D2BA	|

DATA_00D2BD:
	db $B0,$B6,$AE,$B4,$AB,$B2,$A9,$B0
	db $A6,$AE,$A4,$AB,$A1,$A9,$9F,$A6
DATA_00D2CD:
	db $00,$FF,$00,$01,$00,$FF,$00,$01
	db $00,$FF,$00,$01,$80,$FE,$C0,$00
	db $40,$FF,$80,$01,$00,$FE,$40,$00
	db $C0,$FF,$00,$02,$00,$FE,$40,$00
	db $00,$FE,$40,$00,$C0,$FF,$00,$02
	db $C0,$FF,$00,$02,$00,$FC,$00,$FF
	db $00,$01,$00,$04,$00,$FF,$00,$01
	db $00,$FF,$00,$01

DATA_00D309:
	db $E0,$FF,$20,$00,$E0,$FF,$20,$00
	db $E0,$FF,$20,$00,$C0,$FF,$20,$00
	db $E0,$FF,$40,$00,$80,$FF,$20,$00
	db $E0,$FF,$80,$00,$80,$FF,$20,$00
	db $80,$FF,$20,$00,$E0,$FF,$80,$00
	db $E0,$FF,$80,$00,$00,$FE,$80,$FF
	db $80,$00,$00,$02,$00,$FF,$00,$01
	db $00,$FF,$00,$01

MarioAccel:
	db $80

MarioAccel2:
	db $FE,$80,$FE,$80,$01,$80,$01,$80
	db $FE,$80,$FE,$80,$01,$80,$01,$80
	db $FE,$80,$FE,$80,$01,$80,$01,$80
	db $FE,$80,$FE,$40,$01,$40,$01,$C0
	db $FE,$C0,$FE,$80,$01,$80,$01,$80
	db $FE,$80,$FE,$00,$01,$00,$01,$00
	db $FF,$00,$FF,$80,$01,$80,$01,$80
	db $FE,$80,$FE,$00,$01,$00,$01,$80
	db $FE,$80,$FE,$00,$01,$00,$01,$00
	db $FF,$00,$FF,$80,$01,$80,$01,$00
	db $FF,$00,$FF,$80,$01,$80,$01,$00
	db $FC,$00,$FC,$00,$FD,$00,$FD,$00
	db $03,$00,$03,$00,$04,$00,$04,$00
	db $FC,$00,$FC,$00,$06,$00,$06,$00
	db $FA,$00,$FA,$00,$04,$00,$04,$80
	db $FF,$80,$00,$00,$FF,$00,$01,$80
	db $FE,$80,$01,$80,$FE,$80,$FE,$80
	db $01,$80,$01,$80,$FE,$80,$02,$80
	db $FD,$00,$FB,$80,$02,$00,$05,$80
	db $FD,$00,$FB,$80,$02,$00,$05,$80
	db $FD,$00,$FB,$80,$02,$00,$05,$40
	db $FD,$80,$FA,$40,$02,$80,$04,$C0
	db $FD,$80,$FB,$C0,$02,$80,$05,$00
	db $FD,$00,$FA,$00,$02,$00,$04,$00
	db $FE,$00,$FC,$00,$03,$00,$06,$00
	db $FD,$00,$FA,$00,$02,$00,$04,$00
	db $FD,$00,$FA,$00,$02,$00,$04,$00
	db $FE,$00,$FC,$00,$03,$00,$06,$00
	db $FE,$00,$FC,$00,$03,$00,$06,$00
	db $FD,$00,$FA,$00,$FD,$00,$FA,$00
	db $03,$00,$06,$00,$03,$00,$06

DATA_00D43D:
	db $80,$FF,$80,$FE,$80,$00,$80,$01
	db $80,$FF,$80,$FE,$80,$00,$80,$01
	db $80,$FF,$80,$FE,$80,$00,$80,$01
	db $80,$FE,$80,$FE,$80,$00,$40,$01
	db $80,$FF,$C0,$FE,$80,$01,$80,$01
	db $80,$FE,$80,$FE,$80,$00,$00,$01
	db $80,$FF,$00,$FF,$80,$01,$80,$01
	db $80,$FE,$80,$FE,$80,$00,$00,$01
	db $80,$FE,$80,$FE,$80,$00,$00,$01
	db $80,$FF,$00,$FF,$80,$01,$80,$01
	db $80,$FF,$00,$FF,$80,$01,$80,$01
	db $00,$FC,$00,$FC,$00,$FE,$00,$FD
	db $00,$03,$00,$03,$00,$04,$00,$04
	db $00,$FC,$00,$FC,$80,$00,$80,$00
	db $80,$FF,$80,$FF,$00,$04,$00,$04
	db $80,$FF,$80,$00,$00,$FF,$00,$01
	db $80,$FE,$80,$01,$80,$FE,$80,$FE
	db $80,$01,$80,$01,$80,$FE,$80,$02
	db $C0,$FF,$80,$FD,$40,$00,$80,$02
	db $C0,$FF,$80,$FD,$40,$00,$80,$02
	db $C0,$FF,$80,$FD,$40,$00,$80,$02
	db $80,$FF,$40,$FD,$40,$00,$40,$02
	db $C0,$FF,$C0,$FD,$80,$00,$C0,$02
	db $00,$FD,$00,$FD,$40,$00,$00,$02
	db $C0,$FF,$00,$FE,$00,$03,$00,$03
	db $00,$FD,$00,$FD,$40,$00,$00,$02
	db $00,$FD,$00,$FD,$40,$00,$00,$02
	db $C0,$FF,$00,$FE,$00,$03,$00,$03
	db $C0,$FF,$00,$FE,$00,$03,$00,$03
	db $00,$FD,$00,$FD,$00,$FD,$00,$FD
	db $00,$03,$00,$03,$00,$03,$00,$03
DATA_00D535:
	db $EC,$14,$DC,$24,$DC,$24,$D0,$30
	db $EC,$14,$DC,$24,$DC,$24,$D0,$30
	db $EC,$14,$DC,$24,$DC,$24,$D0,$30
	db $E8,$12,$DC,$20,$DC,$20,$D0,$2C
	db $EE,$18,$E0,$24,$E0,$24,$D4,$30
	db $DC,$10,$DC,$1C,$DC,$1C,$D0,$28
	db $F0,$24,$E4,$24,$E4,$24,$D8,$30
	db $DC,$10,$DC,$1C,$DC,$1C,$D0,$28
	db $DC,$10,$DC,$1C,$DC,$1C,$D0,$28
	db $F0,$24,$E4,$24,$E4,$24,$D8,$30
	db $F0,$24,$E4,$24,$E4,$24,$D8,$30
	db $DC,$F0,$DC,$F8,$DC,$F8,$D0,$FC
	db $10,$24,$08,$24,$08,$24,$04,$30
	db $D0,$08,$D0,$08,$D0,$08,$D0,$08
	db $F8,$30,$F8,$30,$F8,$30,$F8,$30
	db $F8,$08,$F0,$10,$F4,$04,$E8,$08
	db $F0,$10,$E0,$20,$EC,$0C,$D8,$18
	db $D8,$28,$D4,$2C,$D0,$30,$D0,$D0
	db $30,$30,$E0,$20

DATA_00D5C9:
	db $00

DATA_00D5CA:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$F0,$00,$10,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$E0,$00
	db $20,$00,$00,$00,$00,$00,$F0,$00
	db $F8

DATA_00D5EB:
	db $FF,$FF,$02

DATA_00D5EE:
	db $68,$70

DATA_00D5F0:
	db $1C,$0C

land_physics:
	LDA $72					;$00D5F2	|
	BEQ CODE_00D5F9				;$00D5F4	|
	JMP CODE_00D682				;$00D5F6	|

CODE_00D5F9:
	STZ $73
	LDA.w $13ED				;$00D5FB	|
	BNE CODE_00D60B				;$00D5FE	|
	LDA $15					;$00D600	|
	AND.b #$04				;$00D602	|
	BEQ CODE_00D60B				;$00D604	|
	STA $73					;$00D606	|
	STZ.w $13E8				;$00D608	|
CODE_00D60B:
	LDA.w $1471
	CMP.b #$02				;$00D60E	|
	BEQ CODE_00D61E				;$00D610	|
	LDA $77					;$00D612	|
	AND.b #$08				;$00D614	|
	BNE CODE_00D61E				;$00D616	|
	LDA $16					;$00D618	|
	ORA $18					;$00D61A	|
	BMI CODE_00D630				;$00D61C	|
CODE_00D61E:
	LDA $73
	BEQ CODE_00D682				;$00D620	|
	LDA $7B					;$00D622	|
	BEQ CODE_00D62D				;$00D624	|
	LDA $86					;$00D626	|
	BNE CODE_00D62D				;$00D628	|
	JSR CODE_00FE4A				;$00D62A	|
CODE_00D62D:
	JMP CODE_00D764

CODE_00D630:
	LDA $7B
	BPL CODE_00D637				;$00D632	|
	EOR.b #$FF				;$00D634	|
	INC A					;$00D636	|
CODE_00D637:
	LSR
	LSR					;$00D638	|
	AND.b #$FE				;$00D639	|
	TAX					;$00D63B	|
	LDA $18					;$00D63C	|
	BPL CODE_00D65E				;$00D63E	|
	LDA.w $148F				;$00D640	|
	BNE CODE_00D65E				;$00D643	|
	INC A					;$00D645	|
	STA.w $140D				;$00D646	|
	LDA.b #$04				;$00D649	|
	STA.w $1DFC				;$00D64B	|
	LDY $76					;$00D64E	|
	LDA.w DATA_00D5F0,Y			;$00D650	|
	STA.w $13E2				;$00D653	|
	LDA.w $187A				;$00D656	|
	BNE CODE_00D682				;$00D659	|
	INX					;$00D65B	|
	BRA CODE_00D663				;$00D65C	|

CODE_00D65E:
	LDA.b #$01
	STA.w $1DFA				;$00D660	|
CODE_00D663:
	LDA.w DATA_00D2BD,X
	STA $7D					;$00D666	|
	LDA.b #$0B				;$00D668	|
	LDY.w $13E4				;$00D66A	|
	CPY.b #$70				;$00D66D	|
	BCC CODE_00D67D				;$00D66F	|
	LDA.w $149F				;$00D671	|
	BNE CODE_00D67B				;$00D674	|
	LDA.b #$50				;$00D676	|
	STA.w $149F				;$00D678	|
CODE_00D67B:
	LDA.b #$0C
CODE_00D67D:
	STA $72
	STZ.w $13ED				;$00D67F	|
CODE_00D682:
	LDA.w $13ED
	BMI CODE_00D692				;$00D685	|
	LDA $15					;$00D687	|
	AND.b #$03				;$00D689	|
	BNE CODE_00D6B1				;$00D68B	|
CODE_00D68D:
	LDA.w $13ED
	BEQ CODE_00D6AE				;$00D690	|
CODE_00D692:
	JSR CODE_00FE4A
	LDA.w $13EE				;$00D695	|
	BEQ CODE_00D6AE				;$00D698	|
	JSR CODE_00D968				;$00D69A	|
	LDA.w $13E1				;$00D69D	|
	LSR					;$00D6A0	|
	LSR					;$00D6A1	|
	TAY					;$00D6A2	|
	ADC.b #$76				;$00D6A3	|
	TAX					;$00D6A5	|
	TYA					;$00D6A6	|
	LSR					;$00D6A7	|
	ADC.b #$87				;$00D6A8	|
	TAY					;$00D6AA	|
	JMP CODE_00D742				;$00D6AB	|

CODE_00D6AE:
	JMP CODE_00D764

CODE_00D6B1:
	STZ.w $13ED
	AND.b #$01				;$00D6B4	|
	LDY.w $1407				;$00D6B6	|
	BEQ CODE_00D6D5				;$00D6B9	|
	CMP $76					;$00D6BB	|
	BEQ CODE_00D6C3				;$00D6BD	|
	LDY $16					;$00D6BF	|
	BPL CODE_00D68D				;$00D6C1	|
CODE_00D6C3:
	LDX $76
	LDY.w DATA_00D5EE,X			;$00D6C5	|
	STY.w $13E1				;$00D6C8	|
	STA $01					;$00D6CB	|
	ASL					;$00D6CD	|
	ASL					;$00D6CE	|
	ORA.w $13E1				;$00D6CF	|
	TAX					;$00D6D2	|
	BRA CODE_00D713				;$00D6D3	|

CODE_00D6D5:
	LDY $76
	CMP $76					;$00D6D7	|
	BEQ CODE_00D6EC				;$00D6D9	|
	LDY.w $148F				;$00D6DB	|
	BEQ CODE_00D6EA				;$00D6DE	|
	LDY.w $1499				;$00D6E0	|
	BNE CODE_00D6EC				;$00D6E3	|
	LDY.b #$08				;$00D6E5	|
	STY.w $1499				;$00D6E7	|
CODE_00D6EA:
	STA $76
CODE_00D6EC:
	STA $01
	ASL					;$00D6EE	|
	ASL					;$00D6EF	|
	ORA.w $13E1				;$00D6F0	|
	TAX					;$00D6F3	|
	LDA $7B					;$00D6F4	|
	BEQ CODE_00D713				;$00D6F6	|
	EOR.w MarioAccel2,X			;$00D6F8	|
	BPL CODE_00D713				;$00D6FB	|
	LDA.w $14A1				;$00D6FD	|
	BNE CODE_00D713				;$00D700	|
	LDA $86					;$00D702	|
	BNE CODE_00D70E				;$00D704	|
	LDA.b #$0D				;$00D706	|
	STA.w $13DD				;$00D708	|
	JSR CODE_00FE4A				;$00D70B	|
CODE_00D70E:
	TXA
	CLC					;$00D70F	|
	ADC.b #$90				;$00D710	|
	TAX					;$00D712	|
CODE_00D713:
	LDY.b #$00
	BIT $15					;$00D715	|
	BVC CODE_00D737				;$00D717	|
	INX					;$00D719	|
	INX					;$00D71A	|
	INY					;$00D71B	|
	LDA $7B					;$00D71C	|
	BPL CODE_00D723				;$00D71E	|
	EOR.b #$FF				;$00D720	|
	INC A					;$00D722	|
CODE_00D723:
	CMP.b #$23
	BMI CODE_00D737				;$00D725	|
	LDA $72					;$00D727	|
	BNE CODE_00D732				;$00D729	|
	LDA.b #$10				;$00D72B	|
	STA.w $14A0				;$00D72D	|
	BRA CODE_00D736				;$00D730	|

CODE_00D732:
	CMP.b #$0C
	BNE CODE_00D737				;$00D734	|
CODE_00D736:
	INY
CODE_00D737:
	JSR CODE_00D96A
	TYA					;$00D73A	|
	ASL					;$00D73B	|
	ORA.w $13E1				;$00D73C	|
	ORA $01					;$00D73F	|
	TAY					;$00D741	|
CODE_00D742:
	LDA $7B
	SEC					;$00D744	|
	SBC.w DATA_00D535,Y			;$00D745	|
	BEQ CODE_00D76B				;$00D748	|
	EOR.w DATA_00D535,Y			;$00D74A	|
	BPL CODE_00D76B				;$00D74D	|
	REP #$20				;$00D74F	|
	LDA.w MarioAccel,X			;$00D751	|
	LDY $86					;$00D754	|
	BEQ CODE_00D75F				;$00D756	|
	LDY $72					;$00D758	|
	BNE CODE_00D75F				;$00D75A	|
	LDA.w DATA_00D43D,X			;$00D75C	|
CODE_00D75F:
	CLC
	ADC $7A					;$00D760	|
	BRA CODE_00D7A0				;$00D762	|

CODE_00D764:
	JSR CODE_00D968
	LDA $72					;$00D767	|
	BNE Return00D7A4			;$00D769	|
CODE_00D76B:
	LDA.w $13E1
	LSR					;$00D76E	|
	TAY					;$00D76F	|
	LSR					;$00D770	|
	TAX					;$00D771	|
CODE_00D772:
	LDA $7B
	SEC					;$00D774	|
	SBC.w DATA_00D5CA,X			;$00D775	|
	BPL CODE_00D77C				;$00D778	|
	INY					;$00D77A	|
	INY					;$00D77B	|
CODE_00D77C:
	LDA.w $1493
	ORA $72					;$00D77F	|
	REP #$20				;$00D781	|
	BNE CODE_00D78C				;$00D783	|
	LDA.w DATA_00D309,Y			;$00D785	|
	BIT $85					;$00D788	|
	BMI CODE_00D78F				;$00D78A	|
CODE_00D78C:
	LDA.w DATA_00D2CD,Y
CODE_00D78F:
	CLC
	ADC $7A					;$00D790	|
	STA $7A					;$00D792	|
	SEC					;$00D794	|
	SBC.w DATA_00D5C9,X			;$00D795	|
	EOR.w DATA_00D2CD,Y			;$00D798	|
	BMI CODE_00D7A2				;$00D79B	|
	LDA.w DATA_00D5C9,X			;$00D79D	|
CODE_00D7A0:
	STA $7A
CODE_00D7A2:
	SEP #$20
Return00D7A4:
	RTS

DATA_00D7A5:
	db $06,$03,$04,$10,$F4,$01,$03,$04
	db $05,$06

DATA_00D7AF:
	db $40,$40,$20,$40,$40,$40,$40,$40
	db $40,$40

DATA_00D7B9:
	db $10,$C8,$E0,$02,$03,$03,$04,$03
	db $02,$00,$01,$00,$00,$00,$00

DATA_00D7C8:
	db $01,$10,$30,$30,$38,$38,$40

CapeSpeed:
	db $FF,$01,$01,$FF,$FF

DATA_00D7D4:
	db $01,$06,$03,$01,$00

DATA_00D7D9:
	db $00,$00,$00,$F8,$F8,$F8,$F4,$F0
	db $C8,$02,$01

aerial_physics:
	LDY.w $1407				;$00D7E4	|
	BNE CODE_00D824				;$00D7E7	|
	LDA $72					;$00D7E9	|
	BEQ CODE_00D811				;$00D7EB	|
	LDA.w $148F				;$00D7ED	|
	ORA.w $187A				;$00D7F0	|
	ORA.w $140D				;$00D7F3	|
	BNE CODE_00D811				;$00D7F6	|
	LDA.w $13ED				;$00D7F8	|
	BMI CODE_00D7FF				;$00D7FB	|
	BNE CODE_00D811				;$00D7FD	|
CODE_00D7FF:
	STZ.w $13ED
	LDX $19					;$00D802	|
	CPX.b #$02				;$00D804	|
	BNE CODE_00D811				;$00D806	|
	LDA $7D					;$00D808	|
	BMI CODE_00D811				;$00D80A	|
	LDA.w $149F				;$00D80C	|
	BNE CODE_00D814				;$00D80F	|
CODE_00D811:
	JMP CODE_00D8CD

CODE_00D814:
	STZ $73
	LDA.b #$0B				;$00D816	|
	STA $72					;$00D818	|
	STZ.w $1409				;$00D81A	|
	JSR CODE_00D94F				;$00D81D	|
	LDX.b #$02				;$00D820	|
	BRA CODE_00D85B				;$00D822	|

CODE_00D824:
	CPY.b #$02
	BCC CODE_00D82B				;$00D826	|
	JSR CODE_00D94F				;$00D828	|
CODE_00D82B:
	LDX.w $1408
	CPX.b #$04				;$00D82E	|
	BEQ CODE_00D856				;$00D830	|
	LDX.b #$03				;$00D832	|
	LDY $7D					;$00D834	|
	BMI CODE_00D856				;$00D836	|
	LDA $15					;$00D838	|
	AND.b #$03				;$00D83A	|
	TAY					;$00D83C	|
	BNE CODE_00D849				;$00D83D	|
	LDA.w $1407				;$00D83F	|
	CMP.b #$04				;$00D842	|
	BCS CODE_00D856				;$00D844	|
	DEX					;$00D846	|
	BRA CODE_00D856				;$00D847	|

CODE_00D849:
	LSR
	LDY $76					;$00D84A	|
	BEQ CODE_00D850				;$00D84C	|
	EOR.b #$01				;$00D84E	|
CODE_00D850:
	TAX
	CPX.w $1408				;$00D851	|
	BNE CODE_00D85B				;$00D854	|
CODE_00D856:
	LDA.w $14A4
	BNE CODE_00D87E				;$00D859	|
CODE_00D85B:
	BIT $15
	BVS CODE_00D861				;$00D85D	|
	LDX.b #$04				;$00D85F	|
CODE_00D861:
	LDA.w $1407
	CMP.w DATA_00D7D4,X			;$00D864	|
	BEQ CODE_00D87E				;$00D867	|
	CLC					;$00D869	|
	ADC.w CapeSpeed,X			;$00D86A	|
	STA.w $1407				;$00D86D	|
	LDA.b #$08				;$00D870	|
	LDY.w $1409				;$00D872	|
	CPY.b #$C8				;$00D875	|
	BNE CODE_00D87B				;$00D877	|
	LDA.b #$02				;$00D879	|
CODE_00D87B:
	STA.w $14A4
CODE_00D87E:
	STX.w $1408
	LDY.w $1407				;$00D881	|
	BEQ CODE_00D8CD				;$00D884	|
	LDA $7D					;$00D886	|
	BPL CODE_00D892				;$00D888	|
	CMP.b #$C8				;$00D88A	|
	BCS CODE_00D89A				;$00D88C	|
	LDA.b #$C8				;$00D88E	|
	BRA CODE_00D89A				;$00D890	|

CODE_00D892:
	CMP.w DATA_00D7C8,Y
	BCC CODE_00D89A				;$00D895	|
	LDA.w DATA_00D7C8,Y			;$00D897	|
CODE_00D89A:
	PHA
	CPY.b #$01				;$00D89B	|
	BNE CODE_00D8C6				;$00D89D	|
	LDX.w $1409				;$00D89F	|
	BEQ CODE_00D8C4				;$00D8A2	|
	LDA $7D					;$00D8A4	|
	BMI CODE_00D8AF				;$00D8A6	|
	LDA.b #$09				;$00D8A8	|
	STA.w $1DF9				;$00D8AA	|
	BRA CODE_00D8B9				;$00D8AD	|

CODE_00D8AF:
	CMP.w $1409
	BCS CODE_00D8B9				;$00D8B2	|
	STX $7D					;$00D8B4	|
	STZ.w $1409				;$00D8B6	|
CODE_00D8B9:
	LDX $76
	LDA $7B					;$00D8BB	|
	BEQ CODE_00D8C4				;$00D8BD	|
	EOR.w DATA_00D535,X			;$00D8BF	|
	BPL CODE_00D8C6				;$00D8C2	|
CODE_00D8C4:
	LDY.b #$02
CODE_00D8C6:
	PLA
	INY					;$00D8C7	|
	INY					;$00D8C8	|
	INY					;$00D8C9	|
	JMP CODE_00D948				;$00D8CA	|

CODE_00D8CD:
	LDA $72
	BEQ CODE_00D928				;$00D8CF	|
	LDX.b #$00				;$00D8D1	|
	LDA.w $187A				;$00D8D3	|
	BEQ CODE_00D8E7				;$00D8D6	|
	LDA.w $141E				;$00D8D8	|
	LSR					;$00D8DB	|
	BEQ CODE_00D8E7				;$00D8DC	|
	LDY.b #$02				;$00D8DE	|
	CPY $19					;$00D8E0	|
	BEQ CODE_00D8E5				;$00D8E2	|
	INX					;$00D8E4	|
CODE_00D8E5:
	BRA CODE_00D8FF

CODE_00D8E7:
	LDA $19
	CMP.b #$02				;$00D8E9	|
	BNE CODE_00D928				;$00D8EB	|
	LDA $72					;$00D8ED	|
	CMP.b #$0C				;$00D8EF	|
	BNE CODE_00D8FD				;$00D8F1	|
	LDY.b #$01				;$00D8F3	|
	CPY.w $149F				;$00D8F5	|
	BCC CODE_00D8FF				;$00D8F8	|
	INC.w $149F				;$00D8FA	|
CODE_00D8FD:
	LDY.b #$00
CODE_00D8FF:
	LDA.w $14A5
	BNE CODE_00D90D				;$00D902	|
	LDA $15,X				;$00D904	|
	BPL CODE_00D924				;$00D906	|
	LDA.b #$10				;$00D908	|
	STA.w $14A5				;$00D90A	|
CODE_00D90D:
	LDA $7D
	BPL CODE_00D91B				;$00D90F	|
	LDX.w DATA_00D7B9,Y			;$00D911	|
	BPL CODE_00D924				;$00D914	|
	CMP.w DATA_00D7B9,Y			;$00D916	|
	BCC CODE_00D924				;$00D919	|
CODE_00D91B:
	LDA.w DATA_00D7B9,Y
	CMP $7D					;$00D91E	|
	BEQ CODE_00D94C				;$00D920	|
	BMI CODE_00D94C				;$00D922	|
CODE_00D924:
	CPY.b #$02
	BEQ CODE_00D930				;$00D926	|
CODE_00D928:
	LDY.b #$01
	LDA $15					;$00D92A	|
	BMI CODE_00D930				;$00D92C	|
CODE_00D92E:
	LDY.b #$00
CODE_00D930:
	LDA $7D
	BMI CODE_00D948				;$00D932	|
	CMP.w DATA_00D7AF,Y			;$00D934	|
	BCC CODE_00D93C				;$00D937	|
	LDA.w DATA_00D7AF,Y			;$00D939	|
CODE_00D93C:
	LDX $72
	BEQ CODE_00D948				;$00D93E	|
	CPX.b #$0B				;$00D940	|
	BNE CODE_00D948				;$00D942	|
	LDX.b #$24				;$00D944	|
	STX $72					;$00D946	|
CODE_00D948:
	CLC
	ADC.w DATA_00D7A5,Y			;$00D949	|
CODE_00D94C:
	STA $7D
	RTS					;$00D94E	|

CODE_00D94F:
	STZ.w $140A
	LDA $7D					;$00D952	|
	BPL CODE_00D958				;$00D954	|
	LDA.b #$00				;$00D956	|
CODE_00D958:
	LSR
	LSR					;$00D959	|
	LSR					;$00D95A	|
	TAY					;$00D95B	|
	LDA.w DATA_00D7D9,Y			;$00D95C	|
	CMP.w $1409				;$00D95F	|
	BPL Return00D967			;$00D962	|
	STA.w $1409				;$00D964	|
Return00D967:
	RTS

CODE_00D968:
	LDY.b #$00
CODE_00D96A:
	LDA.w $13E4
	CLC					;$00D96D	|
	ADC.w DATA_00D5EB,Y			;$00D96E	|
	BPL CODE_00D975				;$00D971	|
	LDA.b #$00				;$00D973	|
CODE_00D975:
	CMP.b #$70
	BCC CODE_00D97C				;$00D977	|
	INY					;$00D979	|
	LDA.b #$70				;$00D97A	|
CODE_00D97C:
	STA.w $13E4
	RTS					;$00D97F	|

DATA_00D980:
	db $16,$1A,$1A,$18

DATA_00D984:
	db $E8,$F8,$D0,$D0

water_physics:
	STZ.w $13ED				;$00D988	|
	STZ $73					;$00D98B	|
	STZ.w $1407				;$00D98D	|
	STZ.w $140D				;$00D990	|
	LDY $7D					;$00D993	|
	LDA.w $148F				;$00D995	|
	BEQ CODE_00D9EB				;$00D998	|
	LDA $72					;$00D99A	|
	BNE CODE_00D9AF				;$00D99C	|
	LDA $16					;$00D99E	|
	ORA $18					;$00D9A0	|
	BPL CODE_00D9AF				;$00D9A2	|
	LDA.b #$0B				;$00D9A4	|
	STA $72					;$00D9A6	|
	STZ.w $13ED				;$00D9A8	|
	LDY.b #$F0				;$00D9AB	|
	BRA CODE_00D9B5				;$00D9AD	|

CODE_00D9AF:
	LDA $15
	AND.b #$04				;$00D9B1	|
	BEQ CODE_00D9BD				;$00D9B3	|
CODE_00D9B5:
	JSR CODE_00DAA9
	TYA					;$00D9B8	|
	CLC					;$00D9B9	|
	ADC.b #$08				;$00D9BA	|
	TAY					;$00D9BC	|
CODE_00D9BD:
	INY
	LDA.w $13FA				;$00D9BE	|
	BNE CODE_00D9CC				;$00D9C1	|
	DEY					;$00D9C3	|
	LDA $14					;$00D9C4	|
	AND.b #$03				;$00D9C6	|
	BNE CODE_00D9CC				;$00D9C8	|
	DEY					;$00D9CA	|
	DEY					;$00D9CB	|
CODE_00D9CC:
	TYA
	BMI CODE_00D9D7				;$00D9CD	|
	CMP.b #$10				;$00D9CF	|
	BCC CODE_00D9DD				;$00D9D1	|
	LDA.b #$10				;$00D9D3	|
	BRA CODE_00D9DD				;$00D9D5	|

CODE_00D9D7:
	CMP.b #$F0
	BCS CODE_00D9DD				;$00D9D9	|
	LDA.b #$F0				;$00D9DB	|
CODE_00D9DD:
	STA $7D
	LDY.b #$80				;$00D9DF	|
	LDA $15					;$00D9E1	|
	AND.b #$03				;$00D9E3	|
	BNE CODE_00DA48				;$00D9E5	|
	LDA $76					;$00D9E7	|
	BRA CODE_00DA46				;$00D9E9	|

CODE_00D9EB:
	LDA $16
	ORA $18					;$00D9ED	|
	BPL CODE_00DA0B				;$00D9EF	|
	LDA.w $13FA				;$00D9F1	|
	BNE CODE_00DA0B				;$00D9F4	|
	JSR CODE_00DAA9				;$00D9F6	|
	LDA $72					;$00D9F9	|
	BNE CODE_00DA06				;$00D9FB	|
	LDA.b #$0B				;$00D9FD	|
	STA $72					;$00D9FF	|
	STZ.w $13ED				;$00DA01	|
	LDY.b #$F0				;$00DA04	|
CODE_00DA06:
	TYA
	SEC					;$00DA07	|
	SBC.b #$20				;$00DA08	|
	TAY					;$00DA0A	|
CODE_00DA0B:
	LDA $14
	AND.b #$03				;$00DA0D	|
	BNE CODE_00DA13				;$00DA0F	|
	INY					;$00DA11	|
	INY					;$00DA12	|
CODE_00DA13:
	LDA $15
	AND.b #$0C				;$00DA15	|
	LSR					;$00DA17	|
	LSR					;$00DA18	|
	TAX					;$00DA19	|
	TYA					;$00DA1A	|
	BMI CODE_00DA25				;$00DA1B	|
	CMP.b #$40				;$00DA1D	|
	BCC CODE_00DA2D				;$00DA1F	|
	LDA.b #$40				;$00DA21	|
	BRA CODE_00DA2D				;$00DA23	|

CODE_00DA25:
	CMP.w DATA_00D984,X
	BCS CODE_00DA2D				;$00DA28	|
	LDA.w DATA_00D984,X			;$00DA2A	|
CODE_00DA2D:
	STA $7D
	LDA $72					;$00DA2F	|
	BNE CODE_00DA40				;$00DA31	|
	LDA $15					;$00DA33	|
	AND.b #$04				;$00DA35	|
	BEQ CODE_00DA40				;$00DA37	|
	STZ.w $13E8				;$00DA39	|
	INC $73					;$00DA3C	|
	BRA CODE_00DA69				;$00DA3E	|

CODE_00DA40:
	LDA $15
	AND.b #$03				;$00DA42	|
	BEQ CODE_00DA69				;$00DA44	|
CODE_00DA46:
	LDY.b #$78
CODE_00DA48:
	STY $00
	AND.b #$01				;$00DA4A	|
	STA $76					;$00DA4C	|
	PHA					;$00DA4E	|
	ASL					;$00DA4F	|
	ASL					;$00DA50	|
	TAX					;$00DA51	|
	PLA					;$00DA52	|
	ORA $00					;$00DA53	|
	LDY.w $1403				;$00DA55	|
	BEQ CODE_00DA5D				;$00DA58	|
	CLC					;$00DA5A	|
	ADC.b #$04				;$00DA5B	|
CODE_00DA5D:
	TAY
	LDA $72					;$00DA5E	|
	BEQ CODE_00DA64				;$00DA60	|
	INY					;$00DA62	|
	INY					;$00DA63	|
CODE_00DA64:
	JSR CODE_00D742
	BRA CODE_00DA7C				;$00DA67	|

CODE_00DA69:
	LDY.b #$00
	TYX					;$00DA6B	|
	LDA.w $1403				;$00DA6C	|
	BEQ CODE_00DA79				;$00DA6F	|
	LDX.b #$1E				;$00DA71	|
	LDA $72					;$00DA73	|
	BNE CODE_00DA79				;$00DA75	|
	INX					;$00DA77	|
	INX					;$00DA78	|
CODE_00DA79:
	JSR CODE_00D772
CODE_00DA7C:
	JSR powerup_physics
	JSL set_player_pose			;$00DA7F	|
	LDA.w $14A6				;$00DA83	|
	BNE Return00DA8C			;$00DA86	|
	LDA $72					;$00DA88	|
	BNE CODE_00DA8D				;$00DA8A	|
Return00DA8C:
	RTS

CODE_00DA8D:
	LDA.b #$18
	LDY.w $149C				;$00DA8F	|
	BNE CODE_00DA9F				;$00DA92	|
	LDA.w $1496				;$00DA94	|
	LSR					;$00DA97	|
	LSR					;$00DA98	|
	AND.b #$03				;$00DA99	|
	TAY					;$00DA9B	|
	LDA.w DATA_00D980,Y			;$00DA9C	|
CODE_00DA9F:
	LDY.w $148F
	BEQ CODE_00DAA5				;$00DAA2	|
	INC A					;$00DAA4	|
CODE_00DAA5:
	STA.w $13E0
	RTS					;$00DAA8	|

CODE_00DAA9:
	LDA.b #$0E
	STA.w $1DF9				;$00DAAB	|
	LDA.w $1496				;$00DAAE	|
	ORA.b #$10				;$00DAB1	|
	STA.w $1496				;$00DAB3	|
	RTS					;$00DAB6	|

DATA_00DAB7:
	db $10,$08,$F0,$F8

DATA_00DABB:
	db $B0,$F0

DATA_00DABD:
	db $00,$01,$00,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01
DATA_00DACD:
	db $22,$15,$22,$15,$21,$1F,$20,$20
	db $20,$20,$1F,$21,$1F,$21

ClimbingImgs:
	db $15,$22

ClimbPunchingImgs:
	db $1E,$23

DATA_00DADF:
	db $10,$0F,$0E,$0D,$0C,$0B,$0A,$09
	db $08,$07,$06,$05,$05,$05,$05,$05
	db $05,$05

DATA_00DAF1:
	db $20,$01,$40,$01,$2A,$01,$2A,$01
	db $30,$01,$33,$01,$32,$01,$34,$01
	db $36,$01,$38,$01,$3A,$01,$3B,$01
	db $45,$01,$45,$01,$45,$01,$45,$01
	db $45,$01,$45,$01,$08,$F8

CODE_00DB17:
	STZ $72
	STZ $7D					;$00DB19	|
	STZ.w $13DF				;$00DB1B	|
	STZ.w $140D				;$00DB1E	|
	LDY.w $149D				;$00DB21	|
	BEQ CODE_00DB7D				;$00DB24	|
	LDA.w $1878				;$00DB26	|
	BPL CODE_00DB2E				;$00DB29	|
	EOR.b #$FF				;$00DB2B	|
	INC A					;$00DB2D	|
CODE_00DB2E:
	TAX
	CPY.b #$1E				;$00DB2F	|
	BCC CODE_00DB45				;$00DB31	|
	LDA.w DATA_00DADF,X			;$00DB33	|
	BIT.w $1878				;$00DB36	|
	BPL CODE_00DB3E				;$00DB39	|
	EOR.b #$FF				;$00DB3B	|
	INC A					;$00DB3D	|
CODE_00DB3E:
	STA $7B
	STZ $7A					;$00DB40	|
	STZ.w $13DA				;$00DB42	|
CODE_00DB45:
	TXA
	ASL					;$00DB46	|
	TAX					;$00DB47	|
	LDA.w $1878				;$00DB48	|
	CPY.b #$08				;$00DB4B	|
	BCS CODE_00DB51				;$00DB4D	|
	EOR.b #$80				;$00DB4F	|
CODE_00DB51:
	ASL
	REP #$20				;$00DB52	|
	LDA.w DATA_00DAF1,X			;$00DB54	|
	BCS CODE_00DB5D				;$00DB57	|
	EOR.w #$FFFF				;$00DB59	|
	INC A					;$00DB5C	|
CODE_00DB5D:
	CLC
	ADC $7A					;$00DB5E	|
	STA $7A					;$00DB60	|
	SEP #$20				;$00DB62	|
	TYA					;$00DB64	|
	LSR					;$00DB65	|
	AND.b #$0E				;$00DB66	|
	ORA.w $13F0				;$00DB68	|
	TAY					;$00DB6B	|
	LDA.w DATA_00DABD,Y			;$00DB6C	|
	BIT.w $1878				;$00DB6F	|
	BMI CODE_00DB76				;$00DB72	|
	EOR.b #$01				;$00DB74	|
CODE_00DB76:
	STA $76
	LDA.w DATA_00DACD,Y			;$00DB78	|
	BRA CODE_00DB92				;$00DB7B	|

CODE_00DB7D:
	STZ $7B
	STZ $7A					;$00DB7F	|
	LDX.w $13F9				;$00DB81	|
	LDA.w $149E				;$00DB84	|
	BEQ CODE_00DB96				;$00DB87	|
	TXA					;$00DB89	|
	INC A					;$00DB8A	|
	INC A					;$00DB8B	|
	JSR CODE_00D044				;$00DB8C	|
	LDA.w ClimbPunchingImgs,X		;$00DB8F	|
CODE_00DB92:
	STA.w $13E0
	RTS					;$00DB95	|

CODE_00DB96:
	LDY $75
	BIT $16					;$00DB98	|
	BPL CODE_00DBAC				;$00DB9A	|
	LDA.b #$0B				;$00DB9C	|
	STA $72					;$00DB9E	|
	LDA.w DATA_00DABB,Y			;$00DBA0	|
	STA $7D					;$00DBA3	|
	LDA.b #$01				;$00DBA5	|
	STA.w $1DFA				;$00DBA7	|
	BRA CODE_00DC00				;$00DBAA	|

CODE_00DBAC:
	BVC CODE_00DBCA
	LDA $74					;$00DBAE	|
	BPL CODE_00DBCA				;$00DBB0	|
	LDA.b #$01				;$00DBB2	|
	STA.w $1DF9				;$00DBB4	|
	STX.w $13F0				;$00DBB7	|
	LDA $94					;$00DBBA	|
	AND.b #$08				;$00DBBC	|
	LSR					;$00DBBE	|
	LSR					;$00DBBF	|
	LSR					;$00DBC0	|
	EOR.b #$01				;$00DBC1	|
	STA $76					;$00DBC3	|
	LDA.b #$08				;$00DBC5	|
	STA.w $149E				;$00DBC7	|
CODE_00DBCA:
	LDA.w ClimbingImgs,X
	STA.w $13E0				;$00DBCD	|
	LDA $15					;$00DBD0	|
	AND.b #$03				;$00DBD2	|
	BEQ CODE_00DBF2				;$00DBD4	|
	LSR					;$00DBD6	|
	TAX					;$00DBD7	|
	LDA $8B					;$00DBD8	|
	AND.b #$18				;$00DBDA	|
	CMP.b #$18				;$00DBDC	|
	BEQ CODE_00DBE8				;$00DBDE	|
	LDA $74					;$00DBE0	|
	BPL CODE_00DC00				;$00DBE2	|
	CPX $8C					;$00DBE4	|
	BEQ CODE_00DBF2				;$00DBE6	|
CODE_00DBE8:
	TXA
	ASL					;$00DBE9	|
	ORA $75					;$00DBEA	|
	TAX					;$00DBEC	|
	LDA.w DATA_00DAB7,X			;$00DBED	|
	STA $7B					;$00DBF0	|
CODE_00DBF2:
	LDA $15
	AND.b #$0C				;$00DBF4	|
	BEQ CODE_00DC16				;$00DBF6	|
	AND.b #$08				;$00DBF8	|
	BNE CODE_00DC03				;$00DBFA	|
	LSR $8B					;$00DBFC	|
	BCS CODE_00DC0B				;$00DBFE	|
CODE_00DC00:
	STZ $74
	RTS					;$00DC02	|

CODE_00DC03:
	INY
	INY					;$00DC04	|
	LDA $8B					;$00DC05	|
	AND.b #$02				;$00DC07	|
	BEQ CODE_00DC16				;$00DC09	|
CODE_00DC0B:
	LDA $74
	BMI CODE_00DC11				;$00DC0D	|
	STZ $7B					;$00DC0F	|
CODE_00DC11:
	LDA.w DATA_00DAB7,Y
	STA $7D					;$00DC14	|
CODE_00DC16:
	ORA $7B
	BEQ Return00DC2C			;$00DC18	|
	LDA.w $1496				;$00DC1A	|
	ORA.b #$08				;$00DC1D	|
	STA.w $1496				;$00DC1F	|
	AND.b #$07				;$00DC22	|
	BNE Return00DC2C			;$00DC24	|
	LDA $76					;$00DC26	|
	EOR.b #$01				;$00DC28	|
	STA $76					;$00DC2A	|
Return00DC2C:
	RTS

apply_player_speeds:				;		\
	LDA $7D					;$00DC2D	 |\ Backup the Y speed.
	STA $8A					;$00DC2F	 |/
	LDA.w $13E3				;$00DC31	 |\ If the player is wall running,
	BEQ .not_wall_running			;$00DC34	 |/
	LSR					;$00DC36	 |
	LDA $7B					;$00DC37	 | Load the player's X speed,
	BCC .no_flip_speed			;$00DC39	 |
	EOR.b #$FF				;$00DC3B	 |\ flip it depending on the wall running direction,
	INC A					;$00DC3D	 |/
.no_flip_speed					;		 |
	STA $7D					;$00DC3E	 | and set the player's Y speed.
.not_wall_running				;		 |
	LDX.b #$00				;$00DC40	 |\ Apply the player's X speed.
	JSR .apply_speed			;$00DC42	 |/
	LDX.b #$02				;$00DC45	 |\ Apply the player's Y speed.
	JSR .apply_speed			;$00DC47	 |/
	LDA $8A					;$00DC4A	 |\ Restore the Y speed.
	STA $7D					;$00DC4C	 |/
	RTS					;$00DC4E	/

.apply_speed
	LDA $7B,X				;$00DC4F	\ Load the player's speed,
	ASL					;$00DC51	 |\ get the lower nybble and multiply by 16,
	ASL					;$00DC52	 | |
	ASL					;$00DC53	 | |
	ASL					;$00DC54	 |/
	CLC					;$00DC55	 |\ and add to the player's fractional position.
	ADC.w $13DA,X				;$00DC56	 | | If the fractional overflows, then the carry bit is set.
	STA.w $13DA,X				;$00DC59	 |/
	REP #$20				;$00DC5C	 |
	PHP					;$00DC5E	 | Preserve the carry bit.
	LDA $7B,X				;$00DC5F	 | Load the player's speed,
	LSR					;$00DC61	 |\ divide by 16,
	LSR					;$00DC62	 | |
	LSR					;$00DC63	 | |
	LSR					;$00DC64	 |/
	AND.w #$000F				;$00DC65	 | remove garbage bits,
	CMP.w #$0008				;$00DC68	 |\ flip the speed if it's negative,
	BCC .nonnegative			;$00DC6B	 | |
	ORA.w #$FFF0				;$00DC6D	 |/
.nonnegative					;		 |
	PLP					;$00DC70	 | restore the carry bit,
	ADC $94,X				;$00DC71	 |\ and add the fractional bit and speed
	STA $94,X				;$00DC73	 |/ to the player's position.
	SEP #$20				;$00DC75	 |
	RTS					;$00DC77	/

NumWalkingFrames:
	db $01,$02,$02,$02

DATA_00DC7C:
	db $0A,$08,$06,$04,$03,$02,$01,$01
	db $0A,$08,$06,$04,$03,$02,$01,$01
	db $0A,$08,$06,$04,$03,$02,$01,$01
	db $08,$06,$04,$03,$02,$01,$01,$01
	db $08,$06,$04,$03,$02,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $04,$03,$02,$01,$01,$01,$01,$01
	db $04,$03,$02,$01,$01,$01,$01,$01
	db $02,$02,$02,$02,$02,$02,$02,$02
DATA_00DCEC:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $02,$04,$04,$04,$0E,$08,$00,$00
	db $00,$00,$00,$00,$00,$00,$08,$08
	db $08,$08,$08,$08,$00,$00,$00,$00
	db $0C,$10,$12,$14,$16,$18,$1A,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$06,$00,$00
	db $00,$00,$00,$0A,$00,$00

DATA_00DD32:
	db $00,$08,$10,$14,$18,$1E,$24,$24
	db $28,$30,$38,$3E,$44,$4A,$50,$54
	db $58,$58,$5C,$60,$64,$68,$6C,$70
	db $74,$78,$7C,$80

DATA_00DD4E:
	db $00,$00,$00,$00,$10,$00,$10,$00
	db $00,$00,$00,$00,$F8,$FF,$F8,$FF
	db $0E,$00,$06,$00,$F2,$FF,$FA,$FF
	db $17,$00,$07,$00,$0F,$00,$EA,$FF
	db $FA,$FF,$FA,$FF,$00,$00,$00,$00
	db $00,$00,$00,$00,$10,$00,$10,$00
	db $00,$00,$00,$00,$F8,$FF,$F8,$FF
	db $00,$00,$F8,$FF,$08,$00,$00,$00
	db $08,$00,$F8,$FF,$00,$00,$00,$00
	db $F8,$FF,$00,$00,$00,$00,$10,$00
	db $02,$00,$00,$00,$FE,$FF,$00,$00
	db $00,$00,$00,$00,$FC,$FF,$05,$00
	db $04,$00,$FB,$FF,$FB,$FF,$06,$00
	db $05,$00,$FA,$FF,$F9,$FF,$09,$00
	db $07,$00,$F7,$FF,$FD,$FF,$FD,$FF
	db $03,$00,$03,$00,$FF,$FF,$07,$00
	db $01,$00,$F9,$FF,$0A,$00,$F6,$FF
	db $08,$00,$F8,$FF,$08,$00,$F8,$FF
	db $00,$00,$04,$00,$FC,$FF,$FE,$FF
	db $02,$00,$0B,$00,$F5,$FF,$14,$00
	db $EC,$FF,$0E,$00,$F3,$FF,$08,$00
	db $F8,$FF,$0C,$00,$14,$00,$FD,$FF
	db $F4,$FF,$F4,$FF,$0B,$00,$0B,$00
	db $03,$00,$13,$00,$F5,$FF,$05,$00
	db $F5,$FF,$09,$00,$01,$00,$01,$00
	db $F7,$FF,$07,$00,$07,$00,$05,$00
	db $0D,$00,$0D,$00,$FB,$FF,$FB,$FF
	db $FB,$FF,$FF,$FF,$0F,$00,$01,$00
	db $F9,$FF,$00,$00

DATA_00DE32:
	db $01,$00,$11,$00,$11,$00,$19,$00
	db $01,$00,$11,$00,$11,$00,$19,$00
	db $0C,$00,$14,$00,$0C,$00,$14,$00
	db $18,$00,$18,$00,$28,$00,$18,$00
	db $18,$00,$28,$00,$06,$00,$16,$00
	db $01,$00,$11,$00,$09,$00,$11,$00
	db $01,$00,$11,$00,$09,$00,$11,$00
	db $01,$00,$11,$00,$11,$00,$01,$00
	db $11,$00,$11,$00,$01,$00,$11,$00
	db $11,$00,$01,$00,$11,$00,$11,$00
	db $01,$00,$11,$00,$01,$00,$11,$00
	db $11,$00,$05,$00,$04,$00,$14,$00
	db $04,$00,$14,$00,$0C,$00,$14,$00
	db $0C,$00,$14,$00,$10,$00,$10,$00
	db $10,$00,$10,$00,$10,$00,$00,$00
	db $10,$00,$00,$00,$10,$00,$00,$00
	db $10,$00,$00,$00,$0B,$00,$0B,$00
	db $11,$00,$11,$00,$FF,$FF,$FF,$FF
	db $10,$00,$10,$00,$10,$00,$10,$00
	db $10,$00,$10,$00,$10,$00,$15,$00
	db $15,$00,$25,$00,$25,$00,$04,$00
	db $04,$00,$04,$00,$14,$00,$14,$00
	db $04,$00,$14,$00,$14,$00,$04,$00
	db $04,$00,$14,$00,$04,$00,$04,$00
	db $14,$00,$00,$00,$08,$00,$00,$00
	db $00,$00,$08,$00,$00,$00,$00,$00
	db $10,$00,$18,$00,$00,$00,$10,$00
	db $18,$00,$00,$00,$10,$00,$00,$00
	db $10,$00,$F8,$FF

TilesetIndex:
	db $00,$46,$83,$46

TileExpansion:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$28,$00,$00,$00,$00
	db $00,$00,$04,$04,$04,$00,$00,$00
	db $00,$00,$08,$00,$00,$00,$00,$0C
	db $0C,$0C,$00,$00,$10,$10,$14,$14
	db $18,$18,$00,$00,$1C,$00,$00,$00
	db $00,$20,$00,$00,$00,$00,$24,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$04
	db $04,$04,$00,$00,$00,$00,$00,$08
	db $00,$00,$00,$00,$0C,$0C,$0C,$00
	db $00,$10,$10,$14,$14,$18,$18,$00
	db $00,$1C,$00,$00,$00,$00,$20,$00
	db $00,$00,$00,$24,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
Mario8x8Tiles:
	db $00,$02,$80,$80,$00,$02,$0C,$80
	db $00,$02,$1A,$1B,$00,$02,$0D,$80
	db $00,$02,$22,$23,$00,$02,$32,$33
	db $00,$02,$0A,$0B,$00,$02,$30,$31
	db $00,$02,$20,$21,$00,$02,$7E,$80
	db $00,$02,$02,$80,$04,$7F,$4A,$5B
	db $4B,$5A

DATA_00E00C:
	db $50,$50,$50,$09,$50,$50,$50,$50
	db $50,$50,$09,$2B,$50,$2D,$50,$D5
	db $2E,$C4,$C4,$C4,$D6,$B6,$50,$50
	db $50,$50,$50,$50,$50,$C5,$D7,$2A
	db $E0,$50,$D5,$29,$2C,$B6,$D6,$28
	db $E0,$E0,$C5,$C5,$C5,$C5,$C5,$C5
	db $5C,$5C,$50,$5A,$B6,$50,$28,$28
	db $C5,$D7,$28,$70,$C5,$70,$1C,$93
	db $C5,$C5,$0B,$85,$90,$84,$70,$70
	db $70,$A0,$70,$70,$70,$70,$70,$70
	db $A0,$74,$70,$80,$70,$84,$17,$A4
	db $A4,$A4,$B3,$B0,$70,$70,$70,$70
	db $70,$70,$70,$E2,$72,$0F,$61,$70
	db $63,$82,$C7,$90,$B3,$D4,$A5,$C0
	db $08,$54,$0C,$0E,$1B,$51,$49,$4A
	db $48,$4B,$4C,$5D,$5E,$5F,$E3,$90
	db $5F,$5F,$C5,$70,$70,$70,$A0,$70
	db $70,$70,$70,$70,$70,$A0,$74,$70
	db $80,$70,$84,$17,$A4,$A4,$A4,$B3
	db $B0,$70,$70,$70,$70,$70,$70,$70
	db $E2,$72,$0F,$61,$70,$63,$82,$C7
	db $90,$B3,$D4,$A5,$C0,$08,$64,$0C
	db $0E,$1B,$51,$49,$4A,$48,$4B,$4C
	db $5D,$5E,$5F,$E3,$90,$5F,$5F,$C5
DATA_00E0CC:
	db $71,$60,$60,$19,$94,$96,$96,$A2
	db $97,$97,$18,$3B,$B4,$3D,$A7,$E5
	db $2F,$D3,$C3,$C3,$F6,$D0,$B1,$81
	db $B2,$86,$B4,$87,$A6,$D1,$F7,$3A
	db $F0,$F4,$F5,$39,$3C,$C6,$E6,$38
	db $F1,$F0,$C5,$C5,$C5,$C5,$C5,$C5
	db $6C,$4D,$71,$6A,$6B,$60,$38,$F1
	db $5B,$69,$F1,$F1,$4E,$E1,$1D,$A3
	db $C5,$C5,$1A,$95,$10,$07,$02,$01
	db $00,$02,$14,$13,$12,$30,$27,$26
	db $30,$03,$15,$04,$31,$07,$E7,$25
	db $24,$23,$62,$36,$33,$91,$34,$92
	db $35,$A1,$32,$F2,$73,$1F,$C0,$C1
	db $C2,$83,$D2,$10,$B7,$E4,$B5,$61
	db $0A,$55,$0D,$75,$77,$1E,$59,$59
	db $58,$02,$02,$6D,$6E,$6F,$F3,$68
	db $6F,$6F,$06,$02,$01,$00,$02,$14
	db $13,$12,$30,$27,$26,$30,$03,$15
	db $04,$31,$07,$E7,$25,$24,$23,$62
	db $36,$33,$91,$34,$92,$35,$A1,$32
	db $F2,$73,$1F,$C0,$C1,$C2,$83,$D2
	db $10,$B7,$E4,$B5,$61,$0A,$55,$0D
	db $75,$77,$1E,$59,$59,$58,$02,$02
	db $6D,$6E,$6F,$F3,$68,$6F,$6F,$06
mario_properties:
	db $00,$40

DATA_00E18E:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$0D,$00,$10
	db $13,$22,$25,$28,$00,$16,$00,$00
	db $00,$00,$00,$00,$00,$08,$19,$1C
	db $04,$1F,$10,$10,$00,$16,$10,$06
	db $04,$08,$2B,$30,$35,$3A,$3F,$43
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $16,$16,$00,$00,$08,$00,$00,$00
	db $00,$00,$00,$10,$04,$00

DATA_00E1D4:
	db $06

DATA_00E1D5:
	db $00

DATA_00E1D6:
	db $06

DATA_00E1D7:
	db $00

DATA_00E1D8:
	db $86,$02,$06,$03,$06,$01,$06,$CE
	db $06,$06,$40,$00,$06,$2C,$06,$06
	db $44,$0E,$86,$2C,$06,$86,$2C,$0A
	db $86,$84,$08,$06,$0A,$02,$06,$AC
	db $10,$06,$CC,$10,$06,$AE,$10,$00
	db $8C,$14,$80,$2E,$00,$CA,$16,$91
	db $2F,$00,$8E,$18,$81,$30,$00,$EB
	db $1A,$90,$31,$04,$ED,$1C,$82,$06
	db $92,$1E

DATA_00E21A:
	db $84,$86,$88,$8A,$8C,$8E,$90,$90
	db $92,$94,$96,$98,$9A,$9C,$9E,$A0
	db $A2,$A4,$A6,$A8,$AA,$B0,$B6,$BC
	db $C2,$C8,$CE,$D4,$DA,$DE,$E2,$E2
DATA_00E23A:
	db $0A,$0A,$84,$0A,$88,$88,$88,$88
	db $8A,$8A,$8A,$8A,$44,$44,$44,$44
	db $42,$42,$42,$42,$40,$40,$40,$40
	db $22,$22,$22,$22,$A4,$A4,$A4,$A4
	db $A6,$A6,$A6,$A6,$86,$86,$86,$86
	db $6E,$6E,$6E,$6E

DATA_00E266:
	db $02,$02,$02,$0C,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$04,$12,$04,$04
	db $04,$12,$04,$04,$04,$12,$04,$04
	db $04,$12,$04,$04

DATA_00E292:
	db $01,$01,$01,$01,$02,$02,$02,$02
	db $04,$04,$04,$04,$08,$08,$08,$08
DATA_00E2A2:
	db $C8,$B2,$DC,$B2,$C8,$B2,$DC,$B2
	db $C8,$B2,$DC,$B2,$F0,$B2,$04,$B3
DATA_00E2B2:
	db $10,$D4,$10,$E8

DATA_00E2B6:
	db $08,$CC,$08

DATA_00E2B9:
	db $E0,$10,$10,$30

CODE_00E2BD:
	PHB
	PHK					;$00E2BE	|
	PLB					;$00E2BF	|
	LDA $78					;$00E2C0	|
	CMP.b #$FF				;$00E2C2	|
	BEQ CODE_00E2CA				;$00E2C4	|
	JSL CODE_01EA70				;$00E2C6	|
CODE_00E2CA:
	LDY.w $149B
	BNE CODE_00E308				;$00E2CD	|
	LDY.w $1490				;$00E2CF	|
	BEQ CODE_00E314				;$00E2D2	|
	LDA $78					;$00E2D4	|
	CMP.b #$FF				;$00E2D6	|
	BEQ CODE_00E2E3				;$00E2D8	|
	LDA $14					;$00E2DA	|
	AND.b #$03				;$00E2DC	|
	BNE CODE_00E2E3				;$00E2DE	|
	DEC.w $1490				;$00E2E0	|
CODE_00E2E3:
	LDA $13
	CPY.b #$1E				;$00E2E5	|
	BCC CODE_00E30A				;$00E2E7	|
	BNE CODE_00E30C				;$00E2E9	|
	LDA.w $0DDA				;$00E2EB	|
	CMP.b #$FF				;$00E2EE	|
	BEQ CODE_00E308				;$00E2F0	|
	AND.b #$7F				;$00E2F2	|
	STA.w $0DDA				;$00E2F4	|
	TAX					;$00E2F7	|
	LDA.w $14AD				;$00E2F8	|
	ORA.w $14AE				;$00E2FB	|
	ORA.w $190C				;$00E2FE	|
	BEQ CODE_00E305				;$00E301	|
	LDX.b #$0E				;$00E303	|
CODE_00E305:
	STX.w $1DFB
CODE_00E308:
	LDA $13
CODE_00E30A:
	LSR
	LSR					;$00E30B	|
CODE_00E30C:
	AND.b #$03
	INC A					;$00E30E	|
	INC A					;$00E30F	|
	INC A					;$00E310	|
	INC A					;$00E311	|
	BRA CODE_00E31A				;$00E312	|

CODE_00E314:
	LDA $19
	ASL					;$00E316	|
	ORA.w $0DB3				;$00E317	|
CODE_00E31A:
	ASL
	TAY					;$00E31B	|
	REP #$20				;$00E31C	|
	LDA.w DATA_00E2A2,Y			;$00E31E	|
	STA.w $0D82				;$00E321	|
	SEP #$20				;$00E324	|
	LDX.w $13E0				;$00E326	|
	LDA.b #$05				;$00E329	|
	CMP.w $13E3				;$00E32B	|
	BCS CODE_00E33E				;$00E32E	|
	LDA.w $13E3				;$00E330	|
	LDY $19					;$00E333	|
	BEQ CODE_00E33B				;$00E335	|
	CPX.b #$13				;$00E337	|
	BNE CODE_00E33D				;$00E339	|
CODE_00E33B:
	EOR.b #$01
CODE_00E33D:
	LSR
CODE_00E33E:
	REP #$20
	LDA $94					;$00E340	|
	SBC $1A					;$00E342	|
	STA $7E					;$00E344	|
	LDA.w $188B				;$00E346	|
	AND.w #$00FF				;$00E349	|
	CLC					;$00E34C	|
	ADC $96					;$00E34D	|
	LDY $19					;$00E34F	|
	CPY.b #$01				;$00E351	|
	LDY.b #$01				;$00E353	|
	BCS CODE_00E359				;$00E355	|
	DEC A					;$00E357	|
	DEY					;$00E358	|
CODE_00E359:
	CPX.b #$0A
	BCS CODE_00E360				;$00E35B	|
	CPY.w $13DB				;$00E35D	|
CODE_00E360:
	SBC $1C
	CPX.b #$1C				;$00E362	|
	BNE CODE_00E369				;$00E364	|
	ADC.w #$0001				;$00E366	|
CODE_00E369:
	STA $80
	SEP #$20				;$00E36B	|
	LDA.w $1497				;$00E36D	|
	BEQ CODE_00E385				;$00E370	|
	LSR					;$00E372	|
	LSR					;$00E373	|
	LSR					;$00E374	|
	TAY					;$00E375	|
	LDA.w DATA_00E292,Y			;$00E376	|
	AND.w $1497				;$00E379	|
	ORA $9D					;$00E37C	|
	ORA.w $13FB				;$00E37E	|
	BNE CODE_00E385				;$00E381	|
	PLB					;$00E383	|
	RTL					;$00E384	|

CODE_00E385:
	LDA.b #$C8
	CPX.b #$43				;$00E387	|
	BNE CODE_00E38D				;$00E389	|
	LDA.b #$E8				;$00E38B	|
CODE_00E38D:
	STA $04
	CPX.b #$29				;$00E38F	|
	BNE CODE_00E399				;$00E391	|
	LDA $19					;$00E393	|
	BNE CODE_00E399				;$00E395	|
	LDX.b #$20				;$00E397	|
CODE_00E399:
	LDA.w DATA_00DCEC,X
	ORA $76					;$00E39C	|
	TAY					;$00E39E	|
	LDA.w DATA_00DD32,Y			;$00E39F	|
	STA $05					;$00E3A2	|
	LDY $19					;$00E3A4	|
	LDA.w $13E0				;$00E3A6	|
	CMP.b #$3D				;$00E3A9	|
	BCS CODE_00E3B0				;$00E3AB	|
	ADC.w TilesetIndex,Y			;$00E3AD	|
CODE_00E3B0:
	TAY
	LDA.w TileExpansion,Y			;$00E3B1	|
	STA $06					;$00E3B4	|
	LDA.w DATA_00E00C,Y			;$00E3B6	|
	STA $0A					;$00E3B9	|
	LDA.w DATA_00E0CC,Y			;$00E3BB	|
	STA $0B					;$00E3BE	|
	LDA $64					;$00E3C0	|
	LDX.w $13F9				;$00E3C2	|
	BEQ CODE_00E3CA				;$00E3C5	|
	LDA.w DATA_00E2B9,X			;$00E3C7	|
CODE_00E3CA:
	LDY.w DATA_00E2B2,X
	LDX $76					;$00E3CD	|
	ORA.w mario_properties,X		;$00E3CF	|
	STA.w $0303,Y				;$00E3D2	|
	STA.w $0307,Y				;$00E3D5	|
	STA.w $030F,Y				;$00E3D8	|
	STA.w $0313,Y				;$00E3DB	|
	STA.w $02FB,Y				;$00E3DE	|
	STA.w $02FF,Y				;$00E3E1	|
	LDX $04					;$00E3E4	|
	CPX.b #$E8				;$00E3E6	|
	BNE CODE_00E3EC				;$00E3E8	|
	EOR.b #$40				;$00E3EA	|
CODE_00E3EC:
	STA.w $030B,Y
	JSR CODE_00E45D				;$00E3EF	|
	JSR CODE_00E45D				;$00E3F2	|
	JSR CODE_00E45D				;$00E3F5	|
	JSR CODE_00E45D				;$00E3F8	|
	LDA $19					;$00E3FB	|
	CMP.b #$02				;$00E3FD	|
	BNE CODE_00E458				;$00E3FF	|
	PHY					;$00E401	|
	LDA.b #$2C				;$00E402	|
	STA $06					;$00E404	|
	LDX.w $13E0				;$00E406	|
	LDA.w DATA_00E18E,X			;$00E409	|
	TAX					;$00E40C	|
	LDA.w DATA_00E1D7,X			;$00E40D	|
	STA $0D					;$00E410	|
	LDA.w DATA_00E1D8,X			;$00E412	|
	STA $0E					;$00E415	|
	LDA.w DATA_00E1D5,X			;$00E417	|
	STA $0C					;$00E41A	|
	CMP.b #$04				;$00E41C	|
	BCS CODE_00E432				;$00E41E	|
	LDA.w $13DF				;$00E420	|
	ASL					;$00E423	|
	ASL					;$00E424	|
	ORA $0C					;$00E425	|
	TAY					;$00E427	|
	LDA.w DATA_00E23A,Y			;$00E428	|
	STA $0C					;$00E42B	|
	LDA.w DATA_00E266,Y			;$00E42D	|
	BRA CODE_00E435				;$00E430	|

CODE_00E432:
	LDA.w DATA_00E1D6,X
CODE_00E435:
	ORA $76
	TAY					;$00E437	|
	LDA.w DATA_00E21A,Y			;$00E438	|
	STA $05					;$00E43B	|
	PLY					;$00E43D	|
	LDA.w DATA_00E1D4,X			;$00E43E	|
	TSB $78					;$00E441	|
	BMI CODE_00E448				;$00E443	|
	JSR CODE_00E45D				;$00E445	|
CODE_00E448:
	LDX.w $13F9
	LDY.w DATA_00E2B6,X			;$00E44B	|
	JSR CODE_00E45D				;$00E44E	|
	LDA $0E					;$00E451	|
	STA $06					;$00E453	|
	JSR CODE_00E45D				;$00E455	|
CODE_00E458:
	JSR CODE_00F636
	PLB					;$00E45B	|
	RTL					;$00E45C	|

CODE_00E45D:
	LSR $78
	BCS CODE_00E49F				;$00E45F	|
	LDX $06					;$00E461	|
	LDA.w Mario8x8Tiles,X			;$00E463	|
	BMI CODE_00E49F				;$00E466	|
	STA.w $0302,Y				;$00E468	|
	LDX $05					;$00E46B	|
	REP #$20				;$00E46D	|
	LDA $80					;$00E46F	|
	CLC					;$00E471	|
	ADC.w DATA_00DE32,X			;$00E472	|
	PHA					;$00E475	|
	CLC					;$00E476	|
	ADC.w #$0010				;$00E477	|
	CMP.w #$0100				;$00E47A	|
	PLA					;$00E47D	|
	SEP #$20				;$00E47E	|
	BCS CODE_00E49F				;$00E480	|
	STA.w $0301,Y				;$00E482	|
	REP #$20				;$00E485	|
	LDA $7E					;$00E487	|
	CLC					;$00E489	|
	ADC.w DATA_00DD4E,X			;$00E48A	|
	PHA					;$00E48D	|
	CLC					;$00E48E	|
	ADC.w #$0080				;$00E48F	|
	CMP.w #$0200				;$00E492	|
	PLA					;$00E495	|
	SEP #$20				;$00E496	|
	BCS CODE_00E49F				;$00E498	|
	STA.w $0300,Y				;$00E49A	|
	XBA					;$00E49D	|
	LSR					;$00E49E	|
CODE_00E49F:
	PHP
	TYA					;$00E4A0	|
	LSR					;$00E4A1	|
	LSR					;$00E4A2	|
	TAX					;$00E4A3	|
	ASL $04					;$00E4A4	|
	ROL					;$00E4A6	|
	PLP					;$00E4A7	|
	ROL					;$00E4A8	|
	AND.b #$03				;$00E4A9	|
	STA.w $0460,X				;$00E4AB	|
	INY					;$00E4AE	|
	INY					;$00E4AF	|
	INY					;$00E4B0	|
	INY					;$00E4B1	|
	INC $05					;$00E4B2	|
	INC $05					;$00E4B4	|
	INC $06					;$00E4B6	|
	RTS					;$00E4B8	|

DATA_00E4B9:
	db $08,$08,$08,$08,$10,$10,$10,$10
	db $18,$18,$20,$20,$28,$30,$08,$10
	db $00,$00,$28,$00,$00,$00,$00,$00
	db $38,$50,$48,$40,$58,$58,$60,$60
	db $00

DATA_00E4DA:
	db $10,$10,$10,$10,$10,$10,$10,$10
	db $20,$20,$20,$20,$30,$30,$40,$30
	db $30,$30,$30,$00,$00,$00,$00,$00
	db $30,$30,$30,$30,$40,$40,$40,$40
	db $00

DATA_00E4FB:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $EC,$EC,$EE,$EE,$DA,$DA,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $DA,$DA,$DA,$DA,$00,$00,$00,$00
	db $00

DATA_00E51C:
	db $08,$08,$08,$08,$08,$08,$08,$08
	db $09,$09,$09,$09,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$00,$00,$00,$00,$00
	db $0B,$0B,$0B,$0B,$14,$14,$14,$14
	db $06

DATA_00E53D:
	db $FF,$FF,$FF,$FF,$01,$01,$01,$01
	db $FE,$FE,$02,$02,$FD,$03,$FD,$03
	db $FD,$03,$FD,$00,$00,$00,$00,$00
	db $08,$08,$F8,$F8,$FC,$FC,$04,$04
	db $00,$00,$00,$00,$00,$00,$01,$01
	db $01,$01,$01,$02,$02,$02,$02,$02
	db $03,$03,$03,$03,$03,$04,$04,$04
	db $04,$04,$05,$05,$05,$05,$05,$06
	db $06,$06,$06,$06,$07,$07,$07,$07
	db $07,$08,$08,$08,$08,$08,$09,$09
	db $09,$09,$09,$0A,$0A,$0A,$0A,$0A
	db $0B,$0B,$0B,$0B,$0B,$0C,$0C,$0C
	db $0C,$0C,$0D,$0D,$0D,$0D,$0D,$0E
	db $0F,$10,$11,$03,$03,$04,$04,$09
	db $09,$0A,$0A,$0C,$0C,$0D,$0D,$12
	db $13,$14,$15,$16,$17,$1C,$1D,$1E
	db $1F,$18,$19,$1A,$1B,$08,$09,$0A
	db $0B,$0C,$0D,$00,$00,$00,$00,$00
	db $01,$01,$01,$01,$01,$02,$02,$02
	db $02,$02,$03,$03,$03,$03,$03,$04
	db $04,$04,$04,$04,$05,$05,$05,$05
	db $05,$06,$06,$06,$06,$06,$07,$07
	db $07,$07,$07,$08,$08,$08,$08,$08
	db $09,$09,$09,$09,$09,$0A,$0A,$0A
	db $0A,$0A,$0B,$0B,$0B,$0B,$0B,$0C
	db $0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D
	db $0D,$0E,$0F,$10,$11,$03,$03,$04
	db $04,$09,$09,$0A,$0A,$0C,$0C,$0D
	db $0D,$0C,$0D,$0D,$0C,$16,$17,$1C
	db $1D,$1E,$1F,$18,$19,$1A,$1B,$08
	db $09,$0A,$0B,$0C,$0D

DATA_00E632:
	db $0F,$0F,$0F,$0F,$0E,$0E,$0E,$0E
	db $0D,$0D,$0D,$0D,$0C,$0C,$0C,$0C
	db $0B,$0B,$0B,$0B,$0A,$0A,$0A,$0A
	db $09,$09,$09,$09,$08,$08,$08,$08
	db $07,$07,$07,$07,$06,$06,$06,$06
	db $05,$05,$05,$05,$04,$04,$04,$04
	db $03,$03,$03,$03,$02,$02,$02,$02
	db $01,$01,$01,$01,$00,$00,$00,$00
	db $00,$00,$00,$00,$01,$01,$01,$01
	db $02,$02,$02,$02,$03,$03,$03,$03
	db $04,$04,$04,$04,$05,$05,$05,$05
	db $06,$06,$06,$06,$07,$07,$07,$07
	db $08,$08,$08,$08,$09,$09,$09,$09
	db $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B
	db $0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D
	db $0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F
	db $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C
	db $0B,$0B,$0A,$0A,$09,$09,$08,$08
	db $07,$07,$06,$06,$05,$05,$04,$04
	db $03,$03,$02,$02,$01,$01,$00,$00
	db $00,$00,$01,$01,$02,$02,$03,$03
	db $04,$04,$05,$05,$06,$06,$07,$07
	db $08,$08,$09,$09,$0A,$0A,$0B,$0B
	db $0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F
	db $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	db $07,$06,$05,$04,$03,$02,$01,$00
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	db $07,$06,$05,$04,$03,$02,$01,$00
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $08,$06,$04,$03,$02,$02,$01,$01
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $01,$01,$02,$02,$03,$04,$06,$08
	db $FF,$FE,$FD,$FC,$FB,$FA,$F9,$F8
	db $F7,$F6,$F5,$F4,$F3,$F2,$F1,$F0
	db $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7
	db $F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF
	db $FF,$FF,$FE,$FE,$FD,$FD,$FC,$FC
	db $FB,$FB,$FA,$FA,$F9,$F9,$F8,$F8
	db $F7,$F7,$F6,$F6,$F5,$F5,$F4,$F4
	db $F3,$F3,$F2,$F2,$F1,$F1,$F0,$F0
	db $F0,$F0,$F1,$F1,$F2,$F2,$F3,$F3
	db $F4,$F4,$F5,$F5,$F6,$F6,$F7,$F7
	db $F8,$F8,$F9,$F9,$FA,$FA,$FB,$FB
	db $FC,$FC,$FD,$FD,$FE,$FE,$FF,$FF
	db $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	db $07,$06,$05,$04,$03,$02,$01,$00
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	db $07,$06,$05,$04,$03,$02,$01,$00
	db $10,$10,$10,$10,$10,$10,$10,$10
	db $0E,$0C,$0A,$08,$06,$04,$02,$00
	db $0E,$0C,$0A,$08,$06,$04,$02,$00
	db $FE,$FC,$FA,$F8,$F6,$F4,$F2,$F0
	db $00,$02,$04,$06,$08,$0A,$0C,$0E
	db $10,$10,$10,$10,$10,$10,$10,$10
	db $F0,$F2,$F4,$F6,$F8,$FA,$FC,$FE
	db $00,$02,$04,$06,$08,$0A,$0C,$0E

collision_x_offsets:
	dw $0008,$000E,$000E,$0008,$0005,$000B	;		| Small, right side
	dw $0008,$0002,$0002,$0008,$000B,$0005	;		| Small, left side
	dw $0008,$000E,$000E,$0008,$0005,$000B	;		| Big, left side
	dw $0008,$0002,$0002,$0008,$000B,$0005	;		| Big, right side
	dw $0008,$000E,$000E,$0008,$0005,$000B	;		| Small, on yoshi, left side
	dw $0008,$0002,$0002,$0008,$000B,$0005	;		| Small, on yoshi, right side
	dw $0008,$000E,$000E,$0008,$0005,$000B	;		| Big, on yoshi, left side
	dw $0008,$0002,$0002,$0008,$000B,$0005	;		| Big, on yoshi, right side
	dw $0010,$0020,$0007,$0000,$FFF0,$0008	;		| Wall-running
	
collision_y_offsets:
	dw $0018,$001A,$0016,$0010,$0020,$0020	;		| Small
	dw $0018,$001A,$0016,$0010,$0020,$0020	;		| Small
	dw $0012,$001A,$000F,$0008,$0020,$0020	;		| Big
	dw $0012,$001A,$000F,$0008,$0020,$0020	;		| Big
	dw $001D,$0028,$0019,$0013,$0030,$0030	;		| Small, on yoshi
	dw $001D,$0028,$0019,$0013,$0030,$0030	;		| Small, on yoshi
	dw $001A,$0028,$0016,$0010,$0030,$0030	;		| Big, on yoshi
	dw $001A,$0028,$0016,$0010,$0030,$0030	;		| Big, on yoshi
	dw $0018,$0018,$0018,$0018,$0018,$0018	;		| Wall-running
	
DATA_00E90A:
	db $01,$02,$11

DATA_00E90D:
	db $FF

DATA_00E90E:
	db $FF,$01,$00

DATA_00E911:
	db $02,$0D

DATA_00E913:
	dw $0001,$FFFF,$0001,$0001
	dw $FFFF,$FFFF

DATA_00E91F:
	dw $0000,$0000,$FFFF,$0001
	dw $FFFF,$0001

level_collision:
	JSR reset_collision_flags		;$00E92B	\ Reset the collision flags.
	LDA.w $185C				;$00E92E	 |\ If the fall through layers flag isn't set,
	BEQ .collision				;$00E931	 |/ process collision.
	JSR CODE_00EE1D				;$00E933	 |
	BRA no_layer_collision			;$00E936	/

.collision					;		\
	LDA.w $13EF				;$00E938	 |\
	STA $8D					;$00E93B	 | | Backup the on ground flag,
	STZ.w $13EF				;$00E93D	 | |
	LDA $72					;$00E940	 | | and the in air flag.
	STA $8F					;$00E942	 |/
	LDA $5B					;$00E944	 |\ If layer 2 isn't interactive,
	BPL .no_layer2_collision		;$00E946	 |/ skip to processing layer 1 collision.
	AND.b #$82				;$00E948	 |\ Isolate the layer 2 collision flags.
	STA $8E					;$00E94A	 |/
	LDA.b #$01				;$00E94C	 |\ Set the layer being processed to layer 2.
	STA.w $1933				;$00E94E	 |/
	REP #$20				;$00E951	 |\
	LDA $94					;$00E953	 | | Offset the player's X position by
	CLC					;$00E955	 | |
	ADC $26					;$00E956	 | | layer 2's relative X position to layer 1.
	STA $94					;$00E958	 | |
	LDA $96					;$00E95A	 | | Offset the player's Y position by
	CLC					;$00E95C	 | |
	ADC $28					;$00E95D	 | | layer 2's relative Y position to layer 1.
	STA $96					;$00E95F	 | |
	SEP #$20				;$00E961	 |/
	JSR layer_collision			;$00E963	 | Process layer 2 collision.
	REP #$20				;$00E966	 |\
	LDA $94					;$00E968	 | | Restore the player's previous X position.
	SEC					;$00E96A	 | |
	SBC $26					;$00E96B	 | |
	STA $94					;$00E96D	 | |
	LDA $96					;$00E96F	 | | Restore the player's previous Y position.
	SEC					;$00E971	 | |
	SBC $28					;$00E972	 | |
	STA $96					;$00E974	 | |
	SEP #$20				;$00E976	 |/
.no_layer2_collision				;		 |
	ASL.w $13EF				;$00E978	 |
	LDA $5B					;$00E97B	 |\ Isolate the layer 1 collision flags.
	AND.b #$41				;$00E97D	 | |
	STA $8E					;$00E97F	 | |
	ASL					;$00E981	 | |
	BMI no_layer_collision			;$00E982	 |/ If the sixth bit is set, don't process layer 1 collision.
	STZ.w $1933				;$00E984	 | Set the layer being processed to layer 1.
	ASL $8D					;$00E987	 |
	JSR layer_collision			;$00E989	 | Process layer 1 collision.
no_layer_collision:				;		 |
	LDA.w $1B96				;$00E98C	 |\ If side exits are enabled,
	BEQ .no_side_exits			;$00E98F	 | |
	REP #$20				;$00E991	 | |
	LDA $7E					;$00E993	 | |
	CMP.w #$00FA				;$00E995	 | | and the player is touching the side of the screen,
	SEP #$20				;$00E998	 | |
	BCC CODE_00E9FB				;$00E99A	 | |
	JSL side_exit_level			;$00E99C	 |/ exit the level.
	RTS					;$00E9A0	/

.no_side_exits
	LDA $7E
	CMP.b #$F0				;$00E9A3	|
	BCS CODE_00EA08				;$00E9A5	|
	LDA $77					;$00E9A7	|
	AND.b #$03				;$00E9A9	|
	BNE CODE_00E9FB				;$00E9AB	|
	REP #$20				;$00E9AD	|
	LDY.b #$00				;$00E9AF	|
	LDA.w $1462				;$00E9B1	|
	CLC					;$00E9B4	|
	ADC.w #$00E8				;$00E9B5	|
	CMP $94					;$00E9B8	|
	BEQ CODE_00E9C8				;$00E9BA	|
	BMI CODE_00E9C8				;$00E9BC	|
	INY					;$00E9BE	|
	LDA $94					;$00E9BF	|
	SEC					;$00E9C1	|
	SBC.w #$0008				;$00E9C2	|
	CMP.w $1462				;$00E9C5	|
CODE_00E9C8:
	SEP #$20
	BEQ CODE_00E9FB				;$00E9CA	|
	BPL CODE_00E9FB				;$00E9CC	|
	LDA.w $1411				;$00E9CE	|
	BNE CODE_00E9F6				;$00E9D1	|
	LDA.b #$80				;$00E9D3	|
	TSB $77					;$00E9D5	|
	REP #$20				;$00E9D7	|
	LDA.w $1446				;$00E9D9	|
	LSR					;$00E9DC	|
	LSR					;$00E9DD	|
	LSR					;$00E9DE	|
	LSR					;$00E9DF	|
	SEP #$20				;$00E9E0	|
	STA $00					;$00E9E2	|
	SEC					;$00E9E4	|
	SBC $7B					;$00E9E5	|
	EOR.w DATA_00E90E,Y			;$00E9E7	|
	BMI CODE_00E9F6				;$00E9EA	|
	LDA $00					;$00E9EC	|
	STA $7B					;$00E9EE	|
	LDA.w $144E				;$00E9F0	|
	STA.w $13DA				;$00E9F3	|
CODE_00E9F6:
	LDA.w DATA_00E90A,Y
	TSB $77					;$00E9F9	|
CODE_00E9FB:
	LDA $77
	AND.b #$1C				;$00E9FD	|
	CMP.b #$1C				;$00E9FF	|
	BNE CODE_00EA0D				;$00EA01	|
	LDA.w $1471				;$00EA03	|
	BNE CODE_00EA0D				;$00EA06	|
CODE_00EA08:
	JSR CODE_00F629
	BRA CODE_00EA32				;$00EA0B	|

CODE_00EA0D:
	LDA $77
	AND.b #$03				;$00EA0F	|
	BEQ CODE_00EA34				;$00EA11	|
	AND.b #$02				;$00EA13	|
	TAY					;$00EA15	|
	REP #$20				;$00EA16	|
	LDA $94					;$00EA18	|
	CLC					;$00EA1A	|
	ADC.w DATA_00E90D,Y			;$00EA1B	|
	STA $94					;$00EA1E	|
	SEP #$20				;$00EA20	|
	LDA $77					;$00EA22	|
	BMI CODE_00EA34				;$00EA24	|
	LDA.b #$03				;$00EA26	|
	STA.w $13E5				;$00EA28	|
	LDA $7B					;$00EA2B	|
	EOR.w DATA_00E90D,Y			;$00EA2D	|
	BPL CODE_00EA34				;$00EA30	|
CODE_00EA32:
	STZ $7B
CODE_00EA34:
	LDA.w $13F9
	CMP.b #$01				;$00EA37	|
	BNE CODE_00EA42				;$00EA39	|
	LDA $8B					;$00EA3B	|
	BNE CODE_00EA42				;$00EA3D	|
	STZ.w $13F9				;$00EA3F	|
CODE_00EA42:
	STZ.w $13FA
	LDA $85					;$00EA45	|
	BNE CODE_00EA5E				;$00EA47	|
	LSR $8A					;$00EA49	|
	BCC CODE_00EAA3				;$00EA4B	|
	LDA $75					;$00EA4D	|
	BNE CODE_00EA65				;$00EA4F	|
	LDA $7D					;$00EA51	|
	BMI CODE_00EA65				;$00EA53	|
	LSR $8A					;$00EA55	|
	BCC Return00EAA5			;$00EA57	|
	JSR CODE_00FDA5				;$00EA59	|
	STZ $7D					;$00EA5C	|
CODE_00EA5E:
	LDA.b #$01
	STA $75					;$00EA60	|
CODE_00EA62:
	JMP CODE_00FD08

CODE_00EA65:
	LSR $8A
	BCS CODE_00EA5E				;$00EA67	|
	LDA $75					;$00EA69	|
	BEQ Return00EAA5			;$00EA6B	|
	LDA.b #$FC				;$00EA6D	|
	CMP $7D					;$00EA6F	|
	BMI CODE_00EA75				;$00EA71	|
	STA $7D					;$00EA73	|
CODE_00EA75:
	INC.w $13FA
	LDA $15					;$00EA78	|
	AND.b #$88				;$00EA7A	|
	CMP.b #$88				;$00EA7C	|
	BNE CODE_00EA62				;$00EA7E	|
	LDA $17					;$00EA80	|
	BPL CODE_00EA92				;$00EA82	|
	LDA.w $148F				;$00EA84	|
	BNE CODE_00EA92				;$00EA87	|
	INC A					;$00EA89	|
	STA.w $140D				;$00EA8A	|
	LDA.b #$04				;$00EA8D	|
	STA.w $1DFC				;$00EA8F	|
CODE_00EA92:
	LDA $77
	AND.b #$08				;$00EA94	|
	BNE CODE_00EA62				;$00EA96	|
	JSR CODE_00FDA5				;$00EA98	|
	LDA.b #$0B				;$00EA9B	|
	STA $72					;$00EA9D	|
	LDA.b #$AA				;$00EA9F	|
	STA $7D					;$00EAA1	|
CODE_00EAA3:
	STZ $75
Return00EAA5:
	RTS

reset_collision_flags:
	STZ.w $13E5				;$00EAA6	\ Clear the player animation timer index,
	STZ $77					;$00EAA9	 | the directional blocked status,
	STZ.w $13E1				;$00EAAB	 |\ the type of slope that the player is on,
	STZ.w $13EE				;$00EAAE	 |/
	STZ $8A					;$00EAB1	 | the collision points' swimming flags,
	STZ $8B					;$00EAB3	 | the collision points' climbing flags,
	STZ.w $140E				;$00EAB5	 | and the layer 2 touched flag.
	RTS					;$00EAB8	/

DATA_00EAB9:
	db $DE,$23

DATA_00EABB:
	db $20,$E0

DATA_00EABD:
	dw $0008,$FFF8

page_1_water_tiles:
	db $71,$72,$76,$77,$7B,$7C,$81,$86
	db $8A,$8B,$8F,$90,$94,$95,$99,$9A
	db $9E,$9F,$A3,$A4,$A8,$A9,$AD,$AE
	db $B2,$B3

layer_collision:
	LDA $96					;$00EADB	|
	AND.b #$0F				;$00EADD	|
	STA $90					;$00EADF	|
	LDA.w $13E3				;$00EAE1	|
	BNE .wall_running			;$00EAE4	|
	JMP normal_collision			;$00EAE6	|

.wall_running
	AND.b #$01				;$00EAE9	|
	TAY					;$00EAEB	|
	LDA $7B					;$00EAEC	|
	SEC					;$00EAEE	|
	SBC.w DATA_00EAB9,Y			;$00EAEF	|
	EOR.w DATA_00EAB9,Y			;$00EAF2	|
	BMI walk_off_wall			;$00EAF5	|
	LDA $72					;$00EAF7	|
	ORA.w $148F				;$00EAF9	|
	ORA $73					;$00EAFC	|
	ORA.w $187A				;$00EAFE	|
	BNE walk_off_wall			;$00EB01	|
	LDA.w $13E3				;$00EB03	|
	CMP.b #$06				;$00EB06	|
	BCS .on_wall				;$00EB08	|
	LDX $90					;$00EB0A	|
	CPX.b #$08				;$00EB0C	|
	BCC stop_wall_running_return		;$00EB0E	|
	CMP.b #$04				;$00EB10	|
	BCS stop_wall_running			;$00EB12	|
	ORA.b #$04				;$00EB14	|
	STA.w $13E3				;$00EB16	|
.solid_collision				;		|
	LDA $94					;$00EB19	|
	AND.b #$F0				;$00EB1B	|
	ORA.b #$08				;$00EB1D	|
	STA $94					;$00EB1F	|
	RTS					;$00EB21	|

.on_wall
	LDX.b #$60				;$00EB22	|
	TYA					;$00EB24	|
	BEQ .on_left_wall			;$00EB25	|
	LDX.b #$66				;$00EB27	|
.on_left_wall					;		|
	JSR CODE_00EFE8				;$00EB29	|
	LDA $19					;$00EB2C	|
	BNE .process_big			;$00EB2E	|
	INX					;$00EB30	|
	INX					;$00EB31	|
	BRA .skip				;$00EB32	|

.process_big					;		|
	JSR CODE_00EFE8				;$00EB34	|
.skip						;		|
	JSR process_collision_point		;$00EB37	|
	BNE .solid_collision			;$00EB3A	|
	LDA.b #$02				;$00EB3C	|
	TRB.w $13E3				;$00EB3E	|
	RTS					;$00EB41	|

fall_off_wall:
	LDA.w $13E3				;$00EB42	|
	AND.b #$01				;$00EB45	|
	TAY					;$00EB47	|
walk_off_wall:					;		|
	LDA.w DATA_00EABB,Y			;$00EB48	|
	STA $7B					;$00EB4B	|
	TYA					;$00EB4D	|
	ASL					;$00EB4E	|
	TAY					;$00EB4F	|
	REP #$20				;$00EB50	|
	LDA $94					;$00EB52	|
	CLC					;$00EB54	|
	ADC.w DATA_00EABD,Y			;$00EB55	|
	STA $94					;$00EB58	|
	LDA.w #$0008				;$00EB5A	|
	LDY $19					;$00EB5D	|
	BEQ .not_big				;$00EB5F	|
	LDA.w #$0010				;$00EB61	|
.not_big					;		|
	CLC					;$00EB64	|
	ADC $96					;$00EB65	|
	STA $96					;$00EB67	|
	SEP #$20				;$00EB69	|
	LDA.b #$24				;$00EB6B	|
	STA $72					;$00EB6D	|
	LDA.b #$E0				;$00EB6F	|
	STA $7D					;$00EB71	|
stop_wall_running:
	STZ.w $13E3				;$00EB73	|
.return
	RTS					;$00EB76	|

normal_collision:
	LDX.b #$00				;$00EB77	\ Initialize collision point index
	LDA $19					;$00EB79	 |\
	BEQ .not_big				;$00EB7B	 | | If the player is big
	LDA $73					;$00EB7D	 | |
	BNE .not_big				;$00EB7F	 | | and not ducking,
	LDX.b #$18				;$00EB81	 | | use the big Mario collision point indices.
.not_big					;		 |/
	LDA.w $187A				;$00EB83	 |\
	BEQ .not_on_yoshi			;$00EB86	 | | If the player is on yoshi,
	TXA					;$00EB88	 | |
	CLC					;$00EB89	 | |
	ADC.b #$30				;$00EB8A	 | | use the Yoshi collision point indices.
	TAX					;$00EB8C	 | |
.not_on_yoshi					;		 |/
	LDA $94					;$00EB8D	 |\ Get the player X,
	AND.b #$0F				;$00EB8F	 | | take the lower nybble,
	TAY					;$00EB91	 | |
	CLC					;$00EB92	 | |
	ADC.b #$08				;$00EB93	 | |
	AND.b #$0F				;$00EB95	 | |
	STA $92					;$00EB97	 | | and set the position within a block.
	STZ $93					;$00EB99	 |/
	CPY.b #$08				;$00EB9B	 |\ If the player is on the left side of a block,
	BCC .right_side				;$00EB9D	 | |
	TXA					;$00EB9F	 | |
	ADC.b #$0B				;$00EBA0	 | | use the left side collision point indices.
	TAX					;$00EBA2	 | |
	INC $93					;$00EBA3	 | | Set the side of the block that the player is in.
.right_side					;		 |/
	LDA $90					;$00EBA5	 |\ Get the player Y,
	CLC					;$00EBA7	 | |
	ADC.w collision_y_offsets+6,X		;$00EBA8	 | | add the head offset,
	AND.b #$0F				;$00EBAB	 | |
	STA $91					;$00EBAD	 |/ and set the amount to move the player out of a block.
	JSR process_collision_point		;$00EBAF	 | Process the center body collision point.
	BEQ .center_page_0			;$00EBB2	 |\ Process page 0 tiles, if applicable.
	CPY.b #$11				;$00EBB4	 | | If it's tiles 100 - 110,
	BCC .skip_center			;$00EBB6	 | | ignore it.
	CPY.b #$6E				;$00EBB8	 | | If it's tiles 111 - 16D,
	BCC .center_solid			;$00EBBA	 | | process being inside a solid block.
	TYA					;$00EBBC	 | |
	JSL is_page_1_water			;$00EBBD	 | | If the tile isn't a water tile,
	BCC .skip_center			;$00EBC1	 | |
	LDA.b #$01				;$00EBC3	 | |
	TSB $8A					;$00EBC5	 |/ disable the center swimming flag.
	BRA .skip_center			;$00EBC7	/

.center_solid
	INX					;$00EBC9	\
	INX					;$00EBCA	 |
	INX					;$00EBCB	 |
	INX					;$00EBCC	 | Skip to the head collision point.
	TYA					;$00EBCD	 |
	LDY.b #$00				;$00EBCE	 |
	CMP.b #$1E				;$00EBD0	 |\ If the tile is a turn block
	BEQ .not_inside_block			;$00EBD2	 | |
	CMP.b #$52				;$00EBD4	 | | or a temporary invisible block,
	BEQ .not_inside_block			;$00EBD6	 | |
	LDY.b #$02				;$00EBD8	 | | don't mark the player as being inside of a block.
.not_inside_block				;		 |/
	JMP .center_in_block			;$00EBDA	/ Run center body in block code.

.center_page_0
	CPY.b #$9C				;$00EBDD	\
	BNE .not_castle_door			;$00EBDF	 |\ If the tile is part of the castle door
	LDA.w $1931				;$00EBE1	 | |
	CMP.b #$01				;$00EBE4	 | | and the tileset is the castle tileset,
	BEQ .castle_door			;$00EBE6	 |/ process castle door.
.not_castle_door				;		 |
	CPY.b #$20				;$00EBE8	 |\ If applicable, process lower half of a door.
	BEQ .lower_door				;$00EBEA	 |/
	CPY.b #$1F				;$00EBEC	 |\ If applicable, process upper half of a door.
	BEQ .upper_door				;$00EBEE	 |/
	LDA.w $14AD				;$00EBF0	 |\ If the blue P-switch is active,
	BEQ .process_center			;$00EBF3	 | |
	CPY.b #$28				;$00EBF5	 | | if applicable, process lower half of a P-switch door.
	BEQ .lower_door				;$00EBF7	 | |
	CPY.b #$27				;$00EBF9	 | | if applicable, process upper half of P-switch door.
	BNE .process_center			;$00EBFB	 |/
.upper_door					;		 |
	LDA $19					;$00EBFD	 |\ If the player is big,
	BNE .skip_center			;$00EBFF	 |/ don't let him use the upper half of the door.
.lower_door					;		 |
	JSR can_use_door			;$00EC01	 |\ If the player isn't positioned correctly,
	BCS .skip_center			;$00EC04	 | |
.castle_door					;		 | |
	LDA $8F					;$00EC06	 | | or if the player isn't on the ground,
	BNE .skip_center			;$00EC08	 | |
	LDA $16					;$00EC0A	 | | or if the player isn't pressing up,
	AND.b #$08				;$00EC0C	 | |
	BEQ .skip_center			;$00EC0E	 |/ don't let him use the door.
	LDA.b #$0F				;$00EC10	 |\ Play the door sound,
	STA.w $1DFC				;$00EC12	 | |
	JSR go_to_sublevel			;$00EC15	 | | go to the sublevel,
	LDA.b #$0D				;$00EC18	 | |
	STA $71					;$00EC1A	 | | set the door animation,
	JSR disable_controls			;$00EC1C	 |/ and disable controls.
	BRA .skip_center			;$00EC1F	/

.process_center
	JSR process_center_page_0_tiles		;$00EC21	\ Process center body page 0 tile collision.
.skip_center					;		 |
	JSR process_collision_point		;$00EC24	 | Process the side body collision point.
	BEQ .side_body_page_0			;$00EC27	 | If applicable, process page 0 tiles.
	CPY.b #$11				;$00EC29	 |\ If the tile is 100 - 111
	BCC .skip_side_body			;$00EC2B	 | |
	CPY.b #$6E				;$00EC2D	 | | or 16E - 1FF,
	BCS .skip_side_body			;$00EC2F	 |/ ignore it.
	INX					;$00EC31	 |
	INX					;$00EC32	 | Skip to the head collision point.
	BRA .side_body_in_block			;$00EC33	/

.side_body_page_0
	LDA.b #$10				;$00EC35	\ Load the climbing flag to set.
	JSR process_page_0_tiles_no_swim	;$00EC37	 | Process side body page 0 tile collision without water.
.skip_side_body					;		 |
	JSR process_collision_point		;$00EC3A	 | Process the side head collision point.
	BNE .side_head_page_1			;$00EC3D	 | If applicable, process page 1 tiles.
	LDA.b #$08				;$00EC3F	 | Load the climbing flag to set.
	JSR process_page_0_tiles_no_swim	;$00EC41	 | Process side head page 0 tile collision without water.
	BRA .skip_side_head			;$00EC44	/

.side_head_page_1				;		\
	CPY.b #$11				;$00EC46	 |\ If the tile is 100 - 111
	BCC .skip_side_head			;$00EC48	 | |
	CPY.b #$6E				;$00EC4A	 | | or 16E - 1FF,
	BCS .skip_side_head			;$00EC4C	 |/ ignore it.
.side_body_in_block				;		 |
	LDA $76					;$00EC4E	 |
	CMP $93					;$00EC50	 |
	BEQ .CODE_00EC5F			;$00EC52	 |
	JSR process_horizontal_pipe		;$00EC54	 |
	PHX					;$00EC57	 |
	JSR process_throw_block			;$00EC58	 |
	LDY.w $1693				;$00EC5B	 |
	PLX					;$00EC5E	 |
.CODE_00EC5F					;		 |
	LDA.b #$03				;$00EC5F	 |
	STA.w $13E5				;$00EC61	 |
	LDY $93					;$00EC64	 |
	LDA $94					;$00EC66	 |
	AND.b #$0F				;$00EC68	 |
	CMP.w DATA_00E911,Y			;$00EC6A	 |
	BEQ .skip_side_head			;$00EC6D	 |
.center_in_block				;		 |
	LDA.w $1402				;$00EC6F	 |
	BEQ .on_note_block			;$00EC72	 |
	LDA.w $1693				;$00EC74	 |
	CMP.b #$52				;$00EC77	 |
	BEQ .skip_side_head			;$00EC79	 |
.on_note_block					;		 |
	LDA.w DATA_00E90A,Y			;$00EC7B	 |
	TSB $77					;$00EC7E	 |
	AND.b #$03				;$00EC80	 |
	TAY					;$00EC82	 |
	LDA.w $1693				;$00EC83	 |
	JSL CODE_00F127				;$00EC86	 |
.skip_side_head					;		 |
	JSR process_collision_point		;$00EC8A	 | Process the head collision point.
	BNE CODE_00ECB1				;$00EC8D	 |
	LDA.b #$02				;$00EC8F	 |
	JSR process_page_0_tiles		;$00EC91	 |
	LDY $7D					;$00EC94	 |
	BPL CODE_00ECA3				;$00EC96	 |
	LDA.w $1693				;$00EC98	 |
	CMP.b #$21				;$00EC9B	 |
	BCC CODE_00ECA3				;$00EC9D	 |
	CMP.b #$25				;$00EC9F	 |
	BCC CODE_00ECA6				;$00ECA1	 |
CODE_00ECA3:
	JMP CODE_00ED4A

CODE_00ECA6:
	SEC
	SBC.b #$04				;$00ECA7	|
	LDY.b #$00				;$00ECA9	|
	JSL CODE_00F17F				;$00ECAB	|
	BRA CODE_00ED0D				;$00ECAF	|

CODE_00ECB1:
	CPY.b #$11
	BCC CODE_00ECA3				;$00ECB3	|
	CPY.b #$6E				;$00ECB5	|
	BCC CODE_00ECFA				;$00ECB7	|
	CPY.b #$D8				;$00ECB9	|
	BCC CODE_00ECDA				;$00ECBB	|
	REP #$20				;$00ECBD	|
	LDA $98					;$00ECBF	|
	CLC					;$00ECC1	|
	ADC.w #$0010				;$00ECC2	|
	STA $98					;$00ECC5	|
	JSR process_collision			;$00ECC7	|
	BEQ CODE_00ECF8				;$00ECCA	|
	CPY.b #$6E				;$00ECCC	|
	BCC CODE_00ED4A				;$00ECCE	|
	CPY.b #$D8				;$00ECD0	|
	BCS CODE_00ED4A				;$00ECD2	|
	LDA $91					;$00ECD4	|
	SBC.b #$0F				;$00ECD6	|
	STA $91					;$00ECD8	|
CODE_00ECDA:
	TYA
	SEC					;$00ECDB	|
	SBC.b #$6E				;$00ECDC	|
	TAY					;$00ECDE	|
	REP #$20				;$00ECDF	|
	LDA [$82],Y				;$00ECE1	|
	AND.w #$00FF				;$00ECE3	|
	ASL					;$00ECE6	|
	ASL					;$00ECE7	|
	ASL					;$00ECE8	|
	ASL					;$00ECE9	|
	SEP #$20				;$00ECEA	|
	ORA $92					;$00ECEC	|
	REP #$10				;$00ECEE	|
	TAY					;$00ECF0	|
	LDA.w DATA_00E632,Y			;$00ECF1	|
	SEP #$10				;$00ECF4	|
	BMI CODE_00ED0F				;$00ECF6	|
CODE_00ECF8:
	BRA CODE_00ED4A

CODE_00ECFA:
	LDA.b #$02
	JSR CODE_00F3E9				;$00ECFC	|
	TYA					;$00ECFF	|
	LDY.b #$00				;$00ED00	|
	JSL CODE_00F127				;$00ED02	|
	LDA.w $1693				;$00ED06	|
	CMP.b #$1E				;$00ED09	|
	BEQ CODE_00ED3B				;$00ED0B	|
CODE_00ED0D:
	LDA.b #$F0
CODE_00ED0F:
	CLC
	ADC $91					;$00ED10	|
	BPL CODE_00ED4A				;$00ED12	|
	CMP.b #$F9				;$00ED14	|
	BCS CODE_00ED28				;$00ED16	|
	LDY $72					;$00ED18	|
	BNE CODE_00ED28				;$00ED1A	|
	LDA $77					;$00ED1C	|
	AND.b #$FC				;$00ED1E	|
	ORA.b #$09				;$00ED20	|
	STA $77					;$00ED22	|
	STZ $7B					;$00ED24	|
	BRA CODE_00ED3B				;$00ED26	|

CODE_00ED28:
	LDY $72
	BEQ CODE_00ED37				;$00ED2A	|
	EOR.b #$FF				;$00ED2C	|
	CLC					;$00ED2E	|
	ADC $96					;$00ED2F	|
	STA $96					;$00ED31	|
	BCC CODE_00ED37				;$00ED33	|
	INC $97					;$00ED35	|
CODE_00ED37:
	LDA.b #$08
	TSB $77					;$00ED39	|
CODE_00ED3B:
	LDA $7D
	BPL CODE_00ED4A				;$00ED3D	|
	STZ $7D					;$00ED3F	|
	LDA.w $1DF9				;$00ED41	|
	BNE CODE_00ED4A				;$00ED44	|
	INC A					;$00ED46	|
	STA.w $1DF9				;$00ED47	|
CODE_00ED4A:
	JSR process_collision_point
	BNE CODE_00ED52				;$00ED4D	|
	JMP CODE_00EDDB				;$00ED4F	|

CODE_00ED52:
	CPY.b #$6E
	BCS CODE_00ED5E				;$00ED54	|
	LDA.b #$03				;$00ED56	|
	JSR CODE_00F3E9				;$00ED58	|
	JMP CODE_00EDF7				;$00ED5B	|

CODE_00ED5E:
	CPY.b #$D8
	BCC CODE_00ED86				;$00ED60	|
	CPY.b #$FB				;$00ED62	|
	BCC CODE_00ED69				;$00ED64	|
	JMP CODE_00F629				;$00ED66	|

CODE_00ED69:
	REP #$20
	LDA $98					;$00ED6B	|
	SEC					;$00ED6D	|
	SBC.w #$0010				;$00ED6E	|
	STA $98					;$00ED71	|
	JSR process_collision			;$00ED73	|
	BEQ CODE_00EDE9				;$00ED76	|
	CPY.b #$6E				;$00ED78	|
	BCC CODE_00EDE9				;$00ED7A	|
	CPY.b #$D8				;$00ED7C	|
	BCS CODE_00EDE9				;$00ED7E	|
	LDA $90					;$00ED80	|
	ADC.b #$10				;$00ED82	|
	STA $90					;$00ED84	|
CODE_00ED86:
	LDA.w $1931
	CMP.b #$03				;$00ED89	|
	BEQ CODE_00ED91				;$00ED8B	|
	CMP.b #$0E				;$00ED8D	|
	BNE CODE_00ED95				;$00ED8F	|
CODE_00ED91:
	CPY.b #$D2
	BCS CODE_00EDE9				;$00ED93	|
CODE_00ED95:
	TYA
	SEC					;$00ED96	|
	SBC.b #$6E				;$00ED97	|
	TAY					;$00ED99	|
	LDA [$82],Y				;$00ED9A	|
	PHA					;$00ED9C	|
	REP #$20				;$00ED9D	|
	AND.w #$00FF				;$00ED9F	|
	ASL					;$00EDA2	|
	ASL					;$00EDA3	|
	ASL					;$00EDA4	|
	ASL					;$00EDA5	|
	SEP #$20				;$00EDA6	|
	ORA $92					;$00EDA8	|
	PHX					;$00EDAA	|
	REP #$10				;$00EDAB	|
	TAX					;$00EDAD	|
	LDA $90					;$00EDAE	|
	SEC					;$00EDB0	|
	SBC.w DATA_00E632,X			;$00EDB1	|
	BPL CODE_00EDB9				;$00EDB4	|
	INC.w $13EF				;$00EDB6	|
CODE_00EDB9:
	SEP #$10
	PLX					;$00EDBB	|
	PLY					;$00EDBC	|
	CMP.w DATA_00E51C,Y			;$00EDBD	|
	BCS CODE_00EDE9				;$00EDC0	|
	STA $91					;$00EDC2	|
	STZ $90					;$00EDC4	|
	JSR CODE_00F005				;$00EDC6	|
	CPY.b #$1C				;$00EDC9	|
	BCC CODE_00EDD5				;$00EDCB	|
	LDA.b #$08				;$00EDCD	|
	STA.w $14A1				;$00EDCF	|
	JMP CODE_00EED1				;$00EDD2	|

CODE_00EDD5:
	JSR CODE_00EFBC
	JMP CODE_00EE85				;$00EDD8	|

CODE_00EDDB:
	CPY.b #$05
	BNE CODE_00EDE4				;$00EDDD	|
	JSR CODE_00F629				;$00EDDF	|
	BRA CODE_00EDE9				;$00EDE2	|

CODE_00EDE4:
	LDA.b #$04
	JSR process_page_0_tiles		;$00EDE6	|
CODE_00EDE9:
	JSR process_collision_point
	BNE CODE_00EDF3				;$00EDEC	|
	JSR process_page_0_tiles_no_climb	;$00EDEE	|
	BRA CODE_00EE1D				;$00EDF1	|

CODE_00EDF3:
	CPY.b #$6E
	BCS CODE_00EE1D				;$00EDF5	|
CODE_00EDF7:
	LDA $7D
	BMI Return00EE39			;$00EDF9	|
	LDA.w $1931				;$00EDFB	|
	CMP.b #$03				;$00EDFE	|
	BEQ CODE_00EE06				;$00EE00	|
	CMP.b #$0E				;$00EE02	|
	BNE CODE_00EE11				;$00EE04	|
CODE_00EE06:
	LDY.w $1693
	CPY.b #$59				;$00EE09	|
	BCC CODE_00EE11				;$00EE0B	|
	CPY.b #$5C				;$00EE0D	|
	BCC CODE_00EE1D				;$00EE0F	|
CODE_00EE11:
	LDA $90
	AND.b #$0F				;$00EE13	|
	STZ $90					;$00EE15	|
	CMP.b #$08				;$00EE17	|
	STA $91					;$00EE19	|
	BCC CODE_00EE3A				;$00EE1B	|
CODE_00EE1D:
	LDA.w $1471
	BEQ CODE_00EE2D				;$00EE20	|
	LDA $7D					;$00EE22	|
	BMI CODE_00EE2D				;$00EE24	|
	STZ $8E					;$00EE26	|
	LDY.b #$20				;$00EE28	|
	JMP CODE_00EEE1				;$00EE2A	|

CODE_00EE2D:
	LDA $77
	AND.b #$04				;$00EE2F	|
	ORA $72					;$00EE31	|
	BNE Return00EE39			;$00EE33	|
CODE_00EE35:
	LDA.b #$24
	STA $72					;$00EE37	|
Return00EE39:
	RTS

CODE_00EE3A:
	LDY.w $1693
	LDA.w $1931				;$00EE3D	|
	CMP.b #$02				;$00EE40	|
	BEQ CODE_00EE48				;$00EE42	|
	CMP.b #$08				;$00EE44	|
	BNE CODE_00EE57				;$00EE46	|
CODE_00EE48:
	TYA
	SEC					;$00EE49	|
	SBC.b #$0C				;$00EE4A	|
	CMP.b #$02				;$00EE4C	|
	BCS CODE_00EE57				;$00EE4E	|
	ASL					;$00EE50	|
	TAX					;$00EE51	|
	JSR CODE_00EFCD				;$00EE52	|
	BRA CODE_00EE83				;$00EE55	|

CODE_00EE57:
	JSR process_throw_block
	LDY.b #$03				;$00EE5A	|
	LDA.w $1693				;$00EE5C	|
	CMP.b #$1E				;$00EE5F	|
	BNE CODE_00EE78				;$00EE61	|
	LDX $8F					;$00EE63	|
	BEQ CODE_00EE83				;$00EE65	|
	LDX $19					;$00EE67	|
	BEQ CODE_00EE83				;$00EE69	|
	LDX.w $140D				;$00EE6B	|
	BEQ CODE_00EE83				;$00EE6E	|
	LDA.b #$21				;$00EE70	|
	JSL CODE_00F17F				;$00EE72	|
	BRA CODE_00EE1D				;$00EE76	|

CODE_00EE78:
	CMP.b #$32
	BNE CODE_00EE7F				;$00EE7A	|
	STZ.w $1909				;$00EE7C	|
CODE_00EE7F:
	JSL CODE_00F120
CODE_00EE83:
	LDY.b #$20
CODE_00EE85:
	LDA $7D
	BPL CODE_00EE8F				;$00EE87	|
	LDA $8D					;$00EE89	|
	CMP.b #$02				;$00EE8B	|
	BCC Return00EE39			;$00EE8D	|
CODE_00EE8F:
	LDX.w $1423
	BEQ CODE_00EED1				;$00EE92	|
	DEX					;$00EE94	|
	TXA					;$00EE95	|
	AND.b #$03				;$00EE96	|
	BEQ CODE_00EEAA				;$00EE98	|
	CMP.b #$02				;$00EE9A	|
	BCS CODE_00EED1				;$00EE9C	|
	REP #$20				;$00EE9E	|
	LDA $9A					;$00EEA0	|
	SEC					;$00EEA2	|
	SBC.w #$0010				;$00EEA3	|
	STA $9A					;$00EEA6	|
	SEP #$20				;$00EEA8	|
CODE_00EEAA:
	TXA
	LSR					;$00EEAB	|
	LSR					;$00EEAC	|
	TAX					;$00EEAD	|
	LDA.w $1F27,X				;$00EEAE	|
	BNE CODE_00EED1				;$00EEB1	|
	INC A					;$00EEB3	|
	STA.w $1F27,X				;$00EEB4	|
	STA.w $13D2				;$00EEB7	|
	PHY					;$00EEBA	|
	STX.w $191E				;$00EEBB	|
	JSR FlatPalaceSwitch			;$00EEBE	|
	PLY					;$00EEC1	|
	LDA.b #$0C				;$00EEC2	|
	STA.w $1DFB				;$00EEC4	|
	LDA.b #$FF				;$00EEC7	|
	STA.w $0DDA				;$00EEC9	|
	LDA.b #$08				;$00EECC	|
	STA.w $1493				;$00EECE	|
CODE_00EED1:
	INC.w $13EF
	LDA $96					;$00EED4	|
	SEC					;$00EED6	|
	SBC $91					;$00EED7	|
	STA $96					;$00EED9	|
	LDA $97					;$00EEDB	|
	SBC $90					;$00EEDD	|
	STA $97					;$00EEDF	|
CODE_00EEE1:
	LDA.w DATA_00E53D,Y
	BNE CODE_00EEEF				;$00EEE4	|
	LDX.w $13ED				;$00EEE6	|
	BEQ CODE_00EF05				;$00EEE9	|
	LDX $7B					;$00EEEB	|
	BEQ CODE_00EF02				;$00EEED	|
CODE_00EEEF:
	STA.w $13EE
	LDA $15					;$00EEF2	|
	AND.b #$04				;$00EEF4	|
	BEQ CODE_00EF05				;$00EEF6	|
	LDA.w $148F				;$00EEF8	|
	ORA.w $13ED				;$00EEFB	|
	BNE CODE_00EF05				;$00EEFE	|
	LDX.b #$1C				;$00EF00	|
CODE_00EF02:
	STX.w $13ED
CODE_00EF05:
	LDX.w DATA_00E4B9,Y
	STX.w $13E1				;$00EF08	|
	CPY.b #$1C				;$00EF0B	|
	BCS CODE_00EF38				;$00EF0D	|
	LDA $7B					;$00EF0F	|
	BEQ CODE_00EF31				;$00EF11	|
	LDA.w DATA_00E53D,Y			;$00EF13	|
	BEQ CODE_00EF31				;$00EF16	|
	EOR $7B					;$00EF18	|
	BPL CODE_00EF31				;$00EF1A	|
	STX.w $13E5				;$00EF1C	|
	LDA $7B					;$00EF1F	|
	BPL CODE_00EF26				;$00EF21	|
	EOR.b #$FF				;$00EF23	|
	INC A					;$00EF25	|
CODE_00EF26:
	CMP.b #$28
	BCC CODE_00EF2F				;$00EF28	|
	LDA.w DATA_00E4FB,Y			;$00EF2A	|
	BRA CODE_00EF60				;$00EF2D	|

CODE_00EF2F:
	LDY.b #$20
CODE_00EF31:
	LDA $7D
	CMP.w DATA_00E4DA,Y			;$00EF33	|
	BCC CODE_00EF3B				;$00EF36	|
CODE_00EF38:
	LDA.w DATA_00E4DA,Y
CODE_00EF3B:
	LDX $8E
	BPL CODE_00EF60				;$00EF3D	|
	INC.w $140E				;$00EF3F	|
	PHA					;$00EF42	|
	REP #$20				;$00EF43	|
	LDA.w $17BE				;$00EF45	|
	AND.w #$FF00				;$00EF48	|
	BPL CODE_00EF50				;$00EF4B	|
	ORA.w #$00FF				;$00EF4D	|
CODE_00EF50:
	XBA
	EOR.w #$FFFF				;$00EF51	|
	INC A					;$00EF54	|
	CLC					;$00EF55	|
	ADC $94					;$00EF56	|
	STA $94					;$00EF58	|
	SEP #$20				;$00EF5A	|
	PLA					;$00EF5C	|
	CLC					;$00EF5D	|
	ADC.b #$28				;$00EF5E	|
CODE_00EF60:
	STA $7D
	TAX					;$00EF62	|
	BPL CODE_00EF68				;$00EF63	|
	INC.w $13EF				;$00EF65	|
CODE_00EF68:
	STZ.w $18B5
	STZ $72					;$00EF6B	|
	STZ $74					;$00EF6D	|
	STZ.w $1406				;$00EF6F	|
	STZ.w $140D				;$00EF72	|
	LDA.b #$04				;$00EF75	|
	TSB $77					;$00EF77	|
	LDY.w $1407				;$00EF79	|
	BNE CODE_00EF99				;$00EF7C	|
	LDA.w $187A				;$00EF7E	|
	BEQ CODE_00EF95				;$00EF81	|
	LDA $8F					;$00EF83	|
	BEQ CODE_00EF95				;$00EF85	|
	LDA.w $18E7				;$00EF87	|
	BEQ CODE_00EF95				;$00EF8A	|
	JSL YoshiStompRoutine			;$00EF8C	|
	LDA.b #$25				;$00EF90	|
	STA.w $1DFC				;$00EF92	|
CODE_00EF95:
	STZ.w $1697
	RTS					;$00EF98	|

CODE_00EF99:
	STZ.w $1697
	STZ.w $1407				;$00EF9C	|
	CPY.b #$05				;$00EF9F	|
	BCS CallGroundPound			;$00EFA1	|
	LDA $19					;$00EFA3	|
	CMP.b #$02				;$00EFA5	|
	BNE Return00EFAD			;$00EFA7	|
	SEC					;$00EFA9	|
	ROR.w $13ED				;$00EFAA	|
Return00EFAD:
	RTS

CallGroundPound:
	LDA $8F
	BEQ Return00EFBB			;$00EFB0	|
	JSL GroundPound				;$00EFB2	|
	LDA.b #$09				;$00EFB6	|
	STA.w $1DFC				;$00EFB8	|
Return00EFBB:
	RTS

CODE_00EFBC:
	LDX.w $1693
	CPX.b #$CE				;$00EFBF	|
	BCC Return00EFE7			;$00EFC1	|
	CPX.b #$D2				;$00EFC3	|
	BCS Return00EFE7			;$00EFC5	|
	TXA					;$00EFC7	|
	SEC					;$00EFC8	|
	SBC.b #$CC				;$00EFC9	|
	ASL					;$00EFCB	|
	TAX					;$00EFCC	|
CODE_00EFCD:
	LDA $13
	AND.b #$03				;$00EFCF	|
	BNE Return00EFE7			;$00EFD1	|
	REP #$20				;$00EFD3	|
	LDA $94					;$00EFD5	|
	CLC					;$00EFD7	|
	ADC.w DATA_00E913,X			;$00EFD8	|
	STA $94					;$00EFDB	|
	LDA $96					;$00EFDD	|
	CLC					;$00EFDF	|
	ADC.w DATA_00E91F,X			;$00EFE0	|
	STA $96					;$00EFE3	|
	SEP #$20				;$00EFE5	|
Return00EFE7:
	RTS

CODE_00EFE8:
	JSR process_collision_point
	BNE ADDR_00EFF0				;$00EFEB	|
	JMP process_page_0_tiles_no_climb	;$00EFED	|

ADDR_00EFF0:
	CPY.b #$11
	BCC Return00F004			;$00EFF2	|
	CPY.b #$6E				;$00EFF4	|
	BCS Return00F004			;$00EFF6	|
	TYA					;$00EFF8	|
	LDY.b #$00				;$00EFF9	|
	JSL CODE_00F160				;$00EFFB	|
	PLA					;$00EFFF	|
	PLA					;$00F000	|
	JMP fall_off_wall			;$00F001	|

Return00F004:
	RTS

CODE_00F005:
	TYA
	SEC					;$00F006	|
	SBC.b #$0E				;$00F007	|
	CMP.b #$02				;$00F009	|
	BCS Return00F04C			;$00F00B	|
	EOR.b #$01				;$00F00D	|
	CMP $76					;$00F00F	|
	BNE Return00F04C			;$00F011	|
	TAX					;$00F013	|
	LSR					;$00F014	|
	LDA $92					;$00F015	|
	BCC CODE_00F01B				;$00F017	|
	EOR.b #$0F				;$00F019	|
CODE_00F01B:
	CMP.b #$08
	BCS Return00F04C			;$00F01D	|
	LDA.w $187A				;$00F01F	|
	BEQ CODE_00F035				;$00F022	|
	LDA.b #$08				;$00F024	|
	STA.w $1DFC				;$00F026	|
	LDA.b #$80				;$00F029	|
	STA $7D					;$00F02B	|
	STA.w $1406				;$00F02D	|
	PLA					;$00F030	|
	PLA					;$00F031	|
	JMP CODE_00EE35				;$00F032	|

CODE_00F035:
	LDA $7B
	SEC					;$00F037	|
	SBC.w DATA_00EAB9,X			;$00F038	|
	EOR.w DATA_00EAB9,X			;$00F03B	|
	BMI Return00F04C			;$00F03E	|
	LDA.w $148F				;$00F040	|
	ORA $73					;$00F043	|
	BNE Return00F04C			;$00F045	|
	INX					;$00F047	|
	INX					;$00F048	|
	STX.w $13E3				;$00F049	|
Return00F04C:
	RTS

is_page_1_water:
	PHX					;$00F04D	\
	LDX.b #$19				;$00F04E	 | Initialize the loop counter.
.loop						;		 |\
	CMP.l page_1_water_tiles,X		;$00F050	 | | If the tile is one of these water tiles,
	BEQ .return				;$00F054	 | | set carry to indicate "true" and return.
	DEX					;$00F056	 | | Otherwise, continue checking.
	BPL .loop				;$00F057	 |/
	CLC					;$00F059	 | Clear carry to indicate "false."
.return						;		 |
	PLX					;$00F05A	 |
	RTL					;$00F05B	/

DATA_00F05C:
	db $01,$05,$01,$02,$01,$01,$00,$00
	db $00,$00,$00,$00,$00,$06,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $02,$03,$03,$04,$02,$02,$02,$01
	db $01,$07,$11,$10

DATA_00F080:
	db $80,$00,$00,$1E,$00,$00,$05,$09
	db $06,$81,$0E,$0C,$14,$00,$05,$09
	db $06,$07,$0E,$0C,$16,$18,$1A,$1A
	db $00,$09,$00,$00,$FF,$0C,$0A,$00
	db $00,$00,$08,$02

DATA_00F0A4:
	db $0C,$08,$0C,$08,$0C,$0F,$08,$08
	db $08,$08,$08,$08,$08,$08,$08,$08
	db $08,$08,$08,$08,$08,$08,$08,$08
	db $08,$03,$03,$08,$08,$08,$08,$08
	db $08,$04,$08,$08

DATA_00F0C8:
	db $0E,$13,$0E,$0D,$0E,$10,$0D,$0D
	db $0D,$0D,$0A,$0D,$0D,$0C,$0D,$0D
	db $0D,$0D,$0B,$0D,$0D,$16,$0D,$0D
	db $0D,$11,$11,$12,$0D,$0D,$0D,$0E
	db $0F,$0C,$0D,$0D

DATA_00F0EC:
	db $08,$01,$02,$04,$ED,$F6,$00,$7D
	db $BE,$00,$6F,$B7

DATA_00F0F8:
	db $40,$50,$00,$70,$80,$00,$A0,$B0
DATA_00F100:
	db $05,$09,$06,$05,$09,$06,$05,$09
	db $06,$05,$09,$06,$05,$09,$06,$05
	db $07,$0A,$10,$07,$0A,$10,$07,$0A
	db $10,$07,$0A,$10,$07,$0A,$10,$07

CODE_00F120:
	XBA
	LDA.w $187A				;$00F121	|
	BNE CODE_00F15F				;$00F124	|
	XBA					;$00F126	|
CODE_00F127:
	CMP.b #$2F
	BEQ CODE_00F154				;$00F129	|
	CMP.b #$59				;$00F12B	|
	BCC CODE_00F144				;$00F12D	|
	CMP.b #$5C				;$00F12F	|
	BCS CODE_00F140				;$00F131	|
	XBA					;$00F133	|
	LDA.w $1931				;$00F134	|
	CMP.b #$05				;$00F137	|
	BEQ CODE_00F154				;$00F139	|
	CMP.b #$0D				;$00F13B	|
	BEQ CODE_00F154				;$00F13D	|
	XBA					;$00F13F	|
CODE_00F140:
	CMP.b #$5D
	BCC CODE_00F14C				;$00F142	|
CODE_00F144:
	CMP.b #$66
	BCC CODE_00F160				;$00F146	|
	CMP.b #$6A				;$00F148	|
	BCS CODE_00F160				;$00F14A	|
CODE_00F14C:
	XBA
	LDA.w $1931				;$00F14D	|
	CMP.b #$01				;$00F150	|
	BNE CODE_00F15F				;$00F152	|
CODE_00F154:
	PHB
	LDA.b #$01				;$00F155	|
	PHA					;$00F157	|
	PLB					;$00F158	|
	JSL HurtMario				;$00F159	|
	PLB					;$00F15D	|
	RTL					;$00F15E	|

CODE_00F15F:
	XBA
CODE_00F160:
	SEC
	SBC.b #$11				;$00F161	|
	CMP.b #$1D				;$00F163	|
	BCC CODE_00F17F				;$00F165	|
	XBA					;$00F167	|
	PHX					;$00F168	|
	LDX.w $1931				;$00F169	|
	LDA.l DATA_00A625,X			;$00F16C	|
	PLX					;$00F170	|
	AND.b #$03				;$00F171	|
	BEQ CODE_00F176				;$00F173	|
	RTL					;$00F175	|

CODE_00F176:
	XBA
	SBC.b #$59				;$00F177	|
	CMP.b #$02				;$00F179	|
	BCS Return00F1F8			;$00F17B	|
	ADC.b #$22				;$00F17D	|
CODE_00F17F:
	PHX
	PHA					;$00F180	|
	TYX					;$00F181	|
	LDA.l DATA_00F0EC,X			;$00F182	|
	PLX					;$00F186	|
	AND.l DATA_00F0A4,X			;$00F187	|
	BEQ CODE_00F1F6				;$00F18B	|
	STY $06					;$00F18D	|
	LDA.l DATA_00F0C8,X			;$00F18F	|
	STA $07					;$00F193	|
	LDA.l DATA_00F05C,X			;$00F195	|
	STA $04					;$00F199	|
	LDA.l DATA_00F080,X			;$00F19B	|
	BPL CODE_00F1BA				;$00F19F	|
	CMP.b #$FF				;$00F1A1	|
	BNE CODE_00F1AE				;$00F1A3	|
	LDA.b #$05				;$00F1A5	|
	LDY.w $0DC0				;$00F1A7	|
	BEQ CODE_00F1D0				;$00F1AA	|
	BRA CODE_00F1CE				;$00F1AC	|

CODE_00F1AE:
	LSR
	LDA $9A					;$00F1AF	|
	ROR					;$00F1B1	|
	LSR					;$00F1B2	|
	LSR					;$00F1B3	|
	LSR					;$00F1B4	|
	TAX					;$00F1B5	|
	LDA.l DATA_00F100,X			;$00F1B6	|
CODE_00F1BA:
	LSR
	BCC CODE_00F1D0				;$00F1BB	|
	CMP.b #$03				;$00F1BD	|
	BEQ CODE_00F1C9				;$00F1BF	|
	LDY $19					;$00F1C1	|
	BNE CODE_00F1D0				;$00F1C3	|
	LDA.b #$01				;$00F1C5	|
	BRA CODE_00F1D0				;$00F1C7	|

CODE_00F1C9:
	LDY.w $1490
	BNE CODE_00F1D0				;$00F1CC	|
CODE_00F1CE:
	LDA.b #$06
CODE_00F1D0:
	STA $05
	CMP.b #$05				;$00F1D2	|
	BNE CODE_00F1DA				;$00F1D4	|
	LDA.b #$16				;$00F1D6	|
	STA $07					;$00F1D8	|
CODE_00F1DA:
	TAY
	LDA.b #$0F				;$00F1DB	|
	TRB $9A					;$00F1DD	|
	TRB $98					;$00F1DF	|
	CPY.b #$06				;$00F1E1	|
	BNE CODE_00F1EC				;$00F1E3	|
	LDY.w $1931				;$00F1E5	|
	CPY.b #$04				;$00F1E8	|
	BEQ CODE_00F1F9				;$00F1EA	|
CODE_00F1EC:
	PHB
	LDA.b #$02				;$00F1ED	|
	PHA					;$00F1EF	|
	PLB					;$00F1F0	|
	JSL CODE_028752				;$00F1F1	|
	PLB					;$00F1F5	|
CODE_00F1F6:
	PLX
	CLC					;$00F1F7	|
Return00F1F8:
	RTL

CODE_00F1F9:
	LDA $99
	LSR					;$00F1FB	|
	LDA $98					;$00F1FC	|
	AND.b #$C0				;$00F1FE	|
	ROL					;$00F200	|
	ROL					;$00F201	|
	ROL					;$00F202	|
	TAY					;$00F203	|
	LDA $9A					;$00F204	|
	LSR					;$00F206	|
	LSR					;$00F207	|
	LSR					;$00F208	|
	LSR					;$00F209	|
	TAX					;$00F20A	|
	LDA.w $13F3,Y				;$00F20B	|
	ORA.l DATA_00F0EC,X			;$00F20E	|
	LDX.w $13F3,Y				;$00F212	|
	STA.w $13F3,Y				;$00F215	|
	CMP.b #$FF				;$00F218	|
	BNE CODE_00F226				;$00F21A	|
	LDA.b #$05				;$00F21C	|
	STA $05					;$00F21E	|
CODE_00F220:
	LDA.b #$17
	STA $07					;$00F222	|
	BRA CODE_00F1EC				;$00F224	|

CODE_00F226:
	LDA.w $141B
	BNE CODE_00F236				;$00F229	|
	TXA					;$00F22B	|
	BEQ CODE_00F230				;$00F22C	|
	LDA.b #$02				;$00F22E	|
CODE_00F230:
	EOR.b #$03
	AND $13					;$00F232	|
	BNE CODE_00F220				;$00F234	|
CODE_00F236:
	LDA.b #$2A
	STA.w $1DFC				;$00F238	|
	PHY					;$00F23B	|
	STZ $05					;$00F23C	|
	PHB					;$00F23E	|
	LDA.b #$02				;$00F23F	|
	PHA					;$00F241	|
	PLB					;$00F242	|
	JSL CODE_028752				;$00F243	|
	PLB					;$00F247	|
	PLY					;$00F248	|
	LDX.b #$07				;$00F249	|
	LDA.w $13F3,Y				;$00F24B	|
CODE_00F24E:
	LSR
	BCS CODE_00F261				;$00F24F	|
	PHA					;$00F251	|
	LDA.b #$0D				;$00F252	|
	STA $9C					;$00F254	|
	LDA.l DATA_00F0F8,X			;$00F256	|
	STA $9A					;$00F25A	|
	JSL generate_tile			;$00F25C	|
	PLA					;$00F260	|
CODE_00F261:
	DEX
	BPL CODE_00F24E				;$00F262	|
	JMP CODE_00F1F6				;$00F264	|

process_throw_block:
	CPY.b #$2E				;$00F267	\ If the tile's not a throw block,
	BNE .return				;$00F269	 | return.
	BIT $16					;$00F26B	 |\ If the player didn't press X or Y,
	BVC .return				;$00F26D	 |/ return.
	LDA.w $148F				;$00F26F	 |\ If the player is already carrying something
	ORA.w $187A				;$00F272	 | | or on Yoshi,
	BNE .return				;$00F275	 |/ return.
	LDA.b #$02				;$00F277	 |\
	PHA					;$00F279	 | | Set the data bank to $02.
	PLB					;$00F27A	 | |
	JSL spawn_throw_block			;$00F27B	 | | Try to spawn a throw block.
	BMI .no_sprite_slots			;$00F27F	 |/ If there were no sprite slots, return.
	LDA.b #$02				;$00F281	 |\
	STA $9C					;$00F283	 | | Clear the tile.
	JSL generate_tile			;$00F285	 |/
.no_sprite_slots				;		 |
	PHK					;$00F289	 |
	PLB					;$00F28A	 |
.return						;		 |
	RTS					;$00F28B	/

process_center_page_0_tiles:
	TYA					;$00F28C	\
	SEC					;$00F28D	 |\
	SBC.b #$6F				;$00F28E	 | |
	CMP.b #$04				;$00F290	 | | If it's an invisible 1up point, process it.
	BCS .not_invisible_1up			;$00F292	 |/
	CMP.w $1421				;$00F294	 |\ If it is the next 1up point,
	BEQ .next_1up_point			;$00F297	 |/ increase the number of 1up points reached.
	INC A					;$00F299	 |\ If it is the current 1up point,
	CMP.w $1421				;$00F29A	 | | don't reset the sequence.
	BEQ .return				;$00F29D	 |/
	LDA.w $1421				;$00F29F	 |\ If the invisible 1up was already triggered,
	CMP.b #$04				;$00F2A2	 | | don't try to trigger it again.
	BCS .return				;$00F2A4	 |/
	LDA.b #$FF				;$00F2A6	 | Reset the 1up point sequence.
.next_1up_point					;		 |
	INC A					;$00F2A8	 |\ Increase the number of 1up points reached.
	STA.w $1421				;$00F2A9	 |/
	CMP.b #$04				;$00F2AC	 |\ If four points have been reached,
	BNE .return				;$00F2AE	 | |
	PHX					;$00F2B0	 | |
	JSL TriggerInivis1Up			;$00F2B1	 | | trigger an invisible 1up,
	JSR get_level_bit_flag			;$00F2B5	 | |
	ORA.w $1F3C,Y				;$00F2B8	 | |
	STA.w $1F3C,Y				;$00F2BB	 | | and set the "triggered invisible 1up" flag.
	PLX					;$00F2BE	 | |
.return						;		 |/
	RTS					;$00F2BF	/

.not_invisible_1up
	LDA.b #$01				;$00F2C0	\
process_page_0_tiles:				;		 |
	CPY.b #$06				;$00F2C2	 | If it's tiles 000 - 005,
	BCS process_page_0_tiles_no_swim	;$00F2C4	 |
	TSB $8A					;$00F2C6	 | set the water flag corresponding to the interaction point.
	RTS					;$00F2C8	/

process_page_0_tiles_no_swim:
	CPY.b #$38				;$00F2C9	\ If it's the midway point,
	BNE .not_midway_point			;$00F2CB	 |
	LDA.b #$02				;$00F2CD	 |
	STA $9C					;$00F2CF	 |
	JSL generate_tile			;$00F2D1	 | remove the midway point,
	JSR smoke_sparkle			;$00F2D5	 | create the sparkle effect,
	LDA.w $13CD				;$00F2D8	 |
	BEQ .no_trigger				;$00F2DB	 |
	JSR CODE_00CA2B				;$00F2DD	 | trigger the midway point,
.no_trigger					;		 |
	LDA $19					;$00F2E0	 |\
	BNE .already_big			;$00F2E2	 | |
	LDA.b #$01				;$00F2E4	 | |
	STA $19					;$00F2E6	 | | make the player big if he isn't already,
.already_big					;		 |/
	LDA.b #$05				;$00F2E8	 |\
	STA.w $1DF9				;$00F2EA	 |/ and play the midway point sound.
	RTS					;$00F2ED	/

.not_midway_point
	CPY.b #$06				;$00F2EF	\ If the tile is a vine,
	BEQ .is_vine				;$00F2F0	 |\
	CPY.b #$07				;$00F2F2	 | |
	BCC process_page_0_tiles_no_climb	;$00F2F4	 | | or it is a climbing net tile,
	CPY.b #$1D				;$00F2F6	 | |
	BCS process_page_0_tiles_no_climb	;$00F2F8	 |/
	ORA.b #$80				;$00F2FA	 | set the climbing flag.
.is_vine					;		 |
	CMP.b #$01				;$00F2FC	 |\
	BNE .not_center				;$00F2FE	 | | If interacting via the center body collision point,
	ORA.b #$18				;$00F300	 | | set a different climbing flag.
.not_center					;		 |/
	TSB $8B					;$00F302	 | Set the climbing flag corresponding to the interaction point.
	LDA $93					;$00F304	 |
	STA $8C					;$00F306	 |
	RTS					;$00F308	/

process_page_0_tiles_no_climb:
	CPY.b #$2F				;$00F309	\
	BCS .not_coin				;$00F30B	 |
	CPY.b #$2A				;$00F30D	 |
	BCS .is_coin				;$00F30F	 | Process coin code, if applicable.
.not_coin					;		 |
	CPY.b #$6E				;$00F311	 |\ If the tile is a 3up moon,
	BNE return_00F376			;$00F313	 | |
	LDA.b #$0F				;$00F315	 | |
	JSL CODE_00F38A				;$00F317	 | | give the player three lives,
	INC.w $13C5				;$00F31B	 | | increase an unused 3up moon flag,
	PHX					;$00F31E	 | |
	JSR get_level_bit_flag			;$00F31F	 | |
	ORA.w $1FEE,Y				;$00F322	 | |
	STA.w $1FEE,Y				;$00F325	 | | set the "collected 3up moon" flag,
	PLX					;$00F328	 |/
	BRA .clear_tile				;$00F329	/ and clear the tile with item memory.

.is_coin
	BNE .is_visible_coin			;$00F32B	\ If the coin is invisible
	LDA.w $14AD				;$00F32D	 | and the blue P-switch is inactive, stop.
	BEQ return_00F376			;$00F330	 |
.is_visible_coin				;		 |
	CPY.b #$2D				;$00F332	 |
	BEQ .is_upper_yoshi_coin		;$00F334	 |
	BCC .is_regular_coin			;$00F336	 | Process regular coin code if it's not a yoshi coin.
	LDA $98					;$00F338	 |\
	SEC					;$00F33A	 | |
	SBC.b #$10				;$00F33B	 | | Offset the tile Y position to erase the top half first.
	STA $98					;$00F33D	 |/
.is_upper_yoshi_coin				;		 |
	JSL give_yoshi_coin_points		;$00F33F	 | Give yoshi coin points.
	INC.w $1422				;$00F343	 |\ Increase the number of yoshi coins collected.
	LDA.w $1422				;$00F346	 | |
	CMP.b #$05				;$00F349	 | |
	BCC .not_all_collected			;$00F34B	 | | If five have been collected,
	PHX					;$00F34D	 | |
	JSR get_level_bit_flag			;$00F34E	 | |
	ORA.w $1F2F,Y				;$00F351	 | |
	STA.w $1F2F,Y				;$00F354	 | | set the "collected five yoshi coins" flag.
	PLX					;$00F357	 |/
.not_all_collected				;		 |
	LDA.b #$1C				;$00F358	 |\ Play the yoshi coin sound,
	STA.w $1DF9				;$00F35A	 |/
	LDA.b #$01				;$00F35D	 |
	JSL CODE_05B330				;$00F35F	 | give the player a coin,
	LDY.b #$18				;$00F363	 |
	BRA .remove_yoshi_coin			;$00F365	/ and remove both yoshi coin tiles.

.is_regular_coin
	JSL CODE_05B34A				;$00F367	\ Give the player a coin.
.clear_tile					;		 |
	LDY.b #$01				;$00F36B	 |
.remove_yoshi_coin				;		 |
	STY $9C					;$00F36D	 |
	JSL generate_tile			;$00F36F	 | Remove the tile with item memory,
	JSR smoke_sparkle			;$00F373	 | and create the sparkle effect.
return_00F376:					;		 |
	RTS					;$00F376	/

give_yoshi_coin_points:
	LDA.w $1420				;$00F377	\
	INC.w $1420				;$00F37A	 |
	CLC					;$00F37D	 |
	ADC.b #$09				;$00F37E	 |
	CMP.b #$0D				;$00F380	 |
	BCC .reached_maximum			;$00F382	 |
	LDA.b #$0D				;$00F384	 |
.reached_maximum				;		 |
	BRA CODE_00F38A				;$00F386	/

CODE_00F388:
	LDA.b #$0D
CODE_00F38A:
	PHA
	JSL CODE_02AD34				;$00F38B	|
	PLA					;$00F38F	|
	STA.w $16E1,Y				;$00F390	|
	LDA $94					;$00F393	|
	STA.w $16ED,Y				;$00F395	|
	LDA $95					;$00F398	|
	STA.w $16F3,Y				;$00F39A	|
	LDA $96					;$00F39D	|
	STA.w $16E7,Y				;$00F39F	|
	LDA $97					;$00F3A2	|
	STA.w $16F9,Y				;$00F3A4	|
	LDA.b #$30				;$00F3A7	|
	STA.w $16FF,Y				;$00F3A9	|
	LDA.b #$00				;$00F3AC	|
	STA.w $1705,Y				;$00F3AE	|
	RTL					;$00F3B1	|

get_level_bit_flag:
	LDA.w $13BF				;$00F3B2	\ Load the current level,
	LSR					;$00F3B5	 |
	LSR					;$00F3B6	 |
	LSR					;$00F3B7	 | and divide by 8 for the index to the level bit flag table.
	TAY					;$00F3B8	 |
	LDA.w $13BF				;$00F3B9	 | Load the current level,
	AND.b #$07				;$00F3BC	 |
	TAX					;$00F3BE	 |
	LDA.l level_bit_masks,X			;$00F3BF	 | and get the bit mask for the level bit flag table.
	RTS					;$00F3C3	/

process_horizontal_pipe:
	CPY.b #$3F				;$00F3C4	\
	BNE return_00F376			;$00F3C6	 | If it's not a exit-enabled horizontal pipe, return.
	LDY $8F					;$00F3C8	 |
	BEQ CODE_00F3CF				;$00F3CA	 |
	JMP CODE_00F43F				;$00F3CC	/

CODE_00F3CF:
	PHX
	TAX					;$00F3D0	|
	LDA $94					;$00F3D1	|
	TXY					;$00F3D3	|
	BEQ CODE_00F3D9				;$00F3D4	|
	EOR.b #$FF				;$00F3D6	|
	INC A					;$00F3D8	|
CODE_00F3D9:
	AND.b #$0F
	ASL					;$00F3DB	|
	CLC					;$00F3DC	|
	ADC.b #$20				;$00F3DD	|
	LDY.b #$05				;$00F3DF	|
	BRA CODE_00F40A				;$00F3E1	|

DATA_00F3E3:
	db $0A,$FF

DATA_00F3E5:
	db $02,$01,$08,$04

CODE_00F3E9:
	XBA
	TYA					;$00F3EA	|
	SEC					;$00F3EB	|
	SBC.b #$37				;$00F3EC	|
	CMP.b #$02				;$00F3EE	|
	BCS Return00F442			;$00F3F0	|
	TAY					;$00F3F2	|
	LDA $92					;$00F3F3	|
	SBC.w DATA_00F3E3,Y			;$00F3F5	|
	CMP.b #$05				;$00F3F8	|
	BCS CODE_00F43F				;$00F3FA	|
	PHX					;$00F3FC	|
	XBA					;$00F3FD	|
	TAX					;$00F3FE	|
	LDA.b #$20				;$00F3FF	|
	LDY.w $187A				;$00F401	|
	BEQ CODE_00F408				;$00F404	|
	LDA.b #$30				;$00F406	|
CODE_00F408:
	LDY.b #$06
CODE_00F40A:
	STA $88
	LDA $15					;$00F40C	|
	AND.w DATA_00F3E5,X			;$00F40E	|
	BEQ CODE_00F43E				;$00F411	|
	STA $9D					;$00F413	|
	AND.b #$01				;$00F415	|
	STA $76					;$00F417	|
	STX $89					;$00F419	|
	TXA					;$00F41B	|
	LSR					;$00F41C	|
	TAX					;$00F41D	|
	BNE CODE_00F430				;$00F41E	|
	LDA.w $148F				;$00F420	|
	BEQ CODE_00F430				;$00F423	|
	LDA $76					;$00F425	|
	EOR.b #$01				;$00F427	|
	STA $76					;$00F429	|
	LDA.b #$08				;$00F42B	|
	STA.w $1499				;$00F42D	|
CODE_00F430:
	INX
	STX.w $1419				;$00F431	|
	STY $71					;$00F434	|
	JSR disable_controls			;$00F436	|
	LDA.b #$04				;$00F439	|
	STA.w $1DF9				;$00F43B	|
CODE_00F43E:
	PLX
CODE_00F43F:
	LDY.w $1693
Return00F442:
	RTS

can_use_door:
	LDA $94					;$00F443	|
	CLC					;$00F445	|
	ADC.b #$04				;$00F446	|
	AND.b #$0F				;$00F448	|
	CMP.b #$08				;$00F44A	|
	RTS					;$00F44C	|

process_collision_point:
	INX					;$00F44D	\ Prepare to process the next player collision point.
	INX					;$00F44E	 |
	REP #$20				;$00F44F	 |\ Enable 16 bit A.
	LDA $94					;$00F451	 | | Get the player's X position,
	CLC					;$00F453	 | |
	ADC.w collision_x_offsets-2,X		;$00F454	 | | add the collision X offset,
	STA $9A					;$00F457	 |/ and set that as the collision X to process.
	LDA $96					;$00F459	 |\ Get the player's Y position,
	CLC					;$00F45B	 | |
	ADC.w collision_y_offsets-2,X		;$00F45C	 | | add the collision Y offset,
	STA $98					;$00F45F	 |/ and set that as the collision Y to process.
process_collision:				;		/
	JSR collision				;$00F461	| Process collision.
	RTS					;$00F464	|

collision:
	SEP #$20				;$00F465	\ Enable 8 bit A.
	STZ.w $1423				;$00F467	 | Clear switch palace switch flag.
	PHX					;$00F46A	 | Preserve collision point index.
	LDA $8E					;$00F46B	 |
	BPL .not_layer_2			;$00F46D	 |
	JMP .layer_2				;$00F46F	/ Process layer 2 collision, if applicable.

.not_layer_2
	BNE .vertical_level			;$00F472	| Process vertical level collision, if applicable.
	REP #$20				;$00F474	\
	LDA $98					;$00F476	 |
	CMP.w #$01B0				;$00F478	 | If collision Y > $01B0,
	SEP #$20				;$00F47B	 |
	BCS .air_tile				;$00F47D	 | act like air.
	AND.b #$F0				;$00F47F	 |\
	STA $00					;$00F481	 | | Set the upper nybble of map16 table index.
	LDX $9B					;$00F483	 | |
	CPX $5D					;$00F485	 | | If collision X > end of level,
	BCS .air_tile				;$00F487	 | | act like air.
	LDA $9A					;$00F489	 | | Get collision X,
	LSR					;$00F48B	 | |
	LSR					;$00F48C	 | |
	LSR					;$00F48D	 | |
	LSR					;$00F48E	 | | divide by 16,
	ORA $00					;$00F48F	 | | and set the lower nybble of map16 table index.
	CLC					;$00F491	 | |
	ADC.l DATA_00BA60,X			;$00F492	 | |
	STA $00					;$00F496	 | |
	LDA $99					;$00F498	 | |
	ADC.l DATA_00BA9C,X			;$00F49A	 |/ Add by $C800 + $01B0 * screen number for map16 pointer.
	BRA .process_map16			;$00F49E	/ Process map16.

.air_tile
	PLX					;$00F4A0	\ Restore collision point index.
	LDY.b #$25				;$00F4A1	 | Set the low byte to $25,
.high_byte_00					;		 |
	LDA.b #$00				;$00F4A3	 | and set the high byte to $00.
	RTS					;$00F4A5	/

.vertical_level
	LDA $9B					;$00F4A6	\
	CMP.b #$02				;$00F4A8	 | If collision X > $0200,
	BCS .air_tile_2				;$00F4AA	 | act like air.
	LDX $99					;$00F4AC	 |
	CPX $5D					;$00F4AE	 | If collision Y > end of level,
	BCS .air_tile_2				;$00F4B0	 | act like air.
	LDA $98					;$00F4B2	 |\
	AND.b #$F0				;$00F4B4	 | |
	STA $00					;$00F4B6	 | | Set the upper nybble of map16 table index.
	LDA $9A					;$00F4B8	 | | Get collision X,
	LSR					;$00F4BA	 | |
	LSR					;$00F4BB	 | |
	LSR					;$00F4BC	 | |
	LSR					;$00F4BD	 | | divide by 16,
	ORA $00					;$00F4BE	 | | and set the lower nybble of map16 table index.
	CLC					;$00F4C0	 | |
	ADC.l DATA_00BA80,X			;$00F4C1	 | |
	STA $00					;$00F4C5	 | |
	LDA $9B					;$00F4C7	 | |
	ADC.l DATA_00BABC,X			;$00F4C9	 |/ Add by $C800 + $0200 * screen number for map16 pointer.
.process_map16					;		 |
	STA $01					;$00F4CD	 |\ Set pointer to map16 low byte table,
	LDA.b #$7E				;$00F4CF	 | |
	STA $02					;$00F4D1	 |/
	LDA [$00]				;$00F4D3	 |\ set $1693 to low byte of map16 tile,
	STA.w $1693				;$00F4D5	 |/
	INC $02					;$00F4D8	 | and set pointer to map16 high byte table.
	PLX					;$00F4DA	 | Restore collision point index.
	LDA [$00]				;$00F4DB	 |
	JSL conditional_map16			;$00F4DD	 | Process "conditional" map16.
	LDY.w $1693				;$00F4E1	 | Set Y to low byte of map16 tile,
	CMP.b #$00				;$00F4E4	 | and check if high byte is $00.
	RTS					;$00F4E6	/

.air_tile_2
	PLX					;$00F4E7	\ Restore collision point index.
	LDY.b #$25				;$00F4E8	 | Set the low byte to $25,
	BRA .high_byte_00			;$00F4EA	/ and set the high byte to $00.

.layer_2
	ASL					;$00F4EC	|
	BNE .vertical_layer_2			;$00F4ED	| Process vertical layer 2 collision, if applicable.
	REP #$20				;$00F4EF	 \
	LDA $98					;$00F4F1	 |
	CMP.w #$01B0				;$00F4F3	 | If collision Y > $01B0,
	SEP #$20				;$00F4F6	 |
	BCS .air_tile_2				;$00F4F8	 | act like air.
	AND.b #$F0				;$00F4FA	 |\
	STA $00					;$00F4FC	 | | Set the upper nybble of map16 table index.
	LDX $9B					;$00F4FE	 | |
	CPX.b #$10				;$00F500	 | | If collision X > end of level,
	BCS .air_tile_2				;$00F502	 | | act like air.
	LDA $9A					;$00F504	 | | Get collision X,
	LSR					;$00F506	 | |
	LSR					;$00F507	 | |
	LSR					;$00F508	 | |
	LSR					;$00F509	 | | divide by 16,
	ORA $00					;$00F50A	 | | and set the lower nybble of map16 table index
	CLC					;$00F50C	 | |
	ADC.l DATA_00BA70,X			;$00F50D	 | |
	STA $00					;$00F511	 | |
	LDA $99					;$00F513	 | |
	ADC.l DATA_00BAAC,X			;$00F515	 |/ Add by $C800 + $1B0 * (screen number + $10) for map16 pointer.
	BRA .process_map16			;$00F519	/ Process map16.

.vertical_layer_2
	LDA $9B					;$00F51B	\
	CMP.b #$02				;$00F51D	 | If collision X > $0200,
	BCS .air_tile_2				;$00F51F	 | act like air.
	LDX $99					;$00F521	 |
	CPX.b #$0E				;$00F523	 | If collision Y > $0E00,
	BCS .air_tile_2				;$00F525	 | act like air.
	LDA $98					;$00F527	 |\
	AND.b #$F0				;$00F529	 | |
	STA $00					;$00F52B	 | | Set the upper nybble of map16 table index.
	LDA $9A					;$00F52D	 | | Get collision X,
	LSR					;$00F52F	 | |
	LSR					;$00F530	 | |
	LSR					;$00F531	 | |
	LSR					;$00F532	 | | divide by 16,
	ORA $00					;$00F533	 | | and set the lower nybble of map16 table index.
	CLC					;$00F535	 | |
	ADC.l DATA_00BA8E,X			;$00F536	 | |
	STA $00					;$00F53A	 | |
	LDA $9B					;$00F53C	 | |
	ADC.l DATA_00BACA,X			;$00F53E	 |/ Add by $C800 + $200 * (screen number + $10) for map16 pointer.
	JMP .process_map16			;$00F542	/ Process map16.

conditional_map16:
	TAY					;$00F545	\ If map16 page != 0,
	BNE .map16_page_01			;$00F546	 | process map16 page 1 code.
	LDY.w $1693				;$00F548	 |
	CPY.b #$29				;$00F54B	 | If it's an invisible ? block
	BNE .not_029				;$00F54D	 | 
	LDY.w $14AD				;$00F54F	 | and the blue P-switch is active,
	BEQ .return				;$00F552	 |
	LDA.b #$24				;$00F554	 |
	STA.w $1693				;$00F556	 | act like a real ? block.
	RTL					;$00F559	/

.not_029
	CPY.b #$2B				;$00F55A	\
	BEQ .is_02B				;$00F55C	 |
	TYA					;$00F55E	 |
	SEC					;$00F55F	 |
	SBC.b #$EC				;$00F560	 |
	CMP.b #$10				;$00F562	 | If it's a switch palace switch,
	BCS .not_switch				;$00F564	 |
	INC A					;$00F566	 |
	STA.w $1423				;$00F567	 | set the switch palace flag,
	BRA .act_like_used_block		;$00F56A	/ and act like a used block.

.is_02B
	LDY.w $14AD				;$00F56C	\ If it's a coin and the blue P-switch is active,
	BEQ .return				;$00F56F	 |
.act_like_used_block				;		 |
	LDA.b #$32				;$00F571	 |
	STA.w $1693				;$00F573	 | act like a used block.
	RTL					;$00F576	/

.map16_page_01
	LDY.w $1693				;$00F577	\
	CPY.b #$32				;$00F57A	 | If it's a used block
	BNE .not_132				;$00F57C	 |
	LDY.w $14AD				;$00F57E	 | and the blue P-switch is active,
	BNE .act_like_coin			;$00F581	 | act like a coin.
	RTL					;$00F583	/

.not_132
	CPY.b #$2F				;$00F584	\ If it's a muncher
	BNE .return				;$00F586	 |
	LDY.w $14AE				;$00F588	 | and the silver P-switch is active,
	BEQ .return				;$00F58B	 |
.act_like_coin					;		 |
	LDY.b #$2B				;$00F58D	 |
	STY.w $1693				;$00F58F	 | act like a coin.
.not_switch					;		 |
	LDA.b #$00				;$00F592	 | Set map16 page 0.
.return						;		 |
	RTL					;$00F594	/

check_y_position:
	REP #$20				;$00F595	\
	LDA.w #$FF80				;$00F597	 |\ If the player is more than 32 pixels above the
	CLC					;$00F59A	 | | Y position of layer 1,
	ADC $1C					;$00F59B	 | |
	CMP $96					;$00F59D	 | |
	BMI .below_y_position_limit		;$00F59F	 | |
	STA $96					;$00F5A1	 | | keep the player at that level.
.below_y_position_limit				;		 |/
	SEP #$20				;$00F5A3	 |
	LDA $81					;$00F5A5	 |\ If the player is below the screen,
	DEC A					;$00F5A7	 | |
	BMI .return				;$00F5A8	 | |
	LDA.w $1B95				;$00F5AA	 | | and it's a Yoshi wing level,
	BEQ .kill				;$00F5AD	 | |
	JMP CODE_00C95B				;$00F5AF	 |/ exit and clear the level.

.kill
	JSL kill_player_no_speed		;$00F5B2	 | Otherwise, kill the player without throwing him upwards.
.return
	RTS					;		/

HurtMario:
	LDA $71
	BNE Return00F628			;$00F5B9	|
	LDA.w $1497				;$00F5BB	|
	ORA.w $1490				;$00F5BE	|
	ORA.w $1493				;$00F5C1	|
	BNE Return00F628			;$00F5C4	|
	STZ.w $18E3				;$00F5C6	|
	LDA.w $13E3				;$00F5C9	|
	BEQ CODE_00F5D5				;$00F5CC	|
	PHB					;$00F5CE	|
	PHK					;$00F5CF	|
	PLB					;$00F5D0	|
	JSR fall_off_wall			;$00F5D1	|
	PLB					;$00F5D4	|
CODE_00F5D5:
	LDA $19
	BEQ kill_player				;$00F5D7	|
	CMP.b #$02				;$00F5D9	|
	BNE PowerDown				;$00F5DB	|
	LDA.w $1407				;$00F5DD	|
	BEQ PowerDown				;$00F5E0	|
CancelSoaring:
	LDY.b #$0F
	STY.w $1DF9				;$00F5E4	|
	LDA.b #$01				;$00F5E7	|
	STA.w $140D				;$00F5E9	|
	LDA.b #$30				;$00F5EC	|
	STA.w $1497				;$00F5EE	|
	BRA CODE_00F622				;$00F5F1	|

PowerDown:
	LDY.b #$04
	STY.w $1DF9				;$00F5F5	|
	JSL CODE_028008				;$00F5F8	|
	LDA.b #$01				;$00F5FC	|
	STA $71					;$00F5FE	|
	STZ $19					;$00F600	|
	LDA.b #$2F				;$00F602	|
	BRA CODE_00F61D				;$00F604	|

kill_player:					;		\
	LDA.b #$90				;$00F606	 |\ Throw the player up.
	STA $7D					;$00F608	 |/
kill_player_no_speed:				;		 |
	LDA.b #$09				;$00F60A	 |\ Play the death music.
	STA.w $1DFB				;$00F60C	 |/
	LDA.b #$FF				;$00F60F	 |
	STA.w $0DDA				;$00F611	 |
	LDA.b #$09				;$00F614	 |\ Set the player death animation.
	STA $71					;$00F616	 |/
	STZ.w $140D				;$00F618	 | Disable spin jumping.
	LDA.b #$30				;$00F61B	 |\
CODE_00F61D:					;		 | | Set the player animation timer
	STA.w $1496				;$00F61D	 | | and the sprite lock timer.
	STA $9D					;$00F620	 |/
CODE_00F622:					;		 |
	STZ.w $1407				;$00F622	 | Stop flying.
	STZ.w $188A				;$00F625	 |
Return00F628:					;		 |
	RTL					;$00F628	/

CODE_00F629:
	JSL kill_player
disable_controls:
	STZ $15
	STZ $16					;$00F62F	|
	STZ $17					;$00F631	|
	STZ $18					;$00F633	|
	RTS					;$00F635	|

CODE_00F636:
	REP #$20
	LDX.b #$00				;$00F638	|
	LDA $09					;$00F63A	|
	ORA.w #$0800				;$00F63C	|
	CMP $09					;$00F63F	|
	BEQ CODE_00F644				;$00F641	|
	CLC					;$00F643	|
CODE_00F644:
	AND.w #$F700
	ROR					;$00F647	|
	LSR					;$00F648	|
	ADC.w #$2000				;$00F649	|
	STA.w $0D85				;$00F64C	|
	CLC					;$00F64F	|
	ADC.w #$0200				;$00F650	|
	STA.w $0D8F				;$00F653	|
	LDX.b #$00				;$00F656	|
	LDA $0A					;$00F658	|
	ORA.w #$0800				;$00F65A	|
	CMP $0A					;$00F65D	|
	BEQ CODE_00F662				;$00F65F	|
	CLC					;$00F661	|
CODE_00F662:
	AND.w #$F700
	ROR					;$00F665	|
	LSR					;$00F666	|
	ADC.w #$2000				;$00F667	|
	STA.w $0D87				;$00F66A	|
	CLC					;$00F66D	|
	ADC.w #$0200				;$00F66E	|
	STA.w $0D91				;$00F671	|
	LDA $0B					;$00F674	|
	AND.w #$FF00				;$00F676	|
	LSR					;$00F679	|
	LSR					;$00F67A	|
	LSR					;$00F67B	|
	ADC.w #$2000				;$00F67C	|
	STA.w $0D89				;$00F67F	|
	CLC					;$00F682	|
	ADC.w #$0200				;$00F683	|
	STA.w $0D93				;$00F686	|
	LDA $0C					;$00F689	|
	AND.w #$FF00				;$00F68B	|
	LSR					;$00F68E	|
	LSR					;$00F68F	|
	LSR					;$00F690	|
	ADC.w #$2000				;$00F691	|
	STA.w $0D99				;$00F694	|
	SEP #$20				;$00F697	|
	LDA.b #$0A				;$00F699	|
	STA.w $0D84				;$00F69B	|
	RTS					;$00F69E	|

DATA_00F69F:
	db $64,$00,$7C,$00

DATA_00F6A3:
	db $00,$00,$FF,$FF

DATA_00F6A7:
	db $FD,$FF,$05,$00,$FA,$FF

DATA_00F6AD:
	db $00,$00,$00,$00,$C0,$00

DATA_00F6B3:
	db $90,$00,$60,$00,$00,$00,$00,$00
	db $00,$00,$00,$00

DATA_00F6BF:
	db $00,$00,$FE,$FF,$02,$00,$00,$00
	db $FE,$FF,$02,$00

DATA_00F6CB:
	db $00,$00,$20,$00

DATA_00F6CF:
	db $D0,$00,$00,$00,$20,$00,$D0,$00
	db $01,$00,$FF,$FF

CODE_00F6DB:
	PHB
	PHK					;$00F6DC	|
	PLB					;$00F6DD	|
	REP #$20				;$00F6DE	|
	LDA.w $142A				;$00F6E0	|
	SEC					;$00F6E3	|
	SBC.w #$000C				;$00F6E4	|
	STA.w $142C				;$00F6E7	|
	CLC					;$00F6EA	|
	ADC.w #$0018				;$00F6EB	|
	STA.w $142E				;$00F6EE	|
	LDA.w $1462				;$00F6F1	|
	STA $1A					;$00F6F4	|
	LDA.w $1464				;$00F6F6	|
	STA $1C					;$00F6F9	|
	LDA.w $1466				;$00F6FB	|
	STA $1E					;$00F6FE	|
	LDA.w $1468				;$00F700	|
	STA $20					;$00F703	|
	LDA $5B					;$00F705	|
	LSR					;$00F707	|
	BCC CODE_00F70D				;$00F708	|
	JMP CODE_00F75C				;$00F70A	|

CODE_00F70D:
	LDA.w #$00C0
	JSR CODE_00F7F4				;$00F710	|
	LDY.w $1411				;$00F713	|
	BEQ CODE_00F75A				;$00F716	|
	LDY.b #$02				;$00F718	|
	LDA $94					;$00F71A	|
	SEC					;$00F71C	|
	SBC $1A					;$00F71D	|
	STA $00					;$00F71F	|
	CMP.w $142A				;$00F721	|
	BPL CODE_00F728				;$00F724	|
	LDY.b #$00				;$00F726	|
CODE_00F728:
	STY $55
	STY $56					;$00F72A	|
	SEC					;$00F72C	|
	SBC.w $142C,Y				;$00F72D	|
	BEQ CODE_00F75A				;$00F730	|
	STA $02					;$00F732	|
	EOR.w DATA_00F6A3,Y			;$00F734	|
	BPL CODE_00F75A				;$00F737	|
	JSR CODE_00F8AB				;$00F739	|
	LDA $02					;$00F73C	|
	CLC					;$00F73E	|
	ADC $1A					;$00F73F	|
	BPL CODE_00F746				;$00F741	|
	LDA.w #$0000				;$00F743	|
CODE_00F746:
	STA $1A
	LDA $5E					;$00F748	|
	DEC A					;$00F74A	|
	XBA					;$00F74B	|
	AND.w #$FF00				;$00F74C	|
	BPL CODE_00F754				;$00F74F	|
	LDA.w #$0080				;$00F751	|
CODE_00F754:
	CMP $1A
	BPL CODE_00F75A				;$00F756	|
	STA $1A					;$00F758	|
CODE_00F75A:
	BRA CODE_00F79D

CODE_00F75C:
	LDA $5F
	DEC A					;$00F75E	|
	XBA					;$00F75F	|
	AND.w #$FF00				;$00F760	|
	JSR CODE_00F7F4				;$00F763	|
	LDY.w $1411				;$00F766	|
	BEQ CODE_00F79D				;$00F769	|
	LDY.b #$00				;$00F76B	|
	LDA $94					;$00F76D	|
	SEC					;$00F76F	|
	SBC $1A					;$00F770	|
	STA $00					;$00F772	|
	CMP.w $142A				;$00F774	|
	BMI CODE_00F77B				;$00F777	|
	LDY.b #$02				;$00F779	|
CODE_00F77B:
	SEC
	SBC.w $142C,Y				;$00F77C	|
	STA $02					;$00F77F	|
	EOR.w DATA_00F6A3,Y			;$00F781	|
	BPL CODE_00F79D				;$00F784	|
	JSR CODE_00F8AB				;$00F786	|
	LDA $02					;$00F789	|
	CLC					;$00F78B	|
	ADC $1A					;$00F78C	|
	BPL CODE_00F793				;$00F78E	|
	LDA.w #$0000				;$00F790	|
CODE_00F793:
	CMP.w #$0101
	BMI CODE_00F79B				;$00F796	|
	LDA.w #$0100				;$00F798	|
CODE_00F79B:
	STA $1A
CODE_00F79D:
	LDY.w $1413
	BEQ CODE_00F7AA				;$00F7A0	|
	LDA $1A					;$00F7A2	|
	DEY					;$00F7A4	|
	BEQ CODE_00F7A8				;$00F7A5	|
	LSR					;$00F7A7	|
CODE_00F7A8:
	STA $1E
CODE_00F7AA:
	LDY.w $1414
	BEQ CODE_00F7C2				;$00F7AD	|
	LDA $1C					;$00F7AF	|
	DEY					;$00F7B1	|
	BEQ CODE_00F7BC				;$00F7B2	|
	LSR					;$00F7B4	|
	DEY					;$00F7B5	|
	BEQ CODE_00F7BC				;$00F7B6	|
	LSR					;$00F7B8	|
	LSR					;$00F7B9	|
	LSR					;$00F7BA	|
	LSR					;$00F7BB	|
CODE_00F7BC:
	CLC
	ADC.w $1417				;$00F7BD	|
	STA $20					;$00F7C0	|
CODE_00F7C2:
	SEP #$20
	LDA $1A					;$00F7C4	|
	SEC					;$00F7C6	|
	SBC.w $1462				;$00F7C7	|
	STA.w $17BD				;$00F7CA	|
	LDA $1C					;$00F7CD	|
	SEC					;$00F7CF	|
	SBC.w $1464				;$00F7D0	|
	STA.w $17BC				;$00F7D3	|
	LDA $1E					;$00F7D6	|
	SEC					;$00F7D8	|
	SBC.w $1466				;$00F7D9	|
	STA.w $17BF				;$00F7DC	|
	LDA $20					;$00F7DF	|
	SEC					;$00F7E1	|
	SBC.w $1468				;$00F7E2	|
	STA.w $17BE				;$00F7E5	|
	LDX.b #$07				;$00F7E8	|
CODE_00F7EA:
	LDA $1A,X
	STA.w $1462,X				;$00F7EC	|
	DEX					;$00F7EF	|
	BPL CODE_00F7EA				;$00F7F0	|
	PLB					;$00F7F2	|
	RTL					;$00F7F3	|

CODE_00F7F4:
	LDX.w $1412
	BNE CODE_00F7FA				;$00F7F7	|
	RTS					;$00F7F9	|

CODE_00F7FA:
	STA $04
	LDY.b #$00				;$00F7FC	|
	LDA $96					;$00F7FE	|
	SEC					;$00F800	|
	SBC $1C					;$00F801	|
	STA $00					;$00F803	|
	CMP.w #$0070				;$00F805	|
	BMI CODE_00F80C				;$00F808	|
	LDY.b #$02				;$00F80A	|
CODE_00F80C:
	STY $55
	STY $56					;$00F80E	|
	SEC					;$00F810	|
	SBC.w DATA_00F69F,Y			;$00F811	|
	STA $02					;$00F814	|
	EOR.w DATA_00F6A3,Y			;$00F816	|
	BMI CODE_00F81F				;$00F819	|
	LDY.b #$02				;$00F81B	|
	STZ $02					;$00F81D	|
CODE_00F81F:
	LDA $02
	BMI CODE_00F82A				;$00F821	|
	LDX.b #$00				;$00F823	|
	STX.w $1404				;$00F825	|
	BRA CODE_00F883				;$00F828	|

CODE_00F82A:
	SEP #$20
	LDA.w $13E3				;$00F82C	|
	CMP.b #$06				;$00F82F	|
	BCS CODE_00F845				;$00F831	|
	LDA.w $1410				;$00F833	|
	LSR					;$00F836	|
	ORA.w $149F				;$00F837	|
	ORA $74					;$00F83A	|
	ORA.w $13F3				;$00F83C	|
	ORA.w $18C2				;$00F83F	|
	ORA.w $1406				;$00F842	|
CODE_00F845:
	TAX
	REP #$20				;$00F846	|
	BNE CODE_00F869				;$00F848	|
	LDX.w $187A				;$00F84A	|
	BEQ CODE_00F856				;$00F84D	|
	LDX.w $141E				;$00F84F	|
	CPX.b #$02				;$00F852	|
	BCS CODE_00F869				;$00F854	|
CODE_00F856:
	LDX $75
	BEQ CODE_00F85E				;$00F858	|
	LDX $72					;$00F85A	|
	BNE CODE_00F869				;$00F85C	|
CODE_00F85E:
	LDX.w $1412
	DEX					;$00F861	|
	BEQ CODE_00F875				;$00F862	|
	LDX.w $13F1				;$00F864	|
	BNE CODE_00F875				;$00F867	|
CODE_00F869:
	STX.w $13F1
	LDX.w $13F1				;$00F86C	|
	BNE CODE_00F881				;$00F86F	|
	LDY.b #$04				;$00F871	|
	BRA CODE_00F881				;$00F873	|

CODE_00F875:
	LDX.w $1404
	BNE CODE_00F881				;$00F878	|
	LDX $72					;$00F87A	|
	BNE Return00F8AA			;$00F87C	|
	INC.w $1404				;$00F87E	|
CODE_00F881:
	LDA $02
CODE_00F883:
	SEC
	SBC.w DATA_00F6A7,Y			;$00F884	|
	EOR.w DATA_00F6A7,Y			;$00F887	|
	ASL					;$00F88A	|
	LDA $02					;$00F88B	|
	BCS CODE_00F892				;$00F88D	|
	LDA.w DATA_00F6A7,Y			;$00F88F	|
CODE_00F892:
	CLC
	ADC $1C					;$00F893	|
	CMP.w DATA_00F6AD,Y			;$00F895	|
	BPL CODE_00F89D				;$00F898	|
	LDA.w DATA_00F6AD,Y			;$00F89A	|
CODE_00F89D:
	STA $1C
	LDA $04					;$00F89F	|
	CMP $1C					;$00F8A1	|
	BPL Return00F8AA			;$00F8A3	|
	STA $1C					;$00F8A5	|
	STZ.w $13F1				;$00F8A7	|
Return00F8AA:
	RTS

CODE_00F8AB:
	LDY.w $13FD
	BNE Return00F8DE			;$00F8AE	|
	SEP #$20				;$00F8B0	|
	LDX.w $13FF				;$00F8B2	|
	REP #$20				;$00F8B5	|
	LDY.b #$08				;$00F8B7	|
	LDA.w $142A				;$00F8B9	|
	CMP.w DATA_00F6B3,X			;$00F8BC	|
	BPL CODE_00F8C3				;$00F8BF	|
	LDY.b #$0A				;$00F8C1	|
CODE_00F8C3:
	LDA.w DATA_00F6BF,Y
	EOR $02					;$00F8C6	|
	BPL Return00F8DE			;$00F8C8	|
	LDA.w DATA_00F6BF,X			;$00F8CA	|
	EOR $02					;$00F8CD	|
	BPL Return00F8DE			;$00F8CF	|
	LDA $02					;$00F8D1	|
	CLC					;$00F8D3	|
	ADC.w DATA_00F6CF,Y			;$00F8D4	|
	BEQ Return00F8DE			;$00F8D7	|
	STA $02					;$00F8D9	|
	STY.w $1400				;$00F8DB	|
Return00F8DE:
	RTS

DATA_00F8DF:
	db $0C,$0C,$08,$00,$20,$04,$0A,$0D
	db $0D

boss_ceiling_height:
	db $2A,$00,$2A,$00,$12,$00,$00,$00
	db $ED,$FF

boss_room_collision:
	JSR reset_collision_flags		;$00F8F2	|
	BIT.w $0D9B				;$00F8F5	|
	BVC CODE_00F94E				;$00F8F8	|
	JSR level_collision			;$00F8FA	|
	LDA.w $13FC				;$00F8FD	|
	ASL					;$00F900	|
	TAX					;$00F901	|
	PHX					;$00F902	|
	LDY $7D					;$00F903	|
	BPL CODE_00F91E				;$00F905	|
	REP #$20				;$00F907	|
	LDA $96					;$00F909	|
	CMP.w boss_ceiling_height,X		;$00F90B	|
	BPL CODE_00F91E				;$00F90E	|
	LDA.w boss_ceiling_height,X		;$00F910	|
	STA $96					;$00F913	|
	SEP #$20				;$00F915	|
	STZ $7D					;$00F917	|
	LDA.b #$01				;$00F919	|
	STA.w $1DF9				;$00F91B	|
CODE_00F91E:
	SEP #$20
	PLX					;$00F920	|
	LDA.w boss_ceiling_height,X		;$00F921	|
	CMP.b #$2A				;$00F924	|
	BNE Return00F94D			;$00F926	|
	REP #$20				;$00F928	|
	LDY.b #$00				;$00F92A	|
	LDA.w $1617				;$00F92C	|
	AND.w #$00FF				;$00F92F	|
	INC A					;$00F932	|
	CMP $94					;$00F933	|
	BEQ CODE_00F94A				;$00F935	|
	BMI CODE_00F94A				;$00F937	|
	LDA.w $153D				;$00F939	|
	AND.w #$00FF				;$00F93C	|
	STA $00					;$00F93F	|
	INY					;$00F941	|
	LDA $94					;$00F942	|
	CLC					;$00F944	|
	ADC.w #$000F				;$00F945	|
	CMP $00					;$00F948	|
CODE_00F94A:
	JMP CODE_00E9C8

Return00F94D:
	RTS

CODE_00F94E:
	LDY.b #$00
	LDA $7D					;$00F950	|
	BPL CODE_00F957				;$00F952	|
	JMP CODE_00F997				;$00F954	|

CODE_00F957:
	JSR CODE_00F9A8
	BCS CODE_00F962				;$00F95A	|
	JSR CODE_00EE1D				;$00F95C	|
	JMP CODE_00F997				;$00F95F	|

CODE_00F962:
	LDA $72
	BEQ CODE_00F983				;$00F964	|
	REP #$20				;$00F966	|
	LDA.w $14B8				;$00F968	|
	AND.w #$00FF				;$00F96B	|
	STA.w $14B4				;$00F96E	|
	STA.w $1436				;$00F971	|
	LDA.w $14BA				;$00F974	|
	AND.w #$00F0				;$00F977	|
	STA.w $14B6				;$00F97A	|
	STA.w $1438				;$00F97D	|
	JSR boss_platform_collision		;$00F980	|
CODE_00F983:
	LDA $36
	CLC					;$00F985	|
	ADC.b #$48				;$00F986	|
	LSR					;$00F988	|
	LSR					;$00F989	|
	LSR					;$00F98A	|
	LSR					;$00F98B	|
	TAX					;$00F98C	|
	LDY.w DATA_00F8DF,X			;$00F98D	|
	LDA.b #$80				;$00F990	|
	STA $8E					;$00F992	|
	JSR CODE_00EEE1				;$00F994	|
CODE_00F997:
	REP #$20
	LDA $80					;$00F999	|
	CMP.w #$00AE				;$00F99B	|
	SEP #$20				;$00F99E	|
	BMI CODE_00F9A5				;$00F9A0	|
	JSR CODE_00F629				;$00F9A2	|
CODE_00F9A5:
	JMP no_layer_collision

CODE_00F9A8:
	REP #$20
	LDA $94					;$00F9AA	|
	CLC					;$00F9AC	|
	ADC.w #$0008				;$00F9AD	|
	STA.w $14B4				;$00F9B0	|
	LDA $96					;$00F9B3	|
	CLC					;$00F9B5	|
	ADC.w #$0020				;$00F9B6	|
	STA.w $14B6				;$00F9B9	|
CODE_00F9BC:
	SEP #$20
	PHB					;$00F9BE	|
	LDA.b #$01				;$00F9BF	|
	PHA					;$00F9C1	|
	PLB					;$00F9C2	|
	JSL CODE_01CC9D				;$00F9C3	|
	PLB					;$00F9C7	|
	RTS					;$00F9C8	|

boss_platform_collision:
	LDA $36					;$00F9C9	|
	PHA					;$00F9CB	|
	EOR.w #$FFFF				;$00F9CC	|
	INC A					;$00F9CF	|
	STA $36					;$00F9D0	|
	JSR CODE_00F9BC				;$00F9D2	|
	REP #$20				;$00F9D5	|
	PLA					;$00F9D7	|
	STA $36					;$00F9D8	|
	LDA.w $14B8				;$00F9DA	|
	AND.w #$00FF				;$00F9DD	|
	SEC					;$00F9E0	|
	SBC.w #$0008				;$00F9E1	|
	STA $94					;$00F9E4	|
	LDA.w $14BA				;$00F9E6	|
	AND.w #$00FF				;$00F9E9	|
	SEC					;$00F9EC	|
	SBC.w #$0020				;$00F9ED	|
	STA $96					;$00F9F0	|
	SEP #$20				;$00F9F2	|
	RTS					;$00F9F4	|

Empty00F9F5:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF

	LDX.b #$0B				;$00FA10	|
ADDR_00FA12:
	STZ.w $14C8,X
	DEX					;$00FA15	|
	BPL ADDR_00FA12				;$00FA16	|
	RTL					;$00FA18	|

CODE_00FA19:
	LDY.b #$32
	STY $05					;$00FA1B	|
	LDY.b #$E6				;$00FA1D	|
	STY $06					;$00FA1F	|
	LDY.b #$00				;$00FA21	|
	STY $07					;$00FA23	|
	SEC					;$00FA25	|
	SBC.b #$6E				;$00FA26	|
	TAY					;$00FA28	|
	LDA [$82],Y				;$00FA29	|
	STA $08					;$00FA2B	|
	ASL					;$00FA2D	|
	ASL					;$00FA2E	|
	ASL					;$00FA2F	|
	ASL					;$00FA30	|
	STA $01					;$00FA31	|
	BCC CODE_00FA37				;$00FA33	|
	INC $06					;$00FA35	|
CODE_00FA37:
	LDA $0C
	AND.b #$0F				;$00FA39	|
	STA $00					;$00FA3B	|
	LDA $0A					;$00FA3D	|
	AND.b #$0F				;$00FA3F	|
	ORA $01					;$00FA41	|
	TAY					;$00FA43	|
	RTL					;$00FA44	|

FlatPalaceSwitch:
	LDA.b #$20
	STA.w $1887				;$00FA47	|
	LDY.b #$02				;$00FA4A	|
	LDA.b #$60				;$00FA4C	|
	STA.w $009E,y				;$00FA4E	|
	LDA.b #$08				;$00FA51	|
	STA.w $14C8,Y				;$00FA53	|
	LDA $9A					;$00FA56	|
	AND.b #$F0				;$00FA58	|
	STA.w $00E4,y				;$00FA5A	|
	LDA $9B					;$00FA5D	|
	STA.w $14E0,Y				;$00FA5F	|
	LDA $98					;$00FA62	|
	AND.b #$F0				;$00FA64	|
	CLC					;$00FA66	|
	ADC.b #$10				;$00FA67	|
	STA.w $00D8,y				;$00FA69	|
	LDA $99					;$00FA6C	|
	ADC.b #$00				;$00FA6E	|
	STA.w $14D4,Y				;$00FA70	|
	PHX					;$00FA73	|
	TYX					;$00FA74	|
	JSL InitSpriteTables			;$00FA75	|
	PLX					;$00FA79	|
	LDA.b #$5F				;$00FA7A	|
	STA.w $1540,Y				;$00FA7C	|
	RTS					;$00FA7F	|

TriggerGoalTape:
	STZ.w $13F3
	STZ.w $1891				;$00FA83	|
	STZ.w $18C0				;$00FA86	|
	STZ.w $18B9				;$00FA89	|
	STZ.w $18DD				;$00FA8C	|
	LDY.b #$0B				;$00FA8F	|
LvlEndSprLoopStrt:
	LDA.w $14C8,Y
	CMP.b #$08				;$00FA94	|
	BCC LvlEndNextSprite			;$00FA96	|
	CMP.b #$0B				;$00FA98	|
	BNE CODE_00FAA3				;$00FA9A	|
	PHX					;$00FA9C	|
	JSR LvlEndPowerUp			;$00FA9D	|
	PLX					;$00FAA0	|
	BRA LvlEndNextSprite			;$00FAA1	|

CODE_00FAA3:
	LDA.w $009E,y
	CMP.b #$7B				;$00FAA6	|
	BEQ CODE_00FAB2				;$00FAA8	|
	LDA.w $15A0,Y				;$00FAAA	|
	ORA.w $186C,Y				;$00FAAD	|
	BNE CODE_00FAC5				;$00FAB0	|
CODE_00FAB2:
	LDA.w $1686,Y
	AND.b #$20				;$00FAB5	|
	BNE CODE_00FAC5				;$00FAB7	|
	LDA.b #$10				;$00FAB9	|
	STA.w $1540,Y				;$00FABB	|
	LDA.b #$06				;$00FABE	|
	STA.w $14C8,Y				;$00FAC0	|
	BRA LvlEndNextSprite			;$00FAC3	|

CODE_00FAC5:
	LDA.w $190F,Y
	AND.b #$02				;$00FAC8	|
	BNE LvlEndNextSprite			;$00FACA	|
	LDA.b #$00				;$00FACC	|
	STA.w $14C8,Y				;$00FACE	|
LvlEndNextSprite:
	DEY
	BPL LvlEndSprLoopStrt			;$00FAD2	|
	LDY.b #$07				;$00FAD4	|
	LDA.b #$00				;$00FAD6	|
CODE_00FAD8:
	STA.w $170B,Y
	DEY					;$00FADB	|
	BPL CODE_00FAD8				;$00FADC	|
	RTL					;$00FADE	|

DATA_00FADF:
	db $74,$74,$77,$75,$76,$E0,$F0,$74
	db $74,$77,$75,$76,$E0,$F1,$F0,$F0
	db $F0,$F0,$F1,$E0,$F2,$E0,$E0,$E0
	db $E0,$F1,$E0,$E4

DATA_00FAFB:
	db $FF,$74,$75,$76,$77

LvlEndPowerUp:
	LDX $19
	LDA.w $1490				;$00FB02	|
	BEQ CODE_00FB09				;$00FB05	|
	LDX.b #$04				;$00FB07	|
CODE_00FB09:
	LDA.w $187A
	BEQ CODE_00FB10				;$00FB0C	|
	LDX.b #$05				;$00FB0E	|
CODE_00FB10:
	LDA.w $009E,y
	CMP.b #$2F				;$00FB13	|
	BEQ CODE_00FB2D				;$00FB15	|
	CMP.b #$3E				;$00FB17	|
	BEQ CODE_00FB2D				;$00FB19	|
	CMP.b #$80				;$00FB1B	|
	BEQ ADDR_00FB28				;$00FB1D	|
	CMP.b #$2D				;$00FB1F	|
	BNE CODE_00FB32				;$00FB21	|
	TXA					;$00FB23	|
	CLC					;$00FB24	|
	ADC.b #$07				;$00FB25	|
	TAX					;$00FB27	|
ADDR_00FB28:
	TXA
	CLC					;$00FB29	|
	ADC.b #$07				;$00FB2A	|
	TAX					;$00FB2C	|
CODE_00FB2D:
	TXA
	CLC					;$00FB2E	|
	ADC.b #$07				;$00FB2F	|
	TAX					;$00FB31	|
CODE_00FB32:
	LDA.l DATA_00FADF,X
	LDX.w $0DC2				;$00FB36	|
	CMP.l DATA_00FAFB,X			;$00FB39	|
	BNE CODE_00FB41				;$00FB3D	|
	LDA.b #$78				;$00FB3F	|
CODE_00FB41:
	STZ $0F
	CMP.b #$E0				;$00FB43	|
	BCC LvlEndStoreSpr			;$00FB45	|
	PHA					;$00FB47	|
	AND.b #$0F				;$00FB48	|
	STA $0F					;$00FB4A	|
	PLA					;$00FB4C	|
	CMP.b #$F0				;$00FB4D	|
	LDA.b #$78				;$00FB4F	|
	BCS LvlEndStoreSpr			;$00FB51	|
	LDA.b #$78				;$00FB53	|
LvlEndStoreSpr:
	STA.w $009E,y
	CMP.b #$76				;$00FB58	|
	BNE CODE_00FB5F				;$00FB5A	|
	INC.w $13CB				;$00FB5C	|
CODE_00FB5F:
	TYX
	JSL InitSpriteTables			;$00FB60	|
	LDA $0F					;$00FB64	|
	STA.w $1594,Y				;$00FB66	|
	LDA.b #$0C				;$00FB69	|
	STA.w $14C8,Y				;$00FB6B	|
	LDA.b #$D0				;$00FB6E	|
	STA.w $00AA,y				;$00FB70	|
	LDA.b #$05				;$00FB73	|
	STA.w $00B6,y				;$00FB75	|
	LDA.b #$20				;$00FB78	|
	STA.w $154C,Y				;$00FB7A	|
	LDA.b #$0C				;$00FB7D	|
	STA.w $1DF9				;$00FB7F	|
	LDX.b #$03				;$00FB82	|
CODE_00FB84:
	LDA.w $17C0,X
	BEQ CODE_00FB8D				;$00FB87	|
	DEX					;$00FB89	|
	BPL CODE_00FB84				;$00FB8A	|
	RTS					;$00FB8C	|

CODE_00FB8D:
	LDA.b #$01
	STA.w $17C0,X				;$00FB8F	|
	LDA.w $00D8,y				;$00FB92	|
	STA.w $17C4,X				;$00FB95	|
	LDA.w $00E4,y				;$00FB98	|
	STA.w $17C8,X				;$00FB9B	|
	LDA.b #$1B				;$00FB9E	|
	STA.w $17CC,X				;$00FBA0	|
	RTS					;$00FBA3	|

LvlEndSmokeTiles:
	db $66,$64,$62,$60,$E8,$EA,$EC,$EA

LvlEndSprCoins:
	PHB
	PHK					;$00FBAD	|
	PLB					;$00FBAE	|
	JSR LvlEndSprCoinsRt			;$00FBAF	|
	PLB					;$00FBB2	|
	RTL					;$00FBB3	|

LvlEndSprCoinsRt:
	LDY.b #$00
	LDA.w $17BD				;$00FBB6	|
	BPL CODE_00FBBC				;$00FBB9	|
	DEY					;$00FBBB	|
CODE_00FBBC:
	CLC
	ADC $E4,X				;$00FBBD	|
	STA $E4,X				;$00FBBF	|
	TYA					;$00FBC1	|
	ADC.w $14E0,X				;$00FBC2	|
	STA.w $14E0,X				;$00FBC5	|
	LDA.w $1540,X				;$00FBC8	|
	BEQ CODE_00FBF0				;$00FBCB	|
	CMP.b #$01				;$00FBCD	|
	BNE CODE_00FBD5				;$00FBCF	|
	LDA.b #$D0				;$00FBD1	|
	STA $AA,X				;$00FBD3	|
CODE_00FBD5:
	PHX
	LDA.b #$04				;$00FBD6	|
	STA.w $15F6,X				;$00FBD8	|
	JSL GenericSprGfxRt2			;$00FBDB	|
	LDA.w $1540,X				;$00FBDF	|
	LSR					;$00FBE2	|
	LSR					;$00FBE3	|
	LDY.w $15EA,X				;$00FBE4	|
	TAX					;$00FBE7	|
	LDA.w LvlEndSmokeTiles,X		;$00FBE8	|
	STA.w $0302,Y				;$00FBEB	|
	PLX					;$00FBEE	|
	RTS					;$00FBEF	|

CODE_00FBF0:
	INC.w $1570,X
	JSL UpdateYPosNoGrvty			;$00FBF3	|
	INC $AA,X				;$00FBF7	|
	INC $AA,X				;$00FBF9	|
	LDA $AA,X				;$00FBFB	|
	CMP.b #$20				;$00FBFD	|
	BMI CODE_00FC1E				;$00FBFF	|
	JSL CODE_05B34A				;$00FC01	|
	LDA.w $18DD				;$00FC05	|
	CMP.b #$0D				;$00FC08	|
	BCC CODE_00FC0E				;$00FC0A	|
	LDA.b #$0D				;$00FC0C	|
CODE_00FC0E:
	JSL GivePoints
	LDA.w $18DD				;$00FC12	|
	CLC					;$00FC15	|
	ADC.b #$02				;$00FC16	|
	STA.w $18DD				;$00FC18	|
	STZ.w $14C8,X				;$00FC1B	|
CODE_00FC1E:
	JSL CoinSprGfx
	RTS					;$00FC22	|

	LDY.b #$0B				;$00FC23	|
ADDR_00FC25:
	LDA.w $14C8,Y
	CMP.b #$08				;$00FC28	|
	BNE ADDR_00FC73				;$00FC2A	|
	LDA.w $009E,y				;$00FC2C	|
	CMP.b #$35				;$00FC2F	|
	BNE ADDR_00FC73				;$00FC31	|
	LDA.b #$01				;$00FC33	|
	STA.w $0DC1				;$00FC35	|
	STZ.w $141E				;$00FC38	|
	LDA.w $15F6,Y				;$00FC3B	|
	AND.b #$F1				;$00FC3E	|
	ORA.b #$0A				;$00FC40	|
	STA.w $15F6,Y				;$00FC42	|
	LDA.w $187A				;$00FC45	|
	BNE Return00FC72			;$00FC48	|
	LDA $1A					;$00FC4A	|
	SEC					;$00FC4C	|
	SBC.b #$10				;$00FC4D	|
	STA.w $00E4,y				;$00FC4F	|
	LDA $1B					;$00FC52	|
	SBC.b #$00				;$00FC54	|
	STA.w $14E0,Y				;$00FC56	|
	LDA $96					;$00FC59	|
	STA.w $00D8,y				;$00FC5B	|
	LDA $97					;$00FC5E	|
	STA.w $14D4,Y				;$00FC60	|
	LDA.b #$03				;$00FC63	|
	STA.w $00C2,y				;$00FC65	|
	LDA.b #$00				;$00FC68	|
	STA.w $157C,Y				;$00FC6A	|
	LDA.b #$10				;$00FC6D	|
	STA.w $00B6,y				;$00FC6F	|
Return00FC72:
	RTL

ADDR_00FC73:
	DEY
	BPL ADDR_00FC25				;$00FC74	|
	STZ.w $0DC1				;$00FC76	|
	RTL					;$00FC79	|

CODE_00FC7A:
	LDA.b #$02
	STA.w $1DFA				;$00FC7C	|
	LDX.b #$00				;$00FC7F	|
	LDA.w $1B94				;$00FC81	|
	BNE CODE_00FC98				;$00FC84	|
	LDX.b #$05				;$00FC86	|
	LDA.w $1692				;$00FC88	|
	CMP.b #$0A				;$00FC8B	|
	BEQ CODE_00FC98				;$00FC8D	|
	JSL FindFreeSprSlot			;$00FC8F	|
	TYX					;$00FC93	|
	BPL CODE_00FC98				;$00FC94	|
	LDX.b #$03				;$00FC96	|
CODE_00FC98:
	LDA.b #$08
	STA.w $14C8,X				;$00FC9A	|
	LDA.b #$35				;$00FC9D	|
	STA $9E,X				;$00FC9F	|
	LDA $94					;$00FCA1	|
	STA $E4,X				;$00FCA3	|
	LDA $95					;$00FCA5	|
	STA.w $14E0,X				;$00FCA7	|
	LDA $96					;$00FCAA	|
	SEC					;$00FCAC	|
	SBC.b #$10				;$00FCAD	|
	STA $96					;$00FCAF	|
	STA $D8,X				;$00FCB1	|
	LDA $97					;$00FCB3	|
	SBC.b #$00				;$00FCB5	|
	STA $97					;$00FCB7	|
	STA.w $14D4,X				;$00FCB9	|
	JSL InitSpriteTables			;$00FCBC	|
	LDA.b #$04				;$00FCC0	|
	STA.w $1FE2,X				;$00FCC2	|
	LDA.w $13C7				;$00FCC5	|
	STA.w $15F6,X				;$00FCC8	|
	LDA.w $1B95				;$00FCCB	|
	BEQ CODE_00FCD5				;$00FCCE	|
	LDA.b #$06				;$00FCD0	|
	STA.w $15F6,X				;$00FCD2	|
CODE_00FCD5:
	INC.w $187A
	INC $C2,X				;$00FCD8	|
	LDA $76					;$00FCDA	|
	EOR.b #$01				;$00FCDC	|
	STA.w $157C,X				;$00FCDE	|
	DEC.w $160E,X				;$00FCE1	|
	INX					;$00FCE4	|
	STX.w $18DF				;$00FCE5	|
	STX.w $18E2				;$00FCE8	|
	RTL					;$00FCEB	|

CODE_00FCEC:
	LDX.b #$0B
CODE_00FCEE:
	STZ.w $14C8,X
	DEX					;$00FCF1	|
	BPL CODE_00FCEE				;$00FCF2	|
	RTS					;$00FCF4	|

CODE_00FCF5:
	LDA.b #$A0
	STA $E4,X				;$00FCF7	|
	LDA.b #$00				;$00FCF9	|
	STA.w $14E0,X				;$00FCFB	|
	LDA.b #$00				;$00FCFE	|
	STA $D8,X				;$00FD00	|
	LDA.b #$00				;$00FD02	|
	STA.w $14D4,X				;$00FD04	|
	RTL					;$00FD07	|

CODE_00FD08:
	LDY.b #$3F
	LDA $15					;$00FD0A	|
	AND.b #$83				;$00FD0C	|
	BNE CODE_00FD12				;$00FD0E	|
	LDY.b #$7F				;$00FD10	|
CODE_00FD12:
	TYA
	AND $14					;$00FD13	|
	ORA $9D					;$00FD15	|
	BNE Return00FD23			;$00FD17	|
	LDX.b #$07				;$00FD19	|
CODE_00FD1B:
	LDA.w $170B,X
	BEQ CODE_00FD26				;$00FD1E	|
	DEX					;$00FD20	|
	BPL CODE_00FD1B				;$00FD21	|
Return00FD23:
	RTS

DATA_00FD24:
	db $02,$0A

CODE_00FD26:
	LDA.b #$12
	STA.w $170B,X				;$00FD28	|
	LDY $76					;$00FD2B	|
	LDA $94					;$00FD2D	|
	CLC					;$00FD2F	|
	ADC.w DATA_00FD24,Y			;$00FD30	|
	STA.w $171F,X				;$00FD33	|
	LDA $95					;$00FD36	|
	ADC.b #$00				;$00FD38	|
	STA.w $1733,X				;$00FD3A	|
	LDA $19					;$00FD3D	|
	BEQ CODE_00FD47				;$00FD3F	|
	LDA.b #$04				;$00FD41	|
	LDY $73					;$00FD43	|
	BEQ CODE_00FD49				;$00FD45	|
CODE_00FD47:
	LDA.b #$0C
CODE_00FD49:
	CLC
	ADC $96					;$00FD4A	|
	STA.w $1715,X				;$00FD4C	|
	LDA $97					;$00FD4F	|
	ADC.b #$00				;$00FD51	|
	STA.w $1729,X				;$00FD53	|
	STZ.w $176F,X				;$00FD56	|
	RTS					;$00FD59	|

smoke_sparkle:
	LDA $7F					;$00FD5A	\ Don't draw the sparkle if the player is offscreen.
	ORA $81					;$00FD5C	 |
	BNE .return				;$00FD5E	 |
	LDY.b #$03				;$00FD60	 |
.loop						;		 |
	LDA.w $17C0,Y				;$00FD62	 |
	BEQ .found_smoke_slot			;$00FD65	 |
	DEY					;$00FD67	 |
	BPL .loop				;$00FD68	 |
.return						;		 |
	RTS					;$00FD6A	/

.found_smoke_slot
	LDA.b #$05
	STA.w $17C0,Y				;$00FD6D	|
	LDA $9A					;$00FD70	|
	AND.b #$F0				;$00FD72	|
	STA.w $17C8,Y				;$00FD74	|
	LDA $98					;$00FD77	|
	AND.b #$F0				;$00FD79	|
	STA.w $17C4,Y				;$00FD7B	|
	LDA.w $1933				;$00FD7E	|
	BEQ CODE_00FD97				;$00FD81	|
	LDA $9A					;$00FD83	|
	SEC					;$00FD85	|
	SBC $26					;$00FD86	|
	AND.b #$F0				;$00FD88	|
	STA.w $17C8,Y				;$00FD8A	|
	LDA $98					;$00FD8D	|
	SEC					;$00FD8F	|
	SBC $28					;$00FD90	|
	AND.b #$F0				;$00FD92	|
	STA.w $17C4,Y				;$00FD94	|
CODE_00FD97:
	LDA.b #$10
	STA.w $17CC,Y				;$00FD99	|
	RTS					;$00FD9C	|

DATA_00FD9D:
	db $08,$FC,$10,$04

DATA_00FDA1:
	db $00,$FF,$00,$00

CODE_00FDA5:
	LDA $72
	BEQ CODE_00FDB3				;$00FDA7	|
	LDY.b #$0B				;$00FDA9	|
CODE_00FDAB:
	LDA.w $17F0,Y
	BEQ CODE_00FDB4				;$00FDAE	|
	DEY					;$00FDB0	|
	BPL CODE_00FDAB				;$00FDB1	|
CODE_00FDB3:
	INY
CODE_00FDB4:
	PHX
	LDX.b #$00				;$00FDB5	|
	LDA $19					;$00FDB7	|
	BEQ CODE_00FDBC				;$00FDB9	|
	INX					;$00FDBB	|
CODE_00FDBC:
	LDA.w $187A
	BEQ CODE_00FDC3				;$00FDBF	|
	INX					;$00FDC1	|
	INX					;$00FDC2	|
CODE_00FDC3:
	LDA $96
	CLC					;$00FDC5	|
	ADC.w DATA_00FD9D,X			;$00FDC6	|
	PHP					;$00FDC9	|
	AND.b #$F0				;$00FDCA	|
	CLC					;$00FDCC	|
	ADC.b #$03				;$00FDCD	|
	STA.w $17FC,Y				;$00FDCF	|
	LDA $97					;$00FDD2	|
	ADC.b #$00				;$00FDD4	|
	PLP					;$00FDD6	|
	ADC.w DATA_00FDA1,X			;$00FDD7	|
	STA.w $1814,Y				;$00FDDA	|
	PLX					;$00FDDD	|
	LDA $94					;$00FDDE	|
	STA.w $1808,Y				;$00FDE0	|
	LDA $95					;$00FDE3	|
	STA.w $18EA,Y				;$00FDE5	|
	LDA.b #$07				;$00FDE8	|
	STA.w $17F0,Y				;$00FDEA	|
	LDA.b #$00				;$00FDED	|
	STA.w $1850,Y				;$00FDEF	|
	LDA $7D					;$00FDF2	|
	BMI Return00FE0D			;$00FDF4	|
	STZ $7D					;$00FDF6	|
	LDY $72					;$00FDF8	|
	BEQ CODE_00FDFE				;$00FDFA	|
	STZ $7B					;$00FDFC	|
CODE_00FDFE:
	LDY.b #$03
	LDA $19					;$00FE00	|
	BNE CODE_00FE05				;$00FE02	|
	DEY					;$00FE04	|
CODE_00FE05:
	LDA.w $170B,Y
	BEQ CODE_00FE16				;$00FE08	|
CODE_00FE0A:
	DEY
	BPL CODE_00FE05				;$00FE0B	|
Return00FE0D:
	RTS

DATA_00FE0E:
	db $10,$16,$13,$1C

DATA_00FE12:
	db $00,$04,$0A,$07

CODE_00FE16:
	LDA.b #$12
	STA.w $170B,Y				;$00FE18	|
	TYA					;$00FE1B	|
	ASL					;$00FE1C	|
	ASL					;$00FE1D	|
	ASL					;$00FE1E	|
	ADC.b #$F7				;$00FE1F	|
	STA.w $1765,Y				;$00FE21	|
	LDA $96					;$00FE24	|
	ADC.w DATA_00FE0E,Y			;$00FE26	|
	STA.w $1715,Y				;$00FE29	|
	LDA $97					;$00FE2C	|
	ADC.b #$00				;$00FE2E	|
	STA.w $1729,Y				;$00FE30	|
	LDA $94					;$00FE33	|
	ADC.w DATA_00FE12,Y			;$00FE35	|
	STA.w $171F,Y				;$00FE38	|
	LDA $95					;$00FE3B	|
	ADC.b #$00				;$00FE3D	|
	STA.w $1733,Y				;$00FE3F	|
	LDA.b #$00				;$00FE42	|
	STA.w $176F,Y				;$00FE44	|
	JMP CODE_00FE0A				;$00FE47	|

CODE_00FE4A:
	LDA $13
	AND.b #$03				;$00FE4C	|
	ORA $72					;$00FE4E	|
	ORA $7F					;$00FE50	|
	ORA $81					;$00FE52	|
	ORA $9D					;$00FE54	|
	BNE Return00FE71			;$00FE56	|
	LDA $15					;$00FE58	|
	AND.b #$04				;$00FE5A	|
	BEQ CODE_00FE67				;$00FE5C	|
	LDA $7B					;$00FE5E	|
	CLC					;$00FE60	|
	ADC.b #$08				;$00FE61	|
	CMP.b #$10				;$00FE63	|
	BCC Return00FE71			;$00FE65	|
CODE_00FE67:
	LDY.b #$03
CODE_00FE69:
	LDA.w $17C0,Y
	BEQ CODE_00FE72				;$00FE6C	|
	DEY					;$00FE6E	|
	BNE CODE_00FE69				;$00FE6F	|
Return00FE71:
	RTS

CODE_00FE72:
	LDA.b #$03
	STA.w $17C0,Y				;$00FE74	|
	LDA $94					;$00FE77	|
	ADC.b #$04				;$00FE79	|
	STA.w $17C8,Y				;$00FE7B	|
	LDA $96					;$00FE7E	|
	ADC.b #$1A				;$00FE80	|
	PHX					;$00FE82	|
	LDX.w $187A				;$00FE83	|
	BEQ CODE_00FE8A				;$00FE86	|
	ADC.b #$10				;$00FE88	|
CODE_00FE8A:
	STA.w $17C4,Y
	PLX					;$00FE8D	|
	LDA.b #$13				;$00FE8E	|
	STA.w $17CC,Y				;$00FE90	|
	RTS					;$00FE93	|

fireball_x_speeds:
	db $FD,$03

fireball_x_offsets:
	db $00,$08,$F8,$10,$F8,$10

fireball_x_high_offsets:
	db $00,$00,$FF,$00,$FF,$00

fireball_y_offsets:
	db $08,$08,$0C,$0C,$14,$14

shoot_fireball:
	LDX.b #$09				;$00FEA8	\ Initialize the loop counter.
.loop						;		 |
	LDA.w $170B,X				;$00FEAA	 |\ If the extended sprite slot is free,
	BEQ .spawn_fireball			;$00FEAD	 |/ spawn a fireball.
	DEX					;$00FEAF	 |\ Otherwise,
	CPX.b #$07				;$00FEB0	 | | check extended sprite slot $08 before quitting.
	BNE .loop				;$00FEB2	 |/
	RTS					;$00FEB4	/

.spawn_fireball					;		\
	LDA.b #$06				;$00FEB5	 |\ Play the fireball shoot sound.
	STA.w $1DFC				;$00FEB7	 |/
	LDA.b #$0A				;$00FEBA	 |\ Set the time to show the shooting pose.
	STA.w $149C				;$00FEBC	 |/
	LDA.b #$05				;$00FEBF	 |\ Set the extended sprite number.
	STA.w $170B,X				;$00FEC1	 |/
	LDA.b #$30				;$00FEC4	 |\ Set the fireball's Y speed.
	STA.w $173D,X				;$00FEC6	 |/
	LDY $76					;$00FEC9	 |\ Set the fireball's X speed
	LDA.w fireball_x_speeds,Y		;$00FECB	 | | depending on the player's direction.
	STA.w $1747,X				;$00FECE	 |/
	LDA.w $187A				;$00FED1	 |\ If on Yoshi,
	BEQ .not_on_yoshi			;$00FED4	 | | use the next two position offsets.
	INY					;$00FED6	 | |
	INY					;$00FED7	 |/
	LDA.w $18DC				;$00FED8	 |\ If also ducking while on Yoshi,
	BEQ .not_on_yoshi			;$00FEDB	 | | use the next two position offsets.
	INY					;$00FEDD	 | |
	INY					;$00FEDE	 |/
.not_on_yoshi					;		 |
	LDA $94					;$00FEDF	 |\ Offset the fireball's X position
	CLC					;$00FEE1	 | | based on the player's current X position,
	ADC.w fireball_x_offsets,Y		;$00FEE2	 | |
	STA.w $171F,X				;$00FEE5	 |/
	LDA $95					;$00FEE8	 |\ and offset the fireball's X position high byte.
	ADC.w fireball_x_high_offsets,Y		;$00FEEA	 | |
	STA.w $1733,X				;$00FEED	 |/
	LDA $96					;$00FEF0	 |\ Offset the fireball's Y position
	CLC					;$00FEF2	 | | based on the player's current Y position,
	ADC.w fireball_y_offsets,Y		;$00FEF3	 | |
	STA.w $1715,X				;$00FEF6	 |/
	LDA $97					;$00FEF9	 |\ and offset the fireball's Y position high byte.
	ADC.b #$00				;$00FEFB	 | |
	STA.w $1729,X				;$00FEFD	 |/
	LDA.w $13F9				;$00FF00	 |\ Set the fireball's layer.
	STA.w $1779,X				;$00FF03	 |/
	RTS					;$00FF06	/

ADDR_00FF07:
	REP #$20
	LDA.w $17BC				;$00FF09	|
	AND.w #$FF00				;$00FF0C	|
	BPL ADDR_00FF14				;$00FF0F	|
	ORA.w #$00FF				;$00FF11	|
ADDR_00FF14:
	XBA
	CLC					;$00FF15	|
	ADC $94					;$00FF16	|
	STA $94					;$00FF18	|
	LDA.w $17BB				;$00FF1A	|
	AND.w #$FF00				;$00FF1D	|
	BPL ADDR_00FF25				;$00FF20	|
	ORA.w #$00FF				;$00FF22	|
ADDR_00FF25:
	XBA
	EOR.w #$FFFF				;$00FF26	|
	INC A					;$00FF29	|
	CLC					;$00FF2A	|
	ADC $96					;$00FF2B	|
	STA $96					;$00FF2D	|
	SEP #$20				;$00FF2F	|
	RTL					;$00FF31	|

ADDR_00FF32:
	LDA.w $14E0,X
	XBA					;$00FF35	|
	LDA $E4,X				;$00FF36	|
	REP #$20				;$00FF38	|
	SEC					;$00FF3A	|
	SBC $1A					;$00FF3B	|
	STA $00					;$00FF3D	|
	LDA.w #$0030				;$00FF3F	|
	SEC					;$00FF42	|
	SBC $00					;$00FF43	|
	STA $22					;$00FF45	|
	SEP #$20				;$00FF47	|
	LDA.w $14D4,X				;$00FF49	|
	XBA					;$00FF4C	|
	LDA $D8,X				;$00FF4D	|
	REP #$20				;$00FF4F	|
	SEC					;$00FF51	|
	SBC $1C					;$00FF52	|
	STA $00					;$00FF54	|
	LDA.w #$0100				;$00FF56	|
	SEC					;$00FF59	|
	SBC $00					;$00FF5A	|
	STA $24					;$00FF5C	|
	SEP #$20				;$00FF5E	|
	RTL					;$00FF60	|

CODE_00FF61:
	LDA.w $14E0,X
	XBA					;$00FF64	|
	LDA $E4,X				;$00FF65	|
	REP #$20				;$00FF67	|
	CMP.w #$FF00				;$00FF69	|
	BMI CODE_00FF73				;$00FF6C	|
	CMP.w #$0100				;$00FF6E	|
	BMI CODE_00FF76				;$00FF71	|
CODE_00FF73:
	LDA.w #$0100
CODE_00FF76:
	STA $22
	SEP #$20				;$00FF78	|
	LDA.w $14D4,X				;$00FF7A	|
	XBA					;$00FF7D	|
	LDA $D8,X				;$00FF7E	|
	REP #$20				;$00FF80	|
	STA $00					;$00FF82	|
	LDA.w #$00A0				;$00FF84	|
	SEC					;$00FF87	|
	SBC $00					;$00FF88	|
	CLC					;$00FF8A	|
	ADC.w $1888				;$00FF8B	|
	STA $24					;$00FF8E	|
	SEP #$20				;$00FF90	|
	RTL					;$00FF92	|

DATA_00FF93:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF
	
snes_header:
	db "SUPER MARIOWORLD     "		;		\ ROM name
	db $20					;		 | slow LOROM
	db $02					;		 | ROM with SRAM
	db $09					;		 | ROM size: 512 KB
	db $01					;		 | SRAM size: 2 KB
	db $01					;		 | NTSC
	db $01					;		 | Nintendo
	db $00					;		 | Version: zero
	dw $5F25				;		 | Checksum complement
	dw $A0DA				;		 | Checksum
	db $FF,$FF,$FF,$FF			;		 |
	dw $82C3				;		 | Native COP vector
	dw $FFFF				;		 | Native BRK vector
	dw $82C3				;		 | Native ABORT vector
	dw NMI_start				;		 | Native NMI vector
	dw $8000				;		 | Native RESET vector(unused)
	dw IRQ_start				;		 | Native IRQ vector
	db $FF,$FF,$FF,$FF			;		 |
	dw $82C3				;		 | Emulation COP vector
	dw $82C3				;		 | Emulation BRK vector(unused)
	dw $82C3				;		 | Emulation ABORT vector
	dw $82C3				;		 | Emulation NMI vector
	dw reset_start				;		 | Emulation RESET vector
	dw $82C3				;		/ Emulation IRQ and BRK vector
