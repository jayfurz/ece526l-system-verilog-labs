#!/bin/bash

if [ "$1" == "ram" ]; then
    vcs -full64 -debug -f lab7.f -lca -kdb -o simv_ram register_file_tb.v
elif [ "$1" == "rom" ]; then
    vcs -full64 -debug -f lab7.f -lca -kdb -o simv_rum rom_tb.v
else
    echo "Invalid argument. Please use either 'ram' or 'rom'."
    exit 1
fi
