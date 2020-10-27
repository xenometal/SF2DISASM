echo off
cls
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
set month=0%Month%
set month=%month:~-2%
set day=0%Day%
set day=%day:~-2%
set today=%Year%%month%%day%
set hour=%Hour%
set hour=0%hour%
set hour=%hour:~-2%
set minutes=0%Minute%
set minutes=%minutes:~-2%
set seconds=0%Second%
set seconds=%seconds:~-2%
echo -------------------------------------------------------------
echo Start of assembly
cd ../disasm/
echo Assembling game ...
SET "buildname=sf2gu-%today%-%hour%%minutes%%seconds%.bin"
@"../tools/asm68k" /e EXPANDED_ROM=1 /o ae-,e+,w+ /p sf2gu.asm, "../build/%buildname%" > ../build/output.log
echo End of assembly, produced %buildname%

echo -------------------------------------------------------------
echo Checking build ...
cd ../build/
IF EXIST "%buildname%" (echo "%buildname%" exists in build directory. Success!) ELSE echo "%buildname%" does not exist, probably due to an assembly error. Check output.log.


pause