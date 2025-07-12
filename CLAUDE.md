# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a DevContainer template for setting up clean, reproducible development environments with Claude Code, MCP servers, and secure credential management. The template uses Docker containers to isolate development environments and prevent credential leakage to Git repositories.

## Environment Setup

### Development Environment Startup

**DevContainer (Recommended):**
- Open repository in VS Code
- Use Command Palette: "Dev Containers: Rebuild Without Cache and Reopen in Container"
- Environment variables from `.aws.env` and `.env` are automatically loaded

**Docker Compose Alternative:**
```bash
docker compose up -d --build
```

### Required Configuration Files

Before starting development, ensure these files exist (they are Git-ignored):

1. **`.aws.env`** - AWS credentials for Bedrock access:
```bash
cp .aws.env.sample .aws.env
# Edit with actual AWS credentials
```

2. **`.env`** - API keys for MCP servers:
```bash
cp .env.sample .env  
# Edit with actual API keys (e.g., OPENAI_API_KEY, GITHUB_PERSONAL_ACCESS_TOKEN)
```

## Architecture

### Container Architecture
- **Base**: Python 3.13 with uv package manager
- **Development Tools**: Claude Code CLI, AWS CLI v2, vim
- **MCP Integration**: o3-search-mcp server configured via `.mcp.json`
- **Security**: Credentials injected via environment variables, never committed to Git

### CPU Architecture Notes
The Dockerfile is configured for aarch64 (Apple Silicon). For x86_64 systems, uncomment the x86_64 AWS CLI installation section in the Dockerfile and comment out the aarch64 section.

### Key Files
- **`Dockerfile`**: Multi-stage build with development tools
- **`compose.yaml`**: Docker Compose configuration with environment file loading
- **`.mcp.json`**: MCP server configuration for Claude Code
- **`pyproject.toml`**: Python project dependencies managed by uv

## Development Commands

### Python Development
```bash
# Install dependencies
uv sync --dev

# Add new dependency  
uv add <package-name>

# Run Python code
uv run python <script.py>

# Code formatting and linting
ruff check .
ruff format .

# Run linting with auto-fix
ruff check . --fix

# Check specific files
ruff check path/to/file.py
```

### Claude Code Usage
```bash
# Start Claude Code interactive session
claude

# Claude Code with Bedrock is pre-configured via CLAUDE_CODE_USE_BEDROCK=1
# MCP servers (like o3-search) are automatically available
```

### Container Management
```bash
# Rebuild container with latest changes
docker compose up -d --build

# View container logs
docker compose logs -f

# Access container shell
docker compose exec app bash
```

## Security Guidelines

- **Never commit** `.env` or `.aws.env` files
- All sensitive credentials are passed via environment variables
- MCP server API keys are injected at runtime, not stored in `.mcp.json`
- Git configuration is mounted read-only from host

## MCP Server Configuration

The template includes o3-search-mcp server configuration and context7 MCP server. To add additional MCP servers:

1. Update `.mcp.json` with new server configuration
2. Add required environment variables to `.env` file
3. Rebuild container to pick up changes

Environment variables are automatically available to MCP servers without explicit configuration in `.mcp.json`.

### Context7 Documentation Management

Context7 MCP server provides access to up-to-date library documentation. Retrieved documentation is saved locally for reference:

- **Storage Location**: `.claude/private/context7/`
- **Usage**: Documentation retrieved via context7 is automatically saved as Markdown files
- **Purpose**: Enables offline access to library documentation and maintains a knowledge base of retrieved information
- **Best Practice**: Refer to saved documentation when working with libraries to ensure consistency and reduce API calls

## Code Quality and Pre-commit Hooks

The project includes pre-commit hooks for consistent code quality:

```bash
# Install pre-commit hooks (done automatically in DevContainer)
pre-commit install

# Run pre-commit hooks on all files
pre-commit run --all-files

# Run pre-commit hooks on staged files
pre-commit run
```

Ruff configuration in `ruff.toml` provides comprehensive linting with Python 3.13 compatibility and Black-style formatting.
