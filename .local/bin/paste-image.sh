#!/bin/bash
TEMP_DIR="/tmp/claude-code-images"
mkdir -p "$TEMP_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
IMAGE_PATH="$TEMP_DIR/image_$TIMESTAMP.png"

if pngpaste "$IMAGE_PATH" 2>/dev/null; then
  echo "$IMAGE_PATH"
else
  # Fallback to regular clipboard paste
  pbpaste
fi
