
; ASM FILE data\stats\allies\stats\sfcd-allystats00.asm :
; 
AllyStats00:    
; Syntax        forClass  [CLASS_]enum
;               hpGrowth  stat, [GROWTHTYPE_]enum
;               mpGrowth  stat, [GROWTHTYPE_]enum
;               atkGrowth stat, [GROWTHTYPE_]enum
;               defGrowth stat, [GROWTHTYPE_]enum
;               agiGrowth stat, [GROWTHTYPE_]enum
;               spellList parameter, [SPELL_]enum[|level],..parameter, [SPELL_]enum[|level]
;                    *or* useFirstSpellList
;
;         stat: starting value at join time in first block, level 99 projected value in second block
;
;    parameter: Level which spell is learned at.
;
;        level: LV1 = 0 (default when omitted)
;               LV2 = 64
;               LV3 = 128
;               LV4 = 192
;
; Note: Constant names ("enums"), shorthands (defined by macro), and numerical indexes are interchangeable.
                
                forClass SDMN               ; Swordsman
                hpGrowth  12, MIDDLE
                mpGrowth   8, LOW
                atkGrowth  6, HIGH
                defGrowth  6, HIGH
                agiGrowth  5, LOW
                spellList         &
                     1, EGRESS,   &
                    15, BOLT,     &
                    18, BOLT|LV2, &
                    22, BOLT|LV3, &
                    27, BOLT|LV4
                    
                forClass HERO               ; Hero
                hpGrowth  88, VERYHIGH
                mpGrowth  60, LOW
                atkGrowth 60, HIGH
                defGrowth 62, HIGH
                agiGrowth 30, MEDIUM
                useFirstSpellList
