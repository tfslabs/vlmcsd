> ⚠️
>
> Since version 2410, we are no longer updated the VLMCSD on Floppy disk. Instead, we encourage people to move to Docker container - which is more reliable, and easier to deploy and management.

# Volume License Management Service

![Docker Tracker](https://img.shields.io/docker/pulls/theflightsims/vlmcsd)

***VLMCSD*** is a free, open-source software to provide an volume activation service for any computer running Office and Windows products.

> For guide and help (written by the original developers), [see here](https://github.com/tfslabs/vlmcsd/tree/master/man)

## Original Contributors

| Contributor | Description |
|--|--|
| Hotbird64 | Original developer of VLMCSD |
| Erik Andersen | Original developer of VLMCSD |
| Waldemar Brodkorb | Original developer of VLMCSD |
| Denys Vlasenko | Original developer of VLMCSD |
| H. Peter Anvin | Original developer of VLMCSD |
| [Wind4](https://github.com/Wind4/vlmcsd) | Contributor of VLMCSD |
| [kkkgo](https://github.com/kkkgo) | Contributor of VLMCSD |
| [HarukaMa](https://github.com/HarukaMa) | Contributor of VLMCSD |
| Nang | Contributor of VLMCSD database |
| [shiroinekotfs](https://github.com/shiroinekotfs) | Contributor of VLMCSD and VLMCSD Database |
| [anhvlt-2k6](https://github.com/anhvlt-2k6) | Contributor of VLMCSD and VLMCSD Database |

## Use VLMCSD & License Manager

### Use the VLMCSD command line

| VLMCSD App | Description | Command line |
| -- | -- | -- |
| `vlmcs` | `vlmcs` is a program that can be used to test a KMS server that provides activation for Microsoft products. It supports KMS 4, KMS 5, and KMS 6 protocol. | [See the document](https://github.com/tfslabs/vlmcsd/blob/master/man/vlmcs.1.unix.txt) |
| `vlmcsd` | `vlmcsd` is a fully Microsoft-compatible KMS server that provides product activation services to clients. It is a drop-in replacement for a Microsoft KMS server. It supports KMS 4, KMS 5, and KMS 6 protocol. | [See the document](https://github.com/tfslabs/vlmcsd/blob/master/man/vlmcsd.7.unix.txt) |
| `vlmcsdmulti` | `vlmcsdmulti` is a multi-call binary that contains `vlmcs` and `vlmcsd` in a  single binary. Since both programs share much code and data, the combined binary is significantly smaller than the sum of both files. | [See the document](https://github.com/tfslabs/vlmcsd/blob/master/man/vlmcsdmulti.1.unix.txt)|

### One-click install for `systemd`

> :warning: Note
>
> Only available when you have installed `gcc`, `git`, `glibc`, and `make` in your system

```bash
curl -sSL https://raw.githubusercontent.com/tfslabs/vlmcsd/refs/heads/master/.systemd/install.sh | sudo bash
```

### Use VLMCSD on Docker

On a system having too many applications running, using `docker` is the better way to deploy, maintain, and retire `vlmcsd`

Containerized `vlmcsd` for both Linux and Windows are available on [Docker Hub](https://hub.docker.com/r/theflightsims/vlmcsd). By default, the container will expose port 1688.

* For Windows Server editions, these images are available for Windows Server 2016 and up. You can try to run these images by using these following command lines

```cmd
:: Windows Server 2022 container
docker run -p 1688:1688 theflightsims/vlmcsd:ltsc2022-amd64
```

* For Linux, containerized images are available for **supporting architectures**. You can try these available architectures by using following command lines

```bash
# AMD64
docker run -p 1688:1688 theflightsims/vlmcsd:linux-amd64

# ARM64
docker run -p 1688:1688 theflightsims/vlmcsd:linux-arm64
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

### Build & Manage Database

* [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD

For the [License Manager](https://github.com/tfslabs/license-manager) database exports to VLMCSD, please review in the License Manager manual.

* VLMCSD database

VLMCSD Database is the binary, external to the internal VLMCSD database. You can configure it in `vlmcsd.ini`, or you can use CLI.

* Internal VLMCSD database

The internal VLMCSD databases are, both includes in `src/kmsdata.c` and `src/kmsdata-full.c` files.

## Activation Error Codes & Limitations

### Error codes

|Error code |Error message |Activation&nbsp;type|
|-----------|--------------|----------------|
|0x8007000D | The KMS host you are using cannot handle your product. It only supports legacy versions. | KMS client |
|0x8004FE21|This computer is not running genuine Windows.  |MAK/KMS client |
|0x80070005 |Access denied. The requested action requires elevated privileges. |MAK/KMS client/KMS host |
|0x8007007b| DNS name does not exist. |KMS client |
|0x80070490|The product key you entered didn't work. Check the product key and try again, or enter a different one. |MAK |
|0x800706BA |The RPC server is unavailable. |KMS client |
|0x8007232A|DNS server failure.  |KMS host  |
|0x8007232B|DNS name does not exist. |KMS client |
|0x8007251D|No records found for DNS query. |KMS client |
|0x80092328|DNS name does not exist.  |KMS client |
|0xC004B100 |The activation server determined that the computer could not be activated. |MAK |
|0xC004C001|The activation server determined the specified product key is invalid |MAK|
|0xC004C003 |The activation server determined the specified product key is blocked |MAK |
|0xC004C008 |The activation server determined that the specified product key could not be used. |KMS |
|0xC004C020|The activation server reported that the Multiple Activation Key has exceeded its limit. |MAK |
|0xC004C021|The activation server reported that the Multiple Activation Key extension limit has been exceeded. |MAK |
|0xC004F009 |The Software Protection Service reported that the grace period expired. |MAK |
|0xC004F00F|The Software Licensing Server reported that the hardware ID binding is beyond level of tolerance. |MAK/KMS client/KMS host |
|0xC004F014|The Software Protection Service reported that the product key is not available |MAK/KMS client |
|0xC004F02C|The Software Protection Service reported that the format for the offline activation data is incorrect. |MAK/KMS client |
|0xC004F035|The Software Protection Service reported that the computer could not be activated with a Volume license product key. |KMS client/KMS host |
|0xC004F038 |The Software Protection Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator. |KMS client |
|0xC004F039|The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) is not enabled. |KMS client |
|0xC004F041|The Software Protection Service determined that the Key Management Server (KMS) is not activated. KMS needs to be activated.  |KMS client |
|0xC004F042 |The Software Protection Service determined that the specified Key Management Service (KMS) cannot be used. |KMS client |
|0xC004F050|The Software Protection Service reported that the product key is invalid. |MAK/KMS/KMS client |
|0xC004F051|The Software Protection Service reported that the product key is blocked. |MAK/KMS |
|0xC004F064|The Software Protection Service reported that the non-genuine grace period expired. |MAK |
|0xC004F065|The Software Protection Service reported that the application is running within the valid non-genuine period. |MAK/KMS client |
|0xC004F06C|The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) determined that the request timestamp is invalid. |KMS client |
|0xC004F074|The Software Protection Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information. |KMS client |
