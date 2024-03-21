; --------------------------------------------------------------------------------------------------------------------- ;
; Copy all the Loderunner level blocks
;   from their old region starting with track 03 on drive #8
;   to   their new region starting with track 01 to drive #9
; --------------------------------------------------------------------------------------------------------------------- ;
                            * = $1000
; --------------------------------------------------------------------------------------------------------------------- ;
; compiler settings
; --------------------------------------------------------------------------------------------------------------------- ;
                            .cpu "6502"                     ; Standard 65xx processor
; --------------------------------------------------------------------------------------------------------------------- ;
Mem                         .include "c64.memory.asm"       ; C64 Memory layout (includes found via -I cmd line option)
; --------------------------------------------------------------------------------------------------------------------- ;
; variables
; --------------------------------------------------------------------------------------------------------------------- ;
TabChannelNum_Cmd           = SA_CHANNEL_CMD ; commnad channel number
TabLevelCount_Max           = 250     ; max number of levels to be copied
TabDiskLevel_Start          = $00     ; start number of disk levels to be copied
TabDiskWriteOffSector_Max   = $14     ; max sector number for track 1-17
TabLevelDataBuf             = $2000   ; level data buffer
; --------------------------------------------------------------------------------------------------------------------- ;
                            jmp DiskCmdHandler              ; jump around work area
; --------------------------------------------------------------------------------------------------------------------- ;
; work area
; --------------------------------------------------------------------------------------------------------------------- ;
TabLevelNumDisk_CL          .byte $00 ; set to $01 if disk has Championship Styp Level Data - need to be de-obfuscated
TabLevelNumDisk_Msg         .byte $01 ; set to $01 if a default level complete msg should be inserted
; --------------------------------------------------------------------------------------------------------------------- ;
TabLevelNumDisk             .byte $00 ; disk level number
TabLevelCount               .byte $00 ; number of levels to be processed
TabDiskWriteOffTrack        .byte $00 ; offset write track number table
TabDiskWriteOffSector       .byte $00 ; offset write track number table
; --------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmdHandler            Does    : control the disk level block read/write
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmdHandler             .block                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; inits
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr CLALL                       ; Kernal($FFE7) Close all files (via $32C to $F32F)
                            
                            ldy #TabErrorMsg_Len            ; ini count
                            lda #" "                        ; get clear value
ClearNextErrMsgBufByte      sta TabErrorMsg,y               ; clear buffer
                            
                            dey                             ; dec count
                            bne ClearNextErrMsgBufByte      ; 
                            
;                            ldy #$00                        ; get intial value
                            sty TabDiskWriteOffTrack        ; ini track number table offset
                            sty TabDiskWriteOffSector       ; ini sector number table offset
                            
                            lda #TabLevelCount_Max          ; get initial value
                            sta TabLevelCount               ; ini level count
                            
                            lda #TabDiskLevel_Start         ; get initial value
                            sta TabLevelNumDisk             ; ini disk level number
; --------------------------------------------------------------------------------------------------------------------- ;
; read 250 blocks from old position
; --------------------------------------------------------------------------------------------------------------------- ;
SetNextDiskLevelBlock       jsr DiskCmdExecRead             ; READ the block
                            
                            inc TabLevelNumDisk             ; set next READ disk level num
; --------------------------------------------------------------------------------------------------------------------- ;
; write 250 blocks to new position
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr DiskCmdExecWrite            ; WRITE the block
                            
                            inc TabDiskWriteOffSector       ; set next sector
                            lda TabDiskWriteOffSector       ; set next 
                            cmp #TabDiskWriteOffSector_Max + $01 ; test max
                            bcc DecLevelCounter             ; check: LT - yes: continue
                            
                            lda #$00                        ; get intial value
                            sta TabDiskWriteOffSector       ; ini sector number table offset
                            
                            inc TabDiskWriteOffTrack        ; set next track number table offset
; --------------------------------------------------------------------------------------------------------------------- ;
; handle counters
; --------------------------------------------------------------------------------------------------------------------- ;
DecLevelCounter             dec TabLevelCount               ; dec level count
                            bne SetNextDiskLevelBlock       ; check: min - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; finish
; --------------------------------------------------------------------------------------------------------------------- ;
                            jmp CLALL                       ; Kernal($FFE7) Close all files (via $32C to $F32F)
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmdExecRead           Does    : read a block from disk to the data buffer
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmdExecRead            .block                           ; 
                            jsr OpenChannelRead_Data        ; setup the data channel
                            jsr OpenChannelRead_Cmd         ; open the cmd channel / setup and issue the READ command
