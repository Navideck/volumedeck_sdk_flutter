import 'package:flutter/services.dart';

class Volumedeck {
  static const _methodChannel = MethodChannel(
    '@com.navideck.volumedeck_flutter',
  );
  static const _messageConnector = BasicMessageChannel(
    "@com.navideck.volumedeck_flutter/message_connector",
    StandardMessageCodec(),
  );

  // TODO: Get the actual value from a method channel
  static bool _isInitialized = false;

  /// Call [initialize] once with required parameters
  static Future<void> initialize({
    bool runInBackground = false,
    bool showStopButtonInAndroidNotification = false,
    bool showSpeedAndVolumeChangesInAndroidNotification = false,
    bool useAndroidWakeLock = false,
    String? activationKey,
    VoidCallback? onStart,
    VoidCallback? onStop,
    Function(bool status)? onLocationStatusChange,
    Function(double speed, double volume)? onLocationUpdate,
  }) async {
    if (_isInitialized) throw "Volumedeck already initialized";

    await _methodChannel.invokeMethod("initialize", {
      "runInBackground": runInBackground,
      "activationKey": activationKey,
      "showStopButtonInNotification": showStopButtonInAndroidNotification,
      "showSpeedAndVolumeChangesInNotification":
          showSpeedAndVolumeChangesInAndroidNotification,
      "useWakeLock": useAndroidWakeLock,
    });
    // TODO: Set it based on the return value of invokeMethod
    _isInitialized = true;

    _messageConnector.setMessageHandler((dynamic message) async {
      var type = message["type"];
      var data = message["data"];
      switch (type) {
        case "onStart":
          onStart?.call();
          break;
        case "onStop":
          onStop?.call();
          break;
        case "onLocationStatusChange":
          onLocationStatusChange?.call(data);
          break;
        case "onLocationUpdate":
          onLocationUpdate?.call(data["speed"], data["volume"]);
          break;
      }
      return null;
    });
  }

  static Future dispose() async {
    _messageConnector.setMessageHandler(null);
    _isInitialized = false;
  }

  static Future start() async {
    if (!_isInitialized) throw "Volumedeck not initialized";
    _methodChannel.invokeMethod('start');
  }

  static Future stop() {
    if (!_isInitialized) throw "Volumedeck not initialized";
    return _methodChannel.invokeMethod('stop');
  }
}
