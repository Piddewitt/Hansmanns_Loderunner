; ------------------------------------------------------------------------------------------------------------- ;
; Hansmanns Lode Runner - Zero Page Equates
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_LodeRuCol               = $03                           ;       loderunner actual col on level ctrl data
HLZ_LodeRuRow               = $04                           ;       loderunner actual row on level ctrl data
HLZ_LodeRuOnImgPosX         = $05                           ;       loderunner pos on image left/right
HLZ_LodeRuOnImgPosX_Min       = $00                         ; 
HLZ_LodeRuOnImgPosX_Mid       = $02                         ;       loderunner pos on image left/right - $02=center
HLZ_LodeRuOnImgPosX_Max       = $04                         ; 
HLZ_LodeRuOnImgPosY         = $06                           ;       loderunner pos on image up/down
HLZ_LodeRuOnImgPosY_Min       = $00                         ; 
HLZ_LodeRuOnImgPosY_Mid       = $02                         ;       loderunner pos on image up/down    - $02=center
HLZ_LodeRuOnImgPosY_Max       = $04                         ; 
HLZ_LodeRuSprtNum           = $07                           ;       loderunner sprite number
HLZ_LodeRuShootMode         = $08                           ; 
HLZ_LodeRuShootMode_Back      = $01                         ;       loderunner shoots against view direction
HLZ_LodeRuShootMode_Front     = $ff                         ;       loderunner shoots in view direction
; ------------------------------------------------------------------------------------------------------------- ;
; pointers
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_LevelDataGamePtrRow     = $09                           ; ptr:  expanded level data rows $0800-$09c3
HLZ_LevelDataGamePtrRow_Lo    = $09                         ;       in game modified with lr/enemy/hole tiles
HLZ_LevelDataGamePtrRow_Hi    = $0a                         ; 
                            
HLZ_LevelDataCtrlPtrRow     = $0b                           ; ptr:  expanded level data rows $0a00-$0bc3
HLZ_LevelDataCtrlPtrRow_Lo    = $0b                         ;       original level structure without lr/enemy/hole tiles
HLZ_LevelDataCtrlPtrRow_Hi    = $0c                         ; 
                            
HLZ_StartGfxDisplay         = $0d                           ; ptr:  start screen gfx ouput
HLZ_StartGfxDisplay_Lo        = $0d                         ; 
HLZ_StartGfxDisplay_Hi        = $0e                         ; 
                            
HLZ_ImageDataOffPtr         = $0d                           ; ptr:  image data offsets
HLZ_ImageDataOffPtr_Lo        = $0d                         ; 
HLZ_ImageDataOffPtr_Hi        = $0e                         ; 
                            
HLZ_SignRowNumberTabPtr     = $0d                           ; ptr:  image game over singn data offsets
HLZ_SignRowNumberTabPtr_Lo    = $0d                         ; 
HLZ_SignRowNumberTabPtr_Hi    = $0e                         ; 
                            
HLZ_ScoreColorScreenPtr     = $0d                           ; ptr:  multi color screen for high score display           .hbu015.
HLZ_ScoreColorScreenPtr_Lo    = $0d                         ; 
HLZ_ScoreColorScreenPtr_Hi    = $0e                         ; 
                            
HLZ_WorkBufPtr              = $0f                           ; ptr:  work buffer pointer for level data column shift     .hbu036.
HLZ_WorkBufPtr_Lo             = $0f                         ; 
HLZ_WorkBufPtr_Hi             = $10                         ; 
                            
HLZ_ScreenGfxPtr            = $0f                           ; ptr:  copy graphic data start address
HLZ_ScreenGfxPtr_Lo           = $0f                         ; 
HLZ_ScreenGfxPtr_Hi           = $10                         ; 
                            
HLZ_ScreenGfxDisplayPtr     = $0f                           ; ptr:  hires display graphic prepare screen        .hbu034.
HLZ_ScreenRowDisplayPtr_Lo    = $0f                         ;                                                   .hbu034.
HLZ_ScreenRowDisplayPtr_Hi    = $10                         ;                                                   .hbu034.
                            
HLZ_ScreenRowPreparePtr     = $11                           ; ptr:  hires display graphic display screen
HLZ_ScreenRowPreparePtr_Lo    = $11                         ; 
HLZ_ScreenRowPreparePtr_Hi    = $12                         ; 
                            
