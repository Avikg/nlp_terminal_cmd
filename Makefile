.PHONY: help install install-dev test demo clean lint format

help:
	@echo "nlpcmd-ai Development Commands"
	@echo "==============================="
	@echo ""
	@echo "install       Install the package"
	@echo "install-dev   Install with development dependencies"
	@echo "install-local Install with local LLM support (Ollama)"
	@echo "test          Run tests"
	@echo "demo          Run demo script"
	@echo "clean         Clean build artifacts"
	@echo "lint          Run linting checks"
	@echo "format        Format code with black"
	@echo "build         Build distribution packages"
	@echo "upload        Upload to PyPI (requires credentials)"

install:
	pip install -e .

install-dev:
	pip install -e ".[dev]"

install-local:
	pip install -e ".[local]"

test:
	pytest tests/ -v

demo:
	python demo.py

clean:
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete

lint:
	ruff check nlpcmd_ai/
	mypy nlpcmd_ai/

format:
	black nlpcmd_ai/ tests/ demo.py

build: clean
	python -m build

upload: build
	python -m twine upload dist/*

# Quick setup for new users
setup:
	@echo "Setting up nlpcmd-ai..."
	cp .env.example .env
	@echo ""
	@echo "✅ Created .env file"
	@echo "📝 Edit .env and add your API key"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Edit .env and add your OPENAI_API_KEY or ANTHROPIC_API_KEY"
	@echo "  2. Run: make install"
	@echo "  3. Run: make demo"
	@echo "  4. Try: nlpai 'what is my ip address'"
