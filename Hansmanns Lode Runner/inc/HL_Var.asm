; ------------------------------------------------------------------------------------------------------------- ;
; Hansmanns Lode Runner - In game variables
; ------------------------------------------------------------------------------------------------------------- ;
; Memory Layout
; ------------------------------------------------------------------------------------------------------------- ;
HL_MemScreenMC              = $0400 ; multi colors screen
HL_MemLevelGameData         = $0800 ; expanded level data - modified with    loderunner/enemies/holes
HL_MemLevelCtrlData         = $0a00 ; expanded level data - original without loderFunner/enemies/holes
HL_MemSpriteStore           = $0c00 ; sprite data store
HL_MemScreenGfxRowPtr_Lo    = $0e00 ; pointer: hires rows start addresses LO
HL_MemScreenGfxRowPtr_Hi    = $0f00 ; pointer: hires rows start addresses HI
HL_MemScoreDataDiskBuf      = $1000 ; buffer: high scores save/load                                             .hbu037.
HL_MemLevelDataDiskBuf      = $1100 ; buffer: packed level data buffer/game save                                .hbu037.
HL_MemTimesDataDiskBuf      = $1200 ; buffer: level times                                                       .hbu037.
HL_MemGameVars              = $1300 ; game variables
HL_MemStartGfxData          = $1400 ; start graphic compressed input data - separately loaded
HL_MemScreenGfxDisplay      = $2000 ; display hires screen
HL_MemScreenGfxPrepare      = $4000 ; prepare hires screen for direct output
; ------------------------------------------------------------------------------------------------------------- ;
; Game Code - $6000-$c1ff
; ------------------------------------------------------------------------------------------------------------- ;
HL_MemSaveGameDiskBuf       = $c200 ; buffer: save games list                                                   .hbu028.
; ------------------------------------------------------------------------------------------------------------- ;
HL_MemImageAdr_Lo           = $c300 ; image address table low  byte                                             .hbu000.
HL_MemImageAdr_Hi           = $c400 ; image address table high byte                                             .hbu000.
; ------------------------------------------------------------------------------------------------------------- ;
; Fix Buffer Area - $c500-$caff
; ------------------------------------------------------------------------------------------------------------- ;
HL_MemTunePlayTime          = $c500 ; tune times buffer
HL_MemTuneDataPtrVoice2     = $c600 ; tune data pointer voice 2 buffer
HL_MemTuneDataPtrVoice3     = $c700 ; tune data pointer voice 3 buffer
HL_MemTuneSuReVol           = $c800 ; tune sustain/release/volume buffer
                            
