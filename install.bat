@echo off
REM Installation script for nlpcmd-ai on Windows
REM Run as: install.bat

echo ========================================
echo Installing nlpcmd-ai
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)

echo Python found:
python --version
echo.

REM Check Python version (need 3.8+)
python -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python 3.8 or higher is required
    echo Please upgrade Python from https://www.python.org/downloads/
    pause
    exit /b 1
)

echo ========================================
echo Installing nlpcmd-ai...
echo ========================================
echo.

REM Install from PyPI
pip install nlpcmd-ai

if errorlevel 1 (
    echo.
    echo ERROR: Installation failed
    echo Try running as Administrator
    pause
    exit /b 1
)

echo.
echo ========================================
echo Installation Complete!
echo ========================================
echo.

REM Create .env file if it doesn't exist
if not exist "%USERPROFILE%\.nlpcmd_ai" mkdir "%USERPROFILE%\.nlpcmd_ai"
if not exist "%USERPROFILE%\.nlpcmd_ai\.env" (
    echo Creating .env file...
    (
        echo # nlpcmd-ai configuration
        echo # Add your API key below:
        echo.
        echo NLP_PROVIDER=openai
        echo OPENAI_API_KEY=your-api-key-here
        echo.
        echo # Or use Anthropic Claude:
        echo # NLP_PROVIDER=anthropic
        echo # ANTHROPIC_API_KEY=sk-ant-your-key-here
        echo.
        echo REQUIRE_CONFIRMATION=true
        echo LOG_COMMANDS=true
    ) > "%USERPROFILE%\.nlpcmd_ai\.env"
    echo Created %USERPROFILE%\.nlpcmd_ai\.env
)

echo.
echo ========================================
echo Next Steps:
echo ========================================
echo.
echo 1. Edit your .env file:
echo    notepad "%USERPROFILE%\.nlpcmd_ai\.env"
echo.
echo 2. Add your OpenAI API key:
echo    Get it from: https://platform.openai.com/api-keys
echo.
echo 3. Try nlpcmd-ai:
echo    nlpai "what is my ip address"
echo    nlpai -i
echo.
echo ========================================
echo.

pause
