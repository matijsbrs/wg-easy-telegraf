# WireGuard Easy Telegraf integration

I've been working with WeeJeWel's wg-easy Image for quite some time now and I think it is realy Great!

But I needed a way to monitor the data usage and data transfer rates. This is why I opted to include Influx Telegraf in the image.

# WireGuard Easy

[![Build & Publish Docker Image to Docker Hub](https://github.com/WeeJeWel/wg-easy/actions/workflows/deploy.yml/badge.svg?branch=production)](https://github.com/WeeJeWel/wg-easy/actions/workflows/deploy.yml)
[![Lint](https://github.com/WeeJeWel/wg-easy/actions/workflows/lint.yml/badge.svg?branch=master)](https://github.com/WeeJeWel/wg-easy/actions/workflows/lint.yml)
[![Docker](https://img.shields.io/docker/v/weejewel/wg-easy/latest)](https://hub.docker.com/r/weejewel/wg-easy)
[![Docker](https://img.shields.io/docker/pulls/weejewel/wg-easy.svg)](https://hub.docker.com/r/weejewel/wg-easy)
[![Sponsor](https://img.shields.io/github/sponsors/weejewel)](https://github.com/sponsors/WeeJeWel)
![GitHub Stars](https://img.shields.io/github/stars/weejewel/wg-easy)

You have found the easiest way to install & manage WireGuard on any Linux host!

<p align="center">
  <img src="./assets/screenshot.png" width="802" />
</p>

## Features

* All-in-one: WireGuard + Web UI + Telegraf.
* Easy installation, simple to use.
* List, create, edit, delete, enable & disable clients.
* Show a client's QR code.
* Download a client's configuration file.
* Statistics for which clients are connected.
* Tx/Rx charts for each connected client.
* Gravatar support.
* Influx Telegraf integration

## Requirements

* A host with a kernel that supports WireGuard (all modern kernels).
* A host with Docker installed.

## Installation

### 1. Install Docker

If you haven't installed Docker yet, install it by running:

```bash
$ curl -sSL https://get.docker.com | sh
$ sudo usermod -aG docker $(whoami)
$ exit
```

And log in again.

### 2. Build container

1. Download the zip file from Github using the following link:
   [https://github.com/matijsbrs/wg-easy-telegraf/archive/refs/tags/v1.0.0.zip](https://github.com/matijsbrs/wg-easy-telegraf/archive/refs/tags/v1.0.0.zip)

2. Once the file is downloaded, unzip it to extract its contents. You can use a file extraction tool like WinRAR, 7-Zip, or the built-in zip utility on your operating system.

3. Open the extracted folder/directory. You can do this by navigating to the location where you extracted the zip file and double-clicking on the folder.

4. To build a Docker image, open a terminal or command prompt and navigate to the directory where you extracted the files.

5. In the terminal, use the following command to build the Docker image with the tag `wg-easy-telegraf`:

   ```shell
   docker build -t wg-easy-telegraf .
   ```

   This command uses the `docker build` command to build a Docker image from the current directory (`.`) and assigns the tag `wg-easy-telegraf` to the image.

6. Wait for the Docker build process to complete. It may take some time depending on the size of the project and the resources available on your machine.

7. Once the build is complete, you can push the Docker image to your local Docker registry. To do this, use the following command:

   ```shell
   docker push wg-easy-telegraf
   ```

   This command pushes the Docker image with the tag `wg-easy-telegraf` to your local Docker registry.

By following these steps, you should be able to download, unzip, build, and push the `wg-easy-telegraf` project to your local Docker registry.

### 3. Run WireGuard Easy

To automatically install & run wg-easy, simply run:

<pre>
$ docker run -d \
  --name=wg-easy-telegraf \
  -e WG_HOST=<b>🚨YOUR_SERVER_IP</b> \
  -e PASSWORD=<b>🚨YOUR_ADMIN_PASSWORD</b> \
  -e INFLUXDB_V2_HOSTNAME=<b>🚨YOUR_INFLUXDB_V2_Host</b> \
  -e INFLUXDB_V2_URL=<b>🚨YOUR_INFLUXDB_V2_URL</b> \
  -e INFLUXDB_V2_TOKEN=<b>🚨YOUR_INFLUXDB_V2_TOKEN</b> \
  -e INFLUXDB_V2_ORG=<b>🚨YOUR_INFLUXDB_V2_ORGANIZATION</b> \
  -e INFLUXDB_V2_BUCKET=<b>🚨YOUR_INFLUXDB_V2_BUCKET</b> \
  -v ~/.wireguard:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped \
  weejewel/wg-easy
</pre>

> 💡 Replace `YOUR_SERVER_IP` with your WAN IP, or a Dynamic DNS hostname.
>
> 💡 Replace `YOUR_ADMIN_PASSWORD` with a password to log in on the Web UI.
>
> 💡 Replace `YOUR_INFLUXDB_V2_HOST` The hostname telegraf should decorate the data.
>
> 💡 Replace `YOUR_INFLUXDB_V2_URL` the URL to your InfluxDB v2.
>
> 💡 Replace `YOUR_INFLUXDB_V2_TOKEN` The token Telegraf should use.
>
> 💡 Replace `YOUR_INFLUXDB_V2_ORGANIZATION` your Organization name
>
> 💡 Replace `YOUR_INFLUXDB_V2_BUCKET` The name of the bucket to store the data.

The Web UI will now be available on `http://0.0.0.0:51821`.

> 💡 Your configuration files will be saved in `~/.wireguard`

### 4. Sponsor

Are you enjoying this project? Don't get me a beer, but buy 'WeeJeWel' one using his sponsor link --> [Buy me a beer!](https://github.com/sponsors/WeeJeWel) 🍻

## Options

These options can be configured by setting environment variables using `-e KEY="VALUE"` in the `docker run` command.

| Env | Default | Example | Description |
| - | - | - | - |
| `PASSWORD` | - | `foobar123` | When set, requires a password when logging in to the Web UI. |
| `WG_HOST` | - | `vpn.myserver.com` | The public hostname of your VPN server. |
| `WG_DEVICE` | `eth0` | `ens6f0` | Ethernet device the wireguard traffic should be forwarded through. |
| `WG_PORT` | `51820` | `12345` | The public UDP port of your VPN server. WireGuard will always listen on `51820` inside the Docker container. |
| `WG_MTU` | `null` | `1420` | The MTU the clients will use. Server uses default WG MTU. |
| `WG_PERSISTENT_KEEPALIVE` | `0` | `25` | Value in seconds to keep the "connection" open. If this value is 0, then connections won't be kept alive. |
| `WG_DEFAULT_ADDRESS` | `10.8.0.x` | `10.6.0.x` | Clients IP address range. |
| `WG_DEFAULT_DNS` | `1.1.1.1` | `8.8.8.8, 8.8.4.4` | DNS server clients will use. |
| `WG_ALLOWED_IPS` | `0.0.0.0/0, ::/0` | `192.168.15.0/24, 10.0.1.0/24` | Allowed IPs clients will use. |
| `WG_PRE_UP` | `...` | - | See [config.js](https://github.com/WeeJeWel/wg-easy/blob/master/src/config.js#L19) for the default value. |
| `WG_POST_UP` | `...` | `iptables ...` | See [config.js](https://github.com/WeeJeWel/wg-easy/blob/master/src/config.js#L20) for the default value. |
| `WG_PRE_DOWN` | `...` | - | See [config.js](https://github.com/WeeJeWel/wg-easy/blob/master/src/config.js#L27) for the default value. |
| `WG_POST_DOWN` | `...` | `iptables ...` | See [config.js](https://github.com/WeeJeWel/wg-easy/blob/master/src/config.js#L28) for the default value. |

> If you change `WG_PORT`, make sure to also change the exposed port.
