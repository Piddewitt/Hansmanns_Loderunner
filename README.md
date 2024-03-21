# Hansmanns Loderunner
Modified Loderunner Game with some of new features to experiment with.
## Directory location
- **dox**
- **npp**
- **C64**
  - **tools**
    - **64tass**
    - **DisAsm**
  - **asm**
    - **Projects**
      - **file:** `Lode Runner.xml`
      - **data**
        - **inc**
        - **originals**
        - **mods**
          - `Hansmanns Lode Runner`
##
## New Start Game Commands
- **S** - Save a game in progress (Available only directly before the play has started)
- **D** - Toggle the demo move recorder (Beep + Grey Border)
  - **Usage**
    - Select the desired demo level
    - Press **D** to start the recording (Beep + Grey Border)
    - Play the level to record the moves. Only $ff tick are possible for each move. Especially if you need to wait longer try to change the Lode Runner view direction to restart at tick $00 again
    - There will be no buffer overflow check! The game will crash if more than $280 (640) moves are recorded (Overflow into the I/O area)
  - Auto Replay of the Recording (Beep + Dark Grey Border)
    - After a successful level completion
    - After getting caught by an enemy
    - After an **R** command
    - After an **A** command
  - End Replay Mode (Beep + Black Border)
    - Stop the replay by pressing FIRE or any KEY
    - Getting caught by an enemy
  - Take Over the recorded demo moves and level
    - Copy and adapt the moves data from the HL_MemBufDemoMoves buffer to its desired TabDemoMoves location
    - Copy level data from HL_LevelDataBuf to its desired TabDemoDataLevel location
    - Re-assemble the code
## New In Game Commands
- **P** - Play previous level
- **V** - Toggle game mirror mode
- **Z** - Toggle game random level mode. This restarts the game from Level One
- **Q** - Return from test to editor
- **L** - Load and Play a saved game
  - **Special**
    - Debug Mode (Championship Loderunner style)
      - Activation
        - Start playing a level
        - Press RUN/STOP to pause the game
        - Press F7 to toggle debug mode (Beep + Light Grey Border)
        - Press RUN/STOP to continue the game
      - Debug Mode commands
        - **G** - Collect all the missing gold
        - **S** - Score 1075 points
        - **L** - Discount number of lives down to 1
        - Commands **U**/**P**/**F**/**G** do not set the cheat flag anymore
## New Board Editor Commands
- **x** - Swap two levels
- **s** - Show high score
- **I** - Init the disk level data/disk high score data/disk time data
- **C** - Clear a disk level
- **T** - Clear the level best time blocks on disk
- **S** - Clear the save games block on disk
- **L** - Clear the leaderboard block on disk
## New Level Editor Commands
- **l** - Additional move edit cursor right
- **t** - Edit the level success message
- **T** - Test the level from edit
- **A** - Reload the level
- **U** - Forward a level
- **P** - Backward a level
- **V** - Mirror the level
- **C** - Clear  the level
- **I** - Rotate the level a row up
- **M** - Rotate the level a row down
- **J** - Rotate the level a column left
- **K** - Rotate the level a column right
- **L** - Rotate the level a column right
- **cursor l/r/u/d** - Allow cursor keys for edit movement (For Emulator usage)
## Special
  - **X** - Toggle xmit mode
    - Copy the actual level from disk #8 to a selected level on disk #9
    - **Preparation**
      - A disk in drive #9 must be available
    - **Xmit Mode commands**
    - **x** - xmit the actual level
      - The target level number is automatically increased
      - The xmit mode is switched off automatically after each xmit
    - **+** - Set next target xmit level (**SHIFT+** - Add 10)
    - **-** - Set previous target xmit level (**SHIFT-** - Subtract 10)
##
