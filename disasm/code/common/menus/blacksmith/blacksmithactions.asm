
; ASM FILE code\common\menus\blacksmith\blacksmithactions.asm :
; 0x21A3A..0x21FD2 : Blacksmith functions

; Local variables:
;   4 = Item cost
;   8 = Current gold
;  $A = Buyer index
;  $C = Item index
;  $E = Material holder index
; $10 = Material index
; $12 = Material slot number
; $14 = Current shop index

; =============== S U B R O U T I N E =======================================

BlacksmithActions:
		
		movem.l d0-a5,-(sp)
		link    a6,#-$14
		moveq   #0,d1
		move.w  ((CURRENT_PORTRAIT-$1000000)).w,d0
		blt.s   loc_21A50
		jsr     j_InitPortraitWindow
loc_21A50:
		trap    #TEXTBOX
		dc.w $C2                ; "Welcome to the Dwarf{N}Craftsman!{D3}"
		trap    #TEXTBOX
		dc.w $C3                ; "We can create a great and{N}special weapon for you if you{N}have some special material.{W1}"
		bsr.s   sub_21A7E
		moveq   #0,d1
		move.w  ((CURRENT_PORTRAIT-$1000000)).w,d0
		blt.s   loc_21A68
		jsr     j_InitPortraitWindow
loc_21A68:
		trap    #TEXTBOX
		dc.w $C6                ; "{CLEAR}Thank you very much!{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		jsr     j_HidePortraitWindow
		unlk    a6
		movem.l (sp)+,d0-a5
		rts

	; End of function BlacksmithActions


; =============== S U B R O U T I N E =======================================

sub_21A7E:
		trap    #TEXTBOX
		dc.w $C7                ; "What kind of material do you{N}have?{D1}"
		trap    #TEXTBOX
		dc.w $FFFF
        jsr     j_HidePortraitWindow
        bsr.w   sub_21CD0
		move.w  #ITEMIDX_NOTHING,((word_FFB13A-$1000000)).w
		move.b  #1,((byte_FFB13C-$1000000)).w
		jsr     sub_10044
		cmpi.w  #$FFFF,d0
		beq.w   return_21CCE
		move.w  d0,-$E(a6)
		move.w  d1,-$12(a6)
		move.w  d2,-$10(a6)
        ; Loop through list of materials
		lea     MithrilShopMaterials(pc), a0
		clr.w   d7
        move.b  (a0)+,d7
        subq.b  #1,d7
		bcs.s   loc_21AD2
		clr.w   d0
		clr.w   d1
loc_21AC6:
		move.b  (a0)+,d0
		cmp.w   d0,d2
        beq.s   loc_21AD8
        addq.b  #1,d1
		dbf     d7,loc_21AC6
loc_21AD2:
		trap    #TEXTBOX
		dc.w $C8                ; "Sorry, I've never worked{N}with that before....{W1}"
		bra.w   loc_21CB8
loc_21AD8:
        move.w  d1,-$14(a6)     ; save loop count as shop index
