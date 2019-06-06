# How to contribute

## Translations
You don't need any preparation or IDE to add a language to the localisation file (see [issue #6](https://github.com/darkdks/KF2ServerTool/issues/6)). You can for instance make a Fork on GitHub and edit `KF2ServerTool.lc` directly in the browser. Follow the instructions in the head of the file for details.

## Prerequisites
This project has been written in Delphi / RAD Studio. You will need to download the official IDE if you want to compile and test your code.

* Download and install the Delphi IDE (you can get the free Community Edition [here](https://www.embarcadero.com/delphi-xe8-starter-edition), requires registration)
* `git clone` the current repo or your fork of it to a folder of your choice
* Start Delphi and go to `File` -> `Open Project` and open `./code/KF2ServerToolApps.groupproj`
  * This will open both modules (KF2ServerTool and KF2ServerToolCMD) 
* The GetIt-Package manager will offer to install any missing dependencies
  * If the download fails: 
  * in the project map `right click` on the module -> `Options` -> `Project dependencies` -> `GetIt dependencies` -> `Install all missing packages`
  * It might be necessary for the IDE to run in admin mode if it was installed in admin mode or if there are any other problems
  * It might be necessary to restart the IDE multiple times until all dependencies are installed

## Branch strategy
Try to use a new branch with a good name for your changes (for instance `feature/linux-support` or `fix/crash-on-start`). It will make the merge history and any references to it easier to read.

## External libraries
Currently KF2ServerTool is using *JEDI Code Library* (used for the utility functions it offers) and *JEDI Visual Component Library* (used for improved Forms). Before adding another library check if the existing libraries cover your use case already. Please avoid using paid libraries as this might cause licensing problems and it excludes other users from contributing. Same thing goes for internal libraries and tools that use dependencies exclusive to the paid version of Delphi.

## Final steps

### Push it
Take a quick glance at the changes, before you commit. Avoid using absolute paths in any of the project files. Be sure not to push any personal information, passwords or private API tokens, because the internet never forgets. Also be sure you didn't add any unnecessary huge binary files or generated files, that are not needed (sadly Delphi needs any *.res files that don't have a corresponding *.rc).

### Pull request
Don't forget to make a pull request if you want your changes to be merged into the default branch of the source repo. You can reference an issue with `#NUMBER` if you didn't in your commit message already. If your PR is not connected to any issue you might want to add some details in the description so the maintainer knows what it is about.
