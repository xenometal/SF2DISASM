
; ASM FILE code\gameflow\battle\battlefunctions_1.asm :
; 0x23A84..0x257C0 : Battle functions

; =============== S U B R O U T I N E =======================================

; In: D0 = map idx
;     D1 = battle idx

ExecuteBattleLoop:
		
		clr.b   ((PLAYER_TYPE-$1000000)).w
		trap    #SET_FLAG
		dc.w $18F               ; set after first battle's cutscene OR first save? Checked at witch screens
		trap    #CHECK_FLAG
		dc.w $58                ; checks if a game has been saved for copying purposes? (or if saved from battle?)
		beq.s   loc_23AB2
		move.l  ((SECONDS_COUNTER_FROM_SRAM-$1000000)).w,((SECONDS_COUNTER-$1000000)).w
		trap    #CLEAR_FLAG
		dc.w $58                ; checks if a game has been saved for copying purposes? (or if saved from battle?)
		jsr     j_ClearEnemyMoveInfo
		clr.b   ((CAMERA_ENTITY-$1000000)).w
		bsr.w   LoadBattle      
		bra.w   loc_23B40       
		bra.w   loc_23B0A       
loc_23AB2:
		clr.l   ((SECONDS_COUNTER-$1000000)).w
		movem.w d0-d1,-(sp)
		move.b  d0,((CURRENT_MAP-$1000000)).w
		move.b  d1,((CURRENT_BATTLE-$1000000)).w
		bsr.w   SetBattleVIntFunctions
		jsr     j_ExecuteBattleCutscene_Intro
		movem.w (sp)+,d0-d1
		move.b  d0,((CURRENT_MAP-$1000000)).w
		move.b  d1,((CURRENT_BATTLE-$1000000)).w
		moveq   #$5A,d1 
loc_23ADA:
		jsr     j_ClearFlag
		addq.w  #1,d1
		cmpi.w  #$69,d1 
		ble.s   loc_23ADA
		bsr.w   HealAliveCharsAndImmortals
		jsr     j_InitAllForceBattlePositions
		jsr     j_InitAllEnemyBattlePositions
		jsr     j_ClearEnemyMoveInfo
		clr.w   d0
		bsr.w   LoadBattle      
		jsr     j_ExecuteBattleCutscene_Start
loc_23B0A:
		bsr.w   UpdateAllEnemyAI; start of battle loop
		jsr     j_ExecuteBattleCutscene_Region
		tst.b   ((DEBUG_MODE_ACTIVATED-$1000000)).w
		beq.s   loc_23B1E
		bsr.w   PrintAllActivatedDefCons
loc_23B1E:
		jsr     j_GetListOfSpawningEnemies
		move.w  ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w,d7
		beq.s   loc_23B3C
		subq.w  #1,d7
		lea     ((TARGET_CHARACTERS_INDEX_LIST-$1000000)).w,a0
loc_23B30:
		clr.w   d0
		move.b  (a0)+,d0
		bsr.w   SpawnEnemy
		dbf     d7,loc_23B30
loc_23B3C:
		bsr.w   CreateRandomizedTurnOrder
loc_23B40:
		clr.w   d0              ; start of individual turn execution
		move.b  ((BATTLE_CURRENT_TURN_OFFSET-$1000000)).w,d0
		lea     ((BATTLE_TURN_ORDER-$1000000)).w,a0
		move.b  (a0,d0.w),d0
		cmpi.b  #$FF,d0
		beq.s   loc_23B0A       
		bsr.w   sub_23EB0       
		tst.b   ((DEBUG_MODE_ACTIVATED-$1000000)).w
		beq.s   loc_23B6A
		cmpi.b  #$71,((P1_INPUT-$1000000)).w
		bne.s   loc_23B6A
		bsr.w   loc_23BB4       
loc_23B6A:
		jsr     j_ExecuteBattleCutscene_Defeated
		jsr     HandleKilledCombatants(pc)
		nop
		bsr.w   GetRemainingFighters
		tst.w   d2
		beq.w   loc_23D44
		tst.w   d3
		beq.w   loc_23CBA
		clr.w   d0
		move.b  ((BATTLE_CURRENT_TURN_OFFSET-$1000000)).w,d0
		lea     ((BATTLE_TURN_ORDER-$1000000)).w,a0
		move.b  (a0,d0.w),d0
		bsr.w   HandleAfterTurnEffects
		jsr     HandleKilledCombatants(pc)
		nop
		bsr.w   GetRemainingFighters
		tst.w   d2
		beq.w   loc_23D44
		tst.w   d3
		beq.w   loc_23CBA
		addq.b  #2,((BATTLE_CURRENT_TURN_OFFSET-$1000000)).w
		bra.s   loc_23B40       
loc_23BB4:
		moveq   #COM_ENEMIES_COUNTER,d7; kill all enemies
		move.w  #COM_ENEMY_START,d0
		lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a0
		clr.w   ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
loc_23BC2:
		jsr     j_GetXPos       ; init whole force for battle (restore stats, apply effects/items)
		tst.b   d1
		bmi.w   loc_23BF4
		jsr     j_GetYPos
		tst.b   d1
		bmi.w   loc_23BF4
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.w   loc_23BF4
		move.b  d0,(a0)+
		addq.w  #1,((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
		moveq   #0,d1
		jsr     j_SetCurrentHP
loc_23BF4:
		addq.w  #1,d0
		dbf     d7,loc_23BC2    
		rts

	; End of function ExecuteBattleLoop


; =============== S U B R O U T I N E =======================================

HealAliveCharsAndImmortals:
		
		movem.l d0-d7,-(sp)
		clr.w   d0
		moveq   #CHAR_MAX_IDX,d7
loc_23C04:
		cmpi.b  #CHAR_IDX_PETER,d0
		beq.w   loc_23C1E
		cmpi.b  #CHAR_IDX_LEMON,d0
		beq.w   loc_23C1E
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.s   loc_23C4C
loc_23C1E:
		jsr     j_GetMaxHP
		jsr     j_SetCurrentHP
		jsr     j_GetMaxMP
		jsr     j_SetCurrentMP
		jsr     j_GetStatus
		andi.w  #STATUSEFFECT_LASTING_EFFECTS_MASK,d1
		jsr     j_SetStatus
		jsr     j_ApplyStatusAndItemsOnStats
loc_23C4C:
		addq.w  #1,d0
		dbf     d7,loc_23C04
		movem.l (sp)+,d0-d7
		rts

	; End of function HealAliveCharsAndImmortals


; =============== S U B R O U T I N E =======================================

; number of force members living, number of enemies living -> D2, D3

GetRemainingFighters:
		
		clr.w   d2
		clr.w   d3
		clr.w   d0
		move.w  #COM_ALLIES_COUNTER,d7
loc_23C62:
		jsr     j_GetXPos
		tst.b   d1
		bmi.w   loc_23C7C
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.w   loc_23C7C
		addq.w  #1,d2
loc_23C7C:
		addq.w  #1,d0
		dbf     d7,loc_23C62
		move.w  #COM_ENEMY_START,d0
		move.w  #COM_ENEMIES_COUNTER,d7
loc_23C8A:
		jsr     j_GetXPos
		tst.b   d1
		bmi.w   loc_23CA4
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.w   loc_23CA4
		addq.w  #1,d3
loc_23CA4:
		addq.w  #1,d0
		dbf     d7,loc_23C8A
		clr.w   d0
		jsr     j_GetCurrentHP
		tst.w   d1
		bne.s   return_23CB8
		clr.w   d2
return_23CB8:
		rts

	; End of function GetRemainingFighters


; START OF FUNCTION CHUNK FOR ExecuteBattleLoop

loc_23CBA:
		bsr.w   HealAliveCharsAndImmortals
		cmpi.b  #BATTLEIDX_FAIRY_WOODS,((CURRENT_BATTLE-$1000000)).w
						; HARDCODED Battle check for fairy woods
		bne.s   loc_23CCC
		jsr     j_DisplayTimerWindow
loc_23CCC:
		move.b  ((CURRENT_MAP-$1000000)).w,((MAP_EVENT_PARAM_2-$1000000)).w
		jsr     (UpdateForceAndGetFirstForceMemberIndex).w
		jsr     j_GetXPos
		add.b   ((CAMERA_LOCK_START_X-$1000000)).w,d1
		move.b  d1,((MAP_EVENT_PARAM_3-$1000000)).w
		jsr     j_GetYPos
		add.b   ((CAMERA_LOCK_START_Y-$1000000)).w,d1
		move.b  d1,((MAP_EVENT_PARAM_4-$1000000)).w
		bsr.w   GetEntityNumberOfCombatant
		lsl.w   #5,d0
		lea     ((ENTITY_DATA-$1000000)).w,a0
		move.b  $10(a0,d0.w),((MAP_EVENT_PARAM_5-$1000000)).w
		move.b  #0,((MAP_EVENT_PARAM_1-$1000000)).w
		jsr     j_ExecuteAfterBattleCutscene
		clr.w   d1
		move.b  ((CURRENT_BATTLE-$1000000)).w,d1
		addi.w  #$190,d1
		jsr     j_ClearFlag
		addi.w  #$64,d1 
		jsr     j_SetFlag
		clr.w   d0
		clr.w   d1
		clr.w   d2
		clr.w   d3
		move.b  ((MAP_EVENT_PARAM_2-$1000000)).w,d0
		move.b  ((MAP_EVENT_PARAM_3-$1000000)).w,d1
		move.b  ((MAP_EVENT_PARAM_4-$1000000)).w,d2
		move.b  ((MAP_EVENT_PARAM_5-$1000000)).w,d3
		moveq   #1,d4
		rts
