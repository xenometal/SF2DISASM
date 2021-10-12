
; ASM FILE data\stats\allies\stats\allystats00.asm :
; 0x1EE2F0..0x1EE31C : Ally stats 00
AllyStats00:    
; Syntax        forClass  [CLASS_]enum
;               hpGrowth  start, projected, [GROWTHCURVE_]enum
;               mpGrowth  start, projected, [GROWTHCURVE_]enum
;               attGrowth start, projected, [GROWTHCURVE_]enum
;               defGrowth start, projected, [GROWTHCURVE_]enum
;               agiGrowth start, projected, [GROWTHCURVE_]enum
;               spellList parameter, [SPELL_]enum[|level],..parameter, [SPELL_]enum[|level]
;                    *or* useFirstSpellList
;
;    parameter: Level which spell is learned at.
;
;        level: LV1 = 0 (default when omitted)
;               LV2 = 64
;               LV3 = 128
;               LV4 = 192
;
; Note: Constant names ("enums"), shorthands (defined by macro), and numerical indexes are interchangeable.
                
                forClass  HERO
                hpGrowth  127, 0, NONE
                mpGrowth  23, 0, NONE
                attGrowth 74, 0, NONE
                defGrowth 69, 0, NONE
                agiGrowth 71, 0, NONE
                spellList &
                    22, BOLT, &
                    31, BOLT|LV2, &
                    33, AURA, &
                    42, BOLT|LV3, &
                    41, AURA|LV2, &
                    51, BOLT|LV4
                    
