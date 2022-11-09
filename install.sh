#!/bin/bash

# This script simply builds the docker image and copies the script
# over to $HOME/bin. 

# This must be run in the root directory of the dockerized-whistle
# repository, since that is where the Dockerfile is kept.

docker build -t ncpi/whistle .
echo "-----------------------------------------------------------------------"
echo "A docker image, ncpi/whistle, has been created. "
echo "-----------------------------------------------------------------------"

mkdir -p $HOME/bin
cp scripts/whistle $HOME/bin

echo "-----------------------------------------------------------------------"
echo "A script has been created at: $HOME/bin/whistle"
echo "This script will handle the docker related arguments allowing you run "
echo "whistle as if it were a native application" 
echo "-----------------------------------------------------------------------"

echo ""

echo "Add the following line to the file, .bash_profile, in your home"
echo "directory to ensure that the script is in your PATH:"
echo "export PATH=$PATH:$HOME/bin"
echo
echo "Then source the .bash_profile or log in again for the new PATH to take"
echo "effect. "
echo "source $HOME/.bash_profile"

echo
echo "Once the script is in your PATH, you can run whistle like any other"
echo "command line tool:"
echo "whistle --help"
