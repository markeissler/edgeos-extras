#!/usr/bin/env bash
#
# Build script for ddclient-ubnt for EdgeOS.
#
# https://github.com/ddclient/ddclient
#

REPO_URL="https://github.com/ddclient/ddclient.git"
REPO_TAG="v3.11.2"

BUILD_DIR="${PWD}/build"
CLONE_DIR="${BUILD_DIR}/ddclient-ubnt-${REPO_TAG#v}"
FINAL_DIR="${PWD}/dist"
PERL_PATH="/usr/bin/perl"

if ! test -d "${BUILD_DIR}"; then
    mkdir -p "${BUILD_DIR}"
fi

if ! test -d "${CLONE_DIR}"; then
    if ! git clone --depth 1 --branch "${REPO_TAG}" "${REPO_URL}" "${CLONE_DIR}"; then
        echo "Failed to clone project into directory: ${CLONE_DIR}"
        exit 1
    fi
fi

pushd .

cd "${CLONE_DIR}"

if ! test -f "./autogen"; then
    echo "Invalid project directory: can't find `autogen` script."
    exit 1
fi

./autogen
PERL="${PERL_PATH}" ./configure --prefix=/usr --sysconfdir=/etc/ddclient --localstatedir=/var
if !(make && make VERBOSE=1 check); then
    echo "Build failed."
    exit 1
fi

if ! test -f "ddclient"; then
    echo "Build failed to produce `ddclient` script."
    exit 1
fi

cp "ddclient" "ddclient-ubnt"

popd

cp "${CLONE_DIR}/ddclient-ubnt" "${FINAL_DIR}"

echo "All done."
