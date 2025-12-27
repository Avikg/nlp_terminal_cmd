# nlpcmd-ai: True NLP-Powered Command Line Assistant

## 🎯 Project Overview

I've created a **complete, production-ready** NLP-powered command-line assistant that goes far beyond the simple pattern matching of the original `nlpcmd`. This is a true AI-powered CLI tool that understands natural language and executes commands intelligently.

## ✨ Key Differences from Original nlpcmd

| Feature | Original nlpcmd | nlpcmd-ai |
|---------|----------------|-----------|
| **Understanding** | Pattern matching | True NLP with AI/LLM |
| **Flexibility** | Fixed patterns only | Understands variations, context |
| **Intelligence** | Rule-based | AI-powered reasoning |
| **Context** | None | Full conversation history |
| **Safety** | Basic | Multi-layer safety features |
| **Extensibility** | Edit code | Plugin system |
| **Command Coverage** | Limited predefined | Unlimited through AI |

## 🏗️ Architecture

### Core Components

1. **AI Engine** (`engine.py`)
   - Processes natural language using OpenAI, Anthropic, or Ollama
   - Maintains conversation context
   - Returns structured CommandIntent objects
   - Confidence scoring for responses

2. **Handler System** (`base_handler.py`, `handlers.py`)
   - Modular handler architecture
   - Built-in handlers: File, Network, System Info, Process, Development
   - Easy to extend with custom handlers
   - Safe command execution

3. **CLI Interface** (`cli.py`)
   - Rich terminal UI with colors and formatting
   - Interactive and one-off modes
   - Dry-run and auto-confirm options
   - User-friendly error messages

4. **Configuration** (`config.py`)
   - YAML and environment variable support
   - Customizable safety settings
   - Flexible AI provider selection

## 📦 What's Included

```
nlpcmd_ai/
├── nlpcmd_ai/              # Main package
│   ├── __init__.py        # Package initialization
│   ├── engine.py          # AI processing engine
│   ├── base_handler.py    # Handler base classes
│   ├── handlers.py        # Built-in handlers
│   ├── cli.py             # CLI interface
│   └── config.py          # Configuration management
├── tests/                  # Test suite
│   └── test_nlpcmd.py     # Comprehensive tests
├── examples/               # Example code
│   └── custom_handlers.py # Custom handler examples
├── README.md              # Main documentation
├── QUICKSTART.md          # Quick start guide
├── CONTRIBUTING.md        # Contribution guidelines
├── pyproject.toml         # Package configuration
├── requirements.txt       # Dependencies
├── Makefile              # Development tasks
├── demo.py               # Demo script
├── .env.example          # Environment template
└── LICENSE               # MIT License
```

## 🚀 Quick Start

### 1. Installation

```bash
cd nlpcmd_ai

# Install the package
pip install -e .

# Or using make
make install
```

### 2. Configuration

```bash
# Set up environment
cp .env.example .env

# Edit and add your API key
# For OpenAI:
echo "OPENAI_API_KEY=sk-your-key-here" >> .env

# For Anthropic Claude:
echo "ANTHROPIC_API_KEY=sk-ant-your-key-here" >> .env
```

### 3. Usage

```bash
# One-off commands
nlpai "what is my ip address"
nlpai "list all python files larger than 1MB"
nlpai "show disk usage"

# Interactive mode
nlpai -i

# Dry run mode (test without executing)
nlpai --dry-run "delete all log files"
```

## 🎨 Features

### 1. True Natural Language Understanding

Unlike pattern matching, uses AI to understand:
- Variations in phrasing
- Complex multi-part commands
- Context from previous commands
- Ambiguous requests (asks for clarification)

**Examples:**
```bash
# All of these work:
nlpai "what's my ip"
nlpai "show me my ip address"
nlpai "tell me my network address"
nlpai "what is the IP of this machine"
```

### 2. Context-Aware Conversations

```bash
nlpai -i
> create a folder called myproject
✅ Created folder 'myproject'

> go into it
✅ Changed directory to 'myproject'

> create a python file called main.py
✅ Created file 'main.py'

> add a hello world function to it
✅ Added function to 'main.py'
```

### 3. Multi-Layer Safety

- **Confirmation prompts** for dangerous operations
- **Path validation** (prevents operations on system directories)
- **Dry-run mode** to test commands
- **Command logging** for audit trail
- **Confidence scoring** with warnings

### 4. Extensible Handler System

Create custom handlers for your specific needs:

```python
# ~/.nlpcmd_ai/handlers/my_handler.py
from nlpcmd_ai.base_handler import BaseHandler, CommandResult

class MyHandler(BaseHandler):
    def can_handle(self, category: str, action: str) -> bool:
        return category == "my_custom_category"
    
    def execute(self, command: str, parameters: dict, dry_run: bool = False):
        # Your custom logic
        return CommandResult(success=True, output="Done!")
```

### 5. Multiple AI Providers

- **OpenAI** (GPT-4, GPT-3.5)
- **Anthropic** (Claude 3.5 Sonnet, Opus)
- **Ollama** (Local LLMs: Llama, Mistral, etc.)

Switch easily:
```bash
# Use OpenAI
export NLP_PROVIDER=openai

# Use Claude
export NLP_PROVIDER=anthropic

# Use local Ollama
export NLP_PROVIDER=ollama
```

## 💡 Usage Examples

