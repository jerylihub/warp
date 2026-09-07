# WARP-in-WARP GitHub Action

> 自动生成 Cloudflare WARP-in-WARP（外层 WARP + 内层 WARP）Mihomo/Clash YAML 配置，并提供 GitHub Raw 与 jsDelivr CDN 订阅地址。

## 一、项目用途

本项目基于开源项目 **WARPSCOUT** 已实现的 WARP-in-WARP / `dialer-proxy` 思路进行 GitHub Actions 自动化封装。

工作链路：

```text
Clash / Mihomo / Shadowrocket
             ↓
        Inner WARP
             ↓
        dialer-proxy
             ↓
        Outer WARP
             ↓
        Cloudflare
             ↓
          Internet
```

外层 WARP 用于选择/承载目标区域的 Cloudflare Endpoint，内层 WARP 通过 `dialer-proxy` 经过外层 WARP。

> **重要：** 当前版本采用上游已经实现的 `WG/AWG → WG/AWG` WARP-in-WARP 方式，不把 MASQUE → WARP 套娃冒充成已经验证的功能。MASQUE 在 WARPSCOUT 中可作为扫描协议，但当前 `-through` 嵌套机制并非任意 MASQUE 组合。

---

# 二、生成文件

GitHub Actions 成功后会生成：

```text
configs/
├── warp-in-warp.yaml
├── warp-in-warp.txt
└── README.txt
```

其中：

- `warp-in-warp.yaml`：完整 Mihomo/Clash YAML。
- `warp-in-warp.txt`：同一份 YAML，专门用于订阅地址。
- `README.txt`：自动生成当前仓库对应的订阅地址。

同时 Action 会上传 Artifact。

---

# 三、Clash / Mihomo 订阅链接

假设你的 GitHub 仓库是：

```text
https://github.com/你的用户名/你的仓库
```

## 1. GitHub Raw 原生订阅

```text
https://raw.githubusercontent.com/你的用户名/你的仓库/main/configs/warp-in-warp.txt
```

这是 GitHub 原生 Raw 地址。

## 2. jsDelivr CDN 订阅

```text
https://cdn.jsdelivr.net/gh/你的用户名/你的仓库@main/configs/warp-in-warp.txt
```

这是 CDN 地址。

### 推荐

- 需要最新文件：GitHub Raw
- 更希望通过 CDN：jsDelivr
- jsDelivr 有缓存，刚更新后可能不会立即同步。

---

# 四、Shadowrocket（小火箭）订阅

Shadowrocket 支持 WireGuard 配置。

本项目生成的内层 WARP + 外层 WARP 是 Mihomo 的 WireGuard 链路，并不是普通的单个 `.conf` 文件。

因此：

### Shadowrocket 直接订阅

不要把 Mihomo YAML 当成 Shadowrocket 原生 WireGuard `.conf` 订阅格式。

如果你的 Shadowrocket 版本能够解析相应的 WireGuard/Mihomo 订阅格式，可以尝试使用：

```text
https://raw.githubusercontent.com/你的用户名/你的仓库/main/configs/warp-in-warp.txt
```

或者：

```text
https://cdn.jsdelivr.net/gh/你的用户名/你的仓库@main/configs/warp-in-warp.txt
```

**但是本项目不宣称 Shadowrocket 原生支持完整 Mihomo `dialer-proxy` 套娃链。**

原因是：

```text
Mihomo:
Inner WireGuard
    ↓
dialer-proxy
    ↓
Outer WireGuard
```

和 Shadowrocket 的原生 WireGuard 配置模型并不是同一个配置模型。

因此：

> **Clash/Mihomo 是本项目的主要目标客户端；Shadowrocket 需要客户端本身支持对应的嵌套代理链。**

如果后续需要，我建议单独增加一个 Shadowrocket/WireGuard 转换器，而不是错误地把 Clash YAML 直接称为“小火箭原生订阅”。

---

# 五、客户端推荐

## Windows

### 推荐：Mihomo Party

适合：

- Mihomo/Clash YAML
- `dialer-proxy`
- WireGuard
- 规则组
- url-test

也可以使用其他支持 Mihomo/Clash Meta 配置的客户端。

---

## Android

### 推荐：Mihomo Party Android / Clash Meta 系客户端

优先选择明确支持：

- Mihomo
- WireGuard
- `dialer-proxy`

的客户端。

如果你的客户端只支持传统 Clash 配置，不保证 WARP-in-WARP 链能够正常工作。

---

## iOS

### 推荐：Shadowrocket（小火箭）用于普通 WireGuard 节点

但要特别注意：

> **本项目生成的是 Mihomo WARP-in-WARP 配置，核心依赖 `dialer-proxy`。Shadowrocket 并不等于完整支持 Mihomo 的 `dialer-proxy` WARP-in-WARP 链。**

所以：

- iOS + Mihomo/Clash Meta 支持的客户端：优先
- Shadowrocket：适合本项目未来输出单独 WireGuard 节点/转换配置

不要把“支持 WireGuard”直接等同于“支持 Mihomo 的 WireGuard + dialer-proxy 套娃”。

---

# 六、Windows / Android / iOS 快速选择

