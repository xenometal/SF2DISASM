
; ASM FILE code\gameflow\battle\battlescenes\battlesceneengine.asm :
; 0x18000..0x1FDEB : Battlescene engine

; =============== S U B R O U T I N E =======================================

j_rts:
		jmp     rts(pc)

	; End of function j_rts


; =============== S U B R O U T I N E =======================================

j_InitializeBattleScene:
		
		jmp     InitializeBattleScene(pc)

	; End of function j_InitializeBattleScene


; =============== S U B R O U T I N E =======================================

j_ExecuteBattleSceneScript:
		
		jmp     ExecuteBattleSceneScript(pc)

	; End of function j_ExecuteBattleSceneScript


; =============== S U B R O U T I N E =======================================

sub_1800C:
		jmp     sub_1924A(pc)

	; End of function sub_1800C


; =============== S U B R O U T I N E =======================================

rts:
		rts

	; End of function rts


; =============== S U B R O U T I N E =======================================

InitializeBattleScene:
		
		lea     ((dword_FFB3C0-$1000000)).w,a0
		move.l  #byte_FFB59A,d2
		subi.l  #dword_FFB3C0,d2
		lsr.l   #2,d2
		subq.w  #1,d2
loc_18026:
		clr.l   (a0)+
		dbf     d2,loc_18026
		move.w  d1,-(sp)
		move.w  d0,((BATTLESCENE_ENEMY-$1000000)).w
		bsr.w   GetBattleSpriteAndPalette
		move.w  d1,((ENEMY_BATTLE_SPRITE-$1000000)).w
		move.w  d2,((ENEMY_BATTLE_PALETTE-$1000000)).w
		move.w  d3,((word_FFB3E6-$1000000)).w
		move.w  (sp)+,d0
		move.w  d0,((BATTLESCENE_CHARACTER-$1000000)).w
		bsr.w   GetBattleSpriteAndPalette
		move.w  d1,((CHARACTER_BATTLE_SPRITE-$1000000)).w
		move.w  d2,((CHARACTER_BATTLE_PALETTE-$1000000)).w
		move.w  d3,((BATTLESCENE_ACTOR-$1000000)).w
		bsr.w   GetWeaponSpriteAndPalette
		move.w  d2,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		move.w  d3,((CHARACTER_WEAPON_PALETTE-$1000000)).w
		move.b  #$FF,((BATTLE_BACKGROUND-$1000000)).w
		bsr.w   FadeOutToBlackForBattlescene
		trap    #SOUND_COMMAND
		dc.w SOUND_COMMAND_FADE_OUT
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		bpl.s   loc_1807C
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
loc_1807C:
		bsr.w   GetBattleBackground
		move.w  d1,d0
		lea     (FF2000_LOADING_SPACE).l,a1
						; store it in RAM for DMA
		bsr.w   LoadBattleBackground
loc_1808C:
		jsr     (WaitForVInt).w 
		tst.b   ((FADING_SETTING-$1000000)).w
		bne.s   loc_1808C
		trap    #VINT_FUNCTIONS
		dc.w VINTS_CLEAR
		jsr     (WaitForVInt).w 
		jsr     (DisableDisplayAndVInt).w
		move.w  #$8B07,d0       ; set VScroll : each 2 cells, HScroll : each 1 line
		jsr     (SetVdpReg).w   
		jsr     (ClearSpriteTable).w
		moveq   #$3F,d0 
		jsr     (InitSprites).w 
		jsr     (sub_19B0).w
		bsr.w   InitializeBattleScenePalettes
		lea     (byte_FFC000).l,a0
		lea     (byte_FFE000).l,a1
		move.w  #$1FF,d0
loc_180CC:
		clr.l   (a0)+
		clr.l   (a1)+
		dbf     d0,loc_180CC
		lea     (byte_FFC000).l,a0
		lea     ($C000).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_10DC).w    
		lea     (byte_FFC000).l,a0
		lea     ($E000).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_10DC).w    
		bsr.w   sub_198C8
		lea     (byte_FFC000).l,a0
		lea     ($C000).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_10DC).w    
		lea     (FF2000_LOADING_SPACE).l,a0
		lea     ($7400).w,a1
		move.w  #$C00,d0
		moveq   #2,d1
		jsr     (sub_10DC).w    
		lea     (FF3800_LOADING_SPACE).l,a0
		lea     ($8C00).l,a1
		move.w  #$C00,d0
		moveq   #2,d1
		jsr     (sub_10DC).w    
		lea     ((byte_FFB542-$1000000)).w,a0
		lea     ((PALETTE_4_BIS-$1000000)).w,a1
		moveq   #7,d0
loc_1814E:
		move.l  (a0)+,(a1)+
		dbf     d0,loc_1814E
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.w   loc_18198
		bsr.w   sub_1EF36
		bset    #3,((byte_FFB56E-$1000000)).w
		bset    #5,((byte_FFB56E-$1000000)).w
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		clr.w   d1
		lea     ($4400).w,a1
		bsr.w   sub_1999E
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		bsr.w   GetEnemyBattleSpriteIdleAnimate
		lea     ($5C00).w,a1
		bsr.w   sub_1999E
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		move.w  ((ENEMY_BATTLE_PALETTE-$1000000)).w,d1
		bsr.w   sub_19970
loc_18198:
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.w   loc_1828C
		lea     byte_1F576(pc), a0
		lea     ((dword_FFDC88-$1000000)).w,a1
		lea     (byte_FFAFA1).l,a2
		moveq   #8,d0
loc_181B2:
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.b  #1,(a2)+
		dbf     d0,loc_181B2
		bset    #1,((byte_FFB56E-$1000000)).w
		bset    #4,((byte_FFB56E-$1000000)).w
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		clr.w   d1
		lea     ($2000).w,a1
		bsr.w   LoadAllyBattleSprite
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		bsr.w   GetAllyBattleSpriteIdleAnimate
		lea     ($3200).w,a1
		bsr.w   LoadAllyBattleSprite
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		move.w  ((CHARACTER_BATTLE_PALETTE-$1000000)).w,d1
		bsr.w   LoadPaletteForBattleScene
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		bsr.w   sub_19E6E
		move.b  d1,((BATTLE_BACKGROUND-$1000000)).w
		cmpi.w  #$FFFF,d1
		beq.w   loc_1822A
		lea     byte_1F686(pc), a0
		lea     ((dword_FFDCF0-$1000000)).w,a1
		lea     (word_FFAFAE).l,a2
		moveq   #2,d0
loc_18218:
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.b  #1,(a2)+
		dbf     d0,loc_18218
		move.w  d1,d0
		bsr.w   LoadBattleSceneGround
loc_1822A:
		move.w  ((CHARACTER_WEAPON_SPRITE-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.w   loc_1828C
		bsr.w   LoadWeaponSprite
		move.w  ((BATTLESCENE_ACTOR-$1000000)).w,d0
		movea.l (p_pt_AllyAnimations).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #4,a0
		move.l  (a0),((WEAPON_IDLE_FRAME1_IDX-$1000000)).w
		move.l  (a0),((WEAPON_FRAME_IDX-$1000000)).w
		move.w  $A(a0),((WEAPON_IDLE_FRAME2_X-$1000000)).w
		clr.w   d1
		bsr.w   sub_1955E
		lea     (FF2000_LOADING_SPACE).l,a0
		move.b  ((WEAPON_FRAME_IDX-$1000000)).w,d0
		andi.w  #7,d0
		ror.w   #5,d0
		lea     (a0,d0.w),a0
		lea     ($D800).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_10DC).w    
		move.w  ((CHARACTER_WEAPON_PALETTE-$1000000)).w,d0
		bsr.w   LoadWeaponPalette
loc_1828C:
		movea.l (p_statusAnimationTiles).l,a0
		lea     ($F600).l,a1
		move.w  #$270,d0
		moveq   #2,d1
		jsr     (DmaTilesViaFF8804).w
		bsr.w   sub_1928C
		move.w  ((ALLY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w,d0
		lsr.w   #1,d0
		move.w  d0,((ALLY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
		clr.b   ((byte_FFB581-$1000000)).w
		move.b  #$20,((byte_FFB580-$1000000)).w 
		jsr     (EnableInterrupts).w
		clr.w   d6
		jsr     (ClearHscrollStuff).w
		move.w  #$FFD4,d6
		bsr.w   sub_1F1CC
		clr.w   d6
		bsr.w   sub_1F1F0
		jsr     (WaitForVInt).w 
		move.w  #$FFEA,d6
		bsr.w   sub_1F214
		clr.w   d6
		bsr.w   sub_1F254
		jsr     (WaitForVInt).w 
		jsr     (sub_1942).w    
		trap    #VINT_FUNCTIONS
		dc.w VINTS_ADD
		dc.l VInt_UpdateBattlesceneGraphics
		jsr     sub_1001C
		trap    #VINT_FUNCTIONS
		dc.w VINTS_ADD
		dc.l VInt_UpdateWindows
		jsr     (EnableDisplayAndInterrupts).w
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   loc_18318
		clr.w   d1
		jsr     sub_10024
loc_18318:
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.w   loc_18342
		clr.w   d1
		jsr     sub_10020
		move.w  #$16,d0
		clr.w   d1
		movem.w d0-d1,-(sp)
		bsr.w   sub_193B2
		movem.w (sp)+,d0-d1
		bsr.w   sub_19504
loc_18342:
		jsr     (WaitForVInt).w 
		bsr.w   FadeInFromBlackIntoBattlescene
		clr.w   d0
		move.b  (SKIRMISH_MUSIC_INDEX).l,d0
		trap    #SOUND_COMMAND
		dc.w SOUND_COMMAND_GET_D0_PARAMETER
		moveq   #$15,d0
loc_18358:
		move.w  ((word_FFB3EA-$1000000)).w,d6
		addi.w  #2,d6
		bsr.w   sub_1F1CC
		move.w  #1,((word_FFB3F6-$1000000)).w
		move.w  #$FFFF,((word_FFB3FA-$1000000)).w
		cmpi.b  #$FF,((BATTLE_BACKGROUND-$1000000)).w
		beq.s   loc_18388
		lea     ((byte_FFDCF6-$1000000)).w,a0
		moveq   #2,d1
loc_1837E:
		subi.w  #1,(a0)
		addq.w  #8,a0
		dbf     d1,loc_1837E
loc_18388:
		jsr     (WaitForVInt).w 
		dbf     d0,loc_18358
loc_18390:
		tst.b   ((FADING_SETTING-$1000000)).w
		bne.s   loc_18390
		rts

	; End of function InitializeBattleScene


; =============== S U B R O U T I N E =======================================

ExecuteBattleSceneScript:
		
		lea     (FF0000_RAM_START).l,a6
		clr.w   ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
		move.b  #$FF,((DEAD_COMBATANTS_LIST-$1000000)).w
		clr.b   ((ACTOR_TO_MAKE_IDLE-$1000000)).w
loc_183AC:
		move.w  (a6)+,d0
		cmpi.w  #$FFFF,d0
		beq.s   loc_183EA
		add.w   d0,d0
		move.w  rjt_BattlesceneScriptCommands(pc,d0.w),d0
		jsr     rjt_BattlesceneScriptCommands(pc,d0.w)
		bra.s   loc_183AC
rjt_BattlesceneScriptCommands:
		
		dc.w bsc00_animateEnemyAction-rjt_BattlesceneScriptCommands
		dc.w bsc01_animateAllyAction-rjt_BattlesceneScriptCommands
		dc.w bsc02_moveEnemyBSprite-rjt_BattlesceneScriptCommands
						; not found any use case, still to figure out
		dc.w bsc03_moveAllyBSprite-rjt_BattlesceneScriptCommands
						; same as previous command
		dc.w bsc04_makeEnemyIdle-rjt_BattlesceneScriptCommands
		dc.w bsc05_makeAllyIdle-rjt_BattlesceneScriptCommands
		dc.w bsc06_switchEnemies-rjt_BattlesceneScriptCommands
		dc.w bsc07_switchAllies-rjt_BattlesceneScriptCommands
		dc.w bsc08_switchToEnemyAlone-rjt_BattlesceneScriptCommands
		dc.w bsc09_switchToAllyAlone-rjt_BattlesceneScriptCommands
		dc.w bsc0A_executeEnemyReaction-rjt_BattlesceneScriptCommands
		dc.w bsc0B_executeAllyReaction-rjt_BattlesceneScriptCommands
		dc.w bsc0C_makeActorIdleAndEndAnimation-rjt_BattlesceneScriptCommands
						; still to figure out exactly, not found any use case yet
		dc.w bsc0D_endAnimation-rjt_BattlesceneScriptCommands
						; still to figure out more precisely
		dc.w bsc0E_sleep-rjt_BattlesceneScriptCommands
		dc.w bsc0F_giveEXP-rjt_BattlesceneScriptCommands
		dc.w bsc10_displayMessage-rjt_BattlesceneScriptCommands
		dc.w bsc11_displayMessageWithNoWait-rjt_BattlesceneScriptCommands
		dc.w j_hideTextBox-rjt_BattlesceneScriptCommands
		dc.w j_WaitForPlayerInput-rjt_BattlesceneScriptCommands
		dc.w nullsub_10-rjt_BattlesceneScriptCommands
loc_183EA:
		clr.w   d0
		rts

	; End of function ExecuteBattleSceneScript


; =============== S U B R O U T I N E =======================================

j_WaitForPlayerInput:
		
		jmp     (WaitForPlayerInput).w

	; End of function j_WaitForPlayerInput


; =============== S U B R O U T I N E =======================================

nullsub_10:
		rts

	; End of function nullsub_10


; =============== S U B R O U T I N E =======================================

; xx      animation type index (0000 for attack, 0001 for dodge, 0002 for magic/item -- others (i.e. MMNK crit, RBT laser, BRGN flashing)
; yy      magic/item/projectile animation idx, set 0x0080 to come from enemy

bsc00_animateEnemyAction:
		
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.w   EndBattlesceneAnimation
		cmpi.w  #$FFFF,(a6)
		beq.w   AnimateSpell
		move.b  #2,((ACTOR_TO_MAKE_IDLE-$1000000)).w
		bclr    #3,((byte_FFB56E-$1000000)).w
		bclr    #5,((byte_FFB56E-$1000000)).w
		move.w  (a6)+,d1
		bsr.w   sub_19838
		clr.w   d7
		move.b  (a0)+,d7
		clr.w   d6
		move.b  (a0)+,d6
		move.w  (a6)+,d5
		move.b  (a0)+,d0
		move.w  #$80,d3 
		bsr.w   sub_184B0
		clr.w   d4
		move.b  (a0)+,d4
		move.w  d4,-(sp)
		tst.w   d6
		bne.s   loc_1844E
		move.l  a0,-(sp)
		movem.w d5-d7,-(sp)
		move.w  d5,d0
		bsr.w   ExecuteSpellAnimation
		movem.w (sp)+,d5-d7
		movea.l (sp)+,a0
loc_1844E:
		move.w  d7,d0
		sub.w   d6,d0
		move.w  d0,d6
		subq.w  #1,d7
		bmi.w   loc_18496
loc_1845A:
		move.b  (a0)+,d0
		ext.w   d0
		clr.w   d3
		move.b  (a0)+,d3
		move.w  (a0)+,d1
		move.w  d3,-(sp)
		move.l  a0,-(sp)
		movem.w d5-d7,-(sp)
		bsr.w   sub_19464
		movem.w (sp)+,d5-d7
		movea.l (sp)+,a0
		cmp.w   d7,d6
		bne.s   loc_1848C
		move.l  a0,-(sp)
		movem.w d5-d7,-(sp)
		move.w  d5,d0
		bsr.w   ExecuteSpellAnimation
		movem.w (sp)+,d5-d7
		movea.l (sp)+,a0
loc_1848C:
		move.w  (sp)+,d0
		jsr     (Sleep).w       
		dbf     d7,loc_1845A
loc_18496:
		move.w  (sp)+,d0
		bne.w   bsc0D_endAnimation
		rts

	; End of function bsc00_animateEnemyAction


; =============== S U B R O U T I N E =======================================

AnimateSpell:
		move.w  2(a6),d0
		cmpi.w  #$FFFF,d0
		beq.s   EndBattlesceneAnimation
		bsr.w   ExecuteSpellAnimation

	; End of function AnimateSpell


; START OF FUNCTION CHUNK FOR bsc00_animateEnemyAction

EndBattlesceneAnimation:
		
		addq.w  #4,a6
		rts

; END OF FUNCTION CHUNK FOR bsc00_animateEnemyAction


; =============== S U B R O U T I N E =======================================

sub_184B0:
		cmpi.w  #1,d1
		beq.w   loc_184E0
		cmpi.w  #2,d1
		beq.w   return_184E6
		tst.w   d5
		beq.w   loc_184CE
		cmpi.w  #$FFFF,d5
		bne.w   return_184E6
loc_184CE:
		cmpi.b  #$FF,d0
		bne.s   loc_184D8
		ext.w   d0
		bra.s   loc_184DC
loc_184D8:
		andi.w  #$FF,d0
loc_184DC:
		move.w  d0,d5
		rts
loc_184E0:
		move.w  d3,d5
		ori.w   #$38,d5 
return_184E6:
		rts

	; End of function sub_184B0


; =============== S U B R O U T I N E =======================================

; xx      animation type index (0000 for attack, 0001 for dodge, 0002 for magic/item -- others (i.e. MMNK crit, RBT laser, BRGN flashing)
; yy      magic/item/projectile animation idx, set 0x0080 to come from enemy

bsc01_animateAllyAction:
		
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.s   EndBattlesceneAnimation
		cmpi.w  #$FFFF,(a6)
		beq.s   AnimateSpell
		move.b  #1,((ACTOR_TO_MAKE_IDLE-$1000000)).w
		bclr    #1,((byte_FFB56E-$1000000)).w
		bclr    #4,((byte_FFB56E-$1000000)).w
		move.w  (a6)+,d1        ; animation type
		bsr.w   GetAllyAnimation
		clr.w   d7
		move.b  (a0)+,d7
		clr.w   d6
		move.b  (a0)+,d6
		move.w  (a6)+,d5        ; magic/item/projectile animation
		move.b  (a0)+,d0
		clr.w   d3
		bsr.s   sub_184B0
		clr.w   d4
		move.b  (a0)+,d4
		lea     $C(a0),a0
		move.w  d4,-(sp)
		tst.w   d6
		bne.s   loc_1853E
		move.l  a0,-(sp)
		movem.w d5-d7,-(sp)
		move.w  d5,d0
		bsr.w   ExecuteSpellAnimation
		movem.w (sp)+,d5-d7
		movea.l (sp)+,a0
loc_1853E:
		move.w  d7,d0
		sub.w   d6,d0
		move.w  d0,d6
		subq.w  #2,d7
		bmi.w   loc_185C0
loc_1854A:
		move.b  (a0)+,d0
		ext.w   d0
		clr.w   d3
		move.b  (a0)+,d3
		move.w  (a0)+,d1
		move.l  (a0)+,((WEAPON_FRAME_IDX-$1000000)).w
		move.w  d3,-(sp)
		move.l  a0,-(sp)
		movem.w d5-d7,-(sp)
		bsr.w   sub_19366
		cmpi.w  #$FFFF,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		beq.s   loc_18596
		clr.w   d0
		move.b  ((WEAPON_FRAME_IDX-$1000000)).w,d0
		andi.w  #7,d0
		ror.w   #5,d0
		lea     (FF2000_LOADING_SPACE).l,a0
		adda.w  d0,a0
		lea     ($D800).l,a1
		move.w  #$400,d0
		move.w  #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
loc_18596:
		movem.w (sp)+,d5-d7
		movea.l (sp)+,a0
		cmp.w   d7,d6
		bne.s   loc_185B2
		move.l  a0,-(sp)
		movem.w d5-d7,-(sp)
		move.w  d5,d0
		bsr.w   ExecuteSpellAnimation
		movem.w (sp)+,d5-d7
		movea.l (sp)+,a0
loc_185B2:
		jsr     (sub_1942).w    
		move.w  (sp)+,d0
		jsr     (Sleep).w       
		dbf     d7,loc_1854A
loc_185C0:
		move.w  (sp)+,d4
		bne.w   bsc0D_endAnimation
		rts

	; End of function bsc01_animateAllyAction


; =============== S U B R O U T I N E =======================================

; like previous bsc but for battlescene ally

bsc03_moveAllyBSprite:
		
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.s   return_185DC
		move.w  (a6)+,((word_FFB3FA-$1000000)).w
		move.w  (a6),((word_FFB3FC-$1000000)).w
		jsr     (WaitForVInt).w 
return_185DC:
		rts

	; End of function bsc03_moveAllyBSprite


; =============== S U B R O U T I N E =======================================

; set a long value at FFB3F6, related to battlescene enemy

bsc02_moveEnemyBSprite:
		
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.s   return_185F2
		move.w  (a6)+,((word_FFB3F6-$1000000)).w
		move.w  (a6),((word_FFB3F8-$1000000)).w
						; no + ... is it the next bsc ?
		jsr     (WaitForVInt).w 
return_185F2:
		rts

	; End of function bsc02_moveEnemyBSprite


; =============== S U B R O U T I N E =======================================

; related to battlescene ally

bsc05_makeAllyIdle:
		
		btst    #4,((byte_FFB56F-$1000000)).w
		bne.w   loc_1A418
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.w   return_18698
		bclr    #1,((byte_FFB56E-$1000000)).w
		move.l  ((WEAPON_IDLE_FRAME1_IDX-$1000000)).w,((WEAPON_FRAME_IDX-$1000000)).w
		bsr.w   sub_192FE
		btst    #0,((byte_FFB56E-$1000000)).w
		beq.s   loc_18624
		clr.w   d0
		bra.s   loc_1862E
loc_18624:
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		bsr.w   GetAllyBattleSpriteIdleAnimate
		move.w  d1,d0
loc_1862E:
		clr.w   d1
		bsr.w   sub_1938C
		cmpi.w  #$FFFF,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		beq.s   loc_18664
		lea     (FF2000_LOADING_SPACE).l,a0
		move.b  ((WEAPON_FRAME_IDX-$1000000)).w,d0
		andi.w  #7,d0
		ror.w   #5,d0
		adda.w  d0,a0
		lea     ($D800).l,a1
		move.w  #$400,d0
		move.w  #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
loc_18664:
		move.w  ((ALLY_BATTLESPRITE_ANIM_SPEED-$1000000)).w,d0
		jsr     (Sleep).w       
		btst    #0,((byte_FFB56E-$1000000)).w
		beq.s   loc_18678
		clr.w   d0
		bra.s   loc_18682
loc_18678:
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		bsr.w   GetAllyBattleSpriteIdleAnimate
		move.w  d1,d0
loc_18682:
		clr.w   d1
		bsr.w   sub_1938C
		jsr     (sub_1942).w    
		bset    #1,((byte_FFB56E-$1000000)).w
		bset    #4,((byte_FFB56E-$1000000)).w
return_18698:
		rts

	; End of function bsc05_makeAllyIdle


; =============== S U B R O U T I N E =======================================

; related to battlescene enemy

bsc04_makeEnemyIdle:
		
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.s   return_186D8
		bclr    #3,((byte_FFB56E-$1000000)).w
		bsr.w   sub_19296
		clr.w   d0
		clr.w   d1
		bsr.w   sub_19464
		move.w  ((ENEMY_BATTLESPRITE_ANIM_SPEED-$1000000)).w,d0
		jsr     (Sleep).w       
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		bsr.w   GetEnemyBattleSpriteIdleAnimate
		move.w  d1,d0
		clr.w   d1
		bsr.w   sub_19464
		bset    #3,((byte_FFB56E-$1000000)).w
		bset    #5,((byte_FFB56E-$1000000)).w
return_186D8:
		rts

	; End of function bsc04_makeEnemyIdle


; =============== S U B R O U T I N E =======================================

; xx      Character index.
; yy      0000 for right side, 0001 for left side

bsc07_switchAllies:
		
		cmpi.b  #1,((byte_FFB589-$1000000)).w
		beq.s   bsc07_switchAllies; loop as long as value 1
		move.b  #2,((byte_FFB589-$1000000)).w
		bclr    #1,((byte_FFB56E-$1000000)).w
		move.w  (a6)+,d7
		move.w  (a6)+,d6
		move.w  d7,d0
		cmpi.w  #$FFFF,d0
		beq.s   loc_18736
		bsr.w   GetBattleSpriteAndPalette
		move.w  d1,d0
		bsr.w   LoadNewAllyBattleSprite
		move.w  d1,d0
		move.w  d2,d1
		bsr.w   LoadPaletteForBattleScene
		move.w  d7,d0
		bsr.w   sub_19E6E
		cmpi.w  #$FFFF,d1
		beq.s   loc_1871E
		move.w  d1,d0
		bsr.w   sub_19BCC       
loc_1871E:
		move.w  d7,d0
		bsr.w   GetWeaponSpriteAndPalette
		cmpi.w  #$FFFF,d2
		beq.s   loc_18736
		move.w  d2,d0
		bsr.w   LoadWeaponSprite
		move.w  d3,d0
		bsr.w   LoadWeaponPalette
loc_18736:
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.s   loc_18754
		btst    #1,d6
		bne.s   loc_1874A
		move.w  #$190,d1
		bra.s   loc_1874E
loc_1874A:
		move.w  #$10,d1
loc_1874E:
		bsr.w   sub_188D4
		bra.s   loc_18758
loc_18754:
		bsr.w   sub_19952
loc_18758:
		jsr     sub_10028
		move.w  d7,((BATTLESCENE_CHARACTER-$1000000)).w
		move.w  d7,d0
		bsr.w   GetBattleSpriteAndPalette
		move.w  d1,((CHARACTER_BATTLE_SPRITE-$1000000)).w
		move.w  d2,((CHARACTER_BATTLE_PALETTE-$1000000)).w
		move.w  d3,((BATTLESCENE_ACTOR-$1000000)).w
		bsr.w   GetWeaponSpriteAndPalette
		move.w  d2,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		move.w  d3,((CHARACTER_WEAPON_PALETTE-$1000000)).w
		clr.b   ((byte_FFB57E-$1000000)).w
		andi.b  #$FC,((byte_FFB56F-$1000000)).w
		cmpi.w  #$FFFF,d7
		beq.w   loc_19912
		move.w  #$108,d1
		tst.w   d6
		beq.s   loc_187AA
		cmpi.w  #3,d6
		beq.s   loc_187AA
		move.w  #$98,d1 
		ori.b   #3,((byte_FFB56F-$1000000)).w
loc_187AA:
		move.w  d1,-(sp)
		cmpi.w  #3,d6
		beq.s   loc_187B8
		move.w  #$FF08,d0
		bra.s   loc_187BC
loc_187B8:
		move.w  #$88,d0 
loc_187BC:
		move.w  d0,-(sp)
		move.w  d0,-(sp)
		lea     (FF6802_LOADING_SPACE).l,a0
		lea     ($2000).w,a1
		move.w  #$900,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
		lea     (FF7A02_LOADING_SPACE).l,a0
		lea     ($3200).w,a1
		move.w  #$900,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		bsr.w   sub_19E6E
		move.b  d1,((BATTLE_BACKGROUND-$1000000)).w
		cmpi.w  #$FFFF,d1
		beq.s   loc_18818
		lea     (byte_FF8C02).l,a0
		lea     ($F000).l,a1
		move.w  #$300,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
loc_18818:
		move.w  ((CHARACTER_WEAPON_SPRITE-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.w   loc_1888C
		move.w  ((BATTLESCENE_ACTOR-$1000000)).w,d0
		movea.l (p_pt_AllyAnimations).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #4,a0
		move.l  (a0),((WEAPON_IDLE_FRAME1_IDX-$1000000)).w
		move.l  (a0),((WEAPON_FRAME_IDX-$1000000)).w
		move.w  $A(a0),((WEAPON_IDLE_FRAME2_X-$1000000)).w
		btst    #1,((byte_FFB56F-$1000000)).w
		beq.s   loc_18864
		moveq   #$20,d0 
		sub.b   ((WEAPON_FRAME_X-$1000000)).w,d0
		move.b  d0,((WEAPON_IDLE_FRAME1_X-$1000000)).w
		move.b  d0,((WEAPON_FRAME_X-$1000000)).w
		moveq   #$20,d0 
		sub.b   ((WEAPON_IDLE_FRAME2_X-$1000000)).w,d0
		move.b  d0,((WEAPON_IDLE_FRAME2_X-$1000000)).w
loc_18864:
		lea     (FF2000_LOADING_SPACE).l,a0
		move.b  ((WEAPON_FRAME_IDX-$1000000)).w,d0
		andi.w  #7,d0
		ror.w   #5,d0
		adda.w  d0,a0
		lea     ($D800).l,a1
		move.w  #$400,d0
		move.w  #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
loc_1888C:
		bsr.w   sub_1892A
		move.w  (sp)+,d0
		clr.w   d1
		bsr.w   sub_193B2
		move.w  (sp)+,d0
		clr.w   d1
		bsr.w   sub_19504
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		move.b  ((byte_FFB56F-$1000000)).w,d1
		andi.w  #2,d1
		jsr     sub_10020
		bsr.w   sub_192FE
		jsr     (sub_1942).w    
		move.w  (sp)+,d1
		bsr.s   sub_188D4
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.s   loc_188CC
		bset    #1,((byte_FFB56E-$1000000)).w
loc_188CC:
		move.b  #3,((byte_FFB589-$1000000)).w
		rts

	; End of function bsc07_switchAllies


; =============== S U B R O U T I N E =======================================

sub_188D4:
		move.w  ((word_FFB3F2-$1000000)).w,d0
		cmp.w   d1,d0
		beq.s   return_18928
		bge.s   loc_188F4
		sub.w   d1,d0
		neg.w   d0
		cmpi.w  #2,d0
		bls.w   return_18928
		cmpi.w  #$10,d0
		bls.s   loc_188F2
		moveq   #$10,d0
loc_188F2:
		bra.s   loc_18908
loc_188F4:
		sub.w   d1,d0
		cmpi.w  #2,d0
		bls.w   return_18928
		cmpi.w  #$10,d0
		bls.s   loc_18906
		moveq   #$10,d0
loc_18906:
		neg.w   d0
loc_18908:
		move.w  d0,((word_FFB3FA-$1000000)).w
		cmpi.b  #$FF,((BATTLE_BACKGROUND-$1000000)).w
		beq.s   loc_18922
		lea     ((byte_FFDCF6-$1000000)).w,a0
		moveq   #2,d2
loc_1891A:
		add.w   d0,(a0)
		addq.w  #8,a0
		dbf     d2,loc_1891A
loc_18922:
		jsr     (WaitForVInt).w 
		bra.s   sub_188D4
return_18928:
		rts

	; End of function sub_188D4


; =============== S U B R O U T I N E =======================================

sub_1892A:
		lea     ((PALETTE_1_BIS-$1000000)).w,a0
		lea     ((PALETTE_1-$1000000)).w,a1
		moveq   #$1F,d0
loc_18934:
		move.l  (a0)+,(a1)+
		dbf     d0,loc_18934
		bra.w   sub_1A092

	; End of function sub_1892A


; =============== S U B R O U T I N E =======================================

; xx      Character index.
; yy      0000 for right side, 0001 for left side

bsc06_switchEnemies:
		
		cmpi.b  #1,((byte_FFB589-$1000000)).w
		beq.s   bsc06_switchEnemies; loop as long as value 1
		move.b  #2,((byte_FFB589-$1000000)).w
		andi.b  #$C,((byte_FFB583-$1000000)).w
		bclr    #3,((byte_FFB56E-$1000000)).w
		clr.w   d6
		bsr.w   sub_1F1CC
		clr.w   d6
		bsr.w   sub_1F1F0
		lea     ((word_FFDCF4-$1000000)).w,a0
		bset    #7,(a0)
		bset    #7,8(a0)
		bset    #7,$10(a0)
		move.w  (a6),d0
		bsr.w   GetBattleSpriteAndPalette
		move.w  d1,d0
		bsr.w   LoadEnemyBattleSprite
		movea.l (p_pt_battlesceneTransitionTiles).l,a2
		movea.l (a2)+,a0
		move.l  a2,-(sp)
		lea     (FF6802_LOADING_SPACE).l,a1
		jsr     (LoadCompressedData).w
		movea.l (sp)+,a2
		movea.l (a2),a0
		lea     (FF8002_LOADING_SPACE).l,a1
		jsr     (LoadCompressedData).w
		move.w  (a6),d0
		bpl.s   loc_189AE
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
loc_189AE:
		bsr.w   GetBattleBackground
		move.w  d1,d0
		move.w  d0,-(sp)
		lea     (FF2000_LOADING_SPACE).l,a1
		bsr.w   LoadBattleBackground
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		jsr     sub_1002C
		bsr.w   sub_198C8
		move.w  (sp)+,d0
		move.w  2(a6),d1
		bsr.w   sub_19E96
		bcc.s   loc_189DC
		moveq   #4,d1
loc_189DC:
		move.w  d1,-(sp)
		btst    #1,d1
		bne.s   loc_189FC
		move.w  #$FF70,d1
		clr.w   d2
		lea     (FF6802_LOADING_SPACE).l,a0
		lea     ($7400).w,a1
		lea     (byte_FFC180).l,a2
		bra.s   loc_18A14
loc_189FC:
		move.w  #$F0,d1 
		moveq   #1,d2
		lea     (byte_FF9202).l,a0
		lea     (loc_9E00).l,a1
		lea     (byte_FFC1B8).l,a2
loc_18A14:
		moveq   #7,d0
		moveq   #0,d6
loc_18A18:
		movem.w d0-d2,-(sp)
		bsr.w   sub_18D14
		tst.w   d2
		bne.s   loc_18A2A
		bsr.w   sub_18C1E
		bra.s   loc_18A2E
loc_18A2A:
		bsr.w   sub_18C94
loc_18A2E:
		jsr     (WaitForVInt).w 
		movem.w (sp)+,d0-d2
		dbf     d0,loc_18A18
		move.w  (a6),d0
		move.w  d0,((BATTLESCENE_ENEMY-$1000000)).w
		bsr.w   GetBattleSpriteAndPalette
		move.w  d1,((ENEMY_BATTLE_SPRITE-$1000000)).w
		move.w  d2,((ENEMY_BATTLE_PALETTE-$1000000)).w
		move.w  d3,((word_FFB3E6-$1000000)).w
		move.w  (sp)+,d2
		clr.b   ((byte_FFB57F-$1000000)).w
		bclr    #2,((byte_FFB56F-$1000000)).w
		clr.w   d1
		move.w  #$F0,d6 
		tst.w   d2
		beq.s   loc_18A7C
		cmpi.w  #3,d2
		bcc.s   loc_18A78
		move.w  #$60,d1 
		bset    #2,((byte_FFB56F-$1000000)).w
		bra.s   loc_18A7C
loc_18A78:
		move.w  #$FF70,d6
loc_18A7C:
		movem.w d1-d2,-(sp)
		bsr.w   sub_1F214
		clr.w   d6
		bsr.w   sub_1F254
		cmpi.w  #$FFFF,d0
		bne.s   loc_18A96
		bsr.w   sub_19926
		bra.s   loc_18AAC
loc_18A96:
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		move.w  ((ENEMY_BATTLE_PALETTE-$1000000)).w,d1
		bsr.w   sub_19970
		bset    #2,((byte_FFB56E-$1000000)).w
		bsr.w   sub_1EF2E
loc_18AAC:
		lea     ((byte_FFB542-$1000000)).w,a0
		lea     ((PALETTE_4_BIS-$1000000)).w,a1
		moveq   #7,d0
loc_18AB6:
		move.l  (a0)+,(a1)+
		dbf     d0,loc_18AB6
		bsr.w   sub_1892A
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   loc_18ACE
		bsr.w   sub_19296
loc_18ACE:
		movem.w (sp)+,d1-d2
		cmpi.w  #3,d2
		bcc.s   loc_18AEC
		clr.w   d2
		lea     (FF2000_LOADING_SPACE).l,a0
		lea     ($7400).w,a1
		lea     (byte_FFC180).l,a2
		bra.s   loc_18AFE
loc_18AEC:
		lea     (byte_FF4A00).l,a0
		lea     (loc_9E00).l,a1
		lea     (byte_FFC1B8).l,a2
loc_18AFE:
		jsr     (WaitForVInt).w 
		moveq   #7,d0
		clr.w   d3
		moveq   #0,d6
loc_18B08:
		movem.w d0-d3,-(sp)
		bsr.w   sub_18BAA
		bsr.w   sub_18D14
		tst.w   d2
		bne.s   loc_18B1E
		bsr.w   sub_18C1E
		bra.s   loc_18B22
loc_18B1E:
		bsr.w   sub_18C94
loc_18B22:
		jsr     (WaitForVInt).w 
		movem.w (sp)+,d0-d3
		addq.w  #1,d3
		dbf     d0,loc_18B08
loc_18B30:
		bsr.w   sub_18D14
		jsr     (WaitForVInt).w 
		tst.w   d0
		bne.s   loc_18B30
		lea     ((word_FFDCF4-$1000000)).w,a0
		bclr    #7,(a0)
		bclr    #7,8(a0)
		bclr    #7,$10(a0)
		clr.w   d6
		bsr.w   sub_1F1CC
		jsr     (WaitForVInt).w 
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   loc_18B8C
		move.b  ((byte_FFB56F-$1000000)).w,d1
		andi.w  #4,d1
		jsr     sub_10024
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		bsr.w   GetEnemyBattleSpriteIdleAnimate
		lea     ($5C00).w,a1
		bsr.w   sub_199BC
		bsr.w   sub_1F540
		bset    #3,((byte_FFB56E-$1000000)).w
loc_18B8C:
		ori.b   #3,((byte_FFB583-$1000000)).w
		move.w  ((CHARACTER_WEAPON_SPRITE-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   loc_18BA0
		bsr.w   LoadWeaponSprite
loc_18BA0:
		addq.w  #4,a6
		move.b  #3,((byte_FFB589-$1000000)).w
		rts

	; End of function bsc06_switchEnemies


; =============== S U B R O U T I N E =======================================

sub_18BAA:
		cmpi.w  #3,d3
		bhi.s   return_18BFC
		movem.l d0-d2/a0-a2,-(sp)
		lea     off_18BFE(pc), a0
		nop
		lsl.w   #3,d3
		movea.l 4(a0,d3.w),a1
		movea.l (a0,d3.w),a0
		cmpi.w  #8,d3
		beq.s   loc_18BD6
		move.w  #$300,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		bra.s   loc_18BF4
loc_18BD6:
		move.w  #$100,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		lea     (word_FF9802).l,a0
		lea     ($4C00).w,a1
		move.w  #$200,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
loc_18BF4:
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,d0-d2/a0-a2
return_18BFC:
		rts
off_18BFE:
		dc.l FF5000_LOADING_SPACE
		dc.l $4400
		dc.l FF5600_LOADING_SPACE
		dc.l $4A00
		dc.l FF9C02_LOADING_SPACE
		dc.l $5000
		dc.l FFA202_LOADING_SPACE
		dc.l $5600

	; End of function sub_18BAA


; =============== S U B R O U T I N E =======================================

sub_18C1E:
		subi.w  #$20,d6 
		move.w  d6,-(sp)
		bsr.w   sub_1F1CC
		move.w  #$300,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
		movem.l a0-a2,-(sp)
		bchg    #7,(a2)
		bchg    #7,2(a2)
		bchg    #7,4(a2)
		bchg    #7,6(a2)
		lea     $40(a2),a2
		moveq   #$B,d0
		move.b  #$A0,d1
loc_18C5A:
		eor.b   d1,(a2)
		eor.b   d1,2(a2)
		eor.b   d1,4(a2)
		eor.b   d1,6(a2)
		lea     $40(a2),a2
		dbf     d0,loc_18C5A
		lea     (byte_FFC180).l,a0
		lea     ($C180).l,a1
		move.w  #$1A0,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,a0-a2
		addq.w  #8,a2
		move.w  (sp)+,d6
		rts

	; End of function sub_18C1E


; =============== S U B R O U T I N E =======================================

sub_18C94:
		addi.w  #$20,d6 
		move.w  d6,-(sp)
		bsr.w   sub_1F1CC
		movem.l a0-a2,-(sp)
		move.w  #$300,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
		bchg    #7,(a2)
		bchg    #7,2(a2)
		bchg    #7,4(a2)
		bchg    #7,6(a2)
		lea     $40(a2),a2
		moveq   #$B,d0
		move.b  #$A0,d1
loc_18CD0:
		eor.b   d1,(a2)
		eor.b   d1,2(a2)
		eor.b   d1,4(a2)
		eor.b   d1,6(a2)
		lea     $40(a2),a2
		dbf     d0,loc_18CD0
		lea     (byte_FFC180).l,a0
		lea     ($C180).l,a1
		move.w  #$1A0,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,a0-a2
		lea     -$600(a0),a0
		lea     -$600(a1),a1
		lea     -8(a2),a2
		move.w  (sp)+,d6
		rts

	; End of function sub_18C94


; =============== S U B R O U T I N E =======================================

sub_18D14:
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.s   loc_18D56
		move.w  ((word_FFB3EC-$1000000)).w,d0
		cmp.w   d1,d0
		beq.s   loc_18D56
		bge.s   loc_18D3C
		sub.w   d1,d0
		neg.w   d0
		cmpi.w  #2,d0
		bls.w   loc_18D56
		cmpi.w  #$10,d0
		bls.s   loc_18D3A
		moveq   #$10,d0
loc_18D3A:
		bra.s   loc_18D50
loc_18D3C:
		sub.w   d1,d0
		cmpi.w  #2,d0
		bls.w   loc_18D56
		cmpi.w  #$10,d0
		bls.s   loc_18D4E
		moveq   #$10,d0
loc_18D4E:
		neg.w   d0
loc_18D50:
		move.w  d0,((word_FFB3F6-$1000000)).w
		rts
loc_18D56:
		clr.w   d0
		rts

	; End of function sub_18D14


; =============== S U B R O U T I N E =======================================

; xx enemy index

bsc08_switchToEnemyAlone:
		
		move.w  (a6)+,((word_FFB3FE-$1000000)).w
		move.l  a6,-(sp)
		lea     ((byte_FFB562-$1000000)).w,a6
		move.w  #$FFFF,(a6)
		clr.w   2(a6)
		bsr.w   bsc07_switchAllies
		lea     ((byte_FFB562-$1000000)).w,a6
		move.w  ((word_FFB3FE-$1000000)).w,(a6)
		move.w  #3,2(a6)
		bsr.w   bsc06_switchEnemies
		bset    #5,((byte_FFB56E-$1000000)).w
		movea.l (sp)+,a6
		rts

	; End of function bsc08_switchToEnemyAlone


; =============== S U B R O U T I N E =======================================

; xx ally index

bsc09_switchToAllyAlone:
		
		move.w  (a6)+,((word_FFB3FE-$1000000)).w
		move.l  a6,-(sp)
		lea     ((byte_FFB562-$1000000)).w,a6
		move.w  #$FFFF,(a6)
		clr.w   2(a6)
		bsr.w   bsc06_switchEnemies
		lea     ((byte_FFB562-$1000000)).w,a6
		move.w  ((word_FFB3FE-$1000000)).w,(a6)
		move.w  #3,2(a6)
		bsr.w   bsc07_switchAllies
		bset    #4,((byte_FFB56E-$1000000)).w
		movea.l (sp)+,a6
		rts

	; End of function bsc09_switchToAllyAlone


; =============== S U B R O U T I N E =======================================

; same parameters as previous command

bsc0B_executeAllyReaction:
		
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		bne.s   loc_18DCC
		addq.w  #8,a6
		rts
loc_18DCC:
		tst.b   ((byte_FFB588-$1000000)).w
		bne.s   loc_18DCC
		move.w  (a6)+,d1
		move.w  d1,-(sp)
		bmi.s   loc_18DE0
		jsr     j_IncreaseCurrentHP
		bra.s   loc_18DE8
loc_18DE0:
		neg.w   d1
		jsr     j_DecreaseCurrentHP
loc_18DE8:
		move.w  (a6)+,d1
		bmi.s   loc_18DF4
		jsr     j_IncreaseCurrentMP
		bra.s   loc_18DFC
loc_18DF4:
		neg.w   d1
		jsr     j_DecreaseCurrentMP
loc_18DFC:
		move.w  (a6)+,d1
		jsr     j_SetStatus
		jsr     j_ApplyStatusAndItemsOnStats
		bsr.w   sub_192FE
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		move.b  ((byte_FFB56F-$1000000)).w,d1
		andi.w  #2,d1
		jsr     sub_10020
		move.w  (sp)+,d1
		move.w  (a6)+,d0
		subq.w  #1,d0
		beq.s   loc_18E30
		subq.w  #1,d0
		beq.w   loc_18F48
		rts
loc_18E30:
		cmpi.w  #$8000,d1
		beq.w   loc_18F26
		trap    #SOUND_COMMAND
		dc.w SFX_LIGHTNING_1    ; enemy attack ?
		bclr    #1,((byte_FFB56E-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,d0
		move.w  d0,-(sp)
		move.b  #1,((FADING_COUNTER_MAX-$1000000)).w
		move.b  #7,((FADING_SETTING-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  #1,((FADING_PALETTE_FLAGS-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.w  ((word_FFB3EC-$1000000)).w,d4
		move.w  ((word_FFB3F0-$1000000)).w,d5
		moveq   #$B,d0
loc_18E6E:
		movem.w d0/d4-d5,-(sp)
		moveq   #5,d6
		jsr     (UpdateRandomSeed).w
		subq.w  #2,d7
		asl.w   #1,d7
		move.w  d7,d6
		move.w  d7,-(sp)
		bsr.w   sub_1F1CC
		add.w   d4,d6
		bsr.w   sub_1F214
		moveq   #5,d6
		jsr     (UpdateRandomSeed).w
		subq.w  #2,d7
		asl.w   #1,d7
		move.w  d7,d6
		move.w  d7,d1
		neg.w   d1
		bsr.w   sub_1F1F0
		add.w   d5,d6
		bsr.w   sub_1F254
		move.w  (sp)+,d0
		movem.w d0-d1,-(sp)
		bsr.w   sub_193B2
		movem.w (sp)+,d0-d1
		bsr.w   sub_19504
		jsr     (sub_1942).w    
		jsr     (WaitForVInt).w 
		movem.w (sp)+,d0/d4-d5
		dbf     d0,loc_18E6E
		clr.w   d6
		bsr.w   sub_1F1CC
		bsr.w   sub_1F1F0
		move.w  d4,d6
		bsr.w   sub_1F214
		move.w  d5,d6
		bsr.w   sub_1F254
		clr.w   d1
		bsr.w   sub_1939E
		clr.w   d1
		bsr.w   sub_194FE
		jsr     (sub_1942).w    
		cmpi.b  #$10,((byte_FFB587-$1000000)).w
		beq.s   loc_18EF8
		bsr.w   sub_1A092
loc_18EF8:
		move.w  (sp)+,d0
		move.b  d0,((FADING_COUNTER_MAX-$1000000)).w
		jsr     (WaitForVInt).w 
		bset    #1,((byte_FFB56E-$1000000)).w
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		jsr     j_GetCurrentHP
		tst.w   d1
		bne.s   return_18F24
		bsr.w   AddAllyToDeadList
		bsr.w   sub_195FE
		move.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
return_18F24:
		rts
loc_18F26:
		cmpi.b  #3,((byte_FFB587-$1000000)).w
		bne.s   loc_18F38
		addq.w  #1,((dword_FFB536-$1000000)).w
		moveq   #$14,d0
		jsr     (Sleep).w       
loc_18F38:
		bsr.w   AddAllyToDeadList
		bsr.w   sub_195FE
		move.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		rts
loc_18F48:
		trap    #SOUND_COMMAND
		dc.w SFX_HEALING
		rts

	; End of function bsc0B_executeAllyReaction


; =============== S U B R O U T I N E =======================================

; Byte 00-01      HP change, signed.
; Byte 02-03      MP change, signed.
; Byte 04-05      Set status bytes.
; Byte 06-07      Flags - 0x0001 enemy flash/sound

bsc0A_executeEnemyReaction:
		
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		bne.s   loc_18F5C
		addq.w  #8,a6
		rts
loc_18F5C:
		tst.b   ((byte_FFB588-$1000000)).w
		bne.s   loc_18F5C
		bclr    #1,((byte_FFB583-$1000000)).w
		move.w  (a6)+,d1
		move.w  d1,-(sp)
		bmi.s   loc_18F76
		jsr     j_IncreaseCurrentHP
		bra.s   loc_18F7E
loc_18F76:
		neg.w   d1
		jsr     j_DecreaseCurrentHP
loc_18F7E:
		move.w  (a6)+,d1
		bmi.s   loc_18F8A
		jsr     j_IncreaseCurrentMP
		bra.s   loc_18F92
loc_18F8A:
		neg.w   d1
		jsr     j_DecreaseCurrentMP
loc_18F92:
		move.w  (a6)+,d1
		jsr     j_SetStatus
		jsr     j_ApplyStatusAndItemsOnStats
		bsr.w   sub_19296
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		move.b  ((byte_FFB56F-$1000000)).w,d1
		andi.w  #4,d1
		jsr     sub_10024
		move.w  (sp)+,d1
		move.w  (a6)+,d0
		subq.w  #1,d0
		beq.s   loc_18FC6
		subq.w  #1,d0
		beq.w   loc_19098
		rts
loc_18FC6:
		cmpi.w  #$8000,d1
		beq.w   loc_19076
		trap    #SOUND_COMMAND
		dc.w SFX_HIT_1          ; attack sfx ?
		bclr    #3,((byte_FFB56E-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,d0
		move.w  d0,-(sp)
		move.b  #1,((FADING_COUNTER_MAX-$1000000)).w
		move.b  #7,((FADING_SETTING-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  #2,((FADING_PALETTE_FLAGS-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.w  ((word_FFB3EC-$1000000)).w,d4
		move.w  ((word_FFB3F0-$1000000)).w,d5
		moveq   #$B,d0
loc_19004:
		moveq   #7,d6
		jsr     (UpdateRandomSeed).w
		subq.w  #3,d7
		asl.w   #1,d7
		move.w  d7,d6
		add.w   d4,d6
		bsr.w   sub_1F214
		moveq   #7,d6
		jsr     (UpdateRandomSeed).w
		subq.w  #3,d7
		asl.w   #1,d7
		move.w  d7,d6
		add.w   d5,d6
		bsr.w   sub_1F254
		jsr     (WaitForVInt).w 
		dbf     d0,loc_19004
		move.w  d4,d6
		bsr.w   sub_1F214
		move.w  d5,d6
		bsr.w   sub_1F254
		cmpi.b  #$10,((byte_FFB587-$1000000)).w
		beq.s   loc_19048
		bsr.w   sub_1A092
loc_19048:
		move.w  (sp)+,d0
		move.b  d0,((FADING_COUNTER_MAX-$1000000)).w
		jsr     (WaitForVInt).w 
		bset    #3,((byte_FFB56E-$1000000)).w
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		jsr     j_GetCurrentHP
		tst.w   d1
		bne.s   return_19074
		bsr.w   AddEnemyToDeadList
		bsr.w   sub_196D4
		move.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
return_19074:
		rts
loc_19076:
		cmpi.b  #3,((byte_FFB587-$1000000)).w
		bne.s   loc_19088
		addq.w  #1,((dword_FFB536-$1000000)).w
		moveq   #$14,d0
		jsr     (Sleep).w       
loc_19088:
		bsr.w   AddEnemyToDeadList
		bsr.w   sub_196D4
		move.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		rts
loc_19098:
		trap    #SOUND_COMMAND
		dc.w SFX_HEALING        ; healing
		bset    #1,((byte_FFB583-$1000000)).w
		rts

	; End of function bsc0A_executeEnemyReaction


; =============== S U B R O U T I N E =======================================

bsc0C_makeActorIdleAndEndAnimation:
		
		bsr.w   MakeActorIdle   
		move.b  #3,((byte_FFB585-$1000000)).w
		jsr     (WaitForVInt).w 
		bsr.w   sub_1A24E
		bsr.w   sub_1F2F6
		jmp     (WaitForVInt).w 

	; End of function bsc0C_makeActorIdleAndEndAnimation


; =============== S U B R O U T I N E =======================================

bsc0D_endAnimation:
		
		move.b  #2,((byte_FFB585-$1000000)).w
loc_190C4:
		tst.b   ((byte_FFB584-$1000000)).w
						; wait for byte cleared
		bne.s   loc_190C4       
		bsr.w   sub_1A24E
		bsr.w   sub_1F2F6
		jmp     (WaitForVInt).w 

	; End of function bsc0D_endAnimation


; =============== S U B R O U T I N E =======================================

bsc0E_sleep:
		move.w  (a6)+,d0
		jmp     (Sleep).w       

	; End of function bsc0E_sleep


; =============== S U B R O U T I N E =======================================

; Byte 00-01      Amount of EXP.

bsc0F_giveEXP:
		
		moveq   #0,d1
		move.w  (a6)+,d1
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.w   return_191DE
		move.l  d1,-(sp)
		andi.w  #$7FFF,d1
		jsr     j_IncreaseEXP
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		move.l  (sp)+,d1
		btst    #$F,d1
		bne.s   loc_1910C
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $107               ; "{NAME} earned {#}{N}EXP. points.{D1}"
loc_1910C:
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		jsr     j_GetCurrentEXP
		subi.w  #$64,d1 
		bcs.w   return_191DE
		jsr     j_SetCurrentEXP
		jsr     j_LevelUp
		clr.w   (CURRENT_SPEAK_SOUND).l
		lea     (byte_FFAF82).l,a5
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,((TEXT_NAME_INDEX_1-$1000000)).w
		moveq   #0,d0
		move.b  (a5)+,d0
		cmpi.b  #$FF,d0
		beq.w   return_191DE
		move.l  d0,((TEXT_NUMBER-$1000000)).w
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		move.b  ((byte_FFB56F-$1000000)).w,d1
		andi.w  #2,d1
		jsr     sub_10020
		trap    #SOUND_COMMAND
		dc.w SFX_LEVEL_UP       ; level up
		trap    #TEXTBOX
		dc.w $F4                ; "{NAME} became{N}level {#}!"
		moveq   #0,d0
		move.b  (a5)+,d0
		beq.s   loc_19174
		move.l  d0,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $10A               ; "{D1}HP increased by {#}!"
loc_19174:
		moveq   #0,d0
		move.b  (a5)+,d0
		beq.s   loc_19182
		move.l  d0,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $10B               ; "{D1}MP increased by {#}!"
loc_19182:
		moveq   #0,d0
		move.b  (a5)+,d0
		beq.s   loc_19190
		move.l  d0,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $10C               ; "{D1}Attack increased by {#}!"
loc_19190:
		moveq   #0,d0
		move.b  (a5)+,d0
		beq.s   loc_1919E
		move.l  d0,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $10D               ; "{D1}Defense increased by {#}!"
loc_1919E:
		moveq   #0,d0
		move.b  (a5)+,d0
		beq.s   loc_191AC
		move.l  d0,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $10E               ; "{D1}Agility increased by {#}!"
loc_191AC:
		moveq   #0,d0
		move.b  (a5)+,d0
		cmpi.b  #$FF,d0
		beq.s   return_191DE
		move.l  d0,d1
		andi.w  #$3F,d0 
		lsr.w   #6,d1
		bne.s   loc_191D0
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,((TEXT_NAME_INDEX_1-$1000000)).w
		move.w  d0,((TEXT_NAME_INDEX_2-$1000000)).w
		trap    #TEXTBOX
		dc.w $10F               ; "{D1}{NAME} learned the new{N}magic spell {SPELL}!"
		bra.s   return_191DE
loc_191D0:
		addq.w  #1,d1
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $110               ; "{D1}{SPELL} increased to{N}level {#}!"
return_191DE:
		rts

	; End of function bsc0F_giveEXP


; =============== S U B R O U T I N E =======================================

;         Byte 00-01      Main string index.
;         Byte 02-03      Character name index.
;         Byte 04-05      Magic/item index.
;         Byte 06-09      Number.

bsc10_displayMessage:
		
		move.w  (a6)+,d0
		move.w  (a6)+,((TEXT_NAME_INDEX_1-$1000000)).w
		move.w  (a6)+,((TEXT_NAME_INDEX_2-$1000000)).w
		move.l  (a6)+,((TEXT_NUMBER-$1000000)).w
		clr.w   (CURRENT_SPEAK_SOUND).l
		tst.b   ((DISPLAY_BATTLE_MESSAGES-$1000000)).w
		bne.s   loc_1920C
		jsr     (DisplayText).l 
		tst.b   ((MESSAGE_SPEED-$1000000)).w
		bne.s   loc_1920C
		trap    #TEXTBOX        ; Wait for P1 input
		dc.w $16A               ; "{DICT}{W2}"
		rts
loc_1920C:
		clr.w   d0
		move.b  ((MESSAGE_SPEED-$1000000)).w,d0
		moveq   #8,d1
		sub.w   d0,d1
		clr.w   d0
		bset    d1,d0
loc_1921A:
		tst.b   ((P1_INPUT-$1000000)).w
		bne.s   return_19228
		jsr     (WaitForVInt).w 
		dbf     d0,loc_1921A
return_19228:
		rts

	; End of function bsc10_displayMessage


; =============== S U B R O U T I N E =======================================

; same params as previous command

bsc11_displayMessageWithNoWait:
		
		move.w  (a6)+,d0
		move.w  (a6)+,((TEXT_NAME_INDEX_1-$1000000)).w
		move.w  (a6)+,((TEXT_NAME_INDEX_2-$1000000)).w
		move.l  (a6)+,((TEXT_NUMBER-$1000000)).w
		clr.w   (CURRENT_SPEAK_SOUND).l
		jmp     (DisplayText).l 

	; End of function bsc11_displayMessageWithNoWait


; =============== S U B R O U T I N E =======================================

j_hideTextBox:
		
		jmp     (HideTextBox).l 

	; End of function j_hideTextBox


; =============== S U B R O U T I N E =======================================

sub_1924A:
		clr.w   d0
		move.b  ((MESSAGE_SPEED-$1000000)).w,d0
		moveq   #7,d1
		sub.w   d0,d1
		clr.w   d0
		bset    d1,d0
loc_19258:
		tst.b   ((P1_INPUT-$1000000)).w
		bne.s   loc_19266
		jsr     (WaitForVInt).w 
		dbf     d0,loc_19258
loc_19266:
		trap    #SOUND_COMMAND
		dc.w SOUND_COMMAND_FADE_OUT
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   loc_1927A
		jsr     sub_10028
loc_1927A:
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   return_1928A
		jsr     sub_1002C
return_1928A:
		rts

	; End of function sub_1924A


; =============== S U B R O U T I N E =======================================

sub_1928C:
		bsr.w   sub_192FE
		bsr.s   sub_19296
		bra.w   sub_1EFD8

	; End of function sub_1928C


; =============== S U B R O U T I N E =======================================

sub_19296:
		move.w  ((ENEMY_BATTLESPRITE_ANIM_SPEED-$1000000)).w,((ENEMY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		clr.w   d2
		cmpi.w  #$FFFF,d0
		beq.s   loc_192F8
		jsr     j_GetStatus
		move.w  d1,d0
		andi.w  #$3000,d0
		beq.s   loc_192BA
		lsr     ((ENEMY_BATTLESPRITE_ANIM_SPEED-$1000000)).w
loc_192BA:
		move.w  d1,d0
		andi.w  #$C00,d0
		beq.s   loc_192C6
		lsl     ((ENEMY_BATTLESPRITE_ANIM_SPEED-$1000000)).w
loc_192C6:
		move.w  d1,d0
		andi.w  #$300,d0
		beq.s   loc_192D0
		moveq   #1,d2
loc_192D0:
		move.w  d1,d0
		andi.w  #8,d0
		beq.s   loc_192DA
		moveq   #2,d2
loc_192DA:
		move.w  d1,d0
		andi.w  #$C0,d0 
		beq.s   loc_192EA
		moveq   #3,d2
		move.w  #$FFFF,((ENEMY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
loc_192EA:
		andi.w  #1,d1
		beq.s   loc_192F8
		moveq   #4,d2
		move.w  #$FFFF,((ENEMY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
loc_192F8:
		move.b  d2,((byte_FFB57F-$1000000)).w
		rts

	; End of function sub_19296


; =============== S U B R O U T I N E =======================================

sub_192FE:
		move.w  ((ALLY_BATTLESPRITE_ANIM_SPEED-$1000000)).w,((ALLY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		clr.w   d2
		cmpi.w  #$FFFF,d0
		beq.s   loc_19360
		jsr     j_GetStatus
		move.w  d1,d0
		andi.w  #$3000,d0
		beq.s   loc_19322
		lsr     ((ALLY_BATTLESPRITE_ANIM_SPEED-$1000000)).w
loc_19322:
		move.w  d1,d0
		andi.w  #$C00,d0
		beq.s   loc_1932E
		lsl     ((ALLY_BATTLESPRITE_ANIM_SPEED-$1000000)).w
loc_1932E:
		move.w  d1,d0
		andi.w  #$300,d0
		beq.s   loc_19338
		moveq   #1,d2
loc_19338:
		move.w  d1,d0
		andi.w  #$30,d0 
		beq.s   loc_19342
		moveq   #2,d2
loc_19342:
		move.w  d1,d0
		andi.w  #$C0,d0 
		beq.s   loc_19352
		moveq   #3,d2
		move.w  #$FFFF,((ALLY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
loc_19352:
		andi.w  #1,d1
		beq.s   loc_19360
		moveq   #4,d2
		move.w  #$FFFF,((ALLY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
loc_19360:
		move.b  d2,((byte_FFB57E-$1000000)).w
		rts

	; End of function sub_192FE


; =============== S U B R O U T I N E =======================================

sub_19366:
		move.w  d1,-(sp)
		move.w  d1,-(sp)
		andi.w  #$F,d0
		cmpi.w  #$F,d0
		beq.s   loc_19378
		bsr.w   sub_1942C
loc_19378:
		move.w  (sp)+,d1
		move.w  d1,d0
		asr.w   #8,d0
		ext.w   d1
		bsr.s   sub_193C4
		move.w  (sp)+,d1
		bsr.w   sub_19546
		jmp     (sub_1942).w    

	; End of function sub_19366


; =============== S U B R O U T I N E =======================================

sub_1938C:
		move.w  d1,-(sp)
		andi.w  #$F,d0
		cmpi.w  #$F,d0
		beq.s   loc_1939C
		bsr.w   sub_1942C
loc_1939C:
		move.w  (sp)+,d1

	; End of function sub_1938C


; =============== S U B R O U T I N E =======================================

sub_1939E:
		move.w  d1,-(sp)
		move.w  d1,d0
		asr.w   #8,d0
		ext.w   d1
		bsr.s   sub_193C4
		move.w  (sp)+,d1
		bsr.w   sub_1955E
		jmp     (sub_1942).w    

	; End of function sub_1939E


; =============== S U B R O U T I N E =======================================

sub_193B2:
		movem.w d0-d1,-(sp)
		bsr.s   sub_193C4
		movem.w (sp)+,d0-d1
		bsr.w   sub_19564
		jmp     (sub_1942).w    

	; End of function sub_193B2


; =============== S U B R O U T I N E =======================================

sub_193C4:
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.s   return_1942A
		lea     byte_1F576(pc), a0
		btst    #1,((byte_FFB56F-$1000000)).w
		beq.s   loc_193E0
		lea     $48(a0),a0
		subi.w  #$70,d0 
loc_193E0:
		lea     ((dword_FFDC88-$1000000)).w,a1
		btst    #0,((byte_FFB56E-$1000000)).w
		bne.s   loc_193F0
		clr.w   d2
		bra.s   loc_193F4
loc_193F0:
		move.w  #$90,d2 
loc_193F4:
		moveq   #8,d7
loc_193F6:
		move.w  (a0)+,(a1)
		add.w   d1,(a1)+
		move.w  (a0)+,(a1)+
		move.w  (a0)+,(a1)
		add.w   d2,(a1)+
		move.w  (a0)+,(a1)
		add.w   d0,(a1)+
		dbf     d7,loc_193F6
		addi.w  #$108,d0
		move.w  d0,((word_FFB3F2-$1000000)).w
		addi.w  #$C0,d1 
		move.w  d1,((word_FFB3F4-$1000000)).w
		lea     (byte_FFAFA1).l,a0
		move.l  #$1010101,d0
		move.b  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
return_1942A:
		rts

	; End of function sub_193C4


; =============== S U B R O U T I N E =======================================

sub_1942C:
		move.w  d0,d1
		bsr.s   sub_19458
		bclr    #1,((byte_FFB56E-$1000000)).w
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   return_19456
		bchg    #0,((byte_FFB56E-$1000000)).w
		bne.s   loc_1944E
		lea     ($3200).w,a1
		bra.s   loc_19452
loc_1944E:
		lea     ($2000).w,a1
loc_19452:
		bsr.w   sub_19A2A       
return_19456:
		rts

	; End of function sub_1942C


; =============== S U B R O U T I N E =======================================

sub_19458:
		tst.b   ((byte_FFB56D-$1000000)).w
		beq.s   return_19462
		jsr     (WaitForVInt).w 
return_19462:
		rts

	; End of function sub_19458


; =============== S U B R O U T I N E =======================================

sub_19464:
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.s   return_194A8
		move.w  d1,-(sp)
		move.w  d1,-(sp)
		andi.w  #$F,d0
		cmpi.w  #$F,d0
		beq.s   loc_19480
		bsr.w   sub_194AA
		bra.s   loc_19486
loc_19480:
		bchg    #2,((byte_FFB56E-$1000000)).w
loc_19486:
		move.w  (sp)+,d6
		asr.w   #8,d6
		btst    #2,((byte_FFB56F-$1000000)).w
		beq.s   loc_19496
		addi.w  #$60,d6 
loc_19496:
		bsr.w   sub_1F214
		move.w  (sp)+,d6
		ext.w   d6
		neg.w   d6
		bsr.w   sub_1F254
		bsr.w   sub_1EF2E
return_194A8:
		rts

	; End of function sub_19464


; =============== S U B R O U T I N E =======================================

sub_194AA:
		move.w  d0,-(sp)
		bsr.s   sub_19458
		move.w  (sp)+,d1
		bclr    #3,((byte_FFB56E-$1000000)).w
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   return_194FC
		bsr.w   sub_19B24       
		lea     (FF8804_LOADING_SPACE).l,a0
		btst    #2,((byte_FFB56E-$1000000)).w
		beq.s   loc_194D8
		lea     ($4400).w,a1
		bra.s   loc_194DC
loc_194D8:
		lea     ($5C00).w,a1
loc_194DC:
		move.w  #$600,d0
		move.w  #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
		move.w  #$600,d0
		move.w  #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
return_194FC:
		rts

	; End of function sub_194AA


; =============== S U B R O U T I N E =======================================

sub_194FE:
		move.w  d1,d0
		asr.w   #8,d0
		ext.w   d1

	; End of function sub_194FE


; =============== S U B R O U T I N E =======================================

sub_19504:
		cmpi.b  #$FF,((BATTLE_BACKGROUND-$1000000)).w
		beq.s   return_19544
		lea     byte_1F686(pc), a0
		btst    #0,((byte_FFB56F-$1000000)).w
		beq.s   loc_19520
		lea     $18(a0),a0
		subi.w  #$70,d0 
loc_19520:
		lea     ((dword_FFDCF0-$1000000)).w,a1
		moveq   #2,d7
loc_19526:
		move.w  (a0)+,(a1)
		add.w   d1,(a1)+
		move.l  (a0)+,(a1)+
		move.w  (a0)+,(a1)
		add.w   d0,(a1)+
		dbf     d7,loc_19526
		move.w  #$101,d0
		move.w  d0,(word_FFAFAE).l
		move.b  d0,(byte_FFAFB0).l
return_19544:
		rts

	; End of function sub_19504


; =============== S U B R O U T I N E =======================================

sub_19546:
		move.w  d1,d0
		asr.w   #8,d0
		ext.w   d1
		move.b  ((WEAPON_FRAME_X-$1000000)).w,d2
		ext.w   d2
		add.w   d2,d0
		move.b  ((WEAPON_FRAME_Y-$1000000)).w,d2
		ext.w   d2
		add.w   d2,d1
		bra.s   loc_1958E

	; End of function sub_19546


; =============== S U B R O U T I N E =======================================

sub_1955E:
		move.w  d1,d0
		asr.w   #8,d0
		ext.w   d1

	; End of function sub_1955E


; =============== S U B R O U T I N E =======================================

sub_19564:
		btst    #0,((byte_FFB56E-$1000000)).w
		bne.s   loc_1957E
		move.b  ((WEAPON_IDLE_FRAME1_X-$1000000)).w,d2
		ext.w   d2
		add.w   d2,d0
		move.b  ((WEAPON_IDLE_FRAME1_Y-$1000000)).w,d2
		ext.w   d2
		add.w   d2,d1
		bra.s   loc_1958E
loc_1957E:
		move.b  ((WEAPON_IDLE_FRAME2_X-$1000000)).w,d2
		ext.w   d2
		add.w   d2,d0
		move.b  ((WEAPON_IDLE_FRAME2_Y-$1000000)).w,d2
		ext.w   d2
		add.w   d2,d1
loc_1958E:
		cmpi.w  #$FFFF,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		beq.w   return_195E0
		move.b  ((WEAPON_FRAME_IDX-$1000000)).w,d7
		btst    #1,((byte_FFB56F-$1000000)).w
		beq.s   loc_195AC
		bchg    #4,d7
		subi.w  #$70,d0 
loc_195AC:
		lea     byte_1F606(pc), a0
		andi.w  #$30,d7 
		add.w   d7,d7
		adda.w  d7,a0
		lea     ((byte_FFDCD0-$1000000)).w,a1
		moveq   #3,d7
loc_195BE:
		move.w  (a0)+,(a1)
		add.w   d1,(a1)+
		move.l  (a0)+,(a1)+
		move.w  (a0)+,(a1)
		add.w   d0,(a1)+
		dbf     d7,loc_195BE
		move.l  #$1010101,d0
		move.b  ((WEAPON_FRAME_LAYER-$1000000)).w,d1
		subq.b  #1,d1
		lsl.l   d1,d0
		move.l  d0,(dword_FFAFAA).l
return_195E0:
		rts

	; End of function sub_19564


; =============== S U B R O U T I N E =======================================

; make actor idle

MakeActorIdle:
		
		move.b  ((ACTOR_TO_MAKE_IDLE-$1000000)).w,d0
		subq.b  #1,d0
		bne.s   loc_195F0
		bsr.w   bsc05_makeAllyIdle
		bra.s   loc_195F8
loc_195F0:
		subq.b  #1,d0
		bne.s   loc_195F8
		bsr.w   bsc04_makeEnemyIdle
loc_195F8:
		clr.b   ((ACTOR_TO_MAKE_IDLE-$1000000)).w
		rts

	; End of function MakeActorIdle


; =============== S U B R O U T I N E =======================================

sub_195FE:
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.s   return_19630
		bclr    #1,((byte_FFB56E-$1000000)).w
		clr.b   ((byte_FFB57E-$1000000)).w
		bsr.w   sub_19AB0
		lea     word_196B4(pc), a1
		moveq   #7,d7
loc_1961A:
		move.w  (a1),d0
		swap    d0
		move.w  (a1)+,d0
		move.w  (a1)+,d1
		movem.l d7/a1,-(sp)
		bsr.s   sub_19632
		movem.l (sp)+,d7/a1
		dbf     d7,loc_1961A
return_19630:
		rts

	; End of function sub_195FE


; =============== S U B R O U T I N E =======================================

sub_19632:
		lea     (FF8804_LOADING_SPACE).l,a0
		adda.w  d1,a0
		move.w  #$23F,d7
loc_1963E:
		and.l   d0,(a0)
		addq.w  #8,a0
		dbf     d7,loc_1963E
		lea     (FF2000_LOADING_SPACE).l,a0
		move.b  ((WEAPON_IDLE_FRAME1_IDX-$1000000)).w,d7
		andi.w  #7,d7
		ror.w   #5,d7
		adda.w  d7,a0
		move.l  a0,-(sp)
		adda.w  d1,a0
		move.w  #$FF,d7
loc_19660:
		and.l   d0,(a0)
		addq.w  #8,a0
		dbf     d7,loc_19660
		movea.l (sp)+,a0
		move.l  a0,-(sp)
		lea     (FF8804_LOADING_SPACE).l,a0
		btst    #0,((byte_FFB56E-$1000000)).w
		bne.s   loc_19680
		lea     ($2000).w,a1
		bra.s   loc_19684
loc_19680:
		lea     ($3200).w,a1
loc_19684:
		move.w  #$900,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
		movea.l (sp)+,a0
		cmpi.w  #$FFFF,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		beq.s   loc_196B0
		lea     ($D800).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
loc_196B0:
		jmp     (WaitForVInt).w 

	; End of function sub_19632

word_196B4:     dc.w $FFF
		dc.w 0
		dc.w $FFF
		dc.w 4
		dc.w $FF0F
		dc.w 0
		dc.w $FF0F
		dc.w 4
		dc.w $F0FF
		dc.w 0
		dc.w $F0FF
		dc.w 4
		dc.w $FFF0
		dc.w 0
		dc.w $FFF0
		dc.w 4

; =============== S U B R O U T I N E =======================================

sub_196D4:
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.s   return_1971A
		bclr    #3,((byte_FFB56E-$1000000)).w
		clr.b   ((byte_FFB57F-$1000000)).w
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d0
		btst    #2,((byte_FFB56E-$1000000)).w
		bne.s   loc_196F6
		clr.w   d1
		bra.s   loc_196FA
loc_196F6:
		bsr.w   GetEnemyBattleSpriteIdleAnimate
loc_196FA:
		bsr.w   sub_19B24       
		lea     word_19764(pc), a1
		moveq   #7,d7
loc_19704:
		move.w  (a1),d0
		swap    d0
		move.w  (a1)+,d0
		move.w  (a1)+,d1
		movem.l d7/a1,-(sp)
		bsr.s   sub_1971C
		movem.l (sp)+,d7/a1
		dbf     d7,loc_19704
return_1971A:
		rts

	; End of function sub_196D4


; =============== S U B R O U T I N E =======================================

sub_1971C:
		lea     (FF8804_LOADING_SPACE).l,a0
		adda.w  d1,a0
		move.w  #$2FF,d7
loc_19728:
		and.l   d0,(a0)
		addq.w  #8,a0
		dbf     d7,loc_19728
		lea     (FF8804_LOADING_SPACE).l,a0
		btst    #2,((byte_FFB56E-$1000000)).w
		bne.s   loc_19744
		lea     ($4400).w,a1
		bra.s   loc_19748
loc_19744:
		lea     ($5C00).w,a1
loc_19748:
		move.w  #$600,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
		move.w  #$600,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jmp     (SetFFDE94b3andWait).w

	; End of function sub_1971C

word_19764:     dc.w $FFF
		dc.w 0
		dc.w $FF0F
		dc.w 4
		dc.w $FF0F
		dc.w 0
		dc.w $FFF
		dc.w 4
		dc.w $F0FF
		dc.w 0
		dc.w $FFF0
		dc.w 4
		dc.w $FFF0
		dc.w 0
		dc.w $F0FF
		dc.w 4

; =============== S U B R O U T I N E =======================================

AddAllyToDeadList:
		
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   return_197A4
		move.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,d1
		lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a0
		move.b  d0,(a0,d1.w)
		move.b  #$FF,1(a0,d1.w)
		addq.w  #1,((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
return_197A4:
		rts

	; End of function AddAllyToDeadList


; =============== S U B R O U T I N E =======================================

; add enemy to dead combatant list

AddEnemyToDeadList:
		
		move.w  ((BATTLESCENE_ENEMY-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		beq.s   return_197C6
		move.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,d1
		lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a0
		move.b  d0,(a0,d1.w)
		move.b  #$FF,1(a0,d1.w)
		addq.w  #1,((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
return_197C6:
		rts

	; End of function AddEnemyToDeadList


; =============== S U B R O U T I N E =======================================

GetAllyAnimation:
		
		movem.l d1-d2,-(sp)
		tst.w   d1
		bne.w   loc_19810
		moveq   #$50,d2 
		cmpi.w  #2,((BATTLESCENE_ACTOR-$1000000)).w
		beq.w   loc_197F6
		addq.w  #1,d2
		cmpi.w  #$D,((BATTLESCENE_ACTOR-$1000000)).w
		beq.w   loc_197F6
		addq.w  #1,d2
		cmpi.w  #$11,((BATTLESCENE_ACTOR-$1000000)).w
		bne.w   loc_19810
loc_197F6:
		cmpi.w  #$C,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		bcs.w   loc_19810
		cmpi.w  #$D,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		bhi.w   loc_19810
		move.w  d2,d1
		bra.w   loc_19826
loc_19810:
		cmpi.w  #$50,d1 
		bcc.s   loc_19826
		cmpi.w  #1,d1
		bne.s   loc_19820
		moveq   #$28,d1 
		bra.s   loc_19822
loc_19820:
		clr.w   d1
loc_19822:
		add.w   ((BATTLESCENE_ACTOR-$1000000)).w,d1
loc_19826:
		movea.l (p_pt_AllyAnimations).l,a0
		lsl.w   #2,d1
		movea.l (a0,d1.w),a0
		movem.l (sp)+,d1-d2
		rts

	; End of function GetAllyAnimation


; =============== S U B R O U T I N E =======================================

sub_19838:
		move.w  d1,-(sp)
		cmpi.w  #$76,d1 
		bcc.s   loc_19850
		cmpi.w  #1,d1
		bne.s   loc_1984A
		moveq   #$3C,d1 
		bra.s   loc_1984C
loc_1984A:
		clr.w   d1
loc_1984C:
		add.w   ((word_FFB3E6-$1000000)).w,d1
loc_19850:
		movea.l (p_pt_EnemyAnimations).l,a0
		lsl.w   #2,d1
		movea.l (a0,d1.w),a0
		move.w  (sp)+,d1
		rts

	; End of function sub_19838


; =============== S U B R O U T I N E =======================================

; Returns whether or not ally bsprite should animate when idle.
; In: D0 = ally bsprite idx
; Out: D1 = 0 if animates, 1 if not

GetAllyBattleSpriteIdleAnimate:
		
		move.l  a0,-(sp)
		lea     AllyBSpriteIdleAnimate(pc), a0
		bra.w   loc_19870

	; End of function GetAllyBattleSpriteIdleAnimate


; =============== S U B R O U T I N E =======================================

; Returns whether or not enemy bsprite should animate when idle.
; In: D0 = enemy bsprite idx
; Out: D1 = 0 if animates, 1 if not

GetEnemyBattleSpriteIdleAnimate:
		
		move.l  a0,-(sp)
		lea     EnemyBSpriteIdleAnimate(pc), a0
loc_19870:
		moveq   #0,d1
loc_19872:
		cmp.b   (a0),d0
		beq.w   loc_19880
		cmpi.b  #CODE_TERMINATOR_BYTE,(a0)+
		bne.s   loc_19872
		moveq   #1,d1
loc_19880:
		movea.l (sp)+,a0
		rts

	; End of function GetEnemyBattleSpriteIdleAnimate


; =============== S U B R O U T I N E =======================================

; clears plt 1-2 and 1-2bis, sets plt 3bis

InitializeBattleScenePalettes:
		
		lea     ((PALETTE_1_BIS-$1000000)).w,a0
		lea     ((PALETTE_1-$1000000)).w,a1
		moveq   #$1F,d0
loc_1988E:
		clr.l   (a0)+
		clr.l   (a1)+
		dbf     d0,loc_1988E
		lea     plt_BattleSceneBasePalette(pc), a0
		lea     ((PALETTE3_BIS-$1000000)).w,a1
		moveq   #7,d0
loc_198A0:
		move.l  (a0)+,(a1)+
		dbf     d0,loc_198A0
		rts

	; End of function InitializeBattleScenePalettes

plt_BattleSceneBasePalette:
		incbin "data/graphics/battles/plt_battlescenebasepalette.bin"
						; Base palette for battlescene UI and ground

; =============== S U B R O U T I N E =======================================

sub_198C8:
		movem.l d0/a0-a1,-(sp)
		lea     (byte_FFC000).l,a0
		move.w  #$BF,d0 
loc_198D6:
		move.w  #$6000,(a0)+
		dbf     d0,loc_198D6
		moveq   #$1F,d0
loc_198E0:
		move.w  #$40F8,(a0)+
		dbf     d0,loc_198E0
		lea     SomePlaneALayout(pc), a1
		move.w  #$BF,d0 
loc_198F0:
		move.l  (a1)+,(a0)+
		dbf     d0,loc_198F0
		moveq   #$1F,d0
loc_198F8:
		move.w  #$40F8,(a0)+
		dbf     d0,loc_198F8
		move.w  #$17F,d0
loc_19904:
		move.w  #$6000,(a0)+
		dbf     d0,loc_19904
		movem.l (sp)+,d0/a0-a1
		rts

	; End of function sub_198C8


; START OF FUNCTION CHUNK FOR bsc07_switchAllies

loc_19912:
		btst    #4,((byte_FFB56F-$1000000)).w
		beq.s   loc_1991C
		rts
loc_1991C:
		moveq   #$10,d0
		jsr     (InitSprites).w 
		jmp     (sub_1942).w    

; END OF FUNCTION CHUNK FOR bsc07_switchAllies


; =============== S U B R O U T I N E =======================================

sub_19926:
		lea     (FF8804_LOADING_SPACE).l,a0
		move.w  #$1FF,d0
		moveq   #0,d1
loc_19932:
		move.l  d1,(a0)+
		dbf     d0,loc_19932
		lea     (FF8804_LOADING_SPACE).l,a0
		lea     ($E000).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jmp     (Set_FFDE94_bit3).w

	; End of function sub_19926


; =============== S U B R O U T I N E =======================================

sub_19952:
		movem.l d0/a0,-(sp)
		lea     ((dword_FFDCF0-$1000000)).w,a0
		moveq   #2,d0
loc_1995C:
		move.w  #1,(a0)+
		clr.l   (a0)+
		move.w  #1,(a0)+
		dbf     d0,loc_1995C
		movem.l (sp)+,d0/a0
		rts

	; End of function sub_19952


; =============== S U B R O U T I N E =======================================

sub_19970:
		movea.l (p_pt_EnemyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		move.w  (a0)+,((ENEMY_BATTLESPRITE_ANIM_SPEED-$1000000)).w
		move.w  (a0)+,((ENEMY_BATTLESPRITE_PROP1-$1000000)).w
		move.w  (a0),d0
		adda.w  d0,a0
		lsl.w   #5,d1
		adda.w  d1,a0
		lea     ((PALLETE_2_BIS-$1000000)).w,a1
		clr.w   (a1)+
		addq.w  #2,a0
		moveq   #$E,d0
loc_19996:
		move.w  (a0)+,(a1)+
		dbf     d0,loc_19996
		rts

	; End of function sub_19970


; =============== S U B R O U T I N E =======================================

sub_1999E:
		movea.l (p_pt_EnemyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		add.w   d1,d1
		adda.w  d1,a0
		move.w  (a0),d0
		adda.w  d0,a0
		move.w  #$C00,d0
		jmp     (DmaTilesViaFF8804).w

	; End of function sub_1999E


; =============== S U B R O U T I N E =======================================

sub_199BC:
		movea.l (p_pt_EnemyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		add.w   d1,d1
		adda.w  d1,a0
		move.w  (a0),d0
		adda.w  d0,a0
		move.w  #$C00,d0
		jsr     (DmaTilesViaFF8804bis).w
		jmp     (SetFFDE94b3andWait).w

	; End of function sub_199BC


; =============== S U B R O U T I N E =======================================

; load palette D1 of battle sprite D0

LoadPaletteForBattleScene:
		
		movea.l (p_pt_AllyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		move.w  (a0)+,((ALLY_BATTLESPRITE_ANIM_SPEED-$1000000)).w
		move.w  (a0)+,((ALLY_BATTLESPRITE_PROP1-$1000000)).w
		move.w  (a0),d0
		adda.w  d0,a0
		lsl.w   #5,d1
		adda.w  d1,a0
		lea     ((PALETTE_1_BIS-$1000000)).w,a1
		clr.w   (a1)+
		addq.w  #2,a0
		moveq   #$E,d0
loc_19A04:
		move.w  (a0)+,(a1)+
		dbf     d0,loc_19A04
		rts

	; End of function LoadPaletteForBattleScene


; =============== S U B R O U T I N E =======================================

;     In: D0 = battle sprite idx
;         D1 = frame idx

LoadAllyBattleSprite:
		
		movea.l (p_pt_AllyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		add.w   d1,d1
		adda.w  d1,a0
		move.w  (a0),d0
		adda.w  d0,a0
		move.w  #$900,d0
		jmp     (DmaTilesViaFF8804).w

	; End of function LoadAllyBattleSprite


; =============== S U B R O U T I N E =======================================

; Load ally battlesprite and set FFDE94 bit 3 and wait

sub_19A2A:
		movea.l (p_pt_AllyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		add.w   d1,d1
		adda.w  d1,a0
		move.w  (a0),d0
		adda.w  d0,a0
		move.w  #$900,d0
		jsr     (DmaTilesViaFF8804bis).w
		jmp     (SetFFDE94b3andWait).w

	; End of function sub_19A2A


; =============== S U B R O U T I N E =======================================

LoadWeaponPalette:
		
		movea.l (p_plt_BattleSceneWeaponColors).l,a0
		lsl.w   #2,d0
		move.l  (a0,d0.w),((WEAPON_PALETTE-$1000000)).w
		rts

	; End of function LoadWeaponPalette


; =============== S U B R O U T I N E =======================================

; ???
; In: D0 = weapon sprite idx

LoadWeaponSprite:
		
		movea.l (p_pt_WeaponSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		lea     (FF2000_LOADING_SPACE).l,a1
		jsr     (LoadCompressedData).w
		lea     (byte_FF4000).l,a0
		move.w  #$1FF,d0
loc_19A7C:
		clr.l   (a0)+
		dbf     d0,loc_19A7C
		rts

	; End of function LoadWeaponSprite


; =============== S U B R O U T I N E =======================================

LoadBattleSceneGround:
		
		movea.l (p_pt_BattleSceneGrounds).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		lea     ((PALETTE3_BIS-$1000000)).w,a1
		move.l  (a0)+,6(a1)
		move.w  (a0)+,$10(a1)
		move.w  (a0),d0
		adda.w  d0,a0
		lea     ($F000).l,a1
		move.w  #$300,d0
		jmp     (DmaTilesViaFF8804).w
		rts

	; End of function LoadBattleSceneGround


; =============== S U B R O U T I N E =======================================

sub_19AB0:
		movea.l (p_pt_AllyBattleSprites).l,a0
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		btst    #0,((byte_FFB56E-$1000000)).w
		beq.s   loc_19AD6
		move.w  ((CHARACTER_BATTLE_SPRITE-$1000000)).w,d0
		bsr.w   GetAllyBattleSpriteIdleAnimate
		add.w   d1,d1
		adda.w  d1,a0
loc_19AD6:
		move.w  (a0),d0
		adda.w  d0,a0
		lea     (FF8804_LOADING_SPACE).l,a1
		jmp     (LoadCompressedData).w

	; End of function sub_19AB0


; =============== S U B R O U T I N E =======================================

LoadNewAllyBattleSprite:
		
		move.w  d1,-(sp)
		move.w  d0,-(sp)
		movea.l (p_pt_AllyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		move.w  (a0),d0
		move.l  a0,-(sp)
		adda.w  d0,a0
		lea     (FF6802_LOADING_SPACE).l,a1
		jsr     (LoadCompressedData).w
		movea.l (sp)+,a0
		move.w  (sp)+,d0
		bsr.w   GetAllyBattleSpriteIdleAnimate
		add.w   d1,d1
		adda.w  d1,a0
		move.w  (a0),d0
		adda.w  d0,a0
		lea     (FF7A02_LOADING_SPACE).l,a1
		jsr     (LoadCompressedData).w
		move.w  (sp)+,d1
		rts

	; End of function LoadNewAllyBattleSprite


; =============== S U B R O U T I N E =======================================

; loads enemy battle sprite

sub_19B24:
		movea.l (p_pt_EnemyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		add.w   d1,d1
		adda.w  d1,a0
		move.w  (a0),d0
		adda.w  d0,a0
		lea     (FF8804_LOADING_SPACE).l,a1
		jmp     (LoadCompressedData).w

	; End of function sub_19B24


; =============== S U B R O U T I N E =======================================

; d0 : battle sprite index

LoadEnemyBattleSprite:
		
		cmpi.w  #$FFFF,d0
		beq.w   return_19B7E
		movea.l (p_pt_EnemyBattleSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		addq.w  #6,a0
		move.w  (a0),d0
		adda.w  d0,a0           ; offset to sprite frame
		lea     (ENEMY_BATTLESPRITE_UNCOMP_SPACE).l,a1
		jsr     (LoadCompressedData).w
		lea     (ENEMY_BATTLESPRITE_UNCOMP_SPACE).l,a0
		lea     (FF5000_LOADING_SPACE).l,a1
		move.w  #$1FF,d0
loc_19B78:
		move.l  (a0)+,(a1)+
		dbf     d0,loc_19B78
return_19B7E:
		rts

	; End of function LoadEnemyBattleSprite


; =============== S U B R O U T I N E =======================================

LoadBattleBackground:
		
		tst.w   d0
		bmi.s   return_19BCA
		movea.l (p_pt_Backgrounds).l,a2
		lsl.w   #2,d0
		movea.l (a2,d0.w),a2
		move.w  (a2)+,d0        ; tiles offset
		movem.l a1-a2,-(sp)
		lea     -2(a2,d0.w),a0
		jsr     (LoadCompressedData).w
		movem.l (sp)+,a1-a2
		move.w  (a2)+,d0
		move.l  a2,-(sp)
		lea     -2(a2,d0.w),a0  ; another tile offset ?
		lea     $1800(a1),a1
		jsr     (LoadCompressedData).w
		movea.l (sp)+,a2
		move.w  (a2),d0
		lea     (a2,d0.w),a0
		lea     ((byte_FFB542-$1000000)).w,a1
		addq.w  #2,a0
		clr.w   (a1)+
		moveq   #$E,d0
loc_19BC4:
		move.w  (a0)+,(a1)+
		dbf     d0,loc_19BC4
return_19BCA:
		rts

	; End of function LoadBattleBackground


; =============== S U B R O U T I N E =======================================

; loads battlescene ground

sub_19BCC:
		movea.l (p_pt_BattleSceneGrounds).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		lea     ((PALETTE3_BIS-$1000000)).w,a1
		move.l  (a0)+,6(a1)
		move.w  (a0)+,$10(a1)
		move.w  (a0),d0
		adda.w  d0,a0
		lea     (byte_FF8C02).l,a1
		jmp     (LoadCompressedData).w

	; End of function sub_19BCC


; =============== S U B R O U T I N E =======================================

LoadInvocationSprite:
		
		movea.l (p_pt_InvocationSprites).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		move.l  a0,-(sp)
		addq.w  #6,a0
		move.w  (a0)+,d0
		lea     -2(a0,d0.w),a1
		addq.w  #2,a1
		lea     ((word_FFD002-$1000000)).w,a2
		lea     ((word_FFD082-$1000000)).w,a3
		moveq   #$E,d0
loc_19C14:
		move.w  (a1),(a2)+
		move.w  (a1)+,(a3)+
		dbf     d0,loc_19C14
		lsl.w   #2,d1
		adda.w  d1,a0
		move.w  (a0)+,d0
		move.l  a0,-(sp)
		lea     -2(a0,d0.w),a0
		move.w  #$900,d0
		btst    #6,((byte_FFB56E-$1000000)).w
		beq.s   loc_19C58
		lea     ($2000).w,a1
		jsr     (DmaTilesViaFF8804bis).w
		jsr     (SetFFDE94b3andWait).w
		movea.l (sp)+,a0
		move.w  (a0),d0
		adda.w  d0,a0
		lea     ($3200).w,a1
		move.w  #$900,d0
		jsr     (DmaTilesViaFF8804bis).w
		jsr     (SetFFDE94b3andWait).w
		bra.s   loc_19CA0
loc_19C58:
		lea     ($A400).l,a1
		jsr     (DmaTilesViaFF8804bis).w
		jsr     (SetFFDE94b3andWait).w
		movea.l (sp)+,a0
		move.w  (a0),d0
		adda.w  d0,a0
		lea     (FF8804_LOADING_SPACE).l,a1
		jsr     (LoadCompressedData).w
		lea     (FF8804_LOADING_SPACE).l,a0
		lea     (loc_B600).l,a1
		move.w  #$500,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		lea     ($D800).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
loc_19CA0:
		movea.l (sp)+,a0
		rts

	; End of function LoadInvocationSprite


; =============== S U B R O U T I N E =======================================

;     Loads spell animation tiles.
;     In: D0 = spell animation tileset index

LoadSpellGraphics:
		
		movea.l (p_pt_SpellGraphics).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		move.w  (a0)+,d0
		lea     ((PALETTE_3-$1000000)).w,a1
		lea     ((PALETTE3_BIS-$1000000)).w,a2
		move.w  (a0),$12(a1)
		move.w  (a0)+,$12(a2)
		move.w  (a0),$1A(a1)
		move.w  (a0)+,$1A(a2)
		move.w  (a0),$1C(a1)
		move.w  (a0)+,$1C(a2)
		jsr     (StoreVdpCommandster).w
		lea     ($A400).l,a1
		lsr.w   #1,d0
		moveq   #2,d1
		jsr     (DmaTilesViaFF8804bis).w
		jmp     (SetFFDE94b3andWait).w

	; End of function LoadSpellGraphics


; =============== S U B R O U T I N E =======================================

; loads spell graphics

sub_19CE8:
		movea.l (p_pt_SpellGraphics).l,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		move.w  (a0)+,d0        ; load bytes 0-1
		lea     ((PALETTE_3-$1000000)).w,a1
		lea     ((PALETTE3_BIS-$1000000)).w,a2
		move.w  (a0),$12(a1)    ; load 3 colors on 3rd palette
		move.w  (a0)+,$12(a2)
		move.w  (a0),$1A(a1)
		move.w  (a0)+,$1A(a2)
		move.w  (a0),$1C(a1)
		move.w  (a0)+,$1C(a2)
		jsr     (StoreVdpCommandster).w
		lea     (FF8804_LOADING_SPACE).l,a1
		jsr     (LoadCompressedData).w
		lea     (FF8804_LOADING_SPACE).l,a0
		lea     ($F000).l,a1
		move.w  #$300,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jmp     (SetFFDE94b3andWait).w

	; End of function sub_19CE8


; =============== S U B R O U T I N E =======================================

; get battle sprite # and palette # for character related to entity D0 -> D1 (sprite), D2 (palette)

GetBattleSpriteAndPalette:
		
		cmpi.w  #$FFFF,d0
		bne.s   loc_19D4C
		move.w  d0,d1
		move.w  d0,d2
		move.w  d0,d3
		rts
loc_19D4C:
		cmpi.w  #$80,d0 
		bcc.w   loc_19D90
		movem.l d0/a0,-(sp)
		jsr     j_GetClass      
		lea     AllyBattleSprites(pc), a0
		mulu.w  #9,d0
		adda.w  d0,a0
		moveq   #2,d0
loc_19D6A:
		cmp.b   (a0)+,d1
		beq.s   loc_19D80
		addq.w  #2,a0
		dbf     d0,loc_19D6A
		clr.w   d1
		clr.w   d2
		clr.w   d3
		movem.l (sp)+,d0/a0
		rts
loc_19D80:
		move.b  (a0)+,d1
		ext.w   d1
		move.b  (a0),d2
		ext.w   d2
		move.w  d1,d3
		movem.l (sp)+,d0/a0
		rts
loc_19D90:
		move.l  a0,-(sp)
		jsr     j_GetEnemyID
		lea     EnemyBattleSprites(pc), a0
		add.w   d1,d1
		move.b  1(a0,d1.w),d2
		ext.w   d2
		move.b  (a0,d1.w),d1
		ext.w   d1
		move.w  d1,d3
		movea.l (sp)+,a0
		rts

	; End of function GetBattleSpriteAndPalette


; =============== S U B R O U T I N E =======================================

; get battle sprite # and palette # for entity D0's equipped weapon -> D2 (sprite), D3 (palette)

GetWeaponSpriteAndPalette:
		
		movem.l d1/a0,-(sp)
		cmpi.w  #$80,d0 
		bcc.w   loc_19DF2
		jsr     j_GetEquippedWeapon
		andi.w  #ITEM_MASK_IDX,d1 
		;cmpi.w  #$1A,d1
		;bcs.w   loc_19DF2
		;cmpi.w  #$6D,d1 
		;bhi.w   loc_19DF2
		lea     WeaponBattleSprites(pc), a0
		;subi.w  #$1A,d1
		add.w   d1,d1
		move.b  (a0,d1.w),d2
		ext.w   d2
		move.b  1(a0,d1.w),d3
		ext.w   d3
		movem.l (sp)+,d1/a0
		rts
loc_19DF2:
		move.w  #$FFFF,d2
		move.w  d2,d3
		movem.l (sp)+,d1/a0
		rts

	; End of function GetWeaponSpriteAndPalette


; =============== S U B R O U T I N E =======================================

GetBattleBackground:
		
		movem.l d0/a0,-(sp)
		cmpi.w  #$FFFF,d0
		beq.s   loc_19E20
		cmpi.w  #$80,d0 
		bcs.s   loc_19E20
		jsr     j_GetEnemyID
		cmpi.w  #$62,d1 ; HARDCODED : if enemy is Zeon, get his own background
		bne.s   loc_19E20
		moveq   #$1B,d1
		bra.w   loc_19E58
loc_19E20:
		clr.w   d1
		move.b  ((CURRENT_BATTLE-$1000000)).w,d1
		lea     CustomBackgrounds(pc), a0
		move.b  (a0,d1.w),d1    ; get battle's own background if it has one
		cmpi.b  #$FF,d1
		bne.w   loc_19E58
		cmpi.w  #$FFFF,d0
		bne.s   loc_19E48
		move.w  ((word_FFB3FE-$1000000)).w,d0
		cmpi.w  #$FFFF,d0
		bne.s   loc_19E48
		clr.w   d0
loc_19E48:
		jsr     j_GetCurrentTerrainType
		andi.w  #$F,d0          ; get background according to terrain type
		move.b  TerrainBackgrounds(pc,d0.w),d1
		ext.w   d1
loc_19E58:
		movem.l (sp)+,d0/a0
		rts

	; End of function GetBattleBackground

TerrainBackgrounds:
		incbin "data/battles/global/terrainbackgrounds.bin"
						; mostly used for overworld battles, I guess !

; =============== S U B R O U T I N E =======================================

sub_19E6E:
		cmpi.w  #$80,d0 
		bcc.w   loc_19E90
		jsr     j_GetUpperMoveType
		cmpi.w  #5,d1
		beq.w   loc_19E90
		cmpi.w  #6,d1
		beq.w   loc_19E90
		bra.w   GetBattleBackground
loc_19E90:
		move.w  #$FFFF,d1
		rts

	; End of function sub_19E6E


; =============== S U B R O U T I N E =======================================

sub_19E96:
		movem.l a0,-(sp)
		lea     byte_1FAB8(pc), a0
		tst.b   (a0,d0.w)
		beq.s   loc_19EA8
		ori     #1,ccr
loc_19EA8:
		movem.l (sp)+,a0
		rts

	; End of function sub_19E96


; =============== S U B R O U T I N E =======================================

FadeInFromBlackIntoBattlescene:
		
		move.b  #1,((FADING_SETTING-$1000000)).w
		clr.w   ((unk_FFDFAA-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w
		rts

	; End of function FadeInFromBlackIntoBattlescene


; =============== S U B R O U T I N E =======================================

FadeOutToBlackForBattlescene:
		
		move.b  #OUT_TO_BLACK,((FADING_SETTING-$1000000)).w
		clr.w   ((unk_FFDFAA-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w
		rts

	; End of function FadeOutToBlackForBattlescene


; =============== S U B R O U T I N E =======================================

; spell animation subroutine

ExecuteSpellAnimation:
		
		tst.b   ((byte_FFB584-$1000000)).w
		bne.w   return_19F5C
		cmpi.b  #$FF,d0
		beq.w   return_19F5C
		move.w  d0,d1
		lsr.w   #5,d1
		andi.w  #3,d1
		addq.w  #1,d1
		btst    #7,d0
		beq.s   loc_19F0A
		bset    #7,d1
loc_19F0A:
		move.b  d1,((byte_FFB586-$1000000)).w
		andi.w  #$1F,d0
		add.w   d0,d0
		move.w  rjt_SpellAnimation(pc,d0.w),d0
		jmp     rjt_SpellAnimation(pc,d0.w)
rjt_SpellAnimation:
		
		dc.w sa00_Nothing-rjt_SpellAnimation
		dc.w sa01_-rjt_SpellAnimation
		dc.w sa02_-rjt_SpellAnimation
		dc.w sa03_-rjt_SpellAnimation
		dc.w sa04_-rjt_SpellAnimation
		dc.w sa05_-rjt_SpellAnimation
		dc.w sa06_-rjt_SpellAnimation
		dc.w sa07_-rjt_SpellAnimation
		dc.w sa08_-rjt_SpellAnimation
		dc.w sa09_-rjt_SpellAnimation
		dc.w sa0A_-rjt_SpellAnimation
		dc.w sa0B_-rjt_SpellAnimation
		dc.w sa0C_-rjt_SpellAnimation
		dc.w sa0D_-rjt_SpellAnimation
		dc.w sa0E_-rjt_SpellAnimation
		dc.w sa0F_-rjt_SpellAnimation
		dc.w sa10_-rjt_SpellAnimation
		dc.w sa11_Dao-rjt_SpellAnimation
		dc.w sa12_Atlas-rjt_SpellAnimation
		dc.w sa13_Neptun-rjt_SpellAnimation
		dc.w sa14_Apollo-rjt_SpellAnimation
		dc.w sa15_-rjt_SpellAnimation
		dc.w sa16_-rjt_SpellAnimation
		dc.w sa17_IceBreath-rjt_SpellAnimation
		dc.w sa18_-rjt_SpellAnimation
		dc.w sa19_-rjt_SpellAnimation
		dc.w sa1A_Detox-rjt_SpellAnimation
		dc.w sa1B_-rjt_SpellAnimation
		dc.w sa1C_-rjt_SpellAnimation
		dc.w sa1D_Blast-rjt_SpellAnimation
		dc.w sa1E_BurstRockExplosion-rjt_SpellAnimation
		dc.w sa1F_OddeyeBeam-rjt_SpellAnimation
return_19F5C:
		rts

	; End of function ExecuteSpellAnimation


; =============== S U B R O U T I N E =======================================

sub_19F5E:
		movem.l d1/a1,-(sp)
		lea     (byte_FFAFA0).l,a1
		move.b  7(a0),d1
		lsr.b   #4,d1
		move.b  d1,(a1,d0.w)
		lea     ((SPRITE_Y-$1000000)).w,a1
		move.w  d0,d1
		lsl.w   #3,d1
		adda.w  d1,a1
		move.w  2(a0),(a1)+
		clr.w   d1
		move.b  6(a0),d1
		lsl.w   #8,d1
		move.w  d1,(a1)+
		move.b  7(a0),d1
		andi.w  #3,d1
		ror.w   #5,d1
		or.w    4(a0),d1
		ori.w   #$C000,d1
		move.w  d1,(a1)+
		move.w  (a0),(a1)
		movem.l (sp)+,d1/a1
		addq.w  #8,a0
		addq.w  #1,d0
		rts

	; End of function sub_19F5E


; =============== S U B R O U T I N E =======================================

sub_19FAA:
		movem.l d0-d3/a1-a2,-(sp)
		subq.w  #1,d1
		addi.w  #$80,d2 
		addi.w  #$80,d3 
		lea     (byte_FFAFA0).l,a2
		adda.w  d0,a2
		lsl.w   #3,d0
		lea     ((SPRITE_Y-$1000000)).w,a1
		adda.w  d0,a1
loc_19FC8:
		move.w  2(a0),d0
		add.w   d3,d0
		move.w  d0,(a1)+
		clr.w   d0
		move.b  6(a0),d0
		lsl.w   #8,d0
		move.w  d0,(a1)+
		move.b  7(a0),d0
		andi.w  #3,d0
		ror.w   #5,d0
		or.w    4(a0),d0
		ori.w   #$C000,d0
		move.w  d0,(a1)+
		move.w  (a0),d0
		add.w   d2,d0
		move.w  d0,(a1)+
		move.b  7(a0),d0
		lsr.b   #4,d0
		move.b  d0,(a2)+
		addq.w  #8,a0
		dbf     d1,loc_19FC8
		movem.l (sp)+,d0-d3/a1-a2
		add.w   d1,d0
		rts

	; End of function sub_19FAA


; =============== S U B R O U T I N E =======================================

sub_1A00A:
		moveq   #$26,d0 
		moveq   #$19,d7
loc_1A00E:
		lea     word_1A020(pc), a0
		nop
		bsr.w   sub_19F5E
		dbf     d7,loc_1A00E
		jmp     (sub_1942).w    

	; End of function sub_1A00A

word_1A020:     dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0

; =============== S U B R O U T I N E =======================================

sub_1A028:
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   nullsub_184
		bsr.w   sub_1A0AA

	; End of function sub_1A028


; =============== S U B R O U T I N E =======================================

sub_1A034:
		clr.w   d0
		move.b  ((byte_FFB587-$1000000)).w,d0
		add.w   d0,d0
		move.w  rjt_1A048(pc,d0.w),d0
		jsr     rjt_1A048(pc,d0.w)
		bra.w   loc_1A088

	; End of function sub_1A034

rjt_1A048:      dc.w nullsub_184-rjt_1A048; related to ally or enemy reaction
		dc.w sub_1A21C-rjt_1A048
		dc.w sub_1A198-rjt_1A048
		dc.w sub_1A198-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w sub_1A146-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w sub_1A11E-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w sub_1A146-rjt_1A048
		dc.w sub_1A21C-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w sub_1A222-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w sub_1A11E-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w sub_1A198-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048
		dc.w nullsub_184-rjt_1A048

; START OF FUNCTION CHUNK FOR sub_1A034

loc_1A088:
		jsr     (StoreVdpCommandster).w
		jmp     (Set_FFDE94_bit3).w

; END OF FUNCTION CHUNK FOR sub_1A034


; =============== S U B R O U T I N E =======================================

nullsub_184:
		rts

	; End of function nullsub_184


; =============== S U B R O U T I N E =======================================

sub_1A092:
		tst.b   ((byte_FFB584-$1000000)).w
		bne.s   loc_1A0A2
		jsr     (StoreVdpCommandster).w
		jsr     (Set_FFDE94_bit3).w
		bra.s   return_1A0A8
loc_1A0A2:
		bsr.w   sub_1A270
		bsr.s   sub_1A034
return_1A0A8:
		rts

	; End of function sub_1A092


; =============== S U B R O U T I N E =======================================

sub_1A0AA:
		movem.l d7-a1,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		lea     ((PALETTE_1_BIS-$1000000)).w,a1
		moveq   #$1F,d7
loc_1A0B8:
		move.l  (a0)+,(a1)+
		dbf     d7,loc_1A0B8
		movem.l (sp)+,d7-a1
		rts

	; End of function sub_1A0AA


; =============== S U B R O U T I N E =======================================

sub_1A0C4:
		movem.l a0-a1,-(sp)
		lea     ((PALETTE_3-$1000000)).w,a0
		lea     ((PALETTE3_BIS-$1000000)).w,a1
		move.w  $12(a0),$12(a1)
		move.l  $1A(a0),$1A(a1)
		movem.l (sp)+,a0-a1
		rts

	; End of function sub_1A0C4


; =============== S U B R O U T I N E =======================================

sub_1A0E2:
		movem.l a0-a1,-(sp)
		lea     ((PALETTE_3-$1000000)).w,a0
		lea     ((PALETTE3_BIS-$1000000)).w,a1
		move.w  $12(a1),$12(a0)
		move.l  $1A(a1),$1A(a0)
		movem.l (sp)+,a0-a1
		rts

	; End of function sub_1A0E2


; =============== S U B R O U T I N E =======================================

sub_1A100:
		movem.l d6-a0,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		moveq   #$3F,d7 
loc_1A10A:
		move.w  (a0),d6
		lsr.w   #1,d6
		andi.w  #$777,d6
		move.w  d6,(a0)+
		dbf     d7,loc_1A10A
		movem.l (sp)+,d6-a0
		rts

	; End of function sub_1A100


; =============== S U B R O U T I N E =======================================

sub_1A11E:
		bsr.s   sub_1A100
		bra.s   sub_1A0E2

	; End of function sub_1A11E


; =============== S U B R O U T I N E =======================================

sub_1A122:
		movem.l d5-a0,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		moveq   #$3F,d7 
loc_1A12C:
		move.w  (a0),d6
		lsr.w   #1,d6
		move.w  d6,d5
		lsr.w   #1,d5
		andi.w  #$333,d5
		add.w   d5,d6
		move.w  d6,(a0)+
		dbf     d7,loc_1A12C
		movem.l (sp)+,d5-a0
		rts

	; End of function sub_1A122


; =============== S U B R O U T I N E =======================================

sub_1A146:
		bsr.s   sub_1A122
		bra.s   sub_1A0E2

	; End of function sub_1A146


; =============== S U B R O U T I N E =======================================

sub_1A14A:
		movem.l d0-d2/a0,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		moveq   #$3F,d2 
loc_1A154:
		move.w  (a0),d0
		andi.w  #$F,d0
		lsr.w   #1,d0
		move.w  (a0),d1
		andi.w  #$F0,d1 
		lsr.w   #4,d1
		add.w   d1,d0
		move.w  (a0),d1
		andi.w  #$F00,d1
		lsr.w   #8,d1
		lsr.w   #2,d1
		add.w   d1,d0
		lsl.w   #1,d0
		ext.l   d0
		divu.w  #3,d0
		cmpi.w  #$E,d0
		bls.s   loc_1A182
		moveq   #$E,d0
loc_1A182:
		move.w  d0,d1
		lsl.w   #4,d1
		or.w    d1,d0
		lsl.w   #4,d1
		or.w    d1,d0
		move.w  d0,(a0)+
		dbf     d2,loc_1A154
		movem.l (sp)+,d0-d2/a0
		rts

	; End of function sub_1A14A


; =============== S U B R O U T I N E =======================================

sub_1A198:
		bsr.s   sub_1A14A
		bra.w   sub_1A0E2

	; End of function sub_1A198


; =============== S U B R O U T I N E =======================================

sub_1A19E:
		movem.l d0-d1/a0,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		moveq   #$3F,d7 
loc_1A1A8:
		move.w  (a0),d0
		move.w  d0,d1
		andi.w  #$E00,d0
		lsr.w   #1,d1
		andi.w  #$EE,d1 
		or.w    d1,d0
		move.w  d0,(a0)+
		dbf     d7,loc_1A1A8
		movem.l (sp)+,d0-d1/a0
		rts

	; End of function sub_1A19E


; =============== S U B R O U T I N E =======================================

sub_1A1C4:
		bsr.s   sub_1A19E
		bra.w   sub_1A0E2

	; End of function sub_1A1C4


; =============== S U B R O U T I N E =======================================

sub_1A1CA:
		movem.l d0-d1/a0,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		moveq   #$3F,d7 
loc_1A1D4:
		move.w  (a0),d0
		move.w  d0,d1
		andi.w  #$E0,d0 
		lsr.w   #1,d1
		andi.w  #$E0E,d1
		or.w    d1,d0
		move.w  d0,(a0)+
		dbf     d7,loc_1A1D4
		movem.l (sp)+,d0-d1/a0
		rts

	; End of function sub_1A1CA


; =============== S U B R O U T I N E =======================================

sub_1A1F0:
		bsr.s   sub_1A1CA
		bra.w   sub_1A0E2

	; End of function sub_1A1F0


; =============== S U B R O U T I N E =======================================

sub_1A1F6:
		movem.l d0-d1/a0,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		moveq   #$3F,d7 
loc_1A200:
		move.w  (a0),d0
		move.w  d0,d1
		andi.w  #$E,d0
		lsr.w   #1,d1
		andi.w  #$EE0,d1
		or.w    d1,d0
		move.w  d0,(a0)+
		dbf     d7,loc_1A200
		movem.l (sp)+,d0-d1/a0
		rts

	; End of function sub_1A1F6


; =============== S U B R O U T I N E =======================================

sub_1A21C:
		bsr.s   sub_1A1F6
		bra.w   sub_1A0E2

	; End of function sub_1A21C


; =============== S U B R O U T I N E =======================================

sub_1A222:
		movem.l d0/a0-a1,-(sp)
		bsr.s   sub_1A1F6
		lea     ((PALETTE_1-$1000000)).w,a0
		lea     ((PALETTE_1_BIS-$1000000)).w,a1
		moveq   #7,d0
loc_1A232:
		move.l  (a1)+,(a0)+
		dbf     d0,loc_1A232
		lea     $20(a0),a0
		lea     $20(a1),a1
		moveq   #7,d0
loc_1A242:
		move.l  (a1)+,(a0)+
		dbf     d0,loc_1A242
		movem.l (sp)+,d0/a0-a1
		rts

	; End of function sub_1A222


; =============== S U B R O U T I N E =======================================

sub_1A24E:
		movem.l d7-a1,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		lea     ((PALETTE_1_BIS-$1000000)).w,a1
		moveq   #$1F,d7
loc_1A25C:
		move.l  (a1)+,(a0)+
		dbf     d7,loc_1A25C
		jsr     (StoreVdpCommandster).w
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,d7-a1
		rts

	; End of function sub_1A24E


; =============== S U B R O U T I N E =======================================

sub_1A270:
		movem.l d7-a1,-(sp)
		lea     ((PALETTE_1-$1000000)).w,a0
		lea     ((PALETTE_1_BIS-$1000000)).w,a1
		move.w  $52(a0),-(sp)
		move.l  $5A(a0),-(sp)
		moveq   #$1F,d7
loc_1A286:
		move.l  (a1)+,(a0)+
		dbf     d7,loc_1A286
		lea     ((PALETTE_1-$1000000)).w,a0
		move.l  (sp)+,$5A(a0)
		move.w  (sp)+,$52(a0)
		jsr     (StoreVdpCommandster).w
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,d7-a1
		rts

	; End of function sub_1A270


; =============== S U B R O U T I N E =======================================

;     In: D0 = color to flash

ExecSpellAnimationFlash:
		
		move.w  d0,d6
		moveq   #3,d7
loc_1A2AA:
		move.w  d6,((PALETTE_1-$1000000)).w
		move.w  d6,((byte_FFD044-$1000000)).w
		jsr     (StoreVdpCommandster).w
		moveq   #4,d0
		jsr     (Sleep).w       
		clr.w   ((PALETTE_1-$1000000)).w
		clr.w   ((byte_FFD044-$1000000)).w
		jsr     (StoreVdpCommandster).w
		moveq   #3,d0
		jsr     (Sleep).w       
		dbf     d7,loc_1A2AA
		rts

	; End of function ExecSpellAnimationFlash


; =============== S U B R O U T I N E =======================================

;     Clears a portion at RAM:b406 and RAM:b532 for spell properties.

ClearSpellAnimationProperties:
		
		movem.l d7-a0,-(sp)
		lea     ((byte_FFB406-$1000000)).w,a0
		moveq   #$4A,d7 
loc_1A2DE:
		clr.l   (a0)+
		dbf     d7,loc_1A2DE
		lea     ((byte_FFB532-$1000000)).w,a0
		moveq   #3,d7
loc_1A2EA:
		clr.l   (a0)+
		dbf     d7,loc_1A2EA
		movem.l (sp)+,d7-a0
		rts

	; End of function ClearSpellAnimationProperties


; =============== S U B R O U T I N E =======================================

sub_1A2F6:
		movem.l d6-d7,-(sp)
		lea     ((byte_FFB406-$1000000)).w,a0
		clr.w   d6
		moveq   #$18,d7
loc_1A302:
		tst.w   (a0)
		bne.s   loc_1A316
		move.w  d0,(a0)
		clr.l   2(a0)
		clr.l   6(a0)
		clr.w   $A(a0)
		bra.s   loc_1A324
loc_1A316:
		lea     $C(a0),a0
		addq.w  #1,d6
		dbf     d7,loc_1A302
		move.w  #$FFFF,d6
loc_1A324:
		move.w  d6,d0
		movem.l (sp)+,d6-d7
		rts

	; End of function sub_1A2F6


; =============== S U B R O U T I N E =======================================

; code for invocations

LoadInvocationSpell:
		
		movem.l d0/a6,-(sp)
		trap    #SOUND_COMMAND  ; play spell sound
		dc.w SFX_SPELL_CAST
		move.w  #$CCE,d0
		bsr.w   ExecSpellAnimationFlash
		move.w  ((BATTLESCENE_CHARACTER-$1000000)).w,((word_FFB400-$1000000)).w
		lea     ((byte_FFB562-$1000000)).w,a6
		move.w  #$FFFF,(a6)
		clr.w   2(a6)
		bsr.w   bsc07_switchAllies
		movem.l (sp)+,d0/a6
		jsr     (WaitForVInt).w 
		clr.w   d1
		bsr.w   LoadInvocationSprite
		moveq   #8,d0
		jsr     (Sleep).w       
		bchg    #6,((byte_FFB56E-$1000000)).w
		jsr     (StoreVdpCommandster).w
		bsr.w   sub_1A380
		jsr     (SetFFDE94b3andWait).w
		bset    #4,((byte_FFB56F-$1000000)).w
		rts

	; End of function LoadInvocationSpell


; =============== S U B R O U T I N E =======================================

sub_1A380:
		lea     ((dword_FFDD20-$1000000)).w,a1
		tst.w   4(a0)
		bne.s   loc_1A39C
		bclr    #5,((byte_FFB56F-$1000000)).w
		moveq   #5,d1
		moveq   #2,d4
		lea     (byte_1F776).l,a2
		bra.s   loc_1A3AC
loc_1A39C:
		bset    #5,((byte_FFB56F-$1000000)).w
		moveq   #3,d1
		moveq   #3,d4
		lea     (byte_1F7BE).l,a2
loc_1A3AC:
		btst    #6,((byte_FFB56E-$1000000)).w
		beq.s   loc_1A3B8
		lea     $24(a2),a2
loc_1A3B8:
		lea     (byte_FFAFB4).l,a3
		move.w  (a0),d0
loc_1A3C0:
		move.w  2(a0),d2
		move.w  d4,d3
loc_1A3C6:
		move.w  d2,(a1)+
		move.w  #$F00,(a1)+
		move.w  (a2)+,(a1)+
		move.w  d0,(a1)+
		move.b  #2,(a3)+
		addi.w  #$20,d2 
		dbf     d3,loc_1A3C6
		addi.w  #$20,d0 
		dbf     d1,loc_1A3C0
		jmp     (sub_1942).w    

	; End of function sub_1A380


; =============== S U B R O U T I N E =======================================

sub_1A3E8:
		lea     ((byte_FFDD24-$1000000)).w,a0
		lea     (byte_1F776).l,a1
		moveq   #$11,d0
		btst    #5,((byte_FFB56F-$1000000)).w
		beq.s   loc_1A402
		lea     $48(a1),a1
		moveq   #$F,d0
loc_1A402:
		btst    #6,((byte_FFB56E-$1000000)).w
		beq.s   loc_1A40E
		lea     $24(a1),a1
loc_1A40E:
		move.w  (a1)+,(a0)
		addq.w  #8,a0
		dbf     d0,loc_1A40E
		rts

	; End of function sub_1A3E8


; START OF FUNCTION CHUNK FOR bsc05_makeAllyIdle

loc_1A418:
		btst    #4,((byte_FFB56F-$1000000)).w
		beq.s   return_1A474
		bsr.w   bsc0D_endAnimation
		move.b  #OUT_TO_BLACK,((FADING_SETTING-$1000000)).w
		clr.w   ((unk_FFDFAA-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.b  #1,((FADING_PALETTE_FLAGS-$1000000)).w
loc_1A43E:
		tst.b   ((FADING_SETTING-$1000000)).w
		bne.s   loc_1A43E
		lea     ((dword_FFDD20-$1000000)).w,a0
		moveq   #$11,d0
loc_1A44A:
		move.w  #1,(a0)+
		clr.l   (a0)+
		move.w  #1,(a0)+
		dbf     d0,loc_1A44A
		move.l  a6,-(sp)
		lea     ((byte_FFB562-$1000000)).w,a6
		move.w  ((word_FFB400-$1000000)).w,(a6)
		move.w  #3,2(a6)
		bsr.w   bsc07_switchAllies
		movea.l (sp)+,a6
		bclr    #4,((byte_FFB56F-$1000000)).w
return_1A474:
		rts

; END OF FUNCTION CHUNK FOR bsc05_makeAllyIdle


; =============== S U B R O U T I N E =======================================

nullsub_12:
		rts

	; End of function nullsub_12


; =============== S U B R O U T I N E =======================================

sa00_Nothing:
		rts

	; End of function sa00_Nothing


; =============== S U B R O U T I N E =======================================

sa01_:
		bsr.s   nullsub_12
		move.w  d1,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$22E,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #2,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		btst    #7,d1
		bne.s   loc_1A4A2
		lea     loc_1A58A(pc), a1
		bra.s   loc_1A4A6
loc_1A4A2:
		lea     byte_1A5B2(pc), a1
loc_1A4A6:
		andi.w  #7,d1
		add.w   d1,d1
		move.w  d1,d2
		lsl.w   #2,d1
		add.w   d2,d1
		adda.w  d1,a1
		move.l  (a1),((byte_FFB532-$1000000)).w
		move.l  4(a1),((dword_FFB536-$1000000)).w
		move.w  8(a1),((byte_FFB53A-$1000000)).w
		clr.w   d2
		move.b  1(a1),d2
		clr.w   d3
		move.b  2(a1),d3
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #5,2(a0)
		moveq   #2,d0
		bsr.w   sub_1A2F6
		lea     byte_1A5E4(pc), a0
		clr.w   d0
		move.b  (a1),d0
		lsl.w   #4,d0
		adda.w  d0,a0
		moveq   #$26,d0 
		moveq   #2,d1
		bsr.w   sub_19FAA
		clr.w   d1
		move.b  5(a1),d1
		beq.s   loc_1A52A
		subq.w  #1,d1
loc_1A500:
		moveq   #$F,d6
		jsr     (UpdateRandomSeed).w
		move.w  d7,d0
		andi.w  #1,d0
		addq.w  #1,d0
		bsr.w   sub_1A2F6
		move.w  #$10,d6
		jsr     (UpdateRandomSeed).w
		move.w  d1,d4
		lsl.w   #3,d4
		add.w   d4,d7
		addq.w  #1,d7
		move.b  d7,3(a0)
		dbf     d1,loc_1A500
loc_1A52A:
		btst    #2,((byte_FFB586-$1000000)).w
		beq.w   loc_1A56E
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$40,2(a0) 
		move.w  #$40,4(a0) 
		move.w  #$80,6(a0) 
		moveq   #$1F,d0
		lea     ((byte_FFB496-$1000000)).w,a0
loc_1A552:
		move.w  d2,(a0)
		addi.w  #$80,(a0)+ 
		move.w  d3,(a0)
		addi.w  #$80,(a0)+ 
		dbf     d0,loc_1A552
		moveq   #$2C,d0 
		moveq   #8,d1
		lea     byte_1A614(pc), a0
		bsr.w   sub_19FAA
loc_1A56E:
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #1,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  5(a1),d0
		addq.b  #1,d0
		move.b  d0,((byte_FFB584-$1000000)).w
loc_1A58A:
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa01_

		dc.b 0
		dc.b $48
		dc.b $70
		dc.b $70
		dc.b 0
		dc.b 0
		dc.b $50
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 1
		dc.b $44
		dc.b $60
		dc.b $80
		dc.b 0
		dc.b $A
		dc.b $50
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 2
		dc.b $40
		dc.b $50
		dc.b $70
		dc.b 1
		dc.b $E
		dc.b $50
		dc.b 0
		dc.b 0
		dc.b 0
byte_1A5B2:     dc.b 2
		dc.b $40
		dc.b $50
		dc.b $70
		dc.b 1
		dc.b 4
		dc.b $50
		dc.b $20
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b $B0
		dc.b $80
		dc.b $80
		dc.b 0
		dc.b 0
		dc.b $30
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 1
		dc.b $AC
		dc.b $70
		dc.b $90
		dc.b 0
		dc.b $A
		dc.b $30
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 2
		dc.b $A8
		dc.b $60
		dc.b $80
		dc.b 1
		dc.b $E
		dc.b $30
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 2
		dc.b $A8
		dc.b $60
		dc.b $80
		dc.b 1
		dc.b 4
		dc.b $30
		dc.b $80
		dc.b $20
		dc.b 0
byte_1A5E4:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $41
		dc.b 7
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $41
		dc.b 7
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $51
		dc.b $B
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $20
		dc.b 5
		dc.b $5D
		dc.b 9
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $75
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $20
		dc.b 5
		dc.b $85
		dc.b $F
		dc.b $20
byte_1A614:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $31
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $28
		dc.b $A
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $28
		dc.b $A
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $28
		dc.b $A
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $28
		dc.b $A
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $28
		dc.b $A
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $24
		dc.b 5
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $20
		dc.b 5
		dc.b $20

; =============== S U B R O U T I N E =======================================

sa02_:
		bsr.w   nullsub_12
		move.w  d1,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$E22,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #$B,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		lea     (loc_1A6CC+2)(pc), a0; need to fix that ugly offset reference with the true data begin label
		bclr    #7,d1
		beq.s   loc_1A680
		lea     $30(a0),a0
loc_1A680:
		lsl.w   #2,d1
		move.w  d1,d0
		lsl.w   #1,d1
		add.w   d0,d1
		adda.w  d1,a0
		lea     ((byte_FFB532-$1000000)).w,a1
		move.b  #1,$E(a1)
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0),(a1)
		moveq   #1,d1
		btst    #2,((byte_FFB586-$1000000)).w
		beq.s   loc_1A6B4
		moveq   #$14,d0
		bsr.w   sub_1A2F6
		move.b  #2,(byte_FFAFC6).l
		addq.w  #1,d1
loc_1A6B4:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
loc_1A6C0:
		move.b  #2,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
loc_1A6CC:
		move.b  d1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa02_

		dc.b 1
		dc.b $70
		dc.b 0
		dc.b $9E
		dc.b $10
		dc.b 0
		dc.b 0
		dc.b $A0
		dc.b $FF
		dc.b $FA
		dc.b 0
		dc.b $C8
		dc.b 1
		dc.b $70
		dc.b 0
		dc.b $9E
		dc.b $16
		dc.b 0
		dc.b 0
		dc.b $C0
		dc.b $FF
		dc.b $FA
		dc.b 0
		dc.b $C8
		dc.b 1
		dc.b $70
		dc.b 0
		dc.b $9E
		dc.b $1C
		dc.b 0
		dc.b 0
		dc.b $E0
		dc.b $FF
		dc.b $FA
		dc.b 0
		dc.b $C8
		dc.b 1
		dc.b $70
		dc.b 0
		dc.b $9E
		dc.b $22
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b $FF
		dc.b $FA
		dc.b 0
		dc.b $C8
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $E2
		dc.b $10
		dc.b 0
		dc.b 0
		dc.b $A0
		dc.b 1
		dc.b 6
		dc.b 1
		dc.b $38
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $E2
		dc.b $16
		dc.b 0
		dc.b 0
		dc.b $C0
		dc.b 1
		dc.b 6
		dc.b 1
		dc.b $38
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $E2
		dc.b $1C
		dc.b 0
		dc.b 0
		dc.b $E0
		dc.b 1
		dc.b 6
		dc.b 1
		dc.b $38
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $E2
		dc.b $22
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 6
		dc.b 1
		dc.b $38

; =============== S U B R O U T I N E =======================================

sa03_:
		bsr.w   nullsub_12
		move.w  d1,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$222,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		bsr.w   sub_1A00A
		moveq   #$D,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		lea     ((byte_FFB532-$1000000)).w,a0
		bclr    #7,d1
		bne.s   loc_1A778
		move.w  #$C0,(a0) 
		move.w  #$98,2(a0) 
		move.w  #$80,d2 
		moveq   #2,d3
		bra.s   loc_1A786
loc_1A778:
		move.w  #$110,(a0)
		move.w  #$A8,2(a0) 
		clr.w   d2
		clr.b   d3
loc_1A786:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  d2,2(a0)
		move.w  #$8000,4(a0)
		move.b  d3,6(a0)
		moveq   #1,d2
		cmpi.b  #2,d1
		bcs.s   loc_1A7E2
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$20,2(a0) 
		move.w  #$1E,4(a0)
		move.w  #3,6(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$20,2(a0) 
		move.w  #$14,4(a0)
		move.w  #$301,6(a0)
		moveq   #$2A,d0 
		lea     byte_1A810(pc), a0
		bsr.w   sub_19F5E
		bsr.w   sub_19F5E
		addq.w  #2,d2
loc_1A7E2:
		move.l  #byte_1A820,((dword_FFB3C0-$1000000)).w
		move.w  #1,((word_FFB3C4-$1000000)).w
		move.b  #5,((byte_FFB583-$1000000)).w
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #3,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  d2,((byte_FFB584-$1000000)).w
		bra.w   sub_1A028

	; End of function sa03_

byte_1A810:     dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 5
		dc.b $80
		dc.b 5
		dc.b $20
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 5
		dc.b $84
		dc.b 5
		dc.b $21
byte_1A820:     dc.b 0
		dc.b $38
		dc.b $10
		dc.b $60
		dc.b 0
		dc.b 1
		dc.b $A8
		dc.b $28
		dc.b 0
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 3
		dc.b 0
		dc.b 0
		dc.b $FF
		dc.b $FD
		dc.b 0
		dc.b 0
		dc.b $FF
		dc.b $FB
		dc.b 0
		dc.b 0
		dc.b $FF
		dc.b $FB
		dc.b 0
		dc.b 0
		dc.b $FF
		dc.b $FD
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 3
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b 0
		dc.b 0

; =============== S U B R O U T I N E =======================================

sa04_:
		move.w  d1,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$CAC,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #6,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		bclr    #7,d1
		bne.s   loc_1A874
		lea     byte_1A908(pc), a0
		lea     byte_1A8F4(pc), a1
		moveq   #7,d4
		bra.s   loc_1A87E
loc_1A874:
		lea     byte_1A918(pc), a0
		lea     byte_1A8FE(pc), a1
		moveq   #3,d4
loc_1A87E:
		lea     ((byte_FFB532-$1000000)).w,a2
		move.l  (a1)+,(a2)+
		move.l  (a1)+,(a2)+
		move.w  (a1),(a2)+
		subq.w  #1,d1
		bne.s   loc_1A88E
		moveq   #1,d1
loc_1A88E:
		move.w  d1,(a2)
		move.b  d1,((byte_FFB584-$1000000)).w
		subq.w  #1,d1
		moveq   #$26,d0 
loc_1A898:
		movem.l d0-d1/a0,-(sp)
		moveq   #2,d1
		clr.w   d2
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		move.w  d7,d3
		bsr.w   sub_19FAA
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  d4,2(a0)
		moveq   #$1E,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.w  d7,8(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		moveq   #$C,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.w  d7,4(a0)
		movem.l (sp)+,d0-d1/a0
		addq.w  #2,d0
		dbf     d1,loc_1A898
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #4,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		bra.w   sub_1A028

	; End of function sa04_

byte_1A8F4:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b $10
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b $28
		dc.b 0
		dc.b $34
byte_1A8FE:     dc.b 0
		dc.b $35
		dc.b 0
		dc.b $45
		dc.b 0
		dc.b $55
		dc.b 0
		dc.b $5D
		dc.b 0
		dc.b $69
byte_1A908:     dc.b 1
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $30
		dc.b $F
		dc.b $20
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $40
		dc.b $D
		dc.b $20
byte_1A918:     dc.b $FF
		dc.b $E0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $65
		dc.b $F
		dc.b $21
		dc.b $FF
		dc.b $E0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $75
		dc.b $D
		dc.b $21

; =============== S U B R O U T I N E =======================================

sa05_:
		bsr.w   nullsub_12
		move.w  d1,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$CC2,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #$F,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		lea     ((byte_FFB532-$1000000)).w,a2
		bclr    #7,d1
		bne.s   loc_1A96E
		move.w  #$D0,(a2) 
		move.w  #$E0,2(a2) 
		cmpi.w  #3,d1
		bcs.s   loc_1A96C
		move.w  #$40,d2 
		move.w  d2,4(a2)
		move.w  #$50,d3 
loc_1A96C:
		bra.s   loc_1A98A
loc_1A96E:
		move.w  #$138,(a2)
		move.w  #$F0,2(a2) 
		cmpi.w  #3,d1
		bcs.s   loc_1A98A
		move.w  #$A8,d2 
		move.w  d2,4(a2)
		move.w  #$60,d3 
loc_1A98A:
		btst    #0,d1
		bne.s   loc_1A996
		move.w  #1,6(a2)
loc_1A996:
		moveq   #7,d1
		lea     (byte_FFAFC6).l,a1
loc_1A99E:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.b  d7,2(a0)
		move.b  #2,(a1)+
		dbf     d1,loc_1A99E
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$301,2(a0)
		move.b  #2,(byte_FFAFCE).l
		tst.w   4(a2)
		beq.s   loc_1AA06
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.b  #1,3(a0)
		move.w  d3,4(a0)
		addi.w  #$B4,4(a0) 
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.b  #2,3(a0)
		move.b  #$1E,4(a0)
		moveq   #$2F,d0 
		moveq   #3,d1
		lea     byte_1AA28(pc), a0
		bsr.w   sub_19FAA
loc_1AA06:
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #5,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa05_

byte_1AA28:     dc.b 0
		dc.b 8
		dc.b 0
		dc.b $30
		dc.b 5
		dc.b $AB
		dc.b 5
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $4B
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $20
		dc.b 5
		dc.b $5B
		dc.b $F
		dc.b $20

; =============== S U B R O U T I N E =======================================

sa06_:
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$A8A,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #7,d0
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #1,4(a0)
		lea     byte_1AA88(pc), a0
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #6,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		bra.w   sub_1A028

	; End of function sa06_

byte_1AA88:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $3B
		dc.b 0
		dc.b $20

; =============== S U B R O U T I N E =======================================

sa07_:
		bsr.w   nullsub_12
		move.w  d1,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$ECA,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #4,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		lea     loc_1AB4A(pc), a1
		andi.w  #7,d1
		lsl.w   #2,d1
		adda.w  d1,a1
		move.l  (a1),((byte_FFB532-$1000000)).w
		moveq   #$10,d0
		btst    #7,((byte_FFB586-$1000000)).w
		beq.s   loc_1AACC
		addi.w  #$80,d0 
loc_1AACC:
		move.w  d0,((dword_FFB536-$1000000)).w
		move.w  (a1),d1
		subq.w  #1,d1
loc_1AAD4:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.w  d7,4(a0)
		dbf     d1,loc_1AAD4
		move.w  2(a1),d1
		beq.s   loc_1AB2C
		subq.w  #1,d1
		move.w  (a1),d0
		mulu.w  #5,d0
		addi.w  #$26,d0 
		lea     byte_1AB5E(pc), a0
		btst    #7,((byte_FFB586-$1000000)).w
		beq.s   loc_1AB0C
		lea     $20(a0),a0
loc_1AB0C:
		movem.l d0/a0,-(sp)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		moveq   #8,d6
		jsr     (UpdateRandomSeed).w
		move.w  d7,2(a0)
		movem.l (sp)+,d0/a0
		bsr.w   sub_19F5E
		dbf     d1,loc_1AB0C
loc_1AB2C:
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #7,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  1(a1),((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
loc_1AB4A:
		bra.w   sub_1A028

	; End of function sa07_

		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 2
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 3
		dc.b 0
		dc.b 2
		dc.b 0
		dc.b 4
		dc.b 0
		dc.b 4
byte_1AB5E:     dc.b 0
		dc.b $C8
		dc.b 0
		dc.b $C0
		dc.b 5
		dc.b $B3
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b $98
		dc.b 0
		dc.b $D8
		dc.b 5
		dc.b $C3
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b $F8
		dc.b 0
		dc.b $C8
		dc.b 5
		dc.b $B3
		dc.b $F
		dc.b $20
		dc.b 1
		dc.b $30
		dc.b 0
		dc.b $B8
		dc.b 5
		dc.b $C3
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b $F8
		dc.b 0
		dc.b $C8
		dc.b 5
		dc.b $B3
		dc.b $F
		dc.b $20
		dc.b 1
		dc.b $30
		dc.b 0
		dc.b $B8
		dc.b 5
		dc.b $C3
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b $C8
		dc.b 0
		dc.b $C0
		dc.b 5
		dc.b $B3
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b $98
		dc.b 0
		dc.b $D8
		dc.b 5
		dc.b $C3
		dc.b $F
		dc.b $20

; =============== S U B R O U T I N E =======================================

sa08_:
		move.w  #$FFFE,d0
		moveq   #$1E,d1
		bra.w   loc_1ABAC

	; End of function sa08_


; =============== S U B R O U T I N E =======================================

sa19_:
		moveq   #2,d0
		moveq   #2,d1
loc_1ABAC:
		movem.w d0-d1,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$2C2,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		movem.w (sp)+,d0-d1
		move.w  d0,((byte_FFB532-$1000000)).w
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #1,2(a0)
		move.w  d1,4(a0)
		move.w  #$11D,((byte_FFB404-$1000000)).w
		move.b  #8,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		bra.w   sub_1A028

	; End of function sa19_


; =============== S U B R O U T I N E =======================================

sa09_:
		lea     byte_1ACC6(pc), a0
		bra.w   loc_1AC08

	; End of function sa09_


; =============== S U B R O U T I N E =======================================

sa1B_:
		lea     byte_1ACCC(pc), a0
		bra.w   loc_1AC08

	; End of function sa1B_


; =============== S U B R O U T I N E =======================================

sa1C_:
		lea     byte_1ACD2(pc), a0

	; End of function sa1C_


; START OF FUNCTION CHUNK FOR sa09_

loc_1AC08:
		move.l  a0,-(sp)
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$E22,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #9,d0
		bsr.w   LoadSpellGraphics
		movea.l (sp)+,a0
		lea     ((PALETTE_3-$1000000)).w,a1
		lea     ((PALETTE3_BIS-$1000000)).w,a2
		move.w  (a0),$12(a1)
		move.w  (a0)+,$12(a2)
		move.w  (a0),$1A(a1)
		move.w  (a0)+,$1A(a2)
		move.w  (a0),$1C(a1)
		move.w  (a0),$1C(a2)
		jsr     (StoreVdpCommandster).w
		lea     ((byte_FFB532-$1000000)).w,a0
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1AC5C
		move.w  #$40,(a0)+ 
		move.w  #$20,(a0) 
		bra.s   loc_1AC64
loc_1AC5C:
		move.w  #$A8,(a0)+ 
		move.w  #$30,(a0) 
loc_1AC64:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #1,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		moveq   #4,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #6,d7
		move.w  d7,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		moveq   #4,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$C,d7
		move.w  d7,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		moveq   #4,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$12,d7
		move.w  d7,4(a0)
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #9,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #4,((byte_FFB584-$1000000)).w
		bra.w   sub_1A028

; END OF FUNCTION CHUNK FOR sa09_

byte_1ACC6:     dc.b 8
		dc.b $88
		dc.b $B
		dc.b $BB
		dc.b $D
		dc.b $DD
byte_1ACCC:     dc.b 8
		dc.b $4E
		dc.b $E
		dc.b $C6
		dc.b $F
		dc.b $DA
byte_1ACD2:     dc.b 8
		dc.b $4E
		dc.b 9
		dc.b $8E
		dc.b $D
		dc.b $BF

; =============== S U B R O U T I N E =======================================

sa0A_:
		trap    #SOUND_COMMAND
		dc.w SFX_WARP
		move.w  #$F,d0
		bra.w   ExecSpellAnimationFlash

	; End of function sa0A_


; =============== S U B R O U T I N E =======================================

sa0B_:
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		moveq   #$16,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		lea     ((byte_FFB532-$1000000)).w,a1
		cmpi.w  #$35,((ENEMY_BATTLE_SPRITE-$1000000)).w 
		bne.s   loc_1AD0C
		move.l  #$B000EA,(a1)
		move.w  #1,4(a1)
		bra.s   loc_1AD16
loc_1AD0C:
		move.l  #$C000D0,(a1)
		clr.w   4(a1)
loc_1AD16:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$B,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa0B_


; =============== S U B R O U T I N E =======================================

sa0C_:
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		moveq   #1,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		lea     ((byte_FFB532-$1000000)).w,a1
		bclr    #7,d1
		bne.s   loc_1AD62
		move.w  #$40,(a1) 
		move.w  #$80,2(a1) 
		bra.s   loc_1AD6A
loc_1AD62:
		move.w  #$C0,(a1) 
		clr.w   2(a1)
loc_1AD6A:
		andi.w  #7,d1
		add.w   d1,d1
		addi.w  #$2C,d1 
		move.w  d1,4(a1)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  (a1),2(a0)
		move.w  #$11D,((byte_FFB404-$1000000)).w
		move.b  #$C,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa0C_


; =============== S U B R O U T I N E =======================================

sa0D_:
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		moveq   #5,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d0
		clr.w   d1
		lea     byte_1AE40(pc), a0
		lea     (loc_1AE16+2)(pc), a1
		bclr    #7,d0
		beq.s   loc_1ADCA
		lea     $30(a0),a0
		lea     $18(a1),a1
loc_1ADCA:
		cmpi.b  #2,d0
		bcs.s   loc_1ADDA
		addq.w  #1,d1
		cmpi.b  #3,d0
		bcs.s   loc_1ADDA
		moveq   #3,d0
loc_1ADDA:
		lsl.w   #3,d0
		adda.w  d0,a1
		add.w   d0,d0
		adda.w  d0,a0
		lea     ((byte_FFB532-$1000000)).w,a2
		move.w  d1,(a2)+
		move.l  (a1)+,(a2)+
		move.l  (a1)+,(a2)
		moveq   #$26,d0 
		addq.w  #1,d1
		clr.w   d2
		clr.w   d3
		bsr.w   sub_19FAA
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$72,((byte_FFB404-$1000000)).w 
		move.b  #$D,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
loc_1AE16:
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa0D_

		dc.b $F2
		dc.b 0
		dc.b 1
		dc.b $90
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b $E8
		dc.b $F2
		dc.b 0
		dc.b 1
		dc.b $90
		dc.b 1
		dc.b $98
		dc.b 0
		dc.b $E8
		dc.b $F2
		dc.b 0
		dc.b 1
		dc.b $90
		dc.b 1
		dc.b $B0
		dc.b 0
		dc.b $E8
		dc.b $E
		dc.b 0
		dc.b 0
		dc.b $60
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b $F0
byte_1AE40:     dc.b $E
		dc.b 0
		dc.b 0
		dc.b $58
		dc.b 0
		dc.b $78
		dc.b 0
		dc.b $F0
		dc.b $E
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b $60
		dc.b 0
		dc.b $F0
		dc.b 0
		dc.b $98
		dc.b 0
		dc.b $6C
		dc.b 5
		dc.b $20
		dc.b $C
		dc.b $11
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $98
		dc.b 0
		dc.b $6C
		dc.b 5
		dc.b $28
		dc.b 0
		dc.b $11
		dc.b 0
		dc.b $A0
		dc.b 0
		dc.b $6C
		dc.b 5
		dc.b $24
		dc.b $C
		dc.b $11
		dc.b 0
		dc.b $68
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $2D
		dc.b $C
		dc.b $11
		dc.b 0
		dc.b $88
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $29
		dc.b $C
		dc.b $11
		dc.b 0
		dc.b $50
		dc.b 0
		dc.b $64
		dc.b 5
		dc.b $20
		dc.b $C
		dc.b $10
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $50
		dc.b 0
		dc.b $64
		dc.b 5
		dc.b $24
		dc.b $C
		dc.b $10
		dc.b 0
		dc.b $70
		dc.b 0
		dc.b $64
		dc.b 5
		dc.b $28
		dc.b 0
		dc.b $10
		dc.b 0
		dc.b $50
		dc.b 0
		dc.b $62
		dc.b 5
		dc.b $29
		dc.b $C
		dc.b $10
		dc.b 0
		dc.b $70
		dc.b 0
		dc.b $62
		dc.b 5
		dc.b $2D
		dc.b $C
		dc.b $10

; =============== S U B R O U T I N E =======================================

sa0E_:
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		moveq   #$12,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d0
		lea     byte_1AEFA(pc), a1
		btst    #7,d0
		beq.s   loc_1AECA
		addq.w  #8,a1
loc_1AECA:
		lea     ((byte_FFB532-$1000000)).w,a2
		move.l  (a1)+,(a2)+
		move.l  (a1),(a2)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$11D,((byte_FFB404-$1000000)).w
		move.b  #$E,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa0E_

byte_1AEFA:     dc.b $F3
		dc.b 0
		dc.b $FF
		dc.b $C0
		dc.b 1
		dc.b $80
		dc.b 0
		dc.b $E8
		dc.b $D
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b $70
		dc.b 0
		dc.b $F0

; =============== S U B R O U T I N E =======================================

sa0F_:
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		moveq   #$10,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d0
		lea     byte_1AF7C(pc), a0
		lea     byte_1AF64(pc), a1
		btst    #7,d0
		beq.s   loc_1AF2C
		addq.w  #8,a0
		lea     $C(a1),a1
loc_1AF2C:
		lea     ((byte_FFB532-$1000000)).w,a2
		move.l  (a1)+,(a2)+
		move.l  (a1)+,(a2)+
		move.l  (a1),(a2)
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$11D,((byte_FFB404-$1000000)).w
		move.b  #$F,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa0F_

byte_1AF64:     dc.b $F4
		dc.b 0
		dc.b $FF
		dc.b $C0
		dc.b 1
		dc.b $80
		dc.b 0
		dc.b $E8
		dc.b 0
		dc.b $50
		dc.b 0
		dc.b $60
		dc.b $C
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b $70
		dc.b 0
		dc.b $F0
		dc.b 0
		dc.b $B8
		dc.b 0
		dc.b $70
byte_1AF7C:     dc.b 1
		dc.b $20
		dc.b 0
		dc.b $E8
		dc.b 5
		dc.b $6C
		dc.b 5
		dc.b $10
		dc.b 0
		dc.b $C8
		dc.b 0
		dc.b $E0
		dc.b 5
		dc.b $6C
		dc.b 5
		dc.b $11

; =============== S U B R O U T I N E =======================================

sa10_:
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		moveq   #$11,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d0
		lea     byte_1B002(pc), a0
		lea     byte_1AFEA(pc), a1
		btst    #7,d0
		beq.s   loc_1AFAE
		addq.w  #8,a0
		lea     $C(a1),a1
loc_1AFAE:
		lea     ((byte_FFB532-$1000000)).w,a2
		move.l  (a1)+,(a2)+
		move.l  (a1)+,(a2)+
		move.l  (a1),(a2)
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		moveq   #1,d0
		bsr.w   sub_1A2F6
		bsr.w   sub_1A0AA
		move.w  #$11D,((byte_FFB404-$1000000)).w
		move.b  #$10,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa10_

byte_1AFEA:     dc.b $F3
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 1
		dc.b $80
		dc.b 0
		dc.b $E8
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b $38
		dc.b $D
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $70
		dc.b 0
		dc.b $F0
		dc.b 0
		dc.b $88
		dc.b 0
		dc.b $48
byte_1B002:     dc.b 1
		dc.b $3E
		dc.b 0
		dc.b $FA
		dc.b 5
		dc.b $20
		dc.b 5
		dc.b $10
		dc.b 0
		dc.b $D0
		dc.b 0
		dc.b $E0
		dc.b 5
		dc.b $20
		dc.b 5
		dc.b $10

; =============== S U B R O U T I N E =======================================

sa11_Dao:
		bsr.w   ClearSpellAnimationProperties
		bclr    #6,((byte_FFB56E-$1000000)).w
		clr.w   d0
		bsr.w   LoadInvocationSpell
		moveq   #1,d1
		moveq   #6,d2
loc_1B026:
		movem.w d1-d2,-(sp)
		cmpi.w  #1,d2
		beq.s   loc_1B036
		jsr     (WaitForVInt).w 
		bra.s   loc_1B040
loc_1B036:
		trap    #SOUND_COMMAND
		dc.w SFX_INTRO_LIGHTNING
		moveq   #$14,d0
		jsr     (Sleep).w       
loc_1B040:
		clr.w   d0
		bsr.w   LoadInvocationSprite
		bchg    #6,((byte_FFB56E-$1000000)).w
		bsr.w   sub_1A3E8
		movem.w (sp)+,d1-d2
		addq.w  #1,d1
		dbf     d2,loc_1B026
		moveq   #3,d0
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$5A,((byte_FFB532-$1000000)).w 
		lea     (FF8804_LOADING_SPACE).l,a0
		move.w  #$3FF,d0
loc_1B076:
		clr.l   (a0)+
		dbf     d0,loc_1B076
		move.l  #byte_1B0CC,((dword_FFB3C0-$1000000)).w
		move.w  #1,((word_FFB3C4-$1000000)).w
		move.l  #byte_1B0CE,((dword_FFB3C6-$1000000)).w
		move.w  #$A,((word_FFB3CA-$1000000)).w
		move.b  #$F,((byte_FFB583-$1000000)).w
		move.b  #1,((byte_FFB56B-$1000000)).w
		bclr    #3,((byte_FFB56E-$1000000)).w
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$11,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa11_Dao

byte_1B0CC:     dc.b 4
		dc.b 1
byte_1B0CE:     dc.b 3
		dc.b $14

; =============== S U B R O U T I N E =======================================

sa12_Atlas:
		bsr.w   ClearSpellAnimationProperties
		bclr    #6,((byte_FFB56E-$1000000)).w
		moveq   #3,d0
		bsr.w   LoadInvocationSpell
		trap    #SOUND_COMMAND
		dc.w SFX_INTRO_LIGHTNING
		lea     ((dword_FFDD20-$1000000)).w,a0
		moveq   #$15,d0
loc_1B0EA:
		move.l  a0,-(sp)
		moveq   #$F,d1
loc_1B0EE:
		addq.w  #8,(a0)
		addq.w  #8,a0
		dbf     d1,loc_1B0EE
		movea.l (sp)+,a0
		jsr     (WaitForVInt).w 
		dbf     d0,loc_1B0EA
		moveq   #3,d0
		moveq   #1,d1
		bsr.w   LoadInvocationSprite
		moveq   #$1E,d0
		jsr     (Sleep).w       
		bchg    #6,((byte_FFB56E-$1000000)).w
		bsr.w   sub_1A3E8
		moveq   #3,d0
		moveq   #2,d1
		bsr.w   LoadInvocationSprite
		moveq   #$13,d0
		bsr.w   sub_19CE8       
		lea     (byte_FF8B04).l,a0
		lea     ($3000).w,a1
		move.w  #$100,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
		lea     (byte_FF8D04).l,a0
		lea     ($4200).w,a1
		move.w  #$100,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
		lea     (byte_FF8F04).l,a0
		lea     ($B400).l,a1
		move.w  #$100,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
		lea     (byte_FF9104).l,a0
		lea     ($DE00).l,a1
		move.w  #$100,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (SetFFDE94b3andWait).w
		moveq   #$26,d0 
		lea     byte_1B1FA(pc), a0
		bsr.w   sub_19F5E
		jsr     (WaitForVInt).w 
		trap    #SOUND_COMMAND
		dc.w SFX_BATTLEFIELD_DEATH
		lea     ((byte_FFDDB0-$1000000)).w,a0
		moveq   #$13,d0
		moveq   #1,d1
loc_1B1A4:
		move.w  (a0),d2
		exg     d1,d2
		move.w  d2,(a0)
		jsr     (WaitForVInt).w 
		dbf     d0,loc_1B1A4
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #2,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.l  #byte_1B202,((dword_FFB3C0-$1000000)).w
		move.w  #1,((word_FFB3C4-$1000000)).w
		move.b  #5,((byte_FFB583-$1000000)).w
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$12,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #2,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa12_Atlas

byte_1B1FA:     dc.b 1
		dc.b $12
		dc.b 0
		dc.b $CB
		dc.b 7
		dc.b $80
		dc.b 5
		dc.b $20
byte_1B202:     dc.b 0
		dc.b $38
		dc.b 8
		dc.b $60
		dc.b 0
		dc.b 1
		dc.b $B2
		dc.b $A
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 2
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FE
		dc.b $FF
		dc.b $FF
		dc.b 0
		dc.b 0

; =============== S U B R O U T I N E =======================================

sa13_Neptun:
		bsr.w   ClearSpellAnimationProperties
		bclr    #6,((byte_FFB56E-$1000000)).w
		moveq   #2,d0
		bsr.w   LoadInvocationSpell
		moveq   #2,d0
		moveq   #1,d1
		bsr.w   LoadInvocationSprite
		trap    #SOUND_COMMAND
		dc.w SFX_PRISM_LASER_FIRING
		bset    #6,((byte_FFB56E-$1000000)).w
		moveq   #$14,d1
		moveq   #9,d2
		lea     byte_1B358(pc), a0
		lea     6(a0),a1
loc_1B248:
		movem.l d1-d2/a0-a1,-(sp)
		bsr.w   sub_1A380
		movem.l (sp)+,d1-d2/a0-a1
		swap    d2
		tst.w   d2
		bne.s   loc_1B25E
		moveq   #1,d0
		bra.s   loc_1B268
loc_1B25E:
		subq.w  #1,d2
		bne.s   loc_1B266
		move.w  #1,d2
loc_1B266:
		move.w  d2,d0
loc_1B268:
		jsr     (Sleep).w       
		exg     a0,a1
		dbf     d1,loc_1B248
		moveq   #$E,d0
		bsr.w   sub_19CE8       
		moveq   #$26,d0 
		lea     byte_1B364(pc), a0
		bsr.w   sub_19F5E
		moveq   #$19,d0
		jsr     (Sleep).w       
		bclr    #6,((byte_FFB56E-$1000000)).w
		bsr.w   sub_1A3E8
		trap    #SOUND_COMMAND
		dc.w SFX_DESOUL_HOVERING
		moveq   #2,d0
		moveq   #0,d1
		moveq   #$10,d2
		lea     ((byte_FFDDB0-$1000000)).w,a0
loc_1B2A0:
		subi.w  #5,(a0)
		subq.w  #1,d0
		bne.s   loc_1B2BE
		moveq   #2,d0
		bchg    #0,d1
		bne.s   loc_1B2B8
		move.w  #$C78C,4(a0)
		bra.s   loc_1B2BE
loc_1B2B8:
		move.w  #$C786,4(a0)
loc_1B2BE:
		jsr     (WaitForVInt).w 
		dbf     d2,loc_1B2A0
		moveq   #$E,d0
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.b  #1,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #2,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #5,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #8,4(a0)
		lea     (byte_FFAFA1).l,a0
		moveq   #$F,d0
loc_1B304:
		move.b  #1,(a0)+
		dbf     d0,loc_1B304
		lea     (byte_FFAFC6).l,a0
		moveq   #$15,d0
loc_1B314:
		move.b  #1,(a0)+
		dbf     d0,loc_1B314
		moveq   #$14,d0
		jsr     (Sleep).w       
		move.l  #byte_1B36C,((dword_FFB3C0-$1000000)).w
		move.w  #1,((word_FFB3C4-$1000000)).w
		move.b  #5,((byte_FFB583-$1000000)).w
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$13,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #4,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa13_Neptun

byte_1B358:     dc.b 1
		dc.b 0
		dc.b 0
		dc.b $B0
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
byte_1B364:     dc.b 1
		dc.b $28
		dc.b 0
		dc.b $C0
		dc.b 7
		dc.b $80
		dc.b 6
		dc.b $20
byte_1B36C:     dc.b 0
		dc.b $38
		dc.b 4
		dc.b $60
		dc.b 0
		dc.b 1
		dc.b $B3
		dc.b $74
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b $FF
		dc.b $FF
		dc.b 0
		dc.b 0

; =============== S U B R O U T I N E =======================================

sa14_Apollo:
		bsr.w   ClearSpellAnimationProperties
		bclr    #6,((byte_FFB56E-$1000000)).w
		moveq   #1,d0
		bsr.w   LoadInvocationSpell
		moveq   #1,d0
		moveq   #1,d1
		bsr.w   LoadInvocationSprite
		lea     ((byte_FFB532-$1000000)).w,a0
		move.w  #$900,(a0)+
		move.w  #$A00,(a0)+
		move.w  #$F700,(a0)+
		move.w  #$A00,(a0)+
		move.w  #$50,(a0) 
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #6,4(a0)
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #1,4(a0)
		move.w  #1,8(a0)
		lea     (byte_FFAFB4).l,a0
		lea     (byte_FFAFC6).l,a1
		moveq   #$F,d0
loc_1B3D8:
		move.b  #2,(a0)+
		move.b  #2,(a1)+
		dbf     d0,loc_1B3D8
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$14,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #2,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa14_Apollo


; =============== S U B R O U T I N E =======================================

sa15_:
		bsr.w   ClearSpellAnimationProperties
		moveq   #8,d0
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		jsr     sub_1A2F6(pc)
		cmpi.w  #$31,((ENEMY_BATTLE_SPRITE-$1000000)).w 
		bne.s   loc_1B426
		move.w  #$28,4(a0) 
		bra.s   loc_1B42C
loc_1B426:
		move.w  #5,2(a0)
loc_1B42C:
		moveq   #4,d1
loc_1B42E:
		moveq   #1,d0
		jsr     sub_1A2F6(pc)
		moveq   #$10,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.w  d7,2(a0)
		dbf     d1,loc_1B42E
		lea     byte_1B480(pc), a0
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		lea     (byte_FFAFC6).l,a1
		moveq   #$F,d0
loc_1B456:
		move.b  #2,(a1)+
		dbf     d0,loc_1B456
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$15,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB589-$1000000)).w
		bra.w   sub_1A028

	; End of function sa15_

byte_1B480:     dc.b 0
		dc.b $B8
		dc.b 0
		dc.b $D4
		dc.b 5
		dc.b $23
		dc.b $F
		dc.b $20

; =============== S U B R O U T I N E =======================================

sa16_:
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		clr.w   d0
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  (sp)+,d1
		andi.w  #7,d1
		cmpi.w  #2,d1
		bcs.s   loc_1B4CE
		lea     byte_1B4F0(pc), a0
		lea     ((PALETTE_3-$1000000)).w,a1
		lea     ((PALETTE3_BIS-$1000000)).w,a2
		move.w  (a0),$12(a1)
		move.w  (a0)+,$12(a2)
		move.w  (a0),$1A(a1)
		move.w  (a0)+,$1A(a2)
		move.w  (a0),$1C(a1)
		move.w  (a0),$1C(a2)
		jsr     (StoreVdpCommandster).w
loc_1B4CE:
		move.w  #$E4,((byte_FFB404-$1000000)).w 
		move.b  #$16,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa16_

byte_1B4F0:     dc.b $C
		dc.b $BF
		dc.b $B
		dc.b $9A
		dc.b $B
		dc.b $46

; =============== S U B R O U T I N E =======================================

sa18_:
		andi.w  #7,d1
		subq.w  #1,d1
		beq.w   loc_1B508
		subq.w  #1,d1
		beq.w   loc_1B53E
		rts
loc_1B508:
		bclr    #3,((byte_FFB56E-$1000000)).w
		move.w  #$EEE,d0
		bsr.w   ExecSpellAnimationFlash
		move.l  #byte_1B53A,((dword_FFB3C6-$1000000)).w
		move.w  #1,((word_FFB3CA-$1000000)).w
		move.b  #$A,((byte_FFB583-$1000000)).w
loc_1B52A:
		tst.w   ((word_FFB3CA-$1000000)).w
		bne.s   loc_1B52A
		clr.l   ((dword_FFB3C6-$1000000)).w
		clr.b   ((byte_FFB583-$1000000)).w
		rts
byte_1B53A:
		dc.b 1
		dc.b $28
		dc.b $68
		dc.b $18
loc_1B53E:
		btst    #7,((byte_FFB586-$1000000)).w
		beq.s   loc_1B55C
		cmpi.w  #$35,((ENEMY_BATTLE_SPRITE-$1000000)).w 
		bne.s   loc_1B550
		rts
loc_1B550:
		btst    #2,((byte_FFB56F-$1000000)).w
		beq.s   loc_1B55A
		rts
loc_1B55A:
		bra.s   loc_1B570
loc_1B55C:
		cmpi.b  #$FF,((BATTLE_BACKGROUND-$1000000)).w
		bne.s   loc_1B566
		rts
loc_1B566:
		btst    #1,((byte_FFB56F-$1000000)).w
		beq.s   loc_1B570
		rts
loc_1B570:
		bsr.w   ClearSpellAnimationProperties
		moveq   #$A,d0
		bsr.w   LoadSpellGraphics
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((word_FFB3FA-$1000000)).w,a3
		lea     word_1B608(pc), a0
		btst    #7,((byte_FFB586-$1000000)).w
		beq.s   loc_1B594
		addq.w  #8,a0
		lea     ((word_FFB3F6-$1000000)).w,a3
loc_1B594:
		move.w  2(a0),6(a5)
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		jsr     (sub_1942).w    
		trap    #SOUND_COMMAND
		dc.w SFX_PSHHH          ; long "psshhhh"
		move.w  #5,4(a5)
		lea     ((byte_FFDDB0-$1000000)).w,a4
loc_1B5B2:
		jsr     (WaitForVInt).w 
		addq.w  #1,(a5)
		btst    #0,1(a5)
		bne.s   loc_1B5CA
		move.w  #1,(a4)
		move.w  #1,(a3)
		bra.s   loc_1B5D2
loc_1B5CA:
		move.w  6(a5),(a4)
		move.w  #$FFFF,(a3)
loc_1B5D2:
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1B5E0
		addq.w  #1,6(a4)
		bra.s   loc_1B5E4
loc_1B5E0:
		subq.w  #1,6(a4)
loc_1B5E4:
		subq.w  #1,4(a5)
		bne.s   loc_1B5B2
		move.w  #5,4(a5)
		addq.w  #1,2(a5)
		cmpi.w  #3,2(a5)
		bcc.w   loc_1B604
		addq.w  #4,4(a4)
		bra.s   loc_1B5B2
loc_1B604:
		bra.w   sub_1A00A

	; End of function sa18_

word_1B608:     dc.w $138
		dc.w $110
		dc.w $520
		dc.w $520
		dc.w $C0
		dc.w $100
		dc.w $520
		dc.w $520

; =============== S U B R O U T I N E =======================================

sa1A_Detox:
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		move.w  #$8A8,d0
		bsr.w   ExecSpellAnimationFlash
		bsr.w   ClearSpellAnimationProperties
		moveq   #7,d0
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #1,4(a0)
		lea     byte_1AA88(pc), a0
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$1A,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		bra.w   sub_1A028

	; End of function sa1A_Detox


; =============== S U B R O U T I N E =======================================

sa17_IceBreath:
		
		bsr.w   ClearSpellAnimationProperties
		moveq   #$C,d0
		bsr.w   LoadSpellGraphics
		lea     ((byte_FFB532-$1000000)).w,a1
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1B67C
		move.w  #$50,(a1) 
		bra.s   loc_1B680
loc_1B67C:
		move.w  #$D0,(a1) 
loc_1B680:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$17,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa17_IceBreath


; =============== S U B R O U T I N E =======================================

sa1D_Blast:
		bsr.w   ClearSpellAnimationProperties
		btst    #0,d1
		beq.s   loc_1B6B6
		moveq   #$14,d0
		bra.s   loc_1B6B8
loc_1B6B6:
		moveq   #$F,d0
loc_1B6B8:
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$D0,4(a0) 
		move.w  #$64,((byte_FFB404-$1000000)).w 
		move.b  #$1D,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa1D_Blast


; =============== S U B R O U T I N E =======================================

sa1E_BurstRockExplosion:
		
		bsr.w   ClearSpellAnimationProperties
		moveq   #$10,d0
		bsr.w   LoadSpellGraphics
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$1E,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		bra.w   sub_1A028

	; End of function sa1E_BurstRockExplosion


; =============== S U B R O U T I N E =======================================

; and maybe Zynk's beam too ?

sa1F_OddeyeBeam:
		
		move.w  d1,-(sp)
		bsr.w   ClearSpellAnimationProperties
		moveq   #$15,d0
		bsr.w   LoadSpellGraphics
		move.w  (sp)+,d1
		lea     byte_1B794(pc), a0
		btst    #7,d1
		beq.s   loc_1B732
		lea     $E(a0),a0
loc_1B732:
		lea     ((byte_FFB532-$1000000)).w,a1
		move.l  (a0)+,(a1)+
		move.w  (a0)+,(a1)
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		moveq   #1,d0
		bsr.w   sub_1A2F6
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1B756
		move.w  #$38,2(a0) 
		bra.s   loc_1B75C
loc_1B756:
		move.w  #$102,2(a0)
loc_1B75C:
		lea     (byte_FFAFC6).l,a1
		moveq   #7,d0
loc_1B764:
		move.b  #2,(a1)+
		dbf     d0,loc_1B764
		move.w  #$FFFF,((byte_FFB404-$1000000)).w
		move.b  #$1F,((byte_FFB587-$1000000)).w
		move.b  #1,((byte_FFB585-$1000000)).w
		move.b  #1,((byte_FFB584-$1000000)).w
		move.b  #1,((byte_FFB589-$1000000)).w
		move.b  #1,((byte_FFB588-$1000000)).w
		bra.w   sub_1A028

	; End of function sa1F_OddeyeBeam

byte_1B794:     dc.b 1
		dc.b 4
		dc.b 0
		dc.b $E9
		dc.b 8
		dc.b 0
		dc.b 1
		dc.b $1C
		dc.b 0
		dc.b $E5
		dc.b 5
		dc.b $20
		dc.b 5
		dc.b $21
		dc.b 0
		dc.b $D2
		dc.b 0
		dc.b $CC
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $D2
		dc.b 0
		dc.b $CC
		dc.b 5
		dc.b $24
		dc.b $C
		dc.b $20

; =============== S U B R O U T I N E =======================================

sub_1B7B0:
		tst.b   ((byte_FFB584-$1000000)).w
		beq.s   return_1B7C8
		move.b  ((byte_FFB585-$1000000)).w,d0
		beq.s   return_1B7C8
		subq.b  #1,d0
		beq.s   loc_1B7CE
		subq.b  #1,d0
		beq.s   loc_1B7CA
		bra.w   sub_1B82A
return_1B7C8:
		rts
loc_1B7CA:
		clr.w   ((byte_FFB404-$1000000)).w
loc_1B7CE:
		tst.w   ((byte_FFB404-$1000000)).w
		beq.s   loc_1B7D8
		subq.w  #1,((byte_FFB404-$1000000)).w
loc_1B7D8:
		clr.w   d7
		move.b  ((byte_FFB587-$1000000)).w,d7
		add.w   d7,d7
		move.w  rjt_SpellAnimations(pc,d7.w),d7
		jmp     rjt_SpellAnimations(pc,d7.w)

	; End of function sub_1B7B0

rjt_SpellAnimations:
		dc.w nullsub_13-rjt_SpellAnimations
		dc.w sub_1B93C-rjt_SpellAnimations
		dc.w sub_1BE9E-rjt_SpellAnimations
		dc.w sub_1C248-rjt_SpellAnimations
		dc.w sub_1C53E-rjt_SpellAnimations
		dc.w sub_1C7F6-rjt_SpellAnimations
		dc.w sub_1CC56-rjt_SpellAnimations
		dc.w spellanim_Bolt-rjt_SpellAnimations
		dc.w sub_1CFFC-rjt_SpellAnimations
		dc.w sub_1D038-rjt_SpellAnimations
		dc.w nullsub_22-rjt_SpellAnimations
		dc.w sub_1D0FE-rjt_SpellAnimations
		dc.w sub_1D2E6-rjt_SpellAnimations
		dc.w sub_1D4E6-rjt_SpellAnimations
		dc.w sub_1D5C6-rjt_SpellAnimations
		dc.w sub_1D786-rjt_SpellAnimations
		dc.w sub_1D9FC-rjt_SpellAnimations
		dc.w sub_1DCE8-rjt_SpellAnimations
		dc.w sub_1DE24-rjt_SpellAnimations
		dc.w sub_1DFD4-rjt_SpellAnimations
		dc.w sub_1E134-rjt_SpellAnimations
		dc.w sub_1E2D4-rjt_SpellAnimations
		dc.w sub_1E5D0-rjt_SpellAnimations
		dc.w sub_1E7B2-rjt_SpellAnimations
		dc.w nullsub_22-rjt_SpellAnimations
		dc.w sub_1CFFC-rjt_SpellAnimations
		dc.w sub_1E958-rjt_SpellAnimations
		dc.w sub_1D038-rjt_SpellAnimations
		dc.w sub_1D038-rjt_SpellAnimations
		dc.w loc_1EA0C-rjt_SpellAnimations
		dc.w sub_1EBBA-rjt_SpellAnimations
		dc.w sub_1ECC8-rjt_SpellAnimations

; =============== S U B R O U T I N E =======================================

nullsub_22:
		rts

	; End of function nullsub_22


; =============== S U B R O U T I N E =======================================

sub_1B82A:
		clr.w   ((PALETTE_1-$1000000)).w
		clr.w   ((byte_FFD044-$1000000)).w
		jsr     (StoreVdpCommandster).w
		jsr     (Set_FFDE94_bit3).w
		bsr.w   sub_1A00A
		bsr.w   ClearSpellAnimationProperties
		cmpi.b  #$11,((byte_FFB587-$1000000)).w
		bcs.s   loc_1B858
		cmpi.b  #$14,((byte_FFB587-$1000000)).w
		bhi.s   loc_1B858
		moveq   #$10,d0
		jsr     (InitSprites).w 
loc_1B858:
		clr.w   ((byte_FFB404-$1000000)).w
		clr.b   ((byte_FFB586-$1000000)).w
		clr.b   ((byte_FFB587-$1000000)).w
		clr.b   ((byte_FFB585-$1000000)).w
		clr.b   ((byte_FFB584-$1000000)).w
		clr.b   ((byte_FFB568-$1000000)).w
		clr.b   ((byte_FFB569-$1000000)).w
		clr.b   ((byte_FFB56A-$1000000)).w
		clr.b   ((byte_FFB588-$1000000)).w
		clr.b   ((byte_FFB589-$1000000)).w
		jmp     (WaitForVInt).w 

	; End of function sub_1B82A


; =============== S U B R O U T I N E =======================================

sub_1B884:
		movem.w d1-d2,-(sp)
		move.w  (a5),d1
loc_1B88A:
		cmp.w   (a0)+,d1
		bne.s   loc_1B8A6
		move.w  (a0)+,2(a4)
		move.w  4(a4),d2
		andi.w  #$F800,d2
		add.w   (a0),d2
		addi.w  #$520,d2
		move.w  d2,4(a4)
		bra.s   loc_1B8AC
loc_1B8A6:
		addq.w  #4,a0
		dbf     d0,loc_1B88A
loc_1B8AC:
		movem.w (sp)+,d1-d2
		rts

	; End of function sub_1B884


; =============== S U B R O U T I N E =======================================

sub_1B8B2:
		movem.w d0-d1/d6-d7,-(sp)
		addq.b  #1,((byte_FFB568-$1000000)).w
		move.b  ((byte_FFB568-$1000000)).w,d0
		cmp.b   ((byte_FFB569-$1000000)).w,d0
		bcs.s   loc_1B8F8
		clr.b   ((byte_FFB568-$1000000)).w
		tst.w   ((PALETTE_1-$1000000)).w
		bne.s   loc_1B8D6
		move.w  4(a0),d0
		move.w  (a0),d1
		bra.s   loc_1B8DC
loc_1B8D6:
		move.w  2(a0),d0
		clr.w   d1
loc_1B8DC:
		move.w  d0,d6
		jsr     (UpdateRandomSeed).w
		add.w   d7,d0
		move.b  d0,((byte_FFB569-$1000000)).w
		move.w  d1,((PALETTE_1-$1000000)).w
		move.w  d1,((byte_FFD044-$1000000)).w
		jsr     (StoreVdpCommandster).w
		jsr     (Set_FFDE94_bit3).w
loc_1B8F8:
		movem.w (sp)+,d0-d1/d6-d7
		rts

	; End of function sub_1B8B2


; =============== S U B R O U T I N E =======================================

sub_1B8FE:
		tst.b   ((byte_FFB56A-$1000000)).w
		bne.s   return_1B90A
		move.b  #4,((byte_FFB56A-$1000000)).w
return_1B90A:
		rts

	; End of function sub_1B8FE


; =============== S U B R O U T I N E =======================================

sub_1B90C:
		movem.w d5-d6,-(sp)
		clr.w   d5
		move.b  ((byte_FFB56A-$1000000)).w,d5
		add.w   d5,d5
		move.w  word_1B930(pc,d5.w),d6
		tst.w   d5
		beq.s   loc_1B92C
		add.w   ((word_FFB3EE-$1000000)).w,d6
		bsr.w   sub_1F1F0
		subq.b  #1,((byte_FFB56A-$1000000)).w
loc_1B92C:
		movem.w (sp)+,d5-d6
word_1B930:
		dc.w $4E75

	; End of function sub_1B90C

		dc.b $FF
		dc.b $FE
		dc.b 0
		dc.b 2
		dc.b 0
		dc.b 3
		dc.b $FF
		dc.b $FD

; =============== S U B R O U T I N E =======================================

nullsub_13:
		rts

	; End of function nullsub_13


; =============== S U B R O U T I N E =======================================

; desoul ?

sub_1B93C:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   (a5)
		beq.w   loc_1B9EA
		addq.w  #1,(a5)
		cmpi.w  #$28,(a5) 
		bne.s   loc_1B95A
		clr.b   ((byte_FFB588-$1000000)).w
loc_1B95A:
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   loc_1B982
		moveq   #1,d1
		move.w  d1,(a4)
		clr.l   2(a4)
		move.w  d1,6(a4)
		move.w  d1,8(a4)
		clr.l   $A(a4)
		move.w  d1,$E(a4)
		clr.w   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1B9EA
loc_1B982:
		subq.w  #1,2(a5)
		bne.w   loc_1B9BC
		move.w  #5,2(a5)
		lea     byte_1BE2A(pc), a0
		bchg    #0,6(a5)
		beq.s   loc_1B99E
		addq.w  #4,a0
loc_1B99E:
		clr.w   d1
		move.b  (a3),d1
		lsl.w   #3,d1
		move.w  (a0,d1.w),d2
		addi.w  #-$3AE0,d2
		move.w  d2,4(a4)
		move.w  2(a0,d1.w),d2
		addi.w  #-$3AE0,d2
		move.w  d2,$C(a4)
loc_1B9BC:
		btst    #0,1(a5)
		bne.s   loc_1B9D0
		move.w  #1,(a4)
		move.w  #1,8(a4)
		bra.s   loc_1B9EA
loc_1B9D0:
		clr.w   d1
		move.b  2(a3),d1
		addi.w  #$80,d1 
		move.w  d1,(a4)
		clr.w   d1
		move.b  3(a3),d1
		addi.w  #$80,d1 
		move.w  d1,8(a4)
loc_1B9EA:
		lea     ((byte_FFB41E-$1000000)).w,a5
		lea     ((byte_FFDDC0-$1000000)).w,a4
		moveq   #$28,d0 
		clr.w   d1
		move.b  5(a3),d1
		beq.w   loc_1BC0A
		subq.w  #1,d1
loc_1BA00:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1BBFA
		addq.w  #1,(a5)
		move.b  2(a5),d1
		bne.w   loc_1BA8C
		subq.b  #1,3(a5)
		bne.w   loc_1BBFA
		move.w  #$106,2(a5)
		lea     byte_1BE42(pc), a0
		tst.b   4(a3)
		beq.s   loc_1BA30
		lea     $20(a0),a0
loc_1BA30:
		bsr.w   sub_19F5E
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1BA42
		bset    #3,4(a4)
loc_1BA42:
		move.w  #$60,d6 
		jsr     (UpdateRandomSeed).w
		addi.w  #$80,d7 
		clr.w   d0
		move.b  6(a3),d0
		add.w   d0,d7
		move.w  d7,6(a4)
		move.w  #$100,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$300,d7
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1BA70
		neg.w   d7
loc_1BA70:
		move.w  d7,4(a5)
		move.w  #$200,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$700,d7
		move.w  d7,6(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_DESOUL_HOVERING
		bra.w   loc_1BBFA
loc_1BA8C:
		subq.b  #1,d1
		bne.w   loc_1BB46
		move.w  4(a5),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1BAA8
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1BAB6
loc_1BAA8:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1BAB6:
		move.w  d1,8(a5)
		add.w   d0,6(a4)
		move.w  6(a5),d0
		add.w   $A(a5),d0
		tst.w   d0
		bmi.s   loc_1BAD4
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1BAE2
loc_1BAD4:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1BAE2:
		move.w  d1,$A(a5)
		add.w   d0,(a4)
		cmpi.w  #$F8,(a4) 
		bcs.s   loc_1BAF8
		move.w  #$200,2(a5)
		bra.w   loc_1BBFA
loc_1BAF8:
		subq.b  #1,3(a5)
		move.b  3(a5),d1
		andi.w  #$3F,d1 
		bne.w   loc_1BBFA
		lea     byte_1BE46(pc), a0
		moveq   #6,d1
		btst    #6,3(a5)
		bne.s   loc_1BB1C
		bset    #6,d1
		addq.w  #8,a0
loc_1BB1C:
		move.b  d1,3(a5)
		tst.b   4(a3)
		beq.s   loc_1BB2A
		lea     $20(a0),a0
loc_1BB2A:
		move.w  (a0),d1
		addi.w  #-$4000,d1
		move.w  d1,4(a4)
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1BB42
		bset    #3,4(a4)
loc_1BB42:
		bra.w   loc_1BBFA
loc_1BB46:
		subq.b  #1,d1
		bne.w   loc_1BB80
		move.w  #$300,2(a5)
		lea     byte_1BE52(pc), a0
		tst.b   4(a3)
		beq.s   loc_1BB60
		lea     $20(a0),a0
loc_1BB60:
		move.w  (a4),d3
		move.w  6(a4),d2
		bsr.w   sub_19F5E
		move.w  d2,6(a4)
		move.w  d3,(a4)
		move.w  d3,$A(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_BATTLEFIELD_DEATH
		bsr.w   sub_1B8FE
		bra.w   loc_1BBFA
loc_1BB80:
		addq.b  #1,3(a5)
		cmpi.b  #6,3(a5)
		bne.s   loc_1BBAE
		lea     byte_1BE5A(pc), a0
		move.w  (a4),d3
		move.w  6(a4),d2
		tst.b   4(a3)
		beq.s   loc_1BBA2
		lea     $20(a0),a0
		bra.s   loc_1BBA4
loc_1BBA2:
		addq.w  #8,d3
loc_1BBA4:
		bsr.w   sub_19F5E
		move.w  d2,6(a4)
		move.w  d3,(a4)
loc_1BBAE:
		btst    #0,1(a5)
		bne.s   loc_1BBBC
		move.w  #1,(a4)
		bra.s   loc_1BBC0
loc_1BBBC:
		move.w  $A(a5),(a4)
loc_1BBC0:
		cmpi.b  #$C,3(a5)
		bcs.w   loc_1BBFA
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   loc_1BBE8
		clr.w   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1BBFA
loc_1BBE8:
		move.w  #1,(a5)
		move.w  #$14,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.w  d7,2(a5)
loc_1BBFA:
		movem.w (sp)+,d0-d1
		addq.w  #1,d0
		addq.w  #8,a4
		lea     $C(a5),a5
		dbf     d1,loc_1BA00
loc_1BC0A:
		bsr.w   sub_1B90C
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		btst    #2,((byte_FFB586-$1000000)).w
		bne.s   loc_1BC20
		rts
loc_1BC20:
		addq.w  #1,(a5)
		move.w  6(a5),d2
		tst.b   $F(a5)
		bne.s   loc_1BC3E
		addi.w  #$10,d2
		cmpi.w  #$300,d2
		bcs.s   loc_1BC3C
		move.b  #1,$F(a5)
loc_1BC3C:
		bra.s   loc_1BC4C
loc_1BC3E:
		subi.w  #$10,d2
		cmpi.w  #$100,d2
		bhi.s   loc_1BC4C
		clr.b   $F(a5)
loc_1BC4C:
		move.w  d2,6(a5)
		move.b  $E(a5),d1
		beq.w   loc_1BCEC
		move.w  2(a5),d0
		subq.b  #1,d1
		bne.s   loc_1BC64
		addq.w  #8,d0
		bra.s   loc_1BC66
loc_1BC64:
		subq.w  #8,d0
loc_1BC66:
		andi.w  #$FF,d0
		move.w  d0,2(a5)
		cmp.w   4(a5),d0
		bne.s   loc_1BC7E
		clr.b   $E(a5)
		move.w  #6,$10(a5)
loc_1BC7E:
		bsr.w   sub_1BD4C
		jsr     (sub_179C).w    
		move.w  d1,d0
		muls.w  d2,d0
		asr.l   #7,d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1BC9E
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1BCAC
loc_1BC9E:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1BCAC:
		move.w  d1,8(a5)
		add.w   d0,6(a4)
		move.w  6(a4),(a2)
		swap    d1
		muls.w  d2,d1
		asr.l   #7,d1
		add.w   $A(a5),d1
		tst.w   d1
		bmi.s   loc_1BCD0
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1BCDE
loc_1BCD0:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1BCDE:
		move.w  d0,$A(a5)
		add.w   d1,(a4)
		move.w  (a4),2(a2)
		bra.w   loc_1BD2E
loc_1BCEC:
		move.w  2(a5),d0
		move.w  6(a5),d2
		tst.w   $10(a5)
		beq.s   loc_1BD02
		subq.w  #1,$10(a5)
		bra.w   loc_1BC7E
loc_1BD02:
		bsr.w   sub_1BDA0
		bcc.w   loc_1BC7E
		move.w  d7,4(a5)
		move.w  2(a5),d0
		cmp.w   d7,d0
		bcc.s   loc_1BD18
		exg     d0,d7
loc_1BD18:
		sub.w   d7,d0
		cmpi.w  #$80,d0 
		bcc.s   loc_1BD28
		move.b  #2,$E(a5)
		bra.s   loc_1BD2E
loc_1BD28:
		move.b  #1,$E(a5)
loc_1BD2E:
		bclr    #3,4(a4)
		cmpi.w  #$40,2(a5) 
		bcs.s   return_1BD4A
		cmpi.w  #$C0,2(a5) 
		bcc.s   return_1BD4A
		bset    #3,4(a4)
return_1BD4A:
		rts

	; End of function sub_1B93C


; =============== S U B R O U T I N E =======================================

sub_1BD4C:
		movem.l d0-d2/a3-a4,-(sp)
		move.w  $12(a5),d0
		addq.w  #1,d0
		andi.w  #$1F,d0
		move.w  d0,$12(a5)
		lea     ((byte_FFB496-$1000000)).w,a2
		lsl.w   #2,d0
		move.w  d0,-(sp)
		lea     word_1BE82(pc), a3
		moveq   #6,d1
loc_1BD6C:
		addq.w  #8,a4
		sub.w   (a3)+,d0
		andi.w  #$7C,d0 
		move.w  (a2,d0.w),d2
		add.w   (a3),d2
		move.w  d2,6(a4)
		move.w  2(a2,d0.w),d2
		add.w   (a3)+,d2
		bchg    #1,$D(a5)
		bne.s   loc_1BD90
		move.w  d2,(a4)
		bra.s   loc_1BD92
loc_1BD90:
		clr.w   (a4)
loc_1BD92:
		dbf     d1,loc_1BD6C
		move.w  (sp)+,d0
		adda.w  d0,a2
		movem.l (sp)+,d0-d2/a3-a4
		rts

	; End of function sub_1BD4C


; =============== S U B R O U T I N E =======================================

sub_1BDA0:
		movem.w d1-d6,-(sp)
		clr.w   d1
		move.b  7(a3),d1
		addi.w  #$80,d1 
		clr.w   d2
		move.b  8(a3),d2
		addi.w  #$80,d2 
		move.w  6(a4),d3
		move.w  (a4),d4
		clr.w   d5
		clr.w   d6
		cmp.w   d1,d3
		bge.s   loc_1BDCC
		bset    #0,d5
		addq.w  #1,d6
loc_1BDCC:
		cmp.w   d2,d4
		bge.s   loc_1BDD6
		bset    #1,d5
		addq.w  #1,d6
loc_1BDD6:
		addi.w  #$80,d1 
		cmp.w   d1,d3
		ble.s   loc_1BDE4
		bset    #2,d5
		addq.w  #1,d6
loc_1BDE4:
		addi.w  #$50,d2 
		cmp.w   d2,d4
		ble.s   loc_1BDF2
		bset    #3,d5
		addq.w  #1,d6
loc_1BDF2:
		tst.w   d6
		beq.w   loc_1BE16
		subq.w  #1,d6
		bne.s   loc_1BE00
		moveq   #$41,d6 
		bra.s   loc_1BE02
loc_1BE00:
		moveq   #$21,d6 
loc_1BE02:
		jsr     (UpdateRandomSeed).w
		clr.w   d3
		move.b  byte_1BE1C(pc,d5.w),d3
		add.w   d3,d7
		andi.w  #$F0,d7 
		ori     #1,ccr
loc_1BE16:
		movem.w (sp)+,d1-d6
		rts

	; End of function sub_1BDA0

byte_1BE1C:     dc.b 0
		dc.b $E0
		dc.b $A0
		dc.b $D0
		dc.b $60
		dc.b 0
		dc.b $90
		dc.b 0
		dc.b $20
		dc.b $10
		dc.b 0
		dc.b 0
		dc.b $50
		dc.b $FF
byte_1BE2A:     dc.b 0
		dc.b $21
		dc.b 0
		dc.b $21
		dc.b 0
		dc.b $29
		dc.b 0
		dc.b $29
		dc.b 0
		dc.b $31
		dc.b 0
		dc.b $3D
		dc.b 0
		dc.b $43
		dc.b 0
		dc.b $4F
		dc.b 0
		dc.b $55
		dc.b 0
		dc.b $65
		dc.b 0
		dc.b $75
		dc.b 0
		dc.b $85
byte_1BE42:     dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
byte_1BE46:     dc.b 5
		dc.b $B5
		dc.b 5
		dc.b $20
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $B9
		dc.b 5
		dc.b $20
byte_1BE52:     dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $BD
		dc.b $A
		dc.b $20
byte_1BE5A:     dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $C6
		dc.b 9
		dc.b $20
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $CC
		dc.b $A
		dc.b $20
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $D5
		dc.b $A
		dc.b $20
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $DE
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b $80
		dc.b 0
		dc.b $60
		dc.b 5
		dc.b $EE
		dc.b $F
		dc.b $20
word_1BE82:     dc.w $C
		dc.b 0
		dc.b 4
		dc.b 0
		dc.b $C
		dc.b 0
		dc.b 4
		dc.b 0
		dc.b $C
		dc.b 0
		dc.b 4
		dc.b 0
		dc.b $C
		dc.b 0
		dc.b 4
		dc.b 0
		dc.b $C
		dc.b 0
		dc.b 4
		dc.b 0
		dc.b 8
		dc.b 0
		dc.b 8
		dc.b 0
		dc.b 8
		dc.b 0
		dc.b 8

; =============== S U B R O U T I N E =======================================

sub_1BE9E:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		moveq   #$26,d0 
		btst    #2,((byte_FFB586-$1000000)).w
		beq.w   loc_1BF5C
		tst.w   (a5)
		beq.w   loc_1BF54
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   loc_1BEC8
		clr.l   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1BF54
loc_1BEC8:
		subq.w  #1,(a5)
		bne.w   loc_1BF54
		move.w  #2,(a5)
		tst.w   2(a5)
		bne.w   loc_1BF1E
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1BEEC
		move.w  #$B8,d1 
		move.w  #$C8,d2 
		bra.s   loc_1BEF4
loc_1BEEC:
		move.w  #$120,d1
		move.w  #$D8,d2 
loc_1BEF4:
		moveq   #$30,d6 
		jsr     (UpdateRandomSeed).w
		add.w   d7,d2
		move.w  d2,(a4)
		move.w  #$200,2(a4)
		move.w  #$C570,4(a4)
		moveq   #$30,d6 
		jsr     (UpdateRandomSeed).w
		add.w   d7,d1
		move.w  d1,6(a4)
		addq.w  #1,2(a5)
		bra.w   loc_1BF54
loc_1BF1E:
		cmpi.w  #3,2(a5)
		bcc.w   loc_1BF42
		move.w  #$C570,d1
		btst    #0,3(a5)
		beq.s   loc_1BF36
		addq.w  #3,d1
loc_1BF36:
		move.w  d1,4(a4)
		addq.w  #1,2(a5)
		bra.w   loc_1BF54
loc_1BF42:
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.w   2(a5)
loc_1BF54:
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
loc_1BF5C:
		lea     ((byte_FFB532-$1000000)).w,a3
		addq.b  #1,$C(a3)
		move.b  $C(a3),$D(a3)
		lea     loc_1C170(pc), a2
		lea     (loc_1C184+2)(pc), a1; undefine operand to undo
		move.b  ((byte_FFB586-$1000000)).w,d2
		andi.w  #7,d2
		move.w  d2,d1
		mulu.w  #$2A,d2 
		adda.w  d2,a2
		lsl.w   #2,d1
		adda.w  d1,a1
		moveq   #$17,d1
loc_1BF88:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1C136
		addq.w  #1,(a5)
		tst.b   2(a5)
		bne.w   loc_1BFF4
		lea     (byte_FFAFA0).l,a0
		moveq   #$28,d6 
		jsr     (UpdateRandomSeed).w
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1BFBC
		addi.w  #$8C,d7 
		move.b  #1,(a0,d0.w)
		bra.s   loc_1BFC6
loc_1BFBC:
		addi.w  #$9C,d7 
		move.b  #2,(a0,d0.w)
loc_1BFC6:
		move.w  d7,$A(a5)
		move.w  d7,(a4)
		move.l  (a1),2(a4)
		moveq   #8,d6
		jsr     (UpdateRandomSeed).w
		add.w   (a3),d7
		move.w  d7,6(a4)
		addq.b  #1,2(a5)
		move.b  3(a3),3(a5)
		move.w  4(a3),4(a5)
		clr.l   6(a5)
		bra.w   loc_1C136
loc_1BFF4:
		cmpi.b  #1,2(a5)
		bne.w   loc_1C0BA
		cmpi.w  #$1C,(a5)
		bcs.s   loc_1C024
		addq.b  #1,2(a5)
		move.w  #$100,d6
		jsr     (UpdateRandomSeed).w
		move.b  d7,3(a5)
		clr.w   6(a5)
		move.w  (a4),8(a5)
		addq.w  #8,8(a5)
		bra.w   loc_1C136
loc_1C024:
		clr.w   d0
		move.b  3(a5),d0
		move.b  8(a3),d1
		ext.w   d1
		add.w   d1,d0
		andi.w  #$FF,d0
		move.b  d0,3(a5)
		jsr     (sub_179C).w    
		lsl.w   #3,d1
		add.w   6(a5),d1
		tst.w   d1
		bmi.s   loc_1C052
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1C060
loc_1C052:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1C060:
		move.w  d0,6(a5)
		add.w   d1,6(a4)
		swap    d1
		lsl.w   #3,d1
		add.w   8(a5),d1
		tst.w   d1
		bmi.s   loc_1C07E
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1C08C
loc_1C07E:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1C08C:
		move.w  d0,8(a5)
		add.w   d1,$A(a5)
		cmpi.w  #4,(a5)
		bne.w   loc_1C136
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1C136
		moveq   #1,d0
		bsr.w   sub_1A2F6
		cmpi.w  #$FFFF,d0
		beq.w   loc_1C136
		addq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1C136
loc_1C0BA:
		lea     (byte_FFAFA0).l,a0
		adda.w  d0,a0
		clr.w   d0
		move.b  3(a5),d0
		move.b  9(a3),d1
		ext.w   d1
		add.w   d1,d0
		andi.w  #$FF,d0
		move.b  d0,3(a5)
		move.w  4(a5),d1
		lsr.w   #2,d1
		swap    d1
		move.w  4(a5),d1
		jsr     (sub_1812).w
		add.w   $A(a3),d2
		move.w  d2,6(a4)
		swap    d2
		subq.w  #8,8(a5)
		add.w   8(a5),d2
		move.w  d2,$A(a5)
		cmpi.b  #$80,3(a5)
		bcc.s   loc_1C10C
		move.b  #0,(a0)
		bra.s   loc_1C110
loc_1C10C:
		move.b  #2,(a0)
loc_1C110:
		move.w  6(a3),d0
		add.w   d0,4(a5)
		cmpi.w  #$2E,(a5) 
		bcs.s   loc_1C136
		clr.l   (a5)
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
		clr.b   ((byte_FFB588-$1000000)).w
loc_1C136:
		bchg    #0,$D(a3)
		bne.s   loc_1C144
		move.w  #1,(a4)
		bra.s   loc_1C148
loc_1C144:
		move.w  $A(a5),(a4)
loc_1C148:
		lea     (a2),a0
		moveq   #6,d0
		bsr.w   sub_1B884
		movem.w (sp)+,d0-d1
		addq.w  #1,d0
		lea     $C(a5),a5
		addq.w  #8,a4
		dbf     d1,loc_1BF88
		subq.b  #1,$E(a3)
		bne.s   loc_1C178
		trap    #SOUND_COMMAND
		dc.w SFX_TINKLING       ; related to bolt ?
		moveq   #$E,d6
		jsr     (UpdateRandomSeed).w
loc_1C170:
		addi.w  #$A,d7
		move.b  d7,$E(a3)
loc_1C178:
		lea     byte_1C242(pc), a0
		bsr.w   sub_1B8B2
		tst.b   ((byte_FFB584-$1000000)).w
loc_1C184:
		beq.w   sub_1B82A
		rts

	; End of function sub_1BE9E

		dc.b 0
		dc.b 0
		dc.b $C5
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b $C5
		dc.b $21
		dc.b 5
		dc.b 0
		dc.b $C5
		dc.b $22
		dc.b $A
		dc.b 0
		dc.b $C5
		dc.b $26
		dc.b 0
		dc.b 8
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $28
		dc.b 0
		dc.b $D
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b $12
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $29
		dc.b 0
		dc.b $17
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b 2
		dc.b 0
		dc.b $1C
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $2A
		dc.b 0
		dc.b $22
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b 6
		dc.b 0
		dc.b $28
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $2E
		dc.b 0
		dc.b 8
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $29
		dc.b 0
		dc.b $D
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b 2
		dc.b 0
		dc.b $12
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $2A
		dc.b 0
		dc.b $17
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b 6
		dc.b 0
		dc.b $1C
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $2E
		dc.b 0
		dc.b $22
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $F
		dc.b 0
		dc.b $28
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $37
		dc.b 0
		dc.b 8
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $2A
		dc.b 0
		dc.b $D
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b 6
		dc.b 0
		dc.b $12
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $2E
		dc.b 0
		dc.b $17
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $F
		dc.b 0
		dc.b $1C
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $37
		dc.b 0
		dc.b $22
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $18
		dc.b 0
		dc.b $28
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b 8
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $2E
		dc.b 0
		dc.b $D
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $F
		dc.b 0
		dc.b $12
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b $37
		dc.b 0
		dc.b $17
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $18
		dc.b 0
		dc.b $1C
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b $22
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $18
		dc.b 0
		dc.b $28
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $40
byte_1C242:     dc.b $E
		dc.b $44
		dc.b 0
		dc.b 8
		dc.b 0
		dc.b 1

; =============== S U B R O U T I N E =======================================

sub_1C248:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   4(a3)
		bne.w   loc_1C362
		clr.w   d0
		move.b  4(a5),d0
		btst    #2,6(a5)
		bne.s   loc_1C27A
		addq.w  #1,d0
		cmpi.w  #$D0,d0 
		bcs.s   loc_1C278
		bset    #2,6(a5)
loc_1C278:
		bra.s   loc_1C288
loc_1C27A:
		subq.w  #1,d0
		cmpi.w  #$80,d0 
		bhi.s   loc_1C288
		bclr    #2,6(a5)
loc_1C288:
		move.b  d0,4(a5)
		lsr.w   #6,d0
		add.w   2(a5),d0
		andi.w  #$FF,d0
		move.w  d0,2(a5)
		btst    #1,6(a5)
		bne.s   loc_1C2C0
		tst.b   5(a5)
		beq.s   loc_1C2D2
		cmpi.w  #$80,d0 
		bcs.s   loc_1C2BE
		bset    #1,6(a5)
loc_1C2B4:
		lea     byte_1C51E(pc), a0
		moveq   #2,d4
		bsr.w   sub_1C4D8
loc_1C2BE:
		bra.s   loc_1C2DC
loc_1C2C0:
		tst.b   5(a5)
		beq.s   loc_1C2B4
		cmpi.w  #$80,d0 
		bhi.s   loc_1C2DC
		bclr    #1,6(a5)
loc_1C2D2:
		lea     word_1C4FE(pc), a0
		moveq   #1,d4
		bsr.w   sub_1C4D8
loc_1C2DC:
		clr.w   d2
		move.b  7(a5),d2
		btst    #3,6(a5)
		bne.s   loc_1C2F6
		subq.b  #1,d2
		bne.s   loc_1C2F4
		bset    #3,6(a5)
loc_1C2F4:
		bra.s   loc_1C304
loc_1C2F6:
		addq.b  #1,d2
		cmpi.b  #$FE,d2
		bcs.s   loc_1C304
		bclr    #3,6(a5)
loc_1C304:
		move.b  d2,7(a5)
		lsl.w   #3,d2
		move.w  #$1000,d1
		add.w   d2,d1
		swap    d1
		lsl.w   #2,d2
		move.w  #$3000,d1
		add.w   d2,d1
		jsr     (sub_1812).w
		add.w   (a3),d2
		move.w  d2,6(a4)
		move.w  d2,$E(a4)
		addi.w  #$20,d2 
		move.w  d2,$16(a4)
		move.w  d2,$1E(a4)
		swap    d2
		subq.b  #1,5(a5)
		bne.s   loc_1C348
		move.b  #$1C,5(a5)
		bchg    #0,6(a5)
loc_1C348:
		add.w   2(a3),d2
		move.w  d2,(a4)
		move.w  d2,$10(a4)
		addi.w  #$20,d2 
		move.w  d2,8(a4)
		move.w  d2,$18(a4)
		bra.w   loc_1C43A
loc_1C362:
		cmpi.w  #1,4(a3)
		bne.w   loc_1C3C4
		move.w  (a3),d0
		subi.w  #$20,d0 
		move.w  d0,6(a4)
		move.w  d0,$E(a4)
		addi.w  #$20,d0 
		move.w  d0,$16(a4)
		move.w  d0,$1E(a4)
		move.w  2(a3),d0
		addi.w  #$10,d0
		move.w  d0,(a4)
		move.w  d0,$10(a4)
		addi.w  #$20,d0 
		move.w  d0,8(a4)
		move.w  d0,$18(a4)
		addq.w  #1,4(a3)
		btst    #1,6(a5)
		bne.s   loc_1C3B4
		move.w  #$40,2(a5) 
		bra.s   loc_1C3BA
loc_1C3B4:
		move.w  #$C0,2(a5) 
loc_1C3BA:
		move.b  #$14,5(a5)
		bra.w   loc_1C43A
loc_1C3C4:
		cmpi.w  #2,4(a3)
		bne.w   loc_1C42A
		subq.b  #1,5(a5)
		bne.w   loc_1C43A
		lea     word_1C4FE(pc), a0
		btst    #1,6(a5)
		beq.s   loc_1C3E6
		lea     $20(a0),a0
loc_1C3E6:
		moveq   #$26,d0 
		moveq   #4,d1
		move.w  6(a4),d2
		subi.w  #$80,d2 
		move.w  (a4),d3
		subi.w  #$70,d3 
		bsr.w   sub_19FAA
		addi.w  #$30,4(a4) 
		addi.w  #$30,$C(a4) 
		addi.w  #$30,$14(a4) 
		addi.w  #$30,$1C(a4) 
		addq.w  #1,4(a3)
		move.b  #$20,5(a5) 
		trap    #SOUND_COMMAND
		dc.w SFX_DESOUL
		bsr.w   sub_1B8FE
		bra.w   loc_1C43A
loc_1C42A:
		bsr.w   sub_1B90C
		subq.b  #1,5(a5)
		bne.w   loc_1C43A
		clr.w   4(a3)
loc_1C43A:
		btst    #1,((byte_FFB586-$1000000)).w
		beq.w   loc_1C464
		lea     $C(a5),a5
		lea     $20(a4),a4
		move.w  #$FFF0,d2
		lea     ((byte_FFDDB0-$1000000)).w,a0
		bsr.w   sub_1C46E
		lea     $C(a5),a5
		addq.w  #8,a4
		moveq   #$20,d2 
		bsr.w   sub_1C46E
loc_1C464:
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1C248


; =============== S U B R O U T I N E =======================================

sub_1C46E:
		tst.w   (a5)
		beq.w   return_1C4D6
		addq.w  #1,(a5)
		move.w  2(a5),d0
		btst    #0,6(a5)
		bne.s   loc_1C486
		subq.w  #1,d0
		bra.s   loc_1C488
loc_1C486:
		addq.w  #1,d0
loc_1C488:
		move.w  d0,2(a5)
		asr.w   #1,d0
		add.w   6(a0),d0
		move.w  d0,6(a4)
		add.w   (a0),d2
		move.w  d2,(a4)
		subq.b  #1,7(a5)
		bne.s   loc_1C4BC
		move.b  #6,7(a5)
		bchg    #1,6(a5)
		bne.s   loc_1C4B6
		addi.w  #4,4(a4)
		bra.s   loc_1C4BC
loc_1C4B6:
		subi.w  #4,4(a4)
loc_1C4BC:
		subq.w  #1,4(a5)
		bne.w   return_1C4D6
		move.w  #$3C,4(a5) 
		bchg    #0,6(a5)
		bchg    #3,4(a4)
return_1C4D6:
		rts

	; End of function sub_1C46E


; =============== S U B R O U T I N E =======================================

sub_1C4D8:
		move.w  d0,-(sp)
		moveq   #$26,d0 
		moveq   #4,d1
		bsr.w   sub_19FAA
		lea     (byte_FFAFC6).l,a0
		move.b  d4,(a0)+
		move.b  d4,(a0)+
		move.b  d4,(a0)+
		move.b  d4,(a0)
		move.b  #$E,5(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_DESOUL_HOVERING
		move.w  (sp)+,d0
		rts

	; End of function sub_1C4D8

word_1C4FE:     dc.w 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $20
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $20
		dc.b 5
		dc.b $30
		dc.b $D
		dc.b $20
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $38
		dc.b $F
		dc.b $20
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b $20
		dc.b 5
		dc.b $48
		dc.b $D
		dc.b $20
byte_1C51E:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $38
		dc.b $F
		dc.b $21
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $20
		dc.b 5
		dc.b $48
		dc.b $D
		dc.b $21
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $20
		dc.b $F
		dc.b $21
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b $20
		dc.b 5
		dc.b $30
		dc.b $D
		dc.b $21

; =============== S U B R O U T I N E =======================================

sub_1C53E:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		moveq   #$26,d0 
		move.w  $A(a3),d1
		subq.w  #1,d1
loc_1C552:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1C73E
		addq.w  #1,(a5)
		move.w  2(a5),d1
		andi.w  #3,d1
		cmpi.w  #3,d1
		bne.w   loc_1C5B6
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   loc_1C57E
		clr.w   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1C73E
loc_1C57E:
		subq.w  #1,8(a5)
		bne.w   loc_1C73E
		move.w  #2,(a5)
		move.w  2(a5),d1
		addq.w  #1,d1
		andi.w  #7,d1
		move.w  d1,2(a5)
		moveq   #$10,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$E6,d7 
		lsl.w   #4,d7
		move.w  d7,4(a5)
		move.w  #$F0,6(a5) 
		clr.l   8(a5)
		bra.w   loc_1C73E
loc_1C5B6:
		cmpi.w  #$2C,(a5) 
		bne.s   loc_1C5D6
		addq.w  #1,2(a5)
		move.w  (a3),d3
		addi.w  #-$3AE0,d3
		btst    #2,3(a5)
		beq.s   loc_1C5D2
		bset    #$B,d3
loc_1C5D2:
		move.w  d3,4(a4)
loc_1C5D6:
		cmpi.w  #$48,(a5) 
		bne.s   loc_1C5F8
		addq.w  #1,2(a5)
		move.w  2(a3),d3
		addi.w  #-$3AE0,d3
		btst    #2,3(a5)
		beq.s   loc_1C5F4
		bset    #$B,d3
loc_1C5F4:
		move.w  d3,4(a4)
loc_1C5F8:
		move.w  2(a5),d1
		move.w  4(a5),d0
		move.w  6(a5),d2
		btst    #0,d1
		bne.s   loc_1C61A
		addi.w  #$14,d2
		addq.w  #6,d0
		andi.w  #$FFF,d0
		move.w  d0,4(a5)
		bra.s   loc_1C622
loc_1C61A:
		subi.w  #$14,d2
		bpl.s   loc_1C622
		clr.w   d2
loc_1C622:
		move.w  d2,6(a5)
		lsr.w   #4,d0
		jsr     (sub_179C).w    
		move.w  d1,d0
		muls.w  d2,d0
		asr.l   #8,d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1C644
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1C652
loc_1C644:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1C652:
		move.w  d1,8(a5)
		btst    #2,3(a5)
		bne.s   loc_1C660
		neg.w   d0
loc_1C660:
		add.w   d0,6(a4)
		add.w   d0,$E(a4)
		swap    d1
		muls.w  d2,d1
		asr.l   #8,d1
		add.w   $A(a5),d1
		tst.w   d1
		bmi.s   loc_1C680
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1C68E
loc_1C680:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1C68E:
		move.w  d0,$A(a5)
		add.w   d1,(a4)
		add.w   d1,8(a4)
		addq.b  #1,$E(a5)
		cmpi.b  #4,$E(a5)
		bcs.s   loc_1C6CC
		clr.b   $E(a5)
		bchg    #0,$F(a5)
		beq.s   loc_1C6B6
		move.w  4(a3),d1
		bra.s   loc_1C6BA
loc_1C6B6:
		move.w  6(a3),d1
loc_1C6BA:
		addi.w  #-$3AE0,d1
		move.w  $C(a4),d3
		andi.w  #$800,d3
		or.w    d3,d1
		move.w  d1,$C(a4)
loc_1C6CC:
		cmpi.w  #$60,6(a4) 
		bcs.w   loc_1C6E0
		cmpi.w  #$180,6(a4)
		bls.w   loc_1C720
loc_1C6E0:
		addq.w  #1,2(a5)
		lea     byte_1C7EE(pc), a0
		btst    #2,3(a5)
		beq.s   loc_1C6F2
		addq.w  #4,a0
loc_1C6F2:
		moveq   #$1C,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.w  d7,8(a5)
		move.w  (a0),6(a4)
		move.w  (a0)+,$E(a4)
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		add.w   (a0),d7
		move.w  d7,(a4)
		move.w  d7,8(a4)
		bchg    #3,4(a4)
		bchg    #3,$C(a4)
loc_1C720:
		subq.w  #1,$10(a5)
		bne.w   loc_1C73E
		moveq   #$C,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #3,d7
		move.w  d7,$10(a5)
		move.w  6(a4),$C(a3)
		move.w  (a4),$E(a3)
loc_1C73E:
		movem.w (sp)+,d0-d1
		addq.w  #2,d0
		lea     $10(a4),a4
		lea     $18(a5),a5
		dbf     d1,loc_1C552
		moveq   #$18,d1
		move.w  $A(a3),d2
		add.w   d2,d2
		sub.w   d2,d1
loc_1C75A:
		tst.w   (a5)
		bne.w   loc_1C7A4
		tst.w   $E(a3)
		beq.w   loc_1C7D8
		move.w  #1,(a5)
		clr.w   2(a5)
		move.w  #6,4(a5)
		move.w  $E(a3),d2
		addi.w  #$C,d2
		move.w  d2,(a4)
		clr.w   2(a4)
		move.w  8(a3),d2
		addi.w  #-$3AE0,d2
		move.w  d2,4(a4)
		move.w  $C(a3),d2
		addi.w  #$C,d2
		move.w  d2,6(a4)
		clr.l   $C(a3)
		bra.w   loc_1C7D8
loc_1C7A4:
		addq.w  #1,(a5)
		addq.w  #1,(a4)
		subq.w  #1,4(a5)
		bne.w   loc_1C7D8
		move.w  #6,4(a5)
		subq.w  #1,4(a4)
		addq.w  #1,2(a5)
		cmpi.w  #4,2(a5)
		bls.w   loc_1C7D8
		clr.l   (a5)
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
loc_1C7D8:
		addq.w  #1,d0
		addq.w  #8,a4
		lea     $C(a5),a5
		dbf     d1,loc_1C75A
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1C53E

byte_1C7EE:     dc.b 0
		dc.b $60
		dc.b 0
		dc.b $80
		dc.b 1
		dc.b $80
		dc.b 0
		dc.b $80

; =============== S U B R O U T I N E =======================================

sub_1C7F6:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		moveq   #7,d1
loc_1C804:
		move.w  d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1C9A0
		tst.b   2(a5)
		beq.w   loc_1C8EC
		subq.b  #1,2(a5)
		bne.w   loc_1C9A0
		moveq   #6,d6
		jsr     (UpdateRandomSeed).w
		cmpi.w  #4,d7
		bcc.s   loc_1C84C
		clr.w   2(a5)
		tst.w   6(a3)
		bne.s   loc_1C83A
		clr.w   d1
		move.w  #$C520,d2
		bra.s   loc_1C842
loc_1C83A:
		move.w  #$500,d1
		move.w  #$C521,d2
loc_1C842:
		move.w  #$680,d3
		move.w  #$680,d4
		bra.s   loc_1C872
loc_1C84C:
		move.w  #1,2(a5)
		tst.w   6(a3)
		bne.s   loc_1C862
		move.w  #$100,d1
		move.w  #$C537,d2
		bra.s   loc_1C86A
loc_1C862:
		move.w  #$500,d1
		move.w  #$C539,d2
loc_1C86A:
		move.w  #$780,d3
		move.w  #$FF80,d4
loc_1C872:
		add.w   d7,d7
		move.w  d7,d0
		add.w   d7,d7
		add.w   d0,d7
		lea     byte_1CBBA(pc), a0
		adda.w  d7,a0
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		subi.w  #$10,d7
		add.w   2(a0),d7
		add.w   2(a3),d7
		move.w  d7,(a4)
		move.w  d1,2(a4)
		or.w    4(a0),d2
		move.w  d2,4(a4)
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		subi.w  #$10,d7
		add.w   (a0),d7
		add.w   (a3),d7
		move.w  d7,6(a4)
		move.w  #$100,d6
		jsr     (UpdateRandomSeed).w
		add.w   d3,d7
		tst.w   (a0)
		bmi.s   loc_1C8C2
		neg.w   d7
loc_1C8C2:
		move.w  d7,4(a5)
		move.w  #$100,d6
		jsr     (UpdateRandomSeed).w
		add.w   d4,d7
		tst.w   2(a0)
		bmi.s   loc_1C8D8
		neg.w   d7
loc_1C8D8:
		move.w  d7,6(a5)
		move.w  #1,(a5)
		clr.l   8(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_BLAST_SPELL
		bra.w   loc_1C9A0
loc_1C8EC:
		addq.w  #1,(a5)
		cmpi.w  #$A,(a5)
		bcc.w   loc_1C918
		lea     word_1CBDE(pc), a0
		tst.w   6(a3)
		beq.s   loc_1C904
		lea     $18(a0),a0
loc_1C904:
		tst.b   3(a5)
		beq.s   loc_1C90E
		lea     $C(a0),a0
loc_1C90E:
		moveq   #2,d0
		bsr.w   sub_1B884
		bra.w   loc_1C9A0
loc_1C918:
		move.w  4(a5),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1C92E
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1C93C
loc_1C92E:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1C93C:
		move.w  d1,8(a5)
		add.w   d0,6(a4)
		move.w  6(a5),d0
		add.w   $A(a5),d0
		tst.w   d0
		bmi.s   loc_1C95A
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1C968
loc_1C95A:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1C968:
		move.w  d1,$A(a5)
		add.w   d0,(a4)
		cmpi.w  #$12,(a5)
		bcs.w   loc_1C9A0
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.b   ((byte_FFB588-$1000000)).w
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   loc_1C994
		clr.w   (a5)
		bra.w   loc_1C9A0
loc_1C994:
		moveq   #8,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.b  d7,2(a5)
loc_1C9A0:
		move.w  (sp)+,d1
		lea     $C(a5),a5
		addq.w  #8,a4
		dbf     d1,loc_1C804
		tst.w   (a5)
		beq.w   loc_1CAA8
		addq.w  #1,(a5)
		subq.b  #1,3(a5)
		bne.w   loc_1CAA8
		move.b  #2,3(a5)
		move.b  2(a5),d0
		addq.w  #1,d0
		andi.w  #3,d0
		move.b  d0,2(a5)
		bne.w   loc_1CA22
		move.w  #$7FF,d6
		jsr     (UpdateRandomSeed).w
		move.w  d7,d0
		andi.w  #7,d0
		move.w  d0,4(a5)
		bsr.w   sub_1CBA6
		move.w  d7,d1
		lsr.w   #3,d1
		andi.w  #$F,d1
		subi.w  #$10,d1
		move.b  1(a0),d2
		ext.w   d2
		add.w   d2,d1
		add.w   2(a3),d1
		move.w  d1,(a4)
		lsr.w   #7,d7
		andi.w  #$F,d7
		subi.w  #$18,d7
		move.b  (a0),d2
		ext.w   d2
		add.w   d2,d7
		add.w   (a3),d7
		move.w  d7,6(a4)
		lea     byte_1CC44(pc), a1
		bra.w   loc_1CA76
loc_1CA22:
		subq.w  #1,d0
		bne.w   loc_1CA38
		lea     byte_1CC46(pc), a1
		move.w  4(a5),d0
		bsr.w   sub_1CBA6
		bra.w   loc_1CA76
loc_1CA38:
		subq.w  #1,d0
		bne.w   loc_1CA5E
		move.w  4(a5),d0
		bsr.w   sub_1CBA6
		clr.w   d1
		move.b  4(a0),d1
		add.w   d1,6(a4)
		move.b  5(a0),d1
		add.w   d1,(a4)
		lea     byte_1CC48(pc), a1
		bra.w   loc_1CA76
loc_1CA5E:
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		move.b  #4,3(a5)
		bra.w   loc_1CAA8
loc_1CA76:
		clr.w   d0
		move.b  2(a0),d0
		add.w   d0,d0
		move.w  d0,d1
		add.w   d0,d0
		add.w   d1,d0
		adda.w  d0,a1
		clr.w   d0
		move.b  (a1),d0
		lsl.w   #4,d0
		move.w  d0,2(a4)
		clr.w   d0
		move.b  1(a1),d0
		addi.w  #-$3AE0,d0
		clr.w   d1
		move.b  3(a0),d1
		lsl.w   #8,d1
		or.w    d1,d0
		move.w  d0,4(a4)
loc_1CAA8:
		tst.w   4(a3)
		beq.w   loc_1CB94
		lea     $C(a5),a5
		addq.w  #8,a4
		tst.w   (a5)
		beq.w   loc_1CB00
		addq.w  #1,(a5)
		subq.b  #1,3(a5)
		bne.w   loc_1CB00
		move.b  #4,3(a5)
		clr.w   d0
		move.b  2(a5),d0
		addq.w  #1,d0
		cmpi.w  #4,d0
		bcs.s   loc_1CAE6
		clr.w   d0
		move.w  4(a3),d1
		addq.w  #8,d1
		move.w  d1,6(a4)
loc_1CAE6:
		move.b  d0,2(a5)
		beq.s   loc_1CAFC
		move.w  4(a5),(a4)
		lsl.w   #2,d0
		addi.w  #-$3A59,d0
		move.w  d0,4(a4)
		bra.s   loc_1CB00
loc_1CAFC:
		move.w  #1,(a4)
loc_1CB00:
		lea     $C(a5),a5
		addq.w  #8,a4
		tst.w   (a5)
		beq.w   loc_1CB94
		addq.w  #1,(a5)
		subq.b  #1,3(a5)
		bne.w   loc_1CB42
		move.b  #4,3(a5)
		clr.w   d0
		move.b  2(a5),d0
		addq.w  #1,d0
		cmpi.w  #3,d0
		bcs.s   loc_1CB2C
		clr.w   d0
loc_1CB2C:
		move.b  d0,2(a5)
		lsl.w   #5,d0
		addi.w  #-$3AB5,d0
		move.w  d0,4(a4)
		addi.w  #$10,d0
		move.w  d0,$C(a4)
loc_1CB42:
		move.w  #$C0,d0 
		tst.b   5(a5)
		beq.s   loc_1CB4E
		neg.w   d0
loc_1CB4E:
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1CB60
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1CB6E
loc_1CB60:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1CB6E:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		add.w   d0,$E(a4)
		move.w  6(a4),4(a3)
		subq.b  #1,4(a5)
		bne.w   loc_1CB94
		move.b  #$3C,4(a5) 
		bchg    #0,5(a5)
loc_1CB94:
		lea     byte_1CC0E(pc), a0
		bsr.w   sub_1B8B2
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1C7F6


; =============== S U B R O U T I N E =======================================

sub_1CBA6:
		move.w  d0,-(sp)
		lea     byte_1CC14(pc), a0
		add.w   d0,d0
		move.w  d0,d1
		add.w   d0,d0
		add.w   d1,d0
		adda.w  d0,a0
		move.w  (sp)+,d0
		rts

	; End of function sub_1CBA6

byte_1CBBA:     dc.b $FF
		dc.b $D0
		dc.b $FF
		dc.b $D0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $30
		dc.b $FF
		dc.b $D0
		dc.b 8
		dc.b 0
		dc.b $FF
		dc.b $D0
		dc.b 0
		dc.b $30
		dc.b $10
		dc.b 0
		dc.b 0
		dc.b $30
		dc.b 0
		dc.b $30
		dc.b $18
		dc.b 0
		dc.b $FF
		dc.b $CC
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $34
		dc.b 0
		dc.b 0
		dc.b 8
		dc.b 0
word_1CBDE:     dc.w 5
		dc.w $500
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 9
		dc.b 6
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b 0
		dc.b 5
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $19
		dc.b 0
		dc.b 9
		dc.b 9
		dc.b 0
		dc.b 0
		dc.b $1D
		dc.b 0
		dc.b 5
		dc.b 6
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b 0
		dc.b 9
		dc.b $B
		dc.b 0
		dc.b 0
		dc.b $B
		dc.b 0
		dc.b 5
		dc.b 9
		dc.b 0
		dc.b 0
		dc.b $1D
		dc.b 0
		dc.b 9
		dc.b $D
		dc.b 0
		dc.b 0
		dc.b $23
byte_1CC0E:     dc.b $C
		dc.b $C4
		dc.b 0
		dc.b $A
		dc.b 0
		dc.b 1
byte_1CC14:     dc.b $18
		dc.b $18
		dc.b 1
		dc.b $10
		dc.b 8
		dc.b 0
		dc.b 0
		dc.b $18
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 8
		dc.b $E8
		dc.b $18
		dc.b 1
		dc.b $18
		dc.b 0
		dc.b 0
		dc.b $18
		dc.b 0
		dc.b 2
		dc.b 0
		dc.b 8
		dc.b 8
		dc.b $E8
		dc.b 0
		dc.b 2
		dc.b 8
		dc.b 8
		dc.b 8
		dc.b $18
		dc.b $E8
		dc.b 1
		dc.b 0
		dc.b 8
		dc.b 0
		dc.b 0
		dc.b $E8
		dc.b 0
		dc.b $10
		dc.b 0
		dc.b 0
		dc.b $E8
		dc.b $E8
		dc.b 1
		dc.b 8
		dc.b 0
		dc.b 0
byte_1CC44:     dc.b $50
		dc.b $97
byte_1CC46:     dc.b $70
		dc.b $9B
byte_1CC48:     dc.b $60
		dc.b $A3
		dc.b $50
		dc.b $A9
		dc.b $D0
		dc.b $AD
		dc.b $90
		dc.b $B5
		dc.b $50
		dc.b $BB
		dc.b $F0
		dc.b $BF
		dc.b $60
		dc.b $CF

; =============== S U B R O U T I N E =======================================

sub_1CC56:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   (a5)
		beq.w   loc_1CD70
		addq.w  #1,(a5)
		cmpi.w  #2,(a3)
		beq.w   loc_1CC92
		tst.w   (a3)
		bne.w   loc_1CCB2
		lea     byte_1CE0C(pc), a0
		moveq   #5,d0
		bsr.w   sub_1B884
		cmpi.w  #$26,(a5) 
		bcs.w   loc_1CCB2
		move.w  #1,(a3)
		bra.w   loc_1CCB2
loc_1CC92:
		lea     byte_1CE2A(pc), a0
		moveq   #5,d0
		bsr.w   sub_1B884
		cmpi.w  #$26,(a5) 
		bcs.w   loc_1CCB2
		clr.w   (a5)
		move.w  #1,(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1CD70
loc_1CCB2:
		move.w  2(a5),d0
		btst    #0,6(a5)
		bne.s   loc_1CCDA
		subq.w  #8,d0
		andi.w  #$FF,d0
		move.w  d0,d1
		cmpi.w  #$88,d0 
		bne.s   loc_1CCD4
		bset    #0,6(a5)
		moveq   #8,d1
loc_1CCD4:
		move.w  #$130,d3
		bra.s   loc_1CCF4
loc_1CCDA:
		addq.w  #8,d0
		andi.w  #$FF,d0
		move.w  d0,d1
		cmpi.w  #8,d0
		bne.s   loc_1CCF0
		bclr    #0,6(a5)
		moveq   #$78,d1 
loc_1CCF0:
		move.w  #$D0,d3 
loc_1CCF4:
		move.w  d1,2(a5)
		move.l  #$10003000,d1
		jsr     (sub_1812).w
		add.w   d3,d2
		move.w  d2,6(a4)
		swap    d2
		addi.w  #$C0,d2 
		move.w  d2,(a4)
loc_1CD10:
		cmpi.w  #$80,d0 
		bcc.s   loc_1CD1A
		moveq   #1,d1
		bra.s   loc_1CD1C
loc_1CD1A:
		moveq   #2,d1
loc_1CD1C:
		move.b  d1,(byte_FFAFA0).l
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   loc_1CD36
		cmpi.w  #2,(a3)
		bcc.s   loc_1CD36
		move.w  #1,(a5)
		move.w  #2,(a3)
loc_1CD36:
		subq.w  #1,4(a5)
		bne.w   loc_1CD70
		moveq   #8,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #2,d7
		move.w  d7,4(a5)
		cmpi.b  #$19,((byte_FFB584-$1000000)).w
		bcc.w   loc_1CD70
		moveq   #1,d0
		bsr.w   sub_1A2F6
		move.w  6(a4),d0
		addq.w  #8,d0
		move.w  d0,4(a0)
		move.w  (a4),d0
		addq.w  #8,d0
		move.w  d0,6(a0)
		addq.b  #1,((byte_FFB584-$1000000)).w
loc_1CD70:
		lea     $C(a5),a5
		addq.w  #8,a4
		moveq   #$27,d0 
		moveq   #$17,d1
loc_1CD7A:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1CDF2
		addq.w  #1,(a5)
		tst.b   2(a5)
		bne.w   loc_1CDBC
		lea     (byte_FFAFA0).l,a1
		adda.w  d0,a1
		lea     byte_1CE48(pc), a0
		bsr.w   sub_19F5E
		move.w  4(a5),6(a4)
		move.w  6(a5),(a4)
		move.b  (byte_FFAFA0).l,(a1)
		addq.b  #1,2(a5)
		move.b  #6,3(a5)
		bra.w   loc_1CDF2
loc_1CDBC:
		addq.w  #1,(a4)
		subq.b  #1,3(a5)
		bne.w   loc_1CDF2
		move.b  #6,3(a5)
		addq.b  #1,2(a5)
		addq.w  #1,4(a4)
		cmpi.b  #5,2(a5)
		bls.w   loc_1CDF2
		clr.w   (a5)
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1CDF2:
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1CD7A
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1CC56

byte_1CE0C:     dc.b 0
		dc.b 8
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $1A
		dc.b 0
		dc.b $E
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $16
		dc.b 0
		dc.b $14
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $12
		dc.b 0
		dc.b $1A
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b 9
		dc.b 0
		dc.b $20
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b 0
byte_1CE2A:     dc.b 0
		dc.b 8
		dc.b $A
		dc.b 0
		dc.b 0
		dc.b 9
		dc.b 0
		dc.b $E
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $12
		dc.b 0
		dc.b $14
		dc.b 5
		dc.b 0
		dc.b 0
		dc.b $16
		dc.b 0
		dc.b $1A
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $1A
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b $1B
byte_1CE48:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $3C
		dc.b 0
		dc.b $20

; =============== S U B R O U T I N E =======================================

spellanim_Bolt:
		
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		moveq   #$26,d0 
		move.w  (a3),d1
		subq.w  #1,d1
loc_1CE62:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1CF84
		addq.w  #1,(a5)
		subq.w  #1,4(a5)
		bne.w   loc_1CF84
		move.w  2(a5),d1
		cmpi.w  #6,d1
		bcc.w   loc_1CEEE
		tst.w   d1
		bne.s   loc_1CEA0
loc_1CE86:
		move.w  #$60,d6 
		jsr     (UpdateRandomSeed).w
		add.w   4(a3),d7
		move.w  d7,6(a5)
		moveq   #2,d6
		jsr     (UpdateRandomSeed).w
		move.b  d7,8(a5)
loc_1CEA0:
		cmpi.w  #2,d1
		bne.s   loc_1CEAA
		trap    #SOUND_COMMAND
		dc.w SFX_BOLT_SPELL
loc_1CEAA:
		tst.b   8(a5)
		bne.s   loc_1CEB8
		movea.l (p_BoltAnimData_A).l,a0
		bra.s   loc_1CEBE
loc_1CEB8:
		movea.l (p_BoltAnimData_B).l,a0
loc_1CEBE:
		lsl.w   #3,d1
		move.w  d1,d2
		lsl.w   #2,d1
		add.w   d2,d1
		adda.w  d1,a0
		moveq   #5,d1
		move.w  6(a5),d2
		btst    #7,((byte_FFB586-$1000000)).w
		bne.s   loc_1CEDA
		clr.w   d3
		bra.s   loc_1CEDC
loc_1CEDA:
		moveq   #8,d3
loc_1CEDC:
		bsr.w   sub_19FAA
		addq.w  #1,2(a5)
		move.w  #2,4(a5)
		bra.w   loc_1CF84
loc_1CEEE:
		bne.w   loc_1CF28
		move.l  a4,-(sp)
		moveq   #4,d1
loc_1CEF6:
		move.w  #1,(a4)
		move.w  #1,6(a4)
		addq.w  #8,a4
		dbf     d1,loc_1CEF6
		movea.l (sp)+,a4
		clr.b   ((byte_FFB588-$1000000)).w
		move.b  ((byte_FFB586-$1000000)).w,d6
		andi.w  #7,d6
		add.w   d6,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #2,d7
		addq.w  #1,2(a5)
		move.w  d7,4(a5)
		bra.w   loc_1CF84
loc_1CF28:
		cmpi.w  #$C,d1
		bcc.w   loc_1CF42
		subq.w  #1,d1
		cmpi.w  #6,d1
		bne.w   loc_1CEAA
		trap    #SOUND_COMMAND
		dc.w SFX_BOLT_SPELL
		bra.w   loc_1CE86
loc_1CF42:
		move.l  a4,-(sp)
		moveq   #4,d1
loc_1CF46:
		move.w  #1,(a4)
		move.w  #1,6(a4)
		addq.w  #8,a4
		dbf     d1,loc_1CF46
		movea.l (sp)+,a4
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   loc_1CF68
		clr.w   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1CF84
loc_1CF68:
		move.b  ((byte_FFB586-$1000000)).w,d6
		andi.w  #7,d6
		lsl.w   #2,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #2,d7
		clr.w   2(a5)
		move.w  d7,4(a5)
		bsr.w   sub_1B8FE
loc_1CF84:
		movem.w (sp)+,d0-d1
		addq.w  #5,d0
		lea     $28(a4),a4
		lea     $C(a5),a5
		dbf     d1,loc_1CE62
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		move.w  2(a3),d1
		beq.w   loc_1CFEA
		subq.w  #1,d1
loc_1CFA8:
		tst.w   (a5)
		beq.w   loc_1CFDE
		addq.w  #1,(a5)
		move.w  2(a5),d2
		addq.w  #1,d2
		andi.w  #7,d2
		move.w  d2,2(a5)
		move.w  #$C5B3,d3
		lsr.w   #1,d2
		bcc.s   loc_1CFCA
		bset    #$B,d3
loc_1CFCA:
		lsr.w   #1,d2
		bcc.s   loc_1CFD2
		addi.w  #$10,d3
loc_1CFD2:
		lsr.w   #1,d2
		bcc.s   loc_1CFDA
		bset    #$C,d3
loc_1CFDA:
		move.w  d3,4(a4)
loc_1CFDE:
		addq.w  #1,d0
		addq.w  #8,a4
		lea     $C(a5),a5
		dbf     d1,loc_1CFA8
loc_1CFEA:
		bsr.w   sub_1B90C
		lea     word_1CFF6(pc), a0
		bra.w   sub_1B8B2

	; End of function spellanim_Bolt

word_1CFF6:     dc.w $EAA
		dc.w $E
		dc.w 1

; =============== S U B R O U T I N E =======================================

sub_1CFFC:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   (a5)
		beq.w   return_1D036
		addq.w  #1,(a5)
		subq.w  #1,2(a5)
		bne.w   return_1D036
		move.w  4(a5),d0
		add.w   (a3),d0
		beq.w   sub_1B82A
		bmi.w   sub_1B82A
		cmpi.w  #$20,d0 
		bcc.w   sub_1B82A
		move.w  d0,2(a5)
		move.w  d0,4(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_PSH
return_1D036:
		rts

	; End of function sub_1CFFC


; =============== S U B R O U T I N E =======================================

sub_1D038:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		moveq   #$26,d0 
		moveq   #3,d1
loc_1D048:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1D0D4
		addq.w  #1,(a5)
		subq.w  #1,4(a5)
		bne.w   loc_1D0D4
		move.w  2(a5),d1
		addq.w  #1,d1
		cmpi.w  #6,d1
		bcs.s   loc_1D06A
		clr.w   d1
loc_1D06A:
		move.w  d1,2(a5)
		tst.w   d1
		bne.w   loc_1D090
		move.w  #1,(a4)
		move.w  #1,6(a4)
		move.w  #8,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #5,d7
		move.w  d7,4(a5)
		bra.w   loc_1D0D4
loc_1D090:
		move.w  #5,4(a5)
		subq.w  #1,d1
		bne.w   loc_1D0C2
		lea     byte_1D0EE(pc), a0
		moveq   #1,d1
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		add.w   (a3),d7
		move.w  d7,d2
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		add.w   2(a3),d7
		move.w  d7,d3
		jsr     sub_19FAA
		bra.w   loc_1D0D4
loc_1D0C2:
		add.w   d1,d1
		lea     byte_1D0F6(pc), a0
		move.w  -2(a0,d1.w),d1
		addi.w  #-$3AE0,d1
		move.w  d1,4(a4)
loc_1D0D4:
		movem.w (sp)+,d0-d1
		addq.w  #1,d0
		lea     $C(a5),a5
		addq.w  #8,a4
		dbf     d1,loc_1D048
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1D038

byte_1D0EE:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $20
		dc.b $F
		dc.b $20
byte_1D0F6:     dc.b 0
		dc.b $10
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b $10
		dc.b 0
		dc.b 0

; =============== S U B R O U T I N E =======================================

sub_1D0FE:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		moveq   #$26,d0 
		moveq   #$18,d1
loc_1D10E:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1D288
		addq.w  #1,(a5)
		cmpi.w  #2,(a5)
		bne.w   loc_1D15E
		move.w  #$80,d6 
		jsr     (UpdateRandomSeed).w
		addi.w  #$80,d7 
		move.w  d7,4(a5)
		move.w  #$500,d6
		jsr     (UpdateRandomSeed).w
		subi.w  #$300,d7
		move.w  d7,6(a5)
		clr.l   8(a5)
		lea     byte_1D2A2(pc), a0
		bsr.w   sub_19F5E
		move.w  (a3),6(a4)
		move.w  2(a3),(a4)
		trap    #SOUND_COMMAND
		dc.w SFX_DEMON_BREATH
		bra.w   loc_1D288
loc_1D15E:
		cmpi.w  #$1C,(a5)
		bcc.w   loc_1D208
		move.w  4(a5),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1D17C
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D18A
loc_1D17C:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D18A:
		move.w  d1,8(a5)
		add.w   d0,6(a4)
		move.w  6(a5),d0
		add.w   $A(a5),d0
		tst.w   d0
		bmi.s   loc_1D1A8
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D1B6
loc_1D1A8:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D1B6:
		move.w  d1,$A(a5)
		add.w   d0,(a4)
		cmpi.w  #$E,(a5)
		bne.s   loc_1D1C8
		move.w  #$C530,4(a4)
loc_1D1C8:
		move.w  4(a4),d0
		move.w  d0,d1
		addi.w  #$800,d0
		andi.w  #$1800,d0
		andi.w  #$E7FF,d1
		or.w    d1,d0
		move.w  d0,4(a4)
		cmpi.w  #$C,(a5)
		bne.w   loc_1D288
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1D288
		cmpi.b  #$19,((byte_FFB584-$1000000)).w
		bcc.w   loc_1D288
		moveq   #1,d0
		bsr.w   sub_1A2F6
		addq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1D288
loc_1D208:
		bne.w   loc_1D22E
		move.w  #$20,d6 
		jsr     (UpdateRandomSeed).w
		addi.w  #$40,d7 
		move.w  d7,2(a5)
		clr.w   4(a5)
		clr.l   8(a5)
		move.w  #$C540,4(a4)
		bra.w   loc_1D288
loc_1D22E:
		move.w  4(a5),d0
		add.w   2(a5),d0
		move.w  d0,4(a5)
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1D24C
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D25A
loc_1D24C:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D25A:
		move.w  d1,8(a5)
		add.w   d0,6(a4)
		tst.w   4(a3)
		beq.s   loc_1D272
		lea     word_1D2AA(pc), a0
		moveq   #$A,d0
		bsr.w   sub_1B884
loc_1D272:
		cmpi.w  #$45,(a5) 
		bcs.w   loc_1D288
		clr.w   (a5)
		move.w  #1,(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
		clr.b   ((byte_FFB588-$1000000)).w
loc_1D288:
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1D10E
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1D0FE

byte_1D2A2:     dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 5
		dc.b $20
		dc.b $F
		dc.b $20
word_1D2AA:     dc.w $20
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $30
		dc.b 0
		dc.b $24
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b $28
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $30
		dc.b 0
		dc.b $2C
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $20
		dc.b 0
		dc.b $30
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b $34
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $50
		dc.b 0
		dc.b $38
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b $3C
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $50
		dc.b 0
		dc.b $40
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $40
		dc.b 0
		dc.b $44
		dc.b $F
		dc.b 0
		dc.b 0
		dc.b $50

; =============== S U B R O U T I N E =======================================

sub_1D2E6:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		moveq   #$18,d1
		moveq   #$26,d0 
loc_1D2F6:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1D424
		addq.w  #1,(a5)
		cmpi.w  #2,(a5)
		bne.w   loc_1D348
		lea     byte_1D4A0(pc), a0
		btst    #7,((byte_FFB586-$1000000)).w
		beq.w   loc_1D33C
		addq.w  #8,a0
		move.w  ((ENEMY_BATTLE_SPRITE-$1000000)).w,d2
		cmpi.w  #$E,d2
		beq.w   loc_1D33C
		addq.w  #8,a0
		cmpi.w  #$13,d2
		beq.w   loc_1D33C
		addq.w  #8,a0
		cmpi.w  #$1A,d2
		beq.w   loc_1D33C
		addq.w  #8,a0
loc_1D33C:
		bsr.w   sub_19F5E
		trap    #SOUND_COMMAND
		dc.w SFX_DOOR_OPEN
		bra.w   loc_1D424
loc_1D348:
		move.w  2(a5),d0
		jsr     (sub_179C).w    
		move.w  d1,d0
		asl.w   #1,d1
		add.w   d0,d1
		add.w   4(a5),d1
		tst.w   d1
		bmi.s   loc_1D368
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1D376
loc_1D368:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1D376:
		move.w  d0,4(a5)
		add.w   d1,6(a4)
		swap    d1
		move.w  d1,d0
		asl.w   #1,d1
		add.w   d0,d1
		add.w   6(a5),d1
		tst.w   d1
		bmi.s   loc_1D398
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1D3A6
loc_1D398:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1D3A6:
		move.w  d0,6(a5)
		add.w   d1,(a4)
		cmpi.w  #6,(a5)
		bne.w   loc_1D402
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1D424
		move.w  2(a5),d1
		move.b  8(a5),d2
		bne.s   loc_1D3D8
		addq.w  #4,d1
		andi.w  #$FC,d1 
		cmp.w   2(a3),d1
		bne.s   loc_1D3D6
		move.b  #1,d2
loc_1D3D6:
		bra.s   loc_1D3E4
loc_1D3D8:
		subq.w  #4,d1
		andi.w  #$FC,d1 
		cmp.w   (a3),d1
		bne.s   loc_1D3E4
		clr.b   d2
loc_1D3E4:
		moveq   #1,d0
		bsr.w   sub_1A2F6
		cmpi.w  #$FFFF,d0
		beq.w   loc_1D424
		move.w  d1,2(a0)
		move.b  d2,8(a0)
		addq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1D424
loc_1D402:
		move.w  4(a3),d1
		cmp.w   (a5),d1
		bhi.w   loc_1D424
		clr.w   (a5)
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.b   ((byte_FFB588-$1000000)).w
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1D424:
		moveq   #4,d0
		lea     byte_1D4C8(pc), a0
		bsr.w   sub_1B884
		btst    #2,1(a5)
		bne.s   loc_1D43E
		bclr    #3,4(a4)
		bra.s   loc_1D444
loc_1D43E:
		bset    #3,4(a4)
loc_1D444:
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1D2F6
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
loc_1D45C:
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB406-$1000000)).w,a5
		moveq   #$17,d0
loc_1D466:
		tst.w   (a5)
		bne.s   loc_1D494
		lea     (a4),a0
		lea     (a5),a1
		move.w  d0,d1
loc_1D470:
		move.l  8(a0),(a0)
		move.l  $C(a0),4(a0)
		move.l  $C(a1),(a1)
		move.l  $10(a1),4(a1)
		move.l  $14(a1),8(a1)
		addq.w  #8,a0
		lea     $C(a1),a1
		dbf     d1,loc_1D470
loc_1D494:
		addq.w  #8,a4
		lea     $C(a5),a5
		dbf     d0,loc_1D466
		rts

	; End of function sub_1D2E6

byte_1D4A0:     dc.b 1
		dc.b $1C
		dc.b   0
		dc.b $DE 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $D2 
		dc.b   0
		dc.b $EC 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $DF 
		dc.b   0
		dc.b $D6 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $D0 
		dc.b   0
		dc.b $D8 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $D4 
		dc.b   0
		dc.b $CC 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
byte_1D4C8:     dc.b 0
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b  $A
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b   2
		dc.b   0
		dc.b  $F
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b   6
		dc.b   0
		dc.b $14
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b  $A
		dc.b   0
		dc.b $19
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $13

; =============== S U B R O U T I N E =======================================

sub_1D4E6:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   (a5)
		beq.w   return_1D5C4
		addq.w  #1,(a5)
		move.w  2(a5),d0
		bne.w   loc_1D54A
		move.w  2(a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1D518
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D526
loc_1D518:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D526:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		tst.w   (a3)
		beq.s   loc_1D536
		add.w   d0,$E(a4)
loc_1D536:
		cmpi.w  #$12,(a5)
		bcs.s   loc_1D546
		addq.w  #1,2(a5)
		move.w  #$22,4(a5) 
loc_1D546:
		bra.w   return_1D5C4
loc_1D54A:
		subq.w  #1,d0
		bne.w   loc_1D582
		subq.w  #1,4(a5)
		bne.w   return_1D5C4
		move.w  4(a3),6(a4)
		move.w  8(a3),(a4)
		tst.w   (a3)
		beq.s   loc_1D572
		move.w  6(a3),$E(a4)
		move.w  8(a3),8(a4)
loc_1D572:
		move.w  #1,(a5)
		addq.w  #1,2(a5)
		clr.l   6(a5)
		bra.w   return_1D5C4
loc_1D582:
		move.w  2(a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1D598
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D5A6
loc_1D598:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D5A6:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		tst.w   (a3)
		beq.s   loc_1D5B6
		add.w   d0,$E(a4)
loc_1D5B6:
		cmpi.w  #$10,(a5)
		bcs.s   return_1D5C4
		clr.b   ((byte_FFB588-$1000000)).w
		bra.w   sub_1B82A
return_1D5C4:
		rts

	; End of function sub_1D4E6


; =============== S U B R O U T I N E =======================================

sub_1D5C6:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		moveq   #$26,d0 
		moveq   #7,d1
loc_1D5D6:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1D748
		move.w  2(a5),d1
		bne.w   loc_1D612
		lea     byte_1D776(pc), a0
		btst    #7,((byte_FFB586-$1000000)).w
		beq.s   loc_1D5F6
		addq.w  #8,a0
loc_1D5F6:
		bsr.w   sub_19F5E
		moveq   #$10,d6
		jsr     (UpdateRandomSeed).w
		subq.w  #8,d7
		add.w   d7,(a4)
		addq.w  #1,2(a5)
		move.w  #4,4(a5)
		bra.w   loc_1D748
loc_1D612:
		addq.w  #1,(a5)
		subq.w  #1,d1
		bne.w   loc_1D69E
		move.w  (a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1D62E
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D63C
loc_1D62E:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D63C:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		move.w  2(a3),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1D65A
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D668
loc_1D65A:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D668:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bsr.w   sub_1D762
		cmpi.w  #3,(a5)
		bne.s   loc_1D68A
		cmpi.b  #8,((byte_FFB584-$1000000)).w
		bcc.s   loc_1D68A
		moveq   #1,d0
		bsr.w   sub_1A2F6
		addq.b  #1,((byte_FFB584-$1000000)).w
loc_1D68A:
		cmpi.w  #$13,(a5)
		bcs.w   loc_1D748
		move.w  #1,(a5)
		addq.w  #1,2(a5)
		bra.w   loc_1D748
loc_1D69E:
		subq.w  #1,d1
		bne.w   loc_1D6D0
		cmpi.w  #$20,(a5) 
		bcs.w   loc_1D748
		move.w  4(a3),6(a4)
		moveq   #$10,d6
		jsr     (UpdateRandomSeed).w
		subq.w  #8,d7
		add.w   6(a3),d7
		move.w  d7,(a4)
		move.w  #1,(a5)
		addq.w  #1,2(a5)
		clr.l   6(a5)
		bra.w   loc_1D748
loc_1D6D0:
		move.w  (a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1D6E4
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D6F2
loc_1D6E4:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D6F2:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		move.w  2(a3),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1D710
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D71E
loc_1D710:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D71E:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bsr.w   sub_1D762
		cmpi.w  #$10,(a5)
		bcs.w   loc_1D748
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.w   (a5)
		clr.b   ((byte_FFB588-$1000000)).w
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1D748:
		movem.w (sp)+,d0-d1
		addq.w  #1,d0
		addq.w  #8,a4
		lea     $C(a5),a5
		dbf     d1,loc_1D5D6
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1D5C6


; =============== S U B R O U T I N E =======================================

sub_1D762:
		subq.w  #1,4(a5)
		bne.s   return_1D774
		move.w  #4,4(a5)
		bchg    #2,5(a4)
return_1D774:
		rts

	; End of function sub_1D762

byte_1D776:     dc.b 1
		dc.b $14
		dc.b 0
		dc.b $E8
		dc.b 5
		dc.b $20
		dc.b $C
		dc.b $10
		dc.b 0
		dc.b $D0
		dc.b 0
		dc.b $E0
		dc.b 5
		dc.b $20
		dc.b $C
		dc.b $11

; =============== S U B R O U T I N E =======================================

sub_1D786:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   $C(a3)
		bne.w   loc_1D8AE
		addq.w  #1,(a5)
		tst.w   2(a5)
		bne.w   loc_1D810
		move.w  (a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1D7B8
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D7C6
loc_1D7B8:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D7C6:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		move.w  2(a3),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1D7E4
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D7F2
loc_1D7E4:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D7F2:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bsr.w   sub_1D9B2
		cmpi.w  #$14,(a5)
		bcs.s   loc_1D80C
		addq.w  #1,2(a5)
		move.w  #$1C,4(a5)
loc_1D80C:
		bra.w   loc_1D9A8
loc_1D810:
		cmpi.w  #1,2(a5)
		bne.w   loc_1D83C
		subq.w  #1,4(a5)
		bne.w   loc_1D9A8
		move.w  4(a3),6(a4)
		move.w  6(a3),(a4)
		move.w  #1,(a5)
		addq.w  #1,2(a5)
		clr.l   6(a5)
		bra.w   loc_1D9A8
loc_1D83C:
		move.w  (a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1D850
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D85E
loc_1D850:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D85E:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		move.w  2(a3),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1D87C
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1D88A
loc_1D87C:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1D88A:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bsr.w   sub_1D9B2
		cmpi.w  #$11,(a5)
		bcs.w   loc_1D9A8
		move.w  #1,(a5)
		clr.l   2(a5)
		move.w  #1,$C(a3)
		bra.w   loc_1D9A8
loc_1D8AE:
		clr.b   ((byte_FFB588-$1000000)).w
		moveq   #$26,d0 
		moveq   #$F,d1
loc_1D8B6:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1D998
		addq.w  #1,(a5)
		tst.w   2(a5)
		bne.w   loc_1D928
		moveq   #2,d6
		jsr     (UpdateRandomSeed).w
		lea     byte_1D9CE(pc), a0
		move.b  d7,$A(a5)
		beq.s   loc_1D8DC
		addq.w  #8,a0
loc_1D8DC:
		moveq   #$50,d6 
		jsr     (UpdateRandomSeed).w
		subi.w  #$28,d7 
		add.w   8(a3),d7
		move.w  d7,d2
		moveq   #$50,d6 
		jsr     (UpdateRandomSeed).w
		subi.w  #$28,d7 
		add.w   $A(a3),d7
		move.w  d7,d3
		moveq   #1,d1
		bsr.w   sub_19FAA
		moveq   #4,d6
		jsr     (UpdateRandomSeed).w
		lsr.w   #1,d7
		bcc.s   loc_1D912
		bset    #3,4(a4)
loc_1D912:
		lsr.w   #1,d7
		bcc.s   loc_1D91C
		bset    #4,4(a4)
loc_1D91C:
		addq.w  #1,2(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_BATTLEFIELD_DEATH
		bra.w   loc_1D998
loc_1D928:
		cmpi.w  #4,(a5)
		bne.w   loc_1D954
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1D998
		cmpi.b  #$10,((byte_FFB584-$1000000)).w
		bcc.w   loc_1D998
		moveq   #1,d0
		bsr.w   sub_1A2F6
		cmpi.w  #$FFFF,d0
		beq.w   loc_1D998
		addq.b  #1,((byte_FFB584-$1000000)).w
loc_1D954:
		tst.b   $A(a5)
		bne.s   loc_1D96E
		lea     byte_1D9DE(pc), a0
		moveq   #2,d0
		bsr.w   sub_1B884
		cmpi.w  #9,(a5)
		bcc.w   loc_1D984
		bra.s   loc_1D980
loc_1D96E:
		lea     byte_1D9EA(pc), a0
		moveq   #3,d0
		bsr.w   sub_1B884
		cmpi.w  #$C,(a5)
		bcc.w   loc_1D984
loc_1D980:
		bra.w   loc_1D998
loc_1D984:
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.l   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1D998:
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1D8B6
loc_1D9A8:
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1D786


; =============== S U B R O U T I N E =======================================

sub_1D9B2:
		move.w  4(a4),d0
		andi.w  #$F800,d0
		ori.w   #$56C,d0
		btst    #1,1(a5)
		beq.s   loc_1D9C8
		addq.w  #4,d0
loc_1D9C8:
		move.w  d0,4(a4)
		rts

	; End of function sub_1D9B2

byte_1D9CE:     dc.b 0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $60 
		dc.b   5
		dc.b $20
		dc.b $FF
		dc.b $F8 
		dc.b $FF
		dc.b $F8 
		dc.b   5
		dc.b $20
		dc.b  $F
		dc.b $20
byte_1D9DE:     dc.b 0
		dc.b   3
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b $44 
		dc.b   0
		dc.b   6
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b $48 
byte_1D9EA:     dc.b 0
		dc.b   3
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $10
		dc.b   0
		dc.b   6
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b   9
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $30 

; =============== S U B R O U T I N E =======================================

sub_1D9FC:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   $C(a3)
		bne.w   loc_1DB2E
		addq.w  #1,(a5)
		tst.w   2(a5)
		bne.w   loc_1DA86
		move.w  (a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1DA2E
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1DA3C
loc_1DA2E:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1DA3C:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		move.w  2(a3),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1DA5A
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1DA68
loc_1DA5A:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1DA68:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bsr.w   sub_1DC14
		cmpi.w  #$12,(a5)
		bcs.s   loc_1DA82
		addq.w  #1,2(a5)
		move.w  #$26,4(a5) 
loc_1DA82:
		bra.w   loc_1DBF8
loc_1DA86:
		cmpi.w  #1,2(a5)
		bne.w   loc_1DAB2
		subq.w  #1,4(a5)
		bne.w   loc_1DBF8
		move.w  4(a3),6(a4)
		move.w  6(a3),(a4)
		move.w  #1,(a5)
		addq.w  #1,2(a5)
		clr.l   6(a5)
		bra.w   loc_1DBF8
loc_1DAB2:
		move.w  (a3),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1DAC6
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1DAD4
loc_1DAC6:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1DAD4:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		move.w  2(a3),d0
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1DAF2
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1DB00
loc_1DAF2:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1DB00:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bsr.w   sub_1DC14
		cmpi.w  #$F,(a5)
		bcs.w   loc_1DBF8
		move.w  #1,(a5)
		clr.w   2(a5)
		move.w  #1,4(a5)
		move.w  #1,$C(a3)
		trap    #SOUND_COMMAND
		dc.w SFX_BIG_DOOR_RUMBLE
		bra.w   loc_1DBF8
loc_1DB2E:
		tst.w   (a5)
		beq.w   loc_1DBF8
		addq.w  #1,(a5)
		cmpi.w  #2,(a5)
		bne.s   loc_1DB62
		bsr.w   sub_1DC36
		move.b  #OUT_TO_WHITE,((FADING_SETTING-$1000000)).w
		clr.w   ((unk_FFDFAA-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w
		move.w  #1,(a4)
		bsr.w   sub_1B8FE
loc_1DB62:
		bsr.w   sub_1B90C
		cmpi.w  #$20,(a5) 
		bcs.w   loc_1DBF8
		bne.s   loc_1DB8E
		bsr.w   sub_1DC48
		move.b  #IN_FROM_WHITE,((FADING_SETTING-$1000000)).w
		clr.w   ((unk_FFDFAA-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w
loc_1DB8E:
		cmpi.w  #$36,(a5) 
		bne.s   loc_1DB9C
		bsr.w   LoadPalette1FromFFB41E
		clr.b   ((byte_FFB588-$1000000)).w
loc_1DB9C:
		move.w  2(a5),d4
		subq.w  #1,4(a5)
		bne.w   loc_1DBBC
		move.w  #6,4(a5)
		addq.w  #1,d4
		cmpi.w  #2,d4
		bls.s   loc_1DBB8
		clr.w   d4
loc_1DBB8:
		move.w  d4,2(a5)
loc_1DBBC:
		lsl.w   #3,d4
		move.w  d4,d0
		lsl.w   #3,d4
		add.w   d0,d4
		btst    #0,1(a5)
		beq.s   loc_1DBD6
		move.w  8(a3),d2
		move.w  $A(a3),d3
		bra.s   loc_1DBDE
loc_1DBD6:
		move.w  #$FF81,d2
		move.w  #$FF81,d3
loc_1DBDE:
		moveq   #$26,d0 
		moveq   #$C,d1
		lea     byte_1DC88(pc), a0
		bsr.w   sub_19FAA
		moveq   #4,d0
		moveq   #$B,d1
loc_1DBEE:
		add.w   d4,(a4,d0.w)
		addq.w  #8,d0
		dbf     d1,loc_1DBEE
loc_1DBF8:
		tst.w   ((byte_FFB404-$1000000)).w
		bne.s   return_1DC12
		lea     ((PALETTE_1_BIS-$1000000)).w,a0
		lea     ((byte_FFB41E-$1000000)).w,a1
		moveq   #$1F,d0
loc_1DC08:
		move.l  (a1)+,(a0)+
		dbf     d0,loc_1DC08
		bra.w   sub_1B82A
return_1DC12:
		rts

	; End of function sub_1D9FC


; =============== S U B R O U T I N E =======================================

sub_1DC14:
		move.w  #$C520,d0
		btst    #1,1(a5)
		bne.s   loc_1DC2E
		btst    #2,1(a5)
		beq.s   loc_1DC2C
		bset    #$B,d0
loc_1DC2C:
		bra.s   loc_1DC30
loc_1DC2E:
		addq.w  #4,d0
loc_1DC30:
		move.w  d0,4(a4)
		rts

	; End of function sub_1DC14


; =============== S U B R O U T I N E =======================================

sub_1DC36:
		lea     ((PALETTE_1-$1000000)).w,a0
		lea     ((byte_FFB41E-$1000000)).w,a1
		moveq   #$1F,d0
loc_1DC40:
		move.l  (a0)+,(a1)+
		dbf     d0,loc_1DC40
		rts

	; End of function sub_1DC36


; =============== S U B R O U T I N E =======================================

sub_1DC48:
		lea     ((byte_FFB41E-$1000000)).w,a0
		lea     ((PALETTE_1_BIS-$1000000)).w,a1
		movem.l a0-a1,-(sp)
		moveq   #$3F,d0 
loc_1DC56:
		move.w  (a0)+,d1
		lsr.w   #1,d1
		andi.w  #$EEE,d1
		move.w  d1,(a1)+
		dbf     d0,loc_1DC56
		movem.l (sp)+,a0-a1
		move.w  $52(a0),$52(a1)
		move.l  $5A(a0),$5A(a1)
		rts

	; End of function sub_1DC48


; =============== S U B R O U T I N E =======================================

LoadPalette1FromFFB41E:
		
		lea     ((PALETTE_1_BIS-$1000000)).w,a0
		lea     ((byte_FFB41E-$1000000)).w,a1
		moveq   #$1F,d0
loc_1DC80:
		move.l  (a1)+,(a0)+
		dbf     d0,loc_1DC80
		rts

	; End of function LoadPalette1FromFFB41E

byte_1DC88:     dc.b 0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $28 
		dc.b  $F
		dc.b $20
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $20
		dc.b   5
		dc.b $38 
		dc.b  $F
		dc.b $20
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $40 
		dc.b   5
		dc.b $48 
		dc.b  $F
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $58 
		dc.b   7
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   5
		dc.b $60 
		dc.b   7
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $40 
		dc.b   5
		dc.b $68 
		dc.b   7
		dc.b $20
		dc.b   0
		dc.b $30 
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $58 
		dc.b   7
		dc.b $21 
		dc.b   0
		dc.b $30 
		dc.b   0
		dc.b $20
		dc.b   5
		dc.b $60 
		dc.b   7
		dc.b $21 
		dc.b   0
		dc.b $30 
		dc.b   0
		dc.b $40 
		dc.b   5
		dc.b $68 
		dc.b   7
		dc.b $21 
		dc.b   0
		dc.b $40 
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $28 
		dc.b  $F
		dc.b $21 
		dc.b   0
		dc.b $40 
		dc.b   0
		dc.b $20
		dc.b   5
		dc.b $38 
		dc.b  $F
		dc.b $21 
		dc.b   0
		dc.b $40 
		dc.b   0
		dc.b $40 
		dc.b   5
		dc.b $48 
		dc.b  $F
		dc.b $21 

; =============== S U B R O U T I N E =======================================

sub_1DCE8:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		subq.w  #1,((byte_FFB532-$1000000)).w
		bne.s   loc_1DCFA
		clr.b   ((byte_FFB588-$1000000)).w
loc_1DCFA:
		moveq   #$F,d0
loc_1DCFC:
		move.w  d0,-(sp)
		tst.w   (a5)
		beq.w   loc_1DDE8
		addq.w  #1,(a5)
		cmpi.w  #2,(a5)
		bne.w   loc_1DD74
		move.w  #$300,d6
		jsr     (UpdateRandomSeed).w
		subi.w  #$700,d7
		move.w  d7,2(a5)
		moveq   #$35,d1 
		sub.w   d0,d1
		move.w  d1,d0
		moveq   #3,d6
		jsr     (UpdateRandomSeed).w
		lsl.w   #3,d7
		lea     byte_1DE06(pc), a0
		adda.w  d7,a0
		bsr.w   sub_19F5E
		move.w  #$100,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$80,d7 
		move.w  d7,6(a4)
		move.w  #$40,d6 
		jsr     (UpdateRandomSeed).w
		addi.w  #$100,d7
		move.w  d7,(a4)
		btst    #0,d7
		beq.s   loc_1DD60
		bset    #3,4(a4)
loc_1DD60:
		btst    #1,d7
		beq.s   loc_1DD6C
		bset    #4,4(a4)
loc_1DD6C:
		trap    #SOUND_COMMAND
		dc.w SFX_BIG_DOOR_RUMBLE
		bra.w   loc_1DDE8
loc_1DD74:
		move.w  2(a5),d1
		add.w   4(a5),d1
		tst.w   d1
		bmi.s   loc_1DD8A
		move.w  d1,d2
		andi.w  #$FF,d2
		asr.w   #8,d1
		bra.s   loc_1DD98
loc_1DD8A:
		neg.w   d1
		move.w  d1,d2
		andi.w  #$FF,d2
		neg.w   d2
		asr.w   #8,d1
		neg.w   d1
loc_1DD98:
		move.w  d2,4(a5)
		add.w   d1,(a4)
		addi.w  #6,2(a5)
		cmpi.w  #8,(a5)
		bne.w   loc_1DDCC
		cmpi.b  #$10,((byte_FFB584-$1000000)).w
		bcc.w   loc_1DDE8
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1DDE8
		moveq   #1,d0
		bsr.w   sub_1A2F6
		addq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1DDE8
loc_1DDCC:
		cmpi.w  #$60,(a4) 
		bhi.w   loc_1DDE8
		clr.w   (a5)
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1DDE8:
		move.w  (sp)+,d0
		addq.w  #8,a4
		lea     $C(a5),a5
		dbf     d0,loc_1DCFC
		lea     byte_1DE1E(pc), a0
		bsr.w   sub_1B8B2
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1DCE8

byte_1DE06:     dc.b 0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $21 
		dc.b   6
		dc.b $20
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $27 
		dc.b  $B
		dc.b $20
byte_1DE1E:     dc.b 2
		dc.b $48 
		dc.b   0
		dc.b $1E
		dc.b   0
		dc.b   1

; =============== S U B R O U T I N E =======================================

sub_1DE24:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		tst.w   (a5)
		beq.w   loc_1DE80
		addq.w  #1,(a5)
		cmpi.w  #$28,(a5) 
		bne.s   loc_1DE3E
		clr.b   ((byte_FFB588-$1000000)).w
loc_1DE3E:
		subq.w  #1,4(a5)
		bne.w   loc_1DE6E
		move.w  #6,4(a5)
		bchg    #6,((byte_FFB56E-$1000000)).w
		bsr.w   sub_1A3E8
		lea     byte_1DFA2(pc), a0
		bchg    #0,3(a5)
		bne.s   loc_1DE64
		addq.w  #8,a0
loc_1DE64:
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		move.w  (a4),6(a5)
loc_1DE6E:
		cmpi.w  #3,4(a5)
		bcc.s   loc_1DE7C
		move.w  6(a5),(a4)
		bra.s   loc_1DE80
loc_1DE7C:
		move.w  #1,(a4)
loc_1DE80:
		lea     $C(a5),a5
		addq.w  #8,a4
		moveq   #$27,d0 
		moveq   #$13,d1
loc_1DE8A:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1DF7E
		addq.w  #1,(a5)
		tst.b   6(a5)
		beq.s   loc_1DEA0
		subq.w  #1,6(a4)
loc_1DEA0:
		move.w  2(a5),d1
		bne.w   loc_1DEFC
		moveq   #$20,d6 
		jsr     (UpdateRandomSeed).w
		move.w  d7,d1
		andi.w  #1,d1
		move.b  d1,6(a5)
		andi.w  #$18,d7
		move.b  d7,7(a5)
		lea     byte_1DFB2(pc), a0
		tst.b   d1
		beq.s   loc_1DECE
		addq.w  #8,a0
		trap    #SOUND_COMMAND
		dc.w SFX_BATTLEFIELD_DEATH
loc_1DECE:
		jsr     sub_19F5E
		or.b    d7,4(a4)
		move.w  #$80,d6 
		jsr     (UpdateRandomSeed).w
		add.w   d7,6(a4)
		move.w  #$A0,d6 
		jsr     (UpdateRandomSeed).w
		add.w   d7,(a4)
		addq.w  #1,2(a5)
		move.w  #3,4(a5)
		bra.w   loc_1DF7E
loc_1DEFC:
		cmpi.w  #3,(a5)
		bne.w   loc_1DF24
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1DF7E
		cmpi.b  #$15,((byte_FFB584-$1000000)).w
		bcc.w   loc_1DF7E
		moveq   #1,d0
		bsr.w   sub_1A2F6
		addq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1DF7E
loc_1DF24:
		subq.w  #1,4(a5)
		bne.w   loc_1DF7E
		move.w  #3,4(a5)
		move.w  2(a5),d1
		cmpi.w  #4,d1
		bcc.w   loc_1DF6A
		lea     byte_1DFC0(pc), a0
		tst.b   6(a5)
		beq.s   loc_1DF4A
		addq.w  #6,a0
loc_1DF4A:
		add.w   d1,d1
		move.w  (a0,d1.w),d1
		addi.w  #-$4000,d1
		clr.w   d2
		move.b  7(a5),d2
		lsl.w   #8,d2
		or.w    d2,d1
		move.w  d1,4(a4)
		addq.w  #1,2(a5)
		bra.w   loc_1DF7E
loc_1DF6A:
		clr.l   (a5)
		clr.l   4(a5)
		move.w  #1,(a4)
		move.w  #1,6(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1DF7E:
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1DE8A
		lea     byte_1DFCE(pc), a0
		bsr.w   sub_1B8B2
		cmpi.b  #2,((byte_FFB584-$1000000)).w
		bcs.w   sub_1B82A
		rts

	; End of function sub_1DE24

byte_1DFA2:     dc.b 1
		dc.b $12
		dc.b   0
		dc.b $CB 
		dc.b   7
		dc.b $80 
		dc.b   5
		dc.b $20
		dc.b   1
		dc.b $1E
		dc.b   0
		dc.b $CC 
		dc.b   7
		dc.b $84 
		dc.b   5
		dc.b $20
byte_1DFB2:     dc.b 0
		dc.b $80 
		dc.b   0
		dc.b $90 
		dc.b   7
		dc.b $94 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $80 
		dc.b   0
		dc.b $90 
		dc.b   6
		dc.b $F0 
byte_1DFC0:     dc.b $F
		dc.b $20
		dc.b   7
		dc.b $90 
		dc.b   7
		dc.b $8C 
		dc.b   7
		dc.b $88 
		dc.b   5
		dc.b $A0 
		dc.b   2
		dc.b $10
		dc.b   1
		dc.b $80 
byte_1DFCE:     dc.b 0
		dc.b  $F
		dc.b   0
		dc.b   8
		dc.b   0
		dc.b   1

; =============== S U B R O U T I N E =======================================

sub_1DFD4:
		lea     ((byte_FFB406-$1000000)).w,a5
		tst.w   (a5)
		beq.w   loc_1E010
		addq.w  #1,(a5)
		cmpi.w  #$28,(a5) 
		bne.s   loc_1DFEA
		clr.b   ((byte_FFB588-$1000000)).w
loc_1DFEA:
		subq.b  #1,4(a5)
		bne.w   loc_1E010
		move.b  #3,4(a5)
		lea     byte_1E10E(pc), a0
		lea     ((dword_FFDC88-$1000000)).w,a4
		moveq   #7,d0
		bsr.w   sub_1E0DA
		lea     ((byte_FFDDB0-$1000000)).w,a4
		moveq   #$A,d0
		bsr.w   sub_1E0DA
loc_1E010:
		lea     $C(a5),a5
		lea     ((byte_FFDE60-$1000000)).w,a4
		moveq   #$3C,d0 
		moveq   #2,d1
loc_1E01C:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1E0C0
		addq.w  #1,(a5)
		move.w  2(a5),d2
		bne.w   loc_1E05E
		subq.w  #1,4(a5)
		bne.w   loc_1E0C0
		lea     byte_1E106(pc), a0
		bsr.w   sub_19F5E
		move.w  #$100,d6
		jsr     (UpdateRandomSeed).w
		add.w   d7,6(a4)
		addq.w  #1,2(a5)
		move.w  #5,4(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_WING_FLAP
		bra.w   loc_1E0C0
loc_1E05E:
		cmpi.w  #3,d2
		bcc.w   loc_1E090
		subq.w  #1,4(a5)
		bne.w   loc_1E0C0
		addi.w  #4,4(a4)
		addq.w  #1,2(a5)
		cmpi.w  #2,d2
		bcc.s   loc_1E086
		move.w  #5,4(a5)
		bra.s   loc_1E08C
loc_1E086:
		move.w  #$C,4(a5)
loc_1E08C:
		bra.w   loc_1E0C0
loc_1E090:
		subq.w  #1,4(a5)
		beq.w   loc_1E0AE
		btst    #0,5(a5)
		bne.s   loc_1E0A6
		move.w  #$100,(a4)
		bra.s   loc_1E0AA
loc_1E0A6:
		move.w  #1,(a4)
loc_1E0AA:
		bra.w   loc_1E0C0
loc_1E0AE:
		clr.w   2(a5)
		moveq   #8,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #4,d7
		move.w  d7,4(a5)
loc_1E0C0:
		movem.w (sp)+,d0-d1
		addq.w  #1,d0
		lea     $C(a5),a5
		addq.w  #8,a4
		dbf     d1,loc_1E01C
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1DFD4


; =============== S U B R O U T I N E =======================================

sub_1E0DA:
		moveq   #$70,d6 
		jsr     (UpdateRandomSeed).w
		addi.w  #$98,d7 
		move.w  d7,(a4)+
		move.w  #$700,(a4)+
		move.w  #$C532,(a4)+
		move.w  (a0),(a4)+
		addi.w  #$20,d7 
		move.w  d7,(a4)+
		move.w  #$500,(a4)+
		move.w  #$C53A,(a4)+
		move.w  (a0)+,(a4)+
		dbf     d0,sub_1E0DA
		rts

	; End of function sub_1E0DA

byte_1E106:     dc.b 0
		dc.b $80 
		dc.b   1
		dc.b   0
		dc.b   5
		dc.b $3E 
		dc.b   5
		dc.b $20
byte_1E10E:     dc.b 0
		dc.b $88 
		dc.b   0
		dc.b $95 
		dc.b   0
		dc.b $A2 
		dc.b   0
		dc.b $AE 
		dc.b   0
		dc.b $BD 
		dc.b   0
		dc.b $C9 
		dc.b   0
		dc.b $D6 
		dc.b   0
		dc.b $E3 
		dc.b   0
		dc.b $F1 
		dc.b   0
		dc.b $FD 
		dc.b   1
		dc.b  $B
		dc.b   1
		dc.b $17
		dc.b   1
		dc.b $25 
		dc.b   1
		dc.b $32 
		dc.b   1
		dc.b $3F 
		dc.b   1
		dc.b $4B 
		dc.b   1
		dc.b $5A 
		dc.b   1
		dc.b $66 
		dc.b   1
		dc.b $78 

; =============== S U B R O U T I N E =======================================

sub_1E134:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((dword_FFDD20-$1000000)).w,a4
		bsr.s   sub_1E160
		lea     $C(a5),a5
		lea     $90(a4),a4
		bsr.s   sub_1E160
		subq.w  #1,((byte_FFB53A-$1000000)).w
		bne.s   loc_1E152
		clr.b   ((byte_FFB588-$1000000)).w
loc_1E152:
		bsr.w   sub_1B90C
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1E134


; =============== S U B R O U T I N E =======================================

sub_1E160:
		tst.w   (a5)
		beq.w   return_1E25C
		addq.w  #1,(a5)
		tst.w   8(a5)
		bne.s   loc_1E17C
		lea     ((byte_FFB532-$1000000)).w,a3
		lea     byte_1E290(pc), a0
		move.w  #$10,d0
		bra.s   loc_1E188
loc_1E17C:
		lea     ((dword_FFB536-$1000000)).w,a3
		lea     byte_1F7BE(pc), a0
		move.w  #$130,d0
loc_1E188:
		move.w  2(a5),d1
		bne.w   loc_1E1BC
		subq.w  #1,4(a5)
		bne.w   return_1E25C
		move.w  #1,(a5)
		addq.w  #1,2(a5)
		clr.l   4(a5)
		moveq   #$18,d6
		jsr     (UpdateRandomSeed).w
		add.w   d7,d0
		moveq   #$30,d6 
		jsr     (UpdateRandomSeed).w
		move.w  d7,d2
		addi.w  #$10,d2
		bra.w   loc_1E268
loc_1E1BC:
		subq.w  #1,d1
		bne.w   loc_1E228
		move.w  (a3),d0
		add.w   4(a5),d0
		tst.w   d0
		bmi.s   loc_1E1D6
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1E1E4
loc_1E1D6:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1E1E4:
		move.w  d1,4(a5)
		add.w   6(a4),d0
		move.w  2(a3),d2
		add.w   6(a5),d2
		tst.w   d2
		bmi.s   loc_1E202
		move.w  d2,d1
		andi.w  #$FF,d1
		asr.w   #8,d2
		bra.s   loc_1E210
loc_1E202:
		neg.w   d2
		move.w  d2,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d2
		neg.w   d2
loc_1E210:
		move.w  d1,6(a5)
		add.w   (a4),d2
		cmpi.w  #$C,(a5)
		bcs.s   loc_1E224
		addq.w  #1,2(a5)
		lea     $24(a0),a0
loc_1E224:
		bra.w   loc_1E268
loc_1E228:
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1E25E
		moveq   #2,d6
		jsr     (UpdateRandomSeed).w
		tst.w   d7
		bne.s   loc_1E240
		trap    #SOUND_COMMAND
		dc.w SFX_HIT_1
		bra.s   loc_1E244
loc_1E240:
		trap    #SOUND_COMMAND
		dc.w SFX_HIT_2
loc_1E244:
		bsr.w   sub_1B8FE
		clr.w   2(a5)
		move.w  #2,4(a5)
		moveq   #2,d6
		jsr     (UpdateRandomSeed).w
		move.w  d7,8(a5)
return_1E25C:
		rts
loc_1E25E:
		clr.w   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
		moveq   #1,d0
		moveq   #1,d2
loc_1E268:
		move.l  a4,-(sp)
		moveq   #3,d1
loc_1E26C:
		moveq   #3,d3
loc_1E26E:
		move.w  d2,(a4)+
		move.w  #$F00,(a4)+
		move.w  (a0)+,(a4)+
		move.w  d0,(a4)+
		addi.w  #$20,d2 
		dbf     d3,loc_1E26E
		addi.w  #$20,d0 
		subi.w  #$80,d2 
		dbf     d1,loc_1E26C
		movea.l (sp)+,a4
		rts

	; End of function sub_1E160

byte_1E290:     dc.b $89
		dc.b $60 
		dc.b $89 
		dc.b $70 
		dc.b $89 
		dc.b $F0 
		dc.b $8A 
		dc.b   0
		dc.b $89 
		dc.b $40 
		dc.b $89 
		dc.b $50 
		dc.b $89 
		dc.b $D0 
		dc.b $89 
		dc.b $E0 
		dc.b $89 
		dc.b $20
		dc.b $89 
		dc.b $30 
		dc.b $89 
		dc.b $B0 
		dc.b $89 
		dc.b $C0 
		dc.b $89 
		dc.b   0
		dc.b $89 
		dc.b $10
		dc.b $89 
		dc.b $90 
		dc.b $89 
		dc.b $A0 
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $8D 
		dc.b $80 
		dc.b $8D 
		dc.b $90 
		dc.b $8E 
		dc.b $D0 
		dc.b $8E 
		dc.b $E0 
		dc.b $8D 
		dc.b $60 
		dc.b $8D 
		dc.b $70 
		dc.b $8D 
		dc.b $F0 
		dc.b $8E 
		dc.b $C0 
		dc.b $8D 
		dc.b $40 
		dc.b $8D 
		dc.b $50 
		dc.b $8D 
		dc.b $D0 
		dc.b $8D 
		dc.b $E0 
		dc.b $8D 
		dc.b $20
		dc.b $8D 
		dc.b $30 
		dc.b $8D 
		dc.b $B0 
		dc.b $8D 
		dc.b $C0 

; =============== S U B R O U T I N E =======================================

sub_1E2D4:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   (a5)
		beq.w   return_1E452
		addq.w  #1,(a5)
		move.w  2(a5),d1
		cmpi.w  #3,d1
		bhi.w   loc_1E31A
		subq.w  #1,4(a5)
		bne.w   sub_1E4AC
		addq.w  #1,d1
		move.w  d1,2(a5)
		cmpi.w  #4,d1
		bcc.w   sub_1E4AC
		addi.w  #$10,4(a4)
		move.w  #$28,4(a5) 
		bra.w   sub_1E4AC
loc_1E31A:
		subq.w  #4,d1
		bne.w   loc_1E33C
		move.b  #1,1(a3)
		bsr.w   sub_1E4AC
		tst.w   d0
		bne.w   return_1E452
		move.w  #$D4,(a4) 
		addq.w  #1,2(a5)
		bra.w   return_1E452
loc_1E33C:
		subq.w  #1,d1
		bne.w   loc_1E3A8
		tst.w   6(a5)
		bne.s   loc_1E36C
		move.w  #$C563,4(a4)
		trap    #SOUND_COMMAND
		dc.w SFX_PRISM_LASER_FIRING; prism laser firing
		move.b  #OUT_TO_WHITE,((FADING_SETTING-$1000000)).w
		clr.w   ((unk_FFDFAA-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w
loc_1E36C:
		move.w  #$D8,d3 
		addq.w  #8,a4
		bsr.w   sub_1E454
		cmpi.w  #8,6(a5)
		bcs.w   return_1E452
		addq.w  #1,2(a5)
		move.w  #$1E,4(a5)
		move.b  #IN_FROM_WHITE,((FADING_SETTING-$1000000)).w
		clr.w   ((unk_FFDFAA-$1000000)).w
		clr.b   ((FADING_POINTER-$1000000)).w
		move.b  ((FADING_COUNTER_MAX-$1000000)).w,((FADING_COUNTER-$1000000)).w
		move.b  #$F,((FADING_PALETTE_FLAGS-$1000000)).w
		bra.w   return_1E452
loc_1E3A8:
		subq.w  #1,d1
		bne.w   loc_1E3C2
		subq.w  #1,4(a5)
		bne.w   return_1E452
		addq.w  #1,2(a5)
		clr.w   6(a5)
		bra.w   return_1E452
loc_1E3C2:
		subq.w  #1,d1
		bne.w   loc_1E3E2
		bsr.w   sub_1E48A
		cmpi.w  #9,6(a5)
		bcs.w   return_1E452
		addq.w  #1,2(a5)
		clr.b   ((byte_FFB589-$1000000)).w
		bra.w   return_1E452
loc_1E3E2:
		subq.w  #1,d1
		bne.w   loc_1E404
		cmpi.b  #3,((byte_FFB589-$1000000)).w
		bne.w   loc_1E44A
		move.b  #1,((byte_FFB589-$1000000)).w
		addq.w  #1,2(a5)
		clr.w   6(a5)
		bra.w   loc_1E44A
loc_1E404:
		subq.w  #1,d1
		bne.w   loc_1E432
		tst.w   6(a5)
		bne.s   loc_1E414
		trap    #SOUND_COMMAND
		dc.w SFX_PRISM_LASER_FIRING
loc_1E414:
		move.w  #$80,d3 
		bsr.w   sub_1E454
		cmpi.w  #9,6(a5)
		bcs.w   loc_1E44A
		addq.w  #1,2(a5)
		clr.w   6(a5)
		bra.w   loc_1E44A
loc_1E432:
		bsr.w   sub_1E48A
		cmpi.w  #9,6(a5)
		bcs.w   loc_1E44A
		clr.b   ((byte_FFB589-$1000000)).w
		move.w  #7,2(a5)
loc_1E44A:
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   sub_1B82A
return_1E452:
		rts

	; End of function sub_1E2D4


; =============== S U B R O U T I N E =======================================

sub_1E454:
		move.w  6(a5),d2
		beq.s   loc_1E476
		subq.w  #1,d2
		lsl.w   #3,d2
		adda.w  d2,a4
		move.w  #$D4,(a4)+ 
		move.w  #$F00,(a4)+
		move.w  #$C573,(a4)+
		lsl.w   #2,d2
		add.w   d2,d3
		move.w  d3,(a4)+
		addi.w  #$20,d3 
loc_1E476:
		move.w  #$D4,(a4)+ 
		move.w  #$F00,(a4)+
		move.w  #$C583,(a4)+
		move.w  d3,(a4)
		addq.w  #1,6(a5)
		rts

	; End of function sub_1E454


; =============== S U B R O U T I N E =======================================

sub_1E48A:
		move.w  6(a5),d2
		beq.s   loc_1E4A0
		subq.w  #1,d2
		lsl.w   #3,d2
		adda.w  d2,a4
		move.w  #1,(a4)+
		clr.l   (a4)+
		move.w  #1,(a4)+
loc_1E4A0:
		move.w  #$CD83,4(a4)
		addq.w  #1,6(a5)
		rts

	; End of function sub_1E48A


; =============== S U B R O U T I N E =======================================

sub_1E4AC:
		movem.l a4-a5,-(sp)
		bchg    #0,(a3)
		bne.s   loc_1E4BC
		move.w  #$D4,(a4) 
		bra.s   loc_1E4C0
loc_1E4BC:
		move.w  #1,(a4)
loc_1E4C0:
		moveq   #0,d0
		moveq   #4,d1
loc_1E4C4:
		lea     $C(a5),a5
		addq.w  #8,a4
		tst.w   (a5)
		beq.w   loc_1E5C6
		addq.w  #1,d0
		cmpi.w  #2,(a5)
		bcc.w   loc_1E532
		subq.w  #1,2(a5)
		bne.w   loc_1E5C6
		moveq   #$38,d6 
		jsr     (UpdateRandomSeed).w
		move.w  d7,d2
		addi.w  #$C8,d2 
		move.w  d2,(a4)
		clr.w   2(a4)
		moveq   #3,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #-$3AE0,d7
		move.w  d7,4(a4)
		moveq   #$14,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$D4,d7 
		move.w  d7,6(a4)
		subi.w  #$C0,d7 
		asl.w   #4,d7
		neg.w   d7
		move.w  d7,4(a5)
		subi.w  #$E4,d2 
		asl.w   #4,d2
		neg.w   d2
		move.w  d2,6(a5)
		clr.l   8(a5)
		addq.w  #1,(a5)
		bra.w   loc_1E5C6
loc_1E532:
		addq.w  #1,(a5)
		cmpi.w  #$12,(a5)
		bcc.w   loc_1E596
		move.w  4(a5),d2
		add.w   8(a5),d2
		tst.w   d2
		bmi.s   loc_1E552
		move.w  d2,d3
		andi.w  #$FF,d3
		asr.w   #8,d2
		bra.s   loc_1E560
loc_1E552:
		neg.w   d2
		move.w  d2,d3
		andi.w  #$FF,d3
		neg.w   d3
		asr.w   #8,d2
		neg.w   d2
loc_1E560:
		move.w  d3,8(a5)
		add.w   d2,6(a4)
		move.w  6(a5),d2
		add.w   $A(a5),d2
		tst.w   d2
		bmi.s   loc_1E57E
		move.w  d2,d3
		andi.w  #$FF,d3
		asr.w   #8,d2
		bra.s   loc_1E58C
loc_1E57E:
		neg.w   d2
		move.w  d2,d3
		andi.w  #$FF,d3
		neg.w   d3
		asr.w   #8,d2
		neg.w   d2
loc_1E58C:
		move.w  d3,$A(a5)
		add.w   d2,(a4)
		bra.w   loc_1E5C6
loc_1E596:
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		tst.b   1(a3)
		bne.s   loc_1E5C2
		move.w  #1,(a5)
		move.w  #4,d6
		jsr     (UpdateRandomSeed).w
		addq.w  #1,d7
		move.w  d7,2(a5)
		trap    #SOUND_COMMAND
		dc.w SFX_PRISM_LASER_LOADING
		bra.s   loc_1E5C6
loc_1E5C2:
		clr.l   (a5)
		subq.w  #1,d0
loc_1E5C6:
		dbf     d1,loc_1E4C4
		movem.l (sp)+,a4-a5
		rts

	; End of function sub_1E4AC


; =============== S U B R O U T I N E =======================================

sub_1E5D0:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		moveq   #$F,d7
		moveq   #$26,d6 
loc_1E5DC:
		tst.w   (a5)
		beq.w   loc_1E75A
		cmpi.w  #1,(a5)
		bne.s   loc_1E622
		movem.w d6-d7,-(sp)
		move.w  #$200,d6
		jsr     (UpdateRandomSeed).w
		addi.w  #$140,d7
		move.w  d7,2(a5)
		move.w  #$100,d6
		jsr     (UpdateRandomSeed).w
		subi.w  #$200,d7
		move.w  d7,4(a5)
		movem.w (sp)+,d6-d7
		lea     byte_1E786(pc), a0
		move.w  d6,d0
		bsr.w   sub_19F5E
		trap    #SOUND_COMMAND
		dc.w SFX_LANDSTALKER_SWITCH
		bra.w   loc_1E730
loc_1E622:
		cmpi.w  #$28,(a5) 
		bcc.w   loc_1E68C
		move.w  2(a5),d0
		add.w   6(a5),d0
		tst.w   d0
		bmi.s   loc_1E640
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1E64E
loc_1E640:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1E64E:
		move.w  d1,6(a5)
		add.w   d0,6(a4)
		move.w  4(a5),d0
		addi.w  #$1C,d0
		move.w  d0,4(a5)
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1E674
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1E682
loc_1E674:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1E682:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bra.w   loc_1E730
loc_1E68C:
		bne.w   loc_1E6B4
		movem.w d6-d7,-(sp)
		clr.w   2(a5)
		move.w  #$20,d6 
		jsr     (UpdateRandomSeed).w
		subi.w  #$40,d7 
		move.w  d7,4(a5)
		clr.l   6(a5)
		movem.w (sp)+,d6-d7
		bra.w   loc_1E730
loc_1E6B4:
		cmpi.w  #$50,(a5) 
		bcc.w   loc_1E716
		addq.w  #1,2(a5)
		move.w  2(a5),d0
		lsr.w   #1,d0
		andi.w  #3,d0
		cmpi.w  #3,d0
		bcs.s   loc_1E6D2
		moveq   #2,d0
loc_1E6D2:
		btst    #3,3(a5)
		beq.s   loc_1E6DC
		neg.w   d0
loc_1E6DC:
		add.w   d0,6(a4)
		move.w  4(a5),d0
		subi.w  #$20,d0 
		move.w  d0,4(a5)
		add.w   8(a5),d0
		tst.w   d0
		bmi.s   loc_1E6FE
		move.w  d0,d1
		andi.w  #$FF,d1
		asr.w   #8,d0
		bra.s   loc_1E70C
loc_1E6FE:
		neg.w   d0
		move.w  d0,d1
		andi.w  #$FF,d1
		neg.w   d1
		asr.w   #8,d0
		neg.w   d0
loc_1E70C:
		move.w  d1,8(a5)
		add.w   d0,(a4)
		bra.w   loc_1E730
loc_1E716:
		clr.w   (a5)
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.b   ((byte_FFB588-$1000000)).w
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.s   loc_1E75A
loc_1E730:
		addq.w  #1,(a5)
		lea     byte_1E78E(pc), a0
		moveq   #5,d0
		bsr.w   sub_1B884
		cmpi.w  #$A,(a5)
		bne.s   loc_1E75A
		cmpi.b  #$10,((byte_FFB584-$1000000)).w
		bcc.s   loc_1E75A
		tst.w   ((byte_FFB404-$1000000)).w
		beq.s   loc_1E75A
		moveq   #1,d0
		bsr.w   sub_1A2F6
		addq.b  #1,((byte_FFB584-$1000000)).w
loc_1E75A:
		btst    #2,1(a5)
		bne.s   loc_1E76A
		bclr    #3,4(a4)
		bra.s   loc_1E770
loc_1E76A:
		bset    #3,4(a4)
loc_1E770:
		addq.w  #8,a4
		lea     $C(a5),a5
		addq.w  #1,d6
		dbf     d7,loc_1E5DC
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1E5D0

byte_1E786:     dc.b 0
		dc.b $D4 
		dc.b   0
		dc.b $F8 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
byte_1E78E:     dc.b 0
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b $14
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   2
		dc.b   0
		dc.b $1E
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   3
		dc.b   0
		dc.b $28 
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b   4
		dc.b   0
		dc.b $32 
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b   8
		dc.b   0
		dc.b $3C 
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $11

; =============== S U B R O U T I N E =======================================

sub_1E7B2:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		addq.b  #1,2(a3)
		move.b  2(a3),3(a3)
		moveq   #$18,d1
		moveq   #$26,d0 
loc_1E7CC:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1E8AA
		addq.w  #1,(a5)
		cmpi.w  #2,(a5)
		bne.w   loc_1E806
		lea     byte_1E8E2(pc), a0
		btst    #7,((byte_FFB586-$1000000)).w
		beq.s   loc_1E7EE
		addq.w  #8,a0
loc_1E7EE:
		bsr.w   sub_19F5E
		move.w  (a4),8(a5)
		moveq   #$28,d6 
		jsr     (UpdateRandomSeed).w
		add.w   (a3),d7
		move.w  d7,2(a5)
		bra.w   loc_1E8AA
loc_1E806:
		move.w  2(a5),d0
		jsr     (sub_179C).w    
		asl.w   #2,d1
		add.w   4(a5),d1
		tst.w   d1
		bmi.s   loc_1E822
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1E830
loc_1E822:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1E830:
		move.w  d0,4(a5)
		add.w   d1,6(a4)
		swap    d1
		asl.w   #2,d1
		add.w   6(a5),d1
		tst.w   d1
		bmi.s   loc_1E84E
		move.w  d1,d0
		andi.w  #$FF,d0
		asr.w   #8,d1
		bra.s   loc_1E85C
loc_1E84E:
		neg.w   d1
		move.w  d1,d0
		andi.w  #$FF,d0
		neg.w   d0
		asr.w   #8,d1
		neg.w   d1
loc_1E85C:
		move.w  d0,6(a5)
		add.w   d1,8(a5)
		cmpi.w  #5,(a5)
		bne.w   loc_1E88A
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1E8AA
		moveq   #1,d0
		bsr.w   sub_1A2F6
		cmpi.w  #$FFFF,d0
		beq.w   loc_1E8AA
		addq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1E8AA
loc_1E88A:
		cmpi.w  #$26,(a5) 
		bcs.w   loc_1E8AA
		clr.w   (a5)
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.b   ((byte_FFB588-$1000000)).w
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1E8AA:
		move.w  8(a5),(a4)
		moveq   #$10,d0
		lea     byte_1E8F2(pc), a0
		bsr.w   sub_1B884
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1E7CC
		move.b  2(a3),d0
		andi.w  #3,d0
		bne.s   loc_1E8D6
		trap    #SOUND_COMMAND
		dc.w SFX_TINKLING
loc_1E8D6:
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		bra.w   loc_1D45C

	; End of function sub_1E7B2

byte_1E8E2:     dc.b 1
		dc.b $1C
		dc.b   0
		dc.b $DE 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $E0 
		dc.b   0
		dc.b $DF 
		dc.b   5
		dc.b $20
		dc.b   0
		dc.b $20
byte_1E8F2:     dc.b 0
		dc.b   2
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b   4
		dc.b   0
		dc.b   4
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b   8
		dc.b   0
		dc.b   6
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b  $C
		dc.b   0
		dc.b   8
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b $10
		dc.b   0
		dc.b  $A
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b $14
		dc.b   0
		dc.b  $D
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b $18
		dc.b   0
		dc.b  $F
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b $21 
		dc.b   0
		dc.b $11
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b $2A 
		dc.b   0
		dc.b $13
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b $33 
		dc.b   0
		dc.b $15
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b $3C 
		dc.b   0
		dc.b $17
		dc.b  $A
		dc.b   0
		dc.b   0
		dc.b $45 
		dc.b   0
		dc.b $1A
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $4E 
		dc.b   0
		dc.b $1C
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $5E 
		dc.b   0
		dc.b $1E
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $6E 
		dc.b   0
		dc.b $20
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $7E 
		dc.b   0
		dc.b $22 
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $8E 
		dc.b   0
		dc.b $24 
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $9E 

; =============== S U B R O U T I N E =======================================

sub_1E958:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   (a5)
		beq.w   loc_1CD70
		addq.w  #1,(a5)
		cmpi.w  #2,(a3)
		beq.w   loc_1E994
		tst.w   (a3)
		bne.w   loc_1E9B4
		lea     byte_1CE0C(pc), a0
		moveq   #5,d0
		bsr.w   sub_1B884
		cmpi.w  #$26,(a5) 
		bcs.w   loc_1E9B4
		move.w  #1,(a3)
		bra.w   loc_1E9B4
loc_1E994:
		lea     byte_1CE2A(pc), a0
		moveq   #5,d0
		bsr.w   sub_1B884
		cmpi.w  #$26,(a5) 
		bcs.w   loc_1E9B4
		clr.w   (a5)
		move.w  #1,(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1CD70
loc_1E9B4:
		btst    #7,((byte_FFB586-$1000000)).w
		beq.s   loc_1E9D0
		btst    #2,((byte_FFB56F-$1000000)).w
		bne.s   loc_1E9CA
		move.w  #$D0,d3 
		bra.s   loc_1E9CE
loc_1E9CA:
		move.w  #$130,d3
loc_1E9CE:
		bra.s   loc_1E9E2
loc_1E9D0:
		btst    #1,((byte_FFB56F-$1000000)).w
		bne.s   loc_1E9DE
		move.w  #$138,d3
		bra.s   loc_1E9E2
loc_1E9DE:
		move.w  #$C8,d3 
loc_1E9E2:
		move.w  2(a5),d0
		subq.w  #8,d0
		andi.w  #$FF,d0
		move.w  d0,2(a5)
		move.l  #$12003800,d1
		jsr     (sub_1812).w
		add.w   d3,d2
		move.w  d2,6(a4)
		swap    d2
		addi.w  #$D0,d2 
		move.w  d2,(a4)
		bra.w   loc_1CD10
loc_1EA0C:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		btst    #0,((byte_FFB586-$1000000)).w
		beq.w   loc_1EAB2
		moveq   #$26,d0 
		moveq   #2,d1
loc_1EA22:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1EA98
		addq.w  #1,(a5)
		cmpi.w  #2,(a5)
		bne.w   loc_1EA46
		lea     byte_1EB88(pc), a0
		bsr.w   sub_19F5E
		trap    #SOUND_COMMAND
		dc.w SFX_LANDSTALKER_SWITCH
		bra.w   loc_1EA98
loc_1EA46:
		subq.w  #3,6(a4)
		lea     byte_1EB90(pc), a0
		moveq   #3,d0
		bsr.w   sub_1B884
		cmpi.w  #$C,(a5)
		bne.w   loc_1EA7C
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1EA98
		cmpi.b  #3,((byte_FFB584-$1000000)).w
		bcc.w   loc_1EA98
		moveq   #1,d0
		bsr.w   sub_1A2F6
		addq.b  #1,((byte_FFB584-$1000000)).w
		bra.w   loc_1EA98
loc_1EA7C:
		cmpi.w  #$1A,(a5)
		bcs.w   loc_1EA98
		clr.w   (a5)
		move.w  #1,(a4)
		move.w  #1,6(a4)
		subq.b  #1,((byte_FFB584-$1000000)).w
		clr.b   ((byte_FFB588-$1000000)).w
loc_1EA98:
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1EA22
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts
loc_1EAB2:
		tst.w   (a5)
		beq.w   loc_1EB7E
		addq.w  #1,(a5)
		move.w  2(a5),d0
		bne.w   loc_1EAD4
		lea     byte_1EBA2(pc), a0
		moveq   #$26,d0 
		bsr.w   sub_19F5E
		addq.w  #1,2(a5)
		bra.w   loc_1EB7E
loc_1EAD4:
		subq.w  #1,d0
		bne.w   loc_1EAFE
		cmpi.w  #4,(a5)
		bcs.w   loc_1EB7E
		moveq   #$27,d0 
		moveq   #2,d1
		clr.w   d2
		clr.w   d3
		lea     byte_1EBAA(pc), a0
		bsr.w   sub_19FAA
		trap    #SOUND_COMMAND
		dc.w SFX_DESOUL_HOVERING
		addq.w  #1,2(a5)
		bra.w   loc_1EB7E
loc_1EAFE:
		cmpi.w  #6,(a5)
		bne.s   loc_1EB12
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
loc_1EB12:
		addq.w  #8,a4
		move.w  4(a5),d0
		subq.w  #2,d0
		andi.w  #$FF,d0
		move.w  d0,4(a5)
		move.w  #$3000,d1
		jsr     (sub_17EC).w
		addi.w  #$D8,d2 
		move.w  d2,6(a4)
		move.w  d2,$E(a4)
		swap    d2
		addi.w  #$A4,d2 
		move.w  d2,(a4)
		addi.w  #$20,d2 
		move.w  d2,8(a4)
		btst    #0,1(a5)
		bne.s   loc_1EB72
		move.w  6(a5),d0
		addq.w  #1,d0
		cmpi.w  #3,d0
		bcs.s   loc_1EB5C
		clr.w   d0
loc_1EB5C:
		move.w  d0,6(a5)
		lsl.w   #5,d0
		addi.w  #-$3AB5,d0
		move.w  d0,4(a4)
		addi.w  #$10,d0
		move.w  d0,$C(a4)
loc_1EB72:
		cmpi.w  #$1A,(a5)
		bne.w   loc_1EB7E
		clr.b   ((byte_FFB588-$1000000)).w
loc_1EB7E:
		cmpi.w  #$22,(a5) 
		bcc.w   sub_1B82A
		rts

	; End of function sub_1E958

byte_1EB88:     dc.b 1
		dc.b $1C
		dc.b   0
		dc.b $D4 
		dc.b   5
		dc.b $20
		dc.b  $F
		dc.b $20
byte_1EB90:     dc.b 0
		dc.b   8
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $10
		dc.b   0
		dc.b  $E
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b $14
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $30 
byte_1EBA2:     dc.b 0
		dc.b $FD 
		dc.b   0
		dc.b $DD 
		dc.b   5
		dc.b $DF 
		dc.b  $F
		dc.b $23 
byte_1EBAA:     dc.b 0
		dc.b $6E 
		dc.b   0
		dc.b $4E 
		dc.b   5
		dc.b $4B 
		dc.b  $F
		dc.b $20
		dc.b   0
		dc.b $6E 
		dc.b   0
		dc.b $6E 
		dc.b   5
		dc.b $5B 
		dc.b  $F
		dc.b $20

; =============== S U B R O U T I N E =======================================

sub_1EBBA:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		moveq   #$26,d0 
		moveq   #$F,d1
loc_1EBC6:
		movem.w d0-d1,-(sp)
		tst.w   (a5)
		beq.w   loc_1EC80
		addq.w  #1,(a5)
		cmpi.w  #2,(a5)
		bne.w   loc_1EC22
		moveq   #7,d6
		jsr     (UpdateRandomSeed).w
		lea     byte_1EC9A(pc), a0
		bclr    #0,d7
		bne.s   loc_1EBF2
		move.b  #1,2(a5)
		addq.w  #8,a0
loc_1EBF2:
		bsr.w   sub_19F5E
		lsl.w   #2,d7
		or.b    d7,4(a4)
		move.w  #$C0,d6 
		jsr     (UpdateRandomSeed).w
		addi.w  #$A0,d7 
		move.w  d7,6(a4)
		move.w  #$80,d6 
		jsr     (UpdateRandomSeed).w
		addi.w  #$A0,d7 
		move.w  d7,(a4)
		trap    #SOUND_COMMAND
		dc.w SFX_BATTLEFIELD_DEATH
		bra.w   loc_1EC80
loc_1EC22:
		cmpi.w  #4,(a5)
		bne.w   loc_1EC46
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   loc_1EC46
		cmpi.b  #$10,((byte_FFB584-$1000000)).w
		bcc.w   loc_1EC46
		moveq   #1,d0
		bsr.w   sub_1A2F6
		addq.b  #1,((byte_FFB584-$1000000)).w
loc_1EC46:
		tst.b   2(a5)
		bne.s   loc_1EC5A
		lea     byte_1ECAA(pc), a0
		moveq   #3,d0
		bsr.w   sub_1B884
		moveq   #$E,d0
		bra.s   loc_1EC66
loc_1EC5A:
		lea     byte_1ECBC(pc), a0
		moveq   #2,d0
		bsr.w   sub_1B884
		moveq   #$B,d0
loc_1EC66:
		cmp.w   (a5),d0
		bhi.w   loc_1EC80
		move.w  #1,(a4)
		clr.l   2(a4)
		move.w  #1,6(a4)
		clr.l   (a5)
		subq.b  #1,((byte_FFB584-$1000000)).w
loc_1EC80:
		movem.w (sp)+,d0-d1
		lea     $C(a5),a5
		addq.w  #8,a4
		addq.w  #1,d0
		dbf     d1,loc_1EBC6
		tst.b   ((byte_FFB584-$1000000)).w
		beq.w   sub_1B82A
		rts

	; End of function sub_1EBBA

byte_1EC9A:     dc.b 0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $20
		dc.b  $F
		dc.b $20
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $60 
		dc.b   5
		dc.b $20
byte_1ECAA:     dc.b 0
		dc.b   5
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $10
		dc.b   0
		dc.b   8
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $20
		dc.b   0
		dc.b  $B
		dc.b  $F
		dc.b   0
		dc.b   0
		dc.b $30 
byte_1ECBC:     dc.b 0
		dc.b   5
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b $44 
		dc.b   0
		dc.b   8
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b $48 

; =============== S U B R O U T I N E =======================================

sub_1ECC8:
		lea     ((byte_FFB406-$1000000)).w,a5
		lea     ((byte_FFDDB0-$1000000)).w,a4
		lea     ((byte_FFB532-$1000000)).w,a3
		tst.w   (a5)
		beq.w   return_1EDDA
		addq.w  #1,(a5)
		move.b  2(a5),d0
		bne.w   loc_1ED06
		move.w  6(a5),d0
		move.w  (a4),d1
		move.w  d1,6(a5)
		move.w  d0,(a4)
		subq.b  #1,3(a5)
		bne.w   return_1EDDA
		addq.b  #1,2(a5)
		move.b  #2,3(a5)
		bra.w   return_1EDDA
loc_1ED06:
		subq.b  #1,d0
		bne.w   loc_1ED64
		subq.b  #1,3(a5)
		bne.w   return_1EDDA
		move.b  #2,3(a5)
		tst.w   4(a5)
		bne.s   loc_1ED42
		move.w  2(a3),(a4)
		move.w  #$C00,2(a4)
		move.w  #$C524,d0
		or.w    4(a3),d0
		move.w  d0,4(a4)
		move.w  (a3),6(a4)
		addq.w  #1,4(a5)
		bra.w   return_1EDDA
loc_1ED42:
		move.w  (a3),d2
		bsr.w   sub_1EDDC
		cmpi.w  #6,4(a5)
		bcs.w   return_1EDDA
		addq.b  #1,2(a5)
		move.b  #$1E,3(a5)
		clr.b   ((byte_FFB588-$1000000)).w
		bra.w   return_1EDDA
loc_1ED64:
		subq.b  #1,d0
		bne.w   loc_1ED84
		subq.b  #1,3(a5)
		bne.w   return_1EDDA
		addq.b  #1,2(a5)
		move.b  #2,3(a5)
		clr.w   4(a5)
		bra.w   return_1EDDA
loc_1ED84:
		subq.b  #1,d0
		bne.w   loc_1EDB2
		subq.b  #1,3(a5)
		bne.w   return_1EDDA
		move.b  #2,3(a5)
		bsr.w   sub_1EE1A
		cmpi.w  #6,4(a5)
		bcs.w   return_1EDDA
		addq.b  #1,2(a5)
		clr.b   ((byte_FFB589-$1000000)).w
		bra.w   return_1EDDA
loc_1EDB2:
		tst.w   ((byte_FFB404-$1000000)).w
		beq.w   sub_1B82A
		cmpi.b  #3,((byte_FFB589-$1000000)).w
		bne.w   return_1EDDA
		move.b  #1,((byte_FFB588-$1000000)).w
		move.b  #1,((byte_FFB589-$1000000)).w
		move.w  #$102,2(a5)
		clr.w   4(a5)
return_1EDDA:
		rts

	; End of function sub_1ECC8


; =============== S U B R O U T I N E =======================================

sub_1EDDC:
		move.w  4(a5),d0
		moveq   #$20,d1 
		tst.w   4(a3)
		beq.s   loc_1EDEA
		neg.w   d1
loc_1EDEA:
		muls.w  d0,d1
		add.w   d2,d1
		lsl.w   #3,d0
		lea     (a4,d0.w),a0
		cmpi.w  #2,4(a5)
		bcs.s   loc_1EE00
		subq.w  #4,-4(a0)
loc_1EE00:
		move.w  2(a3),(a0)+
		move.w  #$C00,(a0)+
		move.w  #$C52C,d0
		or.w    4(a3),d0
		move.w  d0,(a0)+
		move.w  d1,(a0)+
		addq.w  #1,4(a5)
		rts

	; End of function sub_1EDDC


; =============== S U B R O U T I N E =======================================

sub_1EE1A:
		move.w  4(a5),d0
		lsl.w   #3,d0
		move.w  #1,(a4,d0.w)
		addq.w  #1,4(a5)
		rts

	; End of function sub_1EE1A


; =============== S U B R O U T I N E =======================================

; and other stuff ?

VInt_UpdateBattlesceneGraphics:
		
		addq.w  #1,((BATTLESCENE_FRAME_COUNTER-$1000000)).w
		clr.b   ((byte_FFB56D-$1000000)).w
		bsr.w   UpdateEnemyBSprite
		bsr.w   UpdateAllyBSprite
		bsr.w   sub_1EFD8
		bsr.w   sub_1F282
		bsr.w   sub_1B7B0
		bsr.w   sub_1F148
		bsr.w   sub_1F176
		jmp     (sub_1942).w    

	; End of function VInt_UpdateBattlesceneGraphics


; =============== S U B R O U T I N E =======================================

UpdateEnemyBSprite:
		
		btst    #3,((byte_FFB56E-$1000000)).w
		beq.s   return_1EE74
		btst    #5,((byte_FFB56E-$1000000)).w
		beq.s   return_1EE74
		subq.w  #1,((ENEMY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
		bne.s   return_1EE74
		bsr.w   sub_1EF2E
		move.w  ((ENEMY_BATTLESPRITE_ANIM_SPEED-$1000000)).w,((ENEMY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
return_1EE74:
		rts

	; End of function UpdateEnemyBSprite


; =============== S U B R O U T I N E =======================================

UpdateAllyBSprite:
		
		btst    #1,((byte_FFB56E-$1000000)).w
		beq.s   return_1EE94
		btst    #4,((byte_FFB56E-$1000000)).w
		beq.s   return_1EE94
		subq.w  #1,((ALLY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
		bne.s   return_1EE94
		bsr.s   UpdateWeaponSprite
		move.w  ((ALLY_BATTLESPRITE_ANIM_SPEED-$1000000)).w,((ALLY_BATTLESPRITE_ANIM_COUNTER-$1000000)).w
return_1EE94:
		rts

	; End of function UpdateAllyBSprite


; =============== S U B R O U T I N E =======================================

UpdateWeaponSprite:
		
		bchg    #0,((byte_FFB56E-$1000000)).w
		beq.s   loc_1EEAA
		clr.w   d2
		move.b  ((WEAPON_IDLE_FRAME1_X-$1000000)).w,d3
		move.b  ((WEAPON_IDLE_FRAME1_Y-$1000000)).w,d4
		bra.s   loc_1EEB6
loc_1EEAA:
		move.w  #$90,d2 
		move.b  ((WEAPON_IDLE_FRAME2_X-$1000000)).w,d3
		move.b  ((WEAPON_IDLE_FRAME2_Y-$1000000)).w,d4
loc_1EEB6:
		lea     byte_1F57A(pc), a0
		btst    #0,((byte_FFB56F-$1000000)).w
		beq.s   loc_1EEC6
		lea     $48(a0),a0
loc_1EEC6:
		lea     ((byte_FFDC8C-$1000000)).w,a1
		moveq   #8,d7
loc_1EECC:
		move.w  (a0),(a1)
		add.w   d2,(a1)
		addq.w  #8,a0
		addq.w  #8,a1
		dbf     d7,loc_1EECC
		cmpi.w  #$FFFF,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		beq.w   return_1EF2C
		ext.w   d3
		ext.w   d4
		move.b  ((WEAPON_FRAME_IDX-$1000000)).w,d7
		btst    #1,((byte_FFB56F-$1000000)).w
		beq.s   loc_1EEF6
		bchg    #4,d7
loc_1EEF6:
		lea     byte_1F606(pc), a0
		andi.w  #$30,d7 
		add.w   d7,d7
		adda.w  d7,a0
		lea     ((byte_FFDCD0-$1000000)).w,a1
		moveq   #3,d7
loc_1EF08:
		move.w  (a0),d0
		subi.w  #$C0,d0 
		add.w   ((word_FFB3F4-$1000000)).w,d0
		add.w   d4,d0
		move.w  d0,(a1)
		addq.w  #6,a0
		addq.w  #6,a1
		move.w  (a0)+,d0
		subi.w  #$108,d0
		add.w   ((word_FFB3F2-$1000000)).w,d0
		add.w   d3,d0
		move.w  d0,(a1)+
		dbf     d7,loc_1EF08
return_1EF2C:
		rts

	; End of function UpdateWeaponSprite


; =============== S U B R O U T I N E =======================================

sub_1EF2E:
		bsr.w   sub_1EF50
		bra.w   loc_1EFB0

	; End of function sub_1EF2E


; =============== S U B R O U T I N E =======================================

sub_1EF36:
		bsr.w   sub_1EF50
		lea     (byte_FFE000).l,a0
		lea     ($E000).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jmp     (sub_10DC).w    

	; End of function sub_1EF36


; =============== S U B R O U T I N E =======================================

sub_1EF50:
		lea     byte_1F6B6(pc), a0
		lea     (byte_FFE184).l,a1
		bchg    #2,((byte_FFB56E-$1000000)).w
		beq.s   loc_1EF68
		move.w  #$A220,d0
		bra.s   loc_1EF6C
loc_1EF68:
		move.w  #$A2E0,d0
loc_1EF6C:
		btst    #2,((byte_FFB56F-$1000000)).w
		bne.s   loc_1EF8E
		moveq   #$B,d7
loc_1EF76:
		moveq   #$F,d6
loc_1EF78:
		clr.w   d5
		move.b  (a0)+,d5
		add.w   d0,d5
		move.w  d5,(a1)+
		dbf     d6,loc_1EF78
		lea     $20(a1),a1
		dbf     d7,loc_1EF76
		bra.s   return_1EFAE
loc_1EF8E:
		bset    #$B,d0
		lea     $20(a1),a1
		moveq   #$B,d7
loc_1EF98:
		moveq   #$F,d6
loc_1EF9A:
		clr.w   d5
		move.b  (a0)+,d5
		add.w   d0,d5
		move.w  d5,-(a1)
		dbf     d6,loc_1EF9A
		lea     $60(a1),a1
		dbf     d7,loc_1EF98
return_1EFAE:
		rts

	; End of function sub_1EF50


; START OF FUNCTION CHUNK FOR sub_1EF2E

loc_1EFB0:
		tst.b   ((byte_FFB56D-$1000000)).w
		bne.s   return_1EFD6
		move.b  #1,((byte_FFB56D-$1000000)).w
		lea     (byte_FFE000).l,a0
		lea     ($E000).l,a1
		move.w  #$400,d0
		moveq   #2,d1
		jsr     (sub_119E).w    
		jsr     (Set_FFDE94_bit3).w
return_1EFD6:
		rts

; END OF FUNCTION CHUNK FOR sub_1EF2E


; =============== S U B R O U T I N E =======================================

sub_1EFD8:
		clr.w   d7
		move.b  ((byte_FFB580-$1000000)).w,d7
		addq.b  #1,d7
		andi.b  #$3F,d7 
		move.b  d7,((byte_FFB580-$1000000)).w
		move.b  ((byte_FFB57E-$1000000)).w,d0
		btst    #1,((byte_FFB56E-$1000000)).w
		bne.s   loc_1EFFE
		btst    #4,((byte_FFB56E-$1000000)).w
		bne.s   loc_1EFFE
		clr.w   d0
loc_1EFFE:
		move.b  ((ALLY_BATTLESPRITE_PROP2-$1000000)).w,d1
		ext.w   d1
		btst    #1,((byte_FFB56F-$1000000)).w
		bne.s   loc_1F012
		move.b  ((ALLY_BATTLESPRITE_PROP1-$1000000)).w,d4
		bra.s   loc_1F01A
loc_1F012:
		move.b  #$60,d4 
		sub.b   ((ALLY_BATTLESPRITE_PROP1-$1000000)).w,d4
loc_1F01A:
		ext.w   d4
		add.w   ((word_FFB3F4-$1000000)).w,d1
		add.w   ((word_FFB3F2-$1000000)).w,d4
		lea     ((word_FFB3FA-$1000000)).w,a1
		bsr.w   sub_1F0B0
		lea     ((byte_FFDD08-$1000000)).w,a0
		move.w  d1,(a0)+
		move.w  d2,(a0)+
		move.w  d3,(a0)+
		move.w  d4,(a0)
		move.b  #2,(byte_FFAFB1).l
		clr.w   d7
		move.b  ((byte_FFB581-$1000000)).w,d7
		addq.b  #1,d7
		andi.b  #$3F,d7 
		move.b  d7,((byte_FFB581-$1000000)).w
		move.b  ((byte_FFB57F-$1000000)).w,d0
		btst    #3,((byte_FFB56E-$1000000)).w
		bne.s   loc_1F066
		btst    #5,((byte_FFB56E-$1000000)).w
		bne.s   loc_1F066
		clr.w   d0
loc_1F066:
		move.b  ((ENEMY_BATTLESPRITE_PROP2-$1000000)).w,d1
		ext.w   d1
		btst    #2,((byte_FFB56F-$1000000)).w
		bne.s   loc_1F07A
		move.b  ((ENEMY_BATTLESPRITE_PROP1-$1000000)).w,d4
		bra.s   loc_1F082
loc_1F07A:
		move.b  #$80,d4
		sub.b   ((ENEMY_BATTLESPRITE_PROP1-$1000000)).w,d4
loc_1F082:
		ext.w   d4
		addi.w  #$B0,d1 
		add.w   ((word_FFB3F0-$1000000)).w,d1
		addi.w  #$90,d4 
		add.w   ((word_FFB3EC-$1000000)).w,d4
		lea     ((word_FFB3F6-$1000000)).w,a1
		bsr.s   sub_1F0B0
		lea     ((byte_FFDD10-$1000000)).w,a0
		move.w  d1,(a0)+
		move.w  d2,(a0)+
		move.w  d3,(a0)+
		move.w  d4,(a0)
		move.b  #2,(word_FFAFB2).l
		rts

	; End of function sub_1EFD8


; =============== S U B R O U T I N E =======================================

sub_1F0B0:
		tst.b   d0
		beq.w   loc_1F11E
		subq.b  #1,d0
		bne.s   loc_1F0D0
		btst    #4,d7
		beq.w   loc_1F11E
		move.w  #$500,d2
		move.w  #$C7BB,d3
		subq.w  #8,d1
		subq.w  #8,d4
		rts
loc_1F0D0:
		subq.b  #1,d0
		bne.s   loc_1F0F2
		move.w  #$900,d2
		move.w  #$C7BF,d3
		lsr.w   #3,d7
		andi.w  #3,d7
		mulu.w  #6,d7
		add.w   d7,d3
		subi.w  #$20,d1 
		subi.w  #$C,d4
		rts
loc_1F0F2:
		subq.b  #1,d0
		bne.s   loc_1F10E
		lsr.w   #4,d7
		andi.w  #3,d7
		beq.s   loc_1F11E
		lsl.w   #3,d7
		lea     loc_1F120(pc,d7.w),a1
		add.w   (a1)+,d1
		move.w  (a1)+,d2
		move.w  (a1)+,d3
		add.w   (a1),d4
		rts
loc_1F10E:
		subq.b  #1,d0
		bne.s   loc_1F11E
		andi.w  #3,d7
		add.w   d7,d7
		move.w  word_1F140(pc,d7.w),d0
		add.w   d0,(a1)
loc_1F11E:
		moveq   #1,d1
loc_1F120:
		move.w  d1,d2
		move.w  d1,d3
		move.w  d1,d4
		rts

	; End of function sub_1F0B0

		dc.b $FF
		dc.b $F8 
		dc.b   0
		dc.b   0
		dc.b $C7 
		dc.b $B0 
		dc.b $FF
		dc.b $FC 
		dc.b $FF
		dc.b $F0 
		dc.b   5
		dc.b   0
		dc.b $C7 
		dc.b $B1 
		dc.b $FF
		dc.b $FC 
		dc.b $FF
		dc.b $E8 
		dc.b   6
		dc.b   0
		dc.b $C7 
		dc.b $B5 
		dc.b $FF
		dc.b $FC 
word_1F140:     dc.w 1
		dc.b $FF
		dc.b $FF
		dc.b 0
		dc.b 1
		dc.b $FF
		dc.b $FF

; =============== S U B R O U T I N E =======================================

sub_1F148:
		cmpi.w  #$FFFF,((BATTLESCENE_ENEMY-$1000000)).w
		beq.s   return_1F174
		move.w  ((word_FFB3F6-$1000000)).w,d6
		beq.s   loc_1F162
		add.w   ((word_FFB3EC-$1000000)).w,d6
		bsr.w   sub_1F214
		clr.w   ((word_FFB3F6-$1000000)).w
loc_1F162:
		move.w  ((word_FFB3F8-$1000000)).w,d6
		beq.s   return_1F174
		add.w   ((word_FFB3F0-$1000000)).w,d6
		bsr.w   sub_1F254
		clr.w   ((word_FFB3F8-$1000000)).w
return_1F174:
		rts

	; End of function sub_1F148


; =============== S U B R O U T I N E =======================================

sub_1F176:
		cmpi.w  #$FFFF,((BATTLESCENE_CHARACTER-$1000000)).w
		beq.w   return_1F1CA
		move.w  ((word_FFB3FA-$1000000)).w,d0
		move.w  d0,d2
		move.w  ((word_FFB3FC-$1000000)).w,d1
		or.w    d1,d2
		beq.w   return_1F1CA
		add.w   d0,((word_FFB3F2-$1000000)).w
		add.w   d1,((word_FFB3F4-$1000000)).w
		lea     ((dword_FFDC88-$1000000)).w,a0
		moveq   #8,d2
loc_1F19E:
		add.w   d1,(a0)
		addq.w  #6,a0
		add.w   d0,(a0)+
		dbf     d2,loc_1F19E
		cmpi.w  #$FFFF,((CHARACTER_WEAPON_SPRITE-$1000000)).w
		beq.s   loc_1F1C2
		lea     ((byte_FFDCD0-$1000000)).w,a0
		moveq   #3,d2
loc_1F1B6:
		add.w   d0,6(a0)
		add.w   d1,(a0)
		addq.w  #8,a0
		dbf     d2,loc_1F1B6
loc_1F1C2:
		clr.w   ((word_FFB3FA-$1000000)).w
		clr.w   ((word_FFB3FC-$1000000)).w
return_1F1CA:
		rts

	; End of function sub_1F176


; =============== S U B R O U T I N E =======================================

sub_1F1CC:
		movem.l d0/a0,-(sp)
		move.w  d6,((word_FFB3EA-$1000000)).w
		lea     ((byte_FFD1C0-$1000000)).w,a0
		moveq   #$67,d0 
loc_1F1DA:
		move.w  d6,(a0)
		addq.w  #4,a0
		dbf     d0,loc_1F1DA
		jsr     (StoreVdpCommands).w
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,d0/a0
		rts

	; End of function sub_1F1CC


; =============== S U B R O U T I N E =======================================

sub_1F1F0:
		movem.l d0/a0,-(sp)
		move.w  d6,((word_FFB3EE-$1000000)).w
		lea     ((dword_FFD500-$1000000)).w,a0
		moveq   #$13,d0
loc_1F1FE:
		move.w  d6,(a0)
		addq.w  #4,a0
		dbf     d0,loc_1F1FE
		jsr     (StoreVdpCommandsbis).w
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,d0/a0
		rts

	; End of function sub_1F1F0


; =============== S U B R O U T I N E =======================================

sub_1F214:
		movem.l d0/a0,-(sp)
		move.w  d6,((word_FFB3EC-$1000000)).w
		cmpi.w  #$35,((ENEMY_BATTLE_SPRITE-$1000000)).w 
		bne.s   loc_1F236
		btst    #2,((byte_FFB56F-$1000000)).w
		bne.s   loc_1F232
		subi.w  #$10,d6
		bra.s   loc_1F236
loc_1F232:
		addi.w  #$10,d6
loc_1F236:
		lea     ((dword_FFD100+2-$1000000)).w,a0
		move.w  #$FF,d0
loc_1F23E:
		move.w  d6,(a0)
		addq.w  #4,a0
		dbf     d0,loc_1F23E
		jsr     (StoreVdpCommands).w
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,d0/a0
		rts

	; End of function sub_1F214


; =============== S U B R O U T I N E =======================================

sub_1F254:
		movem.l d0/a0,-(sp)
		move.w  d6,((word_FFB3F0-$1000000)).w
		cmpi.w  #$35,((ENEMY_BATTLE_SPRITE-$1000000)).w 
		bne.s   loc_1F266
		subq.w  #8,d6
loc_1F266:
		lea     ((dword_FFD500+2-$1000000)).w,a0
		moveq   #$13,d0
loc_1F26C:
		move.w  d6,(a0)
		addq.w  #4,a0
		dbf     d0,loc_1F26C
		jsr     (StoreVdpCommandsbis).w
		jsr     (Set_FFDE94_bit3).w
		movem.l (sp)+,d0/a0
		rts

	; End of function sub_1F254


; =============== S U B R O U T I N E =======================================

sub_1F282:
		btst    #0,((byte_FFB3CD-$1000000)).w
		bne.s   loc_1F2AE
		btst    #0,((byte_FFB583-$1000000)).w
		beq.s   return_1F2F4
		btst    #2,((byte_FFB583-$1000000)).w
		beq.s   return_1F2F4
		tst.w   ((word_FFB3C4-$1000000)).w
		beq.s   return_1F2F4
		lea     ((dword_FFD100-$1000000)).w,a3
		lea     ((dword_FFD500-$1000000)).w,a4
		lea     ((dword_FFB3C0-$1000000)).w,a5
		bra.s   loc_1F2D0
loc_1F2AE:
		btst    #1,((byte_FFB583-$1000000)).w
		beq.s   return_1F2F4
		btst    #3,((byte_FFB583-$1000000)).w
		beq.s   return_1F2F4
		tst.w   ((word_FFB3CA-$1000000)).w
		beq.s   return_1F2F4
		lea     ((dword_FFD100+2-$1000000)).w,a3
		lea     ((dword_FFD500+2-$1000000)).w,a4
		lea     ((dword_FFB3C6-$1000000)).w,a5
loc_1F2D0:
		addq.w  #1,4(a5)
		movea.l (a5),a0
		move.b  (a0),d0
		beq.w   loc_1F338
		subq.b  #1,d0
		beq.w   loc_1F384
		subq.b  #1,d0
		beq.w   loc_1F3DC
		subq.b  #1,d0
		beq.w   loc_1F3E0
		subq.b  #1,d0
		beq.w   loc_1F4D2
return_1F2F4:
		rts

	; End of function sub_1F282


; =============== S U B R O U T I N E =======================================

sub_1F2F6:
		tst.b   ((byte_FFB583-$1000000)).w
		beq.s   return_1F336
		clr.b   ((byte_FFB583-$1000000)).w
		clr.b   ((byte_FFB56B-$1000000)).w
		clr.w   ((word_FFB3C4-$1000000)).w
		clr.w   ((word_FFB3CA-$1000000)).w
		clr.l   ((dword_FFB3C0-$1000000)).w
		clr.l   ((dword_FFB3C6-$1000000)).w
		clr.w   d6
		bsr.w   sub_1F1CC
		bsr.w   sub_1F1F0
		btst    #2,((byte_FFB56F-$1000000)).w
		beq.s   loc_1F32A
		moveq   #$60,d6 
		bra.s   loc_1F32C
loc_1F32A:
		clr.w   d6
loc_1F32C:
		bsr.w   sub_1F214
		clr.w   d6
		bsr.w   sub_1F254
return_1F336:
		rts

	; End of function sub_1F2F6


; START OF FUNCTION CHUNK FOR sub_1F282

loc_1F338:
		move.w  4(a5),d0
		movea.l (a5),a5
		clr.w   d3
		move.b  1(a5),d3
		lsl.w   #2,d3
		lea     (a3,d3.w),a0
		movea.l 4(a5),a1
		lea     (a1),a2
		clr.w   d2
		move.b  2(a5),d2
		subq.w  #1,d2
		and.w   d2,d0
		move.w  d0,d1
		add.w   d0,d0
		adda.w  d0,a1
		clr.w   d0
		move.b  3(a5),d0
		subq.w  #1,d0
loc_1F368:
		move.w  (a1)+,d3
		add.w   d3,(a0)
		addq.w  #4,a0
		addq.w  #1,d1
		cmp.w   d2,d1
		bls.s   loc_1F378
		clr.w   d1
		lea     (a2),a1
loc_1F378:
		dbf     d0,loc_1F368
		jsr     (StoreVdpCommands).w
		jmp     (Set_FFDE94_bit3).w
loc_1F384:
		move.w  4(a5),d0
		cmpi.w  #$10,d0
		bcc.s   loc_1F3C8
		move.b  byte_1F3CC(pc,d0.w),d0
		movea.l (a5),a2
		clr.w   d3
		move.b  1(a2),d3
		lsl.w   #2,d3
		lea     (a3,d3.w),a0
		clr.w   d1
		move.b  2(a2),d1
		subq.w  #1,d1
		clr.w   d2
		move.b  3(a2),d2
		move.w  d2,d3
loc_1F3B0:
		add.w   d0,(a0)
		subq.w  #1,d3
		bne.s   loc_1F3BA
		neg.w   d0
		move.w  d2,d3
loc_1F3BA:
		addq.w  #4,a0
		dbf     d1,loc_1F3B0
		jsr     (StoreVdpCommands).w
		jmp     (Set_FFDE94_bit3).w
loc_1F3C8:
		clr.w   4(a5)

; END OF FUNCTION CHUNK FOR sub_1F282

byte_1F3CC:     dc.b $4E
		dc.b $75 
		dc.b 4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   0

; START OF FUNCTION CHUNK FOR sub_1F282

loc_1F3DC:
		clr.w   d7
		bra.s   loc_1F3E2
loc_1F3E0:
		moveq   #1,d7
loc_1F3E2:
		btst    #6,4(a5)
		bne.s   loc_1F422
		move.w  #4,d0
		move.w  #8,d1
		bsr.w   sub_1F45E
		move.w  #$FFE0,d0
		move.w  #$FFC0,d1
		tst.w   d7
		beq.s   loc_1F406
		neg.w   d0
		neg.w   d1
loc_1F406:
		bsr.w   sub_1F496
		move.w  4(a5),d0
		movea.l (a5),a0
		clr.w   d1
		move.b  1(a0),d1
		cmp.w   d1,d0
		bls.s   return_1F420
		move.w  #$4001,4(a5)
return_1F420:
		rts
loc_1F422:
		move.w  #$FFFC,d0
		move.w  #$FFF8,d1
		bsr.w   sub_1F45E
		move.w  #$20,d0 
		move.w  #$40,d1 
		tst.w   d7
		beq.s   loc_1F43E
		neg.w   d0
		neg.w   d1
loc_1F43E:
		bsr.w   sub_1F496
		move.w  4(a5),d0
		bclr    #$E,d0
		movea.l (a5),a0
		clr.w   d1
		move.b  1(a0),d1
		cmp.w   d1,d0
		bls.s   return_1F45C
		move.w  #1,4(a5)
return_1F45C:
		rts

; END OF FUNCTION CHUNK FOR sub_1F282


; =============== S U B R O U T I N E =======================================

sub_1F45E:
		lea     $17C(a3),a0
		lea     $180(a3),a1
		lea     (FF8804_LOADING_SPACE).l,a2
		asr.w   #1,d1
		moveq   #$3F,d2 
loc_1F470:
		move.w  d1,d3
		add.w   (a2),d3
		move.w  d3,(a2)+
		asr.w   #8,d3
		move.w  d3,d4
		add.w   ((word_FFB3EC-$1000000)).w,d4
		move.w  d4,(a0)
		neg.w   d3
		add.w   ((word_FFB3EC-$1000000)).w,d3
		move.w  d3,(a1)
		subq.w  #4,a0
		addq.w  #4,a1
		add.w   d0,d1
		dbf     d2,loc_1F470
		jmp     (StoreVdpCommands).w

	; End of function sub_1F45E


; =============== S U B R O U T I N E =======================================

sub_1F496:
		lea     $10(a4),a0
		lea     $14(a4),a1
		lea     (byte_FF8904).l,a2
		asr.w   #1,d1
		moveq   #4,d2
loc_1F4A8:
		move.w  d1,d3
		add.w   (a2),d3
		move.w  d3,(a2)+
		asr.w   #8,d3
		move.w  d3,d4
		add.w   ((word_FFB3F0-$1000000)).w,d4
		move.w  d4,(a1)
		neg.w   d3
		add.w   ((word_FFB3F0-$1000000)).w,d3
		move.w  d3,(a0)
		subq.w  #4,a0
		addq.w  #4,a1
		add.w   d0,d1
		dbf     d2,loc_1F4A8
		jsr     (StoreVdpCommandsbis).w
		jmp     (Set_FFDE94_bit3).w

	; End of function sub_1F496


; START OF FUNCTION CHUNK FOR sub_1F282

loc_1F4D2:
		move.w  4(a5),d0
		movea.l (a5),a0
		clr.w   d1
		move.b  1(a0),d1
		lea     byte_1F530(pc), a0
		move.w  d0,d2
		andi.w  #$F,d2
		move.b  (a0,d2.w),d2
		ext.w   d2
		beq.s   loc_1F502
		muls.w  d1,d2
		move.w  #$FF,d3
loc_1F4F6:
		add.w   d2,(a3)
		addq.w  #4,a3
		dbf     d3,loc_1F4F6
		jsr     (StoreVdpCommands).w
loc_1F502:
		lea     byte_1F528(pc), a0
		move.w  d0,d2
		andi.w  #7,d2
		move.b  (a0,d2.w),d2
		ext.w   d2
		beq.s   loc_1F524
		muls.w  d1,d2
		moveq   #$13,d3
loc_1F518:
		add.w   d2,(a4)
		addq.w  #4,a4
		dbf     d3,loc_1F518
		jsr     (StoreVdpCommandsbis).w
loc_1F524:
		jmp     (Set_FFDE94_bit3).w

; END OF FUNCTION CHUNK FOR sub_1F282

byte_1F528:     dc.b 0
		dc.b   2
		dc.b $FF
		dc.b   0
		dc.b   0
		dc.b $FE 
		dc.b   1
		dc.b   0
byte_1F530:     dc.b $FF
		dc.b   2
		dc.b $FD 
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b   2
		dc.b   0
		dc.b   1
		dc.b $FE 
		dc.b   3
		dc.b   0
		dc.b $FF
		dc.b   0
		dc.b $FE 
		dc.b   0

; =============== S U B R O U T I N E =======================================

sub_1F540:
		tst.b   ((byte_FFB56B-$1000000)).w
		beq.s   return_1F574
		movem.l d0/a0,-(sp)
		move.w  #1,((word_FFB3C4-$1000000)).w
		lea     (FF8804_LOADING_SPACE).l,a0
		move.w  #$3FF,d0
loc_1F55A:
		clr.l   (a0)+
		dbf     d0,loc_1F55A
		movea.l ((dword_FFB3C6-$1000000)).w,a0
		clr.w   d0
		move.b  1(a0),d0
		lsr.w   #1,d0
		move.w  d0,((word_FFB3CA-$1000000)).w
		movem.l (sp)+,d0/a0
return_1F574:
		rts

	; End of function sub_1F540

byte_1F576:     dc.b 0
		dc.b $C0 
		dc.b  $F
		dc.b   0
byte_1F57A:     dc.b $81
		dc.b   0
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $10
		dc.b   1
		dc.b   8
		dc.b   1
		dc.b   0
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $20
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $30 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $40 
		dc.b   1
		dc.b $28 
		dc.b   1
		dc.b   0
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $50 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $60 
		dc.b   1
		dc.b $48 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $70 
		dc.b   1
		dc.b $48 
		dc.b   1
		dc.b   0
		dc.b  $F
		dc.b   0
		dc.b $81 
		dc.b $80 
		dc.b   1
		dc.b $48 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b   0
		dc.b   1
		dc.b $48 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $10
		dc.b   1
		dc.b $48 
		dc.b   1
		dc.b   0
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $20
		dc.b   1
		dc.b $48 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $30 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $40 
		dc.b   1
		dc.b $28 
		dc.b   1
		dc.b   0
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $50 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $60 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $70 
		dc.b   1
		dc.b   8
		dc.b   1
		dc.b   0
		dc.b  $F
		dc.b   0
		dc.b $89 
		dc.b $80 
		dc.b   1
		dc.b   8
byte_1F606:     dc.b 0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $86 
		dc.b $C0 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $86 
		dc.b $D0 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $86 
		dc.b $E0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $86 
		dc.b $F0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $8E 
		dc.b $C0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $8E 
		dc.b $D0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $8E 
		dc.b $E0 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $8E 
		dc.b $F0 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $96 
		dc.b $C0 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $96 
		dc.b $D0 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $96 
		dc.b $E0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $96 
		dc.b $F0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $9E 
		dc.b $C0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $9E 
		dc.b $D0 
		dc.b   1
		dc.b $28 
		dc.b   0
		dc.b $E0 
		dc.b  $F
		dc.b   0
		dc.b $9E 
		dc.b $E0 
		dc.b   1
		dc.b   8
		dc.b   0
		dc.b $C0 
		dc.b  $F
		dc.b   0
		dc.b $9E 
		dc.b $F0 
		dc.b   1
		dc.b   8
byte_1F686:     dc.b 1
		dc.b  $C
		dc.b  $F
		dc.b   0
		dc.b $47 
		dc.b $80 
		dc.b   1
		dc.b   8
		dc.b   1
		dc.b  $C
		dc.b  $F
		dc.b   0
		dc.b $47 
		dc.b $90 
		dc.b   1
		dc.b $28 
		dc.b   1
		dc.b  $C
		dc.b  $F
		dc.b   0
		dc.b $47 
		dc.b $A0 
		dc.b   1
		dc.b $48 
		dc.b   1
		dc.b  $C
		dc.b  $F
		dc.b   0
		dc.b $4F 
		dc.b $80 
		dc.b   1
		dc.b $48 
		dc.b   1
		dc.b  $C
		dc.b  $F
		dc.b   0
		dc.b $4F 
		dc.b $90 
		dc.b   1
		dc.b $28 
		dc.b   1
		dc.b  $C
		dc.b  $F
		dc.b   0
		dc.b $4F 
		dc.b $A0 
		dc.b   1
		dc.b   8
byte_1F6B6:     dc.b 0
		dc.b   4
		dc.b   8
		dc.b  $C
		dc.b $30 
		dc.b $34 
		dc.b $38 
		dc.b $3C 
		dc.b $60 
		dc.b $64 
		dc.b $68 
		dc.b $6C 
		dc.b $90 
		dc.b $94 
		dc.b $98 
		dc.b $9C 
		dc.b   1
		dc.b   5
		dc.b   9
		dc.b  $D
		dc.b $31 
		dc.b $35 
		dc.b $39 
		dc.b $3D 
		dc.b $61 
		dc.b $65 
		dc.b $69 
		dc.b $6D 
		dc.b $91 
		dc.b $95 
		dc.b $99 
		dc.b $9D 
		dc.b   2
		dc.b   6
		dc.b  $A
		dc.b  $E
		dc.b $32 
		dc.b $36 
		dc.b $3A 
		dc.b $3E 
		dc.b $62 
		dc.b $66 
		dc.b $6A 
		dc.b $6E 
		dc.b $92 
		dc.b $96 
		dc.b $9A 
		dc.b $9E 
		dc.b   3
		dc.b   7
		dc.b  $B
		dc.b  $F
		dc.b $33 
		dc.b $37 
		dc.b $3B 
		dc.b $3F 
		dc.b $63 
		dc.b $67 
		dc.b $6B 
		dc.b $6F 
		dc.b $93 
		dc.b $97 
		dc.b $9B 
		dc.b $9F 
		dc.b $10
		dc.b $14
		dc.b $18
		dc.b $1C
		dc.b $40 
		dc.b $44 
		dc.b $48 
		dc.b $4C 
		dc.b $70 
		dc.b $74 
		dc.b $78 
		dc.b $7C 
		dc.b $A0 
		dc.b $A4 
		dc.b $A8 
		dc.b $AC 
		dc.b $11
		dc.b $15
		dc.b $19
		dc.b $1D
		dc.b $41 
		dc.b $45 
		dc.b $49 
		dc.b $4D 
		dc.b $71 
		dc.b $75 
		dc.b $79 
		dc.b $7D 
		dc.b $A1 
		dc.b $A5 
		dc.b $A9 
		dc.b $AD 
		dc.b $12
		dc.b $16
		dc.b $1A
		dc.b $1E
		dc.b $42 
		dc.b $46 
		dc.b $4A 
		dc.b $4E 
		dc.b $72 
		dc.b $76 
		dc.b $7A 
		dc.b $7E 
		dc.b $A2 
		dc.b $A6 
		dc.b $AA 
		dc.b $AE 
		dc.b $13
		dc.b $17
		dc.b $1B
		dc.b $1F
		dc.b $43 
		dc.b $47 
		dc.b $4B 
		dc.b $4F 
		dc.b $73 
		dc.b $77 
		dc.b $7B 
		dc.b $7F 
		dc.b $A3 
		dc.b $A7 
		dc.b $AB 
		dc.b $AF 
		dc.b $20
		dc.b $24 
		dc.b $28 
		dc.b $2C 
		dc.b $50 
		dc.b $54 
		dc.b $58 
		dc.b $5C 
		dc.b $80 
		dc.b $84 
		dc.b $88 
		dc.b $8C 
		dc.b $B0 
		dc.b $B4 
		dc.b $B8 
		dc.b $BC 
		dc.b $21 
		dc.b $25 
		dc.b $29 
		dc.b $2D 
		dc.b $51 
		dc.b $55 
		dc.b $59 
		dc.b $5D 
		dc.b $81 
		dc.b $85 
		dc.b $89 
		dc.b $8D 
		dc.b $B1 
		dc.b $B5 
		dc.b $B9 
		dc.b $BD 
		dc.b $22 
		dc.b $26 
		dc.b $2A 
		dc.b $2E 
		dc.b $52 
		dc.b $56 
		dc.b $5A 
		dc.b $5E 
		dc.b $82 
		dc.b $86 
		dc.b $8A 
		dc.b $8E 
		dc.b $B2 
		dc.b $B6 
		dc.b $BA 
		dc.b $BE 
		dc.b $23 
		dc.b $27 
		dc.b $2B 
		dc.b $2F 
		dc.b $53 
		dc.b $57 
		dc.b $5B 
		dc.b $5F 
		dc.b $83 
		dc.b $87 
		dc.b $8B 
		dc.b $8F 
		dc.b $B3 
		dc.b $B7 
		dc.b $BB 
		dc.b $BF 
byte_1F776:     dc.b $81
		dc.b   0
		dc.b $81 
		dc.b $10
		dc.b $81 
		dc.b $20
		dc.b $81 
		dc.b $30 
		dc.b $81 
		dc.b $40 
		dc.b $81 
		dc.b $50 
		dc.b $81 
		dc.b $60 
		dc.b $81 
		dc.b $70 
		dc.b $81 
		dc.b $80 
		dc.b $81 
		dc.b $90 
		dc.b $81 
		dc.b $A0 
		dc.b $81 
		dc.b $B0 
		dc.b $81 
		dc.b $C0 
		dc.b $81 
		dc.b $D0 
		dc.b $81 
		dc.b $E0 
		dc.b $81 
		dc.b $F0 
		dc.b $82 
		dc.b   0
		dc.b $82 
		dc.b $10
		dc.b $85 
		dc.b $20
		dc.b $85 
		dc.b $30 
		dc.b $85 
		dc.b $40 
		dc.b $85 
		dc.b $50 
		dc.b $85 
		dc.b $60 
		dc.b $85 
		dc.b $70 
		dc.b $85 
		dc.b $80 
		dc.b $85 
		dc.b $90 
		dc.b $85 
		dc.b $A0 
		dc.b $85 
		dc.b $B0 
		dc.b $85 
		dc.b $C0 
		dc.b $85 
		dc.b $D0 
		dc.b $85 
		dc.b $E0 
		dc.b $85 
		dc.b $F0 
		dc.b $86 
		dc.b $C0 
		dc.b $86 
		dc.b $D0 
		dc.b $86 
		dc.b $E0 
		dc.b $86 
		dc.b $F0 
byte_1F7BE:     dc.b $81
		dc.b   0
		dc.b $81 
		dc.b $10
		dc.b $81 
		dc.b $90 
		dc.b $81 
		dc.b $A0 
		dc.b $81 
		dc.b $20
		dc.b $81 
		dc.b $30 
		dc.b $81 
		dc.b $B0 
		dc.b $81 
		dc.b $C0 
		dc.b $81 
		dc.b $40 
		dc.b $81 
		dc.b $50 
		dc.b $81 
		dc.b $D0 
		dc.b $81 
		dc.b $E0 
		dc.b $81 
		dc.b $60 
		dc.b $81 
		dc.b $70 
		dc.b $81 
		dc.b $F0 
		dc.b $82 
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $85 
		dc.b $20
		dc.b $85 
		dc.b $30 
		dc.b $85 
		dc.b $B0 
		dc.b $85 
		dc.b $C0 
		dc.b $85 
		dc.b $40 
		dc.b $85 
		dc.b $50 
		dc.b $85 
		dc.b $D0 
		dc.b $85 
		dc.b $E0 
		dc.b $85 
		dc.b $60 
		dc.b $85 
		dc.b $70 
		dc.b $85 
		dc.b $F0 
		dc.b $86 
		dc.b $C0 
		dc.b $85 
		dc.b $80 
		dc.b $85 
		dc.b $90 
		dc.b $86 
		dc.b $D0 
		dc.b $86 
		dc.b $E0 
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
AllyBattleSprites:
		incbin "data/stats/allies/allybattlesprites.bin"
EnemyBattleSprites:
		incbin "data/stats/enemies/enemybattlesprites.bin"
WeaponBattleSprites:
		incbin "data/stats/items/weaponsprites.bin"
CustomBackgrounds:
		incbin "data/battles/global/custombackgrounds.bin"
byte_1FAB8:     dc.b 0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b   0
AllyBSpriteIdleAnimate:
		incbin "data/stats/allies/allyidlesprites.bin"
						; list of ally battle sprite indeces who do not animate while idle
EnemyBSpriteIdleAnimate:
		incbin "data/stats/enemies/enemyidlesprites.bin"
						; list of enemy battle sprite indeces who do not animate while idle
SomePlaneALayout:
		dc.b $63
		dc.b $A0 
		dc.b $63 
		dc.b $A4 
		dc.b $63 
		dc.b $A8 
		dc.b $63 
		dc.b $AC 
		dc.b $63 
		dc.b $D0 
		dc.b $63 
		dc.b $D4 
		dc.b $63 
		dc.b $D8 
		dc.b $63 
		dc.b $DC 
		dc.b $64 
		dc.b   0
		dc.b $64 
		dc.b   4
		dc.b $64 
		dc.b   8
		dc.b $64 
		dc.b  $C
		dc.b $64 
		dc.b $30 
		dc.b $64 
		dc.b $34 
		dc.b $64 
		dc.b $38 
		dc.b $64 
		dc.b $3C 
		dc.b $64 
		dc.b $60 
		dc.b $64 
		dc.b $64 
		dc.b $64 
		dc.b $68 
		dc.b $64 
		dc.b $6C 
		dc.b $64 
		dc.b $90 
		dc.b $64 
		dc.b $94 
		dc.b $64 
		dc.b $98 
		dc.b $64 
		dc.b $9C 
		dc.b $64 
		dc.b $C0 
		dc.b $64 
		dc.b $C4 
		dc.b $64 
		dc.b $C8 
		dc.b $64 
		dc.b $CC 
		dc.b $64 
		dc.b $F0 
		dc.b $64 
		dc.b $F4 
		dc.b $64 
		dc.b $F8 
		dc.b $64 
		dc.b $FC 
		dc.b $63 
		dc.b $A1 
		dc.b $63 
		dc.b $A5 
		dc.b $63 
		dc.b $A9 
		dc.b $63 
		dc.b $AD 
		dc.b $63 
		dc.b $D1 
		dc.b $63 
		dc.b $D5 
		dc.b $63 
		dc.b $D9 
		dc.b $63 
		dc.b $DD 
		dc.b $64 
		dc.b   1
		dc.b $64 
		dc.b   5
		dc.b $64 
		dc.b   9
		dc.b $64 
		dc.b  $D
		dc.b $64 
		dc.b $31 
		dc.b $64 
		dc.b $35 
		dc.b $64 
		dc.b $39 
		dc.b $64 
		dc.b $3D 
		dc.b $64 
		dc.b $61 
		dc.b $64 
		dc.b $65 
		dc.b $64 
		dc.b $69 
		dc.b $64 
		dc.b $6D 
		dc.b $64 
		dc.b $91 
		dc.b $64 
		dc.b $95 
		dc.b $64 
		dc.b $99 
		dc.b $64 
		dc.b $9D 
		dc.b $64 
		dc.b $C1 
		dc.b $64 
		dc.b $C5 
		dc.b $64 
		dc.b $C9 
		dc.b $64 
		dc.b $CD 
		dc.b $64 
		dc.b $F1 
		dc.b $64 
		dc.b $F5 
		dc.b $64 
		dc.b $F9 
		dc.b $64 
		dc.b $FD 
		dc.b $63 
		dc.b $A2 
		dc.b $63 
		dc.b $A6 
		dc.b $63 
		dc.b $AA 
		dc.b $63 
		dc.b $AE 
		dc.b $63 
		dc.b $D2 
		dc.b $63 
		dc.b $D6 
		dc.b $63 
		dc.b $DA 
		dc.b $63 
		dc.b $DE 
		dc.b $64 
		dc.b   2
		dc.b $64 
		dc.b   6
		dc.b $64 
		dc.b  $A
		dc.b $64 
		dc.b  $E
		dc.b $64 
		dc.b $32 
		dc.b $64 
		dc.b $36 
		dc.b $64 
		dc.b $3A 
		dc.b $64 
		dc.b $3E 
		dc.b $64 
		dc.b $62 
		dc.b $64 
		dc.b $66 
		dc.b $64 
		dc.b $6A 
		dc.b $64 
		dc.b $6E 
		dc.b $64 
		dc.b $92 
		dc.b $64 
		dc.b $96 
		dc.b $64 
		dc.b $9A 
		dc.b $64 
		dc.b $9E 
		dc.b $64 
		dc.b $C2 
		dc.b $64 
		dc.b $C6 
		dc.b $64 
		dc.b $CA 
		dc.b $64 
		dc.b $CE 
		dc.b $64 
		dc.b $F2 
		dc.b $64 
		dc.b $F6 
		dc.b $64 
		dc.b $FA 
		dc.b $64 
		dc.b $FE 
		dc.b $63 
		dc.b $A3 
		dc.b $63 
		dc.b $A7 
		dc.b $63 
		dc.b $AB 
		dc.b $63 
		dc.b $AF 
		dc.b $63 
		dc.b $D3 
		dc.b $63 
		dc.b $D7 
		dc.b $63 
		dc.b $DB 
		dc.b $63 
		dc.b $DF 
		dc.b $64 
		dc.b   3
		dc.b $64 
		dc.b   7
		dc.b $64 
		dc.b  $B
		dc.b $64 
		dc.b  $F
		dc.b $64 
		dc.b $33 
		dc.b $64 
		dc.b $37 
		dc.b $64 
		dc.b $3B 
		dc.b $64 
		dc.b $3F 
		dc.b $64 
		dc.b $63 
		dc.b $64 
		dc.b $67 
		dc.b $64 
		dc.b $6B 
		dc.b $64 
		dc.b $6F 
		dc.b $64 
		dc.b $93 
		dc.b $64 
		dc.b $97 
		dc.b $64 
		dc.b $9B 
		dc.b $64 
		dc.b $9F 
		dc.b $64 
		dc.b $C3 
		dc.b $64 
		dc.b $C7 
		dc.b $64 
		dc.b $CB 
		dc.b $64 
		dc.b $CF 
		dc.b $64 
		dc.b $F3 
		dc.b $64 
		dc.b $F7 
		dc.b $64 
		dc.b $FB 
		dc.b $64 
		dc.b $FF
		dc.b $63 
		dc.b $B0 
		dc.b $63 
		dc.b $B4 
		dc.b $63 
		dc.b $B8 
		dc.b $63 
		dc.b $BC 
		dc.b $63 
		dc.b $E0 
		dc.b $63 
		dc.b $E4 
		dc.b $63 
		dc.b $E8 
		dc.b $63 
		dc.b $EC 
		dc.b $64 
		dc.b $10
		dc.b $64 
		dc.b $14
		dc.b $64 
		dc.b $18
		dc.b $64 
		dc.b $1C
		dc.b $64 
		dc.b $40 
		dc.b $64 
		dc.b $44 
		dc.b $64 
		dc.b $48 
		dc.b $64 
		dc.b $4C 
		dc.b $64 
		dc.b $70 
		dc.b $64 
		dc.b $74 
		dc.b $64 
		dc.b $78 
		dc.b $64 
		dc.b $7C 
		dc.b $64 
		dc.b $A0 
		dc.b $64 
		dc.b $A4 
		dc.b $64 
		dc.b $A8 
		dc.b $64 
		dc.b $AC 
		dc.b $64 
		dc.b $D0 
		dc.b $64 
		dc.b $D4 
		dc.b $64 
		dc.b $D8 
		dc.b $64 
		dc.b $DC 
		dc.b $65 
		dc.b   0
		dc.b $65 
		dc.b   4
		dc.b $65 
		dc.b   8
		dc.b $65 
		dc.b  $C
		dc.b $63 
		dc.b $B1 
		dc.b $63 
		dc.b $B5 
		dc.b $63 
		dc.b $B9 
		dc.b $63 
		dc.b $BD 
		dc.b $63 
		dc.b $E1 
		dc.b $63 
		dc.b $E5 
		dc.b $63 
		dc.b $E9 
		dc.b $63 
		dc.b $ED 
		dc.b $64 
		dc.b $11
		dc.b $64 
		dc.b $15
		dc.b $64 
		dc.b $19
		dc.b $64 
		dc.b $1D
		dc.b $64 
		dc.b $41 
		dc.b $64 
		dc.b $45 
		dc.b $64 
		dc.b $49 
		dc.b $64 
		dc.b $4D 
		dc.b $64 
		dc.b $71 
		dc.b $64 
		dc.b $75 
		dc.b $64 
		dc.b $79 
		dc.b $64 
		dc.b $7D 
		dc.b $64 
		dc.b $A1 
		dc.b $64 
		dc.b $A5 
		dc.b $64 
		dc.b $A9 
		dc.b $64 
		dc.b $AD 
		dc.b $64 
		dc.b $D1 
		dc.b $64 
		dc.b $D5 
		dc.b $64 
		dc.b $D9 
		dc.b $64 
		dc.b $DD 
		dc.b $65 
		dc.b   1
		dc.b $65 
		dc.b   5
		dc.b $65 
		dc.b   9
		dc.b $65 
		dc.b  $D
		dc.b $63 
		dc.b $B2 
		dc.b $63 
		dc.b $B6 
		dc.b $63 
		dc.b $BA 
		dc.b $63 
		dc.b $BE 
		dc.b $63 
		dc.b $E2 
		dc.b $63 
		dc.b $E6 
		dc.b $63 
		dc.b $EA 
		dc.b $63 
		dc.b $EE 
		dc.b $64 
		dc.b $12
		dc.b $64 
		dc.b $16
		dc.b $64 
		dc.b $1A
		dc.b $64 
		dc.b $1E
		dc.b $64 
		dc.b $42 
		dc.b $64 
		dc.b $46 
		dc.b $64 
		dc.b $4A 
		dc.b $64 
		dc.b $4E 
		dc.b $64 
		dc.b $72 
		dc.b $64 
		dc.b $76 
		dc.b $64 
		dc.b $7A 
		dc.b $64 
		dc.b $7E 
		dc.b $64 
		dc.b $A2 
		dc.b $64 
		dc.b $A6 
		dc.b $64 
		dc.b $AA 
		dc.b $64 
		dc.b $AE 
		dc.b $64 
		dc.b $D2 
		dc.b $64 
		dc.b $D6 
		dc.b $64 
		dc.b $DA 
		dc.b $64 
		dc.b $DE 
		dc.b $65 
		dc.b   2
		dc.b $65 
		dc.b   6
		dc.b $65 
		dc.b  $A
		dc.b $65 
		dc.b  $E
		dc.b $63 
		dc.b $B3 
		dc.b $63 
		dc.b $B7 
		dc.b $63 
		dc.b $BB 
		dc.b $63 
		dc.b $BF 
		dc.b $63 
		dc.b $E3 
		dc.b $63 
		dc.b $E7 
		dc.b $63 
		dc.b $EB 
		dc.b $63 
		dc.b $EF 
		dc.b $64 
		dc.b $13
		dc.b $64 
		dc.b $17
		dc.b $64 
		dc.b $1B
		dc.b $64 
		dc.b $1F
		dc.b $64 
		dc.b $43 
		dc.b $64 
		dc.b $47 
		dc.b $64 
		dc.b $4B 
		dc.b $64 
		dc.b $4F 
		dc.b $64 
		dc.b $73 
		dc.b $64 
		dc.b $77 
		dc.b $64 
		dc.b $7B 
		dc.b $64 
		dc.b $7F 
		dc.b $64 
		dc.b $A3 
		dc.b $64 
		dc.b $A7 
		dc.b $64 
		dc.b $AB 
		dc.b $64 
		dc.b $AF 
		dc.b $64 
		dc.b $D3 
		dc.b $64 
		dc.b $D7 
		dc.b $64 
		dc.b $DB 
		dc.b $64 
		dc.b $DF 
		dc.b $65 
		dc.b   3
		dc.b $65 
		dc.b   7
		dc.b $65 
		dc.b  $B
		dc.b $65 
		dc.b  $F
		dc.b $63 
		dc.b $C0 
		dc.b $63 
		dc.b $C4 
		dc.b $63 
		dc.b $C8 
		dc.b $63 
		dc.b $CC 
		dc.b $63 
		dc.b $F0 
		dc.b $63 
		dc.b $F4 
		dc.b $63 
		dc.b $F8 
		dc.b $63 
		dc.b $FC 
		dc.b $64 
		dc.b $20
		dc.b $64 
		dc.b $24 
		dc.b $64 
		dc.b $28 
		dc.b $64 
		dc.b $2C 
		dc.b $64 
		dc.b $50 
		dc.b $64 
		dc.b $54 
		dc.b $64 
		dc.b $58 
		dc.b $64 
		dc.b $5C 
		dc.b $64 
		dc.b $80 
		dc.b $64 
		dc.b $84 
		dc.b $64 
		dc.b $88 
		dc.b $64 
		dc.b $8C 
		dc.b $64 
		dc.b $B0 
		dc.b $64 
		dc.b $B4 
		dc.b $64 
		dc.b $B8 
		dc.b $64 
		dc.b $BC 
		dc.b $64 
		dc.b $E0 
		dc.b $64 
		dc.b $E4 
		dc.b $64 
		dc.b $E8 
		dc.b $64 
		dc.b $EC 
		dc.b $65 
		dc.b $10
		dc.b $65 
		dc.b $14
		dc.b $65 
		dc.b $18
		dc.b $65 
		dc.b $1C
		dc.b $63 
		dc.b $C1 
		dc.b $63 
		dc.b $C5 
		dc.b $63 
		dc.b $C9 
		dc.b $63 
		dc.b $CD 
		dc.b $63 
		dc.b $F1 
		dc.b $63 
		dc.b $F5 
		dc.b $63 
		dc.b $F9 
		dc.b $63 
		dc.b $FD 
		dc.b $64 
		dc.b $21 
		dc.b $64 
		dc.b $25 
		dc.b $64 
		dc.b $29 
		dc.b $64 
		dc.b $2D 
		dc.b $64 
		dc.b $51 
		dc.b $64 
		dc.b $55 
		dc.b $64 
		dc.b $59 
		dc.b $64 
		dc.b $5D 
		dc.b $64 
		dc.b $81 
		dc.b $64 
		dc.b $85 
		dc.b $64 
		dc.b $89 
		dc.b $64 
		dc.b $8D 
		dc.b $64 
		dc.b $B1 
		dc.b $64 
		dc.b $B5 
		dc.b $64 
		dc.b $B9 
		dc.b $64 
		dc.b $BD 
		dc.b $64 
		dc.b $E1 
		dc.b $64 
		dc.b $E5 
		dc.b $64 
		dc.b $E9 
		dc.b $64 
		dc.b $ED 
		dc.b $65 
		dc.b $11
		dc.b $65 
		dc.b $15
		dc.b $65 
		dc.b $19
		dc.b $65 
		dc.b $1D
		dc.b $63 
		dc.b $C2 
		dc.b $63 
		dc.b $C6 
		dc.b $63 
		dc.b $CA 
		dc.b $63 
		dc.b $CE 
		dc.b $63 
		dc.b $F2 
		dc.b $63 
		dc.b $F6 
		dc.b $63 
		dc.b $FA 
		dc.b $63 
		dc.b $FE 
		dc.b $64 
		dc.b $22 
		dc.b $64 
		dc.b $26 
		dc.b $64 
		dc.b $2A 
		dc.b $64 
		dc.b $2E 
		dc.b $64 
		dc.b $52 
		dc.b $64 
		dc.b $56 
		dc.b $64 
		dc.b $5A 
		dc.b $64 
		dc.b $5E 
		dc.b $64 
		dc.b $82 
		dc.b $64 
		dc.b $86 
		dc.b $64 
		dc.b $8A 
		dc.b $64 
		dc.b $8E 
		dc.b $64 
		dc.b $B2 
		dc.b $64 
		dc.b $B6 
		dc.b $64 
		dc.b $BA 
		dc.b $64 
		dc.b $BE 
		dc.b $64 
		dc.b $E2 
		dc.b $64 
		dc.b $E6 
		dc.b $64 
		dc.b $EA 
		dc.b $64 
		dc.b $EE 
		dc.b $65 
		dc.b $12
		dc.b $65 
		dc.b $16
		dc.b $65 
		dc.b $1A
		dc.b $65 
		dc.b $1E
		dc.b $63 
		dc.b $C3 
		dc.b $63 
		dc.b $C7 
		dc.b $63 
		dc.b $CB 
		dc.b $63 
		dc.b $CF 
		dc.b $63 
		dc.b $F3 
		dc.b $63 
		dc.b $F7 
		dc.b $63 
		dc.b $FB 
		dc.b $63 
		dc.b $FF
		dc.b $64 
		dc.b $23 
		dc.b $64 
		dc.b $27 
		dc.b $64 
		dc.b $2B 
		dc.b $64 
		dc.b $2F 
		dc.b $64 
		dc.b $53 
		dc.b $64 
		dc.b $57 
		dc.b $64 
		dc.b $5B 
		dc.b $64 
		dc.b $5F 
		dc.b $64 
		dc.b $83 
		dc.b $64 
		dc.b $87 
		dc.b $64 
		dc.b $8B 
		dc.b $64 
		dc.b $8F 
		dc.b $64 
		dc.b $B3 
		dc.b $64 
		dc.b $B7 
		dc.b $64 
		dc.b $BB 
		dc.b $64 
		dc.b $BF 
		dc.b $64 
		dc.b $E3 
		dc.b $64 
		dc.b $E7 
		dc.b $64 
		dc.b $EB 
		dc.b $64 
		dc.b $EF 
		dc.b $65 
		dc.b $13
		dc.b $65 
		dc.b $17
		dc.b $65 
		dc.b $1B
		dc.b $65 
		dc.b $1F
		dc.b $FF
