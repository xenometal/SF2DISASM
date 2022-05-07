
; ASM FILE code\common\stats\levelup-sfcd.asm :
; Level up functions backported from Shining Force CD and optimized.

; =============== S U B R O U T I N E =======================================

LevelUp:
                
classIndex  = -4
character   = -2
                
                movem.l d0-a1,-(sp)
                link    a6,#-4
                move.w  d0,character(a6)
                bsr.w   GetClass
                move.w  d1,d3
                bsr.w   GetCurrentLevel
                
                ; Determine level cap for class
                moveq   #CHAR_LEVELCAP_PROMOTED,d2
                btst    #0,d3                   ; odd class index = promoted
                bne.s   @CheckLevelCap
                moveq   #CHAR_LEVELCAP_BASE,d2
                
@CheckLevelCap: cmp.w   d2,d1
                bhs.s   @Exit

                ; Get pointer to ally's first stats blocks
                lsl.w   #2,d0
                movea.l (p_pt_AllyStats).l,a0
                movea.l (a0,d0.w),a0
                
@FindStatsBlockForClass_Loop:
                tst.b   (a0)
                bmi.s   @Exit           ; exit function if no matching block found
                cmp.b   (a0)+,d3
                beq.s   @CalculateStatGains
                
@FindNextStatsBlock_Loop:
                cmpi.b  #ALLYSTATS_CODE_USE_FIRST_SPELL_LIST,(a0)+ ; loop until we come across an "end of spell list" control code
                bcs.s   @FindNextStatsBlock_Loop
                bra.s   @FindStatsBlockForClass_Loop
                
@Exit:          lea     ((byte_FFAF82-$1000000)).w,a1
                move.b  #$FF,(a1)+
                clr.l   (a1)+
                clr.b   (a1)+
                move.b  #$FF,(a1)
                bra.w   @Done
                
@CalculateStatGains:
                move.w  d3,classIndex(a6)
                lea     ((byte_FFAF82-$1000000)).w,a1   ; level up messages arguments
                move.w  character(a6),d0
                move.w  d1,d4               ; d4.w = current level
                moveq   #0,d5
                move.w  d1,d5
                divu.w  #5,d5               ; d5.w = growth type column index
                
                move.b  (a0)+,d2            ; d2.b = growth type row index
                move.b  (a0)+,d3            ; d3.b = projected stat value at level 99 (used if promoted and level 20+, unused otherwise)
                bsr.w   GetMaxHP            ; d1.w = current stats value
                bsr.w   CalculateStatGain
                move.b  d1,1(a1)
                bsr.w   IncreaseMaxHP
                
                move.b  (a0)+,d2
                move.b  (a0)+,d3
                bsr.w   GetMaxMP
                bsr.w   CalculateStatGain
                move.b  d1,2(a1)
                bsr.w   IncreaseMaxMP
                
                move.b  (a0)+,d2
                move.b  (a0)+,d3
                bsr.w   GetBaseATT
                bsr.w   CalculateStatGain
                move.b  d1,3(a1)
                bsr.w   IncreaseBaseATT
                
                move.b  (a0)+,d2
                move.b  (a0)+,d3
                bsr.w   GetBaseDEF
                bsr.w   CalculateStatGain
                move.b  d1,4(a1)
                bsr.w   IncreaseBaseDEF
                
                move.b  (a0)+,d2
                move.b  (a0)+,d3
                bsr.w   GetBaseAGI
                bsr.w   CalculateStatGain
                move.b  d1,5(a1)
                bsr.w   IncreaseBaseAGI
                
                ; Increase level
                addq.w  #1,d4
                move.w  d4,d1
                bsr.w   SetLevel
                move.b  d4,(a1)
                
                ; Add extra levels if promoted
                btst    #0,classIndex(a6)           ; odd class index = promoted
                beq.s   @Continue
                addi.w  #CHAR_CLASS_EXTRALEVEL,d4
                
@Continue:      move.b  #$FF,6(a1)
                
