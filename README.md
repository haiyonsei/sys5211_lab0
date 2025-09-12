# Setup the environment

You can play with Scala/Chisel on the cloud right away using Binder. Binder is a free service that provides a temporary, interactive environment.

https://mybinder.org/v2/gh/haiyonsei/sys5211_lab0/HEAD

<br>

# Chisel Bootcamp Local Installation Guide

When using Jupyter Notebook in the online Binder environment, your work may be lost after about 10 minutes of inactivity. To avoid this, you can install the development environment locally on your computer by following the guide below.

We provide automated setup scripts for each operating system (setup-win.ps1 and setup-mac.sh). Running a single script will automatically install all prerequisites, including Java, Python, and Git, and configure the Scala kernel for you.

<br>

## Windows Installation
This process uses PowerShell to automate all installation steps. (You can use Conda environment)

### 1. Download the Script

Download the setup-win.ps1 script file from github and place it in your desired project directory (e.g., C:\Users\YourUser\Projects).

### 2. Run PowerShell as an Administrator

Open the Start Menu, search for PowerShell, right-click on it, and select "Run as administrator".

### 3. Navigate to Your Project Directory

In the PowerShell window, use the cd command to navigate to the folder where you saved the script.

```
cd C:\Users\YourUser\Projects
```

### 4. Change the Execution Policy (for the current session)

By default, PowerShell's security policy may block scripts from running. To allow it for the current session, enter the following command:

```
Set-ExecutionPolicy Unrestricted -Scope Process
```

### 5. Run the Automated Setup Script

Enter the following command to begin the installation:

```
.\setup-win.ps1
```

The script will handle all installations and configurations automatically. Once finished, it will provide instructions on how to launch Jupyter Notebook.

<br>

## macOS Installation
This process uses the Terminal and Homebrew to automate all installation steps. (If you don't have Homebrew, the script will install it for you.)

### 1. Download the Script

Download the setup-mac.sh script file from github and place it in your desired project directory (e.g., ~/Projects).

### 2. Open the Terminal

Open Spotlight (Cmd+Space), search for Terminal, and open the application.

### 3. Navigate to Your Project Directory

In the Terminal window, use the cd command to navigate to the folder where you saved the script.

```
cd ~/Projects
```

### 4. Make the Script Executable

You need to grant the script permission to run. Enter the following command (you only need to do this once):

```
chmod +x setup-mac.sh
```

### 5. Run the Automated Setup Script

Enter the following command to begin the installation:

```
./setup-mac.sh
```

The script will handle all installations and configurations automatically. Once finished, it will provide instructions on how to launch Jupyter Notebook.

<br>

## Running the Lab
After the installation is complete, you can start Jupyter Notebook by following the final instructions provided by the script:

```
# 1. Navigate to the newly created lab folder
cd sys5211_lab0

# 2. Run Jupyter Notebook
jupyter notebook
```

If a browser window does not open automatically, copy one of the URLs from the terminal (it will start with http://localhost:8888/...) and paste it into your web browser's address bar.

<br>

## Acknowledgement

Lab problems are borrowed from https://github.com/agile-hw/labs/tree/main.

## References

- https://github.com/agile-hw/lectures
- https://github.com/freechipsproject/chisel-bootcamp/
