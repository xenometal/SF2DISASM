
; ASM FILE data\graphics\battles\battlesprites\allies-sf2gu\animations\entries.asm :
; Ally animations
pt_AlliesAnimations:
                
                ; Attacks
                dc.l AllyAnimation_BowieBase
                dc.l AllyAnimation_BowiePromo
                dc.l AllyAnimation_SarahBase
                dc.l AllyAnimation_SarahPromo
                dc.l AllyAnimation_SarahSpecial
                dc.l AllyAnimation_ChesterBase
                dc.l AllyAnimation_ChesterPromo
                dc.l AllyAnimation_ChesterSpecial
                dc.l AllyAnimation_JahaBase
                dc.l AllyAnimation_JahaPromo
                dc.l AllyAnimation_JahaSpecial
                dc.l AllyAnimation_KazinBase
                dc.l AllyAnimation_KazinPromo
                dc.l AllyAnimation_KazinSpecial
                dc.l AllyAnimation_SladeBase
                dc.l AllyAnimation_SladePromo
                dc.l AllyAnimation_KiwiBase
                dc.l AllyAnimation_KiwiPromo
                dc.l AllyAnimation_PeterBase
                dc.l AllyAnimation_PeterPromo
                dc.l AllyAnimation_MayBase
                dc.l AllyAnimation_MayPromo
                dc.l AllyAnimation_GerhaltBase
                dc.l AllyAnimation_GerhaltPromo
                dc.l AllyAnimation_LukeBase
                dc.l AllyAnimation_LukePromo
                dc.l AllyAnimation_RhodeSpecial
                dc.l AllyAnimation_RickBase
                dc.l AllyAnimation_RickPromo
                dc.l AllyAnimation_RickSpecial
                dc.l AllyAnimation_ElricBase
                dc.l AllyAnimation_ElricPromo
                dc.l AllyAnimation_ElricSpecial
                dc.l AllyAnimation_EricBase
                dc.l AllyAnimation_EricPromo
                dc.l AllyAnimation_EricSpecial
                dc.l AllyAnimation_KarnaBase
                dc.l AllyAnimation_KarnaPromo
                dc.l AllyAnimation_KarnaSpecial
                dc.l AllyAnimation_RandolfBase
                dc.l AllyAnimation_RandolfPromo
                dc.l AllyAnimation_RandolfSpecial
                dc.l AllyAnimation_TyrinBase
                dc.l AllyAnimation_TyrinPromo
                dc.l AllyAnimation_TyrinSpecial
                dc.l AllyAnimation_JanetBase
                dc.l AllyAnimation_JanetPromo
                dc.l AllyAnimation_JanetSpecial
                dc.l AllyAnimation_HiginsPromo
                dc.l AllyAnimation_SkreechPromo
                dc.l AllyAnimation_TayaSpecial
                dc.l AllyAnimation_FrayjaPromo
                dc.l AllyAnimation_JaroSpecial
                dc.l AllyAnimation_GyanPromo
                dc.l AllyAnimation_SheelaSpecial
                dc.l AllyAnimation_ZynkPromo
                dc.l AllyAnimation_ChazPromo
                dc.l AllyAnimation_LemonSpecial
                dc.l AllyAnimation_ClaudePromo
                
                ; Dodges
                dc.l AllyAnimation_BowieBase_Dodge
                dc.l AllyAnimation_BowiePromo_Dodge
                dc.l AllyAnimation_SarahBase_Dodge
                dc.l AllyAnimation_SarahPromo_Dodge
                dc.l AllyAnimation_SarahSpecial_Dodge
                dc.l AllyAnimation_ChesterBase_Dodge
                dc.l AllyAnimation_ChesterPromo_Dodge
                dc.l AllyAnimation_ChesterSpecial_Dodge
                dc.l AllyAnimation_JahaBase_Dodge
                dc.l AllyAnimation_JahaPromo_Dodge
                dc.l AllyAnimation_JahaSpecial_Dodge
                dc.l AllyAnimation_KazinBase_Dodge
                dc.l AllyAnimation_KazinPromo_Dodge
                dc.l AllyAnimation_KazinSpecial_Dodge
                dc.l AllyAnimation_SladeBase_Dodge
                dc.l AllyAnimation_SladePromo_Dodge
                dc.l AllyAnimation_KiwiBase_Dodge
                dc.l AllyAnimation_KiwiPromo_Dodge
                dc.l AllyAnimation_PeterBase_Dodge
                dc.l AllyAnimation_PeterPromo_Dodge
                dc.l AllyAnimation_MayBase_Dodge
                dc.l AllyAnimation_MayPromo_Dodge
                dc.l AllyAnimation_GerhaltBase_Dodge
                dc.l AllyAnimation_GerhaltPromo_Dodge
                dc.l AllyAnimation_LukeBase_Dodge
                dc.l AllyAnimation_LukePromo_Dodge
                dc.l AllyAnimation_RhodeSpecial_Dodge
                dc.l AllyAnimation_RickBase_Dodge
                dc.l AllyAnimation_RickPromo_Dodge
                dc.l AllyAnimation_RickSpecial_Dodge
                dc.l AllyAnimation_ElricBase_Dodge
                dc.l AllyAnimation_ElricPromo_Dodge
                dc.l AllyAnimation_ElricSpecial_Dodge
                dc.l AllyAnimation_EricBase_Dodge
                dc.l AllyAnimation_EricPromo_Dodge
                dc.l AllyAnimation_EricSpecial_Dodge
                dc.l AllyAnimation_KarnaBase_Dodge
                dc.l AllyAnimation_KarnaPromo_Dodge
                dc.l AllyAnimation_KarnaSpecial_Dodge
                dc.l AllyAnimation_RandolfBase_Dodge
                dc.l AllyAnimation_RandolfPromo_Dodge
                dc.l AllyAnimation_RandolfSpecial_Dodge
                dc.l AllyAnimation_TyrinBase_Dodge
                dc.l AllyAnimation_TyrinPromo_Dodge
                dc.l AllyAnimation_TyrinSpecial_Dodge
                dc.l AllyAnimation_JanetBase_Dodge
                dc.l AllyAnimation_JanetPromo_Dodge
                dc.l AllyAnimation_JanetSpecial_Dodge
                dc.l AllyAnimation_HiginsPromo_Dodge
                dc.l AllyAnimation_SkreechPromo_Dodge
                dc.l AllyAnimation_TayaSpecial_Dodge
                dc.l AllyAnimation_FrayjaPromo_Dodge
                dc.l AllyAnimation_JaroSpecial_Dodge
                dc.l AllyAnimation_GyanPromo_Dodge
                dc.l AllyAnimation_SheelaSpecial_Dodge
                dc.l AllyAnimation_ZynkPromo_Dodge
                dc.l AllyAnimation_ChazPromo_Dodge
                dc.l AllyAnimation_LemonSpecial_Dodge
                dc.l AllyAnimation_ClaudePromo_Dodge
                
                ; Specials
                dc.l AllyAnimation_SpearKNTE
                dc.l AllyAnimation_SpearPLDN
                dc.l AllyAnimation_SpearPGNT
                dc.l AllyAnimation_CriticalMMNK
                dc.l AllyAnimation_SpellCastMNST
                dc.l AllyAnimation_CriticalRBT
                dc.l AllyAnimation_AttackBRGN
