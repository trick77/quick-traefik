# quick-traefik

Locating functional Docker Compose service configurations for the [Traefik reverse proxy](https://github.com/traefik/traefik) can be a challenging quest, especially ones that encompass
a fully operational Traefik dashboard, seamless integration with Let's Encrypt, and robust IPv6 support. The ever-evolving landscape
 of Traefik, coupled with configuration variations across different versions, further complicates this pursuit. 
Fear not! Below unfolds a comprehensive example tailored for the latest Traefik version available at the time of this writing.

This Docker Compose service configuration features:

- Forcefully nudging insecure requests towards the safer realms of HTTPS.
- Elevate the Traefik dashboard to its majestic throne, guarded by the impenetrable shield of basic authentication (credentials: traefik/traefik).
- Harness the power of the Let's Encrypt ACME TLS challenge to effortlessly summon certificates for your esteemed domains.
- Witness the eloquent dance of access logs gracefully streaming into the container's stdout.
- Equip your setup with the nimble ability to absorb environment variables from the sacred tome known as the `.env` file.
- Optionally embraces the futuristic realm of IPv6 support, allowing your Docker Compose service configuration to seamlessly communicate over the latest generation of Internet Protocol.

## Usage

1. Edit `.env` to set configuration details
1. Start the containers with `docker compose up -d`
1. Monitor for errors with `docker compose logs -f`
1. Open your FQDNs in the browser and observe Traefik issuing certificates using Let's Encrypt (may take a few seconds!).

Don't forget to remove the Let's Encrypt staging label in `compose.yml` once the configuration is ready!

## Create external network bridge

Create an external network bridge by following these steps:

1. For IPv4-only setups, use the command: `docker network create traefik`
1. If you want Traefik to be reachable over IPv6 too, modify the Docker daemon configuration in /etc/docker/daemon.json (example provided for Debian Bookworm):
``` json
{
  "ipv6": true,
  "ip6tables": true,
  "fixed-cidr-v6": "fd00:1::/64",
  "experimental": true
}
```
1. Restart the Docker daemon after making this configuration change.
1. Once the Docker daemon is restarted, initiate the IPv6-capable network bridge with the command: ```docker network create --ipv6 --subnet=fd00:2::/64 traefik```
