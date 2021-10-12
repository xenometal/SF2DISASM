
; ASM FILE data\stats\allies\stats\allystats04.asm :
; 0x1EE3D1..0x1EE426 : Ally stats 04
AllyStats04:    forClass  SORC
                hpGrowth  96, 0, NONE
                mpGrowth  90, 0, NONE
                attGrowth 53, 0, NONE
                defGrowth 45, 0, NONE
                agiGrowth 75, 0, NONE
                spellList &
                    1, FREEZE, &
                    7, FREEZE|LV2, &
                    9, MUDDLE, &
                    18, FREEZE|LV3, &
                    22, ATTACK, &
                    29, FREEZE|LV4
                    
