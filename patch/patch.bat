echo off
cls
echo Start of patch operation.
for /f "tokens=1,2" %%i in (patchfiles.txt) do (
    echo Applying patch %%i
    echo to file disasm\data\%%j ...
    floating\flips %%i ..\disasm\data\%%j
)
echo End of patch operation.
pause