HL_MemHiddenLadders         = $c900 ; enlarged hidden ladders tab - $80 row positions / $80 col positions       .hbu030.
HL_MemBufRndLevelNum        = $ca00 ; random level number table                                                 .hbu021.
; ------------------------------------------------------------------------------------------------------------- ;
; Work Buffer Area - $cb00-$cfff - $500 (640) bytes
; ------------------------------------------------------------------------------------------------------------- ;
HL_MemBuf                   = $cb00            ; start of the independent working buffers
HL_MemBufDemoMoves          = HL_MemBuf + $000 ; $cb00 - demo moves - max $280 - $281 (640) crashes the game    .hbu034.
HL_MemBufSwapWork           = HL_MemBuf + $000 ; $cb00 - temp store swap levels                                 .hbu017.
HL_MemBufRndRemainNum       = HL_MemBuf + $000 ; $cb00 - table non selected level numbers for rnd tab generation.hbu021.
HL_MemBufScoreWork          = HL_MemBuf + $000 ; $cb00 - temp store for leaderboard update
HL_MemBufScoreWorkNew       = HL_MemBuf + $100 ; $cc00 - temp store for leaderboard update result
; ------------------------------------------------------------------------------------------------------------- ;
; Game Control Tables
; ------------------------------------------------------------------------------------------------------------- ;
HL_LevelGameData            = HL_MemLevelGameData           ; 
HL_LevelCtrlData            = HL_MemLevelCtrlData           ; 
; ------------------------------------------------------------------------------------------------------------- ;
HL_HiresRowStartPtrTab_Lo   = HL_MemScreenGfxRowPtr_Lo      ; 
HL_HiresRowStartPtrTab_Hi   = HL_MemScreenGfxRowPtr_Hi      ; 
; ------------------------------------------------------------------------------------------------------------- ;
; start track number of level data blocks
; ------------------------------------------------------------------------------------------------------------- ;
;HL_LevelDataStartTrackNum   = $03                          ;                                                   .hbu002. removed
; ------------------------------------------------------------------------------------------------------------- ;
; Level Data Block Layout - Compressed into one disk block (1 data byte = 2 level bytes/right one 1st)          .hbu002.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
; TT / SS - TT / SS ! Disk Level Num  ! Game Level Num  !                                                       .hbu002.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
; $01/$00 - $01/$14 ! Level 000 - 020 ! Level 001 - 021 ! each track contains $15 (21) level blocks ($00-$14)   .hbu002.
; $02/$00 - $02/$14 ! Level 021 - 041 ! Level 022 - 042 +------------------------------------------------------ ;
; $03/$00 - $03/$14 ! Level 042 - 062 ! Level 043 - 063 !                                                       .hbu002.
; $04/$00 - $04/$14 ! Level 063 - 083 ! Level 064 - 084 !                                                       .hbu002.
; $05/$00 - $05/$14 ! Level 084 - 104 ! Level 085 - 105 !                                                       .hbu002.
; $06/$00 - $06/$14 ! Level 105 - 125 ! Level 106 - 126 !                                                       .hbu002.
; $07/$00 - $07/$14 ! Level 126 - 146 ! Level 127 - 147 !                                                       .hbu002.
; $08/$00 - $08/$14 ! Level 147 - 167 ! Level 148 - 168 !                                                       .hbu002.
; $09/$00 - $09/$14 ! Level 168 - 188 ! Level 169 - 189 !                                                       .hbu002.
; $0a/$00 - $0a/$14 ! Level 189 - 219 ! Level 190 - 210 !                                                       .hbu002.
; $0b/$00 - $0b/$14 ! Level 210 - 230 ! Level 211 - 231 !                                                       .hbu002.
; $0c/$00 - $0c/$12 ! Level 231 - 249 ! Level 232 - 250 !                                                       .hbu002.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
;           $0c/$13 ! Disk Level 250  ! Champ Block     ! Congratulations for passing 150 levels                .hbu002.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
;           $0c/$14 ! Disk Level 251  ! Scores Block    ! Leaderboard Entries                                   .hbu002.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
;           $0d/$00 ! Disk Level 252  ! Save Game Block ! 10 Game Save Slots                                    .hbu002.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
;           $0d/$01 ! Disk Level 253  ! Times Block 00  ! Level Solved Times for Level 000-083 (84)             .hbu037.
;           $0d/$02 ! Disk Level 254  ! Times Block 01  ! Level Solved Times for Level 084-167 (84)             .hbu037.
;           $0d/$03 ! Disk Level 255  ! Times Block 02  ! Level Solved Times for Level 168-250 (82)             .hbu037.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
; $0d/$04 - $0d/$0d !                 ! RND Num Blocks  ! Random Mode Level Numbers Blocks for each save game   .hbu028.
; ------------------+-----------------+-----------------+------------------------------------------------------ ;
; High Scores Block Layout - at $1000
; ------------------------------------------------------------------------------------------------------------- ;
; tt=$0c/ss=$14 - Disk Level 251 
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScoreBuf                 = HL_MemScoreDataDiskBuf        ; high scores
HL_ScoreBuf_Len             = $fb                           ; 
HL_ScoreBufEntry_Max          = $0a                         ; max 10 entries
HL_ScoreBufEntry_Len          = HL_ScoreBufFlag_Random - HL_ScoreBufName + $01 ; $10 ($00-$0f)
HL_ScoreBufTable_Len          = HL_ScoreBufEntry_Len * HL_ScoreBufEntry_Max ; $a0 ($10*$0a)
; ------------------------------------------------------------------------------------------------------------- ;
; 10 leaderboard entries
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScoreBufName             = HL_ScoreBuf         + $00     ; scorer name                                       .hbu029.
HL_ScoreBufName_Len           = $08                         ; length of name                                    .hbu029.
HL_ScoreBufName_Char1         = HL_ScoreBufName   + $00     ; scorer name char table                            .hbu029.
HL_ScoreBufName_Char2         = HL_ScoreBufName   + $01     ;                                                   .hbu029.
HL_ScoreBufName_Char3         = HL_ScoreBufName   + $02     ;                                                   .hbu029.
HL_ScoreBufName_Char4         = HL_ScoreBufName   + $03     ;                                                   .hbu029.
HL_ScoreBufName_Char5         = HL_ScoreBufName   + $04     ;                                                   .hbu029.
HL_ScoreBufName_Char6         = HL_ScoreBufName   + $05     ;                                                   .hbu029.
HL_ScoreBufName_Char7         = HL_ScoreBufName   + $06     ;                                                   .hbu029.
HL_ScoreBufName_Char8         = HL_ScoreBufName   + $07     ;                                                   .hbu029.
HL_ScoreBufLevel            = HL_ScoreBuf         + $08     ; level reached - sort crit 01                      .hbu029.
HL_ScoreBufValue            = HL_ScoreBuf         + $09     ; score reached - sort crit 02                      .hbu029.
HL_ScoreBufValue_Hi           = HL_ScoreBufValue    + $00   ; packed decimal - two digits in one byte           .hbu029.
HL_ScoreBufValue_Mid_Hi       = HL_ScoreBufValue    + $01   ;                                                   .hbu029.
HL_ScoreBufValue_Mid_Lo       = HL_ScoreBufValue    + $02   ;                                                   .hbu029.
HL_ScoreBufValue_Lo           = HL_ScoreBufValue    + $03   ;                                                   .hbu029.
HL_ScoreBufFlags            = HL_ScoreBuf         + $0d     ; game flags                                        .hbu029.
HL_ScoreBufFlag_Debug         = HL_ScoreBufFlags    + $00   ;                                                   .hbu029.
HL_ScoreBufFlag_Mirror        = HL_ScoreBufFlags    + $01   ;                                                   .hbu029.
HL_ScoreBufFlag_Random        = HL_ScoreBufFlags    + $02   ;                                                   .hbu029.
; ------------------------------------------------------------------------------------------------------------- ;
; unused space
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScoreBufEmpty_01         = HL_ScoreBuf + HL_ScoreBufTable_Len ; not used
HL_ScoreBufEmpty_01_Len       = $50                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
; loderunner disk ID
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScoreBufDiskId           = HL_ScoreBuf + $f0             ; DANE BIGHAM
HL_ScoreBufDiskId_Len         = $0a                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
; loderunner disk flag
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScoreBufCheck            = HL_ScoreBuf + $fb             ; loderunner user/master disk indicator
HL_ScoreBufCheck_Bad          = $00                         ; loderunner disk ID not found
HL_ScoreBufCheck_Mod_No       = $01                         ; loderunner master disk - not modifiable
HL_ScoreBufCheck_Mod_Yes      = $ff                         ; loderunner user level data disk - modifiable
; ------------------------------------------------------------------------------------------------------------- ;
; rest to complete 255 block bytes
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScoreBufEmpty_02         = HL_ScoreBuf + $fc             ; not used
HL_ScoreBufEmpty_02_Len       = $04                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
; Level Data Block Layout - $1100
; ------------------------------------------------------------------------------------------------------------- ;
HL_LevelDataBuf             = HL_MemLevelDataDiskBuf        ; 
HL_LevelDataBufData         = HL_LevelDataBuf               ; packed level data - 2 level tiles in one byte 
HL_LevelDataBufData_Len       = HL_LevelDataBufDataCols * HL_LevelDataBufDataRows ; 
HL_LevelDataBufDataCols       = $0e                         ; each level data row   consists of $0e column bytes 
HL_LevelDataBufDataRows       = $10                         ; each level data block consists of $10 rows
; ------------------------------------------------------------------------------------------------------------- ;
; all gold collected message area
; ------------------------------------------------------------------------------------------------------------- ;
HL_LevelDataBufMsg          = HL_LevelDataBuf    + $e0      ; message text and id                               .hbu009.
HL_LevelDataBufMsgHdr       = HL_LevelDataBufMsg + $00      ; $00 $00                                           .hbu009.
HL_LevelDataBufMsgHdr_Len     = $02                         ;                                                   .hbu009.
HL_LevelDataBufMsgTxt       = HL_LevelDataBufMsg + $02      ; level victory message text                        .hbu009.
HL_LevelDataBufMsgTxt_Len     = $0f                         ; max 15 text chrs                                  .hbu009.
HL_LevelDataBufMsgID        = HL_LevelDataBufMsg + $12      ; $00 $00 $00 LODE RUNNEr                           .hbu009.
HL_LevelDataBufMsgID_Len      = $0d                         ;                                                   .hbu009.
; ------------------------------------------------------------------------------------------------------------- ;
; Level Solved Times Block Layout - at $1200
; ------------------------------------------------------------------------------------------------------------- ;
; tt=$0d/ss=$01 - Disk Level 253 - Block 01 - stores times for disk level numbers: 000 - 083 (84 levels)
; tt=$0d/ss=$02 - Disk Level 254 - Block 02 - stores times for disk level numbers: 083 - 167 (84 levels)
; tt=$0d/ss=$03 - Disk Level 255 - Block 03 - stores times for disk level numbers: 168 - 249 (82 levels)
; ------------------------------------------------------------------------------------------------------------- ;
HL_TimerBuf                 = HL_MemTimesDataDiskBuf        ; level solved times
HL_TimerBuf_Entry_Max         = $54                         ; 84 ($00-$53) entries of $03 bytes                 .hbu037.
HL_TimerBuf_Entry_Len         = $03                         ; length of each save list entry                    .hbu037.
HL_TimerBuf_Block           = HL_TimerBuf                   ; times data block start                            .hbu037.
HL_TimerBuf_Block_Len         = HL_TimerBuf_Entry_Len * HL_TimerBuf_Entry_Max ; times data block length         .hbu037.
; ------------------------------------------------------------------------------------------------------------- ;
HL_TimerBuf_Empty            = HL_TimerBuf + HL_TimerBuf_Block_Len ; <unused>                                   .hbu037.
; ------------------------------------------------------------------------------------------------------------- ;
HL_TimerBuf_Mod             = HL_TimerBuf + $fd             ; times block number                                .hbu037.
HL_TimerBuf_Mod_Yes           = $80                         ; flag: block was modified with a new time          .hbu037.
HL_TimerBuf_Mod_No            = $00                         ; flag: block was not modified with a new time      .hbu037.
HL_TimerBuf_BlockNum        = HL_TimerBuf + $fe             ; times disk block number                           .hbu037.
HL_TimerBuf_BlockNum_01       = $fd                         ; times disk block number 01 (253)                  .hbu037.
HL_TimerBuf_BlockNum_02       = $fe                         ; times disk block number 01 (254)                  .hbu037.
HL_TimerBuf_BlockNum_03       = $ff                         ; times disk block number 01 (255)                  .hbu037.
; ------------------------------------------------------------------------------------------------------------- ;
; Save Games Block Layout - $c200
; ------------------------------------------------------------------------------------------------------------- ;
; tt=$0d/ss=$00
; ------------------------------------------------------------------------------------------------------------- ;
HL_SaveGameBuf              = HL_MemSaveGameDiskBuf         ;                                                   .hbu028.
HL_SaveGameBuf_Len          = HL_SaveGameBuf_Entry_Len * HL_SaveGameBuf_Entry_Max ; length of the whole block   .hbu028.
HL_SaveGameBuf_Entry_Max      = $0a                         ; 10 entries of 16 bytes                            .hbu028.
HL_SaveGameBuf_Entry_Len      = $10                         ; length of each save list entry                    .hbu028.
HL_SaveGameBuf_Name         = HL_SaveGameBuf     + $00      ; entry name                                        .hbu028.
HL_SaveGameBuf_Name_Len       = $06                         ;                                                   .hbu028.
HL_SaveGameBuf_Level        = HL_SaveGameBuf     + $06      ; game level number                                 .hbu028.
HL_SaveGameBuf_Lives        = HL_SaveGameBuf     + $07      ; number of lives                                   .hbu028.
HL_SaveGameBuf_Score        = HL_SaveGameBuf     + $08      ; score                                             .hbu028.
HL_SaveGameBuf_Score_Hi       = HL_SaveGameBuf_Score + $00  ;                                                   .hbu028.
HL_SaveGameBuf_Score_Mi_Hi    = HL_SaveGameBuf_Score + $01  ;                                                   .hbu028.
HL_SaveGameBuf_Score_Mi_Lo    = HL_SaveGameBuf_Score + $02  ;                                                   .hbu028.
HL_SaveGameBuf_Score_Lo       = HL_SaveGameBuf_Score + $03  ;                                                   .hbu028.
HL_SaveGameBuf_RND_BAM_Num  = HL_SaveGameBuf     + $0c      ; BAM RND status table entry number                 .hbu028.
HL_SaveGameBuf_RND_BAM_Num_Used = $80                       ; flag: BAM RND status table entry number used      .hbu028.
HL_SaveGameBuf_RND_BAM_Num_Free = $00                       ; flag: BAM RND status table entry number unused    .hbu028.
HL_SaveGameBuf_Flag_Debug   = HL_SaveGameBuf     + $0d      ; flag: debug mode used                             .hbu028.
HL_SaveGameBuf_Flag_Mirror  = HL_SaveGameBuf     + $0e      ; flag: mirror mode                                 .hbu028.
HL_SaveGameBuf_Flag_RND     = HL_SaveGameBuf     + $0f      ; flag: random mode                                 .hbu028.
; ------------------------------------------------------------------------------------------------------------- ;
; Status table of the 10 RND level number blocks
; ------------------------------------------------------------------------------------------------------------- ;
HL_SaveGameBuf_RND_BAM      = HL_SaveGameBuf     + $b0      ; table of free/used random level blocks            .hbu028.
HL_SaveGameBuf_RND_BAM_Used   = $00                         ; flag: block used                                  .hbu028.
HL_SaveGameBuf_RND_BAM_Free   = $ff                         ; flag: block free                                  .hbu028.
HL_SaveGameBuf_RND_BAM_Len    = HL_SaveGameBuf_Entry_Max    ; 10 - one entry for each save game                 .hbu028.
; ------------------------------------------------------------------------------------------------------------- ;
; save game block identifier
; ------------------------------------------------------------------------------------------------------------- ;
HL_SaveGameBuf_Id            = HL_SaveGameBuf    + $f0      ; if valid must be set to "HBU"                     .hbu028.
HL_SaveGameBuf_Id_01           = HL_SaveGameBuf_Id + $00    ;                                                   .hbu028.
HL_SaveGameBuf_Id_Char_01        = "H"                      ;                                                   .hbu028.
HL_SaveGameBuf_Id_02           = HL_SaveGameBuf_Id + $01    ;                                                   .hbu028.
HL_SaveGameBuf_Id_Char_02        = "B"                      ;                                                   .hbu028.
HL_SaveGameBuf_Id_03           = HL_SaveGameBuf_Id + $02    ;                                                   .hbu028.
HL_SaveGameBuf_Id_Char_03        = "U"                      ;                                                   .hbu028.
; ------------------------------------------------------------------------------------------------------------- ;
; tt=$0d/ss=$04 - RND save blocks start directly behind disk level block 255 (last best times block)
; ------------------------------------------------------------------------------------------------------------- ;
HL_SaveGameBuf_RND_BAM_Trk    = $0d                         ; track number of the RND level number blocks       .hbu028.
HL_SaveGameBuf_RND_BAM_Sec    = $04                         ; sector number of the RND level number blocks      .hbu028.
; ------------------------------------------------------------------------------------------------------------- ;
; RND level number selection table of 250 entries - $ca00
; ------------------------------------------------------------------------------------------------------------- ;
HL_BufRndLevelNum           = HL_MemBufRndLevelNum          ; random level numbers                              .hbu021.
; ------------------------------------------------------------------------------------------------------------- ;
; Hires Color Positions on Start Screen
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScreenMC                 = HL_MemScreenMC                ; 
HL_ScreenMC_Top             = HL_ScreenMC + $0000           ;                                                   .hbu028.
HL_ScreenMC_Header          = HL_ScreenMC + $00c8           ;                                                   .hbu028.
HL_ScreenMC_Page0           = HL_ScreenMC + $0000           ; 
HL_ScreenMC_Page1           = HL_ScreenMC + $0100           ; 
HL_ScreenMC_Page2           = HL_ScreenMC + $0200           ; 
HL_ScreenMC_Page3           = HL_ScreenMC + $02f8           ; stop at $7f7 - do not overwrite sprite pointers
HL_ScreenMC_Status          = HL_ScreenMC + $0370           ;                                                   .hbu006.
HL_ScreenMC_Title           = HL_ScreenMC + $0398           ; title scores                                      .hbu099.
HL_ScreenMC_MsgColor        = HL_ScreenMC + $03aa           ; message color area                                .hbu006.
HL_ScreenMC_MsgColor_Len      = $14                         ; message color length                              .hbu006.
; ------------------------------------------------------------------------------------------------------------- ;
; Colorram Positions
; ------------------------------------------------------------------------------------------------------------- ;
;HL_ColorRam_Page0          = COLORAM_PAGE_0                ; 
;HL_ColorRam_Page1          = COLORAM_PAGE_1                ; 
;HL_ColorRam_Page2          = COLORAM_PAGE_2                ; 
;HL_ColorRam_Page3          = COLORAM_PAGE_3                ; 
                            
