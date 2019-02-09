
; ASM FILE data\maps\entries\map03\mapsetups\s3_zoneevents.asm :
; 0x50D4C..0x50EEA : 
ms_map3_ZoneEvents:
                msZoneEvent 2, 255, Map3_ZoneEvent0-ms_map3_ZoneEvents
                msZoneEvent 27, 5, Map3_ZoneEvent1-ms_map3_ZoneEvents
                msZoneEvent 28, 5, Map3_ZoneEvent1-ms_map3_ZoneEvents
                msZoneEvent 29, 5, Map3_ZoneEvent1-ms_map3_ZoneEvents
                msZoneEvent 30, 5, Map3_ZoneEvent4-ms_map3_ZoneEvents
                msZoneEvent 31, 5, Map3_ZoneEvent4-ms_map3_ZoneEvents
                msZoneEvent 4, 4, Map3_ZoneEvent6-ms_map3_ZoneEvents
                msZoneEvent 58, 13, Map3_ZoneEvent7-ms_map3_ZoneEvents
                msZoneEvent 43, 10, Map3_ZoneEvent8-ms_map3_ZoneEvents
                msDefaultZoneEvent Map3_DefaultZoneEvent-ms_map3_ZoneEvents

; =============== S U B R O U T I N E =======================================

Map3_ZoneEvent0:
                
                 
                script  cs_51444
                chkFlg  $101            ; TEMP FLAG #01
                bne.s   byte_50DA6      
                jsr     (WaitForCameraToCatchUp).l
                move.w  ((SPEECH_SFX-$1000000)).w,((SPEECH_SFX_BACKUP-$1000000)).w
                move.w  #$8C,d0 
                jsr     GetEntityPortraitAndSpeechSfx
                move.w  d1,((CURRENT_PORTRAIT-$1000000)).w
                move.w  d2,((SPEECH_SFX-$1000000)).w
                txt     $1F2            ; "You unruly boy!{N}Where on earth are you{N}going?{W2}"
                txt     $1F3            ; "There is no school outside!{N}Go to school!{W1}"
byte_50DA6:
                
                setFlg  $101            ; TEMP FLAG #01
                rts

	; End of function Map3_ZoneEvent0


; =============== S U B R O U T I N E =======================================

Map3_ZoneEvent1:
                
                 
                chkFlg  $258            ; Set after agreeing to try getting into the castle
                bne.s   byte_50DE6      
                script  cs_5144C
                chkFlg  $102            ; TEMP FLAG #02
                bne.s   byte_50DE0      
                jsr     (WaitForCameraToCatchUp).l
                move.w  ((SPEECH_SFX-$1000000)).w,((SPEECH_SFX_BACKUP-$1000000)).w
                move.w  #$8A,d0 
                jsr     GetEntityPortraitAndSpeechSfx
                move.w  d1,((CURRENT_PORTRAIT-$1000000)).w
                move.w  d2,((SPEECH_SFX-$1000000)).w
                txt     $1F1            ; "You cannot enter the castle{N}of Granseal.  Go away!{W1}"
byte_50DE0:
                
                setFlg  $102            ; TEMP FLAG #02
                bra.s   return_50DF6
byte_50DE6:
                
                chkFlg  $25C            ; Set after the guards have listened to Sarah and allowed you into the castle
                bne.s   return_50DF6
                script  cs_51652
                setFlg  $25C            ; Set after the guards have listened to Sarah and allowed you into the castle
return_50DF6:
                
                rts

	; End of function Map3_ZoneEvent1


; =============== S U B R O U T I N E =======================================

