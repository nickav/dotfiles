#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $(basename "$0") <name>" >&2
  exit 1
fi

name=$1

number=$(sudo snapper -c root create --type single --print-number --description "$name")

echo "Created snapshot #$number (root) — \"$name\""
echo "Restore with: sudo snapper -c root undochange $number..0"
