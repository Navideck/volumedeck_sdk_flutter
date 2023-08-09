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
    bool showStopButtonInAndroidNotification,
    bool showSpeedAndVolumeChangesInAndroidNotification,
    String? activationKey,
  );

  void start();

  void stop();
}

@FlutterApi()
abstract class VolumedeckCallback {
  void onLocationStatusChange(bool status);
  void onLocationUpdate(double speed, double volume);
  void onStart();
  void onStop();
}
