
; ASM FILE data\stats\allies\stats\allystats01.asm :
; 0x1EE31C..0x1EE36B : Ally stats 01
AllyStats01:    forClass  MMNK
                hpGrowth  105, 0, NONE
                mpGrowth  58, 0, NONE
                attGrowth 69, 0, NONE
                defGrowth 51, 0, NONE
                agiGrowth 76, 0, NONE
                spellList &
                    1, HEAL, &
                    4, BLAST, &
                    7, HEAL|LV2, &
                    10, BOOST, &
                    13, BLAST|LV2, &
                    16, SLOW, &
                    19, HEAL|LV3, &
                    22, BLAST|LV3, &
                    25, BOOST|LV2, &
                    29, SLOW|LV2, &
                    33, BLAST|LV4, &
                    36, HEAL|LV4, &
                    
