
; ASM FILE data\maps\entries\map42\mapsetups\s3.asm :
; 0x5FE04..0x5FE24 : 
ms_map42_ZoneEvents:
		dc.b $13
		dc.b $15
		dc.w sub_5FE0C-ms_map42_ZoneEvents
		dc.w $FD00
		dc.w return_5FE22-ms_map42_ZoneEvents

; =============== S U B R O U T I N E =======================================

sub_5FE0C:
		trap    #CHECK_FLAG
		dc.w $3E7
		beq.s   return_5FE22
		trap    #CHECK_FLAG
		dc.w $385
		bne.s   return_5FE22
		lea     cs_5FE9A(pc), a0
		trap    #6
		trap    #SET_FLAG
		dc.w $385               ; set after the you're pulled toward the Force Sword in the Jewel Cave
return_5FE22:
		rts

	; End of function sub_5FE0C

