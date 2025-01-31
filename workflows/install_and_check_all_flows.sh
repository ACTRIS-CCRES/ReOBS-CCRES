#!/bin/bash

install_and_check(){
    local path=$1
    cylc install $path
    cylc check $(basename $path)
}

contain_cylc_flow(){
    local returncode=0
    local path=$1
    cylc_flows=$(find $path -name flow.cylc)
    if [[ -z $cylc_flows ]]; then
        returncode=1
    fi
    return $returncode
}
files=$(find . -mindepth 1 -maxdepth 1 -type d)

for folder in $files; do
    contain_cylc_flow $folder && install_and_check $folder
done