HL_ColorRam_Status          = COLORAM_PAGE_3 + $b0          ; offset status lines
; ------------------------------------------------------------------------------------------------------------- ;
; Misc Values
; ------------------------------------------------------------------------------------------------------------- ;
; Level Data Tile Numbers
; ------------------------------------------------------------------------------------------------------------- ;
HL_TileNum_Empty            = NumTile_Empty                 ; 
HL_TileNum_BrickSoft        = NumTile_BrickSoft             ; 
HL_TileNum_BrickHard        = NumTile_BrickHard             ; 
HL_TileNum_Ladder           = NumTile_Ladder                ; 
HL_TileNum_Pole             = NumTile_Pole                  ; 
HL_TileNum_BrickTrap        = NumTile_BrickTrap             ; 
HL_TileNum_LadderExit       = NumTile_LadderExit            ; 
HL_TileNum_Gold             = NumTile_Gold                  ; 
HL_TileNum_Enemy            = NumTile_Enemy                 ; 
HL_TileNum_LodeRunner       = NumTile_LodeRunner            ; 
HL_TileNum_Min              = NumTile_Min                   ; 
HL_TileNum_Max              = NumTile_Max                   ; valid tile number range is $00-$09

HL_TileNum_LodeRunner_Edit  = NumTile_LodeRunner_Edit       ;                                                   .hbu033.
; ------------------------------------------------------------------------------------------------------------- ;
; leader board offsets
; ------------------------------------------------------------------------------------------------------------- ;
HL_BoardHeaderRows          = $04                           ; rows to be bypassed to get to the 1st board entry
HL_BoardEntryCol_Id         = $04                           ; col number of the board entry ID                  .hbu029.
HL_BoardEntryCol_Id_Len       = $07                         ; maximum length of each high score ID              .hbu029.
HL_BoardEntryCol_Level      = $0e                           ; col number of the board entry level number
HL_BoardEntryCol_Score      = $13                           ; col number of the board entry scores 
; ------------------------------------------------------------------------------------------------------------- ;
; status row offsets
; ------------------------------------------------------------------------------------------------------------- ;
HL_StatusRow_Col_Score      = $05                           ; column offset for score output in base line       .hbu009.
HL_StatusRowNum             = $10                           ; row offset for status output in base line         .hbu009.
HL_StatusRow_Col_Msg        = $0d                           ; column offset for victory msg  in base line       .hbu009.
; ------------------------------------------------------------------------------------------------------------- ;
; move high score targets to prepare insertion of a new entry
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScoreBufEntryFrom        = HL_ScoreBuf
HL_ScoreBufEntryTo          = HL_ScoreBuf + HL_ScoreBufEntry_Len ; 
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScreenCols_Min           = $00                           ; screen position - max left
HL_ScreenCols_Max           = $1b                           ; screen position - max right
HL_ScreenRows_Min           = $00                           ; screen position - max up
HL_ScreenRows_Max           = $0f                           ; screen position - max down
                            
