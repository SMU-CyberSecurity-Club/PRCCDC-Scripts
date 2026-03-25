# script to change passwords using powershell of all windows users 
# 
#  **** AI Content Below - Needs validation ****
#  Further work needed - script either needs to pull a list of usernames from the system, or we need to have a username text file it iterates through
#
# PowerShell script to change password to a randomly selected one from a password file
# Usage: .\change-password.ps1 -AccountName "username" -PasswordFile "C:\path\to\passwords.txt"

param(
    [Parameter(Mandatory=$true)]
    [string]$AccountName,
    
    [Parameter(Mandatory=$true)]
    [string]$PasswordFile,
    
    [string]$LogFile = "C:\Logs\password-change.log"
)

# Function to log messages
function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] $Message"
    Write-Host $logMessage
    Add-Content -Path $LogFile -Value $logMessage -ErrorAction SilentlyContinue
}

# Validate password file exists
if (-not (Test-Path $PasswordFile)) {
    Write-Log "ERROR: Password file not found at $PasswordFile"
    exit 1
}

# Read passwords from file
try {
    $passwords = @(Get-Content $PasswordFile | Where-Object { $_.Trim() -ne "" })
    Write-Log "Successfully read $($passwords.Count) passwords from file"
} catch {
    Write-Log "ERROR: Failed to read password file - $_"
    exit 1
}

# Validate passwords were loaded
if ($passwords.Count -eq 0) {
    Write-Log "ERROR: No valid passwords found in file"
    exit 1
}

# Select random password
$randomIndex = Get-Random -Minimum 0 -Maximum $passwords.Count
$newPassword = $passwords[$randomIndex]
Write-Log "Selected password from index $randomIndex"

# Validate account exists
try {
    $user = Get-LocalUser -Name $AccountName -ErrorAction Stop
    Write-Log "Account '$AccountName' found"
} catch {
    Write-Log "ERROR: Account '$AccountName' not found - $_"
    exit 1
}

# Convert password to secure string and change it
try {
    $securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
    $user | Set-LocalUser -Password $securePassword
    Write-Log "Successfully changed password for account '$AccountName'"
} catch {
    Write-Log "ERROR: Failed to change password for '$AccountName' - $_"
    exit 1
}

Write-Log "Password change operation completed successfully"
exit 0
