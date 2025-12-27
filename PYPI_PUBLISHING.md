# Publishing to PyPI Guide

This guide will walk you through publishing `nlpcmd-ai` to PyPI so anyone can install it with `pip install nlpcmd-ai`.

## Prerequisites

1. **PyPI Account**: Create accounts on both:
   - TestPyPI (for testing): https://test.pypi.org/account/register/
   - PyPI (production): https://pypi.org/account/register/

2. **API Tokens**: Create API tokens for uploading:
   - TestPyPI: https://test.pypi.org/manage/account/token/
   - PyPI: https://pypi.org/manage/account/token/

3. **Install Build Tools**:
   ```bash
   pip install --upgrade build twine
   ```

## Step-by-Step Publishing Process

### 1. Prepare Your Package

```bash
# Ensure you're in the project root
cd nlpcmd_ai

# Install in development mode to test
pip install -e .

# Test the package locally
nlpai "what is my ip"
nlpai -i  # Test interactive mode

# Run tests
pytest tests/ -v
```

### 2. Update Version Number

Edit `pyproject.toml` and update the version:
```toml
[project]
name = "nlpcmd-ai"
version = "0.1.1"  # Increment this for each release
```

Version format: `MAJOR.MINOR.PATCH`
- MAJOR: Breaking changes
- MINOR: New features, backwards compatible
- PATCH: Bug fixes

### 3. Clean Previous Builds

```bash
# Remove old build artifacts
rm -rf build/ dist/ *.egg-info

# Or use make
make clean
```

### 4. Build Distribution Files

```bash
# Build source distribution and wheel
python -m build

# Or use make
make build
```

This creates:
- `dist/nlpcmd_ai-0.1.0.tar.gz` (source distribution)
- `dist/nlpcmd_ai-0.1.0-py3-none-any.whl` (wheel)

### 5. Test on TestPyPI (RECOMMENDED)

```bash
# Upload to TestPyPI
python -m twine upload --repository testpypi dist/*

# You'll be prompted for:
# - Username: __token__
# - Password: Your TestPyPI token (starts with pypi-)
```

Test installation from TestPyPI:
```bash
# Create a new virtual environment
python -m venv test_env
source test_env/bin/activate  # Windows: test_env\Scripts\activate

# Install from TestPyPI
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ nlpcmd-ai

# Test it
nlpai "what is my ip"

# Deactivate and remove test environment
deactivate
rm -rf test_env
```

### 6. Upload to PyPI (Production)

Once you've tested on TestPyPI:

```bash
# Upload to PyPI
python -m twine upload dist/*

# You'll be prompted for:
# - Username: __token__
# - Password: Your PyPI token (starts with pypi-)

# Or use make
make upload
```

### 7. Verify Installation

```bash
# In a new terminal/environment
pip install nlpcmd-ai

# Test it
nlpai --help
nlpai "what is my ip"
```

## Using API Tokens (Recommended)

### Option 1: Environment Variables

```bash
export TWINE_USERNAME=__token__
export TWINE_PASSWORD=pypi-your-token-here
export TWINE_REPOSITORY=pypi  # or testpypi

# Now you can upload without prompts
twine upload dist/*
```

### Option 2: .pypirc File

Create `~/.pypirc`:
```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = pypi-your-production-token

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-your-test-token
```

Then upload:
```bash
twine upload --repository testpypi dist/*  # For testing
twine upload --repository pypi dist/*      # For production
```

## Automated Publishing with GitHub Actions

Create `.github/workflows/publish.yml`:

```yaml
name: Publish to PyPI

on:
  release:
    types: [published]

jobs:
  build-and-publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install build twine
      
      - name: Build package
        run: python -m build
      
      - name: Publish to PyPI
        env:
          TWINE_USERNAME: __token__
          TWINE_PASSWORD: ${{ secrets.PYPI_API_TOKEN }}
        run: twine upload dist/*
```

Add your PyPI token as a GitHub secret:
1. Go to repository Settings → Secrets → Actions
2. Add new secret: `PYPI_API_TOKEN` with your PyPI token

## Release Checklist

Before each release:

- [ ] All tests pass (`pytest tests/`)
- [ ] Code is formatted (`make format`)
- [ ] Linting passes (`make lint`)
- [ ] Version number updated in `pyproject.toml`
- [ ] CHANGELOG.md updated with changes
- [ ] README.md is up to date
- [ ] Examples work correctly
- [ ] Documentation is current
- [ ] Tested on all platforms (Windows, Linux, macOS)
- [ ] Clean build (`make clean`)
- [ ] Build succeeds (`make build`)
- [ ] Uploaded to TestPyPI first
- [ ] Tested installation from TestPyPI
- [ ] Ready for production PyPI

## Common Issues

### Issue: "File already exists"
**Solution**: You can't re-upload the same version. Increment version number.

### Issue: "Invalid authentication"
**Solution**: 
- Make sure username is `__token__`
- Password should be the full token starting with `pypi-`
- Check token has upload permissions

### Issue: "Package name already taken"
**Solution**: Choose a different name in `pyproject.toml`

### Issue: Dependencies not installing
**Solution**: Make sure all dependencies are available on PyPI (not just GitHub)

## Post-Publishing Tasks

After successful publish:

1. **Create Git Tag**:
   ```bash
   git tag -a v0.1.0 -m "Release version 0.1.0"
   git push origin v0.1.0
   ```

2. **Create GitHub Release**:
   - Go to repository → Releases → Create new release
   - Tag: v0.1.0
   - Title: nlpcmd-ai v0.1.0
   - Description: Release notes

3. **Announce**:
   - Social media
   - Reddit (r/Python, r/MachineLearning)
   - Hacker News
   - Dev.to blog post

4. **Monitor**:
   - Watch for GitHub issues
   - Check PyPI download stats
   - Respond to user feedback

## Updating Your Package

For new releases:

1. Make changes
2. Update version in `pyproject.toml`
3. Update CHANGELOG.md
4. Run full test suite
5. Clean and rebuild
6. Upload to TestPyPI
7. Test installation
8. Upload to PyPI
9. Create git tag
10. Create GitHub release

## Quick Commands Reference

```bash
# One-time setup
pip install --upgrade build twine

# For each release
make clean                    # Clean old builds
make build                    # Build distributions
make upload                   # Upload to PyPI (prompts for credentials)

# Or manually
python -m build
python -m twine upload --repository testpypi dist/*  # Test first
python -m twine upload dist/*                        # Production
```

## Useful Links

- PyPI: https://pypi.org/
- TestPyPI: https://test.pypi.org/
- Packaging Guide: https://packaging.python.org/
- Twine Documentation: https://twine.readthedocs.io/
- PEP 517/518: https://www.python.org/dev/peps/pep-0517/

## Support

If you encounter issues:
1. Check the [Python Packaging Guide](https://packaging.python.org/)
2. Search [PyPI Packaging Help](https://github.com/pypa/packaging-problems/issues)
3. Open an issue in the repository

Good luck with your PyPI release! 🚀