@FindAllLearnableSpells_Loop:
                bsr.s   FindNextLearnableSpell
                tst.w   d2
                bne.s   @Next
                move.b  d1,6(a1)
                moveq   #0,d2
@Next:          bpl.s   @FindAllLearnableSpells_Loop    ; loop until FindNextLearnableSpell returns d2.w = -1
                
                bsr.w   ApplyStatusEffectsAndItemsOnStats
                
@Done:          unlk    a6
                movem.l (sp)+,d0-a1
                rts

    ; End of function LevelUp


; =============== S U B R O U T I N E =======================================

; In: d0.w = ally index
;     d4.w = current level
;
; Out: d2.w = 0: successfully learned spell
;             1: failure : same or higher level spell already known
;             2: failure : all spell slots already occupied
;            -1: current level is too low, or end of spell list has been reached

                module
@GetFirstSpellList:
                move.w  d0,d2
                lsl.w   #2,d2
                movea.l (p_pt_AllyStats).l,a0
                movea.l (a0,d2.w),a0
                lea     ALLYSTATS_OFFSET_SPELL_LIST(a0),a0
                
FindNextLearnableSpell:
                move.b  (a0)+,d2            ; d2 = level which spell is learned at
                move.b  (a0)+,d1            ; d1 = spell index
                cmp.b   d2,d4
                bhs.w   LearnSpell
                
                cmpi.b  #ALLYSTATS_CODE_USE_FIRST_SPELL_LIST,d2
                beq.s   @GetFirstSpellList
                
                moveq   #-1,d2
                rts
                modend
                
    ; End of function FindNextLearnableSpell


; =============== S U B R O U T I N E =======================================

; In: d1.w = current stat value
;     d2.b = growth type row index
;     d3.b = projected stat value at level 99 (used if promoted and level 20+, unused otherwise)
;     d4.w = current level
;     d5.w = growth type column index
;
; Out: d1.w = stat gain value

CalculateStatGain:
                movem.l d5-a0,-(sp)
                ext.w   d2
                ext.w   d3
                cmpi.w  #4,d5   
                blo.s   @Regular
                
                ; Default growth calculation when level is 20+
                moveq   #99,d2
                sub.w   d4,d2           ; d2 = 99 - current level
                sub.w   d1,d3
                move.w  d3,d1
                asl.w   #4,d1           ; d1 = (projected stat - current stat) * 16
                ext.l   d1
                divs.w  d2,d1
                moveq   #4,d6
                bra.s   @Randomize
                
@Regular:       lsl.w   #2,d2
                add.w   d5,d2
                move.b  tbl_GrowthTypeDefs(pc,d2.w),d5
                add.w   d5,d5
                lea     tbl_GrowthAttributes(pc,d5.w),a0
                clr.w   d1
                clr.w   d6
                move.b  (a0)+,d1        ; d1 = base value
                move.b  (a0)+,d6        ; d6 = variance
                beq.s   @Skip           ; skip randomization if variance = 0
                
@Randomize:     jsr     (GenerateRandomNumber).w
                add.w   d7,d1
                jsr     (GenerateRandomNumber).w
                sub.w   d7,d1
                
@Skip:          tst.w   d1              ; clamp randomized value down to 0
                bpl.s   @Continue
                clr.w   d1
                
@Continue:      addq.w  #8,d1
                lsr.w   #4,d1           ; stat gain value = (randomized value + 8) / 16, rounded down
                movem.l (sp)+,d5-a0
                rts
                
    ; End of function CalculateStatGain

tbl_GrowthTypeDefs:
                ; Growth attribute indexes for current level ranges 1-4, 5-9, 10-14, and 15-19, respectively
                dc.b 0, 0, 0, 0     ; 0: None
                dc.b 5, 5, 2, 2     ; 1: Type A (Low)
                dc.b 3, 3, 2, 2     ; 2: Type B (Moderate)
                dc.b 4, 4, 3, 3     ; 3: Type C (High)
                dc.b 6, 6, 4, 4     ; 4: Type D (Very High)
                dc.b 2, 4, 6, 6     ; 5: Type E (Late)
                dc.b 7, 6, 3, 1     ; 6: Type F (Early)
                dc.b 2, 6, 4, 1     ; 7: Type G (Middle)
                
