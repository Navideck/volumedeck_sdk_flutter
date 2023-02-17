import 'package:flutter/services.dart';

class Volumedeck {
  bool runInBackground;
  bool showStopButtonInAndroidNotification;
  bool showSpeedAndVolumeChangesInAndroidNotification;
  bool useAndroidWakeLock;
  String? activationKey;
  VoidCallback? onStart;
  VoidCallback? onStop;
  Function(bool status)? onLocationStatusChange;
  Function(double speed, double volume)? onLocationUpdate;

  Volumedeck({
    this.runInBackground = false,
    this.showStopButtonInAndroidNotification = false,
    this.showSpeedAndVolumeChangesInAndroidNotification = false,
    this.useAndroidWakeLock = false,
    this.activationKey,
    this.onLocationStatusChange,
    this.onStart,
    this.onStop,
    this.onLocationUpdate,
  }) {
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
    _methodChannel.invokeMethod("initialize", {
      "runInBackground": runInBackground,
      "activationKey": activationKey,
      "showStopButtonInNotification": showStopButtonInAndroidNotification,
      "showSpeedAndVolumeChangesInNotification":
          showSpeedAndVolumeChangesInAndroidNotification,
      "useWakeLock": useAndroidWakeLock,
    });
  }

  final _methodChannel = const MethodChannel(
    '@com.navideck.volumedeck_flutter',
  );
  final _messageConnector = const BasicMessageChannel(
    "@com.navideck.volumedeck_flutter/message_connector",
    StandardMessageCodec(),
  );

  Future start() => _methodChannel.invokeMethod('start');

  Future stop() => _methodChannel.invokeMethod('stop');
}
