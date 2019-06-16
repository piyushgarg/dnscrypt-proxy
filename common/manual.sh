#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}
MODDIR=""
iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT --to-destination 127.0.0.1:53
iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT --to-destination 127.0.0.1:53
iptables -L OUTPUT -t nat
sleep 5
killall -9 dnscrypt-proxy
echo "starting dnscrypt..."
$MODDIR/system/bin/dnscrypt-proxy -config /sdcard/dnscrypt-proxy.toml --logfile /sdcard/dns.log &
killall -9 tail
tail -f /sdcard/dns.log|while read line; do log -t dnscrypt $line; done &
#cat /sdcard/dns.log | while read line; do log -t dnscrypt-proxy $line; done &
echo "iptables..."
sleep 60
iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 127.0.0.1:53
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 127.0.0.1:53
#ip6tables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination [::1]:53
#ip6tables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination [::1]:53
echo "done"
iptables -L OUTPUT -t nat

