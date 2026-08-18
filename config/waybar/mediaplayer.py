#!/usr/bin/env python3

import subprocess
import sys
import json
import time


def get_metadata():
    """Get metadata from the active player."""
    try:
        result = subprocess.run(
            ["playerctl", "metadata", "--format",
             '{"player": "{playerName}", "artist": "{artist}", "title": "{title}", "status": "{status}"}'],
            capture_output=True, text=True, timeout=5
        )
        if result.returncode == 0 and result.stdout.strip():
            return json.loads(result.stdout.strip())
    except (FileNotFoundError, subprocess.TimeoutExpired, json.JSONDecodeError):
        pass
    return None


def main():
    while True:
        metadata = get_metadata()
        if metadata and metadata.get("title"):
            player = metadata.get("player", "Unknown")
            artist = metadata.get("artist", "")
            title = metadata.get("title", "Unknown")

            if artist:
                text = f"{artist} - {title}"
            else:
                text = title

            output = {
                "text": text,
                "tooltip": f"{player}: {text}",
                "class": player.lower().replace(" ", "-")
            }
            print(json.dumps(output), flush=True)
        else:
            print(json.dumps({"text": ""}), flush=True)

        time.sleep(3)


if __name__ == "__main__":
    main()
