; --------------------------------------------------------------------------------------------------------------------- ;
; demo moves table entry layout
; --------------------------------------------------------------------------------------------------------------------- ;
; byte 1 - move direction
;          left  nibble le/ri - offset to TabDemoJoystickMove - 1=le 3=ri 4=fire-ri 5=fire-le 6=none
;          right nibble up/do - offset to TabDemoJoystickMove - 0=up 2=do
; byte 2 - move duration
; --------------------------------------------------------------------------------------------------------------------- ;
; move values
; --------------------------------------------------------------------------------------------------------------------- ;
; $16 ; left-- none--
; $36 ; right- none--
; $60 ; none-- up----
; $62 ; none-- down--
;
; $44 ; fi_ri- fi_ri-
; $55 ; fi_le- fi_le-
;
; $66 ; none-- none--
; --------------------------------------------------------------------------------------------------------------------- ;
; demo moves data level 1
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoMoves                = *       ; 
TabDemoMovesLevel_01        = *       ; 
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
TabDemoMoveEntry_Len        = * - TabDemoMoves ; length of each move entry                                              .hbu003.
                            .byte $60 ; ------ up----                                                                   .hbu003.
                            .byte $26 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- none--                                                                   .hbu003.
                            .byte $2e ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $02 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi-ri- fi-ri-                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $8b ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- none--                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $7f ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- none--                                                                   .hbu003.
                            .byte $34 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $03 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- none--                                                                   .hbu003.
                            .byte $07 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $02 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- none--                                                                   .hbu003.
                            .byte $14 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $18 ;                                                                                 .hbu003.
                            
                            .byte $32 ; right- none--                                                                   .hbu003.
                            .byte $03 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- none--                                                                   .hbu003.
                            .byte $24 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $60 ; none-- up----                                                                   .hbu003.
                            .byte $09 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $40 ;                                                                                 .hbu003.
                            
                            .byte $60 ; none-- up----                                                                   .hbu003.
                            .byte $80 ;                                                                                 .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
; demo move data level 2
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoMovesLevel_02        = *       ; 
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $06 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $10 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $0c ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $24 ;                                                                                 .hbu003.
                            
                            .byte $32 ; right- down--                                                                   .hbu003.
                            .byte $14 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $30 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $30 ;                                                                                 .hbu003.
                            
                            .byte $30 ; right- up----                                                                   .hbu003.
                            .byte $14 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $0c ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $32 ; right- down--                                                                   .hbu003.
                            .byte $24 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $3c ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $50 ;                                                                                 .hbu003.
                            
                            .byte $32 ; right- down--                                                                   .hbu003.
                            .byte $2c ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $08 ;                                                                                 .hbu003.
                            
                            .byte $60 ; ------ up----                                                                   .hbu003.
                            .byte $08 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $08 ;                                                                                 .hbu003.
                            
                            .byte $02 ; ------ down--                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $7c ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $24 ;                                                                                 .hbu003.
                            
                            .byte $02 ; ------ down--                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $20 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- up----                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $38 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $20 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $10 ;                                                                                 .hbu003.
                            
                            .byte $55 ; fi_le- fi_le-                                                                   .hbu003.
                            .byte $40 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $20 ;                                                                                 .hbu003.
                            
                            .byte $12 ; left-- down--                                                                   .hbu003.
                            .byte $10 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $20 ;                                                                                 .hbu003.
                            
                            .byte $30 ; right- up----                                                                   .hbu003.
                            .byte $30 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $08 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $0c ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $10 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $1c ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $14 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $06 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $20 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $30 ; right- up----                                                                   .hbu003.
                            .byte $40 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $20 ;                                                                                 .hbu003.
                            
                            .byte $30 ; right- up----                                                                   .hbu003.
                            .byte $e0 ;                                                                                 .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
