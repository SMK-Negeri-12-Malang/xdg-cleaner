# AGENTS.md - Coding Guidelines for Linux XDG Config Cleaner

## Project Overview
- **Type**: Bash CLI tool
- **Purpose**: Clean up residual XDG config files for uninstalled packages
- **Spec**: See `agents/spec.md` for detailed requirements

## Code Style Guidelines

### Script Structure
- Use `#!/usr/bin/env bash` shebang
- Enable strict mode: `set -euo pipefail`
- Define functions at top, main execution at bottom
- Use `main()` function as entry point

### Naming Conventions
- **Functions**: `snake_case()` with descriptive names
- **Variables**: `snake_case` for locals, `UPPER_CASE` for constants/exports
- **Constants**: `readonly MAX_RETRIES=3`
- **Private functions**: prefix with underscore `_helper_func()`

### Safety & Error Handling
- Always check for root: `[[ $EUID -eq 0 ]] && exit 1`
- Validate inputs before use
- Use `[[ ]]` for conditionals, not `[ ]`
- Quote all variables: `"$variable"`
- Use `trap` for cleanup on exit
- Fail fast: `set -euo pipefail`

### XDG Path Handling
- Use `$HOME` not `~` in scripts
- Check paths exist before scanning: `[[ -d "$HOME/.config" ]]`
- Never scan system paths (`/etc`, `/`, `/usr`)
- Use case-insensitive matching carefully

### User Interaction
- Always show dry-run results before prompting
- Default to safe option (N for No)
- Provide clear usage with `--help`
- Give immediate visual feedback on actions

### Comments
- Use `#` for comments
- Document function purpose with `##`
- Explain complex logic or safety checks

### Example Pattern
```bash
#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

## Search for package config directories
## Args: $1 - package name
## Returns: 0 if found, 1 otherwise
find_configs() {
    local package="$1"
    # Implementation
}

main() {
    # Root check
    if [[ $EUID -eq 0 ]]; then
        echo "Error: Do not run as root" >&2
        exit 1
    fi
    # Main logic
}

main "$@"
```
