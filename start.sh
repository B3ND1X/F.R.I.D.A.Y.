#!/bin/bash

# Define log files for debugging
BACKEND_LOG="backend.log"
FRONTEND_LOG="frontend.log"

# Function to start the backend server
start_backend() {
    echo "Starting the backend server..."
    nohup node server.js > "$BACKEND_LOG" 2>&1 &
    BACKEND_PID=$!
    echo "Backend server started with PID: $BACKEND_PID"
}

# Function to start the frontend server
start_frontend() {
    echo "Starting the frontend server..."
    cd public || exit
    nohup http-server -p 8080 > "../$FRONTEND_LOG" 2>&1 &
    FRONTEND_PID=$!
    cd - > /dev/null || exit
    echo "Frontend server started with PID: $FRONTEND_PID"
}

# Function to stop both servers
stop_servers() {
    echo "Stopping servers..."
    [[ -n "$BACKEND_PID" ]] && kill "$BACKEND_PID" && echo "Backend server stopped."
    [[ -n "$FRONTEND_PID" ]] && kill "$FRONTEND_PID" && echo "Frontend server stopped."
    exit 0
}

# Function to check the status of the servers
status_servers() {
    if ps -p "$BACKEND_PID" > /dev/null 2>&1; then
        echo "Backend server is running with PID: $BACKEND_PID"
    else
        echo "Backend server is not running."
    fi

    if ps -p "$FRONTEND_PID" > /dev/null 2>&1; then
        echo "Frontend server is running with PID: $FRONTEND_PID"
    else
        echo "Frontend server is not running."
    fi
}

# Function to debug servers by showing logs
debug_servers() {
    echo "====== Backend Server Logs ======"
    tail -n 20 "$BACKEND_LOG"
    echo "====== Frontend Server Logs ======"
    tail -n 20 "$FRONTEND_LOG"
}

# Set a trap to stop servers on Ctrl+C
trap stop_servers INT

# Parse command-line arguments
case $1 in
    start)
        start_backend
        start_frontend
        echo "Backend server is running at: http://localhost:3000"
        echo "Frontend server is running at: http://localhost:8080"
        echo "Press Ctrl+C to stop the servers"
        while true; do sleep 1; done
        ;;
    stop)
        stop_servers
        ;;
    status)
        status_servers
        ;;
    debug)
        debug_servers
        ;;
    *)
        echo "Usage: $0 {start|stop|status|debug}"
        exit 1
        ;;
esac

