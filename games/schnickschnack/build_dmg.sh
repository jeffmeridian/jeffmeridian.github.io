#!/bin/bash

# Configuration
APP_NAME="schnickschnack.app"
DMG_NAME="schnickschnack-v1.dmg"
VOL_NAME="schnickschnack Installer"

# 1. Clean up old files
echo "Cleaning up old DMG if it exists..."
rm -f "$DMG_NAME"

# 2. Create the DMG
echo "Generating DMG..."
create-dmg \
  --volname "$VOL_NAME" \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --icon "$APP_NAME" 175 120 \
  --hide-extension "$APP_NAME" \
  --app-drop-link 425 120 \
  "$DMG_NAME" \
  "./$APP_NAME"

echo "--------------------------------------------------"
echo "Done! Created $DMG_NAME"
echo "Note: Since you don't have a developer account,"
echo "users must Right-Click -> Open to bypass security."
echo "--------------------------------------------------"