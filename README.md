# 1Panel-InstallScript
## 简介
本项目旨在通过安装1Panel，配置Docker镜像加速（1Panel官方），并配置1Panel三方应用市场，适配Ubuntu或Debian及其对应发行版，为1Panel新用户提供更高效的服务器和部署环境

## 功能

- 检测必要组件并自动安装缺失组件
  - "jq"
  - "curl"
  - "git"
  - "wget"
  - "sed"
  - "awk"
  - "grep"
  - "nodejs"
  - "npm"
  - "python3-dev"
  - "python3-pip"
- 安装1Panel
- 自动配置Docker镜像加速(1Panel源)
- 配置1Panel三方应用市场
- 三方应用市场自动更新
- 适配Ubuntu&Debian（cost.log）
- 适配Centos&RedHat（cost.log）
- 模块架构设计

## 安装指南
### 安装指令
- 操作系统：Ubuntu或Debian及其对应发行版&CentOS或RedHat及其对应发行版
- 默认安装在/setsystem/路径下，如果不是请牢记文件位置

> 拉取程序
```sh
sudo sh -c 'cd / && mkdir -p setsystem && cd setsystem && curl -sSL --insecure https://github.com/muxiao365/1Panel-InstallScript/raw/main/setsystem/panel3git.sh -o panel3git.sh && chmod +x panel3git.sh'
```
> 运行程序
```sh
. /setsystem/panel3git.sh
```

### 高级操作
#### 创建新的计划任务
- 在计划任务页面，点击“添加任务”按钮
- 在弹出的对话框中，填写以下信息：
  - 任务名称：随意取名
  - 任务类型：选择“Shell脚本”
  - 任务命令：输入以下命令：
        
  ```sh
  . /setsystem/panel3git.sh
  ```
  > 若文件位置您已修改，请将/setsystem替换为实际存放/panel3git.sh脚本的路径。如果1Panel默认安装在/opt路径下，则无需修改；如果不是，请确保修改为正确的安装路径
  - 执行周期：根据需要选择合适的执行周期，例如每天、每周等（建议设置凌晨）（每晚自动重启）
  - 其他设置：根据需要进行其他设置，如启用或禁用通知等
#### 日志
- 当程序遇到异常情况时，会自动将错误信息写入日志文件（install_script.log）
  - 这些日志文件可以帮助你诊断和解决问题。默认情况下，日志文件会保存在以下路径：

```
/setsystem/log/install_script.log
```

**查看日志文件**可以使用以下命令：

```sh
cat /setsystem/log/install_script.log
```

或使用文本编辑器打开：

```sh
nano /setsystem/log/install_script.log
```

### 注意事项
- **空间问题**：确保有足够的磁盘空间来存储日志文件，因为日志可能会随着时间增长而变得很大。
- **权限问题**：确保你有适当的权限来执行这些操作。如果你不是超级用户（ROOT）权限，请联系系统管理员。
- **网络连接**：确保你的计算机能够访问互联网，以便成功下载脚本。
- **安全隐患**：使用 `--insecure` 选项会忽略 SSL 证书验证
  - 若选择执行或使用相关代码，则代表你信任下载源（GitHub）并愿意承担对应后果且不进行追责行为。

## 联系方式
### 维护者信息
如果您有任何问题或建议，请联系我们：
- About: https://mxine.link
### 社区支持
由于我们暂时没有配置社区支持的计划，您可以在以下链接（社区）找到更多信息和支持：

- [沐潇MXine官网](https://mxine.link)
- [1Panel官网](https://1panel.cn)
- [1Panel Store Unofficial App](https://1p.131.gs)

## 致谢
感谢所有为项目做出贡献的人。特别感谢以下人员：

- [1Panel 应用商店的非官方应用适配库](https://github.com/okxlin/appstore)
- [1Panel团队](https://1panel.cn)
- [破碎工坊云](www.crush.work)

## Bug反馈
- 如果您在使用过程中遇到任何问题或发现任何bug
  - 请前往我的[网站](https://mxine.link/links)下评论。我们将尽快处理您的反馈。

---

## 更新日志
### [1.0.00] - 2024-12-22
#### 上传源代码，包含：
- 检测必要组件并自动安装缺失组件
  - "jq"
  - "curl"
  - "git"
  - "wget"
  - "sed"
  - "awk"
  - "grep"
- 安装1Panel
- 配置Docker镜像加速
- 配置1Panel三方应用市场
- 三方应用市场自动更新

### [2.0.00] - 2024-12-22
#### 修改整体框架
- 安装1Panel（centos&redhat版）
- 配置Docker镜像加速（增加备份）
- 配置1Panel三方应用市场（日志更全面）
- 增加系统判断机制
- 增加cost.log缓存

### [2.2.34] - 2024-12-22
#### 修复mo[one]ok逻辑问题
- 修复部分已知问题
- 优化部分逻辑问题

### [2.4.00] - 2024-12-22
#### 修复fastdocker逻辑问题
- 修复部分已知问题
- 优化部分逻辑问题

### [2.5.62] - 2024-12-23
#### 修复脚本中的语法错误和逻辑错误
- 修复部分Yum已知问题
- 优化部分逻辑问题

### [2.8.00] - 2024-12-28
#### 修复脚本中的语法错误&增加适配
- 修复部分Apt&Yum已知问题
- 优化部分逻辑问题
- 增加组件支持
  - "nodejs"
  - "npm"
  - "python3-dev"
  - "python3-pip"
  - "tldr"
  - "thefuck"
 
### [2.8.50] - 2024-12-28
#### 修复组件兼容性
- 修复部分Apt&Yum已知问题
- 优化部分逻辑问题
- 取消组件支持（兼容问题）
  - "tldr"
  - "thefuck"

### [2.9.12] - 2024-12-28
#### 功能优化
- 部署基于/imsyy/home的个人主页站
- 程序运行结束自动重启

### [2.9.50] - 2024-12-28
#### 优化部分组件逻辑
- 取消适配/imsyy/home的个人主页站
  - 对新手不友好，经过深思熟虑后的结果
- 优化自动重启逻辑，适配计划任务
# ...**The END**...

---
