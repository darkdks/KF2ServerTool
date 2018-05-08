

## KF2ServerTool for Windows and KF2ServerToolCMD for Windows and Linux
Easy way to add/remove/update maps in your Killing Floor 2 Dedicated Server

## What is this?

This is a tool to add, remove, and force updates of maps and mods in your dedicated server without spending time and patience editing files, entries, managing the cache, and restarting the server many times. With this tool you will just browse the workshop or paste a URL or workshop ID of the map and click on a button, and the application will do everything for you (download the map, add the server subscription, add the map entry, add the map to the cycle of maps, and add the server redirect if needed). You can also force a map or mod to update if it is outdated and reinstall an entire item.

KF2ServerTool
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img1.jpg"/></p>
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img4.jpg"/></p>
The app includes some extra features too, like a server launcher, web admin configuration, workshop download manager configuration, access to webadmin inside the application, and some tools to clean the cache and workshop files. I spent good weeks developing this tool to make it as simple as possible for the end user.
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img2.jpg"/></p>
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img5.jpg"/></p>
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img4.jpg"/></p>

KF2ServerToolCMD
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img3.jpg"/></p>

# Download
### GUI Version to Windows (KF2ServerTool):
Go to <a href="https://github.com/darkdks/KF2ServerTool/releases/latest">release</a> and download the latest KF2ServerToolX.X.X.zip version.

### CMD Version to Windows (KF2ServerToolCMD)
Go to <a href="https://github.com/darkdks/KF2ServerTool/blob/master/code/KF2ServerToolCMD.exe">code/KF2ServerToolCMD.exe</a> and download the file.

### CMD Version to Linux (KF2ServerToolCMD)
Go to <a href="https://github.com/darkdks/KF2ServerTool/blob/master/code/KF2ServerToolCMD">code/KF2ServerToolCMD</a> and download the file.

# Install KF2ServerTool for Windows

### Use in an existing server

- Extract all files from the zip to the server folder (the same folder where you have a .bat to start the server).
- Use the KF2ServerTool.exe to add a map/mod by browsing the workshop or pasting an ID or URL of an item.
.
### Use in a new server installation

- Extract all files in the same folder that the server will be installed
- Open KF2ServerTool.exe and choose the option to install a new server in the same path of the tool folder
- After download all the server, close the tool and open the server one time to create the config files.

### Notes

- You need start the server at least one time to generate server config files that the tool needs.
- If you have never added the line for redirecting the clients to download from the workshop, check the "Options" tab and turn on the Workshop Download Manager.
- If you have issues with the workshop browser inside the tool, like items displaying incorrectly, double click in the WorkshopBrowserFix.reg. 

# Install KF2ServerToolCMD for Windows/linux

- Just put the KF2ServerToolCMD inside the server folder and launch it from terminal with -list, a new file called KF2ServerToolCMD.ini will be created. You can adit inside this file the paths of KFEngine and KFGame if you dont use the default.
- install steamcmd if you have not (see the install cmd section)
- Configure the KF2ServerToolCMD.ini to specify it (for linux is the steamcmd.sh and for windows is the steamcmd.exe).
- K2ServerToolCMD -help to see all avaliable commands

# Install steamcmd
- For Linux: "apt-get install steamcmd" or download it from <a href="https://github.com/darkdks/KF2ServerTool/blob/master/code/steamcmd/steamcmd_linux.tar.gz">here</a> and extract for an folder (eg KF2Server/steamcmd/) 
- For Windows: download it from <a href="https://github.com/darkdks/KF2ServerTool/blob/master/code/steamcmd/steamcmd.exe">here</a> and put it in an folder (eg KF2Server/steamcmd/)


# How to use with multiples servers configs
(very useful if you run multiple instances of servers in the same folder and have several different files for each server.)

- Use the param -config in the .exe to specify a different configuration file. (Example: KF2ServerTool.exe (or KF2ServerToolCMD for cmd version) -config KFServerTool_sv2.ini) 
- The application will create a new config file and you should edit it to specify the custom paths of your configs (PCServer-Game, PCServer-Engine, etc) files

Optional for windows gui only
- Go to the section GENERAL in the config file and set the flag "OnlyShowItemsFromConfig" to true. This will filtrate maps and mods from another servers.



