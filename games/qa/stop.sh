#!/bin/bash
# stop.sh - Stops any process listening on port 8088

PID=$(lsof -t -i:8088)

if [ -z "$PID" ]; then
  echo "No active process found running on port 8088."
else
  echo "Stopping process on port 8088 (PID: $PID)..."
  kill -9 $PID
  echo "Process on port 8088 has been stopped."
fi
