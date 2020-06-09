
; GAME SECTION 19 : ROM EXPANSION.

		include "data\battles\spritesetentries.asm"
		align $210000
		include "code\specialscreens\title\graphics.asm"		; Title Screen Graphics
		include "code\specialscreens\suspend\graphics.asm"		; Suspend String Graphics
		include "code\specialscreens\endkiss\graphics.asm"		; End Kiss Graphics
		include "code\specialscreens\credits\gamestaff.asm"		; Game Staff		
		include "code\specialscreens\jewelend\graphics.asm"		; Jewel End Graphics
		align $220000
        
        if (PROJECT_SF2GU=1)
        include "data\graphics\mapsprites\sf2gu\entries.asm"
        else
		include "data\graphics\mapsprites\entries.asm"		; Map sprites
        endif
        
		align $268000
		include "code\common\tech\graphics\specialspritesentries.asm"		; Special Sprites Entries
        
        if (PROJECT_SF2GU=1)
        align $26A000
        include "data\graphics\battles\battlesprites\enemies-sf2gu\entries.asm"
        wordAlign
        include "data\graphics\battles\battlesprites\allies-sf2gu\entries.asm"
        wordAlign
        include "data\graphics\battles\weapons\sf2gu\entries.asm"
        wordAlign
        include "data\graphics\battles\weapons\sf2gu\palettes\entries.asm"
        align $3A3000
        else
		align $270000
		include "data\graphics\battles\battlesprites\enemies\entries.asm"		; Enemy battle sprites
        align $2D0000
		include "data\graphics\battles\battlesprites\allies\entries.asm"		; Ally battlesprites
        align $320000
        endif
        
		include "data\graphics\battles\backgrounds\entries.asm"		; Backgrounds
        
        if (PROJECT_SF2GU=1)
        align $3CC000
        else
		align $380000
        endif
        
		include "data\maps\entries.asm"		; Map entries table
		align $400000
						
