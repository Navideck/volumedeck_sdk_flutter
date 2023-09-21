import 'package:pigeon/pigeon.dart';

/// Run:  dart run pigeon --input pigeons/volumedeck.dart

@ConfigurePigeon(
  PigeonOptions(
    dartPackageName: "volumedeck_flutter",
    dartOut: 'lib/src/generated/volumedeck_generated.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/navideck/volumedeck_flutter/VolumedeckGenerated.g.kt',
    swiftOut: 'ios/Classes/VolumedeckGenerated.g.swift',
    kotlinOptions: KotlinOptions(package: 'com.navideck.volumedeck_flutter'),
    swiftOptions: SwiftOptions(),
  ),
)

/// Volumedeck
@HostApi()
abstract class VolumedeckChannel {
  void initialize(
    bool autoStart,
    bool runInBackground,
    NativeAndroidConfig? nativeAndroidConfig,
    String? androidActivationKey,
    String? iOSActivationKey,
  );

  void start();

  void stop();

  void setMockSpeed(int speed);
}

@FlutterApi()
abstract class VolumedeckCallback {
  void onLocationStatusChange(bool status);
  void onLocationUpdate(double speed, double volume);
  void onStart();
  void onStop();
}

class NativeAndroidConfig {
  bool? showStopButtonInNotification;
  bool? showSpeedAndVolumeChangesInNotification;
  String? notificationTitle;
  String? notificationSubtitleFormat;
  String? notificationStopButtonText;
  String? notificationIconDrawable;
}
