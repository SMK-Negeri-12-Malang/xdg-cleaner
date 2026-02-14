# xdg-cleaner

A CLI tool to clean up residual XDG configuration files left behind by uninstalled packages.


## Why Use This Tool?

When you uninstall software on Linux, package managers often leave behind configuration files in XDG directories.
If you want to clean uninstall the software, this tool is what used for
it will automaticly delete configuration files in XDG directories
(`~/.config`, `~/.local/share`, `~/.cache`).

**⚠️ WARNING:** I vibe coding this tool so i have no idea what's going on in here, maybe a little :). 
> Make sure you have a backup before proceeding.


## Installation Guide

### Prerequisites

- Bash 4.0 or higher
- Linux system with standard XDG directories

### Step 1: Download

Download the [repository](https://github.com/SMK-Negeri-12-Malang/xdg-cleaner/) to your machine and extract the repository:

```bash
unzip xdg-cleaner
cd xdg-cleaner-master
```

### Step 2: Install

Run the install script to install `cleaner` to `~/.local/bin`:

```bash
chmod +x install.sh
./install.sh
```

### Step 3: Update PATH (if needed)

If you see a warning about PATH, add this to your shell config:

```bash
# For bash (~/.bashrc)
export PATH="$HOME/.local/bin:$PATH"

# For zsh (~/.zshrc)
export PATH="$HOME/.local/bin:$PATH"
```

Then reload your shell:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

## Usage Guide

### Basic Usage

```bash
cleaner <package_name>
```

The tool searches for directories matching your package name in XDG directories and prompts before deletion.

### Common Examples

```bash
# Remove firefox configs after deleting the application
cleaner firefox
```

### Command Options

```
-h, --help      Show help message and usage examples
-v, --version   Display version information
```


## Safety Features

We've built in multiple safeguards to prevent accidental data loss:

### 1. **No Root Execution**
- The tool refuses to run as root user
- Prevents system-wide accidental deletions

### 2. **Minimum Name Length**
- Package names must be at least 2 characters
- Prevents overly broad searches (e.g., "a" matching too many directories)

### 3. **Preview Before Delete**
- Always shows all matching paths before any action
- You see exactly what will be affected

### 4. **Explicit Confirmation**
- Defaults to "No" (safe option)
- Must explicitly type "y" or "yes" to proceed
- One typo won't cause accidental deletion

### 5. **Case-Insensitive Matching**
- Finds configs regardless of capitalization
- Catches variations like "Firefox", "firefox", or "FIREFOX"




## Troubleshooting

### "command not found: cleaner"

Make sure `~/.local/bin` is in your PATH:

```bash
echo $PATH | grep ".local/bin"
```

If not found, add it to your shell config (see Installation Step 3).

### "No configuration files found"

The package may use a different name for its config directory. Try variations:

```bash
cleaner firefox        # Try lowercase
cleaner Firefox        # Try capitalized
cleaner mozilla        # Try the vendor name
```

### "Error: Package name must be at least 2 characters"

This is a safety feature. Use the full package name instead of abbreviations.