; --------------------------------------------------------------------------------------------------------------------- ;
; READ in data buffer from disk
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldx #$02                        ; get data channel number
                            jsr CHKIN                       ; Kernal($FFC6) Define an input channel (via $31E to $F20E)
                            
                            jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            
                            ldy #$00                        ; ini buffer offset
GetNextDiskByte             jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            sta TabLevelDataBuf,y           ; set get store disk data byte
                            
                            iny                             ; inc get byte count
                            bne GetNextDiskByte             ; check: 255 bytes read - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; eventually remove Championship Loderunner level data obfuscation
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda TabLevelNumDisk_CL          ; get flag: CL level data disk
                            beq CheckCopyMsgText            ; check: CL data disk - no: check for a default message text
                            
                            ldy #$00                        ; get max length level data - no obfuscations beyond level data
GetNextLevelDataByte        lda TabLevelDataBuf,y           ; get obfuscated level byte
                            eor #$ff                        ; flip all bits
                            sta TabLevelDataBuf,y           ; set clear level byte
                            
                            iny                             ; dec length level data
                            cpy #$e0                        ; test max
                            bne GetNextLevelDataByte        ; check: EQ - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; copy the message id string then
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldy #$00                        ; ini length
GetNextMsgIdByte            lda TabHeroMsgId,y              ; copy the message id
                            sta TabLevelDataBuf + $f1,y     ; behind the message text
                            
                            iny                             ; inc msg id length
                            cpy #TabHeroMsgId_Len           ; test max len
                            bne GetNextMsgIdByte            ; check: EQ - no: continue
                            beq DiskCmdExecReadX            ; always
; --------------------------------------------------------------------------------------------------------------------- ;
; eventually copy a message text
; --------------------------------------------------------------------------------------------------------------------- ;
CheckCopyMsgText            lda TabLevelNumDisk_Msg         ; get flag: set a default message text
                            beq DiskCmdExecReadX            ; check: CL data disk - no: exit
; --------------------------------------------------------------------------------------------------------------------- ;
; copy the message text string and it
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldy #$00                        ; ini length
GetNextMsgTextByte          lda TabHeroMsg,y                ; get a msg byte
                            sta TabLevelDataBuf + $e0,y     ; set msg
                            
                            iny                             ; inc msg string length
                            cpy #TabHeroMsg_Len             ; test max
                            bne GetNextMsgTextByte          ; check: EQ - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmdExecReadX            rts                             ; close all open channels and return
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmdExecWrite          Does    : write a block from the data buffer to disk
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmdExecWrite           .block                           ; 
                            jsr OpenChannelWrite_Data       ; setup the WRITE data channel
                            
                            ldx #$02                        ; get data channel number
                            jsr CHKOUT                      ; Kernal($FFC6) Define an input channel (via $31E to $F20E)
; --------------------------------------------------------------------------------------------------------------------- ;
; WRITE out data buffer to disk
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldy #$00                        ; ini level data pointer
PutNextDiskByte             lda TabLevelDataBuf,y           ; get data byte
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            iny                             ; inc level data pointer
                            bne PutNextDiskByte             ; check: max - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; open command channel
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr OpenChannelWrite_Cmd        ; open the cmd channel / setup and issue the READ command
                            rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; OpenChannelRead_Cmd       Does    : open the READ cmd channel on drive #8
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannelRead_Cmd        .block                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; generate the READ cmd string
; --------------------------------------------------------------------------------------------------------------------- ;
SetCmdRead                  lda TabLevelNumDisk             ; get disk level number 000-249
                            and #$0f                        ; isolate right nibble for sector calculation
                            tax                             ; set as offset
                            
                            lda TabDiskBlockReadSec_Hi,x    ; get block sector number
                            sta TabDiskCmdRead_Sec_Hi       ; 
                            lda TabDiskBlockReadSec_Lo,x    ; 
                            sta TabDiskCmdRead_Sec_Lo       ; 
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda TabLevelNumDisk             ; get disk level number 000-249
                            lsr a                           ; isolate left nibble for track calculation
                            lsr a                           ; 
                            lsr a                           ; 
                            lsr a                           ; 
                            tax                             ; set as offset
                            
                            lda TabDiskBlockReadTrk_Hi,x    ; get block track number
                            sta TabDiskCmdRead_Trk_Hi       ; 
                            lda TabDiskBlockReadTrk_Lo,x    ; 
                            sta TabDiskCmdRead_Trk_Lo       ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; open the READ command channel
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #TabChannelNum_Cmd          ; get logical file n
                            jsr CLOSE                       ; close logical file
                            
                            lda #TabDiskCmdRead_Len - $01   ; get cmd string length
                            ldx #<TabDiskCmdRead            ; set the command string
                            ldy #>TabDiskCmdRead            ; 
                            jsr SETNAM                      ; KERNAL - $FFBD = Set Filename Parameters
                            
                            lda #TabChannelNum_Cmd          ; get channel number: command channel
                            ldx #$08                        ; get drive number
                            ldy #TabChannelNum_Cmd          ; get secondary address
                            jsr SETLFS                      ; KERNAL - $FFBA = Set Logical File Parameters
                            
                            jsr OPEN                        ; KERNAL - $FFC0 = Open a Logical File
                            bcc OpenChannelRead_CmdX        ; check: disk error - yes