; demo move data level 3
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoMovesLevel_03        = *       ; 

                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $0f ;                                                                                 .hbu003.
                            
                            .byte $32 ; right- down--                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $62 ; ------ down--                                                                   .hbu003.
                            .byte $0a ;                                                                                 .hbu003.
                            
                            .byte $66 ; ------ ------                                                                   .hbu003.
                            .byte $6d ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $03 ;                                                                                 .hbu003.
                            
                            .byte $66 ; ------ ------                                                                   .hbu003.
                            .byte $02 ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $05 ;                                                                                 .hbu003.
                            
                            .byte $60 ; ------ up----                                                                   .hbu003.
                            .byte $43 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $1f ;                                                                                 .hbu003.
                            
                            .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $44 ; fi_ri- fi_ri-                                                                   .hbu003.
                            .byte $01 ;                                                                                 .hbu003.
                            
                            .byte $66 ; ------ ------                                                                   .hbu003.
                            .byte $03 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $0f ;                                                                                 .hbu003.
                            
                            .byte $12 ; left-- down--                                                                   .hbu003.
                            .byte $02 ;                                                                                 .hbu003.
                            
                            .byte $62 ; ------ down--                                                                   .hbu003.
                            .byte $05 ;                                                                                 .hbu003.
                            
                            .byte $66 ; ------ ------                                                                   .hbu003.
                            .byte $10 ;                                                                                 .hbu003.
                            
                            .byte $60 ; ------ up----                                                                   .hbu003.
                            .byte $07 ;                                                                                 .hbu003.
                            
                            .byte $16 ; left-- ------                                                                   .hbu003.
                            .byte $0a ;                                                                                 .hbu003.
                            
                            .byte $66 ; ------ ------                                                                   .hbu003.
                            .byte $90 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- ------                                                                   .hbu003.
                            .byte $50 ;                                                                                 .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
; demo move data level 4
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoMovesLevel_04        .byte $36 ; right- ------                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $60 ; ------ up----                                                                   .hbu003.
                            .byte $04 ;                                                                                 .hbu003.
                            
                            .byte $66 ; none-- none--                                                                   .hbu003.
                            .byte $10 ;                                                                                 .hbu003.
                            
                            .byte $10 ; left-- up----                                                                   .hbu003.
                            .byte $24 ;                                                                                 .hbu003.
                            
                            .byte $60 ; ------ up----                                                                   .hbu003.
                            .byte $a0 ;                                                                                 .hbu003.

                            .byte $00 ;                      ; end of new demo moves                                    .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoDataLevel             = *      ; demo level data
