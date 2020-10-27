
; ASM FILE data\stats\items\weapongraphics-sf2gu.asm :
; Weapon graphics table
tbl_WeaponGraphics:
                
; Syntax        weaponGraphics [WEAPONSPRITE_]index, [WEAPONPALETTE_]index
                
; Total of 66 that could use their own palettem will probably make a palette bin for each one so they are all independent of eachother
    
                weaponGraphics NONE, SHORT_AXE                  ; 26: Leather Glove
                weaponGraphics NONE, SHORT_AXE                  ; 27: Power Glove
                weaponGraphics NONE, SHORT_AXE                  ; 28: Brass Knuckles
                weaponGraphics NONE, SHORT_AXE                  ; 29: Iron Knuckles
                weaponGraphics NONE, SHORT_AXE                  ; 30: Misty Knuckles
                weaponGraphics NONE, SHORT_AXE                  ; 31: Giant Knuckles
                weaponGraphics NONE, SHORT_AXE                  ; 32: Evil Knuckles
                weaponGraphics SHORT_AXE, SHORT_AXE             ; 33: Short Axe
                weaponGraphics HAND_AXE, HAND_AXE               ; 34: Hand Axe
                weaponGraphics MIDDLE_AXE, MIDDLE_AXE           ; 35: Middle Axe
                weaponGraphics POWER_AXE, POWER_AXE             ; 36: Power Axe
                weaponGraphics BATTLE_AXE, BATTLE_AXE           ; 37: Battle Axe
                weaponGraphics LARGE_AXE, LARGE_AXE             ; 38: Large Axe
                weaponGraphics GREAT_AXE, GREAT_AXE             ; 39: Great Axe
                weaponGraphics HEAT_AXE, HEAT_AXE               ; 40: Heat Axe
                weaponGraphics ATLAS_AXE, ATLAS_AXE             ; 41: Atlas Axe
                weaponGraphics GROUND_AXE, GROUND_AXE           ; 42: Ground Axe
                weaponGraphics RUNE_AXE, RUNE_AXE               ; 43: Rune Axe
                weaponGraphics EVIL_AXE, EVIL_AXE               ; 44: Evil Axe
                weaponGraphics NONE, SHORT_AXE                  ; 45: Wooden Arrow
                weaponGraphics NONE, SHORT_AXE                  ; 46: Iron Arrow
                weaponGraphics NONE, SHORT_AXE                  ; 47: Steel Arrow
                weaponGraphics NONE, SHORT_AXE                  ; 48: Robin Arrow
                weaponGraphics NONE, SHORT_AXE                  ; 49: Assault Shell
                weaponGraphics NONE, SHORT_AXE                  ; 50: Great Shot
                weaponGraphics NONE, SHORT_AXE                  ; 51: Nazca Cannon
                weaponGraphics NONE, SHORT_AXE                  ; 52: Buster Shot
                weaponGraphics NONE, SHORT_AXE                  ; 53: Hyper Cannon
                weaponGraphics NONE, SHORT_AXE                  ; 54: Grand Cannon
                weaponGraphics NONE, SHORT_AXE                  ; 55: Evil Shot
                weaponGraphics WOODEN_STICK, WOODEN_STICK       ; 56: Wooden Stick
                weaponGraphics SHORT_SWORD, SHORT_SWORD         ; 57: Short Sword
                weaponGraphics MIDDLE_SWORD, MIDDLE_SWORD       ; 58: Middle Sword
                weaponGraphics LONG_SWORD, LONG_SWORD           ; 59: Long Sword
                weaponGraphics STEEL_SWORD, STEEL_SWORD         ; 60: Steel Sword
                weaponGraphics ACHILLES_SWORD, ACHILLES_SWORD   ; 61: Achilles Sword
                weaponGraphics BROAD_SWORD, BROAD_SWORD         ; 62: Broad Sword
                weaponGraphics BUSTER_SWORD, BUSTER_SWORD       ; 63: Buster Sword
                weaponGraphics GREAT_SWORD, GREAT_SWORD         ; 64: Great Sword
                weaponGraphics CRITICAL_SWORD, CRITICAL_SWORD   ; 65: Critical Sword
                weaponGraphics BATTLE_SWORD, BATTLE_SWORD       ; 66: Battle Sword
                weaponGraphics FORCE_SWORD, FORCE_SWORD         ; 67: Force Sword
                weaponGraphics COUNTER_SWORD, COUNTER_SWORD     ; 68: Counter Sword
                weaponGraphics LEVANTER, LEVANTER               ; 69: Levanter
                weaponGraphics DARK_SWORD, DARK_SWORD           ; 70: Dark Sword
                weaponGraphics WOODEN_SWORD, WOODEN_SWORD       ; 71: Wooden Sword
                weaponGraphics SHORT_SPEAR, SHORT_SPEAR         ; 72: Short Spear
                weaponGraphics BRONZE_LANCE, BRONZE_LANCE       ; 73: Bronze Lance
                weaponGraphics SPEAR, SPEAR                     ; 74: Spear
                weaponGraphics STEEL_LANCE, STEEL_LANCE         ; 75: Steel Lance
                weaponGraphics POWER_SPEAR, POWER_SPEAR         ; 76: Power Spear
                weaponGraphics HEAVY_LANCE, HEAVY_LANCE         ; 77: Heavy Lance
                weaponGraphics JAVELIN, JAVELIN                 ; 78: Javelin
                weaponGraphics CHROME_LANCE, CHROME_LANCE       ; 79: Chrome Lance
                weaponGraphics VALKYRIE, VALKYRIE               ; 80: Valkyrie
                weaponGraphics HOLY_LANCE, HOLY_LANCE           ; 81: Holy Lance
                weaponGraphics MIST_JAVELIN, MIST_JAVELIN       ; 82: Mist Javelin
                weaponGraphics HALBERD, HALBERD                 ; 83: Halberd
                weaponGraphics EVIL_LANCE, EVIL_LANCE           ; 84: Evil Lance
                weaponGraphics WOODEN_ROD, WOODEN_ROD           ; 85: Wooden Rod
                weaponGraphics SHORT_ROD, SHORT_ROD             ; 86: Short Rod
                weaponGraphics BRONZE_ROD, BRONZE_ROD           ; 87: Bronze Rod
                weaponGraphics IRON_ROD, IRON_ROD               ; 88: Iron Rod
                weaponGraphics POWER_STICK, POWER_STICK         ; 89: Power Stick
                weaponGraphics FLAIL, FLAIL                     ; 90: Flail
                weaponGraphics GUARDIAN_STAFF, GUARDIAN_STAFF   ; 91: Guardian Staff
                weaponGraphics INDRA_STAFF, INDRA_STAFF         ; 92: Indra Staff
                weaponGraphics MAGE_STAFF, MAGE_STAFF           ; 93: Mage Staff
                weaponGraphics WISH_STAFF, WISH_STAFF           ; 94: Wish Staff
                weaponGraphics GREAT_ROD, GREAT_ROD             ; 95: Great Rod
                weaponGraphics SUPPLY_STAFF, SUPPLY_STAFF       ; 96: Supply Staff
                weaponGraphics HOLY_STAFF, HOLY_STAFF           ; 97: Holy Staff
                weaponGraphics FREEZE_STAFF, FREEZE_STAFF       ; 98: Freeze Staff
                weaponGraphics GODDESS_STAFF, GODDESS_STAFF     ; 99: Goddess Staff
                weaponGraphics MYSTERY_STAFF, MYSTERY_STAFF     ; 100: Mystery Staff
                weaponGraphics DEMON_ROD, DEMON_ROD             ; 101: Demon Rod
                weaponGraphics GREAT_ROD, GREAT_ROD             ; 102: Iron Ball
                weaponGraphics SHORT_KNIFE, SHORT_KNIFE         ; 103: Short Knife
                weaponGraphics DAGGER, DAGGER                   ; 104: Dagger
                weaponGraphics KNIFE, KNIFE                     ; 105: Knife
                weaponGraphics THIEVES_DAGGER, THIEVES_DAGGER   ; 106: Thieve's Dagger
                weaponGraphics KATANA, KATANA                   ; 107: Katana
                weaponGraphics NINJA_KATANA, NINJA_KATANA       ; 108: Ninja Katana
                weaponGraphics GISARME, GISARME                 ; 109: Gisarme