loc_23D44:
		bsr.w   sub_23E1A
		clr.w   ((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #SOUND_COMMAND
		dc.w MUSIC_SAD_THEME_2  ; sad theme 2
		trap    #TEXTBOX
		dc.w $16B               ; "{LEADER} is exhausted.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d0
		jsr     j_GetMaxHP
		jsr     j_SetCurrentHP
		jsr     j_GetGold
		lsr.l   #1,d1
		jsr     j_SetGold
		jsr     GetEgressPositionForBattle(pc)
		nop
		moveq   #$FFFFFFFF,d4
		cmpi.b  #4,((CURRENT_BATTLE-$1000000)).w
		bne.s   return_23D96
		trap    #CLEAR_FLAG     ; HARDCODED battle 4 behaviour : you can lose this battle
		dc.w $194               ; Battle 4 unlocked
		trap    #SET_FLAG
		dc.w $1F8               ; Battle 4 completed
		jsr     sub_1AC04C
		moveq   #$11,d0
		clr.w   d4
return_23D96:
		rts

; END OF FUNCTION CHUNK FOR ExecuteBattleLoop


; =============== S U B R O U T I N E =======================================

; battlefield spell/item use

sub_23D98:
		move.w  -2(a6),d0
		move.w  ((word_FFB634-$1000000)).w,d1
		jsr     j_RemoveItemBySlot
		bsr.w   HideBattlefieldWindows
		move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		move.w  ((word_FFB630-$1000000)).w,((TEXT_NAME_INDEX_2-$1000000)).w
		andi.w  #ITEM_MASK_IDX,((TEXT_NAME_INDEX_2-$1000000)).w
		trap    #TEXTBOX
		dc.w $113               ; "{NAME} used{N}{ITEM}!"
		bra.w   loc_23DFA
loc_23DC4:
		move.w  -2(a6),d0
		move.w  ((word_FFB630-$1000000)).w,d1
		jsr     j_GetSpellCost
		jsr     j_DecreaseCurrentMP
		bsr.w   HideBattlefieldWindows
		move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		move.w  ((word_FFB630-$1000000)).w,((TEXT_NAME_INDEX_2-$1000000)).w
		andi.w  #SPELL_MASK_IDX,((TEXT_NAME_INDEX_2-$1000000)).w
		move.l  #1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $112               ; "{NAME} cast{N}{SPELL} level {#}!"
loc_23DFA:
		trap    #SOUND_COMMAND
		dc.w SFX_SPELL_CAST
		jsr     j_ExecuteFlashScreenScript
		trap    #TEXTBOX
		dc.w $FFFF
		bsr.w   sub_23E1A
		unlk    a6
		movem.l (sp)+,d0
		bsr.w   GetEgressPositionForBattle
		clr.w   d4
		rts

	; End of function sub_23D98


; =============== S U B R O U T I N E =======================================

sub_23E1A:
		clr.w   d1
		move.b  ((CURRENT_BATTLE-$1000000)).w,d1
		addi.w  #$1F4,d1
		jsr     j_CheckFlag
		beq.s   return_23E36
		subi.w  #$64,d1 
		jsr     j_ClearFlag
return_23E36:
		rts

	; End of function sub_23E1A


; =============== S U B R O U T I N E =======================================

HideBattlefieldWindows:
		
		jsr     j_HideLandEffectWindow
		jsr     j_HideFighterMiniStatusWindow
		clr.b   ((FIGHTER_IS_TARGETTING-$1000000)).w
		jsr     j_HideFighterMiniStatusWindow
		rts

	; End of function HideBattlefieldWindows


; =============== S U B R O U T I N E =======================================

; HARDCODED battle->map relationship ?

GetEgressPositionForBattle:
		
		clr.b   d7
		move.b  ((CURRENT_BATTLE-$1000000)).w,d7
		cmpi.b  #$26,d7 
		bne.s   loc_23E60
		trap    #CLEAR_FLAG
		dc.w $1B6               ; Battle 38 unlocked
loc_23E60:
		cmpi.b  #$27,d7 
		bne.s   loc_23E6A
		trap    #CLEAR_FLAG
		dc.w $1B7               ; Battle 39 unlocked
loc_23E6A:
		cmpi.b  #$10,d7
		bne.s   loc_23E76
		moveq   #$D,d0
		bra.w   loc_23EAA
loc_23E76:
		cmpi.b  #$11,d7
		bne.s   loc_23E82
		moveq   #9,d0
		bra.w   loc_23EAA
loc_23E82:
		cmpi.b  #$D,d7
		bne.s   loc_23E8E
		moveq   #$A,d0
		bra.w   loc_23EAA
loc_23E8E:
		cmpi.b  #$1F,d7
		bne.s   loc_23E9A
		moveq   #$24,d0 
		bra.w   loc_23EAA
loc_23E9A:
		cmpi.b  #$20,d7 
		bne.s   loc_23EA6
		moveq   #2,d0
		bra.w   loc_23EAA
loc_23EA6:
		move.b  ((EGRESS_MAP_INDEX-$1000000)).w,d0
loc_23EAA:
		jsr     (GetEgressPositionForMap).w
		rts

	; End of function GetEgressPositionForBattle


; =============== S U B R O U T I N E =======================================

; In: D0 = combatant idx

sub_23EB0:
		jsr     (sub_4ED8).w
		clr.w   ((CURRENT_SPEAK_SOUND-$1000000)).w
		link    a6,#-$10
		andi.w  #$FF,d0
		move.w  d0,-2(a6)
loc_23EC4:
		bsr.w   ClearDeadCombatantsListLength
		cmpi.b  #BATTLEIDX_TAROS,((CURRENT_BATTLE-$1000000)).w
		bne.s   loc_23EDA
		tst.w   -2(a6)
		bne.s   loc_23EDA
		trap    #CLEAR_FLAG
		dc.w $70                ; cleared, set, and checked in ASM x09EC4..x09F27 (CheckForTaros ASM)
loc_23EDA:
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.w   loc_2423E
		move.w  -2(a6),d0
		jsr     j_GetXPos
		move.w  d1,((word_FFB08E-$1000000)).w
		move.w  d1,((word_FFB094-$1000000)).w
		jsr     j_GetYPos
		move.w  d1,((word_FFB090-$1000000)).w
		move.w  d1,((word_FFB092-$1000000)).w
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   GetEntityNumberOfCombatant
		move.b  d0,((CAMERA_ENTITY-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   SetUnitCursorDestinationToNextCombatant
		move.w  -2(a6),d0
		jsr     j_GetStatus
		andi.w  #COM_STATUS_MASK_MUDDLE,d1
		bne.w   loc_23F58       
		jsr     j_GetCharacterWord34
		andi.w  #4,d1
		bne.w   loc_23F58       
		tst.b   d0
		bpl.s   loc_23F4C       ; check if current combatant is char or monster
		tst.b   ((CONTROL_OPPONENT_CHEAT-$1000000)).w
		beq.w   loc_23F58       
		bra.s   loc_23F54
loc_23F4C:
		tst.b   ((AUTO_BATTLE_CHEAT-$1000000)).w
		bne.w   loc_23F58       
loc_23F54:
		bra.w   loc_23F5E       
loc_23F58:
		jsr     j_sub_DEFC      ; AI controlled unit (enemy, auto-control cheat, MUDDLEd force member)
loc_23F5E:
		bsr.w   WaitForUnitCursor; player controlled unit (normal force member, enemy with control opponent cheat)
		jsr     (WaitForCameraToCatchUp).w
		clr.b   ((FIGHTER_IS_TARGETTING-$1000000)).w
		move.w  -2(a6),d0
		move.w  d0,((MOVING_BATTLE_ENTITY_IDX-$1000000)).w
		jsr     j_CreateFighterMiniStatusWindow
		jsr     j_CreateLandEffectWindow
		move.w  -2(a6),d0
		jsr     j_GenerateTargetRangeLists
		bsr.w   CreateMoveableRangeForUnit
		bsr.w   HideUnitCursor
		move.w  -2(a6),d0
		jsr     j_GetStatus
		andi.w  #COM_STATUS_MASK_SLEEP,d1
		bne.w   loc_2420E
		jsr     j_GetStatus
		andi.w  #CHAR_STATUS_MASK_STUN,d1
		bne.w   loc_2420E
		move.w  -2(a6),d0
		jsr     j_GetStatus
		andi.w  #COM_STATUS_MASK_MUDDLE,d1
		bne.w   loc_24036
		jsr     j_GetCharacterWord34
		andi.w  #4,d1
		bne.w   loc_24036
		tst.b   d0
		bpl.s   loc_23FDE
		tst.b   ((CONTROL_OPPONENT_CHEAT-$1000000)).w
		beq.w   loc_24036
		bra.s   loc_23FE6
loc_23FDE:
		tst.b   ((AUTO_BATTLE_CHEAT-$1000000)).w
		bne.w   loc_24036
loc_23FE6:
		bsr.w   sub_24662
		cmpi.w  #$FFFF,d0
		bne.w   loc_2403A
		jsr     (WaitForCameraToCatchUp).w
		move.w  -2(a6),d0
		clr.b   ((FIGHTER_IS_TARGETTING-$1000000)).w
		jsr     j_HideLandEffectWindow
		jsr     j_HideFighterMiniStatusWindow
		move.w  -2(a6),d0
		bsr.w   SetEntityBlinkingFlag
		move.w  -2(a6),d0
		bsr.w   GetEntityNumberOfCombatant
		moveq   #3,d1
		moveq   #$FFFFFFFF,d2
		moveq   #$FFFFFFFF,d3
		jsr     (sub_6052).l    
		bsr.w   sub_2519E
		move.w  -2(a6),d0
		bsr.w   ClearEntityBlinkingFlag
		bra.w   loc_23EC4
loc_24036:
		bsr.w   sub_252FA
loc_2403A:
		cmpi.w  #ACTION_SPELL,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		bne.s   loc_24052
		move.w  ((word_FFB630-$1000000)).w,d0
		andi.w  #SPELL_MASK_IDX,d0
		cmpi.w  #SPELLIDX_EGRESS,d0
		beq.w   loc_23DC4
loc_24052:
		cmpi.w  #ACTION_ITEM,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		bne.s   loc_2406A
		move.w  ((word_FFB630-$1000000)).w,d0
		andi.w  #ITEM_MASK_IDX,d0
		cmpi.w  #ITEMIDX_ANGEL_WING,d0
		beq.w   sub_23D98       
loc_2406A:
		cmpi.w  #3,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		beq.w   loc_2420E
		cmpi.w  #$80,((BATTLESCENE_ACTION_TYPE-$1000000)).w 
		bne.w   loc_24090
		clr.w   ((BATTLESCENE_ACTION_TYPE-$1000000)).w
		move.w  ((word_FFB630-$1000000)).w,d0
		move.w  -2(a6),((word_FFB630-$1000000)).w
		move.w  d0,-2(a6)
loc_24090:
		move.w  -2(a6),d0
		jsr     j_GetClass      
		cmpi.w  #$1C,d1         ; HARDCODED class test : MNST (Monster, for Kiwi)
		bne.s   loc_240E6       
		tst.w   ((BATTLESCENE_ACTION_TYPE-$1000000)).w
		bne.s   loc_240E6       
		moveq   #4,d6
		jsr     (UpdateRandomSeed).w; Kiwi's special attack ?
		tst.w   d7
		bne.s   loc_240E6       
		move.w  ((word_FFB630-$1000000)).w,((word_FFB632-$1000000)).w
		move.w  #1,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		jsr     j_GetCurrentLevel
		clr.w   d0
		cmpi.w  #$20,d1 
		blt.s   loc_240CC
		addq.w  #1,d0
loc_240CC:
		cmpi.w  #$28,d1 
		blt.s   loc_240D4
		addq.w  #1,d0
loc_240D4:
		cmpi.w  #$32,d1 
		blt.s   loc_240DC
		addq.w  #1,d0
loc_240DC:
		lsl.w   #6,d0
		ori.w   #$29,d0 
		move.w  d0,((word_FFB630-$1000000)).w
loc_240E6:
		cmpi.b  #BATTLEIDX_FAIRY_WOODS,((CURRENT_BATTLE-$1000000)).w
						; HARDCODED Battle check : Fairy wood secret battle
		bne.s   loc_240F4
		jsr     j_DisplayTimerWindow
loc_240F4:
		jsr     (WaitForVInt).w 
		jsr     (WaitForVInt).w 
		move.w  -2(a6),d0
		jsr     j_WriteSkirmishScript
		move.w  -2(a6),d0
		tst.b   d0
		blt.s   loc_2412C       
		jsr     j_GetClass      
		cmpi.w  #$C,d1          ; HARDCODED music choices
		bge.s   loc_24122
		move.b  #MUSIC_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
		bra.s   loc_24128
loc_24122:
		move.b  #MUSIC_PROMOTED_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_24128:
		bra.w   loc_241A4
loc_2412C:
		move.b  #MUSIC_ENEMY_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
						; enemy
		jsr     j_GetEnemyID
		cmpi.b  #$57,d1 
		bne.s   loc_24144
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
						; boss
loc_24144:
		cmpi.b  #$58,d1 
		bne.s   loc_24150
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_24150:
		cmpi.b  #$5B,d1 
		bne.s   loc_2415C
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_2415C:
		cmpi.b  #$5C,d1 
		bne.s   loc_24168
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_24168:
		cmpi.b  #$5E,d1 
		bne.s   loc_24174
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_24174:
		cmpi.b  #$5F,d1 
		bne.s   loc_24180
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_24180:
		cmpi.b  #$60,d1 
		bne.s   loc_2418C
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_2418C:
		cmpi.b  #$61,d1 
		bne.s   loc_24198
		move.b  #MUSIC_BOSS_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
loc_24198:
		cmpi.b  #$62,d1 
		bne.s   loc_241A4
		move.b  #MUSIC_ZEON_ATTACK,((SKIRMISH_MUSIC_INDEX-$1000000)).w
						; zeon
loc_241A4:
		clr.w   d0
		move.b  ((SKIRMISH_FIRST_ENEMY-$1000000)).w,d0
		cmpi.b  #$FF,d0
		bne.s   loc_241B4
		move.w  #$FFFF,d0
loc_241B4:
		clr.w   d1
		move.b  ((SKIRMISH_FIRST_ALLY-$1000000)).w,d1
		cmpi.b  #$FF,d1
		bne.s   loc_241C4
		move.w  #$FFFF,d1
loc_241C4:
		movem.l a6,-(sp)
		jsr     j_InitializeBattleScene
		move.b  #$FF,((WINDOW_HIDING_FORBIDDEN-$1000000)).w
		jsr     j_ExecuteBattleSceneScript
		jsr     sub_1800C
		jsr     j_ApplyPositionsAfterEnemyLeaderDies
						; After-battlescene listener used to prepare entity positions for end cutscene before the enemy leader dies. Only used in battle 5.
		movem.l (sp)+,a6
		movem.l a6,-(sp)
		clr.w   d0
		move.w  -4(a6),d0
		jsr     LoadBattle(pc)  
		nop
		jsr     (WaitForVInt).w 
		clr.b   ((WINDOW_HIDING_FORBIDDEN-$1000000)).w
		move.b  #$FF,((CAMERA_ENTITY-$1000000)).w
		movem.l (sp)+,a6
		bra.s   loc_2423E
loc_2420E:
		jsr     (WaitForCameraToCatchUp).w
		jsr     (WaitForVInt).w 
		clr.b   ((FIGHTER_IS_TARGETTING-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   GetEntityNumberOfCombatant
		moveq   #3,d1
		moveq   #$FFFFFFFF,d2
		moveq   #$FFFFFFFF,d3
		jsr     (sub_6052).l    
		move.w  -2(a6),d0
		jsr     j_HideLandEffectWindow
		jsr     j_HideFighterMiniStatusWindow
loc_2423E:
		unlk    a6
		rts

	; End of function sub_23EB0


; =============== S U B R O U T I N E =======================================

; handle after-turn effects (status effects, HP/MP regen/degen, etc)

HandleAfterTurnEffects:
		
		bsr.w   ClearDeadCombatantsListLength
		link    a6,#-$10
		move.w  d0,-2(a6)
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.w   loc_24486       ; skip all this if character died
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		jsr     j_GetStatus
		move.w  d1,d2
		andi.w  #1,d1
		beq.s   loc_24294
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		andi.w  #$FFFE,d2
		move.w  #2,d6
		jsr     (UpdateRandomSeed).w
		tst.w   d7
		bne.s   loc_24288
		trap    #TEXTBOX
		dc.w $166               ; "{CLEAR}{NAME} is no longer stunned.{D3}"
		clr.w   d1
		bra.s   loc_2428C
loc_24288:
		trap    #TEXTBOX
		dc.w $135               ; "{NAME} is stunned.{D3}"
loc_2428C:
		or.w    d2,d1
		jsr     j_SetStatus
loc_24294:
		jsr     j_GetStatus
		move.w  d1,d2
		andi.w  #$C0,d1 
		beq.s   loc_242CE
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		andi.w  #$FF3F,d2
		move.w  d1,d6
		jsr     (UpdateRandomSeed).w
		andi.w  #$C0,d7 
		bne.s   loc_242BE
		trap    #TEXTBOX
		dc.w $162               ; "{CLEAR}{NAME} has awakened.{D3}"
		clr.w   d1
		bra.s   loc_242C6
loc_242BE:
		trap    #TEXTBOX
		dc.w $132               ; "{NAME} is sleeping.{D3}"
		subi.w  #$40,d1 
loc_242C6:
		or.w    d2,d1
		jsr     j_SetStatus
loc_242CE:
		jsr     j_GetStatus
		move.w  d1,d2
		andi.w  #$30,d1 
		beq.s   loc_24308
		andi.w  #$FFCF,d2
		move.w  d1,d6
		jsr     (UpdateRandomSeed).w
		andi.w  #$30,d7 
		bne.s   loc_242FC
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $163               ; "{CLEAR}{NAME} is fine.{D3}"
		clr.w   d1
		andi.w  #$FFF7,d2
		bra.s   loc_24300
loc_242FC:
		subi.w  #$10,d1
loc_24300:
		or.w    d2,d1
		jsr     j_SetStatus
loc_24308:
		jsr     j_GetStatus
		move.w  d1,d2
		andi.w  #$300,d1
		beq.s   loc_24344
		andi.w  #$FCFF,d2
		move.w  d1,d6
		jsr     (UpdateRandomSeed).w
		andi.w  #$300,d7
		bne.s   loc_24338
		move.w  #6,((TEXT_NAME_INDEX_1-$1000000)).w
		move.w  d0,((TEXT_NAME_INDEX_2-$1000000)).w
		trap    #TEXTBOX
		dc.w $15F               ; "{CLEAR}{SPELL} expired.{N}{NAME} is no longer{N}silenced.{D3}"
		clr.w   d1
		bra.s   loc_2433C
loc_24338:
		subi.w  #$100,d1
loc_2433C:
		or.w    d2,d1
		jsr     j_SetStatus
loc_24344:
		jsr     j_GetStatus
		move.w  d1,d2
		andi.w  #$C00,d1
		beq.s   loc_2436E
		andi.w  #$F3FF,d2
		subi.w  #$400,d1
		bne.s   loc_24366
		move.w  #4,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $15D               ; "{CLEAR}{SPELL} expired.{N}Agility and defense{N}return to normal.{D3}"
loc_24366:
		or.w    d2,d1
		jsr     j_SetStatus
loc_2436E:
		jsr     j_GetStatus
		move.w  d1,d2
		andi.w  #$C000,d1
		beq.s   loc_24398
		andi.w  #$3FFF,d2
		subi.w  #$4000,d1
		bne.s   loc_24390
		move.w  #5,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $15E               ; "{CLEAR}{SPELL} expired.{N}Attack returns to normal.{D3}"
loc_24390:
		or.w    d2,d1
		jsr     j_SetStatus
loc_24398:
		jsr     j_GetStatus
		move.w  d1,d2
		andi.w  #$3000,d1
		beq.s   loc_243C2
		andi.w  #$CFFF,d2
		subi.w  #$1000,d1
		bne.s   loc_243BA
		move.w  #3,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $15C               ; "{CLEAR}{SPELL} expired.{N}Agility and defense{N}return to normal.{D3}"
loc_243BA:
		or.w    d2,d1
		jsr     j_SetStatus
loc_243C2:
		jsr     j_GetEquippedWeapon
		cmpi.w  #$61,d1 
		bne.s   loc_243F0
		jsr     j_GetCurrentHP
		move.w  d1,d2
		moveq   #2,d1
		jsr     j_IncreaseCurrentHP
		sub.w   d2,d1
		ble.s   loc_243F0
		ext.l   d1
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $164               ; "{CLEAR}{NAME} recovered{N}{#} hit points.{D3}"
loc_243F0:
		jsr     j_GetEquippedWeapon
		cmpi.w  #$64,d1 
		bne.s   loc_2441E
		jsr     j_GetCurrentMP
		move.w  d1,d2
		moveq   #2,d1
		jsr     j_IncreaseCurrentMP
		sub.w   d2,d1
		ble.s   loc_2441E
		ext.l   d1
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $165               ; "{CLEAR}{NAME} recovered{N}{#} magic points.{D3}"
loc_2441E:
		jsr     j_GetEquippedRing
		cmpi.w  #ITEMIDX_LIFE_RING,d1
		bne.s   loc_2444C
		jsr     j_GetCurrentHP
		move.w  d1,d2
		moveq   #ITEMDEF_LIFE_RING_RECOVERY,d1
		jsr     j_IncreaseCurrentHP
		sub.w   d2,d1
		ble.s   loc_2444C
		ext.l   d1
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $164               ; "{CLEAR}{NAME} recovered{N}{#} hit points.{D3}"
loc_2444C:
		jsr     j_GetStatus
		andi.w  #2,d1
		beq.s   loc_2447C
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
        ; calculate poison damage
        jsr     j_GetMaxHP
        mulu.w  #POISON_PERCENT,d1
        divu.w  #$64,d1
        andi.l  #$FFFF,d1
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $133               ; "{CLEAR}{NAME} gets damaged{N}by {#} because of the poison.{D3}"
		jsr     j_DecreaseCurrentHP
		tst.w   d1
		bne.s   loc_2447C
		trap    #TEXTBOX
		dc.w $134               ; "{NAME} is exhausted.{D3}"
		addq.w  #1,((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
		move.b  d0,((DEAD_COMBATANTS_LIST-$1000000)).w
loc_2447C:
		jsr     j_ApplyStatusAndItemsOnStats
		trap    #TEXTBOX
		dc.w $FFFF
loc_24486:
		unlk    a6
		rts

	; End of function HandleAfterTurnEffects


; =============== S U B R O U T I N E =======================================

SpawnEnemySkipCamera:
		
		moveq   #1,d1
		bra.w   loc_24492
SpawnEnemy:
		clr.w   d1
loc_24492:
		movem.l d7-a0,-(sp)
		link    a6,#-$10
		move.w  d1,-(sp)
		move.w  d0,-2(a6)
		move.w  -2(a6),d0
		jsr     sub_440B8
		move.w  (sp)+,d1
		bne.s   loc_244D2
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   GetEntityNumberOfCombatant
		move.b  d0,((CAMERA_ENTITY-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   SetUnitCursorDestinationToNextCombatant
		bsr.w   WaitForUnitCursor
		jsr     (WaitForCameraToCatchUp).w
		bsr.w   HideUnitCursor
loc_244D2:
		moveq   #$B,d7
loc_244D4:
		move.w  -2(a6),d0
		bsr.w   GetEntityNumberOfCombatant
		move.w  d7,d1
		addq.w  #3,d1
		andi.w  #3,d1
		moveq   #$FFFFFFFF,d2
		moveq   #$FFFFFFFF,d3
		jsr     (sub_6052).l    
		moveq   #3,d0
		jsr     (Sleep).w       
		dbf     d7,loc_244D4
		trap    #SOUND_COMMAND
		dc.w SFX_LANDSTALKER_SWITCH
		move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $18D               ; "{CLEAR}{NAME} appeared!{D3}"
		trap    #TEXTBOX
		dc.w $FFFF
		unlk    a6
		movem.l (sp)+,d7-a0
		rts

	; End of function SpawnEnemySkipCamera


; =============== S U B R O U T I N E =======================================

ClearDeadCombatantsListLength:
		
		clr.w   ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
		rts

	; End of function ClearDeadCombatantsListLength


; =============== S U B R O U T I N E =======================================

HandleKilledCombatants:
		
		tst.w   ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w
		beq.w   return_24640
		movem.l d0-a2/a6,-(sp)
		moveq   #ANIM_SPRITE_DEATH_NUM_SPINS,d6
loc_24526:
		lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a0
						; loop point for sprite death spin animation
		lea     ((ENTITY_ANIMCOUNTER-$1000000)).w,a1
		move.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,d7
		subq.w  #1,d7
loc_24534:
		clr.w   d0
		move.b  (a0)+,d0
		jsr     GetEntityNumberOfCombatant
		move.w  d6,d1
		andi.w  #3,d1
		clr.w   d2
		moveq   #$FFFFFFFF,d3
		jsr     (sub_6052).l    
		cmpi.b  #GFX_MAX_SPRITES_TO_LOAD,((NUM_SPRITES_TO_LOAD-$1000000)).w
		blt.s   loc_2455E
		jsr     (WaitForVInt).w 
		clr.b   ((NUM_SPRITES_TO_LOAD-$1000000)).w
loc_2455E:
		lsl.w   #5,d0
		move.b  #$FF,(a1,d0.w)
		dbf     d7,loc_24534
		moveq   #ANIM_SPRITE_DEATH_SPIN_DELAY,d0
		jsr     (Sleep).w       
		dbf     d6,loc_24526    
		trap    #SOUND_COMMAND
		dc.w SFX_BATTLEFIELD_DEATH
		moveq   #2,d6
loc_2457A:
		lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a0
		move.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,d7
		subq.w  #1,d7
loc_24584:
		clr.w   d0
		move.b  (a0)+,d0
		jsr     GetEntityNumberOfCombatant
		cmpi.b  #$2F,d0 
		bne.s   loc_245A4
		move.l  #$60006000,((byte_FFAEE2-$1000000)).w
		move.l  #$60006000,((byte_FFAEEE-$1000000)).w
loc_245A4:
		move.w  #3,d1
		sub.w   d6,d1
		clr.w   d2
		move.w  #$3F,d3 
		jsr     (sub_6052).l    
		cmpi.b  #7,((NUM_SPRITES_TO_LOAD-$1000000)).w
		blt.s   loc_245C6
		jsr     (WaitForVInt).w 
		clr.b   ((NUM_SPRITES_TO_LOAD-$1000000)).w
loc_245C6:
		dbf     d7,loc_24584
		moveq   #8,d0
		jsr     (Sleep).w       
		dbf     d6,loc_2457A
		lea     ((DEAD_COMBATANTS_LIST-$1000000)).w,a0
		move.w  ((DEAD_COMBATANTS_LIST_LENGTH-$1000000)).w,d7
		subq.w  #1,d7
loc_245DE:
		moveq   #1,d1
		clr.w   d0
		move.b  (a0)+,d0
		blt.s   loc_245EE
		jsr     j_IncreaseDefeats
		bra.s   loc_24602
loc_245EE:
		movem.l d0,-(sp)
		clr.w   d0
		move.b  ((SKIRMISH_FIRST_ALLY-$1000000)).w,d0
		jsr     j_IncreaseKills
		movem.l (sp)+,d0
loc_24602:
		moveq   #$FFFFFFFF,d1
		jsr     j_SetXPos
		jsr     j_SetYPos
		clr.w   d1
		jsr     j_SetStatus
		jsr     j_ApplyStatusAndItemsOnStats
		jsr     GetEntityNumberOfCombatant
		move.w  #$7000,d1
		move.w  #$7000,d2
		jsr     SetEntityPosition
		dbf     d7,loc_245DE
		moveq   #$A,d0
		jsr     (Sleep).w       
		movem.l (sp)+,d0-a2/a6
return_24640:
		rts

	; End of function HandleKilledCombatants


; =============== S U B R O U T I N E =======================================

; In: D0 = combatant idx

UpdateTargetListForCombatant:
		
		movem.w d0,-(sp)
		move.w  -2(a6),d0
		tst.b   d0
		movem.w (sp)+,d0
		blt.s   loc_2465A
		jsr     j_UpdateTargetListMonsters
		bra.s   return_24660
loc_2465A:
		jsr     j_UpdateTargetListCharacters
return_24660:
		rts

	; End of function UpdateTargetListForCombatant


; =============== S U B R O U T I N E =======================================

sub_24662:
		movem.l d1-a6,-(sp)
		move.w  -2(a6),((MOVING_BATTLE_ENTITY_IDX-$1000000)).w
loc_2466C:
		move.w  -2(a6),d0
		bsr.w   ClearEntityBlinkingFlag
		bsr.w   GetEntityNumberOfCombatant
		move.b  d0,((CAMERA_ENTITY-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   UpdateMoveSound
		bsr.w   ControlBattleUnit
		jsr     (WaitForCameraToCatchUp).w
		btst    #INPUT_A_B_BIT,d4
		beq.w   loc_246EC
		movem.w d2-d3,-(sp)
		move.w  ((word_FFB08E-$1000000)).w,d3
		move.w  ((word_FFB090-$1000000)).w,d4
		lea     ((MOVE_COST_LIST-$1000000)).w,a5
		moveq   #1,d0
		bsr.s   UpdateTargetListForCombatant
		moveq   #$1E,d0
		lea     ((byte_FF4000+$400)).l,a2
		lea     ((byte_FF4A00+$300)).l,a3
		lea     (TERRAIN_DATA).l,a4
		jsr     j_MakeRangeLists
		clr.w   d0
		jsr     UpdateTargetListForCombatant(pc)
		movem.w (sp)+,d0-d1
		jsr     MakeBattleEntityCancelMoveString
		move.w  -2(a6),d0
		lea     (BATTLE_ENTITY_MOVE_STRING).l,a0
		bsr.w   MoveBattleEntityByMoveString
		move.w  #$FFFF,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		moveq   #$FFFFFFFF,d0
		bra.w   loc_25188
loc_246EC:
		clr.w   d0
		moveq   #COM_ALL_COUNTER,d7
loc_246F0:
		cmp.w   -2(a6),d0       ; check if chosen position is inhabited already (for debug mode B-button trick)
		beq.w   loc_24718
		jsr     j_GetXPos
		cmp.w   d1,d2
		bne.w   loc_24718
		jsr     j_GetYPos
		cmp.w   d1,d3
		bne.w   loc_24718
		trap    #SOUND_COMMAND
		dc.w SFX_REFUSAL
		beq.w   loc_2466C
loc_24718:
		addq.w  #1,d0
		cmpi.w  #COM_ALLIES_NUM,d0
		bne.s   loc_24724
		move.w  #COM_ENEMY_START,d0
loc_24724:
		dbf     d7,loc_246F0    
		move.w  -2(a6),d0
		bsr.w   SetEntityBlinkingFlag
		move.w  -2(a6),d0
		move.w  d2,d1
		jsr     j_SetXPos
		move.w  d3,d1
		jsr     j_SetYPos
		clr.w   d1
loc_24746:
		move.w  d1,-(sp)
		jsr     ClearFadingBlockRange
		jsr     (WaitForVInt).w 
		move.w  -2(a6),d0
		bsr.w   GetEntityPositionAfterApplyingFacing
		jsr     (CheckChestItem).w
		move.w  d2,((byte_FFB180-$1000000)).w
		cmpi.w  #$FFFF,d2
		bne.s   loc_2476C       ; if d2 != FFFF, then there is an item
		moveq   #1,d2           ; Battle menu with STAY option
		bra.s   loc_2476E
loc_2476C:
		moveq   #2,d2           ; Battle menu with SEARCH option
loc_2476E:
		move.w  -2(a6),d0
		jsr     j_sub_C404
		tst.w   ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w
		bne.s   loc_24782
		moveq   #3,d0
		bra.s   loc_24784
loc_24782:
		clr.w   d0
loc_24784:
		bsr.w   HideUnitCursor
		move.w  (sp)+,d1
		lea     (InitStack).w,a0
		jsr     j_ExecuteMenu
		cmpi.w  #$FFFF,d0
		bne.w   loc_247C6
		move.w  -2(a6),d0
		move.w  ((word_FFB08E-$1000000)).w,d1
		jsr     j_SetXPos
		move.w  ((word_FFB090-$1000000)).w,d1
		jsr     j_SetYPos
		move.w  -2(a6),d0
		jsr     j_GenerateTargetRangeLists
		bsr.w   CreateMoveableRangeForUnit
		bra.w   loc_2466C
loc_247C6:
		tst.w   d0
		bne.w   loc_2483C
		move.w  -2(a6),d0
		jsr     j_sub_C404
		bsr.w   CreateMoveableRangeForUnit
		tst.w   ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w
		bne.w   loc_247F0
		trap    #TEXTBOX
		dc.w $1B3               ; "No opponent there.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24746
loc_247F0:
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   sub_230E2
		cmpi.w  #$FFFF,d0
		bne.w   loc_2482A
		move.w  -2(a6),d0
		jsr     j_GetXPos
		move.w  d1,d2
		jsr     j_GetYPos
		move.w  d1,d3
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   sub_2322C
		moveq   #$FFFFFFFF,d1
		bra.w   loc_24746
loc_2482A:
		move.w  d0,((word_FFB630-$1000000)).w
		move.w  d0,-4(a6)
		clr.w   ((BATTLESCENE_ACTION_TYPE-$1000000)).w
		clr.w   d0
		bra.w   loc_25188
loc_2483C:
		cmpi.w  #1,d0
		bne.w   loc_24982
		move.w  -2(a6),d0
		clr.w   d1
		jsr     j_GetSpellAndNumberOfSpells
		tst.w   d2
		bne.w   loc_24864
		trap    #TEXTBOX
		dc.w $1B4               ; "Learned no new magic spell.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24746
loc_24864:
		clr.w   d1
loc_24866:
		move.w  -2(a6),d0
		bsr.w   HideUnitCursor
		move.w  d1,-(sp)
		lea     ((DISPLAYED_ICON_1-$1000000)).w,a0
		moveq   #0,d1
		jsr     j_GetSpellAndNumberOfSpells
		move.w  d1,(a0)+
		moveq   #1,d1
		jsr     j_GetSpellAndNumberOfSpells
		move.w  d1,(a0)+
		moveq   #2,d1
		jsr     j_GetSpellAndNumberOfSpells
		move.w  d1,(a0)+
		moveq   #3,d1
		jsr     j_GetSpellAndNumberOfSpells
		move.w  d1,(a0)+
		move.w  (sp)+,d1
		clr.w   d0
		lea     sub_24966(pc), a0
		nop
		jsr     sub_10010
		cmpi.w  #$FFFF,d0
		bne.w   loc_248BA
		moveq   #$FFFFFFFF,d1
		bra.w   loc_24746
loc_248BA:
		move.w  d0,((word_FFB630-$1000000)).w
		move.w  d0,d4
		move.w  -2(a6),d0
		jsr     j_GetCurrentMP
		move.w  d1,d3
		move.w  d4,d1
		jsr     j_GetSpellCost
		sub.w   d1,d3
		bge.w   loc_248E6
		trap    #TEXTBOX
		dc.w $1B5               ; "More MP needed.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.s   loc_24866
loc_248E6:
		move.w  d4,d1
		move.w  -2(a6),d0
		jsr     j_CreateSpellRangeGrid
		bsr.w   CreateMoveableRangeForUnit
		tst.w   ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w
		bne.w   loc_2490C
		trap    #TEXTBOX
		dc.w $1B3               ; "No opponent there.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24866
loc_2490C:
		move.w  ((word_FFB630-$1000000)).w,d1
		jsr     j_GetSpellDefAddress
		move.b  6(a0),((word_FFAF8E-$1000000)).w
		bsr.w   sub_230E2
		cmpi.w  #$FFFF,d0
		bne.w   loc_24952
		move.w  -2(a6),d0
		jsr     j_GetXPos
		move.w  d1,((word_FFB094-$1000000)).w
		jsr     j_GetYPos
		move.w  d1,((word_FFB092-$1000000)).w
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   sub_2322C
		moveq   #$FFFFFFFF,d1
		bra.w   loc_24866
loc_24952:
		move.w  d0,((word_FFB632-$1000000)).w
		move.w  d0,-4(a6)
		move.w  #1,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		clr.w   d0
		bra.w   loc_25188

	; End of function sub_24662


; =============== S U B R O U T I N E =======================================

;     createSpellRangeGridMaster???

sub_24966:
		movem.l d0-a6,-(sp)
		move.w  ((MOVING_BATTLE_ENTITY_IDX-$1000000)).w,d0
		move.w  ((word_FFB18C-$1000000)).w,d1
		jsr     j_CreateSpellRangeGrid
		bsr.w   CreateMoveableRangeForUnit
		movem.l (sp)+,d0-a6
		rts

	; End of function sub_24966


; START OF FUNCTION CHUNK FOR sub_24662

loc_24982:
		cmpi.w  #2,d0
		bne.w   loc_25072
		move.w  -2(a6),d0
		clr.w   d1
		jsr     j_GetItemAndNumberOfItems
		tst.w   d2
		bne.w   loc_249A8
		trap    #TEXTBOX
		dc.w $1B6               ; "You have no item.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		bra.w   loc_24746
loc_249A8:
		clr.w   d1
loc_249AA:
		moveq   #3,d2
		clr.w   d0
		lea     (InitStack).w,a0
		jsr     j_ExecuteMenu
		cmpi.w  #$FFFF,d0
		bne.w   loc_249C6
		moveq   #$FFFFFFFF,d1
		bra.w   loc_24746
loc_249C6:
		tst.w   d0
		bne.w   loc_24B06
		clr.w   d1
loc_249CE:
		move.w  -2(a6),d0
		bsr.w   HideUnitCursor
		move.w  d1,-(sp)
		lea     ((DISPLAYED_ICON_1-$1000000)).w,a0
		moveq   #0,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #1,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #2,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #3,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		move.w  (sp)+,d1
		clr.w   d0
		clr.w   d1
		lea     loc_24ADC(pc), a0
		nop
		jsr     sub_10004
		cmpi.w  #$FFFF,d0
		bne.w   loc_24A24
		bsr.w   ClearFadingBlockRange
		bra.s   loc_249AA
loc_24A24:
		move.w  d0,((word_FFB630-$1000000)).w
		move.w  d1,((word_FFB634-$1000000)).w
		move.w  d0,d1
		move.w  -2(a6),d0
		jsr     j_IsItemUsableWeaponInBattle
		bcs.w   loc_24A4A
		trap    #TEXTBOX
		dc.w $1B7               ; "It has no effect.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24746
loc_24A4A:
		move.w  ((word_FFB630-$1000000)).w,d1
		move.w  -2(a6),d0
		jsr     j_CreateItemRangeGrid
		bsr.w   CreateMoveableRangeForUnit
		tst.w   ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w
		bne.w   loc_24A72
		trap    #TEXTBOX
		dc.w $1B7               ; "It has no effect.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_249CE
loc_24A72:
		move.w  ((word_FFB630-$1000000)).w,d1
		jsr     j_GetItemDefAddress
		clr.w   d1
		move.b  ITEMDEF_OFFSET_SPELL(a0),d1
		jsr     j_GetSpellDefAddress
		move.b  SPELLDEF_OFFSET_RADIUS(a0),((word_FFAF8E-$1000000)).w
		bsr.w   sub_230E2
		cmpi.w  #$FFFF,d0
		bne.w   loc_24AC8
		move.w  -2(a6),d0
		jsr     j_GetXPos
		move.w  d1,((word_FFB094-$1000000)).w
		jsr     j_GetYPos
		move.w  d1,((word_FFB092-$1000000)).w
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   sub_2322C
		moveq   #$FFFFFFFF,d1
		bra.w   loc_24746
		bra.w   loc_249CE
loc_24AC8:
		move.w  d0,((word_FFB632-$1000000)).w
		move.w  d0,-4(a6)
		move.w  #ACTION_ITEM,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		clr.w   d0
		bra.w   loc_25188
loc_24ADC:
		movem.l d0-a6,-(sp)
		move.w  ((MOVING_BATTLE_ENTITY_IDX-$1000000)).w,d0
		move.w  ((word_FFB18C-$1000000)).w,d1
		jsr     j_IsItemUsableWeaponInBattle
		bcc.s   loc_24AFC
		jsr     j_CreateItemRangeGrid
		bsr.w   CreateMoveableRangeForUnit
		bra.s   loc_24B00
loc_24AFC:
		bsr.w   ClearFadingBlockRange
loc_24B00:
		movem.l (sp)+,d0-a6
		rts
loc_24B06:
		cmpi.w  #2,d0
		bne.w   loc_24D64
		move.w  -2(a6),d0
		jsr     j_GetEquippableWeapons
		move.w  d1,d2
		jsr     j_GetEquippableRings
		add.w   d2,d1
		bne.w   loc_24B34
		trap    #TEXTBOX
		dc.w $1BC               ; "You have nothing to equip.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_249AA
loc_24B34:
		bsr.w   HideUnitCursor
		jsr     sub_1005C
		clr.w   d6
loc_24B40:
		move.w  -2(a6),d0
		jsr     j_GetEquippableWeapons
		tst.w   d1
		beq.w   loc_24BBE
		movea.l a0,a2
		lea     ((DISPLAYED_ICON_1-$1000000)).w,a1
		move.w  (a0),(a1)+
		move.w  4(a0),(a1)+
		move.w  8(a0),(a1)+
		move.w  $C(a0),(a1)+
		move.w  d1,d3
		jsr     j_GetEquippedWeapon
		move.w  d2,-(sp)
		bsr.w   sub_24C4E
		jsr     j_GetEquippedWeapon
		move.w  d2,d1
		jsr     j_UnequipItemBySlot
		move.w  (sp)+,d2
		move.w  d1,-(sp)
		move.w  d2,d1
		jsr     j_EquipItem
		move.w  (sp)+,d1
		move.b  ((CURRENT_DIAMENU_CHOICE-$1000000)).w,d1
		ext.w   d1
		bpl.s   loc_24BA0
		moveq   #1,d7
		move.w  #$FFFF,d6
		bra.w   loc_24C44
loc_24BA0:
		lea     ((EQUIPPABLE_ITEMS-$1000000)).w,a2
		lsl.w   #2,d1
		move.w  (a2,d1.w),d2
		move.w  2(a2,d1.w),d1
		move.w  d2,d5
		move.w  d1,d4
		jsr     j_GetEquippedWeapon
		bsr.w   loc_24C94
		clr.w   d6
loc_24BBE:
		jsr     j_GetEquippableRings
		tst.w   d1
		beq.w   loc_24C44
		movea.l a0,a2
		lea     ((DISPLAYED_ICON_1-$1000000)).w,a1
		move.w  (a0),(a1)+
		move.w  4(a0),(a1)+
		move.w  8(a0),(a1)+
		move.w  $C(a0),(a1)+
		move.w  d1,d3
		jsr     j_GetEquippedRing
		move.w  d2,-(sp)
		bsr.w   sub_24C4E
		jsr     j_GetEquippedRing
		move.w  d2,d1
		jsr     j_UnequipItemBySlot
		move.w  (sp)+,d2
		move.w  d1,-(sp)
		move.w  d2,d1
		jsr     j_EquipItem
		move.w  (sp)+,d1
		move.b  ((CURRENT_DIAMENU_CHOICE-$1000000)).w,d1
		ext.w   d1
		bpl.s   loc_24C26
		jsr     j_GetEquippableWeapons
		tst.w   d1
		bne.s   loc_24C22
		moveq   #1,d7
		moveq   #$FFFFFFFF,d6
		bra.w   loc_24C44
loc_24C22:
		bra.w   loc_24B40
loc_24C26:
		lea     ((EQUIPPABLE_ITEMS-$1000000)).w,a2
		lsl.w   #2,d1
		move.w  (a2,d1.w),d2
		move.w  2(a2,d1.w),d1
		move.w  d2,d5
		move.w  d1,d4
		jsr     j_GetEquippedRing
		bsr.w   loc_24C94
		clr.w   d1
loc_24C44:
		jsr     sub_10064
		bra.w   loc_24746

; END OF FUNCTION CHUNK FOR sub_24662


; =============== S U B R O U T I N E =======================================

sub_24C4E:
		move.w  d0,-(sp)
		tst.w   d1
		bpl.s   loc_24C68
		cmpi.w  #4,d3
		bne.s   loc_24C64
		clr.w   d1
		jsr     j_EquipItem
		bra.s   loc_24C66
loc_24C64:
		moveq   #3,d1
loc_24C66:
		bra.s   loc_24C7C
loc_24C68:
		move.l  a0,-(sp)
		moveq   #3,d7
		moveq   #$FFFFFFFF,d1
loc_24C6E:
		addq.w  #1,d1
		addq.l  #2,a0
		move.w  (a0)+,d4
		cmp.w   d2,d4
		dbeq    d7,loc_24C6E
		movea.l (sp)+,a0
loc_24C7C:
		move.b  d1,d0
		lea     loc_24CF6(pc), a0
		nop
		move.w  d6,d1
		move.w  d1,-(sp)
		jsr     sub_10004
		move.w  (sp)+,d1
		move.w  (sp)+,d0
		rts
loc_24C94:
		cmpi.w  #4,d2
		beq.w   loc_24CC4
		move.w  d2,d1
		jsr     j_UnequipItemIfNotCursed
		cmpi.w  #2,d2
		bne.w   loc_24CC4
		cmp.w   d4,d1
		beq.w   return_24CF4
		jsr     sub_10064
		trap    #SOUND_COMMAND
		dc.w MUSIC_CURSED_ITEM
		trap    #TEXTBOX
		dc.w $2B                ; "Gosh!  The curse prohibits{N}you from exchanging{N}equipment!{W2}"
		bra.w   loc_24CE6
loc_24CC4:
		move.w  d4,d1
		jsr     j_EquipItem
		cmpi.w  #2,d2
		bne.w   return_24CF4
		jsr     sub_10064
		trap    #SOUND_COMMAND
		dc.w MUSIC_CURSED_ITEM
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $22                ; "Gosh!  {NAME} is{N}cursed!{W2}"
loc_24CE6:
		bsr.w   FadeOut_WaitForP1Input
		trap    #TEXTBOX
		dc.w $FFFF
		jsr     sub_1005C
return_24CF4:
		rts
loc_24CF6:
		movem.l d0-a6,-(sp)
		move.w  ((MOVING_BATTLE_ENTITY_IDX-$1000000)).w,d0
		jsr     j_GetStatus
		move.w  d1,-(sp)
		clr.w   d2
		move.b  ((CURRENT_DIAMENU_CHOICE-$1000000)).w,d2
		lsl.w   #2,d2
		lea     ((EQUIPPABLE_ITEMS-$1000000)).w,a2
		move.w  (a2,d2.w),d5
		move.w  2(a2,d2.w),d6
		move.w  (a2),d1
		jsr     j_GetItemType
		tst.w   d2
		blt.s   loc_24D2E
		jsr     j_UnequipWeapon
		bra.s   loc_24D34
loc_24D2E:
		jsr     j_UnequipRing
loc_24D34:
		move.w  d6,d1
		cmpi.w  #4,d1
		bge.s   loc_24D42
		jsr     j_EquipItem
loc_24D42:
		jsr     sub_10060
		jsr     j_sub_C404
		bsr.w   CreateMoveableRangeForUnit
		move.w  ((MOVING_BATTLE_ENTITY_IDX-$1000000)).w,d0
		move.w  (sp)+,d1
		jsr     j_SetStatus
		movem.l (sp)+,d0-a6
		rts

	; End of function sub_24C4E


; START OF FUNCTION CHUNK FOR sub_24662

loc_24D64:
		cmpi.w  #1,d0
		bne.w   loc_24F6E
loc_24D6C:
		move.w  -2(a6),d0
		bsr.w   HideUnitCursor
		move.w  d1,-(sp)
		lea     ((DISPLAYED_ICON_1-$1000000)).w,a0
		moveq   #0,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #1,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #2,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #3,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		move.w  (sp)+,d1
		move.w  -2(a6),d0
		jsr     j_sub_C4E8
		bsr.w   CreateMoveableRangeForUnit
		tst.w   ((TARGET_CHARACTERS_INDEX_LIST_SIZE-$1000000)).w
		bne.w   loc_24DCC
		trap    #TEXTBOX
		dc.w $1B3               ; "No opponent there.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bsr.w   ClearFadingBlockRange
		bra.w   loc_249AA
loc_24DCC:
		bsr.w   HideUnitCursor
		jsr     (WaitForVInt).w 
		clr.w   d0
		lea     (InitStack).w,a0
		jsr     sub_10004
		cmpi.w  #$FFFF,d0
		bne.w   loc_24DF0
		bsr.w   ClearFadingBlockRange
		bra.w   loc_249AA
loc_24DF0:
		move.w  d0,((word_FFB634-$1000000)).w
		move.w  d1,((word_FFB630-$1000000)).w
		btst    #7,d0
		beq.w   loc_24E26
		move.w  d0,d1
		jsr     j_GetItemDefAddress
		btst    #6,8(a0)
		beq.w   loc_24E26
		trap    #SOUND_COMMAND
		dc.w MUSIC_CURSED_ITEM
		trap    #TEXTBOX
		dc.w $1B9               ; "The equipment is cursed.{W1}"
		bsr.w   FadeOut_WaitForP1Input
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.s   loc_24DCC
loc_24E26:
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   sub_230E2
		cmpi.w  #$FFFF,d0
		bne.w   loc_24E4C
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  -2(a6),d0
		bsr.w   sub_2322C
		moveq   #$FFFFFFFF,d1
		bra.w   loc_24D6C
loc_24E4C:
		move.w  d0,-4(a6)
		jsr     j_HideFighterMiniStatusWindow
		clr.w   d1
		jsr     j_GetItemAndNumberOfItems
		cmpi.w  #4,d2
		beq.w   loc_24E8E
		move.w  ((word_FFB630-$1000000)).w,d1
		andi.w  #7,d1
		move.w  -2(a6),d0
		jsr     j_RemoveItemBySlot
		move.w  -4(a6),d0
		move.w  ((word_FFB634-$1000000)).w,d1
		bclr    #7,d1
		jsr     j_AddItem
		bra.w   loc_24F62
loc_24E8E:
		move.w  -4(a6),d0
		bsr.w   HideUnitCursor
		move.w  d1,-(sp)
		lea     ((DISPLAYED_ICON_1-$1000000)).w,a0
		moveq   #0,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #1,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #2,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #3,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		move.w  (sp)+,d1
		clr.w   d0
		lea     (InitStack).w,a0
		jsr     sub_10004
		cmpi.w  #$FFFF,d0
		bne.w   loc_24EDE
		bra.w   loc_24E26
loc_24EDE:
		move.w  d0,((word_FFB632-$1000000)).w
		move.w  d1,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		btst    #7,d0
		beq.w   loc_24F16
		move.w  d0,d1
		jsr     j_GetItemDefAddress
		btst    #6,8(a0)
		beq.w   loc_24F16
		trap    #SOUND_COMMAND
		dc.w MUSIC_CURSED_ITEM
		trap    #TEXTBOX
		dc.w $1B9               ; "The equipment is cursed.{W1}"
		bsr.w   FadeOut_WaitForP1Input
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24E8E
loc_24F16:
		move.w  ((word_FFB630-$1000000)).w,d1
		andi.w  #3,d1
		move.w  -2(a6),d0
		jsr     j_RemoveItemBySlot
		move.w  ((word_FFB634-$1000000)).w,d1
		move.w  d1,-(sp)
		move.w  ((BATTLESCENE_ACTION_TYPE-$1000000)).w,d1
		andi.w  #3,d1
		move.w  -4(a6),d0
		jsr     j_RemoveItemBySlot
		move.w  ((word_FFB632-$1000000)).w,d1
		bclr    #7,d1
		move.w  -2(a6),d0
		jsr     j_AddItem
		move.w  (sp)+,d1
		bclr    #7,d1
		move.w  -4(a6),d0
		jsr     j_AddItem
loc_24F62:
		move.w  #3,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		clr.w   d0
		bra.w   loc_25188
loc_24F6E:
		move.w  -2(a6),d0
		bsr.w   HideUnitCursor
		move.w  d1,-(sp)
		lea     ((DISPLAYED_ICON_1-$1000000)).w,a0
		moveq   #0,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #1,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #2,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		moveq   #3,d1
		jsr     j_GetItemAndNumberOfItems
		move.w  d1,(a0)+
		move.w  (sp)+,d1
		clr.w   d0
		clr.w   d1
		lea     (InitStack).w,a0
		jsr     sub_10004
		cmpi.w  #$FFFF,d0
		bne.w   loc_24FC2
		moveq   #$FFFFFFFF,d1
		bra.w   loc_249AA
loc_24FC2:
		move.w  d0,((word_FFB634-$1000000)).w
		move.w  d1,((word_FFB630-$1000000)).w
		btst    #7,d0
		beq.w   loc_24FFA
		move.w  d0,d1
		jsr     j_GetItemDefAddress
		btst    #6,8(a0)
		beq.w   loc_24FFA
		trap    #SOUND_COMMAND
		dc.w MUSIC_CURSED_ITEM
		trap    #TEXTBOX
		dc.w $1B9               ; "The equipment is cursed.{W1}"
		bsr.w   FadeOut_WaitForP1Input
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24F6E
loc_24FFA:
		move.w  ((word_FFB634-$1000000)).w,d1
		jsr     j_GetItemDefAddress
		btst    #4,8(a0)
		beq.w   loc_25022
		move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $1BB               ; "Are you sure?"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24F6E
loc_25022:
		move.w  ((word_FFB634-$1000000)).w,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $2C                ; "The {ITEM} will be{N}discarded.  Are you sure?"
		jsr     j_YesNoChoiceBox
		trap    #TEXTBOX
		dc.w $FFFF
		tst.w   d0
		bne.w   loc_24746
		move.w  ((word_FFB630-$1000000)).w,d1
		move.w  -2(a6),d0
		jsr     j_RemoveItemBySlot
		move.w  ((word_FFB634-$1000000)).w,d1
		jsr     j_GetItemDefAddress
		btst    #3,8(a0)
		beq.s   loc_25066
		move.w  ((word_FFB634-$1000000)).w,d0
		jsr     j_AddItemToDeals
loc_25066:
		trap    #TEXTBOX
		dc.w $2A                ; "Discarded the {ITEM}.{W2}"
		trap    #TEXTBOX
		dc.w $FFFF
		bra.w   loc_24746
loc_25072:
		cmpi.w  #$FFFF,((byte_FFB180-$1000000)).w
		bne.w   loc_25088
		move.w  #3,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		clr.w   d0
		bra.w   loc_25188
loc_25088:
		move.w  -2(a6),d0
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		bsr.w   GetEntityPositionAfterApplyingFacing
		bsr.w   sub_256E6
		cmpi.w  #$FFFF,d3
		beq.s   loc_250B0
		move.w  d3,((TEXT_NAME_INDEX_1-$1000000)).w
		trap    #TEXTBOX
		dc.w $1A2               ; "{NAME} is distributing{N}items from the open chest.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		clr.w   d1
		bra.w   loc_24746
loc_250B0:
		jsr     (OpenChest).w
		trap    #TEXTBOX
		dc.w $193               ; "{NAME} opened the chest.{W2}{CLEAR}"
		move.w  ((byte_FFB180-$1000000)).w,d1
		andi.w  #ITEM_MASK_IDX,d1
		cmpi.w  #$7F,d1 
		beq.w   loc_25178
		move.w  -2(a6),d0
		bsr.w   GetEntityPositionAfterApplyingFacing
		move.w  d1,d2
		move.w  d0,d1
		jsr     sub_1AC054
		cmpi.w  #$FFFF,d0
		beq.w   loc_250FC
		move.w  #$80,((BATTLESCENE_ACTION_TYPE-$1000000)).w 
		move.w  d0,((word_FFB630-$1000000)).w
		move.w  d0,-4(a6)
		trap    #SOUND_COMMAND
		dc.w MUSIC_CORRUPTED_SAVE
		bsr.w   SpawnEnemySkipCamera
		bra.w   loc_25188
loc_250FC:
		move.w  ((byte_FFB180-$1000000)).w,d2
		cmpi.w  #$80,d2 
		blt.s   loc_25124
		bsr.w   GetChestGoldAmount
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		jsr     j_IncreaseGold
		trap    #SOUND_COMMAND
		dc.w MUSIC_ITEM
		trap    #TEXTBOX
		dc.w $19E               ; "{NAME} found {#} gold{N}coins."
		bsr.w   FadeOut_WaitForP1Input
		bra.w   loc_2517C
loc_25124:
		move.w  ((byte_FFB180-$1000000)).w,d1
		move.w  d1,((TEXT_NAME_INDEX_2-$1000000)).w
		move.w  -2(a6),d0
		move.w  d0,((TEXT_NAME_INDEX_1-$1000000)).w
		jsr     j_AddItem
		tst.w   d2
		bne.w   loc_2515A
		move.w  -2(a6),((TEXT_NAME_INDEX_1-$1000000)).w
		move.w  d1,((TEXT_NAME_INDEX_2-$1000000)).w
		trap    #SOUND_COMMAND
		dc.w MUSIC_ITEM
		trap    #TEXTBOX
		dc.w $19F               ; "{NAME} recieved{N}{ITEM}."
		bsr.w   FadeOut_WaitForP1Input
		bra.w   loc_2517C
loc_2515A:
		trap    #TEXTBOX
		dc.w $19D               ; "{NAME} found{N}{ITEM}.{W2}{CLEAR}"
		trap    #TEXTBOX
		dc.w $1A3               ; "{NAME} hands are full.{W1}"
		trap    #TEXTBOX
		dc.w $FFFF
		move.w  -2(a6),d0
		bsr.w   GetEntityPositionAfterApplyingFacing
		jsr     (CloseChest).w
		clr.w   d1
		bra.w   loc_24746
loc_25178:
		trap    #TEXTBOX
		dc.w $198               ; "But, it was empty.{W1}"
loc_2517C:
		trap    #TEXTBOX
		dc.w $FFFF
		move.w  #3,((BATTLESCENE_ACTION_TYPE-$1000000)).w
		clr.w   d0
loc_25188:
		move.w  d0,-(sp)
		move.w  -2(a6),d0
		bsr.w   ClearEntityBlinkingFlag
		move.w  (sp)+,d0
		bsr.w   ClearFadingBlockRange
		movem.l (sp)+,d1-a6
		rts

; END OF FUNCTION CHUNK FOR sub_24662


; =============== S U B R O U T I N E =======================================

sub_2519E:
		clr.b   ((word_FFAF8E-$1000000)).w
		clr.w   ((MOVE_SOUND-$1000000)).w
		bsr.w   ControlUnitCursor
		btst    #INPUT_A_B_BIT,((P1_INPUT-$1000000)).w
		beq.s   BattlefieldMenuActions
		move.w  -2(a6),d0
		rts

	; End of function sub_2519E


; =============== S U B R O U T I N E =======================================

BattlefieldMenuActions:
		
		moveq   #$3D,d7 
		clr.w   d0
loc_251BC:
		jsr     j_GetCurrentHP
		tst.w   d1
		ble.w   loc_25226
		jsr     j_GetXPos
		cmp.w   d1,d2
		bne.w   loc_25226
		jsr     j_GetYPos
		cmp.w   d1,d3
		bne.w   loc_25226
		jsr     (WaitForCameraToCatchUp).w
		btst    #6,((P1_INPUT-$1000000)).w
		beq.s   loc_251F4
		jsr     j_MemberStatsScreen
		bra.s   loc_2521C
loc_251F4:
		cmp.w   -2(a6),d0
		bne.s   loc_251FC
		rts
loc_251FC:
		move.w  d0,((MOVING_BATTLE_ENTITY_IDX-$1000000)).w
		jsr     j_CreateFighterMiniStatusWindow
		jsr     j_CreateLandEffectWindow
		jsr     (WaitForPlayerInput).w
		jsr     j_HideLandEffectWindow
		jsr     j_HideFighterMiniStatusWindow
loc_2521C:
		cmp.w   -2(a6),d0
		bne.w   sub_2519E
		rts
loc_25226:
		addq.w  #1,d0
		cmpi.w  #$1E,d0
		bne.s   loc_25232
		move.w  #$80,d0 
loc_25232:
		dbf     d7,loc_251BC
loc_25236:
		lea     (InitStack).w,a0
		moveq   #0,d0
		moveq   #0,d1
		moveq   #4,d2
		jsr     j_ExecuteMenu
		cmpi.w  #$FFFF,d0
		beq.w   sub_2519E
		tst.w   d0
		bne.w   loc_25286
		jsr     j_UpdateForce
		move.w  ((NUMBER_OF_BATTLE_PARTY_MEMBERS-$1000000)).w,d7
		beq.s   loc_25236
		move.w  ((NUMBER_OF_BATTLE_PARTY_MEMBERS-$1000000)).w,d7
		move.w  d7,((word_FFB12E-$1000000)).w
		lea     ((BATTLE_PARTY_MEMBERS-$1000000)).w,a0
		lea     ((byte_FFB0AE-$1000000)).w,a1
		jsr     (CopyBytes).w   
loc_25274:
		jsr     sub_10040
		tst.b   d0
		bmi.s   loc_25236
		jsr     j_MemberStatsScreen
		bra.s   loc_25274
loc_25286:
		cmpi.w  #1,d0
		bne.w   loc_25296
		jsr     sub_10034
		bra.s   loc_25236
loc_25296:
		cmpi.w  #2,d0
		bne.w   loc_252A6
		jsr     sub_10080
		bra.s   loc_25236
loc_252A6:
		tst.b   ((CURRENT_BATTLE-$1000000)).w
		beq.s   loc_25236
		trap    #TEXTBOX
		dc.w 0                  ; "The game will be suspended.{N}OK?"
		jsr     j_YesNoChoiceBox
		trap    #TEXTBOX
		dc.w $FFFF
		tst.w   d0
		bmi.w   loc_25236
		move.l  ((SECONDS_COUNTER-$1000000)).w,((SECONDS_COUNTER_FROM_SRAM-$1000000)).w
		trap    #SET_FLAG
		dc.w $58                ; checks if a game has been saved for copying purposes? (or if saved from battle?)
		move.w  ((SAVE_SLOT_BEING_USED-$1000000)).w,d0
		                enableSram
		jsr     (SaveGame).l
                disableSram
		tst.b   ((DEBUG_MODE_ACTIVATED-$1000000)).w
		beq.w   loc_252E6
		btst    #INPUT_A_START_BIT,((P1_INPUT-$1000000)).w
		bne.w   loc_252F2
loc_252E6:
		trap    #SOUND_COMMAND
		dc.w SOUND_COMMAND_FADE_OUT
		jsr     (FadeOutToBlack).w
		jmp     (WitchSuspend).w
loc_252F2:
		trap    #CLEAR_FLAG
		dc.w $58                ; checks if a game has been saved for copying purposes? (or if saved from battle?)
		bra.w   loc_25236

	; End of function BattlefieldMenuActions


; =============== S U B R O U T I N E =======================================

sub_252FA:
		movem.l d0-a6,-(sp)
		move.w  -2(a6),d0
		jsr     j_GenerateTargetRangeLists
		bsr.w   CreateMoveableRangeForUnit
		move.w  -2(a6),d0
		move.w  -2(a6),d0
		bsr.w   UpdateMoveSound
		lea     (BATTLE_ENTITY_MOVE_STRING).l,a0
		jsr     MoveBattleEntityByMoveString
		move.w  -2(a6),d0
		move.w  d2,d1
		jsr     j_SetXPos
		move.w  d3,d1
		jsr     j_SetYPos
		bsr.w   ClearFadingBlockRange
		move.w  -2(a6),d0
		bsr.w   SetEntityBlinkingFlag
		move.w  ((BATTLESCENE_ACTION_TYPE-$1000000)).w,d0
		cmpi.w  #3,d0
		beq.w   loc_25480
		tst.w   d0
		bne.w   loc_2537E
		move.w  -2(a6),d0
		jsr     j_sub_C404
		jsr     (WaitForCameraToCatchUp).w
		bsr.w   CreateMoveableRangeForUnit
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  ((word_FFB630-$1000000)).w,d0
		move.w  d0,-4(a6)
		bsr.w   sub_2548E
		clr.w   d0
		bra.w   loc_2547A
loc_2537E:
		cmpi.w  #1,d0
		bne.w   loc_253BE
		move.w  ((word_FFB630-$1000000)).w,d1
		move.w  -2(a6),d0
		jsr     j_CreateSpellRangeGrid
		jsr     (WaitForCameraToCatchUp).w
		bsr.w   CreateMoveableRangeForUnit
		move.w  ((word_FFB630-$1000000)).w,d1
		jsr     j_GetSpellDefAddress
		move.b  6(a0),((word_FFAF8E-$1000000)).w
		move.w  ((word_FFB632-$1000000)).w,d0
		move.w  d0,-4(a6)
		bsr.w   sub_2548E
		clr.w   d0
		bra.w   loc_2547A
loc_253BE:
		cmpi.w  #2,d0
		bne.w   loc_2540A
		move.w  ((word_FFB630-$1000000)).w,d1
		move.w  -2(a6),d0
		jsr     j_CreateItemRangeGrid
		jsr     (WaitForCameraToCatchUp).w
		bsr.w   CreateMoveableRangeForUnit
		move.w  ((word_FFB630-$1000000)).w,d1
		jsr     j_GetItemDefAddress
		clr.w   d1
		move.b  9(a0),d1
		jsr     j_GetSpellDefAddress
		move.b  6(a0),((word_FFAF8E-$1000000)).w
		move.w  ((word_FFB632-$1000000)).w,d0
		move.w  d0,-4(a6)
		bsr.w   sub_2548E
		clr.w   d0
		bra.w   loc_2547A
loc_2540A:
		cmpi.w  #4,d0
		bne.w   loc_2544A
		move.w  ((word_FFB630-$1000000)).w,d1
		move.w  -2(a6),d0
		jsr     j_CreateSpellRangeGrid
		jsr     (WaitForCameraToCatchUp).w
		bsr.w   CreateMoveableRangeForUnit
		move.w  ((word_FFB630-$1000000)).w,d1
		jsr     j_GetSpellDefAddress
		move.b  6(a0),((word_FFAF8E-$1000000)).w
		move.w  ((word_FFB632-$1000000)).w,d0
		move.w  d0,-4(a6)
		bsr.w   sub_2548E
		clr.w   d0
		bra.w   loc_2547A
loc_2544A:
		cmpi.w  #6,d0
		bne.w   loc_2547A
		move.w  -2(a6),d0
		jsr     sub_1AC05C
		jsr     (WaitForCameraToCatchUp).w
		bsr.w   CreateMoveableRangeForUnit
		clr.b   ((word_FFAF8E-$1000000)).w
		move.w  ((word_FFB630-$1000000)).w,d0
		move.w  d0,-4(a6)
		bsr.w   sub_2548E
		clr.w   d0
		bra.w   *+4
loc_2547A:
		jsr     ClearFadingBlockRange
loc_25480:
		move.w  -2(a6),d0
		bsr.w   ClearEntityBlinkingFlag
		movem.l (sp)+,d0-a6
		rts

	; End of function sub_252FA


; =============== S U B R O U T I N E =======================================

sub_2548E:
		move.w  d0,-4(a6)
		move.w  -4(a6),d0
		jsr     j_GetXPos
		move.w  d1,d2
		jsr     j_GetYPos
		move.w  d1,d3
		move.w  -2(a6),d0
		jsr     j_GetXPos
		sub.w   d1,d2
		blt.s   loc_254B8
		moveq   #0,d4
		bra.s   loc_254BC
loc_254B8:
		moveq   #2,d4
		neg.w   d2
loc_254BC:
		jsr     j_GetYPos
		sub.w   d1,d3
		blt.s   loc_254CA
		moveq   #3,d5
		bra.s   loc_254CE
loc_254CA:
		moveq   #1,d5
		neg.w   d3
loc_254CE:
		cmp.w   d2,d3
		blt.s   loc_254D4
		move.w  d5,d4
loc_254D4:
		bsr.w   GetEntityNumberOfCombatant
		move.w  d4,d1
		moveq   #$FFFFFFFF,d2
		moveq   #$FFFFFFFF,d3
		jsr     (sub_6052).l    
		move.w  -4(a6),d0
		bsr.w   sub_2322C
		bsr.w   WaitForUnitCursor
		jsr     (WaitForCameraToCatchUp).w
		move.b  #1,((FIGHTER_IS_TARGETTING-$1000000)).w
		jsr     j_CreateFighterMiniStatusWindow
		moveq   #$F,d0
		jsr     (Sleep).w       
		trap    #SOUND_COMMAND
		dc.w SFX_VALIDATION
		rts

	; End of function sub_2548E


; =============== S U B R O U T I N E =======================================

UpdateAllEnemyAI:
		
		move.w  #$80,d0 
		moveq   #$1F,d7
loc_25512:
		move.w  d7,-(sp)
		bsr.w   UpdateEnemyAI
		move.w  (sp)+,d7
		addq.w  #1,d0
		dbf     d7,loc_25512

	; End of function UpdateAllEnemyAI


; =============== S U B R O U T I N E =======================================

UpdateEnemyAI:
		
		jsr     j_GetXPos
		tst.b   d1
		bmi.w   return_25542
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.w   return_25542
		tst.b   d0
		bpl.s   return_25542
		jsr     j_UpdateTriggeredRegionsAndAI
return_25542:
		rts

	; End of function UpdateEnemyAI


; =============== S U B R O U T I N E =======================================

CreateRandomizedTurnOrder:
		
		lea     ((BATTLE_TURN_ORDER-$1000000)).w,a0
		move.l  a0,-(sp)
		moveq   #$3F,d7 
loc_2554C:
		move.w  #$FFFF,(a0)+
		dbf     d7,loc_2554C
		movea.l (sp)+,a0
		clr.w   d0
		moveq   #$1D,d7
loc_2555A:
		move.w  d7,-(sp)
		bsr.w   AddRandomizedAGIToTurnOrder
		move.w  (sp)+,d7
		addq.w  #1,d0
		dbf     d7,loc_2555A
		move.w  #$80,d0 
		moveq   #$1D,d7
loc_2556E:
		move.w  d7,-(sp)
		bsr.w   AddRandomizedAGIToTurnOrder
		move.w  (sp)+,d7
		addq.w  #1,d0
		dbf     d7,loc_2556E
		moveq   #$3D,d6 
loc_2557E:
		moveq   #$3E,d7 
		lea     ((BATTLE_TURN_ORDER-$1000000)).w,a0
loc_25584:
		move.w  (a0),d0
		move.w  2(a0),d1
		cmp.b   d0,d1
		ble.s   loc_25594
		move.w  d1,(a0)
		move.w  d0,2(a0)
loc_25594:
		addq.l  #2,a0
		dbf     d7,loc_25584
		dbf     d6,loc_2557E
		clr.b   ((BATTLE_CURRENT_TURN_OFFSET-$1000000)).w
		rts

	; End of function CreateRandomizedTurnOrder


; =============== S U B R O U T I N E =======================================

; In: A0 = turn order in RAM
;     D0 = char idx    

AddRandomizedAGIToTurnOrder:
		
		jsr     j_GetXPos
		tst.b   d1
		bmi.w   return_2560E
		jsr     j_GetCurrentHP
		tst.w   d1
		beq.w   return_2560E
		jsr     j_GetCurrentAGI
		move.w  d1,d3
		andi.w  #CHAR_STATCAP_AGI_CURRENT,d1
		move.w  d1,d6
		lsr.w   #3,d6
		jsr     (UpdateRandomSeed).w
		add.w   d7,d1
		jsr     (UpdateRandomSeed).w
		sub.w   d7,d1
		moveq   #3,d6
		jsr     (UpdateRandomSeed).w
		subq.w  #1,d7
		add.w   d7,d1
		move.b  d0,(a0)+
		move.b  d1,(a0)+
		cmpi.w  #$80,d3 
		blt.s   return_2560E
		move.w  d3,d1
		andi.w  #CHAR_STATCAP_AGI_CURRENT,d1
		mulu.w  #5,d1
		divu.w  #6,d1
		move.w  d1,d6
		lsr.w   #3,d6
		jsr     (UpdateRandomSeed).w
		add.w   d7,d1
		jsr     (UpdateRandomSeed).w
		sub.w   d7,d1
		move.b  d0,(a0)+
		move.b  d1,(a0)+
return_2560E:
		rts

	; End of function AddRandomizedAGIToTurnOrder


; =============== S U B R O U T I N E =======================================

; load all battle properties

LoadBattle:
		move.w  d0,-(sp)
		clr.w   d1
		move.b  ((CURRENT_MAP-$1000000)).w,d1
		bsr.w   sub_258EA
		move.b  #$FF,((CAMERA_ENTITY-$1000000)).w
		jsr     (LoadMapTilesets).w
		bsr.w   WaitForFadeToFinish
		trap    #VINT_FUNCTIONS
		dc.w VINTS_CLEAR
		jsr     (WaitForVInt).w 
		jsr     j_MoveEntitiesToBattlePositions
		move.w  (sp)+,d0
		bsr.w   GetEntityNumberOfCombatant
		move.b  d0,((CAMERA_ENTITY-$1000000)).w
		bpl.s   loc_25646
		clr.w   d0
loc_25646:
		andi.w  #$3F,d0 
		lsl.w   #5,d0
		lea     ((ENTITY_DATA-$1000000)).w,a0
		adda.w  d0,a0
		move.w  (a0)+,d0
		ext.l   d0
		divs.w  #$180,d0
		move.b  d0,((BATTLE_ENTITY_CHOSEN_X-$1000000)).w
		move.w  (a0)+,d0
		ext.l   d0
		divs.w  #$180,d0
		move.b  d0,((BATTLE_ENTITY_CHOSEN_Y-$1000000)).w
		moveq   #$3F,d0 
		jsr     (InitSprites).w 
		move.w  #$FFFF,d0
		jsr     (LoadMap).w     
		jsr     (WaitForVInt).w 
		jsr     (LoadMapEntitySprites).w
		bsr.w   SetBattleVIntFunctions
		jsr     j_LoadBattleTerrainData
		jsr     (LoadBattleMusic).w
		jsr     (FadeInFromBlack).w
		cmpi.b  #BATTLEIDX_FAIRY_WOODS,((CURRENT_BATTLE-$1000000)).w
						; if battle 44, then special battle !
		bne.s   return_256A0
		jsr     j_SpecialBattle
return_256A0:
		rts

	; End of function LoadBattle

tbl_RelativeTileMoveX:
		dc.w 1
tbl_RelativeTileMoveY:
		dc.w 0
		dc.w 0
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w 0
		dc.w 1

; =============== S U B R O U T I N E =======================================

; In: D0 = combatant idx
; Out: D0 = new X
;      D1 = new Y

GetEntityPositionAfterApplyingFacing:
		
		movem.l d2-d3/a0,-(sp)
		jsr     j_GetXPos
		move.w  d1,d2
		jsr     j_GetYPos
		bsr.w   GetEntityCombatantNumber
		lsl.w   #ENTITYDEF_SIZE_BITS,d0
		lea     ((ENTITY_DATA-$1000000)).w,a0
		clr.w   d3
		move.b  ENTITYDEF_OFFSET_FACING(a0,d0.w),d3
		move.w  d2,d0
		lsl.w   #2,d3
		add.w   tbl_RelativeTileMoveX(pc,d3.w),d0
		add.w   tbl_RelativeTileMoveY(pc,d3.w),d1
		movem.l (sp)+,d2-d3/a0
		rts

	; End of function GetEntityPositionAfterApplyingFacing


; =============== S U B R O U T I N E =======================================

sub_256E6:
		movem.l d0-d2/d7,-(sp)
		move.w  d0,d2
		move.w  d1,d3
		clr.w   d0
		move.w  #$3D,d7 
loc_256F4:
		jsr     j_GetXPos
		cmp.w   d1,d2
		bne.w   loc_25712
		jsr     j_GetYPos
		cmp.w   d1,d3
		bne.w   loc_25712
		move.w  d0,d3
		bra.w   loc_25724
loc_25712:
		addq.w  #1,d0
		cmpi.w  #$1E,d0
		bne.s   loc_2571E
		move.w  #$80,d0 
loc_2571E:
		dbf     d7,loc_256F4
		moveq   #$FFFFFFFF,d3
loc_25724:
		movem.l (sp)+,d0-d2/d7
		rts

	; End of function sub_256E6


; =============== S U B R O U T I N E =======================================

PrintAllActivatedDefCons:
		
		moveq   #$5A,d1 
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		bsr.w   PrintActivatedDefCon
		trap    #TEXTBOX
		dc.w $FFFF
		rts

	; End of function PrintAllActivatedDefCons


; =============== S U B R O U T I N E =======================================

; if flag D1 is set, display def-con textbox

PrintActivatedDefCon:
		
		move.w  d1,-(sp)
		jsr     j_CheckFlag
		beq.s   loc_2578A
		subi.w  #$5A,d1 
		ext.l   d1
		move.l  d1,((TEXT_NUMBER-$1000000)).w
		trap    #TEXTBOX
		dc.w $1CF               ; "DEF-CON No. {#} has been{N}implemented.{D3}"
loc_2578A:
		move.w  (sp)+,d1
		addq.w  #1,d1
		rts

	; End of function PrintActivatedDefCon


; =============== S U B R O U T I N E =======================================

UpdateMoveSound:
		
		cmpi.b  #CODE_NOTHING_BYTE,((CURRENT_BATTLE-$1000000)).w
		bne.s   loc_2579E
		clr.w   ((MOVE_SOUND-$1000000)).w
		bra.s   loc_257A4
loc_2579E:
		move.w  #SFX_WALKING,((MOVE_SOUND-$1000000)).w
loc_257A4:
		movem.w d0-d7,-(sp)
		jsr     j_GetEquippedRing
		cmpi.w  #ITEMIDX_CHIRRUP_SANDALS,d1
						; HARDCODED chirrup sandals sfx
		bne.s   loc_257BA
		move.w  #SFX_BLOAB,((MOVE_SOUND-$1000000)).w
loc_257BA:
		movem.w (sp)+,d0-d7
		rts

	; End of function UpdateMoveSound

