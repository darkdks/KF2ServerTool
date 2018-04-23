

## KF2ServerTool for Windows
Easy way to add/remove/update maps in your Killing Floor 2 Dedicated Server

## What is this?

This is a tool to add, remove, and force updates of maps and mods in your dedicated server without spending time and patience editing files, entries, managing the cache, and restarting the server many times. With this tool you will just browse the workshop or paste a URL or workshop ID of the map and click on a button, and the application will do everything for you (download the map, add the server subscription, add the map entry, add the map to the cycle of maps, and add the server redirect if needed). You can also force a map or mod to update if it is outdated and reinstall an entire item.
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img1.jpg"/></p>

The app includes some extra features too, like a server launcher, web admin configuration, workshop download manager configuration, access to webadmin inside the application, and some tools to clean the cache and workshop files. I spent good weeks developing this tool to make it as simple as possible for the end user.
<p align="center"><img src="https://github.com/darkdks/KF2ServerTool/raw/master/imgs/img2.jpg"/></p>

### Download
Go to <a href="https://github.com/darkdks/KF2ServerTool/releases/latest">release</a> and download the latest KF2ServerToolX.X.X.zip version.

### How to install / Use in an existing server

- Extract all files from the zip to the server folder (the same folder where you have a .bat to start the server).
- Use the KF2ServerTool.exe to add a map/mod by browsing the workshop or pasting an ID or URL of an item.

### How to install a new server

- Extract all files in the same folder that the server will be installed
- Open KF2ServerTool.exe and choose the option to install a new server in the same path of the tool folder

### How to use with multiples servers configs
(very useful if you run multiple instances of servers in the same folder and have several different files for each server.)

- Use the param -config in the .exe to specify a different configuration file. (Example: KF2ServerTool.exe -config KFServerTool_sv2.ini) 
- The application will create a new config file and you should edit it to specify the custom paths of your configs (PCServer-Game, PCServer-Engine, etc) files
- Go to the section GENERAL in the config file and set the flag "OnlyShowItemsFromConfig" to true. This will filtrate maps and mods from another servers.

### Notes

- You need start the server at least one time to generate server config files that the tool needs.
- If you have never added the line for redirecting the clients to download from the workshop, check the "Server" tab and click on the text “Install” to install the Workshop Download Manager.

## KF2ServerTool for Linux (No gui) is finally real
Need more tests and improvements, but is already possible to add, remove maps and mods and list all the items of the server.
The current compiled version is for Ubuntu 64, no tested in another linux distribution. The compiled version is avaliable in /code/, the executable is 'KF2ServerToolCMD'. Needs steamcmd installed in the working system.