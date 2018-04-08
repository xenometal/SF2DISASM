
; ASM FILE code\gameflow\exploration\explorationfunctions_0.asm :
; 0x2379A..0x239AE : Exploration functions

; =============== S U B R O U T I N E =======================================

; Out: D0 = activated entity idx
;      D1 = activated entity's facing
;      D2 = player entity's facing

GetActivatedEntity:
		
		move.b  ((CAMERA_ENTITY-$1000000)).w,d0
		ext.w   d0
		bpl.s   loc_237A4
		rts
loc_237A4:
		; get X/Y/facing/size of player entity
		movem.l d3-a0,-(sp)
		lea     ((ENTITY_DATA-$1000000)).w,a0
		lsl.w   #5,d0
		adda.w  d0,a0
		move.w  (a0,d0.w),d1    ; get X
		move.w  2(a0,d0.w),d2   ; Y
		move.b  $10(a0,d0.w),d3 ; facing
		move.b  $11(a0,d0.w),d4 ; size ?
		andi.w  #3,d3
		move.w  d3,d5
		lsl.w   #2,d5
loc_237C8:
		; convert X/Y position from pixels into an offset for the Block table
		add.w   tbl_PixelOffsets_X(pc,d5.w),d1
		add.w   tbl_PixelOffsets_Y(pc,d5.w),d2
		move.w  d1,d6
		move.w  d2,d7
		ext.l   d6
		ext.l   d7
		divs.w  #$180,d6
		divs.w  #$180,d7
		lsl.w   #6,d7
		add.w   d6,d7
		add.w   d7,d7
		lea     (FF0000_RAM_START).l,a1
		move.w  (a1,d7.w),d7
		andi.w  #$3C00,d7
		cmpi.w  #$2800,d7
		beq.s   loc_237C8       ; continue offsetting position if encounter a "desk/counter" block flag
		clr.w   d0
		moveq   #$2F,d7 
loc_237FE:
		cmp.b   ((CAMERA_ENTITY-$1000000)).w,d0
		beq.w   loc_2382A       ; skip this entity because it's the player!
		bsr.w   CheckIfEntityIsFollower
		bne.w   loc_2382A       ; skip this entity because it's a follower!
		; get distance from activated block
		move.w  (a0),d5
		move.w  2(a0),d6
		sub.w   d1,d5
		bge.s   loc_2381A
		neg.w   d5
loc_2381A:
		sub.w   d2,d6
		bge.s   loc_23820
		neg.w   d6
loc_23820:
		add.w   d6,d5
		cmpi.w  #$180,d5
		bcs.w   loc_2383A       ; distance is less than 1 block
loc_2382A:
		addq.w  #1,d0
		lea     $20(a0),a0
		dbf     d7,loc_237FE
		moveq   #$FFFFFFFF,d0
		bra.w   loc_23840
loc_2383A:
		; distance is less than one block, 
		move.w  d3,d2
		move.b  $10(a0),d1
loc_23840:
		movem.l (sp)+,d3-a0
		rts

	; End of function GetActivatedEntity


; =============== S U B R O U T I N E =======================================

; In: D0 = entity idx
; Out: Z = entity is NOT follower

CheckIfEntityIsFollower:
		
		movem.l d0/a0,-(sp)
		lea     ((FOLLOWERS_LIST-$1000000)).w,a0
loc_2384E:
		cmpi.b  #$FF,(a0)
		beq.w   loc_2385C
		cmp.b   (a0)+,d0
		bne.s   loc_2384E
		moveq   #1,d0
loc_2385C:
		movem.l (sp)+,d0/a0
		rts

	; End of function CheckIfEntityIsFollower


; =============== S U B R O U T I N E =======================================

sub_23862:
		move.b  ((CAMERA_ENTITY-$1000000)).w,d0
		ext.w   d0
		bpl.s   loc_2386C
		rts
