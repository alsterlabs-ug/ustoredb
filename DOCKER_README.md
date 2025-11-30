# UStore Docker Build

This directory contains Docker support for building and running UStore database.

## Quick Start

### Using Docker Compose (Recommended)

1. **Build and run with Docker Compose:**
```bash
docker-compose up --build
```

2. **Run specific backend:**
```bash
# RocksDB backend (recommended for production)
docker-compose up --build ustore

# UCSet backend (in-memory)
docker-compose up --build ustore
# Then modify command in docker-compose.yml to use ./ucset_server

# LevelDB backend
docker-compose up --build ustore
# Then modify command in docker-compose.yml to use ./leveldb_server
```

### Using Docker directly

1. **Build the image:**
```bash
docker build -t ustore .
```

2. **Run the container:**
```bash
# Create data directory
mkdir -p ./data

# Run RocksDB server
docker run -p 38709:38709 -v $(pwd)/data:/var/lib/ustore/data ustore ./rocksdb_server

# Or run UCSet server (in-memory)
docker run -p 38709:38709 ustore ./ucset_server
```

## Architecture

The Docker image includes three UStore server binaries:
- `ucset_server`: In-memory backend using UCSet
- `leveldb_server`: Persistent backend using LevelDB
- `rocksdb_server`: High-performance persistent backend using RocksDB

## Configuration

The server uses Apache Arrow Flight RPC protocol on port 38709. Configuration files are located in `assets/configs/`.

## Building for Multiple Architectures

To build for both AMD64 and ARM64:

```bash
docker buildx build --platform=linux/amd64,linux/arm64 -t ustore .
```

## Publishing

To publish to Docker Hub (requires authentication):

```bash
./docker/publish.sh
```

This will build and push multi-architecture images to `alsterlabs/ustoredb`.

## Features Included

- ✅ Core Arrow/RocksDB Engine
- ✅ Apache Arrow Flight RPC Server
- ✅ UCSet (in-memory) backend
- ✅ LevelDB backend
- ✅ RocksDB backend
- ❌ Python bindings (disabled)
- ❌ REST API server (disabled)
- ❌ BSON document support (disabled)
- ❌ MsgPack document support (disabled)

## Development

For development builds with tests enabled:

```bash
docker build --build-arg TEST_USTORE=True -t ustore-dev .
```
