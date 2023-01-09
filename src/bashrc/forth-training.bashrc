#!/bin/bash

function forth-training
{
    declare -r ROOT_DIR="$(cd "$(dirname "$BASH_SOURCE")/../.." && pwd)"
    ruby -C "${ROOT_DIR}" -I ./src/main/ ./src/main/main.rb -- "$@"
}