loc_2386C:
		clr.w   ((TEXT_NAME_INDEX_1-$1000000)).w
		clr.w   ((CURRENT_SPEAK_SOUND-$1000000)).w
		lea     ((ENTITY_DATA-$1000000)).w,a0
		lsl.w   #5,d0
		adda.w  d0,a0
		move.w  (a0,d0.w),d2
		move.w  ENTITYDEF_OFFSET_Y(a0,d0.w),d1
		move.b  $10(a0,d0.w),d3
		move.w  d2,d0
		andi.w  #3,d3
		move.w  d3,d5
		lsl.w   #2,d5
		lea     tbl_PixelOffsets_X(pc), a0
		add.w   (a0,d5.w),d0
		add.w   2(a0,d5.w),d1
		ext.l   d0
		ext.l   d1
		divs.w  #$180,d0
		divs.w  #$180,d1
		move.w  d0,d4
		move.w  d1,d5
		move.w  d1,d3
		lsl.w   #6,d3
		add.w   d0,d3
		add.w   d3,d3
		lea     (FF0000_RAM_START).l,a0
		move.w  (a0,d3.w),d3
		andi.w  #$3C00,d3
		cmpi.w  #$1800,d3
		bne.s   loc_238E8
		; block has chest flag set
		jsr     (OpenChest).w
		trap    #TEXTBOX
		dc.w $193               ; "{NAME} opened the chest.{W2}{CLEAR}"
		move.w  d2,d0
		andi.w  #ITEM_MASK_IDX,d0
		cmpi.b  #ITEMIDX_NOTHING,d0
		bne.w   loc_239C8
		trap    #TEXTBOX
		dc.w $198               ; "But, it was empty.{W1}"
		bra.w   loc_23994
loc_238E8:
		cmpi.w  #$2C00,d3
		bne.s   loc_2390C
		jsr     (CheckNonChestItem).w
		trap    #TEXTBOX
		dc.w $194               ; "{NAME} investigated{N}the vase.{W2}{CLEAR}"
		move.w  d2,d0
		andi.w  #ITEM_MASK_IDX,d0
		cmpi.b  #ITEMIDX_NOTHING,d0
		bne.w   loc_239C8
		trap    #TEXTBOX
		dc.w $199               ; "It was dark inside.{W1}"
		bra.w   loc_23994
loc_2390C:
		cmpi.w  #$3000,d3
		bne.s   loc_23930
		jsr     (CheckNonChestItem).w
		trap    #TEXTBOX
		dc.w $195               ; "{NAME} looked in{N}the barrel.{W2}{CLEAR}"
		move.w  d2,d0
		andi.w  #ITEM_MASK_IDX,d0
		cmpi.b  #ITEMIDX_NOTHING,d0
		bne.w   loc_239C8
		trap    #TEXTBOX
		dc.w $19A               ; "It was empty.{W1}"
		bra.w   loc_23994
loc_23930:
		cmpi.w  #$3400,d3
		bne.s   loc_23954
		jsr     (CheckNonChestItem).w
		trap    #TEXTBOX
		dc.w $1AB               ; "{NAME} investigated{N}the book shelves.{W2}{CLEAR}"
		move.w  d2,d0
		andi.w  #ITEM_MASK_IDX,d0
		cmpi.b  #ITEMIDX_NOTHING,d0
		bne.w   loc_239C8
		trap    #TEXTBOX
		dc.w $19C               ; "Nothing was there.{W1}"
		bra.w   loc_23994
loc_23954:
		cmpi.w  #$1C00,d3
		bne.s   loc_23978
		jsr     (CheckNonChestItem).w
		trap    #TEXTBOX
		dc.w $1A7               ; "{NAME} investigated{N}the area.{W2}{CLEAR}"
		move.w  d2,d0
		andi.w  #ITEM_MASK_IDX,d0
		cmpi.b  #ITEMIDX_NOTHING,d0
		bne.w   loc_239C8
		trap    #TEXTBOX
		dc.w $19C               ; "Nothing was there.{W1}"
		bra.w   loc_23994
loc_23978:
		jsr     j_RunMapSetupFunction
		bne.w   loc_23994
		tst.w   d6
		beq.s   loc_2398C
		clr.w   d0
		bra.w   return_2399A
loc_2398C:
		trap    #TEXTBOX
		dc.w $1A7               ; "{NAME} investigated{N}the area.{W2}{CLEAR}"
		trap    #TEXTBOX
		dc.w $19C               ; "Nothing was there.{W1}"
loc_23994:
		; finish up by closing windows
		trap    #TEXTBOX
		dc.w $FFFF
		moveq   #$FFFFFFFF,d0
return_2399A:
		rts

	; End of function sub_23862


; =============== S U B R O U T I N E =======================================

; get amount of gold (D2 - 0x80) as an offset from the gold table (see constants)

GetChestGoldAmount:
		
		subi.w  #CHEST_GOLD_AMOUNTS_START,d2
		andi.w  #ITEM_MASK_IDX,d2
		add.w   d2,d2
		move.w  ChestGoldAmounts(pc,d2.w),d1
		ext.l   d1
		rts

	; End of function GetChestGoldAmount