| 平台 | 推荐客户端 | 本项目完整 WARP-in-WARP |
|---|---|---|
| Windows | Mihomo Party | ✅ 推荐 |
| Android | Mihomo/Clash Meta 系客户端 | ✅ 推荐 |
| iOS | Mihomo/Clash Meta 系客户端 | ✅ 优先 |
| iOS | Shadowrocket | ⚠️ 不保证完整 `dialer-proxy` 套娃 |

---

# 七、GitHub Actions 使用方法

进入：

```text
GitHub
→ Actions
→ Build WARP-in-WARP subscription
→ Run workflow
```

默认参数：

```text
country: US
outer_proto: awg
inner_proto: wg
tun_ping: true
```

例如美国：

```text
US
```

日本：

```text
JP
```

新加坡：

```text
SG
```

德国：

```text
DE
```

然后点击：

```text
Run workflow
```

Action 自动：

```text
注册 WARP
    ↓
筛选外层 Endpoint
    ↓
通过 Outer WARP 扫描 Inner WARP
    ↓
生成 WARP-in-WARP
    ↓
生成 Mihomo YAML
    ↓
提交 configs/
    ↓
上传 Artifact
```

---

# 八、如何取得你自己的订阅链接

Action 第一次成功运行后，进入：

```text
你的 GitHub 仓库
→ configs
→ warp-in-warp.txt
```

复制仓库地址中的：

```text
用户名
仓库名
```

然后把下面模板中的内容替换掉：

## Clash / Mihomo — GitHub Raw

```text
https://raw.githubusercontent.com/USERNAME/REPOSITORY/main/configs/warp-in-warp.txt
```

## Clash / Mihomo — jsDelivr CDN

```text
https://cdn.jsdelivr.net/gh/USERNAME/REPOSITORY@main/configs/warp-in-warp.txt
```

---

# 九、项目引用与致谢

本项目不是从零重新实现 WARP-in-WARP 协议。

特别感谢以下开源项目作者及贡献者：

## 1. WARPSCOUT

项目：

https://github.com/vernette/warpscout

感谢 **vernette** 及 WARPSCOUT Contributors。

本项目重点参考/复用其：

- WARP Endpoint 扫描
- WARP-in-WARP
- `-through`
- `dialer-proxy`
- Mihomo 配置生成
- WireGuard / AmneziaWG WARP 链路

WARPSCOUT 是本项目实现 WARP-in-WARP 自动化的核心参考来源。

## 2. warp-masque-actions

项目：

https://github.com/byJoey/warp-masque-actions

感谢 **byJoey** 及项目贡献者。

本项目参考其：

- GitHub Actions 自动化形式
- WARP 自动注册/生成流程
- Mihomo/Clash 配置自动生成思路
- GitHub Artifact 输出方式

## 3. Cloudflare

感谢 Cloudflare 提供 WARP、WireGuard、MASQUE 及其全球网络基础设施。

本项目不代表 Cloudflare 官方，也不是 Cloudflare 官方项目。

---

# 十、上游项目

WARPSCOUT：

https://github.com/vernette/warpscout

warp-masque-actions：

https://github.com/byJoey/warp-masque-actions

Cloudflare WARP：

https://developers.cloudflare.com/warp-client/

Mihomo：

https://github.com/MetaCubeX/mihomo

---

# 十一、项目热度 / Star History

本项目建议使用 GitHub 原生的 Star History 图表。

将：

```text
OWNER/REPOSITORY
```

替换成你自己的 GitHub 用户名和仓库名。

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=OWNER/REPOSITORY&type=Date)](https://star-history.com/#OWNER/REPOSITORY&Date)

Markdown：

```markdown
[![Star History Chart](https://api.star-history.com/svg?repos=OWNER/REPOSITORY&type=Date)](https://star-history.com/#OWNER/REPOSITORY&Date)
```

### 如何使用

例如你的仓库：

```text
github.com/xiaolei/warp-in-warp
```

修改成：

```markdown
[![Star History Chart](https://api.star-history.com/svg?repos=xiaolei/warp-in-warp&type=Date)](https://star-history.com/#xiaolei/warp-in-warp&Date)
```

这样 GitHub README 会显示项目 Star 随时间变化的曲线。

> Star History 是第三方可视化服务，不是 GitHub 原生生成的图片；数据来自公开 GitHub Star 历史。GitHub 本身不会在 README 中自动提供完整 Star 历史曲线图片。

---

# 十二、项目免责声明

本项目仅用于学习、研究网络协议、GitHub Actions 自动化以及 Mihomo 配置生成。

使用者需要自行遵守：

- GitHub 服务条款
- Cloudflare 服务条款
- WARP/相关服务的使用规则
- 所在国家或地区法律法规
- 目标网站服务条款

本项目作者不保证：

- 某个国家 GeoIP 永久准确
- 所有 AI 网站均可访问
- 所有客户端均支持 WARP-in-WARP
- Cloudflare Endpoint 永久有效
- 第三方 IP 数据库显示结果完全一致

如果 Cloudflare 或上游项目改变接口，Action 可能需要同步更新。

---

# 十三、贡献

欢迎提交 Issue / Pull Request：

```text
Bug 修复
性能优化
更多国家
更多协议
更好的节点测速
Shadowrocket/WireGuard 输出
Cloudflare Worker 订阅
```

---

## License / Attribution

请同时遵守本项目所引用上游项目的许可证。

本仓库中的自动化脚本属于本项目；上游项目的代码、设计和许可证仍归其原作者及贡献者所有。
