import 'package:volumedeck_flutter/volumedeck_flutter_method_channel.dart';

class VolumedeckFlutter {
  static Future start() => MethodChannelVolumedeckFlutter.start();
  static Future stop() => MethodChannelVolumedeckFlutter.stop();
}
