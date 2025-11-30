#include <iostream>
#include <arrow/api.h>
#include <rocksdb/db.h>

int main() {
    std::cout << "Testing Arrow + RocksDB compatibility..." << std::endl;

    // Test Arrow
    arrow::Status status = arrow::Status::OK();
    std::cout << "Arrow status: " << status.ToString() << std::endl;

    // Test RocksDB
    rocksdb::Options options;
    options.create_if_missing = true;
    rocksdb::DB* db;
    rocksdb::Status rocks_status = rocksdb::DB::Open(options, "/tmp/test_db", &db);
    std::cout << "RocksDB status: " << rocks_status.ToString() << std::endl;

    if (db) {
        delete db;
    }

    std::cout << "Arrow + RocksDB compatibility test completed!" << std::endl;
    return 0;
}
