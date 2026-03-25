#!/usr/bin/env python3
"""
Python script to change every user's password in Linux
Pulls all usernames and resets passwords with randomly selected entries from a password list
Runs completely automatically without user input or confirmation
"""

import pwd
import random
import subprocess
import sys
import os

def read_passwords_from_file(file_path):
    """Read passwords from a file (one per line)"""
    try:
        with open(file_path, 'r') as f:
            passwords = [line.strip() for line in f if line.strip()]
        if not passwords:
            print("Error: No passwords found in file")
            sys.exit(1)
        return passwords
    except FileNotFoundError:
        print(f"Error: Password file not found: {file_path}")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading password file: {e}")
        sys.exit(1)

def get_system_users():
    """Get all regular system users (UID >= 1000)"""
    users = []
    try:
        for user in pwd.getwall():
            # Skip system users and root (UID < 1000)
            if user.pw_uid >= 1000:
                users.append(user.pw_name)
    except Exception as e:
        print(f"Error retrieving user list: {e}")
        sys.exit(1)
    return users

def change_password(username, password):
    """Change user password using chpasswd"""
    try:
        process = subprocess.Popen(['chpasswd'], stdin=subprocess.PIPE, text=True)
        process.communicate(input=f'{username}:{password}\n')
        if process.returncode == 0:
            print(f"[SUCCESS] Password changed for: {username}")
            return True
        else:
            print(f"[FAILED] Could not change password for: {username}")
            return False
    except Exception as e:
        print(f"[ERROR] Exception changing password for {username}: {e}")
        return False

def main():
    # Check if running as root
    if os.geteuid() != 0:
        print("Error: This script must be run as root (use sudo)")
        sys.exit(1)
    
    # Check if password file argument provided
    if len(sys.argv) < 2:
        print("Usage: sudo python3 change-password.py <password_file>")
        sys.exit(1)
    
    password_file = sys.argv[1]
    
    # Read passwords
    passwords = read_passwords_from_file(password_file)
    print(f"Loaded {len(passwords)} passwords from file")
    
    # Get system users
    users = get_system_users()
    print(f"Found {len(users)} regular users to update")
    
    # Change passwords automatically
    successful = 0
    failed = 0
    
    for username in users:
        selected_password = random.choice(passwords)
        if change_password(username, selected_password):
            successful += 1
        else:
            failed += 1
    
    # Summary
    print(f"\n--- Summary ---")
    print(f"Successfully changed: {successful}")
    print(f"Failed: {failed}")

if __name__ == "__main__":
    main()