loc_21ADC:
        ; Start buying process
		trap    #TEXTBOX
		dc.w $A2                ; "What do you want to buy?"
		jsr     sub_21CF2(pc)
		nop
		jsr     sub_1004C
		cmpi.w  #$FFFF,d0
		beq.w   loc_21CB8
		move.w  d0,-$C(a6)
		move.w  d0,d1
		jsr     j_GetItemDefAddress
		move.w  6(a0),-4(a6)
		move.w  -$C(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		clr.l   ((TEXT_NUMBER-$1000000)).w
		move.w  -4(a6),((word_FFB778-$1000000)).w
		trap    #TEXTBOX
		dc.w $A3                ; "The {ITEM} costs{N}{#} gold coins.{N}OK?"
		jsr     j_YesNoChoiceBox
		cmpi.w  #0,d0
		beq.s   loc_21B2C
loc_21B26:
		trap    #TEXTBOX
		dc.w $C5                ; "{CLEAR}What a pity!{W2}"
		bra.s   loc_21B44
loc_21B2C:
		jsr     j_GetGold
		move.l  d1,-8(a6)
		clr.l   d0
		move.w  -4(a6),d0
		cmp.l   d0,d1
		bcc.s   loc_21B4A
		trap    #TEXTBOX
		dc.w $CB                ; "You have to bring more{N}money.{W2}"
loc_21B44:
		trap    #TEXTBOX
		dc.w $FFFF
		bra.s   loc_21ADC
loc_21B4A:
		trap    #TEXTBOX
		dc.w $A6                ; "Who gets it?{W2}"
		trap    #TEXTBOX
		dc.w $FFFF
        bsr.w   sub_21CD0
		move.w  -$C(a6),((word_FFB13A-$1000000)).w
		move.b  #0,((byte_FFB13C-$1000000)).w
		jsr     sub_10044
		cmpi.w  #$FFFF,d0
		beq.s   loc_21B26
		move.w  d0,-$A(a6)
		moveq   #0,d1
		jsr     j_GetItemAndNumberOfItems
		cmpi.w  #4,d2
		bcs.s   loc_21B98
		move.w  -$A(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $D0                ; "{NAME}'s hands are are{N}full.  May I pass it to{N}somebody else?"
		jsr     j_YesNoChoiceBox
		cmpi.w  #0,d0
		beq.s   loc_21B4A
		bra.s   loc_21B26
loc_21B98:
		move.w  -$C(a6),d1
		jsr     j_GetItemType
		cmpi.w  #1,d2
		bne.s   loc_21BD0
		move.w  -$C(a6),d1
		move.w  -$A(a6),d0
		jsr     j_IsWeaponOrRingEquippable
		bcs.s   loc_21BD0
		move.w  -$A(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $A7                ; "{NAME} can't be{N}equipped with it.  OK?"
		jsr     j_YesNoChoiceBox
		cmpi.w  #0,d0
		bne.w   loc_21B4A
loc_21BD0:
		moveq   #0,d1
		move.w  -4(a6),d1
		jsr     j_DecreaseGold
		move.w  -$E(a6),d0
		move.w  -$12(a6),d1
		jsr     j_DropItemBySlot
		move.w  -$A(a6),d0
		move.w  -$C(a6),d1
		jsr     j_AddItem
		move.w  -$C(a6),d1
		move.w  -$A(a6),d0
		jsr     j_IsWeaponOrRingEquippable
		bcc.w   loc_21CB4
		trap    #TEXTBOX
		dc.w $AD                ; "{CLEAR}Equip it now?"
		jsr     j_YesNoChoiceBox
		cmpi.w  #0,d0
		bne.w   loc_21CB4
		move.w  -$C(a6),d1
		jsr     j_GetItemType
		cmpi.w  #1,d2
		bne.s   loc_21C56
		move.w  -$A(a6),d0
		jsr     j_GetEquippedWeapon
		cmpi.w  #$FFFF,d1
		beq.s   loc_21C80
		move.w  d2,d1
		jsr     j_UnequipItemIfNotCursed
		cmpi.w  #2,d2
		bne.s   loc_21C80
		move.w  -$A(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $B0                ; "{NAME} can't remove{N}the cursed equipment.{W2}"
		bra.s   loc_21CB4
loc_21C56:
		move.w  -$A(a6),d0
		jsr     j_GetEquippedRing
		cmpi.w  #$FFFF,d1
		beq.s   loc_21C80
		move.w  d2,d1
		jsr     j_UnequipItemIfNotCursed
		cmpi.w  #2,d2
		bne.s   loc_21C80
		move.w  -$A(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $B0                ; "{NAME} can't remove{N}the cursed equipment.{W2}"
		bra.s   loc_21CB4
loc_21C80:
		moveq   #0,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d2,d1
		subq.w  #1,d1
		jsr     j_EquipItem
		cmpi.w  #2,d2
		bne.s   loc_21CAE
		trap    #SOUND_COMMAND
		dc.w MUSIC_CURSED_ITEM  ; cursed item
		jsr     WaitForMusicResumeAndPlayerInput_Shop(pc)
		nop
		move.w  -$A(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $AF                ; "Gee, {NAME} gets{N}cursed.{W2}"
		bra.s   loc_21CB2
loc_21CAE:
		trap    #TEXTBOX
		dc.w $AE                ; "Ah, it suits you!{W2}"
loc_21CB2:
		bra.s   loc_21CB8
loc_21CB4:
		trap    #TEXTBOX
		dc.w $D1                ; "{CLEAR}Here you go!{N}It's a great weapon!{W2}"
loc_21CB8:
		trap    #TEXTBOX
		dc.w $C4                ; "{CLEAR}Anything else?"
		jsr     j_YesNoChoiceBox
		cmpi.w  #0,d0
		beq.w   sub_21A7E
		;trap    #TEXTBOX
		;dc.w $FFFF
return_21CCE:
		rts

	; End of function sub_21A7E


; =============== S U B R O U T I N E =======================================

sub_21CD0:
		jsr     j_UpdateForce
		move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,((word_FFB12E-$1000000)).w
		lea     ((TARGET_CHARACTERS_INDEX_LIST-$1000000)).w,a0
		lea     ((byte_FFB0AE-$1000000)).w,a1
		move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,d7
		subq.b  #1,d7
loc_21CEA:
		move.b  (a0)+,(a1)+
		dbf     d7,loc_21CEA
        rts

	; End of function sub_21CD0


; =============== S U B R O U T I N E =======================================

sub_21CF2:
		lea     ((byte_FFB0AE-$1000000)).w,a1
		bsr.s   GetMithrilShopDefAddress
		clr.w   d7
		move.b  (a0)+,d7
		move.w  d7,((word_FFB12E-$1000000)).w
		subq.b  #1,d7
loc_21D02:
		move.b  (a0)+,(a1)+
		dbf     d7,loc_21D02
		rts

	; End of function sub_21CF2


; =============== S U B R O U T I N E =======================================

GetMithrilShopDefAddress:

		movem.l d0/d7,-(sp)
		lea     MithrilShopItems(pc), a0
		clr.w   d7
		move.w  -$14(a6),d7
		subq.b  #1,d7
		bcs.s   loc_21D26
		clr.w   d0
loc_21D1E:
		move.b  (a0)+,d0
		adda.w  d0,a0
		dbf     d7,loc_21D1E
loc_21D26:
		movem.l (sp)+,d0/d7
		rts

	; End of function GetMithrilShopDefAddress

MithrilShopMaterials:
        dc.b   1        ; number of material indexes to loop through
        dc.b $7B        ; Mithril
MithrilShopItems:
        incbin "data\stats\items\mithrilshopitems.bin"
