# MacOS 屏幕锁定计时器

一个简单的 macOS 菜单栏应用程序，可以快速设置屏幕锁定倒计时。

## 功能特点
- 支持 1 秒到 60 分钟的屏幕锁定计时
- 支持 URL Scheme 外部程序调用
- 简洁的菜单栏界面
- 支持命令行、AppleScript 和 URL Scheme 调用

## 安装方法
1. 从发布页面下载最新版本
2. 双击 DMG 文件
3. 将应用拖到应用程序文件夹

## 使用方法
### 菜单栏
- 点击菜单栏中的锁图标
- 选择倒计时时长
- 屏幕将在选定时间后锁定

### URL Scheme 调用
```bash
open "macoslock://lock?duration=300"  # 锁定 5 分钟
```

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