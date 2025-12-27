#!/usr/bin/env python3
"""
Demo script for nlpcmd-ai

This script demonstrates various features and usage patterns.
Run without API keys to see dry-run examples.
"""

import os
import sys
from pathlib import Path

# Add parent directory to path for local testing
sys.path.insert(0, str(Path(__file__).parent.parent))

from nlpcmd_ai.config import Config
from nlpcmd_ai.engine import AIEngine, CommandIntent
from nlpcmd_ai.base_handler import HandlerRegistry, CommandResult
from rich.console import Console
from rich.panel import Panel
from rich.table import Table

console = Console()


def print_section(title: str):
    """Print a section header"""
    console.print(f"\n[bold cyan]{'='*60}[/bold cyan]")
    console.print(f"[bold cyan]{title}[/bold cyan]")
    console.print(f"[bold cyan]{'='*60}[/bold cyan]\n")


def demo_intent_parsing():
    """Demonstrate intent parsing"""
    print_section("Intent Parsing Demo")
    
    # Create sample intents
    intents = [
        CommandIntent(
            category="file_operation",
            action="list",
            parameters={"path": "."},
            confidence=0.95,
            original_query="list all python files",
            suggested_command="find . -name '*.py'",
            explanation="Find all Python files in current directory",
            requires_confirmation=False
        ),
        CommandIntent(
            category="network",
            action="get_ip",
            parameters={},
            confidence=0.90,
            original_query="what is my ip address",
            suggested_command="curl -s https://api.ipify.org",
            explanation="Get your public IP address",
            requires_confirmation=False
        ),
        CommandIntent(
            category="file_operation",
            action="delete",
            parameters={"pattern": "*.log"},
            confidence=0.85,
            original_query="delete all log files",
            suggested_command="find . -name '*.log' -delete",
            explanation="Delete all log files recursively",
            requires_confirmation=True
        ),
    ]
    
    for intent in intents:
        table = Table(title=f"Query: '{intent.original_query}'")
        table.add_column("Property", style="cyan")
        table.add_column("Value", style="green")
        
        table.add_row("Category", intent.category)
        table.add_row("Action", intent.action)
        table.add_row("Command", intent.suggested_command or "N/A")
        table.add_row("Confidence", f"{intent.confidence:.0%}")
        table.add_row("Needs Confirmation", "Yes" if intent.requires_confirmation else "No")
        table.add_row("Explanation", intent.explanation or "N/A")
        
        console.print(table)
        console.print()


def demo_handlers():
    """Demonstrate different handlers"""
    print_section("Handler Execution Demo")
    
    from nlpcmd_ai.handlers import FileHandler, NetworkHandler, SystemInfoHandler
    
    # File Handler Demo
    console.print("[bold]File Handler:[/bold]")
    file_handler = FileHandler()
    console.print(f"Can handle file_operation: {file_handler.can_handle('file_operation', 'list')}")
    console.print(f"Can handle network: {file_handler.can_handle('network', 'ping')}")
    
    # Network Handler Demo
    console.print("\n[bold]Network Handler:[/bold]")
    net_handler = NetworkHandler()
    
    # Get IP (this actually works without API)
    result = net_handler._get_ip_address(dry_run=False)
    console.print(f"IP Address Result: {result.output if result.success else result.error}")
    
    # System Info Handler Demo
    console.print("\n[bold]System Info Handler:[/bold]")
    sys_handler = SystemInfoHandler()
    
    # Get disk usage
    result = sys_handler._get_disk_usage({"path": "."}, dry_run=False)
    console.print(f"Disk Usage:\n{result.output if result.success else result.error}")


def demo_handler_registry():
    """Demonstrate handler registry"""
    print_section("Handler Registry Demo")
    
    registry = HandlerRegistry()
    
    console.print(f"[bold]Total handlers registered:[/bold] {len(registry.handlers)}")
    
    # Test finding handlers
    test_cases = [
        ("file_operation", "list"),
        ("network", "ping"),
        ("system_info", "disk_usage"),
        ("development", "git_status"),
        ("unknown", "action"),
    ]
    
    table = Table(title="Handler Resolution")
    table.add_column("Category", style="cyan")
    table.add_column("Action", style="yellow")
    table.add_column("Handler Found", style="green")
    
    for category, action in test_cases:
        handler = registry.get_handler(category, action)
        found = "✅ Yes" if handler else "❌ No"
        if handler:
            found += f" ({handler.__class__.__name__})"
        table.add_row(category, action, found)
    
    console.print(table)