### System Information
```bash
nlpai "show me disk usage"
nlpai "what processes are using most CPU"
nlpai "how much memory is available"
nlpai "show system information"
```

### File Operations
```bash
nlpai "list all python files in this directory"
nlpai "find files larger than 10MB modified in last week"
nlpai "create a backup of all my python files"
nlpai "rename all .jpeg files to .jpg"
```

### Network Operations
```bash
nlpai "what is my public IP"
nlpai "check if port 8080 is open"
nlpai "ping google.com"
nlpai "show me network interfaces"
```

### Development Tasks
```bash
nlpai "create a git branch called feature/auth"
nlpai "install the requests package"
nlpai "run my pytest tests"
nlpai "show git status"
nlpai "format all python files with black"
```

### Data Processing
```bash
nlpai "convert this CSV to JSON"
nlpai "extract all email addresses from this file"
nlpai "count lines in all python files"
nlpai "merge all CSV files in this directory"
```

## 🧪 Testing

```bash
# Run all tests
make test

# Run specific tests
pytest tests/test_nlpcmd.py::TestAIEngine -v

# Run demo (works without API keys)
make demo
python demo.py
```

## 🔧 Configuration Options

### Environment Variables
```bash
NLP_PROVIDER=openai          # AI provider
OPENAI_API_KEY=sk-...        # OpenAI key
ANTHROPIC_API_KEY=sk-ant-... # Anthropic key
REQUIRE_CONFIRMATION=true    # Confirm dangerous ops
DRY_RUN_MODE=false          # Dry run by default
LOG_COMMANDS=true           # Log all commands
```

### Config File (~/.nlpcmd_ai/config.yaml)
```yaml
ai:
  provider: openai
  model: gpt-4-turbo-preview
  temperature: 0.3

safety:
  require_confirmation: true
  dangerous_patterns:
    - "rm -rf"
    - "dd if="

logging:
  enabled: true
  level: INFO
```

## 📊 Comparison Example

**Original nlpcmd:**
```python
# Must match exact pattern
"what is my ip" → works
"show my ip"    → doesn't work
"my ip address" → doesn't work
```

**nlpcmd-ai:**
```python
# All variations understood
"what is my ip"       → ✅ works
"show my ip"          → ✅ works  
"my ip address"       → ✅ works
"tell me my network address" → ✅ works
"what's my public IP" → ✅ works
```

## 🎯 Advanced Features

### 1. Command History
All commands logged to `~/.nlpcmd_ai/history.log`:
```
2025-01-15 10:23:45 | SUCCESS | Query: "show my ip" | Command: "curl ifconfig.me"
```

### 2. Custom Handlers
See `examples/custom_handlers.py` for:
- Docker operations
- Git advanced workflows
- Data processing
- And more!

### 3. Safety Validation
```python
# Automatically validates paths
"/home/user/file"  → ✅ allowed
"/etc/passwd"      → ❌ blocked
```

### 4. Confidence Warnings
```
⚠️ Low confidence (45%) in understanding this request
Understanding: Multiple interpretations possible
Would you like me to try executing anyway? [y/N]
```

## 📚 Documentation

- **README.md**: Full feature documentation
- **QUICKSTART.md**: Step-by-step guide
- **CONTRIBUTING.md**: How to contribute
- **demo.py**: Live demonstrations
- **examples/**: Code examples

## 🛠️ Development

```bash
# Setup development environment
make install-dev

# Format code
make format

# Run linters
make lint

# Build package
make build
```

## 🌟 Why This Is Better

1. **True NLP**: Actually understands language, not just patterns
2. **Context-Aware**: Remembers conversation for follow-ups
3. **Extensible**: Easy to add custom handlers
4. **Safe**: Multiple safety layers
5. **Smart**: AI reasoning, not just matching
6. **Flexible**: Works with multiple AI providers
7. **Production-Ready**: Full test suite, logging, config
8. **Well-Documented**: Comprehensive docs and examples

## 📦 Project Structure Highlights

### Modular Design
- Separate concerns (AI, handlers, CLI, config)
- Easy to test individual components
- Simple to extend with new features

### Production Quality
- Type hints throughout
- Comprehensive error handling
- Logging and debugging support
- Configuration management
- Test coverage

### User-Friendly
- Rich terminal UI
- Clear error messages
- Interactive mode
- Helpful examples
- Safety confirmations

## 🚀 Next Steps

1. **Try the demo**: `python demo.py`
2. **Read QUICKSTART.md**: Step-by-step guide
3. **Install and test**: `make install && nlpai "what is my ip"`
4. **Create custom handlers**: See `examples/custom_handlers.py`
5. **Read full docs**: `README.md`

## 📝 Requirements

- Python 3.8+
- OpenAI API key OR Anthropic API key OR Ollama (local)
- pip
- Internet connection (for cloud AI providers)

## 🎓 Learning Resources

The code is heavily documented with:
- Docstrings on all functions/classes
- Inline comments explaining complex logic
- Type hints for clarity
- Examples throughout

Perfect for:
- Learning about NLP in CLI tools
- Understanding AI integration patterns
- Building custom command handlers
- Studying production Python projects

## 🤝 Contributing

See CONTRIBUTING.md for:
- How to contribute
- Code style guide
- Testing requirements
- PR process

## 📄 License

MIT License - see LICENSE file

---

**Created to demonstrate true NLP-powered CLI capabilities beyond simple pattern matching.**

Enjoy building with nlpcmd-ai! 🎉
