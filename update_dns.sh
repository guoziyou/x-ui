#!/bin/bash

# 设置变量
API_TOKEN="j9d5S-BR0VsTGbCP-eBW9ZiX1PTQSLJzkgux0_eQ"              # 替换为你的 Cloudflare API Token
ZONE_ID="048eee499101d0d41340a7b31cce8835"                  # 替换为你的 Cloudflare 区域 ID
RECORD_NAME="armbian.fa666.us.kg"  # 替换为你要更新的子域名
CLOUDFLARE_API="https://api.cloudflare.com/client/v4"

# 获取当前 IPv6 地址
CURRENT_IPV6=$(ip -6 addr show | grep 'inet6' | grep -v '::1' | awk '{print $2}' | cut -d'/' -f1 | head -n 1)

if [ -z "$CURRENT_IPV6" ]; then
    echo "未能获取 IPv6 地址。"
    exit 1
fi

echo "当前 IPv6 地址：$CURRENT_IPV6"

# 更新 Cloudflare DNS 记录
RESPONSE=$(curl -s -X PUT "$CLOUDFLARE_API/zones/$ZONE_ID/dns_records/YOUR_RECORD_ID" \
-H "Authorization: Bearer $API_TOKEN" \
-H "Content-Type: application/json" \
--data "{\"type\":\"AAAA\",\"name\":\"$RECORD_NAME\",\"content\":\"$CURRENT_IPV6\",\"ttl\":1,\"proxied\":false}")

# 检查更新结果
if echo "$RESPONSE" | grep -q '"success": true'; then
    echo "成功更新 DNS 记录！"
else
    echo "更新 DNS 记录失败："
    echo "$RESPONSE" | jq '.errors'  # 使用 jq 查看错误
    exit 1
fi