HL_EnemyMoveDir_None        = $00                           ; for save enemy status
HL_EnemyMoveDir_Le          = $01                           ; 
HL_EnemyMoveDir_Ri          = $02                           ; 
HL_EnemyMoveDir_Up          = $03                           ; 
HL_EnemyMoveDir_Do          = $04                           ; 
                            
HL_ImageHeight              = $0b                           ; image dimensions
HL_ImageWidth               = $0a                           ; 
                            
HL_PosOnImage_Min           = $00                           ; position on image
HL_PosOnImage_Center        = $02                           ; 
HL_PosOnImage_Max           = $04                           ; 
; ------------------------------------------------------------------------------------------------------------- ;
; score values
; ------------------------------------------------------------------------------------------------------------- ;
HL_Score_EnemyDigIn         = $0075                         ; 2 byte BCD - score for digging in enemies
HL_Score_EnemyRebirth       = $0075                         ; 2 byte BCD - score for enemy rebirth
HL_Score_Gold               = $0250                         ; 2 byte BCD - score for picking up gold
HL_Score_FinishLevel        =  1500                         ; decimal    - needed for score step calc in LRZ_ScoreTuneSub_Ini
; ------------------------------------------------------------------------------------------------------------- ;
; disk access flags
; ------------------------------------------------------------------------------------------------------------- ;
HL_DiskRead                 = $01                           ;       flag: read
HL_DiskWrite                = $02                           ;       flag: write
HL_DiskInit                 = $04                           ;       flag: init
HL_DiskTimes                = $08                           ;       flag: times
HL_DiskForce_Times          = $80                           ;       flag: force level times block load          .hbu037.
HL_DiskForce_Score          = $80                           ;       flag: force score block load                .hbu001.
HL_DiskForce_RND            = $40                           ;       flag: force save  block load                .hbu028.
; ------------------------------------------------------------------------------------------------------------- ;
; game over sign spinnig speed values
; ------------------------------------------------------------------------------------------------------------- ;
HL_SpinSignSpeed_Fast       = $01                           ; fast speed flip sign
HL_SpinSignSpeed_Slow       = $64                           ; slow speed flip sign
; ------------------------------------------------------------------------------------------------------------- ;
; IRQ raster line vales the hero message display of the start grafic screen
; ------------------------------------------------------------------------------------------------------------- ;
HL_IRQ_TitleRasterLine_Top  = $ea                           ; 1st raster line                                   .hbu032.
HL_IRQ_TitleRasterLine_Bot  = $f8                           ; 2nd raster line                                   .hbu032.
; ------------------------------------------------------------------------------------------------------------- ;
; Sprite Pointers
; ------------------------------------------------------------------------------------------------------------- ;
HL_SpritePtr                = HL_MemScreenMC + SPNTR_OFFSET ; sprite data pointers
HL_SpritePtr_00             = HL_SpritePtr + $00            ; sprite 0 data at $0c00
HL_SpritePtr_02             = HL_SpritePtr + $02            ; sprite 2 data at $0c40
HL_SpritePtr_03             = HL_SpritePtr + $03            ; sprite 3 data at $0c80
HL_SpritePtr_04             = HL_SpritePtr + $04            ; sprite 4 data at $0cc0
HL_SpritePtr_06             = HL_SpritePtr + $06            ; sprite 6 data at $0d00
HL_SpritePtr_07             = HL_SpritePtr + $07            ; sprite 7 data at $0d40
                            
HL_SpriteData               = HL_MemSpriteStore             ; sprite data storage
HL_SpriteData_00            = HL_SpriteData + SPRT_BLK_LEN * $00 ; sprite data store 0
HL_SpriteData_01            = HL_SpriteData + SPRT_BLK_LEN * $01 ; sprite data store 1
HL_SpriteData_02            = HL_SpriteData + SPRT_BLK_LEN * $02 ; sprite data store 2
HL_SpriteData_03            = HL_SpriteData + SPRT_BLK_LEN * $03 ; sprite data store 3
HL_SpriteData_04            = HL_SpriteData + SPRT_BLK_LEN * $04 ; sprite data store 4
                            
HL_SpriteData_05            = HL_SpriteData + SPRT_BLK_LEN * $05 ; sprite data store 5
HL_SpriteData_06            = HL_SpriteData + SPRT_BLK_LEN * $06 ; sprite data store 6 - not used
HL_SpriteData_07            = HL_SpriteData + SPRT_BLK_LEN * $07 ; sprite data store 7 - not used
                            
HL_SpriteDataPage_01        = HL_MemSpriteStore + SPRT_BLK_LEN * $00 ; 
HL_SpriteDataPage_02        = HL_MemSpriteStore + SPRT_BLK_LEN * $04 ; 
; ------------------------------------------------------------------------------------------------------------- ;
; In Game Vaiables $1300-$137f
; ------------------------------------------------------------------------------------------------------------- ;
HL_GameVars                 = HL_MemGameVars                ; $1300
                              GameVars := HL_GameVars - 1   ; $12ff  set the start value
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1300
HL_NumLives                 = GameVars                      ; 
HL_NumLivesInit               = $05                         ; 
HL_NumLivesDemo               = $01                         ; 
                              GameVars += 1                 ; $1301
HL_NumLivesSave             = GameVars                      ; 
                              GameVars += 1                 ; $1302
