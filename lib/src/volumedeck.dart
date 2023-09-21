import 'package:flutter/services.dart';
import 'package:volumedeck_flutter/src/generated/volumedeck_generated.g.dart';
import 'package:volumedeck_flutter/volumedeck_flutter.dart';

/// Volumedeck provides automatic volume adjustment based on GPS speed,
/// improving the media-listening experience for users in vehicles and public transport.
///
/// To use Volumedeck, call `initialize()` and pass in the required parameters.
///
/// Volumedeck requires an activation key to remove watermarks. The activation key can be obtained by contacting Navideck, the creators of Volumedeck. The watermarked mode is available for free for developers who want to use it without setting an activation key.

class Volumedeck {
  static final _channel = VolumedeckChannel();
  static bool _isInitialized = false;

  /// Initializes Volumedeck with the specified parameters.
  ///
  /// [runInBackground] - Whether to run Volumedeck in the background or not.
  ///
  /// [androidConfig] - @see [AndroidConfig] for android specific configurations.
  ///
  /// [locationServicesStatusChange] - Callback function to be called when location status changes.
  ///
  /// [onLocationUpdate] - Callback function to be called when location is updated.
  ///
  /// [androidActivationKey] - The activation key required to remove watermarks from Volumedeck on Android. The activation key can be obtained by contacting Navideck, the creators of Volumedeck. The watermarked mode is available for free for developers who want to use it without setting an activation key.
  ///
  /// [iOSActivationKey] - The activation key required to remove watermarks from Volumedeck on iOS. The activation key can be obtained by contacting Navideck, the creators of Volumedeck. The watermarked mode is available for free for developers who want to use it without setting an activation key.
  ///
  /// [autoStart] - Determines whether Volumedeck should automatically start detecting gestures when it is initialized. The default value is `true`.
  ///
  /// Throws an exception if Volumedeck is already initialized.
  static Future<void> initialize({
    bool runInBackground = false,
    AndroidConfig? androidConfig,
    Function(bool status)? locationServicesStatusChange,
    Function(double speed, double volume)? onLocationUpdate,
    VoidCallback? onStart,
    VoidCallback? onStop,
    String? androidActivationKey,
    String? iOSActivationKey,
    bool autoStart = true,
  }) async {
    if (_isInitialized) throw "Volumedeck already initialized";
    await _channel.initialize(
      autoStart,
      runInBackground,
      NativeAndroidConfig(
        showStopButtonInNotification:
            androidConfig?.showStopButtonInNotification,
        showSpeedAndVolumeChangesInNotification:
            androidConfig?.showSpeedAndVolumeChangesInNotification,
        notificationTitle: androidConfig?.notificationTitle,
        notificationSubtitleFormat: androidConfig?.notificationSubtitleFormat,
        notificationStopButtonText: androidConfig?.notificationStopButtonText,
        notificationIconDrawable: androidConfig?.notificationIconDrawable,
      ),
      androidActivationKey,
      iOSActivationKey,
    );
    VolumedeckCallback.setup(_VolumedeckCallbackHandler(
      startCallback: onStart,
      stopCallback: onStop,
      locationStatusChangeCallback: locationServicesStatusChange,
      locationUpdateCallback: onLocationUpdate,
    ));
    _isInitialized = true;
  }

  static Future<void> start() async {
    _ensureInitialized();
    await _channel.start();
  }

  static Future<void> stop() async {
    _ensureInitialized();
    await _channel.stop();
  }

  /// Sets the mock speed for testing
  static Future<void> setMockSpeed(int speed) async {
    _ensureInitialized();
    await _channel.setMockSpeed(speed);
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
