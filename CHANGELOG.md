# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.13.12] - November 2024

### Added
- Latest stable release with all modern features
- Enhanced Arrow/RocksDB integration
- Improved build system and dependency management

### Changed
- Updated to RocksDB 8.8.1 for better performance and compatibility
- Modernized Conan 2.x build system
- Enhanced cross-platform support

## [0.13.0] - 2024

### Added
- Major version bump with significant improvements
- Enhanced vector operations and modalities
- Better error handling and stability

## [0.12.0] - 2024

### Added
- Continued development and feature enhancements
- Performance optimizations
- Extended API capabilities

## [0.11.0] - 2024

### Added
- Additional modalities and data type support
- Improved concurrency handling
- Enhanced documentation

## [0.10.0] - 2024

### Added
- Major architectural improvements
- New data processing capabilities
- Better integration options

## [0.9.0] - 2024

### Added
- Enhanced graph processing features
- Improved document handling
- Better Python bindings

## [0.8.0] - 2023

### Added
- Continued development of core features
- Performance enhancements
- API improvements

## [0.7.0] - 2023

### Added
- Major feature additions and improvements
- Enhanced multimodal capabilities
- Better stability and performance

## [0.6.0] - 2023

### Added
- Significant functionality enhancements
- New data modalities support
- Improved build system

## [0.5.0] - 2023

### Added
- Semantic versioning implementation
- Configurations for LevelDB and RocksDB collections
- OpenSSL static library support
- Uniform config system for all engines

### Changed
- Improved build and configuration management

## [0.4.x] - 2022-2023

### Added
- Multiple incremental releases with bug fixes and improvements
- Enhanced stability and performance
- Additional configuration options

## [0.2.0] - July 2022

### Added

- Fully-functional RocksDB backend.
- LevelDB backend, which has no support for transactions or named collections.
- Graph collection logic, which can operate on top of any binary KVS.
- Documents collection logic, which packs & queries JSONs, MsgPacks and other hierarchical docs into any binary KVS.
- Support for JSON-Pointer, JSON-Patch and JSON Merge Patch as an alternative to custom query language.
- NetworkX Python bindings with Python Protocol Buffers support.

## [0.1.0] - June 2022

### Added

- Initial binary KVS headers with "strided" arguments support.
- Initial implementation of STL-based in-memory KV store.
- PyBind-based bindings, mimicking a transactional `dict[str, dict[int, bytes]]`.
- PyBind-based interface for NumPy matrix exports.
- GoLang basic interface for single-entry operations.
- JNI interface with support for single operations and transactions.

[0.13.12]: https://github.com/unum-cloud/ustore/releases/tag/v0.13.12
[0.13.0]: https://github.com/unum-cloud/ustore/compare/v0.12.0...v0.13.0
[0.12.0]: https://github.com/unum-cloud/ustore/compare/v0.11.0...v0.12.0
[0.11.0]: https://github.com/unum-cloud/ustore/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/unum-cloud/ustore/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/unum-cloud/ustore/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/unum-cloud/ustore/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/unum-cloud/ustore/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/unum-cloud/ustore/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/unum-cloud/ustore/compare/v0.4.2699...v0.5.0
[0.2.0]: https://github.com/unum-cloud/ustore/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/unum-cloud/ustore/releases/tag/v0.1.0
