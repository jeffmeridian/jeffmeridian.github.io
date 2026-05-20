#!/bin/bash
# start.sh - Starts the Python HTTP server on port 8088 in the background

# Navigate to the directory of this script to serve its contents
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Clean up any existing process on port 8088 to prevent address conflicts
PID=$(lsof -t -i:8088)
if [ ! -z "$PID" ]; then
  echo "Port 8088 is already in use by process $PID. Stopping it first..."
  kill -9 $PID
fi

echo "Starting python3 -m http.server 8088 in background..."
nohup python3 -m http.server 8088 > server.log 2>&1 &

# Sleep briefly to verify if it started successfully
sleep 1
NEW_PID=$(lsof -t -i:8088)
if [ ! -z "$NEW_PID" ]; then
  echo "HTTP Server started successfully (PID: $NEW_PID) on port 8088."
  echo "Access QA page at: http://localhost:8088/QA.html"
else
  echo "Failed to start HTTP Server. Check server.log for details."
fi
