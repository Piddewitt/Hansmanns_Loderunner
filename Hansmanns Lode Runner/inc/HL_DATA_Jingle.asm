; --------------------------------------------------------------------------------------------------------------------- ;
; jingle frequency and play data
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleMaxNum             .byte TabJingleDataPtr_Len ; 
TabJingleHeight_Min         .byte $02 ; 
TabJingleHeight_Max         .byte $0c ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleDataPtr            = *       ; 
TabJingleDataPtr_Lo         = * + $00 ;
TabJingleDataPtr_Hi         = * + $01 ;
                            .word TabJingleData_00 ; $00
                            .word TabJingleData_01 ; $01
                            .word TabJingleData_02 ; $02
                            .word TabJingleData_03 ; $03
                            .word TabJingleData_04 ; $04
                            .word TabJingleData_05 ; $05
                            .word TabJingleData_06 ; $06
                            .word TabJingleData_07 ; $07
                            .word TabJingleData_08 ; $08
                            .word TabJingleData_09 ; $09
TabJingleDataPtr_Len        = (* - TabJingleDataPtr) / 2 - 1
; --------------------------------------------------------------------------------------------------------------------- ;
                            .word TabJingleData_0a ; $0a - empty: not used
                            .word TabJingleData_0a ; $0a - empty: not used
                            .word TabJingleData_0a ; $0a - empty: not used
                            .word TabJingleData_0a ; $0a - empty: not used
                            .word TabJingleData_0a ; $0a - empty: not used
; --------------------------------------------------------------------------------------------------------------------- ;
TabFreqCtrlData_Lo          = *       ; 
                            .byte $00 ; 
                            .byte $e1 ; 
                            .byte $68 ; 
                            .byte $f7 ; 
                            .byte $8f ; 
                            .byte $30 ; 
                            .byte $da ; 
                            .byte $8f ; 
                            .byte $4e ; 
                            .byte $18 ; 
                            .byte $ef ; 
                            .byte $d2 ; 
                            .byte $c3 ; 
                            .byte $c3 ; 
                            .byte $d1 ; 
                            .byte $ef ; 
                            .byte $1f ; 
                            .byte $60 ; 
                            .byte $b5 ; 
                            .byte $1e ; 
                            .byte $9c ; 
                            .byte $31 ; 
                            .byte $df ; 
                            .byte $a5 ; 
                            .byte $87 ; 
                            .byte $86 ; 
                            .byte $a2 ; 
                            .byte $df ; 
                            .byte $3e ; 
                            .byte $c1 ; 
                            .byte $6b ; 
                            .byte $3c ; 
                            .byte $39 ; 
                            .byte $63 ; 
                            .byte $be ; 
                            .byte $4b ; 
                            .byte $0f ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TabFreqCtrlData_Hi          = *       ; 
                            .byte $00 ; 
                            .byte $08 ; 
                            .byte $09 ; 
                            .byte $09 ; 
                            .byte $0a ; 
                            .byte $0b ; 
                            .byte $0b ; 
                            .byte $0c ; 
                            .byte $0d ; 
                            .byte $0e ; 
                            .byte $0e ; 
                            .byte $0f ; 
                            .byte $10 ; 
                            .byte $11 ; 
                            .byte $12 ; 
                            .byte $13 ; 
                            .byte $15 ; 
                            .byte $16 ; 
                            .byte $17 ; 
                            .byte $19 ; 
                            .byte $1a ; 
                            .byte $1c ; 
                            .byte $1d ; 
                            .byte $1f ; 
                            .byte $21 ; 
                            .byte $23 ; 
                            .byte $25 ; 
                            .byte $27 ; 
                            .byte $2a ; 
                            .byte $2c ; 
                            .byte $2f ; 
                            .byte $32 ; 
                            .byte $35 ; 
                            .byte $38 ; 
                            .byte $3b ; 
                            .byte $3f ; 
                            .byte $43 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_09            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
TabJingleDataBlock_Len      = * - TabJingleData_09
                            
                            .byte $08 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $0c ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $70 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $40 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_05            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                             
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $c0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $12 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0f ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $14 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $12 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $12 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0f ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $12 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $70 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $40 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_02            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                             
                            .byte $05 ; playtime
                            .byte $02 ; tune voice2
                            .byte $1c ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $04 ; tune voice2
                            .byte $17 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $05 ; tune voice2
                            .byte $15 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $07 ; tune voice2
                            .byte $13 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $09 ; tune voice2
                            .byte $11 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $0b ; tune voice2
                            .byte $10 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $0c ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0b ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $11 ; tune voice2
                            .byte $09 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $13 ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $15 ; tune voice2
                            .byte $05 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $17 ; tune voice2
                            .byte $04 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $1c ; tune voice2
                            .byte $02 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_06            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                             
                            .byte $04 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $c0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $06 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $08 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $0c ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $17 ; tune voice2
                            .byte $11 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $18 ; tune voice2
                            .byte $10 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_08            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                             
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol

                            .byte $03 ; playtime
                            .byte $0e ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol

                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $01 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $0e ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $0b ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $05 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $03 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_03            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $70 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $07 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $50 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_00            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $10 ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $13 ; tune voice2
                            .byte $10 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $11 ; tune voice2
                            .byte $0e ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $40 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $11 ; tune voice2
                            .byte $0e ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $40 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $40 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $90 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $80 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $70 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $10 ; tune voice2
                            .byte $0c ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $06 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $40 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $b0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $90 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $80 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $70 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $60 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $50 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $40 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $30 ; su/re/vol
                            
                            .byte $08 ; playtime
                            .byte $0e ; tune voice2
                            .byte $07 ; tune voice3
                            .byte $20 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_04            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $18 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $15 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $0c ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $18 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_07            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $18 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $17 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $16 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $15 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $14 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $12 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0f ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0e ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0d ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $0c ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $0c ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $18 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_01            = *       ; 
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $18 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $10 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $18 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $15 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $80 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $11 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $80 ; su/re/vol
                            
                            .byte $0c ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $12 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $15 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                             
                            .byte $04 ; playtime
                            .byte $1f ; tune voice2
                            .byte $0f ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $15 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $12 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $15 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $1f ; tune voice2
                            .byte $0f ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $15 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $17 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $d0 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $80 ; su/re/vol
                            
                            .byte $04 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $a0 ; su/re/vol
                            
                            .byte $02 ; playtime
                            .byte $13 ; tune voice2
                            .byte $ff ; tune voice3
                            .byte $80 ; su/re/vol
                            
                            .byte $10 ; playtime
                            .byte $00 ; tune voice2
                            .byte $00 ; tune voice3
                            .byte $00 ; su/re/vol
                            
                            .byte $00 ; end of Jingle marker
; --------------------------------------------------------------------------------------------------------------------- ;
TabJingleData_0a            = *       ; 
                            .byte $00 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
