#!/bin/bash
set -e

# Start Docker daemon in background with proper settings for container environment
dockerd \
    --storage-driver=vfs \
    --iptables=false \
    --bridge=none \
    --host=unix:///var/run/docker.sock \
    >/tmp/dockerd.log 2>&1 &

# Wait for Docker daemon to be ready
echo "Waiting for Docker daemon to start..."
for i in {1..30}; do
    if docker ps >/dev/null 2>&1; then
        echo "Docker daemon is ready!"
        break
    fi
    echo "Waiting... ($i/30)"
    sleep 1
done

if ! docker ps >/dev/null 2>&1; then
    echo "Failed to start Docker daemon"
    cat /tmp/dockerd.log
    exit 1
fi

# Execute the main command
exec "$@"
