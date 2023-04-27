#!/bin/bash

if [ "$1" == "unsigned" ]; then
  vcs -full64 -debug alu.v alu_tb.v -lca -kdb -o simv_unsigned
elif [ "$1" == "signed" ]; then
  vcs -full64 -debug -DSIGNED_OPERANDS alu.v alu_tb.v -lca -kdb -o simv_signed
else
  echo "Invalid argument. Please use either 'signed' or 'unsigned'."
  exit 1
fi
