#!/bin/bash
# Launcher script for AgiBot × Certis Report
# Starts Vite dev server if not already running, then opens browser.

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PORT=5173
URL="http://localhost:${PORT}"
PIDFILE="${PROJECT_DIR}/.dev-server.pid"

# Ensure node/npm are on PATH regardless of how this script is invoked
export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.nvm/versions/node/$(ls "$HOME/.nvm/versions/node/" 2>/dev/null | sort -V | tail -1)/bin:/usr/bin:/bin:$PATH"

check_server() {
  curl -s -o /dev/null -w "%{http_code}" "$URL" 2>/dev/null | grep -q "200"
}

cd "$PROJECT_DIR" || exit 1

# Auto-install if node_modules is missing
if [ ! -d "node_modules" ]; then
  if command -v pnpm &>/dev/null; then
    pnpm install
  else
    npm install
  fi
fi

# If server is already running, just open the browser
if check_server; then
  open "$URL"
  exit 0
fi

# Kill stale dev server if pid file exists
if [ -f "$PIDFILE" ]; then
  OLD_PID=$(cat "$PIDFILE")
  kill -0 "$OLD_PID" 2>/dev/null && kill "$OLD_PID" 2>/dev/null
  rm -f "$PIDFILE"
fi

# Start dev server in background
npx vite --port "$PORT" >> "${PROJECT_DIR}/.dev-server.log" 2>&1 &
DEV_PID=$!
echo "$DEV_PID" > "$PIDFILE"

# Poll until server responds (max 45s)
WAITED=0
MAX_WAIT=45
while [ $WAITED -lt $MAX_WAIT ]; do
  if check_server; then
    open "$URL"
    exit 0
  fi
  sleep 1
  WAITED=$((WAITED + 1))
done

echo "Server did not start within ${MAX_WAIT}s" >&2
exit 1
