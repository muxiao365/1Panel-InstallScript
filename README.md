# 1Panel-InstallScript
## 简介
本项目旨在通过安装1Panel，配置Docker镜像加速（1Panel官方），并配置1Panel三方应用市场，适配Ubuntu或Debian及其对应发行版，为1Panel新用户提供更高效的服务器和部署环境。

## 功能

- 安装1Panel

- 配置Docker镜像加速

- 配置1Panel三方应用市场

- 三方应用市场自动更新

## 安装指南
### 安装指令
- 操作系统：Ubuntu, Debian及其对应发行版
  - **仅适配Ubuntu或Debian及其对应发行版**
- 默认安装在/setsystem/路径下，如果不是请牢记文件位置

```sh
sudo sh -c 'cd / && mkdir -p setsystem && cd setsystem && curl -sSL --insecure https://github.com/muxiao365/1Panel-InstallScript/raw/main/setsystem/panel3git.sh -o panel3git.sh && chmod +x panel3git.sh && ./panel3git.sh'
```

### 注意事项
- **权限问题**：确保你有适当的权限来执行这些操作。如果你不是超级用户（ROOT）权限，请联系系统管理员。
- **网络连接**：确保你的计算机能够访问互联网，以便成功下载脚本。
- **安全性**：使用 `--insecure` 选项会忽略 SSL 证书验证，若选择执行或使用相关代码，则代表你信任下载源（GitHub）并愿意承担对应后果且不进行追责行为。

## 联系方式
### 维护者信息
如果您有任何问题或建议，请联系我们：
- About: https://mxine.link/about
### 社区支持
由于我们暂时没有配置社区支持的计划，您可以在以下链接（社区）找到更多信息和支持：

- [沐潇MXine官网](https://mxine.link)

- [1Panel官网](https://1panel.cn)

- [1Panel Store Unofficial App](https://1p.131.gs)

## Bug反馈
如果您在使用过程中遇到任何问题或发现任何bug，请前往我的[网站](https://mxine.link/links)下评论。我们将尽快处理您的反馈。

---

## 更新日志
### [1.0.0] - 2024-12-22
#### 上传源代码，包含：

- 安装1Panel（ubuntu&Debian）

- 配置镜像加速（1Panel系统源）

- 检测安装crul&jq

- [载入三方应用](https://1p.131.gs "@包子叔")

...**The END**...

---

## 致谢
感谢所有为项目做出贡献的人。特别感谢以下人员：

- [1Panel 应用商店的非官方应用适配库](https://github.com/okxlin/appstore)

- [1Panel团队](https://1panel.cn)

- [破碎工坊云](www.crush.work)

## 联系方式
更多信息请访问我们的网站：[关于我们](https://mxine.link/about)
