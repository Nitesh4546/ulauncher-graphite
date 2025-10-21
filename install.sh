#!/bin/bash

# --- Configuration (UPDATE THIS SECTION) ---
REPO_URL="https://github.com/YourUsername/ulauncher-graphite.git" # <-- CHANGE THIS
TARGET_DIR="$HOME/.config/ulauncher/user-themes/"
TEMP_DIR="ulauncher-graphite-temp"
FOLDER_1="graphite-dark"
FOLDER_2="graphite-light"
# -------------------------------------------

echo "--- Ulauncher Graphite Theme Installer ---"

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "Error: 'git' command not found. Please install git and try again."
    exit 1
fi

# 1. Clean up any previous temporary clone directory
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

# 2. Clone the repository into the temporary directory
echo "Cloning themes from repository..."
if ! git clone --depth 1 "$REPO_URL" "$TEMP_DIR"; then
    echo "Error: Failed to clone the repository. Check the URL and connection."
    rm -rf "$TEMP_DIR"
    exit 1
fi

# 3. Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# 4. Move the two theme folders
echo "Installing themes to Ulauncher directory..."

# Check and move FOLDER_1
if [ -d "$TEMP_DIR/$FOLDER_1" ]; then
    mv "$TEMP_DIR/$FOLDER_1" "$TARGET_DIR"
    echo "  - Installed: $FOLDER_1"
else
    echo "Warning: Theme folder '$FOLDER_1' not found in the repository clone."
fi

# Check and move FOLDER_2
if [ -d "$TEMP_DIR/$FOLDER_2" ]; then
    mv "$TEMP_DIR/$FOLDER_2" "$TARGET_DIR"
    echo "  - Installed: $FOLDER_2"
else
    echo "Warning: Theme folder '$FOLDER_2' not found in the repository clone."
fi

# 5. Clean up
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "------------------------------------------"
echo "✅ Done! Themes should now be available in Ulauncher settings."
exit 0
