# 🤖 nlpcmd-ai

[![PyPI version](https://img.shields.io/pypi/v/nlpcmd-ai.svg)](https://pypi.org/project/nlpcmd-ai/)
[![Python versions](https://img.shields.io/pypi/pyversions/nlpcmd-ai.svg)](https://pypi.org/project/nlpcmd-ai/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-blue.svg)](https://pypi.org/project/nlpcmd-ai/)
[![GitHub](https://img.shields.io/badge/GitHub-nlp__terminal__cmd-blue?logo=github)](https://github.com/Avikg/nlp_terminal_cmd)

> **Transform natural language into system commands with AI** 🚀  
> **Current Version: 0.1.3**

A **truly AI-powered** command-line assistant for **Windows, Linux, and macOS** that understands natural language and executes system commands intelligently. No more memorizing complex command syntax - just ask in plain English!

Unlike traditional CLI tools with pattern matching, nlpcmd-ai uses **AI/LLM** (OpenAI GPT-4, Anthropic Claude, or local Ollama) to understand complex, ambiguous commands and translate them into executable system operations - **automatically adapting commands to your operating system**.

## 📚 Links

- **📦 PyPI Package:** [https://pypi.org/project/nlpcmd-ai/](https://pypi.org/project/nlpcmd-ai/)
- **💻 GitHub Repository:** [https://github.com/Avikg/nlp_terminal_cmd](https://github.com/Avikg/nlp_terminal_cmd)
- **📖 Documentation:** [Full Documentation](https://github.com/Avikg/nlp_terminal_cmd#readme)
- **🐛 Issues:** [Report Issues](https://github.com/Avikg/nlp_terminal_cmd/issues)

## ✨ Features

- 🧠 **True Natural Language Understanding** - Uses AI models (OpenAI GPT-4, Anthropic Claude, or local Ollama)
- 🔒 **Safe Execution** - Smart confirmation for dangerous operations only
- 📝 **Context Awareness** - Remembers conversation history for follow-up commands
- 🎯 **Intent Detection** - Automatically determines what you want to do
- 🔧 **Extensible** - Easy to add custom command handlers
- 🌐 **Cross-platform** - Works seamlessly on Windows, Linux, and macOS
- 💬 **Interactive Mode** - Chat-like interface for complex workflows
- 🆓 **100% Free Option** - Use with local Ollama (no API costs)
- ⚡ **Fast & Efficient** - Powered by optimized AI models
- 🐍 **Pure Python** - No PowerShell issues, works everywhere

## 🎬 Quick Start

### Try it in 3 commands:

```bash
# 1. Install
pip install nlpcmd-ai

# 2. Setup (choose one - Ollama is free!)
ollama pull llama3.2  # Free option
# OR get OpenAI API key from https://platform.openai.com/api-keys

# 3. Use it!
python -m nlpcmd_ai.cli "what is my ip"
```

## 🚀 Installation

### Prerequisites

- **Python 3.8+** - [Download Python](https://python.org)
- **pip** (comes with Python)

### Step 1: Install the Package

```bash
pip install nlpcmd-ai
```

### Step 2: Choose Your AI Provider

You have **3 options** for the AI backend:

#### **Option A: Ollama (Recommended - 100% Free & Private)**

Run AI models **locally** on your computer - completely free, no API keys needed!

1. **Install Ollama:**
   - Windows/Mac: Download from [https://ollama.ai](https://ollama.ai)
   - Linux: `curl https://ollama.ai/install.sh | sh`

2. **Download AI model:**
   ```bash
   ollama pull llama3.2
   ```

3. **Create configuration file:**
   
   **Windows:**
   ```cmd
   echo NLP_PROVIDER=ollama > .env
   echo OLLAMA_MODEL=llama3.2 >> .env
   echo REQUIRE_CONFIRMATION=false >> .env
   ```
   
   **Linux/macOS:**
   ```bash
   cat > .env << EOF
   NLP_PROVIDER=ollama
   OLLAMA_MODEL=llama3.2
   REQUIRE_CONFIRMATION=false
   EOF
   ```

#### **Option B: OpenAI (Paid - Most Accurate)**

1. **Get API Key:** [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)

2. **Create .env file:**
   ```bash
   # Windows
   echo NLP_PROVIDER=openai > .env
   echo OPENAI_API_KEY=your-api-key-here >> .env
   
   # Linux/macOS
   cat > .env << EOF
   NLP_PROVIDER=openai
   OPENAI_API_KEY=your-api-key-here
   EOF
   ```

#### **Option C: Anthropic Claude (Paid - Most Intelligent)**

1. **Get API Key:** [https://console.anthropic.com/](https://console.anthropic.com/)

2. **Create .env file:**
   ```bash
   NLP_PROVIDER=anthropic
   ANTHROPIC_API_KEY=your-api-key-here
   ```

### Step 3: Verify Installation

```bash
python -m nlpcmd_ai.cli "what is my ip"
```

If it shows your IP address, you're all set! 🎉

## 💡 Usage

### Basic Commands

Just ask naturally - the AI will understand!

```bash
# System Information
python -m nlpcmd_ai.cli "what is my ip"
python -m nlpcmd_ai.cli "show mac address"
python -m nlpcmd_ai.cli "how much memory do I have"
python -m nlpcmd_ai.cli "show disk usage"
python -m nlpcmd_ai.cli "what's my CPU usage"
python -m nlpcmd_ai.cli "how long has my computer been running"
python -m nlpcmd_ai.cli "who am I"

# File Operations
python -m nlpcmd_ai.cli "list all python files"
python -m nlpcmd_ai.cli "find files larger than 10MB"
python -m nlpcmd_ai.cli "show directory structure"
python -m nlpcmd_ai.cli "show folders in C:"
python -m nlpcmd_ai.cli "find a.txt"
python -m nlpcmd_ai.cli "where is config.json"

# Network Commands
python -m nlpcmd_ai.cli "is port 8080 open"
python -m nlpcmd_ai.cli "ping google.com"
python -m nlpcmd_ai.cli "trace yahoo.com"

# Application Launching
python -m nlpcmd_ai.cli "open file explorer"
python -m nlpcmd_ai.cli "open browser"

# Get Help
python -m nlpcmd_ai.cli "help"
python -m nlpcmd_ai.cli "what can you do"
```

### Interactive Mode (Recommended!)

Have a conversation with your terminal:

```bash
python -m nlpcmd_ai.cli -i
```

Then chat naturally:
```
> what is my ip
> show disk usage
> list python files in current directory
> find files modified today
> help
> exit
```

### Advanced Usage

```bash
# Auto-confirm (skip confirmation prompts)
python -m nlpcmd_ai.cli --yes "show disk usage"

# Dry run (see what would execute without running)
python -m nlpcmd_ai.cli --dry-run "delete all .log files"

# Help
python -m nlpcmd_ai.cli --help
```

### Create a Shortcut (Optional but Convenient)

**Windows:**
Create `nlpai.bat` in your PATH:
```batch
@echo off
python -m nlpcmd_ai.cli %*
```

Then use:
```cmd
nlpai "what is my ip"
nlpai -i
```

**Linux/macOS:**
Add to `~/.bashrc` or `~/.zshrc`:
```bash
alias nlpai='python -m nlpcmd_ai.cli'
```

Then:
```bash
nlpai "what is my ip"
nlpai -i
```

## 📋 Supported Commands

### System Information
- **CPU usage, memory info, disk space** - "show CPU usage", "how much RAM"
- **System uptime, user info, hostname** - "how long running", "who am I"
- **Operating system details** - Windows, Linux, macOS

### Network Operations
- **IP address lookup** - "what is my ip", "show mac address"
- **Port checking** - "is port 8080 open"
- **Network diagnostics** - "ping google.com", "trace yahoo.com"
- **Connectivity tests** - Works without confirmation!

### File & Directory Operations
- **List files** - "list python files", "show folders in C:"
- **Find files** - "find a.txt", "where is config.json"
- **Directory navigation** - "show current folder", "folder structure"
- **File search** - "search for *.py files"

### Process Management
- **List running processes** - "show running processes"
- **Find processes by name** - "is python running"
- **Monitor system resources** - CPU, memory usage

### Application Launching
- **Open applications** - "open file explorer", "open browser"
- **Launch programs** - Cross-platform support

### Help & Information
- **Get help** - "help", "what can you do"
- **Show capabilities** - Lists all available commands
- **Conversational queries** - Friendly redirects to help

**See [SUPPORTED_COMMANDS.txt](SUPPORTED_COMMANDS.txt) for complete list**

## 🔧 Configuration

### Environment Variables (.env file)

```bash
# AI Provider (required)
NLP_PROVIDER=ollama  # or "openai" or "anthropic"

# Provider-specific settings
OLLAMA_MODEL=llama3.2
OPENAI_API_KEY=your-key
ANTHROPIC_API_KEY=your-key

# Safety
REQUIRE_CONFIRMATION=false  # Set to true for dangerous operations

# Logging
LOG_COMMANDS=true
LOG_FILE=~/.nlpcmd_ai/history.log
```

## 🛡️ Safety Features

- ✅ Smart confirmation - Only dangerous operations require confirmation
- ✅ Safe diagnostics - Network commands (ping, tracert) run without prompts
- ✅ Dry-run mode to preview commands
- ✅ Command logging for audit trail
- ✅ Path validation for file operations
- ✅ Protection against system directory access

### Commands That Don't Need Confirmation:
- ✅ Network diagnostics (ping, tracert, nslookup)
- ✅ System info queries (CPU, memory, disk, uptime)
- ✅ File searches and listings
- ✅ Process listing
- ✅ Read-only operations

### Commands That Require Confirmation:
- ⚠️ Deleting files/directories
- ⚠️ Stopping processes
- ⚠️ Modifying system files
- ⚠️ Operations with sudo/admin privileges

## 🎯 Examples

### Example 1: System Monitoring
```bash
$ python -m nlpcmd_ai.cli -i

> what's my CPU usage
CPU Information:
Usage: 23.5%
Cores: 8
Current Speed: 2400 MHz

> how much memory do I have
Memory Information:
Total: 16.00 GB
Available: 8.50 GB
Used: 7.50 GB
Usage: 46.9%

> show disk usage
Disk Usage for C:\:
Total: 476.94 GB
Used: 250.30 GB
Free: 226.64 GB
Usage: 52.5%
```

### Example 2: File Management
```bash
$ python -m nlpcmd_ai.cli "find all python files"

 📋 Category: file_operation
 ⚡ Action: find_files
 💻 Command: dir /s /b *.py

Found 15 files:
./nlpcmd_ai/engine.py
./nlpcmd_ai/handlers.py
./nlpcmd_ai/cli.py
...
```

### Example 3: Network Troubleshooting
```bash
$ python -m nlpcmd_ai.cli "what is my ip"

Local IP: 192.168.1.100
Public IP: 203.0.113.45

$ python -m nlpcmd_ai.cli "show mac address"

Network Interface MAC Addresses:
Ethernet: 00-1A-2B-3C-4D-5E
Wi-Fi: 00-1F-2E-3D-4C-5B

$ python -m nlpcmd_ai.cli "is port 8080 open"

❌ Port 8080 is CLOSED on localhost
```

### Example 4: File Search
```bash
$ python -m nlpcmd_ai.cli "where is config.json"

 💻 Command: dir /s /b config.json

C:\Development\nlpcmd\config.json
C:\Users\user\project\config.json
```

## 🔌 Extending nlpcmd-ai

Create custom handlers for your specific needs:

```python
# custom_handler.py
from nlpcmd_ai.base_handler import BaseHandler, CommandResult

class MyCustomHandler(BaseHandler):
    def can_handle(self, category: str, action: str) -> bool:
        return category == "my_custom_category"
    
    def execute(self, command: str, parameters: dict, dry_run: bool = False) -> CommandResult:
        # Your custom logic here
        return CommandResult(success=True, output="Custom output")
```

See [examples/custom_handlers.py](examples/custom_handlers.py) for more examples.

## 📊 Comparison with Alternatives

| Feature | nlpcmd-ai | Traditional CLI | Shell Scripts |
|---------|-----------|----------------|---------------|
| Natural Language | ✅ Yes | ❌ No | ❌ No |
| Cross-Platform | ✅ Auto-adapts | ⚠️ Manual | ⚠️ Manual |
| Learning Curve | ✅ None | ❌ High | ❌ High |
| AI-Powered | ✅ Yes | ❌ No | ❌ No |
| Interactive | ✅ Yes | ⚠️ Limited | ❌ No |
| Extensible | ✅ Yes | ⚠️ Limited | ✅ Yes |
| No PowerShell Issues | ✅ Yes | ❌ Varies | ❌ Varies |

## 🆕 What's New in v0.1.3

- ✅ Fixed MAC address retrieval using Python (psutil)
- ✅ Improved port checking with better parameter extraction
- ✅ Extended timeout for network commands (ping, tracert) - 120 seconds
- ✅ Removed confirmation prompts for safe diagnostic commands
- ✅ Better file search with `dir /s /b` pattern
- ✅ Help handler for conversational queries
- ✅ Application launching support (file explorer, browser)
- ✅ Enhanced AI prompt for better path handling
- ✅ All system info commands use Python (no PowerShell dependencies)
- ✅ Smart confirmation - only dangerous operations require confirmation
- ✅ Fixed action parameter passing to handlers
- ✅ Improved current directory vs specific path handling

## 🤝 Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup

```bash
# Clone repository
git clone https://github.com/Avikg/nlp_terminal_cmd.git
cd nlp_terminal_cmd

# Install in development mode
pip install -e .

# Install development dependencies
pip install -r requirements-dev.txt

# Run tests
pytest
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [OpenAI GPT](https://openai.com/), [Anthropic Claude](https://anthropic.com/), and [Ollama](https://ollama.ai/)
- Uses [psutil](https://github.com/giampaolo/psutil) for system information
- UI powered by [Rich](https://github.com/Textualize/rich)

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/Avikg/nlp_terminal_cmd/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Avikg/nlp_terminal_cmd/discussions)
- **PyPI:** [https://pypi.org/project/nlpcmd-ai/](https://pypi.org/project/nlpcmd-ai/)

## 🌟 Star History

If you find this project useful, please consider giving it a ⭐ on [GitHub](https://github.com/Avikg/nlp_terminal_cmd)!

---

**Made with ❤️ by [Avikg](https://github.com/Avikg) and [Abhinandan](https://github.com/abhinandan12345678)**

**Try it now:** `pip install nlpcmd-ai`

---

**⚠️ Note:** This tool executes system commands based on AI interpretation. Always review commands before execution and use safety features appropriately.
