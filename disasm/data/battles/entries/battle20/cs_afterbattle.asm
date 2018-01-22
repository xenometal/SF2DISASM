
; ASM FILE data\battles\entries\battle20\cs_afterbattle.asm :
; 0x4B6CE..0x4B790 : Cutscene after battle 20
abcs_battle20:  textCursor $A06
		loadMapFadeIn 51,2,6
		loadMapEntities ce_4B780
		setActscript $0,$FF,eas_Init
		setActscript $7,$FF,eas_Init
		setActscript $1F,$FF,eas_Init
		setPos $7,5,10,UP
		setPos $1F,7,10,UP
		fadeInB
		nextText $0,$D          ; "I'm {NAME;13}, an archer.{N}I had no idea how dangerous{N}this pond was.{W2}"
		nextSingleText $0,$D    ; "You saved my life.{N}Thank you.{W1}"
		nextText $C0,$7         ; "You should thank Oddler.{W2}"
		nextSingleText $C0,$7   ; "He heard your cry for help{N}and brought us here.{W1}"
		setFacing $7,RIGHT
		csWait 5
		setActscript $1F,$0,eas_461B6
		csWait 120
		setFacing $1F,UP
		nextSingleText $C0,$1F  ; "Oh well, it was nothing.{W1}"
		setFacing $7,UP
		nextText $0,$D          ; "An elf always returns a{N}favor.{W2}"
		nextSingleText $0,$D    ; "Please, let me help you.{W1}"
		setFacing $7,RIGHT
		setFacing $0,LEFT
		nextSingleText $C0,$7   ; "{LEADER}, looks like{N}we've found another friend.{W1}"
		moveEntity $D,$FF,$3,$1
		endMove $8080
		nextSingleText $0,$D    ; "Oh, thank you!{W1}"
		setFacing $0,UP
		entityNod $0
		join $D
		setFacing $7,UP
		nextSingleText $C0,$7   ; "Now, let's go see Mr. Creed!{W1}"
		followEntity $7,$0,$2
		followEntity $1F,$7,$2
		followEntity $D,$1F,$2
		csc_end
ce_4B780:       dc.w 6
		dc.w $A
		dc.w 1
		dc.b 6
		dc.b 8
		dc.b 3
		dc.b $D
		dc.l eas_Init           
		dc.w $FFFF
