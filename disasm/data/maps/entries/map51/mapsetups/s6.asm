
; ASM FILE data\maps\entries\map51\mapsetups\s6.asm :
; 0x5C3CA..0x5C454 : 

; =============== S U B R O U T I N E =======================================

ms_map51_InitFunction:
		
		trap    #CHECK_FLAG
		dc.w $1D6
		bne.s   return_5C3D6
		lea     cs_5C3D8(pc), a0
		trap    #6
return_5C3D6:
		rts

	; End of function ms_map51_InitFunction

cs_5C3D8:       textCursor $9F6
		setActscript $1F,$FF,eas_Init
		setActscript $7,$FF,eas_Init
		setPos $0,11,22,UP
		setPos $1F,10,22,UP
		setPos $7,9,22,UP
		fadeInB
		moveEntity $1F,$FF,$1,$2
		endMove $8080
		csWait 5
		setActscript $1F,$0,eas_461B6
		csWait 120
		setFacing $1F,UP
		nextSingleText $0,$1F   ; "It's coming from this{N}direction.{W1}"
		moveEntity $7,$FF,$1,$2
		endMove $8080
		nextSingleText $0,$7    ; "Look!  Over there!{W1}"
		setCamDest 2,2
		csWait 50
		nextSingleText $C0,$D   ; "Help me!{W1}"
		nextText $0,$7          ; "An...elven boy?{N}He's stuck in the pond.{W2}"
		nextSingleText $0,$7    ; "He must be very tired.{N}Let's pull him out.{W1}"
		setCameraEntity $0
		followEntity $7,$0,$2
		followEntity $1F,$7,$2
		csc_end
		dc.b $FF
		dc.b $FF
