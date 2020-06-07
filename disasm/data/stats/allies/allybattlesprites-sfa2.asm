
; ASM FILE data\stats\allies\allybattlesprites-sfa2.asm :
; 0x1F806..0x1F914 : Ally battle sprites table

AllyBattleSpritesTable:

; 3 entries per ally, 3 bytes each :
;               forClass         enum Classes : CLASS_*
;               allyBattleSprite enum AllyBattleSprites : ALLYBATTLESPRITE_*, Pallete index
    
                forClass SDMN                       ; BOWIE
                allyBattleSprite BOWIE_BASE, 0
                forClass HERO
                allyBattleSprite BOWIE_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass PRST                       ; SARAH
                allyBattleSprite SARAH_BASE, 0
                forClass VICR
                allyBattleSprite SARAH_PROMO, 0
                forClass MMNK
                allyBattleSprite SARAH_SPECIAL, 0
                    
                forClass KNTE                       ; CHESTER
                allyBattleSprite CHESTER_BASE, 0
                forClass PLDN
                allyBattleSprite CHESTER_PROMO, 0
                forClass PGNT
                allyBattleSprite CHESTER_SPECIAL, 0
                    
                forClass WARR                       ; JAHA
                allyBattleSprite JAHA_BASE, 0
                forClass GLDT
                allyBattleSprite JAHA_PROMO, 0
                forClass BRN
                allyBattleSprite JAHA_SPECIAL, 0
                    
                forClass MAGE                       ; KAZIN
                allyBattleSprite KAZIN_BASE, 0
                forClass WIZ
                allyBattleSprite KAZIN_PROMO, 0
                forClass SORC
                allyBattleSprite KAZIN_SPECIAL, 0
                    
                forClass THIF                       ; SLADE
                allyBattleSprite SLADE_BASE, 0
                forClass NINJ
                allyBattleSprite SLADE_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass TORT                       ; KIWI
                allyBattleSprite KIWI_BASE, 0
                forClass MNST
                allyBattleSprite KIWI_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass PHNK                       ; PETER
                allyBattleSprite PETER_BASE, 0
                forClass PHNX
                allyBattleSprite PETER_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass RNGR                       ; MAY
                allyBattleSprite MAY_BASE, 0
                forClass BWNT
                allyBattleSprite MAY_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass WFMN                       ; GERHALT
                allyBattleSprite GERHALT_BASE, 0
                forClass WFBR
                allyBattleSprite GERHALT_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass BDMN                       ; LUKE
                allyBattleSprite LUKE_BASE, 0
                forClass BDBT
                allyBattleSprite LUKE_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass BRGN                       ; ROHDE
                allyBattleSprite ROHDE_SPECIAL, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass KNTE                       ; RICK
                allyBattleSprite RICK_BASE, 0
                forClass PLDN
                allyBattleSprite RICK_PROMO, 0
                forClass PGNT
                allyBattleSprite RICK_SPECIAL, 0
                    
                forClass ACHR                       ; ELRIC
                allyBattleSprite ELRIC_BASE, 0
                forClass SNIP
                allyBattleSprite ELRIC_PROMO, 0
                forClass BRGN
                allyBattleSprite ELRIC_SPECIAL, 0
                    
                forClass KNTE                       ; ERIC
                allyBattleSprite ERIC_BASE, 0
                forClass PLDN
                allyBattleSprite ERIC_PROMO, 0
                forClass PGNT
                allyBattleSprite ERIC_SPECIAL, 0
                    
                forClass PRST                       ; KARNA
                allyBattleSprite KARNA_BASE, 0
                forClass VICR
                allyBattleSprite KARNA_PROMO, 0
                forClass MMNK
                allyBattleSprite KARNA_SPECIAL, 0
                    
                forClass WARR                       ; RANDOLF
                allyBattleSprite RANDOLF_BASE, 0
                forClass GLDT
                allyBattleSprite RANDOLF_PROMO, 0
                forClass BRN
                allyBattleSprite RANDOLF_SPECIAL, 0
                    
                forClass MAGE                       ; TYRIN
                allyBattleSprite TYRIN_BASE, 0
                forClass WIZ
                allyBattleSprite TYRIN_PROMO, 0
                forClass SORC
                allyBattleSprite TYRIN_SPECIAL, 0
                    
                forClass ACHR                       ; JANET
                allyBattleSprite JANET_BASE, 0
                forClass SNIP
                allyBattleSprite JANET_PROMO, 0
                forClass BRGN
                allyBattleSprite JANET_SPECIAL, 0
                    
                forClass PLDN                       ; HIGINS
                allyBattleSprite HIGINS_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass BDBT                       ; SKREECH
                allyBattleSprite SCREECH_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass SORC                       ; TAYA
                allyBattleSprite TAYA_SPECIAL, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass VICR                       ; FRAYJA
                allyBattleSprite FRAYJA_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass PGNT                       ; JARO
                allyBattleSprite JARO_SPECIAL, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass GLDT                       ; GYAN
                allyBattleSprite GYAN_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass MMNK                       ; SHEELA
                allyBattleSprite SHEELA_SPECIAL, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass RBT                        ; ZYNK
                allyBattleSprite ZYNK, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass WIZ                        ; CHAZ
                allyBattleSprite CHAZ_PROMO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass RDBN                       ; LEMON
                allyBattleSprite LEMON, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass GLM                        ; CLAUDE
                allyBattleSprite CLAUDE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                
                ; Additional entries to be defined with force members expansion patch
                if (FORCE_MEMBERS_EXPANSION=1)
                
                forClass RDBN
                allyBattleSprite SDMN, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                
                forClass RDBN
                allyBattleSprite SDMN, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                
                endif