HLZ_InputTextOutPtr         = $13                           ; ptr:  to $00 delimited text output string
HLZ_InputTextOutPtr_Lo        = $13                         ; 
HLZ_InputTextOutPtr_Hi        = $14                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_EnemyCol                = $15                           ;       actual enemy col on level ctrl data
HLZ_EnemyRow                = $16                           ;       actual enemy row on level ctrl data
HLZ_EnemySprtNum            = $17                           ;       actual enemy sprite number
HLZ_EnemyViewDir            = $18                           ;       actual enemy dir right/left  $ff=left  $01=right
HLZ_EnemyViewDir_None         = $00                         ; 
HLZ_EnemyViewDir_Ri           = $01                         ; 
HLZ_EnemyViewDir_Le           = $ff                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
; if negative: enemy has gold       - timer is counted up   to $00
; if positive: enemy sits in a hole - timer is counted down to $00
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_EnemyHoleGoldTime       = $19                           ;       time in hole / time carry gold
HLZ_EnemyHoleGoldTime_None    = $00                         ;       time in hole / time carry gold exhausted
HLZ_EnemyHoleGoldTime_Shake   = $0d                         ;       in hole time - start to shiver if lower
HLZ_EnemyHoleGoldTime_Shake_X = $07                         ;       in hole time - get out of hole if lower
HLZ_EnemyHoleGoldTime_Ini     = $ff                         ;       gold timer start value - randomized by HL_EnemyBirthCol
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_EnemyOnImgPosX          = $1a                           ;       actual enemy pos on image left/right
HLZ_EnemyOnImgPosX_Min        = $00                         ; 
HLZ_EnemyOnImgPosX_Mid        = $02                         ;       enemy pos on image left/right - $02=center
HLZ_EnemyOnImgPosX_Max        = $04                         ; 
HLZ_EnemyOnImgPosY          = $1b                           ;       actual enemy pos on image up/down
HLZ_EnemyOnImgPosY_Min        = $00                         ; 
HLZ_EnemyOnImgPosY_Mid        = $02                         ;       enemy pos on image up/down - $02=center
HLZ_EnemyOnImgPosY_Max        = $04                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_SaveGameDataOff         = $1c                           ;                                                           .hbu099.
HLZ_SaveGameDataNameLen     = $1d                           ;                                                           .hbu099.
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_WorkMsgBufferCheck      = $1e                           ; work: check for a blank message buffer                    .hbu007.
HLZ_WorkStartGfxDataCount   = $1e                           ; work: start grafic output data counter/offset
HLZ_WorkGameOverParmTabOff  = $1e                           ; work: offse game over sign row number parm table
HLZ_WorkJoystickMove        = $1e                           ; work: save CIA register value for joysick move checks
HLZ_WorkDiskRC              = $1e                           ; work: disk operation return code
HLZ_WorkEnemyParmSave       = $1e                           ; work: save enemy row/col for subtraction
HLZ_WorkLevelDataPartCtrl   = $1e                           ; work: flag left or right nibble disk data byte procecssing
HLZ_WorkCopyProtTabOff      = $1e                           ; work: offset to copy protection value table
HLZ_WorkImageDataAdr_Lo     = $1e                           ; work: image data address LO
HLZ_WorkImageDataAdr_Hi     = $1f                           ; work: image data address HI
HLZ_WorkHiresRowStartAdr_Lo = $1e                           ; work: hires row address LO
HLZ_WorkHiresRowStartAdr_Hi = $1f                           ; work: hires row address HI
HLZ_WorkStartGfxData        = $1f                           ; work: start grafic output data byte
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_ScreenSpinColOff        = $20                           ;       game over sign column position
HLZ_ScreenSpinColOff_Left     = $70                         ;       game over sign start column
HLZ_ScreenGfxRowPosY        = $20                           ;       grafic screen row column offset
HLZ_EnemyMoveMaxRow         = $20                           ; work: actual row for scan enemy move col max left/right
HLZ_WorkSpritePosX          = $21                           ; work: gfx screen PosX
HLZ_ImageHeight             = $22                           ;       image height
HLZ_ImageHeight_Max           = HL_ImageHeight              ;       $0b
HLZ_WorkScoreEntryLen       = $22                           ; work: score buffer entry length
HLZ_WorkKeyNew              = $23                           ; work: new input key check
HLZ_ImageNumber             = $23                           ;       image number $00-$67 ($66/$67 unnused)
HLZ_WorkImgOffsetPosX       = $23                           ; work: save immage offset
HLZ_WorkImageNumber         = $23                           ;       image number
HLZ_ImageOutputScreen       = $24                           ;       target output screen $20=$2000 $40=$4000
HLZ_WorkChkDiskIdResult     = $25                           ; 
HLZ_GfxImageClearLeft       = $25                           ;       prepare screen image byte for insertion of the buffer image byte
HLZ_GfxImageClearRight      = $26                           ;       prepare screen image byte for insertion of the buffer image byte
HLZ_LodeRuEnemyCollision    = $27                           ;       loderunner-enemy sprite collision value
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_EnemyMoveColStart       = $28                           ; work  fix enemy move start col
HLZ_EnemyMoveRowStart       = $29                           ; work: fix enemy move start row
HLZ_EnemyMoveLodeRuColGap   = $2a                           ;       scan gap between enemy and loderunner if both are on same row
HLZ_EnemyMoveDir            = $2b                           ;       actual enemy move direction
HLZ_EnemyMoveDir_Ini          = $00                         ;       
HLZ_EnemyMoveDir_Le           = $01                         ;       left
HLZ_EnemyMoveDir_Up           = $02                         ;       up
HLZ_EnemyMoveDir_Ri           = $03                         ;       right
HLZ_EnemyMoveDir_Do           = $04                         ;       down 
HLZ_EnemyMoveDistMin        = $2c                           ; work: enemy move target max distance
HLZ_EnemyMoveDistMin_Ini      = $ff                         ;       init to maximum
HLZ_EnemyMoveMaxCol_Le      = $2d                           ;       maximum move enemy left if no obstacles in the way
HLZ_EnemyMoveMaxCol_Ri      = $2e                           ;       maximum move enemy right if no obstacles in the way
HLZ_EnemyMoveScanRowMax     = $2f                           ; work: save max enemy move scan row found 
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_SfxScoreSub             = $2f                           ;       add score tune subtraction value
HLZ_SfxScoreSub_Base          = $40                         ;       add score tune
HLZ_SfxScoreSub_Start         = HL_Score_FinishLevel / 100 - $01 ;  score sub start value - each dec scores 100 points
HLZ_EnemyMoveScanCol        = $30                           ;       enemy move scan row
HLZ_EnemyMoveScanRow        = $31                           ;       enemy move scan col
HLZ_EnemyMoveCycle          = $0032                         ;       enemy move cycles tab
HLZ_EnemyMoveCycle_01         = $32                         ;       enemy move cycles tab value 1
HLZ_EnemyMoveCycle_02         = $33                         ;       enemy move cycles tab value 2
HLZ_EnemyMoveCycle_03         = $34                         ;       enemy move cycles tab value 3
HLZ_EnemyMoveCycleWork      = $35                           ;       enemy move work value
HLZ_EnemyMoveCycleOff       = $36                           ;       enemy move pointer actual cycles ($32-$34)
HLZ_EnemyMoveCycleOff_Min     = $00                         ; 
HLZ_EnemyMoveCycleOff_Max     = HLZ_EnemyMoveCycle_03 - HLZ_EnemyMoveCycle + $01 ; $03
HLZ_WorkScoreNewEntryNum    = $39                           ; work: save number of new leaderboard entry
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_ScoreBoardRank          = $3a                           ; work: rank number of the high score list
HLZ_ScoreBoardOff           = $3b                           ; work: score board offset
HLZ_ScoreBoardIdLen         = $3c                           ; work: score board id length
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_ScreenGfxPartPosY       = $41                           ;       image y-position part number  (bits 0-1 of HLZ_ScreenCol substitution)
HLZ_BirthColorRowPtr        = $42                           ; ptr:  recolor enemy rebirth screen row                    .hbu007.
HLZ_BirthColorRowPtr_Lo       = $42                         ;                                                           .hbu007.  
HLZ_BirthColorRowPtr_Hi       = $43                         ;                                                           .hbu007.
HLZ_BirthColorRowCount      = $46                           ;       number of rows to be colored                        .hbu007.
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_ScreenCol               = $4f                           ;       screen col  (00-1b)
HLZ_ScreenCol_Min             = $00                         ; 
HLZ_ScreenCol_Status_Score    = $05                         ;       column offset for score output in status line
HLZ_ScreenCol_Status_Lives    = $10                         ;       column offset for lives output in status line
HLZ_ScreenCol_Status_Level    = $19                         ;       column offset for level output in status line
HLZ_ScreenCol_Max             = $1b                         ; 
HLZ_ScreenRow               = $50                           ;       screen row  (00-0f)
HLZ_ScreenRow_Min             = $00                         ; 
HLZ_ScreenRow_Max             = $0f                         ; 
HLZ_ScreenRow_BED_Input_Min   = $00                         ;       min screen row for board editor commands
HLZ_ScreenRow_BED_Input_Max   = $09                         ;       max screen row for board editor commands
HLZ_ScreenRow_Status_Sep      = $10                         ;       status row number separator line
HLZ_ScreenRow_Spin            = $50                         ;       screen row game over sign
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_WaitForDemoCounter      = $50                           ;       wait for demo counter
HLZ_TargetGfxOutput         = $51                           ;       target output indicator -  $20=$2000 $40=$4000
HLZ_HoleOpenTimeTabOff      = $52                           ;       offset open hole time table
HLZ_LevelDiskDataOff        = $53                           ;       offset into packed level data loaded from disk
HLZ_ShootStepCtrl           = $54                           ;       loderunner shoot step image table offset
HLZ_ShootStepCtrl_Switch_Le   = $06                         ;       
HLZ_ShootStepCtrl_Switch_Ri   = $12                         ;       
HLZ_DemoMoveDataPtr         = $55                           ; ptr:  Demo move data table
HLZ_DemoMoveDataPtr_Lo        = $55                         ; 
HLZ_DemoMoveDataPtr_Hi        = $56                         ; 
HLZ_DemoMoveType            = $57                           ;       type of demo move (l/r/u/d/fire)
HLZ_DemoMoveDuration        = $58                           ;       duration demo move
                            
