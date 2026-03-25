# script to edit  /create cron jobs for root account in linux 
#
#   **** AI Generated Content Below  **** - needs validation and testing
#
#!/bin/bash

# Script to add a Python script to root crontab to run once per hour
# This script must be run with sudo or as root

# Configuration
PYTHON_SCRIPT_PATH="/path/to/your/script.py"  # Update this with your actual Python script path
CRON_SCHEDULE="0 * * * *"  # Runs at minute 0 of every hour

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# Check if the Python script exists
if [[ ! -f "$PYTHON_SCRIPT_PATH" ]]; then
   echo "Error: Python script not found at $PYTHON_SCRIPT_PATH"
   exit 1
fi

# Get the absolute path of the Python script
PYTHON_SCRIPT_ABS=$(cd "$(dirname "$PYTHON_SCRIPT_PATH")" && pwd)/$(basename "$PYTHON_SCRIPT_PATH")

# Create a temporary file to store the new crontab
TEMP_CRONTAB=$(mktemp)

# Backup the current root crontab (optional but recommended)
sudo crontab -l > /root/crontab.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true

# Get the current root crontab and append the new entry
# Only add if it doesn't already exist
sudo crontab -l 2>/dev/null > "$TEMP_CRONTAB" || true

# Check if the Python script entry already exists
if ! grep -q "$PYTHON_SCRIPT_ABS" "$TEMP_CRONTAB"; then
    echo "$CRON_SCHEDULE /usr/bin/python3 $PYTHON_SCRIPT_ABS" >> "$TEMP_CRONTAB"
    echo "Added Python script to crontab"
else
    echo "Python script already exists in crontab"
fi

# Install the updated crontab
sudo crontab "$TEMP_CRONTAB"

# Clean up temporary file
rm "$TEMP_CRONTAB"

echo "Crontab updated successfully!"
echo "Python script will now run hourly at minute 0"
echo "To view the crontab, run: sudo crontab -l"
