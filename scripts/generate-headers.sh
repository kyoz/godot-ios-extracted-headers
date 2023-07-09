#!/bin/bash

cd ./godot

if [[ "$1" == "3.x" ]];
then
    ./../scripts/timeout scons platform=iphone target=release_debug
else
    ./../scripts/timeout scons platform=ios target=template_release  
fi