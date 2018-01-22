
; ASM FILE data\battles\entries\battle34\cs_beforebattle.asm :
; 0x4D342..0x4D4B6 : Cutscene before battle 34
bbcs_34:        textCursor $B4F
		loadMapFadeIn 55,21,22
		loadMapEntities ce_4D48E
		setActscript $0,$FF,eas_Init
		setActscript $7,$FF,eas_Init
		setPos $7,30,28,LEFT
		setActscript $1F,$FF,eas_Init
		setPos $1F,30,30,LEFT
		jumpIfFlagClear $4C,cs_4D38E; Zynk is a follower
		setActscript $1A,$FF,eas_Init
		setPos $1A,31,29,LEFT
cs_4D38E:       animEntityFadeInOut $81,$6
		playSound MUSIC_BATTLE_THEME_1
		fadeInB
		cameraSpeed $30
		moveEntity $0,$0,$2,$3
		endMove $8080
		moveEntity $7,$0,$2,$3
		endMove $8080
		moveEntity $82,$0,$2,$3
		endMove $8080
		jumpIfFlagClear $4C,cs_4D3C6; Zynk is a follower
		moveEntity $1A,$0,$2,$3
		endMove $8080
cs_4D3C6:       moveEntity $1F,$FF,$2,$3
		endMove $8080
		nextSingleText $0,$80   ; "Hello, Granseal soldiers.{W1}"
		setActscript $7,$FF,eas_Jump
		setCamDest 7,5
		nextText $0,$80         ; "Remember?  I promised that I{N}would see you again.{W2}"
		nextSingleText $0,$80   ; "Come on.  Let's party!{W1}"
		setCamDest 7,4
		animEntityFadeInOut $81,$7
		nextSingleText $C0,$81  ; "Stop!  You need my war plan!{W1}"
		setFacing $80,UP
		nextSingleText $0,$80   ; "You again, Geshp?  Why don't{N}you leave me alone?{W1}"
		nextText $C0,$81        ; "Zeon left me in charge.{W2}"
		nextSingleText $C0,$81  ; "It doesn't matter if you are{N}killed or not.{W1}"
		moveEntity $80,$FF,$1,$1
		endMove $8080
		nextText $0,$80         ; "Then kill me, if you've{N}got the guts to do it!{W2}"
		nextSingleText $0,$80   ; "I know.  You want me to be{N}die!{W1}"
		customActscript $80,$FF
		dc.w $10                ;   0010 SET SPEED X=$30 Y=$30
		dc.b $30
		dc.b $30
		dc.w $34                ;   0034 JUMP TO ABSOLUTE ADDR. 0x451FC
		dc.l eas_Idle           
		dc.w $8080              ; 0014 END OF CUSTOM ACTSCRIPT
		moveEntity $80,$0,$1,$4
		endMove $8080
		csWait 10
		animEntityFadeInOut $81,$6
		waitIdle $80
		setFacing $80,DOWN
		csWait 30
		csWait 5
		setActscript $80,$0,eas_461B6
		csWait 120
		setFacing $80,DOWN
		nextSingleText $0,$80   ; "Geshp, you coward!{N}I'll kill you first!{W1}"
		tintMap
		nextText $C0,$81        ; "I have no time to waste.{N}I must go.{W2}"
		nextSingleText $C0,$81  ; "Silly Cameela.{N}You can't survive without my{N}brains.{W1}"
		flickerOnce
		setCamDest 7,3
		csWait 60
		setActscript $80,$FF,eas_Jump
		setFacing $80,RIGHT
		nextText $0,$80         ; "{LEADER}, did you hear that?{N}He said you would win!{W2}"
		nextSingleText $0,$80   ; "He must be a bad{N}fortuneteller.{W1}"
		setCamDest 21,22
		nextText $0,$1F         ; "We can get a ship and return{N}to Grans if we defeat her.{W2}"
		nextSingleText $0,$1F   ; "{LEADER}, get her!{W1}"
		csc_end
ce_4D48E:       dc.w $1D
		dc.w $1D
		dc.w 2
		dc.b $1E
		dc.b $1C
		dc.b 2
		dc.b 7
		dc.l eas_Init           
		dc.b $B
		dc.b $A
		dc.b 3
		dc.b $9C
		dc.l eas_Init           
		dc.b $B
		dc.b 6
		dc.b 3
		dc.b $9F
		dc.l eas_Init           
		dc.b $1E
		dc.b $1D
		dc.b 2
		dc.b $3E
		dc.l eas_Init           
		dc.w $FFFF
