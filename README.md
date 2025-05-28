# Zephyr Docker Development Environment

This repository provides a ready-to-use Dockerfile for developing with the [Zephyr RTOS](https://zephyrproject.org/) on Ubuntu 24.04 or later, with all dependencies, Python environment, and Zephyr SDK installed according to the official [Zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html).

## Features

- CMake (from Kitware APT, meets Zephyr's minimum version)
- Python 3.10 (from deadsnakes PPA)
- All Zephyr build dependencies (device-tree-compiler, Ninja, etc)
- West tool and all Zephyr modules
- Zephyr SDK (via `west sdk install`)
- User-level setup with Python venv auto-activation

## Usage

### 1. Build the Docker Image

```sh
docker build -t zephyr-dev .
```

### 2. Run the Container

For normal use:
```sh
docker run -it zephyr-dev
```

For USB device access:
```sh
docker run -it --privileged zephyr-dev
```

> **Tip:** The virtual environment in `~/zephyrproject/.venv` will be activated automatically on shell login.

## Inside the Container

- The Zephyr workspace is located at `~/zephyrproject`.
- The Python virtual environment is located at `~/zephyrproject/.venv` and is pre-activated.
- The Zephyr SDK is installed via `west sdk install` in `~/zephyrproject/zephyr`.

### Example Usage

To build a Zephyr sample:

```sh
cd ~/zephyrproject/zephyr
# List available boards
west boards list
# Build a sample (replace BOARD with one from the list)
west build -b BOARD samples/hello_world
```

To flash a board (ensure you run Docker with `--privileged` and USB access):

```sh
west flash
```

## Notes

- If you use a different Zephyr workspace name, adjust paths accordingly.
- For other host OS versions, see the [Zephyr documentation](https://docs.zephyrproject.org/latest/develop/getting_started/index.html).

## Reference

- [Zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)
- [Kitware CMake APT](https://apt.kitware.com/)
- [Deadsnakes Python PPA](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa)

---
