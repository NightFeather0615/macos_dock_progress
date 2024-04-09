import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:macos_dock_progress/macos_dock_progress.dart';

import 'macos_dock_progress_platform_interface.dart';

/// An implementation of [DockProgressPlatform] that uses method channels.
class MethodChannelDockProgress extends DockProgressPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dock_progress');

  @override
  Future<double?> getProgress() async {
    return await methodChannel.invokeMethod<double>('getProgress');
  }

  @override
  Future<double?> setProgress(double value) async {
    return await methodChannel
        .invokeMethod<double>('setProgress', {"value": value});
  }

  @override
  Future<void> resetProgress() async {
    return await methodChannel.invokeMethod<void>('resetProgress');
  }

  @override
  Future<void> changeStyle(ProgressBarStyle style) async {
    return await methodChannel.invokeMethod<void>('changeStyle', style.toMap());
  }
}