; --------------------------------------------------------------------------------------------------------------------- ;
Error_Open                  pha                             ; save error code
                            
                            lda #"w"                        ; mark open type - READ
                            sta SetError_Open.smErrorOpen_Mode ; 
                            lda #"c"                        ; mark open type - CMD channel
                            sta SetError_Open.smErrorOpen_Type ; 
                            
                            pla                             ; restore error code
                            jmp SetError_Open               ; 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannelRead_CmdX        rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; OpenChannelRead_Data      Does    : open the READ data channel on drine #8
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannelRead_Data       .block                           ; 
                            lda #$02                        ; get channel number
                            jsr CLOSE                       ; close logical file
                            
                            lda #FileNameString_Len         ; get length data set name '#'
                            ldx #<FileNameString            ; get address filename LO
                            ldy #>FileNameString            ; get address filename HI
                            jsr SETNAM                      ; KERNAL - $FFBD = Set Filename Parameters
                            
                            lda #$02                        ; get channel number: data
                            ldx #$08                        ; get drive number
                            ldy #$02                        ; get secondary address
                            jsr SETLFS                      ; KERNAL - $FFBA = Set Logical File Parameters
                            
                            jsr OPEN                        ; KERNAL - $FFC0 = Open a Logical File
                            bcc OpenChannelRead_CmdX        ; check: disk error - no
; --------------------------------------------------------------------------------------------------------------------- ;
Error_Open                  pha                             ; save error code
                            
                            lda #"r"                        ; mark open type - READ
                            sta SetError_Open.smErrorOpen_Mode ; 
                            lda #"d"                        ; mark open type - DATA channel
                            sta SetError_Open.smErrorOpen_Type ; 
                            
                            pla                             ; restore error code
                            jmp SetError_Open               ; 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannelRead_CmdX        rts
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; OpenChannelWrite_Cmd      Does    : open the WRITE cmd channel on drive #9
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannelWrite_Cmd       .block                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; generate WRITE cmd string
; --------------------------------------------------------------------------------------------------------------------- ;
SetCmdWrite                 ldx TabDiskWriteOffTrack        ; get track number table offset
                            lda TabDiskBlockWriteTrk_Lo,x   ; 
                            sta TabDiskCmdWrite_Trk_Lo      ; 
                            lda TabDiskBlockWriteTrk_Hi,x   ; 
                            sta TabDiskCmdWrite_Trk_Hi      ; 
                            
                            ldx TabDiskWriteOffSector       ; get track number table offset
                            lda TabDiskBlockWriteSec_Lo,x   ; 
                            sta TabDiskCmdWrite_Sec_Lo      ; 
                            lda TabDiskBlockWriteSec_Hi,x   ; 
                            sta TabDiskCmdWrite_Sec_Hi      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; open the command channel
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #TabChannelNum_Cmd          ; get logical file n
                            jsr CLOSE                       ; close logical file
                            
                            lda #TabDiskCmdWrite_Len - $01  ; get cmd string length
                            ldx #<TabDiskCmdWrite           ; set the command string
                            ldy #>TabDiskCmdWrite           ; 
                            jsr SETNAM                      ; KERNAL - $FFBD = Set Filename Parameters
                            
                            lda #TabChannelNum_Cmd          ; get channel number: command channel
                            ldx #$09                        ; get drive number
                            ldy #TabChannelNum_Cmd          ; get secondary address
                            jsr SETLFS                      ; KERNAL - $FFBA = Set Logical File Parameters
                            
                            jsr OPEN                        ; KERNAL - $FFC0 = Open a Logical File
                            bcc OpenChannelWrite_CmdX       ; check: disk error - no
