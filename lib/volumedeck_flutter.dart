import 'package:volumedeck_flutter/volumedeck_flutter_method_channel.dart';

class VolumedeckFlutter {
  // Stream of events for testing
  static Stream<Map<String, dynamic>> get volumeDeckEventStream {
    return MethodChannelVolumedeckFlutter.volumeDeckEventStream
        .map((event) => Map<String, dynamic>.from(event));
  }

  static Future start() => MethodChannelVolumedeckFlutter.start();

  static Future stop() => MethodChannelVolumedeckFlutter.stop();
}
