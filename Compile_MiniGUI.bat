if "%MG_ROOT%"=="" set MG_ROOT=c:\minigui

title id-valid_hmg

call del.bat

copy id-valid_ver2._ch id-valid_ver.ch
copy id-valid_hmg2._rc id-valid_hmg.rc


call %MG_ROOT%\batch\compile.bat id-valid_hmg /ro


call %MG_ROOT%\batch\compile.bat id-valid_hmg          /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat PESEL_Check           /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat ctklib                /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat About                 /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat AutoAdjustControls    /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat EndOfProgram          /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat MoveActiveWindow      /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat CenterMainWindow      /nl %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat CenterModalWindow     /nl %1 %2 %3 %4 %5 %6 %7 %8 %9

call %MG_ROOT%\batch\compile.bat id-valid_hmg /lo /b PESEL_Check /b ctklib /b About /b AutoAdjustControls /b EndOfProgram /b MoveActiveWindow /b CenterMainWindow /b CenterModalWindow /r id-valid_hmg /nx %1 %2 %3 %4 %5 %6 %7 %8 %9

call %MG_ROOT%\batch\compile.bat id-valid_hmg          /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat PESEL_Check           /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat ctklib                /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat About                 /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat AutoAdjustControls    /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat EndOfProgram          /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat MoveActiveWindow      /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat CenterMainWindow      /do %1 %2 %3 %4 %5 %6 %7 %8 %9
call %MG_ROOT%\batch\compile.bat CenterModalWindow     /do %1 %2 %3 %4 %5 %6 %7 %8 %9

IF NOT EXIST id-valid_hmg.exe goto :END
IF NOT EXIST c:\upx-win32\upx.exe goto :END

IF EXIST c:\upx-win32\upx.exe c:\upx-win32\upx.exe -9 -q id_valid_hmg.exe -o id-valid.exe

IF EXIST eib.exe DEL id-valid_hmg.exe

:END

title OK
