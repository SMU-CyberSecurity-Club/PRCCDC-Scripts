# bash script to update system (OS agnostic)
#
#  **** AI Generated Content **** - needs validation and testing
#
#!/bin/bash

# OS Detection and Update Script
# This script detects the Linux distribution and runs appropriate updates

# Function to update Debian/Ubuntu
update_debian() {
    echo "Updating Debian/Ubuntu..."
    sudo apt update && sudo apt upgrade -y
}

# Function to update Red Hat/CentOS/Fedora
update_redhat() {
    echo "Updating Red Hat/CentOS/Fedora..."
    sudo dnf update -y
}

# Function to update Arch Linux
update_arch() {
    echo "Updating Arch Linux..."
    sudo pacman -Syu --noconfirm
}

# Function to update Alpine Linux
update_alpine() {
    echo "Updating Alpine Linux..."
    sudo apk update && sudo apk upgrade
}

# Detect the Linux distribution
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    case $ID in
        ubuntu|debian)
            update_debian
            ;;
        rhel|centos|fedora)
            update_redhat
            ;;
        arch)
            update_arch
            ;;
        alpine)
            update_alpine
            ;;
        *)
            echo "Unsupported OS: $ID"
            exit 1
            ;;
    esac
else
    echo "Unable to detect the operating system."
    exit 1
fi

echo "Update completed successfully!"
