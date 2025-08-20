# Contributing

## Environment requirements

### Git repo

To clone the repo, run, use this command

```bash
git clone https://github.com/tfslabs/vlmcsd.git
```

### Build with `make`

To build with `make`, make sure you have installed `gcc`, `make`, and `glibc`

#### On Windows

You can try install [GNU Windows](https://github.com/tfslabs/gnu-windows/releases/tag/1.1.0). ([How to install on Windows?](https://github.com/tfslabs/gnu-windows/wiki/Installing-GNU-Windows-binaries))

#### On Linux

Depends on your distribution, the installation may differ.

```bash
# Ubuntu/Debian
apt install -y gcc make

# Fedora
dnf groupinstall "Development Tools"

# Arch Linux
pacman -S gcc base-devel
```

### Build with Visual Studio (only for Windows)

To contribute, you may need Visual Studio 2022. Required Visual Studio 2022 SDKs:

* C++ Windows XP Support for VS 2017 (v141) Tools
* Windows 10 SDK (10.0.18362.0)
* Windows Universal C Runtime

## Build from source

### With `make`

```bash
make
```

For advanced build with `make`, you can use

```bash
make help
```

### With Docker container

To build, `Dockerfile` are provided in the `.docker` folder. Note that the multi-arch may need to include `--platform`. Currently, `vlmcsd` supports these following architecture(s)

* `linux/amd64`
* `linux/arm64/v8`
* `linux/ppc64le`
* `linux/s390x`
* `linux/riscv64`

For example, the command below supports building `vlmcsd` for Linux running on AMD64

```bash
docker build --platform linux/amd64 -f .docker/Dockerfile -t theflightsims/vlmcsd:linux-amd64 .
```

For building with multiple architecture(s), there are `.docker/quick_build.sh` (for Linux) and `.docker/quick_build.cmd` (for Windows).

### With Visual Studio

In the `VisualStudio` folder, there are some built-in projects.

However, since this project is a part of [Windows Server Management Tool](https://github.com/TheFlightSims/windowsserver-mgmttools), you may need to clone the whole repo, before using Visual Studio, because the full Visual Studio Solution are already configured with valid build configurations.

### Manage database

* [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD

> For the [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD, please review in the License Manager manual.

* External database

> VLMCSD Database is the binary, external to the internal VLMCSD database. You can configure it in `vlmcsd.ini`, or providing the command line.

* Internal database

> The internal VLMCSD databases are, both includes in `src/kmsdata.c` and `src/kmsdata-full.c` files.

## Validate the application

To quick validating the Volume License Management Service DAEMON, you can use a quick Python3 script in the `.test`
