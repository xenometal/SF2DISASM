
; GAME SECTION 04 :
; 0x018000..0x020000 : BattleScene Engine
; FREE SPACE : 532 bytes.


                if (PROJECT_SF2GU=1)
                include "code\gameflow\battle\battlescenes\battlesceneengine_0-sf2gu_0.asm"    ; Battlescene engine
                include "code\gameflow\battle\battlescenes\getallyanimation-sf2gu.asm"    ; GetAllyAnimation routine (alternate implementation)
                align $19838
                include "code\gameflow\battle\battlescenes\battlesceneengine_0-sf2gu_1.asm"    ; Battlescene engine
                include "data\stats\allies\allybattlesprites-sf2gu.asm"
                include "data\stats\enemies\enemybattlesprites-sf2gu.asm"
                else
                include "code\gameflow\battle\battlescenes\battlesceneengine_0.asm"    ; Battlescene engine
                include "data\stats\allies\allybattlesprites.asm"    ; Ally battle sprites table
                include "data\stats\enemies\enemybattlesprites.asm"    ; Enemy battle sprites table
                endif
                
                include "data\stats\items\weapongraphics-sf2gu.asm"    ; Weapon graphics table
                include "data\battles\global\custombackgrounds.asm"    ; Battle custom backgrounds table
                include "code\gameflow\battle\battlescenes\battlesceneengine_1.asm"    ; Battlescene engine
                
                if (PROJECT_SF2GU=1)
                include "data\graphics\battles\battlesprites\allyidlebattlesprites-sf2gu.asm"
                include "data\graphics\battles\battlesprites\enemyidlebattlesprites-sf2gu.asm"
                else
                include "data\graphics\battles\battlesprites\allyidlebattlesprites.asm"    ; Ally Idle Battle Sprites
                include "data\graphics\battles\battlesprites\enemyidlebattlesprites.asm"    ; Enemy Idle Battle Sprites
                endif
                
                include "code\gameflow\battle\battlescenes\battlesceneengine_2.asm"    ; Battlescene engine
                
                if (PROJECT_SF2GU=1)
                include "data\stats\allies\centaurbattlesprites-sf2gu.asm" ; Centaur battle sprite and spear throw animation indexes table
                endif
                
                align $20000
