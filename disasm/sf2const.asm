; SF2CONST.ASM INCLUDED AT START OF SF2.ASM

; START OF SEGMENT SRAM OFFSETS FROM SRAM:00200000 TO 0:00204000
SRAM_START: equ $200001
SAVED_ERRCODE_BYTE0: equ $200081
SAVED_ERRCODE_BYTE1: equ $200083
SAVED_ERRCODE_BYTE2: equ $200085
SAVED_ERRCODE_BYTE3: equ $200087
SAVED_ERRCODE_BYTE4: equ $200089
SAVED_ERRCODE_BYTE5: equ $20008B
SAVED_ERRCODE_BYTE6: equ $20008D
SAVED_ERRCODE_BYTE7: equ $20008F
SAVE1_CHARACTER_DATA: equ $2000B1
SRAM_STRING: equ $202011
SAVE_FLAGS: equ $202035
SAVE1_CHECKSUM: equ $202037
SAVE2_CHECKSUM: equ $202039
SAVE2_CHARACTER_DATA: equ $20203B
; END OF SEGMENT SRAM OFFSETS FROM SRAM:00200000 TO 0:00204000

; START OF SEGMENT Z80 OFFSETS FROM Z80:A00000 TO 0:00A0FFFF
Z80_Memory: equ $A00000
Z80_CHANNEL_1_NOT_IN_USE: equ $A01383
Z80_SoundDriverFadeInData: equ $A01FFC
Z80_SoundDriverMusicLevel: equ $A01FFD
Z80_SoundDriverCommand: equ $A01FFF
; END OF SEGMENT Z80 OFFSETS FROM Z80:A00000 TO 0:00A0FFFF

; START OF SEGMENT IO OFFSETS FROM IO:A10000 TO 0:00A10FFF
HW_Info: equ $A10001
DATA1: equ $A10003
DATA2: equ $A10005
DATA3: equ $A10007
CTRL1: equ $A10008
CTRL1_BIS: equ $A10009
CTRL2: equ $A1000B
CTRL3: equ $A1000C
CTRL3_BIS: equ $A1000D
TxDATA1: equ $A1000F
RxDATA1: equ $A10011
SCTRL1: equ $A10013
TxDATA2: equ $A10015
RxDATA2: equ $A10017
SCTRL2: equ $A10019
TxDATA3: equ $A1001B
RxDATA3: equ $A1001D
SCTRL3: equ $A1001F
; END OF SEGMENT IO OFFSETS FROM IO:A10000 TO 0:00A10FFF

; START OF SEGMENT Control OFFSETS FROM Control:A11000 TO 0:00A11FFF
MemMode: equ $A11000
Z80BusReq: equ $A11100
Z80BusReset: equ $A11200
; END OF SEGMENT Control OFFSETS FROM Control:A11000 TO 0:00A11FFF

; START OF SEGMENT VDP OFFSETS FROM VDP:00C00000 TO 0:00C00012
VDP_Data: equ $C00000
VDP_Control: equ $C00004
HV_Counter: equ $C00008
PSG: equ $C00011
; END OF SEGMENT VDP OFFSETS FROM VDP:00C00000 TO 0:00C00012

