# MacOS 屏幕锁定计时器

一个简单的 macOS 菜单栏应用程序，可以快速设置屏幕锁定倒计时。

## 功能特点
- 支持 1 秒到 60 分钟的屏幕锁定计时
- 支持 URL Scheme 外部程序调用
- 简洁的菜单栏界面
- 支持命令行、AppleScript 和 URL Scheme 调用

## 安装方法
1. 从[发布页面](https://github.com/guomengtao/macOS-keep-lock-app/releases/latest)下载最新版本
2. 双击 DMG 文件
3. 将应用拖到应用程序文件夹

## 使用方法
### 菜单栏
- 点击菜单栏中的锁图标
- 选择倒计时时长
- 屏幕将在选定时间后锁定

### URL Scheme 调用
URL Scheme 支持任意秒数的时长设置，不限于菜单中的选项。这意味着你可以设置菜单中没有的自定义时长。

```bash
# 示例：
open "macoslock://lock?duration=60"    # 锁定 1 分钟
open "macoslock://lock?duration=300"   # 锁定 5 分钟
open "macoslock://lock?duration=600"   # 锁定 10 分钟
open "macoslock://lock?duration=1800"  # 锁定 30 分钟
open "macoslock://lock?duration=3600"  # 锁定 1 小时
```

#### 重要说明：
1. duration 参数单位为秒
2. 可以设置任意时长，不限于菜单选项
3. 使用 URL Scheme 时应用必须处于运行状态
4. duration 参数与菜单选项完全独立
5. 没有最大时间限制（请谨慎使用）

### AppleScript 调用
```applescript
tell application "MacOSLock"
    open location "macoslock://lock?duration=300"
end tell
```

## 开发环境
- Swift 5.5+
- macOS 10.15+
- Xcode 12+

## 项目结构
```
macOS-keep-lock-app/
├── Sources/
│   └── MenuBarApp/
│       ├── AppDelegate.swift    # 主要应用逻辑
│       └── main.swift          # 应用入口
├── MenuBarApp.app/             # 编译后的应用
├── MacOSLock.dmg              # 发布包
└── README.md                  # 说明文件
```

## 作者
- GitHub: [guomengtao](https://github.com/guomengtao)

## 许可证
本项目采用 MIT 许可证 - 详见 [LICENSE.md](LICENSE.md) 文件 