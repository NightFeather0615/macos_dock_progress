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

      case "changeStyle":
        let styleData = call.arguments as! Dictionary<String, Any>
        
        let styleType = styleData["type"] as! String
        let badgeValue = styleData["badge_value"] as! Int
        let radius = styleData["radius"] as! Double

        let rawColor = styleData["color"] as! [Double]
        let color = NSColor.init(
          red: CGFloat.init(rawColor[0]),
          green: CGFloat.init(rawColor[1]),
          blue: CGFloat.init(rawColor[2]),
          alpha: CGFloat.init(rawColor[3])
        )

        switch styleType {
          case "squircle":
            DockProgress.style = .squircle(color: color)
          case "circle":
            DockProgress.style = .circle(radius: radius, color: color)
          case "badge":
            DockProgress.style = .badge(color: color, badgeValue: { badgeValue })
          default:
            DockProgress.style = .bar
        }
        result(nil)

      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
