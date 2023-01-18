// ignore_for_file: avoid_print

import 'package:flutter/services.dart';

class MethodChannelVolumedeckFlutter {
  static const MethodChannel _methodChannel =
      MethodChannel('@com.navideck.volumedeck_flutter');
  static const EventChannel _volumeDeckEventChannel =
      EventChannel('@com.navideck.volumedeck_event');

  static Stream get volumeDeckEventStream => _volumeDeckEventChannel
      .receiveBroadcastStream({'name': 'volumeDeckEvent'});

  static Future start() => _methodChannel.invokeMethod<String>('start');

  static Future stop() => _methodChannel.invokeMethod<String>('stop');
}