TabDemoDataLevel_01          = *; $00  $02  $04  $06  $08  $0a  $0c  $0e  $10  $12  $14  $16  $18  $1c ;                .hbu003.
                            .byte $02, $22, $22, $22, $22, $32, $22, $22, $22, $22, $22, $22, $22, $22 ; $00            .hbu003.
                            .byte $32, $22, $33, $32, $33, $22, $32, $23, $22, $32, $23, $22, $33, $22 ; $01            .hbu003.
                            .byte $32, $22, $23, $22, $23, $22, $23, $32, $22, $23, $22, $32, $22, $23 ; $02            .hbu003.
                            .byte $32, $22, $33, $22, $23, $22, $33, $33, $22, $23, $33, $32, $22, $23 ; $03            .hbu003.
                            .byte $32, $22, $23, $22, $23, $22, $23, $32, $22, $23, $32, $32, $22, $23 ; $04            .hbu003.
                            .byte $32, $23, $33, $22, $23, $22, $23, $32, $02, $32, $23, $22, $33, $22 ; $05            .hbu003.
                            .byte $62, $22, $22, $22, $22, $22, $22, $22, $02, $22, $22, $22, $22, $22 ; $06            .hbu003.
                            .byte $62, $02, $00, $00, $00, $00, $00, $70, $00, $00, $00, $00, $00, $00 ; $07            .hbu003.
                            .byte $62, $22, $22, $02, $22, $22, $22, $22, $02, $12, $22, $22, $22, $32 ; $08            .hbu003.
                            .byte $62, $02, $00, $02, $00, $00, $00, $00, $00, $02, $00, $00, $00, $30 ; $09            .hbu003.
                            .byte $62, $02, $00, $12, $25, $22, $22, $22, $22, $00, $00, $00, $00, $30 ; $0a            .hbu003.
                            .byte $62, $02, $00, $12, $10, $00, $00, $00, $00, $00, $00, $00, $00, $30 ; $0b            .hbu003.
                            .byte $62, $72, $44, $44, $16, $00, $00, $00, $00, $00, $00, $00, $00, $30 ; $0c            .hbu003.
                            .byte $62, $22, $11, $11, $11, $00, $00, $00, $00, $00, $00, $00, $00, $30 ; $0d            .hbu003.
                            .byte $62, $00, $80, $88, $08, $00, $00, $00, $00, $00, $00, $00, $00, $30 ; $0e            .hbu003.
                            .byte $22, $22, $22, $22, $02, $00, $00, $00, $00, $08, $00, $00, $00, $39 ; $0f            .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
                            .byte $00 ;                                                                                 .hbu003.
                            
                            .byte "a" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "g" | $80 ;                                                                           .hbu003.
                            .byte "o" | $80 ;                                                                           .hbu003.
                            .byte "o" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "o" | $80 ;                                                                           .hbu003.
                            .byte "l" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "l" | $80 ;                                                                           .hbu003.
                            .byte "a" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte "y" | $80 ;                                                                           .hbu003.
                            
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            
                            .byte "l" | $80 ;                                                                           .hbu003.
                            .byte "o" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "r" | $80 ;                                                                           .hbu003.
                            .byte "u" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "r"       ;                                                                           .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoDataLevel_02          = *; $00  $02  $04  $06  $08  $0a  $0c  $0e  $10  $12  $14  $16  $18  $1c ; 
                            .byte $08, $00, $00, $00, $10, $00, $60, $00, $00, $72, $00, $00, $00, $89 ; $00            .hbu003.
                            .byte $10, $00, $00, $00, $10, $70, $16, $07, $00, $32, $10, $07, $10, $01 ; $01            .hbu003.
                            .byte $11, $70, $00, $00, $10, $30, $10, $22, $03, $32, $20, $12, $01, $10 ; $02            .hbu003.
                            .byte $10, $11, $03, $00, $10, $30, $10, $00, $03, $32, $00, $00, $00, $00 ; $03            .hbu003.
                            .byte $00, $00, $03, $00, $10, $30, $10, $13, $03, $32, $70, $00, $11, $11 ; $04            .hbu003.
                            .byte $00, $00, $03, $00, $10, $30, $10, $03, $00, $12, $11, $01, $00, $00 ; $05            .hbu003.
                            .byte $13, $11, $11, $01, $11, $30, $10, $11, $03, $00, $00, $11, $11, $01 ; $06            .hbu003.
                            .byte $03, $00, $00, $10, $10, $30, $00, $00, $03, $00, $00, $00, $00, $00 ; $07            .hbu003.
                            .byte $03, $00, $00, $00, $10, $11, $03, $07, $03, $07, $10, $11, $11, $11 ; $08            .hbu003.
                            .byte $03, $00, $00, $00, $17, $11, $03, $03, $11, $11, $00, $00, $00, $00 ; $09            .hbu003.
                            .byte $03, $11, $11, $10, $11, $00, $13, $01, $00, $10, $11, $11, $11, $01 ; $0a            .hbu003.
                            .byte $03, $00, $22, $22, $22, $00, $03, $00, $00, $00, $00, $00, $00, $00 ; $0b            .hbu003.
                            .byte $03, $00, $00, $00, $20, $00, $03, $00, $11, $11, $11, $11, $11, $11 ; $0c            .hbu003.
                            .byte $03, $00, $00, $70, $00, $60, $11, $01, $00, $00, $00, $00, $00, $00 ; $0d            .hbu003.
                            .byte $13, $73, $13, $11, $11, $03, $00, $11, $11, $11, $11, $11, $11, $01 ; $0e            .hbu003.
                            .byte $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $0f            .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
                            .byte $00 ;                                                                                 .hbu003.
                            
                            .byte "b" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "a" | $80 ;                                                                           .hbu003.
                            .byte "u" | $80 ;                                                                           .hbu003.
                            .byte "t" | $80 ;                                                                           .hbu003.
                            .byte "i" | $80 ;                                                                           .hbu003.
                            .byte "f" | $80 ;                                                                           .hbu003.
                            .byte "i" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "w" | $80 ;                                                                           .hbu003.
                            .byte "i" | $80 ;                                                                           .hbu003.
                            .byte "t" | $80 ;                                                                           .hbu003.
                            .byte "h" | $80 ;                                                                           .hbu003.
                            
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            
                            .byte "l" | $80 ;                                                                           .hbu003.
                            .byte "o" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "r" | $80 ;                                                                           .hbu003.
                            .byte "u" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "r"       ;                                                                           .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoDataLevel_03          = *; $00  $02  $04  $06  $08  $0a  $0c  $0e  $10  $12  $14  $16  $18  $1c ; 
                            .byte $33, $13, $11, $33, $13, $31, $13, $01, $31, $33, $11, $33, $13, $11 ; $00            .hbu003.
                            .byte $33, $13, $11, $33, $13, $31, $13, $01, $31, $33, $11, $33, $13, $11 ; $01            .hbu003.
                            .byte $33, $13, $11, $33, $13, $31, $13, $00, $00, $00, $00, $00, $69, $66 ; $02            .hbu003.
                            .byte $33, $13, $11, $33, $13, $31, $03, $00, $22, $23, $22, $71, $21, $32 ; $03            .hbu003.
                            .byte $33, $13, $11, $33, $13, $61, $66, $66, $22, $22, $22, $22, $22, $36 ; $04            .hbu003.
                            .byte $33, $13, $11, $33, $13, $00, $00, $00, $10, $11, $11, $11, $11, $36 ; $05            .hbu003.
                            .byte $33, $13, $11, $33, $03, $00, $00, $00, $00, $11, $11, $11, $11, $36 ; $06            .hbu003.
                            .byte $33, $13, $11, $33, $00, $00, $00, $00, $00, $10, $11, $11, $11, $36 ; $07            .hbu003.
                            .byte $33, $13, $11, $03, $00, $00, $00, $00, $00, $00, $11, $11, $11, $36 ; $08            .hbu003.
                            .byte $33, $13, $11, $00, $00, $00, $00, $00, $00, $00, $10, $11, $11, $36 ; $09            .hbu003.
                            .byte $33, $13, $01, $00, $00, $00, $00, $00, $00, $00, $00, $11, $11, $36 ; $0a            .hbu003.
                            .byte $33, $13, $00, $00, $00, $00, $00, $00, $00, $00, $00, $10, $11, $36 ; $0b            .hbu003.
                            .byte $33, $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $11, $36 ; $0c            .hbu003.
                            .byte $33, $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $10, $36 ; $0d            .hbu003.
                            .byte $33, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $36 ; $0e            .hbu003.
                            .byte $03, $00, $00, $00, $00, $10, $00, $00, $00, $08, $00, $00, $00, $36 ; $0f            .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
                            .byte $00 ;                                                                                 .hbu003.
                            
                            .byte "a" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "f" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "w" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "w" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "i" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "a" | $80 ;                                                                           .hbu003.
                            .byte "s" | $80 ;                                                                           .hbu003.
                            
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            
                            .byte "l" | $80 ;                                                                           .hbu003.
                            .byte "o" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "r" | $80 ;                                                                           .hbu003.
                            .byte "u" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "r"       ;                                                                           .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