; START OF SEGMENT RAM OFFSETS FROM RAM:FF0000 TO 0:01000000
FF0000_RAM_START: equ $FF0000
byte_FF0C00: equ $FF0C00
FF1000_MAP_TILESET_4: equ $FF1000
FF2000_LOADING_SPACE: equ $FF2000
FF3000_MAP_TILESET_1: equ $FF3000
FF3800_LOADING_SPACE: equ $FF3800
byte_FF4000: equ $FF4000
byte_FF4A00: equ $FF4A00
FF5000_LOADING_SPACE: equ $FF5000
FF5600_LOADING_SPACE: equ $FF5600
word_FF5C00: equ $FF5C00
word_FF5C02: equ $FF5C02
word_FF5C04: equ $FF5C04
word_FF5C06: equ $FF5C06
byte_FF5C08: equ $FF5C08
BATTLE_TERRAIN: equ $FF5F00
MAP_LAYOUT_HISTORY_MAP_SIZES: equ $FF6000
FF6800_MAP_LOADING_LEFT_HISTORY_MAP: equ $FF6800
FF6802_LOADING_SPACE: equ $FF6802
byte_FF6942: equ $FF6942
byte_FF6C02: equ $FF6C02
byte_FF7002: equ $FF7002
byte_FF7402: equ $FF7402
byte_FF7802: equ $FF7802
FF7A02_LOADING_SPACE: equ $FF7A02
byte_FF7C02: equ $FF7C02
FF8002_LOADING_SPACE: equ $FF8002
FF8800_MAP_LOADING_UPPER_HISTORY_MAP: equ $FF8800
FF8804_LOADING_SPACE: equ $FF8804
byte_FF8805: equ $FF8805
word_FF8806: equ $FF8806
byte_FF8808: equ $FF8808
byte_FF8809: equ $FF8809
word_FF880A: equ $FF880A
word_FF880C: equ $FF880C
byte_FF880E: equ $FF880E
byte_FF883E: equ $FF883E
byte_FF886E: equ $FF886E
byte_FF889E: equ $FF889E
byte_FF88CE: equ $FF88CE
byte_FF88FE: equ $FF88FE
byte_FF8904: equ $FF8904
byte_FF892E: equ $FF892E
byte_FF895E: equ $FF895E
byte_FF8984: equ $FF8984
byte_FF898E: equ $FF898E
byte_FF8A04: equ $FF8A04
byte_FF8A44: equ $FF8A44
byte_FF8B04: equ $FF8B04
byte_FF8C02: equ $FF8C02
byte_FF8C84: equ $FF8C84
byte_FF8D04: equ $FF8D04
byte_FF8E04: equ $FF8E04
byte_FF8EC4: equ $FF8EC4
byte_FF8F04: equ $FF8F04
ENEMY_BATTLESPRITE_UNCOMP_SPACE: equ $FF9002
byte_FF9004: equ $FF9004
byte_FF9104: equ $FF9104
byte_FF9202: equ $FF9202
byte_FF9284: equ $FF9284
word_FF9802: equ $FF9802
BATTLE_ENTITY_MOVE_STRING: equ $FF9804
byte_FF9904: equ $FF9904
byte_FF9984: equ $FF9984
byte_FF9A04: equ $FF9A04
byte_FF9A84: equ $FF9A84
byte_FF9B04: equ $FF9B04
FF9C02_LOADING_SPACE: equ $FF9C02
FFA202_LOADING_SPACE: equ $FFA202
word_FFA804: equ $FFA804
word_FFA806: equ $FFA806
word_FFA808: equ $FFA808
word_FFA80A: equ $FFA80A
QUAKE_AMPLITUDE: equ $FFA80C
word_FFA80E: equ $FFA80E
word_FFA810: equ $FFA810
word_FFA812: equ $FFA812
word_FFA814: equ $FFA814
word_FFA816: equ $FFA816
word_FFA818: equ $FFA818
word_FFA81A: equ $FFA81A
word_FFA81C: equ $FFA81C
word_FFA81E: equ $FFA81E
word_FFA820: equ $FFA820
word_FFA822: equ $FFA822
word_FFA824: equ $FFA824
word_FFA826: equ $FFA826
word_FFA828: equ $FFA828
CAMERA_SCROLLING_MASK: equ $FFA82A
CAMERA_ENTITY: equ $FFA82C
byte_FFA82D: equ $FFA82D
MAP_AREA_LAYER1_STARTX: equ $FFA82E
MAP_AREA_LAYER1_STARTY: equ $FFA830
MAP_AREA_LAYER1_ENDX: equ $FFA832
MAP_AREA_LAYER1_ENDY: equ $FFA834
MAP_AREA_LAYER2_STARTX: equ $FFA836
MAP_AREA_LAYER2_STARTY: equ $FFA838
MAP_AREA_BACKGROUND_STARTX: equ $FFA83A
MAP_AREA_BACKGROUND_STARTY: equ $FFA83C
MAP_AREA_LAYER1_PARALLAX_X: equ $FFA83E
MAP_AREA_LAYER1_PARALLAX_Y: equ $FFA840
MAP_AREA_LAYER2_PARALLAX_X: equ $FFA842
MAP_AREA_LAYER2_PARALLAX_Y: equ $FFA844
MAP_AREA_LAYER1_AUTOSCROLL_X: equ $FFA846
MAP_AREA_LAYER1_AUTOSCROLL_Y: equ $FFA847
MAP_AREA_LAYER2_AUTOSCROLL_X: equ $FFA848
MAP_AREA_LAYER2_AUTOSCROLL_Y: equ $FFA849
MAP_EVENT_TYPE: equ $FFA84A
MAP_EVENT_PARAM_1: equ $FFA84C
MAP_EVENT_PARAM_2: equ $FFA84D
MAP_EVENT_PARAM_3: equ $FFA84E
MAP_EVENT_PARAM_4: equ $FFA84F
MAP_EVENT_PARAM_5: equ $FFA850
TILE_ANIM_DATA_ADDR: equ $FFA86A
TILE_ANIM_COUNTER: equ $FFA86E
TILE_ANIM_MAP_INDEX: equ $FFA870
WINDOW_TILES_END: equ $FFA87A
WINDOW_PROPERTIES: equ $FFA87E
byte_FFA8FE: equ $FFA8FE
byte_FFA8FF: equ $FFA8FF
word_FFA900: equ $FFA900
ENTITY_DATA: equ $FFA902
ENTITY_Y: equ $FFA904
ENTITY_X_DEST: equ $FFA90E
ENTITY_Y_DEST: equ $FFA910
ENTITY_FACING: equ $FFA912
ENTITY_MAPSPRITE: equ $FFA915
ENTITY_ANIMCOUNTER: equ $FFA920
OTHER_ENTITIES: equ $FFA922
byte_FFACE2: equ $FFACE2
byte_FFAEE2: equ $FFAEE2
byte_FFAEEE: equ $FFAEEE
ENTITY_UNIT_CURSOR: equ $FFAF02
FOLLOWERS_LIST: equ $FFAF22
byte_FFAF23: equ $FFAF23
byte_FFAF26: equ $FFAF26
word_FFAF42: equ $FFAF42
SPRITE_SIZE: equ $FFAF44
MAP_AREA_LAYER_TYPE: equ $FFAF46
byte_FFAF47: equ $FFAF47
NUM_SPRITES_TO_LOAD: equ $FFAF67
byte_FFAF69: equ $FFAF69
byte_FFAF6A: equ $FFAF6A
byte_FFAF6B: equ $FFAF6B
TEXT_WINDOW_INDEX: equ $FFAF6C
RAM_Dialogue_VDPTileRowScrollingOffset: equ $FFAF6E
STRING_BYTE: equ $FFAF70
STRING_BIT_COUNTER: equ $FFAF72
DECODED_TEXT_SYMBOL: equ $FFAF74
FIGHTER_MINISTATUS_WINDOW_IDX: equ $FFAF76
DISPLAYED_ICON_1: equ $FFAF7A
DISPLAYED_ICON_2: equ $FFAF7C
DISPLAYED_ICON_3: equ $FFAF7E
DISPLAYED_ICON_4: equ $FFAF80
byte_FFAF82: equ $FFAF82
word_FFAF8C: equ $FFAF8C
word_FFAF8E: equ $FFAF8E
BATTLE_ENTITY_CHOSEN_X: equ $FFAF90
BATTLE_ENTITY_CHOSEN_Y: equ $FFAF91
FIGHTER_IS_TARGETTING: equ $FFAF93
word_FFAF9E: equ $FFAF9E
byte_FFAFA0: equ $FFAFA0
byte_FFAFA1: equ $FFAFA1
dword_FFAFAA: equ $FFAFAA
word_FFAFAE: equ $FFAFAE
byte_FFAFB0: equ $FFAFB0
byte_FFAFB1: equ $FFAFB1
word_FFAFB2: equ $FFAFB2
byte_FFAFB4: equ $FFAFB4
byte_FFAFC6: equ $FFAFC6
byte_FFAFCE: equ $FFAFCE
CURRENT_DIAMENU_CHOICE: equ $FFAFE7
SPEECH_SOUND_TOGGLE: equ $FFAFFB
BLINK_TILE_NUMBER: equ $FFAFFE
BLINK_DATA: equ $FFB000
BLINK_COUNTER: equ $FFB03C
MOUTH_TILE_NUMBER: equ $FFB03E
MOUTH_DATA: equ $FFB040
word_FFB07C: equ $FFB07C
word_FFB07E: equ $FFB07E
PORTRAIT_WINDOW_INDEX: equ $FFB080
byte_FFB082: equ $FFB082
CURRENTLY_TYPEWRITING: equ $FFB083
PORTRAIT_IS_FLIPPED: equ $FFB084
PORTRAIT_IS_ON_RIGHT: equ $FFB085
word_FFB086: equ $FFB086
LAND_EFFECT_WINDOW_IDX: equ $FFB088
TIMER_WINDOW_INDEX: equ $FFB08A
word_FFB08C: equ $FFB08C
word_FFB08E: equ $FFB08E
word_FFB090: equ $FFB090
word_FFB092: equ $FFB092
word_FFB094: equ $FFB094
FIGHTER_MINISTATUS_WINDOW_WIDTH: equ $FFB096
MOVE_SOUND: equ $FFB098
SAVE_SLOT_BEING_USED: equ $FFB09A
CURRENT_SPEAK_SOUND: equ $FFB09C
word_FFB09E: equ $FFB09E
CURRENT_PORTRAIT: equ $FFB0A0
DONT_SEND_SOUND_COMMANDS: equ $FFB0A3
ROM_CHECKSUM: equ $FFB0A4
SPECIAL_TURBO_CHEAT: equ $FFB0A8
DEBUG_MODE_ACTIVATED: equ $FFB0A9
CONTROL_OPPONENT_CHEAT: equ $FFB0AA
AUTO_BATTLE_CHEAT: equ $FFB0AB
CONFIGURATION_MODE_ACTIVATED: equ $FFB0AC
MAP_AREA_MUSIC_INDEX: equ $FFB0AD
byte_FFB0AE: equ $FFB0AE
word_FFB12E: equ $FFB12E
word_FFB130: equ $FFB130
word_FFB132: equ $FFB132
word_FFB134: equ $FFB134
word_FFB136: equ $FFB136
word_FFB138: equ $FFB138
word_FFB13A: equ $FFB13A
byte_FFB13C: equ $FFB13C
word_FFB13D: equ $FFB13D
WINDOW_IS_PRESENT: equ $FFB13F
ENTITY_EVENT_IDX_LIST: equ $FFB140
byte_FFB160: equ $FFB160
byte_FFB180: equ $FFB180
SKIRMISH_MUSIC_INDEX: equ $FFB188
MOVING_BATTLE_ENTITY_IDX: equ $FFB18A
word_FFB18C: equ $FFB18C
byte_FFB18E: equ $FFB18E
CAMERA_SPEED: equ $FFB194
word_FFB196: equ $FFB196
byte_FFB198: equ $FFB198
WINDOW_HIDING_FORBIDDEN: equ $FFB199
DISPLAY_WINDOWS_TOGGLE: equ $FFB19A
AFTER_INTRO_JUMP_OFFSET: equ $FFB19C
dword_FFB1A0: equ $FFB1A0
dword_FFB1A4: equ $FFB1A4
WARP_SFX: equ $FFB1A8
CONFMODE_AND_CREDITS_SEQUENCE_POINTER: equ $FFB1AA
ENEMY_TARGETTING_COMMAND_LIST: equ $FFB1AC
byte_FFB1DC: equ $FFB1DC
byte_FFB20C: equ $FFB20C
dword_FFB3C0: equ $FFB3C0
word_FFB3C4: equ $FFB3C4
dword_FFB3C6: equ $FFB3C6
word_FFB3CA: equ $FFB3CA
BATTLESCENE_FRAME_COUNTER: equ $FFB3CC
byte_FFB3CD: equ $FFB3CD
BATTLESCENE_ENEMY: equ $FFB3CE
ENEMY_BATTLE_SPRITE: equ $FFB3D0
ENEMY_BATTLE_PALETTE: equ $FFB3D2
BATTLESCENE_CHARACTER: equ $FFB3D4
CHARACTER_BATTLE_SPRITE: equ $FFB3D6
CHARACTER_BATTLE_PALETTE: equ $FFB3D8
CHARACTER_WEAPON_SPRITE: equ $FFB3DA
CHARACTER_WEAPON_PALETTE: equ $FFB3DC
ENEMY_BATTLESPRITE_ANIM_SPEED: equ $FFB3DE
ENEMY_BATTLESPRITE_ANIM_COUNTER: equ $FFB3E0
ALLY_BATTLESPRITE_ANIM_SPEED: equ $FFB3E2
ALLY_BATTLESPRITE_ANIM_COUNTER: equ $FFB3E4
word_FFB3E6: equ $FFB3E6
BATTLESCENE_ACTOR: equ $FFB3E8
word_FFB3EA: equ $FFB3EA
word_FFB3EC: equ $FFB3EC
word_FFB3EE: equ $FFB3EE
word_FFB3F0: equ $FFB3F0
word_FFB3F2: equ $FFB3F2
word_FFB3F4: equ $FFB3F4
word_FFB3F6: equ $FFB3F6
word_FFB3F8: equ $FFB3F8
word_FFB3FA: equ $FFB3FA
word_FFB3FC: equ $FFB3FC
word_FFB3FE: equ $FFB3FE
word_FFB400: equ $FFB400
DEAD_COMBATANTS_LIST_LENGTH: equ $FFB402
byte_FFB404: equ $FFB404
byte_FFB406: equ $FFB406
byte_FFB41E: equ $FFB41E
byte_FFB496: equ $FFB496
byte_FFB532: equ $FFB532
dword_FFB536: equ $FFB536
byte_FFB53A: equ $FFB53A
byte_FFB542: equ $FFB542
byte_FFB562: equ $FFB562
byte_FFB568: equ $FFB568
byte_FFB569: equ $FFB569
byte_FFB56A: equ $FFB56A
byte_FFB56B: equ $FFB56B
ACTOR_TO_MAKE_IDLE: equ $FFB56C
byte_FFB56D: equ $FFB56D
byte_FFB56E: equ $FFB56E
byte_FFB56F: equ $FFB56F
WEAPON_FRAME_IDX: equ $FFB570
WEAPON_FRAME_LAYER: equ $FFB571
WEAPON_FRAME_X: equ $FFB572
WEAPON_FRAME_Y: equ $FFB573
WEAPON_IDLE_FRAME1_IDX: equ $FFB574
WEAPON_IDLE_FRAME1_X: equ $FFB576
WEAPON_IDLE_FRAME1_Y: equ $FFB577
WEAPON_IDLE_FRAME2_X: equ $FFB578
WEAPON_IDLE_FRAME2_Y: equ $FFB579
ALLY_BATTLESPRITE_PROP1: equ $FFB57A
ALLY_BATTLESPRITE_PROP2: equ $FFB57B
ENEMY_BATTLESPRITE_PROP1: equ $FFB57C
ENEMY_BATTLESPRITE_PROP2: equ $FFB57D
byte_FFB57E: equ $FFB57E
byte_FFB57F: equ $FFB57F
byte_FFB580: equ $FFB580
byte_FFB581: equ $FFB581
BATTLE_BACKGROUND: equ $FFB582
byte_FFB583: equ $FFB583
byte_FFB584: equ $FFB584
byte_FFB585: equ $FFB585
byte_FFB586: equ $FFB586
byte_FFB587: equ $FFB587
byte_FFB588: equ $FFB588
byte_FFB589: equ $FFB589
DEAD_COMBATANTS_LIST: equ $FFB58A
byte_FFB59A: equ $FFB59A
BATTLESCENE_GOLD: equ $FFB62A
BATTLESCENE_EXP: equ $FFB62C
BATTLESCENE_ACTION_TYPE: equ $FFB62E
word_FFB630: equ $FFB630
word_FFB632: equ $FFB632
word_FFB634: equ $FFB634
RAM_BattleScene_AttackNumber: equ $FFB636
CURRENT_BATTLE_SPELL_INDEX: equ $FFB638
CURRENT_BATTLE_SPELL_LEVEL: equ $FFB63A
CURRENT_BATTLE_ITEM: equ $FFB63C
TARGET_CHARACTERS_INDEX_LIST_SIZE: equ $FFB63E
NUMBER_OF_BATTLE_PARTY_MEMBERS: equ $FFB640
NUMBER_OF_OTHER_PARTY_MEMBERS: equ $FFB642
CUTSCENE_DIALOG_INDEX: equ $FFB646
SKIP_CUTSCENE_TEXT: equ $FFB648
SKIRMISH_FIRST_ALLY: equ $FFB64A
SKIRMISH_LAST_ALLY: equ $FFB64B
SKIRMISH_FIRST_ENEMY: equ $FFB64C
SKIRMISH_LAST_ENEMY: equ $FFB64D
BATTLESCENE_ATTACKER: equ $FFB64E
word_FFB64F: equ $FFB64F
byte_FFB651: equ $FFB651
TARGET_CHARACTERS_INDEX_LIST: equ $FFB652
byte_FFB653: equ $FFB653
BATTLE_PARTY_MEMBERS: equ $FFB682
RESERVE_MEMBERS: equ $FFB68E
ENEMY_LIST: equ $FFB6A2
MOVE_COST_LIST: equ $FFB6C2
CURRENT_SHOP_INDEX: equ $FFB6D2
DIALOGUE_TYPEWRITING_CURRENT_X: equ $FFB6D4
DIALOGUE_TYPEWRITING_CURRENT_Y: equ $FFB6D5
USE_REGULAR_DIALOGUE_FONT: equ $FFB6D6
COMPRESSED_STRING_LENGTH: equ $FFB6D7
byte_FFB6D8: equ $FFB6D8
TEXT_NAME_INDEX_1: equ $FFB6E8
TEXT_NAME_INDEX_2: equ $FFB6EA
TEXT_NAME_INDEX_3: equ $FFB6EC
RAM_Dialog_StringToPrint: equ $FFB6F0
TEXT_NUMBER: equ $FFB776
word_FFB778: equ $FFB778
ADDR_CURRENT_DIALOGUE_ASCII_BYTE: equ $FFB77A
COMPRESSED_STRING_POINTER: equ $FFB77E
ADDR_CURRENT_DIALOGUE_NAMEIDX: equ $FFB782
EQUIPPABLE_ITEMS: equ $FFB786
VDP_TILE_IDX_LIST: equ $FFB800
byte_FFB812: equ $FFB812
byte_FFB852: equ $FFB852
byte_FFC000: equ $FFC000
byte_FFC180: equ $FFC180
byte_FFC1B8: equ $FFC1B8
byte_FFC286: equ $FFC286
byte_FFC350: equ $FFC350
byte_FFC358: equ $FFC358
byte_FFC398: equ $FFC398
byte_FFC41A: equ $FFC41A
byte_FFC480: equ $FFC480
byte_FFC800: equ $FFC800
byte_FFCC86: equ $FFCC86
PALETTE_1: equ $FFD000
PALETTE_1_01: equ $FFD002
PALETTE_1_0F: equ $FFD004
PALETTE_2: equ $FFD020
PALETTE_3: equ $FFD040
PALETTE_3_0F: equ $FFD044
PALETTE_4: equ $FFD060
PALETTE_1_BIS: equ $FFD080
word_FFD082: equ $FFD082
dword_FFD084: equ $FFD084
WEAPON_PALETTE: equ $FFD09C
PALLETE_2_BIS: equ $FFD0A0
PALETTE3_BIS: equ $FFD0C0
PALETTE_4_BIS: equ $FFD0E0
word_FFD100: equ $FFD100
byte_FFD102: equ $FFD102
byte_FFD1C0: equ $FFD1C0
word_FFD500: equ $FFD500
byte_FFD502: equ $FFD502
byte_FFD550: equ $FFD550
byte_FFD780: equ $FFD780
byte_FFDB80: equ $FFDB80
SPRITE_TABLE: equ $FFDC80
SPRITE_LINK: equ $FFDC83
SPRITE_VDP_TILE_INDEX: equ $FFDC84
dword_FFDC88: equ $FFDC88
byte_FFDC8C: equ $FFDC8C
byte_FFDC98: equ $FFDC98
dword_FFDCA0: equ $FFDCA0
dword_FFDCA4: equ $FFDCA4
byte_FFDCA8: equ $FFDCA8
byte_FFDCB8: equ $FFDCB8
byte_FFDCBB: equ $FFDCBB
byte_FFDCC0: equ $FFDCC0
byte_FFDCCB: equ $FFDCCB
byte_FFDCD0: equ $FFDCD0
dword_FFDCF0: equ $FFDCF0
word_FFDCF4: equ $FFDCF4
byte_FFDCF6: equ $FFDCF6
byte_FFDD00: equ $FFDD00
byte_FFDD08: equ $FFDD08
byte_FFDD10: equ $FFDD10
byte_FFDD18: equ $FFDD18
dword_FFDD20: equ $FFDD20
byte_FFDD24: equ $FFDD24
byte_FFDDB0: equ $FFDDB0
byte_FFDDC0: equ $FFDDC0
byte_FFDDF0: equ $FFDDF0
byte_FFDE60: equ $FFDE60
byte_FFDE7B: equ $FFDE7B
byte_FFDE80: equ $FFDE80
byte_FFDE85: equ $FFDE85
VINT_PARAMS: equ $FFDE94
byte_FFDE95: equ $FFDE95
byte_FFDE96: equ $FFDE96
P1_INPUT: equ $FFDE97
P2_INPUT: equ $FFDE99
CURRENT_PLAYER_INPUT: equ $FFDE9B
PRIMARY_WALKING_DIRECTION: equ $FFDE9C
byte_FFDE9D: equ $FFDE9D
byte_FFDE9E: equ $FFDE9E
byte_FFDE9F: equ $FFDE9F
byte_FFDEA0: equ $FFDEA0
byte_FFDEA1: equ $FFDEA1
TEMP_DMA_VALUE: equ $FFDEA2
RANDOM_SEED: equ $FFDEA4
word_FFDEA6: equ $FFDEA6
word_FFDEA8: equ $FFDEA8
VDP_REG00_STATUS: equ $FFDEAA
VDP_REG01_STATUS: equ $FFDEAC
VDP_REG01_VALUE: equ $FFDEAD
byte_FFDEC1: equ $FFDEC1
dword_FFDED0: equ $FFDED0
VDP_REG_COMMANDS: equ $FFDED4
SOUND_COMMAND_QUEUE: equ $FFDED8
MUSIC_STACK_LENGTH: equ $FFDEE0
MUSIC_STACK: equ $FFDEE1
WAIT_FOR_MUSIC_END: equ $FFDEEB
LAST_PLAYER_INPUT: equ $FFDEEC
INPUT_REPEAT_DELAYER: equ $FFDEED
FADING_SETTING: equ $FFDEF0
FADING_COUNTER_MAX: equ $FFDEF2
FADING_POINTER: equ $FFDEF3
FADING_COUNTER: equ $FFDEF4
FADING_PALETTE_FLAGS: equ $FFDEF5
VINT_ENABLED: equ $FFDEF6
VINT_WAIT_TOGGLE: equ $FFDEF7
VINT_FUNCS_ENABLED_BITFIELD: equ $FFDEF8
FRAMES_SINCE_VINT: equ $FFDEF9
VINT_FUNC_ADDRS: equ $FFDEFA
SECONDS_COUNTER: equ $FFDF1E
SPECIAL_BATTLE_TIME: equ $FFDF22
SECONDS_COUNTER_0: equ $FFDF26
byte_FFDF2A: equ $FFDF2A
byte_FFDF4A: equ $FFDF4A
byte_FFDFAA: equ $FFDFAA
byte_FFDFAB: equ $FFDFAB
RANDOM_WAITING_FOR_INPUT: equ $FFDFB0
byte_FFE000: equ $FFE000
byte_FFE0DC: equ $FFE0DC
byte_FFE15C: equ $FFE15C
byte_FFE184: equ $FFE184
byte_FFE19C: equ $FFE19C
byte_FFE21E: equ $FFE21E
byte_FFE29E: equ $FFE29E
byte_FFE31C: equ $FFE31C
CHARACTER_DATA: equ $FFE800
CURRENT_GOLD: equ $FFF600
DEALS_ITEMS: equ $FFF604
NUM_ITEMS_IN_CARAVAN: equ $FFF644
CARAVAN_ITEMS: equ $FFF646
GAME_FLAGS: equ $FFF686
BATTLE_AREA_X: equ $FFF706
BATTLE_AREA_Y: equ $FFF707
BATTLE_AREA_WIDTH: equ $FFF708
BATTLE_AREA_HEIGHT: equ $FFF709
PLAYER_TYPE: equ $FFF710
CURRENT_MAP: equ $FFF711
CURRENT_BATTLE: equ $FFF712
RAFT_MAP_INDEX: equ $FFF713
RAFT_X: equ $FFF714
RAFT_Y: equ $FFF715
MESSAGE_SPEED: equ $FFF717
DISPLAY_BATTLE_MESSAGES: equ $FFF718
EGRESS_MAP_INDEX: equ $FFF719
BATTLE_TURN_ORDER: equ $FFF71A
BATTLE_CURRENT_TURN_OFFSET: equ $FFF79A
SECONDS_COUNTER_FROM_SRAM: equ $FFF79C
SPECIAL_BATTLE_RECORD: equ $FFF7A0
ENEMY_ITEM_DROPS: equ $FFF7A4
CURRENT_MITHRIL_WEAPON_INDEX: equ $FFF7A8
ERRCODE_BYTE0: equ $FFFFF8
ERRCODE_BYTE1: equ $FFFFF9
ERRCODE_BYTE2: equ $FFFFFA
ERRCODE_BYTE3: equ $FFFFFB
ERRCODE_BYTE4: equ $FFFFFC
ERRCODE_BYTE5: equ $FFFFFD
ERRCODE_BYTE6: equ $FFFFFE
ERRCODE_BYTE7: equ $FFFFFF
; END OF SEGMENT RAM OFFSETS FROM RAM:FF0000 TO 0:01000000

