@echo off

REM Script: CleanCookiesAndTempFiles.bat
REM Finalidade: Limpar cookies e arquivos temporários de navegadores e pastas do sistema operacional.
REM Sistemas Operacionais Suportados: Windows (versões compatíveis)
REM Navegadores Suportados: Firefox, Chrome, Edge, Opera, Vivaldi

REM Função para verificar e excluir uma pasta se existir
:DeleteFolderIfExists
if exist "%~1" (
    echo Deletando %~1 ...
    cd /d "%~1"
    del *.* /F /S /Q /A:R /A:H /A:A
    rmdir /s /q "%~1"
)
goto :eof

REM Verificar e excluir os cookies e arquivos temporários dos navegadores e pastas do sistema
cls
echo Iniciando a limpeza de cookies e arquivos temporários...

set "profiles=%userprofile%\.."
for /f "tokens=* delims= " %%u in ('dir /b/ad "%profiles%"') do (
    cls
    title Deletando %%u COOKIES...
    if exist "%profiles%\%%u\cookies" (
        echo Deletando cookies...
        call :DeleteFolderIfExists "%profiles%\%%u\cookies"
    )

    cls
    title Deletando %%u Temp Files...
    if exist "%profiles%\%%u\Local Settings\Temp" (
        echo Deletando arquivos temporários...
        call :DeleteFolderIfExists "%profiles%\%%u\Local Settings\Temp"
    )
    if exist "%profiles%\%%u\AppData\Local\Temp" (
        echo Deletando arquivos temporários...
        call :DeleteFolderIfExists "%profiles%\%%u\AppData\Local\Temp"
    )

    cls
    title Deletando %%u Temporary Internet Files...
    if exist "%profiles%\%%u\Local Settings\Temporary Internet Files" (
        echo Deletando arquivos temporários da Internet...
        call :DeleteFolderIfExists "%profiles%\%%u\Local Settings\Temporary Internet Files"
    )
    if exist "%profiles%\%%u\AppData\Local\Microsoft\Windows\Temporary Internet Files" (
        echo Deletando arquivos temporários da Internet...
        call :DeleteFolderIfExists "%profiles%\%%u\AppData\Local\Microsoft\Windows\Temporary Internet Files"
    )

    cls
    title Deletando %%u WER Files...
    if exist "%profiles%\%%u\AppData\Local\Microsoft\Windows\WER\ReportArchive" (
        echo Deletando arquivos WER...
        call :DeleteFolderIfExists "%profiles%\%%u\AppData\Local\Microsoft\Windows\WER\ReportArchive"
    )
)

cls
echo Processo realizado com sucesso!
pause
exit
