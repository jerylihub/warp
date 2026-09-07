# 客户端与订阅说明

## Clash / Mihomo

GitHub Raw：

```text
https://raw.githubusercontent.com/USERNAME/REPOSITORY/main/configs/warp-in-warp.txt
```

jsDelivr CDN：

```text
https://cdn.jsdelivr.net/gh/USERNAME/REPOSITORY@main/configs/warp-in-warp.txt
```

## Shadowrocket

本项目主要输出 Mihomo/Clash YAML。

Shadowrocket 支持 WireGuard，但“支持 WireGuard”并不代表支持 Mihomo 的 `dialer-proxy` WARP-in-WARP。

因此不要把本项目的 YAML 宣称为 Shadowrocket 原生 WireGuard 订阅。

如果需要小火箭原生配置，建议后续增加单独的 `.conf`/Shadowrocket 节点生成器。

## Windows

推荐 Mihomo Party。

## Android

推荐支持 Mihomo/Clash Meta + WireGuard + dialer-proxy 的客户端。

## iOS

优先使用支持 Mihomo/Clash Meta 的客户端。

Shadowrocket 更适合作为普通 WireGuard 节点客户端；完整 WARP-in-WARP 是否可用取决于具体版本和配置解析能力。
