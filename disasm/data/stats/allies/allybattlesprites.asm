
; ASM FILE data\stats\allies\allybattlesprites.asm :
; 0x1F806..0x1F914 : Ally battle sprites table
AllyBattleSpritesTable:
                ; 3 entries per ally, 3 bytes each :
;  forClass         enum Classes : CLASS_*
;  allyBattleSprite enum AllyBattleSprites : ALLYBATTLESPRITE_*, Pallete ID
    
                forClass SDMN           ; BOWIE
                allyBattleSprite Bowie_base, 0
                forClass HERO
                allyBattleSprite HERO, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass PRST           ; SARAH
                allyBattleSprite Sarah_Base, 0
                forClass VICR
                allyBattleSprite Sarah_Promo, 0
                forClass MMNK
                allyBattleSprite Sarah_Special, 0
                    
                forClass KNTE           ; CHESTER
                allyBattleSprite Chester_Base, 0
                forClass PLDN
                allyBattleSprite Chester_Promo, 0
                forClass PGNT
                allyBattleSprite Chester_Special, 0
                    
                forClass WARR           ; JAHA
                allyBattleSprite Jaha_Base, 0
                forClass GLDT
                allyBattleSprite Jaha_Promo, 0
                forClass BRN
                allyBattleSprite Jaha_Special, 0
                    
                forClass MAGE           ; KAZIN
                allyBattleSprite Kazin_Base, 0
                forClass WIZ
                allyBattleSprite Kazin_Promo, 0
                forClass SORC
                allyBattleSprite Kazin_Special, 0
                    
                forClass THIF           ; SLADE
                allyBattleSprite Slade_Base, 0
                forClass NINJ
                allyBattleSprite Slade_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass TORT           ; KIWI
                allyBattleSprite Kiwi_Base, 0
                forClass MNST
                allyBattleSprite Kiwi_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass PHNK           ; PETER
                allyBattleSprite Peter_Base, 0
                forClass PHNX
                allyBattleSprite Peter_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass RNGR           ; MAY
                allyBattleSprite May_Base, 0
                forClass BWNT
                allyBattleSprite May_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass WFMN           ; GERHALT
                allyBattleSprite Gerhalt_Base, 0
                forClass WFBR
                allyBattleSprite Gerhalt_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass BDMN           ; LUKE
                allyBattleSprite Luke_Base, 0
                forClass BDBT
                allyBattleSprite Luke_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass BRGN           ; ROHDE
                allyBattleSprite Rohde_Special, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass KNTE           ; RICK
                allyBattleSprite Rick_Base, 0
                forClass PLDN
                allyBattleSprite Rick_Promo, 0
                forClass PGNT
                allyBattleSprite Rick_Special, 0
                    
                forClass ACHR           ; ELRIC
                allyBattleSprite Elric_Base, 0
                forClass SNIP
                allyBattleSprite Elric_Promo, 0
                forClass BRGN
                allyBattleSprite Elric_Special, 0
                    
                forClass KNTE           ; ERIC
                allyBattleSprite Eric_Base, 0
                forClass PLDN
                allyBattleSprite Eric_Promo, 0
                forClass PGNT
                allyBattleSprite Eric_Special, 0
                    
                forClass PRST           ; KARNA
                allyBattleSprite Karna_Base, 0
                forClass VICR
                allyBattleSprite Karna_Promo, 0
                forClass MMNK
                allyBattleSprite Karna_Special, 0
                    
                forClass WARR           ; RANDOLF
                allyBattleSprite Randolf_Base, 0
                forClass GLDT
                allyBattleSprite Randolf_Promo, 0
                forClass BRN
                allyBattleSprite Randolf_Special, 0
                    
                forClass MAGE           ; TYRIN
                allyBattleSprite Tyrin_Base, 0
                forClass WIZ
                allyBattleSprite Tyrin_Promo, 0
                forClass SORC
                allyBattleSprite Tryin_Special, 0
                    
                forClass ACHR           ; JANET
                allyBattleSprite Janet_Base, 0
                forClass SNIP
                allyBattleSprite Janet_Promo, 0
                forClass BRGN
                allyBattleSprite Janet_Special, 0
                    
                forClass PLDN           ; HIGINS
                allyBattleSprite Higins_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass BDBT           ; SKREECH
                allyBattleSprite Screech_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass SORC           ; TAYA
                allyBattleSprite Taya_Special, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass VICR           ; FRAYJA
                allyBattleSprite Fraiyja_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass PGNT           ; JARO
                allyBattleSprite Jaro_Special, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass GLDT           ; GYAN
                allyBattleSprite Gyan_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass MMNK           ; SHEELA
                allyBattleSprite Sheela_Special, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass RBT            ; ZYNK
                allyBattleSprite Zynk_Special, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass WIZ            ; CHAZ
                allyBattleSprite Chaz_Promo, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass RDBN           ; LEMON
                allyBattleSprite Lemon_Special, 0
                forClass NONE
                allyBattleSprite NONE, 0
                forClass NONE
                allyBattleSprite NONE, 0
                    
                forClass GLM            ; CLAUDE
                allyBattleSprite Claude_Special, 0
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
                
                    
