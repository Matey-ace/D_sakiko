@echo off
setlocal DisableDelayedExpansion
chcp 65001 >nul
title 数字小祥 - 启动菜单

:menu
echo.
echo ========== 数字小祥 ==========
echo   [1] 桌面端
echo   [2] WebUI（手机端）
echo   [3] 小剧场模式
echo   [0] 退出菜单
echo.
choice /c 1230 /n /m "请选择 [1/2/3/0]："
if errorlevel 4 exit /b 0
if errorlevel 3 goto theater
if errorlevel 2 goto webui
if errorlevel 1 goto desktop
exit /b 0

:desktop
set "entry=run.bat"
goto launch

:webui
set "entry=run_webui.bat"
goto launch

:theater
set "entry=运行小剧场模式.bat"
goto launch

:launch
if not exist "%~dp0%entry%" goto missing
rem START may preserve CHOICE's exit code after successfully opening a window.
"%ComSpec%" /d /c exit 0
start "数字小祥 - %entry%" /d "%~dp0" "%ComSpec%" /d /v:off /s /c ""%entry%""
if errorlevel 1 goto failed
echo 已打开 %entry% 的运行窗口，请保留该窗口。
goto menu

:missing
echo.
echo 未找到："%~dp0%entry%"
echo 请将启动菜单放在完整软件包根目录，并检查对应 BAT 文件是否已解压。
goto menu

:failed
echo.
echo 启动失败，请尝试在软件包目录中双击 %entry% 查看错误。
goto menu
