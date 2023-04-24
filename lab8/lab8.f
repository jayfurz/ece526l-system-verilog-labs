#!/bin/bash

if [ "$1" == "inex" ]; then
  vcs -full64 -debug adder.v multiplier.v register.v level_2.v
top_level.v inexaustive_tb.v -lca -kdb -o simv_inex
elif [ "$1" == "rom" ]; then
  vcs -full64 -debug rom.v rom_tb.v -lca -kdb -o simv_rom
else
  echo "Invalid argument. Please use either 'ram' or 'rom'."
  exit 1
fi
