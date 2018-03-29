
; GAME SECTION 16 :
; 0x1D8000..0x1E0000 : Icons
; FREE SPACE : 126 bytes.


;p_Icons:        dc.l Icons
;Icons:          incbin "data/graphics/icons/icons.bin"
; ---------------------------------------------------------------------------
ItemDefs:       incbin "data/stats/items/itemdefs.bin"
SpellDefs:      incbin "data/stats/spells/spelldefs.bin"
ItemNames:      incbin "data/stats/items/itemnames.bin"
SpellNames:     incbin "data/stats/spells/spellnames.bin"
; ---------------------------------------------------------------------------
		align $1E0000
