import 'package:flutter/services.dart';

class MethodChannelVolumedeckFlutter {
  static const MethodChannel _methodChannel =
      MethodChannel('@com.navideck.volumedeck_flutter');

  static Future start() => _methodChannel.invokeMethod<String>('start');

  static Future stop() => _methodChannel.invokeMethod<String>('stop');
}
