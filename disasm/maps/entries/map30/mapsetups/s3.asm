
; SCRIPT SECTION maps\entries\map30\mapsetups\s3 :
; 
ms_map30_ZoneEvents:dc.b 7
										dc.b $D
										dc.w sub_5A2CA-ms_map30_ZoneEvents
										dc.w $FD00
										dc.w return_5A2E6-ms_map30_ZoneEvents

; =============== S U B R O U T I N E =======================================

sub_5A2CA:
										
										trap    #TRAP_CHECKFLAG
										dc.w $45
										beq.s   return_5A2E6
										trap    #TRAP_CHECKFLAG
										dc.w $2F8
										bne.s   return_5A2E6
										lea     cs_5A33A(pc), a0
										trap    #6
										bsr.s   sub_5A278
										trap    #TRAP_SETFLAG
										dc.w $2F8               ; set after the fairy cures the sick dwarf in the mine
										trap    #TRAP_CLEARFLAG
										dc.w $45                ; Fairy is a follower
return_5A2E6:
										
										rts

	; End of function sub_5A2CA

