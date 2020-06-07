
; GAME SECTION 04 :
; 0x018000..0x020000 : BattleScene Engine
; FREE SPACE : 532 bytes.


                include "code\gameflow\battle\battlescenes\battlesceneengine_0.asm"    ; Battlescene engine
                
                if (PROJECT_sfa2=1)
                include "data\stats\allies\allybattlesprites-sfa2.asm"
                include "data\stats\enemies\enemybattlesprites-sfa2.asm"
				include "data\stats\items\weapongraphics-sfa2.asm"
                else
                include "data\stats\allies\allybattlesprites.asm"    ; Ally battle sprites table
                include "data\stats\enemies\enemybattlesprites.asm"    ; Enemy battle sprites table
				include "data\stats\items\weapongraphics.asm"    ; Weapon graphics table
                endif
                
                include "data\battles\global\custombackgrounds.asm"    ; Battle custom backgrounds table
                include "code\gameflow\battle\battlescenes\battlesceneengine_1.asm"    ; Battlescene engine
                
                if (PROJECT_sfa2=1)
                include "data\graphics\battles\battlesprites\allyidlebattlesprites-sfa2.asm"
                include "data\graphics\battles\battlesprites\enemyidlebattlesprites-sfa2.asm"
                else
                include "data\graphics\battles\battlesprites\allyidlebattlesprites.asm"    ; Ally Idle Battle Sprites
                include "data\graphics\battles\battlesprites\enemyidlebattlesprites.asm"    ; Enemy Idle Battle Sprites
                endif
                
                include "code\gameflow\battle\battlescenes\battlesceneengine_2.asm"    ; Battlescene engine
                
                if (PROJECT_sfa2=1)
                include "data\stats\allies\centaurbattlesprites-sfa2.asm" ; Centaur battle sprite and spear throw animation indexes table
                endif
                
                align $20000
