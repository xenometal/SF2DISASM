
; ASM FILE data\maps\entries\map34\mapsetups\s6.asm :
; 0x5B6BE..0x5BFEE : 

; =============== S U B R O U T I N E =======================================

ms_map34_InitFunction:
		
		rts

	; End of function ms_map34_InitFunction

cs_5B6C0:       textCursor $C87
		setCamDest 2,4
		nextText $80,$80        ; "Yeeenn...queeen...{N}tillooora...synooora...{N}hear my voice....{W2}"
		nextSingleText $80,$80  ; "Evil Spirit, come.{W1}"
		entityFlashWhite $80,$64
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 80
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 60
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 40
		entityActionsWait $81
		 moveUp 1
		endActions
		nextSingleText $0,$81   ; "Hey, Evil Spirit is{N}appearing!{W1}"
		setCamDest 2,2
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 60
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 50
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 40
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 30
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 20
		setPos $82,7,6,DOWN
		csWait 7
		setPos $82,60,60,DOWN
		csWait 10
		setPos $82,7,6,DOWN
		setActscript $82,eas_Transparent
		setActscriptWait $0,eas_Init
		setActscriptWait $7,eas_Init
		setActscriptWait $1F,eas_Init
		setPos $0,7,12,UP
		setPos $7,6,12,UP
		setPos $1F,8,12,UP
		setCamDest 2,4
		entityActionsWait $80
		 moveUp 1
		endActions
		nextSingleText $80,$80  ; "Ahhh....{W1}"
		nextSingleText $0,$82   ; "Creed, what do you want?{W1}"
		nextSingleText $80,$80  ; "Zeon.{W1}"
		nextSingleText $0,$82   ; "Zeon?!  The King of the{N}Devils?{W1}"
		nod $80
		nextText $80,$80        ; "Yes.{W2}"
		nextText $80,$80        ; "He was unsealed.{W1}"
		nextText $80,$80        ; "What is he doing now?{N}What is he going to do?{W2}"
		nextSingleText $80,$80  ; "I need to know anything{N}about him.  Anything!{W1}"
		nextText $0,$82         ; "I've got something.{W1}"
		csWait 40
		flashScreenWhite $4
		csWait 30
		flashScreenWhite $4
		csWait 20
		flashScreenWhite $4
		mapFadeOutToWhite
		csWait 30
		nextSingleText $0,$82   ; "Hmmmm....{N}Hmmmm...mmmm....{W1}"
		entityActions $0
		 moveUp 1
		endActions
		entityActions $7
		 moveUp 1
		endActions
		entityActionsWait $1F
		 moveUp 1
		endActions
		nextSingleText $0,$7    ; "What is he doing now?{W1}"
		setFacing $81,DOWN
		nextText $0,$81         ; "He's channeling his mind{N}into the nature of all{N}things.{W2}"
		setFacing $81,UP
		mapFadeInFromWhite
		csWait 40
		setFacing $81,DOWN
		nextSingleText $0,$81   ; "Shhhh!  Be silent.{N}He's got something.{W1}"
		setFacing $81,UP
		setActscriptWait $80,eas_Jump
		setActscriptWait $80,eas_Jump
		nextSingleText $80,$80  ; "What did you find?{W1}"
		nextSingleText $0,$82   ; "The barrier around Grans{N}Island is too strong.{N}I can't see anything.{W1}"
		shiver $80
		nextSingleText $80,$80  ; "Please try again!{W1}"
		nextSingleText $0,$82   ; "If I touch something of his,{N}maybe I could contact his{N}mind better....{W1}"
		setCamDest 2,5
		setFacing $7,RIGHT
		setFacing $0,LEFT
		setFacing $1F,LEFT
		nextSingleText $0,$7    ; "{LEADER}, you have the{N}Jewel of Evil, right?{W1}"
		setFacing $80,DOWN
		setFacing $81,DOWN
		setActscriptWait $80,eas_Jump
		setActscriptWait $80,eas_Jump
		nextText $80,$80        ; "Is this true, {LEADER}?{W2}"
		nextSingleText $80,$80  ; "That's one of the magic{N}jewels used to seal{N}Zeon.  Give it to me.{W1}"
		setFacing $0,UP
		setFacing $7,UP
		setFacing $1F,UP
		nextSingleText $0,$7    ; "But, we can't remove it.{W1}"
		nextSingleText $80,$80  ; "I can.{W1}"
		entityActionsWait $80
		 moveDown 1
		endActions
		nextSingleText $80,$80  ; "Let me see it.{W1}"
		setActscriptWait $80,eas_46172
		entityActions $80
		 moveDown 1
		endActions
		csWait 2
		setActscriptWait $80,eas_461AA
		stopEntity $80
		csWait 20
		entityFlashWhite $0,$28
		startEntity $80
		entityActions $80
		 moveUp 1
		endActions
		csWait 2
		setActscriptWait $80,eas_461AA
		headshake $80
		nextText $80,$80        ; "Whhoooa!{W2}"
		nextSingleText $80,$80  ; "What's that light?{N}There are two!{W1}"
		nextSingleText $0,$7    ; "The other one is...{N}...ahhh...they called it,{N}the Jewel of Light.{W1}"
		shiver $80
		nextText $80,$80        ; "What?!{W2}"
		nextText $80,$80        ; "{LEADER}, do you have both{N}of the legendary jewels?{W2}"
		nextText $80,$80        ; "I can't remove them.{N}The chain is made of Mithril.{W2}"
		nextSingleText $80,$80  ; "Show them to him.{N}They might help him.{W1}"
		nod $0
		csWait 20
		setCamDest 2,4
		setActscriptWait $80,eas_Init
		entityActions $80
		 moveRight 1
		 moveUp 1
		endActions
		entityActionsWait $0
		 moveUp 2
		endActions
		setFacing $81,UP
		nextSingleText $FF,$FF  ; "{LEADER} displays the{N}jewels to Evil Spirit.{W1}"
		entityFlashWhite $0,$28
		nextText $0,$82         ; "Yeah, I feel it...I feel it...!{N}I think I can do it now.{N}Let me try again.{W1}"
		executeSubroutine csub_55EF4
		csWait 20
		executeSubroutine sub_55F82
		csWait 40
		executeSubroutine csub_55EF4
		csWait 30
		executeSubroutine sub_55F82
		csWait 30
		executeSubroutine csub_55EF4
		csWait 40
		executeSubroutine sub_55F82
		csWait 20
		executeSubroutine csub_55EF4
		nextSingleText $0,$82   ; "Hmmmm....{N}Hmmmm...mmmm....{W1}"
		csWait 100
		nextSingleText $0,$82   ; "Arc Valley was opened and{N}Zeon was revived.{W1}"
		nextSingleText $80,$80  ; "Go on.{W1}"
		nextSingleText $0,$82   ; "Zeon's devils are coming to{N}Parmecia from the sky.{W1}"
		nextText $80,$80        ; "Hmmm....{W2}"
		nextSingleText $80,$80  ; "Where are they heading?{W1}"
		nextSingleText $0,$82   ; "North Parmecia.{W1}"
		nextSingleText $80,$80  ; "Something has happened to{N}Mitula....{W1}"
		nextSingleText $0,$82   ; "I can't see Zeon.{W1}"
		setActscriptWait $80,eas_Jump
		setActscriptWait $80,eas_Jump
		nextSingleText $80,$80  ; "What do you mean?{W1}"
		nextText $0,$82         ; "He's still in Arc Valley.{W2}"
		nextSingleText $0,$82   ; "He has revived, but he has{N}not recovered his full{N}strength yet.{W1}"
		nextText $80,$80        ; "But, he has already created{N}"
		nextText $80,$80        ; "a lot of mischief on the{N}ground...{W2}"
		nextSingleText $80,$80  ; "Is he that powerful?{W1}"
		nextSingleText $0,$82   ; "He is.{N}His power...{W1}"
		executeSubroutine sub_5BFDA
		csWait 10
		executeSubroutine csub_5BFD0
		nextSingleText $80,$80  ; "His power what?{W1}"
		executeSubroutine sub_5BFDA
		csWait 10
		executeSubroutine csub_5BFD0
		nextSingleText $0,$82   ; "Hi...s...pow...er...{W1}"
		executeSubroutine sub_5BFDA
		csWait 10
		executeSubroutine csub_5BFD0
		csWait 10
		executeSubroutine sub_5BFDA
		flashScreenWhite $28
		executeSubroutine sub_5BFE4
		setActscript $0,eas_Jump
		setActscript $7,eas_Jump
		setActscript $1F,eas_Jump
		setActscript $80,eas_Jump
		setActscriptWait $81,eas_Jump
		setActscript $0,eas_Jump
		setActscript $7,eas_Jump
		setActscript $1F,eas_Jump
		setActscript $80,eas_Jump
		setActscriptWait $81,eas_Jump
		nextSingleText $0,$83   ; "I'm Zeon!  I'm the King of{N}the Devils!{W1}"
		nextSingleText $80,$80  ; "What's this?!{W1}"
		nextText $0,$83         ; "Who's contacting me?{N}Do you want to die?{W1}"
		nextSingleText $0,$83   ; "Ggggooo...I see a jewel.{N}The Jewel of Evil!{W1}"
		shiver $80
		nextText $80,$80        ; "He's seeing us through the{N}eyes of Evil Spirit!{W2}"
		nextSingleText $80,$80  ; "Impossible!{W1}"
		nextText $0,$83         ; "You're {LEADER}.{N}I see you....{W2}"
		nextSingleText $0,$83   ; "Listen, {LEADER}.{N}Bring that jewel to Arc{N}Valley.{W1}"
		entityActionsWait $7
		 moveUp 1
		endActions
		nextSingleText $0,$7    ; "Why should we?!{W1}"
		nextText $0,$83         ; "I'll return Elis to you in{N}exchange for the jewel.{W2}"
		nextSingleText $0,$83   ; "Come to Arc Valley...{N}Ggggooo...!{W1}"
		csWait 40
		flashScreenWhite $4
		executeSubroutine sub_5BFDA
		csWait 8
		executeSubroutine sub_5BFE4
		csWait 60
		flashScreenWhite $4
		executeSubroutine sub_5BFDA
		csWait 8
		executeSubroutine sub_5BFE4
		csWait 40
		flashScreenWhite $4
		executeSubroutine sub_5BFDA
		csWait 8
		executeSubroutine sub_5BFE4
		csWait 20
		flashScreenWhite $4
		executeSubroutine sub_5BFDA
		setQuake 5
		playSound SFX_BIG_DOOR_RUMBLE
		customActscriptWait $85
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $86
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $87
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $88
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $89
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $8A
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $8B
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $8C
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $8D
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $8E
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $8F
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $90
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $91
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $92
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $93
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		customActscriptWait $94
		 ac_setSpeed 64,64      ;   
		 ac_jump eas_Idle       ;   
		ac_end
		setPos $8D,8,6,RIGHT
		setPos $8E,7,5,RIGHT
		setPos $8F,6,6,RIGHT
		setPos $90,7,7,RIGHT
		setActscript $8D,eas_464BE
		setActscript $8E,eas_464C6
		setActscript $8F,eas_464CE
		setActscript $90,eas_464D6
		setPos $91,8,6,LEFT
		setPos $92,7,7,LEFT
		setPos $93,6,6,LEFT
		setPos $94,7,5,LEFT
		entityActions $91
		 moveRight 1
		endActions
		csWait 2
		setActscriptWait $91,eas_461AA
		entityActions $92
		 moveDown 1
		endActions
		csWait 2
		setActscriptWait $92,eas_461AA
		entityActions $93
		 moveLeft 1
		endActions
		csWait 2
		setActscriptWait $93,eas_461AA
		entityActions $94
		 moveUp 1
		endActions
		csWait 2
		setActscriptWait $94,eas_461AA
		setActscript $91,eas_464E2
		setActscript $92,eas_464EA
		setActscript $93,eas_464F2
		setActscript $94,eas_464FA
		playSound SFX_BATTLEFIELD_DEATH
		setPos $85,7,6,RIGHT
		setPos $86,7,6,RIGHT
		setPos $87,7,6,RIGHT
		setPos $88,7,6,RIGHT
		setPos $89,7,6,RIGHT
		setPos $8A,7,6,RIGHT
		setPos $8B,7,6,RIGHT
		setPos $8C,7,6,RIGHT
		entityActions $85
		 moveRight 4
		endActions
		entityActions $86
		 moveUp 4
		endActions
		entityActions $87
		 moveLeft 4
		endActions
		entityActions $88
		 moveDown 4
		endActions
		entityActions $89
		 moveUpRight 4
		endActions
		entityActions $8A
		 moveUpLeft 4
		endActions
		entityActions $8B
		 moveDownLeft 4
		endActions
		entityActionsWait $8C
		 moveDownRight 4
		endActions
		playSound SFX_BATTLEFIELD_DEATH
		setPos $85,7,6,RIGHT
		setPos $86,7,6,RIGHT
		setPos $87,7,6,RIGHT
		setPos $88,7,6,RIGHT
		setPos $89,7,6,RIGHT
		setPos $8A,7,6,RIGHT
		setPos $8B,7,6,RIGHT
		setPos $8C,7,6,RIGHT
		entityActions $85
		 moveRight 4
		endActions
		entityActions $86
		 moveUp 4
		endActions
		entityActions $87
		 moveLeft 4
		endActions
		entityActions $88
		 moveDown 4
		endActions
		entityActions $89
		 moveUpRight 4
		endActions
		entityActions $8A
		 moveUpLeft 4
		endActions
		entityActions $8B
		 moveDownLeft 4
		endActions
		entityActionsWait $8C
		 moveDownRight 4
		endActions
		playSound SFX_BATTLEFIELD_DEATH
		setPos $85,7,6,RIGHT
		setPos $86,7,6,RIGHT
		setPos $87,7,6,RIGHT
		setPos $88,7,6,RIGHT
		setPos $89,7,6,RIGHT
		setPos $8A,7,6,RIGHT
		setPos $8B,7,6,RIGHT
		setPos $8C,7,6,RIGHT
		entityActions $85
		 moveRight 4
		endActions
		entityActions $86
		 moveUp 4
		endActions
		entityActions $87
		 moveLeft 4
		endActions
		entityActions $88
		 moveDown 4
		endActions
		entityActions $89
		 moveUpRight 4
		endActions
		entityActions $8A
		 moveUpLeft 4
		endActions
		entityActions $8B
		 moveDownLeft 4
		endActions
		entityActionsWait $8C
		 moveDownRight 4
		endActions
		hide $82
		playSound SFX_BATTLEFIELD_DEATH
		playSound SFX_BIG_DOOR_RUMBLE
		setPos $85,7,6,RIGHT
		setPos $86,7,6,RIGHT
		setPos $87,7,6,RIGHT
		setPos $88,7,6,RIGHT
		setPos $89,7,6,RIGHT
		setPos $8A,7,6,RIGHT
		setPos $8B,7,6,RIGHT
		setPos $8C,7,6,RIGHT
		entityActions $85
		 moveRight 4
		endActions
		entityActions $86
		 moveUp 4
		endActions
		entityActions $87
		 moveLeft 4
		endActions
		entityActions $88
		 moveDown 4
		endActions
		entityActions $89
		 moveUpRight 4
		endActions
		entityActions $8A
		 moveUpLeft 4
		endActions
		entityActions $8B
		 moveDownLeft 4
		endActions
		entityActionsWait $8C
		 moveDownRight 4
		endActions
		playSound SFX_BATTLEFIELD_DEATH
		setPos $85,7,6,RIGHT
		setPos $86,7,6,RIGHT
		setPos $87,7,6,RIGHT
		setPos $88,7,6,RIGHT
		setPos $89,7,6,RIGHT
		setPos $8A,7,6,RIGHT
		setPos $8B,7,6,RIGHT
		setPos $8C,7,6,RIGHT
		entityActions $85
		 moveRight 4
		endActions
		entityActions $86
		 moveUp 4
		endActions
		entityActions $87
		 moveLeft 4
		endActions
		entityActions $88
		 moveDown 4
		endActions
		entityActions $89
		 moveUpRight 4
		endActions
		entityActions $8A
		 moveUpLeft 4
		endActions
		entityActions $8B
		 moveDownLeft 4
		endActions
		entityActionsWait $8C
		 moveDownRight 4
		endActions
		hide $85
		hide $86
		hide $87
		hide $88
		hide $89
		hide $8A
		hide $8B
		hide $8C
		csWait 40
		hide $8D
		hide $8E
		hide $8F
		hide $90
		hide $91
		hide $92
		hide $93
		hide $94
		setQuake 16389
		executeSubroutine sub_55F82
		csWait 60
		setFacing $0,DOWN
		setFacing $81,DOWN
		setFacing $80,DOWN
		nextText $80,$80        ; "No!  Evil Spirit exploded!{W2}"
		nextText $80,$80        ; "That's Zeon's power.{W2}"
		nextSingleText $80,$80  ; "If he revives fully, his{N}power will be unimaginably{N}strong!{W1}"
		setFacing $81,RIGHT
		setFacing $80,LEFT
		nextSingleText $0,$81   ; "Creed, how reliable was he,{N}I mean, Evil Spirit?{W1}"
		nextText $80,$80        ; "Very.{W2}"
		setFacing $80,DOWN
		nextText $80,$80        ; "Why does Zeon want the jewel?{W2}"
		nextSingleText $80,$80  ; "No more questions...{N}...without Evil Spirit....{W1}"
		csWait 30
		entityActionsWait $80
		 moveDown 1
		 moveLeft 1
		 moveDown 5
		endActions
		hide $80
		entityActionsWait $81
		 moveLeft 1
		 moveDown 1
		endActions
		setFacing $7,DOWN
		setFacing $1F,DOWN
		nextText $0,$81         ; "Creed?  Creed!{W2}"
		setActscriptWait $81,eas_Jump
		setActscriptWait $81,eas_Jump
		nextSingleText $0,$81   ; "Hey, don't leave me here!{N}Wait for me!{W1}"
		entityActionsWait $81
		 moveDown 5
		endActions
		hide $81
		followEntity $7,$0,$2
		followEntity $1F,$7,$2
		csc_end

; =============== S U B R O U T I N E =======================================

csub_5BFD0:
		moveq   #0,d0
		jsr     sub_20058
		rts

	; End of function csub_5BFD0


; =============== S U B R O U T I N E =======================================

sub_5BFDA:
		moveq   #1,d0
		jsr     sub_20058
		rts

	; End of function sub_5BFDA


; =============== S U B R O U T I N E =======================================

sub_5BFE4:
		moveq   #2,d0
		jsr     sub_20058
		rts

	; End of function sub_5BFE4

