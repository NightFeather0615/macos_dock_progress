import 'package:macos_dock_progress/macos_dock_progress.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'macos_dock_progress_method_channel.dart';

abstract class DockProgressPlatform extends PlatformInterface {
  /// Constructs a MacosDockProgressPlatform.
  DockProgressPlatform() : super(token: _token);

  static final Object _token = Object();

  static DockProgressPlatform _instance = MethodChannelDockProgress();

  /// The default instance of [DockProgressPlatform] to use.
  ///
  /// Defaults to [MethodChannelDockProgress].
  static DockProgressPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DockProgressPlatform] when
  /// they register themselves.
  static set instance(DockProgressPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the current value of the progress bar.
  Future<double?> getProgress() async {
    throw UnimplementedError('getProgress() has not been implemented.');
  }

  /// Sets the current value of the progress bar.
  Future<double?> setProgress(double value) async {
    throw UnimplementedError('setProgress() has not been implemented.');
  }

  /// Resets the current value of the progress bar.
  Future<void> resetProgress() async {
    throw UnimplementedError('resetProgress() has not been implemented.');
  }

  /// Change the style of the progress bar.
  Future<void> changeStyle(ProgressBarStyle style) async {
    throw UnimplementedError('changeStyle() has not been implemented.');
  }
}
