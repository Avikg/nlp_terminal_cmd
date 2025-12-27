# Cross-Platform Testing Guide

This guide helps you test nlpcmd-ai across Windows, Linux, and macOS to ensure full compatibility.

## Quick Platform Tests

### Windows

```powershell
# Install
pip install nlpcmd-ai

# Test system info
nlpai "show disk usage"
nlpai "show memory usage"
nlpai "what is my ip address"

# Test file operations
nlpai "list all files in current directory"
nlpai "find all python files"
nlpai "show current directory"

# Test network
nlpai "check if port 8080 is open"
nlpai "show network interfaces"

# Interactive mode
nlpai -i
> show system info
> list files
> exit
```

### Linux

```bash
# Install
pip3 install nlpcmd-ai

# Test system info
nlpai "show disk usage"
nlpai "show memory usage"
nlpai "what is my ip address"

# Test file operations
nlpai "list all python files"
nlpai "find files larger than 1MB"

# Test network
nlpai "ping google.com"
nlpai "show network interfaces"

# Interactive mode
nlpai -i
```

### macOS

```bash
# Install
pip3 install nlpcmd-ai

# Test system info
nlpai "show disk usage"
nlpai "show memory usage"  
nlpai "what is my ip address"

# Test file operations
nlpai "list all python files"
nlpai "show current directory"

# Test network
nlpai "what is my public IP"
nlpai "check if port 3000 is open"

# Interactive mode
nlpai -i
```

## Platform-Specific Commands

### Commands That Work on All Platforms

These commands are automatically translated to platform-appropriate equivalents:

```bash
nlpai "show current directory"      # pwd (Unix) / cd (Windows)
nlpai "list files"                  # ls (Unix) / dir (Windows)
nlpai "what is my ip"               # ifconfig (Unix) / ipconfig (Windows)
nlpai "show running processes"      # ps (Unix) / tasklist (Windows)
nlpai "show disk usage"             # df -h (Unix) / Get-PSDrive (Windows)
nlpai "show memory usage"           # free (Linux) / vm_stat (macOS) / wmic (Windows)
```

### Platform-Specific Features

#### Windows-Specific

```bash
nlpai "show windows version"
nlpai "list installed programs"
nlpai "show environment variables"
```

#### Linux-Specific

```bash
nlpai "show linux distribution"
nlpai "list installed packages"
nlpai "show systemd services"
```

#### macOS-Specific

```bash
nlpai "show macOS version"
nlpai "list homebrew packages"
nlpai "show running applications"
```

## Testing Installation Methods

### Method 1: From PyPI (End Users)

```bash
# Clean environment test
python -m venv test_env
source test_env/bin/activate  # Windows: test_env\Scripts\activate

# Install from PyPI
pip install nlpcmd-ai

# Test
nlpai "what is my ip"

# Cleanup
deactivate
rm -rf test_env
```

### Method 2: From Source (Developers)

```bash
# Clone repository
git clone https://github.com/yourusername/nlpcmd-ai.git
cd nlpcmd-ai

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install in development mode
pip install -e .

# Test
nlpai "what is my ip"
```

### Method 3: Using Installation Scripts

#### Windows
```cmd
# Download and run
curl -O https://raw.githubusercontent.com/yourusername/nlpcmd-ai/main/install.bat
install.bat
```

#### Linux/macOS
```bash
# Download and run
curl -O https://raw.githubusercontent.com/yourusername/nlpcmd-ai/main/install.sh
bash install.sh
```

## Automated Testing

### Test Suite

Run the full test suite on each platform:

```bash
# Install with dev dependencies
pip install -e ".[dev]"

# Run tests
pytest tests/ -v

# Run with coverage
pytest tests/ --cov=nlpcmd_ai --cov-report=html

# Open coverage report
# Windows: start htmlcov\index.html
# Linux: xdg-open htmlcov/index.html
# macOS: open htmlcov/index.html
```

### Platform-Specific Tests

```python
# tests/test_platform.py
import platform
import pytest
from nlpcmd_ai.platform_utils import platform_utils, command_mapper

def test_platform_detection():
    """Test that platform is correctly detected"""
    assert platform_utils.system in ["Windows", "Linux", "Darwin"]

def test_command_translation():
    """Test command translation for current platform"""
    if platform_utils.is_windows:
        assert "dir" in command_mapper.get_list_directory_command()
    else:
        assert "ls" in command_mapper.get_list_directory_command()

def test_path_separator():
    """Test correct path separator"""
    sep = platform_utils.get_path_separator()
    if platform_utils.is_windows:
        assert sep == "\\"
    else:
        assert sep == "/"
```

