lorom

;Boss scene selection
org $00950B 
	db $00 ;Disable
	;db $30 ;Enable

;Beat level with start select (holding A / B trigger the secret exit)
org $00A268 
	;db $20 ;Disable
	db $00 ;Enable
org $00A273
	;db $0A ;Disable
	db $00 ;Enable

;Powerup select
org $00C576 
	db $80 ;Disable
	;db $F0 ;Enable

;free roaming
org $00CC84
	;db $80 ;Disable
	db $F0 ;Enable

;unlimited Star power
org $00E2D3 
	db $40 ;Disable
	;db $00 ;Enable

;Change yoshi color with select on overworld
org $04824B 
	;db $80 ;Disable
	db $F0 ;Enable

;Use yoshi's house as star warp by pressing select
org $049136 
	;db $80 ;Disable
	db $F0 ;Enable

;Allow walking on pathes not yet revealed
org $049291
	NOP #3
	JMP $92AF ;Enable

