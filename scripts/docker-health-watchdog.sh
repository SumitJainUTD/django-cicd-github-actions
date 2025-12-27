#!/bin/bash

CONTAINER="django_app"
LOG_FILE="/home/ubuntu/docker-watchdog.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Container exists?
if ! docker inspect "$CONTAINER" >/dev/null 2>&1; then
  echo "$DATE ❌ Container not found: $CONTAINER" >> "$LOG_FILE"
  exit 0
fi

# Read health status
STATUS=$(docker inspect \
  --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}no-healthcheck{{end}}' \
  "$CONTAINER")

if [ "$STATUS" = "unhealthy" ]; then
  echo "$DATE 🔴 UNHEALTHY → restarting $CONTAINER" >> "$LOG_FILE"
  docker restart "$CONTAINER" >> "$LOG_FILE" 2>&1

elif [ "$STATUS" = "healthy" ]; then
  echo "$DATE ✅ healthy" >> "$LOG_FILE"

else
  echo "$DATE ⚠️ no healthcheck configured" >> "$LOG_FILE"
fi