[![pub](https://img.shields.io/pub/v/macos_dock_progress.svg)](https://pub.dev/packages/macos_dock_progress)
[![documentation](https://img.shields.io/badge/Documentation-macos_dock_progress-blue.svg)](https://pub.dev/documentation/macos_dock_progress/latest/)

An API wrapper of [DockProgress](https://github.com/sindresorhus/DockProgress) for Flutter, make you able to interacting with macOS dock icon progress bars in Flutter.

## Usage
See [example](https://github.com/NightFeather0615/macos_dock_progress/tree/main/example).

## Command SwiftCompile failed
If you are experiencing Swift compile failed issues, please follow the instructions below.

### Config macOS deployment target (`MACOSX_DEPLOYMENT_TARGET`) for Pod
```ruby
# macos/Podfile

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_macos_build_settings(target)

    # Add lines below
    target.build_configurations.each do |config|
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.14' # >=10.13
    end
  end
end
```

### Disable Swift compiler optimization
1. Open `macos/Runner.xcodeproj` in Xcode
2. Navigate to `Runner` > Build Settings > Swift Compiler - Code Generation
3. Set Optimization Level to `No Optimization [-Onone]`
