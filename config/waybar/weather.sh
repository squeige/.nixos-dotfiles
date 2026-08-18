#!/usr/bin/env bash
# Fetch weather from wttr.in for waybar

# Use your city or let wttr.in auto-detect
# Change "auto" to a specific city, e.g., "London"
LOCATION="auto"

WEATHER=$(curl -sf "wttr.in/${LOCATION}?format=%t+%C" 2>/dev/null)

if [ -z "$WEATHER" ]; then
    echo "N/A"
    exit 0
fi

# Map weather condition to icon
ICON=""
if echo "$WEATHER" | grep -qi "sun\|clear"; then
    ICON=""
elif echo "$WEATHER" | grep -qi "cloud\|overcast"; then
    ICON=""
elif echo "$WEATHER" | grep -qi "rain\|drizzle"; then
    ICON=""
elif echo "$WEATHER" | grep -qi "snow"; then
    ICON=""
elif echo "$WEATHER" | grep -qi "thunder\|storm"; then
    ICON="⛈"
elif echo "$WEATHER" | grep -qi "fog\|mist"; then
    ICON=""
elif echo "$WEATHER" | grep -qi "wind"; then
    ICON=""
elif echo "$WEATHER" | grep -qi "partly"; then
    ICON=""
fi

echo "${ICON} ${WEATHER}"
