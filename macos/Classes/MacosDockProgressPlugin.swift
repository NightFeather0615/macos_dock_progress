import Cocoa
import FlutterMacOS
import DockProgress

public class MacosDockProgressPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dock_progress", binaryMessenger: registrar.messenger)
    let instance = MacosDockProgressPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "getProgress":
        result(DockProgress.progress)

      case "setProgress":
        var targetProgress = ((call.arguments as? Dictionary<String, Double>)?["value"] ?? 0.0) as Double
        if (0.0 > targetProgress) {
          targetProgress = 0.0
        } else if (targetProgress > 1.0) {
          targetProgress = 1.0
        }
        DockProgress.progress = targetProgress
        result(DockProgress.progress)

      case "resetProgress":
        DockProgress.resetProgress()
        result(nil)

      case "setBadgeValue":
        var targetProgress = ((call.arguments as? Dictionary<String, Int>)?["value"] ?? 0) as Int
        if (0 > targetProgress) {
          targetProgress = 0
        }
        DockProgress.style = .badge(color: NSColor.systemBlue, badgeValue: { targetProgress })
        result(nil)

      case "changeStyle":
        let targetStyle = ((call.arguments as? Dictionary<String, String>)?["style"] ?? "") as String
        switch targetStyle {
          case "squircle":
            DockProgress.style = .squircle(color: NSColor.systemBlue.withAlphaComponent(0.8))
          case "circle":
            DockProgress.style = .circle(radius: 55, color: NSColor.systemBlue)
          default:
            DockProgress.style = .bar
        }
        result(nil)

      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
