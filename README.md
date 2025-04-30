# GeeCache

GeeCache is a simple distributed in-memory cache system implemented in Go, inspired by groupcache and Redis.  
It is built as part of a hands-on learning project from the **7 days Golang series**.

## Features

- **In-Memory Caching**: Fast access to frequently used data with LRU eviction policy.
- **Peer-to-Peer Nodes**: Supports multiple nodes communicating via HTTP.
- **Consistent Hashing**: Automatic load balancing across nodes.
- **Flexible Loader API**: Support for custom data loading when cache miss occurs.
- **Minimal Dependency**: Pure Go standard library implementation.

## Project Structure

```
gee-cache/
├── byteview.go      # Encapsulate bytes data
├── cache.go         # LRU cache and cache group logic
├── geecache.go      # Main cache API (group, getter)
├── http.go          # HTTP server/client for peer communication
├── lru/             # LRU cache module
├── singleflight/    # Prevent cache stampede
└── README.md        # Documentation
```

## Installation

Make sure you have Go installed (1.18+ recommended).

```bash
git clone https://github.com/geektutu/7days-golang.git
cd 7days-golang/gee-cache
go mod tidy
```

## Quick Start

1. Start multiple cache server nodes:

```bash
cd 7days-golang/gee-cache
go run main.go -port=8001
go run main.go -port=8002
go run main.go -port=8003
```

2. Start an API server to access the cache:

```bash
go run main.go -port=9999 -api=true
```

3. Query the cache using curl:

```bash
curl "http://localhost:9999/api?key=Tom"
```

If `Tom` is not cached, the system will fetch it from a simulated database and cache it for subsequent requests.

## Demo

Here is a simple demo diagram:

```
Client --> API Server --> GeeCache Group
                        --> Node 1
                        --> Node 2
                        --> Node 3
```

- If a node has the key, it returns it.
- If not, the node loads the key from the "database" and caches it.

## Why GeeCache?

- To understand distributed caching mechanisms
- To practice Go concurrency patterns
- To learn consistent hashing and peer management
- Lightweight and self-contained codebase

## Future Work

- Add gRPC support for peer communication
- Add TTL (Time To Live) support for cache expiration
- Add monitoring metrics

## License

MIT License. See [LICENSE](../LICENSE) for details.