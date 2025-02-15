// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MenuBarApp",
    platforms: [
        .macOS(.v12)
    ],
    targets: [
        .executableTarget(
            name: "MenuBarApp",
            sources: ["main.swift", "AppDelegate.swift"]
        )
    ]
)