; --------------------------------------------------------------------------------------------------------------------- ;
Error_Open                  pha                             ; save error code
                            
                            lda #"w"                        ; mark open type - WRITE
                            sta SetError_Open.smErrorOpen_Mode ; 
                            lda #"c"                        ; mark open type - CMD channel
                            sta SetError_Open.smErrorOpen_Type ; 
                            
                            pla                             ; restore error code
                            jmp SetError_Open               ; 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannelWrite_CmdX       rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; OpenChannelWrite_Data     Does    : open the WRITE data channel on drine #9
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannelWrite_Data      .block                           ; 
                            lda #$02                        ; get channel number
                            jsr CLOSE                       ; close logical file
                            
                            lda #FileNameString_Len         ; get length data set name '#'
                            ldx #<FileNameString            ; get address filename LO
                            ldy #>FileNameString            ; get address filename HI
                            jsr SETNAM                      ; KERNAL - $FFBD = Set Filename Parameters
                            
                            lda #$02                        ; get channel number: data
                            ldx #$09                        ; get drive number
                            ldy #$02                        ; get secondary address
                            jsr SETLFS                      ; KERNAL - $FFBA = Set Logical File Parameters
                            
                            jsr OPEN                        ; KERNAL - $FFC0 = Open a Logical File
                            bcc SetChannel_Out              ; check: disk error - no
; --------------------------------------------------------------------------------------------------------------------- ;
Error_Open                  pha                             ; save error code
                            
                            lda #"w"                        ; mark open type - WRITE
                            sta SetError_Open.smErrorOpen_Mode ; 
                            lda #"d"                        ; mark open type - DATA channel
                            sta SetError_Open.smErrorOpen_Type ; 
                            
                            pla                             ; restore error code
                            jmp SetError_Open               ; 
; --------------------------------------------------------------------------------------------------------------------- ;
SetChannel_Out              ldx #$02                        ; get data channel number
                            jsr CHKOUT                      ; Kernal($FFC9) Define an output channel (via $320 to $F250)
                            
                            rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; SetError_Open             Does    : fill the open error buffer
;                           Expects : .A=error code
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
SetError_Open              .block                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; someting bad happened - write out the message
; --------------------------------------------------------------------------------------------------------------------- ;
SetErrorOpen_Code           sta TabErrorRc                  ; 
                            
                            lda #"o"                        ; 
                            sta TabErrorId + $00            ; 
                            lda #"p"                        ; 
                            sta TabErrorId + $01            ; 
                            lda #"e"                        ; 
                            sta TabErrorId + $02            ; 
                            lda #"n"                        ; 
                            sta TabErrorId + $03            ; 
                            lda #"-"                        ; 
                            sta TabErrorId + $04            ; 
smErrorOpen_Mode            = * + $01                       ; 
                            lda #"r"                        ; open mode - READ or WRITE
                            sta TabErrorId + $05            ; 
smErrorOpen_Type            = * + $01                       ; 
                            lda #"c"                        ; open type - CMD or DATA channel
                            sta TabErrorId + $06            ; 
                            
                            jmp DiskError                   ; 
; --------------------------------------------------------------------------------------------------------------------- ;
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskError                 Does    : write the disk error msg to buffer
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskError                  .block                           ; 
                            jsr CLRCHN                      ; Kernal($FFCC) Restore default devices (via $322 to $F333)
                            
                            ldx #TabChannelNum_Cmd          ; get command channel number
                            jsr CHKIN                       ; Kernal($FFC6) Define an input channel (via $31E to $F20E)
                            
                            ldy #$00                        ; ini buffer offset
GetNextDiskMsgChar          jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            sta TabErrorMsg,y               ; 
                            
                            iny                             ; inc buffer offset
                            
                            cmp #CR                         ; test <ENTER>
                            bne GetNextDiskMsgChar          ; check: EQ - no: read rest of the message
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr CLALL                       ; close all open channels
                            jmp START                       ; reset the machine
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; --------------------------------------------------------------------------------------------------------------------- ;
FileNameString              .byte "#" ; 
FileNameString_Len          = * - FileNameString ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TabDiskCmdRead               = *      ; 
                            .byte "u" ; user command id
                            .byte "1" ; user command type - 1=read  2=write
                            .byte ":" ; 
