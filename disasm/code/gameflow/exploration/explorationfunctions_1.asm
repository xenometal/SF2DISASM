
; ASM FILE code\gameflow\exploration\explorationfunctions_1.asm :
; 0x239C8..0x23A84 : Exploration functions

; START OF FUNCTION CHUNK FOR sub_23862

loc_239C8:
		clr.w   d0
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		cmpi.w  #CHEST_GOLD_AMOUNTS_START,d2
		blt.s   loc_239EE
		bsr.s   GetChestGoldAmount
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		jsr     j_IncreaseGold
		trap    #SOUND_COMMAND
		dc.w MUSIC_ITEM
		trap    #TEXTBOX
		dc.w $19E               ; "{NAME} found {#} gold{N}coins."
		bsr.w   FadeOut_WaitForP1Input
		bra.s   loc_23994
loc_239EE:
		move.w  d2,((TEXT_NAME_INDEX_2-$1000000)).w
		trap    #TEXTBOX
		dc.w $19D               ; "{NAME} found{N}{ITEM}.{W2}{CLEAR}"
		clr.w   d1
		jsr     j_GetItemAndNumberOfItems
		cmpi.w  #4,d2
		bge.s   loc_23A1E
		move.w  ((TEXT_NAME_INDEX_2-$1000000)).w,d1
		jsr     j_AddItem
		trap    #SOUND_COMMAND
		dc.w MUSIC_ITEM
		trap    #TEXTBOX
		dc.w $19F               ; "{NAME} recieved{N}{ITEM}."
		bsr.w   FadeOut_WaitForP1Input
		bra.w   loc_23994
loc_23A1E:
		jsr     j_UpdateForce
		lea     ((byte_FFB653-$1000000)).w,a0
		move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,d7
		subq.w  #2,d7
		bmi.w   loc_23A66
loc_23A32:
		clr.w   d0
		move.b  (a0)+,d0
		clr.w   d1
		jsr     j_GetItemAndNumberOfItems
		cmpi.w  #4,d2
		bge.s   loc_23A62
		move.w  ((TEXT_NAME_INDEX_2-$1000000)).w,d1
		jsr     j_AddItem
		move.w  d0,((TEXT_NAME_INDEX_3-$1000000)).w
		trap    #SOUND_COMMAND
		dc.w MUSIC_ITEM
		trap    #TEXTBOX
		dc.w $1A0               ; "{NAME} passed the{N}{ITEM} to {NAME}."
		bsr.w   FadeOut_WaitForP1Input
		bra.w   loc_23994
loc_23A62:
		dbf     d7,loc_23A32
loc_23A66:
		move.w  ((TEXT_NAME_INDEX_2-$1000000)).w,d3
		clr.w   d0
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $1A1               ; "But, everyone's hands are{N}full.{W1}"
		move.w  d4,d0
		move.w  d5,d1
		jsr     (CloseChest).w
		jsr     (RefillNonChestItem).w
		bra.w   loc_23994

; END OF FUNCTION CHUNK FOR sub_23862

