#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SOURCE_FILE="${SCRIPT_DIR}/cmd/cleaner"
readonly INSTALL_DIR="${HOME}/.local/bin"
readonly TARGET_FILE="${INSTALL_DIR}/cleaner"


## Check if ~/.local/bin is in PATH
check_path() {
    if [[ ":${PATH}:" != *":${INSTALL_DIR}:"* ]]; then
        echo "Warning: ${INSTALL_DIR} is not in your PATH"
        echo ""
        echo "Add this to your ~/.bashrc or ~/.zshrc:"
        echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo ""
    fi
}

## Verify source exists
verify_source() {
    if [[ ! -f "$SOURCE_FILE" ]]; then
        echo "Error: Source file not found: ${SOURCE_FILE}" >&2
        exit 1
    fi
}


## Install cleaner
install() {
    echo "Installing cleaner..."

    verify_source

    # Create directory
    mkdir -p "$INSTALL_DIR"

    # Copy and make executable
    cp "$SOURCE_FILE" "$TARGET_FILE"
    chmod +x "$TARGET_FILE"

    echo ""
    echo "cleaner installed to: ${TARGET_FILE}"
    echo ""

    check_path
}


main() {
  install
}

main "$@"