Map3_ZoneEvent4:
                
                 
                chkFlg  $258            ; Set after agreeing to try getting into the castle
                bne.s   byte_50E32      
                script  cs_51454
                chkFlg  $103            ; TEMP FLAG #03
                bne.s   byte_50E2C      
                move.w  ((SPEECH_SFX-$1000000)).w,((SPEECH_SFX_BACKUP-$1000000)).w
                move.w  #$8B,d0 
                jsr     GetEntityPortraitAndSpeechSfx
                move.w  d1,((CURRENT_PORTRAIT-$1000000)).w
                move.w  d2,((SPEECH_SFX-$1000000)).w
                jsr     (WaitForCameraToCatchUp).l
                txt     $1F1            ; "You cannot enter the castle{N}of Granseal.  Go away!{W1}"
byte_50E2C:
                
                setFlg  $103            ; TEMP FLAG #03
                bra.s   return_50E42
byte_50E32:
                
                chkFlg  $25C            ; Set after the guards have listened to Sarah and allowed you into the castle
                bne.s   return_50E42
                script  cs_51652
                setFlg  $25C            ; Set after the guards have listened to Sarah and allowed you into the castle
return_50E42:
                
                rts

	; End of function Map3_ZoneEvent4


; =============== S U B R O U T I N E =======================================

Map3_ZoneEvent6:
                
                 
                chkFlg  $259            ; Set after Bowie is intercepted by his mother going downstairs
                bne.s   return_50E64
                script  cs_5145C
                move.w  #$80,d0 
                moveq   #5,d1
                moveq   #6,d2
                moveq   #1,d3
                jsr     MakeEntityWalk
                setFlg  $259            ; Set after Bowie is intercepted by his mother going downstairs
return_50E64:
                
                rts

	; End of function Map3_ZoneEvent6


; =============== S U B R O U T I N E =======================================

Map3_ZoneEvent7:
                
                 
                chkFlg  $25B            ; Set after the messenger scene
                bne.s   return_50ED0
                chkFlg  $25A            ; Set after Astral's second basement line
                bne.s   byte_50E96      
                move.w  ((SPEECH_SFX-$1000000)).w,((SPEECH_SFX_BACKUP-$1000000)).w
                move.w  #$8E,d0 
                jsr     GetEntityPortraitAndSpeechSfx
                move.w  d1,((CURRENT_PORTRAIT-$1000000)).w
                move.w  d2,((SPEECH_SFX-$1000000)).w
                jsr     LoadAndDisplayCurrentPortrait
                txt     $201            ; "Mmm...aahh...{N}Oh, yeah!  It must be....{N}No, it's not a....{W1}"
                bra.s   return_50ED0
byte_50E96:
                
                chkFlg  $104            ; TEMP FLAG #04
                bne.s   return_50ED0
                move.w  ((SPEECH_SFX-$1000000)).w,((SPEECH_SFX_BACKUP-$1000000)).w
                move.w  #$8E,d0 
                jsr     GetEntityPortraitAndSpeechSfx
                move.w  d1,((CURRENT_PORTRAIT-$1000000)).w
                move.w  d2,((SPEECH_SFX-$1000000)).w
                jsr     LoadAndDisplayCurrentPortrait
                txt     $202            ; "By the way, {LEADER},{N}what did you think of the{N}storm last night?{W2}"
                txt     $203            ; "Did you feel something evil,{N}or anything?{W2}"
                txt     $204            ; "No, nothing?!{N}Perhaps it was just my{N}imagination.  Sorry.{W1}"
                script  cs_5148C
                setFlg  $104            ; TEMP FLAG #04
return_50ED0:
                
                rts

	; End of function Map3_ZoneEvent7


; =============== S U B R O U T I N E =======================================

Map3_ZoneEvent8:
                
                 
                chkFlg  $25A            ; Set after Astral's second basement line
                beq.s   Map3_DefaultZoneEvent
                chkFlg  $25B            ; Set after the messenger scene
                bne.s   Map3_DefaultZoneEvent
                script  cs_5149A
                setFlg  $25B            ; Set after the messenger scene
Map3_DefaultZoneEvent:
                
                rts

	; End of function Map3_ZoneEvent8
