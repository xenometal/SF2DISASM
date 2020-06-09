
; GAME SECTION 16 :
; 0x1D8000..0x1E0000 : Icons
; FREE SPACE : 126 bytes.


p_Icons:        dc.l Icons
Icons:          

                if (PROJECT_SF2GU=1)
                incbin "data/graphics/icons/icons-sf2gu.bin"
                else
                incbin "data/graphics/icons/icons.bin"
                endif
                
                align $1E0000
