#!/bin/bash
set -euo pipefail

CONTRACT_FILE="${1:-}"

if [ -z "$CONTRACT_FILE" ]; then
    echo "Usage: $0 <contract-file>"
    exit 1
fi

echo "Validating data contract: $CONTRACT_FILE"
datacontract test --contract "$CONTRACT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Contract validation passed"
else
    echo "❌ Contract validation failed"
    exit 1
fi