AllyAnimation_BowieBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_00_bowie_base.bin"
AllyAnimation_BowiePromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_01_bowie_promo.bin"
AllyAnimation_SarahBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_02_sarah_base.bin"
AllyAnimation_SarahPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_03_sarah_promo.bin"
AllyAnimation_SarahSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_04_sarah_special.bin"
AllyAnimation_ChesterBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_05_chester_base.bin"
AllyAnimation_ChesterPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_06_chester_promo.bin"
AllyAnimation_ChesterSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_07_chester_special.bin"
AllyAnimation_JahaBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_08_jaha_base.bin"
AllyAnimation_JahaPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_09_jaha_promo.bin"
AllyAnimation_JahaSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_10_jaha_special.bin"
AllyAnimation_KazinBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_11_kazin_base.bin"
AllyAnimation_KazinPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_12_kazin_promo.bin"
AllyAnimation_KazinSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_13_kazin_special.bin"
AllyAnimation_SladeBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_14_slade_base.bin"
AllyAnimation_SladePromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_15_slade_promo.bin"
AllyAnimation_KiwiBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_16_kiwi_base.bin"
AllyAnimation_KiwiPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_17_kiwi_promo.bin"
AllyAnimation_PeterBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_18_peter_base.bin"
AllyAnimation_PeterPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_19_peter_promo.bin"
AllyAnimation_MayBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_20_may_base.bin"
AllyAnimation_MayPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_21_may_promo.bin"
AllyAnimation_GerhaltBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_22_gerhalt_base.bin"
AllyAnimation_GerhaltPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_23_gerhalt_promo.bin"
AllyAnimation_LukeBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_24_luke_base.bin"
AllyAnimation_LukePromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_25_luke_promo.bin"
AllyAnimation_RhodeSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_26_rhode_special.bin"
AllyAnimation_RickBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_27_rick_base.bin"
AllyAnimation_RickPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_28_rick_promo.bin"
AllyAnimation_RickSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_29_rick_special.bin"
AllyAnimation_ElricBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_30_elric_base.bin"
AllyAnimation_ElricPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_31_elric_promo.bin"
AllyAnimation_ElricSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_32_elric_special.bin"
AllyAnimation_EricBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_33_eric_base.bin"
AllyAnimation_EricPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_34_eric_promo.bin"
AllyAnimation_EricSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_35_eric_special.bin"
AllyAnimation_KarnaBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_36_karna_base.bin"
AllyAnimation_KarnaPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_37_karna_promo.bin"
AllyAnimation_KarnaSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_38_karna_special.bin"
AllyAnimation_RandolfBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_39_randolf_base.bin"
AllyAnimation_RandolfPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_40_randolf_promo.bin"
AllyAnimation_RandolfSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_41_randolf_special.bin"
AllyAnimation_TyrinBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_42_tyrin_base.bin"
AllyAnimation_TyrinPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_43_tyrin_promo.bin"
AllyAnimation_TyrinSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_44_tyrin_special.bin"
AllyAnimation_JanetBase:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_45_janet_base.bin"
AllyAnimation_JanetPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_46_janet_promo.bin"
AllyAnimation_JanetSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_47_janet_special.bin"
AllyAnimation_HiginsPromo
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_48_higins_promo.bin"
AllyAnimation_SkreechPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_49_screech_promo.bin"
AllyAnimation_TayaSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_50_taya_special.bin"
AllyAnimation_FrayjaPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_51_frayja_promo.bin"
AllyAnimation_JaroSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_52_jaro_special.bin"
AllyAnimation_GyanPromo
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_53_gyan_promo.bin"
AllyAnimation_SheelaSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_54_sheela_special.bin"
AllyAnimation_ZynkPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_55_zynk.bin"
AllyAnimation_ChazPromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_56_chaz_promo.bin"
AllyAnimation_LemonSpecial:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_57_lemon.bin"
AllyAnimation_ClaudePromo:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_58_claude.bin"
AllyAnimation_BowieBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_59_bowie_base_dodge.bin"
AllyAnimation_BowiePromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_60_bowie_promo_dodge.bin"
AllyAnimation_SarahBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_61_sarah_base_dodge.bin"
AllyAnimation_SarahPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_62_sarah_promo_dodge.bin"
AllyAnimation_SarahSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_63_sarah_special_dodge.bin"
AllyAnimation_ChesterBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_64_chester_base_dodge.bin"
AllyAnimation_ChesterPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_65_chester_promo_dodge.bin"
AllyAnimation_ChesterSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_66_chester_special_dodge.bin"
AllyAnimation_JahaBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_67_jaha_base_dodge.bin"
AllyAnimation_JahaPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_68_jaha_promo_dodge.bin"
AllyAnimation_JahaSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_69_jaha_special_dodge.bin"
AllyAnimation_KazinBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_70_kazin_base_dodge.bin"
AllyAnimation_KazinPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_71_kazin_promo_dodge.bin"
AllyAnimation_KazinSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_72_kazin_special_dodge.bin"
AllyAnimation_SladeBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_73_slade_base_dodge.bin"
AllyAnimation_SladePromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_74_slade_promo_dodge.bin"
AllyAnimation_KiwiBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_75_kiwi_base_dodge.bin"
AllyAnimation_KiwiPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_76_kiwi_promo_dodge.bin"				
AllyAnimation_PeterBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_77_peter_base_dodge.bin"
AllyAnimation_PeterPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_78_peter_promo_dodge.bin"
AllyAnimation_MayBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_79_may_base_dodge.bin"
AllyAnimation_MayPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_80_may_promo_dodge.bin"
AllyAnimation_GerhaltBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_81_gerhalt_base_dodge.bin"
AllyAnimation_GerhaltPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_82_gerhalt_promo_dodge.bin"
AllyAnimation_LukeBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_83_luke_base_dodge.bin"
AllyAnimation_LukePromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_84_luke_promo_dodge.bin"
AllyAnimation_RhodeSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_85_rhode_special_dodge.bin"
AllyAnimation_RickBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_86_rick_base_dodge.bin"
AllyAnimation_RickPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_87_rick_promo_dodge.bin"
AllyAnimation_RickSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_88_rick_special_dodge.bin"
AllyAnimation_ElricBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_89_elric_base_dodge.bin"
AllyAnimation_ElricPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_90_elric_promo_dodge.bin"
AllyAnimation_ElricSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_91_elric_special_dodge.bin"
AllyAnimation_EricBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_92_eric_base_dodge.bin"
AllyAnimation_EricPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_93_eric_promo_dodge.bin"
AllyAnimation_EricSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_94_eric_special_dodge.bin"
AllyAnimation_KarnaBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_95_karna_base_dodge.bin"
AllyAnimation_KarnaPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_96_karna_promo_dodge.bin"
AllyAnimation_KarnaSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_97_karna_special_dodge.bin"
AllyAnimation_RandolfBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_98_randolf_base_dodge.bin"
AllyAnimation_RandolfPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_99_randolf_promo_dodge.bin"
AllyAnimation_RandolfSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_100_randolf_special_dodge.bin"
AllyAnimation_TyrinBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_101_tyrin_base_dodge.bin"
AllyAnimation_TyrinPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_102_tyrin_promo_dodge.bin"
AllyAnimation_TyrinSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_103_tyrin_special_dodge.bin"
AllyAnimation_JanetBase_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_104_janet_base_dodge.bin"
AllyAnimation_JanetPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_105_janet_promo_dodge.bin"
AllyAnimation_JanetSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_106_janet_special_dodge.bin"
AllyAnimation_HiginsPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_107_higins_promo_dodge.bin"
AllyAnimation_SkreechPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_108_screech_promo_dodge.bin"
AllyAnimation_TayaSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_109_taya_special_dodge.bin"
AllyAnimation_FrayjaPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_110_frayja_promo_dodge.bin"
AllyAnimation_JaroSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_111_jaro_special_dodge.bin"
AllyAnimation_GyanPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_112_gyan_promo_dodge.bin"
AllyAnimation_SheelaSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_113_sheela_special_dodge.bin"
AllyAnimation_ZynkPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_114_zynk_dodge.bin"
AllyAnimation_ChazPromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_115_chaz_promo_dodge.bin"
AllyAnimation_LemonSpecial_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_116_lemon_dodge.bin"
AllyAnimation_ClaudePromo_Dodge:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_117_claude_dodge.bin"
AllyAnimation_SpearKNTE:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_118_special_knte_spear.bin"
AllyAnimation_SpearPLDN:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_119_special_pldn_spear.bin"
AllyAnimation_SpearPGNT:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_120_special_pgnt_spear.bin"
AllyAnimation_CriticalMMNK:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_121_special_msmk_critical.bin"
AllyAnimation_SpellCastMNST:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_122_special_mnst_flame.bin"
AllyAnimation_CriticalRBT:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_123_special_rbt_critical.bin"
AllyAnimation_AttackBRGN:
                incbin "data/graphics/battles/battlesprites/allies-sf2gu/animations/allyanimation_124_special_brgn_attack.bin"
