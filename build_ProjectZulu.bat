@echo off
echo --------------------------- Building Project Zulu ------------------------------
set /p Input=Enter Enter Version Number:
cd ..
echo Backing up src
XCOPY forge\mcp\src forge\mcp\src-bak /E /I /Q /y
echo.
echo Copying source 
XCOPY "Project Zulu Source\src" "forge\mcp\src\minecraft" /E /Q /y
echo.
echo Recompile
pushd forge\mcp
echo | call recompile.bat
echo Done.
echo.
echo Reobfuscate
echo | call reobfuscate.bat
echo Done.
popd
echo.

echo Moving Art Assets to Setup Folder
XCOPY "Project Zulu Source\projectzuluresources\module_block" forge\mcp\reobf\minecraft\SETUP\ProjectZuluBlocks\projectzuluresources\module_block /E /I /Q /y
XCOPY "Project Zulu Source\projectzuluresources\module_core" forge\mcp\reobf\minecraft\SETUP\ProjectZuluCore\projectzuluresources\module_core /E /I /Q /y
XCOPY "Project Zulu Source\projectzuluresources\module_mob" forge\mcp\reobf\minecraft\SETUP\ProjectZuluMobs\projectzuluresources\module_mob /E /I /Q /y
XCOPY "Project Zulu Source\projectzuluresources\module_world" forge\mcp\reobf\minecraft\SETUP\ProjectZuluWorld\projectzuluresources\module_world /E /I /Q /y

XCOPY "Project Zulu Source\projectzuluresources\module_block" forge\mcp\reobf\minecraft\SETUP\ProjectZuluComplete\projectzuluresources\module_block /E /I /Q /y
XCOPY "Project Zulu Source\projectzuluresources\module_core" forge\mcp\reobf\minecraft\SETUP\ProjectZuluComplete\projectzuluresources\module_core /E /I /Q /y
XCOPY "Project Zulu Source\projectzuluresources\module_mob" forge\mcp\reobf\minecraft\SETUP\ProjectZuluComplete\projectzuluresources\module_mob /E /I /Q /y
XCOPY "Project Zulu Source\projectzuluresources\module_world" forge\mcp\reobf\minecraft\SETUP\ProjectZuluComplete\projectzuluresources\module_world /E /I /Q /y

echo Copy Project Zulu into Complete Module in Setup 
XCOPY forge\mcp\reobf\minecraft\projectzulu forge\mcp\reobf\minecraft\SETUP\ProjectZuluComplete\projectzulu /E /I /Q /y
echo Copy Project Zulu into Core Module in Setup
XCOPY forge\mcp\reobf\minecraft\projectzulu forge\mcp\reobf\minecraft\SETUP\ProjectZuluCore\projectzulu /E /I /Q /y

echo Copy Code Buried In Vanilla Packages
XCOPY forge\mcp\reobf\minecraft\net forge\mcp\reobf\minecraft\SETUP\ProjectZuluComplete\net /E /I /Q /y
XCOPY forge\mcp\reobf\minecraft\net forge\mcp\reobf\minecraft\SETUP\ProjectZuluCore\net /E /I /Q /y

echo Move Block Code from Core to Block Module
md forge\mcp\reobf\minecraft\SETUP\ProjectZuluBlocks\projectzulu\common\
MOVE forge\mcp\reobf\minecraft\SETUP\ProjectZuluCore\projectzulu\common\ProjectZulu_Blocks.class forge\mcp\reobf\minecraft\SETUP\ProjectZuluBlocks\projectzulu\common\
echo Move Mob Code from Core to Mobs Module
md forge\mcp\reobf\minecraft\SETUP\ProjectZuluMobs\projectzulu\common\
MOVE forge\mcp\reobf\minecraft\SETUP\ProjectZuluCore\projectzulu\common\ProjectZulu_Mobs.class forge\mcp\reobf\minecraft\SETUP\ProjectZuluMobs\projectzulu\common\
echo Move World Code from Core to World Module
md forge\mcp\reobf\minecraft\SETUP\ProjectZuluWorld\projectzulu\common\
MOVE forge\mcp\reobf\minecraft\SETUP\ProjectZuluCore\projectzulu\common\ProjectZulu_World.class forge\mcp\reobf\minecraft\SETUP\ProjectZuluWorld\projectzulu\common\

echo Move Active into Setup
pushd forge\mcp\reobf\minecraft\SETUP
echo Using 7Zip to Zip Block Module
"C:\Program Files\7-zip\7z.exe" a ProjectZuluCore%Input%.zip .\ProjectZuluCore\* -r | findstr /b /r /c:"\<Everything is Ok" /c:"\<Scanning" /c:"\<Creating archive"
"C:\Program Files\7-zip\7z.exe" a ProjectZuluBlock%Input%.zip .\ProjectZuluBlocks\* -r | findstr /b /r /c:"\<Everything is Ok" /c:"\<Scanning" /c:"\<Creating archive"
"C:\Program Files\7-zip\7z.exe" a ProjectZuluMobs%Input%.zip .\ProjectZuluMobs\* -r | findstr /b /r /c:"\<Everything is Ok" /c:"\<Scanning" /c:"\<Creating archive"
"C:\Program Files\7-zip\7z.exe" a ProjectZuluWorld%Input%.zip .\ProjectZuluWorld\* -r | findstr /b /r /c:"\<Everything is Ok" /c:"\<Scanning" /c:"\<Creating archive"
"C:\Program Files\7-zip\7z.exe" a -tzip ProjectZuluComplete%Input%.zip .\ProjectZuluComplete\* -r | findstr /b /r /c:"\<Everything is Ok" /c:"\<Scanning" /c:"\<Creating archive"
popd
echo Restoring src-bak
RMDIR /S /Q forge\mcp\src
REN forge\mcp\src-bak src
PAUSE