HL_GoldToCollect            = GameVars                      ; 
HL_GoldToCollect_None         = $00                         ; 
                              GameVars += 1                 ; $1303
HL_LevelNumGame             = GameVars                      ;        001-250
HL_LevelNumGame_Min           = $01                         ;          do not use a value LT 001
HL_LevelNumGame_Max           = $fa                         ;          do not use a value GT 250                .hbu002.
HL_LevelNumDemo_Min           = $01                         ;          minimum number of demo levels            .hbu003.
HL_LevelNumDemo_Max           = $04                         ;          maximum number of demo levels            .hbu003.
                              GameVars += 1                 ; $1304
HL_LevelNumDisk             = GameVars                      ;        000-249
HL_LevelNumDisk_Min           = HL_LevelNumGame_Min - $01   ;            000
HL_LevelNumDisk_Max           = HL_LevelNumGame_Max - $01   ;        $f9=249 - max level  block - Trk 12/Sec 18
HL_LevelNumDisk_Champ         = HL_LevelNumGame_Max         ;        $fa=250 - champion   block - Trk 12/Sec 19 .hbu041.
HL_LevelNumDisk_Score         = HL_LevelNumGame_Max + $01   ;        $fb=251 - top scores block - Trk 12/Sec 20
HL_LevelNumDisk_Saves         = HL_LevelNumGame_Max + $02   ;        $fc=252 - game saves block - Trk 13/Sec 00 .hbu028.
HL_LevelNumDisk_Demo_Min      = HL_LevelNumDemo_Min - $01   ;            000 -                                  .hbu003.
HL_LevelNumDisk_Demo_Max      = HL_LevelNumDemo_Max - $01   ;            004 - build in demo levels             .hbu003.
                              GameVars += 1                 ; $1305
HL_LevelNumDiskSave         = GameVars                      ;                                                   .hbu028.
                              GameVars += 1                 ; $1306
HL_LevelReload              = GameVars                      ;        level will be reloaded if <> HL_LevelNumDisk
HL_LevelReload_Force          = $ff                         ;        force level reload
                              GameVars += 1                 ; $1307
HL_DiskAction               = GameVars                      ;        store read/write/init
                              GameVars += 1                 ; $1308
HL_Cheated                  = GameVars                      ; 
HL_Cheated_Yes                = $00                         ; 
HL_Cheated_No                 = $01                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1309
HL_ModeMirror               = GameVars                      ;        flag: mirror mode                          .hbu017.
HL_ModeMirror_On              = $80                         ;                                                   .hbu017.
HL_ModeMirror_Off             = $00                         ;                                                   .hbu017.
                              GameVars += 1                 ; $130a
HL_ModeRnd                  = GameVars                      ;        flag: random level mode                    .hbu021.
HL_ModeRnd_On                 = $80                         ;                                                   .hbu021.
HL_ModeRnd_Off                = $00                         ;                                                   .hbu021.
                              GameVars += 1                 ; $130b
HL_ModeXmit                 = GameVars                      ;        flag: level xmit mode                      .hbu022.
HL_ModeXmit_On                = $80                         ;                                                   .hbu022.
HL_ModeXmit_Off               = $00                         ;                                                   .hbu022.
                              GameVars += 1                 ; $130c
HL_ModeDebug                = GameVars                      ;        flag: debug mode                           .hbu022.
HL_ModeDebug_On               = $80                         ;                                                   .hbu022.
HL_ModeDebug_Off              = $00                         ;                                                   .hbu022.
                              GameVars += 1                 ; $130d
HL_ModeDebugUsed            = GameVars                      ;        flag: debug mode used                      .hbu022.
HL_ModeDebugUsed_Yes          = $80                         ;                                                   .hbu022.
HL_ModeDebugUsed_Game         = $80                         ;              prevent high score recording         .hbu022.
HL_ModeDebugUsed_Level        = $01                         ;              prevent level time recording         .hbu022.
HL_ModeDebugUsed_No           = $00                         ;                                                   .hbu022.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $130e
HL_GameMode                 = GameVars                      ;        game mode flags
HL_GameMode_Start             = $00                         ;        show start grafic
HL_GameMode_Demo              = $01                         ;        show the demo level play
HL_GameMode_Play              = $02                         ;        play a level / show the score screen
HL_GameMode_PlayFromEdit      = $03                         ;        play a level from a board editor session
HL_GameMode_Edit              = $05                         ;        board editor
; ------------------------------------------------------------------------------------------------------------- ;
; loderunner
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $130f
HL_LodeRuState              = GameVars                      ; 
HL_LodeRuState_Death          = $00                         ; 
HL_LodeRuState_Alive          = $01                         ; 
                              GameVars += 1                 ; $1310
HL_LodeRuFallsDown          = GameVars                      ;        $00=fall $20=no fall $ff=init
HL_LodeRuFallsDown_Yes        = $00                         ; 
HL_LodeRuFallsDown_No         = $20                         ; 
                              GameVars += 1                 ; $1311
HL_LodeRuShoot              = GameVars                      ;        $00=no $01=right $ff=left
HL_LodeRuShoot_No             = $00                         ; 
HL_LodeRuShoot_Ri             = $01                         ; 
HL_LodeRuShoot_Le             = $ff                         ; 
                              GameVars += 1                 ; $1312
HL_LodeRuShootMode          = GameVars                      ;         loderunner shoot direction
HL_LodeRuShootMode_Back       = $00                         ;         shoot behind loderunner
HL_LodeRuShootMode_Front      = $ff                         ;         shoot in front of loderunner
                              GameVars += 1                 ; $1313
HL_LodeRuGetGold            = GameVars                      ;        get gold  0=just gets it
HL_LodeRuGetGold_Picking      = $00                         ; 
HL_LodeRuGetGold_Picked       = $01                         ; 
                              GameVars += 1                 ; $1314
HL_LodeRuShadeTabOff        = GameVars                      ;        shade table offset                         .hbu013.
; ------------------------------------------------------------------------------------------------------------- ;
; enemies
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1315
HL_EnemyBirthCol            = GameVars                      ; 
HL_EnemyBirthCol_Min          = $00                         ; 
HL_EnemyBirthCol_Max          = $1c                         ; 
                              GameVars += 1                 ; $1316
HL_EnemyCount               = GameVars                      ; 
HL_EnemyCount_None            = $00                         ; 
HL_EnemyCount_Min             = $01                         ; 
HL_EnemyCount_Max             = $05                         ; 
                              GameVars += 1                 ; $1317
HL_EnemyToMoveNum           = GameVars                      ; 
HL_EnemyToMoveNum_None        = $00                         ; 
HL_EnemyToMoveNum_Min         = $01                         ; 
                              GameVars += 1                 ; $1318
HL_EnemyInHoleTime          = GameVars                      ;        init values dynamically taken from in game: TabEnemyInHoleTime
                              GameVars += 1                 ; $1319
HL_EnemyBirthColorRowNum    = GameVars                      ;        actual sprite color tab row number         .hbu008.
                              GameVars += 1                 ; $131a
HL_EnemyColorTabRowNum      = GameVars                      ;        actual colorset tab row num for enemy rebirth coloring .hbu007.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $131b
HL_SpriteShow               = GameVars                      ;        control sprite display
HL_SpriteShow_On              = $00                         ; 
HL_SpriteShow_Off             = $05                         ; 
                              GameVars += 1                 ; $131c
HL_SpriteSaveActive         = GameVars                      ;        save the active sprites                    .hbu022.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $131d
HL_Digit                    = GameVars                      ; 
HL_Digit_100                  = GameVars                    ; 
                              GameVars += 1                 ; $131e
