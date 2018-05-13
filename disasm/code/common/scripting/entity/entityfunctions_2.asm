
; ASM FILE code\common\scripting\entity\entityfunctions_2.asm :
; 0x449C6..0x44DE2 : Entity functions

; =============== S U B R O U T I N E =======================================

GetForceMemberSpriteIdx:
		
		cmpi.w  #COM_ALLIES_NUM,d0         ; HARDCODED Force member max index
		blt.s   loc_449D2
		move.w  d0,d4
		bra.w   return_44A5C
loc_449D2:
		movem.w d1,-(sp)
		cmpi.b  #$FF,((CURRENT_BATTLE-$1000000)).w
		bne.s   loc_449F0
		jsr     j_GetCurrentHP
		tst.w   d1
		bne.s   loc_449F0
		move.w  #$BE,d4 ; dead !
		bra.w   loc_44A5A
loc_449F0:
		cmpi.b  #$B,d0          ; Rhode !
		bne.s   loc_44A04
		trap    #CHECK_FLAG
		dc.w $B                 ; Rohde joined
		bne.s   loc_44A04
		move.w  #$AA,d4 
		bra.w   loc_44A5A
loc_44A04:
		move.w  d0,d4
		andi.w  #$1F,d4
		move.b  AllySprites(pc,d4.w),d4
		jsr     j_GetClass      
		cmpi.b  #$C,d1          ; HERO
		beq.w   loc_44A5A       ; HARDCODED class->sprite ?
		cmpi.b  #0,d1
		bne.s   loc_44A28
		subq.w  #1,d4           ; if SDMN, d4 = 0 ?
		bra.w   loc_44A5A
loc_44A28:
		cmpi.b  #$17,d1         ; BDBT ?
		bge.w   loc_44A5A
		cmpi.b  #6,d1           ; BDMN
		blt.s   loc_44A42
		cmpi.b  #$B,d1          ; TORT
		bgt.s   loc_44A42
		subq.w  #1,d4
		bra.w   loc_44A5A
loc_44A42:
		cmpi.b  #5,d1
		bgt.s   loc_44A4E
		subq.w  #2,d4
		bra.w   loc_44A5A
loc_44A4E:
		btst    #0,d1
		beq.s   loc_44A5A
		subq.w  #1,d4
		bra.w   *+4
loc_44A5A:
		move.w  (sp)+,d1
return_44A5C:
		rts

	; End of function GetForceMemberSpriteIdx

AllySprites:    incbin "data/stats/allies/allyspriteids.bin"
						; sprite IDs for each force character in battle

; =============== S U B R O U T I N E =======================================

; In: A6 = battle vars stack ???
; Out: D4 = sprite idx

GetCombatantSpriteIdx:
		
		movem.w d0,-(sp)
		move.w  -4(a6),d0
		tst.b   d0
		blt.s   loc_44A8E
		bsr.w   GetForceMemberSpriteIdx
		bra.s   loc_44A9E
loc_44A8E:
		move.w  d1,-(sp)
		jsr     j_GetEnemyID
		clr.w   d4
		move.b  EnemySprites(pc,d1.w),d4
		move.w  (sp)+,d1
loc_44A9E:
		movem.w (sp)+,d0
		rts

	; End of function GetCombatantSpriteIdx

EnemySprites:   incbin "data/stats/enemies/enemyspriteids.bin"

; =============== S U B R O U T I N E =======================================

SetEntityActscript:
		
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  a1,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function SetEntityActscript


; =============== S U B R O U T I N E =======================================

SetControlledEntityActScript:
		
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		tst.b   ((PLAYER_TYPE-$1000000)).w
		beq.s   loc_44B86
		cmpi.b  #1,((PLAYER_TYPE-$1000000)).w
		bne.s   loc_44B7C
		move.l  #eas_Raft,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
		bra.s   loc_44B84
loc_44B7C:
		move.l  #eas_Caravan,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
loc_44B84:
		bra.s   loc_44B8E
loc_44B86:
		move.l  #eas_ControlledCharacter,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
loc_44B8E:
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function SetControlledEntityActScript


; =============== S U B R O U T I N E =======================================

sub_44B94:
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #eas_UnitCursorSpeedx2,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function sub_44B94


; =============== S U B R O U T I N E =======================================

SetUnitCursorActscript:
		
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #eas_UnitCursor,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function SetUnitCursorActscript


; =============== S U B R O U T I N E =======================================

sub_44BC0:
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #eas_44EF6,$14(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function sub_44BC0


; =============== S U B R O U T I N E =======================================

sub_44BD6:
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #eas_44F16,$14(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function sub_44BD6


; =============== S U B R O U T I N E =======================================

MakeEntityIdle:
		
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #eas_Idle,$14(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function MakeEntityIdle


; =============== S U B R O U T I N E =======================================

; set entity D0's movescript to 0x460ce (default? don't move?)

sub_44C02:
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #eas_Init,$14(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function sub_44C02


; =============== S U B R O U T I N E =======================================

SetEntityMovescriptToIdle:
		
		move.w  d0,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #eas_Standing,$14(a0)
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		rts

	; End of function SetEntityMovescriptToIdle


; =============== S U B R O U T I N E =======================================

AddFollower:
		movem.l a0-a1,-(sp)
		move.w  d0,-(sp)
		bsr.w   GetEntityRAMAddress
		movea.l (dword_FFB1A0).l,a1
		move.l  a1,$14(a0)
		lea     eas_Follower1(pc), a0
		move.w  #$2A,d7 
		jsr     (CopyBytes).w   
		addi.l  #$2A,(dword_FFB1A0).l 
		move.w  d1,$1E(a1)
		move.w  d2,$20(a1)
		move.w  d3,$22(a1)
		lea     ((FOLLOWERS_LIST-$1000000)).w,a0
		move.w  (sp)+,d0
