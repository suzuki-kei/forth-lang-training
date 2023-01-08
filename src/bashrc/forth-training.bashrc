#!/bin/bash

function forth-training
{
    declare -r ROOT_DIR="$(cd "$(dirname "$BASH_SOURCE")/../.." && pwd)"
    make -C "${ROOT_DIR}"
}

