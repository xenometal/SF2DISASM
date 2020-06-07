
; ASM FILE code\gameflow\battle\battlescenes\getallyanimation-sfa2.asm :
; GetAllyAnimation routine (alternate implementation)

; =============== S U B R O U T I N E =======================================

; Alternate implementation of the ally battle sprite index getter routine.
;   Supports the association of special spear throwing animations to
;   a greater number of knight-type battle sprites.
;
;   Version 1.0 - February 18th, 2020
;   by Xenometal
;
;   In: D1 = animation type, Out: A0 = animation pointer

GetAllyAnimation:
        
@CENTAUR_BATTLESPRITES_COUNTER: equ @SPEARTHROW_ANIMATIONS_OFFSET-1
@SPEARTHROW_ANIMATIONS_OFFSET:  equ tbl_SpearThrowAnimations-tbl_CentaurBattleSprites
@ANIMATIONTYPE_DODGE:           equ 1
        
        move.l  d1,-(sp)
        move.w  d7,-(sp)
        
        ; Check if regular attack animation type
        tst.w   d1
        bne.s   @CheckSpecialAnimationType
        
; ---------------------------------------------------------------------------
        
        ; Check if weapon sprite is a spear
        cmpi.w  #SPEAR_WEAPONSPRITES_START,((CHARACTER_WEAPON_SPRITE-$1000000)).w
        blo.s   @GetAnimationIndex
        cmpi.w  #SPEAR_WEAPONSPRITES_END,((CHARACTER_WEAPON_SPRITE-$1000000)).w
        bhi.s   @GetAnimationIndex
        
        ; Check if battle sprite is a centaur
        lea     tbl_CentaurBattleSprites(pc), a0
        move.w  ((BATTLESCENE_ACTOR-$1000000)).w,d1
        move.w  #@CENTAUR_BATTLESPRITES_COUNTER,d7
        
@Loop:
        cmp.b   (a0,d7.w),d1
        beq.s   @GetSpearThrowAnimation
        dbf     d7,@Loop
        bra.s   @GetAnimationPointer
        
@GetSpearThrowAnimation:
        clr.w   d1
        move.b  @SPEARTHROW_ANIMATIONS_OFFSET(a0,d7.w),d1
        bra.s   @GetAnimationPointer
        
; ---------------------------------------------------------------------------
        
@CheckSpecialAnimationType:
        cmpi.w  #SPECIAL_ANIMATIONS_START,d1
        bhs.s   @GetAnimationPointer
        
        ; Check if dodge animation type
        cmpi.w  #@ANIMATIONTYPE_DODGE,d1
        bne.s   @Default
        moveq   #DODGE_ANIMATIONS_START,d1
        bra.s   @GetAnimationIndex
        
@Default:
        clr.w   d1                                      ; default to regular attack animation
        
@GetAnimationIndex:
        add.w   ((BATTLESCENE_ACTOR-$1000000)).w,d1
        
@GetAnimationPointer:
        movea.l (p_pt_AllyAnimations).l,a0
        lsl.w   #2,d1
        movea.l (a0,d1.w),a0
        
        move.w  (sp)+,d7
        move.l  (sp)+,d1
        rts
        
    ; End of function GetAllyAnimation
