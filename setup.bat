@echo off
icacls * /reset /t /c /q 
cls


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: START OF SCRIPT :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Start
set Error=B
:: variables are declared

set /p user_input=Do you play rocket league on A.Steam or B.Epic Games (Enter A or B): 
:: ask user if they play on steam or epic

if /i %user_input%==A goto Steam
:: if user input is A, then user is sent to :Steam

if /i %user_input%==B (goto Epic) else (goto Invalid)
:: if user input is B, then user is sent to :Epic
:: if user input is not A or B, then user is sent to :Invalid then back to :Start

:batchwrite
:: copy map files into CookedPCConsole\

copy maps\movinggoals_diamond.upk "%RLfolder%\TAGame\CookedPCConsole\movinggoals_diamond.upk"
copy maps\movinggoals_diamond_b.upk "%RLfolder%\TAGame\CookedPCConsole\movinggoals_diamond_b.upk"
copy maps\movinggoals_solid_walls.upk "%RLfolder%\TAGame\CookedPCConsole\movinggoals_solid_walls.upk"
copy maps\movinggoals_star.upk "%RLfolder%\TAGame\CookedPCConsole\movinggoals_star.upk"
copy maps\movinggoals_star_b.upk "%RLfolder%\TAGame\CookedPCConsole\movinggoals_star_b.upk"
copy maps\movinggoals_triangle.upk "%RLfolder%\TAGame\CookedPCConsole\movinggoals_triangle.upk"
copy maps\movinggoals_triangle_b.upk "%RLfolder%\TAGame\CookedPCConsole\movinggoals_triangle_b.upk"


:: create Uninstaller
echo del "%RLfolder%\TAGame\CookedPCConsole\movinggoals_diamond.upk" > uninstall_%platform%.bat
echo del "%RLfolder%\TAGame\CookedPCConsole\movinggoals_diamond_b.upk" >> uninstall_%platform%.bat
echo del "%RLfolder%\TAGame\CookedPCConsole\movinggoals_solid_walls.upk" >> uninstall_%platform%.bat
echo del "%RLfolder%\TAGame\CookedPCConsole\movinggoals_star.upk" >> uninstall_%platform%.bat
echo del "%RLfolder%\TAGame\CookedPCConsole\movinggoals_star_b.upk" >> uninstall_%platform%.bat
echo del "%RLfolder%\TAGame\CookedPCConsole\movinggoals_triangle.upk" >> uninstall_%platform%.bat
echo del "%RLfolder%\TAGame\CookedPCConsole\movinggoals_triangle_b.upk" >> uninstall_%platform%.bat
echo exit >> uninstall_%platform%.bat

:: installation complete screen
echo Install complete.
pause
goto Quit

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: END OF SCRIPT ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::: ROCKETLEAGUE FOLDER FUNCTIONS :::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Either a default rocketleague directory is found and stored into %RLfolder%, or the user is asked to select their rocketleague folder

:Steam
set "platform=steam"
if exist "C:\Program Files (x86)\Steam\steamapps\common\rocketleague\Binaries\Win64\rocketleague.exe" ( set "RLfolder=C:\Program Files (x86)\Steam\steamapps\common\rocketleague" && goto batchwrite ) else ( goto Custom )
:: if the default steam rocketleague directory is found, %RLfolder% is created and user is sent to :batchwrite, otherwise, the user is routed to :Custom

:Epic
set "platform=epic"
if exist "C:\Program Files\Epic Games\rocketleague\Binaries\Win64\rocketleague.exe" ( set "RLfolder=C:\Program Files\Epic Games\rocketleague" && goto batchwrite ) else ( goto Custom )
:: if the default epic rocketleague directory is found, %RLfolder% is created and user is sent to :batchwrite, otherwise, the user is routed to :Custom

:Custom
:: %RLfolder% hasn't been made yet because the rocketleague directory hasn't been found
:: user is asked to select their rocketleague folder
echo Error: rocketleague.exe not found.
echo Please select the location of your "rocketleague" folder. &>nul timeout /t 1
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please select the location of your rocketleague folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "RLfolder=%%I"
setlocal enabledelayedexpansion
:: pop up window is created and user is asked to select their rocketleague folder
:: the chosen directory is stored into %RLfolder%
if exist "%RLfolder%\Binaries\Win64\rocketleague.exe" ( goto batchwrite ) else ( goto Custom )
:: checks if rocketleague.exe is in %RLfolder%, this step is just validating that the script will work as intended
:: if the folder is invalid, then the user is sent back to :Custom 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: BASIC FUNCTIONS ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: These functions are used to make the main script, or other functions more readable

:Invalid
:: this function is only called if the user input is not A or B when choosing between steam and epic
echo Error: %user_input% is an invalid, please try again!
pause
( goto Start )
:: display error message and send user back to :Start

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Quit
exit
:: exit the program
