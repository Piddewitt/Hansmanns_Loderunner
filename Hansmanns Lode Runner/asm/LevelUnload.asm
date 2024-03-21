; -------------------------------------------------------------------------------------------------------------- ;
; Lode Runner Level Unload - Creates a Lode Runner Level Disc from "PR Level Set nn" files
;                          - checks for correct disc name "HONZ LODE RUNNER"
;                          - uses full tracks
;                          - track $01-$00   to 
;                          - track $0c-$12 - level data
;                          
;                          - track $0c-$13 - empty (no lode runner tile)
;                          - track $0c-$14 - Scores Block of Leaderboard Entries
;                          - track $0d-$00 - Save Game Block of 10 Game Save Slots
;                          - track $0d-$01 - Times Block 00 of Level Solved Times for Level 000-083 (#84)
;                          - track $0d-$02 - Times Block 01 of Level Solved Times for Level 084-167 (#84)
;                          - track $0d-$03 - Times Block 02 of Level Solved Times for Level 168-250 (#82)
;                          - track $0d/$04   to
;                          - track $0d/$0d - Random Mode Level Numbers Blocks for each save game
; -------------------------------------------------------------------------------------------------------------- ;
                            * = $0801                       ; Start address
; --------------------------------------------------------------------------------------------------------------------- ;
; compiler settings
; --------------------------------------------------------------------------------------------------------------------- ;
                            .cpu "6502"                     ; standard 65xx processor
                            
MemoryLayout                .include "../../inc/c64.MEM.asm" ; C64 Memory layout (includes found via -I cmd line option)
; --------------------------------------------------------------------------------------------------------------------- ;
; Lode Runner Score Map
; --------------------------------------------------------------------------------------------------------------------- ;
BasicStart                  .word BasicEnd                  ; ptr: next line
                            .word 2022                      ; line number
                            .byte $9E                       ; token: sys
                            .text "2061"                    ; 
LineEnd                     .byte $00                       ; End of Basic Line
BasicEnd                    .byte $00, $00                  ; End of Basic Program
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; PrintStartScreen          Does    : print program info screen
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
PrintStartScreen           .block                           ; 
                            lda #BLACK                      ; 
                            sta BGCOL0                      ; VIC($D021) Background Color 0
                            sta EXTCOL                      ; VIC($D020) Border Color
; --------------------------------------------------------------------------------------------------------------------- ;
; print <CLEAR_SCREEN>
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #PETSCII_CLRS               ; get <CLEAR_SCREEN>
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            lda #$ff                        ; preset -1 
                            pha                             ; 
                            
                            tax                             ; ini .X
                            clc                             ; set flag: PLOT cursor pos
; --------------------------------------------------------------------------------------------------------------------- ;
; get message text screen pos and set output cursor
; --------------------------------------------------------------------------------------------------------------------- ;
SetNextMsgCursorPos         inx                             ; 
                            lda TabInfoMsgNum_Col,x         ; get column number
                            tay                             ; set PLOT column number
                            
                            txa                             ; 
                            pha                             ; save column table table offset
                            
                            lda TabInfoMsgNum_Row,x         ; get row number
                            tax                             ; set PLOT row number
                            jsr PLOT                        ; Kernal($FFF0) Read/set position of cursor on screen ($E50A)
; --------------------------------------------------------------------------------------------------------------------- ;
; restore register contents
; --------------------------------------------------------------------------------------------------------------------- ;
                            pla                             ; 
                            tax                             ; restore column table table offset
                            pla                             ; 
                            tay                             ; restore message text offset
; --------------------------------------------------------------------------------------------------------------------- ;
; write out the selected message
; --------------------------------------------------------------------------------------------------------------------- ;
SetNextMsgChar              iny                             ; inc message text offset
                            lda InfoMsgHeader,y             ; get a message char
                            beq EndOfMsgLine                ; chek: end of text: yes: done
                            
                            cmp #$ff                        ; test end of header
                            beq BAM_Handler                 ; check: EQ - yes: finished
; --------------------------------------------------------------------------------------------------------------------- ;
; output the message text char                            
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            jmp SetNextMsgChar              ; check: 
; --------------------------------------------------------------------------------------------------------------------- ;
EndOfMsgLine                tya                             ; get message text offset
                            pha                             ; save message text offset
                            
                            jmp SetNextMsgCursorPos         ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; BAM_Handler               Does    : check correct disk name
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
BAM_Handler                .block                           ; 
                            jsr OpenChannel_Command         ; 
                            bcc BAM_OpenDataChannel         ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; BAM disk error
; --------------------------------------------------------------------------------------------------------------------- ;
BAM_DiskError               jsr DiskErrorCheck              ; get and check the disk operation return code
                            jmp Finish                      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
BAM_OpenDataChannel         jsr OpenChannel_Data            ; 
                            bcs BAM_DiskError               ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; init command
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldy #"0"                        ; BAM: sector 0
                            sty DiskCmd_BlockRW_Sec_Hi      ; 
                            sty DiskCmd_BlockRW_Sec_Lo      ; 
                            
                            ldy #"1"                        ; BAM: track 18
                            sty DiskCmd_BlockRW_Trk_Hi      ; 
                            ldy #"8"                        ; 
                            sty DiskCmd_BlockRW_Trk_Lo      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; write msg: read/check BAM
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldx #<InfoMsgBAM_Read           ; "Read/Check BAM"
                            ldy #>InfoMsgBAM_Read           ; 
                            jsr PrintInfoMsg                ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; read BAM
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr DiskCmd_Read                ; 
                            bcc BAM_GetData                 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; BAM read error
; --------------------------------------------------------------------------------------------------------------------- ;
                            jmp Finish                      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; read in BAM block
; --------------------------------------------------------------------------------------------------------------------- ;
BAM_GetData                 jsr DiskGetData                 ; 
                            bcc BAM_InitNameCheck           ; 
                            bcs BAM_DiskError               ; 
                            
BAM_InitNameCheck           ldy #$0f                        ; disk name length
                            ldx #$00                        ; offest 1st name byte
BAM_CheckNextDiscNameChar   lda TabLodeRunneDiskName,x      ; "HONZ LODE RUNNER"
                            cmp DiskBlockBuffer + $90,x     ; offest BAM disk name
                            bne BAM_BadDiskName             ; check: error - yes: bad disk name
                            
                            inx                             ; inc name byte offset
                            dey                             ; dec name length
                            bpl BAM_CheckNextDiscNameChar   ; check: min - no: continue
                            bmi CopyBlocks                  ; always
; --------------------------------------------------------------------------------------------------------------------- ;
; error: bad disk name
; --------------------------------------------------------------------------------------------------------------------- ;
BAM_BadDiskName             ldx #<ErrorMsg_DiskName_Bad     ; 
                            ldy #>ErrorMsg_DiskName_Bad     ; 
                            jsr PrintInfoMsg                ; 
                            
                            jmp Finish                      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; CopyBlocks                Does    : copy all file level data blocks to disk
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
CopyBlocks                 .block                           ;  
                            lda #$05                        ; get initial value
                            sta WorkNumLevelFile_Max        ; set max level files
; --------------------------------------------------------------------------------------------------------------------- ;
; init disk command string
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #$00                        ; ini target start sector number table offset
                            sta WorkDiskBlockOff_Sector     ; 
                            lda #$00                        ; ini target start track number table offset
                            sta WorkDiskBlockOff_Track      ; 
                            jsr DiskBlockCmdUpdate          ; update the block command string with track/sector numbers
; --------------------------------------------------------------------------------------------------------------------- ;
; let the output files start with number 81
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #"8"                        ; init output file number
                            sta InfoMsgFileRead_Hi          ; 
                            sta FileNameLevelData_Hi        ; 
                            
                            lda #"1"                        ; 
                            sta InfoMsgFileRead_Lo          ; 
                            sta FileNameLevelData_Lo        ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; init the output buffer
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldy #$00                        ; 
                            sty DiskBlockBuffer             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; copy victory message and id string to end of block
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldx #LevelFileDataLevel_Len + $01 ; get initial value
GetNextTrailerByte          lda LevelTrailerData,y          ; get a trailer byte
                            sta DiskBlockBuffer,x           ; write to buffer
                            
                            iny                             ; inc trailer offset
                            inx                             ; inc buffer offset
                            bne GetNextTrailerByte          ; check: max - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
InitNextLevelFile           jsr CLRCHN                      ; Kernal($FFCC) Restore default devices (via $322 to $F333)
                            
                            ldx #<InfoMsgFileRead           ; 
                            ldy #>InfoMsgFileRead           ; 
                            jsr PrintInfoMsg                ; 
                            
ClearFileBufferInit         lda #>LevelFileDataBuffer       ; level data start address ($2000)
                            ldx #(>LevelFileDataBuffer + LevelFileDataBuffer_Len) ; level data end address ($4cbb)
                            
                            sta ZP_BufferPointer_Hi         ; level data pointer
                            ldy #$00                        ; 
                            sty ZP_BufferPointer_Lo         ; 
                            
                            tya                             ; get clear value
ClearNextFileBufferByte     sta (ZP_BufferPointer),y        ; clear buffer
                            
                            iny                             ; inc buffer offset
                            bne ClearNextFileBufferByte     ; check: max - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; advance level data buffer pointer
; --------------------------------------------------------------------------------------------------------------------- ;
                            inc ZP_BufferPointer_Hi         ; inc level data pointer
                            cpx ZP_BufferPointer_Hi         ; test upper border
                            bne ClearNextFileBufferByte     ; check: EQ - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; load a level data file
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr CLRCHN                      ; Kernal($FFCC) Restore default devices (via $322 to $F333)
                            
                            lda #FileNameLevelData_Len      ; get filename length
                            ldx #<FileNameLevelData         ; get filename address
                            ldy #>FileNameLevelData         ; 
                            jsr SETNAM                      ; Kernal($FFBD) Set filename parameters ($FDF9)
                            
                            lda #SA_CHANNEL_CMD             ; get channel number: command channel
                            ldx #FA_DISK                    ; get drive number: 8
                            ldy #KV_SETLFS_SA_NONE          ; flag: no secondary address
                            jsr SETLFS                      ; Kernal($FFBA) Set logical file parameters ($FE00)
                            
                            lda #KV_LOAD_LOAD               ; get flag: load
                            ldx #$ff                        ; 
                            ldy #$ff                        ; 
                            jsr LOAD                        ; Kernal($FFD5) Load from device (via $330 to $F49E)
                            
                            jsr DiskErrorCheck              ; get and check the disk operation return code
                            bcc FileLoadOk                  ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; file not found - write empty buffers
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda WorkDiskRC_Hi               ; 
                            cmp #"6"                        ; test disk RC 62 high
                            bne FileLoadBad                 ; check: EQ - no: exit
                            
                            lda WorkDiskRC_Lo               ; 
                            cmp #"2"                        ; test disk RC 62 low
                            beq FileLoadOk                  ; check: EQ - yes: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; read file error
; --------------------------------------------------------------------------------------------------------------------- ;
FileLoadBad                 jmp Finish                      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
FileLoadOk                  jsr CLALL                       ; Kernal($FFE7) Close all files (via $32C to $F32F)
                            
                            jsr OpenChannel_Command         ; 
                            bcc DataChannel_Open            ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; disk error
; --------------------------------------------------------------------------------------------------------------------- ;
Error_DataChannel           jsr DiskErrorCheck              ; get and check the disk operation return code
                            jmp Finish                      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
DataChannel_Open            jsr OpenChannel_Data            ; 
                            bcs Error_DataChannel           ; 
                            
                            lda #<LevelFileData             ; init level data pointer
                            sta ZP_LevelDataPointer_Lo      ; 
                            lda #>LevelFileData             ; 
                            sta ZP_LevelDataPointer_Hi      ; 
                            
                            lda #LevelFileDataLevel_Num     ; get initial value
                            sta WorkNumLevelFileLevels_Max  ; set max 50 levels per file
; --------------------------------------------------------------------------------------------------------------------- ;
; write next level data block
; --------------------------------------------------------------------------------------------------------------------- ;
WriteNextBlock              ldx #<InfoMsgBlockWrite         ; prin write message
                            ldy #>InfoMsgBlockWrite         ; 
                            jsr PrintInfoMsg                ; 
                            
                            ldy #$00                        ; get initial value
CopyNextLevelDataByte       lda (ZP_LevelDataPointer),y     ; get level data byte
                            sta DiskBlockBuffer + $01,y     ; write to buffer
                            
                            iny                             ; inc buffer offset
                            cpy #LevelFileDataLevel_Len     ; test max length
                            bne CopyNextLevelDataByte       ; check: EQ - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; write buffer to disk
; --------------------------------------------------------------------------------------------------------------------- ;
                            jsr DiskWriteDateToBuffer       ; 
                            bcc LevelWrite                  ; check: errror - no: continue
                            
                            jmp Finish                      ; error end
; --------------------------------------------------------------------------------------------------------------------- ;
LevelWrite                  jsr DiskCmd_Write               ; 
                            bcc LevelSetPtr                 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; error
; --------------------------------------------------------------------------------------------------------------------- ;
                            jmp Finish                      ; done
; --------------------------------------------------------------------------------------------------------------------- ;
; advance pointer to next level data
; --------------------------------------------------------------------------------------------------------------------- ;
LevelSetPtr                 lda ZP_LevelDataPointer_Lo      ; set pointer to next level
                            clc                             ; 
                            adc #LevelFileDataLevel_Len     ; add level data length
                            sta ZP_LevelDataPointer_Lo      ; 
                            bcc AdvanceLevelBlock           ; check overflow - no
                            inc ZP_LevelDataPointer_Hi      ; 
                            
AdvanceLevelBlock           jsr DiskBlockCmdSetNext         ; 
                            
                            dec WorkNumLevelFileLevels_Max  ; dec file level count
                            bne WriteNextBlock              ; check: 50 levels reached - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; set next level data input file name
; --------------------------------------------------------------------------------------------------------------------- ;
                            dec WorkNumLevelFile_Max        ; dec max file number
                            beq DiskWriteEmptyBlock         ; check: min - yes: done - write a trailing emty block
                            
                            inc FileNameLevelData_Lo        ; set next file lo
                            inc InfoMsgFileRead_Lo          ;                
                            
                            lda FileNameLevelData_Lo        ; get next file lo
                            cmp #"9" + $01                  ; test passed "9"
                            bcc GoInitNextLevelFile         ; check: LT - yes: continue
                            
                            lda #"0"                        ; reset to start value
                            sta FileNameLevelData_Lo        ; 
                            sta InfoMsgFileRead_Lo          ; 
                            
                            inc FileNameLevelData_Hi        ; set next file hi
                            inc InfoMsgFileRead_Hi          ; 
                            
                            lda FileNameLevelData_Hi        ; get next file hi
                            cmp #"9" + $01                  ; test passed "9"
                            bcc GoInitNextLevelFile         ; check: LT - yes: continue
                            
                            lda #"0"                        ; yes - reset to start value
                            sta FileNameLevelData_Hi        ; 
                            sta InfoMsgFileRead_Hi          ; 
                            
GoInitNextLevelFile         jmp InitNextLevelFile           ; get next level file
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskWriteEmptyBlock       Does    : write an empty block to disk
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskWriteEmptyBlock        .block                           ; 
                            ldy #$00                        ; fill the level between last level and score block 
                            tya                             ; with illegal data to force the game jump back
BlockEmptyFill              sta DiskBlockBuffer,y           ; to the first level when reached
                            iny                             ; 
                            bne BlockEmptyFill              ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; write the empty block point to entry 13/19 of TabDiskBlockTrk_Hi/TabDiskBlockTrk_Lo
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #$0c                        ; 
                            sta WorkDiskBlockOff_Track      ; 
                            lda #$13                        ; 
                            sta WorkDiskBlockOff_Sector     ; set next sector
                            jsr DiskBlockCmdUpdate          ; update the block command string with track/sector numbers
; --------------------------------------------------------------------------------------------------------------------- ;
; output block empty message
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldx #<InfoMsgBlockWrite         ; 
                            ldy #>InfoMsgBlockWrite         ; 
                            jsr PrintInfoMsg                ; 
                            
                            jsr DiskWriteDateToBuffer       ; illegal: track 19 sector 10
                            jsr DiskCmd_Write               ; 
                            bcc DiskWriteScoreBlock         ; 
                            
                            jmp Finish                      ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskWriteScoreBlock       Does    : write the score block to disk
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskWriteScoreBlock        .block                           ; 
                            ldy #$00                        ; 
                            ldx #$f1                        ; 
GetNextDiskIdChar           lda TabLodeRunneDiskID,y        ; 
                            beq ScoreFlag                   ; 
                            
                            sta DiskBlockBuffer,x           ; edit would fail otherwise
                            inx                             ; 
                            iny                             ; 
                            jmp GetNextDiskIdChar           ; 
                            
ScoreFlag                   inx                             ; 
                            lda #$00                        ; 
                            sta DiskBlockBuffer,x           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; write the score block - point to entry 13/20 of TabDiskBlockTrk_Hi/TabDiskBlockTrk_Lo
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #$0c                        ; 
                            sta WorkDiskBlockOff_Track      ; 
                            lda #$14                        ; 
                            sta WorkDiskBlockOff_Sector     ; set next sector
                            jsr DiskBlockCmdUpdate          ; update the block command string with track/sector numbers
; --------------------------------------------------------------------------------------------------------------------- ;
; output score message
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldx #<InfoMsgBlockWrite         ; 
                            ldy #>InfoMsgBlockWrite         ; 
                            jsr PrintInfoMsg                ; 
                            
                            jsr DiskWriteDateToBuffer       ; score: track 19 sector 11
                            jsr DiskCmd_Write               ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; Finish                    Does    : reset disk and exit the program
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
Finish                     .block                           ; 
                            jsr DiskCmd_Reset               ; 
                            jsr CLALL                       ; Kernal($FFE7) Close all files (via $32C to $F32F)
                            
                            lda #PETSCII_RETURN             ; 
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            lda #PETSCII_RETURN             ; 
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            lda #PETSCII_RETURN             ; 
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
; --------------------------------------------------------------------------------------------------------------------- ;
; set cursor color and return to BASIC
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #PETSCII_WHITE              ; 
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            rts                             ; back to BASIC
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskBlockCmdSetNext       Does    : set trsck and sector of the next disk block
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskBlockCmdSetNext        .block                           ; 
                            inc WorkDiskBlockOff_Sector     ; set next sector table offset
                            
                            lda WorkDiskBlockOff_Sector     ; get next sector
                            cmp #TabDiskBlock_Sec_Max       ; test with max sector number for this track
                            bcc DiskBlockCmdUpdate          ; check: LT - yes: update the block command string with track/sector numbers
                            
                            lda #$00                        ; get inital value
                            sta WorkDiskBlockOff_Sector     ; ini sector number table offset
                            
                            inc WorkDiskBlockOff_Track      ; set next track number table offset
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskBlockCmdUpdate        Does    : update the block command string with track/sector numbers
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskBlockCmdUpdate         .block                           ; 
                            ldy WorkDiskBlockOff_Track      ; actual track number
                            lda TabDiskBlockTrk_Hi,y        ; 10s
                            sta DiskCmd_BlockRW_Trk_Hi      ; 
                            sta InfoMsgBlockWrite_Track_Hi  ; 
                            
                            lda TabDiskBlockTrk_Lo,y        ; 1s
                            sta DiskCmd_BlockRW_Trk_Lo      ; 
                            sta InfoMsgBlockWrite_Track_Lo  ; 
                            
                            ldy WorkDiskBlockOff_Sector     ; actual sector number
                            lda TabDiskBlockSec_Hi,y        ; 10s
                            sta DiskCmd_BlockRW_Sec_Hi      ; 
                            sta InfoMsgBlockWrite_Sector_Hi ; 
                            
                            lda TabDiskBlockSec_Lo,y        ; 1s
                            sta DiskCmd_BlockRW_Sec_Lo      ; 
                            sta InfoMsgBlockWrite_Sector_Lo ; 
                            
                            rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskGetData               Does    : read disk block file data into level buffer
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskGetData                .block                           ; 
                            jsr CLRCHN                      ; Kernal($FFCC) Restore default devices (via $322 to $F333)
                            
                            ldx #$02                        ; 
                            jsr CHKIN                       ; Kernal($FFC6) Define an input channel (via $31E to $F20E)
                            bcs DiskGetDataX                ; 
                            
                            ldy #$00                        ; ini buffer offset
GetNextDataByte             jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            sta DiskBlockBuffer,y           ; 
                            
                            iny                             ; inc buffer offset
                            bne GetNextDataByte             ; check: max - no: continue
                            
DiskGetDataX                rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskWriteDateToBuffer     Does    : write buffer data to disk buffer
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskWriteDateToBuffer      .block                           ; 
                            jsr DiskCmd_BP                  ; 
                            bcs DiskWriteDateToBufferX      ; check: failure - yes: exit
                            
                            ldx #$02                        ; get data channel number
                            jsr CHKOUT                      ; Kernal($FFC9) Define an output channel (via $320 to $F250)
                            bcs DiskWriteDateToBufferX      ; check: failure - yes: exit
                            
                            ldy #$00                        ; ini buffer offset
GetNextBufferByte           lda DiskBlockBuffer,y           ; 
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            iny                             ; inc buffer pointer
                            bne GetNextBufferByte           ; check: max - no: continue
                            
DiskWriteDateToBufferX      rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmd_BP                Does    : set disk command: buffer pointer
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_BP                 .block                           ; 
                            ldx #<DiskCmd_SetBP             ; 
                            ldy #>DiskCmd_SetBP             ; 
                            lda #$01                        ; with error checking
                            
                            jmp DiskCmd_Out                 ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmd_Reset             Does    : set disk command: reset
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_Reset              .block                           ; 
                            ldx #<DiskCmdReset              ; 
                            ldy #>DiskCmdReset              ; 
                            lda #$00                        ; no error checking
                            
                            jmp DiskCmd_Out                 ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmd_Read              Does    : set disk command: read a black
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_Read               .block                           ; 
                            lda #DiskCmd_BlockRead          ; 
                            jmp DiskCmd_Set                 ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmd_Write             Does    : set disk command: write a block
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_Write              .block                           ; 
                            lda #DiskCmd_BlockWrite         ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmd_Set               Does    : set the selected disk command
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_Set                .block                           ; 
                            sta DiskCmd_BlockRW_Type        ; set access type - 1=read  2=write
                            
                            ldx #<DiskCmd_BlockRW           ; Un:0 2 0 tt ss
                            ldy #>DiskCmd_BlockRW           ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskCmd_Out               Does    : send the selected command to the drive
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_Out                .block                           ; 
                            pha                             ; save command
                            
                            stx ZP_BufferPointer_Lo         ; 
                            sty ZP_BufferPointer_Hi         ; 
                            
                            jsr CLRCHN                      ; Kernal($FFCC) Restore default devices (via $322 to $F333)
                            
                            ldx #SA_CHANNEL_CMD             ; cmd channel
                            jsr CHKOUT                      ; Kernal($FFC9) Define an output channel (via $320 to $F250)
                            bcs DiskCmd_SetX                ; check: error - yes: exit
; --------------------------------------------------------------------------------------------------------------------- ;
; send the command string to the drive over the command channel
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldy #$00                        ; 
GetNextCmdStingChar         lda (ZP_BufferPointer),y        ; 
                            beq CheckCommand                ; check: end of command - yes: done
                            
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            iny                             ; inc command string offset
                            jmp GetNextCmdStingChar         ; 
; --------------------------------------------------------------------------------------------------------------------- ;
CheckCommand                pla                             ; restore command
                            beq DiskCmd_SetX                ; check: reset - yes: no error check
                            
                            jmp DiskErrorCheck              ; get and check the disk operation return code
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_SetX                rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskErrorCheck            Does    : get and check the disk operation return code
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskErrorCheck             .block                           ; 
                            jsr CLRCHN                      ; Kernal($FFCC) Restore default devices (via $322 to $F333)
                            
                            ldx #SA_CHANNEL_CMD             ; 
                            jsr CHKIN                       ; Kernal($FFC6) Define an input channel (via $31E to $F20E)
                            
                            jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            sta WorkDiskRC_Hi               ; 
                            
                            jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            sta WorkDiskRC_Lo               ; 
                            ora WorkDiskRC_Hi               ; 
                            cmp #"0"                        ; 
                            bne DiskErrorOut                ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; discard the OK  message text
; --------------------------------------------------------------------------------------------------------------------- ;
GetNextErrorMsgChar         jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            cmp #CR                         ; test <RETURN>
                            bne GetNextErrorMsgChar         ; check: EQ - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; set ok flag
; --------------------------------------------------------------------------------------------------------------------- ;
                            clc                             ; set flag: disk opereatio OK
                            rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; DiskErrorOut              Does    : print the disk error message
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskErrorOut               .block                           ; 
                            ldy #ErrorMsgCol                ; 
                            ldx #ErrorMsgRow                ; 
                            clc                             ; 
                            jsr PLOT                        ; Kernal($FFF0) Read/set position of cursor on screen ($E50A)
                            
                            lda #PETSCII_RED                ; 
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            lda WorkDiskRC_Hi               ; 
                            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            lda WorkDiskRC_Lo               ; 
GetNextErrorMsgChar         jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            jsr CHRIN                       ; Kernal($FFCF) Input a character (via $324 to $F157)
                            cmp #CR                         ; test <RETURN>
                            bne GetNextErrorMsgChar         ; check: EQ - no: continue
; --------------------------------------------------------------------------------------------------------------------- ;
; set failure flag
; --------------------------------------------------------------------------------------------------------------------- ;
                            sec                             ; set flag: disk opereatio BAD
                            rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; OpenChannel_Command       Does    : open the command channel
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannel_Command        .block                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; open 15,8,15
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #$00                        ; open 15,8,15
                            jsr SETNAM                      ; Kernal($FFBD) Set filename parameters ($FDF9)
                            
                            lda #SA_CHANNEL_CMD             ; get channel number: command channel
                            tay                             ; 
                            ldx #FA_DISK                    ; get drive number (8)
                            jsr SETLFS                      ; Kernal($FFBA) Set logical file parameters ($FE00)
                            
                            jmp OPEN                        ; Kernal($FFC0) Open a logical file (via $31A to $F34A)
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; OpenChannel_Data          Does    : open the data channel
;                           Expects : 
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
OpenChannel_Data           .block                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; open 2,8,2,"#"
; --------------------------------------------------------------------------------------------------------------------- ;
                            lda #$01                        ; get length of filename
                            ldx #<DiskCmdFileName           ; 
                            ldy #>DiskCmdFileName           ; 
                            jsr SETNAM                      ; Kernal($FFBD) Set filename parameters ($FDF9)
                            
                            lda #$02                        ; get logical file number - must be the same as in U2 cmd
                            tay                             ; 
                            ldx #FA_DISK                    ; get drive number (8)
                            jsr SETLFS                      ; Kernal($FFBA) Set logical file parameters ($FE00)
                            
                            jmp OPEN                        ; Kernal($FFC0) Open a logical file (via $31A to $F34A)
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; ´ ------------------------------------------------------------------------------------------------------------------- ;
; PrintInfoMsg              Does    : print a selected screen info line
;                           Expects : .X=address message lo
;                                   : .Y=address message hi
;                           Returns : 
; --------------------------------------------------------------------------------------------------------------------- ;
PrintInfoMsg               .block                           ; 
                            stx ZP_BufferPointer_Lo         ; 
                            sty ZP_BufferPointer_Hi         ; 
                            
                            ldy #$00                        ; 
                            lda (ZP_BufferPointer),y        ; 
                            
                            pha                             ; 
                            
                            cmp #PETSCII_RED                ; 
                            beq SetErrMsgPtr                ; 
                            
                            ldy #InfoMsgCol                 ; 
                            ldx #InfoMsgRow                 ; 
                            jmp SetCursor                   ; 
                            
SetErrMsgPtr                ldy #ErrorMsgCol                ; 
                            ldx #ErrorMsgRow                ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; set the cursor
; --------------------------------------------------------------------------------------------------------------------- ;
SetCursor                   clc                             ; 
                            jsr PLOT                        ; Kernal($FFF0) Read/set position of cursor on screen ($E50A)
                            
                            pla                             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; print the message
; --------------------------------------------------------------------------------------------------------------------- ;
                            ldy #$00                        ; ini message offset
PrintNextMsgChar            jsr CHROUT                      ; Kernal($FFD2) Output a character (via $326 to $F1CA)
                            
                            iny                             ; inc message offset
                            lda (ZP_BufferPointer),y        ; get message char
                            bne PrintNextMsgChar            ; chec: EoT - no: continue
                            
                            rts                             ; 
                           .bend                            ; 
; ` ------------------------------------------------------------------------------------------------------------------- ;
                            
; --------------------------------------------------------------------------------------------------------------------- ;
; disk command strings
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmdFileName             .byte "#" ; #                    
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmdReset                .byte "u" ; 
                            .byte "+" ; 
                            
                            .byte CR  ; 
                            .byte $00 ; flag: End of Text
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_SetBP               .byte "b" ; 
                            .byte "-" ; 
                            .byte "p" ; 
                            .byte " " ; 
                            .byte "2" ; 
                            .byte " " ; 
                            .byte "0" ; 
                            
                            .byte CR  ; 
                            .byte $00 ; flag: End of Text
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_BlockRW             .byte "u" ; 
DiskCmd_BlockRW_Type        .byte "2" ; 1-read 2-write
                            .byte ":" ; 
                            .byte "0" ; channel number
                            .byte "2" ; 
                            .byte " " ; 
                            .byte "0" ; drive number
                            .byte " " ; 
DiskCmd_BlockRW_Trk_Hi      .byte "0" ; 
DiskCmd_BlockRW_Trk_Lo      .byte "3" ; 
                            .byte " " ; 
DiskCmd_BlockRW_Sec_Hi      .byte "0" ; 
DiskCmd_BlockRW_Sec_Lo      .byte "0" ; 
                            
                            .byte CR  ; 
                            .byte $00 ; flag: End of Text
; --------------------------------------------------------------------------------------------------------------------- ;
; track/sector numbers
; --------------------------------------------------------------------------------------------------------------------- ;
TabDiskBlockTrk_Hi          .byte "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "1", "1", "1", "1", "1", "1", "1"
TabDiskBlockTrk_Lo          .byte "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "1", "2", "3", "4", "5", "6", "7"
                            
TabDiskBlockSec_Hi          .byte "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "2"
TabDiskBlockSec_Lo          .byte "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
TabDiskBlock_Sec_Max        = * - TabDiskBlockSec_Lo ; max sector number for track 1-17 ($14)
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
WorkDiskBlockOff_Sector     .byte $00 ; 
WorkDiskBlockOff_Track      .byte $01 ; 
                            
WorkNumLevelFile_Max        .byte $05 ; max 5 level data files
WorkNumLevelFileLevels_Max  .byte $32 ; max 50 levels per file
                            
WorkDiskRC_Hi               .byte $00 ; 
WorkDiskRC_Lo               .byte $00 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; lode runner level set name
; --------------------------------------------------------------------------------------------------------------------- ;
FileNameLevelData           = *       ; 
                            .text "pr lvl set "
FileNameLevelData_Hi        .byte "0" ; 0
FileNameLevelData_Lo        .byte "9" ; 9
FileNameLevelData_Len        = * - FileNameLevelData ; length
; --------------------------------------------------------------------------------------------------------------------- ;
; lode runner msg text level completed
; --------------------------------------------------------------------------------------------------------------------- ;
LevelTrailerData            = *       ; 
                            .byte $00 ; 
                            .byte $00 ; 
LevelTrailerData_Text       .text "LEVEL"
                            .byte $a0 ; <SHIFT_BLANK>
                            .byte $a0 ; <SHIFT_BLANK>
                            .text "COMPLETE"
                            .byte $00 ; 
                            .byte $00 ; 
                            .byte $00 ; 
LevelTrailerData_Id         .text "LODE"
                            .byte $a0 ; <SHIFT_BLANK>
                            .text "RUNNEr"
; --------------------------------------------------------------------------------------------------------------------- ;
; lode runner disk name/disk id
; --------------------------------------------------------------------------------------------------------------------- ;
TabLodeRunneDiskName        .null "honz lode runner"
TabLodeRunneDiskID          .null "DANE BIGHAM"
; --------------------------------------------------------------------------------------------------------------------- ;
; utility info msg postions
; --------------------------------------------------------------------------------------------------------------------- ;
TabInfoMsgNum_Row           .byte $07, $0a, $0c
TabInfoMsgNum_Col           .byte $0e, $0e, $0e
; --------------------------------------------------------------------------------------------------------------------- ;
; utility info msg texts
; --------------------------------------------------------------------------------------------------------------------- ;
InfoMsgHeader               = *       ; 
                            .byte PETSCII_CAPSOFF
                            .byte PETSCII_CYAN
                            .null "Lode Runner"
                            
                            .byte PETSCII_WHITE
                            .null "   Level"
                            
                            .byte PETSCII_WHITE
                            .null " Extractor"
                            
                            .byte $ff ; flag: End of Line
; --------------------------------------------------------------------------------------------------------------------- ;
InfoMsgFileRead             = *       ; 
                            .byte PETSCII_GREEN
                            .text "Read Level File: "
                            
                            .byte PETSCII_PURPLE
InfoMsgFileRead_Hi          .byte "0" ; 0
InfoMsgFileRead_Lo          .byte "2" ; 2
                            
                            .null "        "
; --------------------------------------------------------------------------------------------------------------------- ;
InfoMsgBlockWrite           = *       ; 
                            .byte PETSCII_GREEN
                            .text "Write Track: "
                            
                            .byte PETSCII_PURPLE
InfoMsgBlockWrite_Track_Hi  .byte "0" ; 0
InfoMsgBlockWrite_Track_Lo  .byte "0" ; 

                            .byte PETSCII_GREEN
                            .text "  Sector: "
                            
                            .byte PETSCII_PURPLE
InfoMsgBlockWrite_Sector_Hi .byte "0" ; 
InfoMsgBlockWrite_Sector_Lo .byte "0" ; 
                            
                            .byte $00 ; flag: End of Text
; --------------------------------------------------------------------------------------------------------------------- ;
InfoMsgBAM_Read              = *       ; 
                            .byte PETSCII_GREEN
                            .text "Read/Check "
                            
                            .byte PETSCII_PURPLE
                            .null "BAM               "
; --------------------------------------------------------------------------------------------------------------------- ;
ErrorMsg_DiskName_Bad       = *       ; 
                            .byte PETSCII_RED
                            .null "Wrong Disk Name!              "
; --------------------------------------------------------------------------------------------------------------------- ;
; variables
; --------------------------------------------------------------------------------------------------------------------- ;
LevelFileDataBuffer         = $2000                         ; start of level file data
LevelFileDataBuffer_Len       = LevelFileDataLevel_Num * LevelFileDataLevel_Len + LevelFileHdr_Len ; $2cbc
; --------------------------------------------------------------------------------------------------------------------- ;
; level file data layout
; --------------------------------------------------------------------------------------------------------------------- ;
; level file data header
; --------------------------------------------------------------------------------------------------------------------- ;
LevelFileHdr                = LevelFileDataBuffer           ; 
LevelFileHdr_Score          = LevelFileDataBuffer           ; 10*8 score entries
LevelFileHdr_Score_Len        = $08                         ; 
LevelFileHdr_Name           = LevelFileDataBuffer + $50     ; 10*8 name entries
LevelFileHdr_Name_Len         = $08                         ; 
LevelFileHdr_Zeros          = LevelFileDataBuffer + $a0     ; empty
LevelFileHdr_ID             = LevelFileDataBuffer + $f0     ; DANE BIGHAM
LevelFileHdr_PSWD           = LevelFileDataBuffer + $fb     ; 
LevelFileHdr_PSWD_On          = $01                         ; 
LevelFileHdr_PSWD_Off         = $00                         ; 
LevelFileHdr_Len              = $fc                         ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; level file level data
; --------------------------------------------------------------------------------------------------------------------- ;
LevelFileData               = LevelFileDataBuffer + LevelFileHdr_Len ; 
LevelFileDataLevel_Len        = $e0                         ; len level data
LevelFileDataLevel_Num        = $32                         ; 50 levels following
; --------------------------------------------------------------------------------------------------------------------- ;
; pointers
; --------------------------------------------------------------------------------------------------------------------- ;
ZP_LevelDataPointer         = $fb                           ; 
ZP_LevelDataPointer_Lo        = $fb                         ; 
ZP_LevelDataPointer_Hi        = $fc                         ; 
                            
ZP_BufferPointer            = $fd                           ; 
ZP_BufferPointer_Lo           = $fd                         ; 
ZP_BufferPointer_Hi           = $fe                         ; 
; --------------------------------------------------------------------------------------------------------------------- ;
DiskCmd_BlockRead           = "1"                           ; 
DiskCmd_BlockWrite          = "2"                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; PETSCII color codes                             
; --------------------------------------------------------------------------------------------------------------------- ;
PETSCII_WHITE               = $05                           ; 
PETSCII_RED                 = $1c                           ; 
PETSCII_GREEN               = $1e                           ; 
PETSCII_PURPLE              = $9c                           ; 
PETSCII_CYAN                = $9f                           ; 
                            
PETSCII_CAPSOFF             = $0e                           ; 
PETSCII_RETURN              = $0d                           ; 
PETSCII_CLRS                = $93                           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
InfoMsgCol                  = $06                           ; 
InfoMsgRow                  = $11                           ; 17
                            
ErrorMsgCol                 = InfoMsgCol                    ; 
ErrorMsgRow                 = InfoMsgRow + $02              ; 
                            
DiskBlockBuffer             = $c000                         ; 
; --------------------------------------------------------------------------------------------------------------------- ;
