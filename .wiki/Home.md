> ⚠️
>
> Since version 2410, we are no longer updated the VLMCSD on Floppy disk. Instead, we encourage people to move to Docker container - which is more reliable, and easier to deploy and manage.

# Volume License Management Service

![Docker Tracker](https://img.shields.io/docker/pulls/theflightsims/vlmcsd)

**Volume License Management Service** is a free, open-source software to provide an volume activation service Office and Windows product.

It is the replacement (or the solution for Linux) of [Key Management Services on Windows Server](https://learn.microsoft.com/en-us/windows-server/get-started/kms-create-host) (in term of operation), by provide less infrastructure compared to the Windows Server deployment (even the minimal one), or act as a backup solution in case the main Windows KMS Host fails.

> For guide and help (written by the original developers), [see here](https://github.com/tfslabs/vlmcsd/tree/master/man)

## Original Contributors

| Contributor | Description |
|--|--|
| Hotbird64 | Original developer of VLMCSD |
| [Wind4](https://github.com/Wind4/vlmcsd) | Contributor of VLMCSD |
| [kkkgo](https://github.com/kkkgo) | Contributor of VLMCSD |
| [HarukaMa](https://github.com/HarukaMa) | Contributor of VLMCSD |
| Nang | Contributor of VLMCSD database |
| [shiroinekotfs](https://github.com/shiroinekotfs) | Contributor of VLMCSD and VLMCSD Database |
| [anhvlt-2k6](https://github.com/anhvlt-2k6) | Contributor of VLMCSD and VLMCSD Database |

## Deploy Volume License Management Service

### One-click install for `systemd`

> :warning: Note
>
> Only available when you have installed `gcc`, `git`, `glibc`, and `make` in your system.
>
> On Ubuntu/Debian, you can try `apt install -y gcc git make`

```bash
curl -sSL https://raw.githubusercontent.com/tfslabs/vlmcsd/refs/heads/master/.systemd/install.sh | sudo bash
```

### Use VLMCSD on Docker

On a system having too many applications running, using `docker` is the better way to deploy, maintain, and retire `vlmcsd`

Containerized `vlmcsd` for both Linux are available on [Docker Hub](https://hub.docker.com/r/theflightsims/vlmcsd). By default, the container will expose port 1688. Containerized images are available for **supporting architectures**. You can try these available architectures by using following command lines

```bash
# AMD64
docker run -p 1688:1688 theflightsims/vlmcsd:linux-amd64

# ARM64
docker run -p 1688:1688 theflightsims/vlmcsd:linux-arm64
```

### Advanced deployment with command line

> You can see the original developer guide, which can be seen in [`man` folder](https://github.com/tfslabs/vlmcsd/tree/master/man)

If you want to deploy by yourself, you can try advanced arguments with `vlmcsd` (Volume License Management Service DAEMON)

```bash
$ ./vlmcsd -h
Volume License Management Service DAEMON (vlmcsd)
Build Date: Aug 19 2025

Usage:
        ./vlmcsd [Options]

Available options:
 -u <user>              set uid to <user>
 -g <group>             set gid to <group>
 -a <csvlk>=<epid>      Use an ePID value for a set of CSVLK. ePID is known as the ID of the activation client, while the CSVLK is the key for KMS activation
 -r (0|1|2)             Set randomization level of the ePIDs (default is "0")
                                "0" stands for no randomization, which also means VLMCSD will use the default ePID that is built-in. It is useful for emulating/replicating real KMS servers
                                "1" stands for randomization of each KMS request, but it also poses a risk of being detected non-genuine KMS Server, causing clients to fail to be activated
                                "2" is as same as the "1" option, but only for debugging
 -C <LCID>              Use fixed Windows Language Code Identifier in random ePIDs
                                See https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-lcid/a9eac961-e77d-41a6-90a5-ce1a8b0cdb9c for correct LCIDs
 -H <build>             Use fixed Windows build number for activation
                                Useful when the client requires a proper KMS Server
                                See all build numbers here: https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
 -o (0|1|2|3)           Set protection level against clients with public IP addresses (default 0)
                                "0" for no protection, allowing all IP addresses to use KMS service
                                "1" only allows VLMCSD service replies connection with IP addresses in the range define by RFC1918 and RFC6598
                                "2" does not affect the interfaces, while it only check if the client is either external (outbound) and drops its TCP packets when detected
                                "3" is the combination of "1" and "2", for dropping package to that public IP addresses and no reply to that IP addresses
 -x (0|1)               Configure how VLMCSD deal with errors while operating (default 0)
                                "0" will make VLMCSD stay as long as possible, only exit the interface that having problem (including VPN)
                                "1" will exit VLMCSD process if there are any problem with any network interface
 -L <address>[:port]    Listen on the specific IP Address (IPv4/IPv6) with port defined optionally
 -P <port>              Set the specific TCP port for subsequent "-L" statement (default 1688)
                                If you use "-P" alongside with "-L", "-P" must be specified before "-L"
 -F0, -F1               Disable/enable binding to foreign IP addresses
 -m <clients>           Maximum clients VLMCSD can handle at the same time
 -e                     Logging to command line interface (stdout). Useful when running VLMCSD on Docker Container, or floppy on Virtual Machine
 -D                     Run VLMCSD in foreground, useful when in the debugging. Windows is not compatible with this feature
 -K (0|1|2|3)           Set white-listing level which product VLMCSD accepts or refuses (default 0)
                                "0" Activate all products with an unknown, retail or beta/preview KMS IDs
                                "1" Activate products with a retail or beta/preview KMS ID but refuse to activate products with an unknown KMS ID
                                "2" Activate products with an unknown KMS ID but refuse products with a retail or beta/preview KMS ID
                                "3" Activate only products with a known volume license RTM KMS ID and refuse all others
 -c (0|1)               Disable (0)/Enable (1) client time checking
                                If the client time is different than 4 hours compare to the KMS Host, the host will deny the activation (default 0)
                                Note: It is recommended that the VLMCSD has a reliable time service (e.g. sync the time with time.windows.com)
 -M (0|1)               Disable (0)/Enable (1) maintaining clients (default 0)
                                Note: Enabling this service is not recommended, except you have to do so to prevent the activation failling
                                It is because the VLMCSD can only keep maximum of 16777215 clients. If that number exceed, VLMCSD will no longer accept any new connect, nor activation requests
 -E (0|1)               Disable (0)/Enable (1) starting VLMCSD with empty client list (Default 0)
                                Note: It is recommended to keep the default, because Office will not activate unless your KMS Host has at least 5 active clients.
                                See more: https://learn.microsoft.com/en-us/office/troubleshoot/administration/0xc004f038-computer-not-activate
 -t <seconds>           Disconnect client after an amount of time of inactivity (default 30)
 -d                     Disconnect each client after processing one activation request.
 -k                     Do not disconnect clients after processing an activation request (default if "-d" defined in external VLMCSD configuration file).
 -N (0|1)               Disable (0)/Enable (default, 1) NDR64. Only useful when on Windows Vista/7 32-bit, where enabling NDR64 will make VLMCSD by running higher Windows build number.
 -B (0|1)               Disable (0)/Enable (1) bind time feature negotiation in RPC protocol.
 -p <file>              Create pid file filename. This is used by standard init scripts (typically found in "/etc/init.d").
 -i <file>              Use external VLMCSD configuration file. Default name of that file is "vlmcsd.ini".
 -j <file>              Use external VLMCSD ePID database. Default name of that file is "vlmcsd.kmd".
 -R <interval>          Renew activation every <interval> (default 1w).
 -A <interval>          Retry activation every <interval>, if the previous activation/reactivation is failed (default 2h).
 -l <file>              Writes VLMCSD log into a file. Note: Make sure you have read+write access to that file.
 -T0, -T1               Disable (0)/Enable logging client connection with time and date (default 1).
 -v                     Allow logging verbose.
 -q                     Don't allow log verbose (default).
 -V                     Display version information and exit
```

However, your configuration may need to be verified before implement in practical. To test it, you can use `vlmcs` (Volume License Management Service - Client Emulator)

```bash
$ ./vlmcs -l
Volume License Management Service - Client Emulator
Build Date: Aug 19 2025
Usage: ./vlmcs [<Host>:<port> | <FQDN>:<port> ] [Advanced Options]

Basic Operation:
  <host>:       Host name of the KMS to use. Blank means leaving the default local hosting
  <FQDN>:       Target to the VLMCSD server with a Domain or FQDN
  <port>:       TCP port name of the KMS to use. Blank means leaving the default port 1688.

Advanced options:
  -v:           Verbose logging
  -l:           Using available Application ID, which can be shown in "./vlmcs -x"
  -4:           Force KMS V4 protocol
  -5:           Force KMS V5 protocol
  -6:           Force KMS V6 protocol
  -i:           Use IP protocol (4 or 6)
  -j:           Load external KMS data file
  -e:           Show some valid examples
  -x:           Show valid Apps
  -d:           No DNS names, use NetBIOS names (no effect if -w is used)
  -V:           Show version information and exit
  -a:           Use custom Application GUID
  -s:           Use custom Activation Configuration GUID
  -k:           Use custom KMS GUID
  -c:           Use custom Client GUID. Default: Use random
  -o:           Use custom previous Client GUID. Default: ZeroGUID
  -K:           Use a specific (possibly invalid) protocol version
  -w:           Use custom workstation name. Default: Use random
  -r:           Fake required clients
  -n:           Fixed # of requests (Default: Enough to charge)
  -m:           Pretend to be a virtual machine
  -G:           Get ePID/HwId data and write to <file>. Can't be used with -l, -4, -5, -6, -a, -s, -k, -r and -n
  -T:           Use a new TCP connection for each request.
  -N:           <0|1> disable or enable NDR64. Default: 1
  -B:           <0|1> disable or enable RPC bind time feature negotiation. Default: 1
  -t:           Use specific license status (0 <= T <= 6)
  -g:           Use a specific binding expiration time in minutes. Default 43200
  -P:           Ignore priority and weight in DNS SRV records
  -p:           Don't use multiplexed RPC bind
```

Normally, the recommendation for the daemon service is ...

```bash
vlmcsd -P 1688 -H 26100 -C 1033 -T0 -e -v -D
```

... which means

* `-P 1688` - It exposes (uses) the port 1688 (default of KMS).
* `-H 26100` - Host build (Windows build) is 26100 (that is the build number of Windows Server 2025). You can alter this to your current latest build number.
* `-C 1033` - The locale language is English (US)
* `-T0` - Do not check the current time. It is for the validation
* `-e` - Logging to `stdout`. Useful to check logging on Docker or on `systemd`
* `-v` - Verbose logging
* `-D` - Running in foreground

## Configuring Volume License Management Service in your network

Once deployed, the service may need to be configured. By deploying using Docker or the default `systemd` above, the service just work right away. However, there are still some aspects of deployment, operating, and managing being concerned:

### Fail tolerance

Usually, some environments (with a high number of computers) require a large number of activation requests and a small, single server may not good enough. Since `vlmcsd` is designed for small, easy deployment, you can try deploy it into multiple devices in your organization, with the same configuration.

### Host-Client build number

Microsoft, by default, limits the current version of KMS Host to the maximum version you can activate for Windows clients. That means, you cannot (practically) use the host build number of Windows Server 2016 to activate a "client" of Windows Server 2022 or Windows 11 (because build number of Windows Server 2016 is 14393, while Windows Server 2022 has build number of 20348 and Windows 11 has "minimum" build of 22000, except the case of Windows Server 2022 of build 20348 can activate Windows 11 of build 22000).

The same thing also happen on the "client" KMS Host, when use the client build, you may cannot activate the Windows Server (all versions).

That is the reason in the recommendation/default configuration for the daemon, the host build `-H` is always set to the latest version of Windows Server on the database of the Volume License Management Service, because it helps the daemon always replies to all of clients correctly.

However, if you don't use external Volume License Database `.kmd`, the default database and the default host build number are always up-to-date.

You can see the following table to know which version of KMS host can activate which client ([Source from Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/get-started/kms-activation-planning?tabs=server25#activation-versions))

| CSVLK group | CSVLK can <br> be hosted on | Windows editions <br> activated by this KMS host |
|--|--|--|
| Volume License for Windows Server 2025 | <ul><li>Windows Server 2025&sup1;</li><li>Windows Server 2022&sup1;</li><li>Windows Server 2019</li></ul> | <ul><li>Windows Server 2025 (all editions)</li><li>Windows Server 2022 (all editions)</li><li>Windows Server Semi-Annual Channel</li><li>Windows Server 2019 (all editions)</li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 11 Enterprise LTSC 2024</li><li>Windows 11 Enterprise/Enterprise N</li><li>Windows 11 Professional/Professional N</li><li>Windows 11 Professional for Workstations/Professional N for Workstations</li><li>Windows 11 for Education/Education N</li><li>Windows 10 Enterprise LTSC/LTSC N/LTSB</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 for Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |
| Volume License for Windows Server 2022 | <ul><li>Windows Server 2022&sup1;</li><li>Windows Server 2019</li><li>Windows Server 2016</li></ul> | <ul><li>Windows Server 2022 (all editions)</li><li>Windows Server Semi-Annual Channel</li><li>Windows Server 2019 (all editions)</li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 11 Enterprise/Enterprise N</li><li>Windows 11 Professional/Professional N</li><li>Windows 11 Professional for Workstations/Professional N for Workstations</li><li>Windows 11 for Education/Education N</li><li>Windows 10 Enterprise LTSC/LTSC N/LTSB</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 for Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |
| Volume License for Windows Server 2019 | <ul><li>Windows Server 2019</li><li>Windows Server 2016</li><li>Windows Server 2012 R2</li></ul> | <ul><li>Windows Server Semi-Annual Channel</li><li>Windows Server 2019 (all editions)</li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 10 Enterprise LTSC/LTSC N/LTSB</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 for Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |
| Volume License for Windows Server 2016 | <ul><li>Windows Server 2016</li><li>Windows Server 2012 R2</li><li>Windows Server 2012</li></ul> | <ul><li>Windows Server Semi-Annual Channel </li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 10 LTSB (2015 and 2016)</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |
| Volume license for Windows 10 | <ul><li>Windows 10</li><li>Windows 8.1</li><li>Windows 7</li></ul> | <ul><li>Windows 10 Enterprise LTSB/LTSB N (2015)</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Education/Education N</li><li>Windows 10 Pro for Workstations</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |

### KMS deadlines

When activating with the Volume License Management Service, the client has up-to 180 days to reactivate with the KMS host. If the activation failed, it will retry in the interval (by default) of 1440 minutes (a day).

Also, to prevent the client from activating until the deadline (means activate, let it running until the deadline of 180-day meet, then contact for the license), the client will renew the license in the interval of 20160 minutes (14 days, or 2 weeks).

### KMS Host pre-charges

Microsoft limits that the KMS "client" is only be activated if there are 25 clients (in the case of Windows Client/Window Server editions) or 5 clients (in the case of Microsoft Office) contact the server in the last 30-day, and caching them in the most 50 recent contacts.

However, by default of Volume License Management Service, the daemon will automatically "pre-charge" itself up to 24 clients of Windows and 4 clients of Office (leaving 1 remaining for the complete charging).

You can also try `-E1` command to experience this, in some case you need to "trick" to strict client to verify these actual markup, instead of the fake "pre-charge" ones. However, be careful of the error ["0xC004F038: The computer couldn't be activated" error in KMS activation](https://learn.microsoft.com/en-us/troubleshoot/microsoft-365-apps/administration/0xc004f038-computer-not-activate).

### "Strict" client

Some deployments require special strict versions of KMS. For example, your deployment is pretty new and you do not want to install any "pre-release" version of Windows or Office - which may lead into the service disruption, unstable, or crashing. You can try the `-K` flags to do this.

```bash
"0" Activate all products with an unknown, retail or beta/preview KMS IDs
"1" Activate products with a retail or beta/preview KMS ID but refuse to activate products with an unknown KMS ID
"2" Activate products with an unknown KMS ID but refuse products with a retail or beta/preview KMS ID
"3" Activate only products with a known volume license RTM KMS ID and refuse all others
```

### Time checking

By default, time checking is disabled, because the target of designing Volume License Management Service is to activate the client with much less hassle as possible.

However, if you do host a KMS as monolith service, it is recommended to turn that on (using `-c1`) to detect and prevent unauthorized activation. It will check if the time is 4 hours differences.

### Service record (`SRV`) on DNS

If you are hosting Volume License Management Service in the network where Active Directory or self-hosting domain is active, having a `SRV` on the DNS Server may help the client determine which is the best and reliable server to contact with. The `SRV` looks like this

| Property | Value |
|--|--|
| Type | SRV |
| Service/Name | _vlmcs |
| Protocol | _tcp |
| Priority | 0 |
| Weight | 0 |
| Port number | 1688 |
| Hostname | `<FQDN-of-KMS-host>` |

Replace `<FQDN-of-KMS-host>` with your actual KMS Host's FQDN

In non-Microsoft DNS Server, like `bind9` or `dnsmasq`, the DNS configuration may look like this (do not forget to replace the target and `example.com` with your actual deployment, see the [`SRV` record configuration](https://en.wikipedia.org/wiki/SRV_record))

```dns
; _service._proto.name.    TTL   class SRV priority weight port target.
_vlmcs._tcp.example.com.   86400 IN    SRV 0        0      1688 net-srv-01.example.com.
```

## Activation Error Codes

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
