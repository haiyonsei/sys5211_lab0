# Setup the environment

You can play with Scala/Chisel on the cloud right away using Binder. Binder is a free service that provides a temporary, interactive environment.

https://mybinder.org/v2/gh/haiyonsei/sys5211_lab0/HEAD

# Local Installation (Windows)

Binder will discard any work after about 10 minutes of idle time. So if you don't want this, you can install the environment locally on your Windows machine by following the steps below.

## Step 1: Install Prerequisites

These are the basic tools required before setting up the bootcamp.

### 1.1. Java Development Kit (JDK) 8

Download and install JDK 8 from the Adoptium (Eclipse Temurin) site.

https://adoptium.net/temurin/releases

### 1.2. Python 3

Python is required to run JupyterLab.
Download and install the latest version of Python from

https://www.python.org/

During installation, make sure to check the box for "Add Python to PATH".

### 1.3. Git

Git is needed to download (clone) the source code.

https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe

## Step 2: Install Jupyter and the Scala Kernel

With the prerequisites installed, you can now set up the Jupyter environment.

### 2.1. Install Jupyter Lab and Notebook

Open a new Command Prompt (cmd in administrator mode) and run the following command:

```
pip3 install jupyterlab
pip3 install notebook
```

### 2.2. Install the Scala Kernel (Almond)

This installs the "translator" that allows Jupyter to run Scala code, using a tool called Coursier (cs.exe).
Download and Unzip Coursier:

```
curl -fLo cs-x86_64-pc-win32.zip https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-win32.zip
tar -xf cs-x86_64-pc-win32.zip
```

Set up Coursier: This command registers Coursier on your system.

```
move cs-x86_64-pc-win32.exe cs.exe
.\cs setup
```

Restart your terminal. It is crucial to close and reopen your Command Prompt window for the changes to take effect.

Install the Almond Kernel: In the new terminal window, run this command to install the Scala kernel for Jupyter.

```
.\cs launch almond --scala 2.12.15 -- --install
```

A success message like Installed scala kernel under ... should appear.

## Step 3: Set Up the Lab environment

### 3.1. Clone the git Repository

Navigate to the directory where you want to store the lab files and run:

```
git clone https://github.com/haiyonsei/sys5211_lab0
```

## Step 4: Run the Jupyter notebook 🚀

You are all set!

Make sure you are in the sys5211_lab0 directory in your Command Prompt.

Run the following command to start the server:

```
jupyter notebook
```

This will output several URLs in your terminal. Copy one of the http://localhost:8888/... URLs and paste it into your web browser to start the Chisel Assignment.

## For Mac OS (Terminal)

Download jupyter and jupyterlab.

```
pip3 install --upgrade pip
pip3 install jupyter --ignore-installed
pip3 install jupyterlab
```

Next, download coursier and use it to install almond

```
curl -L -o coursier https://git.io/coursier-cli && chmod +x coursier
SCALA_VERSION=2.12.15 ALMOND_VERSION=0.9.1
./coursier bootstrap -r jitpack \
    -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
    sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
    --sources --default=true \
    -o almond
./almond --install
```

Clone the git repository and run the jupyter notebook

```
git clone https://github.com/haiyonsei/sys5211_lab0
jupyter notebook
```

# Acknowledgement

Lab problems are borrowed from https://github.com/agile-hw/labs/tree/main.

# References

- https://github.com/agile-hw/lectures
- https://github.com/freechipsproject/chisel-bootcamp/