loc_44C6A:
		cmp.b   (a0),d0
		beq.w   loc_44C7E
		cmpi.b  #$FF,(a0)+
		bne.s   loc_44C6A
		move.b  d0,-1(a0)
		move.b  #$FF,(a0)
loc_44C7E:
		movem.l (sp)+,a0-a1
		rts

	; End of function AddFollower


; =============== S U B R O U T I N E =======================================

HideEntity:
		movem.l a0-a1,-(sp)
		move.w  d0,-(sp)
		bsr.w   GetEntityRAMAddress
		move.l  #$70007000,(a0)
		move.l  (a0),ENTITYDEF_OFFSET_XDEST(a0)
		move.w  (sp)+,d0
		lea     ((ENTITY_EVENT_IDX_LIST-$1000000)).w,a0
		moveq   #$3F,d7 
loc_44CA0:
		cmp.b   (a0)+,d0
		bne.s   loc_44CAA
		move.b  #$FF,-1(a0)
loc_44CAA:
		dbf     d7,loc_44CA0
		lea     ((FOLLOWERS_LIST-$1000000)).w,a0
loc_44CB2:
		cmpi.b  #$FF,(a0)
		beq.w   loc_44CCA
		cmp.b   (a0)+,d0
		bne.s   loc_44CB2
loc_44CBE:
		move.b  (a0),-1(a0)
		bmi.w   loc_44CCA
		addq.l  #1,a0
		bra.s   loc_44CBE
loc_44CCA:
		movem.l (sp)+,a0-a1
		rts

	; End of function HideEntity


; =============== S U B R O U T I N E =======================================

SetWalkingActscript:
		
		move.w  d0,-(sp)
		movem.l a0-a1,-(sp)
		bsr.w   GetEntityRAMAddress
		movea.l (dword_FFB1A0).l,a1
		move.l  a1,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
		lea     eas_Walking(pc), a0
		move.w  #$32,d7 
		jsr     (CopyBytes).w   
		addi.l  #$32,(dword_FFB1A0).l 
		move.w  d1,$22(a1)
		move.w  d2,$24(a1)
		move.w  d3,$26(a1)
		movem.l (sp)+,a0-a1
		move.w  (sp)+,d0
		rts

	; End of function SetWalkingActscript


; =============== S U B R O U T I N E =======================================

sub_44D0E:
		andi.l  #$FFFFFF,d5
		move.w  d0,-(sp)
		movem.l a0-a2,-(sp)
		bsr.w   GetEntityRAMAddress
		movea.l (dword_FFB1A0).l,a1
		move.l  a1,ENTITYDEF_OFFSET_ACTSCRIPTADDR(a0)
		lea     eas_Walking(pc), a0
		move.w  #$20,d7 
		jsr     (CopyBytes).w   
		addi.l  #$20,(dword_FFB1A0).l 
		movea.l (dword_FFB1A0).l,a1
		movea.l d5,a2
		move.l  a1,d5
loc_44D48:
		clr.w   d1
		move.b  (a2)+,d1
		bmi.w   loc_44D90
		move.w  #4,(a1)+
		tst.b   d1
		bne.s   loc_44D5E
		move.l  #$10000,(a1)+
loc_44D5E:
		cmpi.b  #1,d1
		bne.s   loc_44D6A
		move.l  #$FFFF,(a1)+
loc_44D6A:
		cmpi.b  #2,d1
		bne.s   loc_44D76
		move.l  #$FFFF0000,(a1)+
loc_44D76:
		cmpi.b  #3,d1
		bne.s   loc_44D82
		move.l  #1,(a1)+
loc_44D82:
		move.w  #1,(a1)+
		move.w  #0,(a1)+
		move.w  #$A,(a1)+
		bra.s   loc_44D48
loc_44D90:
		move.w  #$34,(a1)+ 
		move.l  d5,(a1)+
		move.l  a1,(dword_FFB1A0).l
		movem.l (sp)+,a0-a2
		move.w  (sp)+,d0
		rts

	; End of function sub_44D0E


; =============== S U B R O U T I N E =======================================

; In: D0 = entity idx

WaitForEntityToStopMoving:
		
		movem.w d0-d7,-(sp)
		move.l  a0,-(sp)
		bsr.w   GetEntityRAMAddress
loc_44DAE:
		move.w  (a0),d0
		move.w  ENTITYDEF_OFFSET_Y(a0),d1
		move.w  ENTITYDEF_OFFSET_XDEST(a0),d2
		move.w  ENTITYDEF_OFFSET_YDEST(a0),d3
		move.w  d2,d4
		move.w  d3,d5
		sub.w   d0,d4
		sub.w   d1,d5
		move.w  d5,d6
		or.w    d4,d6
		beq.s   loc_44DD0
		jsr     (WaitForVInt).w 
		bra.s   loc_44DAE
loc_44DD0:
		movea.l (sp)+,a0
		movem.w (sp)+,d0-d7
		rts

	; End of function WaitForEntityToStopMoving


; =============== S U B R O U T I N E =======================================

; location in memory of entity # D0 -> A0

GetEntityRAMAddress:
		
		lsl.w   #5,d0
		lea     ((ENTITY_DATA-$1000000)).w,a0
						; start of entity information
		adda.w  d0,a0
		rts

	; End of function GetEntityRAMAddress