TabDemoDataLevel_04          = *; $00  $02  $04  $06  $08  $0a  $0c  $0e  $10  $12  $14  $16  $18  $1c ;                .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $00            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $01            .hbu003.
                            .byte $00, $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00 ; $02            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $03            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $04            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $05            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $06            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $07            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $08            .hbu003.
                            .byte $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $09            .hbu003.
                            .byte $00, $00, $00, $00, $60, $07, $08, $00, $00, $00, $00, $00, $00, $00 ; $0a            .hbu003.
                            .byte $00, $00, $00, $00, $00, $61, $11, $03, $00, $00, $00, $00, $00, $00 ; $0b            .hbu003.
                            .byte $00, $00, $00, $00, $00, $11, $11, $03, $00, $00, $00, $00, $00, $00 ; $0c            .hbu003.
                            .byte $00, $00, $00, $00, $00, $00, $90, $03, $00, $00, $00, $00, $00, $00 ; $0d            .hbu003.
                            .byte $00, $00, $00, $00, $00, $22, $22, $02, $00, $00, $00, $00, $00, $00 ; $0e            .hbu003.
                            .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $0f            .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
                            .byte $00 ;                                                                                 .hbu003.
                            
                            .byte "v" | $80 ;                                                                           .hbu003.
                            .byte "i" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "l" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte "s" | $80 ;                                                                           .hbu003.
                            .byte "p" | $80 ;                                                                           .hbu003.
                            .byte "a" | $80 ;                                                                           .hbu003.
                            .byte "s" | $80 ;                                                                           .hbu003.
                            .byte "s" | $80 ;                                                                           .hbu003.
                            .byte "!" | $80 ;                                                                           .hbu020.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ;                                                                           .hbu003.
                            
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            .byte $00       ;                                                                           .hbu003.
                            
                            .byte "l" | $80 ;                                                                           .hbu003.
                            .byte "o" | $80 ;                                                                           .hbu003.
                            .byte "d" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte " " | $80 ; <SHIFT_SPACE>                                                             .hbu003.
                            .byte "r" | $80 ;                                                                           .hbu003.
                            .byte "u" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "n" | $80 ;                                                                           .hbu003.
                            .byte "e" | $80 ;                                                                           .hbu003.
                            .byte "r"       ;                                                                           .hbu003.
                            
                            .byte $00 ;                                                                                 .hbu003.
; --------------------------------------------------------------------------------------------------------------------- ;
