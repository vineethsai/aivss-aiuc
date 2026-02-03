#!/bin/bash

# AIUC-AIVSS Crosswalk Dashboard Launcher
# ========================================

PORT=8000
DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "╔═══════════════════════════════════════════════════════╗"
echo "║     AIUC ↔ AIVSS Crosswalk Review Dashboard           ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""

# Check if Python is available
if command -v python3 &> /dev/null; then
    PYTHON=python3
elif command -v python &> /dev/null; then
    PYTHON=python
else
    echo "❌ Error: Python is not installed."
    echo "   Please install Python 3 to run this website."
    exit 1
fi

# Check if port is already in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "⚠️  Port $PORT is already in use."
    echo "   The website may already be running."
    echo ""
    echo "   Opening browser anyway..."
    sleep 1
else
    echo "🚀 Starting server on port $PORT..."
    echo ""
    
    # Start server in background
    cd "$DIR"
    $PYTHON -m http.server $PORT &
    SERVER_PID=$!
    
    # Wait for server to start
    sleep 1
    
    echo "✅ Server started (PID: $SERVER_PID)"
    echo ""
fi

URL="http://localhost:$PORT/website/index.html"
echo "🌐 Opening: $URL"
echo ""

# Open browser based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$URL"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$URL" 2>/dev/null || sensible-browser "$URL" 2>/dev/null
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    start "$URL"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Keep script running and forward signals to server
if [ ! -z "$SERVER_PID" ]; then
    trap "echo ''; echo 'Stopping server...'; kill $SERVER_PID 2>/dev/null; exit 0" INT TERM
    wait $SERVER_PID
fi
