#!/bin/bash

trap "rm server; kill 0" EXIT

# 🔧 杀掉已占用的端口（macOS用lsof）
for port in 8001 8002 8003 9999; do
  pid=$(lsof -ti tcp:$port)
  if [ -n "$pid" ]; then
    echo "Killing process on port $port (PID: $pid)"
    kill -9 $pid
  fi
done

echo ">> Building server..."
go build -o server

echo ">> Starting cache servers..."
./server -port=8001 &
./server -port=8002 &
./server -port=8003 -api=1 &

sleep 2

echo ">> Sending test requests to http://localhost:9999/api?key=Tom"
curl "http://localhost:9999/api?key=Tom" &
curl "http://localhost:9999/api?key=Tom" &
curl "http://localhost:9999/api?key=Tom" &

wait
