#!/bin/bash

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${CACHE_DIR}
RELEASE_DIR=${RELEASE_DIR}
SUPPORT_VERSIONS=(${SUPPORT_VERSIONS[@]})
CHOOSED_VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_VERSION})

GODOT_SOURCE_URL="https://github.com/godotengine/godot/releases/download"

# Create .cache folder if not existed
if [ ! -d $CACHE_DIR ]; then
    mkdir -p $CACHE_DIR
fi

# Check if template version is support or not
if [[ ! " ${SUPPORT_VERSIONS[*]} " =~ " ${CHOOSED_VERSION} " ]]; then
    echo "- Your template version is not supported yet :'("
    exit 1
fi

# Install godot sources, will bypass cached sources
SOURCE_FILE=$(get_ios_template_full_name $CHOOSED_VERSION)

# Check if version is cached
if test -f "${CACHE_DIR}/${SOURCE_FILE}"; then
    echo "- Downloaded godot source version ${CHOOSED_VERSION} (cached)"
else
    echo "- Downloading godot source version ${CHOOSED_VERSION}..."
    echo "${GODOT_SOURCE_URL}/${CHOOSED_VERSION}-stable/${SOURCE_FILE}"
    wget -P "${CACHE_DIR}" "${GODOT_SOURCE_URL}/${CHOOSED_VERSION}-stable/${SOURCE_FILE}"
fi