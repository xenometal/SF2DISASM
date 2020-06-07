
; GAME SECTION 16 :
; 0x1D8000..0x1E0000 : Icons
; FREE SPACE : 126 bytes.


p_Icons:        dc.l Icons
Icons:          
                if (PROJECT_sfa2=1)
                incbin "data/graphics/icons/icons-sfa2.bin"
                else
                incbin "data/graphics/icons/icons.bin"
                endif
                
                align $1E0000