tbl_GrowthAttributes:   
                ; base value, variance
                dc.b 0, 0           ; 0: No growth
                dc.b 3, 10          ; 1: Stunted        =  0 (73.7%), +1 (26.3%)
                dc.b 7, 6           ; 2: Very Bad       =  0 (54.5%), +1 (45.4%)
                dc.b 14, 12         ; 3: Mediocre       =  0 (17.4%), +1 (73.9%), +2 (8.7%)
                dc.b 23, 6          ; 4: Good           = +1 (54.5%), +2 (45.5%)
                dc.b 10, 6          ; 5: Bad            =  0 (27.3%), +1 (72.7%)
                dc.b 37, 4          ; 6: Very Good      = +2 (85.7%), +3 (14.3%)
                dc.b 43, 8          ; 7: Exceptional    = +2 (26.7%), +3 (73.3%)


; =============== S U B R O U T I N E =======================================

; In: d0.w = ally index
;     d1.w = starting level

InitCharacterStats:
                
                movem.l d0-d2/a0,-(sp)
                move.w  d1,d4           ; d4.w = copy of starting level
                
                ; Get ally stats entry address -> a0
                move.w  d0,d2
                lsl.w   #2,d2
                movea.l (p_pt_AllyStats).l,a0
                movea.l (a0,d2.w),a0
                
                ; Set starting values
                clr.w   d1
                bsr.w   SetCurrentEXP
                bsr.w   SetStatus
                bsr.w   SetCharacterWord34
                
                addq.w  #2,a0
                move.b  (a0)+,d1
                bsr.w   SetMaxHP
                bsr.w   SetCurrentHP
                
                clr.w   d1
                addq.w  #1,a0
                move.b  (a0)+,d1
                bsr.w   SetMaxMP
                bsr.w   SetCurrentMP
                
                clr.w   d1
                addq.w  #1,a0
                move.b  (a0)+,d1
                bsr.w   SetBaseATT
                
                clr.w   d1
                addq.w  #1,a0
                move.b  (a0)+,d1
                bsr.w   SetBaseDEF
                
                clr.w   d1
                addq.w  #1,a0
                move.b  (a0)+,d1
                bsr.w   SetBaseAGI
                
                move.w  d4,d1
                bsr.w   SetLevel
                
                ; Determine effective level
                bsr.w   GetClass        
                btst    #0,d1                       ; odd class index = promoted
                beq.s   @FindStatsBlockForClass
                addi.w  #CHAR_CLASS_EXTRALEVEL,d4   ; add 20 to effective level if promoted
                
@FindStatsBlockForClass:
                move.w  d0,d2
                lsl.w   #2,d2
                movea.l (p_pt_AllyStats).l,a0
                movea.l (a0,d2.w),a0
                
@FindStatsBlockForClass_Loop:
                tst.b   (a0)
                bmi.w   @Done               ; exit function if "for class" entry is negative (this shouldn't happen)
                cmp.b   (a0)+,d1
                beq.s   @Continue           ; break out of loop once we found a matching stats block for starting class
                
@FindNextStatsBlock_Loop:
                cmpi.b  #ALLYSTATS_CODE_USE_FIRST_SPELL_LIST,(a0)+
                bcs.s   @FindNextStatsBlock_Loop ; parse stats block bytes until we come across a spell list control code
                bra.s   @FindStatsBlockForClass_Loop
                
@Continue:      lea     ALLYSTATS_OFFSET_SPELL_LIST-1(a0),a0
                
@FindAllLearnableSpells_Loop:
                bsr.w   FindNextLearnableSpell
                tst.w   d2
                bpl.s   @FindAllLearnableSpells_Loop    ; loop until FindNextLearnableSpell returns d2.w = -1
                
@Done:          movem.l (sp)+,d0-d2/a0
                rts

    ; End of function InitCharacterStats

