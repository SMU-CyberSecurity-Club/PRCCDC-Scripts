# powershell script to run windows updates
#
#  *** AI Generated Content  *** - Needs validation and testing
#
<#
.SYNOPSIS
    Comprehensive Windows System Update Script
.DESCRIPTION
    This script performs various update operations on a Windows system including:
    - Windows Updates
    - Windows Defender definitions
    - PowerShell modules
    - System drivers (optional)
.PARAMETER InstallUpdates
    If set, automatically installs available updates
.PARAMETER IncludeDrivers
    If set, checks for driver updates
.PARAMETER Verbose
    Enables verbose output
.EXAMPLE
    .\Update-WindowsSystem.ps1 -InstallUpdates -IncludeDrivers
.NOTES
    Requires administrative privileges
    Created: 2026-03-25
#>

param(
    [switch]$InstallUpdates,
    [switch]$IncludeDrivers,
    [switch]$Verbose
)

# Requires administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as Administrator. Please restart PowerShell as Administrator." -ForegroundColor Red
    exit 1
}

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Windows System Update Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Function to check Windows Updates
function Check-WindowsUpdates {
    Write-Host "[*] Checking for Windows Updates..." -ForegroundColor Yellow
    
    try {
        # Create COM object for Windows Update
        $UpdateSession = New-Object -ComObject Microsoft.Update.Session
        $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
        
        Write-Host "    Searching for updates..." -ForegroundColor Gray
        $SearchResult = $UpdateSearcher.Search("IsInstalled=0")
        
        $UpdateCount = $SearchResult.Updates.Count
        
        if ($UpdateCount -gt 0) {
            Write-Host "    Found $UpdateCount update(s) available" -ForegroundColor Green
            
            if ($Verbose) {
                $SearchResult.Updates | ForEach-Object {
                    Write-Host "    - $($_.Title)" -ForegroundColor Gray
                }
            }
            
            if ($InstallUpdates) {
                Write-Host "    Installing updates..." -ForegroundColor Yellow
                $UpdateInstaller = $UpdateSession.CreateUpdateInstaller()
                $UpdateInstaller.Updates = $SearchResult.Updates
                $InstallResult = $UpdateInstaller.Install()
                
                if ($InstallResult.ResultCode -eq 2) {
                    Write-Host "    ✓ Updates installed successfully" -ForegroundColor Green
                } else {
                    Write-Host "    ✗ Update installation incomplete (Result Code: $($InstallResult.ResultCode))" -ForegroundColor Yellow
                }
                
                # Check if reboot is required
                if ($InstallResult.RebootRequired) {
                    Write-Host "    ! System reboot required" -ForegroundColor Red
                }
            } else {
                Write-Host "    Use -InstallUpdates flag to install available updates" -ForegroundColor Cyan
            }
        } else {
            Write-Host "    ✓ System is up to date" -ForegroundColor Green
        }
    } catch {
        Write-Host "    ✗ Error checking Windows Updates: $_" -ForegroundColor Red
    }
}

# Function to update Windows Defender definitions
function Update-WindowsDefender {
    Write-Host "[*] Updating Windows Defender definitions..." -ForegroundColor Yellow
    
    try {
        Update-MpSignature -ErrorAction Stop
        Write-Host "    ✓ Windows Defender definitions updated successfully" -ForegroundColor Green
    } catch {
        Write-Host "    ✗ Error updating Windows Defender: $_" -ForegroundColor Red
    }
}

# Function to update PowerShell modules
function Update-PowerShellModules {
    Write-Host "[*] Checking for PowerShell module updates..." -ForegroundColor Yellow
    
    try {
        # Check if PowerShellGet is available
        if (Get-Module -Name PowerShellGet -ListAvailable) {
            Write-Host "    Searching for module updates..." -ForegroundColor Gray
            $Modules = Get-InstalledModule
            $UpdateCount = 0
            
            foreach ($Module in $Modules) {
                $LatestVersion = Find-Module -Name $Module.Name -ErrorAction SilentlyContinue
                
                if ($LatestVersion -and [version]$LatestVersion.Version -gt [version]$Module.Version) {
                    $UpdateCount++
                    
                    if ($Verbose) {
                        Write-Host "    - $($Module.Name): $($Module.Version) → $($LatestVersion.Version)" -ForegroundColor Gray
                    }
                    
                    if ($InstallUpdates) {
                        Update-Module -Name $Module.Name -Force -ErrorAction SilentlyContinue
                        Write-Host "    ✓ Updated $($Module.Name)" -ForegroundColor Green
                    }
                }
            }
            
            if ($UpdateCount -eq 0) {
                Write-Host "    ✓ All modules are up to date" -ForegroundColor Green
            } elseif (-not $InstallUpdates) {
                Write-Host "    Found $UpdateCount module(s) with available updates" -ForegroundColor Cyan
                Write-Host "    Use -InstallUpdates flag to update modules" -ForegroundColor Cyan
            }
        } else {
            Write-Host "    ! PowerShellGet not available" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "    ✗ Error checking module updates: $_" -ForegroundColor Red
    }
}

# Function to check driver updates (optional)
function Check-DriverUpdates {
    Write-Host "[*] Checking for driver updates..." -ForegroundColor Yellow
    
    try {
        # Note: Windows Update now handles most drivers
        Write-Host "    Drivers are typically managed through Windows Update" -ForegroundColor Gray
        
        # Get list of devices with outdated drivers
        $OutdatedDevices = Get-PnpDevice | Where-Object { $_.Status -eq "Error" }
        
        if ($OutdatedDevices) {
            Write-Host "    Found $($OutdatedDevices.Count) device(s) with potential issues:" -ForegroundColor Yellow
            $OutdatedDevices | ForEach-Object {
                Write-Host "    - $($_.Name) (Class: $($_.Class))" -ForegroundColor Gray
            }
        } else {
            Write-Host "    ✓ No devices with driver errors detected" -ForegroundColor Green
        }
    } catch {
        Write-Host "    ✗ Error checking drivers: $_" -ForegroundColor Red
    }
}

# Function to display system information
function Show-SystemInfo {
    Write-Host "[*] System Information:" -ForegroundColor Yellow
    
    try {
        $OSInfo = Get-WmiObject -Class Win32_OperatingSystem
        $SystemInfo = Get-WmiObject -Class Win32_ComputerSystem
        
        Write-Host "    Computer Name: $($SystemInfo.Name)" -ForegroundColor Gray
        Write-Host "    OS: $($OSInfo.Caption)" -ForegroundColor Gray
        Write-Host "    Version: $($OSInfo.Version)" -ForegroundColor Gray
        Write-Host "    Build: $($OSInfo.BuildNumber)" -ForegroundColor Gray
        Write-Host "    PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Gray
    } catch {
        Write-Host "    ✗ Error retrieving system info: $_" -ForegroundColor Red
    }
}

# Main execution
Show-SystemInfo
Write-Host ""

Check-WindowsUpdates
Write-Host ""

Update-WindowsDefender
Write-Host ""

Update-PowerShellModules
Write-Host ""

if ($IncludeDrivers) {
    Check-DriverUpdates
    Write-Host ""
}

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Update Check Complete" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

if ($InstallUpdates) {
    Write-Host "Consider restarting your system to complete all updates" -ForegroundColor Yellow
}
