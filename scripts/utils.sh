#!/bin/bash

get_ios_template_full_name() {
    echo "godot-$1-stable.tar.xz"
}

get_ios_template_name() {
    echo "godot-$1-stable"
}

get_ios_major_version() {
    VERSION=$1

    if [[ $VERSION =~ ^3\..* ]]; then
        echo $VERSION | sed -E 's/^([0-9]+)\..*$/\1.x/g'
    else
        echo ${VERSION:0:3}
    fi
}