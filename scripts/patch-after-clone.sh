#!/bin/bash
# This script patches libetpan after it's cloned to use arm64 simulators only

LIBETPAN_DIR="$1"
if [ ! -d "$LIBETPAN_DIR" ]; then
  exit 0
fi

SASL_SCRIPT="$LIBETPAN_DIR/build-mac/dependencies/prepare-cyrus-sasl.sh"

if [ -f "$SASL_SCRIPT" ]; then
  echo "Patching cyrus-sasl script for arm64 simulator support..."
  # Update device architectures - remove armv7/armv7s
  sed -i '' 's/MARCHS="armv7 armv7s arm64"/MARCHS="arm64"/g' "$SASL_SCRIPT"
  # Update simulator architectures - remove i386
  sed -i '' 's/MARCHS="i386 x86_64 arm64"/MARCHS="x86_64 arm64"/g' "$SASL_SCRIPT"
  # Update iOS minimum version
  sed -i '' 's/SDK_IOS_MIN_VERSION=7.0/SDK_IOS_MIN_VERSION=16.0/g' "$SASL_SCRIPT"
  echo "✓ Patched cyrus-sasl script"
fi
