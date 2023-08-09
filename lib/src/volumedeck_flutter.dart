import 'package:flutter/services.dart';
import 'package:volumedeck_flutter/src/generated/volumedeck_generated.g.dart';

class Volumedeck {
  static final _channel = VolumedeckChannel();
  static bool _isInitialized = false;

  /// Call [initialize] once with required parameters
  static Future<void> initialize({
    bool autoStart = true,
    bool runInBackground = false,
    bool showStopButtonInAndroidNotification = false,
    bool showSpeedAndVolumeChangesInAndroidNotification = false,
    String? activationKey,
    VoidCallback? onStart,
    VoidCallback? onStop,
    Function(bool status)? locationServicesStatusChange,
    Function(double speed, double volume)? onLocationUpdate,
  }) async {
    if (_isInitialized) throw "Volumedeck already initialized";
    await _channel.initialize(
      autoStart,
      runInBackground,
      showStopButtonInAndroidNotification,
      showSpeedAndVolumeChangesInAndroidNotification,
      activationKey,
    );
    VolumedeckCallback.setup(_VolumedeckCallbackHandler(
      startCallback: onStart,
      stopCallback: onStop,
      locationStatusChangeCallback: locationServicesStatusChange,
      locationUpdateCallback: onLocationUpdate,
    ));
    _isInitialized = true;
  }

  static Future start() async {
    _ensureInitialized();
    await _channel.start();
  }

  static Future stop() async {
    _ensureInitialized();
    await _channel.stop();
  }

  static void _ensureInitialized() {
    if (!_isInitialized) throw "Volumedeck not initialized";
  }
}

class _VolumedeckCallbackHandler extends VolumedeckCallback {
  VoidCallback? startCallback;
  VoidCallback? stopCallback;
  Function(bool status)? locationStatusChangeCallback;
  Function(double speed, double volume)? locationUpdateCallback;

  _VolumedeckCallbackHandler({
    this.startCallback,
    this.stopCallback,
    this.locationStatusChangeCallback,
    this.locationUpdateCallback,
  });

  @override
  void onStart() => startCallback?.call();

  @override
  void onStop() => stopCallback?.call();

  @override
  void onLocationStatusChange(bool status) =>
      locationStatusChangeCallback?.call(status);

  @override
  void onLocationUpdate(double speed, double volume) =>
      locationUpdateCallback?.call(speed, volume);
}
