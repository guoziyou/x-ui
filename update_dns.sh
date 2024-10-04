#!/bin/bash

# 配置你的 Cloudflare API Token 和域名信息
API_TOKEN="b08d39dd2fdf5cb859411a0e518a12da8ce74"
ZONE_ID="048eee499101d0d41340a7b31cce8835"
RECORD_ID="54f1081dc5484ce23f54e0f7c91b6a48"
DOMAIN="armbian.fa666.us.kg"

# 获取当前 IPv6 地址
IPV6=$(ip -6 addr show | grep "inet6" | grep "global" | awk '{print $2}' | cut -d '/' -f 1)

# 更新 Cloudflare DNS 记录
curl -X PUT "https://api.cloudflare.com/client/v4/zones/048eee499101d0d41340a7b31cce8835/dns_records/54f1081dc5484ce23f54e0f7c91b6a48" \
     -H "Authorization: Bearer b08d39dd2fdf5cb859411a0e518a12da8ce74" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"AAAA\",\"name\":\"armbian.fa666.us.kg\",\"content\":\"240e:33d:978e:a500:33a6:d9da:8a4a:856d\",\"ttl\":120,\"proxied\":false}"
