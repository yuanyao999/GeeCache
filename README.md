# 🧠 GeeCache - A Simple Distributed Caching System in Go

GeeCache is a lightweight, distributed caching system implemented in Go, inspired by [GroupCache](https://github.com/golang/groupcache). It supports peer-to-peer communication, consistent hashing, local memory caching, and automatic data loading from a fallback source (like a database).

> 🚀 Designed and built from scratch for educational and practical use, following [7days-Golang](https://geektutu.com/post/geek-golang.html).

---

## 📌 Features

- 🔗 **Consistent Hashing** for distributing keys across nodes
- 🧱 **Local in-memory cache** with optional LRU eviction (in `lru.go`)
- 🔄 **Peer communication** via HTTP/gRPC to retrieve cache entries
- 🐢 **SlowDB simulation** to demonstrate lazy loading and caching
- 📦 **Modular design** for easy extension and testing

---

## 🗂️ Project Structure

```
GeeCache/
├── geecache/            # Core caching logic (Group, LRU, PeerPicker, HTTP pool)
│   ├── cache.go
│   ├── lru.go
│   ├── group.go
│   ├── peers.go
│   └── http.go
├── geecachepb/          # gRPC proto definitions and generated files
│   ├── geecachepb.proto
│   ├── geecachepb.pb.go
│   └── geecachepb_grpc.pb.go
├── run.sh               # One-click startup script for 3 nodes + API server
├── go.mod
├── go.sum
└── README.md
```

---

## 🚀 Quick Start

### 1. Clone the repo

```bash
git clone https://github.com/yuanyao999/GeeCache.git
cd GeeCache
```

### 2. Generate Protobuf (if modified)

```bash
cd geecachepb
protoc --go_out=. --go-grpc_out=. --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative geecachepb.proto
cd ..
```

### 3. Run all servers

```bash
./run.sh
```

This will:
- Compile the server
- Start 3 cache nodes on ports `8001`, `8002`, `8003`
- Start a frontend API server on `localhost:9999`

### 4. Test the cache

```bash
curl "http://localhost:9999/api?key=Tom"
```

Expected logs:

```log
[Server http://localhost:8001] GET /_geecache/scores/Tom
[SlowDB] search key Tom
[GeeCache] hit
```

---

## 📖 How It Works

1. `Group` is the core of GeeCache. It maintains a main cache and handles data retrieval.
2. If a key is not found in local memory, it either:
    - Fetches it from a peer via HTTP/gRPC
    - Or calls the `Getter` function to load it (e.g., from SlowDB)
3. Retrieved data is stored in local cache and returned.

---

## 🛠️ Example: Adding a New Key

You can simulate dynamic key loading and see peer selection via consistent hashing by accessing:

```bash
curl "http://localhost:9999/api?key=Sam"
curl "http://localhost:9999/api?key=Jack"
```

---

## 🧪 Test Output

Example test run:
```bash
$ ./run.sh

>> Starting cache servers...
geecache is running at http://localhost:8001
...
>> Sending test requests
[SlowDB] search key Tom
[GeeCache] hit
[GeeCache] hit
```

---

## 📦 Dependencies

- Go ≥ 1.17
- Protobuf compiler (`protoc`)
- `google.golang.org/protobuf`
- `google.golang.org/grpc`

Install protoc plugins if you haven't:

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

---

## 🙋 About

This project was implemented from scratch as part of a Go learning journey.  
Maintained by [@yuanyao999](https://github.com/yuanyao999).  
Based on ideas from [geektutu's 7days-Golang](https://github.com/geektutu/7days-golang).

---

## 📄 License

MIT License. See [`LICENSE`](LICENSE) file for details.