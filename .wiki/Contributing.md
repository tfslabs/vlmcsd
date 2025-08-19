## Build and developing

### With `make`

```bash
make
```

For advanced build with `make`, you can use

```bash
make help
```

### Build containers

To build, `Dockerfile` are provided in the `.docker` folder. Note that the multi-arch may need to include `--platform`. Currently, `vlmcsd` supports these following architecture

* `linux/amd64`
* `linux/arm64/v8`
* `linux/ppc64le`
* `linux/s390x`
* `linux/riscv64`

For example, the command below supports building `vlmcsd` for Linux running on AMD64

```bash
docker build --platform linux/amd64 -f .docker/Dockerfile -t theflightsims/vlmcsd:linux-amd64 .
```

### With Visual Studio

Since this project is a part of [Windows Server Management Tool](https://github.com/TheFlightSims/windowsserver-mgmttools), you may need to clone the whole repository, before using Visual Studio.

### Build & Manage Database

* [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD

For the [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD, please review in the License Manager manual.

* VLMCSD database

VLMCSD Database is the binary, external to the internal VLMCSD database. You can configure it in `vlmcsd.ini`, or you can use CLI.

* Internal VLMCSD database

The internal VLMCSD databases are, both includes in `src/kmsdata.c` and `src/kmsdata-full.c` files.