def demo_configuration():
    """Demonstrate configuration"""
    print_section("Configuration Demo")
    
    config = Config()
    
    table = Table(title="Current Configuration")
    table.add_column("Setting", style="cyan")
    table.add_column("Value", style="green")
    
    table.add_row("AI Provider", config.ai_provider)
    table.add_row("AI Model", config.ai_model or "Default")
    table.add_row("Require Confirmation", "Yes" if config.require_confirmation else "No")
    table.add_row("Dry Run Mode", "Yes" if config.dry_run_mode else "No")
    table.add_row("Log Commands", "Yes" if config.log_commands else "No")
    table.add_row("Custom Handlers Path", config.custom_handlers_path or "None")
    
    console.print(table)
    
    # Test dangerous command detection
    console.print("\n[bold]Dangerous Command Detection:[/bold]")
    
    test_commands = [
        "ls -la",
        "rm -rf /",
        "echo 'hello'",
        "dd if=/dev/zero of=/dev/sda",
        "find . -name '*.py'",
    ]
    
    for cmd in test_commands:
        is_dangerous = config.is_dangerous_command(cmd)
        status = "⚠️  Dangerous" if is_dangerous else "✅ Safe"
        console.print(f"{status}: {cmd}")


def demo_example_queries():
    """Show example queries and their potential interpretations"""
    print_section("Example Natural Language Queries")
    
    examples = [
        {
            "query": "what is my ip address",
            "category": "network",
            "action": "get_ip",
            "command": "curl -s https://api.ipify.org",
        },
        {
            "query": "list all python files larger than 1MB",
            "category": "file_operation",
            "action": "find",
            "command": "find . -name '*.py' -size +1M",
        },
        {
            "query": "show me disk usage",
            "category": "system_info",
            "action": "disk_usage",
            "command": "df -h",
        },
        {
            "query": "create a git branch called feature/authentication",
            "category": "development",
            "action": "git_branch",
            "command": "git checkout -b feature/authentication",
        },
        {
            "query": "compress all log files from last month",
            "category": "file_operation",
            "action": "compress",
            "command": "find . -name '*.log' -mtime +30 -exec gzip {} \\;",
        },
    ]
    
    table = Table(title="Example Queries → Commands")
    table.add_column("Natural Language", style="cyan", width=40)
    table.add_column("Category", style="yellow", width=15)
    table.add_column("Generated Command", style="green", width=40)
    
    for example in examples:
        table.add_row(
            example["query"],
            example["category"],
            example["command"]
        )
    
    console.print(table)


def demo_safety_features():
    """Demonstrate safety features"""
    print_section("Safety Features Demo")
    
    console.print("[bold]1. Command Confirmation[/bold]")
    console.print("   - Dangerous operations require explicit confirmation")
    console.print("   - Configurable danger patterns")
    console.print()
    
    console.print("[bold]2. Dry Run Mode[/bold]")
    console.print("   - Test commands without executing")
    console.print("   - See what would happen")
    console.print()
    
    console.print("[bold]3. Path Validation[/bold]")
    console.print("   - Prevents operations on critical system directories")
    console.print("   - Protects /bin, /etc, C:\\Windows, etc.")
    console.print()
    
    console.print("[bold]4. Command Logging[/bold]")
    console.print("   - All commands logged with timestamp")
    console.print("   - Audit trail for security")
    console.print()
    
    console.print("[bold]5. Confidence Scoring[/bold]")
    console.print("   - AI reports confidence in understanding")
    console.print("   - Low confidence triggers warning")


def main():
    """Run all demos"""
    console.print(Panel(
        "[bold blue]nlpcmd-ai Demo Script[/bold blue]\n"
        "Demonstrating features and capabilities\n"
        "This demo works without API keys",
        border_style="blue"
    ))
    
    try:
        demo_intent_parsing()
        demo_handlers()
        demo_handler_registry()
        demo_configuration()
        demo_example_queries()
        demo_safety_features()
        
        console.print("\n[bold green]✅ Demo completed successfully![/bold green]")
        console.print("\n[bold]Next Steps:[/bold]")
        console.print("1. Set up your API key in .env")
        console.print("2. Try: nlpai 'what is my ip address'")
        console.print("3. Start interactive mode: nlpai -i")
        console.print("4. Read QUICKSTART.md for more examples")
        
    except Exception as e:
        console.print(f"\n[bold red]❌ Demo error: {str(e)}[/bold red]")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    main()