TabDiskCmdRead_Channel      .byte "2" ; channel number
                            .byte " " ; 
TabDiskCmdRead_Drive        .byte "0" ; drive number - always zero
                            .byte " " ; 
TabDiskCmdRead_Trk_Hi       .byte "0" ; track number HI
TabDiskCmdRead_Trk_Lo       .byte "3" ; track number LO
                            .byte " " ; 
TabDiskCmdRead_Sec_Hi       .byte "0" ; sector number HI
TabDiskCmdRead_Sec_Lo       .byte "0" ; sector number LO
                            
                            .byte CR  ; <RETURN>
TabDiskCmdRead_Len          = * - TabDiskCmdRead ; command length
                            .byte $00 ; End of Command
; --------------------------------------------------------------------------------------------------------------------- ;
TabDiskCmdWrite              = *      ; 
                            .byte "u" ; user command id
                            .byte "2" ; user command type - 1=read  2=write
                            .byte ":" ; 
TabDiskCmdWrite_Channel     .byte "2" ; channel number
                            .byte " " ; 
TabDiskCmdWrite_Drive       .byte "0" ; drive number - always zero
                            .byte " " ; 
TabDiskCmdWrite_Trk_Hi      .byte "0" ; track number HI
TabDiskCmdWrite_Trk_Lo      .byte "1" ; track number LO
                            .byte " " ; 
TabDiskCmdWrite_Sec_Hi      .byte "0" ; sector number HI
TabDiskCmdWrite_Sec_Lo      .byte "0" ; sector number LO
                             
                            .byte CR  ; <RETURN>
TabDiskCmdWrite_Len         = * - TabDiskCmdWrite ; command length
                            .byte $00 ; End of Command
; --------------------------------------------------------------------------------------------------------------------- ;
TabDiskBlockReadTrk_Hi      .byte "0", "0", "0", "0", "0", "0", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1"
TabDiskBlockReadTrk_Lo      .byte "3", "4", "5", "6", "7", "8", "9", "0", "1", "2", "3", "4", "5", "6", "7", "9" ; omit dir
                            
TabDiskBlockReadSec_Hi      .byte "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "1", "1", "1", "1", "1"
TabDiskBlockReadSec_Lo      .byte "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "1", "2", "3", "4", "5"
; --------------------------------------------------------------------------------------------------------------------- ;
TabDiskBlockWriteTrk_Hi     .byte "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "1", "1", "1", "1", "1", "1", "1"
TabDiskBlockWriteTrk_Lo     .byte "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "1", "2", "3", "4", "5", "6", "7"
                            
TabDiskBlockWriteSec_Hi     .byte "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "2"
TabDiskBlockWriteSec_Lo     .byte "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
; --------------------------------------------------------------------------------------------------------------------- ;
TabHeroMsg                  = *       ; 
                            .byte $00 ; 
                            .byte $00 ; 
TabHeroMsg_Text             .byte $cc ; L
                            .byte $c5 ; E
                            .byte $d6 ; V
                            .byte $c5 ; E
                            .byte $cc ; L
                            .byte $a0 ; <blank>
                            .byte $a0 ; <blank>
                            .byte $c3 ; C
                            .byte $cf ; O
                            .byte $cd ; M
                            .byte $d0 ; P
                            .byte $cc ; L
                            .byte $c5 ; E
                            .byte $d4 ; T
                            .byte $c5 ; E
TabHeroMsgText_Len          = * - TabHeroMsg ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TabHeroMsgId                = *       ; 
                            .byte $00 ; 
                            .byte $00 ; 
                            .byte $00 ; 
                            .byte $cc ; L
                            .byte $cf ; O
                            .byte $c4 ; D
                            .byte $c5 ; E
                            .byte $a0 ; <SHIFT_SPACE>
                            .byte $d2 ; R
                            .byte $d5 ; U
                            .byte $ce ; N
                            .byte $ce ; N
                            .byte $c5 ; E
                            .byte $52 ; r
TabHeroMsg_Len              = * - TabHeroMsg ; 
TabHeroMsgId_Len            = * - TabHeroMsgId ; 
; --------------------------------------------------------------------------------------------------------------------- ;
                            .byte "<"
TabErrorRc                  .byte $00
                            .byte ">"
TabErrorId                  .byte $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20 ; 
TabErrorMsg                 .byte $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20 ; 
                            .byte $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20 ; 
TabErrorMsg_Len             = * - TabErrorMsg - $01 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
