# Ubuntu Desktop Entry

This program allows to create a new desktop entry in Launchpad for a new app or program installed which doesn't provide one.

### Usage
1. Download the zip or clone the current repository:
```
$ git clone https://github.com/ptricor/ubuntu-desktop-entry.git
```
2. Give execution permission:
```
$ cd UbuntuDesktopEntry/
$ chmod +x addEntry.sh
```
3. Execute the file as sudo giving the following arguments:
```
$ sudo ./addEntry.sh <path_exec_file> <path_icon_file> <application_name>
```
Where
```
<path_exec_file> --> Absolute path to execution file
<path_icon_file> --> Absolute path to icon file
<application_name> --> Name given to the new entry
```

4. If you want to show help, write argument '-h' or '--help' (sudo not required):
```
$ ./addEntry.sh -h
$ ./addEntry.sh --help
```
5. In case the desktop entry file already exists, the script will ask you to replace it with a new one.

## WARNING
## The script only creates an useful desktop entry if it's for an installed software. If the exec file or icon file are relocated, I recommend running the script again replacing the old entry. If the latter is not done, the desktop entry will not work properly.
