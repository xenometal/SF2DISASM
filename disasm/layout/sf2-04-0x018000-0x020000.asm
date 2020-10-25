
; GAME SECTION 04 :
; 0x018000..0x020000 : BattleScene Engine
; FREE SPACE : 532 bytes.


                include "code\gameflow\battle\battlescenes\battlesceneengine_0.asm"    ; Battlescene engine
                include "data\stats\allies\allybattlesprites-sf2gu.asm"    ; Ally battle sprites table (SF2GU)
                include "data\stats\enemies\enemybattlesprites-sf2gu.asm"    ; Enemy battle sprites table (SF2GU)
				include "data\stats\items\weapongraphics-sf2gu.asm"    ; Weapon graphics table (SF2GU)
                include "data\battles\global\custombackgrounds.asm"    ; Battle custom backgrounds table
                include "code\gameflow\battle\battlescenes\battlesceneengine_1.asm"    ; Battlescene engine
                include "data\graphics\battles\battlesprites\allyidlebattlesprites-sf2gu.asm"    ; Ally Idle Battle Sprites (SF2GU)
                include "data\graphics\battles\battlesprites\enemyidlebattlesprites-sf2gu.asm"    ; Enemy Idle Battle Sprites (SF2GU)
                include "code\gameflow\battle\battlescenes\battlesceneengine_2.asm"    ; Battlescene engine
                include "data\stats\allies\centaurbattlesprites-sf2gu.asm" ; Centaur battle sprite and spear throw animation indexes table
                align $20000
