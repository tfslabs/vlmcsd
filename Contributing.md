# Contributing

## Environment requirements

### Git repo

To clone the repo, run, use this command

```bash
git clone https://github.com/tfslabs/vlmcsd.git
```

### Build with `make`

To build with `make`, make sure you have installed `gcc`, `make`, and `glibc`. Depends on your distribution, the installation may differ.

```bash
# Ubuntu/Debian
apt install -y gcc make

# Fedora
dnf groupinstall "Development Tools"

# Arch/Msys2
pacman -S gcc base-devel
```

### Build with Visual Studio (only for Windows)

To contribute, you may need Visual Studio. Required Visual Studio SDKs:

* MSVC v142 - VS 2019 C++ x64/x86 build tools
* MSVC v142 - VS 2019 C++ x64/x86 Spectre-mitigated libs *(optional)*
* [Windows 10 SDK (10.0.17763.7010)](https://learn.microsoft.com/en-us/windows/apps/windows-sdk/downloads)

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

To build, `Dockerfile` are provided in the `.docker` folder. Note that the multi-arch may need to include `--platform`. Currently, `vlmcsd` supports these following architecture

* `linux/386`
* `linux/amd64`
* `linux/arm/v5`
* `linux/arm/v7`
* `linux/arm64/v8`
* `linux/ppc64le`
* `linux/riscv64`
* `linux/s390x`

For example, the command below supports building `vlmcsd` for Linux running on AMD64

```bash
docker build --platform linux/amd64 -f .docker/Dockerfile -t theflightsims/vlmcsd:linux-amd64 .
```

### With Visual Studio

In the `VisualStudio` folder, there are some built-in projects.

You can open the `vlmcsd.sln` project solution in the `VisualStudio` folder.

### Manage database

* [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD

> For the [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD, please review in the License Manager manual.

* External database

> VLMCSD Database is the binary, external to the internal VLMCSD database. You can configure it in `vlmcsd.ini`, or providing the command line.

* Internal database

> The internal VLMCSD databases are, both includes in `src/kmsdata.c` and `src/kmsdata-full.c` files.
