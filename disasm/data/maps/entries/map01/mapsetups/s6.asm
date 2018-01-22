
; ASM FILE data\maps\entries\map01\mapsetups\s6.asm :
; 0x5E760..0x5E86C : 

; =============== S U B R O U T I N E =======================================

ms_map1_InitFunction:
		
		trap    #CHECK_FLAG
		dc.w $15
		beq.s   return_5E770
		move.w  #$88,d0 
		jsr     MoveEntityOutOfMap
return_5E770:
		rts

	; End of function ms_map1_InitFunction

cs_5E772:       textCursor $E41
		csWait 30
		setFacing $0,UP
		setEntityDest $0,44,27
		setActscript $7,$FF,eas_Init
		setActscript $1F,$FF,eas_Init
		flashScreenWhite $1E
		csWait 30
		flashScreenWhite $1E
		setPos $88,63,62,DOWN
		setPos $15,44,26,DOWN
		stopEntity $15
		csWait 30
		flashScreenWhite $1E
		csWait 30
		setEntityDest $7,43,27
		setEntityDest $1F,45,27
		setFacing $7,UP
		setFacing $1F,UP
		nextSingleText $80,$15  ; "I feel...a power returning{N}me to human.{W2}"
		nextSingleText $80,$15  ; "Hey!  The evil is gone!{N}Did you chase them away?{W1}"
		startEntity $15
		moveEntity $7,$FF,$1,$1
		endMove $8080
		setFacing $7,RIGHT
		nextSingleText $0,$7    ; "{LEADER}, who is she?{W1}"
		setFacing $15,LEFT
		nextSingleText $80,$15  ; "Did you say {LEADER}?{N}Oh, you're from Granseal!{W1}"
		nextSingleText $0,$7    ; "Yes, we are, but who are{N}you?{W1}"
		entityShiver $15
		nextSingleText $80,$15  ; "Do you know how long I've{N}been here as a stone statue?{W1}"
		moveEntity $0,$FF,$3,$1
		endMove $8080
		moveEntity $1F,$FF,$2,$1
		endMove $8080
		setFacing $1F,UP
		moveEntity $0,$FF,$0,$1
		endMove $8080
		moveEntity $0,$FF,$1,$1
		endMove $8080
		setFacing $0,UP
		nextSingleText $0,$1F   ; "How do you know {LEADER}?{W1}"
		setFacing $15,DOWN
		nextSingleText $80,$15  ; "Oh, I'm sorry.{W2}"
		nextSingleText $80,$15  ; "I'm {NAME;21}, a sorceress.{N}Goddess Mitula told me about{N}you.{W1}"
		nextSingleText $0,$1F   ; "She did?{W1}"
		nextSingleText $80,$15  ; "Yes.  She was worried about{N}you.{W2}"
		nextSingleText $80,$15  ; "You are fated to fight Zeon.{W2}"
		nextSingleText $80,$15  ; "But, she is unable to help{N}you.  It's an order from{N}Volcanon.{W2}"
		nextSingleText $80,$15  ; "But, I'm here for her.{N}I'm here to help you.{W1}"
		join $15
		nextSingleText $80,$15  ; "You want to go to Grans,{N}right?  Then, I think we{N}can use the ancient ship.{W2}"
		nextSingleText $80,$15  ; "Let's go to Nazca.{W1}"
		followEntity $7,$0,$2
		followEntity $1F,$7,$2
		addNewFollower $15
		csc_end
