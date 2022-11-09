# dockerized-whistle
Docker image for google's Whistle FHIR ingest language

[Whistle](https://github.com/GoogleCloudPlatform/healthcare-data-harmonization) is google's Data Transformation Language which can be used to transform arbitrary JSON objects into FHIR compliant JSON objects. This repository contains a single docker image suitable to produce a fully functional whistle image and a shell script to make it behave like the actual application would without having to provide the various arguments required for docker to find and call the image. 

## Requirements
To use this repository, you should have docker installed as well as a full bash environment to run it in (I will look into Powershell options if there is interest) for those interested in using the install script. 

## Installation 
For those who don't care to directly deal with Docker, there is a bash script, simply clone this repository, cd into the root directory and run the install script: 

> ./install.sh

It will copy a script named 'whistle' into $HOME/bin. If that directory isn't in your PATH, you can simply add the following line to the file $HOME/.bash_profile and reload it either by logging in again, or sourcing the file: 

(add the following line to the end of your .bash_profile file)
> export PATH=$PATH:$HOME/bin

(source the .bash_profile to effect the changes you made)
> source ~/.bash_profile

Once the whistle script is in your path, whistle should run just like any other command on your system: 
> whistle --help

It should be noted that this script requires that all files required by whistle to run can be found within the current working directory and that the arguments passed to whistle for those files will be relative to "." (the current working directory), not full paths. 
