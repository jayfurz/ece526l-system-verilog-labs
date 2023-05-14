#!/bin/bash

if [ "$1" == "ram" ]; then
  vcs -full64 -debug register_file.v register_file_tb.v -lca -kdb -o simv_ram
elif [ "$1" == "rom" ]; then
  vcs -full64 -debug rom.v rom_tb.v -lca -kdb -o simv_rom
else
  echo "Invalid argument. Please use either 'ram' or 'rom'."
  exit 1
fi