HL_Digit_10                   = GameVars                    ; 
                              GameVars += 1                 ; $131f
HL_Digit_1                    = GameVars                    ; 
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1320
HL_Score                    = GameVars                      ; 
HL_Score_Lo                   = GameVars                    ; 
                              GameVars += 1                 ; $1321
HL_Score_Mid_Lo               = GameVars                    ; 
                              GameVars += 1                 ; $1322
HL_Score_Mid_Hi               = GameVars                    ; 
                              GameVars += 1                 ; $1323
HL_Score_Hi                   = GameVars                    ; 
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1324
HL_ScoreOld                 = GameVars                      ;                                                   .hbu031.
HL_ScoreOld_Lo                = GameVars                    ;                                                   .hbu031.
                              GameVars += 1                 ; $1325
HL_ScoreOld_Mid_Lo            = GameVars                    ;                                                   .hbu031.
                              GameVars += 1                 ; $1326
HL_ScoreOld_Mid_Hi            = GameVars                    ;                                                   .hbu031.
                              GameVars += 1                 ; $1327
HL_ScoreOld_Hi                = GameVars                    ;                                                   .hbu031.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1328
HL_Timer_BCD_Mins           = GameVars                      ;                                                   .hbu011.
                              GameVars += 1                 ; $1329
HL_Timer_BCD_Secs           = GameVars                      ;                                                   .hbu011.
                              GameVars += 1                 ; $132a
HL_Timer_BCD_10th           = GameVars                      ;                                                   .hbu011.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $132b
HL_GameSpeed                = GameVars                      ; 
HL_GameSpeed_Min              = $03                         ; 
HL_GameSpeed_Normal           = $05                         ; 
HL_GameSpeed_Max              = $08                         ; 
                              GameVars += 1                 ; $132c
HL_GameSpeedCtrl            = GameVars                      ;        game speed control value
HL_GameSpeedCtrl_Max          = $0a                         ; 
                              GameVars += 1                 ; $132d
HL_CountIRQs                = GameVars                      ; 
HL_CountIRQs_Init             = $03                         ; 
                              GameVars += 1                 ; $132e
HL_WaitTime_Lo              = GameVars                      ; 
                              GameVars += 1                 ; $132f
HL_WaitTime_Hi              = GameVars                      ; 
                              GameVars += 1                 ; $1330
HL_DisplayChr               = GameVars                      ;        byte under cursor
                              GameVars += 1                 ; $1331
HL_HiresRowColNumAdd_Lo     = GameVars                      ; 
                              GameVars += 1                 ; $1332
HL_HiresRowColNumAdd_Hi     = GameVars                      ; 
                              GameVars += 1                 ; $1333
HL_HiresBlockCount          = GameVars                      ; 
                              GameVars += 1                 ; $1334
HL_ExitLadderCount          = GameVars                      ; 
HL_ExitLadderCount_None       = $00                         ; 
HL_ExitLadderCount_Max        = HL_WA_ExitLadder_Max        ; 
; ------------------------------------------------------------------------------------------------------------- ;
; input control
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1335
HL_ControllerType           = GameVars                      ; 
HL_ControllerType_Joystick    = $ca                         ; 
HL_ControllerType_Keyboard    = $cb                         ; 
                              GameVars += 1                 ; $1336
HL_PlayerInputType          = GameVars                      ;        flag: type of user interaction             .hbu027.
HL_PlayerInputType_Keyboard   = $00                         ;                                                   .hbu027.
HL_PlayerInputType_Joystick   = $ff                         ;                                                   .hbu027.
; ------------------------------------------------------------------------------------------------------------- ;
; keyboard
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1337
HL_KeyNew                   = GameVars                      ; 
HL_KeyNew_None                = $00                         ; 
                              GameVars += 1                 ; $1338
HL_KeyOld                   = GameVars                      ; 
HL_KeyOld_None                = $00                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
; joystick
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1339
HL_JoystickNew              = GameVars                      ;                                                   .hbu027.
HL_JoystickNew_None           = $00                         ; 
                              GameVars += 1                 ; $133a
HL_JoystickOld              = GameVars                      ;                                                   .hbu027.
                              GameVars += 1                 ; $133b
HL_JoystickMoveDirY         = GameVars                      ;        Joystick direction none/up/down
HL_JoystickMoveDir_None       = $00                         ; 
HL_JoystickMoveDirY_Up        = $21                         ; 
HL_JoystickMoveDirY_Do        = $25                         ; 
                              GameVars += 1                 ; $133c
HL_JoystickMoveDirX         = GameVars                      ;        Joystick direction (fire)left/right
HL_JoystickMoveDirX_Le        = $22                         ; 
HL_JoystickMoveDirX_Ri        = $2a                         ; 
HL_JoystickShoot_Le           = $1e                         ; 
HL_JoystickShoot_Ri           = $26                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
; sound
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $133d
HL_Volume                   = GameVars                      ; 
HL_Volume_Off                 = $00                         ; 
HL_Volume_Max                 = $ff                         ; 
                              GameVars += 1                 ; $133e
HL_TuneDeath                = GameVars                      ; 
HL_TuneDeath_None             = $00                         ; 
HL_TuneDeath_Step             = $04                         ; 
HL_TuneDeath_Ini              = $38                         ; 
                              GameVars += 1                 ; $133f
HL_TuneShoot                = GameVars                      ; 
HL_TuneShoot_Start            = $00                         ; 
HL_TuneShoot_Step             = $20                         ; 
                              GameVars += 1                 ; $1340
HL_TuneBeepFall             = GameVars                      ; 
HL_TuneBeepFall_Start         = $53                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1341
HL_TuneToPlayOff            = GameVars                      ;        offset tune to play
                              GameVars += 1                 ; $1342
HL_TuneFreeBufferPosOff     = GameVars                      ;        in Bufs
                              GameVars += 1                 ; $1343
HL_GoldJingleBeamLimit      = GameVars                      ; 
                              GameVars += 1                 ; $1344
HL_JingleNum                = GameVars                      ; 
                              GameVars += 1                 ; $1345
HL_JingleHeight             = GameVars                      ; 
                              GameVars += 1                 ; $1346
HL_GoldJingleRndSeed        = GameVars                      ; 
                              GameVars += 1                 ; $1347
HL_GoldJingleBeamPos        = GameVars                      ; 
                              GameVars += 1                 ; $1348
HL_WaveVoice2               = GameVars                      ; 
                              GameVars += 1                 ; $1349
HL_WaveVoice3               = GameVars                      ; 
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $134a
HL_DemoRec                  = GameVars                      ;        flag: demo recording mode                  .hbu034.
HL_DemoRec_On                 = $80                         ;                                                   .hbu034.
HL_DemoRec_Off                = $00                         ;                                                   .hbu034.
                              GameVars += 1                 ; $134b
HL_DemoRecReplay            = GameVars                      ;        flag: demo replay mode                     .hbu034.
HL_DemoRecReplay_Yes          = $80                         ;                                                   .hbu034.
HL_DemoRecReplay_No           = $00                         ;                                                   .hbu034.
                              GameVars += 1                 ; $134c
HL_LevelTest                = GameVars                      ;        level test mode                            .hbu023.
HL_LevelTest_Off              = $00                         ;                                                   .hbu023.
HL_LevelTest_On               = $80                         ;                                                   .hbu023.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $134d
HL_XmitLevelNum             = GameVars                      ;        number target level drive 9 for xmit       .hbu022.
                              GameVars += 1                 ; $134e
HL_MirrorByteDisk           = GameVars                      ;        byte from disk for mirroring               .hbu017.
                              GameVars += 1                 ; $134f
