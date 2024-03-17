import 'macos_dock_progress_platform_interface.dart';

enum ProgressBarStyle {
  bar,
  squircle,
  circle;

  @override
  String toString() {
    switch (this) {
      case ProgressBarStyle.bar: {
        return "bar";
      }
      case ProgressBarStyle.squircle: {
        return "squircle";
      }
      case ProgressBarStyle.circle: {
        return "circle";
      }
    }
  }
}

/// API wrapper of DockProgress.
class DockProgress {
  DockProgress._();

  /// Gets the current value of the progress bar.
  static Future<double?> getProgress() async {
    return await DockProgressPlatform.instance.getProgress();
  }

  /// Sets the current value of the progress bar.
  static Future<double?> setProgress(double value) async {
    return await DockProgressPlatform.instance.setProgress(value);
  }

  /// Resets the current value of the progress bar.
  static Future<void> resetProgress() async {
    return await DockProgressPlatform.instance.resetProgress();
  }

  /// Sets the value of the badge indicator, this method will change the style to badge.
  static Future<void> setBadgeValue(int value) async {
    return await DockProgressPlatform.instance.setBadgeValue(value);
  }

  /// Change the style of the progress bar.
  static Future<void> changeStyle(ProgressBarStyle style) async {
    return await DockProgressPlatform.instance.changeStyle(style);
  }
}
