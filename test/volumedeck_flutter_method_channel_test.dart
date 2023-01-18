import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:volumedeck_flutter/volumedeck_flutter_method_channel.dart';

void main() {
  MethodChannelVolumedeckFlutter platform = MethodChannelVolumedeckFlutter();
  const MethodChannel channel = MethodChannel('volumedeck_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {});
}