HL_MirrorSwapCount          = GameVars                      ;                                                   .hbu017.
                              GameVars += 1                 ; $1350
HL_MirrorRowCount           = GameVars                      ;                                                   .hbu017.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1351
HL_BufRndRemainNumOff       = GameVars                      ;        maximum random number possible             .hbu021.
                              GameVars += 1                 ; $1352
HL_BufRndLevelNumOff        = GameVars                      ;        offset generated random number table       .hbu021.
                              GameVars += 1                 ; $1353
HL_RND_NumSave              = GameVars                      ;        generated random number                    .hbu021.
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1354
HL_Timer_LevelNumDiskSave   = GameVars                      ;        save the calculated timer block number     .hbu028.
                              GameVars += 1                 ; $1355
HL_Timer_LevelBlockOff      = GameVars                      ;        save the level time offset in timer block  .hbu028.
                              GameVars += 1                 ; $1356
HL_Timer_ModeSave           = GameVars                      ;        save the disc access mode flag             .hbu028.
; ------------------------------------------------------------------------------------------------------------- ;
; misc
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1357
HL_LastLevelPassed          = GameVars                      ;        flag: all 250 levels solved                .hbu0041.
HL_LastLevelPassed_Yes        = $80                         ;                                                   .hbu0041.
HL_LastLevelPassed_No         = $00                         ;                                                   .hbu0041.
                              GameVars += 1                 ; $1358
HL_ScoreShown               = GameVars                      ;        flag: avoid leaderboard redisplay          .hbu040.
HL_ScoreShown_Yes             = $01                         ;        leaderboard is displayed already           .hbu040.
HL_ScoreShown_No              = $00                         ;                                                   .hbu040.
                              GameVars += 1                 ; $1359
HL_MoveLevelNumSource       = GameVars                      ;                                                   .hbu017.
                              GameVars += 1                 ; $135a
HL_MoveLevelNumTarget       = GameVars                      ;                                                   .hbu017.
                              GameVars += 1                 ; $134b
HL_DiscCmdDriveNum          = GameVars                      ;                                                   .hbu001.
                              GameVars += 1                 ; $135c
HL_ScreenRowSave            = GameVars                      ;        save actual screen pos                     .hbu009.
                              GameVars += 1                 ; $135d
HL_ScreenColSave            = GameVars                      ;                                                   .hbu009.
                              GameVars += 1                 ; $135e
HL_ImageColType             = GameVars                      ;        image column type num $00-$03
                              GameVars += 1                 ; $135f
HL_ColorLevel               = GameVars                      ;                                                   .hbu011.
                              GameVars += 1                 ; $1360
HL_ColorColorRam            = GameVars                      ;                                                   .hbu011.
                              GameVars += 1                 ; $1361
HL_ColorStatus              = GameVars                      ;                                                   .hbu011.
                              GameVars += 1                 ; $1362
HL_ColorStatusMsg           = GameVars                      ;                                                   .hbu011.
                              GameVars += 1                 ; $1363
HL_ColorTimerMsg            = GameVars                      ;                                                   .hbu011.
                              GameVars += 1                 ; $1364
HL_OutToScreenPrep          = GameVars                      ;        flag: copy data to prepare hires screen
HL_OutToScreenPrep_Yes        = $00                         ;               data needs a copy
HL_OutToScreenPrep_No         = $01                         ; 
                              GameVars += 1                 ; $1365
HL_TempWork                 = GameVars                      ;        store for temporary values                 .hbu022.
; ------------------------------------------------------------------------------------------------------------- ;
; input buffer work vars
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars += 1                 ; $1366
HL_InputBufferMaxLen        = GameVars                      ;                                                   .hbu012.
                              GameVars += 1                 ; $1367
HL_InputBufferPos           = GameVars                      ;        current input buffer position              .hbu012.
                              GameVars += 1                 ; $1368
; ------------------------------------------------------------------------------------------------------------- ;
; still free                                                ; $1368 - $136f
; ------------------------------------------------------------------------------------------------------------- ;
; input buffer of $10 bytes - at end of var area
; ------------------------------------------------------------------------------------------------------------- ;
                              GameVars := $1370             ; $1370 - $137f
HL_InputBuffer              = GameVars                      ;                                                   .hbu009.
HL_InputBuffer_Len            = HL_LevelDataBufMsgTxt_Len   ;         $0f - from Level Data Block Layout        .hbu009.
; ------------------------------------------------------------------------------------------------------------- ;
; Dynamic Value Tables (enemies/open holes)
; ------------------------------------------------------------------------------------------------------------- ;
; Save Area Enemies - $1380-$13b7 = $38
; ------------------------------------------------------------------------------------------------------------- ;
HL_SA_Enemy                 = HL_MemGameVars + $80                     ;                                        .hbu037. moved
HL_SA_EnemyBlock_Len          = $08                                    ;         max number of enemies          .hbu037. moved
HL_SA_EnemyCol              = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $00 ; $1380 - col actual enemy               .hbu037. moved
HL_SA_EnemyRow              = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $01 ; $1388 - row actual enemy               .hbu037. moved
HL_SA_EnemyHoleGoldTime     = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $02 ; $1390 - either has gold or in a hole   .hbu037. moved
HL_SA_EnemyHoleGoldTime_Ini   = $7f                                    ;         initial value                  .hbu037. moved
HL_SA_EnemyPosOnImgPosX     = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $03 ; $1398 - pos on image le/ri             .hbu037. moved
HL_SA_EnemyPosOnImgPosY     = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $04 ; $13a0 - pos on image up/do             .hbu037. moved
HL_SA_EnemySprtNum          = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $05 ; $13a8 - sprite number                  .hbu037. moved
HL_SA_EnemyViewDir          = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $06 ; $13b0 - sprite move direction          .hbu037. moved
; ------------------------------------------------------------------------------------------------------------- ;
; Work Area Enemies - $13b8-$13bf = $08
; ------------------------------------------------------------------------------------------------------------- ;
HL_WA_EnemyBirthTime        = HL_SA_Enemy + HL_SA_EnemyBlock_Len * $07 ; $13b8 - actual enemy rebirth step      .hbu037. moved
HL_WA_EnemyBirth_Len          = $05                                    ;         max 6 entries ($00-$05)        .hbu037. moved
HL_WA_EnemyBirthStep_Ini      = $16                                    ;         initial value                  .hbu037. moved
HL_WA_EnemyBirthStep_01       = $13                                    ;         1st enemy rebirth mark         .hbu037. moved
HL_WA_EnemyBirthStep_02       = $0a                                    ;         2nd enemy rebirth mark         .hbu037. moved
; ------------------------------------------------------------------------------------------------------------- ;
; Work Area Open Holes - $13c0-$13ff = $40
; ------------------------------------------------------------------------------------------------------------- ;
HL_WA_Hole                  = HL_MemGameVars + $c0                     ; $13c0 - open holes                     .hbu037. 
HL_WA_HoleBlock_Len           = $10                                    ;         max number of open holes       .hbu037. 
HL_WA_HoleMax                 = $0f                                    ;         max number of digged holes     .hbu037. 
HL_WA_HoleCol               = HL_WA_Hole + HL_WA_HoleBlock_Len * $00   ; $13c0 - open holes col                 .hbu037. shortened to $10
HL_WA_HoleRow               = HL_WA_Hole + HL_WA_HoleBlock_Len * $01   ; $13d0 - open holes row                 .hbu037. shortened to $10
HL_WA_HoleOpenTime          = HL_WA_Hole + HL_WA_HoleBlock_Len * $02   ; $13e0 - open holes reaminig open time  .hbu037. shortened to $10
;HL_WA_HoleOpenTime_Ini       = $b4                                    ;         initial value                  .hbu037.hbu042. removed
HL_WA_HoleOpenTime_Ini        = $d4                                    ;         initial value                  .hbu037.hbu042.
HL_WA_HoleOpenTimeStep_01     = $14                                    ;         1st mark to close the hole     .hbu037. 
HL_WA_HoleOpenTimeStep_02     = $0a                                    ;         2nd mark to close the hole     .hbu037. 
; ------------------------------------------------------------------------------------------------------------- ;
; Start Grafic - $1400
; ------------------------------------------------------------------------------------------------------------- ;
HL_StartGfxData             = HL_MemStartGfxData            ; start gfx compressed input data
HL_StartGfxDataPtrOff_Lo      = $01                         ; offset to data pointer LO
HL_StartGfxDataPtrOff_Hi      = $02                         ; offset to data pointer HI

