#!/bin/bash

if [ "$1" == "inex" ]; then
  vcs -full64 -debug level_1.v level_2.v top_level.v inexaustive_tb.v -lca -kdb -o simv_inex
elif [ "$1" == "ex" ]; then
  vcs -full64 -debug level_1.v level_2.v top_level.v exhaustive_tb.v -lca -kdb -o simv_ex
elif [ "$1" == "exerr" ]; then
  vcs -full64 -debug -DFORCE_ERROR level_1.v level_2.v top_level.v exhaustive_tb.v -lca -kdb -o simv_exerr
else
  echo "Invalid argument. Please use either 'inex' or 'ex'."
  exit 1
fi
