import 'package:flutter/cupertino.dart';

import 'macos_dock_progress_platform_interface.dart';

class ProgressBarStyle {
  ProgressBarStyle._(this._type,
      {this.color = CupertinoColors.systemBlue,
      this.badgeValue = 0,
      this.circleRadius = 55});

  final Color color;
  final _ProgressBarType _type;
  final int badgeValue;
  final double circleRadius;

  factory ProgressBarStyle.bar() => ProgressBarStyle._(_ProgressBarType.bar);
  factory ProgressBarStyle.squircle(
          {Color color = CupertinoColors.systemBlue}) =>
      ProgressBarStyle._(_ProgressBarType.squircle, color: color);
  factory ProgressBarStyle.circle(
          {double radius = 55, Color color = CupertinoColors.systemBlue}) =>
      ProgressBarStyle._(_ProgressBarType.circle,
          color: color, circleRadius: radius);
  factory ProgressBarStyle.badge(int badgeValue,
          {Color color = CupertinoColors.systemBlue}) =>
      ProgressBarStyle._(_ProgressBarType.badge,
          color: color, badgeValue: badgeValue);

  Map<String, Object> toMap() {
    return {
      "type": _type.toString(),
      "badge_value": badgeValue,
      "radius": circleRadius,
      "color": [
        color.red / 255,
        color.green / 255,
        color.blue / 255,
        color.alpha / 255
      ]
    };
  }
}

enum _ProgressBarType {
  bar,
  squircle,
  circle,
  badge;

  @override
  String toString() {
    switch (this) {
      case _ProgressBarType.bar:
        {
          return "bar";
        }
      case _ProgressBarType.squircle:
        {
          return "squircle";
        }
      case _ProgressBarType.circle:
        {
          return "circle";
        }
      case _ProgressBarType.badge:
        {
          return "badge";
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

  /// Change the style of the progress bar.
  static Future<void> changeStyle(ProgressBarStyle style) async {
    return await DockProgressPlatform.instance.changeStyle(style);
  }
}
