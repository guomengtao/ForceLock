# MacOS Screen Lock Timer

A macOS menu bar application that allows you to set screen lock countdowns quickly.

## Features
- Set screen lock timers from 1 second to 60 minutes
- URL Scheme support for external program calls
- Minimalist menu bar interface
- Support for command line, AppleScript, and URL Scheme calls

## Installation
1. Download the latest release from the releases page
2. Double click the DMG file
3. Drag the app to your Applications folder

## Usage
### Menu Bar
- Click the lock icon in the menu bar
- Select a countdown duration
- The screen will lock after the selected time

### URL Scheme
```bash
open "macoslock://lock?duration=300"  # Lock for 5 minutes
```

### AppleScript
```applescript
tell application "MacOSLock"
    open location "macoslock://lock?duration=300"
end tell
```

## Development
- Swift 5.5+
- macOS 10.15+
- Xcode 12+

## Project Structure
```
macOS-keep-lock-app/
├── Sources/
│   └── MenuBarApp/
│       ├── AppDelegate.swift    # Main application logic
│       └── main.swift          # Application entry point
├── MenuBarApp.app/             # Compiled application
├── MacOSLock.dmg              # Distribution package
└── README.md                  # This file
```

## Author
- GitHub: [guomengtao](https://github.com/guomengtao)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.