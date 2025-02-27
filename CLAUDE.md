# Overview
This is a nix environment, built for compiling bitcoin core on macOS.

# Build

```bash
  cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_GUI=OFF -DBUILD_TESTS=OFF -DWITH_QRENCODE=OFF
  cmake --build build
```

# Clangd

It seems likely clangd can't find definition of `unint8_t`, `boost::mpl::bool_`, and can't find system file like `#include <cassert>`.

And clangd can't find header files from libevent, sqlite3, boost.

Your task is to update `./.clangd`, fix this issue.
