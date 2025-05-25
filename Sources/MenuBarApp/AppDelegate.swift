import Cocoa
import AppKit
import Foundation
import Security
import CoreFoundation

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem?
    private var countdownTimer: Timer?
    private var lockUntilTime: Date?
    private var countdownMenuItems: [NSMenuItem] = []
    private var isCountdownRunning = false

    func applicationDidFinishLaunching(_ notification: Notification) {
        // 配置应用不在Dock中显示
        NSApp.setActivationPolicy(.accessory)
        
        // 注册URL Scheme处理器
        NSAppleEventManager.shared().setEventHandler(
            self,
            andSelector: #selector(handleURLEvent(_:withReplyEvent:)),
            forEventClass: AEEventClass(kInternetEventClass),
            andEventID: AEEventID(kAEGetURL)
        )
        
        // 创建状态栏项目
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "lock.fill", accessibilityDescription: "屏幕锁定计时器")
        }
        
        // 创建菜单
        let menu = NSMenu()
        
        // 倒计时选项
        let countdownOptions = [
            ("1s", 1.0),
            ("5s", 5.0),
            ("1m", 60.0),
            ("2m", 120.0),
            ("5m", 300.0),
            ("30m", 1800.0),
            ("60m", 3600.0)
        ]
        
        // 添加倒计时菜单项
        for (title, duration) in countdownOptions {
            let item = NSMenuItem(title: title, action: #selector(startCountdown(_:)), keyEquivalent: "")
            item.representedObject = duration
            menu.addItem(item)
            countdownMenuItems.append(item)
        }
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem.separator())
         
        statusItem?.menu = menu
        
        // 启动定期检查计时器
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.checkAndLockIfNeeded()
        }
    }
    
    @objc func startCountdown(_ sender: NSMenuItem) {
        // 如果已经有倒计时正在运行，直接返回
        guard !isCountdownRunning else { return }
        
        // 标记倒计时已开始
        isCountdownRunning = true
        
        // 禁用所有倒计时菜单项
        countdownMenuItems.forEach { $0.isEnabled = false }
        
        // 获取选定的持续时间
        guard let duration = sender.representedObject as? TimeInterval else { return }
        
        // 计算锁定结束时间
        lockUntilTime = Date().addingTimeInterval(duration)
        
        // 立即锁定屏幕
        lockScreen()
        
        // 更新状态栏显示
        updateStatusBarTitle()
        
        // 启动定时器更新显示
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateStatusBarTitle()
        }
    }
    
    func checkAndLockIfNeeded() {
        guard let lockTime = lockUntilTime, Date() < lockTime else {
            // 如果倒计时已结束，但标志还未重置，则停止倒计时
            if isCountdownRunning {
                stopCountdown()
            }
            return
        }
        lockScreen()
    }
    
    func updateStatusBarTitle() {
        guard let lockTime = lockUntilTime else {
            resetStatusBar()
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if let button = statusItem?.button {
            if Date() < lockTime {
                button.title = formatter.string(from: lockTime)
            } else {
                resetStatusBar()
            }
        }
    }
    
    @objc func stopCountdown() {
        lockUntilTime = nil
        countdownTimer?.invalidate()
        countdownTimer = nil
        
        // 重置倒计时运行状态
        isCountdownRunning = false
        
        resetStatusBar()
        
        // 重新启用所有倒计时菜单项
        countdownMenuItems.forEach { $0.isEnabled = true }
    }
    
    func resetStatusBar() {
        if let button = statusItem?.button {
            button.title = ""
            button.image = NSImage(systemSymbolName: "lock.fill", accessibilityDescription: "屏幕锁定计时器")
        }
    }
    
    func lockScreen() {
        // 使用最可靠的 pmset 命令锁定屏幕
        DispatchQueue.main.async {
            let task = Process()
            task.launchPath = "/usr/bin/pmset"
            task.arguments = ["displaysleepnow"]
            task.launch()
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        stopCountdown()
    }
    
    // 处理URL Scheme调用
    @objc func handleURLEvent(_ event: NSAppleEventDescriptor, withReplyEvent replyEvent: NSAppleEventDescriptor) {
        guard let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue,
              let url = URL(string: urlString) else {
            return
        }
        
        // 解析URL参数
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems {
            for item in queryItems {
                if item.name == "duration" {
                    if let duration = Double(item.value ?? "") {
                        // 创建临时菜单项来触发倒计时
                        let tempItem = NSMenuItem()
                        tempItem.representedObject = duration
                        startCountdown(tempItem)
                    }
                }
            }
        }
    }
}