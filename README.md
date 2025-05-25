# MacOS Screen Lock Timer

A macOS menu bar application that allows you to set screen lock countdowns quickly.

## Features
- Set screen lock timers from 1 second to 60 minutes
- URL Scheme support for external program calls
- Minimalist menu bar interface
- Support for command line, AppleScript, and URL Scheme calls

## Installation
1. Download the latest release from [Releases](https://github.com/guomengtao/macOS-keep-lock-app/releases/latest)
2. Double click the DMG file
3. Drag the app to your Applications folder

## Usage
### Menu Bar
- Click the lock icon in the menu bar
- Select a countdown duration
- The screen will lock after the selected time

### URL Scheme
The URL Scheme supports any duration in seconds, not limited to the menu options.

```bash
# Examples:
open "macoslock://lock?duration=60"    # Lock for 1 minute
open "macoslock://lock?duration=300"   # Lock for 5 minutes
open "macoslock://lock?duration=600"   # Lock for 10 minutes
open "macoslock://lock?duration=1800"  # Lock for 30 minutes
open "macoslock://lock?duration=3600"  # Lock for 1 hour
```

Note: The URL Scheme duration parameter is independent of the menu options. You can set any duration in seconds, even if it's not available in the menu.

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