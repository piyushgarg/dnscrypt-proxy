# DNSCrypt Proxy 2 for Android

A flexible DNS proxy, with support for modern encrypted DNS protocols such as [DNSCrypt v2](https://github.com/DNSCrypt/dnscrypt-protocol/blob/master/DNSCRYPT-V2-PROTOCOL.txt) and [DNS-over-HTTP/2](https://tools.ietf.org/html/draft-ietf-doh-dns-over-https-03).

## Features
- arm, arm64, x86 and x86_64 are supported.
- ipv4 and ipv6 are supported.
- All binary files are downloaded from [https://github.com/jedisct1/dnscrypt-proxy/releases](https://github.com/jedisct1/dnscrypt-proxy/releases)

## Installation
- Download [.zip module](https://github.com/Magisk-Modules-Repo/dnscrypt-proxy-magisk/releases), flash it in Magisk Manager App or in Recovery and follow the instructions.
- There are two option in installation progress. 
### Auto redirect DNS queries using `iptables`
Just flash and forget.
### Set DNS server manually with 3rd-party app (not included in this module)
- DNS server address is 127.0.0.1:53 for ipv4 and [::1]:53 for ipv6
- If you use AfWall, you can write this enter custom script
  ```
  iptables -t nat -A OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:53
  iptables -t nat -A OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:53
  ip6tables -t nat -A OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:53
  ip6tables -t nat -A OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:53
  ```
  and this shutdown script
  ```
  iptables -t nat -D OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:53
  iptables -t nat -D OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:53
  ip6tables -t nat -D OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:53
  ip6tables -t nat -D OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:53
  ```

## Configuration (post-installing)
- Configuration located on `/system/etc/dnscrypt-proxy/dnscrypt-proxy.toml`
- For more detailed configuration please refer to [official documentation](https://github.com/jedisct1/dnscrypt-proxy/wiki/Configuration)

## Changelog
### v2.8.5
 - Fix #40
### v2.8.4
 - Fix failed to copy or backup config file
### v2.8.3
 - Fix permission issue
 - Add option to replace or backup-restore config file
### v2.8.2
 - Fix "binary file is missing"
### v2.8.1
 - Update Magisk 18100 requirements
### v2.8.0
 - Update binary files to 2.0.22
### v2.7.0
 - Update binary files to 2.0.21

[Full changelog](changelog.md)

## Credit
- DNSCrypt-Proxy2 upstream | [jedisct1](https://github.com/jedisct1/dnscrypt-proxy)
- Keycheck binary | [someone755](https://github.com/someone755/kerneller/tree/master/extract/tools)
- Idea for keycheck code implementation | [Zappo @xda-developers](https://forum.xda-developers.com/showpost.php?p=71016567&postcount=98)
- [All contributor](https://github.com/Magisk-Modules-Repo/dnscrypt-proxy/graphs/contributors)
