PERCENT_POISON_DAMAGE: equ 0                    ; 0 = OFF, 1-100 = n% of max HP
CAPITALIZED_CHARACTER_NAMES: equ 1              ; 0 = OFF, 1 = ON
; Debugging facilitations
EASY_BATTLE_TEST: equ 1                         ; 0 = OFF, 1 = ON
EASY_CONFIGURATION_MODE: equ 0                  ; 0 = OFF, 1 = ON
EASY_DEBUG_MODE: equ 0                          ; 0 = OFF, 1 = ON
; Bugfixes
BUGFIX_SEARCH_IN_BATTLE: equ 1                  ; 0 = OFF, 1 = ON
BUGFIX_SKIPPED_TURNS: equ 1                     ; 0 = OFF, 1 = ON. Fixes cases where a combatant can miss a turn because of AGI getting higher than 127.
BUGFIX_INCREASE_DOUBLE_RESETS_COUNTER: equ 1    ; 0 = OFF, 1 = ON
BUGFIX_GODDESS_STAFF_DEALS_ABUSE: equ 1         ; 0 = OFF, 1 = ON
BUGFIX_GARBLED_HP_BAR: equ 1                    ; 0 = OFF, 1 = ON. Prevents drawing garbage pixels when HP is greater then 600.
BUGFIX_KIWI_SPELLS_LEARNING_LEVEL: equ 1        ; 0 = OFF, 1 = ON. Kiwi's base class is wrongfully treated as promoted for the purpose of learning spells.
BUGFIX_HIGINS_SPELL: equ 1                      ; 0 = OFF, 1 = ON. Prevent unequipping from possibly corrupting characters spell entries.
BUGFIX_MOVEMENT_GLITCH: equ 1                   ; 0 = OFF, 1 = ON.
; Data expansions
FORCE_MEMBERS_EXPANSION: equ 0                  ; 0 = OFF, 1 = ON. Enable the use of 2 additional force members.
ITEMS_AND_SPELLS_EXPANSION: equ 0               ; 0 = OFF, 1 = ON. Requires 4MB expanded ROM layout!
; Menu enhancements
THREE_DIGITS_STATS: equ 1                       ; 0 = OFF, 1 = ON
EIGHT_CHARACTERS_MEMBER_NAMES: equ 0            ; 0 = OFF, 1 = ON
FULL_CLASS_NAMES: equ 0                         ; 0 = OFF, 1 = ON
ALTERNATE_JEWEL_ICONS_DISPLAY: equ 2            ; 0 = OFF, 1 = small icons, 2 = no display
EXTENDED_SPELL_NAMES: equ 0                     ; 0 = OFF, 1 = ON
SHOW_ENEMY_LEVEL: equ 1                         ; 0 = OFF, 1 = ON
SHOW_ALL_SPELLS_IN_MEMBER_SCREEN: equ 1         ; 0 = OFF, 1 = ON
; Project VS Demo
PROJECT_VS_DEMO: equ 1                          ; Include 6 vs. 6 demo specific assets.
VERSUS_MODE: equ 1                              ; Must be enabled.
START_AT_BATTLE_NUMBER_PROMPT: equ 0
RANDOM_BATTLE_SELECTION: equ 1                  ; Press B at battle number prompt to randomly pick a battle.
BOWIE_CAN_DIE: equ 1
BOSS_ATTACK_MUSIC_FOR_ALL_ENEMIES: equ 1
SKIP_AFTER_TURN_MESSAGES: equ 1                 ; Skip displaying HP/MP regen and poison damage messages.