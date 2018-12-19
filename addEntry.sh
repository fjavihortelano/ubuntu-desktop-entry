#!/bin/bash

help=" Usage: sudo $(basename "${0}") [OPTION] PATH_EXEC PATH_ICON\n
Program to create a new desktop entry for an application\n which is executed from command line calling to an executable file.\n
It doesn't work if it is not an installed application.\n\n

WARNING:\n
    \tExecute as root (sudo is needed)\n
    \tMake sure to not change files location given as arguments after execute this script\n\n

OPTION:\n
    \t-h, --help:   show this help text\n\n

Arguments (PATH_EXEC PATH_ICON) are mandatory on the command line.\n\n

    \tPATH_EXEC:      path to executable file\n
    \tPATH_ICON:      path to the image icon (.png, .jpg, .jpeg, .ico)"

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
if [ ! ${#} -eq 2 ]
then
    echo "2 arguments are needed."
    exit
fi

# FIRST ARGUMENT
# Check if first argument is valid
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

# SECOND ARGUMENT
# Check if second argument is valid
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

# INITIAL CHECKINGS DONE





echo "Llegamos"