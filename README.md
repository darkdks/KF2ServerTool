

## KF2ServerTool for Windows and KF2ServerToolCMD for Windows and Linux
Easy way to add/remove/update maps in your Killing Floor 2 Dedicated Server

## What is this?
With this tool you can easily install and configure your Killing Floor 2 dedicated server. You can easily install or update maps and mods from workshop or a custom redirect, perform server maintenance (updates and verify server integrity), start the server with custom mutators and also have diferent profiles with different settings. All this without wasting time editing lines of config files.

## How easy is that?
You will just browse the workshop inside the app or paste a URL of an workshop item and click on a button. The application will do everything for you (download the map, add the server subscription, add the map entry, add the map to the cycle of maps and add the server redirect if needed). For update an outdated workshop item just right click on the item and choose update.

KF2ServerTool
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img1.jpg"/></p>

The app includes some extra features too, like a server launcher, web admin configuration, workshop download manager configuration, access to webadmin inside the application, and some tools to clean the cache and workshop files. I spent good weeks developing this tool to make it as simple as possible for the end user.
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img5.jpg"/></p>
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img6.jpg"/></p>

KF2ServerToolCMD
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img3.jpg"/></p>

# Download
### GUI Version to Windows (KF2ServerTool):
Go to <a href="https://github.com/darkdks/KF2ServerTool/releases/latest">release</a> and download the latest KF2ServerToolX.X.X.zip version.

### CMD Version compiled to Windows (KF2ServerToolCMD)
Go to <a href="https://github.com/darkdks/KF2ServerTool/blob/master/code/KF2ServerToolCMD.exe">code/KF2ServerToolCMD.exe</a> and download the file.

### CMD Version compiled to Linux (KF2ServerToolCMD)
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

- If you have never added the line for redirecting the clients to download from the workshop, check the "Options" tab and turn on the Workshop Download Manager.

# Install KF2ServerToolCMD for Windows/linux

- Just put the KF2ServerToolCMD inside the server folder and launch it from terminal with -list, a new file called KF2ServerToolCMD.ini will be created. You can adit inside this file the paths of KFEngine and KFGame if you dont use the default.
- install steamcmd if you have not (see the install steamcmd section)
- Configure the KF2ServerToolCMD.ini to specify it (for linux is the steamcmd.sh and for windows is the steamcmd.exe).
- K2ServerToolCMD -help to see all avaliable commands

# Install steamcmd
- For Linux: "apt-get install steamcmd" or download it from <a href="https://github.com/darkdks/KF2ServerTool/blob/master/code/steamcmd/steamcmd_linux.tar.gz">here</a> and extract for an folder (eg KF2Server/steamcmd/) 
- For Windows: download it from <a href="https://github.com/darkdks/KF2ServerTool/blob/master/code/steamcmd/steamcmd.exe">here</a> and put it in an folder (eg KF2Server/steamcmd/)


# How to use with multiples servers configs
(very useful if you run multiple instances of servers in the same folder and have several different files for each server.)

- Use the param -config to specify a different configuration file. 
Example: KF2ServerTool -config KFServerTool_sv2.ini 
Example: KF2ServerToolCMD -config KFServerTool_sv2.ini 

- The application will create a new config file and you should edit it to specify the custom paths of your configs (PCServer-Game, PCServer-Engine, etc) files

Optional for windows gui only
- Go to the section GENERAL in the config file and set the flag "OnlyShowItemsFromConfig" to true. This will filtrate maps and mods from another servers.



