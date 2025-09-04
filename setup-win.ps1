# ===================================================================
# Chisel Bootcamp Automated Setup Script (for Windows PowerShell) - Revised
# ===================================================================
# Usage:
# 1. Save this code as a setup.ps1 file.
# 2. Open PowerShell with 'Run as Administrator'.
# 3. Navigate to the folder containing the script (e.g., cd C:\Users\YourUser\Downloads).
# 4. Change the execution policy: Set-ExecutionPolicy Unrestricted -Scope Process
# 5. Run the script: .\setup.ps1
# ===================================================================

# --- Script Configuration ---
$ErrorActionPreference = 'Stop' # Stop immediately if an error occurs
$installDir = "$PSScriptRoot\bootcamp_setup_files" # Temporary folder to store downloaded and installation files
if (-not (Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir }
cd $installDir

# --- Function: Refresh Environment Variables (PATH) ---
# Since installers modify the PATH but it doesn't apply to the current PowerShell session,
# this function reloads the PATH without needing to restart the terminal.
function Refresh-Path {
    Write-Host "[INFO] Refreshing environment variables (PATH) for the current session..." -ForegroundColor Cyan
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}


# =================================================
# Step 1: Install Prerequisites
# =================================================

Write-Host "=================================================" -ForegroundColor Green
Write-Host "Step 1: Starting prerequisite installation." -ForegroundColor Green
Write-Host "================================================="

# --- 1.1. Install Java Development Kit (JDK) 8 ---
Write-Host "[1.1] Downloading and installing JDK 8..." -ForegroundColor Yellow
$jdkUrl = "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u422-b05/OpenJDK8U-jdk_x64_windows_hotspot_8u422b05.msi"
$jdkFile = "OpenJDK8U-jdk.msi"
Invoke-WebRequest -Uri $jdkUrl -OutFile $jdkFile
Start-Process msiexec.exe -ArgumentList "/i `"$jdkFile`" /qn" -Wait
Write-Host "[SUCCESS] JDK 8 installation complete." -ForegroundColor Green

# --- 1.1.1. Set Java Path ---
Write-Host "[INFO] Setting JAVA_HOME environment variable..." -ForegroundColor Cyan
$JavaHomePath = "C:\Program Files\Eclipse Adoptium\jdk-8.0.462.8-hotspot"
$env:JAVA_HOME = $JavaHomePath
$env:Path = "$($JavaHomePath)\bin;" + $env:Path
Write-Host "[SUCCESS] JAVA_HOME set to '$JavaHomePath'" -ForegroundColor Green

# --- 1.2. Install Python 3 ---
Write-Host "[1.2] Downloading and installing Python 3 (automatically adding to PATH)..." -ForegroundColor Yellow
$pythonUrl = "https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe"
$pythonFile = "python-installer.exe"
Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonFile
Start-Process $pythonFile -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Write-Host "[SUCCESS] Python 3 installation complete." -ForegroundColor Green

# Refresh PATH after Python installation (essential for using the 'pip3' command)
Refresh-Path

# --- 1.3. Install Git ---
Write-Host "[1.3] Downloading and installing Git..." -ForegroundColor Yellow
$gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe"
$gitFile = "git-installer.exe"
Invoke-WebRequest -Uri $gitUrl -OutFile $gitFile
Start-Process $gitFile -ArgumentList "/VERYSILENT" -Wait
Write-Host "[SUCCESS] Git installation complete." -ForegroundColor Green


# =================================================
# Step 2: Install Jupyter and the Scala Kernel
# =================================================

Write-Host "`n=================================================" -ForegroundColor Green
Write-Host "Step 2: Starting installation of Jupyter and the Scala kernel." -ForegroundColor Green
Write-Host "================================================="

# --- 2.1. Install Jupyter Lab and Notebook ---
Write-Host "[2.1] Installing JupyterLab and Notebook..." -ForegroundColor Yellow
# The guide recommends CMD, but this works fine in PowerShell thanks to the PATH refresh function.
pip3 install jupyterlab notebook
Write-Host "[SUCCESS] JupyterLab and Notebook installation complete." -ForegroundColor Green

# --- 2.2. Install the Scala Kernel (Almond) ---
Write-Host "[2.2] Setting up Coursier to install the Scala kernel (Almond)..." -ForegroundColor Yellow
$csUrl = "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-win32.zip"
$csZipFile = "cs.zip"
Invoke-WebRequest -Uri $csUrl -OutFile $csZipFile
Expand-Archive -Path $csZipFile -DestinationPath . -Force
Rename-Item -Path "cs-x86_64-pc-win32.exe" -NewName "cs.exe"

Write-Host "[INFO] Running Coursier (cs.exe) system setup..." -ForegroundColor Cyan
.\cs.exe setup --yes
Write-Host "[SUCCESS] Coursier setup complete." -ForegroundColor Green

# Refresh PATH after Coursier setup (essential for using the 'cs' command directly)
Refresh-Path

Write-Host "[INFO] Installing the Almond kernel with Chisel libraries into Jupyter..." -ForegroundColor Cyan
# Using the new command with the --predef-code argument as specified in the updated guide.
.\cs.exe launch almond --scala 2.12.15 -- --install --force --predef-code 'import $ivy.`edu.berkeley.cs::chisel3:3.5.3`; import $ivy.`edu.berkeley.cs::chiseltest:0.5.3`; import chisel3._'
Write-Host "[SUCCESS] Scala (Almond) kernel installation complete." -ForegroundColor Green


# =================================================
# Step 3: Set Up the Lab Environment
# =================================================

Write-Host "`n=================================================" -ForegroundColor Green
Write-Host "Step 3: Setting up the lab environment." -ForegroundColor Green
Write-Host "================================================="
cd $PSScriptRoot # Return to the original directory where the script was executed
Write-Host "[3.1] Cloning the Git repository..." -ForegroundColor Yellow
git clone https://github.com/haiyonsei/sys5211_lab0
Write-Host "[SUCCESS] Repository cloned: 'sys5211_lab0' folder created." -ForegroundColor Green


# =================================================
# Step 4: Completion and Next Steps
# =================================================

Write-Host "`n=================================================" -ForegroundColor Magenta
Write-Host "All installations and configurations have been completed successfully!" -ForegroundColor Magenta
Write-Host "================================================="
Write-Host "Now, enter the following commands in order to run Jupyter Notebook."
Write-Host ""
Write-Host "1. Navigate to the newly created lab folder:" -ForegroundColor White
Write-Host "   cd sys5211_lab0" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Start the Jupyter Notebook server:" -ForegroundColor White
Write-Host "   jupyter notebook" -ForegroundColor Cyan
Write-Host ""
Write-Host "Running the command above will either open a web browser automatically, or you can copy and paste"
Write-Host "one of the 'http://localhost:8888/...' URLs from the terminal into your browser."
Write-Host "================================================="