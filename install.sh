#!/bin/bash
# Installation script for nlpcmd-ai on Linux/macOS
# Run as: bash install.sh or ./install.sh

set -e  # Exit on error

echo "========================================"
echo "Installing nlpcmd-ai"
echo "========================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}ERROR: Python 3 is not installed${NC}"
    echo "Please install Python 3.8 or higher:"
    echo "  - Ubuntu/Debian: sudo apt install python3 python3-pip"
    echo "  - macOS: brew install python3"
    echo "  - Or download from: https://www.python.org/downloads/"
    exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
REQUIRED_VERSION="3.8"

if ! python3 -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)" 2>/dev/null; then
    echo -e "${RED}ERROR: Python 3.8 or higher is required${NC}"
    echo "Current version: $PYTHON_VERSION"
    echo "Please upgrade Python from https://www.python.org/downloads/"
    exit 1
fi

echo -e "${GREEN}Python found: $PYTHON_VERSION${NC}"
echo ""

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo -e "${YELLOW}pip3 not found, installing...${NC}"
    python3 -m ensurepip --default-pip
fi

echo "========================================"
echo "Installing nlpcmd-ai from PyPI..."
echo "========================================"
echo ""

# Install the package
if pip3 install nlpcmd-ai; then
    echo ""
    echo -e "${GREEN}Installation successful!${NC}"
else
    echo ""
    echo -e "${RED}Installation failed${NC}"
    echo "Try running with sudo: sudo pip3 install nlpcmd-ai"
    exit 1
fi

# Create .env file if it doesn't exist
ENV_DIR="$HOME/.nlpcmd_ai"
ENV_FILE="$ENV_DIR/.env"

mkdir -p "$ENV_DIR"

if [ ! -f "$ENV_FILE" ]; then
    echo ""
    echo "Creating .env configuration file..."
    cat > "$ENV_FILE" << 'EOF'
# nlpcmd-ai configuration
# Add your API key below:

NLP_PROVIDER=openai
OPENAI_API_KEY=your-api-key-here

# Or use Anthropic Claude:
# NLP_PROVIDER=anthropic
# ANTHROPIC_API_KEY=sk-ant-your-key-here

# Or use local Ollama:
# NLP_PROVIDER=ollama
# OLLAMA_MODEL=llama3.2

REQUIRE_CONFIRMATION=true
LOG_COMMANDS=true
EOF
    echo -e "${GREEN}Created $ENV_FILE${NC}"
fi

echo ""
echo "========================================"
echo "Installation Complete!"
echo "========================================"
echo ""
echo "Next Steps:"
echo ""
echo "1. Edit your .env file:"
echo "   ${YELLOW}nano $ENV_FILE${NC}"
echo "   or: ${YELLOW}vim $ENV_FILE${NC}"
echo ""
echo "2. Add your OpenAI API key:"
echo "   Get it from: https://platform.openai.com/api-keys"
echo ""
echo "3. Try nlpcmd-ai:"
echo "   ${GREEN}nlpai \"what is my ip address\"${NC}"
echo "   ${GREEN}nlpai -i${NC}  (interactive mode)"
echo ""
echo "4. For help:"
echo "   ${GREEN}nlpai --help${NC}"
echo ""
echo "========================================"
echo ""

# Check if nlpai is in PATH
if ! command -v nlpai &> /dev/null; then
    echo -e "${YELLOW}WARNING: 'nlpai' command not found in PATH${NC}"
    echo ""
    echo "You may need to add Python's bin directory to your PATH:"
    echo ""
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        PYTHON_BIN=$(python3 -c "import sys; import os; print(os.path.dirname(sys.executable))")
        echo "Add this to your ~/.zshrc or ~/.bash_profile:"
        echo "  export PATH=\"$PYTHON_BIN:\$PATH\""
    else
        # Linux
        echo "Add this to your ~/.bashrc:"
        echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
    
    echo ""
    echo "Then run: source ~/.bashrc (or ~/.zshrc on macOS)"
    echo ""
    echo "Or use: python3 -m nlpcmd_ai.cli instead of nlpai"
fi
