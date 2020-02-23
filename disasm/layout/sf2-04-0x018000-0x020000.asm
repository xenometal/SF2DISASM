
; GAME SECTION 04 :
; 0x018000..0x020000 : BattleScene Engine
; FREE SPACE : 532 bytes.


                include "code\gameflow\battle\battlescenes\battlesceneengine_0.asm"    ; Battlescene engine
                
                if (PROJECT_SF2GU=1)
                include "data\stats\allies\allybattlesprites-sf2gu.asm"
                else
                include "data\stats\allies\allybattlesprites.asm"    ; Ally battle sprites table
                endif
                
                include "data\stats\enemies\enemybattlesprites.asm"    ; Enemy battle sprites table
                include "data\stats\items\weapongraphics.asm"    ; Weapon graphics table
                include "data\battles\global\custombackgrounds.asm"    ; Battle custom backgrounds table
                include "code\gameflow\battle\battlescenes\battlesceneengine_1.asm"    ; Battlescene engine
                
                if (PROJECT_SF2GU=1)
                include "data\graphics\battles\battlesprites\allyidlebattlesprites-sf2gu.asm"
                else
                include "data\graphics\battles\battlesprites\allyidlebattlesprites.asm"    ; Ally Idle Battle Sprites
                endif
                
                include "data\graphics\battles\battlesprites\enemyidlebattlesprites.asm"    ; Enemy Idle Battle Sprites
                include "code\gameflow\battle\battlescenes\battlesceneengine_2.asm"    ; Battlescene engine
                align $20000
