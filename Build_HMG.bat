SET PATH=c:\hmg.3.4.4\harbour\bin;c:\hmg.3.4.4\mingw\bin;%PATH%

title id-valid_hmg

call del.bat

copy id-valid_ver3._ch id-valid_ver.ch
copy id-valid_hmg3._rc id-valid_hmg.rc

call c:\hmg.3.4.4\build.bat /n id-valid_hmg.hbp id-valid_hmg.hbc

IF NOT EXIST id-valid_hmg.exe goto :END
IF NOT EXIST c:\upx-win32\upx.exe goto :END

IF EXIST c:\upx-win32\upx.exe c:\upx-win32\upx.exe -9 -q id-valid_hmg.exe -o id-valid.exe

IF EXIST id-valid.exe DEL id-valid_hmg.exe

:END

title OK
