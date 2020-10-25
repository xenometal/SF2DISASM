
; GAME SECTION 19 : ROM EXPANSION.

		include "data\battles\spritesetentries.asm"
		align $210000
		include "code\specialscreens\title\graphics.asm"		; Title Screen Graphics
		include "code\specialscreens\suspend\graphics.asm"		; Suspend String Graphics
		include "code\specialscreens\endkiss\graphics.asm"		; End Kiss Graphics
		include "code\specialscreens\credits\gamestaff.asm"		; Game Staff		
		include "code\specialscreens\jewelend\graphics.asm"		; Jewel End Graphics
		align $220000
        include "data\graphics\mapsprites\entries-sf2gu.asm"		; Map sprites (SF2GU)
		align $268000
		include "code\common\tech\graphics\specialspritesentries.asm"		; Special Sprites Entries
        align $26A000
        include "data\graphics\battles\battlesprites\enemies\entries-sf2gu.asm"		; Enemy battle sprites (SF2GU)
        wordAlign
        include "data\graphics\battles\battlesprites\allies\entries-sf2gu.asm"		; Ally battlesprites (SF2GU)
        wordAlign
        include "data\graphics\battles\weapons\entries-sf2gu.asm"
        wordAlign
        include "data\graphics\battles\weapons\palettes\entries-sf2gu.asm"
        align $3A3000
		include "data\graphics\battles\backgrounds\entries.asm"		; Backgrounds
        align $3CC000
		include "data\maps\entries.asm"		; Map entries table
		align $400000
