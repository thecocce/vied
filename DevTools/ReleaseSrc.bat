@rem ---------------------------------------------------------------------------
@rem Script used to create zip file containing source code of Version
@rem Information Editor.
@rem
@rem Copyright (C) Peter Johnson (www.delphidabbler.com), 2008
@rem
@rem v1.0 of 30 Apr 2008 - Original version.
@rem ---------------------------------------------------------------------------

@echo off

setlocal

cd ..

set OutFile=Release\dd-vied-src.zip
del %OutFile%

zip -r -9 %OutFile% Source
zip %OutFile% -d Source\*.dsk
zip -r -9 %OutFile% Bin\*.res
zip -j -9 %OutFile% Docs\ReadMe-Src.txt
zip -j -9 %OutFile% Docs\MPL.txt

endlocal