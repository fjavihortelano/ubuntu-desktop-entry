#!/bin/bash

help=" Usage: sudo $(basename "${0}") [OPTION] PATH_EXEC PATH_ICON APP_NAME\n
Program to create a new desktop entry for an application\n which is executed from command line calling to an executable file.\n
It doesn't work if it is not an installed application.\n\n

WARNING:\n
    \tExecute as root (sudo is needed)\n
    \tMake sure to not change files location given as arguments after execute this script\n\n

OPTION:\n
    \t-h, --help:   show this help text\n\n

Arguments (PATH_EXEC PATH_ICON) are mandatory on the command line.\n\n

    \tPATH_EXEC:      absolute path to executable file\n
    \tPATH_ICON:      absolute path to the image icon (.png, .jpg, .jpeg, .ico)\n
    \tAPP_NAME:       application name (if it contains spaces, the name must go between \" \"."

# Check for help
if [ ${1} == "-h" ] || [ ${1} == "--help" ]
then
    echo -e ${help}
    exit
fi

# Check if sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root (sudo)."
  exit
fi

# Check if there are 2 arguments
if [ ! ${#} -eq 3 ]
then
    echo -e "3 arguments are needed:
\tAbsolute path to the executable file
\tAbsolute path to the icon file
\tName of the application"
    exit
fi

# FIRST ARGUMENT
# Check if first argument is valid
if [ ${1:0:1} != "/" ]
then
    echo "The first arg must be an absolute path, not relative."
    exit
else
    if [ ! -e ${1} ] || [ -d ${1} ]
    then
        echo "The path to executable file is wrong or the file doesn't exists."
        exit
    else
        # Check if first argument is executable
        if [ ! -x ${1} ]
        then
            echo "The executable file does not have executable permissions. Try 'chmod +x <path_to_file>'."
            exit
        fi
    fi
fi

# SECOND ARGUMENT
# Check if second argument is valid
if [ ${2:0:1} != "/" ]
then
    echo "The second arg must be an absolute path, not relative."
    exit
else
    if [ ! -e ${2} ] || [ -d ${2} ]
    then
        echo "The path to icon file is wrong or the file doesn't exists."
        exit
    else
        # Check if file extension is correct ()
        if [ ${2: -4} != ".png" ] && [ ${2: -4} != ".jpg" ] && [ ${2: -4} != ".ico" ] && [ ${2: -5} != ".jpeg" ]
        then
            echo "The icon extension is incorrect. Only .png, .jpg, .jpeg, .ico are allowed."
            exit
        fi
    fi
fi

# INITIAL CHECKINGS DONE
# Create new desktop entry
dest_file="/usr/share/applications/${3,,}.desktop"

if [ -e ${dest_file} ]
then
    echo -n "There is currently a file with the same name. Do you want to replace it? (y/n)? "
    read answer
    if [ "${answer}" != "${answer#[Yy]}" ]
    then
        echo YES
        rm -f ${dest_file}
    else
        exit
    fi
fi

# Fill with content
echo "[Desktop Entry]" > ${dest_file}
echo "Version=1.0" >> ${dest_file}
echo "Name=${3}" >> ${dest_file}
echo "Exec=${1}" >> ${dest_file}
echo "Icon=${2}" >> ${dest_file}
echo "Type=Application" >> ${dest_file}
exit