## CI/CD Testing

### GitHub Actions Workflow

Create `.github/workflows/test.yml`:

```yaml
name: Cross-Platform Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        python-version: ['3.8', '3.9', '3.10', '3.11', '3.12']
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -e ".[dev]"
      
      - name: Run tests
        run: pytest tests/ -v
      
      - name: Test installation
        run: |
          pip install -e .
          nlpai --help
```

## Manual Testing Checklist

### Basic Functionality
- [ ] Install completes without errors
- [ ] `nlpai --help` shows help message
- [ ] `nlpai --version` shows version
- [ ] Can create .env file
- [ ] API key configuration works
- [ ] One-off commands work
- [ ] Interactive mode works
- [ ] Exit commands work (exit, quit, q)

### Command Categories
- [ ] System info commands work
- [ ] File operation commands work
- [ ] Network commands work
- [ ] Process commands work (where applicable)
- [ ] Development commands work

### Features
- [ ] Dry-run mode works (`--dry-run`)
- [ ] Auto-confirm works (`--yes`)
- [ ] Different AI providers work (OpenAI, Anthropic, Ollama)
- [ ] Configuration file loading works
- [ ] Command logging works
- [ ] Error handling is graceful

### Safety Features
- [ ] Confirmation prompts appear for dangerous operations
- [ ] Path validation prevents system directory access
- [ ] Dangerous command detection works

### UI/UX
- [ ] Rich terminal output displays correctly
- [ ] Colors and formatting work
- [ ] Tables render properly
- [ ] Progress indicators show
- [ ] Error messages are clear

## Platform-Specific Issues

### Windows Issues

**Issue**: `nlpai` not found after installation
```cmd
# Solution: Add Scripts directory to PATH
# Or use: python -m nlpcmd_ai.cli
```

**Issue**: Permission errors
```cmd
# Solution: Run as Administrator or use --user flag
pip install --user nlpcmd-ai
```

**Issue**: PowerShell execution policy
```powershell
# Solution: Set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Linux Issues

**Issue**: `command not found: nlpai`
```bash
# Solution: Add to PATH
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

**Issue**: Permission denied
```bash
# Solution: Use --user flag
pip3 install --user nlpcmd-ai
```

### macOS Issues

**Issue**: SSL certificate errors
```bash
# Solution: Update certificates
/Applications/Python\ 3.x/Install\ Certificates.command
```

**Issue**: `nlpai` not in PATH
```bash
# Solution: Add to PATH
export PATH="$HOME/Library/Python/3.x/bin:$PATH"
echo 'export PATH="$HOME/Library/Python/3.x/bin:$PATH"' >> ~/.zshrc
```

## Performance Testing

Test command execution time across platforms:

```python
import time
from nlpcmd_ai.cli import NLPCommandCLI
from nlpcmd_ai.config import Config

def benchmark():
    config = Config()
    cli = NLPCommandCLI(config)
    
    start = time.time()
    cli.process_command("what is my ip", dry_run=True)
    end = time.time()
    
    print(f"Command processing took: {end - start:.2f}s")

if __name__ == "__main__":
    benchmark()
```

## Reporting Issues

When reporting platform-specific issues, include:

1. **Platform Information**:
   ```bash
   nlpai "show system information"
   python --version
   pip --version
   ```

2. **Error Messages**: Full error output

3. **Configuration**: Sanitized .env file (remove API keys)

4. **Steps to Reproduce**: Exact commands used

5. **Expected vs Actual**: What you expected vs what happened

## Success Criteria

A successful cross-platform test should:

✅ Install without errors on all platforms
✅ All basic commands work on all platforms  
✅ Platform-specific commands translate correctly
✅ UI renders properly on all platforms
✅ Tests pass on all platforms
✅ Documentation is accurate for all platforms
✅ Installation scripts work on all platforms
✅ No platform-specific hardcoded paths
✅ Error handling works consistently

## Resources

- [Python Packaging Guide](https://packaging.python.org/)
- [Windows Python Installation](https://docs.python.org/3/using/windows.html)
- [macOS Python Installation](https://docs.python.org/3/using/mac.html)
- [Linux Python Installation](https://docs.python.org/3/using/unix.html)
