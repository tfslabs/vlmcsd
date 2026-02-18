> ⚠️
>
> Since version 2410, we are no longer updated the VLMCSD on Floppy disk. Instead, we encourage people to move to Docker container - which is more reliable, and easier to deploy and manage.

# Volume License Management Service

![Docker Tracker](https://img.shields.io/docker/pulls/theflightsims/vlmcsd)

[![CodeQL Advanced](https://github.com/tfslabs/vlmcsd/actions/workflows/codeql.yml/badge.svg)](https://github.com/tfslabs/vlmcsd/actions/workflows/codeql.yml)
[![Build static VLMCSD binary](https://github.com/tfslabs/vlmcsd/actions/workflows/build.yml/badge.svg)](https://github.com/tfslabs/vlmcsd/actions/workflows/build.yml)
[![Build Docker image (all architectures)](https://github.com/tfslabs/vlmcsd/actions/workflows/docker.yml/badge.svg)](https://github.com/tfslabs/vlmcsd/actions/workflows/docker.yml)

[![GitLab CI/CD](https://img.shields.io/badge/gitlab-repo-orange?logo=gitlab)](https://devops.theflightsims.com/tfsinfra/vlmcsd)

**Volume License Management Service** is a free, open-source software to provide a volume-activation for Windows and Office products.

It is the replacement (or the solution for Linux) of [Key Management Services on Windows Server](https://learn.microsoft.com/en-us/windows-server/get-started/kms-activation-planning) (in term of operation), by provide less infrastructure compared to the Windows Server deployment (even the minimal one), or act as a backup solution in case the main Windows KMS Host fails.

> For guide and help (written by the original developers), [see here](https://github.com/tfslabs/vlmcsd/tree/master/man)

## One-click install for `systemd`

> :warning: Note
>
> Only available when you have installed `gcc`, `git`, `glibc`, and `make` in your system

```bash
curl -sSL https://raw.githubusercontent.com/tfslabs/vlmcsd/refs/heads/master/.systemd/install.sh | sudo bash
```

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