HL_StartGfxDataPtr_Len        = $02                         ; length of pointer pair
; ------------------------------------------------------------------------------------------------------------- ;
; Hires Display Screen - $2000-$3fff
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScreenGfxDisplay         = HL_MemScreenGfxDisplay        ; 
HL_ScreenGfxDisplayEnd      = HL_ScreenGfxDisplay   + $1fff ; end of gfx screen display
; ------------------------------------------------------------------------------------------------------------- ;
; Status Separator Row in Hires Display Screen
; ------------------------------------------------------------------------------------------------------------- ;
HL_StatusRowNumber          = HL_ScreenRows_Max + $01       ; status starts directly beyond the last level row
; ------------------------------------------------------------------------------------------------------------- ;
HL_StatusRowSepDisp         = HL_ScreenGfxDisplay   + $1b90 ; 
HL_StatusRowSepDisp_Le_00     = HL_StatusRowSepDisp + $0000 ; left start
HL_StatusRowSepDisp_Le_01     = HL_StatusRowSepDisp + $0001 ; 
HL_StatusRowSepDisp_Le_02     = HL_StatusRowSepDisp + $0002 ; 
HL_StatusRowSepDisp_Le_03     = HL_StatusRowSepDisp + $0003 ; 
                              
HL_StatusRowSepDisp_Mi_00     = HL_StatusRowSepDisp + $0008 ; middle part
                              
HL_StatusRowSepDisp_Ri_00     = HL_StatusRowSepDisp + $0118 ; right end
HL_StatusRowSepDisp_Ri_01     = HL_StatusRowSepDisp + $0119 ; 
HL_StatusRowSepDisp_Ri_02     = HL_StatusRowSepDisp + $011a ; 
HL_StatusRowSepDisp_Ri_03     = HL_StatusRowSepDisp + $011b ; 
; ------------------------------------------------------------------------------------------------------------- ;
; Hires Prepare Screen - $4000-$5fff
; ------------------------------------------------------------------------------------------------------------- ;
HL_ScreenGfxPrepare         = HL_MemScreenGfxPrepare        ; 
HL_ScreenGfxPrepareEnd      = HL_ScreenGfxPrepare   + $1fff ; end of gfx prepare area
; ------------------------------------------------------------------------------------------------------------- ;
; Status Separator Row in Hires Preparation Screen
; ------------------------------------------------------------------------------------------------------------- ;
HL_StatusRowSepPrep         = HL_ScreenGfxPrepare   + $1b90 ; left start
HL_StatusRowSepPrep_Le_00     = HL_StatusRowSepPrep + $0000 ; 
HL_StatusRowSepPrep_Le_01     = HL_StatusRowSepPrep + $0001 ; 
HL_StatusRowSepPrep_Le_02     = HL_StatusRowSepPrep + $0002 ; 
HL_StatusRowSepPrep_Le_03     = HL_StatusRowSepPrep + $0003 ; 
                              
HL_StatusRowSepPrep_Mi_00     = HL_StatusRowSepPrep + $0008 ; middle part
                              
HL_StatusRowSepPrep_Ri_00     = HL_StatusRowSepPrep + $0118 ; right end
HL_StatusRowSepPrep_Ri_01     = HL_StatusRowSepPrep + $0119 ; 
HL_StatusRowSepPrep_Ri_02     = HL_StatusRowSepPrep + $011a ; 
HL_StatusRowSepPrep_Ri_03     = HL_StatusRowSepPrep + $011b ; 
; ------------------------------------------------------------------------------------------------------------- ;
; Jingle Data Areas
; ------------------------------------------------------------------------------------------------------------- ;
HL_TunePlayTime             = HL_MemTunePlayTime            ; tune times
HL_TuneDataPtrVoice2        = HL_MemTuneDataPtrVoice2       ; tune data pointer voice 2
HL_TuneDataPtrVoice3        = HL_MemTuneDataPtrVoice3       ; tune data pointer voice 3
HL_TuneSuReVol              = HL_MemTuneSuReVol             ; tune s/r/volume
; ------------------------------------------------------------------------------------------------------------- ;
HL_ImageAdr_Lo              = HL_MemImageAdr_Lo             ; table: image address low  byte                    .hbu000.
HL_ImageAdr_Hi              = HL_MemImageAdr_Hi             ; table: image address high byte                    .hbu000.
; ------------------------------------------------------------------------------------------------------------- ;
; Work Area Exit Ladders
; ------------------------------------------------------------------------------------------------------------- ;
HL_WA_ExitLadder            = HL_MemHiddenLadders           ; hidden ladders                                    .hbu030.
HL_WA_ExitLadderRow         = HL_WA_ExitLadder              ; hidden ladder rows                                .hbu030.
HL_WA_ExitLadderCol         = HL_WA_ExitLadder + $80        ; hidden ladder cols                                .hbu030.
HL_WA_ExitLadder_Max          = HL_WA_ExitLadderCol - HL_WA_ExitLadderRow ; $80 - max number of hidden ladders  .hbu030.
; ------------------------------------------------------------------------------------------------------------- ;
; buffer: score work
; ------------------------------------------------------------------------------------------------------------- ;
HL_BufScoreWork             = HL_MemBufScoreWork            ; 
HL_BufScoreWorkNew          = HL_MemBufScoreWorkNew         ; 
; ------------------------------------------------------------------------------------------------------------- ;
; buffer: random mode level numbers
; ------------------------------------------------------------------------------------------------------------- ;
HL_BufRndRemainNum          = HL_MemBufRndRemainNum         ; non selected level numbers for rnd num generation .hbu021.
; ------------------------------------------------------------------------------------------------------------- ;
; demo move recording - max $280 - no overflow check - move $281 (641) starts to overwrite the i/o area at $d000
; ------------------------------------------------------------------------------------------------------------- ;
HL_BufDemoMoves             = HL_MemBufDemoMoves            ; buffer: loderunner demo move recording            .hbu034.
; ------------------------------------------------------------------------------------------------------------- ;
; swap two disk levels
; ------------------------------------------------------------------------------------------------------------- ;
HL_BufSwapWork              = HL_MemBufSwapWork             ; temp store for swap level data                    .hbu017.
; ------------------------------------------------------------------------------------------------------------- ;
; edit level data rotation
; ------------------------------------------------------------------------------------------------------------- ;
HL_BufRotateLevelData_01    = HL_MemBuf + $000              ; work buffers for level data rotation              .hbu036.
HL_BufRotateLevelData_02    = HL_MemBuf + $100              ;                                                   .hbu036.
; ------------------------------------------------------------------------------------------------------------- ;
