#!/bin/bash

source ./build.env
source ./scripts/utils.sh

VERSIONS=${VERSIONS}
CACHE_DIR=${CACHE_DIR}
RELEASE_DIR=${RELEASE_DIR}
BUILD_VERSIONS=($([ ! -z "$1" ] && echo $1 || echo ${SUPPORT_VERSIONS[@]}))

if [ ! -d ".release" ]; then
    mkdir .release
fi

for version in "${BUILD_VERSIONS[@]}"; do
    # Install template, will bypass cached templates
    echo ">> Install Godot source..."
    ./scripts/install.sh $version

    rm -rf godot
    rm -rf bin
    mkdir bin

    echo ">> Extract Godot source..."
    SOURCE_FILE=$(get_ios_template_full_name $version)
    SOURCE_FILE_NAME=$(get_ios_template_name $version)
    tar -xf ${CACHE_DIR}/${SOURCE_FILE}
    mv ${SOURCE_FILE_NAME} godot

    echo ">> Generate Godot headers..."
    MAJOR_VERSION=$(get_ios_major_version $version)
    ./scripts/generate-headers.sh $MAJOR_VERSION

    echo ">> Extract Godot headers..."
    rsync -a -m -R --include '*/' --include '*.h' --include '*.inc' --exclude '*' ./godot ./bin/extracted_headers

    echo ">> Pack Godot extracted headers..."
    cd bin/extracted_headers
    ZIP_FILE="extracted_headers_godot_${version}.zip"
    zip -r -q $ZIP_FILE godot/
    cd ../..
    mv bin/extracted_headers/$ZIP_FILE .release/$ZIP_FILE
done


