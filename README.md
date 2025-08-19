> ⚠️
>
> Since version 2410, we are no longer updated the VLMCSD on Floppy disk. Instead, we encourage people to move to Docker container - which is more reliable, and easier to deploy and management.

# Volume License Management Service

![Docker Tracker](https://img.shields.io/docker/pulls/theflightsims/vlmcsd)

***VLMCSD*** is a free, open-source software to provide an volume activation service for any computer running Office and Windows products.

> For guide and help (written by the original developers), see [here](https://github.com/tfslabs/vlmcsd/tree/master/man)

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

### With Visual Studio

Since this project is a part of [Windows Server Management Tool](https://github.com/TheFlightSims/windowsserver-mgmttools), you may need to clone the whole repository, before using Visual Studio.
