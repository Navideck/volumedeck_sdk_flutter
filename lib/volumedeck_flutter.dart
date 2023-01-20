import 'package:flutter/services.dart';

class VolumedeckFlutter {
  VoidCallback? onStart;
  VoidCallback? onStop;
  Function(bool status)? onLocationStatusChange;
  Function(double speed, double volume)? onLocationUpdate;

  VolumedeckFlutter({
    this.onLocationStatusChange,
    this.onStart,
    this.onStop,
    this.onLocationUpdate,
  }) {
    _methodChannel.setMethodCallHandler((MethodCall call) async {
      print(call.method);
      switch (call.method) {
        case "onStart":
          onStart?.call();
          break;
        case "onStop":
          onStop?.call();
          break;
        case "onLocationStatusChange":
          onLocationStatusChange?.call(call.arguments);
          break;
        case "onLocationUpdate":
          var data = call.arguments;
          print(data["speed"]);
          onLocationUpdate?.call(data["speed"], data["volume"]);
          break;
      }
    });
  }

  final MethodChannel _methodChannel =
      const MethodChannel('@com.navideck.volumedeck_flutter');

  Future start() => _methodChannel.invokeMethod<String>('start');

  Future stop() => _methodChannel.invokeMethod<String>('stop');
}