;HLZ_DemoNoFunction         = $59                           ; flag: used but has no function                    .hbu001. removed
                            
HLZ_LevelModified           = $5a                           ; flag: level editor modification
HLZ_LevelModified_No          = $01                         ;       
HLZ_LevelModified_Yes         = $00                         ;       
; ------------------------------------------------------------------------------------------------------------- ;
; image buffer containing the generated image bytes
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_ImageBuffer_Long        = $005b                         ; buf:  generated image bytes - $5b-$7b (HLZ_ImageBuffer - HLZ_ImageBuffer_Len)
HLZ_ImageBuffer             = $5b                           ; 
HLZ_ImageBufferRowPos_01      = $5b                         ; 
HLZ_ImageBufferRowPos_02      = $5c                         ; 
HLZ_ImageBufferRowPos_03      = $5d                         ; 
HLZ_ImageBuffer_Len = HL_ImageHeight * $03                  ;       image buffer length ($03 bytes for each $0b image rows)
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_TuneValueVoice_01       = $7c                           ;       tune value voice 1
HLZ_JingleDataPtr           = $7d                           ; ptr:  jingle Data
HLZ_JingleDataPtr_Lo          = $7d                         ; 
HLZ_JingleDataPtr_Hi          = $7e                         ; 
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_Unused_7f               = $7f                           ;       <not used>
; ------------------------------------------------------------------------------------------------------------- ;
; demo move recorder
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_RecordDemoTime          = $80                           ;                                                   .hbu034.
HLZ_RecordDemoMove          = $81                           ;                                                   .hbu034.
HLZ_RecordDemoMoveOld       = $82                           ;                                                   .hbu034.
HLZ_RecordDemoMoveBufOff    = $83                           ;                                                   .hbu034.
; ------------------------------------------------------------------------------------------------------------- ;
HLZ_DemoMoveBufferPtr       = $84                           ; ptr:  demo move recording buffer                  .hbu034.
HLZ_DemoMoveBufferPtr_Lo      = $84                         ;                                                   .hbu034.
HLZ_DemoMoveBufferPtr_Hi      = $85                         ;                                                   .hbu034.
; ------------------------------------------------------------------------------------------------------------- ;
